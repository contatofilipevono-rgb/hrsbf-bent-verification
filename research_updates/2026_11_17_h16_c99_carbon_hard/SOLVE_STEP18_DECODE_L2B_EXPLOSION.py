#!/usr/bin/env python3
r"""
SOLVE_STEP18_DECODE_L2B_EXPLOSION.py

URGENT DIAGNOSTIC OF THE STEP 16 EXPLOSION (k=30 -> q=18, k=40 -> 5/6 CLOSED & q=1,658, k=45 -> 6/6 CLOSED with 56 vars free!!):

  TEST 1 (REVERSED & RANDOM L2b ORDERING — THE GOLDEN QUESTION!):
    In Step 16, L2b[0..29] did almost nothing (q=17..18), then L2b[30..44] (just 15 forms!)
    exploded to 1,658 quadratics and 6/6 1=0!
    -> Tests L2b in REVERSE order (k=5, 10, 15, 20, 25, 30, 35, 40, 45) AND RANDOM order
       AND prints exact `round_logs` of the explosion!
    If REVERSE k=10..15 explodes to 1=0, we have a 2^10..2^15 exhaustive closure path!

  TEST 2 (EXACT W_ess OVERLAP & ELIMINATION ORDER R' > W_ess):
    Computes exact overlap rank(W_ess, L2b) and runs Elimination Order (R' > W_ess) using
    the TRUE 44-dim bilinear subspace W_ess of the 17..41 quadratics (extracting ALL pure-W_ess
    quads & cubics AND running pure-W_ess Schur-D4 if any exist!).

  TEST 3 (E_even (0x5555, 8 forms) + eta(6 forms)):
    Tests fixing the 8 even-subspace linear forms on top of eta=0 (only <= 256 states -> samples 32).
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
import SOLVE_STEP11_CG_SCHUR_DEG4 as s11
import SOLVE_STEP16_LAYER2A_AND_W44_CRUSH as s16
import SOLVE_STEP17_ELIM_ORDER_R_GT_B_SCHUR4 as s17


def gf2_rank_masks(masks):
    p = {}
    for m in masks:
        x = m
        while x:
            b = x.bit_length() - 1
            if b in p: x ^= p[b]
            else: p[b] = x; break
    return len(p)


def run_step18_cell(cell_name, lib_diag, lib9, lib_cg, lib_sh, lib11, orbits, layer_vecs, orb_tt_np,
                    v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl):
    t0 = time.perf_counter()
    print(f"\n==================== [{cell_name}] STEP 18: DECODE L2b EXPLOSION + W_ess ELIM ORDER ====================", flush=True)
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

    root = s9.run_branch_cascade(lib9, raw_buf, [], list(range(total_raw)), {}, [], tbl, max_xl_rounds=10, verify_subst=False)

    forms_L1 = s16.extract_forms_from_orb_vecs(cb111, layer_vecs["L1"][1], layer_vecs["L1"][0])
    forms_L2b = s16.extract_forms_from_orb_vecs(cb111, layer_vecs["L2b"][1], layer_vecs["L2b"][0])
    eta_free = s16.reduce_forms_mod_pivs(forms_L1, root["_lin_pivs"])
    n_ef = len(eta_free)

    # Target eta=0 for B0_11/B1_11, and eta=4 (q=17) + eta=20 (q=41) for B0_00!
    target_em = 4 if cell_name == "B0_00" else 0
    ex_eta = [(eta_free[k], (target_em >> k) & 1) for k in range(n_ef)]
    sr = s9.run_branch_cascade(
        lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
        ex_eta, tbl, max_xl_rounds=20, verify_subst=False
    )

    l2b_free = s16.reduce_forms_mod_pivs(forms_L2b, sr["_lin_pivs"])
    qps = [s9.row_to_pset(sr["_buf"], qr, tbl) for qr in sr["_quad_ids"]]
    ana = s16.analyze_quad_system(qps)
    W_forms = list(ana["W_piv"].values())

    rk_W = gf2_rank_masks(W_forms)
    rk_L2b = gf2_rank_masks(l2b_free)
    rk_union = gf2_rank_masks(W_forms + l2b_free)
    print(f"[{cell_name}] eta={target_em}: N={sr['N_active']}, q={len(qps)}, c={sr['n_genuine_cubics']} | "
          f"rank(W_ess)={rk_W}, rank(L2b)={rk_L2b}, rank(W_ess U L2b)={rk_union} (overlap={rk_W + rk_L2b - rk_union}!)", flush=True)

    # --------------------------------------------------------------------------
    # TEST 1: REVERSE L2b, RANDOM L2b, FORWARD L2b(32..45), AND W_ess PREFIXES!
    # --------------------------------------------------------------------------
    rng = random.Random(2026111918)
    l2b_rev = list(reversed(l2b_free))
    l2b_shuf = list(l2b_free)
    rng.shuffle(l2b_shuf)

    curves = {}
    for label, flist, ks in [
        ("L2b_REVERSE", l2b_rev, [5, 10, 15, 20, 25, 30, 35, 40, min(44, len(l2b_rev))]),
        ("L2b_SHUFFLED", l2b_shuf, [10, 20, 30, 35, 40, min(44, len(l2b_shuf))]),
        ("W_ess_PREFIX", W_forms, [10, 20, 30, 35, 40, len(W_forms)]),
    ]:
        c_list = []
        for kf in ks:
            if kf <= 0 or kf > len(flist): continue
            cl_c, qs, ls, ns, sample_rlog = 0, [], [], [], None
            for tr in range(4):
                ex = [(flist[k], rng.randint(0, 1)) for k in range(kf)]
                sub = s9.run_branch_cascade(
                    lib9, sr["_buf"], sr["_quad_ids"], sr["_cub_ids"], sr["_lin_pivs"],
                    ex, tbl, max_xl_rounds=12, verify_subst=False
                )
                if sub["closed_unsat"]:
                    cl_c += 1
                    if sample_rlog is None:
                        sample_rlog = {"closed_by": sub.get("closed_by"), "logs": sub.get("round_logs", [])[-3:]}
                elif "n_quad_surviving" in sub:
                    qs.append(sub["n_quad_surviving"]); ls.append(sub["total_lin_dropped"]); ns.append(sub["N_active"])
                    if sub["n_quad_surviving"] > 50 and sample_rlog is None:
                        sample_rlog = {"q": sub["n_quad_surviving"], "logs": sub.get("round_logs", [])[-3:]}
            entry = {
                "k": kf, "closed_of_4": cl_c,
                "max_q": max(qs) if qs else 0, "avg_q": round(sum(qs)/len(qs), 1) if qs else 0,
                "max_l": max(ls) if ls else 0, "min_N": min(ns) if ns else 0,
                "rlog": sample_rlog,
            }
            c_list.append(entry)
            print(f"  [{cell_name}] {label} k={kf:2d}: closed={cl_c}/4, max_q={entry['max_q']}, max_l={entry['max_l']}, min_N={entry['min_N']}", flush=True)
            if sample_rlog:
                print(f"      rlog: {sample_rlog}", flush=True)
        curves[label] = c_list

    # --------------------------------------------------------------------------
    # TEST 2: ELIMINATION ORDER (R' > W_ess) using TRUE W_ess!
    # --------------------------------------------------------------------------
    eq_ids = list(sr["_quad_ids"]) + list(sr["_cub_ids"])
    M_eq = len(eq_ids)
    work = (ctypes.c_uint64 * (M_eq * n_cw))()
    for i, rid in enumerate(eq_ids):
        ctypes.memmove(ctypes.byref(work, i * n_cw * 8), ctypes.byref(sr["_buf"], rid * n_cw * 8), n_cw * 8)

    rref_W = {}
    for fm in W_forms:
        x = fm
        while x:
            b = x.bit_length() - 1
            if b in rref_W: x ^= rref_W[b]
            else:
                for ob in list(rref_W.keys()):
                    if (rref_W[ob] >> b) & 1: rref_W[ob] ^= x
                rref_W[b] = x
                break
    W_piv_vars = sorted(rref_W.keys())
    W_set = set(W_piv_vars)
    active_now = sorted(i for i in range(n) if i not in sr["_lin_pivs"])
    R_vars = [v for v in active_now if v not in W_set]

    for p in W_piv_vars:
        rest = rref_W[p] ^ (1 << p)
        if rest:
            lib_sh.shear_subst_var_batch(
                work, M_eq, n_cw, n, tbl["off2"], tbl["off1"], tbl["off0"],
                tbl["col2_base"], tbl["col3_base"], tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"],
                p, rest & mask64, rest >> 64
            )

    R_set = set(R_vars)
    col_keys, col_degR = [], [0] * n_cols
    for c in range(n_cols):
        d = int(tbl["col_deg"][c])
        dr = 0
        if d >= 1 and int(tbl["col_v0"][c]) in R_set: dr += 1
        if d >= 2 and int(tbl["col_v1"][c]) in R_set: dr += 1
        if d >= 3 and int(tbl["col_v2"][c]) in R_set: dr += 1
        col_degR[c] = dr
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
    w_spec = {}
    pure_W_cnt = 0
    for r in range(M_eq):
        pc = lib9.gf2_echelon_insert_s9(perm_buf, r, n_cw, piv_idx, n_cols)
        if pc < 0: continue
        oc = perm_to_orig[pc]
        dr = col_degR[oc]; td = int(tbl["col_deg"][oc])
        key = f"degR={dr}_deg={td}"
        w_spec[key] = w_spec.get(key, 0) + 1
        if dr == 0: pure_W_cnt += 1
    print(f"  [{cell_name}] ELIMINATION ORDER (R' > W_ess, |W|={len(W_piv_vars)}, |R'|={len(R_vars)}): {json.dumps(w_spec)} (pure_W={pure_W_cnt})", flush=True)

    # --------------------------------------------------------------------------
    # TEST 3: E_even (0x5555, 8 forms) on top of root AND on top of eta!
    # --------------------------------------------------------------------------
    b_tt = np.zeros((111, 65536), dtype=np.uint8)
    for i, m in enumerate(cb111):
        tmp = m
        while tmp:
            lb = tmp & -tmp; b_tt[i] ^= orb_tt_np[lb.bit_length() - 1]; tmp ^= lb
    E_even = np.array([x for x in range(65536) if (x & 0xAAAA) == 0], dtype=np.uint16)
    ev_raw = []
    ep = {}
    for x in E_even:
        col = b_tt[:, x]
        if not np.any(col): continue
        m = sum((1 << int(i)) for i in np.flatnonzero(col))
        rem = m
        while rem:
            b = rem.bit_length() - 1
            if b in ep: rem ^= ep[b]
            else: ep[b] = rem; ev_raw.append(m); break
    ev_free_root = s16.reduce_forms_mod_pivs(ev_raw, root["_lin_pivs"])
    ev_free_eta = s16.reduce_forms_mod_pivs(ev_raw, sr["_lin_pivs"])
    ev_cl_r, ev_maxq_r = 0, 0
    for _ in range(16):
        ex = [(ev_free_root[k], rng.randint(0, 1)) for k in range(len(ev_free_root))]
        sub = s9.run_branch_cascade(lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"], ex, tbl, max_xl_rounds=10, verify_subst=False)
        if sub["closed_unsat"]: ev_cl_r += 1
        elif "n_quad_surviving" in sub: ev_maxq_r = max(ev_maxq_r, sub["n_quad_surviving"])
    ev_cl_e, ev_maxq_e = 0, 0
    for _ in range(16):
        ex = [(ev_free_eta[k], rng.randint(0, 1)) for k in range(len(ev_free_eta))]
        sub = s9.run_branch_cascade(lib9, sr["_buf"], sr["_quad_ids"], sr["_cub_ids"], sr["_lin_pivs"], ex, tbl, max_xl_rounds=10, verify_subst=False)
        if sub["closed_unsat"]: ev_cl_e += 1
        elif "n_quad_surviving" in sub: ev_maxq_e = max(ev_maxq_e, sub["n_quad_surviving"])
    print(f"  [{cell_name}] E_even test: root(free={len(ev_free_root)}): closed={ev_cl_r}/16, max_q={ev_maxq_r} | "
          f"eta(free={len(ev_free_eta)}): closed={ev_cl_e}/16, max_q={ev_maxq_e}", flush=True)

    print(f"[{cell_name}] STEP 18 DONE ({time.perf_counter()-t0:.1f}s)", flush=True)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cells", type=str, default="B0_00,B0_11,B1_11")
    args = parser.parse_args()

    c_diag, so_diag = WORK_DIR / "s18_diag.c", WORK_DIR / "libs18_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s18_s9.c", WORK_DIR / "libs18_s9.so"
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

    c_cg, so_cg = WORK_DIR / "s18_cg.c", WORK_DIR / "libs18_cg.so"
    c_cg.write_text(s10.C_CG_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_cg), "-o", str(so_cg)], check=True)
    lib_cg = ctypes.CDLL(str(so_cg))
    for fn in (lib_cg.build_cg12_row_c, lib_cg.build_cg11_row_c):
        fn.argtypes = [
            ctypes.c_int, ctypes.POINTER(ctypes.c_int16),
            ctypes.POINTER(ctypes.c_int), ctypes.c_int, ctypes.POINTER(ctypes.c_int), ctypes.c_int,
            ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
            ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
            ctypes.POINTER(ctypes.c_uint64),
        ]

    c_sh, so_sh = WORK_DIR / "s18_sh.c", WORK_DIR / "libs18_sh.so"
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
    for cname in [c.strip() for c in args.cells.split(",") if c.strip()]:
        run_step18_cell(
            cname, lib_diag, lib9, lib_cg, lib_sh, None, orbits, layer_vecs, orb_tt_np,
            v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl
        )


if __name__ == "__main__":
    main()
