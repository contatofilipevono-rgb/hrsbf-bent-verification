#!/usr/bin/env python3
"""
SOLVE_B000_K1_CUDA_L4_FES.py

Self-contained CUDA L4 (sm_89, auto-detect fallback) port of Step 59A bit-sliced FES closer
for C5-free B0_00, K=1 (default rep e=11; supports --reps for multi-rep sweeps).

Mathematical & Zero-Trust Guarantees:
  1. Builds B0_00, K=1 via SOLVE_B000_K1_WESS_PILOT.setup_k1_root + get_rep_state
     (force_k=1, A14_LMASK, ZERO C5, ZERO proved_extra).
  2. Extracts exact s45b bilinear pencil (M0_c, Mk_c, L_core) and optimizes U1 (d1 <= 14)
     via s57b.optimize_u1_basis.
  3. Builds the exact global degree-<=3 ANF of C_core in all M_all = nW - 6 variables
     (64-bit lanes = U1[0..5]) on CPU/OpenMP and verifies 0/100 mismatches against direct
     evaluation of sys_ex["eval_b_and_p0_batch"] on 100 random W vectors.
  4. On GPU: 1 CUDA block (256 threads) processes a strip of 64 fibers (nt_strip = 6).
     - Each fiber runs exact GF(2) Round-1 (L_kr + V0 + E_mat) in warp 0.
     - Any degenerate fiber (rK_rem > 6) is atomically logged to GPU->CPU buffer and closed
       exhaustively on CPU via exact full-row verification (ZERO fibers skipped, ZERO false negatives).
     - All 256 threads simultaneously evaluate all 2^d1 points (256 u_hi x 64 u_lo = 16,384 pts)
       with zero warp divergence; every fast-check hit is atomically logged and verified on CPU
       via exact full-row M_1(u_1) r_1 == b_1(u_1).
  5. Mandatory 10/10 GPU->CPU Zero-Trust planted-solution audit BEFORE any sweep.

Usage (Google Colab L4):
  python3 SOLVE_B000_K1_CUDA_L4_FES.py --rep 11 --bench-only --out-json bench_e11_l4.json
  python3 SOLVE_B000_K1_CUDA_L4_FES.py --rep 11 --out-json cert_k1_e11_l4.json
  python3 SOLVE_B000_K1_CUDA_L4_FES.py --reps 11,1,9 --out-json cert_k1_batch_l4.json
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

import SOLVE_B000_K1_WESS_PILOT as pilot
import SOLVE_STEP40A_B11_COMMON_KERNEL_AND_DECOMPOSITION as s40a
import SOLVE_STEP45B_POLAR_EXACT_RHS_AND_KL3 as s45b
import SOLVE_STEP57B_GREEDY_BASIS_AND_BLOCKB_INJECT as s57b


CPU_HELPER_SRC = r"""
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <omp.h>

typedef struct { uint64_t lo, hi; } m128_t;
static inline m128_t m128_zero(void) { m128_t r = {0ULL, 0ULL}; return r; }
static inline m128_t m128_bit(int i) {
    m128_t r = {0ULL, 0ULL};
    if (i < 64) r.lo = 1ULL << i; else r.hi = 1ULL << (i - 64);
    return r;
}
static inline m128_t m128_xor(m128_t a, m128_t b) { m128_t r = {a.lo ^ b.lo, a.hi ^ b.hi}; return r; }
static inline int m128_parity_and(m128_t a, m128_t b) {
    return __builtin_parityll(a.lo & b.lo) ^ __builtin_parityll(a.hi & b.hi);
}

static void init_lane_basis_64(uint64_t LANE_U[6]) {
    for (int a = 0; a < 6; a++) {
        uint64_t v = 0ULL;
        for (int lane = 0; lane < 64; lane++) {
            if ((lane >> a) & 1) v |= (1ULL << lane);
        }
        LANE_U[a] = v;
    }
}

static void eval_ccore_direct_64(
    const uint64_t *W_cur, int nW, int nT, int n_um, int n_core,
    const uint8_t *qt_c0, const uint8_t *qt_lin,
    const int *qt_q_off, const int *qt_q0, const int *qt_q1,
    const int *m_deg, const int *m_v0, const int *m_v1, const int *m_v2,
    const uint8_t *c0_core, const int *cc_row_off, const int *cc_cols,
    uint64_t *WT, uint64_t *M_vals, uint64_t *out_core
) {
    const uint64_t ONES = ~0ULL;
    for (int w = 0; w < nW; w++) WT[w] = W_cur[w];
    for (int ti = 0; ti < nT; ti++) {
        uint64_t acc = qt_c0[ti] ? ONES : 0ULL;
        const uint8_t *ql = qt_lin + ti * nW;
        for (int w = 0; w < nW; w++) if (ql[w]) acc ^= WT[w];
        for (int q = qt_q_off[ti]; q < qt_q_off[ti + 1]; q++) acc ^= (WT[qt_q0[q]] & WT[qt_q1[q]]);
        WT[nW + ti] = acc;
    }
    for (int u = 0; u < n_um; u++) {
        int dg = m_deg[u];
        if (dg == 1) M_vals[u] = WT[m_v0[u]];
        else if (dg == 2) M_vals[u] = WT[m_v0[u]] & WT[m_v1[u]];
        else M_vals[u] = WT[m_v0[u]] & WT[m_v1[u]] & WT[m_v2[u]];
    }
    for (int c = 0; c < n_core; c++) {
        uint64_t acc = c0_core[c] ? ONES : 0ULL;
        for (int p = cc_row_off[c]; p < cc_row_off[c + 1]; p++) acc ^= M_vals[cc_cols[p]];
        out_core[c] = acc;
    }
}

// Build exact global degree-<=3 ANF of C_core in M_all = nW - 6 variables (64-bit lanes = U1[0..5]).
// B_all[0..M_all-1][nW]: rows 0..m-1 = U1[6..d1-1], rows m..M_all-1 = T1[0..nt1-1].
void build_global_anf_64(
    int nW, int nT, int n_um, int n_core, int M_all,
    const uint8_t *U1_lo6,   // (6 * nW,)
    const uint8_t *B_all,    // (M_all * nW,)
    const uint8_t *qt_c0, const uint8_t *qt_lin,
    const int *qt_q_off, const int *qt_q0, const int *qt_q1,
    const int *m_deg, const int *m_v0, const int *m_v1, const int *m_v2,
    const uint8_t *c0_core, const int *cc_row_off, const int *cc_cols,
    const int *pair_idx,     // (M_all * M_all,) -> 0..n_pairs-1
    const int *tri_idx,      // (M_all * M_all * M_all,) -> 0..n_tris-1
    uint64_t *G0,            // (n_core,)
    uint64_t *G1,            // (M_all * n_core,)
    uint64_t *G2,            // (n_pairs * n_core,)
    uint64_t *G3             // (n_tris * n_core,)
) {
    uint64_t LANE_U[6];
    init_lane_basis_64(LANE_U);
    const uint64_t ONES = ~0ULL;

    uint64_t W_base[64];
    for (int w = 0; w < nW; w++) {
        uint64_t v = 0ULL;
        for (int a = 0; a < 6; a++) if (U1_lo6[a * nW + w]) v ^= LANE_U[a];
        W_base[w] = v;
    }

    int n_pairs = M_all * (M_all - 1) / 2;
    uint64_t *F1 = (uint64_t *)malloc((size_t)M_all * n_core * sizeof(uint64_t));
    uint64_t *F2 = (uint64_t *)malloc((size_t)n_pairs * n_core * sizeof(uint64_t));

    // Weight 0
    {
        uint64_t WT[96];
        uint64_t *M_vals = (uint64_t *)malloc((size_t)(n_um + 1) * sizeof(uint64_t));
        eval_ccore_direct_64(W_base, nW, nT, n_um, n_core, qt_c0, qt_lin, qt_q_off, qt_q0, qt_q1,
                             m_deg, m_v0, m_v1, m_v2, c0_core, cc_row_off, cc_cols, WT, M_vals, G0);
        free(M_vals);
    }

    // Weight 1
    #pragma omp parallel
    {
        uint64_t W_cur[64], WT[96];
        uint64_t *M_vals = (uint64_t *)malloc((size_t)(n_um + 1) * sizeof(uint64_t));
        #pragma omp for schedule(static)
        for (int a = 0; a < M_all; a++) {
            for (int w = 0; w < nW; w++) W_cur[w] = B_all[a * nW + w] ? (W_base[w] ^ ONES) : W_base[w];
            uint64_t *f1a = F1 + (size_t)a * n_core;
            eval_ccore_direct_64(W_cur, nW, nT, n_um, n_core, qt_c0, qt_lin, qt_q_off, qt_q0, qt_q1,
                                 m_deg, m_v0, m_v1, m_v2, c0_core, cc_row_off, cc_cols, WT, M_vals, f1a);
            uint64_t *g1a = G1 + (size_t)a * n_core;
            for (int c = 0; c < n_core; c++) g1a[c] = f1a[c] ^ G0[c];
        }
        free(M_vals);
    }

    // Weight 2
    #pragma omp parallel
    {
        uint64_t W_cur[64], WT[96];
        uint64_t *M_vals = (uint64_t *)malloc((size_t)(n_um + 1) * sizeof(uint64_t));
        #pragma omp for schedule(dynamic, 2)
        for (int a = 0; a < M_all; a++) {
            for (int b = a + 1; b < M_all; b++) {
                for (int w = 0; w < nW; w++) {
                    W_cur[w] = (B_all[a * nW + w] ^ B_all[b * nW + w]) ? (W_base[w] ^ ONES) : W_base[w];
                }
                int pid = pair_idx[a * M_all + b];
                uint64_t *f2ab = F2 + (size_t)pid * n_core;
                eval_ccore_direct_64(W_cur, nW, nT, n_um, n_core, qt_c0, qt_lin, qt_q_off, qt_q0, qt_q1,
                                     m_deg, m_v0, m_v1, m_v2, c0_core, cc_row_off, cc_cols, WT, M_vals, f2ab);
                uint64_t *g2ab = G2 + (size_t)pid * n_core;
                const uint64_t *f1a = F1 + (size_t)a * n_core;
                const uint64_t *f1b = F1 + (size_t)b * n_core;
                for (int c = 0; c < n_core; c++) g2ab[c] = f2ab[c] ^ f1a[c] ^ f1b[c] ^ G0[c];
            }
        }
        free(M_vals);
    }

    // Weight 3
    #pragma omp parallel
    {
        uint64_t W_cur[64], WT[96];
        uint64_t *M_vals = (uint64_t *)malloc((size_t)(n_um + 1) * sizeof(uint64_t));
        uint64_t *Ftmp = (uint64_t *)malloc((size_t)n_core * sizeof(uint64_t));
        #pragma omp for schedule(dynamic, 1)
        for (int a = 0; a < M_all; a++) {
            for (int b = a + 1; b < M_all; b++) {
                int pab = pair_idx[a * M_all + b];
                const uint64_t *f2ab = F2 + (size_t)pab * n_core;
                const uint64_t *f1a = F1 + (size_t)a * n_core;
                const uint64_t *f1b = F1 + (size_t)b * n_core;
                for (int d = b + 1; d < M_all; d++) {
                    for (int w = 0; w < nW; w++) {
                        W_cur[w] = (B_all[a * nW + w] ^ B_all[b * nW + w] ^ B_all[d * nW + w]) ? (W_base[w] ^ ONES) : W_base[w];
                    }
                    eval_ccore_direct_64(W_cur, nW, nT, n_um, n_core, qt_c0, qt_lin, qt_q_off, qt_q0, qt_q1,
                                         m_deg, m_v0, m_v1, m_v2, c0_core, cc_row_off, cc_cols, WT, M_vals, Ftmp);
                    const uint64_t *f2ad = F2 + (size_t)pair_idx[a * M_all + d] * n_core;
                    const uint64_t *f2bd = F2 + (size_t)pair_idx[b * M_all + d] * n_core;
                    const uint64_t *f1d = F1 + (size_t)d * n_core;
                    int tid = tri_idx[(a * M_all + b) * M_all + d];
                    uint64_t *g3 = G3 + (size_t)tid * n_core;
                    for (int c = 0; c < n_core; c++) {
                        g3[c] = Ftmp[c] ^ f2ab[c] ^ f2ad[c] ^ f2bd[c] ^ f1a[c] ^ f1b[c] ^ f1d[c] ^ G0[c];
                    }
                }
            }
        }
        free(Ftmp);
        free(M_vals);
    }

    free(F1);
    free(F2);
}

