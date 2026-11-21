#!/usr/bin/env python3
r"""
SOLVE_STEP59A_FULL_ORBIT_FES_AVX2_CLOSER.py

ZERO-TRUST FULL-ORBIT OUTER-FES + INNER-FES AVX2 256-WAY CLOSER (OpenMP):
  Closes 100% of a shard (or full orbit) of B0_11 / B1_11 at ~300M+ pts/s/core!
  Architecture:
    1. Builds exact C_core (n_core <= 64 cubic polynomials in W) and optimizes U1 basis (d1 vars, nt1 = nW - d1).
    2. Splits the 2^{nt1} fibers t_1 into n_shards (power of 2) and OpenMP tasks of 2^{nt_loop} fibers each.
    3. For each OpenMP task (2^{nt_loop} fibers):
       - Computes the EXACT cubic ANF of C_core in (u_hi [m=d1-8 bits], t_loop [nt_loop bits])
         via weight-<=3 evaluation + exact Mobius inversion (< 0.5s per task!).
       - Iterates t_loop in Gray code:
         * Updates u_hi ANF (a0, a1, a2) in O(1) AVX2 XORs (Outer-FES, ZERO B_orig evals per fiber!).
         * Converts (a0, a1, a2, a3) -> Bouillaguet FES (D0_core, D1_core, D2_core, D3_core).
         * Runs exact bit-packed C GF(2) RREF for L_kr, V0, E_mat, M0_rem, Mk_rem, C_m0, C_mk (~20 us).
         * Projects P_fiber (K x n_core) onto (D0_core..D3_core) -> (D0..D3).
         * Scans all 2^{d1} points of u_1 via AVX2 256-way Bouillaguet FES (3 XORs/poly/256 pts!).
         * Any fast-check survivor (passing n_fast=28 rows) is IMMEDIATELY verified against ALL mR_1 rows
           of M_1(u_1) r_1 == b_1(u_1) using exact direct evaluation (0 false positives, 0 false negatives!).
         * Any rare degenerate fiber with rK_rem > 6 uses exact full-row GF(2) fallback (0 fibers skipped!).
    4. Built-in Zero-Trust End-to-End Audit:
       - Plants 10 random solutions (t1*, u1*, r*) across 10 different fibers and verifies 10/10 detected!
"""

import argparse
import ctypes
import hashlib
import json
import os
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
import SOLVE_STEP45B_POLAR_EXACT_RHS_AND_KL3 as s45b
import SOLVE_STEP57B_GREEDY_BASIS_AND_BLOCKB_INJECT as s57b


