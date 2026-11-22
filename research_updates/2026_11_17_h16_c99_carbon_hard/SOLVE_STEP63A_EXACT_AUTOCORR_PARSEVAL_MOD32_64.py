#!/usr/bin/env python3
r"""
SOLVE_STEP63A_EXACT_AUTOCORR_PARSEVAL_MOD32_64.py

MATHEMATICAL FRONT A — EXACT AUTOCORRELATION \Delta_f(a) = 0 (MOD-32/64/128+ DERIVATIVE
INVARIANTS), EXACT D_8-COSET PARSEVAL & CONVOLUTION IDENTITIES P(d) = 65536*delta_{d,0},
DUAL-SQUARE IDENTITIES W_f(v,v)^2 = 65536, AND SHATTERED-FIBER HIGHER-BIT INJECTION!

KEY MATHEMATICAL DISCOVERIES & TARGETS (100% ZERO-TRUST VERIFIED):
  1. Why Step 54B (wt_15(D_a f) mod 16) added 0 new equations:
     For EVERY f in H(16, 4) (deg <= 4) and EVERY a != 0, deg(D_a f) <= 3 on F_2^15.
     By Ax / McEliece's theorem on RM(3, 15), 2^{ceil(15/3)-1} = 16 | wt_15(D_a f) IDENTICALLY!
     Thus wt_15(D_a f) mod 16 is identically 0 = 0 on ALL of H(16, 4)!
     The FIRST NON-TRIVIAL 2-adic bit of derivative balancedness wt_15(D_a f) == 16384 is:
       - bit 4: (wt_15(D_a f) >> 4) & 1 == 0  (wt_15 == 0 mod 32, Delta_f(a) == 0 mod 128),
       - bit 5: (wt_15(D_a f) >> 5) & 1 == 0  (wt_15 == 0 mod 64, Delta_f(a) == 0 mod 256),
       - bit 6: (wt_15(D_a f) >> 6) & 1 == 0  (wt_15 == 0 mod 128, Delta_f(a) == 0 mod 512), ...
     Using 16-stage FWHT (Wiener-Khinchin: Delta_f = FWHT(W_f^2) / 65536) in C/OpenMP,
     we audit ALL 4,115 C_16-orbits of a in F_2^16 \ {0} simultaneously!

  2. Exact D_8-Coset Parseval, Convolution & Dual-Square Identities:
     For z in F_2^8, S(z) = sum_{u in F_2^8} (-1)^{f(u, u^z)} = W_h(z) where h(v) = f_dual(v,v).
     Bentness W_f(v, v) = +-256 for all v in F_2^8 is EQUIVALENT to the 36 exact quadratic-in-S
     identities (one per C_8-orbit of d in F_2^8):
       P(d) := sum_{z in F_2^8} S(z) S(z ^ d) - 65536 * delta_{d, 0} == 0,
     and equivalently in the dual basis (36 C_8-orbits of v in F_2^8):
       Q_dual(v) := W_f(v, v)^2 - 65536 == 0!
     Unlike linear C_8-Walsh (Step 60C, which only checked W_f(v,v)/256 odd), Q_dual(v) = 0
     and P(d) = 0 directly kill W_f(v,v) = +-3*256, +-5*256, ... via higher 2-adic bits!

  3. THREE SYSTEMATIC EXPERIMENTAL STAGES ON BOTH B0_11 AND B1_11:
     - PART 1 (Root N=109):
       (1A) All 4,115 C_16-orbits of a != 0: exact v_2(wt_15), exact algebraic degree of lowest
            active bit & higher bits, spotlight on 0xFFFF, 0x5555, 0x00FF, all 35 D_8 shifts, wt=1..4.
       (1B) 200-tuple 4th-diff & 5th-diff linear-combo degree-drop detector on 180 structured shifts!
       (1C) Exact ANF extraction + 50-sample direct truth-table Zero-Trust verification of any
            deg<=3 (inject into s9!) or deg==4 equations (compare vs V_13..V_16 rank-43 space!).
       (1D) All 36 P(d) & 36 Q_dual(v) identities: exact v_2, degree census, linear-combo drops,
            ANF extraction + 50-sample Zero-Trust verification + s9 injection!
     - PART 2 (Fixed-eta: B0_11 eta in {0,5,9,11}; B1_11 eta in {0,3,8,10}):
       Run BOTH Affine Fixed-eta AND direct on the Quadratic Variety V(Q) (t = Q(w), which
       automatically mods out all 17 Q_t quadratics & all higher-degree Q_t syzygies!) for:
       all 4,115 autocorr orbits, 180-shift linear-combo drops, deg<=3/deg==4 extraction + V_13
       comparison, and all 36 P(d) + 36 Q_dual(v)!
     - PART 3 (Shattered s9 Fibers: B0_11 eta=5,0 d1=26,28; B1_11 eta=3,0 d1=20,22):
       Full all-4,115 autocorr + 180-shift linear-combo drops + all 36 P(d) & 36 Q_dual(v) +
       higher-bit injection into s9.run_branch_cascade with 50-sample direct Zero-Trust verification!
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
import SOLVE_STEP40A_B11_COMMON_KERNEL_AND_DECOMPOSITION as s40a
import SOLVE_STEP45A_B000_PARALLEL_CLOSER as s45a
import SOLVE_STEP45B_POLAR_EXACT_RHS_AND_KL3 as s45b
import SOLVE_STEP57B_GREEDY_BASIS_AND_BLOCKB_INJECT as s57b
import SOLVE_STEP60C_DEG4_V13_WALSH_XL as s60c


# ==============================================================================
# High-Speed OpenMP C Kernel:
#   1. FWHT-based exact wt_15(D_a f) for ALL 4,115 C_16-orbits simultaneously
#   2. Direct 65,536-pt truth-table wt_15(D_a f) for Zero-Trust verification
#   3. Exact D_8-coset Parseval/Convolution P(d) (36) & Dual-Square Q_dual(v) (36)
#   4. Exact inclusion-exclusion deg<=3 and deg<=4 ANF extractors for wt_15(D_a f)
#   5. Exact Mobius deg<=3 and deg<=4 ANF extractors for P(d) & Q_dual(v)
# ==============================================================================
C_STEP63A_SRC = r"""
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <omp.h>

