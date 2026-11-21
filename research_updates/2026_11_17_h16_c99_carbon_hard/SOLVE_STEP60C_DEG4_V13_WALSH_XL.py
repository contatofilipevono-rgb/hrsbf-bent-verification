#!/usr/bin/env python3
r"""
SOLVE_STEP60C_DEG4_V13_WALSH_XL.py

FRONT 4 — DEGREE-4 EQUATIONS (V_13 / V_14 / V_15 / V_16) + HIGHER-ORDER C_8-WALSH
(v2 = 5..10, MOD = 16..512 -> mod 32..1024) + DEGREE-DROP & SHATTERED-FIBER INJECTION!

MATHEMATICAL FOUNDATIONS (100% ZERO-TRUST VERIFIED):
  1. For ANY bent function f in H(16, 4) (degree <= 4) and ANY k-dim subspace V_k (k >= 13):
     - By Ax / Reed-Muller divisibility on RM(4, k), 2^{ceil(k/4)-1} = 8 | wt(f|_{V_k}) IDENTICALLY
       for ALL f in H(16, 4) (zero exceptions!).
     - By Poisson summation on bent f:
         V_13 (35 C_16-coord orbits): 32 | wt(f|_{V_13})  => (wt/8) mod 2 == 0 is EXACT degree <= 4!
         V_14 ( 8 C_16-coord orbits): 64 | wt(f|_{V_14})  => (wt/8) mod 2 == 0 is EXACT degree <= 4!
         V_15 ( 1 C_16-coord orbit): 128 | wt(f|_{V_15})  => (wt/8) mod 2 == 0 is EXACT degree <= 4!
         V_16 ( 1 full space):       128 | wt(f)          => (wt/8) mod 2 == 0 is EXACT degree <= 4!
       (Note: 35 V_13 + 8 V_14 = 43 coordinate orbits; + V_15 + V_16 = 45 coordinate orbits!)
     - Plus non-coordinate linear V_13 subspaces (~156-157 total independent deg-4 eqs at root).
     - Every extracted degree-4 equation is Zero-Trust verified on 50 random points (0 mismatches)
       against exact truth-table wt(f|_V) mod 16 (and 8 | wt asserted on all 50 points!).

  2. C_8-Equivariant Dual-Walsh Lattice Congruences up to v2 = 9, 10 (MOD = 16, 32, 64, 128, 256, 512):
     - For ANY integer vector v in Z^{36} with (v^T A) == c*(MOD/2)*orb_b0_par (mod MOD):
         sum_{i=0}^{35} v_i S_{D_8}(z_i) == 256*v_0 (mod 2*MOD)
       holds IDENTICALLY for every bent f in H(16, 4) (proven algebraically AND verified on 300 duals).
     - Specifically captures v2 = 7, 8, 9, 10 (mod 128, 256, 512, 1024) congruences whose
       degree >= 4 tail was never extracted in Step 37!

  3. FOUR SYSTEMATIC TESTS ON BOTH B0_11 AND B1_11:
     - PART 1 (Root N=109): Extract & Zero-Trust verify ALL 45 coordinate (35 V_13 + 8 V_14 + 1 V_15
       + 1 V_16) + 140 non-coord V_13 degree-4 equations; test exact GF(2) deg-4 rank & degree-<=3 drops!
     - PART 2 (Fixed-eta): On eta in {0, 5, 9, 11} (B0_11) / {0, 3, 8, 10} (B1_11):
       (2A) Pure linear-combo degree-4 drops;
       (2B) EXACT block-by-block ideal reduction mod the 17 Q_t quadratics:
            sum alpha_k P_k^{(4)} in span{Q_m^{(2)}(w) * x_i * x_j};
       (2C) Direct variety V(Q) restriction (t = Q(w)) 4th-diff degree-drop test (catches arbitrary
            higher-degree Q_t syzygies!).
     - PART 3 (C_8-Walsh v2=5..10): Audit ALL MOD in {16, 32, 64, 128, 256, 512} at Root & Fixed-eta
       (check deg <= 3 AND exact deg == 4 C_8-Walsh equations + joint linear combos with V_13..V_16!).
     - PART 4 (Shattered-Fiber Injection on U_1^perp fibers from s9.run_branch_cascade):
       On open shattered fibers (d_free near threshold), inject:
       (4A) ALL 45 coordinate + 120 non-coord V_13 degree-4 eqs (direct & linear-combo drops -> s9);
       (4B) ALL C_8-Walsh v2=5..10 congruences (instant 1=0, lower/top-bit deg<=3 drops, deg-4 joint drops -> s9);
       (4C) Higher-bit wt(f|_V) mod 32/64/128 checks on V_13..V_16;
       (4D) Shattered-fiber degree-4 mod-Q_fiber reduction (linear-tail Q + V(Q_fiber) 4th-diffs)!
"""

import argparse
import ctypes
import random
import subprocess
import sys
import time
from itertools import combinations
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
import SOLVE_STEP36_C8_ORBIT_WALSH_KERNEL_LOCAL as s36
import SOLVE_STEP40A_B11_COMMON_KERNEL_AND_DECOMPOSITION as s40a
import SOLVE_STEP45A_B000_PARALLEL_CLOSER as s45a
import SOLVE_STEP45B_POLAR_EXACT_RHS_AND_KL3 as s45b
import SOLVE_STEP57B_GREEDY_BASIS_AND_BLOCKB_INJECT as s57b


