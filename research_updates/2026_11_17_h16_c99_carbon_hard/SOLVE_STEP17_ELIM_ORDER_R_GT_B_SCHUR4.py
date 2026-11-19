#!/usr/bin/env python3
r"""
SOLVE_STEP17_ELIM_ORDER_R_GT_B_SCHUR4.py

EXPLOITS THE MASSIVE STEP 16 BREAKTHROUGH:
  Fixing Layer 1 (eta, 6 bits) + Layer 2b (deg_u=2, 45 bits) = 51 bits collapsed 100% (6/6) of
  BOTH B0_11 and B1_11 instantly to 1 = 0 WITH 56 VARIABLES STILL COMPLETELY FREE!!
  (And at k=40 of L2b, 5/6 closed and survivors exploded to 1,443..1,658 quadratics!)

STEP 17 USES ELIMINATION ORDER (R > B > A) ON ALL 388 CARLET-GUILLOT CUBICS + QUADS:
  - Partition the N_root = 109 variables by exact linear change of basis into:
      A = L1 (eta, 6 vars)
      B = L2b \ L1 (45 vars)
      R = complement (58 vars, deg_u <= 1)
  - Performs exact GF(2) echelonization in ELIMINATION ORDER R > B > A to extract:
      1. ALL polynomials depending PURELY on (A, B) (deg_R == 0 -> ZERO dependence on the 58 vars R!!),
      2. ALL polynomials that are LINEAR in R (deg_R == 1 -> linear equations in R with quad coeffs in A,B!),
      3. For fixed eta in A (all 64 states!), extracts the exact CLOSED polynomial system in ONLY
         45 VARIABLES B (deg_R == 0 quads & cubics!), and runs:
           - Full Degree-3 XL inside B (only C(45,3) = 14,190 cols!),
           - Full Degree-4 Schur-Complement XL inside B (only C(45,4) = 148,995 cols -> 35x smaller than N=104!!),
           - PLUS inspects the exact matrix M(b) of deg_R==1 equations (why did k=45 close 6/6 with 56 vars free?!).
"""

import argparse
import ctypes
import json
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

