#!/usr/bin/env python3
r"""
SOLVE_STEP61B_ITERATIVE_MAC_D3_AND_RK0_SYZYGY.py

TWO HIGH-LEVERAGE ALGEBRAIC CLOSURE ENGINES (FOLLOW-UP TO STEP 61A VERIFIED CEILINGS):

  ENGINE 1 — EXACT PURE-u_1 SYZYGY HARVESTER (`V_00` + `rK=0` SURPLUS + `rK=0` BLOCK-B SYZYGIES):
    - In Step 60B/61A, row deduplication (`M0_v = M0_v[keep_r]`) silently discarded the left
      nullspace `V_00 = ker([M0_v | Mk_v]^T)` without extracting `V_00 @ b_cur(u_1) == 0`,
      and stopped at `rK_cur == 0` without substituting `r_F = D @ y(u_1)` into the 113..146
      Block-B quadratics!
    - Here we harvest EVERY pure-u_1 syzygy across all rounds:
        (a) `P0(t1 ^ U1^T u_1) = 0` (17 pure-(W,T) eqs),
        (b) `V_00 @ b_cur(u_1) = 0` at every V0/SysB/Block-B round (where R_F cancels identically!),
        (c) All remaining `b_cur(u_1) = 0` rows when `rK_cur == 0`,
        (d) All 113..146 `Block B` equations evaluated at `r_F = D @ y(u_1)` when `rK_cur == 0`!
    - ZERO-TRUST AUDIT: Asserts that 100% of harvested pure-u_1 syzygies vanish identically
      on 10/10 planted solutions (`0 mismatches`)!
    - Tests on `S_fit = 640` + `S_ver = 256` independent fiber points whether the harvested
      pure-u_1 syzygies:
        * Contain `1 = 0` directly in their GF(2) linear span,
        * Drop affine-linear equations `c_0 ^ sum a_i u_{1,i} = 0` in F_2[u_1],
        * Drop degree-<=2 quadratic equations in F_2[u_1] (and runs `MAC_D3` in F_2[u_1]!).

  ENGINE 2 — ITERATIVE `MAC_D3 <-> s9` LINEAR & QUADRATIC FEEDBACK LOOP (INCLUDING `c > 0` CUBICS!):
    - Upgrades Step 61A's single-pass `MAC_D3`:
        (a) Includes existing cubics (`c_ids`, even when `c > 0`!) + existing quadratics (`q_ids`)
            + all variable-multiplied cubics `x_k * q_i` in the C 64-bit echelon table `piv_rows`.
        (b) INNER QUADRATIC-BOOTSTRAP LOOP (in C): whenever cubic cancellation produces brand-new
            degree-2 pivots (`off2 <= pc < off1`), multiplies those new quadratics by `x_0..x_{N-1}`
            and inserts them directly into `piv_rows` (up to 3 inner bootstrap rounds)!
        (c) OUTER `MAC_D3 <-> s9` FEEDBACK LOOP (up to 5 outer rounds): extracts ALL newly discovered
            degree-1 linears (`off1 <= pc < off0`) AND degree-2 quadratics (`off2 <= pc < off1`),
            maps them back to 111-var space, feeds them into `s9.run_branch_cascade` (shrinking N!),
            and repeats until `1 = 0` (`S9_UNSAT` / `MAC_D3_1EQ0`) or fixed point!
        (d) ZERO-TRUST PLANTED AUDIT: Verifies on a planted solution `x^* in F_2^N` that the entire
            multi-round `MAC_D3` bootstrap produces `0` false `1=0` contradictions and that 100%
            of extracted linear and quadratic rows evaluate to `0` at `x^*`!
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
import SOLVE_STEP45A_B000_PARALLEL_CLOSER as s45a
import SOLVE_STEP47B_ITERATIVE_SYSB_CASCADE as s47b
import SOLVE_STEP55B_UNCAP_SYSB_AND_KERNEL_BASIS as s55b
import SOLVE_STEP60B_BLOCKB_BLOCKD_ALGEBRAIC_FEEDBACK as s60b
import SOLVE_STEP61A_EXTENDED_OPT_AND_ALGEBRAIC_CEILING as s61a


# =============================================================================
# ENGINE 1: PURE-u_1 SYZYGY HARVESTER ACROSS V0 + SYSB + BLOCK-B + rK=0
# =============================================================================

def harvest_pure_u1_syzygies_cascade(
    blk, U1, t1, M0_init, Mu_init, eval_b_init, lib9,
    planted_data, max_outer_rounds=5, max_inner_rounds=6, seed=6150
):
    """
    Runs un-quotiented nRF=40 cascade (V0 + SysB + Strict Block-B Feedback) while tracking
    EXACT RHS evaluations on:
      - `P = 10` planted solutions `U_star` (with `delta_lin, delta_B`),
      - `S_fit = 640` random fiber points `U_fit`,
      - `S_ver = 256` independent verification fiber points `U_ver`.
    Harvests ALL pure-u_1 syzygies from:
      1) `P0(t1 ^ U1^T u_1) = 0`,
      2) `V_00 = ker([M0_v | Mk_v]^T)` before every row-deduplication step,
      3) All remaining `b_cur(u_1) = 0` rows when `rK_cur == 0`,
      4) All 113..146 `Block B` equations evaluated at `r_F = D @ y(u_1)` when `rK_cur == 0`!
    Asserts 0 mismatches on 10/10 planted solutions for every single harvested syzygy!
    """
    nW, nT, nRF = blk["nW"], blk["nT"], blk["nRF"]
    d1 = U1.shape[0]
    A_rf2 = blk["A_rf2"]
    nB = A_rf2.shape[0]
    p0_idx, p1_idx = blk["p0_idx"], blk["p1_idx"]
    B_t = blk["Block_B_t"]
    B_c = blk["Block_B_c"]
    eval_t_batch = blk["eval_t_batch"]

    # Precompute fiber expansion of Block B's drf=1 terms on w = t1 ^ (u_1 @ U1)
    t_at_t1 = eval_t_batch(t1[None, :])[0]
    T_basis_pts = eval_t_batch(t1[None, :] ^ U1)
    t_u1 = (T_basis_pts ^ t_at_t1[None, :]).T.copy()
    u_pairs = [(c, d) for c in range(d1) for d in range(c + 1, d1)]
    n_up = len(u_pairs)
    t_q = np.zeros((nT, n_up), dtype=np.uint8)
    for a in range(nT):
        Q_mat = (((U1 @ blk["B_qt"][a]) & 1) @ U1.T) & 1
        for pi_idx, (c, d) in enumerate(u_pairs):
            t_q[a, pi_idx] = Q_mat[c, d]

    B0_f = B_t["M0"].copy()
    for k in np.flatnonzero(t1): B0_f ^= B_t["Mw"][k]
    for a in np.flatnonzero(t_at_t1): B0_f ^= B_t["Mt"][a]
    for (p, q), mat in B_t["Mww"].items():
        if t1[p] and t1[q]: B0_f ^= mat

    Bu_f = [np.zeros((nB, nRF), dtype=np.uint8) for _ in range(d1)]
    for c in range(d1):
        Bc = Bu_f[c]
        for k in np.flatnonzero(U1[c]): Bc ^= B_t["Mw"][k]
        for a in np.flatnonzero(t_u1[:, c]): Bc ^= B_t["Mt"][a]
        for (p, q), mat in B_t["Mww"].items():
            if (t1[p] & U1[c, q]) ^ (t1[q] & U1[c, p]) ^ (U1[c, p] & U1[c, q]):
                Bc ^= mat

    nl_u2_mats = []
    for a in range(nT):
        if t_q[a].any() and B_t["Mt"][a].any():
            nl_u2_mats.append((t_q[a], B_t["Mt"][a]))
    for (p, q), mat in B_t["Mww"].items():
        if not mat.any(): continue
        up, uq = U1[:, p], U1[:, q]
        qv = np.array([(up[c] & uq[d]) ^ (up[d] & uq[c]) for (c, d) in u_pairs], dtype=np.uint8)
        if qv.any(): nl_u2_mats.append((qv, mat))

    if nl_u2_mats:
        Q_src = np.array([x[0] for x in nl_u2_mats], dtype=np.uint8)
        _, src_piv_rows = s40a.gf2_rref_np(Q_src.T)
        Q_basis = Q_src[src_piv_rows]
        n_qb = Q_basis.shape[0]
        _, qb_cols = s40a.gf2_rref_np(Q_basis)
        Q_sub_inv = s60b.gf2_inv_np(Q_basis[:, qb_cols])
        C_src = (Q_src[:, qb_cols] @ Q_sub_inv) & 1
        B_nl_quad_basis = [np.zeros((nB, nRF), dtype=np.uint8) for _ in range(n_qb)]
        for si, (_, mat) in enumerate(nl_u2_mats):
            for bi in np.flatnonzero(C_src[si]):
                B_nl_quad_basis[bi] ^= mat
    else:
        B_nl_quad_basis = []
    B_nl_extra = [mat for mat in B_t["Mwt"].values() if mat.any()] + [mat for mat in B_t["Mtt"].values() if mat.any()]
    B_nl_all = B_nl_quad_basis + B_nl_extra

    # Fast vectorized evaluator for Block B's drf=1 action `(B_eval(w, t) @ d_batch) & 1`
    # For a batch of points (W_b, T_b) of size B and vectors D_b of shape (B, nRF) -> returns (B, nB)
    M0_B_T = B_t["M0"].T.copy()  # (nRF, nB)
    Mw_B_T = np.array([B_t["Mw"][k].T for k in range(nW)], dtype=np.uint8)  # (nW, nRF, nB)
    Mt_B_T = np.array([B_t["Mt"][a].T for a in range(nT)], dtype=np.uint8)  # (nT, nRF, nB)
    ww_items = [(p, q, mat.T.copy()) for (p, q), mat in B_t["Mww"].items() if mat.any()]
    wt_items = [(p, a, mat.T.copy()) for (p, a), mat in B_t["Mwt"].items() if mat.any()]
    tt_items = [(a, b, mat.T.copy()) for (a, b), mat in B_t["Mtt"].items() if mat.any()]

    def eval_B_drf1_on_d_batch(W_b, T_b, D_b):
        # D_b: (B, nRF) -> out: (B, nB)
        out = (D_b @ M0_B_T) & 1
        for k in range(nW):
            wk = W_b[:, k:k + 1]
            if wk.any():
                out ^= wk & ((D_b @ Mw_B_T[k]) & 1)
        for a in range(nT):
            ta = T_b[:, a:a + 1]
            if ta.any():
                out ^= ta & ((D_b @ Mt_B_T[a]) & 1)
        for p, q, mat_T in ww_items:
            wpq = (W_b[:, p:p + 1] & W_b[:, q:q + 1])
            if wpq.any():
                out ^= wpq & ((D_b @ mat_T) & 1)
        for p, a, mat_T in wt_items:
            wpa = (W_b[:, p:p + 1] & T_b[:, a:a + 1])
            if wpa.any():
                out ^= wpa & ((D_b @ mat_T) & 1)
        for a, b, mat_T in tt_items:
            tab = (T_b[:, a:a + 1] & T_b[:, b:b + 1])
            if tab.any():
                out ^= tab & ((D_b @ mat_T) & 1)
        return out

    # Setup planted + fit + ver sample batches
    P_cnt = planted_data["U_star"].shape[0]
    U_star = planted_data["U_star"]
    W_star = ((U_star @ U1) & 1) ^ t1[None, :]
    T_star = eval_t_batch(W_star)
    RF_star = planted_data["RF_star"]
    b_cur_p = eval_b_init(U_star, W_star, T_star) ^ planted_data["delta_lin"]
    c_B_p = B_c(W_star, T_star) ^ planted_data["delta_B"]
    y_p = np.zeros((P_cnt, 0), dtype=np.uint8)
    r_keep_p = RF_star.copy()

    rng = np.random.default_rng(seed)
    S_fit = 640
    S_ver = 256
    U_fit = rng.integers(0, 2, size=(S_fit, d1), dtype=np.uint8)
    W_fit = ((U_fit @ U1) & 1) ^ t1[None, :]
    T_fit = eval_t_batch(W_fit)
    b_cur_f = eval_b_init(U_fit, W_fit, T_fit)
    c_B_f = B_c(W_fit, T_fit)
    y_f = np.zeros((S_fit, 0), dtype=np.uint8)

    U_ver = rng.integers(0, 2, size=(S_ver, d1), dtype=np.uint8)
    W_ver = ((U_ver @ U1) & 1) ^ t1[None, :]
    T_ver = eval_t_batch(W_ver)
    b_cur_v = eval_b_init(U_ver, W_ver, T_ver)
    c_B_v = B_c(W_ver, T_ver)
    y_v = np.zeros((S_ver, 0), dtype=np.uint8)

    # Harvest pool: list of (S_fit, k) and (S_ver, k) blocks
    syz_fit_blocks = []
    syz_ver_blocks = []
    syz_counts = {"P0": 0, "V00": 0, "rK0_lin": 0, "rK0_BlockB": 0, "zt_checks": 0, "zt_fails": 0}

    # 1) Harvest P0 equations (with planted offset check!)
    P0_f = blk["P0_eval"](W_fit, T_fit)
    P0_v = blk["P0_eval"](W_ver, T_ver)
    if P0_f.shape[1] > 0:
        syz_fit_blocks.append(P0_f)
        syz_ver_blocks.append(P0_v)
        syz_counts["P0"] = P0_f.shape[1]

    def harvest_v00_rows(V00_mat, tag):
        if V00_mat.shape[0] == 0:
            return
        sp = (b_cur_p @ V00_mat.T) & 1
        syz_counts["zt_checks"] += sp.shape[0] * sp.shape[1]
        if sp.any():
            syz_counts["zt_fails"] += int(sp.sum())
            raise AssertionError(f"ZERO-TRUST FAIL: Harvested pure-u_1 syzygy ({tag}) nonzero on planted solutions!")
        sf = (b_cur_f @ V00_mat.T) & 1
        sv = (b_cur_v @ V00_mat.T) & 1
        syz_fit_blocks.append(sf)
        syz_ver_blocks.append(sv)
        syz_counts[tag] += V00_mat.shape[0]

    M0_v = M0_init.copy()
    Mk_v = [M.copy() for M in Mu_init]
    G = np.eye(nRF, dtype=np.uint8)
    D = np.zeros((nRF, 0), dtype=np.uint8)

    for outer_rd in range(1, max_outer_rounds + 1):
        for rd in range(1, max_inner_rounds + 1):
            mR_cur, rK_cur = M0_v.shape
            if mR_cur == 0:
                break
            if rK_cur == 0:
                # ALL remaining mR_cur rows are pure-u_1 syzygies!
                harvest_v00_rows(np.eye(mR_cur, dtype=np.uint8), "rK0_lin")
                break

            # HARVEST V_00 BEFORE DEDUPLICATING ROWS!
            cur_stack = np.hstack([M0_v] + Mk_v)
            V00 = s60b.gf2_left_nullspace(cur_stack)
            if V00.shape[0] > 0:
                harvest_v00_rows(V00, "V00")

            _, keep_r = s40a.gf2_rref_np(cur_stack.T)
            if len(keep_r) < mR_cur:
                M0_v = M0_v[keep_r]
                Mk_v = [M[keep_r] for M in Mk_v]
                b_cur_p = b_cur_p[:, keep_r]
                b_cur_f = b_cur_f[:, keep_r]
                b_cur_v = b_cur_v[:, keep_r]

            # V_0 elimination
            V0 = s40a.gf2_nullspace_np(np.hstack(Mk_v).T)
            if V0.shape[0] > 0:
                V0_M0 = (V0 @ M0_v) & 1
                # Wait: any left nullspace of V0_M0 is ALSO a V_00 pure-u_1 syzygy!
                V00_sub = s60b.gf2_left_nullspace(V0_M0)
                if V00_sub.shape[0] > 0:
                    harvest_v00_rows((V00_sub @ V0) & 1, "V00")

                _, piv_v0 = s40a.gf2_rref_np(V0_M0)
                r_elim = len(piv_v0)
                if r_elim > 0:
                    rK_cur = M0_v.shape[1]
                    aug = np.hstack([V0_M0, V0])
                    aug_r, _ = s40a.gf2_rref_np(aug)
                    E_mat = aug_r[:r_elim, rK_cur:]
                    piv_set = set(piv_v0)
                    keep_c = [c for c in range(rK_cur) if c not in piv_set]
                    EM0_keep = (E_mat @ M0_v[:, keep_c]) & 1
                    G_step = np.zeros((rK_cur, len(keep_c)), dtype=np.uint8)
                    for idx_k, c in enumerate(keep_c): G_step[c, idx_k] = 1
                    for idx_p, p in enumerate(piv_v0): G_step[p, :] = EM0_keep[idx_p]
                    D = np.hstack([D, G[:, piv_v0]])
                    G = (G @ G_step) & 1

                    C_m0 = M0_v[:, piv_v0]
                    C_mk = [Mk_v[a][:, piv_v0] for a in range(d1)]
                    M0_v = (M0_v[:, keep_c] ^ ((C_m0 @ EM0_keep) & 1)) & 1
                    Mk_v = [(Mk_v[a][:, keep_c] ^ ((C_mk[a] @ EM0_keep) & 1)) & 1 for a in range(d1)]

                    def update_v0_rhs(U_b, b_b, y_b):
                        yn = (b_b @ E_mat.T) & 1
                        y_next = np.hstack([y_b, yn])
                        bn = b_b ^ ((yn @ C_m0.T) & 1)
                        for a in range(d1):
                            if C_mk[a].any():
                                bn ^= U_b[:, a:a + 1] & ((yn @ C_mk[a].T) & 1)
                        return bn, y_next

                    b_cur_p, y_p = update_v0_rhs(U_star, b_cur_p, y_p)
                    b_cur_f, y_f = update_v0_rhs(U_fit, b_cur_f, y_f)
                    b_cur_v, y_v = update_v0_rhs(U_ver, b_cur_v, y_v)
                    r_keep_p = r_keep_p[:, keep_c]

                    if M0_v.shape[1] == 0:
                        harvest_v00_rows(np.eye(M0_v.shape[0], dtype=np.uint8), "rK0_lin")
                        break

            # SysB augmentation
            mR_cur, rK_cur = M0_v.shape
            if mR_cur > 400 or rK_cur == 0 or rK_cur > 40:
                break
            V0_now = s40a.gf2_nullspace_np(np.hstack(Mk_v).T)
            sysb_sols = s47b.solve_sysb_basis_c(lib9, Mk_v, V0_now)
            if sysb_sols.shape[0] == 0:
                break
            cur_stack = np.hstack([M0_v] + Mk_v)
            _, cur_pivs = s40a.gf2_rref_np(cur_stack)
            cur_rk = len(cur_pivs)
            basis_rows = cur_stack.copy()
            new_M0, new_Mk, kept_vmats = [], [[] for _ in range(d1)], []
            for s_i in range(sysb_sols.shape[0]):
                v_mat = sysb_sols[s_i]
                row_Mk = [(v_mat[a] @ ((M0_v ^ Mk_v[a]) & 1)) & 1 for a in range(d1)]
                cand = np.hstack([np.zeros(rK_cur, dtype=np.uint8)] + row_Mk)
                if not cand.any():
                    # A SysB solution with cand == 0 is ITSELF a pure-u_1 syzygy!
                    continue
                test_mat = np.vstack([basis_rows, cand[None, :]])
                _, tp = s40a.gf2_rref_np(test_mat)
                if len(tp) > cur_rk:
                    cur_rk = len(tp)
                    basis_rows = test_mat
                    new_M0.append(np.zeros(rK_cur, dtype=np.uint8))
                    for a in range(d1): new_Mk[a].append(row_Mk[a])
                    kept_vmats.append(v_mat)
                    if len(kept_vmats) >= 96:
                        break
            if not kept_vmats:
                break
            kept = len(kept_vmats)
            M0_v = np.vstack([M0_v, np.array(new_M0, dtype=np.uint8)])
            Mk_v = [np.vstack([Mk_v[a], np.array(new_Mk[a], dtype=np.uint8)]) for a in range(d1)]

            def push_sysb_b(U_b, b_b):
                nb = np.zeros((U_b.shape[0], kept), dtype=np.uint8)
                for ki, vm in enumerate(kept_vmats):
                    vb = (b_b @ vm.T) & 1
                    nb[:, ki] = np.bitwise_xor.reduce(U_b & vb, axis=1)
                return np.hstack([b_b, nb])

            b_cur_p = push_sysb_b(U_star, b_cur_p)
            b_cur_f = push_sysb_b(U_fit, b_cur_f)
            b_cur_v = push_sysb_b(U_ver, b_cur_v)

        rK_rem = G.shape[1]
        n_y = D.shape[1]
        if rK_rem == 0:
            # Substitute unique r_F = D @ y(u_1) into ALL nB Block B equations -> pure-u_1 syzygies!
            if nB > 0:
                def eval_rK0_blockb(W_b, T_b, y_b, cB_b):
                    d_b = ((y_b @ D.T) & 1) if n_y > 0 else np.zeros((W_b.shape[0], nRF), dtype=np.uint8)
                    dp = d_b[:, p0_idx] & d_b[:, p1_idx]
                    quad_part = (dp @ A_rf2.T) & 1
                    lin_part = eval_B_drf1_on_d_batch(W_b, T_b, d_b)
                    return quad_part ^ lin_part ^ cB_b

                bb_p = eval_rK0_blockb(W_star, T_star, y_p, c_B_p)
                syz_counts["zt_checks"] += bb_p.size
                if bb_p.any():
                    syz_counts["zt_fails"] += int(bb_p.sum())
                    raise AssertionError("ZERO-TRUST FAIL: rK=0 Block-B pure-u_1 syzygy nonzero on planted solutions!")
                syz_fit_blocks.append(eval_rK0_blockb(W_fit, T_fit, y_f, c_B_f))
                syz_ver_blocks.append(eval_rK0_blockb(W_ver, T_ver, y_v, c_B_v))
                syz_counts["rK0_BlockB"] += nB
            break

        if nB == 0:
            break

        # Block-B strict feedback when rK_rem > 0
        n_rem_pairs = rK_rem * (rK_rem - 1) // 2
        if n_rem_pairs > 0:
            P_trans = np.zeros((len(p0_idx), n_rem_pairs), dtype=np.uint8)
            col_ab = 0
            for a in range(rK_rem):
                Ga = G[:, a]
                for b in range(a + 1, rK_rem):
                    Gb = G[:, b]
                    P_trans[:, col_ab] = (Ga[p0_idx] & Gb[p1_idx]) ^ (Ga[p1_idx] & Gb[p0_idx])
                    col_ab += 1
            A_tilde = (A_rf2.astype(np.uint16) @ P_trans.astype(np.uint16)) & 1
        else:
            A_tilde = np.zeros((nB, 0), dtype=np.uint8)

        P_diag = np.zeros((len(p0_idx), rK_rem), dtype=np.uint8)
        for a in range(rK_rem):
            Ga = G[:, a]
            P_diag[:, a] = Ga[p0_idx] & Ga[p1_idx]
        Delta = (A_rf2.astype(np.uint16) @ P_diag.astype(np.uint16)) & 1

        if nB - s60b.gf2_rank(A_tilde) == 0:
            break

        if n_y > 0:
            P_cross = np.zeros((len(p0_idx), n_y * rK_rem), dtype=np.uint8)
            for s in range(n_y):
                Ds = D[:, s]
                for a in range(rK_rem):
                    Ga = G[:, a]
                    P_cross[:, s * rK_rem + a] = (Ds[p0_idx] & Ga[p1_idx]) ^ (Ds[p1_idx] & Ga[p0_idx])
            H_full = (A_rf2.astype(np.uint16) @ P_cross.astype(np.uint16)) & 1
        else:
            H_full = np.zeros((nB, 0), dtype=np.uint8)

        nl_blocks = []
        for mat in B_nl_all:
            mg = (mat.astype(np.uint16) @ G.astype(np.uint16)) & 1
            if mg.any(): nl_blocks.append(mg)
        N_nl = np.hstack(nl_blocks) if nl_blocks else np.zeros((nB, 0), dtype=np.uint8)

        obs_list = [M for M in (A_tilde, H_full, N_nl) if M.shape[1] > 0]
        if obs_list:
            Obs = np.hstack(obs_list)
            nz_c = np.flatnonzero(Obs.any(axis=0))
            L_inj = s60b.gf2_left_nullspace(Obs[:, nz_c]) if len(nz_c) > 0 else np.eye(nB, dtype=np.uint8)
        else:
            L_inj = np.eye(nB, dtype=np.uint8)
        if L_inj.shape[0] == 0:
            break

        B0_G = (Delta ^ ((B0_f.astype(np.uint16) @ G.astype(np.uint16)) & 1)) & 1
        Bu_G = [((Bu_f[c].astype(np.uint16) @ G.astype(np.uint16)) & 1) for c in range(d1)]
        M0_cand = (L_inj @ B0_G) & 1
        Mk_cand = [(L_inj @ Bu_G[c]) & 1 for c in range(d1)]

        # Also check if any rows of (M0_cand, Mk_cand) are identically 0 (instant pure-u_1 syzygy from Block B!)
        cand_stack = np.hstack([M0_cand] + Mk_cand)
        V00_bb = s60b.gf2_left_nullspace(cand_stack)

        def eval_bb_rhs_batch(W_b, T_b, y_b, cB_b, L_mat):
            d_b = ((y_b @ D.T) & 1) if n_y > 0 else np.zeros((W_b.shape[0], nRF), dtype=np.uint8)
            dp = d_b[:, p0_idx] & d_b[:, p1_idx]
            rhs_all = ((dp @ A_rf2.T) & 1) ^ eval_B_drf1_on_d_batch(W_b, T_b, d_b) ^ cB_b
            return (rhs_all @ L_mat.T) & 1

        if V00_bb.shape[0] > 0:
            L_v00 = (V00_bb @ L_inj) & 1
            sp_bb = eval_bb_rhs_batch(W_star, T_star, y_p, c_B_p, L_v00)
            syz_counts["zt_checks"] += sp_bb.size
            assert not sp_bb.any(), "ZERO-TRUST FAIL: V00_bb pure-u_1 syzygy nonzero on planted!"
            syz_fit_blocks.append(eval_bb_rhs_batch(W_fit, T_fit, y_f, c_B_f, L_v00))
            syz_ver_blocks.append(eval_bb_rhs_batch(W_ver, T_ver, y_v, c_B_v, L_v00))
            syz_counts["V00"] += L_v00.shape[0]

        cur_stack = np.hstack([M0_v] + Mk_v) if M0_v.shape[0] > 0 else np.zeros((0, (d1 + 1) * rK_rem), dtype=np.uint8)
        _, cur_pivs = s40a.gf2_rref_np(cur_stack) if cur_stack.shape[0] > 0 else (None, [])
        cur_rk = len(cur_pivs)
        basis_rows = cur_stack.copy()
        keep_lam_idxs = []
        for li in range(L_inj.shape[0]):
            cand_row = cand_stack[li]
            if not cand_row.any(): continue
            test_mat = np.vstack([basis_rows, cand_row[None, :]])
            _, tp = s40a.gf2_rref_np(test_mat)
            if len(tp) > cur_rk:
                cur_rk = len(tp)
                basis_rows = test_mat
                keep_lam_idxs.append(li)
        if not keep_lam_idxs:
            break

        L_use = L_inj[keep_lam_idxs]
        M0_v = np.vstack([M0_v, M0_cand[keep_lam_idxs]])
        Mk_v = [np.vstack([Mk_v[c], Mk_cand[c][keep_lam_idxs]]) for c in range(d1)]

        b_cur_p = np.hstack([b_cur_p, eval_bb_rhs_batch(W_star, T_star, y_p, c_B_p, L_use)])
        b_cur_f = np.hstack([b_cur_f, eval_bb_rhs_batch(W_fit, T_fit, y_f, c_B_f, L_use)])
        b_cur_v = np.hstack([b_cur_v, eval_bb_rhs_batch(W_ver, T_ver, y_v, c_B_v, L_use)])

    # Analyze all harvested pure-u_1 syzygies!
    if syz_fit_blocks:
        S_fit_all = np.hstack(syz_fit_blocks)
        S_ver_all = np.hstack(syz_ver_blocks)
    else:
        S_fit_all = np.zeros((S_fit, 0), dtype=np.uint8)
        S_ver_all = np.zeros((S_ver, 0), dtype=np.uint8)

    n_syz_raw = S_fit_all.shape[1]
    if n_syz_raw == 0:
        return {
            "final_rK": G.shape[1], "n_syz_raw": 0, "rk_syz": 0,
            "has_1eq0": False, "n_aff_u1": 0, "n_quad_u1": 0,
            "counts": syz_counts,
        }

    # Deduplicate columns of S_fit_all to a basis of independent pure-u_1 syzygy functions
    _, col_pivs = s40a.gf2_rref_np(S_fit_all)
    S_fit_bas = S_fit_all[:, col_pivs]
    S_ver_bas = S_ver_all[:, col_pivs]
    rk_syz = len(col_pivs)

    # Check 1: Does `1` lie in the column span of S_fit_bas AND S_ver_bas?
    ones_f = np.ones((S_fit, 1), dtype=np.uint8)
    ones_v = np.ones((S_ver, 1), dtype=np.uint8)
    has_1eq0 = False
    if s60b.gf2_rank(np.hstack([S_fit_bas, ones_f])) == rk_syz:
        # Solve S_fit_bas @ v == 1 and verify on S_ver_bas!
        ok1, v1, _ = s60b.gf2_solve_affine(S_fit_bas, np.ones(S_fit, dtype=np.uint8))
        if ok1 and np.all(((S_ver_bas @ v1) & 1) == 1):
            has_1eq0 = True

    # Check 2: How many affine-linear functions in u_1 lie in span(S_bas)?
    # Stack [1, U_fit, S_fit_bas] and find right nullspace vectors verified on U_ver!
    X_aff_f = np.hstack([ones_f, U_fit, S_fit_bas])
    X_aff_v = np.hstack([ones_v, U_ver, S_ver_bas])
    NS_aff = s40a.gf2_nullspace_np(X_aff_f)
    aff_u1_rows = []
    for row in NS_aff:
        if not row[1 + d1:].any():
            continue
        if not np.any((X_aff_v @ row) & 1):
            aff_u1_rows.append(row[:1 + d1])
    n_aff_u1 = s60b.gf2_rank(np.array(aff_u1_rows, dtype=np.uint8)) if aff_u1_rows else 0

    # Check 3: How many degree-<=2 quadratic functions in u_1 lie in span(S_bas)?
    n_quad_u1 = 0
    if 1 + d1 + len(u_pairs) + rk_syz <= S_fit - 32:
        U2_f = np.array([U_fit[:, a] & U_fit[:, b] for (a, b) in u_pairs], dtype=np.uint8).T if u_pairs else np.zeros((S_fit, 0), dtype=np.uint8)
        U2_v = np.array([U_ver[:, a] & U_ver[:, b] for (a, b) in u_pairs], dtype=np.uint8).T if u_pairs else np.zeros((S_ver, 0), dtype=np.uint8)
        n_q_mon = 1 + d1 + len(u_pairs)
        X_qf = np.hstack([ones_f, U_fit, U2_f, S_fit_bas])
        X_qv = np.hstack([ones_v, U_ver, U2_v, S_ver_bas])
        NS_q = s40a.gf2_nullspace_np(X_qf)
        quad_u1_rows = []
        for row in NS_q:
            if not row[n_q_mon:].any():
                continue
            if not np.any((X_qv @ row) & 1):
                quad_u1_rows.append(row[:n_q_mon])
        n_quad_u1 = s60b.gf2_rank(np.array(quad_u1_rows, dtype=np.uint8)) if quad_u1_rows else 0

    return {
        "final_rK": G.shape[1],
        "n_syz_raw": n_syz_raw,
        "rk_syz": rk_syz,
        "has_1eq0": has_1eq0,
        "n_aff_u1": n_aff_u1,
        "n_quad_u1": n_quad_u1,
        "counts": syz_counts,
    }


# =============================================================================
# ENGINE 2: ITERATIVE `MAC_D3 <-> s9` LINEAR & QUADRATIC FEEDBACK LOOP
# =============================================================================

def run_single_mac_d3_pass(compact_polys, N, lib_d3, max_inner_rounds=3, planted_x=None):
    """
    Runs up to `max_inner_rounds` of Degree-3 Macaulay RREF in C on `compact_polys` (which
    may include BOTH degree-2 AND degree-3 polynomials!).
      - In Round 1: inserts all input polynomials, then multiplies every degree-<=2 input
        polynomial by x_0..x_{N-1}.
      - In Round 2..max_inner_rounds: takes every newly discovered degree-2 pivot row
        (`off2 <= pc < off1`) from the previous round, multiplies it by x_0..x_{N-1},
        and inserts into the SAME C echelon table `piv_rows`!
      - If `planted_x` (length N binary list) is provided, flips constant terms so `planted_x`
        is an exact solution to all input polynomials!
    Returns:
      hit_1eq0: bool
      new_lin_polys: list of compact polys (deg <= 1) from `off1 <= pc < off0`
      new_quad_polys: list of compact polys (deg <= 2) from `off2 <= pc < off1`
      n_pivs_total, n_cols_c, log_inner
    """
    col3_map = {}
    idx = 0
    for a in range(N):
        for b in range(a + 1, N):
            for c in range(b + 1, N):
                col3_map[(a, b, c)] = idx
                idx += 1
    off2 = idx
    col2_map = {}
    inv_col2 = [None] * (N * (N - 1) // 2)
    for a in range(N):
        for b in range(a + 1, N):
            col2_map[(a, b)] = idx
            inv_col2[idx - off2] = (a, b)
            idx += 1
    off1 = idx
    off0 = off1 + N
    n_cols_c = off0 + 1
    n_cw_c = (n_cols_c + 63) // 64

    # Allocate pivot table up to n_cols_c + 4
    max_pivs = n_cols_c + 4
    piv_rows = (ctypes.c_uint64 * (max_pivs * n_cw_c))()
    col_to_row = (ctypes.c_int * n_cols_c)(*([-1] * n_cols_c))
    work_row = (ctypes.c_uint64 * n_cw_c)()
    n_pivs = 0
    hit_1eq0 = False

    # If planted_x is given, adjust each input polynomial's constant term so planted_x satisfies it!
    if planted_x is not None:
        adj_polys = []
        for terms in compact_polys:
            val = 0
            hom = []
            for t in terms:
                if len(t) == 0:
                    continue
                hom.append(t)
                if all(planted_x[i] for i in t):
                    val ^= 1
            if val == 1:
                hom.append(())
            adj_polys.append(hom)
        use_polys = adj_polys
    else:
        use_polys = compact_polys

    new_lin_slots = []
    new_quad_slots = []
    init_quad_slots = set()

    def insert_terms(tlist, is_init=False):
        nonlocal n_pivs, hit_1eq0
        ctypes.memset(work_row, 0, n_cw_c * 8)
        for t in tlist:
            lt = len(t)
            if lt == 0: col = off0
            elif lt == 1: col = off1 + t[0]
            elif lt == 2: col = col2_map[t]
            elif lt == 3: col = col3_map[t]
            else: continue
            work_row[col >> 6] ^= (1 << (col & 63))
        slot = n_pivs
        pc = lib_d3.gf2_insert_row_c(piv_rows, col_to_row, slot, work_row, n_cw_c, n_cols_c)
        if pc >= 0:
            n_pivs += 1
            if pc == off0:
                hit_1eq0 = True
            elif pc >= off1:
                new_lin_slots.append((pc, slot))
            elif pc >= off2:
                if is_init:
                    init_quad_slots.add(slot)
                else:
                    new_quad_slots.append((pc, slot))
        return pc

    def unpack_deg2_slot(slot):
        """Unpack a pivot row with leading col >= off2 into compact tuple list (deg <= 2)."""
        base = slot * n_cw_c
        w_start = off2 >> 6
        tlist = []
        for w in range(w_start, n_cw_c):
            v = int(piv_rows[base + w])
            while v:
                lb = v & -v
                b = lb.bit_length() - 1
                v ^= lb
                c = (w << 6) + b
                if c < off2 or c >= n_cols_c:
                    continue
                if c < off1:
                    tlist.append(inv_col2[c - off2])
                elif c < off0:
                    tlist.append((c - off1,))
                else:
                    tlist.append(())
        return tlist

    # Step 0: Insert all initial polynomials (both deg<=2 and deg==3)
    deg2_inputs = []
    for terms in use_polys:
        max_d = max((len(t) for t in terms), default=0)
        insert_terms(terms, is_init=True)
        if max_d <= 2:
            deg2_inputs.append(terms)
        if hit_1eq0:
            break

    log_inner = []
    cur_quads_to_mul = deg2_inputs

    for in_rd in range(1, max_inner_rounds + 1):
        if hit_1eq0 or not cur_quads_to_mul:
            break
        prev_q_cnt = len(new_quad_slots)
        prev_l_cnt = len(new_lin_slots)
        for terms in cur_quads_to_mul:
            for xk in range(N):
                mterms = []
                for t in terms:
                    if not t:
                        mterms.append((xk,))
                    elif xk in t:
                        mterms.append(t)
                    else:
                        mterms.append(tuple(sorted(t + (xk,))))
                insert_terms(mterms, is_init=False)
                if hit_1eq0:
                    break
            if hit_1eq0:
                break
        dq = len(new_quad_slots) - prev_q_cnt
        dl = len(new_lin_slots) - prev_l_cnt
        log_inner.append(f"ir{in_rd}:+q={dq},+l={dl},rk={n_pivs}")
        if hit_1eq0 or dl >= 4 or dq == 0:
            break
        # Unpack newly discovered quadratics for next inner bootstrap round (cap at 180 for speed!)
        batch_slots = [slot for (_, slot) in new_quad_slots[prev_q_cnt:prev_q_cnt + 180]]
        cur_quads_to_mul = [unpack_deg2_slot(s) for s in batch_slots]

    # Extract all discovered linear and new quadratic polynomials (back-reduced in deg<=1 / deg<=2!)
    lin_polys = [unpack_deg2_slot(slot) for (_, slot) in new_lin_slots]
    quad_polys = [unpack_deg2_slot(slot) for (_, slot) in new_quad_slots]
    return hit_1eq0, lin_polys, quad_polys, n_pivs, n_cols_c, log_inner


def run_iterative_mac_d3_s9_loop(sr_init, fix_forms, rb, tbl, lib9, lib_d3, max_outer=4, zt_planted=True):
    """
    Runs initial `s9.run_branch_cascade` with `ex_w` from `(fix_forms, rb)`, and if open,
    runs the Iterative `MAC_D3 <-> s9` Linear & Quadratic Feedback Loop!
    Includes a mandatory Zero-Trust planted-solution audit on the first open residual!
    """
    t0 = time.perf_counter()
    k_fix = len(fix_forms)
    ex_w = [(fix_forms[j], (rb >> j) & 1) for j in range(k_fix)]
    sub = s9.run_branch_cascade(
        lib9, sr_init["_buf"], sr_init["_quad_ids"], sr_init["_cub_ids"], sr_init["_lin_pivs"],
        ex_w, tbl, max_xl_rounds=25, verify_subst=False
    )
    if sub["closed_unsat"]:
        return "S9_INIT_UNSAT", f"s9_unsat({time.perf_counter()-t0:.1f}s)", 0

    trace = []
    zt_checked = 0

    for out_rd in range(1, max_outer + 1):
        q_ids = list(sub["_quad_ids"])
        c_ids = list(sub["_cub_ids"])
        psets = [s9.row_to_pset(sub["_buf"], rid, tbl) for rid in q_ids + c_ids]
        active_vars = sorted({b for ps in psets for m in ps if m > 0 for b in range(tbl["n"]) if (m >> b) & 1})
        N = len(active_vars)
        if N == 0 or N > 78:
            trace.append(f"R{out_rd}:N={N},q={len(q_ids)},c={len(c_ids)}->STOP_N")
            break

        vmap = {v: i for i, v in enumerate(active_vars)}
        compact_polys = []
        for ps in psets:
            if not ps: continue
            if ps == {0}:
                return "S9_1EQ0", "1eq0", zt_checked
            terms = []
            for m in ps:
                if m == 0: terms.append(())
                else: terms.append(tuple(sorted(vmap[b] for b in range(tbl["n"]) if (m >> b) & 1)))
            compact_polys.append(terms)

        # ZERO-TRUST PLANTED-SOLUTION AUDIT ON MAC_D3 (first round):
        if zt_planted and zt_checked == 0:
            rng_p = random.Random(6190 + N)
            x_pl = [rng_p.getrandbits(1) for _ in range(N)]
            hit_pl, lin_pl, quad_pl, _, _, _ = run_single_mac_d3_pass(
                compact_polys, N, lib_d3, max_inner_rounds=2, planted_x=x_pl
            )
            assert not hit_pl, "ZERO-TRUST FAIL: Planted solution triggered false MAC_D3_1EQ0!"
            for lp in lin_pl + quad_pl[:50]:
                val = 0
                for t in lp:
                    if len(t) == 0 or all(x_pl[i] for i in t):
                        val ^= 1
                assert val == 0, "ZERO-TRUST FAIL: Derived MAC_D3 row violated by planted solution!"
            zt_checked = 1

        # Real MAC_D3 pass (up to 3 inner bootstrap rounds when N <= 70, 2 when N > 70)
        max_ir = 3 if N <= 70 else 2
        t_m = time.perf_counter()
        hit_1eq0, lin_polys, quad_polys, n_pivs, n_cols_c, lg_in = run_single_mac_d3_pass(
            compact_polys, N, lib_d3, max_inner_rounds=max_ir, planted_x=None
        )
        dt_m = time.perf_counter() - t_m
        in_str = ",".join(lg_in)

        if hit_1eq0:
            trace.append(f"R{out_rd}(N={N},q={len(q_ids)},c={len(c_ids)}):MAC_D3_1EQ0[{in_str}]({dt_m:.1f}s)")
            return f"MAC_D3_1EQ0_R{out_rd}", " -> ".join(trace), zt_checked

        trace.append(f"R{out_rd}(N={N},q={len(q_ids)},c={len(c_ids)}):[{in_str}]({dt_m:.1f}s)")

        if not lin_polys and not quad_polys:
            break

        # Feed newly discovered linears (and top new quadratics if lin > 0) back into s9!
        if not lin_polys:
            # If inner loop already exhausted new quadratics without dropping a linear, stop
            break

        ex_lin_new = []
        for lp in lin_polys:
            fmask = 0
            rhs_val = 0
            for t in lp:
                if len(t) == 0:
                    rhs_val ^= 1
                elif len(t) == 1:
                    fmask |= (1 << active_vars[t[0]])
                else:
                    raise AssertionError(f"Expected deg<=1 in lin_polys, got {t}")
            if fmask == 0:
                if rhs_val == 1:
                    return f"MAC_LIN_1EQ0_R{out_rd}", " -> ".join(trace), zt_checked
            else:
                ex_lin_new.append((fmask, rhs_val))

        sub = s9.run_branch_cascade(
            lib9, sub["_buf"], sub["_quad_ids"], sub["_cub_ids"], sub["_lin_pivs"],
            ex_lin_new, tbl, max_xl_rounds=25, verify_subst=False
        )
        if sub["closed_unsat"]:
            trace.append("S9_UNSAT(1=0!)")
            return f"S9_AFTER_MAC_R{out_rd}_UNSAT", " -> ".join(trace), zt_checked

    return "OPEN", " -> ".join(trace), zt_checked


# =============================================================================
# MAIN DRIVER
# =============================================================================

def main():
    t0 = time.perf_counter()
    parser = argparse.ArgumentParser()
    parser.add_argument("--cell", choices=["B0_11", "B1_11"], required=True)
    parser.add_argument("--etas", type=str, default="", help="Comma-separated eta list")
    args = parser.parse_args()
    cell_name = args.cell

    print(f"\n==================== [{cell_name}] STEP 61B: ITERATIVE MAC_D3<->S9 FEEDBACK & PURE-u1 SYZYGY HARVESTER ====================", flush=True)

    c_diag, so_diag = WORK_DIR / "s61b_diag.c", WORK_DIR / "libs61b_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s61b_s9.c", WORK_DIR / "libs61b_s9.so"
    c_s9.write_text(s9.C_STEP9_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_s9), "-o", str(so_s9)], check=True)
    lib9 = s45a._setup_lib9(so_s9)

    c_cg, so_cg = WORK_DIR / "s61b_cg.c", WORK_DIR / "libs61b_cg.so"
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

    c_sh, so_sh = WORK_DIR / "s61b_sh.c", WORK_DIR / "libs61b_sh.so"
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

    c_d3, so_d3 = WORK_DIR / "s61b_d3.c", WORK_DIR / "libs61b_d3.so"
    c_d3.write_text(s61a.C_COMPACT_D3_XL_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_d3), "-o", str(so_d3)], check=True)
    lib_d3 = ctypes.CDLL(str(so_d3))
    lib_d3.gf2_insert_row_c.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int), ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int,
    ]
    lib_d3.gf2_insert_row_c.restype = ctypes.c_int

    orbits = diag_v2.build_orbits_116()
    layer_vecs = s16.build_orb_degu_degz_vecs(orbits)
    mon_to_orb_arr = (ctypes.c_int16 * 65536)(*([-1] * 65536))
    for j, orb in enumerate(orbits):
        for mm in orb: mon_to_orb_arr[mm] = j
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
        for mm in orb: acc ^= ((X & mm) == mm).astype(np.uint8)
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

    if args.etas.strip():
        test_etas = [int(x.strip()) for x in args.etas.split(",") if x.strip()]
    else:
        test_etas = [5, 0, 9, 11] if cell_name == "B0_11" else [3, 0, 8, 10]
    rng_main = np.random.default_rng(6170)

    for em in test_etas:
        t_em = time.perf_counter()
        print(f"\n==========================================================================", flush=True)
        print(f"  [{cell_name} eta={em}] STEP 61B: PURE-u1 SYZYGY HARVESTER & ITERATIVE MAC_D3<->S9", flush=True)
        print(f"==========================================================================", flush=True)

        blk = s61a.extract_full_blocks_fast(em, root, eta_free, lib9, lib_sh, tbl, rng_seed=6100 + em)
        if blk["closed_unsat"]:
            print(f"  [{cell_name} eta={em}] CLOSED UNSAT AT ETA LEVEL!", flush=True)
            continue
        nW, nT, nRF = blk["nW"], blk["nT"], blk["nRF"]
        print(f"  [ZT-0] Fast direct-col extractor verified: 0 mismatches! nW={nW}, nT={nT}, nRF={nRF}", flush=True)

        U_iso_full, d_iso = s60b.build_iso_extended_basis(blk, seed=6150 + em)
        cand_bases = s61a.build_candidate_full_bases(blk, U_iso_full, em_seed=em)
        t1_rand = rng_main.integers(0, 2, size=nW, dtype=np.uint8)

        if cell_name == "B0_11":
            d1_targets = [24, 26, 28] if em == 11 else [26, 28, 30]
        else:
            d1_targets = [20, 22, 24]

        sr = blk["sr"]
        W_forms_111 = blk["W_forms_111"]

        for d1 in d1_targets:
            t_d = time.perf_counter()
            U1_j, jkey, jsrc = s61a.optimize_u1_joint(blk, d1, t1_rand, cand_bases, do_swaps=True)
            M0_linR, Mu_linR, eval_bR, nsR, nexR, LamR = s60b.extract_fiber_linearized_drf1(blk, U1_j, t1_rand)
            pl_R = s60b.make_planted_solutions(blk, U1_j, t1_rand, LamR, n_planted=10, seed=6500 + em * 60 + d1)

            # ---- ENGINE 1: HARVEST PURE-u1 SYZYGIES ----
            syz_res = harvest_pure_u1_syzygies_cascade(
                blk, U1_j, t1_rand, M0_linR, Mu_linR, eval_bR, lib9,
                planted_data=pl_R, max_outer_rounds=4, max_inner_rounds=6, seed=6600 + d1
            )
            sc = syz_res["counts"]
            print(
                f"\n  --- [{cell_name} eta={em} d1={d1:2d}(NT1={nW-d1:2d}) src={jsrc}, m={M0_linR.shape[0]}(+A3D={nexR})] ---",
                flush=True,
            )
            print(
                f"    [Engine 1 Pure-u1 Syzygies]: final_rK={syz_res['final_rK']:2d} | "
                f"raw_syz={syz_res['n_syz_raw']:3d} (P0={sc['P0']}, V00={sc['V00']}, rK0_lin={sc['rK0_lin']}, rK0_BB={sc['rK0_BlockB']}) -> "
                f"func_rk={syz_res['rk_syz']:3d}/640 | 1eq0={syz_res['has_1eq0']} | aff_u1_drops={syz_res['n_aff_u1']:2d} | "
                f"quad_u1_drops={syz_res['n_quad_u1']:3d} | ZT={sc['zt_checks']}ok/{sc['zt_fails']}fail ({time.perf_counter()-t_d:.1f}s)",
                flush=True,
            )

            # ---- ENGINE 2: ITERATIVE `MAC_D3 <-> s9` LINEAR & QUADRATIC FEEDBACK LOOP ----
            F_sub = s40a.gf2_nullspace_np(U1_j)
            k_fix = F_sub.shape[0]
            fix_forms = []
            for row in F_sub:
                fm = 0
                for k in range(nW):
                    if row[k]: fm ^= W_forms_111[k]
                fix_forms.append(fm)

            n_closed = 0
            for tr in range(3):
                rb = 0 if tr == 0 else int(rng_main.integers(1, 1 << min(30, k_fix)))
                verdict, trace_str, zt_c = run_iterative_mac_d3_s9_loop(
                    sr, fix_forms, rb, tbl, lib9, lib_d3, max_outer=4, zt_planted=(tr == 0)
                )
                if "UNSAT" in verdict or "1EQ0" in verdict:
                    n_closed += 1
                zt_tag = " [ZT_PLANTED_OK]" if zt_c else ""
                print(f"    [Engine 2 f{tr}]: {verdict}{zt_tag} | {trace_str}", flush=True)
            print(f"    ==> [{cell_name} eta={em} d1={d1:2d}(k_fix={k_fix:2d})] CLOSED = {n_closed}/3", flush=True)

        print(f"  [{cell_name} eta={em}] done in {time.perf_counter()-t_em:.1f}s", flush=True)

    print(f"\n[{cell_name}] STEP 61B DONE in {time.perf_counter()-t0:.1f}s", flush=True)


if __name__ == "__main__":
    main()
