#!/usr/bin/env python3
r"""
SOLVE_STEP21C_AW_RIGHT_KERNEL_AND_MINRANK.py

PROBES THE DEEP STRUCTURE OF A(w)*r = b(w) ON B0_11 & B1_11:
  1. Right kernel of A(w) and [A_0; A_1(w)] at multiple random w (constant vs w-dependent!).
  2. Exact rank profile of the 96 (B1_11) / 71 (B0_11) bilinear matrices B_k (dim nR x nW)
     in M(w)*r' = c(w), plus column/row space intersection across k!
  3. Full scan of ALL 64 eta-states of B0_11 & B1_11 in 2-block R_all > W_ess order to see
     whether ANY eta-state has pure-W equations, smaller dimW, or more deg_R<=1 rows!
  4. Tests if the `degR=2, degW=0` block (197 rows in B1_11, 164 in B0_11) has a low-dim
     bilinear essential subspace in R (just like the 17 quads had W_ess in W!!)!
     HOLD ON: 197 quadratics in 56 variables R -> what is dim(W_ess_R) of those 197 rows?!
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


def gf2_rank_masks(masks):
    p = {}
    for m in masks:
        x = m
        while x:
            b = x.bit_length() - 1
            if b in p: x ^= p[b]
            else: p[b] = x; break
    return len(p)


def gf2_right_nullspace(row_masks, n_cols):
    """Return basis of right nullspace of K x n_cols binary matrix (given as K ints)."""
    rref = s19.strict_rref_masks(row_masks)
    pivs = set(rref.keys())
    basis = []
    for c in range(n_cols):
        if c in pivs: continue
        vec = 1 << c
        for p, pm in rref.items():
            if (pm >> c) & 1:
                vec |= (1 << p)
        basis.append(vec)
    return basis


def run_step21c_cell(cell_name, lib_diag, lib9, lib_cg, lib_sh, orbits, layer_vecs,
                     v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl):
    t0 = time.perf_counter()
    print(f"\n==================== [{cell_name}] STEP 21C: A(w) RIGHT KERNEL + BILINEAR RANK + DEG_R=2 ANATOMY + ALL-64 ETA ====================", flush=True)
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

    # First: Deep analysis on eta = 0!
    ex_eta = [(eta_free[k], 0) for k in range(n_ef)]
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
    R_vars = [v for v in active_now if v not in W_set]
    R_set = set(R_vars)
    nW, nR = len(W_pivs), len(R_vars)

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

    col_keys, col_meta = [], []
    for c in range(n_cols):
        d = int(tbl["col_deg"][c])
        vs = []
        if d >= 1: vs.append(int(tbl["col_v0"][c]))
        if d >= 2: vs.append(int(tbl["col_v1"][c]))
        if d >= 3: vs.append(int(tbl["col_v2"][c]))
        dr = sum(1 for v in vs if v in R_set)
        dw = sum(1 for v in vs if v in W_set)
        col_meta.append((dr, dw, d))
        col_keys.append((3 - dr, 3 - d, c))
    col_keys.sort()
    orig_to_perm = (ctypes.c_int * n_cols)()
    perm_to_orig = [0] * n_cols
    for pc, (_, _, oc) in enumerate(col_keys):
        orig_to_perm[oc] = pc
        perm_to_orig[pc] = oc

    perm_buf = (ctypes.c_uint64 * (M_eq * n_cw))()
    lib_sh.remap_rows_by_perm(work, perm_buf, M_eq, n_cw, n_cols, orig_to_perm)
    piv_idx = (ctypes.c_int * n_cols)(*([-1] * n_cols))
    ech_meta = []
    for r in range(M_eq):
        pc = lib9.gf2_echelon_insert_s9(perm_buf, r, n_cw, piv_idx, n_cols)
        if pc < 0: continue
        oc = perm_to_orig[pc]
        ech_meta.append((r, col_meta[oc][0], col_meta[oc][1], col_meta[oc][2]))

    inv_perm = (ctypes.c_int * n_cols)(*perm_to_orig)
    std_ech = (ctypes.c_uint64 * (M_eq * n_cw))()
    lib_sh.remap_rows_by_perm(perm_buf, std_ech, M_eq, n_cw, n_cols, inv_perm)

    w_idx = {v: i for i, v in enumerate(W_pivs)}
    r_idx = {v: i for i, v in enumerate(R_vars)}

    # 1. Right kernel of A(w) and [A_0; A_1(w)] across 5 random w!
    linR_polys = []
    degR2_w0_polys = []
    for r_id, dr, dw, td in ech_meta:
        ps = s9.row_to_pset(std_ech, r_id, tbl)
        if dr <= 1:
            by_r = {}
            for m in ps:
                rm, wm = 0, 0
                tmp = m
                while tmp:
                    lb = tmp & -tmp; v = lb.bit_length() - 1; tmp ^= lb
                    if v in r_idx: rm |= (1 << r_idx[v])
                    elif v in w_idx: wm |= (1 << w_idx[v])
                by_r.setdefault(rm, []).append(wm)
            a_deg = max((max(wm.bit_count() for wm in wms) for rm, wms in by_r.items() if rm != 0), default=0)
            linR_polys.append((a_deg, by_r))
        elif dr == 2 and dw == 0:
            degR2_w0_polys.append(ps)

    rng = random.Random(21213)
    def eval_wlist(wms, wv):
        s = 0
        for wm in wms:
            if (wv & wm) == wm: s ^= 1
        return s

    ker_all_sets = []
    ker_01_sets = []
    for t in range(5):
        wv = 0 if t == 0 else rng.getrandbits(nW)
        m_all, m_01 = [], []
        for ad, by_r in linR_polys:
            am = 0
            for rm, wms in by_r.items():
                if rm != 0 and eval_wlist(wms, wv): am |= rm
            m_all.append(am)
            if ad <= 1: m_01.append(am)
        ka = gf2_right_nullspace(m_all, nR)
        k01 = gf2_right_nullspace(m_01, nR)
        ker_all_sets.append(ka)
        ker_01_sets.append(k01)
    # Check if right kernel is CONSTANT (same subspace for all 5 w)!
    same_ka = all(set(k) == set(ker_all_sets[0]) for k in ker_all_sets)
    same_k01 = all(set(k) == set(ker_01_sets[0]) for k in ker_01_sets)
    print(f"[{cell_name}] PART 1 RIGHT KERNEL: dim(ker A(w))={[len(k) for k in ker_all_sets]} (CONSTANT={same_ka}) | "
          f"dim(ker [A_0;A_1])={[len(k) for k in ker_01_sets]} (CONSTANT={same_k01})", flush=True)

    # 2. Exact rank profile of the bilinear matrices B_k (nR x nW) for each degA==1 row!
    b_ranks = []
    b_mats = []
    for ad, by_r in linR_polys:
        if ad != 1: continue
        # B_k[ri] = w-bitmask of degW=1 entries for R-variable ri
        rows_w = []
        for rm, wms in by_r.items():
            if rm == 0: continue
            wmask = 0
            for wm in wms:
                if wm.bit_count() == 1: wmask |= wm
            if wmask: rows_w.append(wmask)
        rk = gf2_rank_masks(rows_w)
        b_ranks.append(rk)
        b_mats.append((by_r, rk))
    rk_hist = {}
    for rk in b_ranks: rk_hist[rk] = rk_hist.get(rk, 0) + 1
    print(f"[{cell_name}] PART 2 Bilinear matrix B_k (nR={nR} x nW={nW}) ranks across {len(b_ranks)} degA=1 rows: {dict(sorted(rk_hist.items()))}", flush=True)

    # Check if ANY random 2-row or 3-row XOR of B_k drops rank dramatically!
    min_pair_rk = 999
    if len(b_mats) >= 2:
        for i in range(min(40, len(b_mats))):
            for j in range(i + 1, min(40, len(b_mats))):
                # compute rank of B_i ^ B_j
                comb = {}
                for by_r in (b_mats[i][0], b_mats[j][0]):
                    for rm, wms in by_r.items():
                        if rm == 0: continue
                        wmask = 0
                        for wm in wms:
                            if wm.bit_count() == 1: wmask |= wm
                        if wmask: comb[rm] = comb.get(rm, 0) ^ wmask
                rk = gf2_rank_masks([v for v in comb.values() if v])
                if rk < min_pair_rk: min_pair_rk = rk
    print(f"      Min rank of pairwise sum B_i ^ B_j (first 40 rows): {min_pair_rk}", flush=True)

    # 3. ANATOMY OF THE `degR=2, degW=0` BLOCK (197 rows in B1_11, 164 in B0_11)!!
    # Extract the pure R-quadratic part (pairs of R-vars) of all degR=2_degW=0 rows and compute
    # its bilinear essential subspace W_ess_R inside F_2^{nR}!!
    r2_qps = []
    for ps in degR2_w0_polys:
        qset = set()
        for m in ps:
            if m.bit_count() == 2:
                b0 = (m & -m).bit_length() - 1
                b1 = (m ^ (1 << b0)).bit_length() - 1
                if b0 in R_set and b1 in R_set:
                    qset.add(m)
        if qset:
            r2_qps.append(qset)
    ana_R2 = s16.analyze_quad_system(r2_qps)
    # Also compute GF(2) rank of the R^2-parts themselves (out of C(nR, 2) pairs!)
    r2_pair_piv = {}
    for qs in r2_qps:
        # pack pair set as big int? Use pair index!
        v = 0
        for m in qs:
            b0 = (m & -m).bit_length() - 1
            b1 = (m ^ (1 << b0)).bit_length() - 1
            i0, i1 = r_idx[b0], r_idx[b1]
            if i0 > i1: i0, i1 = i1, i0
            v ^= (1 << (i0 * nR + i1))
        while v:
            b = v.bit_length() - 1
            if b in r2_pair_piv: v ^= r2_pair_piv[b]
            else: r2_pair_piv[b] = v; break
    print(f"[{cell_name}] PART 3 degR=2_degW=0 block ({len(r2_qps)} rows in nR={nR} vars): "
          f"dim_W_ess_R={ana_R2['dim_W_ess']}/{nR}, pair_rank={len(r2_pair_piv)}/{len(r2_qps)} (of C({nR},2)={nR*(nR-1)//2})", flush=True)

    # 4. SCAN ALL 64 ETA-STATES IN 2-BLOCK R_all > W_ess ORDER!
    spec_summary = {}
    for em in range(1 << n_ef):
        ex = [(eta_free[k], (em >> k) & 1) for k in range(n_ef)]
        sr_e = s9.run_branch_cascade(
            lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
            ex, tbl, max_xl_rounds=10, verify_subst=False
        )
        if sr_e["closed_unsat"]:
            sig = "CLOSED"
        else:
            qps_e = [s9.row_to_pset(sr_e["_buf"], qr, tbl) for qr in sr_e["_quad_ids"]]
            ana_e = s16.analyze_quad_system(qps_e)
            W_r_e = s19.strict_rref_masks(list(ana_e["W_piv"].values()))
            W_p_e = sorted(W_r_e.keys())
            W_s_e = set(W_p_e)
            act_e = sorted(i for i in range(n) if i not in sr_e["_lin_pivs"])
            R_s_e = set(v for v in act_e if v not in W_s_e)
            # Shear & 2-block echelonize
            eids = list(sr_e["_quad_ids"]) + list(sr_e["_cub_ids"])
            me = len(eids)
            wk = (ctypes.c_uint64 * (me * n_cw))()
            for i, rid in enumerate(eids):
                ctypes.memmove(ctypes.byref(wk, i * n_cw * 8), ctypes.byref(sr_e["_buf"], rid * n_cw * 8), n_cw * 8)
            for p in W_p_e:
                rest = W_r_e[p] ^ (1 << p)
                if rest:
                    lib_sh.shear_subst_var_batch(
                        wk, me, n_cw, n, tbl["off2"], tbl["off1"], tbl["off0"],
                        tbl["col2_base"], tbl["col3_base"], tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"],
                        p, rest & mask64, rest >> 64
                    )
            ck, cm = [], []
            for c in range(n_cols):
                d = int(tbl["col_deg"][c])
                vs = []
                if d >= 1: vs.append(int(tbl["col_v0"][c]))
                if d >= 2: vs.append(int(tbl["col_v1"][c]))
                if d >= 3: vs.append(int(tbl["col_v2"][c]))
                dr = sum(1 for v in vs if v in R_s_e)
                cm.append(dr)
                ck.append((3 - dr, 3 - d, c))
            ck.sort()
            o2p = (ctypes.c_int * n_cols)()
            p2o = [0] * n_cols
            for pc, (_, _, oc) in enumerate(ck): o2p[oc] = pc; p2o[pc] = oc
            pb = (ctypes.c_uint64 * (me * n_cw))()
            lib_sh.remap_rows_by_perm(wk, pb, me, n_cw, n_cols, o2p)
            pi = (ctypes.c_int * n_cols)(*([-1] * n_cols))
            dr_cnt = [0, 0, 0, 0]
            for r in range(me):
                pc = lib9.gf2_echelon_insert_s9(pb, r, n_cw, pi, n_cols)
                if pc >= 0: dr_cnt[cm[p2o[pc]]] += 1
            sig = f"W={len(W_p_e)}_R={len(R_s_e)}_dr0={dr_cnt[0]}_dr1={dr_cnt[1]}_dr2={dr_cnt[2]}_dr3={dr_cnt[3]}"
        spec_summary[sig] = spec_summary.get(sig, 0) + 1
    print(f"[{cell_name}] PART 4 ALL 64 ETA-STATES 2-BLOCK SPECTRUM SUMMARY:", flush=True)
    for k, v in sorted(spec_summary.items(), key=lambda kv: -kv[1]):
        print(f"      {k}: {v} eta-states", flush=True)
    print(f"[{cell_name}] STEP 21C DONE ({time.perf_counter()-t0:.1f}s)", flush=True)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cells", type=str, default="B0_11,B1_11")
    args = parser.parse_args()

    c_diag, so_diag = WORK_DIR / "s21c_diag.c", WORK_DIR / "libs21c_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s21c_s9.c", WORK_DIR / "libs21c_s9.so"
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

    c_cg, so_cg = WORK_DIR / "s21c_cg.c", WORK_DIR / "libs21c_cg.so"
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

    c_sh, so_sh = WORK_DIR / "s21c_sh.c", WORK_DIR / "libs21c_sh.so"
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
    for cname in [c.strip() for c in args.cells.split(",") if c.strip()]:
        run_step21c_cell(
            cname, lib_diag, lib9, lib_cg, lib_sh, orbits, layer_vecs,
            v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl
        )


if __name__ == "__main__":
    main()