static m128_t eval_ccore_scalar_c(
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
    m128_t out = m128_zero();
    for (int c = 0; c < n_core; c++) {
        uint8_t acc = c0_core[c];
        for (int p = cc_row_off[c]; p < cc_row_off[c + 1]; p++) acc ^= M_vals_s[cc_cols[p]];
        if (acc) {
            if (c < 64) out.lo |= (1ULL << c);
            else out.hi |= (1ULL << (c - 64));
        }
    }
    return out;
}

// Exact full-row consistency check of M_orig(w_vec) r == b_core(w_vec) ^ plant_delta_core!
// Note: checking M_orig(w_vec) r == b_core(w_vec) is EVEN STRONGER/MORE DIRECT than checking L_kr @ M_1!
static int verify_full_w_exact(
    const uint8_t *w_vec, int nW, int nT, int n_um, int n_core, int rK_init,
    const uint32_t *M0_c_masks, const uint32_t *Mk_c_masks,
    const uint8_t *qt_c0, const uint8_t *qt_lin,
    const int *qt_q_off, const int *qt_q0, const int *qt_q1,
    const int *m_deg, const int *m_v0, const int *m_v1, const int *m_v2,
    const uint8_t *c0_core, const int *cc_row_off, const int *cc_cols,
    m128_t plant_delta_core, uint8_t *M_vals_s
) {
    m128_t b_core = eval_ccore_scalar_c(w_vec, nW, nT, n_um, n_core, qt_c0, qt_lin, qt_q_off, qt_q0, qt_q1,
                                        m_deg, m_v0, m_v1, m_v2, c0_core, cc_row_off, cc_cols, M_vals_s);
    b_core = m128_xor(b_core, plant_delta_core);

    uint32_t piv[32];
    memset(piv, 0, sizeof(piv));
    uint32_t rhs_bit = 1U << rK_init;
    for (int r = 0; r < n_core; r++) {
        uint32_t row = M0_c_masks[r];
        for (int w = 0; w < nW; w++) {
            if (w_vec[w]) row ^= Mk_c_masks[w * n_core + r];
        }
        int b_bit = (r < 64) ? (int)((b_core.lo >> r) & 1ULL) : (int)((b_core.hi >> (r - 64)) & 1ULL);
        if (b_bit) row |= rhs_bit;
        for (int c = 0; c < rK_init; c++) {
            if ((row >> c) & 1U) {
                if (piv[c]) row ^= piv[c];
                else { piv[c] = row; row = 0; break; }
            }
        }
        if (row == rhs_bit) return 0;
    }
    return 1;
}

typedef struct {
    uint64_t fiber_idx;
    uint64_t mask64;
    uint32_t u_hi;
    uint32_t pad;
} CandRec;

// Verify all GPU candidates (and log real survivors if plant_fiber_idx < 0).
int64_t verify_candidates_omp(
    int n_cands, const CandRec *cands,
    int d1, int nW, int nt1, int nT, int n_um, int n_core, int rK_init,
    const uint8_t *U1, const uint8_t *T1,
    const uint32_t *M0_c_masks, const uint32_t *Mk_c_masks,
    const uint8_t *qt_c0, const uint8_t *qt_lin,
    const int *qt_q_off, const int *qt_q0, const int *qt_q1,
    const int *m_deg, const int *m_v0, const int *m_v1, const int *m_v2,
    const uint8_t *c0_core, const int *cc_row_off, const int *cc_cols,
    int64_t plant_fiber_idx, uint64_t plant_delta_lo, uint64_t plant_delta_hi,
    uint64_t *real_surv_w_out, int max_surv_out
) {
    int64_t total_surv = 0;
    #pragma omp parallel
    {
        uint8_t *M_vals_s = (uint8_t *)malloc((size_t)(n_um + 1));
        #pragma omp for schedule(dynamic, 16) reduction(+:total_surv)
        for (int idx = 0; idx < n_cands; idx++) {
            uint64_t fidx = cands[idx].fiber_idx;
            uint32_t u_hi = cands[idx].u_hi;
            uint64_t m64 = cands[idx].mask64;
            uint8_t w_base[64];
            memset(w_base, 0, (size_t)nW);
            for (int p = 0; p < nt1; p++) {
                if ((fidx >> p) & 1ULL) {
                    for (int w = 0; w < nW; w++) w_base[w] ^= T1[p * nW + w];
                }
            }
            int m = d1 - 6;
            for (int b = 0; b < m; b++) {
                if ((u_hi >> b) & 1U) {
                    for (int w = 0; w < nW; w++) w_base[w] ^= U1[(6 + b) * nW + w];
                }
            }
            m128_t p_delta = m128_zero();
            if (plant_fiber_idx >= 0 && (int64_t)fidx == plant_fiber_idx) {
                p_delta.lo = plant_delta_lo;
                p_delta.hi = plant_delta_hi;
            }
            while (m64) {
                int lane = __builtin_ctzll(m64);
                m64 &= m64 - 1;
                uint8_t w_vec[64];
                memcpy(w_vec, w_base, (size_t)nW);
                for (int a = 0; a < 6; a++) {
                    if ((lane >> a) & 1) {
                        for (int w = 0; w < nW; w++) w_vec[w] ^= U1[a * nW + w];
                    }
                }
                if (verify_full_w_exact(w_vec, nW, nT, n_um, n_core, rK_init, M0_c_masks, Mk_c_masks,
                                        qt_c0, qt_lin, qt_q_off, qt_q0, qt_q1,
                                        m_deg, m_v0, m_v1, m_v2, c0_core, cc_row_off, cc_cols,
                                        p_delta, M_vals_s)) {
                    total_surv++;
                    if (plant_fiber_idx < 0 && real_surv_w_out != NULL) {
                        uint64_t wm = 0ULL;
                        for (int w = 0; w < nW; w++) if (w_vec[w]) wm |= (1ULL << w);
                        #pragma omp critical
                        {
                            printf("  [REAL_SURVIVOR_FOUND] fiber=%llu w_mask=0x%012llx\n",
                                   (unsigned long long)fidx, (unsigned long long)wm);
                            fflush(stdout);
                            if (max_surv_out > 0) real_surv_w_out[0] = wm;
                        }
                    }
                }
            }
        }
        free(M_vals_s);
    }
    return total_surv;
}

// Exhaustively close all GPU-logged degenerate fibers (rK_rem > 6) on CPU/OpenMP!
int64_t close_degenerate_fibers_omp(
    int n_deg, const uint64_t *deg_fibers,
    int d1, int nW, int nt1, int nT, int n_um, int n_core, int rK_init,
    const uint8_t *U1, const uint8_t *T1,
    const uint32_t *M0_c_masks, const uint32_t *Mk_c_masks,
    const uint8_t *qt_c0, const uint8_t *qt_lin,
    const int *qt_q_off, const int *qt_q0, const int *qt_q1,
    const int *m_deg, const int *m_v0, const int *m_v1, const int *m_v2,
    const uint8_t *c0_core, const int *cc_row_off, const int *cc_cols,
    int64_t plant_fiber_idx, uint64_t plant_delta_lo, uint64_t plant_delta_hi
) {
    int64_t total_surv = 0;
    int64_t n_pts = 1LL << d1;
    #pragma omp parallel
    {
        uint8_t *M_vals_s = (uint8_t *)malloc((size_t)(n_um + 1));
        #pragma omp for schedule(dynamic, 1) reduction(+:total_surv)
        for (int idx = 0; idx < n_deg; idx++) {
            uint64_t fidx = deg_fibers[idx];
            uint8_t w_shift[64];
            memset(w_shift, 0, (size_t)nW);
            for (int p = 0; p < nt1; p++) {
                if ((fidx >> p) & 1ULL) {
                    for (int w = 0; w < nW; w++) w_shift[w] ^= T1[p * nW + w];
                }
            }
            m128_t p_delta = m128_zero();
            if (plant_fiber_idx >= 0 && (int64_t)fidx == plant_fiber_idx) {
                p_delta.lo = plant_delta_lo;
                p_delta.hi = plant_delta_hi;
            }
            uint8_t w_vec[64];
            for (int64_t u = 0; u < n_pts; u++) {
                memcpy(w_vec, w_shift, (size_t)nW);
                for (int a = 0; a < d1; a++) {
                    if ((u >> a) & 1LL) {
                        for (int w = 0; w < nW; w++) w_vec[w] ^= U1[a * nW + w];
                    }
                }
                if (verify_full_w_exact(w_vec, nW, nT, n_um, n_core, rK_init, M0_c_masks, Mk_c_masks,
                                        qt_c0, qt_lin, qt_q_off, qt_q0, qt_q1,
                                        m_deg, m_v0, m_v1, m_v2, c0_core, cc_row_off, cc_cols,
                                        p_delta, M_vals_s)) {
                    total_surv++;
                }
            }
        }
        free(M_vals_s);
    }
    return total_surv;
}
"""


CUDA_KERNEL_SRC = r"""
#include <stdint.h>
#include <stdio.h>
#include <cuda_runtime.h>

#define MAX_CORE 128
#define MAX_K    60
#define MAX_FAST 24
#define MAX_M    8
#define STRIP_BITS 6
#define STRIP_LEN  (1 << STRIP_BITS)
#define MAX_MON  93  // 1 + 8 + 28 + 56

struct m128_t { uint64_t lo, hi; };
__device__ __forceinline__ m128_t m128_zero() { return {0ULL, 0ULL}; }
__device__ __forceinline__ m128_t m128_bit(int i) {
    if (i < 64) return {1ULL << i, 0ULL};
    return {0ULL, 1ULL << (i - 64)};
}
__device__ __forceinline__ m128_t m128_xor(m128_t a, m128_t b) { return {a.lo ^ b.lo, a.hi ^ b.hi}; }
__device__ __forceinline__ int m128_parity_and(m128_t a, m128_t b) {
    return (__popcll(a.lo & b.lo) ^ __popcll(a.hi & b.hi)) & 1;
}