# ==============================================================================
# High-Speed OpenMP + SIMD C Kernel for Degree-4 ANF Extraction, Verification,
# GF(2) Echelon, and C_8-Walsh High-v2 Extraction
# ==============================================================================
C_DEG4_SRC = r"""
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <omp.h>

static inline void toggle_bit(uint64_t *row, uint64_t col) {
    row[col >> 6] ^= (1ULL << (col & 63));
}

static inline int get_bit(const uint64_t *row, uint64_t col) {
    return (int)((row[col >> 6] >> (col & 63)) & 1ULL);
}

static inline uint64_t comb2(int m) { return (m < 2) ? 0ULL : (uint64_t)m * (m - 1) / 2ULL; }
static inline uint64_t comb3(int m) { return (m < 3) ? 0ULL : (uint64_t)m * (m - 1) * (m - 2) / 6ULL; }
static inline uint64_t comb4(int m) { return (m < 4) ? 0ULL : (uint64_t)m * (m - 1) * (m - 2) * (m - 3) / 24ULL; }

static inline uint64_t idx2_lex(int N, int i, int j) {
    return comb2(N) - comb2(N - i) + (uint64_t)(j - i - 1);
}

static inline uint64_t idx3_lex(int N, int i, int j, int k) {
    return (comb3(N) - comb3(N - i)) + (comb2(N - 1 - i) - comb2(N - j)) + (uint64_t)(k - j - 1);
}

static inline uint64_t idx4_lex(int N, int i, int j, int k, int l) {
    return (comb4(N) - comb4(N - i))
         + (comb3(N - 1 - i) - comb3(N - j))
         + (comb2(N - 1 - j) - comb2(N - k))
         + (uint64_t)(l - k - 1);
}

/*
 * Extract EXACT degree <= 4 ANF of g_s(y) = (wt(f(y)|_{V_s}) / 8) mod 2
 * for K subspaces simultaneously using OpenMP!
 *
 * Input:
 *   orig_tt[65536]   : uint8 truth table of origin f(0) on F_2^16
 *   basis_tt[N*65536]: uint8 truth tables of N basis directions on F_2^16
 *   pts_flat         : concatenated uint16 point lists for all K subspaces
 *   pts_off[K]       : starting offset in pts_flat for subspace s
 *   pts_len[K]       : number of points in subspace s (multiple of 64, <= 65536)
 *   K, N             : number of subspaces, number of active variables (<= 111)
 *   n_words          : uint64 words per output row covering [deg4 | deg3 | deg2 | deg1 | deg0]
 *
 * Output:
 *   out_rows[K * n_words] : packed GF(2) rows (deg4 cols first, then deg3, deg2, deg1, deg0)
 *   out_status[K]         : 0 = OK (8|wt verified on all coeffs), <0 = divisibility failure
 */
void extract_wt_div8_deg4_batch_c(
    const uint8_t *orig_tt,
    const uint8_t *basis_tt,
    const uint16_t *pts_flat,
    const int *pts_off,
    const int *pts_len,
    int K,
    int N,
    uint64_t n_words,
    uint64_t *out_rows,
    int *out_status
) {
    uint64_t n4 = comb4(N);
    uint64_t n3 = comb3(N);
    uint64_t n2 = comb2(N);
    uint64_t off3 = n4;
    uint64_t off2 = n4 + n3;
    uint64_t off1 = n4 + n3 + n2;
    uint64_t off0 = off1 + (uint64_t)N;

    memset(out_rows, 0, (size_t)K * (size_t)n_words * sizeof(uint64_t));

    #pragma omp parallel for schedule(dynamic, 1)
    for (int s = 0; s < K; s++) {
        const uint16_t *pts = pts_flat + pts_off[s];
        int plen = pts_len[s];
        int nw = plen >> 6;
        uint64_t *row = out_rows + (size_t)s * (size_t)n_words;

        uint64_t *o_w = (uint64_t *)calloc((size_t)nw, sizeof(uint64_t));
        uint64_t *b_w = (uint64_t *)calloc((size_t)N * (size_t)nw, sizeof(uint64_t));
        uint64_t *tmp2 = (uint64_t *)malloc((size_t)nw * sizeof(uint64_t));
        uint64_t *tmp3 = (uint64_t *)malloc((size_t)nw * sizeof(uint64_t));

        for (int p = 0; p < plen; p++) {
            uint16_t x = pts[p];
            if (orig_tt[x]) o_w[p >> 6] |= (1ULL << (p & 63));
        }
        for (int i = 0; i < N; i++) {
            const uint8_t *bi = basis_tt + (size_t)i * 65536;
            uint64_t *dst = b_w + (size_t)i * (size_t)nw;
            for (int p = 0; p < plen; p++) {
                if (bi[pts[p]]) dst[p >> 6] |= (1ULL << (p & 63));
            }
        }

        int st = 0;
        /* Deg 0 */
        int w0 = 0;
        for (int w = 0; w < nw; w++) w0 += __builtin_popcountll(o_w[w]);
        if ((unsigned int)w0 & 7U) st = -1;
        else if ((((unsigned int)w0) >> 3) & 1U) toggle_bit(row, off0);

        /* Deg 1 */
        if (st == 0) {
            for (int i = 0; i < N; i++) {
                const uint64_t *bi = b_w + (size_t)i * nw;
                int pb = 0, pob = 0;
                for (int w = 0; w < nw; w++) {
                    pb += __builtin_popcountll(bi[w]);
                    pob += __builtin_popcountll(o_w[w] & bi[w]);
                }
                int w1 = pb - 2 * pob;
                if ((unsigned int)w1 & 7U) { st = -2; break; }
                if ((((unsigned int)w1) >> 3) & 1U) toggle_bit(row, off1 + (uint64_t)i);
            }
        }

        /* Deg 2, 3, 4 in one structured sweep with monotonic counters! */
        if (st == 0) {
            uint64_t c2 = 0, c3 = 0, c4 = 0;
            for (int i = 0; i < N && st == 0; i++) {
                const uint64_t *bi = b_w + (size_t)i * nw;
                for (int j = i + 1; j < N && st == 0; j++) {
                    const uint64_t *bj = b_w + (size_t)j * nw;
                    int p2 = 0, po2 = 0;
                    for (int w = 0; w < nw; w++) {
                        uint64_t v = bi[w] & bj[w];
                        tmp2[w] = v;
                        p2 += __builtin_popcountll(v);
                        po2 += __builtin_popcountll(o_w[w] & v);
                    }
                    int w2 = -2 * p2 + 4 * po2;
                    if ((unsigned int)w2 & 7U) { st = -3; break; }
                    if ((((unsigned int)w2) >> 3) & 1U) toggle_bit(row, off2 + c2);
                    c2++;

                    for (int k = j + 1; k < N && st == 0; k++) {
                        const uint64_t *bk = b_w + (size_t)k * nw;
                        int p3 = 0, po3 = 0;
                        for (int w = 0; w < nw; w++) {
                            uint64_t v = tmp2[w] & bk[w];
                            tmp3[w] = v;
                            p3 += __builtin_popcountll(v);
                            po3 += __builtin_popcountll(o_w[w] & v);
                        }
                        if (p3 & 1) { st = -4; break; }
                        if (((p3 >> 1) ^ po3) & 1) toggle_bit(row, off3 + c3);
                        c3++;

                        for (int l = k + 1; l < N; l++) {
                            const uint64_t *bl = b_w + (size_t)l * nw;
                            uint64_t a0 = 0, a1 = 0, a2 = 0, a3 = 0;
                            int w = 0;
                            for (; w + 3 < nw; w += 4) {
                                a0 ^= tmp3[w]     & bl[w];
                                a1 ^= tmp3[w + 1] & bl[w + 1];
                                a2 ^= tmp3[w + 2] & bl[w + 2];
                                a3 ^= tmp3[w + 3] & bl[w + 3];
                            }
                            uint64_t par = (a0 ^ a1) ^ (a2 ^ a3);
                            for (; w < nw; w++) par ^= tmp3[w] & bl[w];
                            if (__builtin_parityll(par)) {
                                row[c4 >> 6] ^= (1ULL << (c4 & 63));
                            }
                            c4++;
                        }
                    }
                }
            }
        }

        out_status[s] = st;
        free(o_w); free(b_w); free(tmp2); free(tmp3);
    }
}

/*
 * Zero-Trust Verification of K degree-4 rows on R_ver random points y_r in F_2^N!
 * Computes BOTH:
 *   1. Exact truth-table weight wt(f(y_r)|_{V_s}) -> asserts 8|wt and gets bit (wt>>3)&1
 *   2. Exact ANF evaluation of out_rows[s] at y_r (using pre-built eval_mask for y_r!)
 * Returns total number of mismatches (must be 0!) and total mod-8 failures (must be 0!).
 */
void verify_deg4_batch_c(
    const uint8_t *orig_tt,
    const uint8_t *basis_tt,
    const uint16_t *pts_flat,
    const int *pts_off,
    const int *pts_len,
    const uint64_t *rows,
    int K,
    int N,
    uint64_t n_words,
    const uint64_t *ver_lo,
    const uint64_t *ver_hi,
    int R_ver,
    int *out_mod8_fail,
    int *out_mismatches
) {
    uint64_t n4 = comb4(N);
    uint64_t n3 = comb3(N);
    uint64_t n2 = comb2(N);
    uint64_t off3 = n4;
    uint64_t off2 = n4 + n3;
    uint64_t off1 = n4 + n3 + n2;
    uint64_t off0 = off1 + (uint64_t)N;

    /* Precompute truth tables of the R_ver random functions on F_2^16 AND their eval_masks */
    uint8_t *F_ver = (uint8_t *)malloc((size_t)R_ver * 65536);
    uint64_t *eval_masks = (uint64_t *)calloc((size_t)R_ver * (size_t)n_words, sizeof(uint64_t));

    #pragma omp parallel for schedule(static)
    for (int r = 0; r < R_ver; r++) {
        uint8_t *fr = F_ver + (size_t)r * 65536;
        memcpy(fr, orig_tt, 65536);
        int ones[128], m = 0;
        for (int i = 0; i < N; i++) {
            int bit = (i < 64) ? (int)((ver_lo[r] >> i) & 1ULL) : (int)((ver_hi[r] >> (i - 64)) & 1ULL);
            if (bit) {
                ones[m++] = i;
                const uint8_t *bi = basis_tt + (size_t)i * 65536;
                for (int x = 0; x < 65536; x++) fr[x] ^= bi[x];
            }
        }
        uint64_t *em = eval_masks + (size_t)r * (size_t)n_words;
        toggle_bit(em, off0);
        for (int a = 0; a < m; a++) {
            int ia = ones[a];
            toggle_bit(em, off1 + (uint64_t)ia);
            for (int b = a + 1; b < m; b++) {
                int ib = ones[b];
                toggle_bit(em, off2 + idx2_lex(N, ia, ib));
                for (int c = b + 1; c < m; c++) {
                    int ic = ones[c];
                    toggle_bit(em, off3 + idx3_lex(N, ia, ib, ic));
                    for (int d = c + 1; d < m; d++) {
                        int id = ones[d];
                        toggle_bit(em, idx4_lex(N, ia, ib, ic, id));
                    }
                }
            }
        }
    }

    int mod8_fail = 0;
    int mismatches = 0;

    #pragma omp parallel for reduction(+:mod8_fail,mismatches) schedule(dynamic, 1)
    for (int s = 0; s < K; s++) {
        const uint16_t *pts = pts_flat + pts_off[s];
        int plen = pts_len[s];
        const uint64_t *row = rows + (size_t)s * (size_t)n_words;
        for (int r = 0; r < R_ver; r++) {
            const uint8_t *fr = F_ver + (size_t)r * 65536;
            int wt = 0;
            for (int p = 0; p < plen; p++) wt += fr[pts[p]];
            if (wt & 7) {
                mod8_fail++;
                continue;
            }
            int actual = (wt >> 3) & 1;
            const uint64_t *em = eval_masks + (size_t)r * (size_t)n_words;
            uint64_t acc = 0;
            for (uint64_t w = 0; w < n_words; w++) acc ^= (row[w] & em[w]);
            int pe = __builtin_parityll(acc);
            if (pe != actual) mismatches++;
        }
    }

    *out_mod8_fail = mod8_fail;
    *out_mismatches = mismatches;
    free(F_ver);
    free(eval_masks);
}

/*
 * Fast GF(2) Echelon on K rows of n_words (cols 0 .. n_cols_limit-1 are the degree-4 prefix!).
 * Reduces rows IN-PLACE and tracks row combinations in comb_words[K * comb_nw].
 * Returns number of pivots in [0 .. n_deg4_cols - 1] (deg-4 rank), and fills:
 *   out_piv_col[s] = pivot column (if < n_deg4_cols: deg4 pivot; if >= n_deg4_cols: DEG<=3 DROP!; if -1: ZERO ROW!)
 */
int gf2_echelon_deg4_c(
    uint64_t *rows,
    int K,
    uint64_t n_words,
    uint64_t n_deg4_cols,
    uint64_t n_total_cols,
    int64_t *out_piv_col,
    uint64_t *comb_out,
    int comb_nw
) {
    memset(comb_out, 0, (size_t)K * (size_t)comb_nw * sizeof(uint64_t));
    for (int i = 0; i < K; i++) {
        comb_out[(size_t)i * comb_nw + (i >> 6)] = (1ULL << (i & 63));
        out_piv_col[i] = -1;
    }

    /* Map pivot_col -> row_idx (sparse: at most K pivots!) */
    uint64_t *piv_cols = (uint64_t *)malloc((size_t)K * sizeof(uint64_t));
    int *piv_rows = (int *)malloc((size_t)K * sizeof(int));
    int n_piv = 0;
    int deg4_rank = 0;

    for (int i = 0; i < K; i++) {
        uint64_t *ri = rows + (size_t)i * (size_t)n_words;
        uint64_t *ci = comb_out + (size_t)i * (size_t)comb_nw;
        /* Reduce against all existing pivots in increasing pivot-col order */
        for (int p = 0; p < n_piv; p++) {
            uint64_t pc = piv_cols[p];
            if ((ri[pc >> 6] >> (pc & 63)) & 1ULL) {
                const uint64_t *rp = rows + (size_t)piv_rows[p] * (size_t)n_words;
                const uint64_t *cp = comb_out + (size_t)piv_rows[p] * (size_t)comb_nw;
                uint64_t w0 = pc >> 6;
                for (uint64_t w = w0; w < n_words; w++) ri[w] ^= rp[w];
                for (int cw = 0; cw < comb_nw; cw++) ci[cw] ^= cp[cw];
            }
        }
        /* Find first nonzero bit */
        int64_t lead = -1;
        for (uint64_t w = 0; w < n_words; w++) {
            if (ri[w]) {
                uint64_t col = (w << 6) + (uint64_t)__builtin_ctzll(ri[w]);
                if (col < n_total_cols) lead = (int64_t)col;
                break;
            }
        }
        out_piv_col[i] = lead;
        if (lead >= 0) {
            if ((uint64_t)lead < n_deg4_cols) deg4_rank++;
            /* Insert (lead, i) keeping piv_cols sorted ascending! */
            int pos = n_piv;
            while (pos > 0 && piv_cols[pos - 1] > (uint64_t)lead) {
                piv_cols[pos] = piv_cols[pos - 1];
                piv_rows[pos] = piv_rows[pos - 1];
                pos--;
            }
            piv_cols[pos] = (uint64_t)lead;
            piv_rows[pos] = i;
            n_piv++;
        }
    }
    free(piv_cols);
    free(piv_rows);
    return deg4_rank;
}

/*
 * Fast C evaluation of S_{D_8}(z_0..z_35) on a batch of R points in an N-var affine subspace!
 * orig_36w[36 * 4], basis_36w[N * 36 * 4] packed 256-bit truth tables on the 36 D_8 cosets.
 */
void eval_c8_S_batch_c(
    const uint64_t *orig_36w,
    const uint64_t *basis_36w,
    int N,
    const uint64_t *pts_lo,
    const uint64_t *pts_hi,
    int R,
    int64_t *out_S /* [R * 36] */
) {
    #pragma omp parallel for schedule(static)
    for (int r = 0; r < R; r++) {
        uint64_t acc[36][4];
        memcpy(acc, orig_36w, sizeof(acc));
        uint64_t lo = pts_lo[r], hi = pts_hi[r];
        while (lo) {
            int i = __builtin_ctzll(lo); lo &= lo - 1;
            const uint64_t *bi = basis_36w + (size_t)i * 144;
            for (int zi = 0; zi < 36; zi++) {
                acc[zi][0] ^= bi[zi * 4 + 0];
                acc[zi][1] ^= bi[zi * 4 + 1];
                acc[zi][2] ^= bi[zi * 4 + 2];
                acc[zi][3] ^= bi[zi * 4 + 3];
            }
        }
        while (hi) {
            int i = 64 + __builtin_ctzll(hi); hi &= hi - 1;
            const uint64_t *bi = basis_36w + (size_t)i * 144;
            for (int zi = 0; zi < 36; zi++) {
                acc[zi][0] ^= bi[zi * 4 + 0];
                acc[zi][1] ^= bi[zi * 4 + 1];
                acc[zi][2] ^= bi[zi * 4 + 2];
                acc[zi][3] ^= bi[zi * 4 + 3];
            }
        }
        int64_t *Sr = out_S + (size_t)r * 36;
        for (int zi = 0; zi < 36; zi++) {
            int wt = __builtin_popcountll(acc[zi][0]) + __builtin_popcountll(acc[zi][1])
                   + __builtin_popcountll(acc[zi][2]) + __builtin_popcountll(acc[zi][3]);
            Sr[zi] = 256 - 2 * wt;
        }
    }
}

/*
 * Extract EXACT degree <= 3 ANF of K C_8-Walsh congruences on an N-var affine subspace!
 * Checks mod-divisibility (2^shift | (v.S - target)) on ALL weight <= 3 points!
 * Returns packed rows of [deg3 | deg2 | deg1 | deg0] (n3_words uint64s per row).
 */
void extract_c8_walsh_deg3_sub_c(
    const uint64_t *orig_36w,
    const uint64_t *basis_36w,
    const int64_t *V_mat,
    const int64_t *targets,
    const int *shifts,
    int K,
    int N,
    uint64_t n3_words,
    uint64_t *out_rows,
    int *out_mod_fail
) {
    uint64_t n3 = comb3(N);
    uint64_t n2 = comb2(N);
    uint64_t off2 = n3;
    uint64_t off1 = n3 + n2;
    uint64_t off0 = off1 + (uint64_t)N;

    memset(out_rows, 0, (size_t)K * (size_t)n3_words * sizeof(uint64_t));
    memset(out_mod_fail, 0, (size_t)K * sizeof(int));

    uint8_t *c0 = (uint8_t *)calloc((size_t)K, 1);
    uint8_t *c1 = (uint8_t *)calloc((size_t)K * N, 1);
    uint8_t *c2 = (uint8_t *)calloc((size_t)K * N * N, 1);

    int64_t S[36];
    #define EVAL_Q(q, dst) do { \
        int64_t acc = 0; \
        const int64_t *vq = V_mat + (size_t)(q) * 36; \
        for (int z = 0; z < 36; z++) if (vq[z]) acc += vq[z] * S[z]; \
        int64_t diff = acc - targets[q]; \
        int64_t mm = (1LL << shifts[q]); \
        if (diff & (mm - 1)) out_mod_fail[q] = 1; \
        (dst) = (int)((diff >> shifts[q]) & 1LL); \
    } while (0)

    /* 0) origin */
    for (int zi = 0; zi < 36; zi++) {
        int wt = __builtin_popcountll(orig_36w[zi * 4 + 0]) + __builtin_popcountll(orig_36w[zi * 4 + 1])
               + __builtin_popcountll(orig_36w[zi * 4 + 2]) + __builtin_popcountll(orig_36w[zi * 4 + 3]);
        S[zi] = 256 - 2 * wt;
    }
    for (int q = 0; q < K; q++) {
        int b; EVAL_Q(q, b);
        c0[q] = (uint8_t)b;
        if (b) toggle_bit(out_rows + (size_t)q * n3_words, off0);
    }

    /* 1) linear */
    for (int i = 0; i < N; i++) {
        const uint64_t *bi = basis_36w + (size_t)i * 144;
        for (int zi = 0; zi < 36; zi++) {
            int wt = __builtin_popcountll(orig_36w[zi * 4 + 0] ^ bi[zi * 4 + 0])
                   + __builtin_popcountll(orig_36w[zi * 4 + 1] ^ bi[zi * 4 + 1])
                   + __builtin_popcountll(orig_36w[zi * 4 + 2] ^ bi[zi * 4 + 2])
                   + __builtin_popcountll(orig_36w[zi * 4 + 3] ^ bi[zi * 4 + 3]);
            S[zi] = 256 - 2 * wt;
        }
        for (int q = 0; q < K; q++) {
            int b; EVAL_Q(q, b);
            int val = b ^ c0[q];
            c1[q * N + i] = (uint8_t)val;
            if (val) toggle_bit(out_rows + (size_t)q * n3_words, off1 + (uint64_t)i);
        }
    }

    /* 2) quadratic */
    uint64_t xij[36][4];
    for (int i = 0; i < N; i++) {
        const uint64_t *bi = basis_36w + (size_t)i * 144;
        for (int j = i + 1; j < N; j++) {
            const uint64_t *bj = basis_36w + (size_t)j * 144;
            for (int zi = 0; zi < 36; zi++) {
                xij[zi][0] = orig_36w[zi * 4 + 0] ^ bi[zi * 4 + 0] ^ bj[zi * 4 + 0];
                xij[zi][1] = orig_36w[zi * 4 + 1] ^ bi[zi * 4 + 1] ^ bj[zi * 4 + 1];
                xij[zi][2] = orig_36w[zi * 4 + 2] ^ bi[zi * 4 + 2] ^ bj[zi * 4 + 2];
                xij[zi][3] = orig_36w[zi * 4 + 3] ^ bi[zi * 4 + 3] ^ bj[zi * 4 + 3];
                int wt = __builtin_popcountll(xij[zi][0]) + __builtin_popcountll(xij[zi][1])
                       + __builtin_popcountll(xij[zi][2]) + __builtin_popcountll(xij[zi][3]);
                S[zi] = 256 - 2 * wt;
            }
            uint64_t col2 = off2 + idx2_lex(N, i, j);
            for (int q = 0; q < K; q++) {
                int b; EVAL_Q(q, b);
                int val = b ^ c0[q] ^ c1[q * N + i] ^ c1[q * N + j];
                c2[(size_t)q * N * N + (size_t)i * N + j] = (uint8_t)val;
                if (val) toggle_bit(out_rows + (size_t)q * n3_words, col2);
            }
        }
    }

    /* 3) cubic */
    for (int i = 0; i < N; i++) {
        const uint64_t *bi = basis_36w + (size_t)i * 144;
        for (int j = i + 1; j < N; j++) {
            const uint64_t *bj = basis_36w + (size_t)j * 144;
            for (int zi = 0; zi < 36; zi++) {
                xij[zi][0] = orig_36w[zi * 4 + 0] ^ bi[zi * 4 + 0] ^ bj[zi * 4 + 0];
                xij[zi][1] = orig_36w[zi * 4 + 1] ^ bi[zi * 4 + 1] ^ bj[zi * 4 + 1];
                xij[zi][2] = orig_36w[zi * 4 + 2] ^ bi[zi * 4 + 2] ^ bj[zi * 4 + 2];
                xij[zi][3] = orig_36w[zi * 4 + 3] ^ bi[zi * 4 + 3] ^ bj[zi * 4 + 3];
            }
            for (int k = j + 1; k < N; k++) {
                const uint64_t *bk = basis_36w + (size_t)k * 144;
                for (int zi = 0; zi < 36; zi++) {
                    int wt = __builtin_popcountll(xij[zi][0] ^ bk[zi * 4 + 0])
                           + __builtin_popcountll(xij[zi][1] ^ bk[zi * 4 + 1])
                           + __builtin_popcountll(xij[zi][2] ^ bk[zi * 4 + 2])
                           + __builtin_popcountll(xij[zi][3] ^ bk[zi * 4 + 3]);
                    S[zi] = 256 - 2 * wt;
                }
                uint64_t col3 = idx3_lex(N, i, j, k);
                for (int q = 0; q < K; q++) {
                    int b; EVAL_Q(q, b);
                    int val = b ^ c0[q] ^ c1[q * N + i] ^ c1[q * N + j] ^ c1[q * N + k]
                            ^ c2[(size_t)q * N * N + (size_t)i * N + j]
                            ^ c2[(size_t)q * N * N + (size_t)i * N + k]
                            ^ c2[(size_t)q * N * N + (size_t)j * N + k];
                    if (val) toggle_bit(out_rows + (size_t)q * n3_words, col3);
                }
            }
        }
    }
    #undef EVAL_Q
    free(c0); free(c1); free(c2);
}

/*
 * Extract EXACT degree <= 4 ANF of K C_8-Walsh congruences on an N-var affine subspace!
 * Only call for K small (e.g. K <= 64) and N <= 105 where deg <= 4 was pre-screened!
 */
void extract_c8_walsh_deg4_sub_c(
    const uint64_t *orig_36w,
    const uint64_t *basis_36w,
    const int64_t *V_mat,
    const int64_t *targets,
    const int *shifts,
    int K,
    int N,
    uint64_t n4_words,
    uint64_t *out_rows,
    int *out_mod_fail
) {
    uint64_t n4 = comb4(N);
    uint64_t n3 = comb3(N);
    uint64_t n2 = comb2(N);
    uint64_t off3 = n4;
    uint64_t off2 = n4 + n3;
    uint64_t off1 = n4 + n3 + n2;
    uint64_t off0 = off1 + (uint64_t)N;

    memset(out_rows, 0, (size_t)K * (size_t)n4_words * sizeof(uint64_t));
    memset(out_mod_fail, 0, (size_t)K * sizeof(int));

    uint8_t *c0 = (uint8_t *)calloc((size_t)K, 1);
    uint8_t *c1 = (uint8_t *)calloc((size_t)K * N, 1);
    uint8_t *c2 = (uint8_t *)calloc((size_t)K * N * N, 1);
    /* c3[q][idx3] */
    uint8_t *c3 = (uint8_t *)calloc((size_t)K * (size_t)n3, 1);

    int64_t S0[36];
    for (int zi = 0; zi < 36; zi++) {
        int wt = __builtin_popcountll(orig_36w[zi * 4 + 0]) + __builtin_popcountll(orig_36w[zi * 4 + 1])
               + __builtin_popcountll(orig_36w[zi * 4 + 2]) + __builtin_popcountll(orig_36w[zi * 4 + 3]);
        S0[zi] = 256 - 2 * wt;
    }
    for (int q = 0; q < K; q++) {
        int64_t acc = 0;
        const int64_t *vq = V_mat + (size_t)q * 36;
        for (int z = 0; z < 36; z++) if (vq[z]) acc += vq[z] * S0[z];
        int64_t diff = acc - targets[q];
        if (diff & ((1LL << shifts[q]) - 1)) out_mod_fail[q] = 1;
        int b = (int)((diff >> shifts[q]) & 1LL);
        c0[q] = (uint8_t)b;
        if (b) toggle_bit(out_rows + (size_t)q * n4_words, off0);
    }

    for (int i = 0; i < N; i++) {
        const uint64_t *bi = basis_36w + (size_t)i * 144;
        int64_t S[36];
        for (int zi = 0; zi < 36; zi++) {
            int wt = __builtin_popcountll(orig_36w[zi * 4 + 0] ^ bi[zi * 4 + 0])
                   + __builtin_popcountll(orig_36w[zi * 4 + 1] ^ bi[zi * 4 + 1])
                   + __builtin_popcountll(orig_36w[zi * 4 + 2] ^ bi[zi * 4 + 2])
                   + __builtin_popcountll(orig_36w[zi * 4 + 3] ^ bi[zi * 4 + 3]);
            S[zi] = 256 - 2 * wt;
        }
        for (int q = 0; q < K; q++) {
            int64_t acc = 0;
            const int64_t *vq = V_mat + (size_t)q * 36;
            for (int z = 0; z < 36; z++) if (vq[z]) acc += vq[z] * S[z];
            int64_t diff = acc - targets[q];
            if (diff & ((1LL << shifts[q]) - 1)) out_mod_fail[q] = 1;
            int val = ((int)((diff >> shifts[q]) & 1LL)) ^ c0[q];
            c1[q * N + i] = (uint8_t)val;
            if (val) toggle_bit(out_rows + (size_t)q * n4_words, off1 + (uint64_t)i);
        }
    }

    for (int i = 0; i < N; i++) {
        const uint64_t *bi = basis_36w + (size_t)i * 144;
        for (int j = i + 1; j < N; j++) {
            const uint64_t *bj = basis_36w + (size_t)j * 144;
            int64_t S[36];
            for (int zi = 0; zi < 36; zi++) {
                int wt = __builtin_popcountll(orig_36w[zi * 4 + 0] ^ bi[zi * 4 + 0] ^ bj[zi * 4 + 0])
                       + __builtin_popcountll(orig_36w[zi * 4 + 1] ^ bi[zi * 4 + 1] ^ bj[zi * 4 + 1])
                       + __builtin_popcountll(orig_36w[zi * 4 + 2] ^ bi[zi * 4 + 2] ^ bj[zi * 4 + 2])
                       + __builtin_popcountll(orig_36w[zi * 4 + 3] ^ bi[zi * 4 + 3] ^ bj[zi * 4 + 3]);
                S[zi] = 256 - 2 * wt;
            }
            uint64_t col2 = off2 + idx2_lex(N, i, j);
            for (int q = 0; q < K; q++) {
                int64_t acc = 0;
                const int64_t *vq = V_mat + (size_t)q * 36;
                for (int z = 0; z < 36; z++) if (vq[z]) acc += vq[z] * S[z];
                int64_t diff = acc - targets[q];
                if (diff & ((1LL << shifts[q]) - 1)) out_mod_fail[q] = 1;
                int val = ((int)((diff >> shifts[q]) & 1LL)) ^ c0[q] ^ c1[q * N + i] ^ c1[q * N + j];
                c2[(size_t)q * N * N + (size_t)i * N + j] = (uint8_t)val;
                if (val) toggle_bit(out_rows + (size_t)q * n4_words, col2);
            }
        }
    }

    #pragma omp parallel for schedule(dynamic, 1)
    for (int i = 0; i < N; i++) {
        const uint64_t *bi = basis_36w + (size_t)i * 144;
        uint64_t xij[36][4], xijk[36][4];
        int64_t S[36];
        for (int j = i + 1; j < N; j++) {
            const uint64_t *bj = basis_36w + (size_t)j * 144;
            for (int zi = 0; zi < 36; zi++) {
                xij[zi][0] = orig_36w[zi * 4 + 0] ^ bi[zi * 4 + 0] ^ bj[zi * 4 + 0];
                xij[zi][1] = orig_36w[zi * 4 + 1] ^ bi[zi * 4 + 1] ^ bj[zi * 4 + 1];
                xij[zi][2] = orig_36w[zi * 4 + 2] ^ bi[zi * 4 + 2] ^ bj[zi * 4 + 2];
                xij[zi][3] = orig_36w[zi * 4 + 3] ^ bi[zi * 4 + 3] ^ bj[zi * 4 + 3];
            }
            for (int k = j + 1; k < N; k++) {
                const uint64_t *bk = basis_36w + (size_t)k * 144;
                for (int zi = 0; zi < 36; zi++) {
                    xijk[zi][0] = xij[zi][0] ^ bk[zi * 4 + 0];
                    xijk[zi][1] = xij[zi][1] ^ bk[zi * 4 + 1];
                    xijk[zi][2] = xij[zi][2] ^ bk[zi * 4 + 2];
                    xijk[zi][3] = xij[zi][3] ^ bk[zi * 4 + 3];
                    int wt = __builtin_popcountll(xijk[zi][0]) + __builtin_popcountll(xijk[zi][1])
                           + __builtin_popcountll(xijk[zi][2]) + __builtin_popcountll(xijk[zi][3]);
                    S[zi] = 256 - 2 * wt;
                }
                uint64_t i3 = idx3_lex(N, i, j, k);
                for (int q = 0; q < K; q++) {
                    int64_t acc = 0;
                    const int64_t *vq = V_mat + (size_t)q * 36;
                    for (int z = 0; z < 36; z++) if (vq[z]) acc += vq[z] * S[z];
                    int64_t diff = acc - targets[q];
                    if (diff & ((1LL << shifts[q]) - 1)) out_mod_fail[q] = 1;
                    int val = ((int)((diff >> shifts[q]) & 1LL))
                            ^ c0[q] ^ c1[q * N + i] ^ c1[q * N + j] ^ c1[q * N + k]
                            ^ c2[(size_t)q * N * N + (size_t)i * N + j]
                            ^ c2[(size_t)q * N * N + (size_t)i * N + k]
                            ^ c2[(size_t)q * N * N + (size_t)j * N + k];
                    c3[(size_t)q * (size_t)n3 + i3] = (uint8_t)val;
                    if (val) {
                        uint64_t col = off3 + i3;
                        #pragma omp atomic
                        out_rows[(size_t)q * n4_words + (col >> 6)] ^= (1ULL << (col & 63));
                    }
                }
            }
        }
    }

    /* Now degree 4 (uses completed c3!) */
    #pragma omp parallel for schedule(dynamic, 1)
    for (int i = 0; i < N; i++) {
        const uint64_t *bi = basis_36w + (size_t)i * 144;
        uint64_t xij[36][4], xijk[36][4];
        int64_t S[36];
        for (int j = i + 1; j < N; j++) {
            const uint64_t *bj = basis_36w + (size_t)j * 144;
            for (int zi = 0; zi < 36; zi++) {
                xij[zi][0] = orig_36w[zi * 4 + 0] ^ bi[zi * 4 + 0] ^ bj[zi * 4 + 0];
                xij[zi][1] = orig_36w[zi * 4 + 1] ^ bi[zi * 4 + 1] ^ bj[zi * 4 + 1];
                xij[zi][2] = orig_36w[zi * 4 + 2] ^ bi[zi * 4 + 2] ^ bj[zi * 4 + 2];
                xij[zi][3] = orig_36w[zi * 4 + 3] ^ bi[zi * 4 + 3] ^ bj[zi * 4 + 3];
            }
            for (int k = j + 1; k < N; k++) {
                const uint64_t *bk = basis_36w + (size_t)k * 144;
                for (int zi = 0; zi < 36; zi++) {
                    xijk[zi][0] = xij[zi][0] ^ bk[zi * 4 + 0];
                    xijk[zi][1] = xij[zi][1] ^ bk[zi * 4 + 1];
                    xijk[zi][2] = xij[zi][2] ^ bk[zi * 4 + 2];
                    xijk[zi][3] = xij[zi][3] ^ bk[zi * 4 + 3];
                }
                uint64_t i3_ijk = idx3_lex(N, i, j, k);
                for (int l = k + 1; l < N; l++) {
                    const uint64_t *bl = basis_36w + (size_t)l * 144;
                    for (int zi = 0; zi < 36; zi++) {
                        int wt = __builtin_popcountll(xijk[zi][0] ^ bl[zi * 4 + 0])
                               + __builtin_popcountll(xijk[zi][1] ^ bl[zi * 4 + 1])
                               + __builtin_popcountll(xijk[zi][2] ^ bl[zi * 4 + 2])
                               + __builtin_popcountll(xijk[zi][3] ^ bl[zi * 4 + 3]);
                        S[zi] = 256 - 2 * wt;
                    }
                    uint64_t i3_ijl = idx3_lex(N, i, j, l);
                    uint64_t i3_ikl = idx3_lex(N, i, k, l);
                    uint64_t i3_jkl = idx3_lex(N, j, k, l);
                    uint64_t col4 = idx4_lex(N, i, j, k, l);
                    for (int q = 0; q < K; q++) {
                        int64_t acc = 0;
                        const int64_t *vq = V_mat + (size_t)q * 36;
                        for (int z = 0; z < 36; z++) if (vq[z]) acc += vq[z] * S[z];
                        int64_t diff = acc - targets[q];
                        if (diff & ((1LL << shifts[q]) - 1)) out_mod_fail[q] = 1;
                        int val = ((int)((diff >> shifts[q]) & 1LL))
                                ^ c0[q] ^ c1[q * N + i] ^ c1[q * N + j] ^ c1[q * N + k] ^ c1[q * N + l]
                                ^ c2[(size_t)q * N * N + (size_t)i * N + j]
                                ^ c2[(size_t)q * N * N + (size_t)i * N + k]
                                ^ c2[(size_t)q * N * N + (size_t)i * N + l]
                                ^ c2[(size_t)q * N * N + (size_t)j * N + k]
                                ^ c2[(size_t)q * N * N + (size_t)j * N + l]
                                ^ c2[(size_t)q * N * N + (size_t)k * N + l]
                                ^ c3[(size_t)q * (size_t)n3 + i3_ijk]
                                ^ c3[(size_t)q * (size_t)n3 + i3_ijl]
                                ^ c3[(size_t)q * (size_t)n3 + i3_ikl]
                                ^ c3[(size_t)q * (size_t)n3 + i3_jkl];
                        if (val) {
                            #pragma omp atomic
                            out_rows[(size_t)q * n4_words + (col4 >> 6)] ^= (1ULL << (col4 & 63));
                        }
                    }
                }
            }
        }
    }
    free(c0); free(c1); free(c2); free(c3);
}

/*
 * Fast exact check of (0,4) + (1,3) + (2,2)-mod-Q blocks of K degree-4 rows in sheared (W, R) coords!
 * Here vars 0..nW-1 are W, vars nW..N-1 are R.
 * Step 1: Extract columns of deg-4 part where j >= nW (i.e. d_R >= 3, blocks (0,4) and (1,3))
 *         and compute exact GF(2) left nullspace!
 */
int extract_dR_ge3_submatrix_c(
    const uint64_t *rows,
    int K,
    int N,
    int nW,
    uint64_t n_words,
    uint64_t *out_sub,
    uint64_t sub_words
) {
    memset(out_sub, 0, (size_t)K * (size_t)sub_words * sizeof(uint64_t));
    uint64_t c4 = 0;
    uint64_t sc = 0;
    for (int i = 0; i < N; i++) {
        for (int j = i + 1; j < N; j++) {
            int ge3 = (j >= nW);
            for (int k = j + 1; k < N; k++) {
                for (int l = k + 1; l < N; l++) {
                    if (ge3) {
                        uint64_t w_src = c4 >> 6;
                        uint64_t m_src = 1ULL << (c4 & 63);
                        uint64_t w_dst = sc >> 6;
                        uint64_t m_dst = 1ULL << (sc & 63);
                        for (int r = 0; r < K; r++) {
                            if (rows[(size_t)r * n_words + w_src] & m_src) {
                                out_sub[(size_t)r * sub_words + w_dst] |= m_dst;
                            }
                        }
                        sc++;
                    }
                    c4++;
                }
            }
        }
    }
    return (int)sc;
}
"""


