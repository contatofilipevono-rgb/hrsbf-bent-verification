#!/usr/bin/env python3
r"""
SOLVE_STEP63B_MAC_D4_AND_DEEP_XL_SHATTER.py

MATHEMATICAL FRONT B — THREE HIGH-LEVERAGE ALGEBRAIC CLOSURE ENGINES:

  TARGET 1 — EXACT PURE-u_1 DEGREE-3 & DEGREE-4 MACAULAY ON `rK=0` SYZYGIES:
    - Records the exact point-independent replay tape of the un-quotiented nRF=40 cascade
      (`M1_strict + Lin(A3+D) + SysB + Strict Block-B` -> `final_rK == 0`), harvesting ALL
      pure-u_1 syzygies (`P0`, `V_00`, `rK0_lin`, `rK0_BlockB`).
    - Evaluates all harvested syzygies on the full Hamming ball B(0, 4) in F_2^{d1}
      (N4 <= 31,931 for d1 <= 30), runs an exact bit-packed C Mobius transform to recover
      their exact degree-<=4 ANF truncations f^{(<=D)}, and computes the exact GF(2) right
      nullspace of (E_ver ^ E_ver^{(<=D)}) (double-verified on 256 independent points!) to
      extract the COMPLETE subspace of degree-<=1, <=2, <=3, <=4 polynomials in span(syz)!
    - Runs exact Boolean-ring Degree-3 AND Degree-4 Macaulay RREF (`MAC_D3` / `MAC_D4`) in C
      directly inside F_2[u_1] (total cols <= 31,931!) to test direct `1 = 0` closure at
      k_fix = 14..18 (B0_11) and k_fix = 25 (B1_11).
    - ZERO-TRUST AUDIT: Verifies C Mobius/eval on synthetic deg-4 polynomials, verifies 0
      mismatches on 10/10 planted solutions, and runs the full extraction + MAC_D4 on a
      planted-shifted fiber asserting 0 false `1=0` and 0 violated derived polynomials!

  TARGET 2 — DEEP IN-C ITERATIVE `MAC_D3` (`ir1..ir6`) + `41A_Flag` vs `U1_joint`:
    - Moves the entire `MAC_D3` variable-multiplication & quadratic-bootstrap loop into C
      (O(1) monomial indexing, ~10x faster than Python), running up to 6 inner bootstrap
      rounds (cap 400 new quadratics/round) inside an outer `MAC_D3 <-> s9` loop!
    - Directly compares `U1_joint` vs `41A_Flag` on:
        * B1_11 (eta=3, 0, 8, 10) at d1=22 (k_fix=23) and d1=24 (k_fix=21)
        * B0_11 (eta=5, 0, 9)     at d1=26 (k_fix=18) and d1=28 (k_fix=16)

  TARGET 3 — TARGETED DEGREE-4 MACAULAY (`MAC_D4`) ON SHATTERED `c=0` QUADRATICS:
    - Fast in-C Subset-Variable Degree-4 Macaulay (`MAC_D4_SUBSET`) on open shattered
      pure-quadratic residuals (`N = 52..74, c = 0`): permutes the top-K highest-frequency
      variables to `0..K-1`, indexes all deg-4 monomials with >= 2 vars in `{0..K-1}` in
      O(1) (`M4(N,K) <= 165,000` cols), inserts all deg-<=3 Macaulay rows + `q_sub * C(K,2)`
      deg-4 rows `x_a x_b q_i`, and detects `1 = 0`, new linears, and new quadratics!
    - ZERO-TRUST AUDIT: Every `MAC_D3` and `MAC_D4` pass is verified on a planted solution!
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
import SOLVE_STEP40A_B11_COMMON_KERNEL_AND_DECOMPOSITION as s40a
import SOLVE_STEP45A_B000_PARALLEL_CLOSER as s45a
import SOLVE_STEP47B_ITERATIVE_SYSB_CASCADE as s47b
import SOLVE_STEP60A_DEEP_SHATTER_SINGULAR_CMSAT as s60a
import SOLVE_STEP60B_BLOCKB_BLOCKD_ALGEBRAIC_FEEDBACK as s60b
import SOLVE_STEP61A_EXTENDED_OPT_AND_ALGEBRAIC_CEILING as s61a


# =============================================================================
# UNIFIED FAST C ENGINE: MOBIUS BALL-4, DEEP MAC_D3, FULL & SUBSET MAC_D4
# =============================================================================

C_STEP63B_SRC = r"""
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

// -----------------------------------------------------------------------------
// 1. EXACT BIT-PACKED MOBIUS TRANSFORM ON HAMMING BALL B(0, 4) IN F_2^d
//    Ball layout:
//      idx 0                 : deg 0 (empty)
//      off1 .. off2-1        : deg 1 (a)               [d items]
//      off2 .. off3-1        : deg 2 (a < b)           [C(d,2) items]
//      off3 .. off4-1        : deg 3 (a < b < c)       [C(d,3) items]
//      off4 .. N4-1          : deg 4 (a < b < c < e)   [C(d,4) items]
// -----------------------------------------------------------------------------

static inline int idx2_d(int d, int a, int b) {
    return a * (d - 1) - (a * (a - 1)) / 2 + (b - a - 1);
}

static inline int idx3_d(const int *off3_a, int d, int a, int b, int c) {
    int m = d - 1 - a;
    int bp = b - a - 1;
    int cp = c - a - 1;
    return off3_a[a] + bp * m - (bp * (bp + 1)) / 2 + (cp - bp - 1);
}

void mobius_ball4_u64(const uint64_t *vals, uint64_t *anf, int d, int n_w) {
    int off1 = 1;
    int off2 = off1 + d;
    int off3 = off2 + (d * (d - 1)) / 2;
    int off4 = off3 + (d * (d - 1) * (d - 2)) / 6;

    int *off3_a = (int *)malloc((size_t)(d + 1) * sizeof(int));
    int acc3 = 0;
    for (int a = 0; a < d; a++) {
        off3_a[a] = acc3;
        int m = d - 1 - a;
        acc3 += (m * (m - 1)) / 2;
    }

    // deg 0
    memcpy(anf, vals, (size_t)n_w * sizeof(uint64_t));

    // deg 1: c_a = f(e_a) ^ c_0
    for (int a = 0; a < d; a++) {
        uint64_t *dst = anf + (size_t)(off1 + a) * n_w;
        const uint64_t *src = vals + (size_t)(off1 + a) * n_w;
        for (int w = 0; w < n_w; w++) dst[w] = src[w] ^ anf[w];
    }

    // deg 2: c_{ab} = f(e_{ab}) ^ c_a ^ c_b ^ c_0
    int p2 = 0;
    for (int a = 0; a < d; a++) {
        const uint64_t *ca = anf + (size_t)(off1 + a) * n_w;
        for (int b = a + 1; b < d; b++, p2++) {
            uint64_t *dst = anf + (size_t)(off2 + p2) * n_w;
            const uint64_t *src = vals + (size_t)(off2 + p2) * n_w;
            const uint64_t *cb = anf + (size_t)(off1 + b) * n_w;
            for (int w = 0; w < n_w; w++) dst[w] = src[w] ^ ca[w] ^ cb[w] ^ anf[w];
        }
    }

    // deg 3: c_{abc} = f(e_{abc}) ^ c_{ab} ^ c_{ac} ^ c_{bc} ^ c_a ^ c_b ^ c_c ^ c_0
    int p3 = 0;
    for (int a = 0; a < d; a++) {
        const uint64_t *ca = anf + (size_t)(off1 + a) * n_w;
        for (int b = a + 1; b < d; b++) {
            const uint64_t *cb = anf + (size_t)(off1 + b) * n_w;
            const uint64_t *cab = anf + (size_t)(off2 + idx2_d(d, a, b)) * n_w;
            for (int c = b + 1; c < d; c++, p3++) {
                uint64_t *dst = anf + (size_t)(off3 + p3) * n_w;
                const uint64_t *src = vals + (size_t)(off3 + p3) * n_w;
                const uint64_t *cc = anf + (size_t)(off1 + c) * n_w;
                const uint64_t *cac = anf + (size_t)(off2 + idx2_d(d, a, c)) * n_w;
                const uint64_t *cbc = anf + (size_t)(off2 + idx2_d(d, b, c)) * n_w;
                for (int w = 0; w < n_w; w++) {
                    dst[w] = src[w] ^ cab[w] ^ cac[w] ^ cbc[w] ^ ca[w] ^ cb[w] ^ cc[w] ^ anf[w];
                }
            }
        }
    }

    // deg 4: c_{abce} = f(e_{abce}) ^ sum(4 deg3) ^ sum(6 deg2) ^ sum(4 deg1) ^ c_0
    int p4 = 0;
    for (int a = 0; a < d; a++) {
        const uint64_t *ca = anf + (size_t)(off1 + a) * n_w;
        for (int b = a + 1; b < d; b++) {
            const uint64_t *cb = anf + (size_t)(off1 + b) * n_w;
            const uint64_t *cab = anf + (size_t)(off2 + idx2_d(d, a, b)) * n_w;
            for (int c = b + 1; c < d; c++) {
                const uint64_t *cc = anf + (size_t)(off1 + c) * n_w;
                const uint64_t *cac = anf + (size_t)(off2 + idx2_d(d, a, c)) * n_w;
                const uint64_t *cbc = anf + (size_t)(off2 + idx2_d(d, b, c)) * n_w;
                const uint64_t *cabc = anf + (size_t)(off3 + idx3_d(off3_a, d, a, b, c)) * n_w;
                for (int e = c + 1; e < d; e++, p4++) {
                    uint64_t *dst = anf + (size_t)(off4 + p4) * n_w;
                    const uint64_t *src = vals + (size_t)(off4 + p4) * n_w;
                    const uint64_t *ce = anf + (size_t)(off1 + e) * n_w;
                    const uint64_t *cae = anf + (size_t)(off2 + idx2_d(d, a, e)) * n_w;
                    const uint64_t *cbe = anf + (size_t)(off2 + idx2_d(d, b, e)) * n_w;
                    const uint64_t *cce = anf + (size_t)(off2 + idx2_d(d, c, e)) * n_w;
                    const uint64_t *cabe = anf + (size_t)(off3 + idx3_d(off3_a, d, a, b, e)) * n_w;
                    const uint64_t *cace = anf + (size_t)(off3 + idx3_d(off3_a, d, a, c, e)) * n_w;
                    const uint64_t *cbce = anf + (size_t)(off3 + idx3_d(off3_a, d, b, c, e)) * n_w;
                    for (int w = 0; w < n_w; w++) {
                        dst[w] = src[w]
                               ^ cabc[w] ^ cabe[w] ^ cace[w] ^ cbce[w]
                               ^ cab[w] ^ cac[w] ^ cbc[w] ^ cae[w] ^ cbe[w] ^ cce[w]
                               ^ ca[w] ^ cb[w] ^ cc[w] ^ ce[w] ^ anf[w];
                    }
                }
            }
        }
    }
    free(off3_a);
}