struct CandRec {
    uint64_t fiber_idx;
    uint64_t mask64;
    uint32_t u_hi;
    uint32_t pad;
};

__constant__ uint64_t c_LANE_U64[6];
__constant__ uint8_t  c_U1[16 * 64];       // d1 <= 14, nW <= 64
__constant__ uint8_t  c_T1[36 * 64];       // nt1 <= 36, nW <= 64
__constant__ uint32_t c_M0_c[MAX_CORE];
__constant__ uint32_t c_KR[32];
__constant__ int      c_keep_c_kr[32];

// Per-block workspace in global memory (avoids >48KB shared memory limits, stays in L4 48MB L2!)
// Stride per block (in uint64_t):
//   base_a0[n_core] + base_a1[m*n_core] + base_a2[28*n_core]
//   + base_t1[6*n_core] + base_t2[15*n_core] + base_ut[8*6*n_core]
//   + cur_a0[n_core] + cur_a1[8*n_core] + cur_a2[28*n_core]
//   + ap[93*MAX_K]
// Total <= (1+8+28+6+15+48 + 1+8+28)*128 + 93*60 = 143*128 + 5580 = 23,884 uint64_t (~191 KB/block).
#define BLK_WS_STRIDE 24576

__device__ static int dev_gf2_left_nullspace_u32(
    const uint32_t *rows, int nrows, int ncols, m128_t *null_out,
    uint32_t *A, m128_t *I
) {
    for (int r = 0; r < nrows; r++) {
        A[r] = rows[r];
        I[r] = m128_bit(r);
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
            m128_t tI = I[pr]; I[pr] = I[piv]; I[piv] = tI;
        }
        for (int r = 0; r < nrows; r++) {
            if (r != pr && ((A[r] >> c) & 1U)) {
                A[r] ^= A[pr];
                I[r] = m128_xor(I[r], I[pr]);
            }
        }
        pr++;
    }
    int n_null = 0;
    for (int r = pr; r < nrows; r++) null_out[n_null++] = I[r];
    return n_null;
}

__device__ static int dev_gf2_left_nullspace_wide(
    uint64_t *A, int nrows, int n_words, m128_t *null_out, m128_t *I
) {
    for (int r = 0; r < nrows; r++) I[r] = m128_bit(r);
    int pr = 0;
    for (int w = 0; w < n_words && pr < nrows; w++) {
        for (int b = 0; b < 64 && pr < nrows; b++) {
            uint64_t bit = 1ULL << b;
            int piv = -1;
            for (int r = pr; r < nrows; r++) {
                if (A[r * n_words + w] & bit) { piv = r; break; }
            }
            if (piv < 0) continue;
            if (piv != pr) {
                for (int k = w; k < n_words; k++) {
                    uint64_t tmp = A[pr * n_words + k];
                    A[pr * n_words + k] = A[piv * n_words + k];
                    A[piv * n_words + k] = tmp;
                }
                m128_t tI = I[pr]; I[pr] = I[piv]; I[piv] = tI;
            }
            for (int r = 0; r < nrows; r++) {
                if (r != pr && (A[r * n_words + w] & bit)) {
                    for (int k = w; k < n_words; k++) A[r * n_words + k] ^= A[pr * n_words + k];
                    I[r] = m128_xor(I[r], I[pr]);
                }
            }
            pr++;
        }
    }
    int n_null = 0;
    for (int r = pr; r < nrows; r++) null_out[n_null++] = I[r];
    return n_null;
}

