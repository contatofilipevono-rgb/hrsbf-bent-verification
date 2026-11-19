#!/usr/bin/env python3
r"""
SOLVE_STEP39B_B11_PENCIL_RANK_AND_Z16_EXACT.py

DISSECTS THE TWO HUGE DISCOVERIES FROM STEP 38A & 38D ON B1_11 AND B0_11:
  PART 1: EXACT BILINEAR PENCIL ANATOMY OF M_1(w) = M_0 + sum_{k} w_k * M_k
    - Why was REAL 10x-20x faster than RANDOM in Singular, and why did HIGH_FREQ jump B0_11 from free_W=6 to free_W=10?!
    - Computes exact GF(2) rank of M_0 and EVERY individual M_k (k=0..nW-1)!
    - Checks row-density, column-density, and common-kernel / block structure of {M_k}!
    - Tests GREEDY MAX-DEGREE / MAX-RANK variable ordering at k_fix = 36, 34, 32, 30, 28!
  PART 2: EXACT Z_16^* SUBGROUP CLOSURE PROOF (INCLUDING c_0 = c_{p[0]}!)
    - Prints the exact 2 root linear equations of B1_11 / B0_11 and verifies whether ALL 4
      nontrivial subgroups (<pi_15>, <pi_9>, <pi_7>, <pi_3>) close to 1 = 0!
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


def gf2_rank_rows(rows):
    piv = {}
    for r in rows:
        v = r
        while v:
            b = v.bit_length() - 1
            if b in piv:
                v ^= piv[b]
            else:
                piv[b] = v
                break
    return len(piv)


def run_cell(cell_name, lib_diag, lib9, lib_cg, lib_sh, orbits, layer_vecs, orb_tt_np,
             v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl):
    t0 = time.perf_counter()
    print(f"\n==================== [{cell_name}] STEP 39B: PENCIL RANK ANATOMY + EXACT Z_16* PROOF ====================", flush=True)
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
    print(f"  [{cell_name}] Root: N={111 - len(root['_lin_pivs'])}, q={len(root['_quad_ids'])}, cub={len(root['_cub_ids'])}", flush=True)

    # ---------------- PART 2 (FIRST, FAST!): EXACT Z_16^* SUBGROUP CLOSURE PROOF ----------------
    print(f"\n  --- PART 2: EXACT Z_16^* SUBGROUP PROOF (WITH EXACT c_0 = c_{{p[0]}}) ---", flush=True)
    for lp, (pm, pr) in sorted(root["_lin_pivs"].items()):
        vs = [free111[b] for b in range(111) if (pm >> b) & 1]
        print(f"    Root lin_piv {lp} (orb {free111[lp]}): rhs={pr}, wt={len(vs)}, orbs={vs[:12]}{'...' if len(vs)>12 else ''}", flush=True)

    orb_of_mon = {m: j for j, orb in enumerate(orbits) for m in orb}
    def perm_mon(m, k):
        out = 0
        for i in range(16):
            if (m >> i) & 1: out |= (1 << ((k * i) & 15))
        return out
    perms = {k: [orb_of_mon[perm_mon(orbits[j][0], k)] for j in range(116)] for k in [1, 3, 5, 7, 9, 11, 13, 15]}
    orb_to_111 = {j: i for i, j in enumerate(free111)}
    # Express c_0 as (mask111, rhs) since c_0 = c_99 + sum_{j in L\{0}} c_j
    c0_mask = sum((1 << i) for i in L_vars_py)
    c0_rhs = c99

    def exact_sg_eqs(gens):
        eqs = []
        for k in gens:
            p = perms[k]
            # For EVERY orbit j in 0..115, enforce c_j == c_{p[j]}!
            for j in range(116):
                jp = p[j]
                if j == jp: continue
                # Express c_j and c_{jp} as (mask, const)
                def expr_of(o):
                    if o in orb_to_111: return (1 << orb_to_111[o]), 0
                    if o == 0: return c0_mask, c0_rhs
                    if o == 99: return 0, c99
                    if o == 57: return 0, c57
                    if o == 113: return 0, c113
                    if o == 115: return 0, 0
                    raise ValueError(o)
                m1, r1 = expr_of(j)
                m2, r2 = expr_of(jp)
                dm, dr = m1 ^ m2, r1 ^ r2
                if dm or dr:
                    eqs.append((dm, dr))
        return eqs

    for sg_name, gens in [
        ("G=Z_16* (ord 8)", [3, 15]),
        ("<pi_3>  (ord 4)", [3]),
        ("<pi_5>  (ord 4)", [5]),
        ("<pi_15> (palin)", [15]),
        ("<pi_9>  (ord 2)", [9]),
        ("<pi_7>  (ord 2)", [7]),
    ]:
        eqs = exact_sg_eqs(gens)
        # First check PURE LINEAR consistency with root["_lin_pivs"]!
        piv = dict(root["_lin_pivs"])
        lin_contra = False
        for dm, dr in eqs:
            v, r = dm, dr
            while v:
                b = v.bit_length() - 1
                if b in piv:
                    pv, pr = piv[b]; v ^= pv; r ^= pr
                else:
                    piv[b] = (v, r); break
            else:
                if r == 1:
                    lin_contra = True; break
        if lin_contra:
            print(f"    [{sg_name}] -> *** LINEAR CONTRADICTION (1 = 0) WITH ROOT LINEAR EQUATIONS! ***", flush=True)
        else:
            sub = s9.run_branch_cascade(
                lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
                eqs, tbl, max_xl_rounds=20, verify_subst=True
            )
            if sub["closed_unsat"]:
                print(f"    [{sg_name}] -> *** CLOSED UNSAT (1 = 0) BY CASCADE! ***", flush=True)
            else:
                qps = [s9.row_to_pset(sub["_buf"], qr, tbl) for qr in sub["_quad_ids"]]
                ana = s16.analyze_quad_system(qps)
                dimW = len(s19.strict_rref_masks(list(ana["W_piv"].values())))
                print(f"    [{sg_name}] -> OPEN: N={111 - len(sub['_lin_pivs'])}, q={len(sub['_quad_ids'])}, cub={len(sub['_cub_ids'])}, dimW={dimW}", flush=True)

    # ---------------- PART 1: EXACT BILINEAR PENCIL ANATOMY OF M_1(w) ----------------
    print(f"\n  --- PART 1: EXACT BILINEAR PENCIL ANATOMY M_1(w) = M_0 + sum w_k M_k ({cell_name}) ---", flush=True)
    forms_L1 = s16.extract_forms_from_orb_vecs(cb111, layer_vecs["L1"][1], layer_vecs["L1"][0])
    eta_free = s16.reduce_forms_mod_pivs(forms_L1, root["_lin_pivs"])
    ex_eta = [(eta_free[k], 0) for k in range(len(eta_free))]
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
                if v in R_set: rmask |= (1 << v)
        if rmask: tail_forms.append(rmask)
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
    for pc, (_, _, _, oc) in enumerate(col_keys): orig_to_perm[oc] = pc; perm_to_orig[pc] = oc
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

    w_idx = {v: i for i, v in enumerate(W_pivs)}
    rf_idx = {v: i for i, v in enumerate(RF_vars)}

    M1_rows = []
    for r_id, (drf, dt_c, _) in ech_rows:
        if drf == 1 and dt_c == 0:
            M1_rows.append(s9.row_to_pset(std_ech, r_id, tbl))
    nM = len(M1_rows)
    # Build M_0 and M_k (k=0..nW-1) as lists of nM bitmasks (each of width nRF)!
    M0 = [0] * nM
    Mk = [[0] * nM for _ in range(nW)]
    for ri, ps in enumerate(M1_rows):
        for m in ps:
            vs = [b for b in range(n) if (m >> b) & 1]
            rfvs = [rf_idx[v] for v in vs if v in RF_set]
            if len(rfvs) != 1: continue
            rfi = rfvs[0]
            wvs = [w_idx[v] for v in vs if v in w_idx]
            if len(wvs) == 0:
                M0[ri] ^= (1 << rfi)
            elif len(wvs) == 1:
                Mk[wvs[0]][ri] ^= (1 << rfi)

    rk0 = gf2_rank_rows(M0)
    rks = [gf2_rank_rows(Mk[k]) for k in range(nW)]
    wts = [sum(r.bit_count() for r in Mk[k]) for k in range(nW)]
    rk_hist = {}
    for rk in rks: rk_hist[rk] = rk_hist.get(rk, 0) + 1
    print(f"    M1 shape = {nM} x {nRF} | rank(M_0) = {rk0} | individual rank(M_k) hist = {dict(sorted(rk_hist.items()))}", flush=True)
    print(f"    Per-w_k (idx, rank, nnz) sorted by rank: {sorted([(k, rks[k], wts[k]) for k in range(nW)], key=lambda t: (t[1], t[2]))[:12]}", flush=True)
    print(f"    Top-10 highest-rank M_k: {sorted([(k, rks[k], wts[k]) for k in range(nW)], key=lambda t: (-t[1], -t[2]))[:10]}", flush=True)

    # Also check how many M1 rows depend ONLY on a small subset of W-vars (degree in W of each M1 row)!
    row_w_supps = []
    for ri in range(nM):
        wm = 0
        for k in range(nW):
            if Mk[k][ri] != 0: wm |= (1 << k)
        row_w_supps.append(wm)
    supp_lens = [wm.bit_count() for wm in row_w_supps]
    print(f"    M1 row W-support sizes: min={min(supp_lens)}, median={sorted(supp_lens)[nM//2]}, max={max(supp_lens)}, top10_smallest={sorted(supp_lens)[:10]}", flush=True)

    # Greedy variable order: iteratively pick w_k that maximizes the number of M1 rows whose W-support becomes <= 0 (fully linearized in R_free!)
    # Wait: even better, maximize sum of 2^{-rem_w} so small-support rows get linearized FIRST!
    rem_supps = list(row_w_supps)
    chosen = []
    used = set()
    for step in range(nW):
        best_k, best_sc = -1, -1.0
        for k in range(nW):
            if k in used: continue
            bit = 1 << k
            sc = 0.0
            for wm in rem_supps:
                if wm & bit:
                    c = wm.bit_count()
                    sc += (1000.0 if c == 1 else (10.0 if c == 2 else 1.0 / c))
            if sc > best_sc:
                best_sc = sc; best_k = k
        chosen.append(best_k); used.add(best_k)
        bit = 1 << best_k
        rem_supps = [wm & ~bit for wm in rem_supps]
        lin_cnt = sum(1 for wm in rem_supps if wm == 0)
        if step + 1 in (10, 15, 20, 25, 30, 32, 34, 36, 38):
            print(f"    Greedy linearize step {step+1:2d} (free_W={nW-step-1:2d}): fully_linear_M1_rows = {lin_cnt}/{nM}", flush=True)

    # Test this GREEDY order on k_fix = 36, 34, 32, 30, 28 (4 random trials each)!
    W_forms = [W_rref[p] for p in W_pivs]
    rng_g = random.Random(393939)
    print(f"    [Testing GREEDY-LINEARIZE order on {cell_name}]", flush=True)
    for k_fix in [36, 34, 32, 30, 28]:
        n_cl = 0
        min_N, max_q = 999, 0
        for tr in range(4):
            wb = rng_g.getrandbits(nW)
            ex_w = [(W_forms[chosen[j]], (wb >> j) & 1) for j in range(k_fix)]
            sub = s9.run_branch_cascade(
                lib9, sr["_buf"], sr["_quad_ids"], sr["_cub_ids"], sr["_lin_pivs"],
                ex_w, tbl, max_xl_rounds=15, verify_subst=(tr == 0 and k_fix == 34)
            )
            if sub["closed_unsat"]: n_cl += 1
            else:
                min_N = min(min_N, 111 - len(sub["_lin_pivs"]))
                max_q = max(max_q, len(sub["_quad_ids"]))
        print(f"      GREEDY k_fix={k_fix:2d} (free_W={nW-k_fix:2d}): CLOSED={n_cl}/4 | open_min_N={min_N}, open_max_q={max_q}", flush=True)
        if n_cl == 0 and k_fix <= 30:
            break

    print(f"[{cell_name}] STEP 39B DONE ({time.perf_counter()-t0:.1f}s)", flush=True)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cells", type=str, default="B1_11,B0_11")
    args = parser.parse_args()

    c_diag, so_diag = WORK_DIR / "s39b_diag.c", WORK_DIR / "libs39b_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s39b_s9.c", WORK_DIR / "libs39b_s9.so"
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

    c_cg, so_cg = WORK_DIR / "s39b_cg.c", WORK_DIR / "libs39b_cg.so"
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

    c_sh, so_sh = WORK_DIR / "s39b_sh.c", WORK_DIR / "libs39b_sh.so"
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
        run_cell(
            cname, lib_diag, lib9, lib_cg, lib_sh, orbits, layer_vecs, orb_tt_np,
            v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl
        )


if __name__ == "__main__":
    main()