// Evaluate degree-<=max_deg ANF (bit-packed across n_w uint64 words) at S points U[S * d]
void eval_anf_ball4_u64(const uint64_t *anf, const uint8_t *U, int S, int d,
                        int n_w, int max_deg, uint64_t *out) {
    int off1 = 1;
    int off2 = off1 + d;
    int off3 = off2 + (d * (d - 1)) / 2;
    int off4 = off3 + (d * (d - 1) * (d - 2)) / 6;

    int *off3_a = (int *)malloc((size_t)(d + 1) * sizeof(int));
    int acc3 = 0;
    for (int a = 0; a < d; a++) {
        off3_a[a] = acc3;
        int m = d - 1 - a;
        acc3 += (m * (m - 1)) / 2;
    }

    int *off4_ab = NULL;
    if (max_deg >= 4) {
        off4_ab = (int *)malloc((size_t)(d * d) * sizeof(int));
        int acc4 = 0;
        for (int a = 0; a < d; a++) {
            for (int b = a + 1; b < d; b++) {
                off4_ab[a * d + b] = acc4;
                int m = d - 1 - b;
                acc4 += (m * (m - 1)) / 2;
            }
        }
    }

    int ones[64];
    for (int s = 0; s < S; s++) {
        const uint8_t *u = U + (size_t)s * d;
        uint64_t *dst = out + (size_t)s * n_w;
        memcpy(dst, anf, (size_t)n_w * sizeof(uint64_t)); // deg 0
        int wt = 0;
        for (int i = 0; i < d; i++) {
            if (u[i]) ones[wt++] = i;
        }
        if (max_deg >= 1) {
            for (int ia = 0; ia < wt; ia++) {
                const uint64_t *p = anf + (size_t)(off1 + ones[ia]) * n_w;
                for (int w = 0; w < n_w; w++) dst[w] ^= p[w];
            }
        }
        if (max_deg >= 2) {
            for (int ia = 0; ia < wt; ia++) {
                int a = ones[ia];
                for (int ib = ia + 1; ib < wt; ib++) {
                    int b = ones[ib];
                    const uint64_t *p = anf + (size_t)(off2 + idx2_d(d, a, b)) * n_w;
                    for (int w = 0; w < n_w; w++) dst[w] ^= p[w];
                }
            }
        }
        if (max_deg >= 3) {
            for (int ia = 0; ia < wt; ia++) {
                int a = ones[ia];
                for (int ib = ia + 1; ib < wt; ib++) {
                    int b = ones[ib];
                    for (int ic = ib + 1; ic < wt; ic++) {
                        int c = ones[ic];
                        const uint64_t *p = anf + (size_t)(off3 + idx3_d(off3_a, d, a, b, c)) * n_w;
                        for (int w = 0; w < n_w; w++) dst[w] ^= p[w];
                    }
                }
            }
        }
        if (max_deg >= 4) {
            for (int ia = 0; ia < wt; ia++) {
                int a = ones[ia];
                for (int ib = ia + 1; ib < wt; ib++) {
                    int b = ones[ib];
                    int base_ab = off4 + off4_ab[a * d + b];
                    int m = d - 1 - b;
                    for (int ic = ib + 1; ic < wt; ic++) {
                        int c = ones[ic];
                        int cp = c - b - 1;
                        int base_abc = base_ab + cp * m - (cp * (cp + 1)) / 2;
                        for (int ie = ic + 1; ie < wt; ie++) {
                            int e = ones[ie];
                            int idx = base_abc + (e - c - 1);
                            const uint64_t *p = anf + (size_t)idx * n_w;
                            for (int w = 0; w < n_w; w++) dst[w] ^= p[w];
                        }
                    }
                }
            }
        }
    }

    free(off3_a);
    if (off4_ab) free(off4_ab);
}

// -----------------------------------------------------------------------------
// 2. FAST GF(2) ECHELON INSERTION HELPER
// -----------------------------------------------------------------------------

static inline int gf2_insert_row_inline(uint64_t *piv_rows, int *col_to_row,
                                        int n_piv_slots, int max_pivs,
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
                if (n_piv_slots >= max_pivs) return -2; // table full
                col_to_row[c] = n_piv_slots;
                memcpy(piv_rows + (size_t)n_piv_slots * n_cw, row, (size_t)n_cw * sizeof(uint64_t));
                return c;
            }
        }
    }
    return -1;
}

// -----------------------------------------------------------------------------
// 3. DEEP IN-C DEGREE-3 MACAULAY WITH QUADRATIC BOOTSTRAP (`ir1..ir_max`)
//    Columns: deg3 (0..off2-1), deg2 (off2..off1-1), deg1 (off1..off0-1), deg0 (off0)
// -----------------------------------------------------------------------------

static inline void sort3(int *x, int *y, int *z) {
    if (*x > *y) { int t = *x; *x = *y; *y = t; }
    if (*y > *z) { int t = *y; *y = *z; *z = t; }
    if (*x > *y) { int t = *x; *x = *y; *y = t; }
}

static inline void sort4(int *a, int *b, int *c, int *d) {
    if (*a > *b) { int t = *a; *a = *b; *b = t; }
    if (*c > *d) { int t = *c; *c = *d; *d = t; }
    if (*a > *c) { int t = *a; *a = *c; *c = t; }
    if (*b > *d) { int t = *b; *b = *d; *d = t; }
    if (*b > *c) { int t = *b; *b = *c; *c = t; }
}

int mac_d3_deep_c(
    int N, int n_polys,
    const int *poly_off, const uint8_t *t_deg,
    const uint8_t *t_v0, const uint8_t *t_v1, const uint8_t *t_v2,
    int max_ir, int max_boot_q,
    uint64_t *piv_rows, int *col_to_row, int max_pivs,
    int *lin_slots, int *out_n_lin,
    int *quad_slots, int *out_n_quad,
    int *ir_dq, int *ir_dl, int *ir_rk, int *out_n_ir,
    int *out_n_pivs
) {
    int n3 = (N * (N - 1) * (N - 2)) / 6;
    int n2 = (N * (N - 1)) / 2;
    int off2 = n3;
    int off1 = off2 + n2;
    int off0 = off1 + N;
    int n_cols = off0 + 1;
    int n_cw = (n_cols + 63) / 64;

    int *off3_a = (int *)malloc((size_t)(N + 1) * sizeof(int));
    int acc3 = 0;
    for (int a = 0; a < N; a++) {
        off3_a[a] = acc3;
        int m = N - 1 - a;
        acc3 += (m * (m - 1)) / 2;
    }

    // Inverse map for deg-2 cols
    uint8_t *inv2_a = (uint8_t *)malloc((size_t)(n2 + 1));
    uint8_t *inv2_b = (uint8_t *)malloc((size_t)(n2 + 1));
    int p2 = 0;
    for (int a = 0; a < N; a++) {
        for (int b = a + 1; b < N; b++, p2++) {
            inv2_a[p2] = (uint8_t)a;
            inv2_b[p2] = (uint8_t)b;
        }
    }

    uint64_t *work = (uint64_t *)malloc((size_t)n_cw * sizeof(uint64_t));
    int n_pivs = 0;
    int n_lin = 0;
    int n_quad = 0;
    int hit_1eq0 = 0;

    // Step 0: insert all input polynomials; collect deg<=2 indices for ir1
    int *init_d2 = (int *)malloc((size_t)(n_polys + 1) * sizeof(int));
    int n_init_d2 = 0;

    for (int pi = 0; pi < n_polys && !hit_1eq0; pi++) {
        memset(work, 0, (size_t)n_cw * sizeof(uint64_t));
        int s = poly_off[pi], e = poly_off[pi + 1];
        int md = 0;
        for (int ti = s; ti < e; ti++) {
            int dg = t_deg[ti];
            if (dg > md) md = dg;
            int col;
            if (dg == 0) col = off0;
            else if (dg == 1) col = off1 + t_v0[ti];
            else if (dg == 2) col = off2 + idx2_d(N, t_v0[ti], t_v1[ti]);
            else col = idx3_d(off3_a, N, t_v0[ti], t_v1[ti], t_v2[ti]);
            work[col >> 6] ^= (1ULL << (col & 63));
        }
        int pc = gf2_insert_row_inline(piv_rows, col_to_row, n_pivs, max_pivs, work, n_cw, n_cols);
        if (pc >= 0) {
            int slot = n_pivs++;
            if (pc == off0) hit_1eq0 = 1;
            else if (pc >= off1) lin_slots[n_lin++] = slot;
        }
        if (md <= 2) init_d2[n_init_d2++] = pi;
    }

    // Inner bootstrap rounds
    int n_ir_done = 0;
    int prev_q_start = 0;
    // Temp buffer to unpack a deg<=2 pivot row
    int max_q_terms = n2 + N + 2;
    uint8_t *u_deg = (uint8_t *)malloc((size_t)max_q_terms);
    uint8_t *u_v0 = (uint8_t *)malloc((size_t)max_q_terms);
    uint8_t *u_v1 = (uint8_t *)malloc((size_t)max_q_terms);

    for (int ir = 0; ir < max_ir && !hit_1eq0; ir++) {
        int q_before = n_quad;
        int l_before = n_lin;

        if (ir == 0) {
            for (int ii = 0; ii < n_init_d2 && !hit_1eq0; ii++) {
                int pi = init_d2[ii];
                int s = poly_off[pi], e = poly_off[pi + 1];
                for (int xk = 0; xk < N && !hit_1eq0; xk++) {
                    memset(work, 0, (size_t)n_cw * sizeof(uint64_t));
                    for (int ti = s; ti < e; ti++) {
                        int dg = t_deg[ti];
                        int col;
                        if (dg == 0) {
                            col = off1 + xk;
                        } else if (dg == 1) {
                            int v0 = t_v0[ti];
                            if (v0 == xk) col = off1 + xk;
                            else col = off2 + idx2_d(N, v0 < xk ? v0 : xk, v0 < xk ? xk : v0);
                        } else {
                            int v0 = t_v0[ti], v1 = t_v1[ti];
                            if (xk == v0 || xk == v1) {
                                col = off2 + idx2_d(N, v0, v1);
                            } else {
                                int a = v0, b = v1, c = xk;
                                sort3(&a, &b, &c);
                                col = idx3_d(off3_a, N, a, b, c);
                            }
                        }
                        work[col >> 6] ^= (1ULL << (col & 63));
                    }
                    int pc = gf2_insert_row_inline(piv_rows, col_to_row, n_pivs, max_pivs, work, n_cw, n_cols);
                    if (pc >= 0) {
                        int slot = n_pivs++;
                        if (pc == off0) hit_1eq0 = 1;
                        else if (pc >= off1) lin_slots[n_lin++] = slot;
                        else if (pc >= off2) quad_slots[n_quad++] = slot;
                    }
                }
            }
        } else {
            int q_end = q_before;
            if (q_end - prev_q_start > max_boot_q) q_end = prev_q_start + max_boot_q;
            if (prev_q_start >= q_end) break;

            for (int qi = prev_q_start; qi < q_end && !hit_1eq0; qi++) {
                int slot = quad_slots[qi];
                const uint64_t *prow = piv_rows + (size_t)slot * n_cw;
                int nt = 0;
                for (int w = off2 >> 6; w < n_cw; w++) {
                    uint64_t v = prow[w];
                    while (v) {
                        int b = __builtin_ctzll(v);
                        v &= v - 1;
                        int c = (w << 6) + b;
                        if (c < off2 || c >= n_cols) continue;
                        if (c < off1) {
                            u_deg[nt] = 2;
                            u_v0[nt] = inv2_a[c - off2];
                            u_v1[nt] = inv2_b[c - off2];
                            nt++;
                        } else if (c < off0) {
                            u_deg[nt] = 1;
                            u_v0[nt] = (uint8_t)(c - off1);
                            nt++;
                        } else {
                            u_deg[nt] = 0;
                            nt++;
                        }
                    }
                }
                for (int xk = 0; xk < N && !hit_1eq0; xk++) {
                    memset(work, 0, (size_t)n_cw * sizeof(uint64_t));
                    for (int ti = 0; ti < nt; ti++) {
                        int dg = u_deg[ti];
                        int col;
                        if (dg == 0) {
                            col = off1 + xk;
                        } else if (dg == 1) {
                            int v0 = u_v0[ti];
                            if (v0 == xk) col = off1 + xk;
                            else col = off2 + idx2_d(N, v0 < xk ? v0 : xk, v0 < xk ? xk : v0);
                        } else {
                            int v0 = u_v0[ti], v1 = u_v1[ti];
                            if (xk == v0 || xk == v1) {
                                col = off2 + idx2_d(N, v0, v1);
                            } else {
                                int a = v0, b = v1, c = xk;
                                sort3(&a, &b, &c);
                                col = idx3_d(off3_a, N, a, b, c);
                            }
                        }
                        work[col >> 6] ^= (1ULL << (col & 63));
                    }
                    int pc = gf2_insert_row_inline(piv_rows, col_to_row, n_pivs, max_pivs, work, n_cw, n_cols);
                    if (pc >= 0) {
                        int nslot = n_pivs++;
                        if (pc == off0) hit_1eq0 = 1;
                        else if (pc >= off1) lin_slots[n_lin++] = nslot;
                        else if (pc >= off2) quad_slots[n_quad++] = nslot;
                    }
                }
            }
            prev_q_start = q_before;
        }

        int dq = n_quad - q_before;
        int dl = n_lin - l_before;
        ir_dq[n_ir_done] = dq;
        ir_dl[n_ir_done] = dl;
        ir_rk[n_ir_done] = n_pivs;
        n_ir_done++;

        if (hit_1eq0 || dl >= 4 || dq == 0) break;
    }

    *out_n_lin = n_lin;
    *out_n_quad = n_quad;
    *out_n_ir = n_ir_done;
    *out_n_pivs = n_pivs;

    free(off3_a);
    free(inv2_a);
    free(inv2_b);
    free(work);
    free(init_d2);
    free(u_deg);
    free(u_v0);
    free(u_v1);
    return hit_1eq0;
}

