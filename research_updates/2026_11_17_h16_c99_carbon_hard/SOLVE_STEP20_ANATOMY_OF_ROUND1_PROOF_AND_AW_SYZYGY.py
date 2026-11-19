#!/usr/bin/env python3
r"""
SOLVE_STEP20_ANATOMY_OF_ROUND1_PROOF_AND_AW_SYZYGY.py

DECODES THE STEP 19 BREAKTHROUGH:
  In Step 19 (100% Zero-Trust verified with strict RREF + verify_subst=True):
    - In B0_11 (eta=0): fixing W_ess (44 vars) closes 4/4 to 1 = 0 IN ROUND 1 (ZERO XL passes!)
      with 57 variables R COMPLETELY FREE!
    - 3-block shear (ZT 0/300 mismatches) revealed ~95 equations with deg_R <= 1 and ONLY 25
      equations with deg_R == 3!

STEP 20 DISSECTS THIS EXACTLY ON B0_00, B0_11, B1_11:
  1. Exact 2-block strict-RREF shear (R_all > W_ess), ZT-verified (0 mismatches).
     Prints exact (deg_R, deg_W, total_deg) spectrum of ALL equations!
  2. Extracts the EXACT `deg_R <= 1` linear-in-R subsystem:  A(w) * r = b(w)
     where r in F_2^{N_R} (57 vars) and w in F_2^{N_W} (44 vars)!
     Prints:
       - Exact number of rows K_linR by (deg_W of A-part, deg_W of b-part)!
       - Exact rank(A(w)), dim(left_ker(A(w))), and # of violated left-kernel eqs (u . b(w) == 1)
         across 10 random w AND w = 0!
       - Column-support & row-sparsity profile of A(w) (do subsets of rows only touch small
         subsets of R-columns? Does A(w) have constant/linear left syzygies over F_2[W]?)!
  3. Traces the EXACT Round-1 proof of `1 = 0` when W_ess is fixed to random w:
     tracks the exact subset S(w) of equations whose GF(2) sum equals 1 in Round 1, and prints
     the exact deg_R breakdown of S(w) (pure deg_R<=1, or also deg_R=2/3)!
  4. Tests DEGREE-1 POLYNOMIAL LEFT SYZYGIES v(w)^T A(w) == 0 over F_2[W] on the deg_W<=1 rows
     of A(w) — if ANY exists, v(w)^T b(w) == 0 is a BRAND-NEW PURE-W_ess EQUATION!
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


def gf2_rank_and_left_nullspace(rows_int, n_cols):
    """Given K rows as integer bitmasks (bits 0..n_cols-1), return (rank, left_nullspace_masks)
    where each mask in left_nullspace_masks is a K-bit int u with XOR_{i in u} rows_int[i] == 0."""
    piv = {}  # bit -> (row_val, combo_mask)
    nulls = []
    for idx, r in enumerate(rows_int):
        val = r
        comb = 1 << idx
        while val:
            b = val.bit_length() - 1
            if b in piv:
                pv, pc = piv[b]
                val ^= pv
                comb ^= pc
            else:
                piv[b] = (val, comb)
                break
        else:
            nulls.append(comb)
    return len(piv), nulls


def run_step20_cell(cell_name, lib_diag, lib9, lib_cg, lib_sh, orbits, layer_vecs,
                    v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl):
    t0 = time.perf_counter()
    print(f"\n==================== [{cell_name}] STEP 20: ANATOMY OF ROUND-1 PROOF & A(w)*r = b(w) ====================", flush=True)
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

    # Pick eta=4 (q=17, dimW=43) for B0_00 (and also test eta=20 q=41? Stick to q=17 for apples-to-apples, plus check eta=20!)
    targets = [4, 20] if cell_name == "B0_00" else [0]
    for target_em in targets:
        ex_eta = [(eta_free[k], (target_em >> k) & 1) for k in range(n_ef)]
        sr = s9.run_branch_cascade(
            lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
            ex_eta, tbl, max_xl_rounds=20, verify_subst=True
        )
        if sr["closed_unsat"]:
            print(f"[{cell_name}] eta={target_em}: ALREADY CLOSED!", flush=True)
            continue

        qps = [s9.row_to_pset(sr["_buf"], qr, tbl) for qr in sr["_quad_ids"]]
        ana = s16.analyze_quad_system(qps)
        W_rref = s19.strict_rref_masks(list(ana["W_piv"].values()))
        W_pivs = sorted(W_rref.keys())
        W_set = set(W_pivs)
        active_now = sorted(i for i in range(n) if i not in sr["_lin_pivs"])
        R_vars = [v for v in active_now if v not in W_set]
        R_set = set(R_vars)
        nW, nR = len(W_pivs), len(R_vars)
        print(f"\n[{cell_name}] --- eta={target_em}: N={sr['N_active']} (|W|={nW}, |R|={nR}), q={len(qps)}, c={sr['n_genuine_cubics']} ---", flush=True)

        # 1. Exact 2-block shear (W_rref): y_p = W_rref[p](x) for p in W_pivs, y_r = x_r for r in R_vars!
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

        # Zero-trust verify shear on 5 random points
        rng = random.Random(202620)
        mism = 0
        for _ in range(5):
            y = sum((1 << v) for v in active_now if rng.randint(0, 1))
            x = y
            for p in W_pivs:
                rest = W_rref[p] ^ (1 << p)
                if (rest & y).bit_count() & 1: x ^= (1 << p)
            for idx_r in range(min(50, M_eq)):
                r_old = ctypes.cast(ctypes.byref(sr["_buf"], eq_ids[idx_r] * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
                r_new = ctypes.cast(ctypes.byref(work, idx_r * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
                if (lib9.eval_row_s9(r_old, n_cw, tbl["off0"], tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"], x & mask64, x >> 64) !=
                    lib9.eval_row_s9(r_new, n_cw, tbl["off0"], tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"], y & mask64, y >> 64)):
                    mism += 1
        assert mism == 0, f"Shear ZT mismatch: {mism}"

        # 2. Echelonize in 2-BLOCK ELIMINATION ORDER: R_all > W_ess!
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
        spec = {}
        ech_rows_meta = [] # (row_idx_in_perm_buf, lead_dr, lead_dw, lead_d)
        for r in range(M_eq):
            pc = lib9.gf2_echelon_insert_s9(perm_buf, r, n_cw, piv_idx, n_cols)
            if pc < 0: continue
            oc = perm_to_orig[pc]
            dr, dw, td = col_meta[oc]
            key = f"degR={dr}_degW={dw}_d={td}"
            spec[key] = spec.get(key, 0) + 1
            ech_rows_meta.append((r, dr, dw, td))
        print(f"  [{cell_name}] 2-BLOCK ELIM ORDER (R_all={nR} > W_ess={nW}):", flush=True)
        for k in sorted(spec.keys()):
            print(f"      {k}: {spec[k]}", flush=True)

        # Unmap echelonized rows back to standard col order so we can read exact monomials!
        inv_perm = (ctypes.c_int * n_cols)(*perm_to_orig)
        std_ech = (ctypes.c_uint64 * (M_eq * n_cw))()
        lib_sh.remap_rows_by_perm(perm_buf, std_ech, M_eq, n_cw, n_cols, inv_perm)

        # Parse ALL echelonized rows into compact (r_vars_tuple -> list of w_masks) dictionaries!
        w_idx = {v: i for i, v in enumerate(W_pivs)}
        r_idx = {v: i for i, v in enumerate(R_vars)}
        parsed_rows = []  # (max_dr, lead_dw, lead_d, poly_by_rmon) where poly_by_rmon[rmask] = list of wmasks
        for r_id, ldr, ldw, ld in ech_rows_meta:
            ps = s9.row_to_pset(std_ech, r_id, tbl)
            by_r = {}
            max_dr_actual = 0
            for m in ps:
                rm, wm = 0, 0
                tmp = m
                while tmp:
                    lb = tmp & -tmp; v = lb.bit_length() - 1; tmp ^= lb
                    if v in r_idx: rm |= (1 << r_idx[v])
                    elif v in w_idx: wm |= (1 << w_idx[v])
                dr_m = rm.bit_count()
                if dr_m > max_dr_actual: max_dr_actual = dr_m
                by_r.setdefault(rm, []).append(wm)
            assert max_dr_actual == ldr, f"Elim order bug: max_dr={max_dr_actual} != ldr={ldr}"
            parsed_rows.append((ldr, ldw, ld, by_r))

        # Separate degR <= 1 rows (A(w) * r = b(w)!)
        linR_rows = [pr for pr in parsed_rows if pr[0] <= 1]
        print(f"  [{cell_name}] EXACT deg_R <= 1 subsystem A(w)*r = b(w): {len(linR_rows)} rows x {nR} cols (R)!", flush=True)

        # Analyze A(w) row degrees & column sparsity!
        row_a_degs = {}
        row_col_counts = []
        col_deg_max = [0] * nR
        for ldr, ldw, ld, by_r in linR_rows:
            a_max_dw = 0
            n_cols_touched = 0
            for rm, wms in by_r.items():
                if rm == 0: continue
                c_i = rm.bit_length() - 1
                n_cols_touched += 1
                md = max(wm.bit_count() for wm in wms)
                if md > a_max_dw: a_max_dw = md
                if md > col_deg_max[c_i]: col_deg_max[c_i] = md
            b_max_dw = max((wm.bit_count() for wm in by_r.get(0, [0])), default=0)
            key = f"degA={a_max_dw}_degB={b_max_dw}"
            row_a_degs[key] = row_a_degs.get(key, 0) + 1
            row_col_counts.append(n_cols_touched)
        print(f"      A(w) row degree breakdown: {dict(sorted(row_a_degs.items()))}", flush=True)
        print(f"      A(w) cols touched per row: min={min(row_col_counts) if row_col_counts else 0}, "
              f"median={sorted(row_col_counts)[len(row_col_counts)//2] if row_col_counts else 0}, max={max(row_col_counts) if row_col_counts else 0}", flush=True)

        # Evaluate A(w) and [A(w) | b(w)] at w = 0 AND 10 random w in F_2^{nW}!
        def eval_wlist(wms, wval):
            s = 0
            for wm in wms:
                if (wval & wm) == wm: s ^= 1
            return s

        test_ws = [0] + [rng.getrandbits(nW) for _ in range(10)]
        incons_linR_only = 0
        rk_list, viol_list = [], []
        for idx_w, wv in enumerate(test_ws):
            a_masks = []
            b_bits = []
            for _, _, _, by_r in linR_rows:
                am = 0
                for rm, wms in by_r.items():
                    if rm == 0: continue
                    if eval_wlist(wms, wv):
                        am |= rm
                bv = eval_wlist(by_r.get(0, []), wv)
                a_masks.append(am)
                b_bits.append(bv)
            rk_a, lnulls = gf2_rank_and_left_nullspace(a_masks, nR)
            n_viol = 0
            for u in lnulls:
                s = 0
                tmp = u
                while tmp:
                    lb = tmp & -tmp; ri = lb.bit_length() - 1; tmp ^= lb
                    s ^= b_bits[ri]
                if s: n_viol += 1
            rk_list.append(rk_a)
            viol_list.append(n_viol)
            if n_viol > 0: incons_linR_only += 1
        print(f"  [{cell_name}] A(w)*r = b(w) ALONE across w=0 + 10 random w:", flush=True)
        print(f"      inconsistent = {incons_linR_only}/11 | rank(A(w)) = {rk_list} (of {nR}) | violated_left_nulls = {viol_list} (out of {len(linR_rows)} - rk)", flush=True)

        # 3. TRACE THE EXACT ROUND-1 `1 = 0` PROOF ACROSS ALL `M_eq` ROWS AT 5 RANDOM w!
        print(f"  [{cell_name}] TRACING EXACT ROUND-1 PROOF OF 1 = 0 ON ALL {len(parsed_rows)} ECHELON ROWS:", flush=True)
        for idx_w in range(4):
            wv = test_ws[idx_w]
            # Evaluate each parsed row at w = wv -> polynomial in R (dict of rmask -> 0/1)
            piv_r = {}  # lead_rmask_key -> (poly_set, combo_mask)
            # Order rmasks by (deg, rmask) descending!
            found_one = False
            for ri, (ldr, ldw, ld, by_r) in enumerate(parsed_rows):
                poly = set()
                for rm, wms in by_r.items():
                    if eval_wlist(wms, wv):
                        poly.add(rm)
                comb = 1 << ri
                while poly:
                    lead = max(poly, key=lambda m: (m.bit_count(), m))
                    if lead == 0:
                        # 1 = 0 FOUND!! Analyze `comb`!
                        used = [i for i in range(len(parsed_rows)) if (comb >> i) & 1]
                        by_dr = {}
                        for ui in used:
                            d = parsed_rows[ui][0]
                            by_dr[d] = by_dr.get(d, 0) + 1
                        print(f"      w[{idx_w}] ({'w=0' if idx_w==0 else 'rand'}): 1 = 0 PROVED using {len(used)} eqs! Breakdown by deg_R: {dict(sorted(by_dr.items()))}", flush=True)
                        found_one = True
                        break
                    if lead in piv_r:
                        pp, pc = piv_r[lead]
                        poly ^= pp
                        comb ^= pc
                    else:
                        piv_r[lead] = (poly, comb)
                        break
                if found_one:
                    break
            if not found_one:
                n_d1 = sum(1 for k in piv_r if k.bit_count() == 1)
                n_d2 = sum(1 for k in piv_r if k.bit_count() == 2)
                n_d3 = sum(1 for k in piv_r if k.bit_count() == 3)
                print(f"      w[{idx_w}] ({'w=0' if idx_w==0 else 'rand'}): NO Round-1 1=0! Pivots in R: d1={n_d1}, d2={n_d2}, d3={n_d3}", flush=True)

        # 4. CHECK LINEAR-IN-W LEFT SYZYGIES v(w)^T A(w) == 0 ON degA <= 1 ROWS!!
        # Wait: separate rows with degA == 0 (constant in w, the 17 quads!) and degA == 1 (linear in w)!
        degA01_rows = []
        for idx_l, (ldr, ldw, ld, by_r) in enumerate(linR_rows):
            a_max_dw = max((max(wm.bit_count() for wm in wms) for rm, wms in by_r.items() if rm != 0), default=0)
            if a_max_dw <= 1:
                degA01_rows.append((a_max_dw, by_r))
        # Check rank of the constant part A_0 (degA == 0) and whether linear part A_1(w) has small rank!
        # Specifically: for each row i in degA01_rows, A_i(w) is a linear map F_2^{nW} -> F_2^{nR} plus a constant vector in F_2^{nR}.
        # Check how many LINEARLY INDEPENDENT columns of R appear in A_1(w) (the degW=1 part of A(w))!
        # Wait: even better, check the rank of A_1(w) at random w modulo the constant rows A_0!
        a0_rows = [by_r for degA, by_r in degA01_rows if degA == 0]
        a1_rows = [by_r for degA, by_r in degA01_rows if degA == 1]
        print(f"  [{cell_name}] degA<=1 split: {len(a0_rows)} constant-A rows + {len(a1_rows)} linear-A rows!", flush=True)
        # Check which W-variables actually appear in A_1(w) (how many of the nW vars touch A_1!)
        w_in_A1 = set()
        r_in_A1 = set()
        for by_r in a1_rows:
            for rm, wms in by_r.items():
                if rm == 0: continue
                r_in_A1.add(rm.bit_length() - 1)
                for wm in wms:
                    if wm: w_in_A1.add(wm.bit_length() - 1)
        print(f"      A_1(w) touches {len(w_in_A1)}/{nW} W-vars and {len(r_in_A1)}/{nR} R-vars!", flush=True)

        # Check EXACT dimension of the space of matrices spanned by { d(A_1)/d(w_j) : j=0..nW-1 }
        # AND check if ANY single row of A_1(w) only depends on a SMALL number of W-vars or R-vars!
        row_w_cnts = []
        for by_r in a1_rows:
            ws_here = set()
            for rm, wms in by_r.items():
                if rm == 0: continue
                for wm in wms:
                    if wm: ws_here.add(wm.bit_length() - 1)
            row_w_cnts.append(len(ws_here))
        if row_w_cnts:
            print(f"      Per-row W-vars touched in A_1(w): min={min(row_w_cnts)}, median={sorted(row_w_cnts)[len(row_w_cnts)//2]}, max={max(row_w_cnts)}", flush=True)

        # Check if there is ANY constant vector v in F_2^{len(a1_rows)} with v^T A_1(w) == 0 mod rowspace(A_0)!
        # (That would be a pure-W equation after eliminating T = Q(W)!)
        # Build A_0 pivot basis in R (nR bits):
        a0_piv = {}
        for by_r in a0_rows:
            m = 0
            for rm, wms in by_r.items():
                if rm != 0 and (0 in wms): m |= rm
            x = m
            while x:
                b = x.bit_length() - 1
                if b in a0_piv: x ^= a0_piv[b]
                else: a0_piv[b] = x; break
        # For each row of a1_rows, reduce its coefficient of w_j (and const 1) mod a0_piv!
        # Concatenate all (nW + 1) reduced R-vectors into one big bitmask of size (nW + 1) * nR!
        big_rows = []
        for by_r in a1_rows:
            # coeff_by_w[j] = R-mask for w_j (j=0..nW-1), coeff_by_w[nW] = R-mask for const 1
            c_by_w = [0] * (nW + 1)
            for rm, wms in by_r.items():
                if rm == 0: continue
                for wm in wms:
                    if wm == 0: c_by_w[nW] ^= rm
                    else: c_by_w[wm.bit_length() - 1] ^= rm
            big = 0
            for j in range(nW + 1):
                x = c_by_w[j]
                while x:
                    b = x.bit_length() - 1
                    if b in a0_piv: x ^= a0_piv[b]
                    else: break
                # Wait: to properly reduce mod a0_piv, check all bits!
                x = c_by_w[j]
                for b in sorted(a0_piv.keys(), reverse=True):
                    if (x >> b) & 1: x ^= a0_piv[b]
                if x:
                    big |= (x << (j * nR))
            big_rows.append(big)
        rk_big, nulls_big = gf2_rank_and_left_nullspace(big_rows, (nW + 1) * nR)
        print(f"      CONSTANT syzygies of A_1(w) mod A_0 (pure W eqs after T=Q(W)!): {len(nulls_big)} (rank={rk_big}/{len(a1_rows)})", flush=True)

        # ALSO: Check how many R-columns are ZERO in A_1(w) mod A_0, AND check if A_1(w) is RANK-DEFICIENT
        # for EVERY w (i.e. check rank(A_0 U A_1(w)) at 10 random w)!
        rk01_list = []
        for wv in test_ws:
            ms = []
            for by_r in a0_rows + a1_rows:
                am = 0
                for rm, wms in by_r.items():
                    if rm != 0 and eval_wlist(wms, wv): am |= rm
                ms.append(am)
            rk01, _ = gf2_rank_and_left_nullspace(ms, nR)
            rk01_list.append(rk01)
        print(f"      rank([A_0; A_1(w)]) at w=0 + 10 random w: {rk01_list} (out of {nR} cols, {len(a0_rows)+len(a1_rows)} rows!)", flush=True)

    print(f"[{cell_name}] STEP 20 DONE ({time.perf_counter()-t0:.1f}s)", flush=True)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cells", type=str, default="B0_00,B0_11,B1_11")
    args = parser.parse_args()

    c_diag, so_diag = WORK_DIR / "s20_diag.c", WORK_DIR / "libs20_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s20_s9.c", WORK_DIR / "libs20_s9.so"
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

    c_cg, so_cg = WORK_DIR / "s20_cg.c", WORK_DIR / "libs20_cg.so"
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

    c_sh, so_sh = WORK_DIR / "s20_sh.c", WORK_DIR / "libs20_sh.so"
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
        run_step20_cell(
            cname, lib_diag, lib9, lib_cg, lib_sh, orbits, layer_vecs,
            v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl
        )


if __name__ == "__main__":
    main()