__global__ void fes_l4_strip_kernel(
    uint64_t start_strip_idx, int n_strips,
    int d1, int m, int nW, int nt1, int n_core, int rK_init, int n_kr, int rK_1, int M_all,
    const uint32_t * __restrict__ d_Mk_c,        // (nW * n_core)
    const uint32_t * __restrict__ d_Mu_opt_keep, // (d1 * n_core)
    const int      * __restrict__ d_pair_idx,    // (M_all * M_all)
    const int      * __restrict__ d_tri_idx,     // (M_all * M_all * M_all)
    const uint64_t * __restrict__ d_G0,          // (n_core)
    const uint64_t * __restrict__ d_G1,          // (M_all * n_core)
    const uint64_t * __restrict__ d_G2,          // (n_pairs * n_core)
    const uint64_t * __restrict__ d_G3,          // (n_tris * n_core)
    uint64_t       * __restrict__ d_ws_all,      // (gridDim.x * BLK_WS_STRIDE)
    int64_t plant_fiber_idx, uint64_t plant_delta_lo, uint64_t plant_delta_hi,
    CandRec  * __restrict__ d_cands, int max_cands, int * __restrict__ d_cand_count,
    uint64_t * __restrict__ d_deg_fibs, int max_deg, int * __restrict__ d_deg_count
) {
    // Shared memory for per-fiber linear algebra (~14 KB total)
    __shared__ uint32_t s_M0_f[MAX_CORE];
    __shared__ uint32_t s_M0_1[MAX_CORE];
    __shared__ uint32_t s_Mu_1[16 * MAX_CORE];
    __shared__ uint32_t s_tmp_u32[MAX_CORE];
    __shared__ m128_t   s_tmp_I[MAX_CORE];
    __shared__ m128_t   s_L_kr[MAX_CORE];
    __shared__ m128_t   s_V0[MAX_CORE];
    __shared__ uint64_t s_H_mu[MAX_CORE * 8]; // d1 <= 14, rK_1 <= 31 -> <= 434 bits <= 7 u64s!
    __shared__ m128_t   s_P_fiber[MAX_K];
    __shared__ uint32_t s_Cm0[MAX_FAST];
    __shared__ uint32_t s_Cmk[16 * MAX_FAST];
    __shared__ uint32_t s_M0_rem[MAX_FAST];
    __shared__ uint32_t s_Mk_rem[16 * MAX_FAST];
    __shared__ int      s_meta[6]; // [0]=r_elim, [1]=n_fast, [2]=rK_rem, [3]=K, [4]=is_deg, [5]=mR_1
    __shared__ int      s_hi_bits[32];
    __shared__ int      s_n_hi;
    __shared__ uint8_t  s_w_hi[64];

    int tid = threadIdx.x; // 0..255
    int strip_local = blockIdx.x;
    if (strip_local >= n_strips) return;

    uint64_t strip_global = start_strip_idx + (uint64_t)strip_local;
    uint64_t t_hi_mask = strip_global; // bits 0..nt1-STRIP_BITS-1 correspond to T1[STRIP_BITS..nt1-1]

    // Slice per-block workspace in global memory
    uint64_t *ws = d_ws_all + (size_t)strip_local * BLK_WS_STRIDE;
    int n_u2 = m * (m - 1) / 2;
    int n_u3 = m * (m - 1) * (m - 2) / 6;
    int n_t2 = STRIP_BITS * (STRIP_BITS - 1) / 2; // 15
    uint64_t *base_a0 = ws;
    uint64_t *base_a1 = base_a0 + n_core;
    uint64_t *base_a2 = base_a1 + m * n_core;
    uint64_t *base_t1 = base_a2 + n_u2 * n_core;
    uint64_t *base_t2 = base_t1 + STRIP_BITS * n_core;
    uint64_t *base_ut = base_t2 + n_t2 * n_core;
    uint64_t *cur_a0  = base_ut + m * STRIP_BITS * n_core;
    uint64_t *cur_a1  = cur_a0  + n_core;
    uint64_t *cur_a2  = cur_a1  + m * n_core;
    uint64_t *g_ap    = cur_a2  + n_u2 * n_core; // [n_mon * MAX_K]

    // Step 0: Collect set bits of t_hi_mask (as global indices in 0..M_all-1) and w_hi[0..nW-1]
    if (tid == 0) {
        int nh = 0;
        for (int w = 0; w < nW; w++) s_w_hi[w] = 0;
        for (int p = STRIP_BITS; p < nt1; p++) {
            if ((t_hi_mask >> (p - STRIP_BITS)) & 1ULL) {
                s_hi_bits[nh++] = m + p;
                for (int w = 0; w < nW; w++) s_w_hi[w] ^= c_T1[p * 64 + w];
            }
        }
        s_n_hi = nh;
    }
    __syncthreads();

    int nh = s_n_hi;
    // Step 1: Precompute strip base ANF for t_hi in parallel across 256 threads!
    // Each thread handles a subset of c in 0..n_core-1
    for (int c = tid; c < n_core; c += 256) {
        // base_a0[c] = f(t_hi, 0)
        uint64_t a0 = d_G0[c];
        for (int x = 0; x < nh; x++) {
            int gx = s_hi_bits[x];
            a0 ^= d_G1[(size_t)gx * n_core + c];
            for (int y = x + 1; y < nh; y++) {
                int gy = s_hi_bits[y];
                a0 ^= d_G2[(size_t)d_pair_idx[gx * M_all + gy] * n_core + c];
                for (int z = y + 1; z < nh; z++) {
                    int gz = s_hi_bits[z];
                    a0 ^= d_G3[(size_t)d_tri_idx[(gx * M_all + gy) * M_all + gz] * n_core + c];
                }
            }
        }
        base_a0[c] = a0;

        // base_a1[i][c] for i in 0..m-1
        for (int i = 0; i < m; i++) {
            uint64_t v = d_G1[(size_t)i * n_core + c];
            for (int x = 0; x < nh; x++) {
                int gx = s_hi_bits[x];
                v ^= d_G2[(size_t)d_pair_idx[i * M_all + gx] * n_core + c];
                for (int y = x + 1; y < nh; y++) {
                    int gy = s_hi_bits[y];
                    v ^= d_G3[(size_t)d_tri_idx[(i * M_all + gx) * M_all + gy] * n_core + c];
                }
            }
            base_a1[i * n_core + c] = v;
        }

        // base_a2[pair(i,j)][c] for 0 <= i < j < m
        int p_u2 = 0;
        for (int i = 0; i < m; i++) {
            for (int j = i + 1; j < m; j++) {
                uint64_t v = d_G2[(size_t)d_pair_idx[i * M_all + j] * n_core + c];
                for (int x = 0; x < nh; x++) {
                    int gx = s_hi_bits[x];
                    v ^= d_G3[(size_t)d_tri_idx[(i * M_all + j) * M_all + gx] * n_core + c];
                }
                base_a2[p_u2 * n_core + c] = v;
                p_u2++;
            }
        }

        // base_t1[p][c] for p in 0..STRIP_BITS-1 (global idx = m + p)
        for (int p = 0; p < STRIP_BITS; p++) {
            int gp = m + p;
            uint64_t v = d_G1[(size_t)gp * n_core + c];
            for (int x = 0; x < nh; x++) {
                int gx = s_hi_bits[x];
                v ^= d_G2[(size_t)d_pair_idx[gp * M_all + gx] * n_core + c];
                for (int y = x + 1; y < nh; y++) {
                    int gy = s_hi_bits[y];
                    v ^= d_G3[(size_t)d_tri_idx[(gp * M_all + gx) * M_all + gy] * n_core + c];
                }
            }
            base_t1[p * n_core + c] = v;
        }

        // base_t2[pair(p,q)][c] for 0 <= p < q < STRIP_BITS
        int p_t2 = 0;
        for (int p = 0; p < STRIP_BITS; p++) {
            int gp = m + p;
            for (int q = p + 1; q < STRIP_BITS; q++) {
                int gq = m + q;
                uint64_t v = d_G2[(size_t)d_pair_idx[gp * M_all + gq] * n_core + c];
                for (int x = 0; x < nh; x++) {
                    int gx = s_hi_bits[x];
                    v ^= d_G3[(size_t)d_tri_idx[(gp * M_all + gq) * M_all + gx] * n_core + c];
                }
                base_t2[p_t2 * n_core + c] = v;
                p_t2++;
            }
        }

        // base_ut[i][p][c] for i in 0..m-1, p in 0..STRIP_BITS-1
        for (int i = 0; i < m; i++) {
            for (int p = 0; p < STRIP_BITS; p++) {
                int gp = m + p;
                uint64_t v = d_G2[(size_t)d_pair_idx[i * M_all + gp] * n_core + c];
                for (int x = 0; x < nh; x++) {
                    int gx = s_hi_bits[x];
                    v ^= d_G3[(size_t)d_tri_idx[(i * M_all + gp) * M_all + gx] * n_core + c];
                }
                base_ut[(i * STRIP_BITS + p) * n_core + c] = v;
            }
        }
    }
    __syncthreads();

    int n_mon = 1 + m + n_u2 + n_u3;
    int n_u_hi = 1 << m;

    // Step 2: Loop over all 64 fibers t_lo in this strip!
    for (int t_lo = 0; t_lo < STRIP_LEN; t_lo++) {
        uint64_t fiber_idx = (strip_global << STRIP_BITS) | (uint64_t)t_lo;

        // 2A. Thread 0 runs exact Round-1 GF(2) reduction (L_kr + V0 + E_mat) for this fiber
        if (tid == 0) {
            uint8_t w_shift[64];
            for (int w = 0; w < nW; w++) {
                uint8_t v = s_w_hi[w];
                for (int p = 0; p < STRIP_BITS; p++) {
                    if ((t_lo >> p) & 1) v ^= c_T1[p * 64 + w];
                }
                w_shift[w] = v;
            }

            for (int r = 0; r < n_core; r++) s_M0_f[r] = c_M0_c[r];
            for (int w = 0; w < nW; w++) {
                if (w_shift[w]) {
                    const uint32_t *mkw = d_Mk_c + w * n_core;
                    for (int r = 0; r < n_core; r++) s_M0_f[r] ^= mkw[r];
                }
            }

            int mR_1 = 0;
            if (n_kr > 0) {
                uint32_t M0_KR[MAX_CORE];
                for (int r = 0; r < n_core; r++) {
                    uint32_t row = 0;
                    for (int j = 0; j < n_kr; j++) {
                        if (__popc(s_M0_f[r] & c_KR[j]) & 1) row |= (1U << j);
                    }
                    M0_KR[r] = row;
                }
                mR_1 = dev_gf2_left_nullspace_u32(M0_KR, n_core, n_kr, s_L_kr, s_tmp_u32, s_tmp_I);
            } else {
                mR_1 = n_core;
                for (int r = 0; r < n_core; r++) s_L_kr[r] = m128_bit(r);
            }

            uint32_t M0_f_keep[MAX_CORE];
            for (int r = 0; r < n_core; r++) {
                uint32_t v = 0, src = s_M0_f[r];
                for (int c = 0; c < rK_1; c++) {
                    if ((src >> c_keep_c_kr[c]) & 1U) v |= (1U << c);
                }
                M0_f_keep[r] = v;
            }

            for (int r = 0; r < mR_1; r++) {
                m128_t lm = s_L_kr[r];
                uint32_t v0 = 0;
                uint64_t tlo = lm.lo, thi = lm.hi;
                while (tlo) { int j = __ffsll(tlo) - 1; v0 ^= M0_f_keep[j]; tlo &= tlo - 1; }
                while (thi) { int j = 64 + __ffsll(thi) - 1; v0 ^= M0_f_keep[j]; thi &= thi - 1; }
                s_M0_1[r] = v0;
                for (int a = 0; a < d1; a++) {
                    uint32_t va = 0;
                    const uint32_t *mua = d_Mu_opt_keep + a * n_core;
                    tlo = lm.lo; thi = lm.hi;
                    while (tlo) { int j = __ffsll(tlo) - 1; va ^= mua[j]; tlo &= tlo - 1; }
                    while (thi) { int j = 64 + __ffsll(thi) - 1; va ^= mua[j]; thi &= thi - 1; }
                    s_Mu_1[a * mR_1 + r] = va;
                }
            }

            int total_cols = d1 * rK_1;
            int n_words_v0 = (total_cols + 63) / 64;
            for (int i = 0; i < mR_1 * n_words_v0; i++) s_H_mu[i] = 0ULL;
            for (int r = 0; r < mR_1; r++) {
                int col_off = 0;
                for (int a = 0; a < d1; a++) {
                    uint32_t val = s_Mu_1[a * mR_1 + r];
                    while (val) {
                        int c = __ffs(val) - 1;
                        int gcol = col_off + c;
                        s_H_mu[r * n_words_v0 + (gcol >> 6)] |= (1ULL << (gcol & 63));
                        val &= val - 1;
                    }
                    col_off += rK_1;
                }
            }
            int n_v0 = dev_gf2_left_nullspace_wide(s_H_mu, mR_1, n_words_v0, s_V0, s_tmp_I);

            uint32_t VM[MAX_CORE];
            m128_t VE[MAX_CORE];
            for (int i = 0; i < n_v0; i++) {
                m128_t vm = s_V0[i];
                uint32_t acc = 0;
                uint64_t tlo = vm.lo, thi = vm.hi;
                while (tlo) { int r = __ffsll(tlo) - 1; acc ^= s_M0_1[r]; tlo &= tlo - 1; }
                while (thi) { int r = 64 + __ffsll(thi) - 1; acc ^= s_M0_1[r]; thi &= thi - 1; }
                VM[i] = acc;
                VE[i] = vm;
            }
            int piv_v0[32], is_piv[32];
            for (int c = 0; c < 32; c++) is_piv[c] = 0;
            int r_elim = 0;
            for (int c = 0; c < rK_1 && r_elim < n_v0; c++) {
                int piv = -1;
                for (int i = r_elim; i < n_v0; i++) {
                    if ((VM[i] >> c) & 1U) { piv = i; break; }
                }
                if (piv < 0) continue;
                if (piv != r_elim) {
                    uint32_t t1 = VM[r_elim]; VM[r_elim] = VM[piv]; VM[piv] = t1;
                    m128_t t2 = VE[r_elim]; VE[r_elim] = VE[piv]; VE[piv] = t2;
                }
                for (int i = 0; i < n_v0; i++) {
                    if (i != r_elim && ((VM[i] >> c) & 1U)) {
                        VM[i] ^= VM[r_elim];
                        VE[i] = m128_xor(VE[i], VE[r_elim]);
                    }
                }
                piv_v0[r_elim] = c;
                is_piv[c] = 1;
                r_elim++;
            }
            int keep_c[32], rK_rem = 0;
            for (int c = 0; c < rK_1; c++) if (!is_piv[c]) keep_c[rK_rem++] = c;

            if (rK_rem > 6) {
                s_meta[4] = 1; // degenerate -> log to CPU fallback!
                int slot = atomicAdd(d_deg_count, 1);
                if (slot < max_deg) d_deg_fibs[slot] = fiber_idx;
            } else {
                s_meta[4] = 0;
                // Select n_fast <= MAX_FAST rows linearly independent of V0
                uint8_t is_v0_piv[MAX_CORE];
                for (int c = 0; c < mR_1; c++) is_v0_piv[c] = 0;
                for (int i = 0; i < n_v0; i++) s_tmp_I[i] = s_V0[i];
                int vr = 0;
                for (int c = 0; c < mR_1 && vr < n_v0; c++) {
                    int piv = -1;
                    for (int i = vr; i < n_v0; i++) {
                        int bit = (c < 64) ? (int)((s_tmp_I[i].lo >> c) & 1ULL) : (int)((s_tmp_I[i].hi >> (c - 64)) & 1ULL);
                        if (bit) { piv = i; break; }
                    }
                    if (piv < 0) continue;
                    if (piv != vr) { m128_t t = s_tmp_I[vr]; s_tmp_I[vr] = s_tmp_I[piv]; s_tmp_I[piv] = t; }
                    for (int i = vr + 1; i < n_v0; i++) {
                        int bit = (c < 64) ? (int)((s_tmp_I[i].lo >> c) & 1ULL) : (int)((s_tmp_I[i].hi >> (c - 64)) & 1ULL);
                        if (bit) s_tmp_I[i] = m128_xor(s_tmp_I[i], s_tmp_I[vr]);
                    }
                    is_v0_piv[c] = 1;
                    vr++;
                }
                int fast_rows[MAX_FAST], n_fast = 0;
                for (int r = 0; r < mR_1 && n_fast < MAX_FAST; r++) if (!is_v0_piv[r]) fast_rows[n_fast++] = r;
                for (int r = 0; r < mR_1 && n_fast < MAX_FAST; r++) if (is_v0_piv[r]) fast_rows[n_fast++] = r;

                int K = r_elim + n_fast;
                for (int e = 0; e < r_elim; e++) {
                    m128_t acc = m128_zero(), em = VE[e];
                    uint64_t tlo = em.lo, thi = em.hi;
                    while (tlo) { int r = __ffsll(tlo) - 1; acc = m128_xor(acc, s_L_kr[r]); tlo &= tlo - 1; }
                    while (thi) { int r = 64 + __ffsll(thi) - 1; acc = m128_xor(acc, s_L_kr[r]); thi &= thi - 1; }
                    s_P_fiber[e] = acc;
                }
                for (int fi = 0; fi < n_fast; fi++) s_P_fiber[r_elim + fi] = s_L_kr[fast_rows[fi]];

                uint32_t EM0_keep[32];
                for (int e = 0; e < r_elim; e++) {
                    uint32_t v = 0, src = VM[e];
                    for (int c = 0; c < rK_rem; c++) if ((src >> keep_c[c]) & 1U) v |= (1U << c);
                    EM0_keep[e] = v;
                }
                for (int fi = 0; fi < n_fast; fi++) {
                    int r = fast_rows[fi];
                    uint32_t cm0 = 0, m0k = 0;
                    for (int e = 0; e < r_elim; e++) {
                        if ((s_M0_1[r] >> piv_v0[e]) & 1U) { cm0 |= (1U << e); m0k ^= EM0_keep[e]; }
                    }
                    for (int c = 0; c < rK_rem; c++) if ((s_M0_1[r] >> keep_c[c]) & 1U) m0k ^= (1U << c);
                    s_Cm0[fi] = cm0;
                    s_M0_rem[fi] = m0k;
                    for (int a = 0; a < d1; a++) {
                        uint32_t mu_ar = s_Mu_1[a * mR_1 + r];
                        uint32_t cma = 0, mka = 0;
                        for (int e = 0; e < r_elim; e++) {
                            if ((mu_ar >> piv_v0[e]) & 1U) { cma |= (1U << e); mka ^= EM0_keep[e]; }
                        }
                        for (int c = 0; c < rK_rem; c++) if ((mu_ar >> keep_c[c]) & 1U) mka ^= (1U << c);
                        s_Cmk[a * MAX_FAST + fi] = cma;
                        s_Mk_rem[a * MAX_FAST + fi] = mka;
                    }
                }
                s_meta[0] = r_elim;
                s_meta[1] = n_fast;
                s_meta[2] = rK_rem;
                s_meta[3] = K;
                s_meta[5] = mR_1;
            }
        }
        __syncthreads();
        if (s_meta[4] != 0) continue; // degenerate fiber already logged to CPU!

        int r_elim = s_meta[0];
        int n_fast = s_meta[1];
        int rK_rem = s_meta[2];
        int K      = s_meta[3];

        // 2B. All 256 threads compute cur_a0, cur_a1, cur_a2 for this t_lo (popcount <= 6)!
        int lo_bits[STRIP_BITS], nlo = 0;
        for (int p = 0; p < STRIP_BITS; p++) if ((t_lo >> p) & 1) lo_bits[nlo++] = p;

        for (int c = tid; c < n_core; c += 256) {
            uint64_t a0 = base_a0[c];
            for (int x = 0; x < nlo; x++) {
                int px = lo_bits[x];
                a0 ^= base_t1[px * n_core + c];
                for (int y = x + 1; y < nlo; y++) {
                    int py = lo_bits[y];
                    int pt2 = px * (2 * STRIP_BITS - px - 1) / 2 + (py - px - 1);
                    a0 ^= base_t2[pt2 * n_core + c];
                    for (int z = y + 1; z < nlo; z++) {
                        int pz = lo_bits[z];
                        a0 ^= d_G3[(size_t)d_tri_idx[((m + px) * M_all + (m + py)) * M_all + (m + pz)] * n_core + c];
                    }
                }
            }
            cur_a0[c] = a0;

            for (int i = 0; i < m; i++) {
                uint64_t v = base_a1[i * n_core + c];
                for (int x = 0; x < nlo; x++) {
                    int px = lo_bits[x];
                    v ^= base_ut[(i * STRIP_BITS + px) * n_core + c];
                    for (int y = x + 1; y < nlo; y++) {
                        int py = lo_bits[y];
                        v ^= d_G3[(size_t)d_tri_idx[(i * M_all + (m + px)) * M_all + (m + py)] * n_core + c];
                    }
                }
                cur_a1[i * n_core + c] = v;
            }

            int p_u2 = 0;
            for (int i = 0; i < m; i++) {
                for (int j = i + 1; j < m; j++) {
                    uint64_t v = base_a2[p_u2 * n_core + c];
                    for (int x = 0; x < nlo; x++) {
                        int px = lo_bits[x];
                        v ^= d_G3[(size_t)d_tri_idx[(i * M_all + j) * M_all + (m + px)] * n_core + c];
                    }
                    cur_a2[p_u2 * n_core + c] = v;
                    p_u2++;
                }
            }
        }
        __syncthreads();

        // 2C. Project P_fiber (K rows) onto all n_mon monomials in parallel across 256 threads!
        m128_t p_delta = m128_zero();
        if (plant_fiber_idx >= 0 && (int64_t)fiber_idx == plant_fiber_idx) {
            p_delta.lo = plant_delta_lo;
            p_delta.hi = plant_delta_hi;
        }
        int total_proj = n_mon * K;
        for (int idx = tid; idx < total_proj; idx += 256) {
            int mon = idx / K;
            int k = idx - mon * K;
            m128_t pm = s_P_fiber[k];
            const uint64_t *src = NULL;
            uint64_t acc = 0ULL;
            if (mon == 0) {
                src = cur_a0;
                if (m128_parity_and(pm, p_delta)) acc = ~0ULL;
            } else if (mon <= m) {
                src = cur_a1 + (mon - 1) * n_core;
            } else if (mon <= m + n_u2) {
                src = cur_a2 + (mon - 1 - m) * n_core;
            } else {
                // mon in 1+m+n_u2 .. n_mon-1 -> triple index in 0..n_u3-1
                // Note: since u_hi indices are 0..m-1, triples (i<j<l<m) in d_G3 are stored in order!
                // We decode (i,j,l) via compact loop (n_u3 <= 56) or pre-indexed d_tri_idx:
                int t_ord = mon - (1 + m + n_u2);
                int ti = 0, tj = 1, tl = 2, cnt = 0;
                bool found = false;
                for (int i = 0; i < m && !found; i++) {
                    for (int j = i + 1; j < m && !found; j++) {
                        int rem = m - j - 1;
                        if (t_ord < cnt + rem) {
                            ti = i; tj = j; tl = j + 1 + (t_ord - cnt);
                            found = true;
                        } else {
                            cnt += rem;
                        }
                    }
                }
                src = d_G3 + (size_t)d_tri_idx[(ti * M_all + tj) * M_all + tl] * n_core;
            }
            uint64_t tlo = pm.lo, thi = pm.hi;
            while (tlo) { int j = __ffsll(tlo) - 1; acc ^= src[j]; tlo &= tlo - 1; }
            while (thi) { int j = 64 + __ffsll(thi) - 1; acc ^= src[j]; thi &= thi - 1; }
            g_ap[mon * MAX_K + k] = acc;
        }
        __syncthreads();

        // 2D. ALL 256 threads simultaneously evaluate u_hi = tid (64 points/thread -> 16,384 pts in 1 pass!)
        if (tid < n_u_hi) {
            int u_bits[MAX_M], nu = 0;
            for (int b = 0; b < m; b++) if ((tid >> b) & 1) u_bits[nu++] = b;

            // Collect active monomial indices for this u_hi (avg ~15 entries)
            int act_mon[93], n_act = 0;
            act_mon[n_act++] = 0;
            for (int x = 0; x < nu; x++) {
                int bx = u_bits[x];
                act_mon[n_act++] = 1 + bx;
                for (int y = x + 1; y < nu; y++) {
                    int by = u_bits[y];
                    int p2 = bx * (2 * m - bx - 1) / 2 + (by - bx - 1);
                    act_mon[n_act++] = 1 + m + p2;
                    for (int z = y + 1; z < nu; z++) {
                        int bz = u_bits[z];
                        // rank of (bx, by, bz) among 0 <= i < j < l < m
                        int t3 = 0;
                        for (int i = 0; i < bx; i++) t3 += (m - 1 - i) * (m - 2 - i) / 2;
                        for (int j = bx + 1; j < by; j++) t3 += (m - 1 - j);
                        t3 += (bz - by - 1);
                        act_mon[n_act++] = 1 + m + n_u2 + t3;
                    }
                }
            }

            uint64_t Eb[32];
            for (int e = 0; e < r_elim; e++) {
                uint64_t v = 0ULL;
                for (int q = 0; q < n_act; q++) v ^= g_ap[act_mon[q] * MAX_K + e];
                Eb[e] = v;
            }

            uint64_t b_new[MAX_FAST];
            uint64_t Mrem[MAX_FAST][6];
            for (int r = 0; r < n_fast; r++) {
                uint64_t v = 0ULL;
                for (int q = 0; q < n_act; q++) v ^= g_ap[act_mon[q] * MAX_K + (r_elim + r)];

                // Add Cmk_cur[r][e] & Eb[e]
                uint32_t cm_const = s_Cm0[r];
                for (int x = 0; x < nu; x++) cm_const ^= s_Cmk[(6 + u_bits[x]) * MAX_FAST + r];
                for (int e = 0; e < r_elim; e++) {
                    uint64_t ce = ((cm_const >> e) & 1U) ? ~0ULL : 0ULL;
                    for (int a = 0; a < 6; a++) {
                        if ((s_Cmk[a * MAX_FAST + r] >> e) & 1U) ce ^= c_LANE_U64[a];
                    }
                    v ^= (ce & Eb[e]);
                }
                b_new[r] = v;

                // Build Mrem[r][c] for c in 0..rK_rem-1
                uint32_t mr_const = s_M0_rem[r];
                for (int x = 0; x < nu; x++) mr_const ^= s_Mk_rem[(6 + u_bits[x]) * MAX_FAST + r];
                for (int c = 0; c < rK_rem; c++) {
                    uint64_t mc = ((mr_const >> c) & 1U) ? ~0ULL : 0ULL;
                    for (int a = 0; a < 6; a++) {
                        if ((s_Mk_rem[a * MAX_FAST + r] >> c) & 1U) mc ^= c_LANE_U64[a];
                    }
                    Mrem[r][c] = mc;
                }
            }

            // Sweep all 2^{rK_rem} values of r_rem in Gray code!
            uint64_t eq_cur[MAX_FAST];
            for (int r = 0; r < n_fast; r++) eq_cur[r] = b_new[r];
            int n_r = 1 << rK_rem;
            uint64_t any_surv = 0ULL;
            for (int rv = 0; rv < n_r; rv++) {
                if (rv > 0) {
                    int bc = __ffs(rv) - 1;
                    for (int r = 0; r < n_fast; r++) eq_cur[r] ^= Mrem[r][bc];
                }
                uint64_t ok = ~0ULL;
                for (int r = 0; r < n_fast; r++) {
                    ok &= ~eq_cur[r];
                    if (!ok) break;
                }
                any_surv |= ok;
            }
            if (any_surv != 0ULL) {
                int slot = atomicAdd(d_cand_count, 1);
                if (slot < max_cands) {
                    d_cands[slot].fiber_idx = fiber_idx;
                    d_cands[slot].mask64 = any_surv;
                    d_cands[slot].u_hi = (uint32_t)tid;
                    d_cands[slot].pad = 0;
                }
            }
        }
        __syncthreads();
    }
}