# ==============================================================================
# Helper Functions (Subspaces, C_8-Walsh v2=5..10, Coordinate Lifts, GF(2))
# ==============================================================================
def comb2(m): return 0 if m < 2 else m * (m - 1) // 2
def comb3(m): return 0 if m < 3 else m * (m - 1) * (m - 2) // 6
def comb4(m): return 0 if m < 4 else m * (m - 1) * (m - 2) * (m - 3) // 24


def build_coordinate_subspaces():
    """
    Build ALL coordinate C_16-orbits of dim 13 (35), dim 14 (8), dim 15 (1), dim 16 (1) = 45 total!
    Returns list of (tag, dim, mask_I, pts_uint16).
    """
    X16 = np.arange(65536, dtype=np.uint16)
    out = []
    for k in (13, 14, 15, 16):
        reps = s10.subset_orbits(k)
        for idx, I_mask in enumerate(reps):
            # V_I = {x in F_2^16 : (x & ~I_mask) == 0}
            fixed_zero = (~I_mask) & 0xFFFF
            pts = X16[(X16 & fixed_zero) == 0].copy()
            assert len(pts) == (1 << k)
            out.append((f"V{k}_c{idx:02d}", k, I_mask, pts))
    return out


def build_noncoord_v13_subspaces(n_extra=140, seed=60060):
    """Build n_extra random linear non-coordinate V_13 subspaces (each 8192 pts)."""
    X16 = np.arange(65536, dtype=np.uint16)
    rng = random.Random(seed)
    out = []
    seen = set()
    while len(out) < n_extra:
        h = []
        while len(h) < 3:
            v = rng.randint(1, 65535)
            x = v
            for u in h:
                x = min(x, x ^ u)
            if x:
                h.append(v)
        # Canonicalize 3-dim parity-check space
        span = sorted([0, h[0], h[1], h[2], h[0]^h[1], h[0]^h[2], h[1]^h[2], h[0]^h[1]^h[2]])
        key = tuple(span)
        if key in seen:
            continue
        # Skip pure coordinate subspaces (all 3 basis vectors weight 1)
        if sum(1 for u in span if u.bit_count() == 1) >= 3:
            continue
        seen.add(key)
        m = np.ones(65536, dtype=bool)
        for hv in h:
            p = np.zeros(65536, dtype=np.uint8)
            tmp = hv
            while tmp:
                lb = tmp & -tmp
                bit = lb.bit_length() - 1
                tmp ^= lb
                p ^= ((X16 >> bit) & 1).astype(np.uint8)
            m &= (p == 0)
        pts = np.flatnonzero(m).astype(np.uint16)
        assert len(pts) == 8192
        out.append((f"V13_nc{len(out):03d}", 13, 0, pts))
    return out


def pack_subspace_list(sub_list):
    """Pack list of (tag, dim, mask_I, pts) into flat C arrays."""
    pts_flat = np.concatenate([s[3] for s in sub_list]).astype(np.uint16)
    offs = []
    lens = []
    cur = 0
    for s in sub_list:
        offs.append(cur)
        ln = len(s[3])
        lens.append(ln)
        cur += ln
    return (
        np.ascontiguousarray(pts_flat, dtype=np.uint16),
        np.ascontiguousarray(offs, dtype=np.int32),
        np.ascontiguousarray(lens, dtype=np.int32),
    )


