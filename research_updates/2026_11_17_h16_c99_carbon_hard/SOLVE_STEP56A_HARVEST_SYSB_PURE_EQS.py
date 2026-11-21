#!/usr/bin/env python3
r"""
SOLVE_STEP56A_HARVEST_SYSB_PURE_EQS.py

TESTS WHETHER THE `kept=0` SysB SYZYGIES (DISCOVERED IN STEP 55B AT d1=26..44 ON B0_11
AND d1=18..22 ON B1_11) YIELD NON-TRIVIAL PURE-u_1 EQUATIONS (ZERO r_C VARIABLES!)
AT MUCH SMALLER NT1 (NT1 = 8..18 INSTEAD OF 20..29)!

When a SysB solution v_mat satisfies:
  cand = [0 | v_mat[0](M0^M_0) | ... | v_mat[d1-1](M0^M_{d1-1})]
and `cand` is EITHER 0 OR a linear combination `sum_i c_i basis_rows[i]`:
  Then the r_C-part cancels IDENTICALLY, yielding a PURE-u_1 equation:
    P(u_1) = sum_k u_{1,k} (v_mat[k] @ b(u_1)) ^ sum_i c_i b_i(u_1) == 0 !

We:
  1. Harvest ALL such pure-u_1 equations from every SysB round (even when final_rK > 0!).
  2. Zero-Trust verify EVERY harvested equation on 5 planted solutions (u1*, rC*) -> 0 mismatches!
  3. Measure their exact GF(2) rank and survivor count on 4096 random u_1 points!
"""

import argparse
import ctypes
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