struct GpuCtx {
    int d1, m, nW, nt1, n_core, rK_init, n_kr, rK_1, M_all;
    int max_strips_batch, max_cands, max_deg;
    uint32_t *d_Mk_c, *d_Mu_opt_keep;
    int *d_pair_idx, *d_tri_idx;
    uint64_t *d_G0, *d_G1, *d_G2, *d_G3, *d_ws_all;
    CandRec *d_cands;
    int *d_cand_count;
    uint64_t *d_deg_fibs;
    int *d_deg_count;
};

#define CUDA_CHECK(call) do { \
    cudaError_t err = (call); \
    if (err != cudaSuccess) { \
        fprintf(stderr, "CUDA error %s:%d: %s\n", __FILE__, __LINE__, cudaGetErrorString(err)); \
        return NULL; \
    } \
} while (0)

#define CUDA_CHECK_INT(call) do { \
    cudaError_t err = (call); \
    if (err != cudaSuccess) { \
        fprintf(stderr, "CUDA error %s:%d: %s\n", __FILE__, __LINE__, cudaGetErrorString(err)); \
        return -1; \
    } \
} while (0)

extern "C" void* gpu_init(
    int d1, int m, int nW, int nt1, int n_core, int rK_init, int n_kr, int rK_1, int M_all,
    int n_pairs, int n_tris, int max_strips_batch, int max_cands, int max_deg,
    const uint8_t *U1, const uint8_t *T1,
    const uint32_t *M0_c, const uint32_t *Mk_c, const uint32_t *KR, const int *keep_c_kr,
    const uint32_t *Mu_opt_keep, const int *pair_idx, const int *tri_idx,
    const uint64_t *G0, const uint64_t *G1, const uint64_t *G2, const uint64_t *G3
) {
    GpuCtx *ctx = (GpuCtx *)calloc(1, sizeof(GpuCtx));
    ctx->d1 = d1; ctx->m = m; ctx->nW = nW; ctx->nt1 = nt1;
    ctx->n_core = n_core; ctx->rK_init = rK_init; ctx->n_kr = n_kr;
    ctx->rK_1 = rK_1; ctx->M_all = M_all;
    ctx->max_strips_batch = max_strips_batch;
    ctx->max_cands = max_cands;
    ctx->max_deg = max_deg;

    uint64_t lane64[6];
    for (int a = 0; a < 6; a++) {
        uint64_t v = 0ULL;
        for (int l = 0; l < 64; l++) if ((l >> a) & 1) v |= (1ULL << l);
        lane64[a] = v;
    }
    uint8_t u1_pad[16 * 64] = {0};
    for (int a = 0; a < d1; a++) for (int w = 0; w < nW; w++) u1_pad[a * 64 + w] = U1[a * nW + w];
    uint8_t t1_pad[36 * 64] = {0};
    for (int p = 0; p < nt1; p++) for (int w = 0; w < nW; w++) t1_pad[p * 64 + w] = T1[p * nW + w];

    CUDA_CHECK(cudaMemcpyToSymbol(c_LANE_U64, lane64, sizeof(lane64)));
    CUDA_CHECK(cudaMemcpyToSymbol(c_U1, u1_pad, sizeof(u1_pad)));
    CUDA_CHECK(cudaMemcpyToSymbol(c_T1, t1_pad, sizeof(t1_pad)));
    CUDA_CHECK(cudaMemcpyToSymbol(c_M0_c, M0_c, (size_t)n_core * sizeof(uint32_t)));
    if (n_kr > 0) CUDA_CHECK(cudaMemcpyToSymbol(c_KR, KR, (size_t)n_kr * sizeof(uint32_t)));
    CUDA_CHECK(cudaMemcpyToSymbol(c_keep_c_kr, keep_c_kr, (size_t)rK_1 * sizeof(int)));

    CUDA_CHECK(cudaMalloc(&ctx->d_Mk_c, (size_t)nW * n_core * sizeof(uint32_t)));
    CUDA_CHECK(cudaMemcpy(ctx->d_Mk_c, Mk_c, (size_t)nW * n_core * sizeof(uint32_t), cudaMemcpyHostToDevice));
    CUDA_CHECK(cudaMalloc(&ctx->d_Mu_opt_keep, (size_t)d1 * n_core * sizeof(uint32_t)));
    CUDA_CHECK(cudaMemcpy(ctx->d_Mu_opt_keep, Mu_opt_keep, (size_t)d1 * n_core * sizeof(uint32_t), cudaMemcpyHostToDevice));
    CUDA_CHECK(cudaMalloc(&ctx->d_pair_idx, (size_t)M_all * M_all * sizeof(int)));
    CUDA_CHECK(cudaMemcpy(ctx->d_pair_idx, pair_idx, (size_t)M_all * M_all * sizeof(int), cudaMemcpyHostToDevice));
    CUDA_CHECK(cudaMalloc(&ctx->d_tri_idx, (size_t)M_all * M_all * M_all * sizeof(int)));
    CUDA_CHECK(cudaMemcpy(ctx->d_tri_idx, tri_idx, (size_t)M_all * M_all * M_all * sizeof(int), cudaMemcpyHostToDevice));

    CUDA_CHECK(cudaMalloc(&ctx->d_G0, (size_t)n_core * sizeof(uint64_t)));
    CUDA_CHECK(cudaMemcpy(ctx->d_G0, G0, (size_t)n_core * sizeof(uint64_t), cudaMemcpyHostToDevice));
    CUDA_CHECK(cudaMalloc(&ctx->d_G1, (size_t)M_all * n_core * sizeof(uint64_t)));
    CUDA_CHECK(cudaMemcpy(ctx->d_G1, G1, (size_t)M_all * n_core * sizeof(uint64_t), cudaMemcpyHostToDevice));
    CUDA_CHECK(cudaMalloc(&ctx->d_G2, (size_t)n_pairs * n_core * sizeof(uint64_t)));
    CUDA_CHECK(cudaMemcpy(ctx->d_G2, G2, (size_t)n_pairs * n_core * sizeof(uint64_t), cudaMemcpyHostToDevice));
    CUDA_CHECK(cudaMalloc(&ctx->d_G3, (size_t)n_tris * n_core * sizeof(uint64_t)));
    CUDA_CHECK(cudaMemcpy(ctx->d_G3, G3, (size_t)n_tris * n_core * sizeof(uint64_t), cudaMemcpyHostToDevice));

    CUDA_CHECK(cudaMalloc(&ctx->d_ws_all, (size_t)max_strips_batch * BLK_WS_STRIDE * sizeof(uint64_t)));
    CUDA_CHECK(cudaMalloc(&ctx->d_cands, (size_t)max_cands * sizeof(CandRec)));
    CUDA_CHECK(cudaMalloc(&ctx->d_cand_count, sizeof(int)));
    CUDA_CHECK(cudaMalloc(&ctx->d_deg_fibs, (size_t)max_deg * sizeof(uint64_t)));
    CUDA_CHECK(cudaMalloc(&ctx->d_deg_count, sizeof(int)));
    return ctx;
}

