#!/usr/bin/env python3
r"""
SOLVE_STEP23_EXTRACT_318_R3_SYZYGIES.py

IMMEDIATE FOLLOW-UP TO STEP 22B'S DISCOVERY:
  In Step 22B, R-only XL on the `degR=2, degW=0` block found:
    - B0_11: 318 R^3-cancelling syzygies (rank 9055 / 9373)!
    - B1_11:  43 R^3-cancelling syzygies (rank 10828 / 10871)!

STEP 23 EXTRACTS THE EXACT FULL POLYNOMIALS OF EVERY SINGLE ONE OF THOSE SYZYGIES
(ON B0_00, B0_11, B1_11) AND CHECKS:
  1. Do ANY of the 318 (B0_11) / 43 (B1_11) syzygies ALSO cancel their deg=4 terms
     (R^2*W^2, R*W^3), dropping BRAND-NEW degree <= 3 cubics/quads/linears?!
  2. If ANY degree <= 3 mutant drops (zero-trust verified on 10 random points!), feeds ALL
     new mutants directly into `run_branch_cascade` to see if the cell SHATTERS!
  3. Even for degree-4 syzygies, prints their exact (total_deg, max_degR, n_terms) profile
     AND tests if linear combinations of the 318 / 43 degree-4 syzygies cancel their deg-4
     terms (`deg4 -> deg3` mutant cascade!!).
  4. ALSO inspects the exact quadratic ranks of the 164/194 `degR=2, degW=0` rows and runs
     the same syzygy extraction on the `degR=2` + `degR=1` combined R-only XL!
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

C_SYZ_SRC = r"""
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

