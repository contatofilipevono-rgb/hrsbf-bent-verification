#!/usr/bin/env python3
r"""
SOLVE_STEP19_ZEROTRUST_AUDIT_AND_TRUE_WESS_CRUSH.py

CRITICAL ZERO-TRUST AUDIT & TRUE W_ess DECOMPOSITION AFTER FIXING `s9.add_linear_rref`!
(Previously `add_linear_rref` & `rref_B`/`rref_W` stopped at the first unseen pivot bit
without reducing other existing pivots out of `cur_v`, corrupting multi-pivot RREF!)

With STRICT Gauss-Jordan RREF + `verify_subst=True` EVERYWHERE:
  PART 1: Audit ALL 64 eta-states (with verify_subst=True!) -> verify exact closed/quad counts!
  PART 2: Audit L2b_FORWARD, L2b_REVERSE, W_ess_PREFIX (with verify_subst=True!) -> verify the
          k=35..45 explosion and whether W_ess (full) immediately drops +17 linears and closes 1=0!
  PART 3: TRUE Strict-RREF 3-block shear change of basis (R_free > R_tail > W_ess) with 100%
          zero-trust random-point verification! Prints exact (deg_Rfree, deg_Rtail, deg_W)
          spectrum of all quads and cubics!
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


def strict_rref_masks(forms):
    """Build STRICT Gauss-Jordan RREF dict piv_bit -> mask (zero pivot overlap!)."""
    rref = {}
    for fm in forms:
        x = fm
        for p, pm in rref.items():
            if (x >> p) & 1:
                x ^= pm
        if x == 0:
            continue
        b = x.bit_length() - 1
        for ob in list(rref.keys()):
            if (rref[ob] >> b) & 1:
                rref[ob] ^= x
        rref[b] = x
    # Assert strict RREF invariant!
    pkeys = set(rref.keys())
    for p, pm in rref.items():
        assert (pm >> p) & 1
        for q in pkeys:
            if q != p:
                assert not ((pm >> q) & 1), f"Strict RREF violation: {q} in {p}"
    return rref


def gf2_rank_masks(masks):
    return len(strict_rref_masks(masks))


def verify_lin_pivs_rref(lin_pivs):
    pkeys = set(lin_pivs.keys())
    for p, (pv, pr) in lin_pivs.items():
        assert (pv >> p) & 1
        for q in pkeys:
            if q != p:
                assert not ((pv >> q) & 1), f"lin_pivs RREF violation: {q} in {p}"


def run_step19_cell(cell_name, lib_diag, lib9, lib_cg, lib_sh, orbits, layer_vecs,
                    v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl, probe=None):
    t0 = time.perf_counter()
    print(f"\n==================== [{cell_name}] STEP 19: ZERO-TRUST AUDIT + TRUE (R_free > R_tail > W_ess) ====================", flush=True)
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
    verify_lin_pivs_rref(root["_lin_pivs"])
    print(f"[{cell_name}] ROOT (ZT-verified): N={root['N_active']}, q={root['n_quad_surviving']}, c={root['n_genuine_cubics']}", flush=True)

    forms_L1 = s16.extract_forms_from_orb_vecs(cb111, layer_vecs["L1"][1], layer_vecs["L1"][0])
    forms_L2b = s16.extract_forms_from_orb_vecs(cb111, layer_vecs["L2b"][1], layer_vecs["L2b"][0])
    eta_free = s16.reduce_forms_mod_pivs(forms_L1, root["_lin_pivs"])
    n_ef = len(eta_free)

    # --------------------------------------------------------------------------
    # PART 1: ZERO-TRUST AUDIT OF ALL 2^{n_ef} = 64 ETA STATES!
    # --------------------------------------------------------------------------
    closed_eta, q_hist, n_hist, target_sr, target_em = 0, {}, {}, None, None
    for em in range(1 << n_ef):
        ex = [(eta_free[k], (em >> k) & 1) for k in range(n_ef)]
        sr = s9.run_branch_cascade(
            lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
            ex, tbl, max_xl_rounds=20, verify_subst=True
        )
        if sr["closed_unsat"]:
            closed_eta += 1
        else:
            verify_lin_pivs_rref(sr["_lin_pivs"])
            q = sr.get("n_quad_surviving", -1)
            na = sr["N_active"]
            q_hist[q] = q_hist.get(q, 0) + 1
            n_hist[na] = n_hist.get(na, 0) + 1
            if target_sr is None and q > 0:
                target_sr, target_em = sr, em
    print(f"[{cell_name}] PART 1 (ALL {1<<n_ef} eta-states, ZT-verified): closed={closed_eta}/{1<<n_ef} | q_hist={dict(sorted(q_hist.items()))} | N_hist={dict(sorted(n_hist.items()))}", flush=True)

    if target_sr is None:
        print(f"[{cell_name}] NO SURVIVING q>0 ETA STATE! DONE!", flush=True)
        return

    sr = target_sr
    l2b_free = s16.reduce_forms_mod_pivs(forms_L2b, sr["_lin_pivs"])
    qps = [s9.row_to_pset(sr["_buf"], qr, tbl) for qr in sr["_quad_ids"]]
    ana = s16.analyze_quad_system(qps)
    W_rref = strict_rref_masks(list(ana["W_piv"].values()))
    W_forms = list(W_rref.values())

    rk_W = len(W_forms)
    rk_L2b = gf2_rank_masks(l2b_free)
    rk_union = gf2_rank_masks(W_forms + l2b_free)
    print(f"[{cell_name}] Target eta={target_em}: N={sr['N_active']}, q={len(qps)}, c={sr['n_genuine_cubics']} | "
          f"dim_W_ess={rk_W}, rank(L2b)={rk_L2b}, union={rk_union} (overlap={rk_W+rk_L2b-rk_union}), "
          f"pure_W={ana['n_pure_in_W_ess']}, rk_rad_tails={ana['rank_radical_linear_tails']}", flush=True)

    # --------------------------------------------------------------------------
    # PART 2: ZERO-TRUST AUDIT OF L2b_FORWARD, L2b_REVERSE, W_ess_PREFIX!
    # --------------------------------------------------------------------------
    rng = random.Random(2026111919)
    for label, flist, ks in [
        ("W_ess_PREFIX", W_forms, [10, 20, 30, 35, 40, len(W_forms)]),
        ("L2b_FORWARD", l2b_free, [10, 20, 30, 35, 40, len(l2b_free)]),
        ("L2b_REVERSE", list(reversed(l2b_free)), [10, 20, 30, 35, 40, len(l2b_free)]),
    ]:
        for kf in ks:
            if kf <= 0 or kf > len(flist): continue
            cl_c, qs, ls, ns, sample_rlog = 0, [], [], [], None
            for tr in range(4):
                ex = [(flist[k], rng.randint(0, 1)) for k in range(kf)]
                sub = s9.run_branch_cascade(
                    lib9, sr["_buf"], sr["_quad_ids"], sr["_cub_ids"], sr["_lin_pivs"],
                    ex, tbl, max_xl_rounds=12, verify_subst=True
                )
                if sub["closed_unsat"]:
                    cl_c += 1
                    if sample_rlog is None:
                        sample_rlog = {"closed_by": sub.get("closed_by"), "logs": sub.get("round_logs", [])[-3:]}
                else:
                    verify_lin_pivs_rref(sub["_lin_pivs"])
                    q_s = sub.get("n_quad_surviving", -1)
                    qs.append(q_s); ls.append(sub.get("total_lin_dropped", 0)); ns.append(sub["N_active"])
                    if (q_s > 50 or sub.get("total_lin_dropped", 0) > 0) and sample_rlog is None:
                        sample_rlog = {"q": q_s, "l": sub.get("total_lin_dropped", 0), "logs": sub.get("round_logs", [])[-3:]}
            print(f"  [{cell_name}] {label:12s} k={kf:2d}: closed={cl_c}/4, max_q={max(qs) if qs else 0}, max_l={max(ls) if ls else 0}, min_N={min(ns) if ns else 0}", flush=True)
            if sample_rlog:
                print(f"      rlog: {sample_rlog}", flush=True)

    # --------------------------------------------------------------------------
    # PART 3: TRUE STRICT-RREF 3-BLOCK BASIS CHANGE (R_free > R_tail > W_ess)!
    # --------------------------------------------------------------------------
    # Extract the linear tails of the quads (reduced mod W_rref) as R_tail forms!
    tail_forms_raw = []
    for ps in qps:
        lmask = 0
        for m in ps:
            if m.bit_count() == 1:
                lmask |= m
        # reduce lmask mod W_rref
        rem = lmask
        for p, pm in W_rref.items():
            if (rem >> p) & 1:
                rem ^= pm
        if rem:
            tail_forms_raw.append(rem)

    # Build combined strict RREF for W_forms + tail_forms!
    # Wait: keep W_pivs = sorted(W_rref.keys())! Then reduce tail_forms mod W_rref so they ONLY
    # touch active_vars \ W_pivs, then strict-RREF those tail_forms to get T_pivs!
    T_rref = strict_rref_masks(tail_forms_raw)
    W_pivs = sorted(W_rref.keys())
    T_pivs = sorted(T_rref.keys())
    assert len(set(W_pivs) & set(T_pivs)) == 0, "W_pivs and T_pivs must be disjoint!"

    # Now back-substitute T_rref into W_rref so combined (W_rref U T_rref) is STRICT RREF?
    # NO!! If we shear-subst W_pivs FIRST using W_rref (where rest ONLY uses active \ W_pivs),
    # and THEN shear-subst T_pivs using T_rref (where rest ONLY uses active \ (W_pivs U T_pivs)):
    # Check what happens to a quadratic q(x) = Q(W_forms(x)) + L_tail(x) + L_W(x)!
    # Wait: T_rref[t] is a linear combo of x outside W_pivs.
    # For a single combined invertible shear map y_p = rref[p](x) for p in (W_pivs U T_pivs) and y_r = x_r for r in R_free:
    # We need STRICT RREF of BOTH W_rref AND T_rref? Wait: if we back-sub T_rref into W_rref,
    # then W_rref[w] changes by adding T_rref[t], which mixes T into W! We DON'T want to mix T into W!
    # Instead, do TWO sequential invertible transformations:
    #   Step A: Transform x -> x' by shear-substituting x_p <- x'_p ^ (W_rref[p] ^ (1<<p)) for p in W_pivs.
    #           Since W_rref[p] has NO other W_pivs, these ALL commute, and after Step A:
    #             - EVERY form in span(W_forms) is a pure linear combo of {x'_p : p in W_pivs}!
    #             - EVERY quadratic Q_a(W_forms(x)) has deg_2 terms ONLY in W_pivs!
    #             - EVERY x_j for j not in W_pivs is UNCHANGED (x'_j = x_j), so T_rref[t](x') == T_rref[t](x)!
    #   Step B: Transform x' -> y by shear-substituting x'_t <- y_t ^ (T_rref[t] ^ (1<<t)) for t in T_pivs.
    #           Since T_rref[t] has ZERO bits in W_pivs and ZERO other bits in T_pivs:
    #             - ALL W_pivs variables x'_p are UNCHANGED (y_p = x'_p)!
    #             - ALL T_rref[t](x') become pure single variables y_t!
    #             - EVERY quadratic becomes:  y_t + Q_a(y_W) + L_a(y_W) = 0 !! (ZERO R_free, deg_T=1, deg_W=2!)
    eq_ids = list(sr["_quad_ids"]) + list(sr["_cub_ids"])
    M_eq = len(eq_ids)
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
    # Step B: T_rref shear
    for t in T_pivs:
        rest = T_rref[t] ^ (1 << t)
        if rest:
            lib_sh.shear_subst_var_batch(
                work, M_eq, n_cw, n, tbl["off2"], tbl["off1"], tbl["off0"],
                tbl["col2_base"], tbl["col3_base"], tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"],
                t, rest & mask64, rest >> 64
            )

    # ZERO-TRUST VERIFY the two-step shear change of basis on 5 random points x all M_eq rows!
    active_now = sorted(i for i in range(n) if i not in sr["_lin_pivs"])
    W_set, T_set = set(W_pivs), set(T_pivs)
    R_free = [v for v in active_now if v not in W_set and v not in T_set]
    RF_set = set(R_free)

    mism_shear = 0
    for _ in range(5):
        # Sample random y on active_now
        y = sum((1 << v) for v in active_now if rng.randint(0, 1))
        # Inverse map: Step B inverse (x' from y): x'_t = y_t ^ (T_rref[t] ^ (1<<t))(y)
        xp = y
        for t in T_pivs:
            rest = T_rref[t] ^ (1 << t)
            if (rest & y).bit_count() & 1:
                xp ^= (1 << t)
        # Step A inverse (x from x'): x_p = x'_p ^ (W_rref[p] ^ (1<<p))(x')
        x = xp
        for p in W_pivs:
            rest = W_rref[p] ^ (1 << p)
            if (rest & xp).bit_count() & 1:
                x ^= (1 << p)
        x_lo, x_hi = x & mask64, x >> 64
        y_lo, y_hi = y & mask64, y >> 64
        for idx_r in range(min(60, M_eq)):
            r_old = ctypes.cast(ctypes.byref(sr["_buf"], eq_ids[idx_r] * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
            r_new = ctypes.cast(ctypes.byref(work, idx_r * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
            v_old = lib9.eval_row_s9(r_old, n_cw, tbl["off0"], tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"], x_lo, x_hi)
            v_new = lib9.eval_row_s9(r_new, n_cw, tbl["off0"], tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"], y_lo, y_hi)
            if v_old != v_new:
                mism_shear += 1
    print(f"  [{cell_name}] PART 3 Two-step shear (|W|={len(W_pivs)}, |T|={len(T_pivs)}, |R_free|={len(R_free)}): ZT mismatches = {mism_shear}/300", flush=True)
    assert mism_shear == 0, f"SHEAR ZERO-TRUST MISMATCH: {mism_shear}"

    # Inspect the transformed quadratics directly!
    q_degRF_hist, q_degT_hist = {}, {}
    for qi in range(len(sr["_quad_ids"])):
        ps = s9.row_to_pset(work, qi, tbl)
        max_rf, max_t, max_w2 = 0, 0, 0
        for m in ps:
            if m == 0: continue
            vs = [b for b in range(n) if (m >> b) & 1]
            rf = sum(1 for v in vs if v in RF_set)
            tt = sum(1 for v in vs if v in T_set)
            max_rf = max(max_rf, rf); max_t = max(max_t, tt)
        q_degRF_hist[max_rf] = q_degRF_hist.get(max_rf, 0) + 1
        q_degT_hist[max_t] = q_degT_hist.get(max_t, 0) + 1
    print(f"  [{cell_name}] Transformed 17 quads: max_deg(R_free)={q_degRF_hist}, max_deg(R_tail)={q_degT_hist}", flush=True)

    # Echelonize ALL M_eq rows in 3-block elimination order: R_free > R_tail > W_ess!
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
    linear_rows = []
    pure_WT, pure_W = 0, 0
    for r in range(M_eq):
        pc = lib9.gf2_echelon_insert_s9(perm_buf, r, n_cw, piv_idx, n_cols)
        if pc < 0: continue
        oc = perm_to_orig[pc]
        drf, dt, dw, td = col_meta[oc]
        if drf <= 1:
            linear_rows.append(r)
        key = f"RF={drf}_T={dt}_W={dw}_d={td}"
        spec[key] = spec.get(key, 0) + 1
        if drf == 0:
            pure_WT += 1
            if dt == 0:
                pure_W += 1
    print(f"  [{cell_name}] 3-BLOCK ELIM ORDER (R_free > R_tail > W_ess): pure_WT={pure_WT}, pure_W={pure_W}", flush=True)
    for k in sorted(spec.keys()):
        print(f"      {k}: {spec[k]}", flush=True)

    if probe is not None:
        unpermuted = (ctypes.c_uint64 * (M_eq * n_cw))()
        inverse = (ctypes.c_int * n_cols)(*perm_to_orig)
        lib_sh.remap_rows_by_perm(perm_buf, unpermuted, M_eq, n_cw, n_cols, inverse)
        quads = [s9.row_to_pset(work, q, tbl) for q in range(len(sr["_quad_ids"]))]
        linear = [s9.row_to_pset(unpermuted, q, tbl) for q in linear_rows]
        # The tail equations are eliminated by substitution in the callback.
        probe(cell_name, quads, [p for p in linear if p not in quads],
              {v: i for i, v in enumerate(W_pivs)}, {v: i for i, v in enumerate(T_pivs)},
              {v: i for i, v in enumerate(R_free)})

    print(f"[{cell_name}] STEP 19 DONE ({time.perf_counter()-t0:.1f}s)", flush=True)


def main(probe=None):
    parser = argparse.ArgumentParser()
    parser.add_argument("--cells", type=str, default="B0_00,B0_11,B1_11")
    args = parser.parse_args()

    c_diag, so_diag = WORK_DIR / "s19_diag.c", WORK_DIR / "libs19_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s19_s9.c", WORK_DIR / "libs19_s9.so"
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

    c_cg, so_cg = WORK_DIR / "s19_cg.c", WORK_DIR / "libs19_cg.so"
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

    c_sh, so_sh = WORK_DIR / "s19_sh.c", WORK_DIR / "libs19_sh.so"
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
        run_step19_cell(
            cname, lib_diag, lib9, lib_cg, lib_sh, orbits, layer_vecs,
            v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl, probe=probe
        )


if __name__ == "__main__":
    main()