C_BASIS_CHANGE_SRC = r"""
#include <stddef.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

// Transform a batch of M degree<=3 polynomials from old variables x[0..N-1]
// to new variables y[0..N-1] given linear substitution x_i = c_i ^ sum_j T[i][j] y_j!
// T_mask_lo[i], T_mask_hi[i] store the N-bit mask of y_j in x_i; T_const[i] in {0,1}.
// Outputs into dst_rows using the SAME column table (N <= 111), where column ordering
// puts y[0] < y[1] < ... < y[N-1] (so putting R at indices 0..nR-1 makes R-containing
// monomials come FIRST in column order -> pure GF(2) echelon eliminates R automatically!!).
// Wait: in s9's column table:
//   deg 3: (i < j < k) lex ascending -> i=0 comes FIRST!
//   deg 2: (i < j) lex ascending -> i=0 comes FIRST!
//   deg 1: i=0..N-1
//   deg 0: const
// Notice: a monomial has deg_R == 0 iff ALL its variables are >= nR!
// Wait: in s9's table, a deg-3 monomial with i>=nR STILL comes BEFORE a deg-2 monomial with i<nR!
// So for TRUE elimination order (ALL R-monomials before ALL pure-AB monomials!), we just use
// a custom column map `col_perm[old_col]` when echelonizing in Python/C!
// Even simpler: transform into standard s9 format in new y-coordinates (super fast in C!),
// then in C echelonize with a priority column permutation that puts:
//   Group 0: deg_R == 3
//   Group 1: deg_R == 2
//   Group 2: deg_R == 1 (deg 3, then deg 2, then deg 1)
//   Group 3: deg_R == 0 (pure AB! deg 3, then deg 2, then deg 1, then deg 0)!

static inline void toggle_col(uint64_t *row, int col) {
    row[col >> 6] ^= (1ULL << (col & 63));
}

void transform_poly_batch_deg3(
    const uint64_t *src_rows,
    uint64_t *dst_rows,
    int n_rows, int n_cw, int n,
    int off2, int off1, int off0,
    const int *col2_base, const int *col3_base,
    const uint8_t *col_deg, const uint8_t *col_v0, const uint8_t *col_v1, const uint8_t *col_v2,
    const int *t_len, const int *t_vars, const int *t_const // t_vars[i*128 + k]
) {
    int n_cols = off0 + 1;
    // Precompute expansion of every pair (a < b) in new vars? No, just expand directly!
    // Wait: N <= 111, each row has ~40k terms, and t_len[i] can be ~20 -> naive triple expansion
    // of 40k * 20^3 would be slow!
    // SMART WAY: Use the inverse trick — NO! Even better: only ~50 of the 109 vars need to change,
    // OR pick a pivot basis so almost all vars of R are SINGLETONS (t_len == 1)!
    // YES! In GF(2), choosing a basis (A, B, R) where R = standard coordinate variables outside
    // the 51 pivot columns of (A, B) makes ALL 58 R-variables have t_len == 1, and ONLY the 51
    // (A, B) pivot columns expand into linear combinations of A, B, R!!
    // Even better: substitute ONE variable at a time? No — if we know x_p = y_p ^ (other vars) for
    // the 51 pivot columns of (A, B), we can apply 51 sequential in-place linear substitutions
    // via `subst_one_linear_var_batch` in 0.1 SECONDS TOTAL!!
    (void)src_rows; (void)dst_rows; (void)n_rows; (void)n_cw; (void)n;
    (void)off2; (void)off1; (void)off0; (void)col2_base; (void)col3_base;
    (void)col_deg; (void)col_v0; (void)col_v1; (void)col_v2; (void)t_len; (void)t_vars; (void)t_const;
}

// Fast GF(2) echelon insert using an arbitrary column permutation `perm_to_orig[pcol]` and `orig_to_perm[ocol]`!
// Actually even simpler: remap row bits from standard col order to perm col order in 0.05ms,
// then call standard gf2_echelon_insert_s9!
void remap_rows_by_perm(
    const uint64_t *src_rows, uint64_t *dst_rows,
    int n_rows, int n_cw, int n_cols, const int *orig_to_perm
) {
    memset(dst_rows, 0, (size_t)n_rows * (size_t)n_cw * sizeof(uint64_t));
    for (int r = 0; r < n_rows; r++) {
        const uint64_t *sr = src_rows + (size_t)r * n_cw;
        uint64_t *dr = dst_rows + (size_t)r * n_cw;
        for (int w = 0; w < n_cw; w++) {
            uint64_t v = sr[w];
            while (v) {
                int b = __builtin_ctzll(v);
                int oc = (w << 6) + b;
                v &= v - 1;
                if (oc < n_cols) {
                    int pc = orig_to_perm[oc];
                    dr[pc >> 6] ^= (1ULL << (pc & 63));
                }
            }
        }
    }
}
"""


def apply_invertible_linear_change_of_basis(lib9, buf, n_rows, active_vars, target_forms, tbl):
    """Given `target_forms` (list of independent masks supported on `active_vars`, len = K),
    perform an exact invertible triangular linear change of variables on `buf` so that:
      - `K` chosen pivot variables `piv_vars` become the new variables representing `target_forms`
        (specifically, old x_p = y_p ^ rest, so y_p == target_form_k(x)!),
      - ALL remaining `N - K` variables `R_vars` are UNTOUCHED!
    Uses sequential `subst_one_linear_var_batch` in C (~0.1s total!).
    Returns (piv_vars_for_forms, R_vars, exact_forward_map_for_verify)."""
    n = tbl["n"]
    n_cw = tbl["n_col_words"]
    mask64 = (1 << 64) - 1

    # RREF of target_forms (each is an int bitmask over 0..n-1)
    # Wait: to represent target_forms[0..K-1] as SINGLE variables y_{p_0}..y_{p_{K-1}},
    # put the K forms in full RREF (Gauss-Jordan)!
    # In full RREF, form k has pivot bit p_k, and NO OTHER form j != k has bit p_k!
    # Therefore, substituting x_{p_k} <- y_{p_k} ^ (rref_form_k ^ (1 << p_k)) SIMULTANEOUSLY
    # (or sequentially, because p_k does NOT appear in any other rref_form_j!!) maps:
    #   rref_form_k(x) = x_{p_k} ^ (rest_k(x_R))  -->  y_{p_k}!!
    # CHECK THAT!! Because in full RREF, rest_k ONLY involves non-pivot variables x_R!
    # So each substitution x_{p_k} <- y_{p_k} ^ rest_k(x_R) commutes with all others,
    # and we can just call `subst_one_linear_var_batch` ONCE per k=0..K-1!
    # Wait: `subst_one_linear_var_batch` replaces x_p by `m` (WITHOUT x_p in m!).
    # Here we want to replace x_p by `x_p ^ rest_k`!
    # Let's check if `subst_one_linear_var_batch` handles x_p -> x_p ^ rest_k?
    # NO! `subst_one_linear_var_batch` ELIMINATES x_p completely (assumes bit p is NOT in m!).
    # How to do x_p -> x_p ^ rest_k using ONLY pure C?
    # Easy! Write a 20-line C function `shearsubst_var_batch(p, rest_lo, rest_hi)` that replaces
    # x_p by (x_p ^ rest) in-place!
    pass


