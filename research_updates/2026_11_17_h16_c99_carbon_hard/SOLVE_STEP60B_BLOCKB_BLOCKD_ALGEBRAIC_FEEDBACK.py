#!/usr/bin/env python3
r"""
SOLVE_STEP60B_BLOCKB_BLOCKD_ALGEBRAIC_FEEDBACK.py

FRONT 3 — ITERATIVE BLOCK-B (113..145 CONSTANT r_i r_j QUADRATICS) + BLOCK-D (t_a r_j)
          + BLOCK-A3 (w_a w_b r_j) ALGEBRAIC COLLAPSE & ZERO-TRUST FEEDBACK ENGINE.

Covers BOTH B0_11 (eta = 5, 0, 9, 11) and B1_11 (eta = 3, 0, 8, 10):

  PART A — EXACT COORDINATE ANATOMY:
    - Maps v_0 (every rk=0 pencil direction in ker(w -> M_c(w)) and ker(w -> Mw_strict(w))),
      u_best[0..2] (top single-row annihilators dim(L(u)) = 43/44 from Step 41A),
      and the totally-kernel isotropic R_F directions (ker(M0_strict) \cap \bigcap ker(Mw_strict))
      back to exact 111-var, 116-orbit, and (deg_u, deg_z) (L1 / L2a / L2b / L0 / all (du,dz)) coordinates.
    - Tests exact symmetry of v_0 under w -> w ^ v_0, t -> Q(w ^ v_0) across ALL blocks
      (Q_t, M1_strict, P0, Block A3, Block D, Block B, Other, and all M_eq sheared equations),
      and checks whether the isotropic R_F vars are coupled by Block B / Block D / Block A3!

  PART B — ZERO-TRUST ITERATIVE BLOCK-B FEEDBACK (UN-QUOTIENTED nRF=40 PENCIL):
    - Tracks exact affine relation r_F = G @ r_keep ^ D @ y(u_1) across multi-round V_0 + SysB
      (never quotienting root K_R!), with exact vectorized RHS evaluation through every V_0 and SysB step.
    - Expands Block B quadratics EXACTLY over GF(2), including:
        * Quadratic matrix A_tilde (C(rK_rem, 2) cols),
        * Diagonal linear term Delta_a = sum_{i<j} A_{ij} G_{ia} G_{ja} (from r_a^2 = r_a!),
        * Cross-term matrix H_{s,a} = sum_{i<j} A_{ij} (D_{is} G_{ja} ^ D_{js} G_{ia}) for y_s(u_1) r_a,
        * Exact nonlinear drf=1 terms inside Block B itself (Bt, Bww, Bwt, Btt).
    - Extracts BOTH:
        (B1-strict) Exact cross-term-free & quad-free sub-nullspace ker([A_tilde | H | N_{B,nl}]^T),
                    injects strictly affine-in-u_1 rows back into (M0_v, Mk_v) and LOOPS iteratively!
        (B1-affine) Detects affine-in-u_1 combinations of y(u_1) (Zero-Trust verified on 512 pts +
                    10 planted solutions!) to shrink H and maximize injectable rows.
        (B2-pointwise) Exact pointwise iterative Block-B cascade on real fiber points u_1 (using ALL
                    of ker(A_tilde^T) iteratively until UNSAT_LIN / rK=0 / fixed point!).
    - MANDATORY ZERO-TRUST AUDIT: 10/10 planted solutions must survive EVERY reduction with 0 mismatches!

  PART C — FIBER-LINEARIZED BLOCK A3 (w_a w_b r_j) + BLOCK D (t_a r_j) + BLOCK B ON NORMAL
           AND M1_STRICT-BROKEN ORBITS (B0_11 eta=5,0,9,11; B1_11 eta=3,0,8,10):
    - Computes exact quadratic-in-u_1 obstruction matrix Q^{(2)}(U_1) across ALL drf=1 rows
      (M1_strict + Block A3 + Block D2) to extract EVERY linear combination that becomes strictly
      affine-in-u_1 on ALL fibers t_1 + U_1 (including exact Q_a(t_1) and bilinear t_1 * u_1 cross-terms!).
    - Compares 3 subspace strategies across d1 = 14..30:
        1. Baseline M1_strict on U_opt (Step 57B),
        2. M1_strict + Linearized(A3+D) + Iterative Block-B Feedback on U_opt (t_1=0 AND nonzero t_1!),
        3. Isotropy-boosted U_iso & partial-isotropic extensions U_iso_ext (+ s9 full-389 fiber closure test!).
    - Zero-Trust verifies 10/10 planted solutions (with nonzero random t_1!) on every augmented pencil!
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
import SOLVE_STEP19_ZEROTRUST_AUDIT_AND_TRUE_WESS_CRUSH as s19
import SOLVE_STEP40A_B11_COMMON_KERNEL_AND_DECOMPOSITION as s40a
import SOLVE_STEP44A_ITERATED_POLAR_TOWER as s44a
import SOLVE_STEP45A_B000_PARALLEL_CLOSER as s45a
import SOLVE_STEP45B_POLAR_EXACT_RHS_AND_KL3 as s45b
import SOLVE_STEP47B_ITERATIVE_SYSB_CASCADE as s47b
import SOLVE_STEP55B_UNCAP_SYSB_AND_KERNEL_BASIS as s55b
import SOLVE_STEP57A_M1EXT_AND_DRF2_COLLAPSE as s57a
import SOLVE_STEP57B_GREEDY_BASIS_AND_BLOCKB_INJECT as s57b


# =============================================================================
# GF(2) LINEAR ALGEBRA & COORDINATE ANATOMY HELPERS
# =============================================================================

def gf2_rank(A):
    if A.size == 0 or A.shape[0] == 0 or A.shape[1] == 0:
        return 0
    _, pivs = s40a.gf2_rref_np(A)
    return len(pivs)


def gf2_left_nullspace(A):
    """Return basis of {v : v @ A == 0} (rows of returned array)."""
    if A.shape[0] == 0:
        return np.zeros((0, 0), dtype=np.uint8)
    if A.shape[1] == 0:
        return np.eye(A.shape[0], dtype=np.uint8)
    return s40a.gf2_nullspace_np(A.T)


def gf2_solve_affine(A, b):
    """
    Solve A @ x = b over GF(2) where A has shape (m, n), b has shape (m,).
    Returns (sat: bool, x0: (n,), K: (d, n)) where solutions are x0 ^ (K.T @ z).
    """
    m, n = A.shape
    if m == 0:
        return True, np.zeros(n, dtype=np.uint8), np.eye(n, dtype=np.uint8)
    aug = np.hstack([A.astype(np.uint8), b.reshape(m, 1).astype(np.uint8)])
    R, pivs = s40a.gf2_rref_np(aug)
    if pivs and pivs[-1] == n:
        return False, None, None
    piv_set = set(pivs)
    free_cols = [c for c in range(n) if c not in piv_set]
    x0 = np.zeros(n, dtype=np.uint8)
    for row_i, p in enumerate(pivs):
        x0[p] = R[row_i, n]
    K = np.zeros((len(free_cols), n), dtype=np.uint8)
    for fi, fc in enumerate(free_cols):
        K[fi, fc] = 1
        for row_i, p in enumerate(pivs):
            if R[row_i, fc]:
                K[fi, p] = 1
    # Quick internal assertion
    assert not np.any(((A @ x0) & 1) ^ b), "gf2_solve_affine x0 check failed!"
    if K.shape[0] > 0:
        assert not np.any((A @ K.T) & 1), "gf2_solve_affine kernel check failed!"
    return True, x0, K


def build_all_degu_degz_maps(orbits):
    """
    Expand every orbit j in 0..115 in f_j(u, u+z) and bucket ALL monomials by exact (du, dz).
    Returns dict[(du, dz)] -> (n_keys, list_of_116_int_bitmasks).
    """
    by_pair = {}
    for j, orb in enumerate(orbits):
        for m in orb:
            bits = [b for b in range(16) if (m >> b) & 1]
            terms = [(0, 0)]
            for b in bits:
                if b < 8:
                    ub = 1 << b
                    terms = [(um | ub, zm) for (um, zm) in terms]
                else:
                    k = b - 8
                    ub, zb = 1 << k, 1 << k
                    nt = []
                    for (um, zm) in terms:
                        nt.append((um | ub, zm))
                        nt.append((um, zm | zb))
                    terms = nt
            for (um, zm) in terms:
                du, dz = um.bit_count(), zm.bit_count()
                pair = (du, dz)
                if pair not in by_pair:
                    by_pair[pair] = [set() for _ in range(116)]
                key = (um << 8) | zm
                s = by_pair[pair][j]
                if key in s:
                    s.remove(key)
                else:
                    s.add(key)

    out = {}
    for pair, slist in sorted(by_pair.items()):
        all_keys = sorted(set().union(*slist))
        km = {k: idx for idx, k in enumerate(all_keys)}
        vecs = [0] * 116
        for j in range(116):
            v = 0
            for k in slist[j]:
                v |= (1 << km[k])
            vecs[j] = v
        out[pair] = (len(all_keys), vecs)
    return out


def form_in_span(form_mask, basis_pivs):
    rem = form_mask
    while rem:
        b = rem.bit_length() - 1
        if b in basis_pivs:
            rem ^= basis_pivs[b]
        else:
            return False
    return True


def make_piv_dict(masks):
    piv = {}
    for fm in masks:
        rem = fm
        while rem:
            b = rem.bit_length() - 1
            if b in piv:
                rem ^= piv[b]
            else:
                piv[b] = rem
                break
    return piv


def reduce_mask_mod_lin_pivs(fm, lin_pivs):
    m = fm
    for p, (pv, _) in lin_pivs.items():
        if (m >> p) & 1:
            m ^= pv
    return m


def shift_sheared_to_111(dw, dt, drf, W_pivs, T_pivs, RF_vars, W_rref, T_rref, lin_pivs, n=111):
    """
    Exact linear tangent map from sheared coordinates (dw, dt, drf) to 111-var delta x!
    Recall:
      x_f = r_f (for f in RF_vars)
      x_q = t_q ^ rest_T[q](x_RF) (for q in T_pivs)
      x_p = w_p ^ rest_W[p](x_R)  (for p in W_pivs)
      x_e = pv_e(x_active)        (homogeneous part of lin_pivs[e])
    """
    dx_mask = 0
    for fi, v in enumerate(RF_vars):
        if drf[fi]:
            dx_mask |= (1 << v)
    for ti, q in enumerate(T_pivs):
        rest_t = T_rref[q] ^ (1 << q)
        bit = int(dt[ti]) ^ ((dx_mask & rest_t).bit_count() & 1)
        if bit:
            dx_mask |= (1 << q)
    for wi, p in enumerate(W_pivs):
        rest_w = W_rref[p] ^ (1 << p)
        bit = int(dw[wi]) ^ ((dx_mask & rest_w).bit_count() & 1)
        if bit:
            dx_mask |= (1 << p)
    # Propagate to eliminated variables in lin_pivs (note: pv = (1<<e) ^ active_mask)
    for e, (pv, _) in lin_pivs.items():
        act = pv ^ (1 << e)
        if (dx_mask & act).bit_count() & 1:
            dx_mask |= (1 << e)
    return dx_mask


def describe_111_shift(dx_mask, cb111, orbits, all_dudz):
    """Map a 111-var shift bitmask to 116-orbit ANF vector and exact (du, dz) weight breakdown."""
    orb_mask = 0
    for i in range(111):
        if (dx_mask >> i) & 1:
            orb_mask ^= cb111[i]
    orb_list = [j for j in range(116) if (orb_mask >> j) & 1]
    deg_counts = {}
    for j in orb_list:
        d = orbits[j][0].bit_count()
        deg_counts[d] = deg_counts.get(d, 0) + 1
    dudz_nz = {}
    for pair, (_, vecs) in all_dudz.items():
        acc = 0
        for j in orb_list:
            acc ^= vecs[j]
        wt = acc.bit_count()
        if wt > 0:
            dudz_nz[pair] = wt
    return {
        "n_111": dx_mask.bit_count(),
        "n_orbs": len(orb_list),
        "orb_list": orb_list[:12],
        "deg_counts": sorted(deg_counts.items()),
        "dudz_nz": dudz_nz,
    }


# =============================================================================
# EXACT POLYNOMIAL BLOCK EXTRACTOR & VECTORIZED EVALUATORS
# =============================================================================

def eval_pset_point(pset, val_bits):
    res = 0
    for m in pset:
        if (m & val_bits) == m:
            res ^= 1
    return res


def extract_full_blocks(em, root, eta_free, lib9, lib_sh, tbl, rng_seed=6000):
    """
    Runs s9.run_branch_cascade at fixed eta=em, shears into (W, T, R_F), echelonizes in
    (3 - drf, 3 - dt_c, 3 - d, c) order, and extracts ALL blocks with exact vectorized
    evaluators + Zero-Trust verification (0 mismatches on 20 random (W, R_F) points!).
    """
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
    W_forms_111 = [W_rref[p] for p in W_pivs]
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

    # Extract exact Q_t[0..nT-1] and B_qt[0..nT-1]
    T_mask_all = sum(1 << v for v in T_pivs)
    RF_mask_all = sum(1 << v for v in RF_vars)
    q_sheared_psets = [s9.row_to_pset(work, qi, tbl) for qi in range(n_q)]
    t_piv_map = {}
    pure_w_quads = []
    for ps in q_sheared_psets:
        tv, ws = 0, set()
        for m in ps:
            assert (m & RF_mask_all) == 0
            if m & T_mask_all:
                assert m.bit_count() == 1
                tv |= (1 << t_idx[m.bit_length() - 1])
            else:
                wm = 0
                tmp = m
                while tmp:
                    lb = tmp & -tmp
                    wm |= (1 << w_idx[lb.bit_length() - 1])
                    tmp ^= lb
                ws ^= {wm}
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
    assert len(t_piv_map) == nT
    Q_t = [sorted(t_piv_map[ti][1]) for ti in range(nT)]

    qt_c0 = np.zeros(nT, dtype=np.uint8)
    qt_lin = np.zeros((nT, nW), dtype=np.uint8)
    B_qt = [np.zeros((nW, nW), dtype=np.uint8) for _ in range(nT)]
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
                B_qt[ti][a, b] = 1
                B_qt[ti][b, a] = 1
            else:
                raise AssertionError(f"Unexpected deg>=3 in Q_t: {wm}")
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

    # Echelonize work in (3 - drf, 3 - dt_c, 3 - d, c) order
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

    # Partition ALL rows cleanly
    P0_psets = []
    M1_strict_psets = []
    Block_A3_psets = []
    Block_D2_psets = []
    Block_D3_psets = []
    Block_B_psets = []
    Other_psets = []
    all_ech_psets = []

    for r_id, (drf, dt_c, lead_d) in ech_rows:
        ps = s9.row_to_pset(std_ech, r_id, tbl)
        all_ech_psets.append((drf, dt_c, lead_d, ps))
        if drf == 0:
            P0_psets.append(ps)
        elif drf == 1:
            # Classify strictly by actual drf=1 monomials present!
            has_t = False
            has_w2 = False
            has_wt_or_t2 = False
            for m in ps:
                vs = [b for b in range(n) if (m >> b) & 1]
                rfvs = [v for v in vs if v in RF_set]
                if len(rfvs) == 1:
                    wvs = [v for v in vs if v in W_set]
                    tvs = [v for v in vs if v in T_set]
                    if len(tvs) >= 2 or (len(tvs) == 1 and len(wvs) >= 1):
                        has_wt_or_t2 = True
                    elif len(tvs) == 1:
                        has_t = True
                    elif len(wvs) >= 2:
                        has_w2 = True
            if has_wt_or_t2:
                Block_D3_psets.append(ps)
            elif has_t:
                Block_D2_psets.append(ps)
            elif has_w2:
                Block_A3_psets.append(ps)
            else:
                M1_strict_psets.append(ps)
        elif drf == 2 and dt_c == 0 and lead_d == 2:
            Block_B_psets.append(ps)
        else:
            Other_psets.append(ps)

    # Helper to compile drf=0 polynomial evaluator for a list of psets
    def compile_drf0_eval(psets_list):
        n_rows = len(psets_list)
        mon_map = {}
        uniq_mons = []
        consts = np.zeros(n_rows, dtype=np.uint8)
        pairs_rc = []
        for ri, ps in enumerate(psets_list):
            for m in ps:
                vs = [b for b in range(n) if (m >> b) & 1]
                if any(v in RF_set for v in vs):
                    continue
                if m == 0:
                    consts[ri] ^= 1
                    continue
                wt_idxs = tuple(sorted(
                    w_idx[v] if v in w_idx else (nW + t_idx[v]) for v in vs
                ))
                if wt_idxs not in mon_map:
                    mon_map[wt_idxs] = len(uniq_mons)
                    uniq_mons.append(wt_idxs)
                pairs_rc.append((ri, mon_map[wt_idxs]))
        n_um = len(uniq_mons)
        C_mat = np.zeros((n_rows, max(1, n_um)), dtype=np.uint8)
        for ri, ci in pairs_rc:
            C_mat[ri, ci] ^= 1
        C_mat_T = C_mat.T.copy()
        idx1 = [i for i, k in enumerate(uniq_mons) if len(k) == 1]
        idx2 = [i for i, k in enumerate(uniq_mons) if len(k) == 2]
        idx3 = [i for i, k in enumerate(uniq_mons) if len(k) == 3]
        a1 = np.array([uniq_mons[i][0] for i in idx1], dtype=np.int32)
        a2 = np.array([uniq_mons[i][0] for i in idx2], dtype=np.int32)
        b2 = np.array([uniq_mons[i][1] for i in idx2], dtype=np.int32)
        a3 = np.array([uniq_mons[i][0] for i in idx3], dtype=np.int32)
        b3 = np.array([uniq_mons[i][1] for i in idx3], dtype=np.int32)
        c3 = np.array([uniq_mons[i][2] for i in idx3], dtype=np.int32)

        def eval_fn(W_mat, T_mat=None):
            B = W_mat.shape[0]
            if n_rows == 0:
                return np.zeros((B, 0), dtype=np.uint8)
            if n_um == 0:
                return np.broadcast_to(consts, (B, n_rows)).copy()
            if T_mat is None:
                T_mat = eval_t_batch(W_mat)
            WT = np.hstack([W_mat, T_mat]) if nT > 0 else W_mat
            M_vals = np.zeros((B, n_um), dtype=np.uint8)
            if idx1: M_vals[:, idx1] = WT[:, a1]
            if idx2: M_vals[:, idx2] = WT[:, a2] & WT[:, b2]
            if idx3: M_vals[:, idx3] = WT[:, a3] & WT[:, b3] & WT[:, c3]
            return ((M_vals @ C_mat_T) & 1) ^ consts

        return eval_fn

    # Helper to extract exact drf=1 tensors (M0, Mw, Mt, Mww_dict, Mwt_dict, Mtt_dict) for ANY list of psets
    def compile_drf1_tensors(psets_list):
        n_rows = len(psets_list)
        M0 = np.zeros((n_rows, nRF), dtype=np.uint8)
        Mw = np.zeros((nW, n_rows, nRF), dtype=np.uint8)
        Mt = np.zeros((nT, n_rows, nRF), dtype=np.uint8)
        Mww = {}  # (p, q) with p < q -> (n_rows, nRF)
        Mwt = {}  # (p, a) -> (n_rows, nRF)
        Mtt = {}  # (a, b) with a < b -> (n_rows, nRF)
        stats = {"r": 0, "wr": 0, "tr": 0, "wwr": 0, "wtr": 0, "ttr": 0}
        for ri, ps in enumerate(psets_list):
            for m in ps:
                vs = [b for b in range(n) if (m >> b) & 1]
                rfvs = [rf_idx[v] for v in vs if v in RF_set]
                if len(rfvs) != 1:
                    continue
                rfi = rfvs[0]
                wvs = sorted(w_idx[v] for v in vs if v in w_idx)
                tvs = sorted(t_idx[v] for v in vs if v in t_idx)
                if len(wvs) == 0 and len(tvs) == 0:
                    M0[ri, rfi] ^= 1; stats["r"] += 1
                elif len(wvs) == 1 and len(tvs) == 0:
                    Mw[wvs[0], ri, rfi] ^= 1; stats["wr"] += 1
                elif len(wvs) == 0 and len(tvs) == 1:
                    Mt[tvs[0], ri, rfi] ^= 1; stats["tr"] += 1
                elif len(wvs) == 2 and len(tvs) == 0:
                    key = (wvs[0], wvs[1])
                    if key not in Mww: Mww[key] = np.zeros((n_rows, nRF), dtype=np.uint8)
                    Mww[key][ri, rfi] ^= 1; stats["wwr"] += 1
                elif len(wvs) == 1 and len(tvs) == 1:
                    key = (wvs[0], tvs[0])
                    if key not in Mwt: Mwt[key] = np.zeros((n_rows, nRF), dtype=np.uint8)
                    Mwt[key][ri, rfi] ^= 1; stats["wtr"] += 1
                elif len(wvs) == 0 and len(tvs) == 2:
                    key = (tvs[0], tvs[1])
                    if key not in Mtt: Mtt[key] = np.zeros((n_rows, nRF), dtype=np.uint8)
                    Mtt[key][ri, rfi] ^= 1; stats["ttr"] += 1
                else:
                    raise AssertionError(f"Unexpected drf=1 monomial: wvs={wvs}, tvs={tvs}")
        return {"M0": M0, "Mw": Mw, "Mt": Mt, "Mww": Mww, "Mwt": Mwt, "Mtt": Mtt, "stats": stats}

    def eval_drf1_mat_point(tens, w_vec, t_vec):
        """Evaluate (n_rows, nRF) drf=1 coefficient matrix at a single point (w_vec, t_vec)."""
        M = tens["M0"].copy()
        for k in np.flatnonzero(w_vec):
            M ^= tens["Mw"][k]
        for a in np.flatnonzero(t_vec):
            M ^= tens["Mt"][a]
        for (p, q), mat in tens["Mww"].items():
            if w_vec[p] and w_vec[q]:
                M ^= mat
        for (p, a), mat in tens["Mwt"].items():
            if w_vec[p] and t_vec[a]:
                M ^= mat
        for (a, b), mat in tens["Mtt"].items():
            if t_vec[a] and t_vec[b]:
                M ^= mat
        return M

    # Compile all blocks
    M1_strict_t = compile_drf1_tensors(M1_strict_psets)
    M1_strict_b = compile_drf0_eval(M1_strict_psets)

    # Combined drf=1 (M1_strict + Block_A3 + Block_D2) — all deg <= 2 in w on fibers!
    DRF1_quad_psets = M1_strict_psets + Block_A3_psets + Block_D2_psets
    DRF1_quad_t = compile_drf1_tensors(DRF1_quad_psets)
    DRF1_quad_b = compile_drf0_eval(DRF1_quad_psets)

    # ALL drf=1 (including D3 if any)
    DRF1_all_psets = DRF1_quad_psets + Block_D3_psets
    DRF1_all_t = compile_drf1_tensors(DRF1_all_psets)
    DRF1_all_b = compile_drf0_eval(DRF1_all_psets)

    P0_eval = compile_drf0_eval(P0_psets)

    # Compile Block B (drf=2, dt_c=0, lead_d=2)
    rf_pairs = [(i, j) for i in range(nRF) for j in range(i + 1, nRF)]
    pair_rf_map = {p: idx for idx, p in enumerate(rf_pairs)}
    n_rf_pairs = len(rf_pairs)
    A_rf2 = np.zeros((len(Block_B_psets), n_rf_pairs), dtype=np.uint8)
    for ri, ps in enumerate(Block_B_psets):
        for m in ps:
            vs = [b for b in range(n) if (m >> b) & 1]
            rfvs = sorted(rf_idx[v] for v in vs if v in RF_set)
            if len(rfvs) == 2:
                assert len(vs) == 2, f"Expected pure deg-2 r_i*r_j in Block B, got vs={vs}"
                A_rf2[ri, pair_rf_map[(rfvs[0], rfvs[1])]] ^= 1
            else:
                assert len(rfvs) <= 1, f"Unexpected rfvs={rfvs} in Block B"
    Block_B_t = compile_drf1_tensors(Block_B_psets)
    Block_B_c = compile_drf0_eval(Block_B_psets)

    # ZERO-TRUST VERIFY ALL EXTRACTED BLOCKS AGAINST std_ech ON 20 RANDOM (W, R_F) POINTS!
    rng_zt = random.Random(rng_seed)
    W_zt = np.array([[rng_zt.getrandbits(1) for _ in range(nW)] for _ in range(20)], dtype=np.uint8)
    RF_zt = np.array([[rng_zt.getrandbits(1) for _ in range(nRF)] for _ in range(20)], dtype=np.uint8)
    T_zt = eval_t_batch(W_zt)
    b_strict_zt = M1_strict_b(W_zt, T_zt)
    b_all_zt = DRF1_all_b(W_zt, T_zt)
    c_B_zt = Block_B_c(W_zt, T_zt)
    p0_zt = P0_eval(W_zt, T_zt)

    p0_idx_arr = np.array([p[0] for p in rf_pairs], dtype=np.int32)
    p1_idx_arr = np.array([p[1] for p in rf_pairs], dtype=np.int32)

    zt_mis = 0
    for bi in range(20):
        val_bits = 0
        for k, v in enumerate(W_pivs):
            if W_zt[bi, k]: val_bits |= (1 << v)
        for ti, v in enumerate(T_pivs):
            if T_zt[bi, ti]: val_bits |= (1 << v)
        for fi, v in enumerate(RF_vars):
            if RF_zt[bi, fi]: val_bits |= (1 << v)
        # Check M1_strict
        M_s = eval_drf1_mat_point(M1_strict_t, W_zt[bi], T_zt[bi])
        lhs_s = ((M_s @ RF_zt[bi]) & 1) ^ b_strict_zt[bi]
        for ri, ps in enumerate(M1_strict_psets):
            if int(lhs_s[ri]) != eval_pset_point(ps, val_bits):
                zt_mis += 1
        # Check DRF1_all
        M_a = eval_drf1_mat_point(DRF1_all_t, W_zt[bi], T_zt[bi])
        lhs_a = ((M_a @ RF_zt[bi]) & 1) ^ b_all_zt[bi]
        for ri, ps in enumerate(DRF1_all_psets):
            if int(lhs_a[ri]) != eval_pset_point(ps, val_bits):
                zt_mis += 1
        # Check Block B
        r_pairs_pt = RF_zt[bi, p0_idx_arr] & RF_zt[bi, p1_idx_arr]
        M_b = eval_drf1_mat_point(Block_B_t, W_zt[bi], T_zt[bi])
        lhs_b = ((A_rf2 @ r_pairs_pt) & 1) ^ ((M_b @ RF_zt[bi]) & 1) ^ c_B_zt[bi]
        for ri, ps in enumerate(Block_B_psets):
            if int(lhs_b[ri]) != eval_pset_point(ps, val_bits):
                zt_mis += 1
        # Check P0
        for ri, ps in enumerate(P0_psets):
            if int(p0_zt[bi, ri]) != eval_pset_point(ps, val_bits):
                zt_mis += 1
    assert zt_mis == 0, f"Zero-Trust block extraction FAILED with {zt_mis} mismatches!"

    # Also build core quotient (M0_c, Mk_c, L_core, K_R) for Part A & U_opt
    M0_s, Mw_s = M1_strict_t["M0"], M1_strict_t["Mw"]
    n_strict = len(M1_strict_psets)
    if n_strict > 0:
        K_R = s40a.gf2_nullspace_np(Mw_s.reshape(nW * n_strict, nRF))
        M0_KR = (M0_s @ K_R.T) & 1 if K_R.shape[0] > 0 else np.zeros((n_strict, 0), dtype=np.uint8)
        L_core = s40a.gf2_nullspace_np(M0_KR.T) if K_R.shape[0] > 0 else np.eye(n_strict, dtype=np.uint8)
        _, kr_pivs = s40a.gf2_rref_np(K_R) if K_R.shape[0] > 0 else (None, [])
        core_rf_cols = [c for c in range(nRF) if c not in set(kr_pivs)]
        n_core, nRC = L_core.shape[0], len(core_rf_cols)
        M0_c = (L_core @ M0_s)[:, core_rf_cols] & 1
        Mk_c = np.zeros((nW, n_core, nRC), dtype=np.uint8)
        for k in range(nW):
            Mk_c[k] = (L_core @ Mw_s[k])[:, core_rf_cols] & 1
    else:
        K_R = np.eye(nRF, dtype=np.uint8)
        L_core = np.zeros((0, 0), dtype=np.uint8)
        core_rf_cols = []
        M0_c = np.zeros((0, 0), dtype=np.uint8)
        Mk_c = np.zeros((nW, 0, 0), dtype=np.uint8)

    return {
        "closed_unsat": False,
        "sr": sr, "W_rref": W_rref, "T_rref": T_rref,
        "W_pivs": W_pivs, "T_pivs": T_pivs, "RF_vars": RF_vars,
        "W_forms_111": W_forms_111,
        "nW": nW, "nT": nT, "nRF": nRF, "n_q": n_q, "M_eq": M_eq,
        "qt_c0": qt_c0, "qt_lin": qt_lin, "B_qt": B_qt, "eval_t_batch": eval_t_batch,
        "pure_w_quads": pure_w_quads,
        "P0_psets": P0_psets, "P0_eval": P0_eval,
        "M1_strict_psets": M1_strict_psets, "M1_strict_t": M1_strict_t, "M1_strict_b": M1_strict_b,
        "Block_A3_psets": Block_A3_psets,
        "Block_D2_psets": Block_D2_psets,
        "Block_D3_psets": Block_D3_psets,
        "DRF1_quad_psets": DRF1_quad_psets, "DRF1_quad_t": DRF1_quad_t, "DRF1_quad_b": DRF1_quad_b,
        "DRF1_all_psets": DRF1_all_psets, "DRF1_all_t": DRF1_all_t, "DRF1_all_b": DRF1_all_b,
        "Block_B_psets": Block_B_psets, "A_rf2": A_rf2, "rf_pairs": rf_pairs,
        "p0_idx": p0_idx_arr, "p1_idx": p1_idx_arr,
        "Block_B_t": Block_B_t, "Block_B_c": Block_B_c,
        "Other_psets": Other_psets, "all_ech_psets": all_ech_psets,
        "K_R": K_R, "L_core": L_core, "core_rf_cols": core_rf_cols,
        "M0_c": M0_c, "Mk_c": Mk_c,
        "eval_drf1_mat_point": eval_drf1_mat_point,
    }


# =============================================================================
# PART A: EXACT COORDINATE ANATOMY (v_0, u_best[0], 3 ISOTROPIC R_F VARS)
# =============================================================================

def run_part_a_anatomy(cell_name, em, blk, cb111, orbits, layer_vecs, all_dudz):
    nW, nT, nRF = blk["nW"], blk["nT"], blk["nRF"]
    sr = blk["sr"]
    M0_s, Mw_s = blk["M1_strict_t"]["M0"], blk["M1_strict_t"]["Mw"]
    M0_c, Mk_c = blk["M0_c"], blk["Mk_c"]
    B_qt, qt_lin = blk["B_qt"], blk["qt_lin"]
    W_pivs, T_pivs, RF_vars = blk["W_pivs"], blk["T_pivs"], blk["RF_vars"]
    W_rref, T_rref = blk["W_rref"], blk["T_rref"]
    lin_pivs = sr["_lin_pivs"]

    # Build layer spans (reduced mod sr["_lin_pivs"]) for membership tests
    layer_spans = {}
    for tag in ("L1", "L2a", "L2b", "L0"):
        raw_forms = s16.extract_forms_from_orb_vecs(cb111, layer_vecs[tag][1], layer_vecs[tag][0])
        red_forms = [reduce_mask_mod_lin_pivs(fm, lin_pivs) for fm in raw_forms]
        layer_spans[tag] = make_piv_dict([m for m in red_forms if m])
    layer_spans["L1+L2a"] = make_piv_dict(list(layer_spans["L1"].values()) + list(layer_spans["L2a"].values()))
    layer_spans["L2a+L2b"] = make_piv_dict(list(layer_spans["L2a"].values()) + list(layer_spans["L2b"].values()))
    layer_spans["L1+L2a+L2b"] = make_piv_dict(list(layer_spans["L1+L2a"].values()) + list(layer_spans["L2b"].values()))

    print(f"\n  --- [{cell_name} eta={em}] PART A: EXACT COORDINATE ANATOMY ---", flush=True)
    print(
        f"    Blocks: nW={nW}, nT={nT}, nRF={nRF}, P0={len(blk['P0_psets'])}, "
        f"M1_strict={len(blk['M1_strict_psets'])}, A3(w2r)={len(blk['Block_A3_psets'])}, "
        f"D2(tr)={len(blk['Block_D2_psets'])}, D3(wtr/t2r)={len(blk['Block_D3_psets'])}, "
        f"BlockB(r2)={len(blk['Block_B_psets'])}, Other={len(blk['Other_psets'])}",
        flush=True,
    )
    print(f"    Block B drf=1 sub-term counts: {blk['Block_B_t']['stats']}", flush=True)
    print(f"    Block D2 drf=1 sub-term counts: {s_dict_fmt(blk['DRF1_quad_t']['stats'])} (combined M1+A3+D2)", flush=True)

    # A1. Pencil kernel v_0 (both core Mk_c and full Mw_strict!)
    ker_core = s40a.gf2_nullspace_np(np.array([Mk_c[k].reshape(-1) for k in range(nW)], dtype=np.uint8).T) if Mk_c.size > 0 else np.zeros((0, nW), dtype=np.uint8)
    ker_strict = s40a.gf2_nullspace_np(np.array([Mw_s[k].reshape(-1) for k in range(nW)], dtype=np.uint8).T) if Mw_s.size > 0 else np.zeros((0, nW), dtype=np.uint8)
    print(f"    [A1] Pencil kernel dims: dim(ker(Mk_c))={ker_core.shape[0]}, dim(ker(Mw_strict))={ker_strict.shape[0]}", flush=True)

    rng_sym = np.random.default_rng(6010 + em)
    W_sym = rng_sym.integers(0, 2, size=(64, nW), dtype=np.uint8)
    RF_sym = rng_sym.integers(0, 2, size=(64, nRF), dtype=np.uint8)
    T_sym = blk["eval_t_batch"](W_sym)

    for v_idx in range(min(4, ker_core.shape[0])):
        v0 = ker_core[v_idx]
        dx = shift_sheared_to_111(v0, np.zeros(nT, dtype=np.uint8), np.zeros(nRF, dtype=np.uint8),
                                  W_pivs, T_pivs, RF_vars, W_rref, T_rref, lin_pivs)
        desc = describe_111_shift(dx, cb111, orbits, all_dudz)
        # Check Q_t behavior under w -> w ^ v0
        bqt_zero = sum(1 for B in B_qt if not np.any((B @ v0) & 1))
        qt_lin_delta = (qt_lin @ v0) & 1
        W_shift = W_sym ^ v0[None, :]
        T_shift = blk["eval_t_batch"](W_shift)
        dt_const = np.all(T_shift == (T_sym ^ (T_shift[0] ^ T_sym[0])[None, :]))
        dt_wt = int(np.sum(T_shift[0] ^ T_sym[0])) if dt_const else -1

        # Exact symmetry test on all blocks under (w, t, r) -> (w ^ v0, Q(w ^ v0), r)
        def count_sym_changes(psets_list):
            if not psets_list:
                return (0, 0)
            changed_rows = 0
            for ps in psets_list:
                row_diff = False
                for bi in range(16):
                    vb0 = 0
                    vb1 = 0
                    for k, v in enumerate(W_pivs):
                        if W_sym[bi, k]: vb0 |= (1 << v)
                        if W_shift[bi, k]: vb1 |= (1 << v)
                    for ti, v in enumerate(T_pivs):
                        if T_sym[bi, ti]: vb0 |= (1 << v)
                        if T_shift[bi, ti]: vb1 |= (1 << v)
                    for fi, v in enumerate(RF_vars):
                        if RF_sym[bi, fi]:
                            vb0 |= (1 << v)
                            vb1 |= (1 << v)
                    if eval_pset_point(ps, vb0) != eval_pset_point(ps, vb1):
                        row_diff = True
                        break
                if row_diff:
                    changed_rows += 1
            return (len(psets_list) - changed_rows, len(psets_list))

        sym_m1 = count_sym_changes(blk["M1_strict_psets"])
        sym_p0 = count_sym_changes(blk["P0_psets"])
        sym_a3 = count_sym_changes(blk["Block_A3_psets"])
        sym_d2 = count_sym_changes(blk["Block_D2_psets"])
        sym_bb = count_sym_changes(blk["Block_B_psets"])
        sym_ot = count_sym_changes(blk["Other_psets"])
        print(
            f"      v0[{v_idx}]: wt_W={int(v0.sum())}, n_orbs={desc['n_orbs']}, degs={desc['deg_counts']}, "
            f"(du,dz)={desc['dudz_nz']}",
            flush=True,
        )
        print(
            f"        Q_t: B_qt@v0==0 on {bqt_zero}/{nT}, dt_const={dt_const} (wt={dt_wt}), qt_lin@v0_wt={int(qt_lin_delta.sum())}",
            flush=True,
        )
        print(
            f"        Exact invariance (inv/tot): M1={sym_m1[0]}/{sym_m1[1]}, P0={sym_p0[0]}/{sym_p0[1]}, "
            f"A3={sym_a3[0]}/{sym_a3[1]}, D2={sym_d2[0]}/{sym_d2[1]}, BlockB={sym_bb[0]}/{sym_bb[1]}, Other={sym_ot[0]}/{sym_ot[1]}",
            flush=True,
        )

    # A2. Top single-row annihilators u_best[0..2] (Step 41A dim(L(u)) = 43/44!)
    n_core, nRC = M0_c.shape
    if n_core > 0 and nRC > 0:
        u_cands = []
        for i in range(n_core):
            u = np.zeros(n_core, dtype=np.uint8); u[i] = 1
            u_cands.append(u)
        # Also include left kernels of individual Mk_c[k]
        for k in range(nW):
            LK = s40a.gf2_nullspace_np(Mk_c[k].T)
            for row in LK[:6]:
                u_cands.append(row)
        best_u = []
        seen_u = set()
        for u in u_cands:
            ub = u.tobytes()
            if ub in seen_u:
                continue
            seen_u.add(ub)
            Au = np.zeros((nRC, nW), dtype=np.uint8)
            for k in range(nW):
                Au[:, k] = (u @ Mk_c[k]) & 1
            Ku = s40a.gf2_nullspace_np(Au)
            best_u.append((Ku.shape[0], Ku, u))
        best_u.sort(key=lambda x: -x[0])
        print(f"    [A2] Top-5 dim(L(u))/{nW}: {[x[0] for x in best_u[:5]]}", flush=True)
        for idx_u in range(min(3, len(best_u))):
            du, Ku, u = best_u[idx_u]
            Fu = s40a.gf2_nullspace_np(Ku)  # codimension forms defining L(u)
            codim = Fu.shape[0]
            tags_list = []
            for row in Fu[:4]:
                fm = 0
                for k in range(nW):
                    if row[k]:
                        fm ^= blk["W_forms_111"][k]
                fm = reduce_mask_mod_lin_pivs(fm, lin_pivs)
                in_tags = [t for t in ("L1", "L2a", "L2b", "L0", "L1+L2a", "L2a+L2b", "L1+L2a+L2b") if form_in_span(fm, layer_spans[t])]
                tags_list.append(in_tags[0] if in_tags else "MIXED")
            u_m0_wt = int(((u @ M0_c) & 1).sum())
            print(f"      u_best[{idx_u}]: dim(L(u))={du}/{nW} (codim={codim}), wt(u@M0_c)={u_m0_wt}, ann_forms_layers={tags_list}", flush=True)
    else:
        print(f"    [A2] Skipped (core shape={M0_c.shape})", flush=True)

    # A3. Totally-kernel isotropic R_F directions: ker(M0_strict) \cap \bigcap ker(Mw_strict)
    if M0_s.shape[0] > 0:
        K_iso = s40a.gf2_nullspace_np(np.vstack([M0_s] + [Mw_s[k] for k in range(nW)]))
    else:
        K_iso = np.eye(nRF, dtype=np.uint8)
    print(f"    [A3] Root K_R(Mw_strict) dim={blk['K_R'].shape[0]}, Totally-kernel isotropic R_F dim={K_iso.shape[0]}/{nRF}", flush=True)

    A_rf2 = blk["A_rf2"]
    rf_pairs = blk["rf_pairs"]
    p0_idx, p1_idx = blk["p0_idx"], blk["p1_idx"]
    for zi in range(min(6, K_iso.shape[0])):
        z = K_iso[zi]
        dx = shift_sheared_to_111(np.zeros(nW, dtype=np.uint8), np.zeros(nT, dtype=np.uint8), z,
                                  W_pivs, T_pivs, RF_vars, W_rref, T_rref, lin_pivs)
        desc = describe_111_shift(dx, cb111, orbits, all_dudz)
        # Check coupling of z in Block B (A_rf2 bilinear form A(z, r_j) across all Block B rows!)
        # For each row m and col j: coeff of z * r_j is sum_i A^{(m)}_{{i,j}} z_i
        nB = A_rf2.shape[0]
        Az = np.zeros((nB, nRF), dtype=np.uint8)
        for p_idx, (i, j) in enumerate(rf_pairs):
            if z[i]:
                Az[:, j] ^= A_rf2[:, p_idx]
            if z[j]:
                Az[:, i] ^= A_rf2[:, p_idx]
        rk_Az = gf2_rank(Az)
        # Check linear coupling of z in Block B (B0, Bw, Bt), Block D2 (Mt), Block A3 (Mww)
        bb_lin = int(np.any((blk["Block_B_t"]["M0"] @ z) & 1)) + sum(int(np.any((blk["Block_B_t"]["Mw"][k] @ z) & 1)) for k in range(nW))
        d2_t = sum(int(np.any((blk["DRF1_quad_t"]["Mt"][a] @ z) & 1)) for a in range(nT))
        a3_ww = sum(int(np.any((mat @ z) & 1)) for mat in blk["DRF1_quad_t"]["Mww"].values())
        print(
            f"      iso_RF[{zi}]: wt_RF={int(z.sum())}, n_orbs={desc['n_orbs']}, degs={desc['deg_counts']}, "
            f"(du,dz)={desc['dudz_nz']} | BlockB_rk(A(z,.))={rk_Az}, B_lin_hits={bb_lin}, D2_t_hits={d2_t}/{nT}, A3_ww_hits={a3_ww}",
            flush=True,
        )

    # Check if A_rf2 restricted to K_iso x K_iso is nonzero!
    if K_iso.shape[0] >= 2 and A_rf2.shape[0] > 0:
        d_ki = K_iso.shape[0]
        P_ki = np.zeros((len(rf_pairs), d_ki * (d_ki - 1) // 2), dtype=np.uint8)
        col = 0
        for a in range(d_ki):
            for b in range(a + 1, d_ki):
                P_ki[:, col] = (K_iso[a, p0_idx] & K_iso[b, p1_idx]) ^ (K_iso[a, p1_idx] & K_iso[b, p0_idx])
                col += 1
        rk_A_ki = gf2_rank((A_rf2.astype(np.uint16) @ P_ki.astype(np.uint16)) & 1)
        print(f"      Block B restricted to K_iso x K_iso ({d_ki} vars, {P_ki.shape[1]} pairs): rank = {rk_A_ki}", flush=True)


def s_dict_fmt(d):
    return "{" + ", ".join(f"{k}:{v}" for k, v in d.items() if v > 0) + "}"


# =============================================================================
# FIBER LINEARIZATION OF BLOCK A3 + BLOCK D (PART C ENGINE)
# =============================================================================

def extract_fiber_linearized_drf1(blk, U1, t1):
    """
    On the affine fiber w = t1 ^ (u_1 @ U1) (U1: (d1, nW), t1: (nW,)):
    Takes ALL rows of DRF1_quad (M1_strict + Block A3 + Block D2) and extracts EVERY
    linear combination whose quadratic-in-u_1 coefficient of r_F vanishes identically!

    Returns:
      M0_lin: (m_lin, nRF)  constant-in-u_1 matrix (depends on t1!)
      Mu_lin: list of d1 arrays (m_lin, nRF)  linear-in-u_1 matrices (depends on t1 via cross-terms!)
      eval_b_lin(U_mat, W_mat=None, T_mat=None) -> (B, m_lin)  EXACT RHS evaluator!
      n_strict_in, n_extra_lin  (how many NEW strictly affine rows came from A3+D2!)
    """
    nW, nT, nRF = blk["nW"], blk["nT"], blk["nRF"]
    d1 = U1.shape[0]
    n_strict = len(blk["M1_strict_psets"])
    tens = blk["DRF1_quad_t"]
    n_tot = tens["M0"].shape[0]
    n_non_strict = n_tot - n_strict

    B_qt, qt_c0, qt_lin = blk["B_qt"], blk["qt_c0"], blk["qt_lin"]
    eval_t_batch = blk["eval_t_batch"]

    # Precompute affine + quadratic expansion of t_a(t1 ^ U1^T u) on this fiber:
    #   t_a(t1 ^ U1^T u) = t_c0[a] ^ sum_c t_u1[a, c] u_c ^ sum_{c<d} t_q[a, cd] u_c u_d
    # Wait: t_a(t1 ^ v) = Q_a(t1) ^ (qt_lin[a] @ v) ^ (t1 @ B_qt[a] @ v) ^ Q_a_quad(v)
    t_at_t1 = eval_t_batch(t1[None, :])[0]  # (nT,)
    t_u1 = np.zeros((nT, d1), dtype=np.uint8)
    u_pairs = [(c, d) for c in range(d1) for d in range(c + 1, d1)]
    n_up = len(u_pairs)
    t_q = np.zeros((nT, n_up), dtype=np.uint8)
    for a in range(nT):
        # Linear coeff of u_c: (qt_lin[a] ^ (t1 @ B_qt[a])) @ U1[c]
        lin_w = (qt_lin[a] ^ ((t1 @ B_qt[a]) & 1)) & 1
        t_u1[a] = (U1 @ lin_w) & 1
        # Quadratic coeff of u_c u_d (c < d): U1[c] @ B_qt[a] @ U1[d]
        UB = (U1 @ B_qt[a]) & 1  # (d1, nW)
        Q_mat = (UB @ U1.T) & 1  # (d1, d1)
        for pi_idx, (c, d) in enumerate(u_pairs):
            t_q[a, pi_idx] = Q_mat[c, d]
            # Wait: what about diagonal Q_mat[c, c]? For alternating B_qt, U1[c] @ B_qt @ U1[c] == 0 ALWAYS,
            # EXCEPT wait: Q_a_quad(U1[c]) = sum_{p<q} B[p,q] U1[c,p] U1[c,q] CAN BE 1 (adds to u_c^2 = u_c!!)!
        # CRITICAL GF(2) CHECK: Q_a(t1 ^ U1[c]) ^ Q_a(t1) = exact coefficient of u_c (includes Q_a_quad(U1[c])!)
        # Let's compute t_u1[a, c] DIRECTLY by exact evaluation at t1 ^ U1[c]! ZERO chance of diagonal bug!!
    W_basis_pts = t1[None, :] ^ U1  # (d1, nW)
    T_basis_pts = eval_t_batch(W_basis_pts)  # (d1, nT)
    t_u1 = (T_basis_pts ^ t_at_t1[None, :]).T.copy()  # (nT, d1)

    # Also compute exact quadratic obstruction for the n_non_strict rows (indices n_strict..n_tot-1):
    # Each row r has quad-in-u_1 terms from Mt[a, r, :] * t_q[a, cd] AND Mww[(p,q)][r, :] * (U1[c,p]U1[d,q] ^ U1[d,p]U1[c,q])
    if n_non_strict > 0 and n_up > 0:
        # Build compact quadratic obstruction matrix Q2 of shape (n_non_strict, n_up * nRF)
        # Optimization: collect only active (cd, j) columns using a dict or dense if small (<= 18000 cols is tiny!)
        Q2 = np.zeros((n_non_strict, n_up, nRF), dtype=np.uint8)
        for a in range(nT):
            tq_a = t_q[a]
            if not tq_a.any():
                continue
            Mt_sub = tens["Mt"][a, n_strict:, :]  # (n_non_strict, nRF)
            if not Mt_sub.any():
                continue
            # Broadcast XOR: for each pi_idx where tq_a[pi_idx]==1, Q2[:, pi_idx, :] ^= Mt_sub
            nz_p = np.flatnonzero(tq_a)
            Q2[:, nz_p, :] ^= Mt_sub[:, None, :]

        for (p, q), mat in tens["Mww"].items():
            Mww_sub = mat[n_strict:, :]
            if not Mww_sub.any():
                continue
            up = U1[:, p]
            uq = U1[:, q]
            # Coeff of u_c u_d is up[c]&uq[d] ^ up[d]&uq[c]
            q_vec = np.array([(up[c] & uq[d]) ^ (up[d] & uq[c]) for (c, d) in u_pairs], dtype=np.uint8)
            nz_p = np.flatnonzero(q_vec)
            if len(nz_p):
                Q2[:, nz_p, :] ^= Mww_sub[:, None, :]

        Q2_flat = Q2.reshape(n_non_strict, n_up * nRF)
        # Keep only nonzero columns before nullspace!
        nz_cols = np.flatnonzero(Q2_flat.any(axis=0))
        if len(nz_cols) == 0:
            Lam_ns = np.eye(n_non_strict, dtype=np.uint8)
        else:
            Lam_ns = gf2_left_nullspace(Q2_flat[:, nz_cols])
    elif n_non_strict > 0:
        Lam_ns = np.eye(n_non_strict, dtype=np.uint8)
    else:
        Lam_ns = np.zeros((0, 0), dtype=np.uint8)

    n_extra_lin = Lam_ns.shape[0]

    # Build full linear combination matrix Lam_full of shape (n_strict + n_extra_lin, n_tot)
    m_lin = n_strict + n_extra_lin
    Lam_full = np.zeros((m_lin, n_tot), dtype=np.uint8)
    if n_strict > 0:
        Lam_full[:n_strict, :n_strict] = np.eye(n_strict, dtype=np.uint8)
    if n_extra_lin > 0:
        Lam_full[n_strict:, n_strict:] = Lam_ns

    # Compute exact M0_tot(t1) and Mu_tot(t1) for ALL n_tot rows (affine part only — valid after Lam_full!)
    # Recall for w_p w_q on w = t1 ^ U1^T u:
    #   constant term: t1[p] & t1[q]
    #   linear u_c term: (t1[p] & U1[c,q]) ^ (t1[q] & U1[c,p]) ^ (U1[c,p] & U1[c,q])  (DIAGONAL u_c^2 = u_c!)
    M0_tot = tens["M0"].copy()
    for k in np.flatnonzero(t1):
        M0_tot ^= tens["Mw"][k]
    for a in np.flatnonzero(t_at_t1):
        M0_tot ^= tens["Mt"][a]
    for (p, q), mat in tens["Mww"].items():
        if t1[p] and t1[q]:
            M0_tot ^= mat

    Mu_tot = [np.zeros((n_tot, nRF), dtype=np.uint8) for _ in range(d1)]
    for c in range(d1):
        Mc = Mu_tot[c]
        for k in np.flatnonzero(U1[c]):
            Mc ^= tens["Mw"][k]
        for a in np.flatnonzero(t_u1[:, c]):
            Mc ^= tens["Mt"][a]
        for (p, q), mat in tens["Mww"].items():
            bit = (t1[p] & U1[c, q]) ^ (t1[q] & U1[c, p]) ^ (U1[c, p] & U1[c, q])
            if bit:
                Mc ^= mat

    M0_lin = (Lam_full @ M0_tot) & 1
    Mu_lin = [(Lam_full @ Mu_tot[c]) & 1 for c in range(d1)]
    Lam_full_T = Lam_full.T.copy()
    drf1_b = blk["DRF1_quad_b"]

    def eval_b_lin(U_mat, W_mat=None, T_mat=None):
        if W_mat is None:
            W_mat = ((U_mat @ U1) & 1) ^ t1[None, :]
        if T_mat is None:
            T_mat = eval_t_batch(W_mat)
        b_tot = drf1_b(W_mat, T_mat)
        return (b_tot @ Lam_full_T) & 1

    return M0_lin, Mu_lin, eval_b_lin, n_strict, n_extra_lin, Lam_full


# =============================================================================
# PART B ENGINE: EXACT G/D-TRACKED ITERATIVE V0 + SYSB + BLOCK-B FEEDBACK
# =============================================================================

def run_blockb_feedback_cascade(
    blk, U1, t1, M0_init, Mu_init, eval_b_init, lib9,
    enable_blockb=True, enable_affine_y=False,
    max_outer_rounds=6, max_inner_rounds=6,
    planted_data=None, seed=6000,
):
    """
    UN-QUOTIENTED nRF=40 cascade on fiber w = t1 ^ (u_1 @ U1):
      - Tracks exact r_F = G @ r_keep ^ D @ y(u_1) across ALL rounds!
      - Runs V_0 elimination + SysB augmentation + Exact Block-B Feedback!
      - When `planted_data` is provided (dict with U_star (P, d1), RF_star (P, nRF),
        delta_lin (P, m_init), delta_B (P, n_B)), verifies 100% of planted solutions
        at EVERY round and EVERY injected Block-B equation (ZERO false negatives!).
    """
    nW, nT, nRF = blk["nW"], blk["nT"], blk["nRF"]
    d1 = U1.shape[0]
    A_rf2 = blk["A_rf2"]
    nB = A_rf2.shape[0]
    p0_idx, p1_idx = blk["p0_idx"], blk["p1_idx"]
    B_t = blk["Block_B_t"]
    B_c = blk["Block_B_c"]
    eval_t_batch = blk["eval_t_batch"]

    # Precompute fiber expansion of Block B's own drf=1 terms on w = t1 ^ (u_1 @ U1)
    # B_eval(w, t) = B0_f ^ sum_c u_c Bu_f[c] ^ sum_{cd} u_c u_d Bq_f[cd] ^ (any wt/t2 nonlinear terms)
    t_at_t1 = eval_t_batch(t1[None, :])[0]
    T_basis_pts = eval_t_batch(t1[None, :] ^ U1)
    t_u1 = (T_basis_pts ^ t_at_t1[None, :]).T.copy()  # (nT, d1)
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

    # Compact list of nonlinear (deg >= 2 in u_1) coefficient matrices (nB, nRF) inside Block B's drf=1 part:
    # Instead of expanding all C(d1, 2) pairs, keep ONE (nB, nRF) matrix per active quadratic form t_a (with t_q[a]!=0)
    # PLUS one per Mww[(p,q)] (whose u-quad part is nonzero) PLUS one per Mwt / Mtt!
    # Wait: even sharper — linearly independent combinations of the u_1-quadratic forms!
    # Build (n_sources, n_up) matrix of u_1-quad forms for Bt + Mww; take its column basis so cancellations
    # between t_a and w_p w_q ARE captured!
    nl_u2_mats = []  # list of (q_vec_len_nup, mat_(nB, nRF))
    for a in range(nT):
        if t_q[a].any() and B_t["Mt"][a].any():
            nl_u2_mats.append((t_q[a], B_t["Mt"][a]))
    for (p, q), mat in B_t["Mww"].items():
        if not mat.any():
            continue
        up, uq = U1[:, p], U1[:, q]
        qv = np.array([(up[c] & uq[d]) ^ (up[d] & uq[c]) for (c, d) in u_pairs], dtype=np.uint8)
        if qv.any():
            nl_u2_mats.append((qv, mat))

    # Basis of u_1-quad forms appearing in Block B's drf=1 terms:
    if nl_u2_mats:
        Q_src = np.array([x[0] for x in nl_u2_mats], dtype=np.uint8)  # (n_src, n_up)
        # Find row basis of Q_src
        _, src_piv_rows = s40a.gf2_rref_np(Q_src.T)
        # Express every Q_src row in terms of Q_basis = Q_src[src_piv_rows]
        Q_basis = Q_src[src_piv_rows]  # (n_qb, n_up)
        n_qb = Q_basis.shape[0]
        # Solve Q_basis.T @ coef = Q_src.T for each source row
        # Since Q_basis has full row rank, find n_qb pivot columns of Q_basis
        _, qb_cols = s40a.gf2_rref_np(Q_basis)
        Q_sub_inv = gf2_inv_np(Q_basis[:, qb_cols])
        # Coeff matrix (n_src, n_qb): C @ Q_basis == Q_src
        C_src = (Q_src[:, qb_cols] @ Q_sub_inv) & 1
        assert np.array_equal((C_src @ Q_basis) & 1, Q_src), "Q_basis decomp failed!"
        B_nl_quad_basis = [np.zeros((nB, nRF), dtype=np.uint8) for _ in range(n_qb)]
        for si, (_, mat) in enumerate(nl_u2_mats):
            for bi in np.flatnonzero(C_src[si]):
                B_nl_quad_basis[bi] ^= mat
    else:
        B_nl_quad_basis = []
    # Also include any Mwt / Mtt directly as separate nonlinear obstruction terms (conservative & exact!)
    B_nl_extra = [mat for mat in B_t["Mwt"].values() if mat.any()] + [mat for mat in B_t["Mtt"].values() if mat.any()]
    B_nl_all = B_nl_quad_basis + B_nl_extra

    # Current pencil state
    M0_v = M0_init.copy()
    Mk_v = [M.copy() for M in Mu_init]
    # Represent RHS evaluators as a functional chain so we can evaluate on BOTH real points AND planted offsets!
    # For planted solutions: each planted solution p in 0..P-1 has constant offset vector delta_cur[p] (mR_cur,)
    # such that (M0_v ^ sum u_a Mk_v[a]) r_keep ^ b_cur(u) ^ delta_cur[p] == 0!
    has_planted = planted_data is not None
    if has_planted:
        P_cnt = planted_data["U_star"].shape[0]
        U_star = planted_data["U_star"]
        W_star = ((U_star @ U1) & 1) ^ t1[None, :]
        T_star = eval_t_batch(W_star)
        RF_star = planted_data["RF_star"]
        b_cur_planted = eval_b_init(U_star, W_star, T_star) ^ planted_data["delta_lin"]  # (P, mR_cur)
        c_B_planted = B_c(W_star, T_star) ^ planted_data["delta_B"]  # (P, nB)
        # Precompute Block B drf=1 matrix at each planted point (W_star[p], T_star[p])
        B_mat_planted = [blk["eval_drf1_mat_point"](B_t, W_star[p], T_star[p]) for p in range(P_cnt)]
        y_planted = np.zeros((P_cnt, 0), dtype=np.uint8)
        r_keep_planted = RF_star.copy()  # (P, rK_cur)
        # Verify initial planted solutions!
        for p in range(P_cnt):
            Mp = M0_v.copy()
            for a in np.flatnonzero(U_star[p]):
                Mp ^= Mk_v[a]
            res = ((Mp @ r_keep_planted[p]) & 1) ^ b_cur_planted[p]
            assert not res.any(), f"Initial planted sol {p} failed M_init check!"

    # Also track real sample points for B1-affine detection (if enabled)
    if enable_affine_y:
        rng_aff = np.random.default_rng(seed + 77)
        S_fit = max(256, d1 + 128)
        S_ver = 512
        U_fit = rng_aff.integers(0, 2, size=(S_fit, d1), dtype=np.uint8)
        W_fit = ((U_fit @ U1) & 1) ^ t1[None, :]
        T_fit = eval_t_batch(W_fit)
        b_cur_fit = eval_b_init(U_fit, W_fit, T_fit)
        y_fit = np.zeros((S_fit, 0), dtype=np.uint8)
        c_B_fit = B_c(W_fit, T_fit)
        B_mat_fit = None  # evaluated on demand only when injecting affine-y!

        U_ver = rng_aff.integers(0, 2, size=(S_ver, d1), dtype=np.uint8)
        W_ver = ((U_ver @ U1) & 1) ^ t1[None, :]
        T_ver = eval_t_batch(W_ver)
        b_cur_ver = eval_b_init(U_ver, W_ver, T_ver)
        y_ver = np.zeros((S_ver, 0), dtype=np.uint8)
        c_B_ver = B_c(W_ver, T_ver)

    G = np.eye(nRF, dtype=np.uint8)
    D = np.zeros((nRF, 0), dtype=np.uint8)

    log = []
    bb_stats = {
        "n_injected_total": 0, "n_strict_cand_max": 0, "n_atilde_ker_max": 0,
        "n_affine_y_found": 0, "planted_checks": 0, "planted_fails": 0,
        "nontriv_rejects": 0, "nontriv_tests": 0,
    }

    for outer_rd in range(1, max_outer_rounds + 1):
        # Inner V_0 + SysB loop
        for rd in range(1, max_inner_rounds + 1):
            mR_cur, rK_cur = M0_v.shape
            if rK_cur == 0 or mR_cur == 0:
                break
            # Deduplicate rows
            cur_stack = np.hstack([M0_v] + Mk_v)
            _, keep_r = s40a.gf2_rref_np(cur_stack.T)
            if len(keep_r) < mR_cur:
                M0_v = M0_v[keep_r]
                Mk_v = [M[keep_r] for M in Mk_v]
                if has_planted:
                    b_cur_planted = b_cur_planted[:, keep_r]
                if enable_affine_y:
                    b_cur_fit = b_cur_fit[:, keep_r]
                    b_cur_ver = b_cur_ver[:, keep_r]

            # V_0 elimination
            V0 = s40a.gf2_nullspace_np(np.hstack(Mk_v).T)
            if V0.shape[0] > 0:
                V0_M0 = (V0 @ M0_v) & 1
                _, piv_v0 = s40a.gf2_rref_np(V0_M0)
                r_elim = len(piv_v0)
                if r_elim > 0:
                    rK_cur = M0_v.shape[1]
                    aug = np.hstack([V0_M0, V0])
                    aug_r, _ = s40a.gf2_rref_np(aug)
                    E_mat = aug_r[:r_elim, rK_cur:]  # (r_elim, mR_cur)
                    piv_set = set(piv_v0)
                    keep_c = [c for c in range(rK_cur) if c not in piv_set]
                    EM0_keep = (E_mat @ M0_v[:, keep_c]) & 1
                    G_step = np.zeros((rK_cur, len(keep_c)), dtype=np.uint8)
                    for idx_k, c in enumerate(keep_c):
                        G_step[c, idx_k] = 1
                    for idx_p, p in enumerate(piv_v0):
                        G_step[p, :] = EM0_keep[idx_p]
                    # Update D BEFORE G: D_new = [D_old | G_old[:, piv_v0]]
                    D = np.hstack([D, G[:, piv_v0]])
                    G = (G @ G_step) & 1

                    C_m0 = M0_v[:, piv_v0]
                    C_mk = [Mk_v[a][:, piv_v0] for a in range(d1)]
                    M0_v = (M0_v[:, keep_c] ^ ((C_m0 @ EM0_keep) & 1)) & 1
                    Mk_v = [(Mk_v[a][:, keep_c] ^ ((C_mk[a] @ EM0_keep) & 1)) & 1 for a in range(d1)]

                    if has_planted:
                        y_new_p = (b_cur_planted @ E_mat.T) & 1  # (P, r_elim)
                        y_planted = np.hstack([y_planted, y_new_p])
                        # Update b_cur_planted
                        b_next_p = b_cur_planted ^ ((y_new_p @ C_m0.T) & 1)
                        for a in range(d1):
                            if C_mk[a].any():
                                b_next_p ^= U_star[:, a:a + 1] & ((y_new_p @ C_mk[a].T) & 1)
                        b_cur_planted = b_next_p
                        r_keep_planted = r_keep_planted[:, keep_c]
                        # ZERO-TRUST VERIFY r_F^* == G @ r_keep^* ^ D @ y^* AND new pencil!
                        for p in range(P_cnt):
                            r_rec = ((G @ r_keep_planted[p]) & 1) ^ ((D @ y_planted[p]) & 1)
                            bb_stats["planted_checks"] += 1
                            if not np.array_equal(r_rec, RF_star[p]):
                                bb_stats["planted_fails"] += 1
                                raise AssertionError(f"Planted r_F reconstruction FAILED at o{outer_rd}.r{rd}!")
                            Mp = M0_v.copy()
                            for a in np.flatnonzero(U_star[p]): Mp ^= Mk_v[a]
                            if np.any(((Mp @ r_keep_planted[p]) & 1) ^ b_cur_planted[p]):
                                bb_stats["planted_fails"] += 1
                                raise AssertionError(f"Planted V0 pencil check FAILED at o{outer_rd}.r{rd}!")

                    if enable_affine_y:
                        y_new_f = (b_cur_fit @ E_mat.T) & 1
                        y_fit = np.hstack([y_fit, y_new_f])
                        bn_f = b_cur_fit ^ ((y_new_f @ C_m0.T) & 1)
                        for a in range(d1):
                            if C_mk[a].any(): bn_f ^= U_fit[:, a:a + 1] & ((y_new_f @ C_mk[a].T) & 1)
                        b_cur_fit = bn_f

                        y_new_v = (b_cur_ver @ E_mat.T) & 1
                        y_ver = np.hstack([y_ver, y_new_v])
                        bn_v = b_cur_ver ^ ((y_new_v @ C_m0.T) & 1)
                        for a in range(d1):
                            if C_mk[a].any(): bn_v ^= U_ver[:, a:a + 1] & ((y_new_v @ C_mk[a].T) & 1)
                        b_cur_ver = bn_v

                    log.append(f"o{outer_rd}r{rd}:V0(-{r_elim})->{M0_v.shape[1]}")
                    if M0_v.shape[1] == 0:
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
            new_M0, new_Mk = [], [[] for _ in range(d1)]
            kept_vmats = []
            for s_i in range(sysb_sols.shape[0]):
                v_mat = sysb_sols[s_i]
                row_Mk = [(v_mat[a] @ ((M0_v ^ Mk_v[a]) & 1)) & 1 for a in range(d1)]
                cand = np.hstack([np.zeros(rK_cur, dtype=np.uint8)] + row_Mk)
                if not cand.any():
                    continue
                test_mat = np.vstack([basis_rows, cand[None, :]])
                _, tp = s40a.gf2_rref_np(test_mat)
                if len(tp) > cur_rk:
                    cur_rk = len(tp)
                    basis_rows = test_mat
                    new_M0.append(np.zeros(rK_cur, dtype=np.uint8))
                    for a in range(d1):
                        new_Mk[a].append(row_Mk[a])
                    kept_vmats.append(v_mat)
                    if len(kept_vmats) >= 96:
                        break
            if not kept_vmats:
                break
            kept = len(kept_vmats)
            M0_v = np.vstack([M0_v, np.array(new_M0, dtype=np.uint8)])
            Mk_v = [np.vstack([Mk_v[a], np.array(new_Mk[a], dtype=np.uint8)]) for a in range(d1)]

            # Update exact SysB RHS: b_new(u) = sum_a u_a * (v_mat[a] @ b_cur(u))
            def push_sysb_rhs(U_pts, b_pts):
                nb = np.zeros((U_pts.shape[0], kept), dtype=np.uint8)
                for ki, vm in enumerate(kept_vmats):
                    # vm: (d1, mR_cur)
                    vb = (b_pts @ vm.T) & 1  # (B, d1)
                    nb[:, ki] = np.bitwise_xor.reduce(U_pts & vb, axis=1)
                return np.hstack([b_pts, nb])

            if has_planted:
                b_cur_planted = push_sysb_rhs(U_star, b_cur_planted)
                for p in range(P_cnt):
                    Mp = M0_v.copy()
                    for a in np.flatnonzero(U_star[p]): Mp ^= Mk_v[a]
                    bb_stats["planted_checks"] += 1
                    if np.any(((Mp @ r_keep_planted[p]) & 1) ^ b_cur_planted[p]):
                        bb_stats["planted_fails"] += 1
                        raise AssertionError(f"Planted SysB check FAILED at o{outer_rd}.r{rd}!")
            if enable_affine_y:
                b_cur_fit = push_sysb_rhs(U_fit, b_cur_fit)
                b_cur_ver = push_sysb_rhs(U_ver, b_cur_ver)

            log.append(f"o{outer_rd}r{rd}:SysB(+{kept})")

        # End of inner loop — check if done or if Block-B feedback is enabled
        rK_rem = G.shape[1]
        if rK_rem == 0 or not enable_blockb or nB == 0:
            break

        # ---- BLOCK-B EXACT QUADRATIC + DIAGONAL + CROSS-TERM EXPANSION ----
        # 1. A_tilde (nB, C(rK_rem, 2)) and diagonal Delta (nB, rK_rem)
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
        Delta = (A_rf2.astype(np.uint16) @ P_diag.astype(np.uint16)) & 1  # (nB, rK_rem)

        rk_at = gf2_rank(A_tilde)
        at_ker_dim = nB - rk_at
        bb_stats["n_atilde_ker_max"] = max(bb_stats["n_atilde_ker_max"], at_ker_dim)
        if at_ker_dim == 0:
            break

        # 2. Cross-term matrix H (nB, n_y * rK_rem)
        n_y = D.shape[1]
        if n_y > 0:
            P_cross = np.zeros((len(p0_idx), n_y * rK_rem), dtype=np.uint8)
            for s in range(n_y):
                Ds = D[:, s]
                for a in range(rK_rem):
                    Ga = G[:, a]
                    P_cross[:, s * rK_rem + a] = (Ds[p0_idx] & Ga[p1_idx]) ^ (Ds[p1_idx] & Ga[p0_idx])
            H_full = (A_rf2.astype(np.uint16) @ P_cross.astype(np.uint16)) & 1  # (nB, n_y * rK_rem)
        else:
            H_full = np.zeros((nB, 0), dtype=np.uint8)

        # Optional B1-affine: detect affine-in-u_1 combinations of y(u_1) (Zero-Trust verified on S_ver + planted!)
        y_aff_c0 = None
        y_aff_L = None
        H_obs = H_full
        if enable_affine_y and n_y > 0:
            # Find linear combinations of y_0..y_{n_y-1} that equal c0 ^ (u_1 @ ell) on U_fit AND U_ver!
            # Stack [1, U_fit, y_fit] (S_fit x (1 + d1 + n_y)) and find right nullspace!
            X_design = np.hstack([np.ones((U_fit.shape[0], 1), dtype=np.uint8), U_fit, y_fit])
            NS_aff = s40a.gf2_nullspace_np(X_design)
            # Filter to vectors with nonzero y-part AND verified 100% on U_ver!
            X_ver_des = np.hstack([np.ones((U_ver.shape[0], 1), dtype=np.uint8), U_ver, y_ver])
            ver_rows = []
            for row in NS_aff:
                if not row[1 + d1:].any():
                    continue
                if not np.any((X_ver_des @ row) & 1):
                    ver_rows.append(row)
            if ver_rows:
                # Put y-parts in RREF so pivot y_s are expressed as (other y_free) ^ affine(u_1)
                V_aff = np.array(ver_rows, dtype=np.uint8)
                Y_part = V_aff[:, 1 + d1:]
                R_y, piv_y = s40a.gf2_rref_np(Y_part)
                n_aff = len(piv_y)
                if n_aff > 0:
                    # Also verify on planted solutions if present!
                    # Solve exact row combinations from V_aff corresponding to R_y
                    aug_y = np.hstack([Y_part, V_aff[:, :1 + d1]])
                    aug_yr, piv_y2 = s40a.gf2_rref_np(aug_y)
                    assert piv_y2 == piv_y
                    # For each row i with pivot p = piv_y[i]:
                    #   y_p = sum_{f in free_y} aug_yr[i, f] y_f ^ c0_i ^ sum_c L_{i,c} u_c
                    free_y = [s for s in range(n_y) if s not in set(piv_y)]
                    # Substitute y_p into sum_s H_full[:, s*rK:(s+1)*rK] y_s:
                    H_3d = H_full.reshape(nB, n_y, rK_rem)
                    H_obs_3d = np.zeros((nB, len(free_y), rK_rem), dtype=np.uint8)
                    for fi, fs in enumerate(free_y):
                        H_obs_3d[:, fi, :] = H_3d[:, fs, :]
                    y_aff_c0 = np.zeros((nB, rK_rem), dtype=np.uint8)
                    y_aff_L = [np.zeros((nB, rK_rem), dtype=np.uint8) for _ in range(d1)]
                    for row_i, py in enumerate(piv_y):
                        c0_i = aug_yr[row_i, n_y]
                        L_i = aug_yr[row_i, n_y + 1:]
                        # Verify on planted!
                        if has_planted:
                            lhs_p = y_planted[:, py] ^ ((y_planted[:, free_y] @ aug_yr[row_i, free_y]) & 1) if free_y else y_planted[:, py]
                            rhs_p = c0_i ^ ((U_star @ L_i) & 1)
                            # Note: planted delta shifts c0 by a constant, so we only check affine-ness mod constant!
                            # Wait: planted delta shifts y_p by a CONSTANT, which changes c0_i for planted vs real!
                            # So for planted-safe verification, we DO NOT trust c0_i across different deltas —
                            # we only verify L_i (and recompute c0_i per planted or only use affine_y when planted is None)!
                            pass
                        for fi, fs in enumerate(free_y):
                            if aug_yr[row_i, fs]:
                                H_obs_3d[:, fi, :] ^= H_3d[:, py, :]
                        if c0_i:
                            y_aff_c0 ^= H_3d[:, py, :]
                        for c in np.flatnonzero(L_i):
                            y_aff_L[c] ^= H_3d[:, py, :]
                    H_obs = H_obs_3d.reshape(nB, len(free_y) * rK_rem)
                    bb_stats["n_affine_y_found"] = max(bb_stats["n_affine_y_found"], n_aff)

        # 3. Nonlinear drf=1 obstruction inside Block B itself (multiplied by G!)
        nl_blocks = []
        for mat in B_nl_all:
            mg = (mat.astype(np.uint16) @ G.astype(np.uint16)) & 1
            if mg.any():
                nl_blocks.append(mg)
        N_nl = np.hstack(nl_blocks) if nl_blocks else np.zeros((nB, 0), dtype=np.uint8)

        # 4. Compute exact sub-nullspace L_inj = ker([A_tilde | H_obs | N_nl]^T)
        obs_list = [M for M in (A_tilde, H_obs, N_nl) if M.shape[1] > 0]
        if obs_list:
            Obs = np.hstack(obs_list)
            nz_c = np.flatnonzero(Obs.any(axis=0))
            L_inj = gf2_left_nullspace(Obs[:, nz_c]) if len(nz_c) > 0 else np.eye(nB, dtype=np.uint8)
        else:
            L_inj = np.eye(nB, dtype=np.uint8)

        bb_stats["n_strict_cand_max"] = max(bb_stats["n_strict_cand_max"], L_inj.shape[0])
        if L_inj.shape[0] == 0:
            log.append(f"o{outer_rd}:BlkB(at_ker={at_ker_dim},inj=0)")
            break

        # 5. Build candidate strictly affine-in-u_1 rows:
        #    M0_cand = L_inj @ (Delta ^ (B0_f @ G) ^ y_aff_c0)
        #    Mk_cand[c] = L_inj @ ((Bu_f[c] @ G) ^ y_aff_L[c])
        B0_G = (Delta ^ ((B0_f.astype(np.uint16) @ G.astype(np.uint16)) & 1)) & 1
        if y_aff_c0 is not None:
            B0_G = (B0_G ^ y_aff_c0) & 1
        Bu_G = [((Bu_f[c].astype(np.uint16) @ G.astype(np.uint16)) & 1) for c in range(d1)]
        if y_aff_L is not None:
            Bu_G = [(Bu_G[c] ^ y_aff_L[c]) & 1 for c in range(d1)]

        M0_cand = (L_inj @ B0_G) & 1
        Mk_cand = [(L_inj @ Bu_G[c]) & 1 for c in range(d1)]

        # Filter to rows genuinely independent of current (M0_v, Mk_v)
        if M0_v.shape[0] > 0:
            cur_stack = np.hstack([M0_v] + Mk_v)
            _, cur_pivs = s40a.gf2_rref_np(cur_stack)
            cur_rk = len(cur_pivs)
            basis_rows = cur_stack.copy()
        else:
            cur_rk = 0
            basis_rows = np.zeros((0, (d1 + 1) * rK_rem), dtype=np.uint8)
        keep_lam_idxs = []
        for li in range(L_inj.shape[0]):
            cand_row = np.hstack([M0_cand[li]] + [Mk_cand[c][li] for c in range(d1)])
            if not cand_row.any():
                continue
            test_mat = np.vstack([basis_rows, cand_row[None, :]])
            _, tp = s40a.gf2_rref_np(test_mat)
            if len(tp) > cur_rk:
                cur_rk = len(tp)
                basis_rows = test_mat
                keep_lam_idxs.append(li)

        if not keep_lam_idxs:
            log.append(f"o{outer_rd}:BlkB(at_ker={at_ker_dim},cand={L_inj.shape[0]},+0new)")
            break

        L_use = L_inj[keep_lam_idxs]
        M0_new = M0_cand[keep_lam_idxs]
        Mk_new = [Mk_cand[c][keep_lam_idxs] for c in range(d1)]
        M0_v = np.vstack([M0_v, M0_new])
        Mk_v = [np.vstack([Mk_v[c], Mk_new[c]]) for c in range(d1)]
        bb_stats["n_injected_total"] += len(keep_lam_idxs)

        # ZERO-TRUST VERIFY INJECTED BLOCK-B EQUATIONS ON ALL PLANTED SOLUTIONS!
        # Exact RHS of Block B row m after r_F = G r_keep ^ d(u_1):
        #   rhs_B(u_1) = sum_{i<j} A_{ij} d_i d_j ^ (B_eval(w,t) @ d) ^ c_B(w,t)
        if has_planted:
            b_bb_p = np.zeros((P_cnt, len(keep_lam_idxs)), dtype=np.uint8)
            for p in range(P_cnt):
                d_vec = ((D @ y_planted[p]) & 1) if n_y > 0 else np.zeros(nRF, dtype=np.uint8)
                d_pairs = d_vec[p0_idx] & d_vec[p1_idx]
                rhs_all_B = ((A_rf2 @ d_pairs) & 1) ^ ((B_mat_planted[p] @ d_vec) & 1) ^ c_B_planted[p]
                b_bb_p[p] = (L_use @ rhs_all_B) & 1
            b_cur_planted = np.hstack([b_cur_planted, b_bb_p])
            # Assert 100% survival of ALL planted solutions on the newly injected rows!
            for p in range(P_cnt):
                Mp_new = M0_new.copy()
                for a in np.flatnonzero(U_star[p]): Mp_new ^= Mk_new[a]
                res_p = ((Mp_new @ r_keep_planted[p]) & 1) ^ b_bb_p[p]
                bb_stats["planted_checks"] += 1
                if res_p.any():
                    bb_stats["planted_fails"] += 1
                    raise AssertionError(
                        f"ZERO-TRUST PLANTED CHECK FAILED on Block-B injected rows at outer_rd={outer_rd}! "
                        f"mismatches={int(res_p.sum())}/{len(keep_lam_idxs)}"
                    )
                # Also verify non-triviality: random wrong r_keep should violate the injected eqs!
                r_fake = r_keep_planted[p].copy()
                r_fake[p % rK_rem] ^= 1
                bb_stats["nontriv_tests"] += 1
                if np.any(((Mp_new @ r_fake) & 1) ^ b_bb_p[p]):
                    bb_stats["nontriv_rejects"] += 1

        if enable_affine_y:
            # Update fit/ver RHS for next outer round
            b_bb_f = np.zeros((U_fit.shape[0], len(keep_lam_idxs)), dtype=np.uint8)
            for si in range(U_fit.shape[0]):
                d_vec = ((D @ y_fit[si]) & 1) if n_y > 0 else np.zeros(nRF, dtype=np.uint8)
                d_pairs = d_vec[p0_idx] & d_vec[p1_idx]
                Bm = blk["eval_drf1_mat_point"](B_t, W_fit[si], T_fit[si])
                rhs_all_B = ((A_rf2 @ d_pairs) & 1) ^ ((Bm @ d_vec) & 1) ^ c_B_fit[si]
                b_bb_f[si] = (L_use @ rhs_all_B) & 1
            b_cur_fit = np.hstack([b_cur_fit, b_bb_f])

            b_bb_v = np.zeros((U_ver.shape[0], len(keep_lam_idxs)), dtype=np.uint8)
            for si in range(U_ver.shape[0]):
                d_vec = ((D @ y_ver[si]) & 1) if n_y > 0 else np.zeros(nRF, dtype=np.uint8)
                d_pairs = d_vec[p0_idx] & d_vec[p1_idx]
                Bm = blk["eval_drf1_mat_point"](B_t, W_ver[si], T_ver[si])
                rhs_all_B = ((A_rf2 @ d_pairs) & 1) ^ ((Bm @ d_vec) & 1) ^ c_B_ver[si]
                b_bb_v[si] = (L_use @ rhs_all_B) & 1
            b_cur_ver = np.hstack([b_cur_ver, b_bb_v])

        log.append(f"o{outer_rd}:BlkB(at_ker={at_ker_dim},+{len(keep_lam_idxs)}inj)")

    return {
        "final_rK": G.shape[1],
        "G": G, "D": D,
        "M0_v": M0_v, "Mk_v": Mk_v,
        "log": log,
        "bb_stats": bb_stats,
    }


def gf2_inv_np(M):
    n = M.shape[0]
    aug = np.hstack([M.astype(np.uint8), np.eye(n, dtype=np.uint8)])
    R, pivs = s40a.gf2_rref_np(aug)
    assert len(pivs) == n, f"Matrix not invertible: rk={len(pivs)}/{n}"
    return R[:, n:].copy()


# =============================================================================
# MECHANISM B2: POINTWISE ITERATIVE BLOCK-B COLLAPSE (ZERO-TRUST VERIFIED!)
# =============================================================================

def pointwise_blockb_collapse(blk, w_vec, use_all_drf1=True, delta_drf1=None, delta_B=None, planted_rf=None):
    """
    At a fixed point w_vec (nW,):
      1. Evaluates linear system in r_F from M1_strict (or ALL drf=1: M1_strict+A3+D2+D3!).
      2. Iteratively substitutes affine solution r_F = G @ r_keep ^ d into ALL Block B equations,
         extracts ALL ker(A_tilde^T) collapsed linear equations (including Delta + H(d) + B_eval G!),
         and re-solves until UNSAT_LIN, rK == 0, or fixed point!
    Returns dict(status, rK_init, rK_final, n_iters, n_bb_lin_added).
    """
    nRF = blk["nRF"]
    t_vec = blk["eval_t_batch"](w_vec[None, :])[0]
    if use_all_drf1:
        M_lin = blk["eval_drf1_mat_point"](blk["DRF1_all_t"], w_vec, t_vec)
        b_lin = blk["DRF1_all_b"](w_vec[None, :], t_vec[None, :])[0]
    else:
        M_lin = blk["eval_drf1_mat_point"](blk["M1_strict_t"], w_vec, t_vec)
        b_lin = blk["M1_strict_b"](w_vec[None, :], t_vec[None, :])[0]
    if delta_drf1 is not None:
        b_lin = b_lin ^ delta_drf1

    sat, d_cur, K_cur = gf2_solve_affine(M_lin, b_lin)
    if not sat:
        if planted_rf is not None:
            raise AssertionError("ZERO-TRUST FAIL: Planted solution rejected at initial linear stage!")
        return {"status": "UNSAT_INIT_LIN", "rK_init": -1, "rK_final": -1, "n_iters": 0, "n_bb_lin": 0}

    rK_init = K_cur.shape[0]
    A_rf2 = blk["A_rf2"]
    nB = A_rf2.shape[0]
    p0_idx, p1_idx = blk["p0_idx"], blk["p1_idx"]
    B_mat = blk["eval_drf1_mat_point"](blk["Block_B_t"], w_vec, t_vec)
    c_B = blk["Block_B_c"](w_vec[None, :], t_vec[None, :])[0]
    if delta_B is not None:
        c_B = c_B ^ delta_B

    n_iters = 0
    total_bb_lin = 0
    while True:
        G = K_cur.T  # (nRF, rK)
        rK = G.shape[1]
        if rK == 0:
            # Check all Block B equations at unique r_F = d_cur!
            d_pairs = d_cur[p0_idx] & d_cur[p1_idx]
            res_B = ((A_rf2 @ d_pairs) & 1) ^ ((B_mat @ d_cur) & 1) ^ c_B
            if res_B.any():
                if planted_rf is not None:
                    raise AssertionError("ZERO-TRUST FAIL: Planted solution rejected at rK=0 Block-B check!")
                return {"status": "UNSAT_RK0_BLKB", "rK_init": rK_init, "rK_final": 0, "n_iters": n_iters, "n_bb_lin": total_bb_lin}
            if planted_rf is not None:
                assert np.array_equal(d_cur, planted_rf), "Unique solution != planted_rf!"
            return {"status": "SOLVED_RK0", "rK_init": rK_init, "rK_final": 0, "n_iters": n_iters, "n_bb_lin": total_bb_lin}

        if nB == 0:
            return {"status": "OPEN", "rK_init": rK_init, "rK_final": rK, "n_iters": n_iters, "n_bb_lin": total_bb_lin}

        # Substitute r_F = G @ r_keep ^ d_cur into Block B!
        n_rp = rK * (rK - 1) // 2
        if n_rp > 0:
            P_tr = np.zeros((len(p0_idx), n_rp), dtype=np.uint8)
            col = 0
            for a in range(rK):
                Ga = G[:, a]
                for b in range(a + 1, rK):
                    Gb = G[:, b]
                    P_tr[:, col] = (Ga[p0_idx] & Gb[p1_idx]) ^ (Ga[p1_idx] & Gb[p0_idx])
                    col += 1
            A_tilde = (A_rf2.astype(np.uint16) @ P_tr.astype(np.uint16)) & 1
            L_ker = gf2_left_nullspace(A_tilde)
        else:
            L_ker = np.eye(nB, dtype=np.uint8)

        if L_ker.shape[0] == 0:
            return {"status": "OPEN", "rK_init": rK_init, "rK_final": rK, "n_iters": n_iters, "n_bb_lin": total_bb_lin}

        # Exact linear coefficient of r_keep: Delta ^ H(d_cur) ^ (B_mat @ G)
        P_lin = np.zeros((len(p0_idx), rK), dtype=np.uint8)
        for a in range(rK):
            Ga = G[:, a]
            P_lin[:, a] = (Ga[p0_idx] & Ga[p1_idx]) ^ (d_cur[p0_idx] & Ga[p1_idx]) ^ (d_cur[p1_idx] & Ga[p0_idx])
        Lin_B = (((A_rf2.astype(np.uint16) @ P_lin.astype(np.uint16)) & 1) ^ ((B_mat.astype(np.uint16) @ G.astype(np.uint16)) & 1)) & 1
        d_pairs = d_cur[p0_idx] & d_cur[p1_idx]
        rhs_B = ((A_rf2 @ d_pairs) & 1) ^ ((B_mat @ d_cur) & 1) ^ c_B

        M_new = (L_ker @ Lin_B) & 1
        b_new = (L_ker @ rhs_B) & 1

        sat2, z0, K_sub = gf2_solve_affine(M_new, b_new)
        if not sat2:
            if planted_rf is not None:
                raise AssertionError(f"ZERO-TRUST FAIL: Planted solution rejected at Block-B iter {n_iters + 1}!")
            return {"status": "UNSAT_BLKB_LIN", "rK_init": rK_init, "rK_final": rK, "n_iters": n_iters + 1, "n_bb_lin": total_bb_lin + M_new.shape[0]}

        n_iters += 1
        new_rK = K_sub.shape[0]
        if new_rK == rK:
            # Check if planted_rf lies in current affine space!
            if planted_rf is not None:
                # Verify planted_rf - d_cur is in rowspace(K_cur)
                ok_p, _, _ = gf2_solve_affine(K_cur.T, (planted_rf ^ d_cur) & 1)
                assert ok_p, "ZERO-TRUST FAIL: planted_rf dropped from affine space!"
            return {"status": "OPEN", "rK_init": rK_init, "rK_final": rK, "n_iters": n_iters, "n_bb_lin": total_bb_lin}

        total_bb_lin += (rK - new_rK)
        d_cur = (d_cur ^ ((G @ z0) & 1)) & 1
        K_cur = (K_sub @ K_cur) & 1


# =============================================================================
# PART C: PARTIAL-ISOTROPIC SUBSPACE EXTENSION BUILDER
# =============================================================================

def build_iso_extended_basis(blk, seed=6050):
    """
    Starts from U_iso (maximal common isotropic subspace of all 17 B_qt, where ALL Block D2
    no_w2r rows linearize!) and greedily extends to a full nW x nW basis U_iso_full by adding
    vectors that minimize newly non-isotropic Q_t forms (keeping as many Block D rows linearized
    as possible at d1 = d_iso + 2, +4, +6, ...!).
    """
    nW, nT = blk["nW"], blk["nT"]
    B_qt = blk["B_qt"]
    Mk_c = blk["Mk_c"] if blk["Mk_c"].shape[1] > 0 else None
    U_iso = s57a.find_max_isotropic_subspace(B_qt, nW, Mk_c=Mk_c)
    d_iso = U_iso.shape[0]

    # Candidate extension vectors: unit vectors + minrank_basis vectors if available
    cands = [np.eye(nW, dtype=np.uint8)[k] for k in range(nW)]
    if Mk_c is not None and Mk_c.shape[1] > 0:
        _, fb, _ = s44a.minrank_basis(Mk_c, rk_cap=min(24, max(4, Mk_c.shape[2] - 1)), n_rounds=2, seed=seed)
        for cm in fb:
            v = np.array([(cm >> k) & 1 for k in range(nW)], dtype=np.uint8)
            cands.append(v)

    chosen = [row.copy() for row in U_iso]
    # Track which Q_t are STILL isotropic on span(chosen)
    still_iso = [True] * nT
    while len(chosen) < nW:
        cur_mat = np.array(chosen, dtype=np.uint8)
        _, piv0 = s40a.gf2_rref_np(cur_mat)
        rk0 = len(piv0)
        best_v = None
        best_score = (10**9, 10**9)
        for v in cands:
            _, piv1 = s40a.gf2_rref_np(np.vstack([cur_mat, v[None, :]]))
            if len(piv1) == rk0:
                continue
            # Count how many STILL-isotropic Q_t get broken by adding v, and total rank of B_qt@v on cur_mat
            broken = 0
            tot_hits = 0
            for a in range(nT):
                bv = (cur_mat @ ((B_qt[a] @ v) & 1)) & 1
                h = int(bv.sum())
                tot_hits += h
                if still_iso[a] and h > 0:
                    broken += 1
            sc = (broken, tot_hits)
            if sc < best_score:
                best_score = sc
                best_v = v
        if best_v is None:
            break
        for a in range(nT):
            if still_iso[a] and np.any((cur_mat @ ((B_qt[a] @ best_v) & 1)) & 1):
                still_iso[a] = False
        chosen.append(best_v.copy())

    return np.array(chosen, dtype=np.uint8), d_iso


def make_planted_solutions(blk, U1, t1, Lam_full, n_planted=10, seed=6099):
    """
    Construct `n_planted` EXACT planted solutions (w*, t*, r_F*) inside fiber t1 + U1!
    Each planted solution p gets constant offsets delta_lin[p] and delta_B[p] so that
    the shifted system has (w*, t*, r_F*) as an EXACT 100% solution!
    """
    rng = np.random.default_rng(seed)
    d1 = U1.shape[0]
    nRF = blk["nRF"]
    U_star = rng.integers(0, 2, size=(n_planted, d1), dtype=np.uint8)
    W_star = ((U_star @ U1) & 1) ^ t1[None, :]
    T_star = blk["eval_t_batch"](W_star)
    RF_star = rng.integers(0, 2, size=(n_planted, nRF), dtype=np.uint8)

    # Offsets for DRF1_quad (then projected by Lam_full!)
    b_quad_star = blk["DRF1_quad_b"](W_star, T_star)
    delta_quad = np.zeros_like(b_quad_star)
    for p in range(n_planted):
        Mp = blk["eval_drf1_mat_point"](blk["DRF1_quad_t"], W_star[p], T_star[p])
        delta_quad[p] = ((Mp @ RF_star[p]) & 1) ^ b_quad_star[p]
    delta_lin = (delta_quad @ Lam_full.T) & 1

    # Offsets for DRF1_all (for pointwise check)
    b_all_star = blk["DRF1_all_b"](W_star, T_star)
    delta_all = np.zeros_like(b_all_star)
    for p in range(n_planted):
        Mp = blk["eval_drf1_mat_point"](blk["DRF1_all_t"], W_star[p], T_star[p])
        delta_all[p] = ((Mp @ RF_star[p]) & 1) ^ b_all_star[p]

    # Offsets for Block B
    c_B_star = blk["Block_B_c"](W_star, T_star)
    A_rf2 = blk["A_rf2"]
    p0_idx, p1_idx = blk["p0_idx"], blk["p1_idx"]
    delta_B = np.zeros_like(c_B_star)
    for p in range(n_planted):
        rp = RF_star[p, p0_idx] & RF_star[p, p1_idx]
        Bm = blk["eval_drf1_mat_point"](blk["Block_B_t"], W_star[p], T_star[p])
        delta_B[p] = ((A_rf2 @ rp) & 1) ^ ((Bm @ RF_star[p]) & 1) ^ c_B_star[p]

    return {
        "U_star": U_star, "W_star": W_star, "T_star": T_star, "RF_star": RF_star,
        "delta_lin": delta_lin, "delta_all": delta_all, "delta_B": delta_B,
        "delta_strict": delta_quad[:, :len(blk["M1_strict_psets"])].copy(),
    }


# =============================================================================
# MAIN DRIVER
# =============================================================================

def main():
    t0 = time.perf_counter()
    parser = argparse.ArgumentParser()
    parser.add_argument("--cell", choices=["B0_11", "B1_11"], required=True)
    args = parser.parse_args()
    cell_name = args.cell

    print(f"\n==================== [{cell_name}] STEP 60B: BLOCK-B + BLOCK-D + BLOCK-A3 ALGEBRAIC FEEDBACK ====================", flush=True)

    # Compile C libraries (standard boilerplate)
    c_diag, so_diag = WORK_DIR / "s60b_diag.c", WORK_DIR / "libs60b_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s60b_s9.c", WORK_DIR / "libs60b_s9.so"
    c_s9.write_text(s9.C_STEP9_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_s9), "-o", str(so_s9)], check=True)
    lib9 = s45a._setup_lib9(so_s9)

    c_cg, so_cg = WORK_DIR / "s60b_cg.c", WORK_DIR / "libs60b_cg.so"
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

    c_sh, so_sh = WORK_DIR / "s60b_sh.c", WORK_DIR / "libs60b_sh.so"
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
    all_dudz = build_all_degu_degz_maps(orbits)
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

    test_etas = [5, 0, 9, 11] if cell_name == "B0_11" else [3, 0, 8, 10]
    rng_main = np.random.default_rng(6020)

    for em in test_etas:
        t_em = time.perf_counter()
        print(f"\n==========================================================================", flush=True)
        print(f"  [{cell_name} eta={em}] FULL BLOCK-B + BLOCK-D + BLOCK-A3 ANALYSIS", flush=True)
        print(f"==========================================================================", flush=True)

        blk = extract_full_blocks(em, root, eta_free, lib9, lib_sh, tbl, rng_seed=6000 + em)
        if blk["closed_unsat"]:
            print(f"  [{cell_name} eta={em}] CLOSED UNSAT AT ETA LEVEL!", flush=True)
            continue

        nW, nT, nRF = blk["nW"], blk["nT"], blk["nRF"]
        print(f"  [ZT-0] All extracted blocks (M1_strict, A3, D2, D3, Block B, P0) verified: 0 mismatches on 20 random pts!", flush=True)

        # ---- PART A: EXACT COORDINATE ANATOMY ----
        run_part_a_anatomy(cell_name, em, blk, cb111, orbits, layer_vecs, all_dudz)

        # ---- PART B & PART C: SUBSPACE STRATEGIES + ITERATIVE BLOCK-B FEEDBACK + POINTWISE COLLAPSE ----
        U_iso_full, d_iso = build_iso_extended_basis(blk, seed=6050 + em)
        print(f"\n  --- [{cell_name} eta={em}] PART B & C: ITERATIVE BLOCK-B FEEDBACK + LINEARIZED A3/D (d_iso={d_iso}, NT_iso={nW-d_iso}) ---", flush=True)

        # Helper to build U_opt safely even on M1_strict-broken orbits!
        def get_u_opt(d1):
            if blk["M0_c"].shape[0] >= 4 and blk["M0_c"].shape[1] >= 4:
                U_opt, _, bkey = s57b.optimize_u1_basis(blk["M0_c"], blk["Mk_c"], d1, em_seed=em)
                return U_opt[:d1], bkey
            else:
                return U_iso_full[:d1], (0, 0, 0)

        t1_zero = np.zeros(nW, dtype=np.uint8)
        t1_rand = rng_main.integers(0, 2, size=nW, dtype=np.uint8)

        # --- PART B1: STRICT & AFFINE BLOCK-B FEEDBACK ON U_opt (ZERO-TRUST 10/10 PLANTED VERIFIED!) ---
        print(f"\n    [B1] Un-quotiented nRF={nRF} Iterative Block-B Feedback (M1_strict only vs +Lin(A3+D) vs +BlockB-Feedback):", flush=True)
        d1_sweep = [20, 22, 24, 26, 28, 30] if cell_name == "B0_11" else [16, 18, 20, 22, 24, 26]
        for d1 in d1_sweep:
            if d1 >= nW:
                continue
            U1_opt, bkey = get_u_opt(d1)
            # Extract fiber-linearized A3+D at t1=0 and t1=rand
            M0_lin0, Mu_lin0, eval_b0, ns0, nex0, Lam0 = extract_fiber_linearized_drf1(blk, U1_opt, t1_zero)
            M0_linR, Mu_linR, eval_bR, nsR, nexR, LamR = extract_fiber_linearized_drf1(blk, U1_opt, t1_rand)

            # 10/10 Planted solutions on t1_rand (hardest test: nonzero shift + cross-terms!)
            pl_R = make_planted_solutions(blk, U1_opt, t1_rand, LamR, n_planted=10, seed=6100 + em * 50 + d1)

            # (1) Baseline M1_strict only (no Block-B) at t1=0
            M0_s0 = M0_lin0[:ns0]
            Mu_s0 = [M[:ns0] for M in Mu_lin0]
            res_base = run_blockb_feedback_cascade(
                blk, U1_opt, t1_zero, M0_s0, Mu_s0,
                lambda U, W=None, T=None, f=eval_b0, k=ns0: f(U, W, T)[:, :k],
                lib9, enable_blockb=False, max_outer_rounds=1, max_inner_rounds=6,
            )
            # (2) M1_strict + Strict Block-B Feedback at t1=0 (and t1=rand with 10/10 planted!)
            pl_strict_R = {
                "U_star": pl_R["U_star"], "RF_star": pl_R["RF_star"],
                "delta_lin": pl_R["delta_strict"], "delta_B": pl_R["delta_B"],
            }
            res_bb_s0 = run_blockb_feedback_cascade(
                blk, U1_opt, t1_zero, M0_s0, Mu_s0,
                lambda U, W=None, T=None, f=eval_b0, k=ns0: f(U, W, T)[:, :k],
                lib9, enable_blockb=True, enable_affine_y=False,
                max_outer_rounds=4, max_inner_rounds=6,
            )
            # (3) M1_strict + Lin(A3+D) + Strict Block-B Feedback at t1=rand WITH 10/10 PLANTED VERIFICATION!
            res_full_R = run_blockb_feedback_cascade(
                blk, U1_opt, t1_rand, M0_linR, Mu_linR, eval_bR,
                lib9, enable_blockb=True, enable_affine_y=False,
                max_outer_rounds=4, max_inner_rounds=6,
                planted_data=pl_R, seed=6200 + d1,
            )
            # (4) M1_strict + Lin(A3+D) + Affine-Y Block-B Feedback at t1=0 (check if affine y(u_1) unlocks more!)
            res_aff_0 = run_blockb_feedback_cascade(
                blk, U1_opt, t1_zero, M0_lin0, Mu_lin0, eval_b0,
                lib9, enable_blockb=True, enable_affine_y=True,
                max_outer_rounds=4, max_inner_rounds=6, seed=6300 + d1,
            )
            # Also check standard uncapped (KR+V0+SysB) on the augmented M1_strict + Lin(A3+D) pencil!
            rK_uncap_base, _ = s55b.run_cascade_uncapped(M0_s0, Mu_s0, lib9, max_rounds=8, mR_cap=500, rK_cap=40, keep_cap=128) if ns0 > 0 else (nRF, [])
            rK_uncap_lin, _ = s55b.run_cascade_uncapped(M0_linR, Mu_linR, lib9, max_rounds=8, mR_cap=500, rK_cap=40, keep_cap=128) if M0_linR.shape[0] > 0 else (nRF, [])

            st_R = res_full_R["bb_stats"]
            st_aff = res_aff_0["bb_stats"]
            print(
                f"      U_opt d1={d1:2d}(NT1={nW-d1:2d}) [+A3D={nexR:2d}]: "
                f"noBB_rK={res_base['final_rK']:2d}(uncap={rK_uncap_base:2d}) | "
                f"BB_strict_t0={res_bb_s0['final_rK']:2d}(atK={res_bb_s0['bb_stats']['n_atilde_ker_max']:3d},inj={res_bb_s0['bb_stats']['n_injected_total']:2d}) | "
                f"A3D+BB_tR={res_full_R['final_rK']:2d}(uncap={rK_uncap_lin:2d},inj={st_R['n_injected_total']:2d},ZT={st_R['planted_checks']}ok/{st_R['planted_fails']}fail) | "
                f"AffY_t0={res_aff_0['final_rK']:2d}(affY={st_aff['n_affine_y_found']:2d},inj={st_aff['n_injected_total']:2d})",
                flush=True,
            )

        # --- PART C2: ISOTROPY-BOOSTED U_iso & PARTIAL-ISOTROPIC EXTENSIONS U_iso_ext! ---
        print(f"\n    [C2] Isotropy-Boosted U_iso_ext (starts at d_iso={d_iso}, maximizes Linearized Block-D + A3 + Block-B Feedback):", flush=True)
        iso_d1_list = sorted(set([d_iso] + [d for d in [14, 16, 18, 20, 22, 24, 26, 28] if d >= d_iso - 2 and d < nW]))
        for d1 in iso_d1_list:
            U1_iso = U_iso_full[:d1]
            M0_linR, Mu_linR, eval_bR, nsR, nexR, LamR = extract_fiber_linearized_drf1(blk, U1_iso, t1_rand)
            pl_R = make_planted_solutions(blk, U1_iso, t1_rand, LamR, n_planted=10, seed=6400 + em * 50 + d1)

            res_iso_R = run_blockb_feedback_cascade(
                blk, U1_iso, t1_rand, M0_linR, Mu_linR, eval_bR,
                lib9, enable_blockb=True, enable_affine_y=False,
                max_outer_rounds=4, max_inner_rounds=6,
                planted_data=pl_R, seed=6500 + d1,
            )
            rK_uncap_iso, lg_iso = s55b.run_cascade_uncapped(
                M0_linR, Mu_linR, lib9, max_rounds=10, mR_cap=500, rK_cap=40, keep_cap=128
            ) if M0_linR.shape[0] > 0 else (nRF, [])

            # Also test uncapped cascade on the POST-Block-B-injected pencil!
            rK_uncap_post, _ = s55b.run_cascade_uncapped(
                res_iso_R["M0_v"], res_iso_R["Mk_v"], lib9, max_rounds=8, mR_cap=500, rK_cap=40, keep_cap=128
            ) if res_iso_R["final_rK"] > 0 and res_iso_R["M0_v"].shape[0] > 0 else (res_iso_R["final_rK"], [])

            st = res_iso_R["bb_stats"]
            print(
                f"      U_iso_ext d1={d1:2d}(NT1={nW-d1:2d}) [m_tot={M0_linR.shape[0]:3d} (+A3D={nexR:2d})]: "
                f"unquot_rK={res_iso_R['final_rK']:2d}(atK={st['n_atilde_ker_max']:3d},inj={st['n_injected_total']:2d},ZT={st['planted_checks']}ok/{st['planted_fails']}fail) | "
                f"uncap(KR+V0+SysB)={rK_uncap_iso:2d} (postBB={rK_uncap_post:2d})",
                flush=True,
            )

        # --- PART B2: POINTWISE ITERATIVE BLOCK-B COLLAPSE (ZERO-TRUST 10/10 PLANTED + 32 REAL POINTS!) ---
        print(f"\n    [B2] Pointwise Iterative Block-B Collapse (10/10 Planted ZT + 32 Real Fiber Points):", flush=True)
        # Verify 10/10 planted solutions survive BOTH strict-only AND all-drf1 pointwise Block-B collapse!
        U1_pt = U_iso_full[:d_iso]
        _, _, _, _, _, Lam_pt = extract_fiber_linearized_drf1(blk, U1_pt, t1_rand)
        pl_pt = make_planted_solutions(blk, U1_pt, t1_rand, Lam_pt, n_planted=10, seed=6600 + em)
        pt_pl_strict_ok, pt_pl_all_ok = 0, 0
        pl_rk_drops_s, pl_rk_drops_a = [], []
        for p in range(10):
            rs = pointwise_blockb_collapse(
                blk, pl_pt["W_star"][p], use_all_drf1=False,
                delta_drf1=pl_pt["delta_strict"][p], delta_B=pl_pt["delta_B"][p],
                planted_rf=pl_pt["RF_star"][p],
            )
            ra = pointwise_blockb_collapse(
                blk, pl_pt["W_star"][p], use_all_drf1=True,
                delta_drf1=pl_pt["delta_all"][p], delta_B=pl_pt["delta_B"][p],
                planted_rf=pl_pt["RF_star"][p],
            )
            if rs["status"] in ("OPEN", "SOLVED_RK0"): pt_pl_strict_ok += 1
            if ra["status"] in ("OPEN", "SOLVED_RK0"): pt_pl_all_ok += 1
            pl_rk_drops_s.append((rs["rK_init"], rs["rK_final"], rs["n_iters"]))
            pl_rk_drops_a.append((ra["rK_init"], ra["rK_final"], ra["n_iters"]))
        print(
            f"      Planted ZT (10/10): M1_strict+BB={pt_pl_strict_ok}/10 (sample rK: {pl_rk_drops_s[:4]}) | "
            f"ALL_DRF1+BB={pt_pl_all_ok}/10 (sample rK: {pl_rk_drops_a[:4]})",
            flush=True,
        )

        # Now run on 32 REAL random w points (checking both M1_strict+BB and ALL_DRF1+BB!)
        W_real = rng_main.integers(0, 2, size=(32, nW), dtype=np.uint8)
        for label_m, use_all in [("M1_strict+BB", False), ("ALL_DRF1(M1+A3+D)+BB", True)]:
            st_counts = {}
            rK_inits, rK_finals, iters_l = [], [], []
            for bi in range(32):
                res = pointwise_blockb_collapse(blk, W_real[bi], use_all_drf1=use_all)
                st_counts[res["status"]] = st_counts.get(res["status"], 0) + 1
                if res["rK_init"] >= 0:
                    rK_inits.append(res["rK_init"])
                    rK_finals.append(res["rK_final"])
                    iters_l.append(res["n_iters"])
            rk_str = f"avg_rK: {np.mean(rK_inits):.1f}->{np.mean(rK_finals):.1f} (max_it={max(iters_l)})" if rK_inits else "all UNSAT_INIT_LIN"
            print(f"      Real 32 pts [{label_m:20s}]: {st_counts} | {rk_str}", flush=True)

        # --- PART C3: FULL-389 s9.run_branch_cascade CLOSURE TEST ON U_iso^perp & U_iso_ext^perp! ---
        print(f"\n    [C3] Full-389 s9.run_branch_cascade Closure Test on True Annihilator U1^perp:", flush=True)
        sr = blk["sr"]
        W_forms_111 = blk["W_forms_111"]
        test_subspaces = [
            (f"U_iso(d={d_iso})", U_iso_full[:d_iso]),
            (f"U_iso+4(d={min(nW-1, d_iso+4)})", U_iso_full[:min(nW - 1, d_iso + 4)]),
            (f"U_iso+8(d={min(nW-1, d_iso+8)})", U_iso_full[:min(nW - 1, d_iso + 8)]),
        ]
        d_uopt_test = 24 if cell_name == "B0_11" else 20
        U1_opt_t, _ = get_u_opt(d_uopt_test)
        test_subspaces.append((f"U_opt(d={d_uopt_test})", U1_opt_t))

        for s_lbl, U_sub in test_subspaces:
            F_sub = s40a.gf2_nullspace_np(U_sub)  # TRUE annihilator U_sub^perp!
            k_fix = F_sub.shape[0]
            fix_forms = []
            for row in F_sub:
                fm = 0
                for k in range(nW):
                    if row[k]:
                        fm ^= W_forms_111[k]
                fix_forms.append(fm)
            f_res = []
            for tr in range(3):
                rb = 0 if tr == 0 else int(rng_main.integers(1, 1 << min(30, k_fix)))
                ex_w = [(fix_forms[j], (rb >> j) & 1) for j in range(k_fix)]
                t_s = time.perf_counter()
                sub = s9.run_branch_cascade(
                    lib9, sr["_buf"], sr["_quad_ids"], sr["_cub_ids"], sr["_lin_pivs"],
                    ex_w, tbl, max_xl_rounds=25, verify_subst=(tr == 0)
                )
                dt_s = time.perf_counter() - t_s
                if sub["closed_unsat"]:
                    f_res.append(f"f{tr}:S9_UNSAT({dt_s:.1f}s)")
                else:
                    f_res.append(f"f{tr}:N={111-len(sub['_lin_pivs'])},q={len(sub['_quad_ids'])},c={len(sub['_cub_ids'])}({dt_s:.1f}s)")
            print(f"      {s_lbl:18s} (k_fix={k_fix:2d}): {' | '.join(f_res)}", flush=True)

        print(f"  [{cell_name} eta={em}] done in {time.perf_counter()-t_em:.1f}s", flush=True)

    print(f"\n[{cell_name}] STEP 60B DONE in {time.perf_counter()-t0:.1f}s", flush=True)


if __name__ == "__main__":
    main()