static inline void toggle_bit(uint64_t *row, uint64_t col) {
    row[col >> 6] ^= (1ULL << (col & 63));
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
 * Fast Wiener-Khinchin FWHT computation of wt_15(D_a f) = (65536 - Delta_f(a)) / 4
 * for R input functions (specified by pts_lo/pts_hi over basis_tt[N][65536])
 * and M shifts a = shifts[0..M-1].
 */
void fwht_autocorr_batch_c(
    const uint8_t *orig_tt,
    const uint8_t *basis_tt,
    int N,
    const uint64_t *pts_lo,
    const uint64_t *pts_hi,
    int R,
    const uint16_t *shifts,
    int M,
    int32_t *out_wt15
) {
    #pragma omp parallel
    {
        uint8_t *ftt = (uint8_t *)malloc(65536);
        int32_t *W = (int32_t *)malloc(65536 * sizeof(int32_t));
        int64_t *W2 = (int64_t *)malloc(65536 * sizeof(int64_t));

        #pragma omp for schedule(static)
        for (int r = 0; r < R; r++) {
            memcpy(ftt, orig_tt, 65536);
            uint64_t lo = pts_lo[r], hi = pts_hi[r];
            for (int i = 0; i < N; i++) {
                int bit = (i < 64) ? (int)((lo >> i) & 1ULL) : (int)((hi >> (i - 64)) & 1ULL);
                if (bit) {
                    const uint8_t *bi = basis_tt + (size_t)i * 65536;
                    for (int x = 0; x < 65536; x++) ftt[x] ^= bi[x];
                }
            }
            for (int x = 0; x < 65536; x++) W[x] = ftt[x] ? -1 : 1;

            /* 16-stage FWHT for W_f */
            for (int len = 1; len < 65536; len <<= 1) {
                int step = len << 1;
                for (int i = 0; i < 65536; i += step) {
                    int32_t *p0 = W + i;
                    int32_t *p1 = W + i + len;
                    for (int j = 0; j < len; j++) {
                        int32_t u = p0[j], v = p1[j];
                        p0[j] = u + v;
                        p1[j] = u - v;
                    }
                }
            }
            for (int x = 0; x < 65536; x++) {
                int64_t v = (int64_t)W[x];
                W2[x] = v * v;
            }
            /* 16-stage FWHT for 65536 * Delta_f */
            for (int len = 1; len < 65536; len <<= 1) {
                int step = len << 1;
                for (int i = 0; i < 65536; i += step) {
                    int64_t *p0 = W2 + i;
                    int64_t *p1 = W2 + i + len;
                    for (int j = 0; j < len; j++) {
                        int64_t u = p0[j], v = p1[j];
                        p0[j] = u + v;
                        p1[j] = u - v;
                    }
                }
            }
            int32_t *dst = out_wt15 + (size_t)r * M;
            for (int m = 0; m < M; m++) {
                int64_t delta = W2[shifts[m]] >> 16;
                dst[m] = (int32_t)((65536LL - delta) >> 2);
            }
        }
        free(ftt);
        free(W);
        free(W2);
    }
}

/*
 * Direct 65,536-pt truth-table computation of wt_15(D_a f) for Zero-Trust verification!
 * Does NOT use FWHT: directly counts (f(x) ^ f(x ^ a)) / 2 over all 65,536 x.
 */
void direct_wt15_verify_c(
    const uint8_t *orig_tt,
    const uint8_t *basis_tt,
    int N,
    const uint64_t *pts_lo,
    const uint64_t *pts_hi,
    int R,
    const uint16_t *shifts,
    int M,
    int32_t *out_wt15
) {
    #pragma omp parallel
    {
        uint8_t *ftt = (uint8_t *)malloc(65536);
        #pragma omp for schedule(static)
        for (int r = 0; r < R; r++) {
            memcpy(ftt, orig_tt, 65536);
            uint64_t lo = pts_lo[r], hi = pts_hi[r];
            for (int i = 0; i < N; i++) {
                int bit = (i < 64) ? (int)((lo >> i) & 1ULL) : (int)((hi >> (i - 64)) & 1ULL);
                if (bit) {
                    const uint8_t *bi = basis_tt + (size_t)i * 65536;
                    for (int x = 0; x < 65536; x++) ftt[x] ^= bi[x];
                }
            }
            int32_t *dst = out_wt15 + (size_t)r * M;
            for (int m = 0; m < M; m++) {
                uint16_t a = shifts[m];
                int cnt = 0;
                for (int x = 0; x < 65536; x++) {
                    cnt += (int)(ftt[x] ^ ftt[x ^ a]);
                }
                dst[m] = cnt >> 1;
            }
        }
        free(ftt);
    }
}

/*
 * Evaluate ALL 36 primal D_8-coset Parseval/Convolution identities:
 *   P(d_idx) = sum_{z=0..255} S(z) * S(z ^ z_reps[d_idx]) - 65536 * (d_idx == 0)
 * AND ALL 36 dual-square identities:
 *   Q_dual(v_idx) = W_f(v_rep, v_rep)^2 - 65536
 * for R input functions.
 * Output: out_PQ[R * 72] where [0..35] are P(0..35) and [36..71] are Q_dual(0..35).
 */
void eval_d8_parseval_batch_c(
    const uint64_t *orig_36w,
    const uint64_t *basis_36w,
    int N,
    const uint64_t *pts_lo,
    const uint64_t *pts_hi,
    int R,
    const int *c8_idx_256,
    const int *z_reps_36,
    int64_t *out_PQ
) {
    #pragma omp parallel for schedule(static)
    for (int r = 0; r < R; r++) {
        uint64_t cur[144];
        memcpy(cur, orig_36w, 144 * sizeof(uint64_t));
        uint64_t lo = pts_lo[r], hi = pts_hi[r];
        for (int i = 0; i < N; i++) {
            int bit = (i < 64) ? (int)((lo >> i) & 1ULL) : (int)((hi >> (i - 64)) & 1ULL);
            if (bit) {
                const uint64_t *bi = basis_36w + (size_t)i * 144;
                for (int w = 0; w < 144; w++) cur[w] ^= bi[w];
            }
        }
        int64_t S_orb[36];
        for (int z = 0; z < 36; z++) {
            int wt = __builtin_popcountll(cur[z * 4 + 0])
                   + __builtin_popcountll(cur[z * 4 + 1])
                   + __builtin_popcountll(cur[z * 4 + 2])
                   + __builtin_popcountll(cur[z * 4 + 3]);
            S_orb[z] = 256 - 2 * wt;
        }
        int64_t S_full[256];
        for (int z = 0; z < 256; z++) S_full[z] = S_orb[c8_idx_256[z]];

        int64_t *dst = out_PQ + (size_t)r * 72;
        for (int d = 0; d < 36; d++) {
            int d_val = z_reps_36[d];
            int64_t acc = 0;
            for (int z = 0; z < 256; z++) acc += S_full[z] * S_full[z ^ d_val];
            if (d_val == 0) acc -= 65536LL;
            dst[d] = acc;
        }
        /* 8-stage FWHT of S_full gives W_f(v, v) for all v in 0..255 */
        int64_t W8[256];
        memcpy(W8, S_full, 256 * sizeof(int64_t));
        for (int len = 1; len < 256; len <<= 1) {
            int step = len << 1;
            for (int i = 0; i < 256; i += step) {
                for (int j = 0; j < len; j++) {
                    int64_t u = W8[i + j], v = W8[i + j + len];
                    W8[i + j] = u + v;
                    W8[i + j + len] = u - v;
                }
            }
        }
        for (int v = 0; v < 36; v++) {
            int64_t wv = W8[z_reps_36[v]];
            dst[36 + v] = wv * wv - 65536LL;
        }
    }
}

/*
 * Exact inclusion-exclusion ANF extractor for (wt_15(D_a f) >> bit_b) & 1
 * up to max_deg in {3, 4}, verifying 2^{bit_b} | alternating_sum on every subset!
 */
void extract_deriv_bit_anf_batch_c(
    const uint8_t *orig_tt,
    const uint8_t *basis_tt,
    const uint16_t *shifts,
    const int *bit_bs,
    int K,
    int N,
    int max_deg,
    uint64_t n_words,
    uint64_t *out_rows,
    int *out_status
) {
    uint64_t n4 = (max_deg == 4) ? comb4(N) : 0ULL;
    uint64_t n3 = comb3(N);
    uint64_t n2 = comb2(N);
    uint64_t off3 = n4;
    uint64_t off2 = n4 + n3;
    uint64_t off1 = n4 + n3 + n2;
    uint64_t off0 = off1 + (uint64_t)N;

    memset(out_rows, 0, (size_t)K * (size_t)n_words * sizeof(uint64_t));

    #pragma omp parallel for schedule(dynamic, 1)
    for (int s = 0; s < K; s++) {
        uint16_t a = shifts[s];
        int b = bit_bs[s];
        uint32_t mask_b = (1U << b) - 1U;
        int b0 = __builtin_ctz((unsigned int)a);
        const int nw = 512; /* 32768 / 64 */
        uint64_t *row = out_rows + (size_t)s * (size_t)n_words;

        uint64_t *o_w = (uint64_t *)calloc(nw, sizeof(uint64_t));
        uint64_t *b_w = (uint64_t *)calloc((size_t)N * nw, sizeof(uint64_t));
        uint64_t *tmp2 = (uint64_t *)malloc(nw * sizeof(uint64_t));
        uint64_t *tmp3 = (uint64_t *)malloc(nw * sizeof(uint64_t));
        uint64_t *tmp3_o = (uint64_t *)malloc(nw * sizeof(uint64_t));

        int idx_p = 0;
        for (int x = 0; x < 65536; x++) {
            if ((x >> b0) & 1) continue;
            int xa = x ^ (int)a;
            if (orig_tt[x] ^ orig_tt[xa]) o_w[idx_p >> 6] |= (1ULL << (idx_p & 63));
            idx_p++;
        }
        for (int i = 0; i < N; i++) {
            const uint8_t *bi = basis_tt + (size_t)i * 65536;
            uint64_t *dst = b_w + (size_t)i * nw;
            int ip = 0;
            for (int x = 0; x < 65536; x++) {
                if ((x >> b0) & 1) continue;
                if (bi[x] ^ bi[x ^ (int)a]) dst[ip >> 6] |= (1ULL << (ip & 63));
                ip++;
            }
        }

        int st = 0;
        /* Deg 0 */
        int w0 = 0;
        for (int w = 0; w < nw; w++) w0 += __builtin_popcountll(o_w[w]);
        if ((unsigned int)w0 & mask_b) st = -1;
        else if ((((unsigned int)w0) >> b) & 1U) toggle_bit(row, off0);

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
                if ((unsigned int)w1 & mask_b) { st = -2; break; }
                if ((((unsigned int)w1) >> b) & 1U) toggle_bit(row, off1 + (uint64_t)i);
            }
        }

        /* Deg 2, 3, (and 4 if max_deg == 4) */
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
                    if ((unsigned int)w2 & mask_b) { st = -3; break; }
                    if ((((unsigned int)w2) >> b) & 1U) toggle_bit(row, off2 + c2);
                    c2++;

                    for (int k = j + 1; k < N && st == 0; k++) {
                        const uint64_t *bk = b_w + (size_t)k * nw;
                        int p3 = 0, po3 = 0;
                        for (int w = 0; w < nw; w++) {
                            uint64_t v = tmp2[w] & bk[w];
                            uint64_t vo = v & o_w[w];
                            tmp3[w] = v;
                            tmp3_o[w] = vo;
                            p3 += __builtin_popcountll(v);
                            po3 += __builtin_popcountll(vo);
                        }
                        int w3 = 4 * p3 - 8 * po3;
                        if ((unsigned int)w3 & mask_b) { st = -4; break; }
                        if ((((unsigned int)w3) >> b) & 1U) toggle_bit(row, off3 + c3);
                        c3++;

                        if (max_deg == 4) {
                            for (int l = k + 1; l < N; l++) {
                                const uint64_t *bl = b_w + (size_t)l * nw;
                                int p4 = 0, po4 = 0;
                                for (int w = 0; w < nw; w++) {
                                    p4 += __builtin_popcountll(tmp3[w] & bl[w]);
                                    po4 += __builtin_popcountll(tmp3_o[w] & bl[w]);
                                }
                                int w4 = -8 * p4 + 16 * po4;
                                if ((unsigned int)w4 & mask_b) { st = -5; break; }
                                if ((((unsigned int)w4) >> b) & 1U) {
                                    row[c4 >> 6] ^= (1ULL << (c4 & 63));
                                }
                                c4++;
                            }
                        }
                    }
                }
            }
        }
        out_status[s] = st;
        free(o_w); free(b_w); free(tmp2); free(tmp3); free(tmp3_o);
    }
}

/*
 * Exact Mobius ANF extractor (deg <= 3) for D_8 Parseval/Dual-Square identities
 * pq_ids[q] in 0..71 (0..35 = P(d), 36..71 = Q_dual(v)), bit shifts bit_bs[q].
 */