C_SHEAR_SRC = C_BASIS_CHANGE_SRC + r"""
// In-place shear substitution: x_p <- x_p ^ (sum_{j in rest} x_j) across n_rows polynomials of deg <= 3!
// Since p is NOT in rest:
//   - Any term NOT containing p is UNCHANGED!
//   - Linear term x_p: adds sum_{j in rest} x_j
//   - Quad term x_p * x_a: adds sum_{j in rest} x_j * x_a (where x_a * x_a = x_a!)
//   - Cubic term x_p * x_a * x_b: adds sum_{j in rest} x_j * x_a * x_b (deduping j==a or j==b!)
void shear_subst_var_batch(
    uint64_t *rows, int n_rows, int n_cw, int n,
    int off2, int off1, int off0,
    const int *col2_base, const int *col3_base,
    const uint8_t *col_deg, const uint8_t *col_v0, const uint8_t *col_v1, const uint8_t *col_v2,
    int p, uint64_t rest_lo, uint64_t rest_hi
) {
    int rlist[128], nr = 0;
    for (int j = 0; j < n; j++) {
        if (j == p) continue;
        int bit = (j < 64) ? (int)((rest_lo >> j) & 1ULL) : (int)((rest_hi >> (j - 64)) & 1ULL);
        if (bit) rlist[nr++] = j;
    }
    if (nr == 0) return;

    // Collect all columns containing p!
    int p_cols_cap = n * n;
    int *p_cols = (int *)malloc((size_t)p_cols_cap * sizeof(int));
    int np = 0;
    for (int c = 0; c < off0; c++) {
        uint8_t d = col_deg[c];
        if (d == 1 && col_v0[c] == p) p_cols[np++] = c;
        else if (d == 2 && (col_v0[c] == p || col_v1[c] == p)) p_cols[np++] = c;
        else if (d == 3 && (col_v0[c] == p || col_v1[c] == p || col_v2[c] == p)) p_cols[np++] = c;
    }

    // For each row, read ONLY columns containing p, and accumulate into a temp copy of row?
    // Even safer: since p is NOT in rlist, NO generated term contains p!
    // So reading columns containing p and XORing into columns NOT containing p NEVER interferes with reading!
    for (int r = 0; r < n_rows; r++) {
        uint64_t *row = rows + (size_t)r * n_cw;
        for (int idx = 0; idx < np; idx++) {
            int c = p_cols[idx];
            if (!((row[c >> 6] >> (c & 63)) & 1ULL)) continue;
            uint8_t d = col_deg[c];
            if (d == 1) {
                for (int k = 0; k < nr; k++) toggle_col(row, off1 + rlist[k]);
            } else if (d == 2) {
                int a = (col_v0[c] == p) ? col_v1[c] : col_v0[c];
                for (int k = 0; k < nr; k++) {
                    int j = rlist[k];
                    if (j == a) toggle_col(row, off1 + a);
                    else {
                        int u = (j < a) ? j : a, v = (j < a) ? a : j;
                        toggle_col(row, off2 + col2_base[u] + (v - u - 1));
                    }
                }
            } else if (d == 3) {
                int a, b;
                if (col_v0[c] == p) { a = col_v1[c]; b = col_v2[c]; }
                else if (col_v1[c] == p) { a = col_v0[c]; b = col_v2[c]; }
                else { a = col_v0[c]; b = col_v1[c]; }
                // a < b guaranteed
                for (int k = 0; k < nr; k++) {
                    int j = rlist[k];
                    if (j == a || j == b) {
                        toggle_col(row, off2 + col2_base[a] + (b - a - 1));
                    } else {
                        int u = j, v = a, w = b, t;
                        if (u > v) { t = u; u = v; v = t; }
                        if (v > w) { t = v; v = w; w = t; }
                        if (u > v) { t = u; u = v; v = t; }
                        toggle_col(row, col3_base[u * n + v] + (w - v - 1));
                    }
                }
            }
        }
    }
    free(p_cols);
}
"""