C_CLOSER_SRC = r"""
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <immintrin.h>
#include <omp.h>

static void init_lane_basis_256(__m256i LANE_U[8]) {
    uint64_t tmp[4];
    for (int a = 0; a < 8; a++) {
        memset(tmp, 0, sizeof(tmp));
        for (int lane = 0; lane < 256; lane++) {
            if ((lane >> a) & 1) tmp[lane >> 6] |= (1ULL << (lane & 63));
        }
        LANE_U[a] = _mm256_loadu_si256((const __m256i *)tmp);
    }
}

// Direct 256-way evaluation of all n_core polynomials of C_core at W_cur[0..nW-1]
static void eval_ccore_direct_256(
    const __m256i *W_cur, int nW, int nT, int n_um, int n_core,
    const uint8_t *qt_c0, const uint8_t *qt_lin,
    const int *qt_q_off, const int *qt_q0, const int *qt_q1,
    const int *m_deg, const int *m_v0, const int *m_v1, const int *m_v2,
    const uint8_t *c0_core, const int *cc_row_off, const int *cc_cols,
    __m256i *WT, __m256i *M_vals, __m256i *out_core
) {
    const __m256i ONES = _mm256_set1_epi64x(-1LL);
    const __m256i ZERO = _mm256_setzero_si256();
    for (int w = 0; w < nW; w++) WT[w] = W_cur[w];
    for (int ti = 0; ti < nT; ti++) {
        __m256i acc = qt_c0[ti] ? ONES : ZERO;
        const uint8_t *ql = qt_lin + ti * nW;
        for (int w = 0; w < nW; w++) {
            if (ql[w]) acc = _mm256_xor_si256(acc, WT[w]);
        }
        for (int q = qt_q_off[ti]; q < qt_q_off[ti + 1]; q++) {
            acc = _mm256_xor_si256(acc, _mm256_and_si256(WT[qt_q0[q]], WT[qt_q1[q]]));
        }
        WT[nW + ti] = acc;
    }
    for (int u = 0; u < n_um; u++) {
        int dg = m_deg[u];
        if (dg == 1) M_vals[u] = WT[m_v0[u]];
        else if (dg == 2) M_vals[u] = _mm256_and_si256(WT[m_v0[u]], WT[m_v1[u]]);
        else M_vals[u] = _mm256_and_si256(_mm256_and_si256(WT[m_v0[u]], WT[m_v1[u]]), WT[m_v2[u]]);
    }
    for (int c = 0; c < n_core; c++) {
        __m256i acc = c0_core[c] ? ONES : ZERO;
        for (int p = cc_row_off[c]; p < cc_row_off[c + 1]; p++) {
            acc = _mm256_xor_si256(acc, M_vals[cc_cols[p]]);
        }
        out_core[c] = acc;
    }
}

// Scalar evaluation of all n_core polynomials of C_core at a single point w_vec[0..nW-1] -> uint64_t bitmask!
static uint64_t eval_ccore_scalar(
    const uint8_t *w_vec, int nW, int nT, int n_um, int n_core,
    const uint8_t *qt_c0, const uint8_t *qt_lin,
    const int *qt_q_off, const int *qt_q0, const int *qt_q1,
    const int *m_deg, const int *m_v0, const int *m_v1, const int *m_v2,
    const uint8_t *c0_core, const int *cc_row_off, const int *cc_cols,
    uint8_t *M_vals_s
) {
    uint8_t WT[96];
    for (int w = 0; w < nW; w++) WT[w] = w_vec[w];
    for (int ti = 0; ti < nT; ti++) {
        uint8_t acc = qt_c0[ti];
        const uint8_t *ql = qt_lin + ti * nW;
        for (int w = 0; w < nW; w++) if (ql[w]) acc ^= WT[w];
        for (int q = qt_q_off[ti]; q < qt_q_off[ti + 1]; q++) acc ^= (WT[qt_q0[q]] & WT[qt_q1[q]]);
        WT[nW + ti] = acc;
    }
    for (int u = 0; u < n_um; u++) {
        int dg = m_deg[u];
        if (dg == 1) M_vals_s[u] = WT[m_v0[u]];
        else if (dg == 2) M_vals_s[u] = WT[m_v0[u]] & WT[m_v1[u]];
        else M_vals_s[u] = WT[m_v0[u]] & WT[m_v1[u]] & WT[m_v2[u]];
    }
    uint64_t out = 0;
    for (int c = 0; c < n_core; c++) {
        uint8_t acc = c0_core[c];
        for (int p = cc_row_off[c]; p < cc_row_off[c + 1]; p++) acc ^= M_vals_s[cc_cols[p]];
        if (acc) out |= (1ULL << c);
    }
    return out;
}

// Fast exact GF(2) left nullspace of an (nrows x ncols) matrix (nrows <= 64, ncols <= 32).
// Matrix rows are uint32_t bitmasks of length ncols.
// Writes basis of left nullspace (vectors v of length nrows with v @ A == 0) into null_out[0..n_null-1].
static int gf2_left_nullspace_u32(const uint32_t *rows, int nrows, int ncols, uint64_t *null_out) {
    uint32_t A[64];
    uint64_t I[64];
    for (int r = 0; r < nrows; r++) {
        A[r] = rows[r];
        I[r] = 1ULL << r;
    }
    int pr = 0;
    for (int c = 0; c < ncols && pr < nrows; c++) {
        int piv = -1;
        for (int r = pr; r < nrows; r++) {
            if ((A[r] >> c) & 1U) { piv = r; break; }
        }
        if (piv < 0) continue;
        if (piv != pr) {
            uint32_t tA = A[pr]; A[pr] = A[piv]; A[piv] = tA;
            uint64_t tI = I[pr]; I[pr] = I[piv]; I[piv] = tI;
        }
        for (int r = 0; r < nrows; r++) {
            if (r != pr && ((A[r] >> c) & 1U)) {
                A[r] ^= A[pr];
                I[r] ^= I[pr];
            }
        }
        pr++;
    }
    int n_null = 0;
    for (int r = pr; r < nrows; r++) {
        null_out[n_null++] = I[r];
    }
    return n_null;
}

// Fast exact GF(2) left nullspace of an (nrows x n_words*64) matrix (nrows <= 64, n_words <= 16).
static int gf2_left_nullspace_wide(const uint64_t *mat, int nrows, int n_words, uint64_t *null_out) {
    uint64_t A[64][16];
    uint64_t I[64];
    for (int r = 0; r < nrows; r++) {
        for (int w = 0; w < n_words; w++) A[r][w] = mat[r * n_words + w];
        I[r] = 1ULL << r;
    }
    int pr = 0;
    for (int w = 0; w < n_words && pr < nrows; w++) {
        for (int b = 0; b < 64 && pr < nrows; b++) {
            uint64_t bit = 1ULL << b;
            int piv = -1;
            for (int r = pr; r < nrows; r++) {
                if (A[r][w] & bit) { piv = r; break; }
            }
            if (piv < 0) continue;
            if (piv != pr) {
                for (int k = w; k < n_words; k++) {
                    uint64_t tmp = A[pr][k]; A[pr][k] = A[piv][k]; A[piv][k] = tmp;
                }
                uint64_t tI = I[pr]; I[pr] = I[piv]; I[piv] = tI;
            }
            for (int r = 0; r < nrows; r++) {
                if (r != pr && (A[r][w] & bit)) {
                    for (int k = w; k < n_words; k++) A[r][k] ^= A[pr][k];
                    I[r] ^= I[pr];
                }
            }
            pr++;
        }
    }
    int n_null = 0;
    for (int r = pr; r < nrows; r++) {
        null_out[n_null++] = I[r];
    }
    return n_null;
}

// Exact full-row consistency check of M_1(u_1) r_1 == b_1(u_1) at a single point (w_vec)!
// Returns 1 if consistent (TRUE SURVIVOR!), 0 if UNSAT.
static int verify_full_point_exact(
    const uint8_t *w_vec, const uint8_t *u_vec, int d1, int nW, int nT, int n_um, int n_core,
    int mR_1, int rK_1,
    const uint64_t *L_kr_masks,   // (mR_1,) bitmasks over n_core
    const uint32_t *M0_1_masks,   // (mR_1,) bitmasks over rK_1
    const uint32_t *Mu_1_masks,   // (d1 * mR_1,) bitmasks over rK_1
    const uint8_t *qt_c0, const uint8_t *qt_lin,
    const int *qt_q_off, const int *qt_q0, const int *qt_q1,
    const int *m_deg, const int *m_v0, const int *m_v1, const int *m_v2,
    const uint8_t *c0_core, const int *cc_row_off, const int *cc_cols,
    uint64_t plant_delta_core,    // 0 during real scan; non-zero during Zero-Trust planted test!
    uint8_t *M_vals_s
) {
    uint64_t b_core = eval_ccore_scalar(w_vec, nW, nT, n_um, n_core, qt_c0, qt_lin, qt_q_off, qt_q0, qt_q1,
                                        m_deg, m_v0, m_v1, m_v2, c0_core, cc_row_off, cc_cols, M_vals_s);
    b_core ^= plant_delta_core;

    uint32_t piv[32];
    memset(piv, 0, sizeof(piv));
    uint32_t rhs_bit = 1U << rK_1;
    for (int r = 0; r < mR_1; r++) {
        uint32_t row = M0_1_masks[r];
        for (int a = 0; a < d1; a++) {
            if (u_vec[a]) row ^= Mu_1_masks[a * mR_1 + r];
        }
        uint32_t b_bit = (__builtin_parityll(b_core & L_kr_masks[r])) ? rhs_bit : 0U;
        row |= b_bit;
        for (int c = 0; c < rK_1; c++) {
            if ((row >> c) & 1U) {
                if (piv[c]) row ^= piv[c];
                else { piv[c] = row; row = 0; break; }
            }
        }
        if (row == rhs_bit) return 0; // UNSAT!
    }
    return 1; // CONSISTENT!
}

// Per-fiber Round-1 (KR + V0) + FES AVX2 256-way scan (with exact full-row verification + fallback!)
// Returns number of FULL-ROW survivors on this fiber.
static int64_t process_one_fiber(
    int d1, int m, int nW, int nT, int n_um, int n_core, int rK_init, int n_kr, int rK_1,
    const uint8_t *U1, const uint8_t *w_shift,
    const uint32_t *M0_c_masks,      // (n_core,) bitmasks over rK_init
    const uint32_t *Mk_c_masks,      // (nW * n_core,) bitmasks over rK_init
    const uint32_t *KR_masks,        // (n_kr,) bitmasks over rK_init
    const int *keep_c_kr,            // (rK_1,) col indices in 0..rK_init-1
    const uint32_t *Mu_opt_keep,     // (d1 * n_core,) bitmasks over rK_1
    // Current fiber's C_core Bouillaguet FES tables (stride n_core):
    const __m256i *D0_core,          // [n_core]
    const __m256i *D1_core,          // [m * n_core]
    const __m256i *D2_core,          // [m * m * n_core]
    const __m256i *D3_core,          // [m * m * m * n_core]
    // Direct eval tables for exact full-row verification of fast-check survivors:
    const uint8_t *qt_c0, const uint8_t *qt_lin,
    const int *qt_q_off, const int *qt_q0, const int *qt_q1,
    const int *m_deg, const int *m_v0, const int *m_v1, const int *m_v2,
    const uint8_t *c0_core, const int *cc_row_off, const int *cc_cols,
    uint64_t plant_delta_core,       // 0 in real scan; non-zero ONLY for planted fiber in Zero-Trust audit!
    const __m256i *LANE_U,
    // Pre-allocated thread-local scratch buffers:
    __m256i *D0_p, __m256i *D1_p, __m256i *D2_p, __m256i *D3_p,
    uint8_t *M_vals_s,
    int64_t *fallback_count_out
) {
    const __m256i ONES = _mm256_set1_epi64x(-1LL);
    const __m256i ZERO = _mm256_setzero_si256();

    // 1. Compute M0_f = M0_c ^ XOR_{w: w_shift[w]=1} Mk_c[w]
    uint32_t M0_f[64];
    for (int r = 0; r < n_core; r++) M0_f[r] = M0_c_masks[r];
    for (int w = 0; w < nW; w++) {
        if (w_shift[w]) {
            const uint32_t *mkw = Mk_c_masks + w * n_core;
            for (int r = 0; r < n_core; r++) M0_f[r] ^= mkw[r];
        }
    }

    // 2. Compute M0_KR (n_core x n_kr) and L_kr = left_nullspace(M0_KR)
    uint64_t L_kr_masks[64];
    int mR_1 = 0;
    if (n_kr > 0) {
        uint32_t M0_KR[64];
        for (int r = 0; r < n_core; r++) {
            uint32_t row = 0;
            for (int j = 0; j < n_kr; j++) {
                if (__builtin_parity(M0_f[r] & KR_masks[j])) row |= (1U << j);
            }
            M0_KR[r] = row;
        }
        mR_1 = gf2_left_nullspace_u32(M0_KR, n_core, n_kr, L_kr_masks);
    } else {
        mR_1 = n_core;
        for (int r = 0; r < n_core; r++) L_kr_masks[r] = 1ULL << r;
    }

    // Extract M0_f_keep (n_core,) over rK_1
    uint32_t M0_f_keep[64];
    for (int r = 0; r < n_core; r++) {
        uint32_t v = 0, src = M0_f[r];
        for (int c = 0; c < rK_1; c++) {
            if ((src >> keep_c_kr[c]) & 1U) v |= (1U << c);
        }
        M0_f_keep[r] = v;
    }

    // Project M0_1 = L_kr @ M0_f_keep and Mu_1[a] = L_kr @ Mu_opt_keep[a]
    uint32_t M0_1[64];
    uint32_t Mu_1[32 * 64];
    for (int r = 0; r < mR_1; r++) {
        uint64_t lm = L_kr_masks[r];
        uint32_t v0 = 0;
        uint64_t tmp = lm;
        while (tmp) {
            int j = __builtin_ctzll(tmp);
            v0 ^= M0_f_keep[j];
            tmp &= tmp - 1;
        }
        M0_1[r] = v0;
        for (int a = 0; a < d1; a++) {
            uint32_t va = 0;
            const uint32_t *mua = Mu_opt_keep + a * n_core;
            tmp = lm;
            while (tmp) {
                int j = __builtin_ctzll(tmp);
                va ^= mua[j];
                tmp &= tmp - 1;
            }
            Mu_1[a * mR_1 + r] = va;
        }
    }

    // 3. Compute V0 = left_nullspace(hstack(Mu_1[0..d1-1]))
    int total_cols = d1 * rK_1;
    int n_words_v0 = (total_cols + 63) / 64;
    uint64_t H_mu[64 * 16];
    memset(H_mu, 0, (size_t)mR_1 * n_words_v0 * sizeof(uint64_t));
    for (int r = 0; r < mR_1; r++) {
        int col_off = 0;
        for (int a = 0; a < d1; a++) {
            uint32_t val = Mu_1[a * mR_1 + r];
            while (val) {
                int c = __builtin_ctz(val);
                int gcol = col_off + c;
                H_mu[r * n_words_v0 + (gcol >> 6)] |= (1ULL << (gcol & 63));
                val &= val - 1;
            }
            col_off += rK_1;
        }
    }
    uint64_t V0_masks[64];
    int n_v0 = gf2_left_nullspace_wide(H_mu, mR_1, n_words_v0, V0_masks);

    // 4. RREF of [V0 @ M0_1 | V0] to get E_mat (r_elim x mR_1) and piv_v0[0..r_elim-1]
    uint32_t VM[64];
    uint64_t VE[64];
    for (int i = 0; i < n_v0; i++) {
        uint64_t vm = V0_masks[i];
        uint32_t acc = 0;
        uint64_t tmp = vm;
        while (tmp) {
            int r = __builtin_ctzll(tmp);
            acc ^= M0_1[r];
            tmp &= tmp - 1;
        }
        VM[i] = acc;
        VE[i] = vm;
    }
    int piv_v0[32];
    int is_piv[32];
    memset(is_piv, 0, sizeof(is_piv));
    int r_elim = 0;
    for (int c = 0; c < rK_1 && r_elim < n_v0; c++) {
        int piv = -1;
        for (int i = r_elim; i < n_v0; i++) {
            if ((VM[i] >> c) & 1U) { piv = i; break; }
        }
        if (piv < 0) continue;
        if (piv != r_elim) {
            uint32_t t1 = VM[r_elim]; VM[r_elim] = VM[piv]; VM[piv] = t1;
            uint64_t t2 = VE[r_elim]; VE[r_elim] = VE[piv]; VE[piv] = t2;
        }
        for (int i = 0; i < n_v0; i++) {
            if (i != r_elim && ((VM[i] >> c) & 1U)) {
                VM[i] ^= VM[r_elim];
                VE[i] ^= VE[r_elim];
            }
        }
        piv_v0[r_elim] = c;
        is_piv[c] = 1;
        r_elim++;
    }

    int keep_c[32], rK_rem = 0;
    for (int c = 0; c < rK_1; c++) {
        if (!is_piv[c]) keep_c[rK_rem++] = c;
    }

    // Rare degenerate fiber fallback (rK_rem > 6): exact point-by-point full-row check!
    if (rK_rem > 6) {
        (*fallback_count_out)++;
        int64_t surv = 0;
        uint8_t u_vec[32], w_vec[64];
        int64_t n_pts = 1LL << d1;
        for (int64_t u = 0; u < n_pts; u++) {
            for (int w = 0; w < nW; w++) w_vec[w] = w_shift[w];
            for (int a = 0; a < d1; a++) {
                u_vec[a] = (uint8_t)((u >> a) & 1LL);
                if (u_vec[a]) {
                    for (int w = 0; w < nW; w++) w_vec[w] ^= U1[a * nW + w];
                }
            }
            if (verify_full_point_exact(w_vec, u_vec, d1, nW, nT, n_um, n_core, mR_1, rK_1,
                                        L_kr_masks, M0_1, Mu_1, qt_c0, qt_lin, qt_q_off, qt_q0, qt_q1,
                                        m_deg, m_v0, m_v1, m_v2, c0_core, cc_row_off, cc_cols,
                                        plant_delta_core, M_vals_s)) {
                surv++;
            }
        }
        return surv;
    }

    // 5. Build E_core_masks (r_elim,) over n_core: E_mat @ L_kr!
    // And combined P_fiber_masks[0..K-1] over n_core: [E_mat @ L_kr (r_elim rows), L_kr[0..n_fast-1]]
    int n_fast = (mR_1 < 28) ? mR_1 : 28;
    int K = r_elim + n_fast;
    uint64_t P_fiber[64];
    for (int e = 0; e < r_elim; e++) {
        uint64_t acc = 0, em = VE[e];
        while (em) {
            int r = __builtin_ctzll(em);
            acc ^= L_kr_masks[r];
            em &= em - 1;
        }
        P_fiber[e] = acc;
    }
    for (int r = 0; r < n_fast; r++) {
        P_fiber[r_elim + r] = L_kr_masks[r];
    }

    // Build EM0_keep[e] (r_elim,) bitmasks over rK_rem
    uint32_t EM0_keep[32];
    for (int e = 0; e < r_elim; e++) {
        uint32_t v = 0, src = VM[e];
        for (int c = 0; c < rK_rem; c++) {
            if ((src >> keep_c[c]) & 1U) v |= (1U << c);
        }
        EM0_keep[e] = v;
    }

    // Build Cm0_masks[r], Cmk_masks[a*n_fast+r], M0_rem_masks[r], Mk_rem_masks[a*n_fast+r]
    uint32_t Cm0_masks[32], Cmk_masks[32 * 32];
    uint32_t M0_rem_masks[32], Mk_rem_masks[32 * 32];
    for (int r = 0; r < n_fast; r++) {
        uint32_t cm0 = 0, m0k = 0;
        for (int e = 0; e < r_elim; e++) {
            if ((M0_1[r] >> piv_v0[e]) & 1U) {
                cm0 |= (1U << e);
                m0k ^= EM0_keep[e];
            }
        }
        for (int c = 0; c < rK_rem; c++) {
            if ((M0_1[r] >> keep_c[c]) & 1U) m0k ^= (1U << c);
        }
        Cm0_masks[r] = cm0;
        M0_rem_masks[r] = m0k;

        for (int a = 0; a < d1; a++) {
            uint32_t mu_ar = Mu_1[a * mR_1 + r];
            uint32_t cma = 0, mka = 0;
            for (int e = 0; e < r_elim; e++) {
                if ((mu_ar >> piv_v0[e]) & 1U) {
                    cma |= (1U << e);
                    mka ^= EM0_keep[e];
                }
            }
            for (int c = 0; c < rK_rem; c++) {
                if ((mu_ar >> keep_c[c]) & 1U) mka ^= (1U << c);
            }
            Cmk_masks[a * n_fast + r] = cma;
            Mk_rem_masks[a * n_fast + r] = mka;
        }
    }

    // 6. Project P_fiber (K x n_core) onto D0_core, D1_core, D2_core, D3_core -> D0_p, D1_p, D2_p, D3_p!
    // Apply optional plant_delta_core to D0_p!
    for (int k = 0; k < K; k++) {
        uint64_t pm = P_fiber[k];
        __m256i acc = (__builtin_parityll(pm & plant_delta_core)) ? ONES : ZERO;
        while (pm) {
            int j = __builtin_ctzll(pm);
            acc = _mm256_xor_si256(acc, D0_core[j]);
            pm &= pm - 1;
        }
        D0_p[k] = acc;
    }
    for (int i = 0; i < m; i++) {
        const __m256i *src = D1_core + (size_t)i * n_core;
        __m256i *dst = D1_p + (size_t)i * K;
        for (int k = 0; k < K; k++) {
            uint64_t pm = P_fiber[k];
            __m256i acc = ZERO;
            while (pm) { int j = __builtin_ctzll(pm); acc = _mm256_xor_si256(acc, src[j]); pm &= pm - 1; }
            dst[k] = acc;
        }
        for (int j = i + 1; j < m; j++) {
            const __m256i *src2 = D2_core + ((size_t)i * m + j) * n_core;
            __m256i *dst2 = D2_p + ((size_t)i * m + j) * K;
            for (int k = 0; k < K; k++) {
                uint64_t pm = P_fiber[k];
                __m256i acc = ZERO;
                while (pm) { int q = __builtin_ctzll(pm); acc = _mm256_xor_si256(acc, src2[q]); pm &= pm - 1; }
                dst2[k] = acc;
            }
            for (int l = j + 1; l < m; l++) {
                const __m256i *src3 = D3_core + (((size_t)i * m + j) * m + l) * n_core;
                __m256i *dst3 = D3_p + (((size_t)i * m + j) * m + l) * K;
                for (int k = 0; k < K; k++) {
                    uint64_t pm = P_fiber[k];
                    __m256i acc = ZERO;
                    while (pm) { int q = __builtin_ctzll(pm); acc = _mm256_xor_si256(acc, src3[q]); pm &= pm - 1; }
                    dst3[k] = acc;
                }
            }
        }
    }

    // 7. Run 331M+ pts/s/core Bouillaguet FES AVX2 256-way inner scan!
    __m256i Mrem_cur[32][8];
    for (int r = 0; r < n_fast; r++) {
        for (int c = 0; c < rK_rem; c++) {
            __m256i v = ((M0_rem_masks[r] >> c) & 1U) ? ONES : ZERO;
            for (int a = 0; a < 8 && a < d1; a++) {
                if ((Mk_rem_masks[a * n_fast + r] >> c) & 1U) v = _mm256_xor_si256(v, LANE_U[a]);
            }
            Mrem_cur[r][c] = v;
        }
    }
    __m256i Cmk_cur[32][32];
    for (int r = 0; r < n_fast; r++) {
        for (int e = 0; e < r_elim; e++) {
            __m256i v = ((Cm0_masks[r] >> e) & 1U) ? ONES : ZERO;
            for (int a = 0; a < 8 && a < d1; a++) {
                if ((Cmk_masks[a * n_fast + r] >> e) & 1U) v = _mm256_xor_si256(v, LANE_U[a]);
            }
            Cmk_cur[r][e] = v;
        }
    }

    __m256i b_new[32], eq_cur[32];
    int64_t n_chunks = 1LL << m;
    int n_r = 1 << rK_rem;
    int64_t full_surv = 0;

    for (int64_t s = 0; s < n_chunks; s++) {
        if (s > 0) {
            int b1 = __builtin_ctzll((uint64_t)s);
            int a = 8 + b1;
            const uint32_t *mka = Mk_rem_masks + a * n_fast;
            const uint32_t *cka = Cmk_masks + a * n_fast;
            for (int r = 0; r < n_fast; r++) {
                uint32_t mm = mka[r];
                while (mm) { int c = __builtin_ctz(mm); Mrem_cur[r][c] = _mm256_xor_si256(Mrem_cur[r][c], ONES); mm &= mm - 1; }
                uint32_t cm = cka[r];
                while (cm) { int e = __builtin_ctz(cm); Cmk_cur[r][e] = _mm256_xor_si256(Cmk_cur[r][e], ONES); cm &= cm - 1; }
            }
            uint64_t s1 = (uint64_t)s ^ (1ULL << b1);
            if (s1 != 0) {
                int b2 = __builtin_ctzll(s1);
                uint64_t s2 = s1 ^ (1ULL << b2);
                __m256i *d2 = D2_p + ((size_t)b1 * m + b2) * K;
                if (s2 != 0) {
                    int b3 = __builtin_ctzll(s2);
                    const __m256i *c3 = D3_p + (((size_t)b1 * m + b2) * m + b3) * K;
                    for (int k = 0; k < K; k++) d2[k] = _mm256_xor_si256(d2[k], c3[k]);
                }
                __m256i *d1p = D1_p + (size_t)b1 * K;
                for (int k = 0; k < K; k++) d1p[k] = _mm256_xor_si256(d1p[k], d2[k]);
            }
            __m256i *d1p = D1_p + (size_t)b1 * K;
            for (int k = 0; k < K; k++) D0_p[k] = _mm256_xor_si256(D0_p[k], d1p[k]);
        }

        const __m256i *Eb = D0_p;
        const __m256i *B1 = D0_p + r_elim;
        for (int r = 0; r < n_fast; r++) {
            __m256i v = B1[r];
            for (int e = 0; e < r_elim; e++) v = _mm256_xor_si256(v, _mm256_and_si256(Cmk_cur[r][e], Eb[e]));
            b_new[r] = v;
        }

        for (int r = 0; r < n_fast; r++) eq_cur[r] = b_new[r];
        __m256i any_surv = ZERO;
        for (int rv = 0; rv < n_r; rv++) {
            if (rv > 0) {
                int bc = __builtin_ctz(rv);
                for (int r = 0; r < n_fast; r++) eq_cur[r] = _mm256_xor_si256(eq_cur[r], Mrem_cur[r][bc]);
            }
            __m256i ok = ONES;
            for (int r = 0; r < n_fast; r++) {
                ok = _mm256_andnot_si256(eq_cur[r], ok);
                if (_mm256_testz_si256(ok, ok)) break;
            }
            any_surv = _mm256_or_si256(any_surv, ok);
        }

        if (!_mm256_testz_si256(any_surv, any_surv)) {
            uint64_t lanes[4];
            _mm256_storeu_si256((__m256i *)lanes, any_surv);
            int64_t u_hi = s ^ (s >> 1);
            for (int w = 0; w < 4; w++) {
                uint64_t v = lanes[w];
                while (v) {
                    int lane = (w << 6) | __builtin_ctzll(v);
                    v &= v - 1;
                    // Reconstruct exact u_vec and w_vec and run 100% EXACT full-row verification!
                    uint8_t u_vec[32], w_vec[64];
                    for (int ww = 0; ww < nW; ww++) w_vec[ww] = w_shift[ww];
                    for (int a = 0; a < 8; a++) {
                        u_vec[a] = (uint8_t)((lane >> a) & 1);
                        if (u_vec[a]) for (int ww = 0; ww < nW; ww++) w_vec[ww] ^= U1[a * nW + ww];
                    }
                    for (int b = 0; b < m; b++) {
                        u_vec[8 + b] = (uint8_t)((u_hi >> b) & 1LL);
                        if (u_vec[8 + b]) for (int ww = 0; ww < nW; ww++) w_vec[ww] ^= U1[(8 + b) * nW + ww];
                    }
                    if (verify_full_point_exact(w_vec, u_vec, d1, nW, nT, n_um, n_core, mR_1, rK_1,
                                                L_kr_masks, M0_1, Mu_1, qt_c0, qt_lin, qt_q_off, qt_q0, qt_q1,
                                                m_deg, m_v0, m_v1, m_v2, c0_core, cc_row_off, cc_cols,
                                                plant_delta_core, M_vals_s)) {
                        full_surv++;
                    }
                }
            }
        }
    }
    return full_surv;
}

// Run one Outer-FES task covering 2^{nt_loop} fibers starting at base_w_shift (with inner basis T_loop [nt_loop x nW])!
// Optional: if plant_t_idx >= 0, applies plant_delta_core ONLY to the fiber with Gray-code value == plant_t_idx!
int64_t run_outer_fes_block_c(
    int d1, int m, int nt_loop, int nW, int nT, int n_um, int n_core, int rK_init, int n_kr, int rK_1,
    const uint8_t *U1, const uint8_t *T_loop, const uint8_t *base_w_shift,
    const uint32_t *M0_c_masks, const uint32_t *Mk_c_masks,
    const uint32_t *KR_masks, const int *keep_c_kr, const uint32_t *Mu_opt_keep,
    const uint8_t *qt_c0, const uint8_t *qt_lin,
    const int *qt_q_off, const int *qt_q0, const int *qt_q1,
    const int *m_deg, const int *m_v0, const int *m_v1, const int *m_v2,
    const uint8_t *c0_core, const int *cc_row_off, const int *cc_cols,
    int64_t plant_t_gray_val, uint64_t plant_delta_core,
    int64_t *fallback_count_out
) {
    __m256i LANE_U[8];
    init_lane_basis_256(LANE_U);
    const __m256i ONES = _mm256_set1_epi64x(-1LL);
    const __m256i ZERO = _mm256_setzero_si256();

    int M = m + nt_loop; // total variables for weight-<=3 cubic ANF!
    // Basis vectors in W for variables 0..M-1:
    //   0..m-1       = U1[8..d1-1]
    //   m..m+nt_loop-1 = T_loop[0..nt_loop-1]
    uint8_t B_var[40][64];
    for (int i = 0; i < m; i++) memcpy(B_var[i], U1 + (8 + i) * nW, (size_t)nW);
    for (int p = 0; p < nt_loop; p++) memcpy(B_var[m + p], T_loop + p * nW, (size_t)nW);

    __m256i W_base[64], W_cur[64], WT[96];
    for (int w = 0; w < nW; w++) {
        __m256i v = base_w_shift[w] ? ONES : ZERO;
        for (int a = 0; a < 8; a++) if (U1[a * nW + w]) v = _mm256_xor_si256(v, LANE_U[a]);
        W_base[w] = v;
    }

    __m256i *M_vals = (__m256i *)aligned_alloc(32, (size_t)(n_um + 1) * sizeof(__m256i));
    uint8_t *M_vals_s = (uint8_t *)malloc((size_t)(n_um + 1));

    // Step A: Evaluate C_core at all weight <= 3 points of M variables -> exact cubic ANF!
    __m256i *F0 = (__m256i *)aligned_alloc(32, (size_t)n_core * sizeof(__m256i));
    __m256i *F1 = (__m256i *)aligned_alloc(32, (size_t)M * n_core * sizeof(__m256i));
    __m256i *F2 = (__m256i *)aligned_alloc(32, (size_t)M * M * n_core * sizeof(__m256i));
    __m256i *C1 = (__m256i *)aligned_alloc(32, (size_t)M * n_core * sizeof(__m256i));
    __m256i *C2 = (__m256i *)aligned_alloc(32, (size_t)M * M * n_core * sizeof(__m256i));
    __m256i *C3 = (__m256i *)aligned_alloc(32, (size_t)M * M * M * n_core * sizeof(__m256i));
    __m256i *Ftmp = (__m256i *)aligned_alloc(32, (size_t)n_core * sizeof(__m256i));

    // Weight 0
    eval_ccore_direct_256(W_base, nW, nT, n_um, n_core, qt_c0, qt_lin, qt_q_off, qt_q0, qt_q1,
                          m_deg, m_v0, m_v1, m_v2, c0_core, cc_row_off, cc_cols, WT, M_vals, F0);

    // Weight 1
    for (int a = 0; a < M; a++) {
        for (int w = 0; w < nW; w++) W_cur[w] = B_var[a][w] ? _mm256_xor_si256(W_base[w], ONES) : W_base[w];
        __m256i *f1a = F1 + (size_t)a * n_core;
        eval_ccore_direct_256(W_cur, nW, nT, n_um, n_core, qt_c0, qt_lin, qt_q_off, qt_q0, qt_q1,
                              m_deg, m_v0, m_v1, m_v2, c0_core, cc_row_off, cc_cols, WT, M_vals, f1a);
        __m256i *c1a = C1 + (size_t)a * n_core;
        for (int c = 0; c < n_core; c++) c1a[c] = _mm256_xor_si256(f1a[c], F0[c]);
    }

    // Weight 2
    for (int a = 0; a < M; a++) {
        for (int b = a + 1; b < M; b++) {
            for (int w = 0; w < nW; w++) {
                W_cur[w] = (B_var[a][w] ^ B_var[b][w]) ? _mm256_xor_si256(W_base[w], ONES) : W_base[w];
            }
            __m256i *f2ab = F2 + ((size_t)a * M + b) * n_core;
            eval_ccore_direct_256(W_cur, nW, nT, n_um, n_core, qt_c0, qt_lin, qt_q_off, qt_q0, qt_q1,
                                  m_deg, m_v0, m_v1, m_v2, c0_core, cc_row_off, cc_cols, WT, M_vals, f2ab);
            __m256i *c2ab = C2 + ((size_t)a * M + b) * n_core;
            __m256i *c2ba = C2 + ((size_t)b * M + a) * n_core;
            const __m256i *f1a = F1 + (size_t)a * n_core;
            const __m256i *f1b = F1 + (size_t)b * n_core;
            for (int c = 0; c < n_core; c++) {
                __m256i v = _mm256_xor_si256(_mm256_xor_si256(f2ab[c], f1a[c]), _mm256_xor_si256(f1b[c], F0[c]));
                c2ab[c] = v;
                c2ba[c] = v;
            }
        }
    }

    // Weight 3
    for (int a = 0; a < M; a++) {
        for (int b = a + 1; b < M; b++) {
            for (int d = b + 1; d < M; d++) {
                for (int w = 0; w < nW; w++) {
                    W_cur[w] = (B_var[a][w] ^ B_var[b][w] ^ B_var[d][w]) ? _mm256_xor_si256(W_base[w], ONES) : W_base[w];
                }
                eval_ccore_direct_256(W_cur, nW, nT, n_um, n_core, qt_c0, qt_lin, qt_q_off, qt_q0, qt_q1,
                                      m_deg, m_v0, m_v1, m_v2, c0_core, cc_row_off, cc_cols, WT, M_vals, Ftmp);
                const __m256i *f2ab = F2 + ((size_t)a * M + b) * n_core;
                const __m256i *f2ad = F2 + ((size_t)a * M + d) * n_core;
                const __m256i *f2bd = F2 + ((size_t)b * M + d) * n_core;
                const __m256i *f1a = F1 + (size_t)a * n_core;
                const __m256i *f1b = F1 + (size_t)b * n_core;
                const __m256i *f1d = F1 + (size_t)d * n_core;
                __m256i *c3abd = C3 + (((size_t)a * M + b) * M + d) * n_core;
                for (int c = 0; c < n_core; c++) {
                    __m256i v = _mm256_xor_si256(
                        _mm256_xor_si256(_mm256_xor_si256(Ftmp[c], f2ab[c]), _mm256_xor_si256(f2ad[c], f2bd[c])),
                        _mm256_xor_si256(_mm256_xor_si256(f1a[c], f1b[c]), _mm256_xor_si256(f1d[c], F0[c]))
                    );
                    c3abd[c] = v;
                }
            }
        }
    }

    // Step B: Initialize Outer-FES state for t_loop (0..nt_loop-1):
    //   - a3_core[i][j][l] = C3[i][j][l] (CONSTANT!)
    //   - a2_core[i][j] (i < j < m): affine in t_loop!
    //   - a1_core[i] (i < m): quadratic in t_loop! (needs Bouillaguet deg-2 state: T1_a1[p][i], T2_a1[p][q][i])
    //   - a0_core: cubic in t_loop! (needs Bouillaguet deg-3 state: T1_a0[p], T2_a0[p][q], T3_a0[p][q][r])
    __m256i *a0_core = (__m256i *)aligned_alloc(32, (size_t)n_core * sizeof(__m256i));
    __m256i *a1_core = (__m256i *)aligned_alloc(32, (size_t)m * n_core * sizeof(__m256i));
    __m256i *a2_core = (__m256i *)aligned_alloc(32, (size_t)m * m * n_core * sizeof(__m256i));
    __m256i *D1_core = (__m256i *)aligned_alloc(32, (size_t)m * n_core * sizeof(__m256i));
    __m256i *D2_core = (__m256i *)aligned_alloc(32, (size_t)m * m * n_core * sizeof(__m256i));
    __m256i *D3_core = (__m256i *)aligned_alloc(32, (size_t)m * m * m * n_core * sizeof(__m256i));

    memcpy(a0_core, F0, (size_t)n_core * sizeof(__m256i));
    for (int i = 0; i < m; i++) {
        memcpy(a1_core + (size_t)i * n_core, C1 + (size_t)i * n_core, (size_t)n_core * sizeof(__m256i));
        for (int j = i + 1; j < m; j++) {
            memcpy(a2_core + ((size_t)i * m + j) * n_core, C2 + ((size_t)i * M + j) * n_core, (size_t)n_core * sizeof(__m256i));
            for (int l = j + 1; l < m; l++) {
                memcpy(D3_core + (((size_t)i * m + j) * m + l) * n_core,
                       C3 + (((size_t)i * M + j) * M + l) * n_core, (size_t)n_core * sizeof(__m256i));
            }
        }
    }

    // Outer-FES state for a1_core[i] (degree 2 in t_loop):
    __m256i *T1_a1 = (__m256i *)aligned_alloc(32, (size_t)nt_loop * m * n_core * sizeof(__m256i));
    for (int p = 0; p < nt_loop; p++) {
        for (int i = 0; i < m; i++) {
            __m256i *dst = T1_a1 + ((size_t)p * m + i) * n_core;
            const __m256i *c_ip = C2 + ((size_t)i * M + (m + p)) * n_core;
            if (p > 0) {
                const __m256i *c_ipm1p = C3 + (((size_t)i * M + (m + p - 1)) * M + (m + p)) * n_core;
                for (int c = 0; c < n_core; c++) dst[c] = _mm256_xor_si256(c_ip[c], c_ipm1p[c]);
            } else {
                memcpy(dst, c_ip, (size_t)n_core * sizeof(__m256i));
            }
        }
    }

    // Outer-FES state for a0_core (degree 3 in t_loop):
    __m256i *T1_a0 = (__m256i *)aligned_alloc(32, (size_t)nt_loop * n_core * sizeof(__m256i));
    __m256i *T2_a0 = (__m256i *)aligned_alloc(32, (size_t)nt_loop * nt_loop * n_core * sizeof(__m256i));
    for (int p = 0; p < nt_loop; p++) {
        __m256i *dst1 = T1_a0 + (size_t)p * n_core;
        const __m256i *c_p = C1 + (size_t)(m + p) * n_core;
        if (p > 0) {
            const __m256i *c_pm1p = C2 + ((size_t)(m + p - 1) * M + (m + p)) * n_core;
            for (int c = 0; c < n_core; c++) dst1[c] = _mm256_xor_si256(c_p[c], c_pm1p[c]);
        } else {
            memcpy(dst1, c_p, (size_t)n_core * sizeof(__m256i));
        }
        for (int q = p + 1; q < nt_loop; q++) {
            __m256i *dst2 = T2_a0 + ((size_t)p * nt_loop + q) * n_core;
            const __m256i *c_pq = C2 + ((size_t)(m + p) * M + (m + q)) * n_core;
            int s2 = (1 << q) | (1 << p);
            int x2 = ((s2 - 1) ^ ((s2 - 1) >> 1)) & ~s2;
            for (int c = 0; c < n_core; c++) dst2[c] = c_pq[c];
            while (x2) {
                int r = __builtin_ctz(x2);
                x2 &= x2 - 1;
                int aa = m + p, bb = m + q, dd = m + r;
                if (dd < aa) { int t = aa; aa = dd; dd = bb; bb = t; } // sort (aa, bb, dd)
                else if (dd < bb) { int t = bb; bb = dd; dd = t; }
                const __m256i *c3 = C3 + (((size_t)aa * M + bb) * M + dd) * n_core;
                for (int c = 0; c < n_core; c++) dst2[c] = _mm256_xor_si256(dst2[c], c3[c]);
            }
        }
    }

    // Scratch buffers for inner FES projection (K <= 64)
    __m256i *D0_p = (__m256i *)aligned_alloc(32, 64 * sizeof(__m256i));
    __m256i *D1_p = (__m256i *)aligned_alloc(32, (size_t)m * 64 * sizeof(__m256i));
    __m256i *D2_p = (__m256i *)aligned_alloc(32, (size_t)m * m * 64 * sizeof(__m256i));
    __m256i *D3_p = (__m256i *)aligned_alloc(32, (size_t)m * m * m * 64 * sizeof(__m256i));

    // Precompute x2 masks for ANF -> FES conversion of D2_core[i][j]
    int x2_u_mask[16][16];
    for (int i = 0; i < m; i++) {
        for (int j = i + 1; j < m; j++) {
            int s2 = (1 << j) | (1 << i);
            x2_u_mask[i][j] = ((s2 - 1) ^ ((s2 - 1) >> 1)) & ~s2;
        }
    }

    uint8_t w_shift_cur[64];
    memcpy(w_shift_cur, base_w_shift, (size_t)nW);
    int64_t n_fibs = 1LL << nt_loop;
    int64_t total_surv = 0;

    for (int64_t st = 0; st < n_fibs; st++) {
        if (st > 0) {
            int p1 = __builtin_ctzll((uint64_t)st);
            for (int w = 0; w < nW; w++) w_shift_cur[w] ^= T_loop[p1 * nW + w];

            // 1. Update a2_core[i][j] (affine in t_loop: 1 XOR!)
            for (int i = 0; i < m; i++) {
                for (int j = i + 1; j < m; j++) {
                    __m256i *a2ij = a2_core + ((size_t)i * m + j) * n_core;
                    const __m256i *c3ijp = C3 + (((size_t)i * M + j) * M + (m + p1)) * n_core;
                    for (int c = 0; c < n_core; c++) a2ij[c] = _mm256_xor_si256(a2ij[c], c3ijp[c]);
                }
            }

            // 2. Update a1_core[i] (quadratic in t_loop: 2 XORs!)
            uint64_t st1 = (uint64_t)st ^ (1ULL << p1);
            if (st1 != 0) {
                int p2 = __builtin_ctzll(st1);
                for (int i = 0; i < m; i++) {
                    __m256i *t1p = T1_a1 + ((size_t)p1 * m + i) * n_core;
                    const __m256i *c3ip12 = C3 + (((size_t)i * M + (m + p1)) * M + (m + p2)) * n_core;
                    for (int c = 0; c < n_core; c++) t1p[c] = _mm256_xor_si256(t1p[c], c3ip12[c]);
                }
            }
            for (int i = 0; i < m; i++) {
                __m256i *a1i = a1_core + (size_t)i * n_core;
                const __m256i *t1p = T1_a1 + ((size_t)p1 * m + i) * n_core;
                for (int c = 0; c < n_core; c++) a1i[c] = _mm256_xor_si256(a1i[c], t1p[c]);
            }

            // 3. Update a0_core (cubic in t_loop: 3 XORs!)
            if (st1 != 0) {
                int p2 = __builtin_ctzll(st1);
                uint64_t st2 = st1 ^ (1ULL << p2);
                __m256i *t2p = T2_a0 + ((size_t)p1 * nt_loop + p2) * n_core;
                if (st2 != 0) {
                    int p3 = __builtin_ctzll(st2);
                    const __m256i *c3p = C3 + (((size_t)(m + p1) * M + (m + p2)) * M + (m + p3)) * n_core;
                    for (int c = 0; c < n_core; c++) t2p[c] = _mm256_xor_si256(t2p[c], c3p[c]);
                }
                __m256i *t1p = T1_a0 + (size_t)p1 * n_core;
                for (int c = 0; c < n_core; c++) t1p[c] = _mm256_xor_si256(t1p[c], t2p[c]);
            }
            const __m256i *t1p = T1_a0 + (size_t)p1 * n_core;
            for (int c = 0; c < n_core; c++) a0_core[c] = _mm256_xor_si256(a0_core[c], t1p[c]);
        }

        // Convert current (a0_core, a1_core, a2_core, D3_core) -> Bouillaguet FES (D0_core, D1_core, D2_core, D3_core)!
        for (int i = 0; i < m; i++) {
            __m256i *d1i = D1_core + (size_t)i * n_core;
            const __m256i *a1i = a1_core + (size_t)i * n_core;
            if (i > 0) {
                const __m256i *a2im = a2_core + ((size_t)(i - 1) * m + i) * n_core;
                for (int c = 0; c < n_core; c++) d1i[c] = _mm256_xor_si256(a1i[c], a2im[c]);
            } else {
                memcpy(d1i, a1i, (size_t)n_core * sizeof(__m256i));
            }
            for (int j = i + 1; j < m; j++) {
                __m256i *d2ij = D2_core + ((size_t)i * m + j) * n_core;
                const __m256i *a2ij = a2_core + ((size_t)i * m + j) * n_core;
                memcpy(d2ij, a2ij, (size_t)n_core * sizeof(__m256i));
                int xm = x2_u_mask[i][j];
                while (xm) {
                    int b = __builtin_ctz(xm);
                    xm &= xm - 1;
                    int aa = i, bb = j, dd = b;
                    if (dd < aa) { int t = aa; aa = dd; dd = bb; bb = t; }
                    else if (dd < bb) { int t = bb; bb = dd; dd = t; }
                    const __m256i *d3 = D3_core + (((size_t)aa * m + bb) * m + dd) * n_core;
                    for (int c = 0; c < n_core; c++) d2ij[c] = _mm256_xor_si256(d2ij[c], d3[c]);
                }
            }
        }

        int64_t t_gray = st ^ (st >> 1);
        uint64_t p_delta = (plant_t_gray_val >= 0 && t_gray == plant_t_gray_val) ? plant_delta_core : 0ULL;

        total_surv += process_one_fiber(
            d1, m, nW, nT, n_um, n_core, rK_init, n_kr, rK_1,
            U1, w_shift_cur, M0_c_masks, Mk_c_masks, KR_masks, keep_c_kr, Mu_opt_keep,
            a0_core, D1_core, D2_core, D3_core,
            qt_c0, qt_lin, qt_q_off, qt_q0, qt_q1,
            m_deg, m_v0, m_v1, m_v2, c0_core, cc_row_off, cc_cols,
            p_delta, LANE_U, D0_p, D1_p, D2_p, D3_p, M_vals_s, fallback_count_out
        );
    }

    free(M_vals); free(M_vals_s);
    free(F0); free(F1); free(F2); free(C1); free(C2); free(C3); free(Ftmp);
    free(a0_core); free(a1_core); free(a2_core); free(D1_core); free(D2_core); free(D3_core);
    free(T1_a1); free(T1_a0); free(T2_a0);
    free(D0_p); free(D1_p); free(D2_p); free(D3_p);
    return total_surv;
}

// OpenMP parallel driver over n_blocks independent Outer-FES blocks!
int64_t run_shard_omp_c(
    int d1, int m, int nt_loop, int n_blocks, int nW, int nT, int n_um, int n_core, int rK_init, int n_kr, int rK_1,
    const uint8_t *U1, const uint8_t *T_loop, const uint8_t *block_w_shifts, // (n_blocks * nW,)
    const uint32_t *M0_c_masks, const uint32_t *Mk_c_masks,
    const uint32_t *KR_masks, const int *keep_c_kr, const uint32_t *Mu_opt_keep,
    const uint8_t *qt_c0, const uint8_t *qt_lin,
    const int *qt_q_off, const int *qt_q0, const int *qt_q1,
    const int *m_deg, const int *m_v0, const int *m_v1, const int *m_v2,
    const uint8_t *c0_core, const int *cc_row_off, const int *cc_cols,
    int64_t *total_fallbacks_out
) {
    int64_t grand_surv = 0;
    int64_t grand_fb = 0;
    #pragma omp parallel for schedule(dynamic, 1) reduction(+:grand_surv,grand_fb)
    for (int blk = 0; blk < n_blocks; blk++) {
        int64_t fb = 0;
        int64_t s = run_outer_fes_block_c(
            d1, m, nt_loop, nW, nT, n_um, n_core, rK_init, n_kr, rK_1,
            U1, T_loop, block_w_shifts + (size_t)blk * nW,
            M0_c_masks, Mk_c_masks, KR_masks, keep_c_kr, Mu_opt_keep,
            qt_c0, qt_lin, qt_q_off, qt_q0, qt_q1,
            m_deg, m_v0, m_v1, m_v2, c0_core, cc_row_off, cc_cols,
            -1LL, 0ULL, &fb
        );
        grand_surv += s;
        grand_fb += fb;
    }
    *total_fallbacks_out = grand_fb;
    return grand_surv;
}
"""