extern "C" int gpu_run_strips(
    void *vctx, uint64_t start_strip_idx, int n_strips,
    int64_t plant_fiber_idx, uint64_t plant_delta_lo, uint64_t plant_delta_hi,
    CandRec *h_cands, int *h_cand_count_out,
    uint64_t *h_deg_fibs, int *h_deg_count_out
) {
    GpuCtx *ctx = (GpuCtx *)vctx;
    int zero = 0;
    CUDA_CHECK_INT(cudaMemcpy(ctx->d_cand_count, &zero, sizeof(int), cudaMemcpyHostToDevice));
    CUDA_CHECK_INT(cudaMemcpy(ctx->d_deg_count, &zero, sizeof(int), cudaMemcpyHostToDevice));

    fes_l4_strip_kernel<<<n_strips, 256>>>(
        start_strip_idx, n_strips,
        ctx->d1, ctx->m, ctx->nW, ctx->nt1, ctx->n_core, ctx->rK_init, ctx->n_kr, ctx->rK_1, ctx->M_all,
        ctx->d_Mk_c, ctx->d_Mu_opt_keep, ctx->d_pair_idx, ctx->d_tri_idx,
        ctx->d_G0, ctx->d_G1, ctx->d_G2, ctx->d_G3, ctx->d_ws_all,
        plant_fiber_idx, plant_delta_lo, plant_delta_hi,
        ctx->d_cands, ctx->max_cands, ctx->d_cand_count,
        ctx->d_deg_fibs, ctx->max_deg, ctx->d_deg_count
    );
    CUDA_CHECK_INT(cudaGetLastError());
    CUDA_CHECK_INT(cudaDeviceSynchronize());

    int n_cands = 0, n_deg = 0;
    CUDA_CHECK_INT(cudaMemcpy(&n_cands, ctx->d_cand_count, sizeof(int), cudaMemcpyDeviceToHost));
    CUDA_CHECK_INT(cudaMemcpy(&n_deg, ctx->d_deg_count, sizeof(int), cudaMemcpyDeviceToHost));
    if (n_cands > ctx->max_cands || n_deg > ctx->max_deg) {
        fprintf(stderr, "CRITICAL BUFFER OVERFLOW: n_cands=%d/%d, n_deg=%d/%d\n",
                n_cands, ctx->max_cands, n_deg, ctx->max_deg);
        return -2;
    }
    if (n_cands > 0) {
        CUDA_CHECK_INT(cudaMemcpy(h_cands, ctx->d_cands, (size_t)n_cands * sizeof(CandRec), cudaMemcpyDeviceToHost));
    }
    if (n_deg > 0) {
        CUDA_CHECK_INT(cudaMemcpy(h_deg_fibs, ctx->d_deg_fibs, (size_t)n_deg * sizeof(uint64_t), cudaMemcpyDeviceToHost));
    }
    *h_cand_count_out = n_cands;
    *h_deg_count_out = n_deg;
    return 0;
}

