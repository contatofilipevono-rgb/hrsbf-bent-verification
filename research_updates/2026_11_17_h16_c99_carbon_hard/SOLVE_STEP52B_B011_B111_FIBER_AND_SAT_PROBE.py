#!/usr/bin/env python3
r"""
SOLVE_STEP52B_B011_B111_FIBER_AND_SAT_PROBE.py

NON-ZERO FIBER AUDIT + EXACT 65,536-POINT ANF DEGREE PROFILE + GREEDY MIN-NT1 PROBE
FOR B0_11 AND B1_11:
  1. Tests BOTH t_1 = 0 AND 8 random non-zero fibers t_1 != 0 on:
       - B0_11 eta=5 (d1=24, d1=20, d1=16) and eta=0 (d1=20, d1=16)
       - B1_11 eta=0, 1 (d1=16)
     Verifies whether rK -> 0 holds UNIVERSALLY on non-zero fibers t_1 != 0!
  2. At d1 = 16 (2^16 = 65,536 points of u_1!), computes the EXACT exhaustive survivor
     count across ALL 65,536 points AND computes the EXACT ANF degree profile (deg 0, 1, 2, 3, 4+)
     of every pure-u_1 equation via 16-variable Fast Mobius Transform!
  3. Checks if ANY pure-u_1 equation is identically 1 = 0, linear (deg 1), or quadratic (deg 2)
     on non-zero fibers t_1 != 0 (which would allow instant symbolic / SAT closure across ALL
     2^{NT1} fibers!).
"""

import argparse
import ctypes
import random
import subprocess
import sys
import time
from pathlib import Path
import numpy as np

WORK_DIR = Path(__file__).resolve().parent
sys.path.insert(0, str(WORK_DIR))

import DIAGNOSE_V2_STRUCTURE as diag_v2
import SOLVE_B09_DUAL_S_ELIM as b09
import SOLVE_STEP9_8BRANCH_CUBIC_DROP as s9
import SOLVE_STEP10_CARLET_GUILLOT_NNF as s10
import SOLVE_STEP16_LAYER2A_AND_W44_CRUSH as s16
import SOLVE_STEP17_ELIM_ORDER_R_GT_B_SCHUR4 as s17
import SOLVE_STEP40A_B11_COMMON_KERNEL_AND_DECOMPOSITION as s40a
import SOLVE_STEP44A_ITERATED_POLAR_TOWER as s44a
import SOLVE_STEP45A_B000_PARALLEL_CLOSER as s45a
import SOLVE_STEP45B_POLAR_EXACT_RHS_AND_KL3 as s45b
import SOLVE_STEP47B_ITERATIVE_SYSB_CASCADE as s47b


POP16 = np.array([i.bit_count() for i in range(65536)], dtype=np.uint8)


def anf_degree_16(tt_u8):
    """Exact 16-variable Fast Mobius Transform -> algebraic degree of tt_u8 (length 65536)."""
    a = tt_u8.copy()
    for b in range(16):
        step = 1 << b
        a = a.reshape(-1, 2, step)
        a[:, 1, :] ^= a[:, 0, :]
        a = a.reshape(65536)
    nz = np.flatnonzero(a)
    if len(nz) == 0:
        return -1
    return int(POP16[nz].max())


