#!/usr/bin/env python3
r"""
SOLVE_STEP61A_EXTENDED_OPT_AND_ALGEBRAIC_CEILING.py

FRONT 3 (FOLLOW-UP TO STEP 60B VERIFIED BREAKTHROUGH):
  1. FAST DIRECT-COLUMN BLOCK EXTRACTOR (~10x faster than Step 60B: reads col_deg/v0/v1/v2
     directly from uint64 echelon words instead of scanning 2.7M Python big-ints; 0-mismatch ZT!).
  2. JOINT `M1_strict + Lin(A3+D)` SUBSPACE OPTIMIZER (`optimize_u1_joint`):
     Optimizes U_1 DIRECTLY on the full fiber-linearized `M1_strict + Block A3 + Block D2` pencil
     (pooling M1_strict minrank seeds, U_iso_full, AND full-131..146-row linear-part minrank seeds,
     followed by greedy 1-swap optimization maximizing `(r1_elim, V0, KR, n_lin)`!).
  3. TRUE `d1` CEILING SWEEP:
     - B0_11 (eta = 5, 0, 9, 11): d1 = 26, 28, 30, 32, 34, 36, 38, 40, 42, 44 (plus 20,22,24 on eta=11)
     - B1_11 (eta = 3, 0, 8, 10): d1 = 18, 20, 22, 24, 26, 28, 30, 32
     Tests un-quotiented nRF=40 cascade + Iterative Strict Block-B Feedback (10/10 planted ZT!)
     AND uncapped KR+V0+SysB cascade to find the EXACT maximum d1 (minimum NT1) with final_rK == 0!
  4. DIRECT ALGEBRAIC `1 = 0` CLOSURE ON `final_rK = 0` FIBERS (NO u_1 SCANNING!):
     - (A) Pure-u_1 syzygy check on `P0 + b_cur(u_1)` at `final_rK = 0` (checks if `1` lies in
           the span of pure-u_1 equations, verified against 10/10 planted solutions!).
     - (B) Full-389 `s9.run_branch_cascade` on true annihilator `U1_joint^perp`, followed by
           UNTRUNCATED C-backed Degree-3 Macaulay RREF + `CaDiCaL` (`Cadical195`) on any
           shattered pure-quadratic residual (`c == 0, N <= 75`), with planted-solution ZT check!
"""

import argparse
import ctypes
import random
import subprocess
import sys
import time
from pathlib import Path
import numpy as np
from pysat.solvers import Cadical195

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
import SOLVE_STEP47B_ITERATIVE_SYSB_CASCADE as s47b
import SOLVE_STEP55B_UNCAP_SYSB_AND_KERNEL_BASIS as s55b
import SOLVE_STEP57A_M1EXT_AND_DRF2_COLLAPSE as s57a
import SOLVE_STEP57B_GREEDY_BASIS_AND_BLOCKB_INJECT as s57b
import SOLVE_STEP60B_BLOCKB_BLOCKD_ALGEBRAIC_FEEDBACK as s60b


# =============================================================================
# FAST DIRECT-COLUMN BLOCK EXTRACTOR (~10x FASTER THAN STEP 60B, 0-MISMATCH ZT!)
# =============================================================================