extern "C" void gpu_free(void *vctx) {
    if (!vctx) return;
    GpuCtx *ctx = (GpuCtx *)vctx;
    cudaFree(ctx->d_Mk_c); cudaFree(ctx->d_Mu_opt_keep);
    cudaFree(ctx->d_pair_idx); cudaFree(ctx->d_tri_idx);
    cudaFree(ctx->d_G0); cudaFree(ctx->d_G1); cudaFree(ctx->d_G2); cudaFree(ctx->d_G3);
    cudaFree(ctx->d_ws_all); cudaFree(ctx->d_cands); cudaFree(ctx->d_cand_count);
    cudaFree(ctx->d_deg_fibs); cudaFree(ctx->d_deg_count);
    free(ctx);
}
"""


class CandRec(ctypes.Structure):
    _fields_ = [
        ("fiber_idx", ctypes.c_uint64),
        ("mask64", ctypes.c_uint64),
        ("u_hi", ctypes.c_uint32),
        ("pad", ctypes.c_uint32),
    ]


def detect_gpu_arch():
    try:
        out = subprocess.check_output(
            ["nvidia-smi", "--query-gpu=compute_cap,name", "--format=csv,noheader"],
            text=True, stderr=subprocess.DEVNULL
        ).strip().splitlines()[0]
        cap, name = [x.strip() for x in out.split(",", 1)]
        sm = "sm_" + cap.replace(".", "")
        print(f"  [GPU] Detected {name} (compute_cap={cap} -> {sm})", flush=True)
        return sm, name
    except Exception:
        print("  [GPU] nvidia-smi unavailable; defaulting to sm_89 (L4)", flush=True)
        return "sm_89", "unknown"


def compile_cpu_and_cuda(tag, arch):
    c_path = WORK_DIR / f"{tag}_cpu_helper.c"
    so_cpu = WORK_DIR / f"lib{tag}_cpu_helper.so"
    c_path.write_text(CPU_HELPER_SRC, encoding="utf-8")
    subprocess.run(
        ["gcc", "-O3", "-march=native", "-fopenmp", "-shared", "-fPIC", str(c_path), "-o", str(so_cpu)],
        check=True,
    )
    lib_cpu = ctypes.CDLL(str(so_cpu))
    lib_cpu.build_global_anf_64.argtypes = [
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
    ]
    lib_cpu.verify_candidates_omp.argtypes = [
        ctypes.c_int, ctypes.POINTER(CandRec),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_uint32), ctypes.POINTER(ctypes.c_uint32),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int64, ctypes.c_uint64, ctypes.c_uint64,
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
    ]
    lib_cpu.verify_candidates_omp.restype = ctypes.c_int64
    lib_cpu.close_degenerate_fibers_omp.argtypes = [
        ctypes.c_int, ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_uint32), ctypes.POINTER(ctypes.c_uint32),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int64, ctypes.c_uint64, ctypes.c_uint64,
    ]
    lib_cpu.close_degenerate_fibers_omp.restype = ctypes.c_int64

    cu_path = WORK_DIR / f"{tag}_fes_l4.cu"
    so_gpu = WORK_DIR / f"lib{tag}_fes_l4.so"
    cu_path.write_text(CUDA_KERNEL_SRC, encoding="utf-8")
    nvcc_cmd = ["nvcc", "-O3", f"-arch={arch}", "-Xcompiler", "-fPIC", "-shared", str(cu_path), "-o", str(so_gpu)]
    print("  [CUDA] Compiling:", " ".join(nvcc_cmd), flush=True)
    subprocess.run(nvcc_cmd, check=True)
    lib_gpu = ctypes.CDLL(str(so_gpu))
    lib_gpu.gpu_init.argtypes = [
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_uint32), ctypes.POINTER(ctypes.c_uint32),
        ctypes.POINTER(ctypes.c_uint32), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint32), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
    ]
    lib_gpu.gpu_init.restype = ctypes.c_void_p
    lib_gpu.gpu_run_strips.argtypes = [
        ctypes.c_void_p, ctypes.c_uint64, ctypes.c_int,
        ctypes.c_int64, ctypes.c_uint64, ctypes.c_uint64,
        ctypes.POINTER(CandRec), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
    ]
    lib_gpu.gpu_run_strips.restype = ctypes.c_int
    lib_gpu.gpu_free.argtypes = [ctypes.c_void_p]
    return lib_cpu, lib_gpu


def run_one_rep(rep, root_bundle, lib_cpu, lib_gpu, args, gpu_name):
    t0 = time.perf_counter()
    root1, indep_forms, origin111, k_mask, lib9, lib_sh, _, tbl = root_bundle
    _, sr = pilot.get_rep_state(rep, root1, indep_forms, origin111, k_mask, lib9, tbl)
    dim_sr = 111 - len(sr["_lin_pivs"])
    q_sr = len(sr["_quad_ids"])
    c_sr = len(sr["_cub_ids"])
    print(f"\n==================== [B0_00 K=1 e={rep}] CUDA L4 FES (dim={dim_sr}, q={q_sr}, c={c_sr}) ====================", flush=True)
    assert not sr["closed_unsat"], f"Unexpected direct closure on e={rep}"

    sys_ex = s45b.extract_eta_exact_system(0, sr, [], lib9, lib_sh, tbl, rng_seed=5900 + rep)
    nW, nT = int(sys_ex["nW"]), int(sys_ex["nT"])
    M0_c, Mk_c, L_core = sys_ex["M0_c"], sys_ex["Mk_c"], sys_ex["L_core"]
    n_core, rK_init = int(M0_c.shape[0]), int(M0_c.shape[1])
    assert n_core <= 128 and rK_init <= 31 and nW <= 64 and (nW + nT) <= 96

    # Optimize U1 with d1 <= 14 so m = d1 - 6 <= 8 (256 threads = full 2^d1 inner space in 1 pass!)
    if args.d1 > 0:
        d1 = args.d1
        assert 7 <= d1 <= 14
        U_opt, Mu_opt, bkey = s57b.optimize_u1_basis(M0_c, Mk_c, d1, em_seed=rep)
    else:
        chosen = None
        for d1_try in [14, 13, 12, 11, 10]:
            U_try, Mu_try, bk_try = s57b.optimize_u1_basis(M0_c, Mk_c, d1_try, em_seed=rep)
            rK_rem_try = rK_init - int(bk_try[0])
            print(f"  [U1 scan] d1={d1_try}: r1_elim={bk_try[0]}, V0={bk_try[1]}, KR={bk_try[2]} -> rK_rem={rK_rem_try}", flush=True)
            if rK_rem_try <= 6:
                chosen = (d1_try, U_try, Mu_try, bk_try)
                break
        assert chosen is not None, "No d1 <= 14 achieved rK_rem <= 6"
        d1, U_opt, Mu_opt, bkey = chosen

    m = d1 - 6
    nt1 = nW - d1
    rK_rem_nom = rK_init - int(bkey[0])
    print(f"  [Selected] nW={nW}, nT={nT}, n_core={n_core}, rK_init={rK_init}, d1={d1} (m={m}), nt1={nt1}, rK_rem={rK_rem_nom}", flush=True)

    # Extract C_core tables from sys_ex closure
    fn_b = sys_ex["eval_b_and_p0_batch"]
    cl_b = dict(zip(fn_b.__code__.co_freevars, [c.cell_contents for c in fn_b.__closure__]))
    fn_t = cl_b["eval_t_batch"]
    cl_t = dict(zip(fn_t.__code__.co_freevars, [c.cell_contents for c in fn_t.__closure__]))

    qt_c0 = np.ascontiguousarray(cl_t["qt_c0"], dtype=np.uint8)
    qt_lin = np.ascontiguousarray(cl_t["qt_lin"], dtype=np.uint8)
    qt_q_off, qt_q0, qt_q1 = [0], [], []
    for qp in cl_t["qt_quads"]:
        for a, b in qp:
            qt_q0.append(a); qt_q1.append(b)
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
    for ii, u in enumerate(cl_b["idx1"]): m_deg[u] = 1; m_v0[u] = int(cl_b["a1"][ii])
    for ii, u in enumerate(cl_b["idx2"]): m_deg[u] = 2; m_v0[u] = int(cl_b["a2"][ii]); m_v1[u] = int(cl_b["b2"][ii])
    for ii, u in enumerate(cl_b["idx3"]): m_deg[u] = 3; m_v0[u] = int(cl_b["a3"][ii]); m_v1[u] = int(cl_b["b3"][ii]); m_v2[u] = int(cl_b["c3"][ii])

    C_core = (L_core.astype(np.uint16) @ B_coeff.astype(np.uint16)) & 1
    c0_core = np.ascontiguousarray((L_core.astype(np.uint16) @ b0_const.astype(np.uint16)) & 1, dtype=np.uint8)
    cc_off, cc_cols = [0], []
    for c in range(n_core):
        nz = np.flatnonzero(C_core[c]).tolist()
        cc_cols.extend(nz)
        cc_off.append(len(cc_cols))
    cc_off = np.ascontiguousarray(cc_off, dtype=np.int32)
    cc_cols = np.ascontiguousarray(cc_cols, dtype=np.int32)

    U1 = np.ascontiguousarray(U_opt[:d1], dtype=np.uint8)
    T1 = np.ascontiguousarray(U_opt[d1:], dtype=np.uint8)
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

    # Build global degree-<=3 ANF of C_core in M_all = m + nt1 = nW - 6 variables
    M_all = m + nt1
    B_all = np.ascontiguousarray(np.vstack([U1[6:], T1]), dtype=np.uint8)
    U1_lo6 = np.ascontiguousarray(U1[:6], dtype=np.uint8)

    n_pairs = M_all * (M_all - 1) // 2
    n_tris = M_all * (M_all - 1) * (M_all - 2) // 6
    pair_idx = np.full((M_all, M_all), -1, dtype=np.int32)
    pid = 0
    for a in range(M_all):
        for b in range(a + 1, M_all):
            pair_idx[a, b] = pair_idx[b, a] = pid
            pid += 1
    tri_idx = np.full((M_all, M_all, M_all), -1, dtype=np.int32)
    tid_cnt = 0
    for a in range(M_all):
        for b in range(a + 1, M_all):
            for d in range(b + 1, M_all):
                for x, y, z in ((a,b,d),(a,d,b),(b,a,d),(b,d,a),(d,a,b),(d,b,a)):
                    tri_idx[x, y, z] = tid_cnt
                tid_cnt += 1

    G0 = np.zeros(n_core, dtype=np.uint64)
    G1 = np.zeros((M_all, n_core), dtype=np.uint64)
    G2 = np.zeros((n_pairs, n_core), dtype=np.uint64)
    G3 = np.zeros((n_tris, n_core), dtype=np.uint64)

    t_anf = time.perf_counter()
    lib_cpu.build_global_anf_64(
        nW, nT, n_um, n_core, M_all,
        U1_lo6.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
        B_all.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
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
        pair_idx.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
        tri_idx.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
        G0.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        G1.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        G2.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        G3.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
    )
    print(f"  [ANF] Built global deg<=3 ANF (M_all={M_all}, n_tris={n_tris}, {G3.nbytes/1e6:.2f} MB) in {time.perf_counter()-t_anf:.2f}s", flush=True)

    # Zero-Trust check 1: verify global degree-<=3 ANF matches sys_ex on 100 random W vectors!
    rng_anf = np.random.default_rng(7700 + rep)
    anf_mismatches = 0
    for _ in range(100):
        lo_bits = rng_anf.integers(0, 2, size=6, dtype=np.uint8)
        lane = sum(int(lo_bits[a]) << a for a in range(6))
        hi_bits = rng_anf.integers(0, 2, size=M_all, dtype=np.uint8)
        w_vec = ((lo_bits @ U1_lo6) ^ (hi_bits @ B_all)) & 1
        b_orig, _ = sys_ex["eval_b_and_p0_batch"](w_vec.reshape(1, -1))
        b_ref = (L_core @ b_orig[0]) & 1
        nz = np.flatnonzero(hi_bits).tolist()
        val = G0.copy()
        for x in range(len(nz)):
            gx = nz[x]; val ^= G1[gx]
            for y in range(x + 1, len(nz)):
                gy = nz[y]; val ^= G2[pair_idx[gx, gy]]
                for z in range(y + 1, len(nz)):
                    gz = nz[z]; val ^= G3[tri_idx[gx, gy, gz]]
        b_anf = ((val >> np.uint64(lane)) & np.uint64(1)).astype(np.uint8)
        if not np.array_equal(b_ref, b_anf):
            anf_mismatches += 1
    print(f"  [ANF ZT] 100 random W points vs direct eval: {anf_mismatches} mismatches", flush=True)
    assert anf_mismatches == 0, "CRITICAL: C_core has degree > 3 in W!"

    # Initialize GPU context
    total_strips = 1 << (nt1 - 6)
    max_strips_batch = min(args.batch_blocks, total_strips)
    max_cands = max(262144, max_strips_batch * 64)
    max_deg = max(65536, max_strips_batch * 16)

    gctx = lib_gpu.gpu_init(
        d1, m, nW, nt1, n_core, rK_init, n_kr, rK_1, M_all, n_pairs, n_tris,
        max_strips_batch, max_cands, max_deg,
        U1.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
        T1.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
        M0_c_masks.ctypes.data_as(ctypes.POINTER(ctypes.c_uint32)),
        Mk_c_masks.ctypes.data_as(ctypes.POINTER(ctypes.c_uint32)),
        KR_masks.ctypes.data_as(ctypes.POINTER(ctypes.c_uint32)),
        keep_c_kr.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
        Mu_opt_keep.ctypes.data_as(ctypes.POINTER(ctypes.c_uint32)),
        pair_idx.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
        tri_idx.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
        G0.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        G1.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        G2.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        G3.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
    )
    assert gctx, "gpu_init failed!"

    h_cands = (CandRec * max_cands)()
    h_deg_fibs = (ctypes.c_uint64 * max_deg)()
    h_cand_cnt = ctypes.c_int(0)
    h_deg_cnt = ctypes.c_int(0)
    dummy_surv = (ctypes.c_uint64 * 4)()

    # Zero-Trust check 2: 10/10 GPU->CPU planted-solution audit!
    print("  --- GPU ZERO-TRUST PLANTED-SOLUTION AUDIT (10 trials) ---", flush=True)
    rng_zt = np.random.default_rng(9900 + rep)
    zt_pass = 0
    for trial in range(10):
        f_star = int(rng_zt.integers(0, 1 << nt1))
        strip_star = f_star >> 6
        t_bits = np.array([(f_star >> p) & 1 for p in range(nt1)], dtype=np.uint8)
        u_star = rng_zt.integers(0, 2, size=d1, dtype=np.uint8)
        r_star = rng_zt.integers(0, 2, size=rK_init, dtype=np.uint8)
        w_star = (((t_bits @ T1) ^ (u_star @ U1)) & 1).astype(np.uint8)
        b_orig_s, _ = sys_ex["eval_b_and_p0_batch"](w_star.reshape(1, -1))
        b_core_s = (L_core @ b_orig_s[0]) & 1
        M_s = M0_c.copy()
        for w in range(nW):
            if w_star[w]: M_s ^= Mk_c[w]
        delta_core = (b_core_s ^ ((M_s @ r_star) & 1)) & 1
        d_lo = sum(int(delta_core[c]) << c for c in range(min(64, n_core)))
        d_hi = sum(int(delta_core[c]) << (c - 64) for c in range(64, n_core))

        rc = lib_gpu.gpu_run_strips(
            gctx, ctypes.c_uint64(strip_star), 1,
            ctypes.c_int64(f_star), ctypes.c_uint64(d_lo), ctypes.c_uint64(d_hi),
            h_cands, ctypes.byref(h_cand_cnt), h_deg_fibs, ctypes.byref(h_deg_cnt)
        )
        assert rc == 0, f"gpu_run_strips failed with rc={rc}"
        s_cand = int(lib_cpu.verify_candidates_omp(
            h_cand_cnt.value, h_cands, d1, nW, nt1, nT, n_um, n_core, rK_init,
            U1.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
            T1.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
            M0_c_masks.ctypes.data_as(ctypes.POINTER(ctypes.c_uint32)),
            Mk_c_masks.ctypes.data_as(ctypes.POINTER(ctypes.c_uint32)),
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
            ctypes.c_int64(f_star), ctypes.c_uint64(d_lo), ctypes.c_uint64(d_hi),
            None, 0
        ))
        s_deg = int(lib_cpu.close_degenerate_fibers_omp(
            h_deg_cnt.value, h_deg_fibs, d1, nW, nt1, nT, n_um, n_core, rK_init,
            U1.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
            T1.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
            M0_c_masks.ctypes.data_as(ctypes.POINTER(ctypes.c_uint32)),
            Mk_c_masks.ctypes.data_as(ctypes.POINTER(ctypes.c_uint32)),
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
            ctypes.c_int64(f_star), ctypes.c_uint64(d_lo), ctypes.c_uint64(d_hi),
        ))
        tot = s_cand + s_deg
        if tot >= 1: zt_pass += 1
        print(f"    ZT trial {trial}: fiber={f_star}, cands={h_cand_cnt.value}, deg={h_deg_cnt.value} -> verified_surv={tot}", flush=True)
    print(f"  GPU ZERO-TRUST AUDIT: {zt_pass}/10 PASS!", flush=True)
    assert zt_pass == 10, "CRITICAL: GPU FES missed a planted solution!"

    # Main sweep (or --bench-only)
    strips_to_run = min(args.bench_strips, total_strips) if args.bench_only else total_strips
    total_fibs_target = strips_to_run * 64
    total_pts_target = total_fibs_target * (1 << d1)
    print(f"\n  Launching CUDA L4 sweep: {strips_to_run:,}/{total_strips:,} strips ({total_fibs_target:,} fibers = {total_pts_target:,} pts)...", flush=True)

    t_sweep = time.perf_counter()
    t_last_log = t_sweep
    grand_cands = 0
    grand_deg = 0
    grand_surv = 0
    strips_done = 0

    while strips_done < strips_to_run:
        n_cur = min(max_strips_batch, strips_to_run - strips_done)
        rc = lib_gpu.gpu_run_strips(
            gctx, ctypes.c_uint64(strips_done), n_cur,
            ctypes.c_int64(-1), ctypes.c_uint64(0), ctypes.c_uint64(0),
            h_cands, ctypes.byref(h_cand_cnt), h_deg_fibs, ctypes.byref(h_deg_cnt)
        )
        assert rc == 0, f"gpu_run_strips failed with rc={rc} at strip {strips_done}"
        nc, nd = h_cand_cnt.value, h_deg_cnt.value
        grand_cands += nc
        grand_deg += nd
        if nc > 0:
            grand_surv += int(lib_cpu.verify_candidates_omp(
                nc, h_cands, d1, nW, nt1, nT, n_um, n_core, rK_init,
                U1.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
                T1.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
                M0_c_masks.ctypes.data_as(ctypes.POINTER(ctypes.c_uint32)),
                Mk_c_masks.ctypes.data_as(ctypes.POINTER(ctypes.c_uint32)),
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
                ctypes.c_int64(-1), ctypes.c_uint64(0), ctypes.c_uint64(0),
                dummy_surv, 4
            ))
        if nd > 0:
            grand_surv += int(lib_cpu.close_degenerate_fibers_omp(
                nd, h_deg_fibs, d1, nW, nt1, nT, n_um, n_core, rK_init,
                U1.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
                T1.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
                M0_c_masks.ctypes.data_as(ctypes.POINTER(ctypes.c_uint32)),
                Mk_c_masks.ctypes.data_as(ctypes.POINTER(ctypes.c_uint32)),
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
                ctypes.c_int64(-1), ctypes.c_uint64(0), ctypes.c_uint64(0),
            ))
        strips_done += n_cur
        now = time.perf_counter()
        if (now - t_last_log) >= 5.0 or strips_done == strips_to_run:
            el = max(now - t_sweep, 1e-6)
            pts_done = strips_done * 64 * (1 << d1)
            gpts = (pts_done / el) / 1e9
            pct = 100.0 * strips_done / strips_to_run
            eta_s = el * (strips_to_run - strips_done) / max(strips_done, 1)
            print(
                f"  [e={rep}] {pct:6.2f}% ({strips_done:,}/{strips_to_run:,} strips) | "
                f"{gpts:6.2f} Gpts/s | cands={grand_cands:,} deg={grand_deg:,} surv={grand_surv} | ETA={eta_s:.1f}s",
                flush=True,
            )
            t_last_log = now

    dt_sweep = time.perf_counter() - t_sweep
    lib_gpu.gpu_free(gctx)

    pts_closed = strips_to_run * 64 * (1 << d1)
    gpts_per_s = (pts_closed / max(dt_sweep, 1e-9)) / 1e9
    orbit_pts = 1 << nW
    eta_full_s = orbit_pts / (gpts_per_s * 1e9) if gpts_per_s > 0 else 0.0
    is_full = (not args.bench_only) and (strips_to_run == total_strips)

    cert = {
        "cell": "B0_00",
        "K": 1,
        "rep": rep,
        "c5_free": True,
        "gpu": gpu_name,
        "root_state": {"dim": dim_sr, "quads": q_sr, "cubs": c_sr},
        "pencil": {"nW": nW, "nT": nT, "n_core": n_core, "rK_init": rK_init, "d1": d1, "nt1": nt1, "rK_rem": rK_rem_nom},
        "anf_zt_mismatches": anf_mismatches,
        "gpu_zt_planted_audit": f"{zt_pass}/10 PASS",
        "is_full_orbit": is_full,
        "strips_closed": int(strips_to_run),
        "total_strips": int(total_strips),
        "fibers_closed": int(strips_to_run * 64),
        "points_closed": int(pts_closed),
        "gpu_candidates_verified": int(grand_cands),
        "degenerate_fibers_closed_cpu": int(grand_deg),
        "full_survivors": int(grand_surv),
        "verdict": ("ORBIT_FORMALLY_CLOSED_UNSAT_100%" if (is_full and grand_surv == 0) else ("BENCHMARK_ONLY" if args.bench_only else "SURVIVOR_FOUND")),
        "sweep_wall_s": round(dt_sweep, 3),
        "rate_gpts_per_s": round(gpts_per_s, 3),
        "projected_full_orbit_min": round(eta_full_s / 60.0, 2),
        "total_rep_s": round(time.perf_counter() - t0, 2),
    }
    cert["sha256"] = hashlib.sha256(json.dumps(cert, sort_keys=True).encode()).hexdigest()
    return cert


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--rep", type=int, default=11, help="Single A14 K=1 rep (ignored if --reps is set)")
    ap.add_argument("--reps", type=str, default="", help="Comma-separated list of A14 K=1 reps")
    ap.add_argument("--d1", type=int, default=0, help="Override d1 <= 14 (0 = auto-select largest d1 <= 14 with rK_rem <= 6)")
    ap.add_argument("--arch", type=str, default="", help="Override nvcc -arch (default: auto-detect via nvidia-smi)")
    ap.add_argument("--batch-blocks", type=int, default=2048, help="CUDA blocks (64 fibers/block) per kernel launch")
    ap.add_argument("--bench-only", action="store_true", help="Run quick throughput benchmark instead of full sweep")
    ap.add_argument("--bench-strips", type=int, default=2048, help="Number of 64-fiber strips for --bench-only (2048 = 2.15B pts)")
    ap.add_argument("--out-json", type=str, default="cert_k1_l4.json", help="Output JSON certificate/benchmark path")
    args = ap.parse_args()

    reps = [int(x.strip()) for x in args.reps.split(",") if x.strip()] if args.reps else [args.rep]
    arch, gpu_name = (args.arch, args.arch) if args.arch else detect_gpu_arch()

    tag = f"k1_l4_{reps[0]}"
    lib_cpu, lib_gpu = compile_cpu_and_cuda(tag, arch)
    root_bundle = pilot.setup_k1_root(tag)

    certs = []
    for rep in reps:
        c = run_one_rep(rep, root_bundle, lib_cpu, lib_gpu, args, gpu_name)
        certs.append(c)
        print("\n  *** RESULT ***", flush=True)
        print(json.dumps(c, indent=2), flush=True)

    out_obj = certs[0] if len(certs) == 1 else {"gpu": gpu_name, "reps": certs}
    Path(args.out_json).write_text(json.dumps(out_obj, indent=2) + "\n", encoding="utf-8")
    print(f"\nSaved output to {args.out_json}", flush=True)


if __name__ == "__main__":
    main()