def run_cascade_return_pure(M0_init, Mk_init, eval_b_init, lib9, max_rounds=8, rng_seed=5200):
    """Lightweight copy of Step 47B cascade that returns (final_rK, pure_eval_fns) cleanly."""
    M0 = M0_init.copy()
    Mk = [M.copy() for M in Mk_init]
    eval_b = eval_b_init
    mW = len(Mk)
    pure_fns = []

    for rd in range(1, max_rounds + 1):
        mR, rK = M0.shape
        if rK == 0:
            pure_fns.append(eval_b)
            return 0, pure_fns

        # 1. K_R quotient
        stack_Mk = np.vstack(Mk)  # (mW*mR, rK)
        KR = s40a.gf2_nullspace_np(stack_Mk)
        if KR.shape[0] > 0:
            # Eliminate columns in KR using M0 @ KR.T
            M0_KR = (M0 @ KR.T) & 1  # (mR, kr_dim)
            # Find pivot rows of M0_KR
            _, piv_c = s40a.gf2_rref_np(M0_KR.T)  # pivot rows of M0_KR
            # Left nullspace of M0_KR
            L_kr = s40a.gf2_nullspace_np(M0_KR.T)  # (mR - rk, mR)
            # Complement basis for columns outside KR
            _, kr_pivs = s40a.gf2_rref_np(KR)
            kr_set = set(kr_pivs)
            keep_c = [c for c in range(rK) if c not in kr_set]
            M0 = (L_kr @ M0[:, keep_c]) & 1
            Mk = [(L_kr @ M[:, keep_c]) & 1 for M in Mk]
            _eb0 = eval_b
            _L = L_kr.T.copy()
            eval_b = lambda U, _eb=_eb0, _Lt=_L: (_eb(U) @ _Lt) & 1
            if M0.shape[1] == 0:
                pure_fns.append(eval_b)
                return 0, pure_fns

        # 2. Deduplicate rows
        cur_stack = np.hstack([M0] + Mk)
        _, keep_r = s40a.gf2_rref_np(cur_stack.T)
        if len(keep_r) < M0.shape[0]:
            M0 = M0[keep_r]
            Mk = [M[keep_r] for M in Mk]
            _eb0 = eval_b
            _kr = list(keep_r)
            eval_b = lambda U, _eb=_eb0, _k=_kr: _eb(U)[:, _k]

        # 3. V_0 elimination
        stack_T = np.hstack(Mk).T  # (mW*rK, mR)
        V0 = s40a.gf2_nullspace_np(stack_T)  # (v0_dim, mR)
        if V0.shape[0] > 0:
            V0_M0 = (V0 @ M0) & 1  # (v0_dim, rK)
            R_v0, piv_c_v0 = s40a.gf2_rref_np(V0_M0)
            r_elim = len(piv_c_v0)
            # Pure rows from V0_M0 left kernel (rows where V0 @ M0 == 0 AND V0 @ Mk == 0)
            L_v00 = s40a.gf2_nullspace_np(V0_M0.T)
            if L_v00.shape[0] > 0:
                W_pure = (L_v00 @ V0) & 1
                _eb0 = eval_b
                _Wp = W_pure.T.copy()
                pure_fns.append(lambda U, _eb=_eb0, _W=_Wp: (_eb(U) @ _W) & 1)
            if r_elim > 0:
                rK_cur = M0.shape[1]
                # Eliminate piv_c_v0 columns from M0, Mk using the r_elim pivot rows of V0
                # Express V0 rows in RREF: T_v0 @ V0 @ M0 = R_v0
                aug = np.hstack([V0_M0, V0])
                aug_r, pivs_a = s40a.gf2_rref_np(aug)
                # First r_elim rows have pivot in 0..rK_cur-1
                E_mat = aug_r[:r_elim, rK_cur:]  # (r_elim, mR) so E_mat @ M0[:, piv_c_v0] == I
                piv_set = set(piv_c_v0)
                keep_c = [c for c in range(rK_cur) if c not in piv_set]
                # For each row i of M0: subtract M0[i, piv_c_v0] @ (E_mat @ M0)
                C_m0 = M0[:, piv_c_v0]  # (mR, r_elim)
                M0_new = (M0[:, keep_c] ^ ((C_m0 @ (E_mat @ M0[:, keep_c])) & 1)) & 1
                # Mk: for each k, Mk[k][:, piv_c_v0] @ (E_mat @ M0[:, keep_c])? Wait:
                # E_mat @ (M0 + sum u_k Mk[k]) r_C = E_mat @ b(u) => E_mat @ M0 r_C = E_mat @ b(u) (since E_mat in V0!)
                # So r_{piv} = E_mat @ M0[:, keep_c] r_{keep} + E_mat @ b(u)!
                # Substituting into row i:
                #   M0_new = M0[:, keep_c] + M0[:, piv] (E_mat M0[:, keep_c])
                #   Mk_new[k] = Mk[k][:, keep_c] + Mk[k][:, piv] (E_mat M0[:, keep_c])
                #   b_new(u) = b(u) + (M0[:, piv] + sum u_k Mk[k][:, piv]) (E_mat b(u))!
                EM0_keep = (E_mat @ M0[:, keep_c]) & 1
                Mk_new = [(Mk[k][:, keep_c] ^ ((Mk[k][:, piv_c_v0] @ EM0_keep) & 1)) & 1 for k in range(mW)]
                C_mk = [Mk[k][:, piv_c_v0].copy() for k in range(mW)]
                _eb0 = eval_b
                _Et = E_mat.T.copy()
                _Cm0 = C_m0.T.copy()
                _Cmk = [cm.T.copy() for cm in C_mk]

                def _make_v0_eb(eb_p, Et, Cm0, Cmk):
                    def _fn(U):
                        B = eb_p(U)  # (N, mR)
                        Eb = (B @ Et) & 1  # (N, r_elim)
                        out = B ^ ((Eb @ Cm0) & 1)
                        for k in range(len(Cmk)):
                            uk = U[:, k:k+1]
                            out ^= (uk * ((Eb @ Cmk[k]) & 1))
                        return out & 1
                    return _fn

                eval_b = _make_v0_eb(_eb0, _Et, _Cm0, _Cmk)
                M0 = M0_new
                Mk = Mk_new
                if M0.shape[1] == 0:
                    pure_fns.append(eval_b)
                    return 0, pure_fns

        # 4. SysB augmentation (if small enough)
        mR, rK = M0.shape
        if mR > 260 or rK > 24:
            break
        stack_T = np.hstack(Mk).T
        V0_now = s40a.gf2_nullspace_np(stack_T)
        sysb_sols = s47b.solve_sysb_basis_c(lib9, Mk, V0_now)
        if sysb_sols.shape[0] == 0:
            break
        cur_stack = np.hstack([M0] + Mk)
        _, cur_pivs = s40a.gf2_rref_np(cur_stack)
        cur_rk = len(cur_pivs)
        basis_rows = cur_stack.copy()
        new_M0, new_Mk, kept_sols = [], [[] for _ in range(mW)], []
        for s_i in range(sysb_sols.shape[0]):
            v_mat = sysb_sols[s_i]
            row_Mk = [(v_mat[k] @ ((M0 ^ Mk[k]) & 1)) & 1 for k in range(mW)]
            cand = np.hstack([np.zeros(rK, dtype=np.uint8)] + row_Mk)
            if not cand.any():
                continue
            test_mat = np.vstack([basis_rows, cand[None, :]])
            _, tp = s40a.gf2_rref_np(test_mat)
            if len(tp) > cur_rk:
                cur_rk = len(tp)
                basis_rows = test_mat
                new_M0.append(np.zeros(rK, dtype=np.uint8))
                for k in range(mW):
                    new_Mk[k].append(row_Mk[k])
                kept_sols.append(v_mat)
                if len(kept_sols) >= 64:
                    break
        if not kept_sols:
            break
        M0 = np.vstack([M0, np.array(new_M0, dtype=np.uint8)])
        Mk = [np.vstack([Mk[k], np.array(new_Mk[k], dtype=np.uint8)]) for k in range(mW)]
        _eb_prev = eval_b
        _Vk = np.array(kept_sols, dtype=np.uint8)

        def _make_sysb_eb(eb_p, V_k):
            def _fn(U):
                B = eb_p(U)
                S_n, mW_n, mR_n = V_k.shape
                BV = (B.astype(np.uint16) @ V_k.reshape(S_n * mW_n, mR_n).T.astype(np.uint16)) & 1
                BV = BV.reshape(B.shape[0], S_n, mW_n)
                extra = (np.einsum("bsk,bk->bs", BV, U.astype(np.uint16)) & 1).astype(np.uint8)
                return np.hstack([B, extra])
            return _fn

        eval_b = _make_sysb_eb(_eb_prev, _Vk)

    return M0.shape[1], pure_fns


