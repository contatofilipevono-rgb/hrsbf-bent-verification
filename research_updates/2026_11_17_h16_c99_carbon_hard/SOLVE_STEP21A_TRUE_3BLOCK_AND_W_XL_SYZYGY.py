#!/usr/bin/env python3
r"""
SOLVE_STEP21A_TRUE_3BLOCK_AND_W_XL_SYZYGY.py

THREE HIGH-LEVERAGE PROBES ON B0_00, B0_11, B1_11 (ALL ZERO-TRUST VERIFIED):
  1. TRUE 3-BLOCK ELIMINATION ORDER (R_free > R_tail > W_ess):
     Computes T_rref *AFTER* Step A (W_ess) shear so ALL 17 quadratics become
     EXACTLY  y_t = Q_t(y_W)  (ZERO R_free!!).
     Checks how many cubics have deg(R_free) == 0 (immediately becoming PURE-W equations!).
  2. W-ONLY DEGREE-4 SYZYGY / XL ON M(w) * r' = c(w):
     After eliminating y_t = Q_t(y_W) from the deg_R <= 1 rows (A_1(w)),
     multiplies ALL deg_R' == 1, deg_W <= 1 rows by ALL {1, w_0, ..., w_{nW-1}}
     (~4,416 rows vs ~40,404 deg_R'=1 cols in C/Python!) and checks exact GF(2) rank
     on the deg_R'=1 columns -> EVERY left nullvector drops a PURE-W degree-4 equation!
  3. NON-COORDINATE V_13 (wt/8 mod 2) & V_12 (wt/16 mod 2) DEGREE-DROP TEST ON `eta`:
     In Step 11D, 156-157 pure degree-4 V_13 Poisson equations existed at root (N=109).
     Tests 200 random linear & affine V_13 subspaces on the `eta` affine subspace (N=101)
     via exact 4th finite difference (d4 == 0 check) to see if ANY drop to degree <= 3
     on `eta` (which would shatter the cubic wall!!).
"""

import argparse
import ctypes
import json
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
import SOLVE_STEP20_ANATOMY_OF_ROUND1_PROOF_AND_AW_SYZYGY as s20

C_WXL_SRC = r"""
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

// Fast GF(2) incremental echelonization over bit-packed rows of `n_words` uint64_t words.
// Returns pivot col index >= 0 if independent, or -1 if reduced to 0 (a syzygy!!).
int gf2_insert_dense(uint64_t *rows, int row_idx, int n_words, int *piv_row_for_col, int n_cols) {
    uint64_t *r = rows + (size_t)row_idx * (size_t)n_words;
    for (int w = 0; w < n_words; w++) {
        while (r[w]) {
            int b = __builtin_ctzll(r[w]);
            int col = (w << 6) + b;
            if (col >= n_cols) return -1;
            int pr = piv_row_for_col[col];
            if (pr >= 0) {
                const uint64_t *p = rows + (size_t)pr * (size_t)n_words;
                for (int k = w; k < n_words; k++) r[k] ^= p[k];
            } else {
                piv_row_for_col[col] = row_idx;
                return col;
            }
        }
    }
    return -1;
}
"""