def run_cascade_harvest_pure(M0_init, Mk_init, eval_b_init, lib9, max_rounds=6, mR_cap=400, rK_cap=30, keep_cap=128):
    """
    Runs KR -> dedup -> V0 -> SysB cascade AND harvests ALL pure-u_1 equations from:
      - L_v00 (left kernel of V0 @ M0)
      - SysB syzygies where cand == 0 OR cand is in the row space of [M0 | Mk] !
    Returns (final_rK, pure_fns, log_strs).
    """
    M0 = M0_init.copy()
    Mk = [M.copy() for M in Mk_init]
    eval_b = eval_b_init
    mW = len(Mk)
    pure_fns = []
    log = []

    for rd in range(1, max_rounds + 1):
        mR, rK = M0.shape
        if rK == 0:
            pure_fns.append(eval_b)
            return 0, pure_fns, log

        # 1. K_R quotient
        KR = s40a.gf2_nullspace_np(np.vstack(Mk))
        if KR.shape[0] > 0:
            M0_KR = (M0 @ KR.T) & 1
            L_kr = s40a.gf2_nullspace_np(M0_KR.T)
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
                return 0, pure_fns, log

        # 2. Deduplicate rows — AND harvest left-kernel pure eqs of [M0 | Mk] before dropping!
        cur_stack = np.hstack([M0] + Mk)  # (mR, (mW+1)*rK)
        L_dep = s40a.gf2_nullspace_np(cur_stack.T)
        if L_dep.shape[0] > 0:
            _eb0 = eval_b
            _Ld = L_dep.T.copy()
            pure_fns.append(lambda U, _eb=_eb0, _W=_Ld: (_eb(U) @ _W) & 1)
            log.append(f"r{rd}:dep_pure={L_dep.shape[0]}")
        _, keep_r = s40a.gf2_rref_np(cur_stack.T)
        if len(keep_r) < M0.shape[0]:
            M0 = M0[keep_r]
            Mk = [M[keep_r] for M in Mk]
            _eb0 = eval_b
            _kr = list(keep_r)
            eval_b = lambda U, _eb=_eb0, _k=_kr: _eb(U)[:, _k]

        # 3. V_0 elimination
        V0 = s40a.gf2_nullspace_np(np.hstack(Mk).T)
        if V0.shape[0] > 0:
            V0_M0 = (V0 @ M0) & 1
            _, piv_c_v0 = s40a.gf2_rref_np(V0_M0)
            r_elim = len(piv_c_v0)
            L_v00 = s40a.gf2_nullspace_np(V0_M0.T)
            if L_v00.shape[0] > 0:
                W_pure = (L_v00 @ V0) & 1
                _eb0 = eval_b
                _Wp = W_pure.T.copy()
                pure_fns.append(lambda U, _eb=_eb0, _W=_Wp: (_eb(U) @ _W) & 1)
                log.append(f"r{rd}:Lv00={L_v00.shape[0]}")
            if r_elim > 0:
                rK_cur = M0.shape[1]
                aug = np.hstack([V0_M0, V0])
                aug_r, _ = s40a.gf2_rref_np(aug)
                E_mat = aug_r[:r_elim, rK_cur:]
                piv_set = set(piv_c_v0)
                keep_c = [c for c in range(rK_cur) if c not in piv_set]
                C_m0 = M0[:, piv_c_v0]
                C_mk = [Mk[k][:, piv_c_v0].copy() for k in range(mW)]
                EM0_keep = (E_mat @ M0[:, keep_c]) & 1
                M0 = (M0[:, keep_c] ^ ((C_m0 @ EM0_keep) & 1)) & 1
                Mk = [(Mk[k][:, keep_c] ^ ((C_mk[k] @ EM0_keep) & 1)) & 1 for k in range(mW)]
                _eb0 = eval_b
                _Et = E_mat.T.copy()
                _Cm0 = C_m0.T.copy()
                _Cmk = [cm.T.copy() for cm in C_mk]

                def _make_v0_eb(eb_p, Et, Cm0, Cmk):
                    def _fn(U):
                        B = eb_p(U)
                        Eb = (B @ Et) & 1
                        out = B ^ ((Eb @ Cm0) & 1)
                        for k in range(len(Cmk)):
                            uk = U[:, k:k+1]
                            out ^= (uk * ((Eb @ Cmk[k]) & 1))
                        return out & 1
                    return _fn

                eval_b = _make_v0_eb(_eb0, _Et, _Cm0, _Cmk)
                if M0.shape[1] == 0:
                    pure_fns.append(eval_b)
                    return 0, pure_fns, log

        # 4. SysB augmentation + HARVEST ALL DEPENDENT/ZERO SysB ROWS AS PURE-u_1 EQUATIONS!
        mR, rK = M0.shape
        if mR > mR_cap or rK > rK_cap:
            break
        V0_now = s40a.gf2_nullspace_np(np.hstack(Mk).T)
        sysb_sols = s47b.solve_sysb_basis_c(lib9, Mk, V0_now)
        if sysb_sols.shape[0] == 0:
            break

        # Build ALL candidate SysB rows at once: C_mat of shape (n_sols, (mW+1)*rK)
        n_sols = sysb_sols.shape[0]
        cur_stack = np.hstack([M0] + Mk)  # (mR, Wc)
        # Note: rows of cur_stack are linearly independent after step 2!
        # Compute RREF of [cur_stack | I_mR] so we can express any dependent cand as coeff @ cur_stack!
        Wc = cur_stack.shape[1]
        # Incremental echelon with transformation matrix tracking coeffs in terms of cur_stack + kept_sols
        # Simpler & super fast: stack [cur_stack; all_cands] and find its LEFT nullspace!
        cands = np.zeros((n_sols, Wc), dtype=np.uint8)
        M0_xor_Mk = [(M0 ^ Mk[k]) & 1 for k in range(mW)]
        for s_i in range(n_sols):
            v_mat = sysb_sols[s_i]
            for k in range(mW):
                cands[s_i, (k + 1) * rK : (k + 2) * rK] = (v_mat[k] @ M0_xor_Mk[k]) & 1

        # Left nullspace of [cur_stack; cands] gives ALL linear combinations that cancel M(u) r_C!
        full_stack = np.vstack([cur_stack, cands])  # (mR + n_sols, Wc)
        L_sysb = s40a.gf2_nullspace_np(full_stack.T)  # (n_syz, mR + n_sols)
        if L_sysb.shape[0] > 0:
            L_base = L_sysb[:, :mR].copy()       # (n_syz, mR)
            L_cand = L_sysb[:, mR:].copy()       # (n_syz, n_sols)
            _eb_p = eval_b
            _V_all = sysb_sols.copy()            # (n_sols, mW, mR)

            def _make_syz_pure(eb_p, V_all, Lb, Lc):
                # Pre-contract Lc @ V_all -> (n_syz, mW, mR)
                n_s, mW_n, mR_n = V_all.shape
                V_comb = (Lc.astype(np.uint16) @ V_all.reshape(n_s, mW_n * mR_n).astype(np.uint16)) & 1
                V_comb = V_comb.reshape(Lc.shape[0], mW_n, mR_n).astype(np.uint8)
                Lb_T = Lb.T.copy()

                def _fn(U):
                    B = eb_p(U)  # (N, mR)
                    out = (B.astype(np.uint16) @ Lb_T.astype(np.uint16)) & 1
                    n_z = V_comb.shape[0]
                    BV = (B.astype(np.uint16) @ V_comb.reshape(n_z * mW_n, mR_n).T.astype(np.uint16)) & 1
                    BV = BV.reshape(B.shape[0], n_z, mW_n)
                    out ^= (np.einsum("bsk,bk->bs", BV, U.astype(np.uint16)) & 1)
                    return out.astype(np.uint8)
                return _fn

            pure_fns.append(_make_syz_pure(_eb_p, _V_all, L_base, L_cand))
            log.append(f"r{rd}:sysb_syz={L_sysb.shape[0]}")

        # Also keep linearly independent new rows for next round
        _, piv_rows = s40a.gf2_rref_np(full_stack.T)
        new_idxs = [p - mR for p in piv_rows if p >= mR][:keep_cap]
        if not new_idxs:
            break
        kept_sols = sysb_sols[new_idxs]
        new_M0 = np.zeros((len(new_idxs), rK), dtype=np.uint8)
        M0 = np.vstack([M0, new_M0])
        for k in range(mW):
            Mk[k] = np.vstack([Mk[k], cands[new_idxs, (k + 1) * rK : (k + 2) * rK]])

        _eb_prev = eval_b
        _Vk = kept_sols.copy()

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
        log.append(f"r{rd}:SysB(+{len(new_idxs)})")

    return M0.shape[1], pure_fns, log