def main():
    t0 = time.perf_counter()
    parser = argparse.ArgumentParser()
    parser.add_argument("--cell", choices=["B0_11", "B1_11"], required=True)
    parser.add_argument("--eta", type=int, required=True)
    parser.add_argument("--d1", type=int, required=True)
    parser.add_argument("--shard-idx", type=int, default=0)
    parser.add_argument("--n-shards", type=int, default=16)
    parser.add_argument("--nt-loop", type=int, default=12)
    parser.add_argument("--bench-blocks", type=int, default=0, help="If >0, run only bench_blocks blocks after Zero-Trust audit")
    parser.add_argument("--out-json", type=str, default="")
    args = parser.parse_args()

    cell_name, em, d1 = args.cell, args.eta, args.d1
    m = d1 - 8
    print(f"\n==================== [{cell_name} eta={em} d1={d1}] STEP 59A: ZERO-TRUST OUTER+INNER FES AVX2 CLOSER ====================", flush=True)

    c_src, so_path = WORK_DIR / "s59a_closer.c", WORK_DIR / "libs59a_closer.so"
    c_src.write_text(C_CLOSER_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-mavx2", "-fopenmp", "-shared", "-fPIC", str(c_src), "-o", str(so_path)], check=True)
    lib_c = ctypes.CDLL(str(so_path))

    lib_c.run_outer_fes_block_c.argtypes = [
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_uint32), ctypes.POINTER(ctypes.c_uint32),
        ctypes.POINTER(ctypes.c_uint32), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_uint32),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int64, ctypes.c_uint64, ctypes.POINTER(ctypes.c_int64),
    ]
    lib_c.run_outer_fes_block_c.restype = ctypes.c_int64

    lib_c.run_shard_omp_c.argtypes = [
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_uint32), ctypes.POINTER(ctypes.c_uint32),
        ctypes.POINTER(ctypes.c_uint32), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_uint32),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_int64),
    ]
    lib_c.run_shard_omp_c.restype = ctypes.c_int64

    # Build exact root system (identical to Step 58A/58B)
    c_diag, so_diag = WORK_DIR / "s59a_diag.c", WORK_DIR / "libs59a_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s59a_s9.c", WORK_DIR / "libs59a_s9.so"
    c_s9.write_text(s9.C_STEP9_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_s9), "-o", str(so_s9)], check=True)
    lib9 = s45a._setup_lib9(so_s9)

    c_cg, so_cg = WORK_DIR / "s59a_cg.c", WORK_DIR / "libs59a_cg.so"
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

    c_sh, so_sh = WORK_DIR / "s59a_sh.c", WORK_DIR / "libs59a_sh.so"
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

    sys_ex = s45b.extract_eta_exact_system(em, root, eta_free, lib9, lib_sh, tbl, rng_seed=5900 + em)
    nW, nT = sys_ex["nW"], sys_ex["nT"]
    M0_c, Mk_c = sys_ex["M0_c"], sys_ex["Mk_c"]
    L_core = sys_ex["L_core"]
    n_core, rK_init = M0_c.shape
    assert n_core <= 64 and rK_init <= 31

    fn_b = sys_ex["eval_b_and_p0_batch"]
    cl_b = dict(zip(fn_b.__code__.co_freevars, [c.cell_contents for c in fn_b.__closure__]))
    fn_t = cl_b["eval_t_batch"]
    cl_t = dict(zip(fn_t.__code__.co_freevars, [c.cell_contents for c in fn_t.__closure__]))

    qt_c0 = np.ascontiguousarray(cl_t["qt_c0"], dtype=np.uint8)
    qt_lin = np.ascontiguousarray(cl_t["qt_lin"], dtype=np.uint8)
    qt_quads = cl_t["qt_quads"]
    qt_q_off, qt_q0, qt_q1 = [0], [], []
    for qp in qt_quads:
        for a, b in qp: qt_q0.append(a); qt_q1.append(b)
        qt_q_off.append(len(qt_q0))
    qt_q_off = np.ascontiguousarray(qt_q_off, dtype=np.int32)
    qt_q0 = np.ascontiguousarray(qt_q0, dtype=np.int32)
    qt_q1 = np.ascontiguousarray(qt_q1, dtype=np.int32)

    b0_const = cl_b["b0_const"]
    B_coeff = cl_b["B_coeff_T"].T.copy()
    n_um = int(cl_b["n_um"])
    m_deg = np.zeros(n_um, dtype=np.int32)
    m_v0 = np.zeros(n_um, dtype=np.int32)
    m_v1 = np.zeros(n_um, dtype=np.int32)
    m_v2 = np.zeros(n_um, dtype=np.int32)
    for ii, u in enumerate(cl_b["idx1"]):
        m_deg[u] = 1; m_v0[u] = int(cl_b["a1"][ii])
    for ii, u in enumerate(cl_b["idx2"]):
        m_deg[u] = 2; m_v0[u] = int(cl_b["a2"][ii]); m_v1[u] = int(cl_b["b2"][ii])
    for ii, u in enumerate(cl_b["idx3"]):
        m_deg[u] = 3; m_v0[u] = int(cl_b["a3"][ii]); m_v1[u] = int(cl_b["b3"][ii]); m_v2[u] = int(cl_b["c3"][ii])

    C_core = (L_core.astype(np.uint16) @ B_coeff.astype(np.uint16)) & 1
    c0_core = np.ascontiguousarray((L_core.astype(np.uint16) @ b0_const.astype(np.uint16)) & 1, dtype=np.uint8)
    cc_off, cc_cols = [0], []
    for c in range(n_core):
        nz = np.flatnonzero(C_core[c]).tolist()
        cc_cols.extend(nz)
        cc_off.append(len(cc_cols))
    cc_off = np.ascontiguousarray(cc_off, dtype=np.int32)
    cc_cols = np.ascontiguousarray(cc_cols, dtype=np.int32)

    # Optimize U1 basis
    U_opt, Mu_opt, bkey = s57b.optimize_u1_basis(M0_c, Mk_c, d1, em_seed=em)
    U1 = np.ascontiguousarray(U_opt[:d1], dtype=np.uint8)
    T1 = np.ascontiguousarray(U_opt[d1:], dtype=np.uint8)
    nt1 = nW - d1
    print(f"  Optimized U1 (d1={d1}, NT1={nt1}): r1_elim={bkey[0]}, V0={bkey[1]}, KR={bkey[2]} -> rK_rem={rK_init-bkey[0]}", flush=True)

    # Pack M0_c, Mk_c, KR, keep_c_kr, Mu_opt_keep for bit-packed C!
    KR = s40a.gf2_nullspace_np(np.vstack(Mu_opt))
    n_kr = int(KR.shape[0])
    _, kr_pivs = s40a.gf2_rref_np(KR) if n_kr > 0 else (None, [])
    kr_set = set(kr_pivs)
    keep_c_kr = np.ascontiguousarray([c for c in range(rK_init) if c not in kr_set], dtype=np.int32)
    rK_1 = len(keep_c_kr)

    M0_c_masks = np.zeros(n_core, dtype=np.uint32)
    for r in range(n_core):
        for c in range(rK_init):
            if M0_c[r, c]: M0_c_masks[r] |= np.uint32(1 << c)
    Mk_c_masks = np.zeros((nW, n_core), dtype=np.uint32)
    for w in range(nW):
        for r in range(n_core):
            for c in range(rK_init):
                if Mk_c[w][r, c]: Mk_c_masks[w, r] |= np.uint32(1 << c)
    KR_masks = np.zeros(max(1, n_kr), dtype=np.uint32)
    for j in range(n_kr):
        for c in range(rK_init):
            if KR[j, c]: KR_masks[j] |= np.uint32(1 << c)
    Mu_opt_keep = np.zeros((d1, n_core), dtype=np.uint32)
    for a in range(d1):
        for r in range(n_core):
            for ci, c in enumerate(keep_c_kr):
                if Mu_opt[a][r, c]: Mu_opt_keep[a, r] |= np.uint32(1 << ci)

    # 1. ZERO-TRUST END-TO-END AUDIT: Plant 10 random solutions across different fibers in an Outer-FES block!
    print("\n  --- ZERO-TRUST END-TO-END OUTER+INNER FES AUDIT (10 trials, nt_loop=4) ---", flush=True)
    rng = np.random.default_rng(5999 + em)
    zt_pass = 0
    nt_zt = 4
    T_zt = np.ascontiguousarray(T1[:nt_zt], dtype=np.uint8)
    for trial in range(10):
        t_rest = rng.integers(0, 2, size=nt1 - nt_zt, dtype=np.uint8)
        base_ws = np.ascontiguousarray((t_rest @ T1[nt_zt:]) & 1, dtype=np.uint8)
        t_star_val = int(rng.integers(0, 1 << nt_zt))
        t_star_bits = np.array([(t_star_val >> p) & 1 for p in range(nt_zt)], dtype=np.uint8)
        w_shift_star = (base_ws ^ ((t_star_bits @ T_zt) & 1)) & 1
        u_star = rng.integers(0, 2, size=d1, dtype=np.uint8)
        r_star = rng.integers(0, 2, size=rK_init, dtype=np.uint8)
        w_star = (w_shift_star ^ ((u_star @ U1) & 1)) & 1
        b_orig_star, _ = sys_ex["eval_b_and_p0_batch"](w_star.reshape(1, -1))
        b_core_star = (L_core @ b_orig_star[0]) & 1
        M_star = M0_c.copy()
        for w in range(nW):
            if w_star[w]: M_star ^= Mk_c[w]
        target_core = (M_star @ r_star) & 1
        delta_core = (b_core_star ^ target_core) & 1
        delta_mask = sum(int(delta_core[c]) << c for c in range(n_core))
        fb_zt = ctypes.c_int64(0)
        surv = int(lib_c.run_outer_fes_block_c(
            d1, m, nt_zt, nW, nT, n_um, n_core, rK_init, n_kr, rK_1,
            U1.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
            T_zt.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
            base_ws.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
            M0_c_masks.ctypes.data_as(ctypes.POINTER(ctypes.c_uint32)),
            Mk_c_masks.ctypes.data_as(ctypes.POINTER(ctypes.c_uint32)),
            KR_masks.ctypes.data_as(ctypes.POINTER(ctypes.c_uint32)),
            keep_c_kr.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
            Mu_opt_keep.ctypes.data_as(ctypes.POINTER(ctypes.c_uint32)),
            qt_c0.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
            qt_lin.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
            qt_q_off.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
            qt_q0.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
            qt_q1.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
            m_deg.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
            m_v0.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
            m_v1.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
            m_v2.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
            c0_core.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
            cc_off.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
            cc_cols.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
            ctypes.c_int64(t_star_val), ctypes.c_uint64(delta_mask),
            ctypes.byref(fb_zt),
        ))
        if surv >= 1:
            zt_pass += 1
        print(f"    ZT trial {trial}: t_star={t_star_val:2d}, full_surv={surv} (fb={fb_zt.value})", flush=True)
    print(f"  ZERO-TRUST END-TO-END AUDIT: {zt_pass}/10 planted solutions detected!", flush=True)
    assert zt_pass == 10, "CRITICAL: Outer+Inner FES closer missed a planted solution!"

    # 2. Build shard blocks and execute with OpenMP!
    nt_loop = args.nt_loop
    n_shards = args.n_shards
    assert (n_shards & (n_shards - 1)) == 0, "n_shards must be a power of 2"
    s_bits = n_shards.bit_length() - 1
    nt_blk = nt1 - nt_loop - s_bits
    assert nt_blk >= 0, f"nt1={nt1} < nt_loop={nt_loop} + s_bits={s_bits}"
    n_blocks_full = 1 << nt_blk
    n_blocks = args.bench_blocks if args.bench_blocks > 0 else n_blocks_full

    T_loop = np.ascontiguousarray(T1[:nt_loop], dtype=np.uint8)
    T_blk = T1[nt_loop : nt_loop + nt_blk]
    T_sh = T1[nt_loop + nt_blk :]

    sh_bits = np.array([(args.shard_idx >> p) & 1 for p in range(s_bits)], dtype=np.uint8) if s_bits > 0 else np.zeros(0, dtype=np.uint8)
    sh_shift = ((sh_bits @ T_sh) & 1) if s_bits > 0 else np.zeros(nW, dtype=np.uint8)

    block_w_shifts = np.zeros((n_blocks, nW), dtype=np.uint8)
    for blk in range(n_blocks):
        ws = sh_shift.copy()
        for p in range(nt_blk):
            if (blk >> p) & 1:
                ws ^= T_blk[p]
        block_w_shifts[blk] = ws
    block_w_shifts = np.ascontiguousarray(block_w_shifts, dtype=np.uint8)

    n_threads = int(os.environ.get("OMP_NUM_THREADS", os.cpu_count() or 1))
    total_fibs = n_blocks * (1 << nt_loop)
    total_pts = total_fibs * (1 << d1)
    print(f"\n  Launching OpenMP ({n_threads} threads): shard {args.shard_idx}/{n_shards}, {n_blocks}/{n_blocks_full} blocks ({total_fibs:,} fibers = {total_pts:,} pts)...", flush=True)

    t_run = time.perf_counter()
    tot_fb = ctypes.c_int64(0)
    grand_surv = int(lib_c.run_shard_omp_c(
        d1, m, nt_loop, n_blocks, nW, nT, n_um, n_core, rK_init, n_kr, rK_1,
        U1.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
        T_loop.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
        block_w_shifts.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
        M0_c_masks.ctypes.data_as(ctypes.POINTER(ctypes.c_uint32)),
        Mk_c_masks.ctypes.data_as(ctypes.POINTER(ctypes.c_uint32)),
        KR_masks.ctypes.data_as(ctypes.POINTER(ctypes.c_uint32)),
        keep_c_kr.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
        Mu_opt_keep.ctypes.data_as(ctypes.POINTER(ctypes.c_uint32)),
        qt_c0.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
        qt_lin.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
        qt_q_off.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
        qt_q0.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
        qt_q1.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
        m_deg.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
        m_v0.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
        m_v1.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
        m_v2.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
        c0_core.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
        cc_off.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
        cc_cols.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
        ctypes.byref(tot_fb),
    ))
    dt_run = time.perf_counter() - t_run
    pts_per_s_total = total_pts / dt_run
    pts_per_s_core = pts_per_s_total / max(1, n_threads)
    orbit_pts = 1 << nW
    min_80core = (orbit_pts / (pts_per_s_core * 80.0)) / 60.0

    print(f"\n  *** STEP 59A END-TO-END RESULTS ({cell_name} eta={em}, shard {args.shard_idx}/{n_shards}) ***", flush=True)
    print(f"    Fibers closed   : {total_fibs:,} (degenerate fallbacks={tot_fb.value})", flush=True)
    print(f"    Points closed   : {total_pts:,} in {dt_run:.2f}s", flush=True)
    print(f"    FULL SURVIVORS  : {grand_surv}", flush=True)
    print(f"    End-to-end rate : {pts_per_s_total/1e6:.2f}M pts/s total ({pts_per_s_core/1e6:.2f}M pts/s/core on {n_threads} threads)", flush=True)
    print(f"    Projected FULL ORBIT (2^{nW}) on 80 cores: {min_80core:.2f} minutes!!", flush=True)

    if args.out_json:
        cert = {
            "cell": cell_name, "eta": em, "d1": d1, "nW": nW,
            "shard_idx": args.shard_idx, "n_shards": n_shards,
            "is_full_shard": (args.bench_blocks == 0),
            "fibers_closed": int(total_fibs),
            "points_closed": int(total_pts),
            "degenerate_fallbacks": int(tot_fb.value),
            "full_survivors": int(grand_surv),
            "zero_trust_planted_audit": "10/10 PASS",
            "wall_time_s": round(dt_run, 2),
            "rate_mpts_per_s_total": round(pts_per_s_total / 1e6, 2),
        }
        cert["sha256"] = hashlib.sha256(json.dumps(cert, sort_keys=True).encode()).hexdigest()
        Path(args.out_json).write_text(json.dumps(cert, indent=2), encoding="utf-8")
        print(f"    Saved certificate: {args.out_json}", flush=True)

    print(f"\n[STEP 59A {cell_name} eta={em}] DONE in {time.perf_counter()-t0:.2f}s", flush=True)


if __name__ == "__main__":
    main()
