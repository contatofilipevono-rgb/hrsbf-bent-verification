#!/usr/bin/env python3
r"""
SOLVE_STEP47B_ITERATIVE_SYSB_CASCADE.py

ITERATIVE DEGREE-1 SYSB PENCIL AUGMENTATION + V0 / ZERO-SPLIT POLAR ELIMINATION + K_R CASCADE:
  Combines four exact NT = 0 (ZERO fiber split!) reductions in a single self-feeding loop:
    1. K_R Quotient (NT = 0): eliminates common right kernel columns of Mk[0..mW-1].
    2. V_00 Pure-u Extraction (NT = 0): extracts all rows where M_0 = 0 and M_k = 0 forall k.
    3. V_0 & Zero-Split (NT2 == 0) Polar Left-Inverse (NT = 0):
       - Eliminates r_elim = rank(V_0 M_0) columns where L M_k = 0 on all columns.
       - Also scans MinRank kernels K_2p for any Polar Left-Inverse step where the Schur
         complement H_quad = (H B(u))(L D(u)) has ZERO degree-2 terms (p2["NT"] == 0,
         so U = I_{mW}, 0 fiber splits!) and eliminates r_elim2 columns at NT = 0!
    4. System B Degree-1 Bilinear Row Augmentation (NT = 0):
       - Solves v_j^T M_k + v_k^T M_j = 0 (forall 0 <= j < k < mW) in C via 64-bit echelon.
       - Every solution v yields a new strictly linear-in-u row:
           M_0^{new} = 0,  M_k^{new} = v_k^T (M_0 + M_k),  b^{new}(u) = sum_k u_k (v_k^T b(u))
         which is appended to (M_0, M_k) for Round r+1!
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
import SOLVE_STEP12A_B0_00_NORMAL_BENT_CRUSH as s12a
import SOLVE_STEP16_LAYER2A_AND_W44_CRUSH as s16
import SOLVE_STEP17_ELIM_ORDER_R_GT_B_SCHUR4 as s17
import SOLVE_STEP40A_B11_COMMON_KERNEL_AND_DECOMPOSITION as s40a
import SOLVE_STEP43A_ETA_INVARIANCE_AND_ITERATED_POLAR as s43a
import SOLVE_STEP44A_ITERATED_POLAR_TOWER as s44a
import SOLVE_STEP45B_POLAR_EXACT_RHS_AND_KL3 as s45b


def solve_sysb_basis_c(lib9, Mk_list, V0_basis):
    """
    Solve System B:
      v_j^T M_k + v_k^T M_j = 0  for all 0 <= j < k < mW,
    where each v_k in F_2^{mR}, constrained to a complement of V0_basis so that
    only non-trivial extra_SysB solutions are returned.
    """
    mW = len(Mk_list)
    mR, rK = Mk_list[0].shape
    if mR == 0 or rK == 0:
        return np.zeros((0, mW, mR), dtype=np.uint8)

    _, v0_pivs = s40a.gf2_rref_np(V0_basis) if V0_basis.shape[0] > 0 else (None, [])
    v0_piv_set = set(v0_pivs)
    active_rows = [r for r in range(mR) if r not in v0_piv_set]
    mR_act = len(active_rows)
    if mR_act == 0:
        return np.zeros((0, mW, mR), dtype=np.uint8)

    Mk_act = [M[active_rows, :] for M in Mk_list]
    n_cols_total = mW * mR_act
    n_cw = (n_cols_total + 63) // 64
    piv_idx = (ctypes.c_int * n_cols_total)(*([-1] * n_cols_total))
    max_pivs = n_cols_total + 32
    buf = (ctypes.c_uint64 * (max_pivs * n_cw))()
    n_pivs = 0

    Ak_nz = [[np.flatnonzero(Mk_act[k][:, c]).tolist() for c in range(rK)] for k in range(mW)]

    for j in range(mW):
        off_j = j * mR_act
        for k in range(j + 1, mW):
            off_k = k * mR_act
            for c in range(rK):
                rj = Ak_nz[k][c]
                rk_l = Ak_nz[j][c]
                if not rj and not rk_l:
                    continue
                base = n_pivs * n_cw
                for w in range(n_cw):
                    buf[base + w] = 0
                for r in rj:
                    b = off_j + r
                    buf[base + (b >> 6)] ^= (1 << (b & 63))
                for r in rk_l:
                    b = off_k + r
                    buf[base + (b >> 6)] ^= (1 << (b & 63))
                pc = lib9.gf2_echelon_insert_s9(buf, n_pivs, n_cw, piv_idx, n_cols_total)
                if pc >= 0:
                    n_pivs += 1
                    if n_pivs == n_cols_total:
                        return np.zeros((0, mW, mR), dtype=np.uint8)

    n_extra = n_cols_total - n_pivs
    if n_extra == 0:
        return np.zeros((0, mW, mR), dtype=np.uint8)

    words_np = np.ctypeslib.as_array(buf).reshape(max_pivs, n_cw)[:n_pivs]
    bits_np = np.unpackbits(words_np.view(np.uint8), axis=1, bitorder="little")[:, :n_cols_total]
    null_act = s40a.gf2_nullspace_np(bits_np)
    null_act = null_act.reshape(null_act.shape[0], mW, mR_act)

    full_sols = np.zeros((null_act.shape[0], mW, mR), dtype=np.uint8)
    for idx_a, r_orig in enumerate(active_rows):
        full_sols[:, :, r_orig] = null_act[:, :, idx_a]
    return full_sols


def try_zero_split_polar_step(M0, Mk_list, rng_seed=4700):
    """
    Search MinRank kernels K2p (df2 in [1, 2, 3, 4, 6, 8, 12]) for a Polar Left-Inverse step
    with p2["NT"] == 0 (ZERO degree-2 terms in H_quad -> ZERO fiber splits!) and max r_elim.
     Notice: when p2["NT"] == 0, s43a.isotropic_flat_from_poly_mat returns U = I_{mW},
    so M_u0 and M_ua are in the EXACT same u-coordinates (0 coordinate change!).
    """
    mW = len(Mk_list)
    mR, rK = M0.shape
    if mR == 0 or rK == 0:
        return None
    Mk_arr = np.array(Mk_list, dtype=np.uint8)
    _, fb2, _ = s44a.minrank_basis(Mk_arr, rk_cap=min(20, max(3, rK - 1)), n_rounds=2, seed=rng_seed)
    best_p2 = None
    for df2 in [1, 2, 3, 4, 6, 8, 12]:
        if df2 > mW:
            continue
        rs2 = np.zeros((df2, mR, rK), dtype=np.uint8)
        for idx_m, cm in enumerate(fb2[:df2]):
            for a in range(mW):
                if (cm >> a) & 1:
                    rs2[idx_m] ^= Mk_list[a]
        K2p = s40a.gf2_nullspace_np(rs2.reshape(df2 * mR, rK))
        if K2p.shape[0] == 0:
            continue
        p2 = s45b.build_polar_step_exact(M0, Mk_arr, K2p, rng_seed=rng_seed + df2)
        if p2 is not None and p2["NT"] == 0 and p2["r_elim"] > 0:
            assert np.array_equal(p2["U"], np.eye(mW, dtype=np.uint8)), "Expected U = I_mW when NT == 0"
            if best_p2 is None or p2["r_elim"] > best_p2[0]:
                best_p2 = (p2["r_elim"], df2, p2)
    return best_p2


def run_iterative_sysb_v0_kr_cascade(label, M0_init, Mk_init, eval_b_init, lib9, max_rounds=10, rng_seed=4700):
    """
    Runs the exact Iterative (K_R Quotient -> V_00 Pure-w Extract -> V_0 & NT2=0 Polar Elim -> SysB Augment)
    cascade on a bilinear pencil (M0, Mk) with exact RHS evaluator eval_b(X_mat) -> (B, mR).
    """
    mW = len(Mk_init)
    M0 = M0_init.copy()
    Mk = [M.copy() for M in Mk_init]
    cur_eval_b = eval_b_init

    rng_zt = random.Random(rng_seed)
    X_zt = np.array([[rng_zt.getrandbits(1) for _ in range(mW)] for _ in range(16)], dtype=np.uint8)
    pure_w_evals = []

    print(f"    [{label}] START CASCADE: mW={mW}, init_shape={M0.shape[0]}x{M0.shape[1]}", flush=True)

    for rnd in range(1, max_rounds + 1):
        mR, rK = M0.shape
        if mR == 0:
            print(f"      [Round {rnd}] mR=0 -> stop", flush=True)
            break

        if rK == 0:
            b_zt = cur_eval_b(X_zt)
            rk_b = len(s40a.gf2_rref_np(b_zt.T)[1])
            pure_w_evals.append(cur_eval_b)
            print(f"      [Round {rnd}] rK=0! All {mR} rows are PURE-U equations (zt_sample_rk={rk_b})!", flush=True)
            break

        # Step B: Check K_R (common right kernel of Mk[0..mW-1])
        K_R = s40a.gf2_nullspace_np(np.vstack(Mk))
        kr_dim = K_R.shape[0]
        if kr_dim > 0:
            M0_KR = (M0 @ K_R.T) & 1
            L_kr = s40a.gf2_nullspace_np(M0_KR.T)
            _, kr_pivs = s40a.gf2_rref_np(K_R)
            keep_cols = [c for c in range(rK) if c not in set(kr_pivs)]
            M0 = (L_kr @ M0)[:, keep_cols] & 1
            Mk = [(L_kr @ M)[:, keep_cols] & 1 for M in Mk]
            L_kr_T = L_kr.T.copy()
            prev_eb = cur_eval_b
            cur_eval_b = (lambda eb, LT: lambda X: (eb(X) @ LT) & 1)(prev_eb, L_kr_T)
            mR, rK = M0.shape
            if mR == 0:
                print(f"      [Round {rnd}] K_R={kr_dim} -> mR=0", flush=True)
                break
            if rK == 0:
                b_zt = cur_eval_b(X_zt)
                rk_b = len(s40a.gf2_rref_np(b_zt.T)[1])
                pure_w_evals.append(cur_eval_b)
                print(f"      [Round {rnd}] K_R={kr_dim} -> rK=0! {mR} PURE-U equations (zt_rk={rk_b})!", flush=True)
                break

        # Step C: Compute V_0 = {u : u^T M_k = 0 forall k} and V_00 = {u in V_0 : u^T M_0 = 0}
        V0 = s40a.gf2_nullspace_np(np.hstack(Mk).T)
        V00 = s40a.gf2_nullspace_np(np.hstack([M0] + Mk).T)
        v0_dim, v00_dim = V0.shape[0], V00.shape[0]

        if v00_dim > 0:
            V00_T = V00.T.copy()
            prev_eb = cur_eval_b
            pure_w_evals.append((lambda eb, VT: lambda X: (eb(X) @ VT) & 1)(prev_eb, V00_T))

        # Step D1: Eliminate r_elim = rank(V0 @ M0) columns of r_C via Constant-Coefficient Polar Left-Inverse (NT = 0!)
        r_elim = 0
        if v0_dim > 0 and rK > 0:
            P = (V0 @ M0) & 1
            _, piv_cols = s40a.gf2_rref_np(P)
            r_elim = len(piv_cols)
            if r_elim > 0:
                K_use = np.eye(rK, dtype=np.uint8)[piv_cols]
                comp_cols = [c for c in range(rK) if c not in set(piv_cols)]
                C = np.eye(rK, dtype=np.uint8)[:, comp_cols]
                B0_use = M0[:, piv_cols]
                P_use = (V0 @ B0_use) & 1
                _, v_rows = s40a.gf2_rref_np(P_use.T)
                S_inv = s43a.gf2_inv_np(P_use[v_rows])
                L = (S_inv @ V0[v_rows]) & 1
                assert np.array_equal((L @ B0_use) & 1, np.eye(r_elim, dtype=np.uint8))

                _, l_col_pivs = s40a.gf2_rref_np(L)
                h_cols = [c for c in range(mR) if c not in set(l_col_pivs)]
                H = np.eye(mR, dtype=np.uint8)[h_cols]

                LM0C = (L @ ((M0 @ C) & 1)) & 1
                C_eff = (C ^ ((K_use.T @ LM0C) & 1)) & 1

                M0_new = (H @ ((M0 @ C_eff) & 1)) & 1
                Mk_new = [(H @ ((M @ C_eff) & 1)) & 1 for M in Mk]

                HB0_T = ((H @ B0_use) & 1).T.copy()
                HBk_T = [((H @ M[:, piv_cols]) & 1).T.copy() for M in Mk]
                L_T = L.T.copy()
                H_T = H.T.copy()
                prev_eb = cur_eval_b

                def make_v0_eval_b(eb_in, LT_in, HT_in, HB0T_in, HBkT_in, mW_in):
                    def _eval(X_mat):
                        b_in = eb_in(X_mat)
                        Lb = (b_in @ LT_in) & 1
                        bH = ((b_in @ HT_in) & 1) ^ ((Lb @ HB0T_in) & 1)
                        for k_i in range(mW_in):
                            if HBkT_in[k_i].any():
                                bH ^= X_mat[:, k_i:k_i + 1] & ((Lb @ HBkT_in[k_i]) & 1)
                        return bH
                    return _eval

                next_eval_b = make_v0_eval_b(prev_eb, L_T, H_T, HB0_T, HBk_T, mW)

                # Zero-Trust verification of Constant-Coefficient V0 Polar Elimination
                b_old_zt = prev_eb(X_zt)
                b_new_zt = next_eval_b(X_zt)
                for bi in range(4):
                    rC_rem = np.array([rng_zt.getrandbits(1) for _ in range(C.shape[1])], dtype=np.uint8)
                    Mw_old = M0.copy()
                    Mw_new = M0_new.copy()
                    for k_i in range(mW):
                        if X_zt[bi, k_i]:
                            Mw_old ^= Mk[k_i]
                            Mw_new ^= Mk_new[k_i]
                    rK_val = ((LM0C @ rC_rem) ^ (L @ b_old_zt[bi])) & 1
                    rC_full = ((C @ rC_rem) ^ (K_use.T @ rK_val)) & 1
                    assert not ((L @ ((Mw_old @ rC_full) ^ b_old_zt[bi])) & 1).any()
                    lhs_orig = (H @ ((Mw_old @ rC_full) ^ b_old_zt[bi])) & 1
                    lhs_red = ((Mw_new @ rC_rem) ^ b_new_zt[bi]) & 1
                    assert np.array_equal(lhs_orig, lhs_red), "ZT mismatch in V0 Constant Polar elimination!"

                M0, Mk, cur_eval_b = M0_new, Mk_new, next_eval_b
                mR, rK = M0.shape

        # Step D2: Also try Zero-Split (NT2 == 0) Polar Left-Inverse on MinRank sub-kernels K2p!
        r_elim_p2 = 0
        df2_used = 0
        if mR > 0 and rK > 0:
            zp2 = try_zero_split_polar_step(M0, Mk, rng_seed=rng_seed + rnd * 100)
            if zp2 is not None:
                r_elim_p2, df2_used, p2 = zp2
                M0 = p2["M_u0"].copy()
                Mk = [p2["M_ua"][k].copy() for k in range(mW)]
                prev_eb = cur_eval_b
                p2_push = p2["push_rhs_batch"]
                cur_eval_b = (lambda eb_in, push_fn: lambda X_mat: push_fn(X_mat, eb_in(X_mat)))(prev_eb, p2_push)
                mR, rK = M0.shape

        # Recompute V0 and V00 on the reduced pencil before solving SysB
        if mR == 0 or rK == 0:
            if mR > 0 and rK == 0:
                pure_w_evals.append(cur_eval_b)
            print(
                f"      [Round {rnd}] K_R={kr_dim}, V0_init={v0_dim}(r_elim={r_elim}), "
                f"NT0_polar_elim={r_elim_p2}(df2={df2_used}) -> reduced to {mR}x{rK} (DONE!)",
                flush=True,
            )
            break

        V0_now = s40a.gf2_nullspace_np(np.hstack(Mk).T)
        V00_now = s40a.gf2_nullspace_np(np.hstack([M0] + Mk).T)
        if V00_now.shape[0] > 0:
            V00_T = V00_now.T.copy()
            prev_eb = cur_eval_b
            pure_w_evals.append((lambda eb, VT: lambda X: (eb(X) @ VT) & 1)(prev_eb, V00_T))

        # Step E: Solve extra_SysB on the reduced pencil (M0, Mk)
        t_sb = time.perf_counter()
        sysb_sols = solve_sysb_basis_c(lib9, Mk, V0_now)
        n_extra_b = sysb_sols.shape[0]

        M0_plus_Mk = [(M0 ^ Mk[k]) for k in range(mW)]
        existing_concat = np.hstack([M0] + Mk)
        _, exist_pivs = s40a.gf2_rref_np(existing_concat.T)
        if len(exist_pivs) < mR:
            keep_r = sorted(exist_pivs)
            M0 = M0[keep_r]
            Mk = [M[keep_r] for M in Mk]
            prev_eb = cur_eval_b
            cur_eval_b = (lambda eb, kr: lambda X: eb(X)[:, kr])(prev_eb, keep_r)
            mR = len(keep_r)
            sysb_sols = sysb_sols[:, :, keep_r]
            M0_plus_Mk = [(M0 ^ Mk[k]) for k in range(mW)]
            existing_concat = np.hstack([M0] + Mk)

        new_M0_rows = []
        new_Mk_rows = [[] for _ in range(mW)]
        accepted_v = []
        pure_sysb_v = []

        cur_span = existing_concat.copy()
        cur_rk = len(s40a.gf2_rref_np(cur_span)[1])

        for s_idx in range(n_extra_b):
            v_arr = sysb_sols[s_idx]
            mk_r = [((v_arr[k] @ M0_plus_Mk[k]) & 1) for k in range(mW)]
            row_concat = np.concatenate([np.zeros(rK, dtype=np.uint8)] + mk_r)
            if not row_concat.any():
                pure_sysb_v.append(v_arr.copy())
                continue
            test_span = np.vstack([cur_span, row_concat])
            new_rk = len(s40a.gf2_rref_np(test_span)[1])
            if new_rk > cur_rk:
                cur_span = test_span
                cur_rk = new_rk
                new_M0_rows.append(np.zeros(rK, dtype=np.uint8))
                for k in range(mW):
                    new_Mk_rows[k].append(mk_r[k])
                accepted_v.append(v_arr.copy())

        if pure_sysb_v:
            pv_arr = np.array(pure_sysb_v, dtype=np.uint8)
            prev_eb = cur_eval_b

            def make_pure_sysb_eval(eb_in, pv_in, mW_in):
                vk_T = [pv_in[:, k, :].T.copy() for k in range(mW_in)]
                def _eval(X_mat):
                    b_in = eb_in(X_mat)
                    acc = np.zeros((X_mat.shape[0], pv_in.shape[0]), dtype=np.uint8)
                    for k_i in range(mW_in):
                        if vk_T[k_i].any():
                            acc ^= X_mat[:, k_i:k_i + 1] & ((b_in @ vk_T[k_i]) & 1)
                    return acc
                return _eval

            pure_w_evals.append(make_pure_sysb_eval(prev_eb, pv_arr, mW))

        n_added = len(accepted_v)
        print(
            f"      [Round {rnd}] K_R={kr_dim}, V0={v0_dim}(r_elim={r_elim}), NT0_polar={r_elim_p2}(df2={df2_used}), "
            f"V00={v00_dim}+{V00_now.shape[0]} | pencil={mR}x{rK} | extra_SysB={n_extra_b} "
            f"-> pure_SysA0_hom={len(pure_sysb_v)}, new_indep_rows=+{n_added} ({time.perf_counter()-t_sb:.2f}s)",
            flush=True,
        )

        if n_added == 0 and r_elim == 0 and r_elim_p2 == 0 and kr_dim == 0:
            break

        if n_added > 0:
            acc_arr = np.array(accepted_v, dtype=np.uint8)
            M0_add = np.array(new_M0_rows, dtype=np.uint8)
            Mk_add = [np.array(new_Mk_rows[k], dtype=np.uint8) for k in range(mW)]

            for bi in range(4):
                rC_test = np.array([rng_zt.getrandbits(1) for _ in range(rK)], dtype=np.uint8)
                Mw = M0.copy()
                Mw_add = M0_add.copy()
                for k_i in range(mW):
                    if X_zt[bi, k_i]:
                        Mw ^= Mk[k_i]
                        Mw_add ^= Mk_add[k_i]
                orig_vec = (Mw @ rC_test) & 1
                lhs_new = (Mw_add @ rC_test) & 1
                rhs_check = np.zeros(n_added, dtype=np.uint8)
                for k_i in range(mW):
                    if X_zt[bi, k_i]:
                        rhs_check ^= (acc_arr[:, k_i, :] @ orig_vec) & 1
                assert np.array_equal(lhs_new, rhs_check), "ZT mismatch in SysB row augmentation!"

            M0 = np.vstack([M0, M0_add])
            Mk = [np.vstack([Mk[k], Mk_add[k]]) for k in range(mW)]
            prev_eb = cur_eval_b

            def make_aug_eval_b(eb_in, acc_in, mW_in):
                vk_T = [acc_in[:, k, :].T.copy() for k in range(mW_in)]
                def _eval(X_mat):
                    b_in = eb_in(X_mat)
                    b_add = np.zeros((X_mat.shape[0], acc_in.shape[0]), dtype=np.uint8)
                    for k_i in range(mW_in):
                        if vk_T[k_i].any():
                            b_add ^= X_mat[:, k_i:k_i + 1] & ((b_in @ vk_T[k_i]) & 1)
                    return np.hstack([b_in, b_add])
                return _eval

            cur_eval_b = make_aug_eval_b(prev_eb, acc_arr, mW)

    if pure_w_evals:
        X_sample = np.array([[rng_zt.getrandbits(1) for _ in range(mW)] for _ in range(4096)], dtype=np.uint8)
        all_p = np.hstack([fn(X_sample) for fn in pure_w_evals])
        rk_p = len(s40a.gf2_rref_np(all_p.T)[1])
        surv_p = int(np.sum(np.all(all_p == 0, axis=1)))
        # Also test if constant 1 is in the GF(2)-span of the pure equations on the 4096 sample points!
        ones_row = np.ones((1, 4096), dtype=np.uint8)
        rk_with_1 = len(s40a.gf2_rref_np(np.vstack([all_p.T, ones_row]))[1])
        has_1eq0_sample = (rk_with_1 == rk_p)
        print(
            f"    *** [{label}] CASCADE SUMMARY: final_pencil={M0.shape[0]}x{M0.shape[1]} | "
            f"total_pure_eqs={all_p.shape[1]} (indep_sample_rk={rk_p}, sample_surv={surv_p}/4096, "
            f"has_1eq0_on_4096={has_1eq0_sample}) ***",
            flush=True,
        )
    else:
        print(
            f"    *** [{label}] CASCADE SUMMARY: final_pencil={M0.shape[0]}x{M0.shape[1]} | total_pure_eqs=0 ***",
            flush=True,
        )


def audit_eta_cascade(label, sys_ex, lib9, rng_seed=4700):
    nW = sys_ex["nW"]
    M0_c, Mk_c = sys_ex["M0_c"], sys_ex["Mk_c"]
    L_core_T = sys_ex["L_core"].T.copy()

    def eval_bc(W_mat):
        b_orig, _ = sys_ex["eval_b_and_p0_batch"](W_mat)
        return (b_orig @ L_core_T) & 1

    print(f"\n  === [{label}] 1. GLOBAL (NT = 0, mW = {nW}) ITERATIVE SYSB + V0 + NT0_POLAR + K_R CASCADE ===", flush=True)
    run_iterative_sysb_v0_kr_cascade(
        f"{label} NT=0", M0_c, [Mk_c[k] for k in range(nW)], eval_bc, lib9, max_rounds=10, rng_seed=rng_seed
    )

    _, full_bas1, _ = s44a.minrank_basis(Mk_c, rk_cap=24, n_rounds=3, seed=rng_seed)
    U_full = np.zeros((nW, nW), dtype=np.uint8)
    for a, cm in enumerate(full_bas1):
        for k in range(nW):
            if (cm >> k) & 1:
                U_full[a, k] = 1

    print(f"\n  === [{label}] 2. SUBSPACE U_1 (d1 = 38, 34, 30, 24) ITERATIVE SYSB + V0 + NT0_POLAR + K_R CASCADE ===", flush=True)
    for d1 in [38, 34, 30, 24]:
        if d1 >= nW:
            continue
        U1 = U_full[:d1]
        NT1 = nW - d1
        Mu1 = [np.zeros_like(M0_c) for _ in range(d1)]
        for a in range(d1):
            for k in range(nW):
                if U1[a, k]:
                    Mu1[a] ^= Mk_c[k]

        def make_u1_eval(U1_in):
            def _eval(U1_mat):
                W_mat = (U1_mat @ U1_in) & 1
                return eval_bc(W_mat)
            return _eval

        run_iterative_sysb_v0_kr_cascade(
            f"{label} d1={d1}(NT1={NT1})", M0_c, Mu1, make_u1_eval(U1), lib9, max_rounds=10, rng_seed=rng_seed + d1
        )


def main():
    t0 = time.perf_counter()
    parser = argparse.ArgumentParser()
    parser.add_argument("--mode", choices=["B0_11", "B1_11", "B0_00_hard"], required=True)
    args = parser.parse_args()

    c_diag, so_diag = WORK_DIR / "s47b_diag.c", WORK_DIR / "libs47b_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s47b_s9.c", WORK_DIR / "libs47b_s9.so"
    c_s9.write_text(s9.C_STEP9_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_s9), "-o", str(so_s9)], check=True)
    lib9 = ctypes.CDLL(str(so_s9))
    lib9.subst_one_linear_var_batch.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.c_int, ctypes.c_uint64, ctypes.c_uint64, ctypes.c_int,
    ]
    lib9.gf2_echelon_insert_s9.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int,
    ]
    lib9.gf2_echelon_insert_s9.restype = ctypes.c_int
    lib9.mul_deg2_row_by_var.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
    ]
    lib9.eval_row_s9.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.c_uint64, ctypes.c_uint64,
    ]
    lib9.eval_row_s9.restype = ctypes.c_int

    c_cg, so_cg = WORK_DIR / "s47b_cg.c", WORK_DIR / "libs47b_cg.so"
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

    c_sh, so_sh = WORK_DIR / "s47b_sh.c", WORK_DIR / "libs47b_sh.so"
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

    cell_name = args.mode if args.mode in ("B0_11", "B1_11") else "B0_00"
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

    if cell_name == "B0_00":
        c_d8, so_d8 = WORK_DIR / "s47b_d8.c", WORK_DIR / "libs47b_d8.so"
        c_d8.write_text(s12a.C_D8CUB_SRC, encoding="utf-8")
        subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_d8), "-o", str(so_d8)], check=True)
        lib_d8 = ctypes.CDLL(str(so_d8))
        lib_d8.extract_deg3_coset_poly.argtypes = [
            ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int,
            ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
            ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_uint64),
        ]
        b_tt = np.zeros((111, 65536), dtype=np.uint8)
        for i, m in enumerate(cb111):
            tmp = m
            while tmp:
                lb = tmp & -tmp
                b_tt[i] ^= orb_tt_np[lb.bit_length() - 1]
                tmp ^= lb
        seen_a, d8_specs = set(), []
        for a in range(1, 256):
            if a in seen_a: continue
            orb_a = [((a << s) | (a >> (8 - s))) & 0xFF for s in range(8)]
            seen_a.update(orb_a)
            olen = len(set(orb_a))
            d8_specs.append((a, 3))
            if olen == 4: d8_specs.append((a, 4))
            elif olen == 2: d8_specs.append((a, 5))
            elif olen == 1: d8_specs.append((a, 6))
        d8_buf = (ctypes.c_uint64 * (len(d8_specs) * n_cw))()
        for idx_d, (a, sb) in enumerate(d8_specs):
            pts = np.array([v | ((v ^ a) << 8) for v in range(256)], dtype=np.uint16)
            b_words = (ctypes.c_uint64 * (111 * 4))()
            for i in range(111):
                bits = b_tt[i, pts]
                for w in range(4):
                    val = 0
                    for b in range(64):
                        if bits[w * 64 + b]: val |= (1 << b)
                    b_words[i * 4 + w] = val
            rptr = ctypes.cast(ctypes.byref(d8_buf, idx_d * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
            lib_d8.extract_deg3_coset_poly(
                b_words, sb, n, tbl["off2"], tbl["off1"], tbl["off0"], n_cw,
                tbl["col2_base"], tbl["col3_base"], rptr
            )
        total_raw = n_base + len(cyc_cubs) + n_cg + len(d8_specs)
        raw_buf = (ctypes.c_uint64 * (total_raw * n_cw))()
        ctypes.memmove(raw_buf, sys_data["rows_c"], n_base * n_cw * 8)
        for idx_c, (_, poly) in enumerate(cyc_cubs):
            s9.pset_to_row(poly, raw_buf, n_base + idx_c, tbl)
        ctypes.memmove(ctypes.byref(raw_buf, (n_base + len(cyc_cubs)) * n_cw * 8), cg_buf, n_cg * n_cw * 8)
        ctypes.memmove(ctypes.byref(raw_buf, (n_base + len(cyc_cubs) + n_cg) * n_cw * 8), d8_buf, len(d8_specs) * n_cw * 8)
        eta_targets = [18, 19, 7, 8, 9, 10]
    else:
        total_raw = n_base + len(cyc_cubs) + n_cg
        raw_buf = (ctypes.c_uint64 * (total_raw * n_cw))()
        ctypes.memmove(raw_buf, sys_data["rows_c"], n_base * n_cw * 8)
        for idx_c, (_, poly) in enumerate(cyc_cubs):
            s9.pset_to_row(poly, raw_buf, n_base + idx_c, tbl)
        ctypes.memmove(ctypes.byref(raw_buf, (n_base + len(cyc_cubs)) * n_cw * 8), cg_buf, n_cg * n_cw * 8)
        eta_targets = [0, 1, 4, 5]

    root = s9.run_branch_cascade(lib9, raw_buf, [], list(range(total_raw)), {}, [], tbl, max_xl_rounds=10, verify_subst=True)
    forms_L1 = s16.extract_forms_from_orb_vecs(cb111, layer_vecs["L1"][1], layer_vecs["L1"][0])
    eta_free = s16.reduce_forms_mod_pivs(forms_L1, root["_lin_pivs"])

    print(f"\n==================== [{args.mode}] STEP 47B: ITERATIVE SYSB + V0 + NT0_POLAR + K_R CASCADE ====================", flush=True)
    for em in eta_targets:
        sys_ex = s45b.extract_eta_exact_system(em, root, eta_free, lib9, lib_sh, tbl, rng_seed=4700 + em)
        if sys_ex.get("closed_unsat"):
            continue
        audit_eta_cascade(f"{cell_name} eta={em}", sys_ex, lib9, rng_seed=4700 + em * 10)

    print(f"\n[{args.mode}] STEP 47B DONE ({time.perf_counter()-t0:.1f}s)", flush=True)


if __name__ == "__main__":
    main()