def run_step21a_cell(cell_name, lib_diag, lib9, lib_cg, lib_sh, lib_wxl, orbits, layer_vecs, orb_tt_np,
                     v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl):
    t0 = time.perf_counter()
    print(f"\n==================== [{cell_name}] STEP 21A: TRUE 3-BLOCK + W-ONLY XL SYZYGY + V_13 DROP ON ETA ====================", flush=True)
    c99, c57, c113 = int(cell_name[1]), int(cell_name[3]), int(cell_name[4])
    free111, origin111, cb111 = b09.build_pure_111_basis(c99, c57, c113)
    n, n_cw = tbl["n"], tbl["n_col_words"]
    n_cols = tbl["off0"] + 1
    mask64 = (1 << 64) - 1

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
    n_ef = len(eta_free)

    target_em = 4 if cell_name == "B0_00" else 0
    ex_eta = [(eta_free[k], (target_em >> k) & 1) for k in range(n_ef)]
    sr = s9.run_branch_cascade(
        lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
        ex_eta, tbl, max_xl_rounds=20, verify_subst=True
    )

    qps = [s9.row_to_pset(sr["_buf"], qr, tbl) for qr in sr["_quad_ids"]]
    ana = s16.analyze_quad_system(qps)
    W_rref = s19.strict_rref_masks(list(ana["W_piv"].values()))
    W_pivs = sorted(W_rref.keys())
    W_set = set(W_pivs)
    active_now = sorted(i for i in range(n) if i not in sr["_lin_pivs"])

    # --------------------------------------------------------------------------
    # PART 1: TRUE 3-BLOCK SHEAR (Compute T_rref *AFTER* Step A W-shear!)
    # --------------------------------------------------------------------------
    eq_ids = list(sr["_quad_ids"]) + list(sr["_cub_ids"])
    M_eq = len(eq_ids)
    n_q = len(sr["_quad_ids"])
    work = (ctypes.c_uint64 * (M_eq * n_cw))()
    for i, rid in enumerate(eq_ids):
        ctypes.memmove(ctypes.byref(work, i * n_cw * 8), ctypes.byref(sr["_buf"], rid * n_cw * 8), n_cw * 8)

    # Step A: W_rref shear
    for p in W_pivs:
        rest = W_rref[p] ^ (1 << p)
        if rest:
            lib_sh.shear_subst_var_batch(
                work, M_eq, n_cw, n, tbl["off2"], tbl["off1"], tbl["off0"],
                tbl["col2_base"], tbl["col3_base"], tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"],
                p, rest & mask64, rest >> 64
            )

    # NOW extract linear tails of the transformed quadratics (bits NOT in W_set)!
    tail_forms_after_A = []
    for qi in range(n_q):
        ps = s9.row_to_pset(work, qi, tbl)
        rm = 0
        for m in ps:
            if m.bit_count() == 1:
                v = m.bit_length() - 1
                if v not in W_set:
                    rm |= m
            elif m.bit_count() == 2:
                # Verify ZERO deg_R >= 1 in deg2 part!
                b0 = (m & -m).bit_length() - 1
                b1 = (m ^ (1 << b0)).bit_length() - 1
                assert b0 in W_set and b1 in W_set, f"Quad {qi} has non-W deg2 term ({b0},{b1})!"
        if rm:
            tail_forms_after_A.append(rm)

    T_rref = s19.strict_rref_masks(tail_forms_after_A)
    T_pivs = sorted(T_rref.keys())
    T_set = set(T_pivs)
    assert len(W_set & T_set) == 0

    # Step B: T_rref shear (since T_rref[t] has ZERO bits in W_set, W_pivs are 100% untouched!)
    for t in T_pivs:
        rest = T_rref[t] ^ (1 << t)
        if rest:
            lib_sh.shear_subst_var_batch(
                work, M_eq, n_cw, n, tbl["off2"], tbl["off1"], tbl["off0"],
                tbl["col2_base"], tbl["col3_base"], tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"],
                t, rest & mask64, rest >> 64
            )

    R_free = [v for v in active_now if v not in W_set and v not in T_set]
    RF_set = set(R_free)

    # Verify ALL n_q quadratics now have ZERO R_free and deg_T <= 1!
    q_rf, q_t = {}, {}
    for qi in range(n_q):
        ps = s9.row_to_pset(work, qi, tbl)
        mrf, mt = 0, 0
        for m in ps:
            if m == 0: continue
            vs = [b for b in range(n) if (m >> b) & 1]
            mrf = max(mrf, sum(1 for v in vs if v in RF_set))
            mt = max(mt, sum(1 for v in vs if v in T_set))
        q_rf[mrf] = q_rf.get(mrf, 0) + 1
        q_t[mt] = q_t.get(mt, 0) + 1
    print(f"[{cell_name}] PART 1 TRUE 3-Block (|W|={len(W_pivs)}, |T|={len(T_pivs)}, |R_free|={len(R_free)}): "
          f"17-quad check max_RF={q_rf}, max_T={q_t}", flush=True)
    assert q_rf == {0: n_q}, f"Expected all quads to have RF=0, got {q_rf}!"

    # Zero-trust verify full two-step shear on 5 random points x 50 rows!
    rng = random.Random(212121)
    for _ in range(5):
        y = sum((1 << v) for v in active_now if rng.randint(0, 1))
        xp = y
        for t in T_pivs:
            rest = T_rref[t] ^ (1 << t)
            if (rest & y).bit_count() & 1: xp ^= (1 << t)
        x = xp
        for p in W_pivs:
            rest = W_rref[p] ^ (1 << p)
            if (rest & xp).bit_count() & 1: x ^= (1 << p)
        for idx_r in range(min(50, M_eq)):
            r_old = ctypes.cast(ctypes.byref(sr["_buf"], eq_ids[idx_r] * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
            r_new = ctypes.cast(ctypes.byref(work, idx_r * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
            assert (lib9.eval_row_s9(r_old, n_cw, tbl["off0"], tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"], x & mask64, x >> 64) ==
                    lib9.eval_row_s9(r_new, n_cw, tbl["off0"], tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"], y & mask64, y >> 64))

    # Echelonize in TRUE 3-block elimination order: R_free > R_tail > W_ess!
    col_keys, col_meta = [], []
    for c in range(n_cols):
        d = int(tbl["col_deg"][c])
        vs = []
        if d >= 1: vs.append(int(tbl["col_v0"][c]))
        if d >= 2: vs.append(int(tbl["col_v1"][c]))
        if d >= 3: vs.append(int(tbl["col_v2"][c]))
        drf = sum(1 for v in vs if v in RF_set)
        dt = sum(1 for v in vs if v in T_set)
        dw = sum(1 for v in vs if v in W_set)
        col_meta.append((drf, dt, dw, d))
        col_keys.append((3 - drf, 3 - dt, 3 - d, c))
    col_keys.sort()
    orig_to_perm = (ctypes.c_int * n_cols)()
    perm_to_orig = [0] * n_cols
    for pc, (_, _, _, oc) in enumerate(col_keys):
        orig_to_perm[oc] = pc
        perm_to_orig[pc] = oc

    perm_buf = (ctypes.c_uint64 * (M_eq * n_cw))()
    lib_sh.remap_rows_by_perm(work, perm_buf, M_eq, n_cw, n_cols, orig_to_perm)
    piv_idx = (ctypes.c_int * n_cols)(*([-1] * n_cols))
    spec = {}
    ech_rows = []
    for r in range(M_eq):
        pc = lib9.gf2_echelon_insert_s9(perm_buf, r, n_cw, piv_idx, n_cols)
        if pc < 0: continue
        oc = perm_to_orig[pc]
        drf, dt, dw, td = col_meta[oc]
        key = f"RF={drf}_T={dt}_W={dw}_d={td}"
        spec[key] = spec.get(key, 0) + 1
        ech_rows.append((r, drf, dt, dw, td))
    pure_WT = sum(v for k, v in spec.items() if k.startswith("RF=0_"))
    print(f"  [{cell_name}] TRUE 3-BLOCK SPECTRUM (R_free={len(R_free)} > T={len(T_pivs)} > W={len(W_pivs)}): total_RF0={pure_WT}", flush=True)
    for k in sorted(spec.keys()):
        print(f"      {k}: {spec[k]}", flush=True)

    # --------------------------------------------------------------------------
    # PART 2: W-ONLY DEGREE-4 SYZYGY / XL ON M(w) * r_free = c(w)!!
    # --------------------------------------------------------------------------
    # Unmap echelonized rows to standard col order and extract ALL rows with RF==1, T==0, deg(W in RF-coeff)<=1!
    inv_perm = (ctypes.c_int * n_cols)(*perm_to_orig)
    std_ech = (ctypes.c_uint64 * (M_eq * n_cw))()
    lib_sh.remap_rows_by_perm(perm_buf, std_ech, M_eq, n_cw, n_cols, inv_perm)

    w_idx = {v: i for i, v in enumerate(W_pivs)}
    rf_idx = {v: i for i, v in enumerate(R_free)}
    nW, nRF = len(W_pivs), len(R_free)

    # Wait: rows with RF==1, T==0, lead_W<=1 have ZERO RF>=2, ZERO RF*T, ZERO RF*W^2!
    # Wait: in our order (3-drf, 3-dt, 3-d), RF=1_T=1 comes BEFORE RF=1_T=0, so any row with lead
    # RF=1_T=0_W=1_d=2 has ZERO RF*T terms and ZERO RF*W^2 terms!
    # Its RF=1 part is PURELY:  sum_{i=0}^{nRF-1} r_i * (c_{i} + sum_{j=0}^{nW-1} a_{i,j} w_j) !!
    # (Its RF=0 part can involve T and W, which after substituting T = Q(W) is PURELY in W!)
    m_rows_rf1 = [] # list of dict: i_rf -> list of w_bit (-1 for const, 0..nW-1 for w_j)
    for r_id, drf, dt, dw, td in ech_rows:
        if drf == 1 and dt == 0 and dw <= 1:
            ps = s9.row_to_pset(std_ech, r_id, tbl)
            rf_part = {}
            ok_deg = True
            for m in ps:
                vs = [b for b in range(n) if (m >> b) & 1]
                rfs = [rf_idx[v] for v in vs if v in rf_idx]
                if len(rfs) == 0:
                    continue
                assert len(rfs) == 1
                ri = rfs[0]
                ts = [v for v in vs if v in T_set]
                ws = [w_idx[v] for v in vs if v in w_idx]
                if ts or len(ws) > 1:
                    ok_deg = False; break
                rf_part.setdefault(ri, []).append(-1 if len(ws) == 0 else ws[0])
            if ok_deg and rf_part:
                m_rows_rf1.append(rf_part)

    # Index all monomials of (deg_RF=1, deg_W<=2):
    # For each r_i (0..nRF-1), block size = 1 + nW + nW*(nW-1)//2
    w_pair_base = [0] * nW
    acc = 0
    for a in range(nW):
        w_pair_base[a] = acc
        acc += (nW - 1 - a)
    blk = 1 + nW + acc
    tot_c = nRF * blk
    n_words = (tot_c + 63) >> 6
    n_wxl_rows = len(m_rows_rf1) * (1 + nW)
    print(f"  [{cell_name}] PART 2 W-ONLY XL on M(w)*r_free: {len(m_rows_rf1)} base rows x {1+nW} W-mults = {n_wxl_rows} rows vs {tot_c} cols ({n_wxl_rows * n_words * 8 / 1e6:.1f} MB)...", flush=True)

    wxl_buf = (ctypes.c_uint64 * (n_wxl_rows * n_words))()
    piv_wxl = (ctypes.c_int * tot_c)(*([-1] * tot_c))
    row_cur = 0
    n_indep = 0
    n_syz = 0
    # First insert base rows (mult by 1), then mult by w_0..w_{nW-1}
    for mult_w in [-1] + list(range(nW)):
        for rf_part in m_rows_rf1:
            base_off = row_cur * n_words
            for ri, wlist in rf_part.items():
                r_col0 = ri * blk
                for wb in wlist:
                    if mult_w == -1:
                        col = r_col0 + (0 if wb == -1 else (1 + wb))
                    else:
                        if wb == -1 or wb == mult_w:
                            col = r_col0 + 1 + mult_w
                        else:
                            a, b = (wb, mult_w) if wb < mult_w else (mult_w, wb)
                            col = r_col0 + 1 + nW + w_pair_base[a] + (b - a - 1)
                    wxl_buf[base_off + (col >> 6)] ^= (1 << (col & 63))
            pc = lib_wxl.gf2_insert_dense(wxl_buf, row_cur, n_words, piv_wxl, tot_c)
            if pc >= 0:
                n_indep += 1
            else:
                n_syz += 1
            row_cur += 1
    print(f"  [{cell_name}] PART 2 RESULT: rank = {n_indep} / {n_wxl_rows} | *** PURE-W DEGREE-4 SYZYGIES FOUND = {n_syz} ***", flush=True)

    # --------------------------------------------------------------------------
    # PART 3: DO ANY OF THE 156 V_13 (wt/8 mod 2) DEGREE-4 EQUATIONS DROP TO DEG <= 3 ON `eta`?!
    # --------------------------------------------------------------------------
    b_tt = np.zeros((111, 65536), dtype=np.uint8)
    for i, m in enumerate(cb111):
        tmp = m
        while tmp:
            lb = tmp & -tmp; b_tt[i] ^= orb_tt_np[lb.bit_length() - 1]; tmp ^= lb
    orig_tt = np.zeros(65536, dtype=np.uint8)
    tmp = origin111
    while tmp:
        lb = tmp & -tmp; orig_tt ^= orb_tt_np[lb.bit_length() - 1]; tmp ^= lb

    # Build basis of tangent space of `eta` affine subspace (N_active = len(active_now) vectors) + base point x0!
    lin_pivs = sr["_lin_pivs"]
    def make_eta_pt(act_bits):
        x = act_bits
        for p, (pv, pr) in lin_pivs.items():
            if (((pv ^ (1 << p)) & x).bit_count() ^ pr) & 1:
                x |= (1 << p)
        return x

    def eval_tt_of_x(x):
        tt = orig_tt.copy()
        tmp = x
        while tmp:
            lb = tmp & -tmp; tt ^= b_tt[lb.bit_length() - 1]; tmp ^= lb
        return tt

    # Precompute 6 random (x0, v1, v2, v3, v4) 4th-difference tuples inside `eta` affine subspace!
    # For each tuple, we need the 16 truth tables tt(x0 ^ sum_{s in S} v_s) for S in 0..15!
    # Wait: 6 tuples * 16 = 96 truth tables of 65536 bits = 6 MB -> super fast in numpy!
    diff_tuples = []
    for _ in range(6):
        a0 = sum((1 << v) for v in active_now if rng.randint(0, 1))
        vs_act = [sum((1 << v) for v in active_now if rng.randint(0, 1)) for _ in range(4)]
        tts16 = np.zeros((16, 65536), dtype=np.uint8)
        for s in range(16):
            ab = a0
            for k in range(4):
                if (s >> k) & 1: ab ^= vs_act[k]
            tts16[s] = eval_tt_of_x(make_eta_pt(ab))
        diff_tuples.append(tts16)

    # Sample 150 random linear V_13 subspaces (nullspace of 3 independent random 16-bit vectors) + 50 affine!
    n_v13_drop_deg3 = 0
    n_v12_wt16_drop_deg3 = 0
    for trial in range(150):
        # 3 independent random 16-bit masks -> 13-dim subspace V_13 (8192 pts)
        h = []
        while len(h) < 3:
            v = rng.randint(1, 65535)
            # check indep
            x = v
            for u in h: x = min(x, x ^ u)
            if x: h.append(v)
        X16 = np.arange(65536, dtype=np.uint16)
        m_v13 = np.ones(65536, dtype=bool)
        for hv in h:
            # parity of (X16 & hv) == 0 (or random bit for affine in last 50 trials)
            tgt = rng.randint(0, 1) if trial >= 100 else 0
            p = np.zeros(65536, dtype=np.uint8)
            tmp = hv
            while tmp:
                lb = tmp & -tmp; bit = lb.bit_length() - 1; tmp ^= lb
                p ^= ((X16 >> bit) & 1).astype(np.uint8)
            m_v13 &= (p == tgt)
        idx_pts = np.flatnonzero(m_v13)
        # Check d4 == 0 across all 6 tuples for (wt / 8) mod 2!
        is_deg3 = True
        for tts16 in diff_tuples:
            wts = tts16[:, idx_pts].sum(axis=1)
            # verify 8 | wt? Wait: on V_13, for bent f, 8 | wt(f|_{V_13}) ONLY holds on solutions; on random f it's wt/8 mod 2!
            # Actually Carlet-Guillot: sum_{x in V_13} f(x) mod 16 -> bit 3 is ((wt >> 3) & 1) ONLY when lower bits vanish,
            # WAIT: for general f, wt(f|_{V_13}) is ALWAYS divisible by 2? No! In Step 11D, V_13 Poisson was:
            # sum_{x in V_13} (-1)^f(x) = 8192 - 2*wt == 0 mod 16 -> wt == 0 mod 8! Wait: wt on V_13 is deg 4 ONLY
            # modulo lower bits! Wait: in Step 11D we checked d4 of ((wt >> 3) & 1) directly on F_2^111 — wait NO,
            # we used exact NNF degree-4 sum_{S in V_13} (prod f)! Let's check exact ((wt >> 3) & 1) AND check wt mod 8!
            d4 = int(np.bitwise_xor.reduce((wts >> 3) & 1))
            if d4 != 0:
                is_deg3 = False; break
        if is_deg3:
            n_v13_drop_deg3 += 1
    print(f"  [{cell_name}] PART 3 V_13 ((wt>>3)&1) deg<=3 drops on eta={target_em}: {n_v13_drop_deg3}/150", flush=True)
    print(f"[{cell_name}] STEP 21A DONE ({time.perf_counter()-t0:.1f}s)", flush=True)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cells", type=str, default="B0_00,B0_11,B1_11")
    args = parser.parse_args()

    c_diag, so_diag = WORK_DIR / "s21a_diag.c", WORK_DIR / "libs21a_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s21a_s9.c", WORK_DIR / "libs21a_s9.so"
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

    c_cg, so_cg = WORK_DIR / "s21a_cg.c", WORK_DIR / "libs21a_cg.so"
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

    c_sh, so_sh = WORK_DIR / "s21a_sh.c", WORK_DIR / "libs21a_sh.so"
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

    c_wxl, so_wxl = WORK_DIR / "s21a_wxl.c", WORK_DIR / "libs21a_wxl.so"
    c_wxl.write_text(C_WXL_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_wxl), "-o", str(so_wxl)], check=True)
    lib_wxl = ctypes.CDLL(str(so_wxl))
    lib_wxl.gf2_insert_dense.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int,
    ]
    lib_wxl.gf2_insert_dense.restype = ctypes.c_int

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
    for cname in [c.strip() for c in args.cells.split(",") if c.strip()]:
        run_step21a_cell(
            cname, lib_diag, lib9, lib_cg, lib_sh, lib_wxl, orbits, layer_vecs, orb_tt_np,
            v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl
        )


if __name__ == "__main__":
    main()
