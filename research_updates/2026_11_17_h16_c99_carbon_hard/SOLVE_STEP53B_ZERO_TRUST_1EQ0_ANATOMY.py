#!/usr/bin/env python3
r"""
SOLVE_STEP53B_ZERO_TRUST_1EQ0_ANATOMY.py

CRITICAL ZERO-TRUST AUDIT + ANATOMY OF THE `SPAN_HAS_1EQ0 = True` BREAKTHROUGH
ON B0_11 AND B1_11:
  1. ZERO-TRUST SYNTHETIC SOUNDNESS TEST:
     Plants 10 random solutions (u1*, rC*) into the EXACT pencil (M0_f, Mu1):
       b_synth(u1) = b_real(u1) ^ b_real(u1*) ^ ((M0_f ^ sum u1*_k Mu1[k]) @ rC*)
     Runs `run_cascade_return_pure` and verifies:
       - P_all(u1*) == 0 for ALL 10/10 planted solutions (0 mismatches!)
       - SPAN_HAS_1EQ0 == False for ALL 10/10 planted satisfiable systems!
     Also checks whether the REAL `b_real(W)` on a random (W, rC) matches the original
     quadratic system `s45b` and whether `1 = 0` is already in `b_real` alone!
  2. ROUND-BY-ROUND ANATOMY:
     Traces each round (KR, V0, SysB) and reports (mR, rK, n_pure, span_has_1eq0),
     plus the Hamming weight of the `1 = 0` linear combination `lam`!
  3. FULL d1 SWEEP (d1 = 16, 18, 20, 22, 24, 26, 28, 30, 32, 36, 40, 44):
     Finds the LARGEST d1 (smallest NT1!) where rK=0 and/or SPAN_HAS_1EQ0=True!
  4. 20-FIBER UNIVERSALITY TEST:
     Tests 20 random non-zero fibers t_1 != 0 for rK=0 and SPAN_HAS_1EQ0!
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
import SOLVE_STEP52B_B011_B111_FIBER_AND_SAT_PROBE as s52b


def span_1eq0_and_witness(P_mat):
    """
    Given P_mat of shape (n_samples, n_eqs) over GF(2), return:
      (rank_P, has_1_in_span, witness_weight)
    where witness_weight is the Hamming weight of a vector lam with P_mat @ lam == 1
    (or -1 if not in span).
    """
    if P_mat.shape[1] == 0:
        return 0, False, -1
    n_s, n_e = P_mat.shape
    # Solve P_mat @ lam = 1 by RREF on [P_mat | 1]
    aug = np.hstack([P_mat, np.ones((n_s, 1), dtype=np.uint8)])
    R, pivs = s40a.gf2_rref_np(aug)
    if len(pivs) > 0 and pivs[-1] == n_e:
        return len(pivs) - 1, False, -1
    rk = len(pivs)
    lam = np.zeros(n_e, dtype=np.uint8)
    for row_i, col_i in enumerate(pivs):
        lam[col_i] = R[row_i, n_e]
    # Verify
    prod = (P_mat.astype(np.uint16) @ lam.astype(np.uint16)) & 1
    assert np.all(prod == 1), "Witness verification failed!"
    return rk, True, int(lam.sum())


def run_cascade_traced(M0_init, Mk_init, eval_b_init, lib9, U_test, max_rounds=8, verbose=False):
    """Same as s52b.run_cascade_return_pure, with round-by-round trace on U_test."""
    M0 = M0_init.copy()
    Mk = [M.copy() for M in Mk_init]
    eval_b = eval_b_init
    mW = len(Mk)
    pure_fns = []
    trace = []

    def _check_pure(tag, rK_val):
        if not pure_fns:
            return False, 0, -1
        P = np.hstack([fn(U_test) for fn in pure_fns])
        rk, has1, wt = span_1eq0_and_witness(P)
        if verbose:
            print(f"      [{tag}] rK={rK_val}, pure_eqs={P.shape[1]}, rk={rk}, SPAN_1EQ0={has1}, lam_wt={wt}", flush=True)
        trace.append((tag, rK_val, P.shape[1], rk, has1, wt))
        return has1, P.shape[1], wt

    for rd in range(1, max_rounds + 1):
        mR, rK = M0.shape
        if rK == 0:
            pure_fns.append(eval_b)
            _check_pure(f"rd{rd}_entry_rK0", 0)
            return 0, pure_fns, trace

        # 1. K_R quotient
        stack_Mk = np.vstack(Mk)
        KR = s40a.gf2_nullspace_np(stack_Mk)
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
            if verbose:
                print(f"      [rd{rd}_KR] KR={KR.shape[0]} -> mR={M0.shape[0]}, rK={M0.shape[1]}", flush=True)
            if M0.shape[1] == 0:
                pure_fns.append(eval_b)
                _check_pure(f"rd{rd}_KR_rK0", 0)
                return 0, pure_fns, trace

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
        stack_T = np.hstack(Mk).T
        V0 = s40a.gf2_nullspace_np(stack_T)
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
                _check_pure(f"rd{rd}_Lv00", M0.shape[1])
            if r_elim > 0:
                rK_cur = M0.shape[1]
                aug = np.hstack([V0_M0, V0])
                aug_r, _ = s40a.gf2_rref_np(aug)
                E_mat = aug_r[:r_elim, rK_cur:]
                piv_set = set(piv_c_v0)
                keep_c = [c for c in range(rK_cur) if c not in piv_set]
                C_m0 = M0[:, piv_c_v0]
                EM0_keep = (E_mat @ M0[:, keep_c]) & 1
                M0_new = (M0[:, keep_c] ^ ((C_m0 @ EM0_keep) & 1)) & 1
                Mk_new = [(Mk[k][:, keep_c] ^ ((Mk[k][:, piv_c_v0] @ EM0_keep) & 1)) & 1 for k in range(mW)]
                C_mk = [Mk[k][:, piv_c_v0].copy() for k in range(mW)]
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
                M0 = M0_new
                Mk = Mk_new
                if verbose:
                    print(f"      [rd{rd}_V0] V0={V0.shape[0]}, elim={r_elim} -> mR={M0.shape[0]}, rK={M0.shape[1]}", flush=True)
                if M0.shape[1] == 0:
                    pure_fns.append(eval_b)
                    _check_pure(f"rd{rd}_V0_rK0", 0)
                    return 0, pure_fns, trace

        # 4. SysB augmentation
        mR, rK = M0.shape
        if mR > 260 or rK > 24:
            if verbose:
                print(f"      [rd{rd}_STOP] cap mR={mR}, rK={rK}", flush=True)
            break
        stack_T = np.hstack(Mk).T
        V0_now = s40a.gf2_nullspace_np(stack_T)
        sysb_sols = s47b.solve_sysb_basis_c(lib9, Mk, V0_now)
        if sysb_sols.shape[0] == 0:
            if verbose:
                print(f"      [rd{rd}_STOP] sysb=0 (mR={mR}, rK={rK})", flush=True)
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
            if verbose:
                print(f"      [rd{rd}_STOP] kept_sols=0", flush=True)
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
        if verbose:
            print(f"      [rd{rd}_SysB] +{len(kept_sols)} rows -> mR={M0.shape[0]}, rK={M0.shape[1]}", flush=True)

    return M0.shape[1], pure_fns, trace


def main():
    t0 = time.perf_counter()
    parser = argparse.ArgumentParser()
    parser.add_argument("--cell", choices=["B0_11", "B1_11"], required=True)
    args = parser.parse_args()
    cell_name = args.cell

    print(f"\n==================== [{cell_name}] STEP 53B: ZERO-TRUST 1=0 SOUNDNESS + ANATOMY + d1 SWEEP ====================", flush=True)

    c_diag, so_diag = WORK_DIR / "s53b_diag.c", WORK_DIR / "libs53b_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s53b_s9.c", WORK_DIR / "libs53b_s9.so"
    c_s9.write_text(s9.C_STEP9_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_s9), "-o", str(so_s9)], check=True)
    lib9 = s45a._setup_lib9(so_s9)

    c_cg, so_cg = WORK_DIR / "s53b_cg.c", WORK_DIR / "libs53b_cg.so"
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

    c_sh, so_sh = WORK_DIR / "s53b_sh.c", WORK_DIR / "libs53b_sh.so"
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

    rng = np.random.default_rng(5353)
    etas = [0, 5] if cell_name == "B0_11" else [0, 1]

    for em in etas:
        sys_ex = s45b.extract_eta_exact_system(em, root, eta_free, lib9, lib_sh, tbl, rng_seed=5300 + em)
        nW = sys_ex["nW"]
        M0_c, Mk_c = sys_ex["M0_c"], sys_ex["Mk_c"]
        L_core_T = sys_ex["L_core"].T.copy()

        def eval_bc(W_mat, _fn=sys_ex["eval_b_and_p0_batch"], _Lt=L_core_T):
            b_orig, _ = _fn(W_mat)
            return (b_orig @ _Lt) & 1

        # 0. Check if b_real(W) ALONE already spans 1=0 on 4096 random W
        W_test = rng.integers(0, 2, size=(4096, nW), dtype=np.uint8)
        B_test = eval_bc(W_test)
        rk_b, has1_b, wt_b = span_1eq0_and_witness(B_test)
        print(f"\n  [{cell_name} eta={em}] Raw eval_bc(W) on 4096 pts: shape={B_test.shape}, rk={rk_b}, SPAN_1EQ0_RAW={has1_b} (wt={wt_b})", flush=True)

        _, full_bas1, _ = s44a.minrank_basis(Mk_c, rk_cap=24, n_rounds=3, seed=5320 + em)
        U_full = np.zeros((nW, nW), dtype=np.uint8)
        for a, cm in enumerate(full_bas1):
            for k in range(nW):
                if (cm >> k) & 1:
                    U_full[a, k] = 1

        # 1. ZERO-TRUST SYNTHETIC PLANTED-SOLUTION TEST at d1 = 16
        d1 = 16
        U1 = U_full[:d1]
        T1 = U_full[d1:]
        nt1 = nW - d1
        Mu1 = [np.zeros_like(M0_c) for _ in range(d1)]
        for a in range(d1):
            for k in range(nW):
                if U1[a, k]:
                    Mu1[a] ^= Mk_c[k]

        # Test fiber 0 (or fiber 2 for B0_11 eta=5)
        w_shift = np.zeros(nW, dtype=np.uint8) if not (cell_name == "B0_11" and em == 5) else ((rng.integers(0, 2, size=nt1, dtype=np.uint8) @ T1) & 1)
        M0_f = M0_c.copy()
        for k in range(nW):
            if w_shift[k]:
                M0_f ^= Mk_c[k]

        def eb_real(U_mat, _U1=U1, _ws=w_shift, _eb=eval_bc):
            W_mat = ((U_mat @ _U1) ^ _ws[None, :]) & 1
            return _eb(W_mat)

        U_4096 = rng.integers(0, 2, size=(4096, d1), dtype=np.uint8)
        print(f"\n  === [{cell_name} eta={em} d1=16] PART 1: ZERO-TRUST PLANTED-SOLUTION AUDIT ===", flush=True)
        planted_ok = 0
        planted_no_1eq0 = 0
        rK_init = M0_f.shape[1]
        for t_i in range(10):
            u_star = rng.integers(0, 2, size=(1, d1), dtype=np.uint8)
            r_star = rng.integers(0, 2, size=(rK_init,), dtype=np.uint8)
            # Compute M(u_star) @ r_star
            M_ustar = M0_f.copy()
            for a in range(d1):
                if u_star[0, a]:
                    M_ustar ^= Mu1[a]
            lhs_star = (M_ustar @ r_star) & 1
            b_star = eb_real(u_star)[0]
            shift_vec = (lhs_star ^ b_star) & 1

            def eb_synth(U_mat, _eb=eb_real, _sv=shift_vec):
                return (_eb(U_mat) ^ _sv[None, :]) & 1

            # Verify planted solution satisfies original pencil
            assert np.all(((M_ustar @ r_star) & 1) == eb_synth(u_star)[0])
            rK_s, pf_s, _ = run_cascade_traced(M0_f, Mu1, eb_synth, lib9, U_4096, max_rounds=8, verbose=False)
            if pf_s:
                val_star = np.hstack([fn(u_star) for fn in pf_s])
                if not np.any(val_star):
                    planted_ok += 1
                P_s = np.hstack([fn(U_4096) for fn in pf_s])
                _, has1_s, _ = span_1eq0_and_witness(P_s)
                if not has1_s:
                    planted_no_1eq0 += 1
            else:
                planted_ok += 1
                planted_no_1eq0 += 1
        print(f"    ZERO-TRUST PLANTED AUDIT: {planted_ok}/10 satisfied P_all(u*)=0, {planted_no_1eq0}/10 had SPAN_1EQ0=False (rK_s={rK_s})", flush=True)

        # 2. ROUND-BY-ROUND ANATOMY ON REAL SYSTEM (d1=16)
        print(f"\n  === [{cell_name} eta={em} d1=16] PART 2: ROUND-BY-ROUND 1=0 ANATOMY ===", flush=True)
        rK_r, pf_r, tr_r = run_cascade_traced(M0_f, Mu1, eb_real, lib9, U_4096, max_rounds=8, verbose=True)

        # 3. d1 SWEEP: 16, 18, 20, 22, 24, 26, 28, 30, 32, 36, 40, 44
        print(f"\n  === [{cell_name} eta={em}] PART 3: d1 SWEEP (t1=0 + 2 rand fibers) ===", flush=True)
        for d1_sw in [16, 18, 20, 22, 24, 26, 28, 30, 32, 36, 40, nW]:
            U1_sw = U_full[:d1_sw]
            T1_sw = U_full[d1_sw:]
            nt1_sw = nW - d1_sw
            Mu1_sw = [np.zeros_like(M0_c) for _ in range(d1_sw)]
            for a in range(d1_sw):
                for k in range(nW):
                    if U1_sw[a, k]:
                        Mu1_sw[a] ^= Mk_c[k]
            U_s = rng.integers(0, 2, size=(2048, d1_sw), dtype=np.uint8)
            n_fib = 1 if nt1_sw == 0 else 3
            res_strs = []
            for f_i in range(n_fib):
                ws_sw = np.zeros(nW, dtype=np.uint8) if f_i == 0 else ((rng.integers(0, 2, size=nt1_sw, dtype=np.uint8) @ T1_sw) & 1)
                M0_sw = M0_c.copy()
                for k in range(nW):
                    if ws_sw[k]:
                        M0_sw ^= Mk_c[k]

                def eb_sw(U_mat, _U1=U1_sw, _ws=ws_sw, _eb=eval_bc):
                    W_mat = ((U_mat @ _U1) ^ _ws[None, :]) & 1
                    return _eb(W_mat)

                rK_sw, pf_sw, _ = run_cascade_traced(M0_sw, Mu1_sw, eb_sw, lib9, U_s, max_rounds=8, verbose=False)
                if pf_sw:
                    P_sw = np.hstack([fn(U_s) for fn in pf_sw])
                    rk_sw, has1_sw, wt_sw = span_1eq0_and_witness(P_sw)
                    res_strs.append(f"f{f_i}:rK={rK_sw},eq={P_sw.shape[1]},1eq0={has1_sw}(wt={wt_sw})")
                else:
                    res_strs.append(f"f{f_i}:rK={rK_sw},eq=0")
            print(f"    d1={d1_sw:2d}(NT1={nt1_sw:2d}): " + " | ".join(res_strs), flush=True)

        # 4. 20-FIBER UNIVERSALITY AT d1=16
        print(f"\n  === [{cell_name} eta={em} d1=16] PART 4: 20-FIBER UNIVERSALITY ===", flush=True)
        n_rk0 = 0
        n_1eq0 = 0
        for f_i in range(20):
            ws_20 = np.zeros(nW, dtype=np.uint8) if f_i == 0 else ((rng.integers(0, 2, size=nt1, dtype=np.uint8) @ T1) & 1)
            M0_20 = M0_c.copy()
            for k in range(nW):
                if ws_20[k]:
                    M0_20 ^= Mk_c[k]

            def eb_20(U_mat, _U1=U1, _ws=ws_20, _eb=eval_bc):
                W_mat = ((U_mat @ _U1) ^ _ws[None, :]) & 1
                return _eb(W_mat)

            rK_20, pf_20, _ = run_cascade_traced(M0_20, Mu1, eb_20, lib9, U_4096[:2048], max_rounds=8, verbose=False)
            if rK_20 == 0:
                n_rk0 += 1
            if pf_20:
                P_20 = np.hstack([fn(U_4096[:2048]) for fn in pf_20])
                _, has1_20, _ = span_1eq0_and_witness(P_20)
                if has1_20:
                    n_1eq0 += 1
        print(f"    20-FIBER RESULT: rK=0 in {n_rk0}/20, SPAN_1EQ0=True in {n_1eq0}/20", flush=True)

    print(f"\n[{cell_name}] STEP 53B DONE ({time.perf_counter()-t0:.1f}s)", flush=True)


if __name__ == "__main__":
    main()