def main():
    t0 = time.perf_counter()
    parser = argparse.ArgumentParser()
    parser.add_argument("--cell", choices=["B0_11", "B1_11"], required=True)
    args = parser.parse_args()
    cell_name = args.cell

    print(f"\n==================== [{cell_name}] STEP 52B: NON-ZERO FIBER AUDIT + 65536-PT EXACT ANF ====================", flush=True)

    c_diag, so_diag = WORK_DIR / "s52b_diag.c", WORK_DIR / "libs52b_diag.so"
    c_diag.write_text(diag_v2.C_DIAG_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_diag), "-o", str(so_diag)], check=True)
    lib_diag = ctypes.CDLL(str(so_diag))
    lib_diag.extract_level1_quad_when_diag4.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_uint64),
    ]
    lib_diag.extract_level1_quad_when_diag4.restype = ctypes.c_int
    lib_diag.extract_coset_full_hierarchy_corrected.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int, ctypes.POINTER(ctypes.c_int), ctypes.c_int, ctypes.c_int,
        ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_uint64),
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
    ]
    lib_diag.extract_coset_full_hierarchy_corrected.restype = ctypes.c_int
    lib_diag.gf2_echelon_insert.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int,
    ]
    lib_diag.gf2_echelon_insert.restype = ctypes.c_int

    c_s9, so_s9 = WORK_DIR / "s52b_s9.c", WORK_DIR / "libs52b_s9.so"
    c_s9.write_text(s9.C_STEP9_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_s9), "-o", str(so_s9)], check=True)
    lib9 = s45a._setup_lib9(so_s9)

    c_cg, so_cg = WORK_DIR / "s52b_cg.c", WORK_DIR / "libs52b_cg.so"
    c_cg.write_text(s10.C_CG_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_cg), "-o", str(so_cg)], check=True)
    lib_cg = ctypes.CDLL(str(so_cg))
    for fn in (lib_cg.build_cg12_row_c, lib_cg.build_cg11_row_c):
        fn.argtypes = [
            ctypes.c_int, ctypes.POINTER(ctypes.c_int16), ctypes.POINTER(ctypes.c_int),
            ctypes.c_int, ctypes.POINTER(ctypes.c_int), ctypes.c_int,
            ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
            ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_uint64),
        ]

    c_sh, so_sh = WORK_DIR / "s52b_sh.c", WORK_DIR / "libs52b_sh.so"
    c_sh.write_text(s17.C_SHEAR_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_sh), "-o", str(so_sh)], check=True)
    lib_sh = ctypes.CDLL(str(so_sh))
    lib_sh.shear_subst_var_batch.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.c_int, ctypes.c_uint64, ctypes.c_uint64,
    ]
    lib_sh.remap_rows_by_perm.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_int),
    ]

    orbits = diag_v2.build_orbits_116()
    layer_vecs = s16.build_orb_degu_degz_vecs(orbits)
    mon_to_orb_arr = (ctypes.c_int16 * 65536)(*([-1] * 65536))
    for j, orb in enumerate(orbits):
        for m in orb: mon_to_orb_arr[m] = j
    reps12, reps11 = s10.subset_orbits(12), s10.subset_orbits(11)
    v6_list = diag_v2.all_v6_orbits()
    _, u8_size8, nonzero_z = diag_v2.build_c8_orbits()
    M_rows = []
    for rep_z, _ in nonzero_z:
        row_mask = 0
        for m_idx, (_, u_orb) in enumerate(u8_size8):
            s = sum(1 if ((u & rep_z).bit_count() & 1) == 0 else -1 for u in u_orb)
            if (s // 2) & 1: row_mask |= (1 << m_idx)
        M_rows.append(row_mask)
    fiber_meta = (nonzero_z, diag_v2.gf2_nullspace_left(M_rows))

    pair_idx, all_pairs = {}, []
    for v in range(256):
        for w in range(v + 1, 256):
            pair_idx[(v, w)] = len(all_pairs)
            all_pairs.append(v | (w << 8))
    seen_x = bytearray(65536)
    rot4_reps, rep_of_x = [], [-1] * 65536
    for x in range(65536):
        if (x & 0xFF) == (x >> 8) or seen_x[x]: continue
        r_idx = len(rot4_reps); rot4_reps.append(x)
        for y in (x, diag_v2.rot16(x, 4), diag_v2.rot16(x, 8), diag_v2.rot16(x, 12)):
            seen_x[y] = 1; rep_of_x[y] = r_idx
    coset_0xf_reps = []
    vis16 = bytearray(65536)
    for x in range(65536):
        if vis16[x]: continue
        cur, mem = x, []
        while not vis16[cur]:
            vis16[cur] = 1; mem.append(cur); cur = diag_v2.rot16(cur)
        if len(mem) == 16:
            vnib = (x & 0xF) ^ ((x >> 4) & 0xF) ^ ((x >> 8) & 0xF) ^ ((x >> 12) & 0xF)
            if vnib == 0xF: coset_0xf_reps.append(mem[0])

    X = np.arange(65536, dtype=np.uint16)
    orb_tts = [bytearray(65536) for _ in range(116)]
    orb_tt_np = np.zeros((116, 65536), dtype=np.uint8)
    orb_diag, orb_pair, orb_r4, orb_0xf_parity = [0] * 116, [0] * 116, [0] * 116, [0] * 116
    for j, orb in enumerate(orbits):
        acc = np.zeros(65536, dtype=np.uint8)
        for m in orb: acc ^= ((X & m) == m).astype(np.uint8)
        orb_tt_np[j] = acc
        tt = bytearray(acc.tolist())
        orb_tts[j] = tt
        orb_diag[j] = sum((1 << v) for v in range(256) if tt[v | (v << 8)])
        orb_pair[j] = sum((1 << k) for k, x in enumerate(all_pairs) if tt[x])
        orb_r4[j] = sum((1 << k) for k, x in enumerate(rot4_reps) if tt[x])
        orb_0xf_parity[j] = sum(tt[x] for x in coset_0xf_reps) & 1
    chi_r4 = sum((1 << k) for k, x in enumerate(rot4_reps) if x.bit_count() & 1)
    rot4_data = (pair_idx, orb_diag, orb_pair, orb_r4, chi_r4, rep_of_x, orb_0xf_parity, lambda j, x: orb_tts[j][x])

    layers, c0x0 = s9.build_cyclotomic_layers()
    tbl = s9.build_col_tables(111)
    n, n_cw = tbl["n"], tbl["n_col_words"]
    c99, c57, c113 = int(cell_name[1]), int(cell_name[3]), int(cell_name[4])
    free111, origin111, cb111 = b09.build_pure_111_basis(c99, c57, c113)

    orb_map = (ctypes.c_int * 116)(*([-1] * 116))
    for i, j in enumerate(free111): orb_map[j] = i
    orb_map[0] = -3; orb_map[115] = -1
    orb_map[99] = -2 if c99 else -1
    orb_map[57] = -2 if c57 else -1
    orb_map[113] = -2 if c113 else -1
    L_set = set(diag_v2.L_INDICES)
    L_vars_py = [i for i, j in enumerate(free111) if j in L_set]
    L_vars_arr = (ctypes.c_int * len(L_vars_py))(*L_vars_py)

    n_cg = len(reps12) + len(reps11)
    cg_buf = (ctypes.c_uint64 * (n_cg * n_cw))()
    for idx, I_m in enumerate(reps12):
        rptr = ctypes.cast(ctypes.byref(cg_buf, idx * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
        lib_cg.build_cg12_row_c(
            I_m, mon_to_orb_arr, orb_map, c99, L_vars_arr, len(L_vars_py),
            n, tbl["off2"], tbl["off1"], tbl["off0"], n_cw, tbl["col2_base"], tbl["col3_base"], rptr
        )
    for idx, I_m in enumerate(reps11):
        rptr = ctypes.cast(ctypes.byref(cg_buf, (len(reps12) + idx) * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
        lib_cg.build_cg11_row_c(
            I_m, mon_to_orb_arr, orb_map, c99, L_vars_arr, len(L_vars_py),
            n, tbl["off2"], tbl["off1"], tbl["off0"], n_cw, tbl["col2_base"], tbl["col3_base"], rptr
        )

    sys_data = diag_v2.build_cell_algebraic_system(cell_name, lib_diag, orbits, v6_list, rot4_data, fiber_meta, extract_sec=18.0)
    cyc_cubs = s9.extract_verified_cyclotomic_cubics(cell_name, orbits, origin111, cb111, layers, c0x0)
    n_base = sum(sys_data["deg_pivs_111"].values())
    total_raw = n_base + len(cyc_cubs) + n_cg
    raw_buf = (ctypes.c_uint64 * (total_raw * n_cw))()
    ctypes.memmove(raw_buf, sys_data["rows_c"], n_base * n_cw * 8)
    for idx_c, (_, poly) in enumerate(cyc_cubs):
        s9.pset_to_row(poly, raw_buf, n_base + idx_c, tbl)
    ctypes.memmove(ctypes.byref(raw_buf, (n_base + len(cyc_cubs)) * n_cw * 8), cg_buf, n_cg * n_cw * 8)

    root = s9.run_branch_cascade(lib9, raw_buf, [], list(range(total_raw)), {}, [], tbl, max_xl_rounds=10, verify_subst=True)
    forms_L1 = s16.extract_forms_from_orb_vecs(cb111, layer_vecs["L1"][1], layer_vecs["L1"][0])
    eta_free = s16.reduce_forms_mod_pivs(forms_L1, root["_lin_pivs"])

    # Prebuild all 65,536 points of F_2^16 for exact exhaustive d1=16 check
    U16_all = np.zeros((65536, 16), dtype=np.uint8)
    idx16 = np.arange(65536, dtype=np.uint32)
    for b in range(16):
        U16_all[:, b] = (idx16 >> b) & 1

    test_cases = [(5, [24, 16]), (12, [24, 16]), (0, [20, 16])] if cell_name == "B0_11" else [(0, [16]), (1, [16])]
    rng = np.random.default_rng(5299)

    for em, d1_list in test_cases:
        sys_ex = s45b.extract_eta_exact_system(em, root, eta_free, lib9, lib_sh, tbl, rng_seed=5200 + em)
        nW = sys_ex["nW"]
        M0_c, Mk_c = sys_ex["M0_c"], sys_ex["Mk_c"]
        L_core_T = sys_ex["L_core"].T.copy()

        def eval_bc(W_mat, _fn=sys_ex["eval_b_and_p0_batch"], _Lt=L_core_T):
            b_orig, _ = _fn(W_mat)
            return (b_orig @ _Lt) & 1

        _, full_bas1, _ = s44a.minrank_basis(Mk_c, rk_cap=24, n_rounds=3, seed=5220 + em)
        U_full = np.zeros((nW, nW), dtype=np.uint8)
        for a, cm in enumerate(full_bas1):
            for k in range(nW):
                if (cm >> k) & 1:
                    U_full[a, k] = 1

        for d1 in d1_list:
            U1 = U_full[:d1]
            T1 = U_full[d1:]
            nt1 = nW - d1
            Mu1 = [np.zeros_like(M0_c) for _ in range(d1)]
            for a in range(d1):
                for k in range(nW):
                    if U1[a, k]:
                        Mu1[a] ^= Mk_c[k]

            print(f"\n  === [{cell_name} eta={em} d1={d1}(NT1={nt1})] Testing t1=0 + 4 random non-zero fibers t1!=0 ===", flush=True)
            for f_idx in range(5):
                if f_idx == 0:
                    w_shift = np.zeros(nW, dtype=np.uint8)
                else:
                    t_vec = rng.integers(0, 2, size=nt1, dtype=np.uint8)
                    w_shift = (t_vec @ T1) & 1
                M0_f = M0_c.copy()
                for k in range(nW):
                    if w_shift[k]:
                        M0_f ^= Mk_c[k]

                def make_eb_f(U1_in, ws_in, eb_in):
                    def _fn(U_mat):
                        W_mat = ((U_mat @ U1_in) ^ ws_in[None, :]) & 1
                        return eb_in(W_mat)
                    return _fn

                rK_f, pure_fns = run_cascade_return_pure(M0_f, Mu1, make_eb_f(U1, w_shift, eval_bc), lib9, max_rounds=8)
                if d1 == 16 and rK_f == 0:
                    # EXACT EXHAUSTIVE 65,536-point check + exact ANF degree histogram!
                    mats = [fn(U16_all) for fn in pure_fns]
                    P_all = np.hstack(mats)
                    surv = int(np.sum(~P_all.any(axis=1)))
                    # Compute ANF degree histogram of all columns
                    deg_hist = {}
                    has_const1 = False
                    for col_i in range(P_all.shape[1]):
                        col = P_all[:, col_i]
                        if np.all(col == 1):
                            has_const1 = True
                        dg = anf_degree_16(col)
                        deg_hist[dg] = deg_hist.get(dg, 0) + 1
                    print(
                        f"    fiber {f_idx} ({'t1=0' if f_idx==0 else 'rand'}): rK={rK_f}, eqs={P_all.shape[1]}, "
                        f"EXACT_SURV={surv}/65536, has_1eq0={has_const1}, ANF_degs={sorted(deg_hist.items())}",
                        flush=True,
                    )
                else:
                    U_samp = rng.integers(0, 2, size=(1024, d1), dtype=np.uint8)
                    if pure_fns:
                        P_s = np.hstack([fn(U_samp) for fn in pure_fns])
                        surv_s = int(np.sum(~P_s.any(axis=1)))
                        has_c1 = bool(np.any(np.all(P_s == 1, axis=0)))
                        print(
                            f"    fiber {f_idx} ({'t1=0' if f_idx==0 else 'rand'}): rK={rK_f}, eqs={P_s.shape[1]}, "
                            f"samp_surv={surv_s}/1024, has_1eq0={has_c1}",
                            flush=True,
                        )
                    else:
                        print(f"    fiber {f_idx} ({'t1=0' if f_idx==0 else 'rand'}): rK={rK_f}, eqs=0", flush=True)

    print(f"\n[{cell_name}] STEP 52B DONE ({time.perf_counter()-t0:.1f}s)", flush=True)


if __name__ == "__main__":
    main()