// Incremental GF(2) echelonization with exact combination history bitvector!
// `rows` has `n_rows * n_words` uint64_t; `hist` has `n_rows * h_words` uint64_t.
// Before calling on `row_idx`, caller sets bit `row_idx` in `hist[row_idx]`.
// Returns pivot col >= 0 if independent, or -1 if reduced to 0 (then `hist[row_idx]` is the EXACT syzygy!).
int gf2_insert_with_hist(
    uint64_t *rows, uint64_t *hist,
    int row_idx, int n_words, int h_words,
    int *piv_row_for_col, int n_cols
) {
    uint64_t *r = rows + (size_t)row_idx * (size_t)n_words;
    uint64_t *h = hist + (size_t)row_idx * (size_t)h_words;
    for (int w = 0; w < n_words; w++) {
        while (r[w]) {
            int b = __builtin_ctzll(r[w]);
            int col = (w << 6) + b;
            if (col >= n_cols) return -1;
            int pr = piv_row_for_col[col];
            if (pr >= 0) {
                const uint64_t *p = rows + (size_t)pr * (size_t)n_words;
                const uint64_t *ph = hist + (size_t)pr * (size_t)h_words;
                for (int k = w; k < n_words; k++) r[k] ^= p[k];
                for (int k = 0; k < h_words; k++) h[k] ^= ph[k];
            } else {
                piv_row_for_col[col] = row_idx;
                return col;
            }
        }
    }
    return -1;
}
"""


def run_step23_cell(cell_name, lib_diag, lib9, lib_cg, lib_sh, lib_syz, orbits, layer_vecs,
                    v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl):
    t0 = time.perf_counter()
    print(f"\n==================== [{cell_name}] STEP 23: EXTRACT ALL R^3-CANCELLING SYZYGIES ====================", flush=True)
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
    target_em = 4 if cell_name == "B0_00" else 0
    ex_eta = [(eta_free[k], (target_em >> k) & 1) for k in range(len(eta_free))]
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
        orig_to_perm[oc] = pc; perm_to_orig[pc] = oc
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

    r_idx = {v: i for i, v in enumerate(R_vars)}
    r2_full, r3_full = [], []  # store (full_pset, r_part)
    for r_id, dr, dw, td in ech_meta:
        ps = s9.row_to_pset(std_ech, r_id, tbl)
        if dr == 2 and dw == 0:
            pairs = []
            for m in ps:
                if m.bit_count() == 2:
                    b0 = (m & -m).bit_length() - 1
                    b1 = (m ^ (1 << b0)).bit_length() - 1
                    if b0 in r_idx and b1 in r_idx:
                        i0, i1 = r_idx[b0], r_idx[b1]
                        pairs.append((i0, i1) if i0 < i1 else (i1, i0))
            r2_full.append((ps, pairs))
        elif dr == 3 and dw == 0:
            trips = []
            for m in ps:
                if m.bit_count() == 3:
                    vs = sorted(r_idx[b] for b in range(n) if (m >> b) & 1 and b in r_idx)
                    if len(vs) == 3: trips.append(tuple(vs))
            r3_full.append((ps, trips))

    # Inspect ranks of the individual R^2 quadratic forms!
    q_rk_hist = {}
    for _, pairs in r2_full:
        adj = {}
        for i0, i1 in pairs:
            adj[i0] = adj.get(i0, 0) ^ (1 << i1)
            adj[i1] = adj.get(i1, 0) ^ (1 << i0)
        piv = {}
        for row in adj.values():
            x = row
            while x:
                b = x.bit_length() - 1
                if b in piv: x ^= piv[b]
                else: piv[b] = x; break
        q_rk_hist[len(piv)] = q_rk_hist.get(len(piv), 0) + 1
    print(f"[{cell_name}] degR=2_W=0 ({len(r2_full)} rows, nR={nR}): R^2-form ranks = {dict(sorted(q_rk_hist.items()))}", flush=True)

    # Run R-only XL WITH FULL COMBINATION HISTORY!
    t2c = {}
    c_t = 0
    for i in range(nR):
        for j in range(i + 1, nR):
            for k in range(j + 1, nR):
                t2c[(i, j, k)] = c_t; c_t += 1
    n_tw = (c_t + 63) >> 6
    n_rxl_rows = len(r3_full) + len(r2_full) * nR
    h_words = (n_rxl_rows + 63) >> 6
    print(f"[{cell_name}] Running R-only XL with history: {n_rxl_rows} rows x {c_t} cols ({(n_rxl_rows*(n_tw+h_words)*8)/1e6:.1f} MB)...", flush=True)

    rxl_buf = (ctypes.c_uint64 * (n_rxl_rows * n_tw))()
    hist_buf = (ctypes.c_uint64 * (n_rxl_rows * h_words))()
    piv_rxl = (ctypes.c_int * c_t)(*([-1] * c_t))

    # Tag each row index -> (kind, base_idx, mult_r_var)
    row_tags = []
    syzygy_rows = []
    rc = 0
    for idx3, (ps, trips) in enumerate(r3_full):
        row_tags.append(("r3", idx3, -1))
        off = rc * n_tw
        for t in trips:
            col = t2c[t]; rxl_buf[off + (col >> 6)] ^= (1 << (col & 63))
        hist_buf[rc * h_words + (rc >> 6)] |= (1 << (rc & 63))
        if lib_syz.gf2_insert_with_hist(rxl_buf, hist_buf, rc, n_tw, h_words, piv_rxl, c_t) < 0:
            syzygy_rows.append(rc)
        rc += 1
    for ri_m in range(nR):
        rv_actual = R_vars[ri_m]
        for idx2, (ps, pairs) in enumerate(r2_full):
            row_tags.append(("r2", idx2, rv_actual))
            off = rc * n_tw
            for i0, i1 in pairs:
                if ri_m == i0 or ri_m == i1: continue
                t = tuple(sorted((i0, i1, ri_m)))
                col = t2c[t]; rxl_buf[off + (col >> 6)] ^= (1 << (col & 63))
            hist_buf[rc * h_words + (rc >> 6)] |= (1 << (rc & 63))
            if lib_syz.gf2_insert_with_hist(rxl_buf, hist_buf, rc, n_tw, h_words, piv_rxl, c_t) < 0:
                syzygy_rows.append(rc)
            rc += 1

    print(f"[{cell_name}] Found {len(syzygy_rows)} R^3-cancelling syzygies! Reconstructing FULL degree<=4 polynomials...", flush=True)

    # Reconstruct FULL polynomials of all syzygy_rows (storing deg4 part and deg<=3 part separately!)
    deg_hist = {}
    max_dr_hist = {}
    deg4_polys = []   # list of (deg4_set, full_pset)
    deg3_mutants = [] # full_pset of deg <= 3!

    for s_rc in syzygy_rows:
        # Decode history bits
        base_h = s_rc * h_words
        full_ps = set()
        n_terms_used = 0
        for w in range(h_words):
            v = hist_buf[base_h + w]
            while v:
                lb = v & -v
                r_src = (w << 6) + lb.bit_length() - 1
                v ^= lb
                n_terms_used += 1
                kind, bidx, rvar = row_tags[r_src]
                if kind == "r3":
                    full_ps.symmetric_difference_update(r3_full[bidx][0])
                else:
                    rm_bit = 1 << rvar
                    for m in r2_full[bidx][0]:
                        nm = m | rm_bit
                        if nm in full_ps: full_ps.remove(nm)
                        else: full_ps.add(nm)
        # Analyze reconstructed polynomial!
        if not full_ps:
            deg_hist[0] = deg_hist.get(0, 0) + 1
            continue
        max_d = max(m.bit_count() for m in full_ps)
        max_dr = max(sum(1 for b in R_vars if (m >> b) & 1) for m in full_ps)
        deg_hist[max_d] = deg_hist.get(max_d, 0) + 1
        max_dr_hist[max_dr] = max_dr_hist.get(max_dr, 0) + 1
        if max_d <= 3:
            deg3_mutants.append(full_ps)
        else:
            d4_part = frozenset(m for m in full_ps if m.bit_count() == 4)
            deg4_polys.append((d4_part, full_ps))

    print(f"[{cell_name}] RAW SYZYGY DEGREES: total_deg_hist={dict(sorted(deg_hist.items()))} | max_degR_hist={dict(sorted(max_dr_hist.items()))}", flush=True)
    print(f"[{cell_name}] DIRECT deg<=3 mutants: {len(deg3_mutants)} | deg=4 syzygies: {len(deg4_polys)}", flush=True)

    # NOW: Echelonize the deg=4 parts of `deg4_polys` to see if LINEAR COMBINATIONS of the deg=4 syzygies
    # CANCEL their deg=4 parts and drop EVEN MORE deg<=3 mutants!!
    if deg4_polys:
        d4_piv = {}  # lead_mon -> (d4_set, full_set)
        extra_deg3 = []
        n_zero = 0
        for d4s, fps in deg4_polys:
            cur_d4 = set(d4s)
            cur_f = set(fps)
            while cur_d4:
                lead = max(cur_d4)
                if lead in d4_piv:
                    pd4, pf = d4_piv[lead]
                    cur_d4 ^= pd4
                    cur_f ^= pf
                else:
                    d4_piv[lead] = (cur_d4, cur_f)
                    break
            else:
                if cur_f:
                    extra_deg3.append(cur_f)
                else:
                    n_zero += 1
        print(f"[{cell_name}] AFTER DEG-4 REDUCTION OF SYZYGIES: deg4_rank={len(d4_piv)}/{len(deg4_polys)}, zero={n_zero}, *** NEW deg<=3 MUTANTS DROPPED = {len(extra_deg3)} ***", flush=True)
        deg3_mutants.extend(extra_deg3)

    # ALSO check if any deg<=3 mutants are GENUINELY NEW (not already in span of work[0..M_eq]!)
    if deg3_mutants:
        # Echelonize `work` first, then insert `deg3_mutants`!
        # Wait: `work` is in sheared y-coords, and `deg3_mutants` are ALSO in sheared y-coords!
        tot_check = M_eq + len(deg3_mutants)
        chk_buf = (ctypes.c_uint64 * (tot_check * n_cw))()
        ctypes.memmove(chk_buf, work, M_eq * n_cw * 8)
        for i, ps in enumerate(deg3_mutants):
            s9.pset_to_row(ps, chk_buf, M_eq + i, tbl)
        cpiv = (ctypes.c_int * n_cols)(*([-1] * n_cols))
        for r in range(M_eq):
            lib9.gf2_echelon_insert_s9(chk_buf, r, n_cw, cpiv, n_cols)
        new_by_deg = {0: 0, 1: 0, 2: 0, 3: 0}
        for i in range(len(deg3_mutants)):
            pc = lib9.gf2_echelon_insert_s9(chk_buf, M_eq + i, n_cw, cpiv, n_cols)
            if pc >= 0:
                if pc == tbl["off0"]: new_by_deg[0] += 1
                elif pc >= tbl["off1"]: new_by_deg[1] += 1
                elif pc >= tbl["off2"]: new_by_deg[2] += 1
                else: new_by_deg[3] += 1
        print(f"[{cell_name}] *** GENUINELY NEW MUTANTS BEYOND CURRENT IDEAL (by deg 0,1,2,3): {new_by_deg} ***", flush=True)

        # If ANY genuinely new mutants exist, zero-trust verify them on 10 random points AND run cascade!
        if sum(new_by_deg.values()) > 0:
            # Verify every deg3_mutant vanishes on any point where work vanishes? No, just verify directly from syzygy!
            # Even better: feed `chk_buf[0..tot_check]` into run_branch_cascade (in y-coords, lin_pivs = eliminated vars)!
            # Keep lin_pivs = dummy eliminated vars outside active_now so run_branch_cascade knows active_now!
            y_lin_pivs = {v: (1 << v, 0) for v in range(n) if v not in active_now}
            res_new = s9.run_branch_cascade(
                lib9, chk_buf, [], list(range(tot_check)), y_lin_pivs, [], tbl,
                max_xl_rounds=20, verify_subst=True
            )
            print(f"[{cell_name}] *** CASCADE WITH NEW SYZYGY MUTANTS: closed_unsat={res_new['closed_unsat']} ({res_new.get('closed_by')}), "
                  f"N={res_new.get('N_active')}, q={res_new.get('n_quad_surviving')}, c={res_new.get('n_genuine_cubics')} ***", flush=True)

    print(f"[{cell_name}] STEP 23 DONE ({time.perf_counter()-t0:.1f}s)", flush=True)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cells", type=str, default="B0_00,B0_11,B1_11")
    args = parser.parse_args()

    c_diag, so_diag = WORK_DIR / "s23_diag.c", WORK_DIR / "libs23_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s23_s9.c", WORK_DIR / "libs23_s9.so"
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

    c_cg, so_cg = WORK_DIR / "s23_cg.c", WORK_DIR / "libs23_cg.so"
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

    c_sh, so_sh = WORK_DIR / "s23_sh.c", WORK_DIR / "libs23_sh.so"
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

    c_syz, so_syz = WORK_DIR / "s23_syz.c", WORK_DIR / "libs23_syz.so"
    c_syz.write_text(C_SYZ_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_syz), "-o", str(so_syz)], check=True)
    lib_syz = ctypes.CDLL(str(so_syz))
    lib_syz.gf2_insert_with_hist.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int,
    ]
    lib_syz.gf2_insert_with_hist.restype = ctypes.c_int

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
        run_step23_cell(
            cname, lib_diag, lib9, lib_cg, lib_sh, lib_syz, orbits, layer_vecs,
            v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl
        )


if __name__ == "__main__":
    main()
