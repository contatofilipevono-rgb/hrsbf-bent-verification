#!/usr/bin/env python3
r"""
SOLVE_STEP45B_POLAR_EXACT_RHS_AND_KL3.py

EXACT RHS EXTRACTION + POLAR PUSH + K_L^{(3)} PURE-u EQUATION AUDIT:
  Modes (--mode):
    - B0_11 / B1_11:
        1. Audits ALL M1 rows (drf==1, dt_c==0) for quadratic-in-W terms w_a*w_b*r_j
           (`n_w2r_rows` vs strictly bilinear `n_strict_bilin`).
        2. Uses strictly bilinear M1 rows + exact t_i = Q_i(w) substitution from the
           n_q quadratics to build exact vectorized `eval_b_orig_batch(W_mat)` and `P0`.
           Zero-Trust verifies 0 mismatches against std_ech on 20 random (w, r_F) points!
        3. Pushes exact RHS b_orig(w) through L_core -> Round-1 Polar -> Round-2 Polar
           (Zero-Trust verified at every stage, 0 mismatches!).
        4. Evaluates pure-u equations K_L^{(3)} (plus P0) across fibers (t1=0 & nonzero shifts),
           exhaustively counts survivors whenever NU_2 <= 16, and computes exact ANF degrees!
        5. Also pushes eta=(1, 4, 5) into Round 2 Polar + K_L^{(3)} audit!
    - B0_00_hard:
        Audits the 7 hardest remaining open non-zero B0_00 orbits (eta = 7,8,9,10,11,18,19)
        with exact bilinear check + Round-1 & Round-2 Polar Tower (K_L3, NU_2, TOTAL_NT).
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
import SOLVE_STEP19_ZEROTRUST_AUDIT_AND_TRUE_WESS_CRUSH as s19
import SOLVE_STEP40A_B11_COMMON_KERNEL_AND_DECOMPOSITION as s40a
import SOLVE_STEP43A_ETA_INVARIANCE_AND_ITERATED_POLAR as s43a
import SOLVE_STEP44A_ITERATED_POLAR_TOWER as s44a


def _eval_pset_point(pset, val_bits):
    res = 0
    for m in pset:
        if (m & val_bits) == m:
            res ^= 1
    return res


def extract_eta_exact_system(em, root, eta_free, lib9, lib_sh, tbl, rng_seed=4500):
    n, n_cw = tbl["n"], tbl["n_col_words"]
    n_cols = tbl["off0"] + 1
    mask64 = (1 << 64) - 1
    n_ef = len(eta_free)
    ex_eta = [(eta_free[k], (em >> k) & 1) for k in range(n_ef)]
    sr = s9.run_branch_cascade(
        lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
        ex_eta, tbl, max_xl_rounds=20, verify_subst=(em == 0)
    )
    if sr["closed_unsat"]:
        return {"closed_unsat": True}

    qps = [s9.row_to_pset(sr["_buf"], qr, tbl) for qr in sr["_quad_ids"]]
    ana = s16.analyze_quad_system(qps)
    W_rref = s19.strict_rref_masks(list(ana["W_piv"].values()))
    W_pivs = sorted(W_rref.keys())
    W_set = set(W_pivs)
    active_now = sorted(i for i in range(n) if i not in sr["_lin_pivs"])
    R_vars = [v for v in active_now if v not in W_set]
    R_set = set(R_vars)

    eq_ids = list(sr["_quad_ids"]) + list(sr["_cub_ids"])
    M_eq = len(eq_ids)
    work = (ctypes.c_uint64 * (M_eq * n_cw))()
    for i, rid in enumerate(eq_ids):
        ctypes.memmove(ctypes.byref(work, i * n_cw * 8), ctypes.byref(sr["_buf"], rid * n_cw * 8), n_cw * 8)
    for p in W_pivs:
        rest = W_rref[p] ^ (1 << p)
        if rest:
            lib_sh.shear_subst_var_batch(
                work, M_eq, n_cw, n, tbl["off2"], tbl["off1"], tbl["off0"],
                tbl["col2_base"], tbl["col3_base"], tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"],
                p, rest & mask64, rest >> 64
            )
    n_q = len(sr["_quad_ids"])
    tail_forms = []
    for qi in range(n_q):
        qps_sh = s9.row_to_pset(work, qi, tbl)
        rmask = 0
        for m in qps_sh:
            if m.bit_count() == 1:
                v = m.bit_length() - 1
                if v in R_set:
                    rmask |= (1 << v)
        if rmask:
            tail_forms.append(rmask)
    T_rref = s19.strict_rref_masks(tail_forms)
    T_pivs = sorted(T_rref.keys())
    T_set = set(T_pivs)
    RF_vars = [v for v in R_vars if v not in T_set]
    RF_set = set(RF_vars)
    nW, nT, nRF = len(W_pivs), len(T_pivs), len(RF_vars)
    for p in T_pivs:
        rest = T_rref[p] ^ (1 << p)
        if rest:
            lib_sh.shear_subst_var_batch(
                work, M_eq, n_cw, n, tbl["off2"], tbl["off1"], tbl["off0"],
                tbl["col2_base"], tbl["col3_base"], tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"],
                p, rest & mask64, rest >> 64
            )

    w_idx = {v: i for i, v in enumerate(W_pivs)}
    t_idx = {v: i for i, v in enumerate(T_pivs)}
    rf_idx = {v: i for i, v in enumerate(RF_vars)}

    # Audit 2: extract exact t_i = Q_i(w) from work[0..n_q-1]
    T_mask_all = sum(1 << v for v in T_pivs)
    RF_mask_all = sum(1 << v for v in RF_vars)
    q_sheared_psets = [s9.row_to_pset(work, qi, tbl) for qi in range(n_q)]
    q_t_vecs = []
    q_w_polys = []
    for ps in q_sheared_psets:
        tvec = 0
        wset = set()
        for m in ps:
            assert (m & RF_mask_all) == 0, f"Unexpected RF var in sheared quad: {hex(m)}"
            if m & T_mask_all:
                assert m.bit_count() == 1, f"Unexpected non-linear T term in quad: {hex(m)}"
                v = m.bit_length() - 1
                tvec |= (1 << t_idx[v])
            else:
                # Remap monomial bits from global 0..n-1 into local W indices 0..nW-1
                wm = 0
                tmp = m
                while tmp:
                    lb = tmp & -tmp
                    v = lb.bit_length() - 1
                    tmp ^= lb
                    wm |= (1 << w_idx[v])
                if wm in wset:
                    wset.remove(wm)
                else:
                    wset.add(wm)
        q_t_vecs.append(tvec)
        q_w_polys.append(wset)

    # Gauss-Jordan RREF over (tvec, wset) to solve each t_i = Q_i(w)
    t_piv_map = {}
    pure_w_quads = []
    for tvec, wset in zip(q_t_vecs, q_w_polys):
        tv = tvec
        ws = set(wset)
        for p_ti, (ptv, pws) in t_piv_map.items():
            if (tv >> p_ti) & 1:
                tv ^= ptv
                ws ^= pws
        if tv == 0:
            if ws:
                pure_w_quads.append(ws)
            continue
        b = (tv & -tv).bit_length() - 1
        for ob in list(t_piv_map.keys()):
            otv, ows = t_piv_map[ob]
            if (otv >> b) & 1:
                t_piv_map[ob] = (otv ^ tv, ows ^ ws)
        t_piv_map[b] = (tv, ws)
    assert len(t_piv_map) == nT, f"Expected full rank nT={nT}, got {len(t_piv_map)}"
    Q_t = [sorted(t_piv_map[ti][1]) for ti in range(nT)]

    # Compile vectorized evaluator for Q_t on W_mat (B, nW) -> T_mat (B, nT)
    qt_c0 = np.zeros(nT, dtype=np.uint8)
    qt_lin = np.zeros((nT, nW), dtype=np.uint8)
    qt_quads = []
    for ti, mlist in enumerate(Q_t):
        qpairs = []
        for wm in mlist:
            if wm == 0:
                qt_c0[ti] ^= 1
            elif wm.bit_count() == 1:
                qt_lin[ti, wm.bit_length() - 1] ^= 1
            elif wm.bit_count() == 2:
                a = (wm & -wm).bit_length() - 1
                b = (wm ^ (1 << a)).bit_length() - 1
                qpairs.append((a, b))
            else:
                raise AssertionError(f"Unexpected deg>=3 term in Q_t: {wm}")
        qt_quads.append(qpairs)

    def eval_t_batch(W_mat):
        B = W_mat.shape[0]
        T_mat = ((W_mat @ qt_lin.T) & 1) ^ qt_c0
        for ti, qpairs in enumerate(qt_quads):
            if qpairs:
                acc = np.zeros(B, dtype=np.uint8)
                for a, b in qpairs:
                    acc ^= (W_mat[:, a] & W_mat[:, b])
                T_mat[:, ti] ^= acc
        return T_mat

    # Zero-Trust verify Q_t against all n_q original sheared quadratics
    rng_zt = random.Random(rng_seed)
    W_test = np.array([[rng_zt.getrandbits(1) for _ in range(nW)] for _ in range(20)], dtype=np.uint8)
    T_test = eval_t_batch(W_test)
    zt_q_mis = 0
    for bi in range(20):
        val_bits = 0
        for k, v in enumerate(W_pivs):
            if W_test[bi, k]: val_bits |= (1 << v)
        for ti, v in enumerate(T_pivs):
            if T_test[bi, ti]: val_bits |= (1 << v)
        for ps in q_sheared_psets:
            if _eval_pset_point(ps, val_bits) != 0:
                zt_q_mis += 1
    assert zt_q_mis == 0, f"t=Q(w) ZT mismatches={zt_q_mis}"

    # Echelonize work in elimination order
    col_keys, col_meta = [], []
    for c in range(n_cols):
        d = int(tbl["col_deg"][c])
        vs = []
        if d >= 1: vs.append(int(tbl["col_v0"][c]))
        if d >= 2: vs.append(int(tbl["col_v1"][c]))
        if d >= 3: vs.append(int(tbl["col_v2"][c]))
        drf = sum(1 for v in vs if v in RF_set)
        dt_c = sum(1 for v in vs if v in T_set)
        col_meta.append((drf, dt_c, d))
        col_keys.append((3 - drf, 3 - dt_c, 3 - d, c))
    col_keys.sort()
    orig_to_perm = (ctypes.c_int * n_cols)()
    perm_to_orig = [0] * n_cols
    for pc, (_, _, _, oc) in enumerate(col_keys):
        orig_to_perm[oc] = pc
        perm_to_orig[pc] = oc
    perm_buf = (ctypes.c_uint64 * (M_eq * n_cw))()
    lib_sh.remap_rows_by_perm(work, perm_buf, M_eq, n_cw, n_cols, orig_to_perm)
    piv_idx = (ctypes.c_int * n_cols)(*([-1] * n_cols))
    ech_rows = []
    for r in range(M_eq):
        pc = lib9.gf2_echelon_insert_s9(perm_buf, r, n_cw, piv_idx, n_cols)
        if pc >= 0:
            ech_rows.append((r, col_meta[perm_to_orig[pc]]))
    inv_perm = (ctypes.c_int * n_cols)(*perm_to_orig)
    std_ech = (ctypes.c_uint64 * (M_eq * n_cw))()
    lib_sh.remap_rows_by_perm(perm_buf, std_ech, M_eq, n_cw, n_cols, inv_perm)

    # Audit 1: Separate strict bilinear M1 rows (d <= 2) vs non-bilinear w_a w_b r_j rows (d == 3)
    M1_all = []
    M1_strict = []
    P0_psets = []
    n_w2r_rows = 0
    for r_id, (drf, dt_c, lead_d) in ech_rows:
        if drf == 1 and dt_c == 0:
            ps = s9.row_to_pset(std_ech, r_id, tbl)
            M1_all.append((lead_d, ps))
            has_w2r = False
            for m in ps:
                vs = [b for b in range(n) if (m >> b) & 1]
                rfvs = [v for v in vs if v in RF_set]
                if len(rfvs) == 1 and len([v for v in vs if v in W_set]) >= 2:
                    has_w2r = True
                    break
            if has_w2r:
                n_w2r_rows += 1
            else:
                M1_strict.append(ps)
        elif drf == 0:
            P0_psets.append(s9.row_to_pset(std_ech, r_id, tbl))

    nM = len(M1_strict)
    M0 = np.zeros((nM, nRF), dtype=np.uint8)
    Mk = np.zeros((nW, nM, nRF), dtype=np.uint8)

    # Build sparse monomial table over concatenated WT (0..nW+nT-1)
    mon_map = {}
    uniq_mons = []

    def compile_drf0_rows(psets_list, check_rf=False):
        consts = np.zeros(len(psets_list), dtype=np.uint8)
        pairs_rc = []
        for ri, ps in enumerate(psets_list):
            for m in ps:
                vs = [b for b in range(n) if (m >> b) & 1]
                if any(v in RF_set for v in vs):
                    continue
                if m == 0:
                    consts[ri] ^= 1
                    continue
                wt_idxs = []
                for v in vs:
                    if v in w_idx:
                        wt_idxs.append(w_idx[v])
                    elif v in t_idx:
                        wt_idxs.append(nW + t_idx[v])
                    else:
                        raise AssertionError(f"Unexpected var {v} in drf=0 term")
                key = tuple(sorted(wt_idxs))
                if key not in mon_map:
                    mon_map[key] = len(uniq_mons)
                    uniq_mons.append(key)
                pairs_rc.append((ri, mon_map[key]))
        mat = np.zeros((len(psets_list), len(uniq_mons) if uniq_mons else 1), dtype=np.uint8)
        for ri, ci in pairs_rc:
            mat[ri, ci] ^= 1
        return consts, pairs_rc

    for ri, ps in enumerate(M1_strict):
        for m in ps:
            vs = [b for b in range(n) if (m >> b) & 1]
            rfvs = [rf_idx[v] for v in vs if v in RF_set]
            if len(rfvs) == 1:
                rfi = rfvs[0]
                wvs = [w_idx[v] for v in vs if v in w_idx]
                assert len(wvs) <= 1, "Strict row leaked deg>=2 in W"
                if len(wvs) == 0: M0[ri, rfi] ^= 1
                else: Mk[wvs[0], ri, rfi] ^= 1
            else:
                assert len(rfvs) == 0, f"Unexpected rfvs={len(rfvs)} in M1_strict"

    b0_const, b0_pairs = compile_drf0_rows(M1_strict)
    p0_const, p0_pairs = compile_drf0_rows(P0_psets)
    n_um = len(uniq_mons)
    B_coeff = np.zeros((nM, max(1, n_um)), dtype=np.uint8)
    for ri, ci in b0_pairs: B_coeff[ri, ci] ^= 1
    P_coeff = np.zeros((len(P0_psets), max(1, n_um)), dtype=np.uint8)
    for ri, ci in p0_pairs: P_coeff[ri, ci] ^= 1
    # Bucket uniq_mons by tuple length (1, 2, 3) for vectorized evaluation
    idx1 = [i for i, k in enumerate(uniq_mons) if len(k) == 1]
    idx2 = [i for i, k in enumerate(uniq_mons) if len(k) == 2]
    idx3 = [i for i, k in enumerate(uniq_mons) if len(k) == 3]
    a1 = np.array([uniq_mons[i][0] for i in idx1], dtype=np.int32)
    a2 = np.array([uniq_mons[i][0] for i in idx2], dtype=np.int32)
    b2 = np.array([uniq_mons[i][1] for i in idx2], dtype=np.int32)
    a3 = np.array([uniq_mons[i][0] for i in idx3], dtype=np.int32)
    b3 = np.array([uniq_mons[i][1] for i in idx3], dtype=np.int32)
    c3 = np.array([uniq_mons[i][2] for i in idx3], dtype=np.int32)

    B_coeff_T = B_coeff.T.copy()
    P_coeff_T = P_coeff.T.copy()

    def eval_b_and_p0_batch(W_mat):
        B = W_mat.shape[0]
        if n_um == 0:
            B_orig = np.broadcast_to(b0_const, (B, nM)).copy()
            P0_vals = np.broadcast_to(p0_const, (B, len(P0_psets))).copy()
            return B_orig, P0_vals
        T_mat = eval_t_batch(W_mat)
        WT = np.hstack([W_mat, T_mat]) if nT > 0 else W_mat
        M_vals = np.zeros((B, n_um), dtype=np.uint8)
        if idx1:
            M_vals[:, idx1] = WT[:, a1]
        if idx2:
            M_vals[:, idx2] = WT[:, a2] & WT[:, b2]
        if idx3:
            M_vals[:, idx3] = WT[:, a3] & WT[:, b3] & WT[:, c3]
        B_orig = ((M_vals @ B_coeff_T) & 1) ^ b0_const
        P0_vals = (((M_vals @ P_coeff_T) & 1) ^ p0_const) if P0_psets else np.zeros((B, 0), dtype=np.uint8)
        return B_orig, P0_vals

    # Zero-Trust Audit 3: Verify ((M0 + sum w_k Mk) @ r_F ^ B_orig(w)) == orig std_ech on 20 random (W, R_F) points!
    RF_test = np.array([[rng_zt.getrandbits(1) for _ in range(nRF)] for _ in range(20)], dtype=np.uint8)
    B_orig_t, P0_t = eval_b_and_p0_batch(W_test)
    zt_b_mis = 0
    for bi in range(20):
        val_bits = 0
        for k, v in enumerate(W_pivs):
            if W_test[bi, k]: val_bits |= (1 << v)
        for ti, v in enumerate(T_pivs):
            if T_test[bi, ti]: val_bits |= (1 << v)
        for fi, v in enumerate(RF_vars):
            if RF_test[bi, fi]: val_bits |= (1 << v)
        M_w = M0.copy()
        for k in range(nW):
            if W_test[bi, k]: M_w ^= Mk[k]
        lhs_vec = ((M_w @ RF_test[bi]) & 1) ^ B_orig_t[bi]
        for ri, ps in enumerate(M1_strict):
            if int(lhs_vec[ri]) != _eval_pset_point(ps, val_bits):
                zt_b_mis += 1
        for pi_idx, ps in enumerate(P0_psets):
            if int(P0_t[bi, pi_idx]) != _eval_pset_point(ps, val_bits):
                zt_b_mis += 1
    assert zt_b_mis == 0, f"B_orig / P0 ZT mismatches={zt_b_mis}"

    K_R = s40a.gf2_nullspace_np(Mk.reshape(nW * nM, nRF)) if nM > 0 else np.eye(nRF, dtype=np.uint8)
    M0_KR = (M0 @ K_R.T) & 1 if (nM > 0 and K_R.shape[0] > 0) else np.zeros((nM, 0), dtype=np.uint8)
    L_core = s40a.gf2_nullspace_np(M0_KR.T) if (nM > 0 and K_R.shape[0] > 0) else np.eye(nM, dtype=np.uint8)
    n_core = L_core.shape[0]
    _, kr_pivs = s40a.gf2_rref_np(K_R) if (K_R.shape[0] > 0 and nM > 0) else (None, [])
    core_rf_cols = [c for c in range(nRF) if c not in set(kr_pivs)]
    nRC = len(core_rf_cols)
    M0_c = (L_core @ M0)[:, core_rf_cols] & 1 if nM > 0 else np.zeros((n_core, nRC), dtype=np.uint8)
    Mk_c = np.zeros((nW, n_core, nRC), dtype=np.uint8)
    if nM > 0:
        for k in range(nW):
            Mk_c[k] = (L_core @ Mk[k])[:, core_rf_cols] & 1

    # Check K_L_core (pure-w linear combinations at root!)
    K_L_core = s40a.gf2_nullspace_np(np.transpose(Mk_c, (0, 2, 1)).reshape(nW * nRC, n_core)) if n_core > 0 else np.zeros((0, 0), dtype=np.uint8)
    # Wait: rows of L_core are in F_2^{nM}, wait: also rows v in K_L_core could have (v @ M0_c) != 0!
    # We must remove non-zero M0_c @ rC part by requiring v @ M0_c == 0 too!
    if n_core > 0:
        K_L0 = s40a.gf2_nullspace_np(np.vstack([M0_c.T, np.transpose(Mk_c, (0, 2, 1)).reshape(nW * nRC, n_core)]))
    else:
        K_L0 = np.zeros((0, 0), dtype=np.uint8)

    return {
        "closed_unsat": False,
        "nW": nW, "nT": nT, "nRF": nRF, "n_q": n_q,
        "n_M1_total": len(M1_all),
        "n_w2r_rows": n_w2r_rows,
        "n_strict_bilin": nM,
        "n_P0": len(P0_psets),
        "core_shape": (n_core, nRC),
        "K_R_dim": K_R.shape[0],
        "K_L0_core_dim": K_L0.shape[0],
        "L_core": L_core, "K_L0": K_L0,
        "M0_c": M0_c, "Mk_c": Mk_c,
        "eval_b_and_p0_batch": eval_b_and_p0_batch,
    }


def build_polar_step_exact(M0_in, Mk_in, K_in, rng_seed=4500):
    """Exact Polar Left-Inverse returning full operators (L, N, H, HB0, HBk, C, K_use) + M_res + U."""
    mW, mR, mC = Mk_in.shape
    B0 = (M0_in @ K_in.T) & 1
    Bk = [(Mk_in[k] @ K_in.T) & 1 for k in range(mW)]
    V_const = s40a.gf2_nullspace_np(np.hstack(Bk).T)
    if V_const.shape[0] == 0:
        return None
    P = (V_const @ B0) & 1
    _, piv_cols = s40a.gf2_rref_np(P)
    r_elim = len(piv_cols)
    if r_elim == 0:
        return None

    K_use = K_in[piv_cols]
    B0_use = B0[:, piv_cols]
    Bk_use = [M[:, piv_cols] for M in Bk]
    P_use = (V_const @ B0_use) & 1
    _, v_row_idxs = s40a.gf2_rref_np(P_use.T)
    S_inv = s43a.gf2_inv_np(P_use[v_row_idxs])
    L = (S_inv @ V_const[v_row_idxs]) & 1
    assert np.array_equal((L @ B0_use) & 1, np.eye(r_elim, dtype=np.uint8))

    N = s40a.gf2_nullspace_np(np.hstack([B0_use] + Bk_use).T)
    LN = np.vstack([L, N]) if N.shape[0] > 0 else L
    _, ln_col_pivs = s40a.gf2_rref_np(LN)
    h_cols = [c for c in range(mR) if c not in set(ln_col_pivs)]
    H = np.eye(mR, dtype=np.uint8)[h_cols]
    NH = np.vstack([N, H]) if N.shape[0] > 0 else H

    _, k_col_pivs = s40a.gf2_rref_np(K_use)
    comp_cols = [c for c in range(mC) if c not in set(k_col_pivs)]
    C = np.eye(mC, dtype=np.uint8)[:, comp_cols]
    nRC_res = C.shape[1]

    D_pm = {0: (M0_in @ C) & 1}
    B_pm = {0: B0_use}
    for k in range(mW):
        dk = (Mk_in[k] @ C) & 1
        if dk.any(): D_pm[1 << k] = dk
        if Bk_use[k].any(): B_pm[1 << k] = Bk_use[k]

    LD_pm = s43a.poly_mat_mul_left(L, D_pm)
    ND_pm = s43a.poly_mat_mul_left(N, D_pm) if N.shape[0] > 0 else {}
    HD_pm = s43a.poly_mat_mul_left(H, D_pm) if H.shape[0] > 0 else {}
    HB_pm = s43a.poly_mat_mul_left(H, B_pm) if H.shape[0] > 0 else {}
    H_quad = s43a.poly_mat_mul_mats(HB_pm, LD_pm)

    H_tot = {}
    for m, A in HD_pm.items(): H_tot[m] = A.copy()
    for m, A in H_quad.items():
        if m in H_tot: H_tot[m] ^= A
        else: H_tot[m] = A.copy()
    H_tot = {m: A for m, A in H_tot.items() if A.any()}

    nN, nH = N.shape[0], H.shape[0]
    n_res_rows = nN + nH
    M_res = {}
    for m in (ND_pm.keys() | H_tot.keys()):
        top = ND_pm.get(m, np.zeros((nN, nRC_res), dtype=np.uint8))
        bot = H_tot.get(m, np.zeros((nH, nRC_res), dtype=np.uint8))
        full = np.vstack([top, bot]) if (nN > 0 and nH > 0) else (top if nH == 0 else bot)
        if full.any(): M_res[m] = full

    HB0 = ((H @ B0_use) & 1).T.copy() if nH > 0 else np.zeros((r_elim, 0), dtype=np.uint8)
    HBk_T = [((H @ Bk_use[k]) & 1).T.copy() for k in range(mW)] if nH > 0 else []
    L_T = L.T.copy()
    N_T = N.T.copy() if nN > 0 else np.zeros((mR, 0), dtype=np.uint8)
    H_T = H.T.copy() if nH > 0 else np.zeros((mR, 0), dtype=np.uint8)

    def push_rhs_batch(X_mat, b_in_mat):
        # X_mat: (B, mW), b_in_mat: (B, mR) -> b_res: (B, n_res_rows)
        B = X_mat.shape[0]
        parts = []
        if nN > 0:
            parts.append((b_in_mat @ N_T) & 1)
        if nH > 0:
            Lb = (b_in_mat @ L_T) & 1
            bH = ((b_in_mat @ H_T) & 1) ^ ((Lb @ HB0) & 1)
            for k in range(mW):
                if HBk_T[k].any():
                    bH ^= X_mat[:, k:k + 1] & ((Lb @ HBk_T[k]) & 1)
            parts.append(bH)
        return np.hstack(parts) if len(parts) > 1 else (parts[0] if parts else np.zeros((B, 0), dtype=np.uint8))

    rad_dim, NU, U = s43a.isotropic_flat_from_poly_mat(M_res, mW)
    NT = mW - NU
    M_u0, M_ua = s44a.specialize_poly_mat_affine_shift(M_res, n_res_rows, nRC_res, mW, 0, U)

    # Zero-Trust test for homogeneous + RHS push on 12 random points
    rng_zt = random.Random(rng_seed)
    X_zt = np.array([[rng_zt.getrandbits(1) for _ in range(mW)] for _ in range(12)], dtype=np.uint8)
    b_zt = np.array([[rng_zt.getrandbits(1) for _ in range(mR)] for _ in range(12)], dtype=np.uint8)
    bres_zt = push_rhs_batch(X_zt, b_zt)
    zt_mis = 0
    for bi in range(12):
        wb = sum((1 << k) for k in range(mW) if X_zt[bi, k])
        rC = np.array([rng_zt.getrandbits(1) for _ in range(nRC_res)], dtype=np.uint8)
        M_w = M0_in.copy()
        for k in range(mW):
            if X_zt[bi, k]: M_w ^= Mk_in[k]
        Dw = (M_w @ C) & 1
        rK = (L @ ((Dw @ rC) ^ b_zt[bi])) & 1
        r_full = ((C @ rC) ^ (K_use.T @ rK)) & 1
        assert not ((L @ ((M_w @ r_full) ^ b_zt[bi])) & 1).any()
        rhs_orig = (NH @ ((M_w @ r_full) ^ b_zt[bi])) & 1
        Mres_w = np.zeros((n_res_rows, nRC_res), dtype=np.uint8)
        for m, A in M_res.items():
            if (m & wb) == m: Mres_w ^= A
        rhs_new = ((Mres_w @ rC) & 1) ^ bres_zt[bi]
        if not np.array_equal(rhs_orig, rhs_new):
            zt_mis += 1
    assert zt_mis == 0, f"Exact RHS polar push ZT mismatches={zt_mis}"

    return {
        "r_elim": r_elim, "n_res_rows": n_res_rows, "nRC_res": nRC_res,
        "nN": nN, "nH": nH, "rad_dim": rad_dim, "NU": NU, "NT": NT, "U": U,
        "M_u0": M_u0, "M_ua": M_ua, "M_res": M_res,
        "L": L, "K_use": K_use, "C": C, "NH": NH, "push_rhs_batch": push_rhs_batch,
    }


def anf_mobius_audit(F_mat, d):
    """Exact GF(2) Mobius transform on shape (2**d, m_eq) -> degree histogram & deg<=1 rank."""
    m_eq = F_mat.shape[1]
    if m_eq == 0:
        return {"max_degs": [], "n_nonzero": 0, "deg_le1_rank": 0, "has_1eq0": False}
    anf = F_mat.copy()
    for bit in range(d):
        step = 1 << bit
        anf_v = anf.reshape(1 << (d - 1 - bit), 2, step, m_eq)
        anf_v[:, 1, :, :] ^= anf_v[:, 0, :, :]
    popcnt = np.array([i.bit_count() for i in range(1 << d)], dtype=np.int32)
    max_degs = []
    for eq in range(m_eq):
        nz = np.flatnonzero(anf[:, eq])
        if len(nz) == 0:
            max_degs.append(-1)
        else:
            max_degs.append(int(popcnt[nz].max()))
    # Check GF(2) rank of full truth-table / ANF rows and check if constant-1 vector is in span
    eq_rows = anf.T  # (m_eq, 2^d)
    # Only run RREF if 2^d <= 65536
    rk_full = len(s40a.gf2_rref_np(eq_rows)[1])
    one_row = np.zeros((1, 1 << d), dtype=np.uint8)
    one_row[0, 0] = 1
    rk_with_one = len(s40a.gf2_rref_np(np.vstack([eq_rows, one_row]))[1])
    has_1eq0 = (rk_with_one == rk_full)
    deg1_cols = [0] + [1 << b for b in range(d)]
    rk_deg1 = len(s40a.gf2_rref_np(anf[deg1_cols, :].T)[1])
    deg2_cols = deg1_cols + [(1 << i) | (1 << j) for i in range(d) for j in range(i + 1, d)]
    rk_deg2 = len(s40a.gf2_rref_np(anf[deg2_cols, :].T)[1])
    return {
        "n_nonzero": sum(1 for md in max_degs if md >= 0),
        "deg_hist": {deg: sum(1 for md in max_degs if md == deg) for deg in sorted(set(max_degs)) if deg >= 0},
        "rk_full": rk_full,
        "rk_deg1": rk_deg1,
        "rk_deg2": rk_deg2,
        "has_1eq0": has_1eq0,
    }


def eval_kl3_and_anf(cell_tag, sys_ex, p1, df2, t1_list, rng_seed=4550):
    nW = sys_ex["nW"]
    nR1, nC1, NU1 = p1["n_res_rows"], p1["nRC_res"], p1["NU"]
    low2, full_bas2, _ = s44a.minrank_basis(p1["M_ua"], rk_cap=18, n_rounds=2, seed=rng_seed)
    if df2 > NU1:
        return
    rstack2 = np.array([sum(p1["M_ua"][a] for a in range(NU1) if (cm >> a) & 1) for cm in full_bas2[:df2]], dtype=np.uint8)
    rstack2 = (rstack2 & 1).reshape(df2 * nR1, nC1)
    K2 = s40a.gf2_nullspace_np(rstack2)
    if K2.shape[0] == 0:
        return

    L_core_T = sys_ex["L_core"].T.copy()
    U1 = p1["U"]
    rng = random.Random(rng_seed + 77)

    for idx_t1, t1_int in enumerate(t1_list):
        t1_vec = np.array([(t1_int >> k) & 1 for k in range(nW)], dtype=np.uint8)
        Mu0_t, Mua_t = s44a.specialize_poly_mat_affine_shift(p1["M_res"], nR1, nC1, nW, t1_int, U1)
        p2 = build_polar_step_exact(Mu0_t, Mua_t, K2, rng_seed=rng_seed + idx_t1 * 13)
        if p2 is None:
            print(f"    [{cell_tag} t1_idx={idx_t1}] R2 polar failed", flush=True)
            continue
        NU2, nR2, nC2 = p2["NU"], p2["n_res_rows"], p2["nRC_res"]
        U2 = p2["U"]

        # Exact pure-u left kernel of M_res_2 (BOTH M_u2_0 and M_u2_a must be zero on K_L3!)
        # Wait: Wait a second! In Step 44A, K_L3 was left nullspace of M_ua ONLY (giving affine eqs (K_L3 @ M_u0) rC ^ K_L3 b_res2 = 0)!
        # Check BOTH: K_L3_quad (kills ONLY M_u2_a, leaving linear in rC2!) AND K_L3_pure (kills BOTH M_u2_0 and M_u2_a -> ZERO rC2!!)!
        stack_ua = np.transpose(p2["M_ua"], (0, 2, 1)).reshape(NU2 * nC2, nR2) if NU2 > 0 else np.zeros((0, nR2), dtype=np.uint8)
        K_L3_pure = s40a.gf2_nullspace_np(np.vstack([p2["M_u0"].T, stack_ua])) if nR2 > 0 else np.zeros((0, 0), dtype=np.uint8)
        K_L3_aff = s40a.gf2_nullspace_np(stack_ua) if nR2 > 0 else np.zeros((0, 0), dtype=np.uint8)

        print(
            f"    [{cell_tag} t1_idx={idx_t1} df2={df2}] R2 r_elim={p2['r_elim']} -> {nR2}x{nC2} "
            f"(NU_2={NU2}, NT_2={p2['NT']}, TOTAL_NT={p1['NT']+p2['NT']}) | "
            f"K_L3_aff={K_L3_aff.shape[0]}, K_L3_PURE_U={K_L3_pure.shape[0]}",
            flush=True,
        )

        # End-to-end pipeline W_of(u2) and b_res2(u2) for a fiber shift t2 in F_2^{NU1}
        def eval_u2_fiber(U2_mat, t2_vec):
            # u1 = t2 ^ U2_mat @ U2
            u1_mat = ((U2_mat @ U2) & 1) ^ t2_vec
            w_mat = ((u1_mat @ U1) & 1) ^ t1_vec
            b_orig, p0_vals = sys_ex["eval_b_and_p0_batch"](w_mat)
            b_c = (b_orig @ L_core_T) & 1
            b_res1 = p1["push_rhs_batch"](w_mat, b_c)
            b_res2 = p2["push_rhs_batch"](u1_mat, b_res1)
            kl3_vals = (b_res2 @ K_L3_pure.T) & 1 if K_L3_pure.shape[0] > 0 else np.zeros((U2_mat.shape[0], 0), dtype=np.uint8)
            k0_vals = (b_c @ sys_ex["K_L0"].T) & 1 if sys_ex["K_L0"].shape[0] > 0 else np.zeros((U2_mat.shape[0], 0), dtype=np.uint8)
            return w_mat, u1_mat, b_c, b_res1, b_res2, kl3_vals, k0_vals, p0_vals

        # End-to-end Zero-Trust check on 10 random (u2, r_C2) points!
        if idx_t1 == 0:
            t2_zt = np.array([rng.getrandbits(1) for _ in range(NU1)], dtype=np.uint8)
            U2_zt = np.array([[rng.getrandbits(1) for _ in range(NU2)] for _ in range(10)], dtype=np.uint8)
            w_zt, u1_zt, bc_zt, br1_zt, br2_zt, kl3_zt, k0_zt, p0_zt = eval_u2_fiber(U2_zt, t2_zt)
            for bi in range(10):
                rC2 = np.array([rng.getrandbits(1) for _ in range(p2["nRC_res"])], dtype=np.uint8)
                M2_w = Mu0_t.copy()
                for a in range(NU1):
                    if u1_zt[bi, a]: M2_w ^= Mua_t[a]
                D2 = (M2_w @ p2["C"]) & 1
                rK2 = (p2["L"] @ ((D2 @ rC2) ^ br1_zt[bi])) & 1
                rC1 = ((p2["C"] @ rC2) ^ (p2["K_use"].T @ rK2)) & 1
                assert not ((p2["L"] @ ((M2_w @ rC1) ^ br1_zt[bi])) & 1).any()
                M_u2 = p2["M_u0"].copy()
                for g in range(NU2):
                    if U2_zt[bi, g]: M_u2 ^= p2["M_ua"][g]
                assert not ((p2["NH"] @ ((M2_w @ rC1) ^ br1_zt[bi])) ^ ((M_u2 @ rC2) & 1) ^ br2_zt[bi]).any()
                if K_L3_pure.shape[0] > 0:
                    # K_L3_pure annihilates both M_u0 and M_ua, so K_L3_pure @ NH2 @ (M2 rC1 ^ br1) MUST equal kl3_zt!
                    lhs_direct = (K_L3_pure @ p2["NH"] @ ((M2_w @ rC1) ^ br1_zt[bi])) & 1
                    assert np.array_equal(lhs_direct, kl3_zt[bi]), "End-to-end K_L3_pure ZT mismatch!"
            print(f"      [ZT PASSED] End-to-end 2-round polar RHS + K_L3_pure verified (0 mismatches across 10 points)!", flush=True)

        n_t2_tests = 17 if (NU2 <= 16 and idx_t1 == 0) else (5 if NU2 <= 16 else 4)
        t2_shifts = [np.zeros(NU1, dtype=np.uint8)] + [
            np.array([rng.getrandbits(1) for _ in range(NU1)], dtype=np.uint8) for _ in range(n_t2_tests - 1)
        ]

        if NU2 <= 16:
            N_pts = 1 << NU2
            ints = np.arange(N_pts, dtype=np.uint32)[:, None]
            U2_all = ((ints >> np.arange(NU2, dtype=np.uint32)) & 1).astype(np.uint8)
            surv_list = []
            for j2, t2v in enumerate(t2_shifts):
                _, _, _, _, _, kl3_all, k0_all, p0_all = eval_u2_fiber(U2_all, t2v)
                comb = np.hstack([kl3_all, k0_all, p0_all])
                ok_kl3 = int(np.sum(np.all(kl3_all == 0, axis=1))) if kl3_all.shape[1] > 0 else N_pts
                ok_all = int(np.sum(np.all(comb == 0, axis=1))) if comb.shape[1] > 0 else N_pts
                surv_list.append((ok_kl3, ok_all))
                if j2 == 0 and (idx_t1 == 0):
                    anf_kl3 = anf_mobius_audit(kl3_all, NU2)
                    anf_all = anf_mobius_audit(comb, NU2)
                    print(f"      [EXACT FULL-FIBER t2=0 (N=2^{NU2}={N_pts})]", flush=True)
                    print(f"        KL3_PURE ({kl3_all.shape[1]} eqs): surv={ok_kl3}/{N_pts}, ANF={anf_kl3}", flush=True)
                    print(f"        KL3+K0+P0 ({comb.shape[1]} eqs): surv={ok_all}/{N_pts}, ANF={anf_all}", flush=True)
            print(f"      [EXACT SURVIVORS across {len(t2_shifts)} t2 fibers (kl3_only, total)]: {surv_list[:10]} (max_total={max(x[1] for x in surv_list)})", flush=True)
        else:
            # Sample 4096 random u2 points on each t2 shift + exact ANF on 12-dim slices
            U2_samp = np.array([[rng.getrandbits(1) for _ in range(NU2)] for _ in range(4096)], dtype=np.uint8)
            stats = []
            for j2, t2v in enumerate(t2_shifts):
                _, _, _, _, _, kl3_s, k0_s, p0_s = eval_u2_fiber(U2_samp, t2v)
                comb = np.hstack([kl3_s, k0_s, p0_s])
                rk_k = len(s40a.gf2_rref_np(kl3_s.T)[1]) if kl3_s.shape[1] > 0 else 0
                rk_c = len(s40a.gf2_rref_np(comb.T)[1]) if comb.shape[1] > 0 else 0
                ok_k = int(np.sum(np.all(kl3_s == 0, axis=1))) if kl3_s.shape[1] > 0 else 4096
                ok_c = int(np.sum(np.all(comb == 0, axis=1))) if comb.shape[1] > 0 else 4096
                stats.append((ok_k, ok_c, rk_k, rk_c))
            print(f"      [SAMPLE 4096 across {len(t2_shifts)} t2 fibers (ok_kl3, ok_tot, rk_kl3, rk_tot)]: {stats}", flush=True)
            # 12-dim affine slice ANF audit
            ints12 = np.arange(4096, dtype=np.uint32)[:, None]
            S12 = ((ints12 >> np.arange(12, dtype=np.uint32)) & 1).astype(np.uint8)
            cols_pick = rng.sample(range(NU2), 12)
            U2_sl = np.zeros((4096, NU2), dtype=np.uint8)
            U2_sl[:, cols_pick] = S12
            _, _, _, _, _, kl3_sl, k0_sl, p0_sl = eval_u2_fiber(U2_sl, np.zeros(NU1, dtype=np.uint8))
            print(f"      [12-DIM SLICE ANF] KL3={anf_mobius_audit(kl3_sl, 12)}, ALL={anf_mobius_audit(np.hstack([kl3_sl, k0_sl, p0_sl]), 12)}", flush=True)


def run_b11_cell(cell_name, lib_diag, lib9, lib_cg, lib_sh, orbits, layer_vecs,
                 v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl):
    t0 = time.perf_counter()
    print(f"\n==================== [{cell_name}] STEP 45B: EXACT RHS + K_L^(3) AUDIT ====================", flush=True)
    c99, c57, c113 = int(cell_name[1]), int(cell_name[3]), int(cell_name[4])
    free111, origin111, cb111 = b09.build_pure_111_basis(c99, c57, c113)
    n, n_cw = tbl["n"], tbl["n_col_words"]

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

    for em in [0, 1, 4, 5]:
        sys_ex = extract_eta_exact_system(em, root, eta_free, lib9, lib_sh, tbl, rng_seed=4520 + em)
        print(
            f"\n  [{cell_name} eta={em}] AUDIT: M1_total={sys_ex['n_M1_total']}, n_w2r_rows={sys_ex['n_w2r_rows']}, "
            f"strict_bilin={sys_ex['n_strict_bilin']}, n_P0={sys_ex['n_P0']}, "
            f"core_strict={sys_ex['core_shape']} (K_R={sys_ex['K_R_dim']}, K_L0={sys_ex['K_L0_core_dim']}) [ZT PASSED]",
            flush=True,
        )
        nW, n_core, nRC = sys_ex["nW"], sys_ex["core_shape"][0], sys_ex["core_shape"][1]
        _, full_bas1, _ = s44a.minrank_basis(sys_ex["Mk_c"], rk_cap=24, n_rounds=3, seed=4530 + em)

        if em == 0:
            df_list = [12, 30, 34] if cell_name == "B0_11" else [6, 14]
        else:
            df_list = [6, 12, 20, 28]

        rng_t1 = random.Random(4540 + em)
        best_r1 = None
        for df in df_list:
            if df > nW: continue
            rstack = np.array(
                [sum(sys_ex["Mk_c"][k] for k in range(nW) if (cm >> k) & 1) for cm in full_bas1[:df]],
                dtype=np.uint8,
            )
            rstack = (rstack & 1).reshape(df * n_core, nRC)
            K1 = s40a.gf2_nullspace_np(rstack)
            if K1.shape[0] == 0: continue
            p1 = build_polar_step_exact(sys_ex["M0_c"], sys_ex["Mk_c"], K1, rng_seed=4550 + em * 10 + df)
            if p1 is None: continue
            print(
                f"    [eta={em} R1 df={df:2d}] r_elim_1={p1['r_elim']:2d} -> M_res_1={p1['n_res_rows']}x{p1['nRC_res']} "
                f"(NU_1={p1['NU']}, NT_1={p1['NT']}, rad={p1['rad_dim']})",
                flush=True,
            )
            if em == 0:
                t1_list = [0] + [rng_t1.getrandbits(nW) for _ in range(4)]
                if cell_name == "B0_11":
                    df2_target = 12 if df == 12 else (24 if df == 34 else 20)
                else:
                    df2_target = 4 if df == 6 else 2
                # Find best df2 near target with positive R2 elimination
                cand_df2 = sorted(set([df2_target, 1, 2, 4, 6, 8, 12, 20, 24]))
                best_df2 = None
                _, fb2_check, _ = s44a.minrank_basis(p1["M_ua"], rk_cap=18, n_rounds=2, seed=4560 + df)
                for df2c in cand_df2:
                    if df2c > p1["NU"]: continue
                    rs2 = np.array([sum(p1["M_ua"][a] for a in range(p1["NU"]) if (cm >> a) & 1) for cm in fb2_check[:df2c]], dtype=np.uint8)
                    rs2 = (rs2 & 1).reshape(df2c * p1["n_res_rows"], p1["nRC_res"])
                    K2c = s40a.gf2_nullspace_np(rs2)
                    if K2c.shape[0] == 0: continue
                    B02 = (p1["M_u0"] @ K2c.T) & 1
                    Bk2 = [(p1["M_ua"][a] @ K2c.T) & 1 for a in range(p1["NU"])]
                    Vc2 = s40a.gf2_nullspace_np(np.hstack(Bk2).T)
                    r2e = len(s40a.gf2_rref_np((Vc2 @ B02) & 1)[1]) if Vc2.shape[0] > 0 else 0
                    if r2e >= 2 and (best_df2 is None or (r2e, df2c) > (best_df2[0], best_df2[1])):
                        best_df2 = (r2e, df2c)
                if best_df2:
                    eval_kl3_and_anf(f"{cell_name} eta=0 df={df}", sys_ex, p1, best_df2[1], t1_list, rng_seed=4560 + df)
            else:
                if best_r1 is None or (p1["r_elim"], -p1["NT"]) > (best_r1[0]["r_elim"], -best_r1[0]["NT"]):
                    best_r1 = (p1, df)

        if em != 0 and best_r1 is not None:
            p1, df_best = best_r1
            t1_list = [0] + [rng_t1.getrandbits(nW) for _ in range(3)]
            _, fb2, _ = s44a.minrank_basis(p1["M_ua"], rk_cap=18, n_rounds=2, seed=4570 + em)
            best_df2 = None
            for df2 in [1, 2, 4, 6, 8, 12, 16, 20]:
                if df2 > p1["NU"]: continue
                rs2 = np.array([sum(p1["M_ua"][a] for a in range(p1["NU"]) if (cm >> a) & 1) for cm in fb2[:df2]], dtype=np.uint8)
                rs2 = (rs2 & 1).reshape(df2 * p1["n_res_rows"], p1["nRC_res"])
                K2 = s40a.gf2_nullspace_np(rs2)
                if K2.shape[0] == 0: continue
                B02 = (p1["M_u0"] @ K2.T) & 1
                Bk2 = [(p1["M_ua"][a] @ K2.T) & 1 for a in range(p1["NU"])]
                Vc2 = s40a.gf2_nullspace_np(np.hstack(Bk2).T)
                r2e = len(s40a.gf2_rref_np((Vc2 @ B02) & 1)[1]) if Vc2.shape[0] > 0 else 0
                if r2e >= 2:
                    print(f"    [eta={em} R2 sweep] df2={df2:2d}: K2={K2.shape[0]}, r_elim_2={r2e}", flush=True)
                    if best_df2 is None or (r2e, df2) > best_df2:
                        best_df2 = (r2e, df2)
            if best_df2:
                eval_kl3_and_anf(f"{cell_name} eta={em} df={df_best}", sys_ex, p1, best_df2[1], t1_list, rng_seed=4570 + em)

    print(f"\n[{cell_name}] STEP 45B DONE ({time.perf_counter()-t0:.1f}s)", flush=True)


def run_b000_hard(lib_diag, lib9, lib_cg, lib_d8, lib_sh, orbits, layer_vecs,
                  v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl):
    t0 = time.perf_counter()
    print("\n==================== [B0_00_hard] STEP 45B: POLAR TOWER AUDIT (eta=7,8,9,10,11,18,19) ====================", flush=True)
    n, n_cw = tbl["n"], tbl["n_col_words"]
    free111, origin111, cb111 = b09.build_pure_111_basis(0, 0, 0)
    b_tt = np.zeros((111, 65536), dtype=np.uint8)
    X = np.arange(65536, dtype=np.uint16)
    orb_tt_np = np.zeros((116, 65536), dtype=np.uint8)
    for j, orb in enumerate(orbits):
        acc = np.zeros(65536, dtype=np.uint8)
        for m in orb: acc ^= ((X & m) == m).astype(np.uint8)
        orb_tt_np[j] = acc
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

    orb_map = (ctypes.c_int * 116)(*([-1] * 116))
    for i, j in enumerate(free111): orb_map[j] = i
    orb_map[0] = -3; orb_map[115] = -1; orb_map[99] = -1; orb_map[57] = -1; orb_map[113] = -1
    L_set = set(diag_v2.L_INDICES)
    L_vars_py = [i for i, j in enumerate(free111) if j in L_set]
    L_vars_arr = (ctypes.c_int * len(L_vars_py))(*L_vars_py)

    n_cg = len(reps12) + len(reps11)
    cg_buf = (ctypes.c_uint64 * (n_cg * n_cw))()
    for idx, I_m in enumerate(reps12):
        rptr = ctypes.cast(ctypes.byref(cg_buf, idx * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
        lib_cg.build_cg12_row_c(
            I_m, mon_to_orb_arr, orb_map, 0, L_vars_arr, len(L_vars_py),
            n, tbl["off2"], tbl["off1"], tbl["off0"], n_cw, tbl["col2_base"], tbl["col3_base"], rptr
        )
    for idx, I_m in enumerate(reps11):
        rptr = ctypes.cast(ctypes.byref(cg_buf, (len(reps12) + idx) * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
        lib_cg.build_cg11_row_c(
            I_m, mon_to_orb_arr, orb_map, 0, L_vars_arr, len(L_vars_py),
            n, tbl["off2"], tbl["off1"], tbl["off0"], n_cw, tbl["col2_base"], tbl["col3_base"], rptr
        )

    sys_data = diag_v2.build_cell_algebraic_system("B0_00", lib_diag, orbits, v6_list, rot4_data, fiber_meta, extract_sec=18.0)
    cyc_cubs = s9.extract_verified_cyclotomic_cubics("B0_00", orbits, origin111, cb111, layers, c0x0)
    n_base = sum(sys_data["deg_pivs_111"].values())
    total_raw = n_base + len(cyc_cubs) + n_cg + len(d8_specs)
    raw_buf = (ctypes.c_uint64 * (total_raw * n_cw))()
    ctypes.memmove(raw_buf, sys_data["rows_c"], n_base * n_cw * 8)
    for idx_c, (_, poly) in enumerate(cyc_cubs):
        s9.pset_to_row(poly, raw_buf, n_base + idx_c, tbl)
    ctypes.memmove(ctypes.byref(raw_buf, (n_base + len(cyc_cubs)) * n_cw * 8), cg_buf, n_cg * n_cw * 8)
    ctypes.memmove(ctypes.byref(raw_buf, (n_base + len(cyc_cubs) + n_cg) * n_cw * 8), d8_buf, len(d8_specs) * n_cw * 8)

    root = s9.run_branch_cascade(lib9, raw_buf, [], list(range(total_raw)), {}, [], tbl, max_xl_rounds=10, verify_subst=True)
    forms_L1 = s16.extract_forms_from_orb_vecs(cb111, layer_vecs["L1"][1], layer_vecs["L1"][0])
    eta_free = s16.reduce_forms_mod_pivs(forms_L1, root["_lin_pivs"])

    for em in [7, 8, 9, 10, 11, 18, 19]:
        sys_ex = extract_eta_exact_system(em, root, eta_free, lib9, lib_sh, tbl, rng_seed=4600 + em)
        print(
            f"\n  [B0_00 eta={em:2d}] AUDIT: M1_total={sys_ex['n_M1_total']}, n_w2r={sys_ex['n_w2r_rows']}, "
            f"strict={sys_ex['n_strict_bilin']}, core={sys_ex['core_shape']} (K_R={sys_ex['K_R_dim']}, K_L0={sys_ex['K_L0_core_dim']})",
            flush=True,
        )
        nW, n_core, nRC = sys_ex["nW"], sys_ex["core_shape"][0], sys_ex["core_shape"][1]
        if n_core == 0 or nRC == 0:
            continue
        _, full_bas1, _ = s44a.minrank_basis(sys_ex["Mk_c"], rk_cap=24, n_rounds=3, seed=4610 + em)
        best_r1 = None
        for df in [6, 12, 18, 24, 30, 34]:
            if df > nW: continue
            rs = np.array([sum(sys_ex["Mk_c"][k] for k in range(nW) if (cm >> k) & 1) for cm in full_bas1[:df]], dtype=np.uint8)
            rs = (rs & 1).reshape(df * n_core, nRC)
            K1 = s40a.gf2_nullspace_np(rs)
            if K1.shape[0] == 0: continue
            p1 = build_polar_step_exact(sys_ex["M0_c"], sys_ex["Mk_c"], K1, rng_seed=4620 + em * 10 + df)
            if p1 is not None:
                print(
                    f"    [eta={em:2d} R1 df={df:2d}] r_elim_1={p1['r_elim']:2d} -> {p1['n_res_rows']}x{p1['nRC_res']} "
                    f"(NU_1={p1['NU']}, NT_1={p1['NT']})",
                    flush=True,
                )
                if best_r1 is None or (p1["r_elim"], -p1["NT"]) > (best_r1[0]["r_elim"], -best_r1[0]["NT"]):
                    best_r1 = (p1, df)

        if best_r1 is not None:
            p1, df_b = best_r1
            _, fb2, _ = s44a.minrank_basis(p1["M_ua"], rk_cap=18, n_rounds=2, seed=4640 + em)
            best_df2 = None
            for df2 in [1, 2, 4, 6, 8, 12, 16, 20]:
                if df2 > p1["NU"]: continue
                rs2 = np.array([sum(p1["M_ua"][a] for a in range(p1["NU"]) if (cm >> a) & 1) for cm in fb2[:df2]], dtype=np.uint8)
                rs2 = (rs2 & 1).reshape(df2 * p1["n_res_rows"], p1["nRC_res"])
                K2 = s40a.gf2_nullspace_np(rs2)
                if K2.shape[0] == 0: continue
                B02 = (p1["M_u0"] @ K2.T) & 1
                Bk2 = [(p1["M_ua"][a] @ K2.T) & 1 for a in range(p1["NU"])]
                Vc2 = s40a.gf2_nullspace_np(np.hstack(Bk2).T)
                r2e = len(s40a.gf2_rref_np((Vc2 @ B02) & 1)[1]) if Vc2.shape[0] > 0 else 0
                if r2e >= 1 and (best_df2 is None or (r2e, df2) > best_df2):
                    best_df2 = (r2e, df2)
            if best_df2:
                eval_kl3_and_anf(f"B0_00 eta={em} df={df_b}", sys_ex, p1, best_df2[1], [0, 1], rng_seed=4650 + em)

    print(f"\n[B0_00_hard] STEP 45B DONE ({time.perf_counter()-t0:.1f}s)", flush=True)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--mode", choices=["B0_11", "B1_11", "B0_00_hard"], required=True)
    args = parser.parse_args()

    c_diag, so_diag = WORK_DIR / "s45b_diag.c", WORK_DIR / "libs45b_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s45b_s9.c", WORK_DIR / "libs45b_s9.so"
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

    c_cg, so_cg = WORK_DIR / "s45b_cg.c", WORK_DIR / "libs45b_cg.so"
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

    c_sh, so_sh = WORK_DIR / "s45b_sh.c", WORK_DIR / "libs45b_sh.so"
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

    if args.mode in ("B0_11", "B1_11"):
        run_b11_cell(
            args.mode, lib_diag, lib9, lib_cg, lib_sh, orbits, layer_vecs,
            v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl
        )
    else:
        c_d8, so_d8 = WORK_DIR / "s45b_d8.c", WORK_DIR / "libs45b_d8.so"
        c_d8.write_text(s12a.C_D8CUB_SRC, encoding="utf-8")
        subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_d8), "-o", str(so_d8)], check=True)
        lib_d8 = ctypes.CDLL(str(so_d8))
        lib_d8.extract_deg3_coset_poly.argtypes = [
            ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
            ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
            ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_uint64),
        ]
        run_b000_hard(
            lib_diag, lib9, lib_cg, lib_d8, lib_sh, orbits, layer_vecs,
            v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl
        )


if __name__ == "__main__":
    main()