def main():
    t0 = time.perf_counter()
    parser = argparse.ArgumentParser()
    parser.add_argument("--cell", choices=["B0_11", "B1_11"], required=True)
    args = parser.parse_args()
    cell_name = args.cell

    print(f"\n==================== [{cell_name}] STEP 56A: HARVEST SysB SYZYGY PURE-u1 EQUATIONS ====================", flush=True)

    c_diag, so_diag = WORK_DIR / "s56a_diag.c", WORK_DIR / "libs56a_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s56a_s9.c", WORK_DIR / "libs56a_s9.so"
    c_s9.write_text(s9.C_STEP9_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_s9), "-o", str(so_s9)], check=True)
    lib9 = s45a._setup_lib9(so_s9)

    c_cg, so_cg = WORK_DIR / "s56a_cg.c", WORK_DIR / "libs56a_cg.so"
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

    c_sh, so_sh = WORK_DIR / "s56a_sh.c", WORK_DIR / "libs56a_sh.so"
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
    orb_diag, orb_pair, orb_r4, orb_0xf_parity = [0] * 116, [0] * 116, [0] * 116, [0] * 116
    for j, orb in enumerate(orbits):
        acc = np.zeros(65536, dtype=np.uint8)
        for m in orb: acc ^= ((X & m) == m).astype(np.uint8)
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

    rng = np.random.default_rng(5601)
    etas = [5, 0] if cell_name == "B0_11" else [0, 1]

    for em in etas:
        sys_ex = s45b.extract_eta_exact_system(em, root, eta_free, lib9, lib_sh, tbl, rng_seed=5600 + em)
        nW = sys_ex["nW"]
        M0_c, Mk_c = sys_ex["M0_c"], sys_ex["Mk_c"]
        L_core_T = sys_ex["L_core"].T.copy()

        def eval_bc(W_mat, _fn=sys_ex["eval_b_and_p0_batch"], _Lt=L_core_T):
            b_orig, _ = _fn(W_mat)
            return (b_orig @ _Lt) & 1

        _, full_bas1, _ = s44a.minrank_basis(Mk_c, rk_cap=24, n_rounds=3, seed=5620 + em)
        U_full = np.zeros((nW, nW), dtype=np.uint8)
        for a, cm in enumerate(full_bas1):
            for k in range(nW):
                if (cm >> k) & 1:
                    U_full[a, k] = 1

        print(f"\n  === [{cell_name} eta={em}] HARVESTING SysB SYZYGY PURE-u1 EQUATIONS ===", flush=True)
        d1_list = [24, 26, 28, 30, 32, 36, nW] if cell_name == "B0_11" else [18, 20, 22, 24]
        for d1 in d1_list:
            U1 = U_full[:d1]
            Mu1 = [np.zeros_like(M0_c) for _ in range(d1)]
            for a in range(d1):
                for k in range(nW):
                    if U1[a, k]:
                        Mu1[a] ^= Mk_c[k]

            def eb_u(U_mat, _U1=U1, _eb=eval_bc):
                return _eb((U_mat @ _U1) & 1)

            rK_f, pf, lg = run_cascade_harvest_pure(M0_c, Mu1, eb_u, lib9, max_rounds=6)
            if not pf:
                print(f"    d1={d1:2d}(NT1={nW-d1:2d}): rK={rK_f:2d}, raw_pure=0 | {' ; '.join(lg)}", flush=True)
                continue

            # Zero-Trust check on 3 planted solutions (u*, r*)
            zt_ok = 0
            rK_0 = M0_c.shape[1]
            for _ in range(3):
                u_star = rng.integers(0, 2, size=(1, d1), dtype=np.uint8)
                r_star = rng.integers(0, 2, size=(rK_0,), dtype=np.uint8)
                M_u = M0_c.copy()
                for a in range(d1):
                    if u_star[0, a]:
                        M_u ^= Mu1[a]
                sv = ((M_u @ r_star) ^ eb_u(u_star)[0]) & 1
                _, pf_s, _ = run_cascade_harvest_pure(M0_c, Mu1, lambda U, _eb=eb_u, _sv=sv: (_eb(U) ^ _sv[None, :]) & 1, lib9, max_rounds=6)
                val_s = np.hstack([fn(u_star) for fn in pf_s])
                if not np.any(val_s):
                    zt_ok += 1

            U_samp = rng.integers(0, 2, size=(4096, d1), dtype=np.uint8)
            P = np.hstack([fn(U_samp) for fn in pf])
            nz_cols = int(P.any(axis=0).sum())
            # Fast GF(2) rank of P.T (n_eqs x 4096)
            _, pivs = s40a.gf2_rref_np(P.T)
            rk = len(pivs)
            surv = int((~P.any(axis=1)).sum())
            print(
                f"    d1={d1:2d}(NT1={nW-d1:2d}): rK={rK_f:2d}, raw_pure={P.shape[1]}, nz_cols={nz_cols}, "
                f"IND_RK={rk}, surv={surv}/4096, ZT={zt_ok}/3 | {' ; '.join(lg)}",
                flush=True,
            )

    print(f"\n[{cell_name}] STEP 56A DONE ({time.perf_counter()-t0:.1f}s)", flush=True)


if __name__ == "__main__":
    main()