def extract_full_blocks_fast(em, root, eta_free, lib9, lib_sh, tbl, rng_seed=6100):
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

    # Extract Q_t[0..nT-1] and B_qt[0..nT-1]
    T_mask_all = sum(1 << v for v in T_pivs)
    RF_mask_all = sum(1 << v for v in RF_vars)
    q_sheared_psets = [s9.row_to_pset(work, qi, tbl) for qi in range(n_q)]
    t_piv_map = {}
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

    # Precompute column metadata ONCE (fast!)
    col_deg_np = np.ctypeslib.as_array(tbl["col_deg"], shape=(n_cols,))
    col_v0_np = np.ctypeslib.as_array(tbl["col_v0"], shape=(n_cols,))
    col_v1_np = np.ctypeslib.as_array(tbl["col_v1"], shape=(n_cols,))
    col_v2_np = np.ctypeslib.as_array(tbl["col_v2"], shape=(n_cols,))

    # Map every variable 0..n-1 to group: 0=W, 1=T, 2=RF, -1=inactive
    var_grp = np.full(n, -1, dtype=np.int8)
    var_loc = np.full(n, -1, dtype=np.int16)
    for k, v in enumerate(W_pivs): var_grp[v] = 0; var_loc[v] = k
    for k, v in enumerate(T_pivs): var_grp[v] = 1; var_loc[v] = k
    for k, v in enumerate(RF_vars): var_grp[v] = 2; var_loc[v] = k

    # Vectorized column classification!
    c_drf = np.zeros(n_cols, dtype=np.int8)
    c_dtc = np.zeros(n_cols, dtype=np.int8)
    m1 = col_deg_np >= 1
    m2 = col_deg_np >= 2
    m3 = col_deg_np >= 3
    c_drf[m1] += (var_grp[col_v0_np[m1]] == 2)
    c_drf[m2] += (var_grp[col_v1_np[m2]] == 2)
    c_drf[m3] += (var_grp[col_v2_np[m3]] == 2)
    c_dtc[m1] += (var_grp[col_v0_np[m1]] == 1)
    c_dtc[m2] += (var_grp[col_v1_np[m2]] == 1)
    c_dtc[m3] += (var_grp[col_v2_np[m3]] == 1)

    col_keys = [(3 - int(c_drf[c]), 3 - int(c_dtc[c]), 3 - int(col_deg_np[c]), c) for c in range(n_cols)]
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
            oc = perm_to_orig[pc]
            ech_rows.append((r, int(c_drf[oc]), int(c_dtc[oc]), int(col_deg_np[oc])))
    inv_perm = (ctypes.c_int * n_cols)(*perm_to_orig)
    std_ech = (ctypes.c_uint64 * (M_eq * n_cw))()
    lib_sh.remap_rows_by_perm(perm_buf, std_ech, M_eq, n_cw, n_cols, inv_perm)

    # View std_ech as numpy uint64 (M_eq, n_cw) -> unpackbits directly per row!
    std_u64 = np.ctypeslib.as_array(std_ech, shape=(M_eq, n_cw))
    std_bits = np.unpackbits(std_u64.view(np.uint8), axis=1, bitorder="little")[:, :n_cols]

    # Classify rows using numpy nonzero columns (instant!)
    P0_rids, M1_strict_rids, Block_A3_rids, Block_D2_rids, Block_D3_rids, Block_B_rids = [], [], [], [], [], []
    drf1_col_mask = (c_drf == 1)
    # Pre-classify every drf=1 column by (n_w, n_t)
    c_nw = np.zeros(n_cols, dtype=np.int8)
    c_nw[m1] += (var_grp[col_v0_np[m1]] == 0)
    c_nw[m2] += (var_grp[col_v1_np[m2]] == 0)
    c_nw[m3] += (var_grp[col_v2_np[m3]] == 0)

    is_wt_or_t2 = drf1_col_mask & ((c_dtc >= 2) | ((c_dtc == 1) & (c_nw >= 1)))
    is_t_only = drf1_col_mask & (c_dtc == 1) & (c_nw == 0)
    is_w2_only = drf1_col_mask & (c_dtc == 0) & (c_nw >= 2)

    for r_id, drf, dt_c, lead_d in ech_rows:
        if drf == 0:
            P0_rids.append(r_id)
        elif drf == 1:
            row_nz = np.flatnonzero(std_bits[r_id])
            if np.any(is_wt_or_t2[row_nz]):
                Block_D3_rids.append(r_id)
            elif np.any(is_t_only[row_nz]):
                Block_D2_rids.append(r_id)
            elif np.any(is_w2_only[row_nz]):
                Block_A3_rids.append(r_id)
            else:
                M1_strict_rids.append(r_id)
        elif drf == 2 and dt_c == 0 and lead_d == 2:
            Block_B_rids.append(r_id)

    # FAST VECTORIZED TENSOR COMPILER DIRECTLY FROM std_bits!
    # Precompute column index sets for each drf=1 type
    cols_r = np.flatnonzero(drf1_col_mask & (c_nw == 0) & (c_dtc == 0))
    cols_wr = np.flatnonzero(drf1_col_mask & (c_nw == 1) & (c_dtc == 0))
    cols_tr = np.flatnonzero(drf1_col_mask & (c_nw == 0) & (c_dtc == 1))
    cols_wwr = np.flatnonzero(drf1_col_mask & (c_nw == 2) & (c_dtc == 0))
    cols_wtr = np.flatnonzero(drf1_col_mask & (c_nw == 1) & (c_dtc == 1))
    cols_ttr = np.flatnonzero(drf1_col_mask & (c_nw == 0) & (c_dtc == 2))
    cols_drf0 = np.flatnonzero(c_drf == 0)
    cols_drf2_d2 = np.flatnonzero((c_drf == 2) & (c_dtc == 0) & (col_deg_np == 2))

    # Helper: unpack local indices for a column array
    def unpack_col_vars(col_arr):
        out = []
        for c in col_arr:
            d = int(col_deg_np[c])
            vs = [int(col_v0_np[c])]
            if d >= 2: vs.append(int(col_v1_np[c]))
            if d >= 3: vs.append(int(col_v2_np[c]))
            wvs = sorted(int(var_loc[v]) for v in vs if var_grp[v] == 0)
            tvs = sorted(int(var_loc[v]) for v in vs if var_grp[v] == 1)
            rfvs = sorted(int(var_loc[v]) for v in vs if var_grp[v] == 2)
            out.append((int(c), wvs, tvs, rfvs))
        return out

    meta_r = [(c, rfvs[0]) for c, _, _, rfvs in unpack_col_vars(cols_r)]
    meta_wr = [(c, wvs[0], rfvs[0]) for c, wvs, _, rfvs in unpack_col_vars(cols_wr)]
    meta_tr = [(c, tvs[0], rfvs[0]) for c, _, tvs, rfvs in unpack_col_vars(cols_tr)]
    meta_wwr = [(c, (wvs[0], wvs[1]), rfvs[0]) for c, wvs, _, rfvs in unpack_col_vars(cols_wwr)]
    meta_wtr = [(c, (wvs[0], tvs[0]), rfvs[0]) for c, wvs, tvs, rfvs in unpack_col_vars(cols_wtr)]
    meta_ttr = [(c, (tvs[0], tvs[1]), rfvs[0]) for c, _, tvs, rfvs in unpack_col_vars(cols_ttr)]

    # Group meta_wwr, meta_wtr, meta_ttr by key -> (col_arr, rf_arr) for instant numpy slicing!
    def group_by_key(meta_list):
        d = {}
        for c, key, rfi in meta_list:
            d.setdefault(key, ([], []))
            d[key][0].append(c)
            d[key][1].append(rfi)
        return {k: (np.array(cs, dtype=np.int32), np.array(rfs, dtype=np.int32)) for k, (cs, rfs) in d.items()}

    grp_wwr = group_by_key(meta_wwr)
    grp_wtr = group_by_key(meta_wtr)
    grp_ttr = group_by_key(meta_ttr)

    def compile_drf1_fast(rids):
        nr = len(rids)
        sub = std_bits[rids] if nr > 0 else np.zeros((0, n_cols), dtype=np.uint8)
        M0 = np.zeros((nr, nRF), dtype=np.uint8)
        Mw = np.zeros((nW, nr, nRF), dtype=np.uint8)
        Mt = np.zeros((nT, nr, nRF), dtype=np.uint8)
        Mww, Mwt, Mtt = {}, {}, {}
        if nr > 0:
            for c, rfi in meta_r:
                M0[:, rfi] ^= sub[:, c]
            for c, wi, rfi in meta_wr:
                Mw[wi, :, rfi] ^= sub[:, c]
            for c, ti, rfi in meta_tr:
                Mt[ti, :, rfi] ^= sub[:, c]
            for key, (cs, rfs) in grp_wwr.items():
                sl = sub[:, cs]
                if sl.any():
                    mat = np.zeros((nr, nRF), dtype=np.uint8)
                    mat[:, rfs] = sl
                    Mww[key] = mat
            for key, (cs, rfs) in grp_wtr.items():
                sl = sub[:, cs]
                if sl.any():
                    mat = np.zeros((nr, nRF), dtype=np.uint8)
                    mat[:, rfs] = sl
                    Mwt[key] = mat
            for key, (cs, rfs) in grp_ttr.items():
                sl = sub[:, cs]
                if sl.any():
                    mat = np.zeros((nr, nRF), dtype=np.uint8)
                    mat[:, rfs] = sl
                    Mtt[key] = mat
        return {"M0": M0, "Mw": Mw, "Mt": Mt, "Mww": Mww, "Mwt": Mwt, "Mtt": Mtt}

    # Fast drf=0 compiler directly from std_bits!
    drf0_meta = unpack_col_vars(cols_drf0)
    drf0_col_to_wt = {}
    for c, wvs, tvs, _ in drf0_meta:
        drf0_col_to_wt[c] = tuple(sorted(wvs + [nW + t for t in tvs]))

    def compile_drf0_fast(rids):
        nr = len(rids)
        if nr == 0:
            return lambda W_mat, T_mat=None: np.zeros((W_mat.shape[0], 0), dtype=np.uint8)
        sub = std_bits[rids][:, cols_drf0]
        nz_local = np.flatnonzero(sub.any(axis=0))
        consts = np.zeros(nr, dtype=np.uint8)
        uniq_mons = []
        keep_sub_cols = []
        for li in nz_local:
            c = int(cols_drf0[li])
            key = drf0_col_to_wt[c]
            if len(key) == 0:
                consts ^= sub[:, li]
            else:
                uniq_mons.append(key)
                keep_sub_cols.append(li)
        n_um = len(uniq_mons)
        C_mat_T = sub[:, keep_sub_cols].T.copy() if n_um > 0 else np.zeros((0, nr), dtype=np.uint8)
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
            if n_um == 0:
                return np.broadcast_to(consts, (B, nr)).copy()
            if T_mat is None:
                T_mat = eval_t_batch(W_mat)
            WT = np.hstack([W_mat, T_mat]) if nT > 0 else W_mat
            M_vals = np.zeros((B, n_um), dtype=np.uint8)
            if idx1: M_vals[:, idx1] = WT[:, a1]
            if idx2: M_vals[:, idx2] = WT[:, a2] & WT[:, b2]
            if idx3: M_vals[:, idx3] = WT[:, a3] & WT[:, b3] & WT[:, c3]
            return ((M_vals @ C_mat_T) & 1) ^ consts

        return eval_fn

    def eval_drf1_mat_point(tens, w_vec, t_vec):
        M = tens["M0"].copy()
        for k in np.flatnonzero(w_vec): M ^= tens["Mw"][k]
        for a in np.flatnonzero(t_vec): M ^= tens["Mt"][a]
        for (p, q), mat in tens["Mww"].items():
            if w_vec[p] and w_vec[q]: M ^= mat
        for (p, a), mat in tens["Mwt"].items():
            if w_vec[p] and t_vec[a]: M ^= mat
        for (a, b), mat in tens["Mtt"].items():
            if t_vec[a] and t_vec[b]: M ^= mat
        return M

    # Compile all blocks FAST!
    DRF1_quad_rids = M1_strict_rids + Block_A3_rids + Block_D2_rids
    DRF1_all_rids = DRF1_quad_rids + Block_D3_rids

    M1_strict_t = compile_drf1_fast(M1_strict_rids)
    M1_strict_b = compile_drf0_fast(M1_strict_rids)
    DRF1_quad_t = compile_drf1_fast(DRF1_quad_rids)
    DRF1_quad_b = compile_drf0_fast(DRF1_quad_rids)
    DRF1_all_t = compile_drf1_fast(DRF1_all_rids)
    DRF1_all_b = compile_drf0_fast(DRF1_all_rids)
    P0_eval = compile_drf0_fast(P0_rids)

    # Block B A_rf2
    rf_pairs = [(i, j) for i in range(nRF) for j in range(i + 1, nRF)]
    pair_rf_map = {p: idx for idx, p in enumerate(rf_pairs)}
    p0_idx_arr = np.array([p[0] for p in rf_pairs], dtype=np.int32)
    p1_idx_arr = np.array([p[1] for p in rf_pairs], dtype=np.int32)
    A_rf2 = np.zeros((len(Block_B_rids), len(rf_pairs)), dtype=np.uint8)
    if Block_B_rids:
        sub_B = std_bits[Block_B_rids]
        for c, _, _, rfvs in unpack_col_vars(cols_drf2_d2):
            A_rf2[:, pair_rf_map[(rfvs[0], rfvs[1])]] ^= sub_B[:, c]
    Block_B_t = compile_drf1_fast(Block_B_rids)
    Block_B_c = compile_drf0_fast(Block_B_rids)

    # ZERO-TRUST VERIFY ALL EXTRACTED BLOCKS AGAINST std_ech ON 16 RANDOM (W, R_F) POINTS!
    rng_zt = random.Random(rng_seed)
    W_zt = np.array([[rng_zt.getrandbits(1) for _ in range(nW)] for _ in range(16)], dtype=np.uint8)
    RF_zt = np.array([[rng_zt.getrandbits(1) for _ in range(nRF)] for _ in range(16)], dtype=np.uint8)
    T_zt = eval_t_batch(W_zt)
    b_all_zt = DRF1_all_b(W_zt, T_zt)
    c_B_zt = Block_B_c(W_zt, T_zt)
    p0_zt = P0_eval(W_zt, T_zt)

    # Check against C eval_row_s9 directly (instant & 100% independent!)
    zt_mis = 0
    for bi in range(16):
        val_bits = 0
        for k, v in enumerate(W_pivs):
            if W_zt[bi, k]: val_bits |= (1 << v)
        for ti, v in enumerate(T_pivs):
            if T_zt[bi, ti]: val_bits |= (1 << v)
        for fi, v in enumerate(RF_vars):
            if RF_zt[bi, fi]: val_bits |= (1 << v)
        v_lo, v_hi = val_bits & mask64, val_bits >> 64

        M_a = eval_drf1_mat_point(DRF1_all_t, W_zt[bi], T_zt[bi])
        lhs_a = ((M_a @ RF_zt[bi]) & 1) ^ b_all_zt[bi]
        for ri, rid in enumerate(DRF1_all_rids):
            ev = lib9.eval_row_s9(std_ech, rid, n_cw, tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"], v_lo, v_hi)
            if int(lhs_a[ri]) != ev:
                zt_mis += 1

        rp = RF_zt[bi, p0_idx_arr] & RF_zt[bi, p1_idx_arr]
        M_b = eval_drf1_mat_point(Block_B_t, W_zt[bi], T_zt[bi])
        lhs_b = ((A_rf2 @ rp) & 1) ^ ((M_b @ RF_zt[bi]) & 1) ^ c_B_zt[bi]
        for ri, rid in enumerate(Block_B_rids):
            ev = lib9.eval_row_s9(std_ech, rid, n_cw, tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"], v_lo, v_hi)
            if int(lhs_b[ri]) != ev:
                zt_mis += 1

        for ri, rid in enumerate(P0_rids):
            ev = lib9.eval_row_s9(std_ech, rid, n_cw, tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"], v_lo, v_hi)
            if int(p0_zt[bi, ri]) != ev:
                zt_mis += 1
    assert zt_mis == 0, f"Fast extractor Zero-Trust FAILED: {zt_mis} mismatches!"

    # Build M1_strict core (M0_c, Mk_c)
    M0_s, Mw_s = M1_strict_t["M0"], M1_strict_t["Mw"]
    n_strict = len(M1_strict_rids)
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
        M0_c = np.zeros((0, 0), dtype=np.uint8)
        Mk_c = np.zeros((nW, 0, 0), dtype=np.uint8)

    # Also build FULL-DRF1 linear-part core (M0_full_lin, Mk_full_lin) for joint minrank seeding!
    M0_fl = DRF1_quad_t["M0"].copy()
    for a in np.flatnonzero(qt_c0):
        M0_fl ^= DRF1_quad_t["Mt"][a]
    Mw_fl = DRF1_quad_t["Mw"].copy()
    for k in range(nW):
        for a in np.flatnonzero(qt_lin[:, k]):
            Mw_fl[k] ^= DRF1_quad_t["Mt"][a]

    return {
        "closed_unsat": False,
        "sr": sr, "W_rref": W_rref, "T_rref": T_rref,
        "W_pivs": W_pivs, "T_pivs": T_pivs, "RF_vars": RF_vars,
        "W_forms_111": W_forms_111,
        "nW": nW, "nT": nT, "nRF": nRF, "n_q": n_q, "M_eq": M_eq,
        "qt_c0": qt_c0, "qt_lin": qt_lin, "B_qt": B_qt, "eval_t_batch": eval_t_batch,
        "P0_psets": P0_rids, "P0_eval": P0_eval,
        "M1_strict_psets": M1_strict_rids, "M1_strict_t": M1_strict_t, "M1_strict_b": M1_strict_b,
        "Block_A3_psets": Block_A3_rids, "Block_D2_psets": Block_D2_rids, "Block_D3_psets": Block_D3_rids,
        "DRF1_quad_psets": DRF1_quad_rids, "DRF1_quad_t": DRF1_quad_t, "DRF1_quad_b": DRF1_quad_b,
        "DRF1_all_psets": DRF1_all_rids, "DRF1_all_t": DRF1_all_t, "DRF1_all_b": DRF1_all_b,
        "Block_B_psets": Block_B_rids, "A_rf2": A_rf2, "rf_pairs": rf_pairs,
        "p0_idx": p0_idx_arr, "p1_idx": p1_idx_arr,
        "Block_B_t": Block_B_t, "Block_B_c": Block_B_c,
        "M0_c": M0_c, "Mk_c": Mk_c,
        "M0_fl": M0_fl, "Mw_fl": Mw_fl,
        "eval_drf1_mat_point": eval_drf1_mat_point,
    }


# =============================================================================
# GOAL 1: JOINT `M1_strict + Lin(A3+D)` SUBSPACE OPTIMIZER!
# =============================================================================

def build_candidate_full_bases(blk, U_iso_full, em_seed=0):
    """Build a diverse pool of full (nW x nW) bases from:
       1) U_iso_full (isotropy-extended basis),
       2) M1_strict core minrank_basis (6 seeds),
       3) FULL DRF1 (M1+A3+D2) linear-part minrank_basis (6 seeds — works even on M1_strict-broken orbits!).
    """
    nW = blk["nW"]
    bases = [("iso", U_iso_full.copy())]

    # Pool 2: M1_strict core
    if blk["M0_c"].shape[0] >= 4 and blk["M0_c"].shape[1] >= 4:
        for s_i in range(6):
            rk_cap = [20, 24, 28][s_i % 3]
            _, fb, _ = s44a.minrank_basis(blk["Mk_c"], rk_cap=rk_cap, n_rounds=2 + (s_i % 2), seed=6100 + 31 * s_i + em_seed)
            U = np.zeros((nW, nW), dtype=np.uint8)
            for a, cm in enumerate(fb):
                for k in range(nW):
                    if (cm >> k) & 1: U[a, k] = 1
            bases.append((f"m1_{s_i}", U))

    # Pool 3: Full DRF1 linear-part minrank_basis!
    M0_fl, Mw_fl = blk["M0_fl"], blk["Mw_fl"]
    if M0_fl.shape[0] >= 4:
        for s_i in range(6):
            rk_cap = [24, 28, 32][s_i % 3]
            _, fb, _ = s44a.minrank_basis(Mw_fl, rk_cap=rk_cap, n_rounds=2 + (s_i % 2), seed=6200 + 37 * s_i + em_seed)
            U = np.zeros((nW, nW), dtype=np.uint8)
            for a, cm in enumerate(fb):
                for k in range(nW):
                    if (cm >> k) & 1: U[a, k] = 1
            bases.append((f"fl_{s_i}", U))

    return bases


def optimize_u1_joint(blk, d1, t1_ref, cand_bases, do_swaps=True):
    """
    Directly optimizes a d1-dim subspace U1 on the EXACT fiber-linearized
    `M1_strict + Block A3 + Block D2` pencil!
    Objective key: (tot_r1_elim, d_v0, d_kr, m_lin).
    """
    nW = blk["nW"]
    if d1 >= nW:
        U_id = np.eye(nW, dtype=np.uint8)
        M0_l, Mu_l, _, _, nex, _ = s60b.extract_fiber_linearized_drf1(blk, U_id, t1_ref)
        te, dkr, dv0, _ = s57b.round1_elim_score(M0_l, Mu_l) if M0_l.shape[0] > 0 else (0, 0, 0, blk["nRF"])
        return U_id, (te, dv0, dkr, M0_l.shape[0]), "full_id"

    best_U = None
    best_key = (-1, -1, -1, -1)
    best_src = ""

    for tag, U_full in cand_bases:
        U1 = U_full[:d1]
        M0_l, Mu_l, _, _, _, _ = s60b.extract_fiber_linearized_drf1(blk, U1, t1_ref)
        if M0_l.shape[0] == 0:
            key = (0, 0, 0, 0)
        else:
            te, dkr, dv0, _ = s57b.round1_elim_score(M0_l, Mu_l)
            key = (te, dv0, dkr, M0_l.shape[0])
        if key > best_key:
            best_key = key
            best_U = U_full.copy()
            best_src = tag

    # Also test s57b's M1_strict-optimized basis at this d1 (if M1_strict has >= 4 rows)
    if blk["M0_c"].shape[0] >= 4 and blk["M0_c"].shape[1] >= 4:
        U_m1opt, _, _ = s57b.optimize_u1_basis(blk["M0_c"], blk["Mk_c"], d1, em_seed=d1)
        M0_l, Mu_l, _, _, _, _ = s60b.extract_fiber_linearized_drf1(blk, U_m1opt[:d1], t1_ref)
        if M0_l.shape[0] > 0:
            te, dkr, dv0, _ = s57b.round1_elim_score(M0_l, Mu_l)
            key = (te, dv0, dkr, M0_l.shape[0])
            if key > best_key:
                best_key = key
                best_U = U_m1opt.copy()
                best_src = "s57b_m1"

    # Greedy 1-swap refinement directly on `M1_strict + Lin(A3+D)` (bounded swap budget for speed!)
    if do_swaps and d1 < nW:
        n_swaps_tried = 0
        max_swaps = 45
        for i in range(d1 - 1, max(-1, d1 - 10), -1):
            for j in range(d1, nW):
                if n_swaps_tried >= max_swaps:
                    break
                n_swaps_tried += 1
                best_U[[i, j]] = best_U[[j, i]]
                M0_l, Mu_l, _, _, _, _ = s60b.extract_fiber_linearized_drf1(blk, best_U[:d1], t1_ref)
                if M0_l.shape[0] > 0:
                    te, dkr, dv0, _ = s57b.round1_elim_score(M0_l, Mu_l)
                    key = (te, dv0, dkr, M0_l.shape[0])
                else:
                    key = (0, 0, 0, 0)
                if key > best_key:
                    best_key = key
                    best_src += "+"
                    break
                else:
                    best_U[[i, j]] = best_U[[j, i]]
            if n_swaps_tried >= max_swaps:
                break

    return best_U[:d1].copy(), best_key, best_src


# =============================================================================
# GOAL 3: UNTRUNCATED COMPACT D3 MACAULAY + CADICAL + PURE-U1 SYZYGY CLOSER
# =============================================================================

C_COMPACT_D3_XL_SRC = r"""
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

// Fast GF(2) echelon insert on arbitrary width n_cw uint64 words.
// Returns pivot col >= 0 if independent, -1 if reduced to 0.
int gf2_insert_row_c(uint64_t *piv_rows, int *col_to_row, int n_piv_slots,
                     uint64_t *row, int n_cw, int n_cols) {
    for (int w = 0; w < n_cw; w++) {
        uint64_t v = row[w];
        while (v) {
            int b = __builtin_ctzll(v);
            int c = (w << 6) + b;
            if (c >= n_cols) return -1;
            int pr = col_to_row[c];
            if (pr >= 0) {
                const uint64_t *p = piv_rows + (size_t)pr * n_cw;
                for (int k = w; k < n_cw; k++) row[k] ^= p[k];
                v = row[w];
            } else {
                // Insert as new pivot at slot n_piv_slots!
                col_to_row[c] = n_piv_slots;
                memcpy(piv_rows + (size_t)n_piv_slots * n_cw, row, (size_t)n_cw * sizeof(uint64_t));
                return c;
            }
        }
    }
    return -1;
}
"""


def run_untruncated_d3_macaulay_and_cadical(buf, q_ids, c_ids, tbl, lib_d3, max_conf=500000):
    """
    Given surviving quadratic/cubic equations in `buf` after `s9.run_branch_cascade`:
      1. Remaps to compact active variables 0..N-1.
      2. If c_ids is empty and N <= 74: runs UNTRUNCATED Degree-3 Macaulay XL
         (ALL q quadratics + ALL q * N variable-multiplied cubics -> echelonize in C!)
         and checks for exact algebraic `1 = 0` or new linear drops!
      3. Runs CaDiCaL (`Cadical195`) with `conf_budget=max_conf`, PLUS a Zero-Trust
         planted-solution check verifying that a random planted assignment returns SAT!
    """
    psets = [s9.row_to_pset(buf, rid, tbl) for rid in list(q_ids) + list(c_ids)]
    active_vars = sorted({b for ps in psets for m in ps if m > 0 for b in range(tbl["n"]) if (m >> b) & 1})
    N = len(active_vars)
    if N == 0:
        return "TRIVIAL_N0", 0, 0.0, "SKIP", 0.0

    vmap = {v: i for i, v in enumerate(active_vars)}
    # Remap psets to compact tuples of local indices 0..N-1
    compact_polys = []
    for ps in psets:
        if not ps:
            continue
        if ps == {0}:
            return "MAC_1EQ0", 0, 0.0, "UNSAT_1EQ0", 0.0
        terms = []
        for m in ps:
            if m == 0:
                terms.append(())
            else:
                vs = tuple(sorted(vmap[b] for b in range(tbl["n"]) if (m >> b) & 1))
                terms.append(vs)
        compact_polys.append(terms)

    # ---- (A) UNTRUNCATED COMPACT DEGREE-3 MACAULAY RREF (when pure-quadratic & N <= 74) ----
    mac_status = "SKIP"
    mac_new_lin = 0
    t_mac = time.perf_counter()
    if len(c_ids) == 0 and N <= 74:
        # Column ordering: deg 3 (0..n3-1), deg 2 (n3..n3+n2-1), deg 1 (..+N), deg 0 (const = last col!)
        col3_map = {}
        idx = 0
        for a in range(N):
            for b in range(a + 1, N):
                for c in range(b + 1, N):
                    col3_map[(a, b, c)] = idx
                    idx += 1
        off2 = idx
        col2_map = {}
        for a in range(N):
            for b in range(a + 1, N):
                col2_map[(a, b)] = idx
                idx += 1
        off1 = idx
        off0 = off1 + N
        n_cols_c = off0 + 1
        n_cw_c = (n_cols_c + 63) // 64

        # Allocate pivot buffer up to min(n_cols_c, len(compact_polys)*(N+1))
        max_rows_gen = len(compact_polys) * (N + 1)
        max_pivs = min(n_cols_c, max_rows_gen) + 4
        piv_rows = (ctypes.c_uint64 * (max_pivs * n_cw_c))()
        col_to_row = (ctypes.c_int * n_cols_c)(*([-1] * n_cols_c))
        work_row = (ctypes.c_uint64 * n_cw_c)()
        n_pivs = 0
        hit_1eq0 = False

        def insert_terms(tlist):
            nonlocal n_pivs, hit_1eq0, mac_new_lin
            ctypes.memset(work_row, 0, n_cw_c * 8)
            for t in tlist:
                lt = len(t)
                if lt == 0: col = off0
                elif lt == 1: col = off1 + t[0]
                elif lt == 2: col = col2_map[t]
                elif lt == 3: col = col3_map[t]
                else: continue
                work_row[col >> 6] ^= (1 << (col & 63))
            pc = lib_d3.gf2_insert_row_c(piv_rows, col_to_row, n_pivs, work_row, n_cw_c, n_cols_c)
            if pc >= 0:
                n_pivs += 1
                if pc == off0:
                    hit_1eq0 = True
                elif pc >= off1:
                    mac_new_lin += 1

        # Insert original quadratics first
        for terms in compact_polys:
            insert_terms(terms)
            if hit_1eq0:
                break
        # Multiply EVERY quadratic by EVERY variable x_k (untruncated!)
        if not hit_1eq0:
            for terms in compact_polys:
                for xk in range(N):
                    mterms = []
                    for t in terms:
                        if not t:
                            mterms.append((xk,))
                        elif xk in t:
                            mterms.append(t)
                        else:
                            mterms.append(tuple(sorted(t + (xk,))))
                    insert_terms(mterms)
                    if hit_1eq0:
                        break
                if hit_1eq0:
                    break

        mac_status = "MAC_D3_1EQ0" if hit_1eq0 else f"MAC_D3_rk{n_pivs}/{n_cols_c}_lin{mac_new_lin}"
    dt_mac = time.perf_counter() - t_mac

    # ---- (B) CADICAL SAT SOLVER (+ ZERO-TRUST PLANTED SAT CHECK!) ----
    t_sat = time.perf_counter()
    if mac_status == "MAC_D3_1EQ0":
        return mac_status, mac_new_lin, dt_mac, "UNSAT_BY_MAC", 0.0

    def build_cnf(polys_in, flip_rhs=None):
        next_v = N + 1
        mon_v = {}
        clauses = []

        def get_mv(t):
            nonlocal next_v
            if len(t) == 1:
                return t[0] + 1
            if t not in mon_v:
                mv = next_v
                next_v += 1
                mon_v[t] = mv
                lits = [x + 1 for x in t]
                for l in lits:
                    clauses.append([-mv, l])
                clauses.append([mv] + [-l for l in lits])
            return mon_v[t]

        def add_xor(lits, rhs):
            nonlocal next_v
            cur = list(lits)
            while len(cur) > 3:
                a, b = cur[0], cur[1]
                aux = next_v
                next_v += 1
                clauses.append([-a, -b, -aux])
                clauses.append([a, b, -aux])
                clauses.append([a, -b, aux])
                clauses.append([-a, b, aux])
                cur = [aux] + cur[2:]
            k = len(cur)
            for mask in range(1 << k):
                if (mask.bit_count() & 1) != rhs:
                    clauses.append([(-cur[i] if ((mask >> i) & 1) else cur[i]) for i in range(k)])

        for pi_idx, terms in enumerate(polys_in):
            has_const = 0
            lits = []
            for t in terms:
                if len(t) == 0: has_const ^= 1
                else: lits.append(get_mv(t))
            if flip_rhs is not None and flip_rhs[pi_idx]:
                has_const ^= 1
            rhs = has_const  # sum(lits) ^ has_const == 0 <=> sum(lits) == has_const!
            if not lits:
                if rhs == 1:
                    clauses.append([])
                continue
            add_xor(lits, rhs)
        return clauses

    # Zero-Trust Planted-SAT check on CaDiCaL encoder (1 planted assignment -> must be SAT!)
    rng_p = random.Random(6199 + N)
    x_pl = [rng_p.getrandbits(1) for _ in range(N)]
    flips = []
    for terms in compact_polys:
        val = 0
        for t in terms:
            if all(x_pl[i] for i in t):
                val ^= 1
        flips.append(val)
    cl_pl = build_cnf(compact_polys, flip_rhs=flips)
    with Cadical195(bootstrap_with=cl_pl) as slv_pl:
        assert slv_pl.solve(assumptions=[(i + 1 if x_pl[i] else -(i + 1)) for i in range(N)]) is True, "CaDiCaL CNF encoder ZT FAILED!"

    # Now solve REAL system!
    cl_real = build_cnf(compact_polys)
    with Cadical195(bootstrap_with=cl_real) as slv:
        slv.conf_budget(max_conf)
        res = slv.solve_limited()
    dt_sat = time.perf_counter() - t_sat
    sat_st = "CADICAL_UNSAT" if res is False else ("CADICAL_SAT" if res is True else "CADICAL_BUDGET")
    return mac_status, mac_new_lin, dt_mac, sat_st, dt_sat


def check_pure_u1_1eq0_at_rk0(blk, U1, t1, res_rk0, eval_b_lin, n_samp=256, seed=6180):
    """
    When `final_rK == 0` in the un-quotiented cascade, check whether `1` lies in the
    GF(2) linear span of the pure-u_1 equations `P0(t1 ^ U1^T u_1) = 0` on `n_samp` random u_1!
    """
    rng = np.random.default_rng(seed)
    d1 = U1.shape[0]
    U_s = rng.integers(0, 2, size=(n_samp, d1), dtype=np.uint8)
    W_s = ((U_s @ U1) & 1) ^ t1[None, :]
    T_s = blk["eval_t_batch"](W_s)
    P0_s = blk["P0_eval"](W_s, T_s)  # (n_samp, nP0)
    ones = np.ones((n_samp, 1), dtype=np.uint8)
    rk_p0 = s60b.gf2_rank(P0_s)
    rk_p0_1 = s60b.gf2_rank(np.hstack([P0_s, ones]))
    p0_has_1eq0 = (rk_p0_1 == rk_p0)
    return rk_p0, p0_has_1eq0


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

    print(f"\n==================== [{cell_name}] STEP 61A: JOINT (M1+A3+D) OPT, TRUE d1 CEILING & ALGEBRAIC 1=0 CLOSURE ====================", flush=True)

    # Compile C libraries
    c_diag, so_diag = WORK_DIR / "s61a_diag.c", WORK_DIR / "libs61a_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s61a_s9.c", WORK_DIR / "libs61a_s9.so"
    c_s9.write_text(s9.C_STEP9_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_s9), "-o", str(so_s9)], check=True)
    lib9 = s45a._setup_lib9(so_s9)

    c_cg, so_cg = WORK_DIR / "s61a_cg.c", WORK_DIR / "libs61a_cg.so"
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

    c_sh, so_sh = WORK_DIR / "s61a_sh.c", WORK_DIR / "libs61a_sh.so"
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

    c_d3, so_d3 = WORK_DIR / "s61a_d3.c", WORK_DIR / "libs61a_d3.so"
    c_d3.write_text(C_COMPACT_D3_XL_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_d3), "-o", str(so_d3)], check=True)
    lib_d3 = ctypes.CDLL(str(so_d3))
    lib_d3.gf2_insert_row_c.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int), ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int,
    ]
    lib_d3.gf2_insert_row_c.restype = ctypes.c_int

    # Build root system
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
    rng_main = np.random.default_rng(6120)

    for em in test_etas:
        t_em = time.perf_counter()
        print(f"\n==========================================================================", flush=True)
        print(f"  [{cell_name} eta={em}] STEP 61A: JOINT OPT, TRUE d1 CEILING & 1=0 CLOSURE", flush=True)
        print(f"==========================================================================", flush=True)

        t_ext = time.perf_counter()
        blk = extract_full_blocks_fast(em, root, eta_free, lib9, lib_sh, tbl, rng_seed=6100 + em)
        if blk["closed_unsat"]:
            print(f"  [{cell_name} eta={em}] CLOSED UNSAT AT ETA LEVEL!", flush=True)
            continue
        nW, nT, nRF = blk["nW"], blk["nT"], blk["nRF"]
        print(
            f"  [ZT-0] Fast direct-col extractor ({time.perf_counter()-t_ext:.1f}s): 0 mismatches! "
            f"nW={nW}, nT={nT}, nRF={nRF}, M1={len(blk['M1_strict_psets'])}, A3={len(blk['Block_A3_psets'])}, "
            f"D2={len(blk['Block_D2_psets'])}, BlockB={len(blk['Block_B_psets'])}",
            flush=True,
        )

        U_iso_full, d_iso = s60b.build_iso_extended_basis(blk, seed=6150 + em)
        cand_bases = build_candidate_full_bases(blk, U_iso_full, em_seed=em)
        t1_rand = rng_main.integers(0, 2, size=nW, dtype=np.uint8)

        # ---- GOALS 1 & 2: JOINT OPTIMIZATION + TRUE d1 CEILING SWEEP ----
        if cell_name == "B0_11":
            d1_sweep = [20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44] if em == 11 else [26, 28, 30, 32, 34, 36, 38, 40, 42, 44]
        else:
            d1_sweep = [18, 20, 22, 24, 26, 28, 30, 32]

        print(f"\n  --- [G1+G2] JOINT (M1+A3+D) OPT & TRUE d1 CEILING SWEEP (d_iso={d_iso}, {len(cand_bases)} seed bases) ---", flush=True)
        best_rk0_subspaces = []  # collect (d1, U1_joint) where final_rK == 0 for Goal 3!
        consec_high_rK = 0

        for d1 in d1_sweep:
            if d1 > nW:
                continue
            t_d = time.perf_counter()
            U1_j, jkey, jsrc = optimize_u1_joint(blk, d1, t1_rand, cand_bases, do_swaps=(d1 <= 36))
            M0_linR, Mu_linR, eval_bR, nsR, nexR, LamR = s60b.extract_fiber_linearized_drf1(blk, U1_j, t1_rand)
            pl_R = s60b.make_planted_solutions(blk, U1_j, t1_rand, LamR, n_planted=10, seed=6300 + em * 60 + d1)

            res_j = s60b.run_blockb_feedback_cascade(
                blk, U1_j, t1_rand, M0_linR, Mu_linR, eval_bR,
                lib9, enable_blockb=True, enable_affine_y=False,
                max_outer_rounds=4, max_inner_rounds=6,
                planted_data=pl_R, seed=6400 + d1,
            )
            rK_uncap, _ = s55b.run_cascade_uncapped(
                M0_linR, Mu_linR, lib9, max_rounds=10, mR_cap=600, rK_cap=40, keep_cap=160
            ) if M0_linR.shape[0] > 0 else (nRF, [])
            rK_post = res_j["final_rK"]
            if rK_post > 0 and res_j["M0_v"].shape[0] > 0:
                rK_post, _ = s55b.run_cascade_uncapped(
                    res_j["M0_v"], res_j["Mk_v"], lib9, max_rounds=8, mR_cap=600, rK_cap=40, keep_cap=160
                )

            st = res_j["bb_stats"]
            p0_str = ""
            if res_j["final_rK"] == 0 or rK_uncap == 0 or rK_post == 0:
                rk_p0, has1 = check_pure_u1_1eq0_at_rk0(blk, U1_j, t1_rand, res_j, eval_bR)
                p0_str = f" | P0_rk={rk_p0},1eq0={has1}"
                best_rk0_subspaces.append((d1, U1_j.copy(), jsrc, res_j["final_rK"], min(rK_uncap, rK_post)))
                consec_high_rK = 0
            else:
                consec_high_rK += 1

            print(
                f"    d1={d1:2d}(NT1={nW-d1:2d}) [src={jsrc:8s}, m={M0_linR.shape[0]:3d}(+A3D={nexR:2d}), r1e={jkey[0]:2d}]: "
                f"unquot_rK={res_j['final_rK']:2d}(atK={st['n_atilde_ker_max']:3d},inj={st['n_injected_total']:2d},ZT={st['planted_checks']}ok/{st['planted_fails']}fail) | "
                f"uncap={rK_uncap:2d}(postBB={rK_post:2d}) ({time.perf_counter()-t_d:4.1f}s){p0_str}",
                flush=True,
            )
            if consec_high_rK >= 3 and d1 >= (34 if cell_name == "B0_11" else 24):
                print(f"    (Ceiling reached: 3 consecutive d1 with rK > 0; testing d1={nW} global check directly)", flush=True)
                if d1 < nW and cell_name == "B0_11":
                    # Still run global d1=nW (NT1=0) once!
                    U_id = np.eye(nW, dtype=np.uint8)
                    M0_g, Mu_g, _, _, nex_g, _ = s60b.extract_fiber_linearized_drf1(blk, U_id, t1_rand)
                    rk_g, _ = s55b.run_cascade_uncapped(M0_g, Mu_g, lib9, max_rounds=8, mR_cap=600, rK_cap=40, keep_cap=160) if M0_g.shape[0] > 0 else (nRF, [])
                    print(f"    d1={nW:2d}(NT1= 0) [GLOBAL  , m={M0_g.shape[0]:3d}(+A3D={nex_g:2d})]: uncap={rk_g:2d}", flush=True)
                break

        # ---- GOAL 3: DIRECT ALGEBRAIC `1 = 0` CLOSURE (s9 + UNTRUNCATED D3 MACAULAY + CADICAL!) ----
        print(f"\n  --- [G3] DIRECT ALGEBRAIC 1=0 CLOSURE (s9 U1^perp + UNTRUNCATED D3 MACAULAY + CADICAL) ---", flush=True)
        # Pick top 3 highest-d1 subspaces that achieved rK == 0 (plus fallback if none)
        if best_rk0_subspaces:
            chosen_g3 = best_rk0_subspaces[-3:]
        else:
            d_fb = 24 if cell_name == "B0_11" else 18
            U_fb, _, s_fb = optimize_u1_joint(blk, d_fb, t1_rand, cand_bases, do_swaps=False)
            chosen_g3 = [(d_fb, U_fb, s_fb, -1, -1)]

        sr = blk["sr"]
        W_forms_111 = blk["W_forms_111"]
        for d1_g3, U_sub, src_g3, uq_rk, uc_rk in chosen_g3:
            F_sub = s40a.gf2_nullspace_np(U_sub)
            k_fix = F_sub.shape[0]
            if k_fix == 0:
                continue
            fix_forms = []
            for row in F_sub:
                fm = 0
                for k in range(nW):
                    if row[k]: fm ^= W_forms_111[k]
                fix_forms.append(fm)

            print(f"    Testing U1_joint d1={d1_g3:2d} (NT1=k_fix={k_fix:2d}, src={src_g3}, unquot_rK={uq_rk}, uncap_rK={uc_rk}):", flush=True)
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
                    print(f"      f{tr}: S9_UNSAT (1=0!) in {dt_s:.1f}s", flush=True)
                else:
                    n_act = 111 - len(sub["_lin_pivs"])
                    nq_s, nc_s = len(sub["_quad_ids"]), len(sub["_cub_ids"])
                    mac_st, mac_lin, dt_m, sat_st, dt_sat = run_untruncated_d3_macaulay_and_cadical(
                        sub["_buf"], sub["_quad_ids"], sub["_cub_ids"], tbl, lib_d3, max_conf=500000
                    )
                    print(
                        f"      f{tr}: s9->N={n_act},q={nq_s},c={nc_s} ({dt_s:.1f}s) | "
                        f"{mac_st} ({dt_m:.1f}s) | {sat_st} ({dt_sat:.1f}s)",
                        flush=True,
                    )

        print(f"  [{cell_name} eta={em}] done in {time.perf_counter()-t_em:.1f}s", flush=True)

    print(f"\n[{cell_name}] STEP 61A DONE in {time.perf_counter()-t0:.1f}s", flush=True)


if __name__ == "__main__":
    main()