def run_step17_cell(cell_name, lib_diag, lib9, lib_cg, lib_sh, lib11, orbits, layer_vecs,
                    v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl):
    t0 = time.perf_counter()
    print(f"\n==================== [{cell_name}] STEP 17: ELIMINATION ORDER (R > B > A) + PURE-45-VAR SCHUR-D4 ====================", flush=True)
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

    # Extract L1 (eta) and L2b (deg_u=2) forms, projected modulo root["_lin_pivs"]!
    forms_L1 = s16.extract_forms_from_orb_vecs(cb111, layer_vecs["L1"][1], layer_vecs["L1"][0])
    forms_L2b = s16.extract_forms_from_orb_vecs(cb111, layer_vecs["L2b"][1], layer_vecs["L2b"][0])

    # Fix eta = state 0 (or in B0_00, ALSO test eta=20 [q=41] and eta=4 [q=17]!)
    eta_free = s16.reduce_forms_mod_pivs(forms_L1, root["_lin_pivs"])
    n_ef = len(eta_free)
    test_etas = [0, 4, 20] if cell_name == "B0_00" else [0, 1]

    cell_results = []
    for em in test_etas:
        ex = [(eta_free[k], (em >> k) & 1) for k in range(n_ef)]
        sr = s9.run_branch_cascade(
            lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
            ex, tbl, max_xl_rounds=20, verify_subst=False
        )
        if sr["closed_unsat"]:
            print(f"  [{cell_name}] eta={em}: CLOSED immediately!", flush=True)
            continue

        # Collect all surviving equations (quads + genuine cubics) in sr["_buf"]!
        eq_ids = list(sr["_quad_ids"]) + list(sr["_cub_ids"])
        M_eq = len(eq_ids)
        work = (ctypes.c_uint64 * (M_eq * n_cw))()
        for i, rid in enumerate(eq_ids):
            ctypes.memmove(ctypes.byref(work, i * n_cw * 8), ctypes.byref(sr["_buf"], rid * n_cw * 8), n_cw * 8)

        # Compute full RREF of L2b forms modulo sr["_lin_pivs"]!
        l2b_raw = s16.reduce_forms_mod_pivs(forms_L2b, sr["_lin_pivs"])
        rref_B = {}  # piv_bit -> mask
        for fm in l2b_raw:
            x = fm
            while x:
                b = x.bit_length() - 1
                if b in rref_B: x ^= rref_B[b]
                else:
                    # Back-substitute into existing rows so rref_B is full Gauss-Jordan RREF!
                    for ob in list(rref_B.keys()):
                        if (rref_B[ob] >> b) & 1:
                            rref_B[ob] ^= x
                    rref_B[b] = x
                    break

        B_piv_vars = sorted(rref_B.keys())
        B_set = set(B_piv_vars)
        active_now = sorted(i for i in range(n) if i not in sr["_lin_pivs"])
        R_vars = [v for v in active_now if v not in B_set]
        print(f"\n[{cell_name}] eta={em:0{n_ef}b}: N={len(active_now)}, |B|={len(B_piv_vars)}, |R|={len(R_vars)}, "
              f"quads={len(sr['_quad_ids'])}, cubics={len(sr['_cub_ids'])}", flush=True)

        # Apply exact invertible shear change of basis: x_p <- y_p ^ (rref_B[p] ^ (1<<p)) for each p in B_piv_vars!
        # After this, y_p == rref_B[p](x) (the B coordinates!), and y_r == x_r (the R coordinates!)!
        for p in B_piv_vars:
            rest = rref_B[p] ^ (1 << p)
            if rest:
                lib_sh.shear_subst_var_batch(
                    work, M_eq, n_cw, n, tbl["off2"], tbl["off1"], tbl["off0"],
                    tbl["col2_base"], tbl["col3_base"], tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"],
                    p, rest & mask64, rest >> 64
                )

        # ZERO-TRUST VERIFY the shear change of basis on 3 random points!
        import random
        rng = random.Random(20261119)
        for _ in range(3):
            y_mask = 0
            for v in active_now:
                if rng.getrandbits(1): y_mask |= (1 << v)
            # Compute corresponding x_mask: x_r = y_r; x_p = y_p ^ parity(rest & y)
            x_mask = y_mask
            for p in B_piv_vars:
                rest = rref_B[p] ^ (1 << p)
                if (rest & y_mask).bit_count() & 1:
                    x_mask ^= (1 << p)
            for chk in range(min(15, M_eq)):
                r_old = ctypes.cast(ctypes.byref(sr["_buf"], eq_ids[chk] * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
                r_new = ctypes.cast(ctypes.byref(work, chk * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
                vo = lib9.eval_row_s9(r_old, n_cw, tbl["off0"], tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"], x_mask & mask64, x_mask >> 64)
                vn = lib9.eval_row_s9(r_new, n_cw, tbl["off0"], tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"], y_mask & mask64, y_mask >> 64)
                assert vo == vn, f"SHEAR BASIS CHANGE ZERO-TRUST FAILED at chk={chk}!"

        # Build ELIMINATION ORDER permutation:
        # Priority key for each original column c in 0..off0:
        #   (3 - deg_R, 3 - total_deg, c) -> puts deg_R=3 FIRST, then deg_R=2, then deg_R=1, then deg_R=0 (pure B!) LAST!
        R_set = set(R_vars)
        col_keys = []
        col_degR = [0] * n_cols
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

        # Remap all M_eq rows into elimination order and echelonize!
        perm_buf = (ctypes.c_uint64 * (M_eq * n_cw))()
        lib_sh.remap_rows_by_perm(work, perm_buf, M_eq, n_cw, n_cols, orig_to_perm)
        piv_idx = (ctypes.c_int * n_cols)(*([-1] * n_cols))

        by_degR_and_deg = {}
        pure_B_rows = []  # (total_deg, list_of_orig_cols)
        degR1_rows = []
        for r in range(M_eq):
            pc = lib9.gf2_echelon_insert_s9(perm_buf, r, n_cw, piv_idx, n_cols)
            if pc < 0: continue
            oc = perm_to_orig[pc]
            dr = col_degR[oc]
            td = int(tbl["col_deg"][oc])
            key = f"degR={dr}_deg={td}"
            by_degR_and_deg[key] = by_degR_and_deg.get(key, 0) + 1
            if dr == 0:
                # Extract original columns of this PURE-B row!
                ocols = []
                for w in range(n_cw):
                    v = perm_buf[r * n_cw + w]
                    while v:
                        lb = v & -v
                        pcol = (w << 6) + (lb.bit_length() - 1)
                        ocols.append(perm_to_orig[pcol])
                        v ^= lb
                pure_B_rows.append((td, ocols))
            elif dr == 1:
                degR1_rows.append((td, r))

        print(f"  [{cell_name}] ELIMINATION ORDER (R > B) SPECTRUM: {json.dumps(by_degR_and_deg)}", flush=True)
        print(f"  [{cell_name}] PURE-B equations (ZERO dependence on all {len(R_vars)} vars of R!): {len(pure_B_rows)} | "
              f"LINEAR-in-R equations (deg_R == 1): {len(degR1_rows)}", flush=True)

        # NOW: If we have pure-B equations (or even run pure-B Schur-D4 on ALL pure-B equations in |B|<=46 vars!!):
        schur_B_res = None
        if len(pure_B_rows) >= 5 and len(B_piv_vars) <= 52:
            B_to_new = {bv: idx for idx, bv in enumerate(B_piv_vars)}
            NB = len(B_piv_vars)
            rc = lib11.s11_init(NB, 20000, ctypes.c_size_t(400_000_000))  # 1.6 GB arena — HUGE for NB=45!
            assert rc == 0
            quad_B_packed, cub_B_packed = [], []
            for td, ocols in pure_B_rows:
                pms = []
                for oc in ocols:
                    d = int(tbl["col_deg"][oc])
                    if d == 0: pms.append(0xFFFFFFFF)
                    elif d == 1: pms.append(s11.pack_mon_sorted([B_to_new[int(tbl["col_v0"][oc])]]))
                    elif d == 2:
                        idxs = sorted([B_to_new[int(tbl["col_v0"][oc])], B_to_new[int(tbl["col_v1"][oc])]])
                        pms.append(s11.pack_mon_sorted(idxs))
                    else:
                        idxs = sorted([B_to_new[int(tbl["col_v0"][oc])], B_to_new[int(tbl["col_v1"][oc])], B_to_new[int(tbl["col_v2"][oc])]])
                        pms.append(s11.pack_mon_sorted(idxs))
                arr = (ctypes.c_uint32 * len(pms))(*pms)
                lib11.s11_insert_le3_packed(arr, len(pms), 0)
                if td <= 2: quad_B_packed.append(pms)
                else: cub_B_packed.append(pms)

            # Multiply all pure-B quads by all pairs AND all pure-B cubics by all NB vars!
            dl = time.monotonic() + 45.0
            for pms in quad_B_packed:
                lib11.s11_mul_quad_by_all_pairs((ctypes.c_uint32 * len(pms))(*pms), len(pms), ctypes.c_double(dl))
            for pms in cub_B_packed:
                if lib11.s11_mul_cubic_by_all_vars((ctypes.c_uint32 * len(pms))(*pms), len(pms), ctypes.c_double(dl)):
                    break
            st = (ctypes.c_uint32 * 14)()
            lib11.s11_get_stats(st)
            schur_B_res = {
                "NB": NB, "n_pure_B_quads": len(quad_B_packed), "n_pure_B_cubs": len(cub_B_packed),
                "has_one": bool(st[0]), "piv4": int(st[1]),
                "low_pivs": list(st[2:6]), "mutants": list(st[6:10]), "arena_mb": int(st[10]),
            }
            lib11.s11_free()
            print(f"  [{cell_name}] PURE-B SCHUR-D4 (NB={NB}): {json.dumps(schur_B_res)}", flush=True)

        cell_results.append({
            "eta": em, "NB": len(B_piv_vars), "NR": len(R_vars),
            "elim_spectrum": by_degR_and_deg, "n_pure_B": len(pure_B_rows),
            "n_degR1": len(degR1_rows), "schur_B": schur_B_res,
        })

    print(f"[{cell_name}] STEP 17 SUMMARY ({time.perf_counter()-t0:.1f}s): {json.dumps(cell_results)}", flush=True)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cells", type=str, default="B0_00,B0_11,B1_11")
    args = parser.parse_args()

    c_diag, so_diag = WORK_DIR / "s17_diag.c", WORK_DIR / "libs17_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s17_s9.c", WORK_DIR / "libs17_s9.so"
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

    c_cg, so_cg = WORK_DIR / "s17_cg.c", WORK_DIR / "libs17_cg.so"
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

    c_sh, so_sh = WORK_DIR / "s17_sh.c", WORK_DIR / "libs17_sh.so"
    c_sh.write_text(C_SHEAR_SRC, encoding="utf-8")
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

    c_11, so_11 = WORK_DIR / "s17_schur.c", WORK_DIR / "libs17_schur.so"
    c_11.write_text(s11.C_SCHUR11_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_11), "-o", str(so_11)], check=True)
    lib11 = ctypes.CDLL(str(so_11))
    lib11.s11_init.argtypes = [ctypes.c_int, ctypes.c_uint32, ctypes.c_size_t]
    lib11.s11_init.restype = ctypes.c_int
    lib11.s11_insert_le3_packed.argtypes = [ctypes.POINTER(ctypes.c_uint32), ctypes.c_int, ctypes.c_int]
    lib11.s11_insert_le3_packed.restype = ctypes.c_int
    lib11.s11_mul_cubic_by_all_vars.argtypes = [ctypes.POINTER(ctypes.c_uint32), ctypes.c_int, ctypes.c_double]
    lib11.s11_mul_cubic_by_all_vars.restype = ctypes.c_int
    lib11.s11_mul_quad_by_all_pairs.argtypes = [ctypes.POINTER(ctypes.c_uint32), ctypes.c_int, ctypes.c_double]
    lib11.s11_mul_quad_by_all_pairs.restype = ctypes.c_int
    lib11.s11_get_stats.argtypes = [ctypes.POINTER(ctypes.c_uint32)]

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
        run_step17_cell(
            cname, lib_diag, lib9, lib_cg, lib_sh, lib11, orbits, layer_vecs,
            v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl
        )


if __name__ == "__main__":
    main()