void extract_d8_pq_deg3_c(
    const uint64_t *orig_36w,
    const uint64_t *basis_36w,
    const int *c8_idx_256,
    const int *z_reps_36,
    const int *pq_ids,
    const int *bit_bs,
    int K,
    int N,
    uint64_t n_words,
    uint64_t *out_rows,
    int *out_mod_fail
) {
    uint64_t n3 = comb3(N);
    uint64_t n2 = comb2(N);
    uint64_t off2 = n3;
    uint64_t off1 = n3 + n2;
    uint64_t off0 = off1 + (uint64_t)N;
    memset(out_rows, 0, (size_t)K * (size_t)n_words * sizeof(uint64_t));
    memset(out_mod_fail, 0, (size_t)K * sizeof(int));

    /* Helper macro to evaluate PQ[0..71] from packed 144 uint64 words */
    #define EVAL_PQ_FROM_CUR(CUR, PQ_ARR) do { \
        int64_t _So[36], _Sf[256], _W8[256]; \
        for (int _z = 0; _z < 36; _z++) { \
            int _wt = __builtin_popcountll((CUR)[_z*4+0]) + __builtin_popcountll((CUR)[_z*4+1]) \
                    + __builtin_popcountll((CUR)[_z*4+2]) + __builtin_popcountll((CUR)[_z*4+3]); \
            _So[_z] = 256 - 2 * _wt; \
        } \
        for (int _z = 0; _z < 256; _z++) _Sf[_z] = _So[c8_idx_256[_z]]; \
        for (int _d = 0; _d < 36; _d++) { \
            int _dv = z_reps_36[_d]; \
            int64_t _acc = 0; \
            for (int _z = 0; _z < 256; _z++) _acc += _Sf[_z] * _Sf[_z ^ _dv]; \
            if (_dv == 0) _acc -= 65536LL; \
            (PQ_ARR)[_d] = _acc; \
        } \
        memcpy(_W8, _Sf, 256 * sizeof(int64_t)); \
        for (int _len = 1; _len < 256; _len <<= 1) { \
            int _step = _len << 1; \
            for (int _i = 0; _i < 256; _i += _step) { \
                for (int _j = 0; _j < _len; _j++) { \
                    int64_t _u = _W8[_i+_j], _v = _W8[_i+_j+_len]; \
                    _W8[_i+_j] = _u + _v; _W8[_i+_j+_len] = _u - _v; \
                } \
            } \
        } \
        for (int _v = 0; _v < 36; _v++) { \
            int64_t _wv = _W8[z_reps_36[_v]]; \
            (PQ_ARR)[36 + _v] = _wv * _wv - 65536LL; \
        } \
    } while(0)

    int *c0 = (int *)calloc(K, sizeof(int));
    int *c1 = (int *)calloc((size_t)K * N, sizeof(int));
    int *c2 = (int *)calloc((size_t)K * N * N, sizeof(int));

    int64_t pq0[72];
    EVAL_PQ_FROM_CUR(orig_36w, pq0);
    for (int q = 0; q < K; q++) {
        int64_t v = pq0[pq_ids[q]];
        int b = bit_bs[q];
        if ((uint64_t)v & ((1ULL << b) - 1ULL)) out_mod_fail[q] = 1;
        c0[q] = (int)(((uint64_t)v >> b) & 1ULL);
        if (c0[q]) toggle_bit(out_rows + (size_t)q * n_words, off0);
    }

    for (int i = 0; i < N; i++) {
        uint64_t cur[144];
        const uint64_t *bi = basis_36w + (size_t)i * 144;
        for (int w = 0; w < 144; w++) cur[w] = orig_36w[w] ^ bi[w];
        int64_t pq[72];
        EVAL_PQ_FROM_CUR(cur, pq);
        for (int q = 0; q < K; q++) {
            int64_t v = pq[pq_ids[q]];
            int b = bit_bs[q];
            if ((uint64_t)v & ((1ULL << b) - 1ULL)) out_mod_fail[q] = 1;
            int val = ((int)(((uint64_t)v >> b) & 1ULL)) ^ c0[q];
            c1[q * N + i] = val;
            if (val) toggle_bit(out_rows + (size_t)q * n_words, off1 + (uint64_t)i);
        }
    }

    #pragma omp parallel for schedule(dynamic, 1)
    for (int i = 0; i < N; i++) {
        const uint64_t *bi = basis_36w + (size_t)i * 144;
        uint64_t cur2[144], cur3[144];
        int64_t pq[72];
        for (int j = i + 1; j < N; j++) {
            const uint64_t *bj = basis_36w + (size_t)j * 144;
            for (int w = 0; w < 144; w++) cur2[w] = orig_36w[w] ^ bi[w] ^ bj[w];
            EVAL_PQ_FROM_CUR(cur2, pq);
            uint64_t col2 = off2 + idx2_lex(N, i, j);
            for (int q = 0; q < K; q++) {
                int64_t v = pq[pq_ids[q]];
                int b = bit_bs[q];
                if ((uint64_t)v & ((1ULL << b) - 1ULL)) out_mod_fail[q] = 1;
                int val = ((int)(((uint64_t)v >> b) & 1ULL)) ^ c0[q] ^ c1[q * N + i] ^ c1[q * N + j];
                c2[(size_t)q * N * N + (size_t)i * N + j] = val;
                if (val) {
                    #pragma omp atomic
                    out_rows[(size_t)q * n_words + (col2 >> 6)] ^= (1ULL << (col2 & 63));
                }
            }
        }
    }

    #pragma omp parallel for schedule(dynamic, 1)
    for (int i = 0; i < N; i++) {
        const uint64_t *bi = basis_36w + (size_t)i * 144;
        uint64_t cur2[144], cur3[144];
        int64_t pq[72];
        for (int j = i + 1; j < N; j++) {
            const uint64_t *bj = basis_36w + (size_t)j * 144;
            for (int w = 0; w < 144; w++) cur2[w] = orig_36w[w] ^ bi[w] ^ bj[w];
            for (int k = j + 1; k < N; k++) {
                const uint64_t *bk = basis_36w + (size_t)k * 144;
                for (int w = 0; w < 144; w++) cur3[w] = cur2[w] ^ bk[w];
                EVAL_PQ_FROM_CUR(cur3, pq);
                uint64_t col3 = idx3_lex(N, i, j, k);
                for (int q = 0; q < K; q++) {
                    int64_t v = pq[pq_ids[q]];
                    int b = bit_bs[q];
                    if ((uint64_t)v & ((1ULL << b) - 1ULL)) out_mod_fail[q] = 1;
                    int val = ((int)(((uint64_t)v >> b) & 1ULL))
                            ^ c0[q] ^ c1[q * N + i] ^ c1[q * N + j] ^ c1[q * N + k]
                            ^ c2[(size_t)q * N * N + (size_t)i * N + j]
                            ^ c2[(size_t)q * N * N + (size_t)i * N + k]
                            ^ c2[(size_t)q * N * N + (size_t)j * N + k];
                    if (val) {
                        #pragma omp atomic
                        out_rows[(size_t)q * n_words + (col3 >> 6)] ^= (1ULL << (col3 & 63));
                    }
                }
            }
        }
    }
    #undef EVAL_PQ_FROM_CUR
    free(c0); free(c1); free(c2);
}
"""


# ==============================================================================
# Helper Functions
# ==============================================================================
def canon_c16(a):
    best = a
    cur = a
    for _ in range(15):
        cur = ((cur << 1) | (cur >> 15)) & 0xFFFF
        if cur < best:
            best = cur
    return best


def build_all_4115_c16_shifts():
    r"""Return all 4,115 C_16-orbit representatives of a in F_2^16 \ {0}, plus structured subsets."""
    seen = set()
    all_reps = []
    for a in range(1, 65536):
        c = canon_c16(a)
        if c not in seen:
            seen.add(c)
            all_reps.append(c)
    assert len(all_reps) == 4115

    # Build 180 structured shifts:
    # - 0xFFFF, 0x5555, 0x00FF, 0x1111, 0x3333, 0x7777
    # - All 35 D_8 shifts a = (z, z)
    # - All wt=1 (1), wt=2 (8), wt=3 (35) shifts
    # - Symmetric wt=4..12 shifts + deterministic sample up to 180
    struct_set = []
    seen_s = set()

    def add_s(a):
        c = canon_c16(a)
        if c not in seen_s:
            seen_s.add(c)
            struct_set.append(c)

    for special in (0xFFFF, 0x5555, 0x00FF, 0x0101, 0x1111, 0x3333, 0x7777, 0x0001, 0x0003, 0x000F):
        add_s(special)
    d8_shifts = []
    for z in range(1, 256):
        c = canon_c16(z | (z << 8))
        if c not in d8_shifts:
            d8_shifts.append(c)
        add_s(c)
    for a in all_reps:
        if a.bit_count() in (1, 2, 3):
            add_s(a)
    for a in all_reps:
        if a.bit_count() in (4, 8, 12, 14, 15) and len(struct_set) < 180:
            add_s(a)
    rng = random.Random(63001)
    while len(struct_set) < 180:
        add_s(rng.choice(all_reps))

    rep_to_idx = {r: i for i, r in enumerate(all_reps)}
    struct_indices = [rep_to_idx[r] for r in struct_set]
    return (
        np.ascontiguousarray(all_reps, dtype=np.uint16),
        all_reps,
        d8_shifts,
        struct_set,
        struct_indices,
    )


def build_c8_orbit_tables():
    """Return c8_idx_256[256], z_reps_36[36], orb_sz_36[36]."""
    seen = set()
    c8_orbs = []
    c8_idx = [0] * 256
    for b in range(256):
        if b in seen:
            continue
        oid = len(c8_orbs)
        orb, cur = [], b
        while cur not in seen:
            seen.add(cur)
            orb.append(cur)
            c8_idx[cur] = oid
            cur = ((cur << 1) | (cur >> 7)) & 0xFF
        c8_orbs.append(orb)
    assert len(c8_orbs) == 36
    z_reps = [o[0] for o in c8_orbs]
    return (
        np.ascontiguousarray(c8_idx, dtype=np.int32),
        np.ascontiguousarray(z_reps, dtype=np.int32),
        z_reps,
    )


def gf2_left_nullspace_binmat(M_u8):
    """
    Given K x T binary matrix M_u8 (uint8 0/1), return exact GF(2) left nullspace
    as list of Python int bitmasks (bit r = row r in combination).
    """
    K, T = M_u8.shape
    piv = {}
    nulls = []
    for r in range(K):
        v = 0
        row = M_u8[r]
        nz = np.flatnonzero(row)
        for c in nz:
            v |= (1 << int(c))
        cm = 1 << r
        while v:
            b = v.bit_length() - 1
            if b in piv:
                pv, pc = piv[b]
                v ^= pv
                cm ^= pc
            else:
                piv[b] = (v, cm)
                break
        else:
            nulls.append(cm)
    return len(piv), nulls


def gen_points_affine(N, R_rand, T4, T5, T6, seed):
    """Generate random points + 4th/5th/6th finite-difference tuples in F_2^N."""
    rng = random.Random(seed)
    pts = [rng.getrandbits(N) for _ in range(R_rand)]
    for T, d in ((T4, 4), (T5, 5), (T6, 6)):
        for _ in range(T):
            x0 = rng.getrandbits(N)
            ds = [rng.getrandbits(N) for _ in range(d)]
            for s in range(1 << d):
                p = x0
                for b in range(d):
                    if (s >> b) & 1:
                        p ^= ds[b]
                pts.append(p)
    mask64 = (1 << 64) - 1
    lo = np.array([p & mask64 for p in pts], dtype=np.uint64)
    hi = np.array([p >> 64 for p in pts], dtype=np.uint64)
    return pts, lo, hi


def gen_points_vq(nW, nT, nRF, Q_polys_W, R_rand, T4, T5, T6, seed):
    """
    Generate random points + 4th/5th/6th finite-difference tuples directly on
    the quadratic variety V(Q) = {(w, Q(w), rf)} parameterized by (w, rf) in F_2^{nW + nRF}!
    """
    N_free = nW + nRF
    rng = random.Random(seed)
    free_pts = [rng.getrandbits(N_free) for _ in range(R_rand)]
    for T, d in ((T4, 4), (T5, 5), (T6, 6)):
        for _ in range(T):
            x0 = rng.getrandbits(N_free)
            ds = [rng.getrandbits(N_free) for _ in range(d)]
            for s in range(1 << d):
                p = x0
                for b in range(d):
                    if (s >> b) & 1:
                        p ^= ds[b]
                free_pts.append(p)

    maskW = (1 << nW) - 1
    mask64 = (1 << 64) - 1
    sh_pts = []
    for fp in free_pts:
        w_b = fp & maskW
        rf_b = fp >> nW
        t_b = 0
        for m in range(nT):
            v = 0
            for mon in Q_polys_W[m]:
                if (mon & w_b) == mon:
                    v ^= 1
            if v:
                t_b |= (1 << m)
        full = w_b | (t_b << nW) | (rf_b << (nW + nT))
        sh_pts.append(full)
    lo = np.array([p & mask64 for p in sh_pts], dtype=np.uint64)
    hi = np.array([p >> 64 for p in sh_pts], dtype=np.uint64)
    return sh_pts, lo, hi


def analyze_integer_family(vals, R_rand, T4, T5, T6, names, max_bit=14, tag=""):
    """
    Given integer values vals[R_tot, M] (evaluated on R_rand + 16*T4 + 32*T5 + 64*T6 pts),
    classify EVERY member m in 0..M-1 by:
      - lowest non-identically-zero bit b_low (v_2 divisibility)
      - exact algebraic degree at b_low: const0, CONST_NZ (1=0!), deg<=3, deg==4, deg==5, deg>=6
    Returns dict with lists of (m, b_low) for const_nz, deg3, deg4, deg5, and summary counts.
    """
    M = vals.shape[1]
    off4 = R_rand
    off5 = off4 + 16 * T4
    off6 = off5 + 32 * T5

    v_rand = vals[:R_rand]
    v_fd4 = vals[off4:off5].reshape(T4, 16, M)
    v_fd5 = vals[off5:off6].reshape(T5, 32, M)
    v_fd6 = vals[off6:].reshape(T6, 64, M) if T6 > 0 else None

    const_nz = []
    deg3_list = []
    deg4_list = []
    deg5_list = []
    census = {}
    spotlight = {}

    for m in range(M):
        vr = v_rand[:, m]
        if np.all(vr == 0):
            key = ("const0", -1)
            census[key] = census.get(key, 0) + 1
            spotlight[m] = ("const0", -1)
            continue
        # Check constant nonzero!
        if np.all(vr == vr[0]):
            cval = int(vr[0])
            b_low = (abs(cval) & -abs(cval)).bit_length() - 1
            const_nz.append((m, b_low, cval))
            deg3_list.append((m, b_low))
            key = ("CONST_NZ", b_low)
            census[key] = census.get(key, 0) + 1
            spotlight[m] = ("CONST_NZ", b_low)
            continue

        # Find highest power of 2 dividing ALL random samples
        or_all = int(np.bitwise_or.reduce(np.abs(vr).astype(np.int64)))
        b_low = (or_all & -or_all).bit_length() - 1
        if b_low > max_bit:
            key = (f"v2>{max_bit}", b_low)
            census[key] = census.get(key, 0) + 1
            spotlight[m] = (f"v2>{max_bit}", b_low)
            continue

        mask_b = (1 << b_low) - 1
        # Test deg <= 3
        d4 = v_fd4[:, :, m]
        if np.all((d4 & mask_b) == 0):
            par4 = np.bitwise_xor.reduce((d4 >> b_low) & 1, axis=1)
            if not np.any(par4):
                deg3_list.append((m, b_low))
                key = ("deg<=3", b_low)
                census[key] = census.get(key, 0) + 1
                spotlight[m] = ("deg<=3", b_low)
                continue

        # Test deg == 4
        d5 = v_fd5[:, :, m]
        if np.all((d5 & mask_b) == 0):
            par5 = np.bitwise_xor.reduce((d5 >> b_low) & 1, axis=1)
            if not np.any(par5):
                deg4_list.append((m, b_low))
                key = ("deg==4", b_low)
                census[key] = census.get(key, 0) + 1
                spotlight[m] = ("deg==4", b_low)
                continue

        # Test deg == 5
        if v_fd6 is not None:
            d6 = v_fd6[:, :, m]
            if np.all((d6 & mask_b) == 0):
                par6 = np.bitwise_xor.reduce((d6 >> b_low) & 1, axis=1)
                if not np.any(par6):
                    deg5_list.append((m, b_low))
                    key = ("deg==5", b_low)
                    census[key] = census.get(key, 0) + 1
                    spotlight[m] = ("deg==5", b_low)
                    continue

        key = ("deg>=6", b_low)
        census[key] = census.get(key, 0) + 1
        spotlight[m] = ("deg>=6", b_low)

    print(
        f"    [{tag}] M={M}: CONST_NZ={len(const_nz)}, deg<=3={len(deg3_list)}, "
        f"deg==4={len(deg4_list)}, deg==5={len(deg5_list)} | census={dict(sorted(census.items()))}",
        flush=True,
    )
    return {
        "const_nz": const_nz,
        "deg3": deg3_list,
        "deg4": deg4_list,
        "deg5": deg5_list,
        "census": census,
        "spotlight": spotlight,
    }


def detect_linear_combo_drops(vals_fd4, vals_fd5, b_lows, tag=""):
    """
    Given vals_fd4[T4, 16, K] and vals_fd5[T5, 32, K] and bit shifts b_lows[K] (valid >= 0),
    compute GF(2) left nullspace of:
      - K x T4 4th-diff matrix (finds ANY linear combo dropping to deg <= 3!)
      - K x T5 5th-diff matrix (finds ANY linear combo dropping to deg <= 4!)
    """
    valid = [i for i, b in enumerate(b_lows) if b >= 0]
    if not valid:
        return [], []
    K = len(valid)
    T4 = vals_fd4.shape[0]
    T5 = vals_fd5.shape[0]
    M4 = np.zeros((K, T4), dtype=np.uint8)
    M5 = np.zeros((K, T5), dtype=np.uint8)
    for ki, idx in enumerate(valid):
        b = b_lows[idx]
        M4[ki] = np.bitwise_xor.reduce((vals_fd4[:, :, idx] >> b) & 1, axis=1).astype(np.uint8)
        M5[ki] = np.bitwise_xor.reduce((vals_fd5[:, :, idx] >> b) & 1, axis=1).astype(np.uint8)
    rk4, null4 = gf2_left_nullspace_binmat(M4)
    rk5, null5 = gf2_left_nullspace_binmat(M5)
    print(
        f"    [{tag} Combo-Drop Detector (K={K})]: "
        f"4th-diff rk={rk4}/{K} -> *** {len(null4)} deg<=3 combos *** | "
        f"5th-diff rk={rk5}/{K} -> *** {len(null5)} deg<=4 combos ***",
        flush=True,
    )
    return (valid, null4), (valid, null5)


def zt_verify_deriv_rows(
    orig_tt, basis_tt, N, active_vars, shifts_sub, bits_sub, rows_u64, max_deg, lib_ac, tag="", rng_seed=63500
):
    """
    100% Zero-Trust Verification of extracted derivative ANF rows on 50 fresh random points
    against DIRECT 65,536-pt truth-table evaluation (NO FWHT)!
    Returns list of verified 111-var psets (for deg<=3) or verified indices (for deg==4).
    """
    K = len(shifts_sub)
    if K == 0:
        return []
    R_zt = 50
    rng = random.Random(rng_seed)
    mask64 = (1 << 64) - 1
    zt_pts = [rng.getrandbits(N) for _ in range(R_zt)]
    zt_lo = np.array([p & mask64 for p in zt_pts], dtype=np.uint64)
    zt_hi = np.array([p >> 64 for p in zt_pts], dtype=np.uint64)
    sh_arr = np.ascontiguousarray(shifts_sub, dtype=np.uint16)
    wt_direct = np.zeros((R_zt, K), dtype=np.int32)
    lib_ac.direct_wt15_verify_c(
        orig_tt.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
        basis_tt.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
        N,
        zt_lo.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        zt_hi.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        R_zt,
        sh_arr.ctypes.data_as(ctypes.POINTER(ctypes.c_uint16)),
        K,
        wt_direct.ctypes.data_as(ctypes.POINTER(ctypes.c_int32)),
    )

    verified = []
    mismatches = 0
    div_fails = 0
    if max_deg == 3:
        zt_111 = []
        for y in zt_pts:
            x = 0
            for i in range(N):
                if (y >> i) & 1:
                    x |= (1 << active_vars[i])
            zt_111.append(x)
        for q in range(K):
            b = bits_sub[q]
            wts = wt_direct[:, q]
            if np.any((wts & ((1 << b) - 1)) != 0):
                div_fails += 1
                continue
            ps = s60c.deg3_subrow_to_111_pset(rows_u64[q], N, active_vars, is_deg4_buf=False)
            ok = True
            for r in range(R_zt):
                actual = int((wts[r] >> b) & 1)
                pe = 0
                x111 = zt_111[r]
                for mon in ps:
                    if (mon & x111) == mon:
                        pe ^= 1
                if pe != actual:
                    ok = False
                    mismatches += 1
                    break
            if ok:
                verified.append((shifts_sub[q], b, ps))
        print(
            f"    [{tag} ZERO-TRUST 50-PT DIRECT TT (deg<=3)]: "
            f"verified={len(verified)}/{K}, div_fails={div_fails}, mismatches={mismatches}",
            flush=True,
        )
        assert mismatches == 0, f"ZERO-TRUST MISMATCH in {tag}!"
        return verified
    else:
        # Deg 4 verification using C eval_mask or direct Python bit check
        n4 = s60c.comb4(N)
        n3 = s60c.comb3(N)
        n2 = s60c.comb2(N)
        off3 = n4
        off2 = n4 + n3
        off1 = n4 + n3 + n2
        off0 = off1 + N
        n_words = rows_u64.shape[1]
        # Build eval masks for the 50 points
        eval_masks = np.zeros((R_zt, n_words), dtype=np.uint64)
        for r, y in enumerate(zt_pts):
            ones = [i for i in range(N) if (y >> i) & 1]
            em = eval_masks[r]
            em[off0 >> 6] ^= np.uint64(1 << (off0 & 63))
            for ia in range(len(ones)):
                a = ones[ia]
                c1 = off1 + a
                em[c1 >> 6] ^= np.uint64(1 << (c1 & 63))
                b2 = off2 + n2 - s60c.comb2(N - a)
                b3_a = off3 + n3 - s60c.comb3(N - a)
                b4_a = n4 - s60c.comb4(N - a)
                c2_a = s60c.comb2(N - 1 - a)
                c3_a = s60c.comb3(N - 1 - a)
                for ib in range(ia + 1, len(ones)):
                    bb = ones[ib]
                    c2 = b2 + (bb - a - 1)
                    em[c2 >> 6] ^= np.uint64(1 << (c2 & 63))
                    b3_ab = b3_a + (c2_a - s60c.comb2(N - bb))
                    b4_ab = b4_a + (c3_a - s60c.comb3(N - bb))
                    c2_b = s60c.comb2(N - 1 - bb)
                    for ic in range(ib + 1, len(ones)):
                        cc = ones[ic]
                        c3 = b3_ab + (cc - bb - 1)
                        em[c3 >> 6] ^= np.uint64(1 << (c3 & 63))
                        b4_abc = b4_ab + (c2_b - s60c.comb2(N - cc))
                        for id_ in range(ic + 1, len(ones)):
                            dd = ones[id_]
                            c4 = b4_abc + (dd - cc - 1)
                            em[c4 >> 6] ^= np.uint64(1 << (c4 & 63))
        for q in range(K):
            b = bits_sub[q]
            wts = wt_direct[:, q]
            if np.any((wts & ((1 << b) - 1)) != 0):
                div_fails += 1
                continue
            row = rows_u64[q]
            ok = True
            for r in range(R_zt):
                actual = int((wts[r] >> b) & 1)
                xor_acc = int(np.bitwise_xor.reduce(row & eval_masks[r]))
                pe = xor_acc.bit_count() & 1
                if pe != actual:
                    ok = False
                    mismatches += 1
                    break
            if ok:
                verified.append(q)
        print(
            f"    [{tag} ZERO-TRUST 50-PT DIRECT TT (deg==4)]: "
            f"verified={len(verified)}/{K}, div_fails={div_fails}, mismatches={mismatches}",
            flush=True,
        )
        assert mismatches == 0, f"ZERO-TRUST MISMATCH in {tag}!"
        return verified


def zt_verify_d8_pq_deg3(
    orig_tt, basis_tt, N, active_vars, pq_ids, bits_sub, rows_u64, c8_idx_256, z_reps_36, tag="", rng_seed=63700
):
    """Zero-Trust 50-pt verification of extracted deg<=3 D_8 Parseval/Dual-Square rows directly from 65,536-pt TT."""
    K = len(pq_ids)
    if K == 0:
        return []
    R_zt = 50
    rng = random.Random(rng_seed)
    zt_pts = [rng.getrandbits(N) for _ in range(R_zt)]
    zt_111 = []
    PQ_exact = np.zeros((R_zt, 72), dtype=np.int64)
    # Precompute D_8 coset point indices for all 256 z
    u_arr = np.arange(256, dtype=np.uint16)
    z_pts = [(u_arr | ((u_arr ^ z) << 8)) for z in range(256)]

    for r, y in enumerate(zt_pts):
        x = 0
        ftt = orig_tt.copy()
        for i in range(N):
            if (y >> i) & 1:
                x |= (1 << active_vars[i])
                ftt ^= basis_tt[i]
        zt_111.append(x)
        S_full = np.array([256 - 2 * int(ftt[z_pts[z]].sum()) for z in range(256)], dtype=np.int64)
        for d in range(36):
            dv = int(z_reps_36[d])
            acc = sum(int(S_full[z]) * int(S_full[z ^ dv]) for z in range(256))
            if dv == 0:
                acc -= 65536
            PQ_exact[r, d] = acc
        # Direct W_f(v, v) = sum_z S(z) (-1)^{<v, z>}
        for v in range(36):
            vv = int(z_reps_36[v])
            wv = sum(int(S_full[z]) * (-1 if ((z & vv).bit_count() & 1) else 1) for z in range(256))
            PQ_exact[r, 36 + v] = wv * wv - 65536

    verified = []
    mismatches = 0
    for q in range(K):
        pid = pq_ids[q]
        b = bits_sub[q]
        vals = PQ_exact[:, pid]
        if np.any((vals & ((1 << b) - 1)) != 0):
            continue
        ps = s60c.deg3_subrow_to_111_pset(rows_u64[q], N, active_vars, is_deg4_buf=False)
        ok = True
        for r in range(R_zt):
            actual = int((int(vals[r]) >> b) & 1)
            pe = 0
            x111 = zt_111[r]
            for mon in ps:
                if (mon & x111) == mon:
                    pe ^= 1
            if pe != actual:
                ok = False
                mismatches += 1
                break
        if ok:
            verified.append((pid, b, ps))
    print(
        f"    [{tag} D8-PQ ZERO-TRUST 50-PT DIRECT TT (deg<=3)]: "
        f"verified={len(verified)}/{K}, mismatches={mismatches}",
        flush=True,
    )
    assert mismatches == 0, f"D8-PQ ZERO-TRUST MISMATCH in {tag}!"
    return verified


def run_autocorr_and_parseval_suite(
    orig_tt, basis_tt, active_vars, sub_state,
    all_shifts_u16, all_shifts_py, d8_shifts, struct_set, struct_indices,
    c8_idx_256, z_reps_36, z_reps_py,
    lib_ac, lib_d4, lib9, tbl, coord_subs,
    tag="", seed=63100, vq_ctx=None, do_deg4_compare=False, out_states=None
):
    """
    Full suite on an N-variable affine subspace (or V(Q) variety when vq_ctx is given!):
      1. All 4,115 C_16-orbits of a != 0: exact v_2 + degree census + spotlight
      2. 180 structured shifts: 200-tuple 4th-diff & 5th-diff linear-combo drop detector
      3. All 36 P(d) & 36 Q_dual(v): exact v_2 + degree census + 200-tuple combo-drop detector
      4. Extract & 50-sample Zero-Trust verify ANY deg<=3 equations -> inject into s9!
      5. If do_deg4_compare and deg==4 shifts found: extract & ZT-verify deg-4 rows and compare
         GF(2) rank jointly against the 45 coordinate V_13..V_16 deg-4 equations!
    """
    N = len(active_vars)
    is_vq = (vq_ctx is not None)
    R_rand, T4, T5, T6 = 64, 24, 24, 10
    if is_vq:
        nW, nT, nRF, Q_polys_W = vq_ctx
        _, pts_lo, pts_hi = gen_points_vq(nW, nT, nRF, Q_polys_W, R_rand, T4, T5, T6, seed)
    else:
        _, pts_lo, pts_hi = gen_points_affine(N, R_rand, T4, T5, T6, seed)
    R_tot = len(pts_lo)

    # 1. All 4,115 C_16-orbits via FWHT
    t1 = time.perf_counter()
    wt_all = np.zeros((R_tot, len(all_shifts_u16)), dtype=np.int32)
    lib_ac.fwht_autocorr_batch_c(
        orig_tt.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
        basis_tt.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
        N,
        pts_lo.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        pts_hi.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        R_tot,
        all_shifts_u16.ctypes.data_as(ctypes.POINTER(ctypes.c_uint16)),
        len(all_shifts_u16),
        wt_all.ctypes.data_as(ctypes.POINTER(ctypes.c_int32)),
    )
    dt_fwht = time.perf_counter() - t1
    res_ac = analyze_integer_family(wt_all, R_rand, T4, T5, T6, all_shifts_py, max_bit=14, tag=f"{tag}_AC4115 ({dt_fwht:.2f}s)")

    # Print spotlight on key structured shifts
    rep_to_idx = {r: i for i, r in enumerate(all_shifts_py)}
    spot_keys = [0xFFFF, 0x5555, 0x00FF, 0x0101, 0x1111, 0x3333, 0x7777, 0x0001, 0x0003, 0x000F]
    spot_str = ", ".join(
        f"0x{a:04x}:{res_ac['spotlight'][rep_to_idx[canon_c16(a)]][0]}@b{res_ac['spotlight'][rep_to_idx[canon_c16(a)]][1]}"
        for a in spot_keys
    )
    print(f"      [Spotlight]: {spot_str}", flush=True)
    # D_8 35-orbit breakdown
    d8_hist = {}
    for a in d8_shifts:
        cat = res_ac["spotlight"][rep_to_idx[a]]
        d8_hist[cat] = d8_hist.get(cat, 0) + 1
    print(f"      [All 35 D_8 shifts a=(z,z)]: {dict(sorted(d8_hist.items()))}", flush=True)

    # 2. 180 structured shifts: 200-tuple 4th-diff & 5th-diff linear-combo detector
    T4_c, T5_c = 200, 200
    if is_vq:
        _, lo_c, hi_c = gen_points_vq(nW, nT, nRF, Q_polys_W, 0, T4_c, T5_c, 0, seed + 17)
    else:
        _, lo_c, hi_c = gen_points_affine(N, 0, T4_c, T5_c, 0, seed + 17)
    struct_u16 = np.ascontiguousarray(struct_set, dtype=np.uint16)
    wt_c = np.zeros((len(lo_c), len(struct_u16)), dtype=np.int32)
    lib_ac.fwht_autocorr_batch_c(
        orig_tt.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
        basis_tt.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
        N,
        lo_c.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        hi_c.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        len(lo_c),
        struct_u16.ctypes.data_as(ctypes.POINTER(ctypes.c_uint16)),
        len(struct_u16),
        wt_c.ctypes.data_as(ctypes.POINTER(ctypes.c_int32)),
    )
    b_lows_s = [res_ac["spotlight"][idx][1] for idx in struct_indices]
    (valid_ac, null4_ac), _ = detect_linear_combo_drops(
        wt_c[:T4_c * 16].reshape(T4_c, 16, len(struct_u16)),
        wt_c[T4_c * 16:].reshape(T5_c, 32, len(struct_u16)),
        b_lows_s,
        tag=f"{tag}_AC180",
    )

    # 3. All 36 P(d) & 36 Q_dual(v) identities
    orig_36w, basis_36w = s60c.pack_c8_36w(orig_tt, basis_tt, z_reps_py)
    pq_vals = np.zeros((R_tot, 72), dtype=np.int64)
    lib_ac.eval_d8_parseval_batch_c(
        orig_36w.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        basis_36w.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        N,
        pts_lo.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        pts_hi.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        R_tot,
        c8_idx_256.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
        z_reps_36.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
        pq_vals.ctypes.data_as(ctypes.POINTER(ctypes.c_int64)),
    )
    pq_names = [f"P(0x{z:02x})" for z in z_reps_py] + [f"Qd(0x{z:02x})" for z in z_reps_py]
    res_P = analyze_integer_family(pq_vals[:, :36], R_rand, T4, T5, T6, pq_names[:36], max_bit=30, tag=f"{tag}_D8_Parseval_P(36)")
    res_Q = analyze_integer_family(pq_vals[:, 36:], R_rand, T4, T5, T6, pq_names[36:], max_bit=30, tag=f"{tag}_D8_DualSq_Q(36)")

    # Combo-drop detector on P(36) + Q_dual(36)
    pq_c = np.zeros((len(lo_c), 72), dtype=np.int64)
    lib_ac.eval_d8_parseval_batch_c(
        orig_36w.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        basis_36w.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        N,
        lo_c.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        hi_c.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        len(lo_c),
        c8_idx_256.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
        z_reps_36.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
        pq_c.ctypes.data_as(ctypes.POINTER(ctypes.c_int64)),
    )
    b_lows_pq = [res_P["spotlight"][i][1] for i in range(36)] + [res_Q["spotlight"][i][1] for i in range(36)]
    (valid_pq, null4_pq), _ = detect_linear_combo_drops(
        pq_c[:T4_c * 16].reshape(T4_c, 16, 72),
        pq_c[T4_c * 16:].reshape(T5_c, 32, 72),
        b_lows_pq,
        tag=f"{tag}_D8_PQ72",
    )

    # 4. Extract, Zero-Trust verify, and inject ALL deg<=3 equations (single + linear combos!)
    injected_psets = []
    if not is_vq:
        # (4A) Linear-combo deg<=3 drops from AC180!
        if null4_ac:
            used_pos = sorted({ki for cm in null4_ac for ki in range(len(valid_ac)) if (cm >> ki) & 1})
            used_sidx = [valid_ac[ki] for ki in used_pos]
            pos_to_local = {ki: li for li, ki in enumerate(used_pos)}
            sh_u = [int(struct_set[si]) for si in used_sidx]
            bt_u = [int(b_lows_s[si]) for si in used_sidx]
            Ku = len(used_pos)
            n3_cols = s60c.comb3(N) + s60c.comb2(N) + N + 1
            n3_words = (n3_cols + 63) // 64
            out_u = np.zeros((Ku, n3_words), dtype=np.uint64)
            out_stu = np.zeros(Ku, dtype=np.int32)
            lib_ac.extract_deriv_bit_anf_batch_c(
                orig_tt.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
                basis_tt.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
                np.ascontiguousarray(sh_u, dtype=np.uint16).ctypes.data_as(ctypes.POINTER(ctypes.c_uint16)),
                np.ascontiguousarray(bt_u, dtype=np.int32).ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
                Ku, N, 3, n3_words,
                out_u.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
                out_stu.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
            )
            # Zero-Trust verify every combo on 50 fresh random points (direct 65,536-pt TT)!
            R_zt = 50
            rng_z = random.Random(seed + 411)
            mask64 = (1 << 64) - 1
            zt_pts = [rng_z.getrandbits(N) for _ in range(R_zt)]
            zt_lo = np.array([p & mask64 for p in zt_pts], dtype=np.uint64)
            zt_hi = np.array([p >> 64 for p in zt_pts], dtype=np.uint64)
            wt_dir = np.zeros((R_zt, Ku), dtype=np.int32)
            lib_ac.direct_wt15_verify_c(
                orig_tt.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
                basis_tt.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
                N,
                zt_lo.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
                zt_hi.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
                R_zt,
                np.ascontiguousarray(sh_u, dtype=np.uint16).ctypes.data_as(ctypes.POINTER(ctypes.c_uint16)),
                Ku,
                wt_dir.ctypes.data_as(ctypes.POINTER(ctypes.c_int32)),
            )
            zt_111 = []
            for y in zt_pts:
                x = 0
                for i in range(N):
                    if (y >> i) & 1:
                        x |= (1 << active_vars[i])
                zt_111.append(x)
            n_zero, n_1eq0, n_nontriv, n_mis = 0, 0, 0, 0
            for cm in null4_ac:
                kis = [ki for ki in range(len(valid_ac)) if (cm >> ki) & 1]
                lis = [pos_to_local[ki] for ki in kis]
                if any(out_stu[li] != 0 for li in lis):
                    continue
                comb_row = np.zeros(n3_words, dtype=np.uint64)
                for li in lis:
                    comb_row ^= out_u[li]
                ps = s60c.deg3_subrow_to_111_pset(comb_row, N, active_vars, is_deg4_buf=False)
                ok = True
                for r in range(R_zt):
                    actual = 0
                    for li in lis:
                        actual ^= int((wt_dir[r, li] >> bt_u[li]) & 1)
                    pe = 0
                    x111 = zt_111[r]
                    for mon in ps:
                        if (mon & x111) == mon:
                            pe ^= 1
                    if pe != actual:
                        ok = False
                        n_mis += 1
                        break
                if ok:
                    if len(ps) == 0:
                        n_zero += 1
                    elif ps == {0}:
                        n_1eq0 += 1
                        injected_psets.append(ps)
                    else:
                        n_nontriv += 1
                        injected_psets.append(ps)
            print(
                f"    [{tag}_AC180_COMBO_DEG3 ZT 50-PT DIRECT TT]: "
                f"total={len(null4_ac)} -> id_0eq0={n_zero}, *** 1=0={n_1eq0} ***, nontriv={n_nontriv}, mismatches={n_mis}",
                flush=True,
            )
            assert n_mis == 0, f"AC180 combo ZT mismatch in {tag}!"

        # (4B) Linear-combo deg<=3 drops from D8_PQ72!
        if null4_pq:
            used_pos = sorted({ki for cm in null4_pq for ki in range(len(valid_pq)) if (cm >> ki) & 1})
            used_pidx = [valid_pq[ki] for ki in used_pos]
            pos_to_local = {ki: li for li, ki in enumerate(used_pos)}
            bt_p = [int(b_lows_pq[pi]) for pi in used_pidx]
            Kp = len(used_pos)
            n3_cols = s60c.comb3(N) + s60c.comb2(N) + N + 1
            n3_words = (n3_cols + 63) // 64
            out_p = np.zeros((Kp, n3_words), dtype=np.uint64)
            out_mfp = np.zeros(Kp, dtype=np.int32)
            lib_ac.extract_d8_pq_deg3_c(
                orig_36w.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
                basis_36w.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
                c8_idx_256.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
                z_reps_36.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
                np.ascontiguousarray(used_pidx, dtype=np.int32).ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
                np.ascontiguousarray(bt_p, dtype=np.int32).ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
                Kp, N, n3_words,
                out_p.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
                out_mfp.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
            )
            # Zero-Trust 50-pt direct verification
            R_zt = 50
            rng_z = random.Random(seed + 422)
            zt_pts = [rng_z.getrandbits(N) for _ in range(R_zt)]
            u_arr = np.arange(256, dtype=np.uint16)
            z_pts = [(u_arr | ((u_arr ^ z) << 8)) for z in range(256)]
            PQ_ex = np.zeros((R_zt, 72), dtype=np.int64)
            zt_111 = []
            for r, y in enumerate(zt_pts):
                x = 0
                ftt = orig_tt.copy()
                for i in range(N):
                    if (y >> i) & 1:
                        x |= (1 << active_vars[i])
                        ftt ^= basis_tt[i]
                zt_111.append(x)
                S_full = np.array([256 - 2 * int(ftt[z_pts[z]].sum()) for z in range(256)], dtype=np.int64)
                for d in range(36):
                    dv = int(z_reps_36[d])
                    acc = sum(int(S_full[z]) * int(S_full[z ^ dv]) for z in range(256))
                    if dv == 0:
                        acc -= 65536
                    PQ_ex[r, d] = acc
                for v in range(36):
                    vv = int(z_reps_36[v])
                    wv = sum(int(S_full[z]) * (-1 if ((z & vv).bit_count() & 1) else 1) for z in range(256))
                    PQ_ex[r, 36 + v] = wv * wv - 65536
            n_zero, n_1eq0, n_nontriv, n_mis = 0, 0, 0, 0
            for cm in null4_pq:
                kis = [ki for ki in range(len(valid_pq)) if (cm >> ki) & 1]
                lis = [pos_to_local[ki] for ki in kis]
                if any(out_mfp[li] != 0 for li in lis):
                    continue
                comb_row = np.zeros(n3_words, dtype=np.uint64)
                for li in lis:
                    comb_row ^= out_p[li]
                ps = s60c.deg3_subrow_to_111_pset(comb_row, N, active_vars, is_deg4_buf=False)
                ok = True
                for r in range(R_zt):
                    actual = 0
                    for li in lis:
                        actual ^= int((int(PQ_ex[r, used_pidx[li]]) >> bt_p[li]) & 1)
                    pe = 0
                    x111 = zt_111[r]
                    for mon in ps:
                        if (mon & x111) == mon:
                            pe ^= 1
                    if pe != actual:
                        ok = False
                        n_mis += 1
                        break
                if ok:
                    if len(ps) == 0:
                        n_zero += 1
                    elif ps == {0}:
                        n_1eq0 += 1
                        injected_psets.append(ps)
                    else:
                        n_nontriv += 1
                        injected_psets.append(ps)
            print(
                f"    [{tag}_D8_PQ72_COMBO_DEG3 ZT 50-PT DIRECT TT]: "
                f"total={len(null4_pq)} -> id_0eq0={n_zero}, *** 1=0={n_1eq0} ***, nontriv={n_nontriv}, mismatches={n_mis}",
                flush=True,
            )
            assert n_mis == 0, f"D8_PQ72 combo ZT mismatch in {tag}!"

        # (4C) Single-shift deg<=3 equations (if any outside AC180)
        if res_ac["deg3"]:
            sub_d3 = res_ac["deg3"][:64]
            sh_d3 = [int(all_shifts_py[m]) for m, _ in sub_d3]
            bt_d3 = [int(b) for _, b in sub_d3]
            K3 = len(sub_d3)
            n3_cols = s60c.comb3(N) + s60c.comb2(N) + N + 1
            n3_words = (n3_cols + 63) // 64
            out_r3 = np.zeros((K3, n3_words), dtype=np.uint64)
            out_st = np.zeros(K3, dtype=np.int32)
            lib_ac.extract_deriv_bit_anf_batch_c(
                orig_tt.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
                basis_tt.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
                np.ascontiguousarray(sh_d3, dtype=np.uint16).ctypes.data_as(ctypes.POINTER(ctypes.c_uint16)),
                np.ascontiguousarray(bt_d3, dtype=np.int32).ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
                K3, N, 3, n3_words,
                out_r3.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
                out_st.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
            )
            ok_idx = [i for i in range(K3) if out_st[i] == 0]
            if ok_idx:
                ver_ac = zt_verify_deriv_rows(
                    orig_tt, basis_tt, N, active_vars,
                    [sh_d3[i] for i in ok_idx], [bt_d3[i] for i in ok_idx],
                    out_r3[ok_idx], 3, lib_ac, tag=f"{tag}_AC_DEG3", rng_seed=seed + 501
                )
                injected_psets.extend([ps for _, _, ps in ver_ac])

        pq_d3 = [(m, b) for m, b in res_P["deg3"]] + [(36 + m, b) for m, b in res_Q["deg3"]]
        if pq_d3:
            Kpq = len(pq_d3)
            n3_cols = s60c.comb3(N) + s60c.comb2(N) + N + 1
            n3_words = (n3_cols + 63) // 64
            out_rpq = np.zeros((Kpq, n3_words), dtype=np.uint64)
            out_mf = np.zeros(Kpq, dtype=np.int32)
            pids = np.ascontiguousarray([x[0] for x in pq_d3], dtype=np.int32)
            pbs = np.ascontiguousarray([x[1] for x in pq_d3], dtype=np.int32)
            lib_ac.extract_d8_pq_deg3_c(
                orig_36w.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
                basis_36w.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
                c8_idx_256.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
                z_reps_36.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
                pids.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
                pbs.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
                Kpq, N, n3_words,
                out_rpq.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
                out_mf.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
            )
            ok_idx = [i for i in range(Kpq) if out_mf[i] == 0]
            if ok_idx:
                ver_pq = zt_verify_d8_pq_deg3(
                    orig_tt, basis_tt, N, active_vars,
                    [int(pids[i]) for i in ok_idx], [int(pbs[i]) for i in ok_idx],
                    out_rpq[ok_idx], c8_idx_256, z_reps_36, tag=f"{tag}_PQ_DEG3", rng_seed=seed + 601
                )
                injected_psets.extend([ps for _, _, ps in ver_pq])

        if injected_psets and sub_state is not None:
            sub_new, chg = s60c.inject_psets_into_s9(sub_state, injected_psets, lib9, tbl)
            if out_states is not None:
                out_states["sub_ac"] = sub_new
                out_states["injected_psets"] = list(injected_psets)
            print(
                f"    [{tag} *** INJECT {len(injected_psets)} ZT-VERIFIED DEG<=3 EQS INTO s9 ***]: "
                f"changed={chg}, CLOSED_UNSAT={sub_new['closed_unsat']}, "
                f"N={111 - len(sub_new['_lin_pivs'])} (was {N}), "
                f"q={len(sub_new['_quad_ids'])} (was {len(sub_state['_quad_ids'])}), "
                f"c={len(sub_new['_cub_ids'])} (was {len(sub_state['_cub_ids'])})",
                flush=True,
            )

        # 5. If deg==4 derivative equations exist, extract & ZT-verify & compare with V_13..V_16!
        if do_deg4_compare and res_ac["deg4"] and N <= 109:
            sub_d4 = res_ac["deg4"][:40]
            sh_d4 = [int(all_shifts_py[m]) for m, _ in sub_d4]
            bt_d4 = [int(b) for _, b in sub_d4]
            K4 = len(sub_d4)
            n4 = s60c.comb4(N)
            ntot = n4 + s60c.comb3(N) + s60c.comb2(N) + N + 1
            n_words = (ntot + 63) // 64
            out_r4 = np.zeros((K4, n_words), dtype=np.uint64)
            out_st4 = np.zeros(K4, dtype=np.int32)
            t_e4 = time.perf_counter()
            lib_ac.extract_deriv_bit_anf_batch_c(
                orig_tt.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
                basis_tt.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
                np.ascontiguousarray(sh_d4, dtype=np.uint16).ctypes.data_as(ctypes.POINTER(ctypes.c_uint16)),
                np.ascontiguousarray(bt_d4, dtype=np.int32).ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
                K4, N, 4, n_words,
                out_r4.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
                out_st4.ctypes.data_as(ctypes.POINTER(ctypes.c_int)),
            )
            ok4 = [i for i in range(K4) if out_st4[i] == 0]
            print(f"    [{tag} AC deg==4 extracted]: ok={len(ok4)}/{K4} ({time.perf_counter()-t_e4:.2f}s)", flush=True)
            if ok4:
                ver4 = zt_verify_deriv_rows(
                    orig_tt, basis_tt, N, active_vars,
                    [sh_d4[i] for i in ok4], [bt_d4[i] for i in ok4],
                    out_r4[ok4], 4, lib_ac, tag=f"{tag}_AC_DEG4", rng_seed=seed + 701
                )
                if ver4:
                    ac_rows4 = out_r4[ok4][ver4]
                    s60c.echelon_and_harvest_deg3_drops(
                        ac_rows4, n4, ntot, N, active_vars, lib_d4, tag=f"{tag}_AC_DEG4_ONLY"
                    )
                    # Joint comparison with 45 coord V_13..V_16 deg-4 equations!
                    rows_v13, n4_v, ntot_v = s60c.extract_and_audit_deg4_family(
                        orig_tt, basis_tt, coord_subs, lib_d4, tag=f"{tag}_V13_45_REF", rng_seed=seed + 750
                    )
                    assert n4_v == n4 and ntot_v == ntot
                    joint = np.vstack([rows_v13, ac_rows4])
                    rk_j, j_drops, _ = s60c.echelon_and_harvest_deg3_drops(
                        joint, n4, ntot, N, active_vars, lib_d4, tag=f"{tag}_JOINT_V13(45)+AC_DEG4({len(ac_rows4)})"
                    )
                    if j_drops and sub_state is not None:
                        if out_states is not None:
                            out_states["j_drops"] = list(j_drops)
                        sub_j, chg = s60c.inject_psets_into_s9(sub_state, j_drops, lib9, tbl)
                        print(
                            f"    [{tag} *** JOINT V13+AC DEG<=3 INJECT ({len(j_drops)} drops) ***]: "
                            f"changed={chg}, CLOSED_UNSAT={sub_j['closed_unsat']}, "
                            f"N={111 - len(sub_j['_lin_pivs'])}, q={len(sub_j['_quad_ids'])}, c={len(sub_j['_cub_ids'])}",
                            flush=True,
                        )

    return res_ac, res_P, res_Q


# ==============================================================================
# Main Driver
# ==============================================================================
def setup_cell_env(cell_name):
    t0 = time.perf_counter()
    print(f"\n================================================================================", flush=True)
    print(f"  [{cell_name}] STEP 63A ENV SETUP", flush=True)
    print(f"================================================================================", flush=True)

    # Compile C libraries
    c_ac, so_ac = WORK_DIR / "s63a_ac.c", WORK_DIR / "libs63a_ac.so"
    c_ac.write_text(C_STEP63A_SRC, encoding="utf-8")
    subprocess.run(
        ["gcc", "-O3", "-march=native", "-fopenmp", "-shared", "-fPIC", str(c_ac), "-o", str(so_ac)],
        check=True,
    )
    lib_ac = ctypes.CDLL(str(so_ac))
    lib_ac.fwht_autocorr_batch_c.argtypes = [
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8), ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint16), ctypes.c_int, ctypes.POINTER(ctypes.c_int32),
    ]
    lib_ac.direct_wt15_verify_c.argtypes = lib_ac.fwht_autocorr_batch_c.argtypes
    lib_ac.eval_d8_parseval_batch_c.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int64),
    ]
    lib_ac.extract_deriv_bit_anf_batch_c.argtypes = [
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_uint16), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_uint64,
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
    ]
    lib_ac.extract_d8_pq_deg3_c.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.c_uint64,
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
    ]

    # Compile Step 60C deg-4 C lib + diag/s9/cg/shear
    c_d4, so_d4 = WORK_DIR / "s63a_d4.c", WORK_DIR / "libs63a_d4.so"
    c_d4.write_text(s60c.C_DEG4_SRC, encoding="utf-8")
    subprocess.run(
        ["gcc", "-O3", "-march=native", "-fopenmp", "-shared", "-fPIC", str(c_d4), "-o", str(so_d4)],
        check=True,
    )
    lib_d4 = ctypes.CDLL(str(so_d4))
    lib_d4.extract_wt_div8_deg4_batch_c.argtypes = [
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_uint16), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.c_uint64, ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
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

    c_diag, so_diag = WORK_DIR / "s63a_diag.c", WORK_DIR / "libs63a_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s63a_s9.c", WORK_DIR / "libs63a_s9.so"
    c_s9.write_text(s9.C_STEP9_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_s9), "-o", str(so_s9)], check=True)
    lib9 = s45a._setup_lib9(so_s9)

    c_cg, so_cg = WORK_DIR / "s63a_cg.c", WORK_DIR / "libs63a_cg.so"
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

    c_sh, so_sh = WORK_DIR / "s63a_sh.c", WORK_DIR / "libs63a_sh.so"
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

    # Build orbits, CG(389) root system, and 111-var truth tables
    orbits = diag_v2.build_orbits_116()
    layer_vecs = s16.build_orb_degu_degz_vecs(orbits)
    mon_to_orb_arr = (ctypes.c_int16 * 65536)(*([-1] * 65536))
    for j, orb in enumerate(orbits):
        for m in orb:
            mon_to_orb_arr[m] = j
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

    X = np.arange(65536, dtype=np.uint16)
    orb_tts = [bytearray(65536) for _ in range(116)]
    orb_tt_np = np.zeros((116, 65536), dtype=np.uint8)
    orb_diag, orb_pair, orb_r4, orb_0xf_parity = [0] * 116, [0] * 116, [0] * 116, [0] * 116
    for j, orb in enumerate(orbits):
        acc = np.zeros(65536, dtype=np.uint8)
        for m in orb:
            acc ^= ((X & m) == m).astype(np.uint8)
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
    c99, c57, c113 = int(cell_name[1]), int(cell_name[3]), int(cell_name[4])
    free111, origin111, cb111 = b09.build_pure_111_basis(c99, c57, c113)

    b_tt_111 = np.zeros((111, 65536), dtype=np.uint8)
    for i, m in enumerate(cb111):
        tmp = m
        while tmp:
            lb = tmp & -tmp
            b_tt_111[i] ^= orb_tt_np[lb.bit_length() - 1]
            tmp ^= lb
    o_tt_111 = np.zeros(65536, dtype=np.uint8)
    tmp = origin111
    while tmp:
        lb = tmp & -tmp
        o_tt_111 ^= orb_tt_np[lb.bit_length() - 1]
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
            n, tbl["off2"], tbl["off1"], tbl["off0"], n_cw, tbl["col2_base"], tbl["col3_base"], rptr,
        )
    for idx, I_m in enumerate(reps11):
        rptr = ctypes.cast(ctypes.byref(cg_buf, (len(reps12) + idx) * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
        lib_cg.build_cg11_row_c(
            I_m, mon_to_orb_arr, orb_map, c99, L_vars_arr, len(L_vars_py),
            n, tbl["off2"], tbl["off1"], tbl["off0"], n_cw, tbl["col2_base"], tbl["col3_base"], rptr,
        )

    sys_data = diag_v2.build_cell_algebraic_system(cell_name, lib_diag, orbits, v6_list, rot4_data, fiber_meta, extract_sec=18.0)
    cyc_cubs = s9.extract_verified_cyclotomic_cubics(cell_name, orbits, origin111, cb111, layers, c0x0)
    n_base = sum(sys_data["deg_pivs_111"].values())
    total_base = n_base + len(cyc_cubs) + n_cg
    base_buf = (ctypes.c_uint64 * (total_base * n_cw))()
    ctypes.memmove(base_buf, sys_data["rows_c"], n_base * n_cw * 8)
    for idx_c, (_, poly) in enumerate(cyc_cubs):
        s9.pset_to_row(poly, base_buf, n_base + idx_c, tbl)
    ctypes.memmove(ctypes.byref(base_buf, (n_base + len(cyc_cubs)) * n_cw * 8), cg_buf, n_cg * n_cw * 8)

    root = s9.run_branch_cascade(lib9, base_buf, [], list(range(total_base)), {}, [], tbl, max_xl_rounds=20, verify_subst=True)
    root_act = sorted(i for i in range(111) if i not in root["_lin_pivs"])
    N_root = len(root_act)
    print(f"  [ROOT CG(389)] N={N_root}, q={len(root['_quad_ids'])}, c={len(root['_cub_ids'])} ({time.perf_counter()-t0:.1f}s)", flush=True)

    # Eta basis (Layer 1: deg_u=3, deg_z=1)
    forms_L1 = s16.extract_forms_from_orb_vecs(cb111, layer_vecs["L1"][1], layer_vecs["L1"][0])
    eta_free = s16.reduce_forms_mod_pivs(forms_L1, root["_lin_pivs"])

    # Precompute shift lists, C_8 tables, and 45 coord V_13..V_16 subspaces
    all_shifts_u16, all_shifts_py, d8_shifts, struct_set, struct_indices = build_all_4115_c16_shifts()
    c8_idx_256, z_reps_36, z_reps_py = build_c8_orbit_tables()
    coord_subs = s60c.build_coordinate_subspaces()

    return {
        "t0": t0, "lib_ac": lib_ac, "lib_d4": lib_d4, "lib9": lib9, "lib_sh": lib_sh,
        "tbl": tbl, "root": root, "root_act": root_act, "N_root": N_root,
        "eta_free": eta_free, "o_tt_111": o_tt_111, "b_tt_111": b_tt_111,
        "all_shifts_u16": all_shifts_u16, "all_shifts_py": all_shifts_py,
        "d8_shifts": d8_shifts, "struct_set": struct_set, "struct_indices": struct_indices,
        "c8_idx_256": c8_idx_256, "z_reps_36": z_reps_36, "z_reps_py": z_reps_py,
        "coord_subs": coord_subs,
    }


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cell", choices=["B0_11", "B1_11"], required=True)
    args = parser.parse_args()
    cell_name = args.cell
    env = setup_cell_env(cell_name)
    t0 = env["t0"]
    lib_ac, lib_d4, lib9, lib_sh = env["lib_ac"], env["lib_d4"], env["lib9"], env["lib_sh"]
    tbl, root, root_act, N_root = env["tbl"], env["root"], env["root_act"], env["N_root"]
    eta_free, o_tt_111, b_tt_111 = env["eta_free"], env["o_tt_111"], env["b_tt_111"]
    all_shifts_u16, all_shifts_py = env["all_shifts_u16"], env["all_shifts_py"]
    d8_shifts, struct_set, struct_indices = env["d8_shifts"], env["struct_set"], env["struct_indices"]
    c8_idx_256, z_reps_36, z_reps_py = env["c8_idx_256"], env["z_reps_36"], env["z_reps_py"]
    coord_subs = env["coord_subs"]

    # ==========================================================================
    # ZERO-TRUST KERNEL SELF-TEST (FWHT vs Direct 65536-pt TT, and D8-PQ vs Direct)
    # ==========================================================================
    orig_root, basis_root, _, _ = s60c.build_affine_tt_basis(o_tt_111, b_tt_111, root["_lin_pivs"], root_act)
    _, zt_lo, zt_hi = gen_points_affine(N_root, 16, 0, 0, 0, 63999)
    test_sh = np.ascontiguousarray(struct_set[:50], dtype=np.uint16)
    wt_fwht = np.zeros((16, 50), dtype=np.int32)
    wt_dir = np.zeros((16, 50), dtype=np.int32)
    lib_ac.fwht_autocorr_batch_c(
        orig_root.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
        basis_root.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
        N_root,
        zt_lo.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        zt_hi.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        16, test_sh.ctypes.data_as(ctypes.POINTER(ctypes.c_uint16)), 50,
        wt_fwht.ctypes.data_as(ctypes.POINTER(ctypes.c_int32)),
    )
    lib_ac.direct_wt15_verify_c(
        orig_root.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
        basis_root.ctypes.data_as(ctypes.POINTER(ctypes.c_uint8)),
        N_root,
        zt_lo.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        zt_hi.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)),
        16, test_sh.ctypes.data_as(ctypes.POINTER(ctypes.c_uint16)), 50,
        wt_dir.ctypes.data_as(ctypes.POINTER(ctypes.c_int32)),
    )
    assert np.array_equal(wt_fwht, wt_dir), "FWHT vs Direct wt_15 MISMATCH!"
    assert np.all((wt_dir & 15) == 0), "Ax theorem 16 | wt_15(D_a f) violated!"
    print(f"  [ZT-0 KERNEL SELF-TEST] FWHT vs Direct 65,536-pt TT: 16x50 = 800/800 EXACT MATCHES (16|wt_15 verified!)", flush=True)

    # ==========================================================================
    # PART 1: ROOT (N=109)
    # ==========================================================================
    print(f"\n==================== PART 1: [{cell_name}] ROOT (N={N_root}) ====================", flush=True)
    run_autocorr_and_parseval_suite(
        orig_root, basis_root, root_act, root,
        all_shifts_u16, all_shifts_py, d8_shifts, struct_set, struct_indices,
        c8_idx_256, z_reps_36, z_reps_py,
        lib_ac, lib_d4, lib9, tbl, coord_subs,
        tag=f"{cell_name}_ROOT", seed=63100, vq_ctx=None, do_deg4_compare=True,
    )

    # ==========================================================================
    # PART 2: FIXED-ETA (AFFINE AND DIRECT ON QUADRATIC VARIETY V(Q))
    # ==========================================================================
    test_etas = [0, 5, 9, 11] if cell_name == "B0_11" else [0, 3, 8, 10]
    print(f"\n==================== PART 2: [{cell_name}] FIXED-ETA (AFFINE + V(Q)) ====================", flush=True)
    eta_cache = {}
    mask64 = (1 << 64) - 1

    for em in test_etas:
        print(f"\n  ---------------- [{cell_name} eta={em}] ----------------", flush=True)
        ex_eta = [(eta_free[k], (em >> k) & 1) for k in range(len(eta_free))]
        sr = s9.run_branch_cascade(
            lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
            ex_eta, tbl, max_xl_rounds=20, verify_subst=False,
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

        # Shear quadratics to extract exact T_rref & Q_m(w)
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
                    p, rest & mask64, rest >> 64,
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
                    p, rest & mask64, rest >> 64,
                )

        w_idx = {v: i for i, v in enumerate(W_pivs)}
        t_idx = {v: i for i, v in enumerate(T_pivs)}
        Q_polys_W = [set() for _ in range(nT)]
        q_psets_sh = [s9.row_to_pset(work_q, qi, tbl) for qi in range(n_q)]
        t_rows = []
        for ps in q_psets_sh:
            tm, wp = 0, set()
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
                            wm |= (1 << w_idx[v])
                        wp.add(wm)
            t_rows.append((tm, wp))
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
        for b in sorted(piv_t.keys(), reverse=True):
            pt, pw = piv_t[b]
            for b2 in sorted(piv_t.keys()):
                if b2 < b and ((piv_t[b2][0] >> b) & 1):
                    piv_t[b2] = (piv_t[b2][0] ^ pt, piv_t[b2][1] ^ pw)
        for m in range(nT):
            assert m in piv_t and piv_t[m][0] == (1 << m)
            Q_polys_W[m] = piv_t[m][1]

        print(f"    [{cell_name} eta={em}] N={len(active_now)} (nW={nW}, nT={nT}, nRF={nRF}), q={n_q}, c={len(sr['_cub_ids'])}", flush=True)
        eta_cache[em] = (sr, W_forms_111, W_pivs, nW, nT, nRF)

        # (2A) Affine Fixed-eta
        orig_act, basis_act, _, _ = s60c.build_affine_tt_basis(o_tt_111, b_tt_111, sr["_lin_pivs"], active_now)
        run_autocorr_and_parseval_suite(
            orig_act, basis_act, active_now, sr,
            all_shifts_u16, all_shifts_py, d8_shifts, struct_set, struct_indices,
            c8_idx_256, z_reps_36, z_reps_py,
            lib_ac, lib_d4, lib9, tbl, coord_subs,
            tag=f"{cell_name}_eta{em}_AFF", seed=63200 + em * 10, vq_ctx=None, do_deg4_compare=(em in (0, 5, 3)),
        )

        # (2B) Direct on V(Q) (modding out all 17 Q_t quadratics!)
        orig_sh, basis_sh, x0_sh, tan111_sh = s60c.build_sheared_tt_basis(
            o_tt_111, b_tt_111, sr["_lin_pivs"], W_rref, W_pivs, T_rref, T_pivs, RF_vars
        )
        run_autocorr_and_parseval_suite(
            orig_sh, basis_sh, active_now, None,
            all_shifts_u16, all_shifts_py, d8_shifts, struct_set, struct_indices,
            c8_idx_256, z_reps_36, z_reps_py,
            lib_ac, lib_d4, lib9, tbl, coord_subs,
            tag=f"{cell_name}_eta{em}_VQ", seed=63300 + em * 10, vq_ctx=(nW, nT, nRF, Q_polys_W), do_deg4_compare=False,
        )

    # ==========================================================================
    # PART 3: SHATTERED s9 FIBERS (B0_11 eta=5,0 d1=26,28; B1_11 eta=3,0 d1=20,22)
    # ==========================================================================
    print(f"\n==================== PART 3: [{cell_name}] SHATTERED s9 FIBERS ====================", flush=True)
    shatter_etas = [5, 0] if cell_name == "B0_11" else [3, 0]
    d_cands = [26, 28] if cell_name == "B0_11" else [20, 22]
    rng_f = np.random.default_rng(6390)

    for em in shatter_etas:
        if em not in eta_cache:
            continue
        sr, W_forms_111, W_pivs, nW, nT, nRF = eta_cache[em]
        sys_ex = s45b.extract_eta_exact_system(em, root, eta_free, lib9, lib_sh, tbl, rng_seed=6390 + em)
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
            assert k_fix == nW - d_free
            assert np.all(((U1 @ F_sub.T) & 1) == 0)

            fix_forms = []
            for row in F_sub:
                fm = 0
                for k in range(nW):
                    if row[k]:
                        fm ^= W_forms_111[k]
                fix_forms.append(fm)

            print(f"\n    --- d_free={d_free} (k_fix={k_fix}, r1_elim={bkey[0]}) ---", flush=True)
            n_open = 0
            for tr in range(4):
                rb = 0 if tr == 0 else int(rng_f.integers(1, 1 << min(30, k_fix)))
                ex_w = [(fix_forms[j], (rb >> j) & 1) for j in range(k_fix)]
                sub = s9.run_branch_cascade(
                    lib9, sr["_buf"], sr["_quad_ids"], sr["_cub_ids"], sr["_lin_pivs"],
                    ex_w, tbl, max_xl_rounds=25, verify_subst=False,
                )
                if sub["closed_unsat"]:
                    print(f"      [fiber {tr}] BASELINE s9 CLOSED UNSAT", flush=True)
                    continue
                f_act = sorted(i for i in range(111) if i not in sub["_lin_pivs"])
                N_f = len(f_act)
                print(
                    f"      [fiber {tr}] OPEN BASELINE: N_act={N_f}, q={len(sub['_quad_ids'])}, c={len(sub['_cub_ids'])}",
                    flush=True,
                )
                if n_open >= 2:
                    continue
                n_open += 1
                orig_f, basis_f, _, _ = s60c.build_affine_tt_basis(o_tt_111, b_tt_111, sub["_lin_pivs"], f_act)
                run_autocorr_and_parseval_suite(
                    orig_f, basis_f, f_act, sub,
                    all_shifts_u16, all_shifts_py, d8_shifts, struct_set, struct_indices,
                    c8_idx_256, z_reps_36, z_reps_py,
                    lib_ac, lib_d4, lib9, tbl, coord_subs,
                    tag=f"{cell_name}_e{em}_d{d_free}_f{tr}",
                    seed=63500 + em * 100 + d_free * 10 + tr,
                    vq_ctx=None,
                    do_deg4_compare=True,
                )

    print(f"\n[STEP 63A {cell_name}] COMPLETED ALL PARTS in {time.perf_counter()-t0:.1f}s!", flush=True)


if __name__ == "__main__":
    main()