// -----------------------------------------------------------------------------
// 4. UNIFIED FULL & SUBSET DEGREE-4 MACAULAY ENGINE IN C
//    Supports K == N (exact full MAC_D4 for N <= 32, deg<=4 inputs)
//    AND      K <  N (targeted subset MAC_D4 on N <= 74, deg<=3 inputs)
//    Columns:
//      0 .. off3-1       : deg 4 with 0 <= a < b < K, b < c < d < N
//      off3 .. off2-1    : deg 3 (all C(N, 3))
//      off2 .. off1-1    : deg 2 (all C(N, 2))
//      off1 .. off0-1    : deg 1 (N)
//      off0              : deg 0 (const)
// -----------------------------------------------------------------------------

int mac_d4_engine_c(
    int N, int K, int n_polys, int q_sub_limit,
    const int *poly_off, const uint8_t *t_deg,
    const uint8_t *t_v0, const uint8_t *t_v1, const uint8_t *t_v2, const uint8_t *t_v3,
    int do_d4_mults, int max_pivs,
    uint64_t *piv_rows, int *col_to_row,
    int *lin_slots, int *out_n_lin,
    int *quad_slots, int *out_n_quad,
    int *out_n_d3_new, int *out_n_pivs, int *out_n_cols, int *out_table_full
) {
    // Build deg-4 offset table for 0 <= a < b < K
    int *off4_ab = (int *)malloc((size_t)(K * K + 1) * sizeof(int));
    int n4 = 0;
    for (int a = 0; a < K; a++) {
        for (int b = a + 1; b < K; b++) {
            off4_ab[a * K + b] = n4;
            int m = N - 1 - b;
            n4 += (m * (m - 1)) / 2;
        }
    }
    int n3 = (N * (N - 1) * (N - 2)) / 6;
    int n2 = (N * (N - 1)) / 2;
    int off3 = n4;
    int off2 = off3 + n3;
    int off1 = off2 + n2;
    int off0 = off1 + N;
    int n_cols = off0 + 1;
    int n_cw = (n_cols + 63) / 64;
    *out_n_cols = n_cols;

    int *off3_a = (int *)malloc((size_t)(N + 1) * sizeof(int));
    int acc3 = 0;
    for (int a = 0; a < N; a++) {
        off3_a[a] = acc3;
        int m = N - 1 - a;
        acc3 += (m * (m - 1)) / 2;
    }

    uint64_t *work = (uint64_t *)malloc((size_t)n_cw * sizeof(uint64_t));
    int n_pivs = 0;
    int n_lin = 0;
    int n_quad = 0;
    int n_d3_new = 0;
    int hit_1eq0 = 0;
    int tbl_full = 0;

    int *d2_list = (int *)malloc((size_t)(n_polys + 1) * sizeof(int));
    int *d3_list = (int *)malloc((size_t)(n_polys + 1) * sizeof(int));
    int n_d2 = 0, n_d3 = 0;

    #define COL4(a, b, c, d) (off4_ab[(a) * K + (b)] + ((c) - (b) - 1) * (N - 1 - (b)) - (((c) - (b) - 1) * ((c) - (b))) / 2 + ((d) - (c) - 1))
    #define INSERT_WORK(is_init) do { \
        int pc = gf2_insert_row_inline(piv_rows, col_to_row, n_pivs, max_pivs, work, n_cw, n_cols); \
        if (pc == -2) { tbl_full = 1; } \
        else if (pc >= 0) { \
            int slot = n_pivs++; \
            if (pc == off0) hit_1eq0 = 1; \
            else if (pc >= off1) lin_slots[n_lin++] = slot; \
            else if (pc >= off2) { if (!(is_init)) quad_slots[n_quad++] = slot; } \
            else if (pc >= off3) { if (!(is_init)) n_d3_new++; } \
        } \
    } while (0)

    // 1. Insert all initial polynomials (deg <= 4)
    for (int pi = 0; pi < n_polys && !hit_1eq0 && !tbl_full; pi++) {
        memset(work, 0, (size_t)n_cw * sizeof(uint64_t));
        int s = poly_off[pi], e = poly_off[pi + 1];
        int md = 0;
        for (int ti = s; ti < e; ti++) {
            int dg = t_deg[ti];
            if (dg > md) md = dg;
            int col;
            if (dg == 0) col = off0;
            else if (dg == 1) col = off1 + t_v0[ti];
            else if (dg == 2) col = off2 + idx2_d(N, t_v0[ti], t_v1[ti]);
            else if (dg == 3) col = off3 + idx3_d(off3_a, N, t_v0[ti], t_v1[ti], t_v2[ti]);
            else col = COL4(t_v0[ti], t_v1[ti], t_v2[ti], t_v3[ti]);
            work[col >> 6] ^= (1ULL << (col & 63));
        }
        INSERT_WORK(1);
        if (md <= 2) d2_list[n_d2++] = pi;
        else if (md == 3) d3_list[n_d3++] = pi;
    }

    // 2. Multiply all deg<=2 polynomials by x_0..x_{N-1} (full MAC_D3 layer)
    for (int ii = 0; ii < n_d2 && !hit_1eq0 && !tbl_full; ii++) {
        int pi = d2_list[ii];
        int s = poly_off[pi], e = poly_off[pi + 1];
        for (int xk = 0; xk < N && !hit_1eq0 && !tbl_full; xk++) {
            memset(work, 0, (size_t)n_cw * sizeof(uint64_t));
            for (int ti = s; ti < e; ti++) {
                int dg = t_deg[ti];
                int col;
                if (dg == 0) col = off1 + xk;
                else if (dg == 1) {
                    int v0 = t_v0[ti];
                    if (v0 == xk) col = off1 + xk;
                    else col = off2 + idx2_d(N, v0 < xk ? v0 : xk, v0 < xk ? xk : v0);
                } else {
                    int v0 = t_v0[ti], v1 = t_v1[ti];
                    if (xk == v0 || xk == v1) col = off2 + idx2_d(N, v0, v1);
                    else {
                        int a = v0, b = v1, c = xk;
                        sort3(&a, &b, &c);
                        col = off3 + idx3_d(off3_a, N, a, b, c);
                    }
                }
                work[col >> 6] ^= (1ULL << (col & 63));
            }
            INSERT_WORK(0);
        }
    }

    // 3. Degree-4 layer
    if (do_d4_mults && !hit_1eq0 && !tbl_full) {
        // 3a. If K == N (full MAC_D4), multiply all deg==3 polynomials by x_0..x_{N-1}
        if (K == N) {
            for (int ii = 0; ii < n_d3 && !hit_1eq0 && !tbl_full; ii++) {
                int pi = d3_list[ii];
                int s = poly_off[pi], e = poly_off[pi + 1];
                for (int xk = 0; xk < N && !hit_1eq0 && !tbl_full; xk++) {
                    memset(work, 0, (size_t)n_cw * sizeof(uint64_t));
                    for (int ti = s; ti < e; ti++) {
                        int dg = t_deg[ti];
                        int col;
                        if (dg == 0) col = off1 + xk;
                        else if (dg == 1) {
                            int v0 = t_v0[ti];
                            if (v0 == xk) col = off1 + xk;
                            else col = off2 + idx2_d(N, v0 < xk ? v0 : xk, v0 < xk ? xk : v0);
                        } else if (dg == 2) {
                            int v0 = t_v0[ti], v1 = t_v1[ti];
                            if (xk == v0 || xk == v1) col = off2 + idx2_d(N, v0, v1);
                            else {
                                int a = v0, b = v1, c = xk;
                                sort3(&a, &b, &c);
                                col = off3 + idx3_d(off3_a, N, a, b, c);
                            }
                        } else {
                            int v0 = t_v0[ti], v1 = t_v1[ti], v2 = t_v2[ti];
                            if (xk == v0 || xk == v1 || xk == v2) {
                                col = off3 + idx3_d(off3_a, N, v0, v1, v2);
                            } else {
                                int a = v0, b = v1, c = v2, d = xk;
                                sort4(&a, &b, &c, &d);
                                col = COL4(a, b, c, d);
                            }
                        }
                        work[col >> 6] ^= (1ULL << (col & 63));
                    }
                    INSERT_WORK(0);
                }
            }
        }

        // 3b. Multiply deg<=2 polynomials (up to q_sub_limit) by x_u x_v (0 <= u < v < K)
        int n_q_use = n_d2 < q_sub_limit ? n_d2 : q_sub_limit;
        for (int ii = 0; ii < n_q_use && !hit_1eq0 && !tbl_full; ii++) {
            int pi = d2_list[ii];
            int s = poly_off[pi], e = poly_off[pi + 1];
            for (int u = 0; u < K && !hit_1eq0 && !tbl_full; u++) {
                for (int v = u + 1; v < K && !hit_1eq0 && !tbl_full; v++) {
                    memset(work, 0, (size_t)n_cw * sizeof(uint64_t));
                    for (int ti = s; ti < e; ti++) {
                        int dg = t_deg[ti];
                        int col;
                        if (dg == 0) {
                            col = off2 + idx2_d(N, u, v);
                        } else if (dg == 1) {
                            int v0 = t_v0[ti];
                            if (v0 == u || v0 == v) {
                                col = off2 + idx2_d(N, u, v);
                            } else {
                                int a = u, b = v, c = v0;
                                sort3(&a, &b, &c);
                                col = off3 + idx3_d(off3_a, N, a, b, c);
                            }
                        } else {
                            int v0 = t_v0[ti], v1 = t_v1[ti];
                            int in0 = (v0 == u || v0 == v);
                            int in1 = (v1 == u || v1 == v);
                            if (in0 && in1) {
                                col = off2 + idx2_d(N, u, v);
                            } else if (in0) {
                                int a = u, b = v, c = v1;
                                sort3(&a, &b, &c);
                                col = off3 + idx3_d(off3_a, N, a, b, c);
                            } else if (in1) {
                                int a = u, b = v, c = v0;
                                sort3(&a, &b, &c);
                                col = off3 + idx3_d(off3_a, N, a, b, c);
                            } else {
                                int a = u, b = v, c = v0, d = v1;
                                sort4(&a, &b, &c, &d);
                                col = COL4(a, b, c, d);
                            }
                        }
                        work[col >> 6] ^= (1ULL << (col & 63));
                    }
                    INSERT_WORK(0);
                }
            }
        }
    }

    #undef COL4
    #undef INSERT_WORK

    *out_n_lin = n_lin;
    *out_n_quad = n_quad;
    *out_n_d3_new = n_d3_new;
    *out_n_pivs = n_pivs;
    *out_table_full = tbl_full;

    free(off4_ab);
    free(off3_a);
    free(work);
    free(d2_list);
    free(d3_list);
    return hit_1eq0;
}
"""


def compile_step63b_c():
    c_path = WORK_DIR / "s63b_engine.c"
    so_path = WORK_DIR / "libs63b_engine.so"
    c_path.write_text(C_STEP63B_SRC, encoding="utf-8")
    subprocess.run(
        ["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_path), "-o", str(so_path)],
        check=True,
    )
    lib = ctypes.CDLL(str(so_path))
    lib.mobius_ball4_u64.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int, ctypes.c_int,
    ]
    lib.eval_anf_ball4_u64.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint8),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64),
    ]
    lib.mac_d3_deep_c.argtypes = [
        ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int), ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
    ]
    lib.mac_d3_deep_c.restype = ctypes.c_int

    lib.mac_d4_engine_c.argtypes = [
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
    ]
    lib.mac_d4_engine_c.restype = ctypes.c_int
    return lib


# =============================================================================
# ZERO-TRUST UNIT AUDIT OF C MOBIUS + EVAL + MAC_D3 + MAC_D4
# =============================================================================

def zt_audit_c_engines(lib63):
    rng = np.random.default_rng(63001)
    # 1. Test mobius_ball4_u64 + eval_anf_ball4_u64 on 64 random synthetic deg<=4 polynomials in d=14 vars
    d = 14
    mons = [()]
    for a in range(d): mons.append((a,))
    for a in range(d):
        for b in range(a + 1, d): mons.append((a, b))
    for a in range(d):
        for b in range(a + 1, d):
            for c in range(b + 1, d): mons.append((a, b, c))
    for a in range(d):
        for b in range(a + 1, d):
            for c in range(b + 1, d):
                for e in range(c + 1, d): mons.append((a, b, c, e))
    N4 = len(mons)
    n_w = 2  # 128 functions
    true_anf = rng.integers(0, (1 << 64) - 1, size=(N4, n_w), dtype=np.uint64)
    # Build Hamming ball B(0, 4)
    U_ball = np.zeros((N4, d), dtype=np.uint8)
    for idx, m in enumerate(mons):
        for v in m:
            U_ball[idx, v] = 1
    vals = np.zeros((N4, n_w), dtype=np.uint64)
    lib63.eval_anf_ball4_u64(
        true_anf.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        U_ball.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
        N4, d, n_w, 4,
        vals.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
    )
    rec_anf = np.zeros((N4, n_w), dtype=np.uint64)
    lib63.mobius_ball4_u64(
        vals.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        rec_anf.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        d, n_w,
    )
    assert np.array_equal(true_anf, rec_anf), "ZT FAIL: C mobius_ball4_u64 mismatch!"

    # Also cross-check eval_anf_ball4_u64 against Python on 16 random points for function 0
    U_chk = rng.integers(0, 2, size=(16, d), dtype=np.uint8)
    eval_c = np.zeros((16, n_w), dtype=np.uint64)
    lib63.eval_anf_ball4_u64(
        true_anf.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        U_chk.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
        16, d, n_w, 4,
        eval_c.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
    )
    for s in range(16):
        u = U_chk[s]
        acc = 0
        for idx, m in enumerate(mons):
            if (int(true_anf[idx, 0]) & 1) and all(u[v] for v in m):
                acc ^= 1
        assert acc == (int(eval_c[s, 0]) & 1), "ZT FAIL: eval_anf_ball4_u64 mismatch!"

    # 2. Test mac_d4_engine_c (full K=N=10 and subset K=6, N=12) on planted random quadratics
    for N_t, K_t in [(10, 10), (12, 6)]:
        x_pl = [int(rng.integers(0, 2)) for _ in range(N_t)]
        polys = []
        for _ in range(20):
            terms = []
            for _ in range(8):
                a, b = sorted(rng.choice(N_t, size=2, replace=False).tolist())
                terms.append((a, b))
            terms = list(set(terms))
            val = 0
            for t in terms:
                if all(x_pl[v] for v in t): val ^= 1
            if val: terms.append(())
            polys.append(terms)
        hit, lin_p, quad_p, _, _, _, _ = run_mac_d4_c(polys, N_t, K_t, lib63, do_d4_mults=True, q_sub_limit=20, max_pivs=5000)
        assert not hit, f"ZT FAIL: mac_d4_engine_c false 1=0 on planted (N={N_t}, K={K_t})!"
        for p in lin_p + quad_p:
            val = 0
            for t in p:
                if len(t) == 0 or all(x_pl[v] for v in t): val ^= 1
            assert val == 0, f"ZT FAIL: mac_d4_engine_c derived poly violated by planted (N={N_t}, K={K_t})!"

    print("  [ZT-ENGINE] C Mobius(B4) + Eval(B4) + MAC_D4(full & subset) self-audit PASSED (0 mismatches)!", flush=True)


# =============================================================================
# PYTHON WRAPPERS FOR C MAC_D3 AND MAC_D4
# =============================================================================

def pack_compact_polys(compact_polys):
    """Pack list of compact term-tuples (deg <= 4) into flat C arrays."""
    n_polys = len(compact_polys)
    poly_off = np.zeros(n_polys + 1, dtype=np.int32)
    tot = 0
    for i, terms in enumerate(compact_polys):
        poly_off[i] = tot
        tot += len(terms)
    poly_off[n_polys] = tot
    t_deg = np.zeros(max(1, tot), dtype=np.uint8)
    t_v0 = np.zeros(max(1, tot), dtype=np.uint8)
    t_v1 = np.zeros(max(1, tot), dtype=np.uint8)
    t_v2 = np.zeros(max(1, tot), dtype=np.uint8)
    t_v3 = np.zeros(max(1, tot), dtype=np.uint8)
    k = 0
    for terms in compact_polys:
        for t in terms:
            lt = len(t)
            t_deg[k] = lt
            if lt >= 1: t_v0[k] = t[0]
            if lt >= 2: t_v1[k] = t[1]
            if lt >= 3: t_v2[k] = t[2]
            if lt >= 4: t_v3[k] = t[3]
            k += 1
    return poly_off, t_deg, t_v0, t_v1, t_v2, t_v3


def adjust_polys_for_planted(compact_polys, planted_x):
    adj = []
    for terms in compact_polys:
        val = 0
        hom = []
        for t in terms:
            if len(t) == 0: continue
            hom.append(t)
            if all(planted_x[v] for v in t):
                val ^= 1
        if val: hom.append(())
        adj.append(hom)
    return adj


def unpack_deg2_from_pivs(piv_rows_np, slot, off2, off1, off0, n_cols, inv_col2):
    row = piv_rows_np[slot]
    n_cw = row.shape[0]
    tlist = []
    for w in range(off2 >> 6, n_cw):
        v = int(row[w])
        while v:
            lb = v & -v
            b = lb.bit_length() - 1
            v ^= lb
            c = (w << 6) + b
            if c < off2 or c >= n_cols: continue
            if c < off1: tlist.append(inv_col2[c - off2])
            elif c < off0: tlist.append((c - off1,))
            else: tlist.append(())
    return tlist


def run_mac_d3_deep_c(compact_polys, N, lib63, max_ir=6, max_boot_q=400, planted_x=None):
    use_polys = adjust_polys_for_planted(compact_polys, planted_x) if planted_x is not None else compact_polys
    poly_off, t_deg, t_v0, t_v1, t_v2, _ = pack_compact_polys(use_polys)
    n3 = (N * (N - 1) * (N - 2)) // 6
    n2 = (N * (N - 1)) // 2
    off2 = n3
    off1 = off2 + n2
    off0 = off1 + N
    n_cols = off0 + 1
    n_cw = (n_cols + 63) // 64
    max_pivs = n_cols + 4

    piv_rows = np.zeros((max_pivs, n_cw), dtype=np.uint64)
    col_to_row = np.full(n_cols, -1, dtype=np.int32)
    lin_slots = np.zeros(N + 8, dtype=np.int32)
    quad_slots = np.zeros(n2 + 8, dtype=np.int32)
    ir_dq = np.zeros(max_ir + 2, dtype=np.int32)
    ir_dl = np.zeros(max_ir + 2, dtype=np.int32)
    ir_rk = np.zeros(max_ir + 2, dtype=np.int32)
    out_n_lin = ctypes.c_int(0)
    out_n_quad = ctypes.c_int(0)
    out_n_ir = ctypes.c_int(0)
    out_n_pivs = ctypes.c_int(0)

    hit = lib63.mac_d3_deep_c(
        N, len(use_polys),
        poly_off.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
        t_deg.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
        t_v0.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
        t_v1.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
        t_v2.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
        max_ir, max_boot_q,
        piv_rows.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        col_to_row.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
        max_pivs,
        lin_slots.ctypes.data_as(ctypes.POINTER(ctypes.c_int)), ctypes.byref(out_n_lin),
        quad_slots.ctypes.data_as(ctypes.POINTER(ctypes.c_int)), ctypes.byref(out_n_quad),
        ir_dq.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
        ir_dl.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
        ir_rk.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
        ctypes.byref(out_n_ir), ctypes.byref(out_n_pivs),
    )

    inv_col2 = [(a, b) for a in range(N) for b in range(a + 1, N)]
    lin_polys = [unpack_deg2_from_pivs(piv_rows, int(lin_slots[i]), off2, off1, off0, n_cols, inv_col2) for i in range(out_n_lin.value)]
    quad_polys = [unpack_deg2_from_pivs(piv_rows, int(quad_slots[i]), off2, off1, off0, n_cols, inv_col2) for i in range(out_n_quad.value)]
    log_ir = [f"ir{i+1}:+q={int(ir_dq[i])},+l={int(ir_dl[i])},rk={int(ir_rk[i])}" for i in range(out_n_ir.value)]
    return bool(hit), lin_polys, quad_polys, out_n_pivs.value, n_cols, log_ir


def run_mac_d4_c(compact_polys, N, K, lib63, do_d4_mults=True, q_sub_limit=200, max_pivs=32000, planted_x=None):
    use_polys = adjust_polys_for_planted(compact_polys, planted_x) if planted_x is not None else compact_polys
    poly_off, t_deg, t_v0, t_v1, t_v2, t_v3 = pack_compact_polys(use_polys)
    n4 = sum((N - 1 - b) * (N - 2 - b) // 2 for a in range(K) for b in range(a + 1, K))
    n3 = (N * (N - 1) * (N - 2)) // 6
    n2 = (N * (N - 1)) // 2
    off3 = n4
    off2 = off3 + n3
    off1 = off2 + n2
    off0 = off1 + N
    n_cols = off0 + 1
    n_cw = (n_cols + 63) // 64
    use_max_pivs = min(max_pivs, n_cols + 4)

    piv_rows = np.zeros((use_max_pivs, n_cw), dtype=np.uint64)
    col_to_row = np.full(n_cols, -1, dtype=np.int32)
    lin_slots = np.zeros(N + 8, dtype=np.int32)
    quad_slots = np.zeros(n2 + 8, dtype=np.int32)
    out_n_lin = ctypes.c_int(0)
    out_n_quad = ctypes.c_int(0)
    out_n_d3_new = ctypes.c_int(0)
    out_n_pivs = ctypes.c_int(0)
    out_n_cols = ctypes.c_int(0)
    out_tbl_full = ctypes.c_int(0)

    hit = lib63.mac_d4_engine_c(
        N, K, len(use_polys), q_sub_limit,
        poly_off.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
        t_deg.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
        t_v0.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
        t_v1.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
        t_v2.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
        t_v3.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
        1 if do_d4_mults else 0, use_max_pivs,
        piv_rows.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        col_to_row.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
        lin_slots.ctypes.data_as(ctypes.POINTER(ctypes.c_int)), ctypes.byref(out_n_lin),
        quad_slots.ctypes.data_as(ctypes.POINTER(ctypes.c_int)), ctypes.byref(out_n_quad),
        ctypes.byref(out_n_d3_new), ctypes.byref(out_n_pivs),
        ctypes.byref(out_n_cols), ctypes.byref(out_tbl_full),
    )

    inv_col2 = [(a, b) for a in range(N) for b in range(a + 1, N)]
    lin_polys = [unpack_deg2_from_pivs(piv_rows, int(lin_slots[i]), off2, off1, off0, n_cols, inv_col2) for i in range(out_n_lin.value)]
    quad_polys = [unpack_deg2_from_pivs(piv_rows, int(quad_slots[i]), off2, off1, off0, n_cols, inv_col2) for i in range(out_n_quad.value)]
    return bool(hit), lin_polys, quad_polys, out_n_d3_new.value, out_n_pivs.value, n_cols, bool(out_tbl_full.value)


# =============================================================================
# TARGET 1: PURE-u1 `rK=0` SYZYGY TAPE + EXACT BALL-4 ANF + MAC_D3 / MAC_D4
# =============================================================================

def record_syzygy_cascade_tape(blk, U1, t1, M0_init, Mu_init, eval_b_init, lib9, planted_data,
                               max_outer_rounds=4, max_inner_rounds=6):
    """
    Runs the un-quotiented nRF=40 cascade on planted_data (verifying 0 mismatches on 10/10
    planted solutions!) and records the exact point-independent replay tape `ops`.
    """
    nW, nT, nRF = blk["nW"], blk["nT"], blk["nRF"]
    d1 = U1.shape[0]
    A_rf2 = blk["A_rf2"]
    nB = A_rf2.shape[0]
    p0_idx, p1_idx = blk["p0_idx"], blk["p1_idx"]
    B_t = blk["Block_B_t"]
    B_c = blk["Block_B_c"]
    eval_t_batch = blk["eval_t_batch"]

    t_at_t1 = eval_t_batch(t1[None, :])[0]
    T_basis_pts = eval_t_batch(t1[None, :] ^ U1)
    t_u1 = (T_basis_pts ^ t_at_t1[None, :]).T.copy()
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

    nl_u2_mats = []
    for a in range(nT):
        if t_q[a].any() and B_t["Mt"][a].any():
            nl_u2_mats.append((t_q[a], B_t["Mt"][a]))
    for (p, q), mat in B_t["Mww"].items():
        if not mat.any(): continue
        up, uq = U1[:, p], U1[:, q]
        qv = np.array([(up[c] & uq[d]) ^ (up[d] & uq[c]) for (c, d) in u_pairs], dtype=np.uint8)
        if qv.any(): nl_u2_mats.append((qv, mat))

    if nl_u2_mats:
        Q_src = np.array([x[0] for x in nl_u2_mats], dtype=np.uint8)
        _, src_piv_rows = s40a.gf2_rref_np(Q_src.T)
        Q_basis = Q_src[src_piv_rows]
        n_qb = Q_basis.shape[0]
        _, qb_cols = s40a.gf2_rref_np(Q_basis)
        Q_sub_inv = s60b.gf2_inv_np(Q_basis[:, qb_cols])
        C_src = (Q_src[:, qb_cols] @ Q_sub_inv) & 1
        B_nl_quad_basis = [np.zeros((nB, nRF), dtype=np.uint8) for _ in range(n_qb)]
        for si, (_, mat) in enumerate(nl_u2_mats):
            for bi in np.flatnonzero(C_src[si]):
                B_nl_quad_basis[bi] ^= mat
    else:
        B_nl_quad_basis = []
    B_nl_extra = [mat for mat in B_t["Mwt"].values() if mat.any()] + [mat for mat in B_t["Mtt"].values() if mat.any()]
    B_nl_all = B_nl_quad_basis + B_nl_extra

    M0_B_T = B_t["M0"].T.copy()
    Mw_B_T = np.array([B_t["Mw"][k].T for k in range(nW)], dtype=np.uint8)
    Mt_B_T = np.array([B_t["Mt"][a].T for a in range(nT)], dtype=np.uint8)
    ww_items = [(p, q, mat.T.copy()) for (p, q), mat in B_t["Mww"].items() if mat.any()]
    wt_items = [(p, a, mat.T.copy()) for (p, a), mat in B_t["Mwt"].items() if mat.any()]
    tt_items = [(a, b, mat.T.copy()) for (a, b), mat in B_t["Mtt"].items() if mat.any()]

    def eval_B_drf1_on_d_batch(W_b, T_b, D_b):
        out = (D_b @ M0_B_T) & 1
        for k in range(nW):
            wk = W_b[:, k:k + 1]
            if wk.any(): out ^= wk & ((D_b @ Mw_B_T[k]) & 1)
        for a in range(nT):
            ta = T_b[:, a:a + 1]
            if ta.any(): out ^= ta & ((D_b @ Mt_B_T[a]) & 1)
        for p, q, mat_T in ww_items:
            wpq = W_b[:, p:p + 1] & W_b[:, q:q + 1]
            if wpq.any(): out ^= wpq & ((D_b @ mat_T) & 1)
        for p, a, mat_T in wt_items:
            wpa = W_b[:, p:p + 1] & T_b[:, a:a + 1]
            if wpa.any(): out ^= wpa & ((D_b @ mat_T) & 1)
        for a, b, mat_T in tt_items:
            tab = T_b[:, a:a + 1] & T_b[:, b:b + 1]
            if tab.any(): out ^= tab & ((D_b @ mat_T) & 1)
        return out

    U_star = planted_data["U_star"]
    W_star = ((U_star @ U1) & 1) ^ t1[None, :]
    T_star = eval_t_batch(W_star)
    b_cur_p = eval_b_init(U_star, W_star, T_star) ^ planted_data["delta_lin"]
    c_B_p = B_c(W_star, T_star) ^ planted_data["delta_B"]
    y_p = np.zeros((U_star.shape[0], 0), dtype=np.uint8)

    ops = []
    syz_counts = {"P0": 0, "V00": 0, "rK0_lin": 0, "rK0_BlockB": 0, "zt_checks": 0}
    P0_p = blk["P0_eval"](W_star, T_star)
    if P0_p.shape[1] > 0:
        ops.append(("HARVEST_P0",))
        syz_counts["P0"] = P0_p.shape[1]

    M0_v = M0_init.copy()
    Mk_v = [M.copy() for M in Mu_init]
    G = np.eye(nRF, dtype=np.uint8)
    D = np.zeros((nRF, 0), dtype=np.uint8)

    for _outer in range(max_outer_rounds):
        for _rd in range(max_inner_rounds):
            mR_cur, rK_cur = M0_v.shape
            if mR_cur == 0:
                break
            if rK_cur == 0:
                sp = b_cur_p
                syz_counts["zt_checks"] += sp.size
                assert not sp.any(), "ZT FAIL: rK0_lin nonzero on planted!"
                ops.append(("HARVEST_V00", np.eye(mR_cur, dtype=np.uint8), "rK0_lin"))
                syz_counts["rK0_lin"] += mR_cur
                break

            cur_stack = np.hstack([M0_v] + Mk_v)
            V00 = s60b.gf2_left_nullspace(cur_stack)
            if V00.shape[0] > 0:
                sp = (b_cur_p @ V00.T) & 1
                syz_counts["zt_checks"] += sp.size
                assert not sp.any(), "ZT FAIL: V00 nonzero on planted!"
                ops.append(("HARVEST_V00", V00.copy(), "V00"))
                syz_counts["V00"] += V00.shape[0]

            _, keep_r = s40a.gf2_rref_np(cur_stack.T)
            if len(keep_r) < mR_cur:
                keep_r_arr = np.array(keep_r, dtype=np.int32)
                M0_v = M0_v[keep_r_arr]
                Mk_v = [M[keep_r_arr] for M in Mk_v]
                b_cur_p = b_cur_p[:, keep_r_arr]
                ops.append(("SLICE_R", keep_r_arr))

            V0 = s40a.gf2_nullspace_np(np.hstack(Mk_v).T)
            if V0.shape[0] > 0:
                V0_M0 = (V0 @ M0_v) & 1
                V00_sub = s60b.gf2_left_nullspace(V0_M0)
                if V00_sub.shape[0] > 0:
                    V_comb = (V00_sub @ V0) & 1
                    sp = (b_cur_p @ V_comb.T) & 1
                    syz_counts["zt_checks"] += sp.size
                    assert not sp.any(), "ZT FAIL: V00_sub nonzero on planted!"
                    ops.append(("HARVEST_V00", V_comb, "V00"))
                    syz_counts["V00"] += V_comb.shape[0]

                _, piv_v0 = s40a.gf2_rref_np(V0_M0)
                r_elim = len(piv_v0)
                if r_elim > 0:
                    rK_cur = M0_v.shape[1]
                    aug = np.hstack([V0_M0, V0])
                    aug_r, _ = s40a.gf2_rref_np(aug)
                    E_mat = aug_r[:r_elim, rK_cur:].copy()
                    piv_set = set(piv_v0)
                    keep_c = [c for c in range(rK_cur) if c not in piv_set]
                    EM0_keep = (E_mat @ M0_v[:, keep_c]) & 1
                    G_step = np.zeros((rK_cur, len(keep_c)), dtype=np.uint8)
                    for idx_k, c in enumerate(keep_c): G_step[c, idx_k] = 1
                    for idx_p, p in enumerate(piv_v0): G_step[p, :] = EM0_keep[idx_p]
                    D = np.hstack([D, G[:, piv_v0]])
                    G = (G @ G_step) & 1

                    C_m0 = M0_v[:, piv_v0].copy()
                    C_mk = [Mk_v[a][:, piv_v0].copy() for a in range(d1)]
                    M0_v = (M0_v[:, keep_c] ^ ((C_m0 @ EM0_keep) & 1)) & 1
                    Mk_v = [(Mk_v[a][:, keep_c] ^ ((C_mk[a] @ EM0_keep) & 1)) & 1 for a in range(d1)]

                    yn = (b_cur_p @ E_mat.T) & 1
                    y_p = np.hstack([y_p, yn])
                    b_cur_p = b_cur_p ^ ((yn @ C_m0.T) & 1)
                    for a in range(d1):
                        if C_mk[a].any():
                            b_cur_p ^= U_star[:, a:a + 1] & ((yn @ C_mk[a].T) & 1)
                    ops.append(("V0_STEP", E_mat.T.copy(), C_m0.T.copy(), [(a, C_mk[a].T.copy()) for a in range(d1) if C_mk[a].any()]))

                    if M0_v.shape[1] == 0:
                        sp = b_cur_p
                        syz_counts["zt_checks"] += sp.size
                        assert not sp.any(), "ZT FAIL: rK0_lin post-V0 nonzero on planted!"
                        ops.append(("HARVEST_V00", np.eye(M0_v.shape[0], dtype=np.uint8), "rK0_lin"))
                        syz_counts["rK0_lin"] += M0_v.shape[0]
                        break

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
            new_M0, new_Mk, kept_vmats = [], [[] for _ in range(d1)], []
            for s_i in range(sysb_sols.shape[0]):
                v_mat = sysb_sols[s_i]
                row_Mk = [(v_mat[a] @ ((M0_v ^ Mk_v[a]) & 1)) & 1 for a in range(d1)]
                cand = np.hstack([np.zeros(rK_cur, dtype=np.uint8)] + row_Mk)
                if not cand.any(): continue
                test_mat = np.vstack([basis_rows, cand[None, :]])
                _, tp = s40a.gf2_rref_np(test_mat)
                if len(tp) > cur_rk:
                    cur_rk = len(tp)
                    basis_rows = test_mat
                    new_M0.append(np.zeros(rK_cur, dtype=np.uint8))
                    for a in range(d1): new_Mk[a].append(row_Mk[a])
                    kept_vmats.append(v_mat.copy())
                    if len(kept_vmats) >= 96:
                        break
            if not kept_vmats:
                break
            kept = len(kept_vmats)
            M0_v = np.vstack([M0_v, np.array(new_M0, dtype=np.uint8)])
            Mk_v = [np.vstack([Mk_v[a], np.array(new_Mk[a], dtype=np.uint8)]) for a in range(d1)]
            nb = np.zeros((U_star.shape[0], kept), dtype=np.uint8)
            for ki, vm in enumerate(kept_vmats):
                vb = (b_cur_p @ vm.T) & 1
                nb[:, ki] = np.bitwise_xor.reduce(U_star & vb, axis=1)
            b_cur_p = np.hstack([b_cur_p, nb])
            ops.append(("SYSB_STEP", [vm.T.copy() for vm in kept_vmats]))

        rK_rem = G.shape[1]
        n_y = D.shape[1]
        if rK_rem == 0:
            if nB > 0:
                D_snap = D.T.copy()
                d_b = ((y_p @ D_snap) & 1) if n_y > 0 else np.zeros((U_star.shape[0], nRF), dtype=np.uint8)
                dp = d_b[:, p0_idx] & d_b[:, p1_idx]
                bb_p = ((dp @ A_rf2.T) & 1) ^ eval_B_drf1_on_d_batch(W_star, T_star, d_b) ^ c_B_p
                syz_counts["zt_checks"] += bb_p.size
                assert not bb_p.any(), "ZT FAIL: rK0_BlockB nonzero on planted!"
                ops.append(("HARVEST_BB", D_snap, None, "rK0_BlockB"))
                syz_counts["rK0_BlockB"] += nB
            break

        if nB == 0:
            break

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
        Delta = (A_rf2.astype(np.uint16) @ P_diag.astype(np.uint16)) & 1
        if nB - s60b.gf2_rank(A_tilde) == 0:
            break

        if n_y > 0:
            P_cross = np.zeros((len(p0_idx), n_y * rK_rem), dtype=np.uint8)
            for s in range(n_y):
                Ds = D[:, s]
                for a in range(rK_rem):
                    Ga = G[:, a]
                    P_cross[:, s * rK_rem + a] = (Ds[p0_idx] & Ga[p1_idx]) ^ (Ds[p1_idx] & Ga[p0_idx])
            H_full = (A_rf2.astype(np.uint16) @ P_cross.astype(np.uint16)) & 1
        else:
            H_full = np.zeros((nB, 0), dtype=np.uint8)

        nl_blocks = []
        for mat in B_nl_all:
            mg = (mat.astype(np.uint16) @ G.astype(np.uint16)) & 1
            if mg.any(): nl_blocks.append(mg)
        N_nl = np.hstack(nl_blocks) if nl_blocks else np.zeros((nB, 0), dtype=np.uint8)
        obs_list = [M for M in (A_tilde, H_full, N_nl) if M.shape[1] > 0]
        if obs_list:
            Obs = np.hstack(obs_list)
            nz_c = np.flatnonzero(Obs.any(axis=0))
            L_inj = s60b.gf2_left_nullspace(Obs[:, nz_c]) if len(nz_c) > 0 else np.eye(nB, dtype=np.uint8)
        else:
            L_inj = np.eye(nB, dtype=np.uint8)
        if L_inj.shape[0] == 0:
            break

        B0_G = (Delta ^ ((B0_f.astype(np.uint16) @ G.astype(np.uint16)) & 1)) & 1
        Bu_G = [((Bu_f[c].astype(np.uint16) @ G.astype(np.uint16)) & 1) for c in range(d1)]
        M0_cand = (L_inj @ B0_G) & 1
        Mk_cand = [(L_inj @ Bu_G[c]) & 1 for c in range(d1)]
        cand_stack = np.hstack([M0_cand] + Mk_cand)
        V00_bb = s60b.gf2_left_nullspace(cand_stack)
        D_snap = D.T.copy()

        if V00_bb.shape[0] > 0:
            L_v00 = (V00_bb @ L_inj) & 1
            d_b = ((y_p @ D_snap) & 1) if n_y > 0 else np.zeros((U_star.shape[0], nRF), dtype=np.uint8)
            dp = d_b[:, p0_idx] & d_b[:, p1_idx]
            rhs_all = ((dp @ A_rf2.T) & 1) ^ eval_B_drf1_on_d_batch(W_star, T_star, d_b) ^ c_B_p
            sp_bb = (rhs_all @ L_v00.T) & 1
            syz_counts["zt_checks"] += sp_bb.size
            assert not sp_bb.any(), "ZT FAIL: V00_bb nonzero on planted!"
            ops.append(("HARVEST_BB", D_snap, L_v00.T.copy(), "V00"))
            syz_counts["V00"] += L_v00.shape[0]

        cur_stack = np.hstack([M0_v] + Mk_v) if M0_v.shape[0] > 0 else np.zeros((0, (d1 + 1) * rK_rem), dtype=np.uint8)
        _, cur_pivs = s40a.gf2_rref_np(cur_stack) if cur_stack.shape[0] > 0 else (None, [])
        cur_rk = len(cur_pivs)
        basis_rows = cur_stack.copy()
        keep_lam_idxs = []
        for li in range(L_inj.shape[0]):
            cand_row = cand_stack[li]
            if not cand_row.any(): continue
            test_mat = np.vstack([basis_rows, cand_row[None, :]])
            _, tp = s40a.gf2_rref_np(test_mat)
            if len(tp) > cur_rk:
                cur_rk = len(tp)
                basis_rows = test_mat
                keep_lam_idxs.append(li)
        if not keep_lam_idxs:
            break

        L_use = L_inj[keep_lam_idxs]
        M0_v = np.vstack([M0_v, M0_cand[keep_lam_idxs]])
        Mk_v = [np.vstack([Mk_v[c], Mk_cand[c][keep_lam_idxs]]) for c in range(d1)]
        d_b = ((y_p @ D_snap) & 1) if n_y > 0 else np.zeros((U_star.shape[0], nRF), dtype=np.uint8)
        dp = d_b[:, p0_idx] & d_b[:, p1_idx]
        rhs_all = ((dp @ A_rf2.T) & 1) ^ eval_B_drf1_on_d_batch(W_star, T_star, d_b) ^ c_B_p
        b_cur_p = np.hstack([b_cur_p, (rhs_all @ L_use.T) & 1])
        ops.append(("APPEND_BB", D_snap, L_use.T.copy()))

    # Build fast replay evaluator for any batch U_b (shape (B, d1))
    def eval_tape_batch(U_b, delta_lin=None, delta_B=None, delta_P0=None):
        B = U_b.shape[0]
        W_b = ((U_b @ U1) & 1) ^ t1[None, :]
        T_b = eval_t_batch(W_b)
        b_cur = eval_b_init(U_b, W_b, T_b)
        if delta_lin is not None: b_cur = b_cur ^ delta_lin
        c_B = B_c(W_b, T_b)
        if delta_B is not None: c_B = c_B ^ delta_B
        y = np.zeros((B, 0), dtype=np.uint8)
        blocks = []
        for op in ops:
            kind = op[0]
            if kind == "HARVEST_P0":
                p0_val = blk["P0_eval"](W_b, T_b)
                if delta_P0 is not None: p0_val = p0_val ^ delta_P0
                blocks.append(p0_val)
            elif kind == "HARVEST_V00":
                V_mat = op[1]
                blocks.append((b_cur @ V_mat.T) & 1)
            elif kind == "SLICE_R":
                b_cur = b_cur[:, op[1]]
            elif kind == "V0_STEP":
                E_T, Cm0_T, Cmk_nz = op[1], op[2], op[3]
                yn = (b_cur @ E_T) & 1
                y = np.hstack([y, yn])
                b_cur = b_cur ^ ((yn @ Cm0_T) & 1)
                for a, Cmk_T in Cmk_nz:
                    b_cur ^= U_b[:, a:a + 1] & ((yn @ Cmk_T) & 1)
            elif kind == "SYSB_STEP":
                vm_Ts = op[1]
                nb = np.zeros((B, len(vm_Ts)), dtype=np.uint8)
                for ki, vm_T in enumerate(vm_Ts):
                    vb = (b_cur @ vm_T) & 1
                    nb[:, ki] = np.bitwise_xor.reduce(U_b & vb, axis=1)
                b_cur = np.hstack([b_cur, nb])
            elif kind == "HARVEST_BB":
                D_snap, L_T = op[1], op[2]
                d_b = ((y @ D_snap) & 1) if D_snap.shape[0] > 0 else np.zeros((B, nRF), dtype=np.uint8)
                dp = d_b[:, p0_idx] & d_b[:, p1_idx]
                rhs_all = ((dp @ A_rf2.T) & 1) ^ eval_B_drf1_on_d_batch(W_b, T_b, d_b) ^ c_B
                blocks.append(((rhs_all @ L_T) & 1) if L_T is not None else rhs_all)
            elif kind == "APPEND_BB":
                D_snap, L_T = op[1], op[2]
                d_b = ((y @ D_snap) & 1) if D_snap.shape[0] > 0 else np.zeros((B, nRF), dtype=np.uint8)
                dp = d_b[:, p0_idx] & d_b[:, p1_idx]
                rhs_all = ((dp @ A_rf2.T) & 1) ^ eval_B_drf1_on_d_batch(W_b, T_b, d_b) ^ c_B
                b_cur = np.hstack([b_cur, (rhs_all @ L_T) & 1])
        return np.hstack(blocks) if blocks else np.zeros((B, 0), dtype=np.uint8)

    return G.shape[1], syz_counts, eval_tape_batch


def pack_u8_to_u64_cols(M_u8):
    """Pack (S, M) uint8 {0,1} matrix along axis=1 into (S, n_w) uint64."""
    S, M = M_u8.shape
    n_w = (M + 63) // 64
    pad = n_w * 64 - M
    if pad > 0:
        M_pad = np.hstack([M_u8, np.zeros((S, pad), dtype=np.uint8)])
    else:
        M_pad = M_u8
    packed_u8 = np.packbits(M_pad, axis=1, bitorder="little")
    return np.ascontiguousarray(packed_u8.view(np.uint64))


def unpack_u64_to_u8_cols(M_u64, M):
    unp = np.unpackbits(M_u64.view(np.uint8), axis=1, bitorder="little")
    return np.ascontiguousarray(unp[:, :M])


def run_pure_u1_ball4_anf_and_macd4(d1, eval_tape_batch, lib63, planted_shift=None, seed=6350):
    """
    1. Evaluates all M harvested pure-u1 syzygies on the full Hamming ball B(0, 4) in F_2^{d1}.
    2. Runs exact C Mobius transform `mobius_ball4_u64` to get degree-<=4 ANF truncations.
    3. On S_ver1 random points (and double-checked on S_ver2=256 independent points!), finds:
         - exact degree-<=1, <=2, <=3, <=4 polynomial subspaces in span(syz),
         - exact symbolic ANF tuples for every extracted degree-<=4 polynomial.
    4. Runs exact full Boolean-ring MAC_D3 AND MAC_D4 in F_2[u_1] on the extracted polynomials!
    """
    t0 = time.perf_counter()
    rng = np.random.default_rng(seed)

    # Build Hamming ball B(0, 4)
    mons = [()]
    for a in range(d1): mons.append((a,))
    for a in range(d1):
        for b in range(a + 1, d1): mons.append((a, b))
    for a in range(d1):
        for b in range(a + 1, d1):
            for c in range(b + 1, d1): mons.append((a, b, c))
    for a in range(d1):
        for b in range(a + 1, d1):
            for c in range(b + 1, d1):
                for e in range(c + 1, d1): mons.append((a, b, c, e))
    N4 = len(mons)
    off1 = 1
    off2 = off1 + d1
    off3 = off2 + d1 * (d1 - 1) // 2
    off4 = off3 + d1 * (d1 - 1) * (d1 - 2) // 6

    d_lin = planted_shift["delta_lin"] if planted_shift else None
    d_B = planted_shift["delta_B"] if planted_shift else None
    d_P0 = planted_shift["delta_P0"] if planted_shift else None

    # First evaluate on U_ver1 (to get M_raw and deduplicate syzygy basis!)
    probe = eval_tape_batch(np.zeros((1, d1), dtype=np.uint8), d_lin, d_B, d_P0)
    M_raw = probe.shape[1]
    if M_raw == 0:
        return {"M_raw": 0, "rk_syz": 0}

    S_ver1 = max(768, M_raw + 128)
    S_ver2 = 256
    U_ver1 = rng.integers(0, 2, size=(S_ver1, d1), dtype=np.uint8)
    U_ver2 = rng.integers(0, 2, size=(S_ver2, d1), dtype=np.uint8)
    E_ver1 = eval_tape_batch(U_ver1, d_lin, d_B, d_P0)
    E_ver2 = eval_tape_batch(U_ver2, d_lin, d_B, d_P0)

    # Deduplicate to an independent functional basis on U_ver1
    _, col_pivs = s40a.gf2_rref_np(E_ver1)
    col_pivs_arr = np.array(col_pivs, dtype=np.int32)
    M_bas = len(col_pivs)
    E1_bas = E_ver1[:, col_pivs_arr]
    E2_bas = E_ver2[:, col_pivs_arr]
    n_w = (M_bas + 63) // 64

    # Evaluate on Hamming ball B(0, 4) in chunks of 2048
    vals_ball = np.zeros((N4, n_w), dtype=np.uint64)
    chunk = 2048
    for st in range(0, N4, chunk):
        en = min(N4, st + chunk)
        U_ch = np.zeros((en - st, d1), dtype=np.uint8)
        for i, m in enumerate(mons[st:en]):
            for v in m:
                U_ch[i, v] = 1
        ev_ch = eval_tape_batch(U_ch, d_lin, d_B, d_P0)[:, col_pivs_arr]
        vals_ball[st:en] = pack_u8_to_u64_cols(ev_ch)

    # Exact C Mobius transform on B(0, 4)
    anf_ball = np.zeros((N4, n_w), dtype=np.uint64)
    lib63.mobius_ball4_u64(
        vals_ball.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        anf_ball.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        d1, n_w,
    )

    # For each D in (0, 1, 2, 3, 4), find ALL linear combinations in span(S_bas) of exact deg <= D!
    deg_counts = {}
    deg_vecs = {}
    for D in (0, 1, 2, 3, 4):
        ev1_tr_u64 = np.zeros((S_ver1, n_w), dtype=np.uint64)
        ev2_tr_u64 = np.zeros((S_ver2, n_w), dtype=np.uint64)
        lib63.eval_anf_ball4_u64(
            anf_ball.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            U_ver1.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
            S_ver1, d1, n_w, D,
            ev1_tr_u64.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        )
        lib63.eval_anf_ball4_u64(
            anf_ball.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            U_ver2.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
            S_ver2, d1, n_w, D,
            ev2_tr_u64.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        )
        diff1 = E1_bas ^ unpack_u64_to_u8_cols(ev1_tr_u64, M_bas)
        diff2 = E2_bas ^ unpack_u64_to_u8_cols(ev2_tr_u64, M_bas)
        NS = s40a.gf2_nullspace_np(diff1)
        verified = []
        for v in NS:
            if not np.any((diff2 @ v) & 1):
                verified.append(v)
        deg_counts[D] = len(verified)
        deg_vecs[D] = np.array(verified, dtype=np.uint8) if verified else np.zeros((0, M_bas), dtype=np.uint8)

    # Extract exact symbolic ANF polynomials for ALL deg<=4 combinations!
    # Unpack anf_ball (N4, n_w) -> only compute combinations for deg_vecs[4]
    anf_u8 = unpack_u64_to_u8_cols(anf_ball, M_bas)  # (N4, M_bas)
    polys_d4 = []
    if deg_counts[4] > 0:
        # Compute exact ANF matrix: (deg_counts[4], N4) = (deg_vecs[4] @ anf_u8.T) & 1
        # Use uint32 matmul mod 2 for speed!
        C_anf = (deg_vecs[4].astype(np.uint16) @ anf_u8.T.astype(np.uint16)) & 1
        # RREF C_anf to remove any duplicates
        _, r_pivs = s40a.gf2_rref_np(C_anf.T)
        C_anf = C_anf[r_pivs]
        for r in range(C_anf.shape[0]):
            nz = np.flatnonzero(C_anf[r])
            if len(nz) > 0:
                polys_d4.append([mons[int(idx)] for idx in nz])

    # Count exact max-degree breakdown of extracted polys_d4
    by_deg = {0: 0, 1: 0, 2: 0, 3: 0, 4: 0}
    for p in polys_d4:
        md = max((len(t) for t in p), default=0)
        by_deg[md] += 1

    # If planted_shift is given, verify EVERY extracted poly vanishes at planted_u!
    if planted_shift is not None:
        u_pl = planted_shift["u_pl"]
        for p in polys_d4:
            val = 0
            for t in p:
                if len(t) == 0 or all(u_pl[v] for v in t): val ^= 1
            assert val == 0, "ZT FAIL: Extracted deg<=4 pure-u1 syzygy nonzero on planted u_star!"

    # Run EXACT Boolean-ring MAC_D3 and MAC_D4 in F_2[u_1]!
    mac3_res = "SKIP"
    mac4_res = "SKIP"
    if polys_d4:
        polys_d3_only = [p for p in polys_d4 if max((len(t) for t in p), default=0) <= 3]
        if polys_d3_only:
            hit3, l3, q3, piv3, cols3, lg3 = run_mac_d3_deep_c(polys_d3_only, d1, lib63, max_ir=4, max_boot_q=300)
            mac3_res = f"{'1EQ0!' if hit3 else 'open'}(rk={piv3}/{cols3},l={len(l3)},q+={len(q3)})"
        else:
            hit3 = False

        hit4, l4, q4, d3n4, piv4, cols4, full4 = run_mac_d4_c(
            polys_d4, d1, d1, lib63, do_d4_mults=True, q_sub_limit=len(polys_d4), max_pivs=N4 + 4
        )
        mac4_res = f"{'1EQ0!' if hit4 else 'open'}(rk={piv4}/{cols4},l={len(l4)},q+={len(q4)},c+={d3n4})"
        if planted_shift is not None:
            assert not hit3 and not hit4, "ZT FAIL: Planted pure-u1 MAC_D3/D4 triggered false 1=0!"
            u_pl = planted_shift["u_pl"]
            for p in l4 + q4[:50]:
                val = 0
                for t in p:
                    if len(t) == 0 or all(u_pl[v] for v in t): val ^= 1
                assert val == 0, "ZT FAIL: Pure-u1 MAC_D4 derived poly violated by planted u_star!"
    else:
        hit3, hit4 = False, False

    return {
        "M_raw": M_raw, "rk_syz": M_bas, "N4": N4,
        "deg_counts": deg_counts, "by_deg": by_deg, "n_polys_d4": len(polys_d4),
        "hit3": hit3, "hit4": hit4, "mac3_res": mac3_res, "mac4_res": mac4_res,
        "dt": time.perf_counter() - t0,
    }


# =============================================================================
# TARGET 2 & TARGET 3: DEEP IN-C `MAC_D3 <-> s9` + TARGETED `MAC_D4` ON SHATTERED
# =============================================================================

def run_deep_mac_d3_and_targeted_d4(
    sr_init, fix_forms, rb, tbl, lib9, lib63,
    max_outer=4, max_ir=6, do_targeted_d4=False, zt_planted=True
):
    t0 = time.perf_counter()
    k_fix = len(fix_forms)
    ex_w = [(fix_forms[j], (rb >> j) & 1) for j in range(k_fix)]
    sub = s9.run_branch_cascade(
        lib9, sr_init["_buf"], sr_init["_quad_ids"], sr_init["_cub_ids"], sr_init["_lin_pivs"],
        ex_w, tbl, max_xl_rounds=25, verify_subst=False
    )
    if sub["closed_unsat"]:
        return "S9_INIT_UNSAT", f"s9_unsat({time.perf_counter()-t0:.1f}s)", 0, None

    trace = []
    zt_checked = 0
    last_open_state = None

    for out_rd in range(1, max_outer + 1):
        q_ids = list(sub["_quad_ids"])
        c_ids = list(sub["_cub_ids"])
        psets = [s9.row_to_pset(sub["_buf"], rid, tbl) for rid in q_ids + c_ids]
        active_vars = sorted({b for ps in psets for m in ps if m > 0 for b in range(tbl["n"]) if (m >> b) & 1})
        N = len(active_vars)
        if N == 0 or N > 78:
            trace.append(f"R{out_rd}:N={N},q={len(q_ids)},c={len(c_ids)}->STOP_N")
            break

        vmap = {v: i for i, v in enumerate(active_vars)}
        compact_polys = []
        for ps in psets:
            if not ps: continue
            if ps == {0}:
                return "S9_1EQ0", "1eq0", zt_checked, None
            terms = []
            for m in ps:
                if m == 0: terms.append(())
                else: terms.append(tuple(sorted(vmap[b] for b in range(tbl["n"]) if (m >> b) & 1)))
            compact_polys.append(terms)

        # ZERO-TRUST PLANTED AUDIT ON MAC_D3
        if zt_planted and zt_checked == 0:
            rng_p = random.Random(6390 + N)
            x_pl = [rng_p.getrandbits(1) for _ in range(N)]
            hit_pl, lin_pl, quad_pl, _, _, _ = run_mac_d3_deep_c(
                compact_polys, N, lib63, max_ir=2, max_boot_q=150, planted_x=x_pl
            )
            assert not hit_pl, "ZT FAIL: Planted MAC_D3 triggered false 1=0!"
            for lp in lin_pl + quad_pl[:40]:
                val = 0
                for t in lp:
                    if len(t) == 0 or all(x_pl[i] for i in t): val ^= 1
                assert val == 0, "ZT FAIL: Planted MAC_D3 derived row violated!"
            zt_checked = 1

        t_m = time.perf_counter()
        hit_1eq0, lin_polys, quad_polys, n_pivs, n_cols_c, lg_in = run_mac_d3_deep_c(
            compact_polys, N, lib63, max_ir=max_ir, max_boot_q=400, planted_x=None
        )
        dt_m = time.perf_counter() - t_m
        in_str = ",".join(lg_in)

        if hit_1eq0:
            trace.append(f"R{out_rd}(N={N},q={len(q_ids)},c={len(c_ids)}):MAC_D3_1EQ0[{in_str}]({dt_m:.1f}s)")
            return f"MAC_D3_1EQ0_R{out_rd}", " -> ".join(trace), zt_checked, None

        trace.append(f"R{out_rd}(N={N},q={len(q_ids)},c={len(c_ids)}):[{in_str}]({dt_m:.1f}s)")
        last_open_state = (compact_polys, N, len(q_ids), len(c_ids))

        if not lin_polys:
            break

        ex_lin_new = []
        for lp in lin_polys:
            fmask, rhs_val = 0, 0
            for t in lp:
                if len(t) == 0: rhs_val ^= 1
                elif len(t) == 1: fmask |= (1 << active_vars[t[0]])
                else: raise AssertionError(f"Expected deg<=1, got {t}")
            if fmask == 0:
                if rhs_val == 1:
                    return f"MAC_LIN_1EQ0_R{out_rd}", " -> ".join(trace), zt_checked, None
            else:
                ex_lin_new.append((fmask, rhs_val))

        sub = s9.run_branch_cascade(
            lib9, sub["_buf"], sub["_quad_ids"], sub["_cub_ids"], sub["_lin_pivs"],
            ex_lin_new, tbl, max_xl_rounds=25, verify_subst=False
        )
        if sub["closed_unsat"]:
            trace.append("S9_UNSAT(1=0!)")
            return f"S9_AFTER_MAC_R{out_rd}_UNSAT", " -> ".join(trace), zt_checked, None

    # ---- TARGET 3: TARGETED SUBSET MAC_D4 ON OPEN SHATTERED QUADRATICS ----
    d4_summary = None
    if do_targeted_d4 and last_open_state is not None:
        compact_polys, N, nq, nc = last_open_state
        if nc == 0 and N <= 74:
            # Order variables by frequency in the quadratics (most frequent -> 0..K-1)
            freq = np.zeros(N, dtype=np.int32)
            for p in compact_polys:
                for t in p:
                    for v in t:
                        freq[v] += 1
            perm = np.argsort(-freq).tolist()
            inv_p = [0] * N
            for new_i, old_i in enumerate(perm):
                inv_p[old_i] = new_i
            remapped = []
            for p in compact_polys:
                remapped.append([tuple(sorted(inv_p[v] for v in t)) for t in p])
            # Sort quadratics by fewest terms outside 0..K-1 (most concentrated on S first!)
            K = min(N, 14 if N <= 64 else 12)
            remapped.sort(key=lambda p: (sum(1 for t in p if any(v >= K for v in t)), len(p)))
            q_sub = min(len(remapped), 200)
            max_pivs_d4 = 32000

            # ZERO-TRUST PLANTED AUDIT ON TARGETED MAC_D4 (subset of 40 quadratics for speed)
            rng_p4 = random.Random(6399 + N)
            x_pl4 = [rng_p4.getrandbits(1) for _ in range(N)]
            h_pl4, l_pl4, q_pl4, _, _, _, _ = run_mac_d4_c(
                remapped, N, K, lib63, do_d4_mults=True, q_sub_limit=min(40, q_sub),
                max_pivs=18000, planted_x=x_pl4
            )
            assert not h_pl4, "ZT FAIL: Targeted MAC_D4 triggered false 1=0 on planted!"
            for lp in l_pl4 + q_pl4[:30]:
                val = 0
                for t in lp:
                    if len(t) == 0 or all(x_pl4[i] for i in t): val ^= 1
                assert val == 0, "ZT FAIL: Targeted MAC_D4 derived row violated by planted!"

            # Real Targeted MAC_D4 run!
            t_d4 = time.perf_counter()
            hit4, l4, q4, d3n4, piv4, cols4, full4 = run_mac_d4_c(
                remapped, N, K, lib63, do_d4_mults=True, q_sub_limit=q_sub, max_pivs=max_pivs_d4, planted_x=None
            )
            dt_d4 = time.perf_counter() - t_d4
            d4_summary = (
                f"MAC_D4_SUB(N={N},K={K},q_sub={q_sub}/{nq}): "
                f"{'1EQ0!' if hit4 else 'open'} | rk={piv4}/{cols4}{' [CAP]' if full4 else ''} | "
                f"l={len(l4)}, q+={len(q4)}, c+={d3n4} [ZT_D4_OK] ({dt_d4:.1f}s)"
            )
            if hit4:
                return "MAC_D4_SUB_1EQ0", " -> ".join(trace), zt_checked, d4_summary

    return "OPEN", " -> ".join(trace), zt_checked, d4_summary


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

    print(f"\n==================== [{cell_name}] STEP 63B: PURE-u1 MAC_D4 + DEEP IR6 MAC_D3 + TARGETED MAC_D4 ====================", flush=True)

    lib63 = compile_step63b_c()
    zt_audit_c_engines(lib63)

    c_diag, so_diag = WORK_DIR / "s63b_diag.c", WORK_DIR / "libs63b_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s63b_s9.c", WORK_DIR / "libs63b_s9.so"
    c_s9.write_text(s9.C_STEP9_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_s9), "-o", str(so_s9)], check=True)
    lib9 = s45a._setup_lib9(so_s9)

    c_cg, so_cg = WORK_DIR / "s63b_cg.c", WORK_DIR / "libs63b_cg.so"
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

    c_sh, so_sh = WORK_DIR / "s63b_sh.c", WORK_DIR / "libs63b_sh.so"
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
        test_etas = [5, 0, 9] if cell_name == "B0_11" else [3, 0, 8, 10]
    rng_main = np.random.default_rng(6370)

    for em in test_etas:
        t_em = time.perf_counter()
        print(f"\n==========================================================================", flush=True)
        print(f"  [{cell_name} eta={em}] STEP 63B: PURE-u1 MAC_D4 + DEEP IR6 + TARGETED MAC_D4", flush=True)
        print(f"==========================================================================", flush=True)

        blk = s61a.extract_full_blocks_fast(em, root, eta_free, lib9, lib_sh, tbl, rng_seed=6300 + em)
        if blk["closed_unsat"]:
            print(f"  [{cell_name} eta={em}] CLOSED UNSAT AT ETA LEVEL!", flush=True)
            continue
        nW, nT, nRF = blk["nW"], blk["nT"], blk["nRF"]
        print(f"  [ZT-0] Fast extractor OK (0 mismatches): nW={nW}, nT={nT}, nRF={nRF}", flush=True)

        U_iso_full, _ = s60b.build_iso_extended_basis(blk, seed=6350 + em)
        cand_bases = s61a.build_candidate_full_bases(blk, U_iso_full, em_seed=em)
        t1_rand = rng_main.integers(0, 2, size=nW, dtype=np.uint8)
        sr = blk["sr"]
        W_forms_111 = blk["W_forms_111"]

        # Build 41A_Flag if M0_c is non-empty
        flag_cms = None
        if blk["M0_c"].shape[0] > 0 and blk["M0_c"].shape[1] > 0:
            flag_cms, _, _, _ = s60a.build_step41a_flags(blk["Mk_c"], nW, seed=6301 + em)

        # ---- TARGET 1: PURE-u1 rK=0 SYZYGY EXACT BALL-4 ANF & MAC_D3 / MAC_D4 ----
        t1_d1_list = [26, 28, 30] if cell_name == "B0_11" else [20]
        print(f"\n  >>> [TARGET 1] PURE-u1 `rK=0` SYZYGY EXACT BALL-4 ANF & MAC_D3/D4 (d1={t1_d1_list})", flush=True)
        for d1 in t1_d1_list:
            U1_j, _, jsrc = s61a.optimize_u1_joint(blk, d1, t1_rand, cand_bases, do_swaps=True)
            M0_linR, Mu_linR, eval_bR, _, nexR, LamR = s60b.extract_fiber_linearized_drf1(blk, U1_j, t1_rand)
            pl_R = s60b.make_planted_solutions(blk, U1_j, t1_rand, LamR, n_planted=10, seed=6500 + em * 60 + d1)
            final_rK, sc, eval_tape = record_syzygy_cascade_tape(
                blk, U1_j, t1_rand, M0_linR, Mu_linR, eval_bR, lib9, pl_R
            )

            # ZT planted check on Target 1 ANF + MAC_D4 (on first d1 per eta!)
            if d1 == t1_d1_list[0]:
                u_pl0 = pl_R["U_star"][0]
                w_pl0 = ((u_pl0[None, :] @ U1_j) & 1) ^ t1_rand[None, :]
                t_pl0 = blk["eval_t_batch"](w_pl0)
                d_P0_0 = blk["P0_eval"](w_pl0, t_pl0)
                pl_shift = {
                    "u_pl": u_pl0,
                    "delta_lin": pl_R["delta_lin"][0:1],
                    "delta_B": pl_R["delta_B"][0:1],
                    "delta_P0": d_P0_0,
                }
                # Verify tape vanishes at u_pl0
                chk_pl = eval_tape(u_pl0[None, :], pl_shift["delta_lin"], pl_shift["delta_B"], pl_shift["delta_P0"])
                assert not chk_pl.any(), "ZT FAIL: Replay tape nonzero on planted u_pl0!"
                zt_res = run_pure_u1_ball4_anf_and_macd4(d1, eval_tape, lib63, planted_shift=pl_shift, seed=6390 + d1)
                print(
                    f"    [T1 ZT-PLANTED d1={d1}]: OK (0 false 1=0, 0 violated polys, deg<=4 cnt={zt_res['n_polys_d4']}, {zt_res['dt']:.1f}s)",
                    flush=True,
                )

            res1 = run_pure_u1_ball4_anf_and_macd4(d1, eval_tape, lib63, planted_shift=None, seed=6350 + em * 10 + d1)
            dc = res1["deg_counts"]
            bd = res1["by_deg"]
            print(
                f"    [T1 d1={d1:2d}(k_fix={nW-d1:2d}) rK={final_rK:2d} src={jsrc}]: "
                f"syz={res1['M_raw']}(rk={res1['rk_syz']}) | "
                f"span_deg<=0..4=[{dc[0]},{dc[1]},{dc[2]},{dc[3]},{dc[4]}] | "
                f"by_deg={bd} | MAC_D3={res1['mac3_res']} | MAC_D4={res1['mac4_res']} ({res1['dt']:.1f}s)",
                flush=True,
            )

        # ---- TARGET 2 & TARGET 3: DEEP IR6 `MAC_D3 <-> s9` + `41A_Flag` vs `U1_joint` + TARGETED `MAC_D4` ----
        t2_d1_list = [26, 28] if cell_name == "B0_11" else [22, 24]
        print(f"\n  >>> [TARGET 2 & 3] DEEP IR6 MAC_D3<->s9 (`U1_joint` vs `41A_Flag`) + TARGETED MAC_D4 (d1={t2_d1_list})", flush=True)
        for d1 in t2_d1_list:
            subspaces = []
            U1_j, _, jsrc = s61a.optimize_u1_joint(blk, d1, t1_rand, cand_bases, do_swaps=True)
            subspaces.append((f"U1_joint({jsrc})", U1_j))

            if flag_cms is not None and d1 <= len(flag_cms):
                U1_flag = np.zeros((d1, nW), dtype=np.uint8)
                for ri, cm in enumerate(flag_cms[:d1]):
                    for k in range(nW):
                        if (cm >> k) & 1: U1_flag[ri, k] = 1
                subspaces.append(("41A_Flag", U1_flag))

            for label, U1_use in subspaces:
                F_sub = s40a.gf2_nullspace_np(U1_use)
                k_fix = F_sub.shape[0]
                fix_forms = []
                for row in F_sub:
                    fm = 0
                    for k in range(nW):
                        if row[k]: fm ^= W_forms_111[k]
                    fix_forms.append(fm)

                n_closed = 0
                d4_done = False
                for tr in range(3):
                    rb = 0 if tr == 0 else int(rng_main.integers(1, 1 << min(30, k_fix)))
                    # Run Targeted MAC_D4 on first open fiber of U1_joint (or 41A_Flag if U1_joint closed)
                    want_d4 = (not d4_done) and (label.startswith("U1_joint"))
                    verdict, trace_str, zt_c, d4_sum = run_deep_mac_d3_and_targeted_d4(
                        sr, fix_forms, rb, tbl, lib9, lib63,
                        max_outer=4, max_ir=6, do_targeted_d4=want_d4, zt_planted=(tr == 0)
                    )
                    if "UNSAT" in verdict or "1EQ0" in verdict:
                        n_closed += 1
                    zt_tag = " [ZT_OK]" if zt_c else ""
                    print(f"    [T2 {label} d1={d1}(k={k_fix}) f{tr}]: {verdict}{zt_tag} | {trace_str}", flush=True)
                    if d4_sum is not None:
                        d4_done = True
                        print(f"      [T3 TARGETED MAC_D4]: {d4_sum}", flush=True)
                print(f"    ==> [{cell_name} eta={em} {label} d1={d1:2d}(k_fix={k_fix:2d})] CLOSED = {n_closed}/3", flush=True)

        print(f"  [{cell_name} eta={em}] done in {time.perf_counter()-t_em:.1f}s", flush=True)

    print(f"\n[{cell_name}] STEP 63B DONE in {time.perf_counter()-t0:.1f}s", flush=True)


if __name__ == "__main__":
    main()