def build_c8_walsh_all_v2(cell_name):
    """
    Build ALL algebraically proven C_8-orbit Walsh congruences for MOD in (16, 32, 64, 128, 256, 512)
    (i.e. congruences mod 32, 64, 128, 256, 512, 1024 -> v2 = 5, 6, 7, 8, 9, 10!).
    Zero-Trust verifies EVERY spec BOTH algebraically AND on 300 random deg<=6 C_8-sym duals!
    """
    seen = set()
    c8_orbs = []
    for b in range(256):
        if b in seen:
            continue
        orb, cur = [], b
        while cur not in seen:
            seen.add(cur)
            orb.append(cur)
            cur = ((cur << 1) | (cur >> 7)) & 0xFF
        c8_orbs.append(orb)
    m = len(c8_orbs)
    assert m == 36
    z_reps = [o[0] for o in c8_orbs]

    A = np.zeros((m, m), dtype=np.int64)
    for i, z in enumerate(z_reps):
        for j, orb in enumerate(c8_orbs):
            A[i, j] = sum(-1 if ((b & z).bit_count() & 1) else 1 for b in orb)
    orb_sz = np.array([len(o) for o in c8_orbs], dtype=np.int64)
    orb_b0_par = np.array([sum(b & 1 for b in o) & 1 for o in c8_orbs], dtype=np.int64)

    # Zero-Trust check against 300 random C_8-symmetric deg <= 6 duals g
    rng_g = random.Random(600037)
    idx_ff = [j for j, o in enumerate(c8_orbs) if o[0] == 0xFF][0]
    G_W = []
    for _ in range(300):
        y = np.array([rng_g.getrandbits(1) for _ in range(m)], dtype=np.int64)
        if int((orb_b0_par * y).sum()) & 1:
            y[idx_ff] ^= 1
        if int((orb_sz * y).sum()) & 1:
            y[0] ^= 1
        G_W.append(A @ (1 - 2 * y))
    G_W = np.array(G_W, dtype=np.int64)

    specs = []  # (v_vec36, target, shift, mod_2x)
    seen_specs = set()
    for MOD in (16, 32, 64, 128, 256, 512):
        shift = MOD.bit_length() - 1
        A_ext = np.vstack([A, (MOD // 2) * orb_b0_par])
        ker = s36.mod_rref_kernel(A_ext, MOD)
        # Also explicitly include all 36 rows of A for MOD=256 (since A^2 = 256 I -> WHT of S(z) == 256 mod 512!)
        cands = [k[:36] % MOD for k in ker]
        if MOD == 256:
            for r in range(36):
                cands.append(A[r] % MOD)
        if MOD == 512:
            v_b0 = (orb_b0_par @ A) % MOD
            cands.append(v_b0)

        for v in cands:
            if not np.any(v != 0):
                continue
            # Algebraic Zero-Trust proof check:
            # v^T A must be == 0 (mod MOD) OR == (MOD/2)*orb_b0_par (mod MOD)
            vA = (v @ A) % MOD
            is_zero = np.all(vA == 0)
            is_b0 = np.all(vA == ((MOD // 2) * orb_b0_par) % MOD)
            if not (is_zero or is_b0):
                continue
            target = int((256 * int(v[0])) % (2 * MOD))
            # Reduce gcd if v is all even and target even (we still keep higher MOD if primitive!)
            g_vals = (G_W @ v) % (2 * MOD)
            assert np.all(g_vals == target), f"C8-Walsh algebraic mismatch at MOD={MOD}!"
            key = (shift, tuple(int(x) for x in v))
            if key not in seen_specs:
                seen_specs.add(key)
                specs.append((v.copy(), target, shift, 2 * MOD))

    return z_reps, specs


def build_affine_tt_basis(o_tt_111, b_tt_111, lin_pivs, active_vars):
    """
    Given lin_pivs {piv: (mask_111, rhs)} and active_vars (list of len N),
    build orig_tt[65536] and basis_tt[N, 65536] for the affine subspace!
    Also returns lift_aff(y_mask) and lift_tan(y_mask) functions.
    """
    N = len(active_vars)
    def lift_tan_111(act_mask_111):
        x = act_mask_111
        for p, (pv, _) in lin_pivs.items():
            if ((pv ^ (1 << p)) & x).bit_count() & 1:
                x |= (1 << p)
        return x

    def lift_aff_111(act_mask_111):
        x = act_mask_111
        for p, (pv, pr) in lin_pivs.items():
            if (((pv ^ (1 << p)) & x).bit_count() ^ pr) & 1:
                x |= (1 << p)
        return x

    x0 = lift_aff_111(0)
    orig_tt = o_tt_111.copy()
    tmp = x0
    while tmp:
        lb = tmp & -tmp
        orig_tt ^= b_tt_111[lb.bit_length() - 1]
        tmp ^= lb

    basis_tt = np.zeros((N, 65536), dtype=np.uint8)
    tan_111 = []
    for i, av in enumerate(active_vars):
        tv = lift_tan_111(1 << av)
        tan_111.append(tv)
        acc = np.zeros(65536, dtype=np.uint8)
        tmp = tv
        while tmp:
            lb = tmp & -tmp
            acc ^= b_tt_111[lb.bit_length() - 1]
            tmp ^= lb
        basis_tt[i] = acc

    return np.ascontiguousarray(orig_tt, dtype=np.uint8), np.ascontiguousarray(basis_tt, dtype=np.uint8), x0, tan_111


def build_sheared_tt_basis(o_tt_111, b_tt_111, lin_pivs, W_rref, W_pivs, T_rref, T_pivs, RF_vars):
    """
    Build EXACT sheared (W, T, RF) affine truth-table basis on `sr` (fixed eta)!
    Var order: [W_0..W_{nW-1}, T_0..T_{nT-1}, RF_0..RF_{nRF-1}].
    Zero-Trust asserts W_forms and T_forms act as exact coordinate projections!
    """
    def lift_tan_111(act_mask_111):
        x = act_mask_111
        for p, (pv, _) in lin_pivs.items():
            if ((pv ^ (1 << p)) & x).bit_count() & 1:
                x |= (1 << p)
        return x

    def lift_aff_111(act_mask_111):
        x = act_mask_111
        for p, (pv, pr) in lin_pivs.items():
            if (((pv ^ (1 << p)) & x).bit_count() ^ pr) & 1:
                x |= (1 << p)
        return x

    x0 = lift_aff_111(0)
    tan_act = []
    # 1. W directions: z_{W,k} = 1, z_T = 0, z_RF = 0 => x_{W_pivs[k]} = 1
    for wp in W_pivs:
        tan_act.append(1 << wp)
    # 2. T directions: z_{T,m} = 1, z_W = 0, z_RF = 0 => x_{T_pivs[m]} = 1, plus W_pivs where (W_rref[wp] >> tp) & 1
    for tp in T_pivs:
        am = 1 << tp
        for wp in W_pivs:
            if (W_rref[wp] >> tp) & 1:
                am |= (1 << wp)
        tan_act.append(am)
    # 3. RF directions: z_{RF,j} = 1, z_W = 0, z_T = 0 => x_{rf} = 1, then T_pivs, then W_pivs!
    for rfv in RF_vars:
        am = 1 << rfv
        for tp in T_pivs:
            if (T_rref[tp] >> rfv) & 1:
                am |= (1 << tp)
        for wp in W_pivs:
            if (W_rref[wp] & am).bit_count() & 1:
                am |= (1 << wp)
        tan_act.append(am)

    nW, nT, nRF = len(W_pivs), len(T_pivs), len(RF_vars)
    N = nW + nT + nRF
    # ZERO-TRUST ASSERTIONS on sheared tangent basis!
    for idx, am in enumerate(tan_act):
        for k, wp in enumerate(W_pivs):
            exp = 1 if idx == k else 0
            assert ((W_rref[wp] & am).bit_count() & 1) == exp, f"W shear mismatch idx={idx} k={k}"
        for m, tp in enumerate(T_pivs):
            exp = 1 if idx == nW + m else 0
            assert ((T_rref[tp] & am).bit_count() & 1) == exp, f"T shear mismatch idx={idx} m={m}"

    orig_tt = o_tt_111.copy()
    tmp = x0
    while tmp:
        lb = tmp & -tmp
        orig_tt ^= b_tt_111[lb.bit_length() - 1]
        tmp ^= lb

    basis_tt = np.zeros((N, 65536), dtype=np.uint8)
    tan_111 = []
    for i, am in enumerate(tan_act):
        tv = lift_tan_111(am)
        tan_111.append(tv)
        acc = np.zeros(65536, dtype=np.uint8)
        tmp = tv
        while tmp:
            lb = tmp & -tmp
            acc ^= b_tt_111[lb.bit_length() - 1]
            tmp ^= lb
        basis_tt[i] = acc

    return np.ascontiguousarray(orig_tt, dtype=np.uint8), np.ascontiguousarray(basis_tt, dtype=np.uint8), x0, tan_111


def pack_c8_36w(orig_tt, basis_tt, z_reps):
    """Pack orig_tt and basis_tt onto the 36 D_8 cosets (36 * 4 uint64 words each)."""
    N = basis_tt.shape[0]
    pts36 = np.array([[u | ((u ^ z) << 8) for u in range(256)] for z in z_reps], dtype=np.uint16)  # (36, 256)
    orig_bits = orig_tt[pts36]  # (36, 256)
    orig_36w = np.zeros((36, 4), dtype=np.uint64)
    for w in range(4):
        chunk = orig_bits[:, w * 64:(w + 1) * 64].astype(np.uint64)
        shifts = np.arange(64, dtype=np.uint64)[None, :]
        orig_36w[:, w] = np.bitwise_or.reduce(chunk << shifts, axis=1)

    basis_36w = np.zeros((N, 36, 4), dtype=np.uint64)
    shifts = np.arange(64, dtype=np.uint64)[None, None, :]
    for w in range(4):
        chunk = basis_tt[:, pts36[:, w * 64:(w + 1) * 64]].astype(np.uint64)  # (N, 36, 64)
        basis_36w[:, :, w] = np.bitwise_or.reduce(chunk << shifts, axis=2)

    return np.ascontiguousarray(orig_36w.reshape(-1), dtype=np.uint64), np.ascontiguousarray(basis_36w.reshape(-1), dtype=np.uint64)


def deg3_subrow_to_111_pset(row_u64, N, active_vars, is_deg4_buf=False):
    """
    Convert a degree <= 3 row in N active vars (either from deg4 buf [deg4|deg3|deg2|deg1|deg0]
    or deg3 buf [deg3|deg2|deg1|deg0]) to a 111-var pset (set of 111-bit monomial masks).
    """
    n4 = comb4(N) if is_deg4_buf else 0
    n3 = comb3(N)
    n2 = comb2(N)
    off3 = n4
    off2 = n4 + n3
    off1 = n4 + n3 + n2
    off0 = off1 + N

    def gbit(col):
        return (int(row_u64[col >> 6]) >> (col & 63)) & 1

    ps = set()
    if gbit(off0):
        ps.add(0)
    for i in range(N):
        if gbit(off1 + i):
            ps.add(1 << active_vars[i])
    c2 = 0
    for i in range(N):
        bi = 1 << active_vars[i]
        for j in range(i + 1, N):
            if gbit(off2 + c2):
                ps.add(bi | (1 << active_vars[j]))
            c2 += 1
    c3 = 0
    for i in range(N):
        bi = 1 << active_vars[i]
        for j in range(i + 1, N):
            bij = bi | (1 << active_vars[j])
            for k in range(j + 1, N):
                if gbit(off3 + c3):
                    ps.add(bij | (1 << active_vars[k]))
                c3 += 1
    return ps


def gf2_left_nullspace_u64(rows_u64, K, n_words):
    """
    Compute exact GF(2) rank and left nullspace of a (K, n_words) uint64 matrix!
    Returns (rank, list of K-bit combination ints in left nullspace).
    """
    piv = {}  # col -> (row_arr, comb_int)
    nulls = []
    for i in range(K):
        r = rows_u64[i].copy()
        comb = 1 << i
        while True:
            # find first nonzero word
            nz = np.flatnonzero(r)
            if len(nz) == 0:
                nulls.append(comb)
                break
            w = int(nz[0])
            val = int(r[w])
            bit = (val & -val).bit_length() - 1
            col = (w << 6) + bit
            if col in piv:
                pr, pc = piv[col]
                r[w:] ^= pr[w:]
                comb ^= pc
            else:
                piv[col] = (r, comb)
                break
    return len(piv), nulls


def run_mod_Qt_exact_block_test(rows_u64, K, N, nW, nT, nRF, Q_quad_vecs, lib_d4, tag=""):
    """
    EXACT NECESSARY & SUFFICIENT TEST for whether ANY linear combination of `K` degree-4 rows
    in sheared (W, T, RF) coordinates drops to degree <= 3 modulo <Q_m^{(2)}(w) * x_i * x_j>:
      Block (0,4)+(1,3): d_R >= 3 -> MUST vanish identically! (gives kernel K1)
      Block (2,2):       for each r_a < r_b, P^{(2,2)}_{ab}(w) in span(Q_m^{(2)}(w))! (gives K2 <= K1)
      Block (3,1):       for each r_a, P^{(3,1)}_a(w) in span(Q_m^{(2)}(w) * w_s)! (gives K3 <= K2)
      Block (4,0):       P^{(4,0)}(w) in span(Q_m^{(2)}(w) * w_s * w_t)! (gives K4 <= K3)
    """
    n_words = rows_u64.shape[1]
    nR = nT + nRF
    # Count columns with j >= nW (d_R >= 3)
    n_ge3 = comb4(nR) + nW * comb3(nR)
    sub_words = (n_ge3 + 63) // 64
    sub_mat = np.zeros((K, sub_words), dtype=np.uint64)
    sc = lib_d4.extract_dR_ge3_submatrix_c(
        rows_u64.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        K, N, nW, n_words,
        sub_mat.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        sub_words,
    )
    assert sc == n_ge3
    rk1, K1 = gf2_left_nullspace_u64(sub_mat, K, sub_words)
    print(f"      [{tag} Mod-Q_t Block (0,4)+(1,3) (d_R>=3, cols={n_ge3})]: rk={rk1}/{K}, dim(K1)={len(K1)}", flush=True)
    if not K1:
        return 0, []

    # Step 2: Check (2,2) block mod span(Q_m^{(2)}(w))!
    # Build RREF of Q_quad_vecs (shape (n_q, nW2)) as Python bitmasks
    nW2 = comb2(nW)
    q_piv = {}
    for qv in Q_quad_vecs:
        x = qv
        while x:
            b = x.bit_length() - 1
            if b in q_piv:
                x ^= q_piv[b]
            else:
                q_piv[b] = x
                break
    q_piv_sorted = sorted(q_piv.keys(), reverse=True)

    # Combine K1 rows
    d1 = len(K1)
    K1_rows = np.zeros((d1, n_words), dtype=np.uint64)
    for idx_k, cm in enumerate(K1):
        tmp = cm
        while tmp:
            lb = tmp & -tmp
            K1_rows[idx_k] ^= rows_u64[lb.bit_length() - 1]
            tmp ^= lb

    # For each pair r1 < r2 (nW <= r1 < r2 < N), extract W-quadratic and reduce mod q_piv!
    # Build reduced (2,2) matrix over GF(2) on K1
    nR2 = comb2(nR)
    # Use sparse dict of columns -> bitmask of length d1
    piv2 = {}
    K2_combs = []
    # Precompute lex4 column base for (w1, w2, r1, r2)
    # Note: i=w1 < j=w2 < k=r1 < l=r2!
    # idx4(N, w1, w2, r1, r2) = (C4(N)-C4(N-w1)) + (C3(N-1-w1)-C3(N-w2)) + (C2(N-1-w2)-C2(N-r1)) + (r2 - r1 - 1)
    c4_N = comb4(N)
    w_pair_base = []
    for w1 in range(nW):
        b1 = c4_N - comb4(N - w1)
        c3_1 = comb3(N - 1 - w1)
        for w2 in range(w1 + 1, nW):
            b2 = b1 + (c3_1 - comb3(N - w2)) + comb2(N - 1 - w2)
            w_pair_base.append(b2)
    assert len(w_pair_base) == nW2

    # Build row bit-vectors for each of the d1 combos across all nR2 pairs of R
    res2_ints = [0] * d1
    bit_cursor = 0
    for r1 in range(nW, N):
        c2_r1 = comb2(N - r1)
        for r2 in range(r1 + 1, N):
            off_r = (r2 - r1 - 1) - c2_r1
            # Extract W-quad for each of d1 combos
            any_nz = False
            vals = [0] * d1
            for w_idx_p, b2 in enumerate(w_pair_base):
                col = b2 + off_r
                w = col >> 6
                m = 1 << (col & 63)
                for idx_k in range(d1):
                    if int(K1_rows[idx_k, w]) & m:
                        vals[idx_k] |= (1 << w_idx_p)
                        any_nz = True
            if not any_nz:
                continue
            for idx_k in range(d1):
                v = vals[idx_k]
                if v:
                    for pb in q_piv_sorted:
                        if (v >> pb) & 1:
                            v ^= q_piv[pb]
                    if v:
                        res2_ints[idx_k] |= (v << bit_cursor)
            bit_cursor += nW2

    # Left nullspace of res2_ints (d1 rows)
    piv_r2 = {}
    K2 = []
    for idx_k in range(d1):
        v = res2_ints[idx_k]
        cm = K1[idx_k]
        while v:
            b = v.bit_length() - 1
            if b in piv_r2:
                pv, pc = piv_r2[b]
                v ^= pv
                cm ^= pc
            else:
                piv_r2[b] = (v, cm)
                break
        else:
            K2.append(cm)
    print(f"      [{tag} Mod-Q_t Block (2,2) mod span(Q_m^(2))]: rk={len(piv_r2)}/{d1}, dim(K2)={len(K2)}", flush=True)
    if not K2:
        return 0, []

    # Step 3: Check (3,1) block mod span(Q_m^{(2)}(w) * w_s)!
    nW3 = comb3(nW)
    # Map (a,b,c) -> lex3 index in 0..nW3-1
    w3_idx = {}
    c3 = 0
    for a in range(nW):
        for b in range(a + 1, nW):
            for c in range(b + 1, nW):
                w3_idx[(a, b, c)] = c3
                c3 += 1
    w2_pairs = [(a, b) for a in range(nW) for b in range(a + 1, nW)]
    q3_piv = {}
    for qv in Q_quad_vecs:
        pairs_in_q = [w2_pairs[p] for p in range(nW2) if (qv >> p) & 1]
        for s in range(nW):
            mask3 = 0
            for a, b in pairs_in_q:
                if s != a and s != b:
                    t = tuple(sorted((a, b, s)))
                    mask3 ^= (1 << w3_idx[t])
            x = mask3
            while x:
                b_bit = x.bit_length() - 1
                if b_bit in q3_piv:
                    x ^= q3_piv[b_bit]
                else:
                    q3_piv[b_bit] = x
                    break
    q3_piv_sorted = sorted(q3_piv.keys(), reverse=True)

    d2 = len(K2)
    K2_rows = np.zeros((d2, n_words), dtype=np.uint64)
    for idx_k, cm in enumerate(K2):
        tmp = cm
        while tmp:
            lb = tmp & -tmp
            K2_rows[idx_k] ^= rows_u64[lb.bit_length() - 1]
            tmp ^= lb

    res3_ints = [0] * d2
    bit_cursor = 0
    for r1 in range(nW, N):
        vals = [0] * d2
        any_nz = False
        c3_i = 0
        for a in range(nW):
            b1 = c4_N - comb4(N - a)
            c3_a = comb3(N - 1 - a)
            for b in range(a + 1, nW):
                b2 = b1 + (c3_a - comb3(N - b))
                c2_b = comb2(N - 1 - b)
                for c in range(b + 1, nW):
                    col = b2 + (c2_b - comb2(N - c)) + (r1 - c - 1)
                    w = col >> 6
                    m = 1 << (col & 63)
                    for idx_k in range(d2):
                        if int(K2_rows[idx_k, w]) & m:
                            vals[idx_k] |= (1 << c3_i)
                            any_nz = True
                    c3_i += 1
        if not any_nz:
            continue
        for idx_k in range(d2):
            v = vals[idx_k]
            if v:
                for pb in q3_piv_sorted:
                    if (v >> pb) & 1:
                        v ^= q3_piv[pb]
                if v:
                    res3_ints[idx_k] |= (v << bit_cursor)
        bit_cursor += nW3

    piv_r3 = {}
    K3 = []
    for idx_k in range(d2):
        v = res3_ints[idx_k]
        cm = K2[idx_k]
        while v:
            b = v.bit_length() - 1
            if b in piv_r3:
                pv, pc = piv_r3[b]
                v ^= pv
                cm ^= pc
            else:
                piv_r3[b] = (v, cm)
                break
        else:
            K3.append(cm)
    print(f"      [{tag} Mod-Q_t Block (3,1) mod span(Q_m^(2)*w)]: rk={len(piv_r3)}/{d2}, dim(K3)={len(K3)}", flush=True)
    if not K3:
        return 0, []

    # Step 4: Check (4,0) block mod span(Q_m^{(2)}(w) * w_s * w_t)!
    nW4 = comb4(nW)
    w4_idx = {}
    c4_i = 0
    for a in range(nW):
        for b in range(a + 1, nW):
            for c in range(b + 1, nW):
                for d in range(c + 1, nW):
                    w4_idx[(a, b, c, d)] = c4_i
                    c4_i += 1
    q4_piv = {}
    for qv in Q_quad_vecs:
        pairs_in_q = [w2_pairs[p] for p in range(nW2) if (qv >> p) & 1]
        for s in range(nW):
            for t in range(s + 1, nW):
                mask4 = 0
                for a, b in pairs_in_q:
                    if s != a and s != b and t != a and t != b:
                        quad = tuple(sorted((a, b, s, t)))
                        mask4 ^= (1 << w4_idx[quad])
                x = mask4
                while x:
                    b_bit = x.bit_length() - 1
                    if b_bit in q4_piv:
                        x ^= q4_piv[b_bit]
                    else:
                        q4_piv[b_bit] = x
                        break
    q4_piv_sorted = sorted(q4_piv.keys(), reverse=True)

    d3 = len(K3)
    K3_rows = np.zeros((d3, n_words), dtype=np.uint64)
    for idx_k, cm in enumerate(K3):
        tmp = cm
        while tmp:
            lb = tmp & -tmp
            K3_rows[idx_k] ^= rows_u64[lb.bit_length() - 1]
            tmp ^= lb

    piv_r4 = {}
    K4 = []
    for idx_k in range(d3):
        v = 0
        c4_w = 0
        for a in range(nW):
            b1 = c4_N - comb4(N - a)
            c3_a = comb3(N - 1 - a)
            for b in range(a + 1, nW):
                b2 = b1 + (c3_a - comb3(N - b))
                c2_b = comb2(N - 1 - b)
                for c in range(b + 1, nW):
                    b3 = b2 + (c2_b - comb2(N - c))
                    for d in range(c + 1, nW):
                        col = b3 + (d - c - 1)
                        if (int(K3_rows[idx_k, col >> 6]) >> (col & 63)) & 1:
                            v |= (1 << c4_w)
                        c4_w += 1
        for pb in q4_piv_sorted:
            if (v >> pb) & 1:
                v ^= q4_piv[pb]
        cm = K3[idx_k]
        while v:
            b = v.bit_length() - 1
            if b in piv_r4:
                pv, pc = piv_r4[b]
                v ^= pv
                cm ^= pc
            else:
                piv_r4[b] = (v, cm)
                break
        else:
            K4.append(cm)
    print(f"      [{tag} Mod-Q_t Block (4,0) mod span(Q_m^(2)*w*w)]: rk={len(piv_r4)}/{d3}, *** dim(K4)={len(K4)} ***", flush=True)
    return len(K4), K4


def test_c8_walsh_on_subspace(
    orig_tt, basis_tt, z_reps, c8_specs, lib_d4, active_vars,
    sub_state, lib9, tbl, tag="", do_deg4_extract=False, rng_seed=6060
):
    """
    Audit ALL C_8-Walsh congruences (MOD=16, 32, 64, 128, 256, 512) on an N-var affine subspace!
    1. Evaluates S_{D_8}(z_0..z_35) on 64 random points + 16 4th-diff tuples + 12 5th-diff tuples!
    2. Detects:
       - Instant 1=0 (constant nonzero mod 2*MOD)
       - Exact deg <= 3 drops (either at top bit `shift` or any lower bit `b < shift` where 2^b | diff!)
       - Exact deg == 4 equations (optional extraction for joint combo with V_13!)
    3. Extracts exact deg <= 3 ANF in C, Zero-Trust verifies on 50 fresh random points (0 mismatches),
       and tests injection into `sub_state` via s9.run_branch_cascade!
    """
    N = len(active_vars)
    mask64 = (1 << 64) - 1
    orig_36w, basis_36w = pack_c8_36w(orig_tt, basis_tt, z_reps)

    rng = random.Random(rng_seed)
    R_rand = 64
    T_fd4 = 12   # 12 * 16 = 192 pts (tests deg <= 3)
    T_fd5 = 8    #  8 * 32 = 256 pts (tests deg <= 4)
    pts_all = [rng.getrandbits(N) for _ in range(R_rand)]
    for _ in range(T_fd4):
        x0 = rng.getrandbits(N)
        ds = [rng.getrandbits(N) for _ in range(4)]
        for s in range(16):
            p = x0
            for b in range(4):
                if (s >> b) & 1:
                    p ^= ds[b]
            pts_all.append(p)
    for _ in range(T_fd5):
        x0 = rng.getrandbits(N)
        ds = [rng.getrandbits(N) for _ in range(5)]
        for s in range(32):
            p = x0
            for b in range(5):
                if (s >> b) & 1:
                    p ^= ds[b]
            pts_all.append(p)

    R_tot = len(pts_all)
    pts_lo = np.array([x & mask64 for x in pts_all], dtype=np.uint64)
    pts_hi = np.array([x >> 64 for x in pts_all], dtype=np.uint64)
    S_out = np.zeros((R_tot, 36), dtype=np.int64)
    lib_d4.eval_c8_S_batch_c(
        orig_36w.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        basis_36w.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        N,
        pts_lo.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        pts_hi.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        R_tot,
        S_out.ctypes.data_as(ctypes.POINTER(ctypes.c_int64)),
    )

    S_rand = S_out[:R_rand]
    S_fd4 = S_out[R_rand:R_rand + T_fd4 * 16].reshape(T_fd4, 16, 36)
    S_fd5 = S_out[R_rand + T_fd4 * 16:].reshape(T_fd5, 32, 36)

    cand_deg3 = []  # (v, target, b_shift, orig_shift)
    cand_deg4 = []  # (v, target, b_shift, orig_shift)
    const_nonzero = []
    by_mod_deg = {}  # (2*MOD, deg_cat) -> count

    for idx_s, (v, target, shift, mod2) in enumerate(c8_specs):
        diffs_r = (S_rand @ v - target) % mod2
        # Find lowest bit b <= shift where diffs_r is NOT identically 0
        if np.all(diffs_r == 0):
            by_mod_deg[(mod2, "const0")] = by_mod_deg.get((mod2, "const0"), 0) + 1
            continue
        # Check if constant nonzero!
        if len(set(int(u) for u in diffs_r)) == 1:
            # Find lowest set bit of this constant
            cval = int(diffs_r[0])
            b_low = (cval & -cval).bit_length() - 1
            const_nonzero.append((idx_s, mod2, cval, b_low))
            cand_deg3.append((v, target % (1 << (b_low + 1)), b_low, shift))
            by_mod_deg[(mod2, "CONST_NZ")] = by_mod_deg.get((mod2, "CONST_NZ"), 0) + 1
            continue

        # Find highest power of 2 dividing ALL diffs_r
        or_all = 0
        for u in diffs_r:
            or_all |= int(u)
        b_low = (or_all & -or_all).bit_length() - 1  # guaranteed 2^{b_low} | diff on all 64 rand pts
        if b_low > shift:
            continue

        # Test deg <= 3 on bit b_low using T_fd4 tuples!
        d4 = (S_fd4 @ v - target)
        if np.all((d4 & ((1 << b_low) - 1)) == 0):
            bits4 = (d4 >> b_low) & 1
            fd4_par = np.bitwise_xor.reduce(bits4, axis=1)
            if not np.any(fd4_par):
                cand_deg3.append((v, target % (1 << (b_low + 1)), b_low, shift))
                by_mod_deg[(mod2, f"deg<=3@b{b_low}")] = by_mod_deg.get((mod2, f"deg<=3@b{b_low}"), 0) + 1
                continue

        # Test deg == 4 on bit b_low using T_fd5 tuples!
        d5 = (S_fd5 @ v - target)
        if np.all((d5 & ((1 << b_low) - 1)) == 0):
            bits5 = (d5 >> b_low) & 1
            fd5_par = np.bitwise_xor.reduce(bits5, axis=1)
            if not np.any(fd5_par):
                cand_deg4.append((v, target % (1 << (b_low + 1)), b_low, shift))
                by_mod_deg[(mod2, f"deg4@b{b_low}")] = by_mod_deg.get((mod2, f"deg4@b{b_low}"), 0) + 1
                continue

        by_mod_deg[(mod2, f"deg>=5@b{b_low}")] = by_mod_deg.get((mod2, f"deg>=5@b{b_low}"), 0) + 1

    print(f"      [{tag} C8-Walsh v2=5..10 census]: const_nz={len(const_nonzero)}, cand_deg3={len(cand_deg3)}, cand_deg4={len(cand_deg4)} | {dict(sorted(by_mod_deg.items()))}", flush=True)

    # Extract & Zero-Trust verify ALL cand_deg3!
    verified_psets = []
    if cand_deg3:
        # Deduplicate by (b_shift, v mod 2^{b_shift})
        uniq_c3 = []
        seen_c3 = set()
        for v, tgt, b_sh, orig_sh in cand_deg3:
            key = (b_sh, tuple(int(x) % (1 << (b_sh + 1)) for x in v))
            if key not in seen_c3:
                seen_c3.add(key)
                uniq_c3.append((v, tgt, b_sh, orig_sh))

        K3 = len(uniq_c3)
        n3_cols = comb3(N) + comb2(N) + N + 1
        n3_words = (n3_cols + 63) // 64
        V_mat = np.ascontiguousarray(np.vstack([x[0] for x in uniq_c3]), dtype=np.int64)
        tgts = np.ascontiguousarray([x[1] for x in uniq_c3], dtype=np.int64)
        shs = np.ascontiguousarray([x[2] for x in uniq_c3], dtype=np.int32)
        out_r3 = np.zeros((K3, n3_words), dtype=np.uint64)
        out_mf = np.zeros(K3, dtype=np.int32)

        lib_d4.extract_c8_walsh_deg3_sub_c(
            orig_36w.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            basis_36w.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            V_mat.ctypes.data_as(ctypes.POINTER(ctypes.c_int64)),
            tgts.ctypes.data_as(ctypes.POINTER(ctypes.c_int64)),
            shs.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
            K3, N, n3_words,
            out_r3.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            out_mf.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
        )

        # Zero-Trust verify on 50 fresh random points!
        R_zt = 50
        rng_zt = random.Random(rng_seed + 999)
        zt_pts = [rng_zt.getrandbits(N) for _ in range(R_zt)]
        zt_lo = np.array([x & mask64 for x in zt_pts], dtype=np.uint64)
        zt_hi = np.array([x >> 64 for x in zt_pts], dtype=np.uint64)
        S_zt = np.zeros((R_zt, 36), dtype=np.int64)
        lib_d4.eval_c8_S_batch_c(
            orig_36w.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            basis_36w.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            N,
            zt_lo.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            zt_hi.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            R_zt,
            S_zt.ctypes.data_as(ctypes.POINTER(ctypes.c_int64)),
        )

        # Build 111-bit lifted zt points for exact pset verification
        zt_111 = []
        for y in zt_pts:
            x = 0
            for i in range(N):
                if (y >> i) & 1:
                    x |= (1 << active_vars[i])
            zt_111.append(x)

        for q in range(K3):
            if out_mf[q] != 0:
                continue
            v, tgt, b_sh, orig_sh = uniq_c3[q]
            diffs_zt = S_zt @ v - tgt
            if np.any((diffs_zt & ((1 << b_sh) - 1)) != 0):
                continue
            actuals = (diffs_zt >> b_sh) & 1
            ps = deg3_subrow_to_111_pset(out_r3[q], N, active_vars, is_deg4_buf=False)
            ok = True
            for r in range(R_zt):
                pe = 0
                x111 = zt_111[r]
                for m in ps:
                    if (m & x111) == m:
                        pe ^= 1
                if pe != int(actuals[r]):
                    ok = False
                    break
            if ok:
                verified_psets.append((orig_sh, b_sh, ps))

        has_1eq0 = any(ps == {0} for _, _, ps in verified_psets)
        print(f"      [{tag} C8-Walsh deg<=3 ZERO-TRUST VERIFIED]: {len(verified_psets)}/{K3} passed 50/50 ZT | 1=0={has_1eq0}", flush=True)

    # Optionally extract deg4 C8-Walsh rows (deduplicated, capped at 48 for speed)
    deg4_c8_rows = None
    if do_deg4_extract and cand_deg4 and N <= 105:
        uniq_c4 = []
        seen_c4 = set()
        for v, tgt, b_sh, orig_sh in cand_deg4:
            key = (b_sh, tuple(int(x) % (1 << (b_sh + 1)) for x in v))
            if key not in seen_c4:
                seen_c4.add(key)
                uniq_c4.append((v, tgt, b_sh, orig_sh))
        uniq_c4 = uniq_c4[:48]
        K4 = len(uniq_c4)
        n4_cols = comb4(N) + comb3(N) + comb2(N) + N + 1
        n4_words = (n4_cols + 63) // 64
        V4 = np.ascontiguousarray(np.vstack([x[0] for x in uniq_c4]), dtype=np.int64)
        t4 = np.ascontiguousarray([x[1] for x in uniq_c4], dtype=np.int64)
        s4 = np.ascontiguousarray([x[2] for x in uniq_c4], dtype=np.int32)
        out_r4 = np.zeros((K4, n4_words), dtype=np.uint64)
        out_mf4 = np.zeros(K4, dtype=np.int32)
        lib_d4.extract_c8_walsh_deg4_sub_c(
            orig_36w.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            basis_36w.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            V4.ctypes.data_as(ctypes.POINTER(ctypes.c_int64)),
            t4.ctypes.data_as(ctypes.POINTER(ctypes.c_int64)),
            s4.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
            K4, N, n4_words,
            out_r4.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            out_mf4.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
        )
        # Zero-Trust verify on 50 random points!
        R_zt = 50
        rng_zt = random.Random(rng_seed + 1999)
        zt_pts = [rng_zt.getrandbits(N) for _ in range(R_zt)]
        zt_lo = np.array([x & mask64 for x in zt_pts], dtype=np.uint64)
        zt_hi = np.array([x >> 64 for x in zt_pts], dtype=np.uint64)
        S_zt = np.zeros((R_zt, 36), dtype=np.int64)
        lib_d4.eval_c8_S_batch_c(
            orig_36w.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            basis_36w.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            N,
            zt_lo.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            zt_hi.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
            R_zt,
            S_zt.ctypes.data_as(ctypes.POINTER(ctypes.c_int64)),
        )
        good_rows = []
        n4_c = comb4(N); n3_c = comb3(N); n2_c = comb2(N)
        off3 = n4_c; off2 = n4_c + n3_c; off1 = off2 + n2_c; off0 = off1 + N
        # Precompute eval masks in Python/numpy? Fast enough for 50 pts if we evaluate directly
        # Build bit positions for each of 50 pts
        pt_masks = np.zeros((R_zt, n4_words), dtype=np.uint64)
        c4_N = comb4(N); c3_N = comb3(N); c2_N = comb2(N)
        for r, y in enumerate(zt_pts):
            ones = [i for i in range(N) if (y >> i) & 1]
            m = len(ones)
            pt_masks[r, off0 >> 6] ^= np.uint64(1 << (off0 & 63))
            for a in range(m):
                ia = ones[a]
                col = off1 + ia
                pt_masks[r, col >> 6] ^= np.uint64(1 << (col & 63))
                b2_a = c2_N - comb2(N - ia)
                b3_a = c3_N - comb3(N - ia) + comb2(N - 1 - ia)
                b4_a = c4_N - comb4(N - ia) + comb3(N - 1 - ia)
                for b in range(a + 1, m):
                    ib = ones[b]
                    col2 = off2 + b2_a + (ib - ia - 1)
                    pt_masks[r, col2 >> 6] ^= np.uint64(1 << (col2 & 63))
                    b3_ab = b3_a - comb2(N - ib)
                    b4_ab = b4_a - comb3(N - ib) + comb2(N - 1 - ib)
                    for c in range(b + 1, m):
                        ic = ones[c]
                        col3 = off3 + b3_ab + (ic - ib - 1)
                        pt_masks[r, col3 >> 6] ^= np.uint64(1 << (col3 & 63))
                        b4_abc = b4_ab - comb2(N - ic)
                        for d in range(c + 1, m):
                            id_ = ones[d]
                            col4 = b4_abc + (id_ - ic - 1)
                            pt_masks[r, col4 >> 6] ^= np.uint64(1 << (col4 & 63))
        for q in range(K4):
            if out_mf4[q] != 0:
                continue
            v, tgt, b_sh, orig_sh = uniq_c4[q]
            diffs_zt = S_zt @ v - tgt
            if np.any((diffs_zt & ((1 << b_sh) - 1)) != 0):
                continue
            actuals = (diffs_zt >> b_sh) & 1
            ok = True
            for r in range(R_zt):
                x = np.bitwise_xor.reduce(out_r4[q] & pt_masks[r])
                if (int(x).bit_count() & 1) != int(actuals[r]):
                    ok = False
                    break
            if ok:
                good_rows.append(out_r4[q])
        if good_rows:
            deg4_c8_rows = np.vstack(good_rows)
        print(f"      [{tag} C8-Walsh deg==4 ZERO-TRUST VERIFIED]: {len(good_rows)}/{K4} passed 50/50 ZT!", flush=True)

    return verified_psets, deg4_c8_rows


def inject_psets_into_s9(sub_state, new_psets, lib9, tbl):
    """Inject a list of verified 111-var deg<=3 psets into an existing s9 state and run cascade!"""
    if not new_psets:
        return sub_state, False
    n_cw = tbl["n_col_words"]
    old_q = list(sub_state["_quad_ids"])
    old_c = list(sub_state["_cub_ids"])
    n_old_q = len(old_q)
    n_old_c = len(old_c)
    n_new = len(new_psets)
    tot = n_old_q + n_old_c + n_new
    buf = (ctypes.c_uint64 * (tot * n_cw))()
    for i, rid in enumerate(old_q):
        ctypes.memmove(ctypes.byref(buf, i * n_cw * 8), ctypes.byref(sub_state["_buf"], rid * n_cw * 8), n_cw * 8)
    for i, rid in enumerate(old_c):
        ctypes.memmove(ctypes.byref(buf, (n_old_q + i) * n_cw * 8), ctypes.byref(sub_state["_buf"], rid * n_cw * 8), n_cw * 8)
    for i, ps in enumerate(new_psets):
        s9.pset_to_row(ps, buf, n_old_q + n_old_c + i, tbl)

    new_st = s9.run_branch_cascade(
        lib9, buf, list(range(n_old_q)), list(range(n_old_q, tot)),
        sub_state["_lin_pivs"], [], tbl, max_xl_rounds=25, verify_subst=False
    )
    changed = (
        new_st["closed_unsat"]
        or len(new_st["_lin_pivs"]) != len(sub_state["_lin_pivs"])
        or len(new_st["_quad_ids"]) != len(sub_state["_quad_ids"])
        or len(new_st["_cub_ids"]) != len(sub_state["_cub_ids"])
    )
    return new_st, changed


def extract_and_audit_deg4_family(orig_tt, basis_tt, sub_list, lib_d4, tag="", rng_seed=6001):
    """
    Extract exact degree-4 ANF for all subspaces in sub_list, Zero-Trust verify on 50 random points
    (asserting 0 mod-8 fails AND 0 mismatches!), and return (rows_u64, n4_cols, n_total_cols).
    """
    K = len(sub_list)
    N = basis_tt.shape[0]
    n4 = comb4(N); n3 = comb3(N); n2 = comb2(N)
    n_total_cols = n4 + n3 + n2 + N + 1
    n_words = (n_total_cols + 63) // 64

    pts_flat, pts_off, pts_len = pack_subspace_list(sub_list)
    rows_u64 = np.zeros((K, n_words), dtype=np.uint64)
    status = np.zeros(K, dtype=np.int32)

    t0 = time.perf_counter()
    lib_d4.extract_wt_div8_deg4_batch_c(
        orig_tt.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
        basis_tt.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
        pts_flat.ctypes.data_as(ctypes.POINTER(ctypes.c_uint16)),
        pts_off.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
        pts_len.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
        K, N, n_words,
        rows_u64.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        status.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
    )
    dt_ext = time.perf_counter() - t0
    assert np.all(status == 0), f"[{tag}] Divisibility failure in deg-4 extractor: {status[status != 0]}"

    # ZERO-TRUST VERIFICATION ON 50 RANDOM INPUTS!
    R_ver = 50
    rng = random.Random(rng_seed)
    mask64 = (1 << 64) - 1
    ver_pts = [rng.getrandbits(N) for _ in range(R_ver)]
    ver_lo = np.array([x & mask64 for x in ver_pts], dtype=np.uint64)
    ver_hi = np.array([x >> 64 for x in ver_pts], dtype=np.uint64)
    m8_fail = ctypes.c_int(0)
    mism = ctypes.c_int(0)
    t_v = time.perf_counter()
    lib_d4.verify_deg4_batch_c(
        orig_tt.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
        basis_tt.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
        pts_flat.ctypes.data_as(ctypes.POINTER(ctypes.c_uint16)),
        pts_off.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
        pts_len.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
        rows_u64.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        K, N, n_words,
        ver_lo.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        ver_hi.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        R_ver,
        ctypes.byref(m8_fail),
        ctypes.byref(mism),
    )
    dt_ver = time.perf_counter() - t_v
    assert m8_fail.value == 0, f"[{tag}] ZT mod-8 fail count = {m8_fail.value}!"
    assert mism.value == 0, f"[{tag}] ZT MISMATCH count = {mism.value}!"
    print(f"    [{tag}] Extracted K={K} deg-4 eqs (N={N}, n4={n4}) in {dt_ext:.2f}s | ZT VERIFIED {K}x{R_ver}={K*R_ver} evals: 0 mod8-fails, 0 mismatches ({dt_ver:.2f}s)!", flush=True)
    return rows_u64, n4, n_total_cols


def echelon_and_harvest_deg3_drops(
    rows_u64, n4_cols, n_total_cols, N, active_vars, lib_d4, tag="",
    zt_ctx=None
):
    """
    Run C GF(2) echelon on deg-4 rows; return (deg4_rank, list of dropped deg<=3 111-var psets, zero_rows).
    If zt_ctx=(orig_tt, basis_tt, sub_list) is provided and active_vars is not None, every dropped
    degree<=3 pset is Zero-Trust verified against the exact linear combination of (wt(f|_V)/8) mod 2
    on 20 fresh random points!
    """
    K, n_words = rows_u64.shape
    work = rows_u64.copy()
    piv_cols = np.zeros(K, dtype=np.int64)
    comb_nw = (K + 63) // 64
    comb_out = np.zeros((K, comb_nw), dtype=np.uint64)
    rk4 = lib_d4.gf2_echelon_deg4_c(
        work.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        K, n_words, n4_cols, n_total_cols,
        piv_cols.ctypes.data_as(ctypes.POINTER(ctypes.c_int64)),
        comb_out.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        comb_nw,
    )
    drops = []
    drop_combs = []
    n_zero = 0
    for i in range(K):
        pc = int(piv_cols[i])
        if pc < 0:
            n_zero += 1
        elif pc >= n4_cols:
            if active_vars is not None:
                ps = deg3_subrow_to_111_pset(work[i], N, active_vars, is_deg4_buf=True)
                drops.append(ps)
                drop_combs.append(comb_out[i].copy())
            else:
                drops.append(work[i].copy())
                drop_combs.append(comb_out[i].copy())

    if drops and zt_ctx is not None and active_vars is not None:
        orig_tt, basis_tt, sub_list = zt_ctx
        if len(sub_list) == K:
            rng_z = random.Random(60999 + K)
            for _ in range(20):
                y = rng_z.getrandbits(N)
                tt = orig_tt.copy()
                x111 = 0
                for b in range(N):
                    if (y >> b) & 1:
                        tt ^= basis_tt[b]
                        x111 |= (1 << active_vars[b])
                wts_bit = [((int(tt[pts].sum()) >> 3) & 1) for _, _, _, pts in sub_list]
                for ps, cw in zip(drops, drop_combs):
                    exp = 0
                    for r_idx in range(K):
                        if (int(cw[r_idx >> 6]) >> (r_idx & 63)) & 1:
                            exp ^= wts_bit[r_idx]
                    pe = 0
                    for m in ps:
                        if (m & x111) == m:
                            pe ^= 1
                    assert pe == exp, f"[{tag}] Dropped deg<=3 pset ZT mismatch: pe={pe} != exp={exp}!"
            print(f"      [{tag} DROPS ZT-VERIFIED]: all {len(drops)} dropped deg<=3 psets matched 20/20 truth-table evals!", flush=True)

    print(f"      [{tag} Echelon K={K}]: deg4_rank={rk4}, *** DEG<=3 DROPS={len(drops)} ***, identical_zero={n_zero}", flush=True)
    return rk4, drops, n_zero


def test_vq_4th_diff_drops(orig_tt, basis_tt, Q_polys_W, sub_list, nW, nT, nRF, tag="", rng_seed=6070):
    """
    Direct variety V(Q) restriction (t_m = Q_m(w)) 4th-difference degree-drop test!
    Catches ANY degree <= 3 equation in (w, r_F) on V(Q) arising from arbitrary-degree Q_t syzygies!
    Evaluates BOTH:
      - ALL-dir 4th diffs on V(Q) (d_total <= 3 in (w, r_F))
      - RF-only 4th diffs on V(Q) (d_{RF} <= 3, keeping w & t constant!)
    """
    K = len(sub_list)
    rng = random.Random(rng_seed)

    def eval_Q_t(w_bits):
        t_bits = 0
        for m, qp in enumerate(Q_polys_W):
            v = 0
            for mon in qp:
                if (mon & w_bits) == mon:
                    v ^= 1
            if v:
                t_bits |= (1 << m)
        return t_bits

    def run_mode(mode_name, T_tup, rf_only=False):
        # Generate T_tup 4th-diff tuples on V(Q)
        # Each tuple = 16 points in F_2^{nW + nT + nRF}
        M_mat = np.zeros((K, T_tup), dtype=np.uint8)
        BS = 16
        basis_f32 = basis_tt.astype(np.float32)
        for t0 in range(0, T_tup, BS):
            t1 = min(T_tup, t0 + BS)
            nb = t1 - t0
            Z = np.zeros((nb * 16, nW + nT + nRF), dtype=np.float32)
            for bi in range(nb):
                w0 = rng.getrandbits(nW)
                rf0 = rng.getrandbits(nRF)
                dw = [0 if rf_only else rng.getrandbits(nW) for _ in range(4)]
                drf = [rng.getrandbits(nRF) for _ in range(4)]
                for s in range(16):
                    w = w0
                    rf = rf0
                    for b in range(4):
                        if (s >> b) & 1:
                            w ^= dw[b]
                            rf ^= drf[b]
                    t = eval_Q_t(w)
                    row = Z[bi * 16 + s]
                    for i in range(nW):
                        if (w >> i) & 1: row[i] = 1.0
                    for m in range(nT):
                        if (t >> m) & 1: row[nW + m] = 1.0
                    for j in range(nRF):
                        if (rf >> j) & 1: row[nW + nT + j] = 1.0
            F = (orig_tt[None, :] ^ (np.rint(Z @ basis_f32).astype(np.int32) & 1)).astype(np.uint8)
            F_r = F.reshape(nb, 16, 65536)
            for i, (_, _, _, pts) in enumerate(sub_list):
                wts = F_r[:, :, pts].sum(axis=2)
                bits = (wts >> 3) & 1
                M_mat[i, t0:t1] = np.bitwise_xor.reduce(bits, axis=1).astype(np.uint8)

        # Compute GF(2) rank & left nullspace of M_mat
        piv = {}
        nulls = []
        for i in range(K):
            val = 0
            for c in np.flatnonzero(M_mat[i]):
                val |= (1 << int(c))
            cm = 1 << i
            while val:
                b = val.bit_length() - 1
                if b in piv:
                    pv, pc = piv[b]
                    val ^= pv; cm ^= pc
                else:
                    piv[b] = (val, cm)
                    break
            else:
                nulls.append(cm)
        print(f"      [{tag} V(Q) 4th-diff {mode_name} (T={T_tup})]: rk={len(piv)}/{K}, *** NULLS={len(nulls)} ***", flush=True)
        return len(piv), nulls

    run_mode("ALL_(w,rF)", min(220, K + 40), rf_only=False)
    run_mode("RF_only", min(220, K + 40), rf_only=True)


def main():
    t0 = time.perf_counter()
    parser = argparse.ArgumentParser()
    parser.add_argument("--cell", choices=["B0_11", "B1_11"], required=True)
    args = parser.parse_args()
    cell_name = args.cell

    print(f"\n==================== [{cell_name}] STEP 60C: DEGREE-4 V_13..V_16 + C_8-WALSH v2=5..10 + SHATTERED-FIBER XL ====================", flush=True)

    # 1. Compile C libraries
    c_d4, so_d4 = WORK_DIR / "s60c_deg4.c", WORK_DIR / "libs60c_deg4.so"
    c_d4.write_text(C_DEG4_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-fopenmp", "-shared", "-fPIC", str(c_d4), "-o", str(so_d4)], check=True)
    lib_d4 = ctypes.CDLL(str(so_d4))
    lib_d4.extract_wt_div8_deg4_batch_c.argtypes = [
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_uint16), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.c_uint64,
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
    ]
    lib_d4.verify_deg4_batch_c.argtypes = [
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_uint16), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int, ctypes.c_uint64,
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
    ]
    lib_d4.gf2_echelon_deg4_c.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_uint64, ctypes.c_uint64, ctypes.c_uint64,
        ctypes.POINTER(ctypes.c_int64), ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
    ]
    lib_d4.gf2_echelon_deg4_c.restype = ctypes.c_int
    lib_d4.eval_c8_S_batch_c.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
        ctypes.POINTER(ctypes.c_int64),
    ]
    lib_d4.extract_c8_walsh_deg3_sub_c.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.POINTER(ctypes.c_int64), ctypes.POINTER(ctypes.c_int64), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.c_uint64,
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
    ]
    lib_d4.extract_c8_walsh_deg4_sub_c.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.POINTER(ctypes.c_int64), ctypes.POINTER(ctypes.c_int64), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.c_uint64,
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
    ]
    lib_d4.extract_dR_ge3_submatrix_c.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_uint64,
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_uint64,
    ]
    lib_d4.extract_dR_ge3_submatrix_c.restype = ctypes.c_int

    c_diag, so_diag = WORK_DIR / "s60c_diag.c", WORK_DIR / "libs60c_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s60c_s9.c", WORK_DIR / "libs60c_s9.so"
    c_s9.write_text(s9.C_STEP9_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_s9), "-o", str(so_s9)], check=True)
    lib9 = s45a._setup_lib9(so_s9)

    c_cg, so_cg = WORK_DIR / "s60c_cg.c", WORK_DIR / "libs60c_cg.so"
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

    c_sh, so_sh = WORK_DIR / "s60c_sh.c", WORK_DIR / "libs60c_sh.so"
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

    # 2. Build cell base algebraic system & CG(389)
    orbits = diag_v2.build_orbits_116()
    layer_vecs = s16.build_orb_degu_degz_vecs(orbits)
    mon_to_orb_arr = (ctypes.c_int16 * 65536)(*([-1] * 65536))
    for j, orb in enumerate(orbits):
        for mm in orb:
            mon_to_orb_arr[mm] = j
    reps12, reps11 = s10.subset_orbits(12), s10.subset_orbits(11)
    v6_list = diag_v2.all_v6_orbits()
    _, u8_size8, nonzero_z = diag_v2.build_c8_orbits()
    M_rows = []
    for rep_z, _ in nonzero_z:
        row_mask = 0
        for m_idx, (_, u_orb) in enumerate(u8_size8):
            s = sum(1 if ((u & rep_z).bit_count() & 1) == 0 else -1 for u in u_orb)
            if (s // 2) & 1:
                row_mask |= (1 << m_idx)
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
        if (x & 0xFF) == (x >> 8) or seen_x[x]:
            continue
        r_idx = len(rot4_reps)
        rot4_reps.append(x)
        for y in (x, diag_v2.rot16(x, 4), diag_v2.rot16(x, 8), diag_v2.rot16(x, 12)):
            seen_x[y] = 1
            rep_of_x[y] = r_idx
    coset_0xf_reps = []
    vis16 = bytearray(65536)
    for x in range(65536):
        if vis16[x]:
            continue
        cur, mem = x, []
        while not vis16[cur]:
            vis16[cur] = 1
            mem.append(cur)
            cur = diag_v2.rot16(cur)
        if len(mem) == 16:
            vnib = (x & 0xF) ^ ((x >> 4) & 0xF) ^ ((x >> 8) & 0xF) ^ ((x >> 12) & 0xF)
            if vnib == 0xF:
                coset_0xf_reps.append(mem[0])

    X16 = np.arange(65536, dtype=np.uint16)
    orb_tts = [bytearray(65536) for _ in range(116)]
    orb_tt_np = np.zeros((116, 65536), dtype=np.uint8)
    orb_diag, orb_pair, orb_r4, orb_0xf_parity = [0] * 116, [0] * 116, [0] * 116, [0] * 116
    for j, orb in enumerate(orbits):
        acc = np.zeros(65536, dtype=np.uint8)
        for mm in orb:
            acc ^= ((X16 & mm) == mm).astype(np.uint8)
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
    n, n_cw = tbl["n"], tbl["n_col_words"]
    mask64 = (1 << 64) - 1
    c99, c57, c113 = int(cell_name[1]), int(cell_name[3]), int(cell_name[4])
    free111, origin111, cb111 = b09.build_pure_111_basis(c99, c57, c113)

    # Precompute 111-var truth tables
    o_tt_111 = np.zeros(65536, dtype=np.uint8)
    tmp = origin111
    while tmp:
        lb = tmp & -tmp
        o_tt_111 ^= orb_tt_np[lb.bit_length() - 1]
        tmp ^= lb
    b_tt_111 = np.zeros((111, 65536), dtype=np.uint8)
    for i, m in enumerate(cb111):
        tmp = m
        while tmp:
            lb = tmp & -tmp
            b_tt_111[i] ^= orb_tt_np[lb.bit_length() - 1]
            tmp ^= lb

    orb_map = (ctypes.c_int * 116)(*([-1] * 116))
    for i, j in enumerate(free111):
        orb_map[j] = i
    orb_map[0] = -3
    orb_map[115] = -1
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
    root_active = sorted(i for i in range(111) if i not in root["_lin_pivs"])
    print(f"[{cell_name}] ROOT baseline: N_act={len(root_active)}, q={len(root['_quad_ids'])}, c={len(root['_cub_ids'])}, n_eta_free={len(eta_free)} ({time.perf_counter()-t0:.1f}s)", flush=True)

    # 3. Build Subspace Families & C_8-Walsh v2=5..10 Specs
    coord_subs = build_coordinate_subspaces()  # 35 V13 + 8 V14 + 1 V15 + 1 V16 = 45!
    v13_coord = [s for s in coord_subs if s[1] == 13]
    v13_v14_coord = [s for s in coord_subs if s[1] in (13, 14)]
    noncoord_v13 = build_noncoord_v13_subspaces(n_extra=130, seed=60060)
    all_subs = coord_subs + noncoord_v13
    print(f"[{cell_name}] Subspace families: V13_coord={len(v13_coord)}, V13+V14_coord={len(v13_v14_coord)}, ALL_coord(V13..16)={len(coord_subs)}, noncoord_V13={len(noncoord_v13)}", flush=True)

    z_reps, c8_specs = build_c8_walsh_all_v2(cell_name)
    c8_by_mod = {}
    for _, _, _, m2 in c8_specs:
        c8_by_mod[m2] = c8_by_mod.get(m2, 0) + 1
    print(f"[{cell_name}] Algebraically-PROVEN & ZT-verified C_8-Walsh specs: total={len(c8_specs)} by 2*MOD={dict(sorted(c8_by_mod.items()))}", flush=True)

    # ==========================================================================
    # PART 1: ROOT DEGREE-4 EXTRACTION, ZERO-TRUST AUDIT, & DEGREE-DROP TEST!
    # ==========================================================================
    print(f"\n==================== PART 1: [{cell_name}] ROOT (N={len(root_active)}) V_13..V_16 + C_8-WALSH ====================", flush=True)
    orig_r, basis_r, _, _ = build_affine_tt_basis(o_tt_111, b_tt_111, root["_lin_pivs"], root_active)
    rows_r_all, n4_r, ntot_r = extract_and_audit_deg4_family(orig_r, basis_r, all_subs, lib_d4, tag=f"{cell_name}_ROOT_ALL175", rng_seed=6010)

    # Check degree-4 ranks & degree<=3 drops for: 35 V13, 43 V13+V14, 45 coord, ALL 175!
    echelon_and_harvest_deg3_drops(rows_r_all[:35], n4_r, ntot_r, len(root_active), root_active, lib_d4, tag="ROOT_V13_35")
    echelon_and_harvest_deg3_drops(rows_r_all[:43], n4_r, ntot_r, len(root_active), root_active, lib_d4, tag="ROOT_V13+14_43")
    _, drops_r45, _ = echelon_and_harvest_deg3_drops(rows_r_all[:45], n4_r, ntot_r, len(root_active), root_active, lib_d4, tag="ROOT_COORD_45")
    _, drops_r175, _ = echelon_and_harvest_deg3_drops(rows_r_all, n4_r, ntot_r, len(root_active), root_active, lib_d4, tag="ROOT_ALL_175")

    if drops_r175:
        root_after, chg = inject_psets_into_s9(root, drops_r175, lib9, tbl)
        print(f"    [ROOT INJECT {len(drops_r175)} deg<=3 drops]: changed={chg}, closed={root_after['closed_unsat']}, N={111-len(root_after['_lin_pivs'])}, q={len(root_after['_quad_ids'])}, c={len(root_after['_cub_ids'])}", flush=True)

    # C_8-Walsh v2=5..10 at Root!
    c8_r_psets, _ = test_c8_walsh_on_subspace(orig_r, basis_r, z_reps, c8_specs, lib_d4, root_active, root, lib9, tbl, tag=f"{cell_name}_ROOT", do_deg4_extract=False, rng_seed=6015)
    if c8_r_psets:
        root_c8, chg = inject_psets_into_s9(root, [p for _, _, p in c8_r_psets], lib9, tbl)
        print(f"    [ROOT INJECT {len(c8_r_psets)} C8-Walsh deg<=3]: changed={chg}, closed={root_c8['closed_unsat']}, N={111-len(root_c8['_lin_pivs'])}, q={len(root_c8['_quad_ids'])}, c={len(root_c8['_cub_ids'])}", flush=True)

    # ==========================================================================
    # PART 2 & 3: FIXED-ETA PURE + MOD-Q_t + V(Q) + C_8-WALSH (DEG3 & DEG4)!
    # ==========================================================================
    test_etas = [0, 5, 9, 11] if cell_name == "B0_11" else [0, 3, 8, 10]
    print(f"\n==================== PART 2 & 3: [{cell_name}] FIXED-ETA DEGREE-DROP + MOD-Q_t + C_8-WALSH ====================", flush=True)

    eta_cache = {}
    for em in test_etas:
        print(f"\n  ---------------- [{cell_name} eta={em}] ----------------", flush=True)
        n_ef = len(eta_free)
        ex_eta = [(eta_free[k], (em >> k) & 1) for k in range(n_ef)]
        sr = s9.run_branch_cascade(
            lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
            ex_eta, tbl, max_xl_rounds=20, verify_subst=False
        )
        if sr["closed_unsat"]:
            print(f"    [{cell_name} eta={em}] Already closed UNSAT by s9!", flush=True)
            continue

        qps = [s9.row_to_pset(sr["_buf"], qr, tbl) for qr in sr["_quad_ids"]]
        ana = s16.analyze_quad_system(qps)
        W_rref = s19.strict_rref_masks(list(ana["W_piv"].values()))
        W_pivs = sorted(W_rref.keys())
        W_set = set(W_pivs)
        W_forms_111 = [W_rref[p] for p in W_pivs]
        active_now = sorted(i for i in range(n) if i not in sr["_lin_pivs"])
        R_vars = [v for v in active_now if v not in W_set]
        R_set = set(R_vars)

        # Shear quadratics to extract exact T_rref & Q_m(w)!
        n_q = len(sr["_quad_ids"])
        work_q = (ctypes.c_uint64 * (n_q * n_cw))()
        for i, rid in enumerate(sr["_quad_ids"]):
            ctypes.memmove(ctypes.byref(work_q, i * n_cw * 8), ctypes.byref(sr["_buf"], rid * n_cw * 8), n_cw * 8)
        for p in W_pivs:
            rest = W_rref[p] ^ (1 << p)
            if rest:
                lib_sh.shear_subst_var_batch(
                    work_q, n_q, n_cw, n, tbl["off2"], tbl["off1"], tbl["off0"],
                    tbl["col2_base"], tbl["col3_base"], tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"],
                    p, rest & mask64, rest >> 64
                )
        tail_forms = []
        for qi in range(n_q):
            qps_sh = s9.row_to_pset(work_q, qi, tbl)
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
        nW, nT, nRF = len(W_pivs), len(T_pivs), len(RF_vars)
        for p in T_pivs:
            rest = T_rref[p] ^ (1 << p)
            if rest:
                lib_sh.shear_subst_var_batch(
                    work_q, n_q, n_cw, n, tbl["off2"], tbl["off1"], tbl["off0"],
                    tbl["col2_base"], tbl["col3_base"], tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"],
                    p, rest & mask64, rest >> 64
                )

        # Extract exact Q_m(w) polynomials (in 0..nW-1 bitmasks) and pure deg-2 parts Q_quad_vecs!
        w_idx = {v: i for i, v in enumerate(W_pivs)}
        t_idx = {v: i for i, v in enumerate(T_pivs)}
        Q_polys_W = [set() for _ in range(nT)]
        Q_quad_vecs = []
        nW2 = comb2(nW)
        w2_to_col = {}
        c2_i = 0
        for a in range(nW):
            for b in range(a + 1, nW):
                w2_to_col[(a, b)] = c2_i
                c2_i += 1
        # Solve linear system over T_pivs in case multiple T_pivs appear in one sheared quad
        q_psets_sh = [s9.row_to_pset(work_q, qi, tbl) for qi in range(n_q)]
        # Build RREF on T_pivs linear parts
        t_rows = []
        for ps in q_psets_sh:
            tm = 0
            wp = set()
            qv = 0
            for m in ps:
                if m == 0:
                    wp.add(0)
                else:
                    vs = [b for b in range(n) if (m >> b) & 1]
                    if len(vs) == 1 and vs[0] in t_idx:
                        tm |= (1 << t_idx[vs[0]])
                    else:
                        wm = 0
                        for v in vs:
                            assert v in w_idx, f"Unexpected non-W var {v} in sheared quad!"
                            wm |= (1 << w_idx[v])
                        wp.add(wm)
                        if len(vs) == 2:
                            a, b = sorted((w_idx[vs[0]], w_idx[vs[1]]))
                            qv ^= (1 << w2_to_col[(a, b)])
            if qv:
                Q_quad_vecs.append(qv)
            t_rows.append((tm, wp))
        # Reduce t_rows to get explicit t_m = Q_m(w)
        piv_t = {}
        for tm, wp in t_rows:
            cur_t, cur_w = tm, set(wp)
            while cur_t:
                b = (cur_t & -cur_t).bit_length() - 1
                if b in piv_t:
                    pt, pw = piv_t[b]
                    cur_t ^= pt
                    cur_w ^= pw
                else:
                    piv_t[b] = (cur_t, cur_w)
                    break
        # Back-substitute piv_t for clean t_m = Q_m(w)
        for b in sorted(piv_t.keys(), reverse=True):
            pt, pw = piv_t[b]
            for b2 in sorted(piv_t.keys()):
                if b2 < b and ((piv_t[b2][0] >> b) & 1):
                    piv_t[b2] = (piv_t[b2][0] ^ pt, piv_t[b2][1] ^ pw)
        for m in range(nT):
            assert m in piv_t and piv_t[m][0] == (1 << m), f"T_piv {m} not isolated!"
            Q_polys_W[m] = piv_t[m][1]

        print(f"    [{cell_name} eta={em}] N={len(active_now)} (nW={nW}, nT={nT}, nRF={nRF}), n_q={n_q}, n_c={len(sr['_cub_ids'])}", flush=True)
        eta_cache[em] = (sr, W_forms_111, W_pivs, nW, nT, nRF)

        # Build sheared truth-table basis AND Zero-Trust verify that all n_q quadratics vanish on V(Q)!
        orig_sh, basis_sh, x0_sh, tan111_sh = build_sheared_tt_basis(
            o_tt_111, b_tt_111, sr["_lin_pivs"], W_rref, W_pivs, T_rref, T_pivs, RF_vars
        )
        # Zero-Trust check of sheared Q_m(w) against original sr["_quad_ids"] on 20 random V(Q) points!
        rng_vq = random.Random(6020 + em)
        for _ in range(20):
            w_b = rng_vq.getrandbits(nW)
            rf_b = rng_vq.getrandbits(nRF)
            t_b = 0
            for m in range(nT):
                v = 0
                for mon in Q_polys_W[m]:
                    if (mon & w_b) == mon:
                        v ^= 1
                if v:
                    t_b |= (1 << m)
            x111 = x0_sh
            for i in range(nW):
                if (w_b >> i) & 1: x111 ^= tan111_sh[i]
            for m in range(nT):
                if (t_b >> m) & 1: x111 ^= tan111_sh[nW + m]
            for j in range(nRF):
                if (rf_b >> j) & 1: x111 ^= tan111_sh[nW + nT + j]
            for qr in sr["_quad_ids"]:
                rptr = ctypes.cast(ctypes.byref(sr["_buf"], qr * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
                val = lib9.eval_row_s9(rptr, n_cw, tbl["off0"], tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"], x111 & mask64, x111 >> 64)
                assert val == 0, f"Zero-Trust V(Q) parameterization mismatch on eta={em}!"

        # Extract ALL 45 coord (+ 130 non-coord for main orbits eta=0, 5 / 0, 3) in sheared coords!
        use_subs = all_subs if em in (0, 5, 3) else coord_subs
        rows_sh, n4_sh, ntot_sh = extract_and_audit_deg4_family(orig_sh, basis_sh, use_subs, lib_d4, tag=f"{cell_name}_eta{em}_SH", rng_seed=6030 + em)

        # (2A) Pure linear-combo degree-4 drops on fixed-eta
        echelon_and_harvest_deg3_drops(rows_sh[:35], n4_sh, ntot_sh, len(active_now), None, lib_d4, tag=f"eta{em}_V13_35")
        echelon_and_harvest_deg3_drops(rows_sh[:43], n4_sh, ntot_sh, len(active_now), None, lib_d4, tag=f"eta{em}_V13+14_43")
        echelon_and_harvest_deg3_drops(rows_sh[:45], n4_sh, ntot_sh, len(active_now), None, lib_d4, tag=f"eta{em}_COORD_45")
        if len(use_subs) > 45:
            echelon_and_harvest_deg3_drops(rows_sh, n4_sh, ntot_sh, len(active_now), None, lib_d4, tag=f"eta{em}_ALL_175")

        # (2B) EXACT block-by-block ideal reduction mod <Q_t>!
        run_mod_Qt_exact_block_test(rows_sh[:45], 45, len(active_now), nW, nT, nRF, Q_quad_vecs, lib_d4, tag=f"eta{em}_COORD45")
        if len(use_subs) > 45:
            run_mod_Qt_exact_block_test(rows_sh, len(use_subs), len(active_now), nW, nT, nRF, Q_quad_vecs, lib_d4, tag=f"eta{em}_ALL175")

        # (2C) Direct V(Q) restriction 4th-diff drop test on coord_subs (45 eqs = full 43-dim deg-4 span!)
        test_vq_4th_diff_drops(orig_sh, basis_sh, Q_polys_W, coord_subs, nW, nT, nRF, tag=f"eta{em}_COORD45", rng_seed=6040 + em)

        # (PART 3) C_8-Walsh v2=5..10 audit on fixed-eta (including deg-4 extraction & joint combo on eta=0!)
        orig_act, basis_act, _, _ = build_affine_tt_basis(o_tt_111, b_tt_111, sr["_lin_pivs"], active_now)
        c8_ps, c8_d4 = test_c8_walsh_on_subspace(
            orig_act, basis_act, z_reps, c8_specs, lib_d4, active_now, sr, lib9, tbl,
            tag=f"{cell_name}_eta{em}", do_deg4_extract=(em == 0), rng_seed=6050 + em
        )
        if c8_ps:
            sr_c8, chg = inject_psets_into_s9(sr, [p for _, _, p in c8_ps], lib9, tbl)
            print(f"      [eta={em} INJECT {len(c8_ps)} C8-Walsh deg<=3]: changed={chg}, closed={sr_c8['closed_unsat']}, N={111-len(sr_c8['_lin_pivs'])}, q={len(sr_c8['_quad_ids'])}, c={len(sr_c8['_cub_ids'])}", flush=True)
        if c8_d4 is not None and len(c8_d4) > 0:
            # Extract V13..V16 in unsheared active_now coords (same coords as c8_d4) and test JOINT combo!
            rows_act45, n4_a, ntot_a = extract_and_audit_deg4_family(orig_act, basis_act, coord_subs, lib_d4, tag=f"eta{em}_ACT45_for_C8", rng_seed=6055 + em)
            joint = np.vstack([rows_act45, c8_d4])
            _, joint_drops, _ = echelon_and_harvest_deg3_drops(joint, n4_a, ntot_a, len(active_now), active_now, lib_d4, tag=f"eta{em}_JOINT_COORD45+C8DEG4")
            if joint_drops:
                sr_j, chg = inject_psets_into_s9(sr, joint_drops, lib9, tbl)
                print(f"      [eta={em} JOINT INJECT {len(joint_drops)} drops]: changed={chg}, closed={sr_j['closed_unsat']}, N={111-len(sr_j['_lin_pivs'])}, q={len(sr_j['_quad_ids'])}, c={len(sr_j['_cub_ids'])}", flush=True)

    # ==========================================================================
    # PART 4: SHATTERED-FIBER INJECTION TEST (U_1^perp FIXED, s9.run_branch_cascade)!
    # ==========================================================================
    print(f"\n==================== PART 4: [{cell_name}] SHATTERED-FIBER DEGREE-4 + C_8-WALSH INJECTION ====================", flush=True)
    shatter_etas = [0, 5, 9] if cell_name == "B0_11" else [0, 3, 8]
    d_cands = [22, 24, 26, 28] if cell_name == "B0_11" else [18, 20, 22, 24]
    rng_f = np.random.default_rng(6090)

    for em in shatter_etas:
        if em not in eta_cache:
            continue
        sr, W_forms_111, W_pivs, nW, nT, nRF = eta_cache[em]
        sys_ex = s45b.extract_eta_exact_system(em, root, eta_free, lib9, lib_sh, tbl, rng_seed=6090 + em)
        if sys_ex.get("closed_unsat"):
            continue
        M0_c, Mk_c = sys_ex["M0_c"], sys_ex["Mk_c"]
        print(f"\n  ======== [{cell_name} eta={em}] M1_strict={M0_c.shape}, nW={nW} ========", flush=True)

        for d_free in d_cands:
            if d_free >= nW:
                continue
            U_opt, _, bkey = s57b.optimize_u1_basis(M0_c, Mk_c, d_free, em_seed=em)
            U1 = U_opt[:d_free]
            F_sub = s40a.gf2_nullspace_np(U1)  # TRUE ANNIHILATOR U1^perp!
            k_fix = F_sub.shape[0]
            assert k_fix == nW - d_free, f"k_fix mismatch: {k_fix} vs {nW - d_free}"
            assert np.all(((U1 @ F_sub.T) & 1) == 0), "DUAL BASIS BUG: F_sub does not annihilate U1!"

            fix_forms = []
            for row in F_sub:
                fm = 0
                for k in range(nW):
                    if row[k]:
                        fm ^= W_forms_111[k]
                fix_forms.append(fm)

            print(f"\n    --- d_free={d_free} (k_fix={k_fix}, r1_elim={bkey[0]}) ---", flush=True)
            n_open_tested = 0
            for tr in range(4):
                rb = 0 if tr == 0 else int(rng_f.integers(1, 1 << min(30, k_fix)))
                ex_w = [(fix_forms[j], (rb >> j) & 1) for j in range(k_fix)]
                t_s9 = time.perf_counter()
                sub = s9.run_branch_cascade(
                    lib9, sr["_buf"], sr["_quad_ids"], sr["_cub_ids"], sr["_lin_pivs"],
                    ex_w, tbl, max_xl_rounds=25, verify_subst=False
                )
                dt_s9 = time.perf_counter() - t_s9
                if sub["closed_unsat"]:
                    print(f"      [fiber {tr}] BASELINE s9 CLOSED UNSAT ({dt_s9:.2f}s)", flush=True)
                    continue

                f_act = sorted(i for i in range(111) if i not in sub["_lin_pivs"])
                N_f = len(f_act)
                nq_f = len(sub["_quad_ids"])
                nc_f = len(sub["_cub_ids"])
                print(f"      [fiber {tr}] OPEN BASELINE: N_act={N_f}, q={nq_f}, c={nc_f} ({dt_s9:.2f}s)", flush=True)

                # Limit deep injection to at most 2 open fibers per (eta, d_free) to keep runtime brisk!
                if n_open_tested >= 2:
                    continue
                n_open_tested += 1

                orig_f, basis_f, _, _ = build_affine_tt_basis(o_tt_111, b_tt_111, sub["_lin_pivs"], f_act)

                # (4A) Extract ALL 45 coord + 130 non-coord V_13 degree-4 eqs on shattered fiber!
                rows_f, n4_f, ntot_f = extract_and_audit_deg4_family(
                    orig_f, basis_f, all_subs, lib_d4, tag=f"f{tr}_d{d_free}_ALL175", rng_seed=6100 + em * 100 + d_free * 10 + tr
                )
                _, drops_f45, _ = echelon_and_harvest_deg3_drops(
                    rows_f[:45], n4_f, ntot_f, N_f, f_act, lib_d4, tag=f"f{tr}_COORD45",
                    zt_ctx=(orig_f, basis_f, all_subs[:45])
                )
                _, drops_f175, _ = echelon_and_harvest_deg3_drops(
                    rows_f, n4_f, ntot_f, N_f, f_act, lib_d4, tag=f"f{tr}_ALL175",
                    zt_ctx=(orig_f, basis_f, all_subs)
                )

                # (4B) C_8-Walsh v2=5..10 on shattered fiber (deg<=3 AND deg==4)!
                c8_f_ps, c8_f_d4 = test_c8_walsh_on_subspace(
                    orig_f, basis_f, z_reps, c8_specs, lib_d4, f_act, sub, lib9, tbl,
                    tag=f"f{tr}_d{d_free}", do_deg4_extract=(N_f <= 85), rng_seed=6200 + em * 100 + d_free * 10 + tr
                )

                # Joint deg-4 echelon: V13..16(175) + C_8-Walsh deg4!
                joint_f_drops = []
                if c8_f_d4 is not None and len(c8_f_d4) > 0:
                    j_mat = np.vstack([rows_f, c8_f_d4])
                    _, joint_f_drops, _ = echelon_and_harvest_deg3_drops(
                        j_mat, n4_f, ntot_f, N_f, f_act, lib_d4, tag=f"f{tr}_JOINT_175+C8DEG4"
                    )

                # (4C) Higher-bit check: wt(f|_{V}) mod 32/64/128 on all 45 coord subspaces!
                rng_hb = random.Random(6300 + tr)
                R_hb = 48
                Z_hb = np.zeros((R_hb, N_f), dtype=np.float32)
                for r in range(R_hb):
                    y = rng_hb.getrandbits(N_f)
                    for i in range(N_f):
                        if (y >> i) & 1:
                            Z_hb[r, i] = 1.0
                F_hb = (orig_f[None, :] ^ (np.rint(Z_hb @ basis_f.astype(np.float32)).astype(np.int32) & 1)).astype(np.uint8)
                hb_const_nz = 0
                hb_div16 = 0
                for s_tag, s_dim, _, pts in coord_subs:
                    mod_req = 32 if s_dim == 13 else (64 if s_dim == 14 else 128)
                    wts = F_hb[:, pts].sum(axis=1)
                    rems = wts % mod_req
                    if len(set(int(u) for u in rems)) == 1 and int(rems[0]) != 0:
                        hb_const_nz += 1
                    if np.all((wts & 15) == 0):
                        hb_div16 += 1
                print(f"      [f{tr} Higher-Bit V13..16 mod32/64/128]: const_nonzero={hb_const_nz}/45, 16|wt_all48={hb_div16}/45", flush=True)

                # Combine ALL verified deg<=3 drops (from V13..16 + C8-Walsh + joint) and INJECT into s9 FIRST!
                all_new_ps = list(drops_f175) + [p for _, _, p in c8_f_ps] + list(joint_f_drops)
                if all_new_ps:
                    sub_new, chg = inject_psets_into_s9(sub, all_new_ps, lib9, tbl)
                    print(
                        f"      [f{tr} *** INJECT {len(all_new_ps)} NEW DEG<=3 EQS INTO s9 ***]: "
                        f"changed={chg}, CLOSED_UNSAT={sub_new['closed_unsat']}, "
                        f"N={111-len(sub_new['_lin_pivs'])} (was {N_f}), "
                        f"q={len(sub_new['_quad_ids'])} (was {nq_f}), c={len(sub_new['_cub_ids'])} (was {nc_f})",
                        flush=True,
                    )
                else:
                    print(f"      [f{tr} INJECT]: 0 deg<=3 drops to inject on this open fiber.", flush=True)

                # (4D) Shattered-fiber quadratic geometry (only run block-mod-QF when small enough for exact Python check!)
                if nq_f > 0:
                    qps_f = [s9.row_to_pset(sub["_buf"], qr, tbl) for qr in sub["_quad_ids"]]
                    ana_f = s16.analyze_quad_system(qps_f)
                    Wf_rref = s19.strict_rref_masks(list(ana_f["W_piv"].values()))
                    Wf_pivs = sorted(Wf_rref.keys())
                    Rf_vars = [v for v in f_act if v not in set(Wf_pivs)]
                    print(f"      [f{tr} Quad Geometry]: n_q={nq_f}, dim_W_ess={len(Wf_pivs)}, dim_R_rem={len(Rf_vars)}", flush=True)
                    if 0 < len(Rf_vars) < N_f and 0 < len(Wf_pivs) <= 46 and nq_f <= 40:
                        orig_fs, basis_fs, _, _ = build_sheared_tt_basis(
                            o_tt_111, b_tt_111, sub["_lin_pivs"], Wf_rref, Wf_pivs, {}, [], Rf_vars
                        )
                        rows_fs, _, _ = extract_and_audit_deg4_family(
                            orig_fs, basis_fs, all_subs[:45], lib_d4, tag=f"f{tr}_SH45", rng_seed=6400 + tr
                        )
                        work_qf = (ctypes.c_uint64 * (nq_f * n_cw))()
                        for qi_f, rid in enumerate(sub["_quad_ids"]):
                            ctypes.memmove(ctypes.byref(work_qf, qi_f * n_cw * 8), ctypes.byref(sub["_buf"], rid * n_cw * 8), n_cw * 8)
                        for p in Wf_pivs:
                            rest = Wf_rref[p] ^ (1 << p)
                            if rest:
                                lib_sh.shear_subst_var_batch(
                                    work_qf, nq_f, n_cw, n, tbl["off2"], tbl["off1"], tbl["off0"],
                                    tbl["col2_base"], tbl["col3_base"], tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"],
                                    p, rest & mask64, rest >> 64
                                )
                        wf_idx = {v: i for i, v in enumerate(Wf_pivs)}
                        wf2_col = {}
                        cc = 0
                        for a in range(len(Wf_pivs)):
                            for b in range(a + 1, len(Wf_pivs)):
                                wf2_col[(a, b)] = cc; cc += 1
                        Qf_quad_vecs = []
                        for qi_f in range(nq_f):
                            ps_sh = s9.row_to_pset(work_qf, qi_f, tbl)
                            qv = 0
                            for m in ps_sh:
                                if m.bit_count() == 2:
                                    vs = [b for b in range(n) if (m >> b) & 1]
                                    if vs[0] in wf_idx and vs[1] in wf_idx:
                                        a, b = sorted((wf_idx[vs[0]], wf_idx[vs[1]]))
                                        qv ^= (1 << wf2_col[(a, b)])
                            if qv:
                                Qf_quad_vecs.append(qv)
                        run_mod_Qt_exact_block_test(rows_fs, 45, N_f, len(Wf_pivs), 0, len(Rf_vars), Qf_quad_vecs, lib_d4, tag=f"f{tr}_MOD_QF")

    print(f"\n[STEP 60C {cell_name}] COMPLETED ALL PARTS in {time.perf_counter()-t0:.1f}s!", flush=True)


if __name__ == "__main__":
    main()
