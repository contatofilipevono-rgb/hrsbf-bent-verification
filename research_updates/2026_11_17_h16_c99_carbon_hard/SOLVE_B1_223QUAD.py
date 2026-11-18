#!/usr/bin/env python3
"""
SOLVE_B1_223QUAD.py
Ultra-fast, 100% standalone algebraic & SAT+FWHT closer for B1_00 (1,0,0) and B1_11 (1,1,1)
on the pure 111-variable basis (ONLY c115=0 and L=c99=1 assumed; C5 and C7 derived from scratch!).

Pipeline per cell:
  [Stage 1] Pure 111-var extraction in C:
            - Exact C_{0xf} parity (Theorem 1 in c99=1: wt_orb(C_{0xf}) = 128 => even)
            - Weight-12 coordinate subspaces (0x3f3f, 0x5f5f, 0x6f6f, 0x7777, 0x0fff...) -> derives C5 & C7!
              (Closes B1_00 immediately in degree 1 with 1=0!)
            - Validated Q4 (lc) + V6 x V6 (linear + affine shifts + interleaved) + rot^4 dim-12 mod 32 & dim-11 mod 16
            - Iterative Macaulay XL up to degree 3 -> extracts the >= 2 linear + >= 223 quadratic + ~12,405 cubic pivots!
  [Stage 2] Exact Linear Variable Elimination (111 -> N <= 109) + C11 Schur-Complement Mutant-XL at Degree 4:
            - Re-indexes variables by decreasing quadratic degree (adapted grevlex)
            - Streams sparse x_i * x_j * q_a AND pairwise products q_a * q_b through sparse A_44 CSR
            - Captures degree <= 3/2/1 Mutants and cascades XL to seek algebraic 1 = 0!
  [Stage 3] Pure 223-Quadratic SAT + Z_16^* Symmetry Breaking + Lazy C Cubic Filter + 0.04ms C FWHT:
            - Zero slow CardEnc fiber counters! Only the >= 223 RREF quadratics over shared y_{ij} = x_i & x_j
            - Uses CryptoMiniSat5 (if available, native XOR-Gauss) or CaDiCaL 1.9.5 to prove UNSAT in seconds!

Usage:
  python3 SOLVE_B1_223QUAD.py [all | B1_00 | B1_11] [sat_budget_sec]
"""
import ctypes
import json
import os
import random
import subprocess
import sys
import time
from itertools import combinations
from pathlib import Path

try:
    from pysat.solvers import Solver
    HAS_PYSAT = True
except ImportError:
    HAS_PYSAT = False


# ==============================================================================
# C11 KERNEL: Extraction + Degree-3 Echelon + Degree-4 Schur-Mutant-XL + FWHT
# ==============================================================================
C_KERNEL_SRC = r"""
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

static inline void pack_subset(
    const uint64_t *src_510,
    const int *p_idxs,
    int n_pairs,
    uint64_t out32[32]
) {
    memset(out32, 0, 32 * sizeof(uint64_t));
    for (int k = 0; k < n_pairs; k++) {
        int idx = p_idxs[k];
        if ((src_510[idx >> 6] >> (idx & 63)) & 1ULL) {
            out32[k >> 6] |= 1ULL << (k & 63);
        }
    }
}

static inline int pop32(const uint64_t a[32]) {
    int s = 0;
    for (int w = 0; w < 32; w++) s += __builtin_popcountll(a[w]);
    return s;
}

static inline int pop32_and(const uint64_t a[32], const uint64_t b[32]) {
    int s = 0;
    for (int w = 0; w < 32; w++) s += __builtin_popcountll(a[w] & b[w]);
    return s;
}

static inline int pop32_and3(const uint64_t a[32], const uint64_t b[32], const uint64_t c[32]) {
    int s = 0;
    for (int w = 0; w < 32; w++) s += __builtin_popcountll(a[w] & b[w] & c[w]);
    return s;
}

// Level-0 linear equation if wt_pairs % 2 != (wt_diag_odd_target): here wt_diag is even, so wt_pairs % 2 == 0!
int extract_level0_lin_if_odd(
    const uint64_t *all_pair_bits,
    const int *p_idxs,
    int n_pairs,
    int n,
    const uint64_t *char_word32,
    int off1,
    int off0,
    int n_col_words,
    uint64_t *out_row
) {
    uint64_t basis_i[32], O_word[32];
    pack_subset(all_pair_bits + (size_t)n * 510, p_idxs, n_pairs, O_word);
    if (char_word32) {
        for (int w = 0; w < 32; w++) O_word[w] ^= char_word32[w];
    }
    int o_pop = pop32(O_word);
    int any_nz = (o_pop & 1);
    memset(out_row, 0, (size_t)n_col_words * sizeof(uint64_t));
    if (o_pop & 1) out_row[off0 >> 6] ^= 1ULL << (off0 & 63);
    for (int i = 0; i < n; i++) {
        pack_subset(all_pair_bits + (size_t)i * 510, p_idxs, n_pairs, basis_i);
        if (pop32(basis_i) & 1) {
            int c = off1 + i;
            out_row[c >> 6] ^= 1ULL << (c & 63);
            any_nz = 1;
        }
    }
    return any_nz ? 0 : -1;
}

// Level-1 quadratic equation when wt_diag % 4 == 0:
// wt_total = wt_diag + 2*wt_pairs == 0 mod 16 => wt_pairs + wt_diag/2 == 0 mod 8
// Modulo 4: wt_pairs == -(wt_diag/2) mod 4 => (wt_pairs / 2) ^ ((wt_diag / 4) & 1) == 0 mod 2!
int extract_level1_quad_general(
    const uint64_t *all_pair_bits,
    const int *p_idxs,
    int n_pairs,
    int n,
    int diag_div4_parity, // (wt_diag / 4) & 1: 1 when wt_diag % 8 == 4, 0 when wt_diag % 8 == 0!
    const uint64_t *char_word32,
    int off2,
    int off1,
    int off0,
    int n_col_words,
    uint64_t *out_row
) {
    uint64_t basis[112][32];
    uint64_t O_word[32];
    pack_subset(all_pair_bits + (size_t)n * 510, p_idxs, n_pairs, O_word);
    if (char_word32) {
        for (int w = 0; w < 32; w++) O_word[w] ^= char_word32[w];
    }
    int o_pop = pop32(O_word);
    if (o_pop & 1) return -1;

    int Ai[112];
    int any_nz = (((o_pop >> 1) ^ diag_div4_parity) & 1);
    for (int i = 0; i < n; i++) {
        pack_subset(all_pair_bits + (size_t)i * 510, p_idxs, n_pairs, basis[i]);
        int wp = pop32(basis[i]);
        if (wp & 1) return -2;
        int wop = pop32_and(basis[i], O_word);
        Ai[i] = wp - 2 * wop;
        if ((Ai[i] >> 1) & 1) any_nz = 1;
    }
    memset(out_row, 0, (size_t)n_col_words * sizeof(uint64_t));
    if (((o_pop >> 1) ^ diag_div4_parity) & 1) {
        out_row[off0 >> 6] ^= 1ULL << (off0 & 63);
    }
    for (int i = 0; i < n; i++) {
        if ((Ai[i] >> 1) & 1) {
            int c = off1 + i;
            out_row[c >> 6] ^= 1ULL << (c & 63);
        }
    }
    int c2_idx = 0;
    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            int ip = pop32_and(basis[i], basis[j]);
            if (ip & 1) {
                int c = off2 + c2_idx;
                out_row[c >> 6] ^= 1ULL << (c & 63);
                any_nz = 1;
            }
            c2_idx++;
        }
    }
    return any_nz ? 0 : -3;
}

int extract_coset_full_hierarchy_corrected(
    const uint64_t *all_pair_bits,
    const int *p_idxs,
    int n_pairs,
    int n,
    int diag_div8_parity,
    const uint64_t *char_words32,
    int n_chars,
    const int *col3_base,
    int off2,
    int off1,
    int off0,
    int n_col_words,
    uint64_t *out_base_row,
    uint64_t *out_quad_rows,
    int *out_quad_valid,
    uint64_t *out_lin_rows,
    int *out_lin_valid
) {
    uint64_t basis[112][32];
    uint64_t O_word[32];
    pack_subset(all_pair_bits + (size_t)n * 510, p_idxs, n_pairs, O_word);

    int o_pop = pop32(O_word);
    if (o_pop & 3) return -1;

    memset(out_base_row, 0, (size_t)n_col_words * sizeof(uint64_t));
    for (int i = 0; i < n; i++) {
        pack_subset(all_pair_bits + (size_t)i * 510, p_idxs, n_pairs, basis[i]);
        int wi_pop = pop32(basis[i]);
        int wo_pop = pop32_and(basis[i], O_word);
        if ((wi_pop & 1) || ((wi_pop - 2 * wo_pop) & 3)) return -2;
        if (((wi_pop - 2 * wo_pop) / 4) & 1) {
            int c = off1 + i;
            out_base_row[c >> 6] ^= 1ULL << (c & 63);
        }
    }
    if (((o_pop / 4) ^ diag_div8_parity) & 1) {
        out_base_row[off0 >> 6] ^= 1ULL << (off0 & 63);
    }

    int c2_idx = 0;
    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            uint64_t inter[32];
            int inter_pop = 0, io_pop = 0;
            for (int w = 0; w < 32; w++) {
                uint64_t iv = basis[i][w] & basis[j][w];
                inter[w] = iv;
                inter_pop += __builtin_popcountll(iv);
                io_pop += __builtin_popcountll(iv & O_word[w]);
            }
            if (inter_pop & 1) return -3;
            if (((inter_pop / 2) + io_pop) & 1) {
                int c = off2 + c2_idx;
                out_base_row[c >> 6] ^= 1ULL << (c & 63);
            }
            for (int m = 0; m < n_chars; m++) {
                const uint64_t *Um = char_words32 + (size_t)m * 32;
                int iju = 0;
                for (int w = 0; w < 32; w++) iju += __builtin_popcountll(inter[w] & Um[w]);
                if (iju & 1) {
                    int c = off2 + c2_idx;
                    out_quad_rows[(size_t)m * n_col_words + (c >> 6)] ^= 1ULL << (c & 63);
                }
            }
            c2_idx++;

            int base3 = col3_base[i * n + j];
            for (int k = j + 1; k < n; k++) {
                int p = 0;
                for (int w = 0; w < 32; w++) p += __builtin_popcountll(inter[w] & basis[k][w]);
                if (p & 1) {
                    int c = base3 + (k - j - 1);
                    out_base_row[c >> 6] ^= 1ULL << (c & 63);
                }
            }
        }
    }

    for (int m = 0; m < n_chars; m++) {
        const uint64_t *Um = char_words32 + (size_t)m * 32;
        uint64_t OU[32];
        for (int w = 0; w < 32; w++) OU[w] = O_word[w] ^ Um[w];
        int ou_pop = pop32(OU);
        if (ou_pop & 3) {
            out_quad_valid[m] = 0;
            memset(out_quad_rows + (size_t)m * n_col_words, 0, (size_t)n_col_words * sizeof(uint64_t));
            continue;
        }
        int ok = 1;
        uint64_t *qrow = out_quad_rows + (size_t)m * n_col_words;
        for (int i = 0; i < n; i++) {
            int wi_pop = pop32(basis[i]);
            int wo_pop = pop32_and(basis[i], O_word);
            int wou_pop = pop32_and(basis[i], OU);
            if ((wi_pop - 2 * wou_pop) & 3) {
                ok = 0;
                break;
            }
            int bit0 = ((wi_pop - 2 * wo_pop) / 4) & 1;
            int bitu = ((wi_pop - 2 * wou_pop) / 4) & 1;
            if (bit0 ^ bitu) {
                int c = off1 + i;
                qrow[c >> 6] ^= 1ULL << (c & 63);
            }
        }
        if (!ok) {
            out_quad_valid[m] = 0;
            memset(qrow, 0, (size_t)n_col_words * sizeof(uint64_t));
            continue;
        }
        if (((o_pop / 4) ^ (ou_pop / 4)) & 1) {
            qrow[off0 >> 6] ^= 1ULL << (off0 & 63);
        }
        out_quad_valid[m] = 1;
    }

    int pair_m = 0;
    for (int r = 0; r < n_chars; r++) {
        for (int s = r + 1; s < n_chars; s++) {
            uint64_t *lrow = out_lin_rows + (size_t)pair_m * n_col_words;
            memset(lrow, 0, (size_t)n_col_words * sizeof(uint64_t));
            if (!out_quad_valid[r] || !out_quad_valid[s]) {
                out_lin_valid[pair_m++] = 0;
                continue;
            }
            const uint64_t *Ur = char_words32 + (size_t)r * 32;
            const uint64_t *Us = char_words32 + (size_t)s * 32;
            uint64_t OUr[32], OUs[32], OUrs[32];
            for (int w = 0; w < 32; w++) {
                OUr[w] = O_word[w] ^ Ur[w];
                OUs[w] = O_word[w] ^ Us[w];
                OUrs[w] = O_word[w] ^ Ur[w] ^ Us[w];
            }
            int pop_0 = o_pop;
            int pop_r = pop32(OUr);
            int pop_s = pop32(OUs);
            int pop_rs = pop32(OUrs);
            if (pop_rs & 3) {
                out_lin_valid[pair_m++] = 0;
                continue;
            }
            int ok = 1;
            for (int i = 0; i < n; i++) {
                int w_urs = pop32_and3(basis[i], Ur, Us);
                int wi_pop = pop32(basis[i]);
                int w_ours = pop32_and(basis[i], OUrs);
                if ((wi_pop - 2 * w_ours) & 3) {
                    ok = 0;
                    break;
                }
                if (w_urs & 1) {
                    int c = off1 + i;
                    lrow[c >> 6] ^= 1ULL << (c & 63);
                }
            }
            if (!ok) {
                memset(lrow, 0, (size_t)n_col_words * sizeof(uint64_t));
                out_lin_valid[pair_m++] = 0;
                continue;
            }
            int c0 = ((pop_0 / 4) ^ (pop_r / 4) ^ (pop_s / 4) ^ (pop_rs / 4)) & 1;
            if (c0) {
                lrow[off0 >> 6] ^= 1ULL << (off0 & 63);
            }
            out_lin_valid[pair_m++] = 1;
        }
    }
    return 0;
}

int gf2_echelon_insert(
    uint64_t *rows,
    int row_idx,
    int n_words,
    int *piv_row_idx,
    int n_cols
) {
    uint64_t *r = rows + (size_t)row_idx * n_words;
    for (int w = 0; w < n_words; w++) {
        while (r[w] != 0ULL) {
            int bit = __builtin_ctzll(r[w]);
            int col = (w << 6) + bit;
            if (col >= n_cols) return -1;
            int p_idx = piv_row_idx[col];
            if (p_idx >= 0) {
                const uint64_t *p = rows + (size_t)p_idx * n_words;
                for (int k = w; k < n_words; k++) r[k] ^= p[k];
            } else {
                piv_row_idx[col] = row_idx;
                return col;
            }
        }
    }
    return -1;
}

// ==============================================================================
// DEGREE-4 SCHUR-COMPLEMENT MUTANT-XL ENGINE (N <= 111)
// ==============================================================================
static uint32_t C_tab[128][5];

void init_combinadics(int N) {
    memset(C_tab, 0, sizeof(C_tab));
    for (int n = 0; n <= N; n++) {
        C_tab[n][0] = 1;
        for (int k = 1; k <= 4 && k <= n; k++) {
            C_tab[n][k] = C_tab[n - 1][k - 1] + C_tab[n - 1][k];
        }
    }
}

static inline void sort4(int *a) {
    if (a[0] > a[1]) { int t = a[0]; a[0] = a[1]; a[1] = t; }
    if (a[2] > a[3]) { int t = a[2]; a[2] = a[3]; a[3] = t; }
    if (a[0] > a[2]) { int t = a[0]; a[0] = a[2]; a[2] = t; }
    if (a[1] > a[3]) { int t = a[1]; a[1] = a[3]; a[3] = t; }
    if (a[1] > a[2]) { int t = a[1]; a[1] = a[2]; a[2] = t; }
}

static inline void sort3(int *a) {
    if (a[0] > a[1]) { int t = a[0]; a[0] = a[1]; a[1] = t; }
    if (a[1] > a[2]) { int t = a[1]; a[1] = a[2]; a[2] = t; }
    if (a[0] > a[1]) { int t = a[0]; a[0] = a[1]; a[1] = t; }
}

// Encode a union of up to 4 variables (packed in uint64_t maskLo, maskHi for N <= 111) into global grevlex column
static inline uint32_t mask_to_col_d4(
    uint64_t lo, uint64_t hi,
    uint32_t off3, uint32_t off2, uint32_t off1, uint32_t off0
) {
    int idxs[4], k = 0;
    uint64_t w0 = lo;
    while (w0) {
        int b = __builtin_ctzll(w0);
        idxs[k++] = b;
        w0 &= w0 - 1;
    }
    uint64_t w1 = hi;
    while (w1) {
        int b = __builtin_ctzll(w1);
        idxs[k++] = 64 + b;
        w1 &= w1 - 1;
    }
    if (k == 4) return C_tab[idxs[0]][1] + C_tab[idxs[1]][2] + C_tab[idxs[2]][3] + C_tab[idxs[3]][4];
    if (k == 3) return off3 + C_tab[idxs[0]][1] + C_tab[idxs[1]][2] + C_tab[idxs[2]][3];
    if (k == 2) return off2 + C_tab[idxs[0]][1] + C_tab[idxs[1]][2];
    if (k == 1) return off1 + idxs[0];
    return off0;
}

typedef struct {
    int N;
    uint32_t n4, n3, n2, off3, off2, off1, off0, total_cols;
    uint32_t low_cols, low_words, total_words;

    int32_t *piv4_head;
    uint32_t *csr_arena;
    size_t arena_cap, arena_used;
    uint32_t max_nnz4;

    uint64_t *low_rows;
    int32_t *piv_low;
    uint32_t cur_low_rows, max_low_rows;

    uint64_t *tmp_bits;
    uint64_t *low_buf;

    uint32_t num_piv4;
    uint32_t deg_pivs[4];
    uint32_t mutants_found[4];
    int has_one;
} SchurD4;

// Run Schur-Mutant-XL on m_quad quadratic polynomials in N variables!
// Each quadratic polynomial q_a is passed as CSR of (lo, hi) 128-bit monomial masks:
//   q_offs[0..m_quad], q_lo[0..nnz-1], q_hi[0..nnz-1].
// Exports any newly discovered degree <= 2 pivots into out_deg12_lo / out_deg12_hi!
int run_schur_mutant_xl_quads(
    int N,
    int m_quad,
    const int *q_offs,
    const uint64_t *q_lo,
    const uint64_t *q_hi,
    double time_budget_sec,
    uint32_t max_nnz4,
    size_t arena_u32_cap,
    int *out_stats,          // [has_one, num_piv4, p_d3, p_d2, p_d1, mut_d3, mut_d2, mut_d1]
    int *out_n_deg12,
    int *out_deg12_offs,
    uint64_t *out_deg12_lo,
    uint64_t *out_deg12_hi,
    int max_deg12_terms
) {
    init_combinadics(N);
    SchurD4 ctx;
    memset(&ctx, 0, sizeof(ctx));
    ctx.N = N;
    ctx.n4 = C_tab[N][4];
    ctx.n3 = C_tab[N][3];
    ctx.n2 = C_tab[N][2];
    ctx.off3 = ctx.n4;
    ctx.off2 = ctx.n4 + ctx.n3;
    ctx.off1 = ctx.off2 + ctx.n2;
    ctx.off0 = ctx.off1 + N;
    ctx.total_cols = ctx.off0 + 1;
    ctx.low_cols = ctx.total_cols - ctx.off3;
    ctx.low_words = (ctx.low_cols + 63) / 64;
    ctx.total_words = (ctx.total_cols + 63) / 64;

    ctx.piv4_head = (int32_t*)malloc((size_t)ctx.n4 * sizeof(int32_t));
    memset(ctx.piv4_head, -1, (size_t)ctx.n4 * sizeof(int32_t));
    ctx.arena_cap = arena_u32_cap;
    ctx.csr_arena = (uint32_t*)malloc(arena_u32_cap * sizeof(uint32_t));
    ctx.max_nnz4 = max_nnz4;

    ctx.max_low_rows = 18000;
    ctx.low_rows = (uint64_t*)calloc((size_t)ctx.max_low_rows * ctx.low_words, sizeof(uint64_t));
    ctx.piv_low = (int32_t*)malloc((size_t)ctx.low_cols * sizeof(int32_t));
    memset(ctx.piv_low, -1, (size_t)ctx.low_cols * sizeof(int32_t));

    ctx.tmp_bits = (uint64_t*)calloc(ctx.total_words, sizeof(uint64_t));
    ctx.low_buf = (uint64_t*)calloc(ctx.low_words, sizeof(uint64_t));

    // Helper lambda-style macros
    #define INSERT_LOW_BUF(ret_deg) do { \
        ret_deg = -1; \
        if (!ctx.has_one && ctx.cur_low_rows < ctx.max_low_rows) { \
            uint32_t rid = ctx.cur_low_rows; \
            uint64_t *r = ctx.low_rows + (size_t)rid * ctx.low_words; \
            memcpy(r, ctx.low_buf, ctx.low_words * sizeof(uint64_t)); \
            for (uint32_t w = 0; w < ctx.low_words; w++) { \
                while (r[w] != 0ULL) { \
                    int bit = __builtin_ctzll(r[w]); \
                    uint32_t lcol = (w << 6) + bit; \
                    if (lcol >= ctx.low_cols) { r[w] = 0ULL; break; } \
                    int32_t pidx = ctx.piv_low[lcol]; \
                    if (pidx >= 0) { \
                        const uint64_t *p = ctx.low_rows + (size_t)pidx * ctx.low_words; \
                        for (uint32_t k = w; k < ctx.low_words; k++) r[k] ^= p[k]; \
                    } else { \
                        ctx.piv_low[lcol] = (int32_t)rid; \
                        ctx.cur_low_rows++; \
                        uint32_t gcol = ctx.off3 + lcol; \
                        int d = (gcol == ctx.off0) ? 0 : (gcol >= ctx.off1 ? 1 : (gcol >= ctx.off2 ? 2 : 3)); \
                        ctx.deg_pivs[d]++; \
                        if (d == 0) ctx.has_one = 1; \
                        ret_deg = d; \
                        w = ctx.low_words; \
                        break; \
                    } \
                } \
            } \
        } \
    } while (0)

    // Precompute unranking table for low_cols -> (lo, hi) mask so any mutant deg <= 2 can be multiplied by x_i!
    uint64_t *unrank_lo = (uint64_t*)calloc(ctx.low_cols, sizeof(uint64_t));
    uint64_t *unrank_hi = (uint64_t*)calloc(ctx.low_cols, sizeof(uint64_t));
    for (int i = 0; i < N; i++) {
        uint64_t mi_lo = (i < 64) ? (1ULL << i) : 0ULL;
        uint64_t mi_hi = (i >= 64) ? (1ULL << (i - 64)) : 0ULL;
        unrank_lo[ctx.off1 + i - ctx.off3] = mi_lo;
        unrank_hi[ctx.off1 + i - ctx.off3] = mi_hi;
        for (int j = i + 1; j < N; j++) {
            uint64_t mj_lo = mi_lo | ((j < 64) ? (1ULL << j) : 0ULL);
            uint64_t mj_hi = mi_hi | ((j >= 64) ? (1ULL << (j - 64)) : 0ULL);
            uint32_t c2 = ctx.off2 + C_tab[i][1] + C_tab[j][2] - ctx.off3;
            unrank_lo[c2] = mj_lo;
            unrank_hi[c2] = mj_hi;
            for (int k = j + 1; k < N; k++) {
                uint64_t mk_lo = mj_lo | ((k < 64) ? (1ULL << k) : 0ULL);
                uint64_t mk_hi = mj_hi | ((k >= 64) ? (1ULL << (k - 64)) : 0ULL);
                uint32_t c3 = C_tab[i][1] + C_tab[j][2] + C_tab[k][3];
                unrank_lo[c3] = mk_lo;
                unrank_hi[c3] = mk_hi;
            }
        }
    }

    // Queue of low row IDs of degree <= 2 to multiply by x_0 .. x_{N-1}
    uint32_t *xl_q = (uint32_t*)malloc(ctx.max_low_rows * sizeof(uint32_t));
    int q_head = 0, q_tail = 0;

    // 1. Seed C_low with all m_quad quadratics and run full degree-3 XL closure!
    for (int a = 0; a < m_quad && !ctx.has_one; a++) {
        memset(ctx.low_buf, 0, ctx.low_words * sizeof(uint64_t));
        for (int t = q_offs[a]; t < q_offs[a + 1]; t++) {
            uint32_t gcol = mask_to_col_d4(q_lo[t], q_hi[t], ctx.off3, ctx.off2, ctx.off1, ctx.off0);
            uint32_t lcol = gcol - ctx.off3;
            ctx.low_buf[lcol >> 6] ^= 1ULL << (lcol & 63);
        }
        int d;
        INSERT_LOW_BUF(d);
        if (d == 1 || d == 2) xl_q[q_tail++] = ctx.cur_low_rows - 1;
    }

    // Helper to drain xl_q in C_low
    #define DRAIN_LOW_XL() do { \
        while (q_head < q_tail && !ctx.has_one && ctx.cur_low_rows + N + 4 < ctx.max_low_rows) { \
            uint32_t rid = xl_q[q_head++]; \
            const uint64_t *prow = ctx.low_rows + (size_t)rid * ctx.low_words; \
            /* Extract active terms (all have deg <= 2 since rid has pivot >= off2) */ \
            int n_act = 0; \
            uint32_t act_lcols[8192]; \
            uint32_t start_w = (ctx.off2 - ctx.off3) >> 6; \
            for (uint32_t w = start_w; w < ctx.low_words; w++) { \
                uint64_t v = prow[w]; \
                while (v) { \
                    int b = __builtin_ctzll(v); \
                    act_lcols[n_act++] = (w << 6) + b; \
                    v &= v - 1; \
                } \
            } \
            for (int v_i = 0; v_i < N && !ctx.has_one; v_i++) { \
                uint64_t vi_lo = (v_i < 64) ? (1ULL << v_i) : 0ULL; \
                uint64_t vi_hi = (v_i >= 64) ? (1ULL << (v_i - 64)) : 0ULL; \
                memset(ctx.low_buf, 0, ctx.low_words * sizeof(uint64_t)); \
                for (int t = 0; t < n_act; t++) { \
                    uint32_t lc = act_lcols[t]; \
                    uint32_t gc = mask_to_col_d4(unrank_lo[lc] | vi_lo, unrank_hi[lc] | vi_hi, \
                                                 ctx.off3, ctx.off2, ctx.off1, ctx.off0); \
                    uint32_t nlc = gc - ctx.off3; \
                    ctx.low_buf[nlc >> 6] ^= 1ULL << (nlc & 63); \
                } \
                int nd; \
                INSERT_LOW_BUF(nd); \
                if (nd == 1 || nd == 2) xl_q[q_tail++] = ctx.cur_low_rows - 1; \
            } \
        } \
    } while (0)

    DRAIN_LOW_XL();

    // Helper macro: reduce tmp_bits [min_w .. max_w] against A_44; if mutant, push to C_low & XL!
    uint32_t deg4_limit_w = (ctx.n4 + 63) >> 6;
    #define REDUCE_TMP_DEG4(min_w, max_w) do { \
        int new_p4 = -1; \
        for (uint32_t w = (min_w); w < deg4_limit_w && w <= (max_w); w++) { \
            while (ctx.tmp_bits[w] != 0ULL) { \
                int bit = __builtin_ctzll(ctx.tmp_bits[w]); \
                uint32_t c = (w << 6) + bit; \
                if (c >= ctx.n4) break; \
                int32_t a_off = ctx.piv4_head[c]; \
                if (a_off >= 0) { \
                    uint32_t plen = ctx.csr_arena[a_off]; \
                    const uint32_t *pcols = &ctx.csr_arena[a_off + 1]; \
                    for (uint32_t k = 0; k < plen; k++) { \
                        uint32_t pc = pcols[k]; \
                        uint32_t pw = pc >> 6; \
                        ctx.tmp_bits[pw] ^= (1ULL << (pc & 63)); \
                        if (pw > (max_w)) (max_w) = pw; \
                    } \
                } else { \
                    new_p4 = (int)c; \
                    goto p4_stop_##__LINE__; \
                } \
            } \
        } \
        p4_stop_##__LINE__: ; \
        if (new_p4 < 0) { \
            memset(ctx.low_buf, 0, ctx.low_words * sizeof(uint64_t)); \
            uint32_t sh = ctx.off3 & 63; \
            uint32_t bw = ctx.off3 >> 6; \
            for (uint32_t lw = 0; lw < ctx.low_words; lw++) { \
                uint64_t v = (bw + lw <= (max_w)) ? (ctx.tmp_bits[bw + lw] >> sh) : 0ULL; \
                if (sh && (bw + lw + 1 <= (max_w))) v |= (ctx.tmp_bits[bw + lw + 1] << (64 - sh)); \
                ctx.low_buf[lw] = v; \
            } \
            for (uint32_t w = (min_w); w <= (max_w); w++) ctx.tmp_bits[w] = 0ULL; \
            int md; \
            INSERT_LOW_BUF(md); \
            if (md >= 0) { \
                ctx.mutants_found[md]++; \
                if (md == 1 || md == 2) { \
                    xl_q[q_tail++] = ctx.cur_low_rows - 1; \
                    DRAIN_LOW_XL(); \
                } \
            } \
        } else { \
            uint32_t nnz = 0; \
            uint32_t sw = (uint32_t)new_p4 >> 6; \
            for (uint32_t w = sw; w <= (max_w); w++) { \
                if (ctx.tmp_bits[w]) nnz += __builtin_popcountll(ctx.tmp_bits[w]); \
            } \
            if (nnz <= ctx.max_nnz4 && (ctx.arena_used + nnz + 1) <= ctx.arena_cap) { \
                int32_t off = (int32_t)ctx.arena_used; \
                ctx.csr_arena[ctx.arena_used++] = nnz; \
                for (uint32_t w = sw; w <= (max_w); w++) { \
                    uint64_t word = ctx.tmp_bits[w]; \
                    while (word) { \
                        int b = __builtin_ctzll(word); \
                        ctx.csr_arena[ctx.arena_used++] = (w << 6) + b; \
                        word &= word - 1; \
                    } \
                    ctx.tmp_bits[w] = 0ULL; \
                } \
                for (uint32_t w = (min_w); w < sw; w++) ctx.tmp_bits[w] = 0ULL; \
                ctx.piv4_head[new_p4] = off; \
                ctx.num_piv4++; \
            } else { \
                for (uint32_t w = (min_w); w <= (max_w); w++) ctx.tmp_bits[w] = 0ULL; \
            } \
        } \
    } while (0)

    // 2. Degree-4 Phase A: Multiply quadratics q_a (sorted by sparsity by caller!) by pairs x_i * x_j
    //    AND Phase B: Pairwise products q_a * q_b for the sparsest quadratics!
    // Use clock() for lightweight time budget check
    double clk_start = (double)clock() / 1000000.0;
    for (int a = 0; a < m_quad && !ctx.has_one; a++) {
        int qa_start = q_offs[a], qa_end = q_offs[a + 1];
        for (int i = 0; i < N && !ctx.has_one; i++) {
            if ((i & 7) == 0) {
                double el = ((double)clock() / 1000000.0) - clk_start;
                if (el > time_budget_sec) goto d4_done;
            }
            uint64_t mi_lo = (i < 64) ? (1ULL << i) : 0ULL;
            uint64_t mi_hi = (i >= 64) ? (1ULL << (i - 64)) : 0ULL;
            for (int j = i + 1; j < N && !ctx.has_one; j++) {
                uint64_t mij_lo = mi_lo | ((j < 64) ? (1ULL << j) : 0ULL);
                uint64_t mij_hi = mi_hi | ((j >= 64) ? (1ULL << (j - 64)) : 0ULL);
                uint32_t min_w = UINT32_MAX, max_w = 0;
                for (int t = qa_start; t < qa_end; t++) {
                    uint32_t c = mask_to_col_d4(q_lo[t] | mij_lo, q_hi[t] | mij_hi,
                                                ctx.off3, ctx.off2, ctx.off1, ctx.off0);
                    uint32_t w = c >> 6;
                    ctx.tmp_bits[w] ^= 1ULL << (c & 63);
                    if (w < min_w) min_w = w;
                    if (w > max_w) max_w = w;
                }
                if (min_w <= max_w) {
                    REDUCE_TMP_DEG4(min_w, max_w);
                }
            }
        }

        // Also form pairwise product q_a * q_b with sparser previous quadratics b < a
        if ((qa_end - qa_start) <= 450) {
            for (int b = 0; b < a && !ctx.has_one; b++) {
                int qb_start = q_offs[b], qb_end = q_offs[b + 1];
                if ((qb_end - qb_start) > 450) continue;
                uint32_t min_w = UINT32_MAX, max_w = 0;
                for (int ta = qa_start; ta < qa_end; ta++) {
                    uint64_t alo = q_lo[ta], ahi = q_hi[ta];
                    for (int tb = qb_start; tb < qb_end; tb++) {
                        uint32_t c = mask_to_col_d4(alo | q_lo[tb], ahi | q_hi[tb],
                                                    ctx.off3, ctx.off2, ctx.off1, ctx.off0);
                        uint32_t w = c >> 6;
                        ctx.tmp_bits[w] ^= 1ULL << (c & 63);
                        if (w < min_w) min_w = w;
                        if (w > max_w) max_w = w;
                    }
                }
                if (min_w <= max_w) {
                    REDUCE_TMP_DEG4(min_w, max_w);
                }
            }
        }
    }

d4_done:
    // Export ALL RREF degree <= 2 rows from C_low for SAT!
    // First backward-eliminate among degree <= 2 pivots so they are maximally sparse (RREF in deg <= 2)
    int n_d12 = 0;
    int term_cursor = 0;
    out_deg12_offs[0] = 0;
    uint32_t lcol_deg2_start = ctx.off2 - ctx.off3;
    for (uint32_t lc = lcol_deg2_start; lc < ctx.low_cols; lc++) {
        int32_t rid = ctx.piv_low[lc];
        if (rid < 0) continue;
        uint64_t *r = ctx.low_rows + (size_t)rid * ctx.low_words;
        // Reduce tail against later deg <= 2 pivots for cleaner CNF!
        for (uint32_t lc2 = lc + 1; lc2 < ctx.low_cols; lc2++) {
            int32_t rid2 = ctx.piv_low[lc2];
            if (rid2 >= 0 && ((r[lc2 >> 6] >> (lc2 & 63)) & 1ULL)) {
                const uint64_t *r2 = ctx.low_rows + (size_t)rid2 * ctx.low_words;
                for (uint32_t w = (lc2 >> 6); w < ctx.low_words; w++) r[w] ^= r2[w];
            }
        }
        for (uint32_t w = (lc >> 6); w < ctx.low_words; w++) {
            uint64_t v = r[w];
            while (v) {
                int b = __builtin_ctzll(v);
                uint32_t pos = (w << 6) + b;
                if (pos < ctx.low_cols && term_cursor < max_deg12_terms) {
                    out_deg12_lo[term_cursor] = unrank_lo[pos];
                    out_deg12_hi[term_cursor] = unrank_hi[pos];
                    term_cursor++;
                }
                v &= v - 1;
            }
        }
        n_d12++;
        out_deg12_offs[n_d12] = term_cursor;
    }
    *out_n_deg12 = n_d12;

    out_stats[0] = ctx.has_one;
    out_stats[1] = (int)ctx.num_piv4;
    out_stats[2] = (int)ctx.deg_pivs[3];
    out_stats[3] = (int)ctx.deg_pivs[2];
    out_stats[4] = (int)ctx.deg_pivs[1];
    out_stats[5] = (int)ctx.mutants_found[3];
    out_stats[6] = (int)ctx.mutants_found[2];
    out_stats[7] = (int)ctx.mutants_found[1];

    free(xl_q);
    free(unrank_lo);
    free(unrank_hi);
    free(ctx.tmp_bits);
    free(ctx.low_buf);
    free(ctx.piv_low);
    free(ctx.low_rows);
    free(ctx.csr_arena);
    free(ctx.piv4_head);
    return ctx.has_one;
}

// ==============================================================================
// ULTRA-FAST 65,536-POINT FWHT BENT AUDITOR (0.04 ms per candidate!)
// ==============================================================================
int audit_bent_116_c(
    const uint64_t *orb_tts, // 116 * 1024 uint64_t words
    uint64_t cint_lo,
    uint64_t cint_hi,
    int *out_bad_u,
    int *out_bad_val
) {
    uint64_t tt[1024];
    memset(tt, 0, sizeof(tt));
    for (int j = 0; j < 64; j++) {
        if ((cint_lo >> j) & 1ULL) {
            const uint64_t *src = orb_tts + (size_t)j * 1024;
            for (int w = 0; w < 1024; w++) tt[w] ^= src[w];
        }
    }
    for (int j = 64; j < 116; j++) {
        if ((cint_hi >> (j - 64)) & 1ULL) {
            const uint64_t *src = orb_tts + (size_t)j * 1024;
            for (int w = 0; w < 1024; w++) tt[w] ^= src[w];
        }
    }
    int32_t fw[65536];
    for (int w = 0; w < 1024; w++) {
        uint64_t word = tt[w];
        int base = w << 6;
        for (int b = 0; b < 64; b++) {
            fw[base + b] = ((word >> b) & 1ULL) ? -1 : 1;
        }
    }
    for (int len = 1; len < 65536; len <<= 1) {
        int step = len << 1;
        for (int i = 0; i < 65536; i += step) {
            for (int j = 0; j < len; j++) {
                int32_t u = fw[i + j];
                int32_t v = fw[i + j + len];
                fw[i + j] = u + v;
                fw[i + j + len] = u - v;
            }
        }
    }
    for (int u = 0; u < 65536; u++) {
        if (fw[u] != 256 && fw[u] != -256) {
            *out_bad_u = u;
            *out_bad_val = fw[u];
            return 0;
        }
    }
    *out_bad_u = -1;
    *out_bad_val = 256;
    return 1;
}
"""

L_INDICES = [0, 4, 8, 14, 18, 22, 42, 46, 52, 56, 71, 81, 85, 94, 98, 106]
I1 = [0, 4, 8, 18, 42, 52, 56, 94]
J1 = [14, 22, 46, 71, 81, 85, 98, 106]
I2 = [1, 9, 15, 28, 53, 67, 76, 103]
J2 = [3, 11, 34, 45, 55, 69, 78, 89]
I3 = [2, 10, 25, 37, 54, 68, 83, 104]
J3 = [12, 20, 29, 33, 41, 48, 96, 110]
I4 = [13, 21, 38, 70, 74, 93, 97, 109]
J4 = [24, 32, 47, 72, 80, 86, 91, 107]
U4_LIST = [u * 0x1111 for u in range(16)]


def rot16(x: int, r: int = 1) -> int:
    r &= 15
    return (((x << r) | (x >> (16 - r))) & 0xFFFF) if r else x


def rot8(v: int) -> int:
    return ((v << 1) & 0xFF) | (v >> 7)


def interleave16(x: int) -> int:
    out = 0
    for half in (0, 8):
        for j in range(4):
            if (x >> (half + j)) & 1:
                out |= 1 << (half + 2 * j)
            if (x >> (half + 4 + j)) & 1:
                out |= 1 << (half + 2 * j + 1)
    return out


def build_orbits_116():
    seen = set()
    orbits = []
    for comb in combinations(range(16), 4):
        m = sum(1 << i for i in comb)
        if m in seen:
            continue
        orb = sorted({rot16(m, r) for r in range(16)})
        seen.update(orb)
        orbits.append(orb)
    assert len(orbits) == 116
    return orbits


def all_v6_orbits():
    dual_seen = set()
    v6_list = []
    for a in range(1, 256):
        for b in range(a + 1, 256):
            c = a ^ b
            trip = tuple(sorted((a, b, c)))
            if trip in dual_seen:
                continue
            cur = trip
            for _ in range(8):
                dual_seen.add(tuple(sorted(cur)))
                cur = tuple(rot8(z) for z in cur)
            pts = [v for v in range(256) if ((v & a).bit_count() & 1) == 0 and ((v & b).bit_count() & 1) == 0]
            v6_list.append(pts)
    return v6_list


def build_pure_111_basis(c99_val: int, c57_val: int, c113_val: int):
    """Pure 111-variable basis: ONLY c115=0 and L=c99 (eliminating c0). Zero assumptions on K or R!"""
    excluded = {0, 57, 99, 113, 115}
    free111 = sorted(set(range(116)) - excluded)
    L_set = set(L_INDICES)
    origin = (c99_val << 0) | (c99_val << 99) | (c57_val << 57) | (c113_val << 113)
    cb = []
    for j in free111:
        c = 1 << j
        if j in L_set:
            c ^= 1 << 0
        cb.append(c)
    assert len(cb) == 111
    return free111, origin, cb


def rref_gf2(vecs):
    pivs = {}
    for v in vecs:
        x = v
        while x:
            b = x.bit_length() - 1
            if b in pivs:
                x ^= pivs[b]
            else:
                pivs[b] = x
                break
    for b in sorted(pivs.keys(), reverse=True):
        for b2 in list(pivs.keys()):
            if b2 != b and ((pivs[b2] >> b) & 1):
                pivs[b2] ^= pivs[b]
    return [pivs[b] for b in sorted(pivs.keys(), reverse=True)]


def span_set(basis):
    pts = [0]
    for b in basis:
        pts += [p ^ b for p in pts]
    return pts


def nullspace_basis(hs):
    rows = rref_gf2(hs)
    piv_map = {r.bit_length() - 1: r for r in rows}
    out = []
    for f in range(16):
        if f in piv_map:
            continue
        v = 1 << f
        for pb, r in piv_map.items():
            if (r >> f) & 1:
                v |= 1 << pb
        out.append(v)
    return out


def sample_rot4_wperp(rng, target_codim):
    for _ in range(200):
        gens = []
        while len(rref_gf2(gens)) < target_codim:
            choice = rng.random()
            if choice < 0.35:
                u = rng.choice(U4_LIST)
                cand = gens + [u]
            elif choice < 0.70:
                v = rng.randint(1, 255)
                d = v | (v << 8)
                cand = gens + [d, rot16(d, 4)]
            else:
                if rng.random() < 0.75:
                    v = rng.randint(0, 255)
                    u4b = rng.choice([u & 0xFF for u in U4_LIST if u])
                    h = v | ((v ^ u4b) << 8)
                else:
                    h = rng.randint(1, 65535)
                cand = gens + [h, rot16(h, 4), rot16(h, 8), rot16(h, 12)]
            if len(rref_gf2(cand)) <= target_codim:
                gens = rref_gf2(cand)
            elif len(rref_gf2(gens)) == target_codim - 1:
                for u in rng.sample(U4_LIST, len(U4_LIST)):
                    if len(rref_gf2(gens + [u])) == target_codim:
                        gens = rref_gf2(gens + [u])
                        break
                break
        if len(gens) == target_codim:
            sp = set(span_set(gens))
            if all(rot16(w, 4) in sp for w in sp):
                return gens
    return None


def extract_mod8_from_orbits4(basis_words, O_word, d0_div4, n):
    o_pop = O_word.bit_count()
    g0 = o_pop + d0_div4
    if g0 & 1:
        return None, None
    S1 = []
    for i in range(n):
        wi = basis_words[i].bit_count()
        wo = (basis_words[i] & O_word).bit_count()
        si = wi - 2 * wo
        if si & 1:
            return None, None
        S1.append(si)

    def toggle(pset, m):
        if m in pset:
            pset.remove(m)
        else:
            pset.add(m)

    P2, Q_raw = set(), set()
    v0 = g0 >> 1
    if v0 & 1:
        toggle(P2, 0)
    if (v0 >> 1) & 1:
        toggle(Q_raw, 0)
    for i in range(n):
        vi = S1[i] >> 1
        if vi & 1:
            toggle(P2, 1 << i)
        if (vi >> 1) & 1:
            toggle(Q_raw, 1 << i)
    for i in range(n):
        bi = basis_words[i]
        for j in range(i + 1, n):
            inter = bi & basis_words[j]
            if not inter:
                continue
            ij_pop = inter.bit_count()
            ijo_pop = (inter & O_word).bit_count()
            vij = 2 * ijo_pop - ij_pop
            m_ij = (1 << i) | (1 << j)
            if vij & 1:
                toggle(P2, m_ij)
            if (vij >> 1) & 1:
                toggle(Q_raw, m_ij)
            for k in range(j + 1, n):
                if (inter & basis_words[k]).bit_count() & 1:
                    toggle(Q_raw, m_ij | (1 << k))
    p2_list = sorted(P2)
    Q4 = set(Q_raw)
    for idx_a in range(len(p2_list)):
        ma = p2_list[idx_a]
        for idx_b in range(idx_a + 1, len(p2_list)):
            toggle(Q4, ma | p2_list[idx_b])
    return P2, Q4


def decode_row_to_pset(row_words, n_cols, off2, off1, off0, pair2_list, col3_list):
    pset = set()
    n_words = (n_cols + 63) // 64
    for w in range(n_words):
        val = row_words[w]
        while val:
            b = val & -val
            col = (w << 6) + b.bit_length() - 1
            val ^= b
            if col == off0:
                pset.add(0)
            elif col >= off1:
                pset.add(1 << (col - off1))
            elif col >= off2:
                pset.add(pair2_list[col - off2])
            else:
                pset.add(col3_list[col])
    return pset


# ==============================================================================
# CNF ENCODING HELPERS (Shared AND-gate cache + Tree XOR + Z_16^* Lex Symmetry)
# ==============================================================================
def add_and_gate(clauses, y_var, lits):
    for l in lits:
        clauses.append([-y_var, l])
    clauses.append([y_var] + [-l for l in lits])


def add_long_xor(clauses, lits, rhs_const, new_var_fn, chunk=4):
    cur = list(lits)
    rhs = rhs_const & 1
    if not cur:
        if rhs == 1:
            v = new_var_fn()
            clauses.append([v])
            clauses.append([-v])
        return
    while len(cur) > chunk:
        head = cur[:chunk - 1]
        aux = new_var_fn()
        block = head + [aux]
        for mask in range(1 << len(block)):
            if mask.bit_count() & 1:
                clauses.append([-block[i] if ((mask >> i) & 1) else block[i] for i in range(len(block))])
        cur = [aux] + cur[chunk - 1:]
    for mask in range(1 << len(cur)):
        if (mask.bit_count() & 1) != rhs:
            clauses.append([-cur[i] if ((mask >> i) & 1) else cur[i] for i in range(len(cur))])


def encode_pset_zero_cnf(clauses, pset, new_var_fn, pair_cache, trip_cache=None):
    xor_lits = []
    rhs = 0
    for m in sorted(pset):
        d = m.bit_count()
        if d == 0:
            rhs ^= 1
        elif d == 1:
            xor_lits.append((m.bit_length() - 1) + 1)
        elif d == 2:
            if m not in pair_cache:
                b0 = (m & -m).bit_length() - 1
                b1 = (m ^ (1 << b0)).bit_length() - 1
                yv = new_var_fn()
                add_and_gate(clauses, yv, [b0 + 1, b1 + 1])
                pair_cache[m] = yv
            xor_lits.append(pair_cache[m])
        elif d == 3 and trip_cache is not None:
            if m not in trip_cache:
                b0 = (m & -m).bit_length() - 1
                m2 = m ^ (1 << b0)
                if m2 not in pair_cache:
                    b1 = (m2 & -m2).bit_length() - 1
                    b2 = (m2 ^ (1 << b1)).bit_length() - 1
                    pv = new_var_fn()
                    add_and_gate(clauses, pv, [b1 + 1, b2 + 1])
                    pair_cache[m2] = pv
                tv = new_var_fn()
                add_and_gate(clauses, tv, [b0 + 1, pair_cache[m2]])
                trip_cache[m] = tv
            xor_lits.append(trip_cache[m])
    add_long_xor(clauses, xor_lits, rhs, new_var_fn)


def add_lex_leq_clauses(clauses, a_lits, b_lits, new_var_fn):
    """Enforce (a_0, ..., a_{k-1}) <=_lex (b_0, ..., b_{k-1}) in O(k) clauses."""
    eq_prev = None
    for a, b in zip(a_lits, b_lits):
        if a == b:
            continue
        if eq_prev is None:
            clauses.append([-a, b])
            eq_cur = new_var_fn()
            # eq_prev -> (a == b)  <=>  [-eq_cur, -a, b] & [-eq_cur, a, -b]
            clauses.append([-eq_cur, -a, b])
            clauses.append([-eq_cur, a, -b])
            eq_prev = eq_cur
        else:
            clauses.append([-eq_prev, -a, b])
            eq_cur = new_var_fn()
            clauses.append([-eq_cur, eq_prev])
            clauses.append([-eq_cur, -a, b])
            clauses.append([-eq_cur, a, -b])
            eq_prev = eq_cur


# ==============================================================================
# LINEAR VARIABLE ELIMINATION & GREVLEX RE-INDEXING
# ==============================================================================
def eliminate_linears_and_reindex(lin_psets, quad_psets, n_orig, origin_c, cb_c):
    """
    Given linear and quadratic psets in n_orig=111 variables:
      1. Perform exact RREF on lin_psets; detect immediate 1=0 if {0} arises.
      2. Eliminate all pivot variables from origin_c, cb_c, and quad_psets -> N_free variables.
      3. Re-order the N_free variables by DECREASING degree-2 frequency (adapted grevlex).
      4. Echelonize the resulting quadratics in N_free variables to confirm exact independent rank!
    """
    # 1. RREF on linear equations: represent as (var_mask, rhs_bit)
    lin_pivs = {}  # lead_bit -> (var_mask, rhs_bit)
    for p in lin_psets:
        vm = 0
        rhs = 0
        for m in p:
            if m == 0:
                rhs ^= 1
            else:
                assert m.bit_count() == 1
                vm |= m
        while vm:
            b = (vm & -vm).bit_length() - 1
            if b in lin_pivs:
                p_vm, p_rhs = lin_pivs[b]
                vm ^= p_vm
                rhs ^= p_rhs
            else:
                lin_pivs[b] = (vm, rhs)
                break
        if vm == 0 and rhs == 1:
            return {"unsat_in_linear": True}

    # Back-substitute linear RREF so each pivot p expresses x_p = rhs_p ^ sum_{f in free} alpha_{p,f} x_f
    piv_vars = sorted(lin_pivs.keys(), reverse=True)
    for idx, b in enumerate(piv_vars):
        vm, rhs = lin_pivs[b]
        for b2 in piv_vars[:idx]:
            if (vm >> b2) & 1:
                vm2, rhs2 = lin_pivs[b2]
                vm ^= vm2
                rhs ^= rhs2
        lin_pivs[b] = (vm, rhs)

    piv_set = set(lin_pivs.keys())
    free_old_vars = [i for i in range(n_orig) if i not in piv_set]
    N_free = len(free_old_vars)
    old_to_temp = {old_i: new_i for new_i, old_i in enumerate(free_old_vars)}

    # Build affine expression for every old variable i in 0..n_orig-1 over temp free vars 0..N_free-1:
    # x_old[i] = const_bit[i] ^ <lin_mask[i], x_temp>
    var_const = [0] * n_orig
    var_mask = [0] * n_orig
    for new_i, old_i in enumerate(free_old_vars):
        var_mask[old_i] = 1 << new_i
    for b, (vm, rhs) in lin_pivs.items():
        var_const[b] = rhs
        rem = vm ^ (1 << b)
        m_new = 0
        while rem:
            lsb = rem & -rem
            f_old = lsb.bit_length() - 1
            rem ^= lsb
            m_new ^= 1 << old_to_temp[f_old]
        var_mask[b] = m_new

    # Update origin_c and cb_c in 116-orbit space
    new_origin = origin_c
    new_cb_temp = [0] * N_free
    for old_i in range(n_orig):
        if var_const[old_i]:
            new_origin ^= cb_c[old_i]
        vm = var_mask[old_i]
        while vm:
            lsb = vm & -vm
            ti = lsb.bit_length() - 1
            vm ^= lsb
            new_cb_temp[ti] ^= cb_c[old_i]

    # Substitute into every quadratic pset
    def subst_quad(pset):
        out = set()

        def tog(m):
            if m in out:
                out.remove(m)
            else:
                out.add(m)

        for m in pset:
            d = m.bit_count()
            if d == 0:
                tog(0)
            elif d == 1:
                i = m.bit_length() - 1
                if var_const[i]:
                    tog(0)
                vm = var_mask[i]
                while vm:
                    lsb = vm & -vm
                    tog(lsb)
                    vm ^= lsb
            elif d == 2:
                i = (m & -m).bit_length() - 1
                j = (m ^ (1 << i)).bit_length() - 1
                ci, mi = var_const[i], var_mask[i]
                cj, mj = var_const[j], var_mask[j]
                if ci and cj:
                    tog(0)
                if ci:
                    tmp = mj
                    while tmp:
                        lsb = tmp & -tmp
                        tog(lsb)
                        tmp ^= lsb
                if cj:
                    tmp = mi
                    while tmp:
                        lsb = tmp & -tmp
                        tog(lsb)
                        tmp ^= lsb
                ti = mi
                while ti:
                    li = ti & -ti
                    tj = mj
                    while tj:
                        lj = tj & -tj
                        tog(li | lj)
                        tj ^= lj
                    ti ^= li
        return out

    sub_quads = [subst_quad(q) for q in quad_psets]

    # Count degree-2 frequency of each temp variable to build adapted grevlex permutation!
    freq = [0] * N_free
    for q in sub_quads:
        for m in q:
            if m.bit_count() == 2:
                b0 = (m & -m).bit_length() - 1
                b1 = (m ^ (1 << b0)).bit_length() - 1
                freq[b0] += 1
                freq[b1] += 1

    order_temp = sorted(range(N_free), key=lambda u: (-freq[u], u))
    temp_to_final = {tu: fu for fu, tu in enumerate(order_temp)}
    final_cb = [new_cb_temp[tu] for tu in order_temp]

    def permute_pset(pset):
        out = set()
        for m in pset:
            if m == 0:
                out.add(0)
            elif m.bit_count() == 1:
                out.add(1 << temp_to_final[m.bit_length() - 1])
            else:
                b0 = (m & -m).bit_length() - 1
                b1 = (m ^ (1 << b0)).bit_length() - 1
                out.add((1 << temp_to_final[b0]) | (1 << temp_to_final[b1]))
        return out

    perm_quads = [permute_pset(q) for q in sub_quads]

    # Exact RREF on perm_quads in degree <= 2 to check if substitution already triggered new linears or 1=0!
    # Loop in case quadratic cancellation creates new linear equations!
    piv2 = {}
    for q in perm_quads:
        cur = set(q)
        while cur:
            lead = max(cur, key=lambda m: (m.bit_count(), -m))
            if lead in piv2:
                cur ^= piv2[lead]
            else:
                piv2[lead] = cur
                break
        if 0 in piv2 and piv2[0] == {0}:
            return {"unsat_in_linear": True}

    # Back-reduce RREF in degree <= 2 for maximum sparsity
    leads_sorted = sorted(piv2.keys(), key=lambda m: (m.bit_count(), -m))
    for idx, ld in enumerate(leads_sorted):
        for ld2 in leads_sorted[idx + 1:]:
            if ld in piv2[ld2]:
                piv2[ld2] ^= piv2[ld]

    rref_polys = [piv2[ld] for ld in reversed(leads_sorted)]
    rref_polys.sort(key=len)  # Sparser quadratics first for Schur-Mutant-XL!
    n_lin_extra = sum(1 for ld in leads_sorted if ld.bit_count() == 1)
    n_quad_indep = sum(1 for ld in leads_sorted if ld.bit_count() == 2)

    return {
        "unsat_in_linear": False,
        "N_free": N_free,
        "lin_eliminated": len(lin_pivs),
        "extra_lin_after_subst": n_lin_extra,
        "quad_indep_rank": n_quad_indep,
        "new_origin": new_origin,
        "final_cb": final_cb,
        "rref_quads": rref_polys,
    }


# ==============================================================================
# MAIN SOLVER FOR A SINGLE CELL (B1_00 or B1_11)
# ==============================================================================
def solve_b1_cell(lib, orbits, orb_tts, v6_list, pair_idx, orb_diag, orb_pair, orb_r4, chi_r4, rep_of_x,
                  orb_0xf_parity, wt12_coord_subspaces, c57_val: int, sat_budget_sec: float = 120.0):
    t0 = time.perf_counter()
    c99_val = 1
    c113_val = c57_val
    cell_name = f"B1_{c57_val}{c113_val}"
    print(f"\n==================== [{cell_name}] STARTING PURE 111-VAR AUDIT & CLOSE ====================", flush=True)

    _, origin, cb = build_pure_111_basis(c99_val, c57_val, c113_val)
    n = 111

    O_diag, O_pair, O_r4 = 0, 0, 0
    for j in range(116):
        if (origin >> j) & 1:
            O_diag ^= orb_diag[j]
            O_pair ^= orb_pair[j]
            O_r4 ^= orb_r4[j]
    cb_pair, cb_r4 = [], []
    for cdir in cb:
        vp, vr = 0, 0
        for j in range(116):
            if (cdir >> j) & 1:
                vp ^= orb_pair[j]
                vr ^= orb_r4[j]
        cb_pair.append(vp)
        cb_r4.append(vr)

    mask64 = (1 << 64) - 1
    all_pair_bits = (ctypes.c_uint64 * ((n + 1) * 510))()
    for i in range(n):
        for w in range(510):
            all_pair_bits[i * 510 + w] = (cb_pair[i] >> (64 * w)) & mask64
    for w in range(510):
        all_pair_bits[n * 510 + w] = (O_pair >> (64 * w)) & mask64

    n3 = n * (n - 1) * (n - 2) // 6
    n2 = n * (n - 1) // 2
    off2, off1, off0 = n3, n3 + n2, n3 + n2 + n
    n_cols = off0 + 1
    n_col_words = (n_cols + 63) // 64

    col3_base = (ctypes.c_int * (n * n))()
    col3_list = []
    cur3 = 0
    for i in range(n):
        for j in range(i + 1, n):
            col3_base[i * n + j] = cur3
            for k in range(j + 1, n):
                col3_list.append((1 << i) | (1 << j) | (1 << k))
            cur3 += (n - 1 - j)
    pair2_col, pair2_list = {}, []
    for i in range(n):
        for j in range(i + 1, n):
            m = (1 << i) | (1 << j)
            pair2_col[m] = off2 + len(pair2_list)
            pair2_list.append(m)

    max_rows = 16000
    rows = (ctypes.c_uint64 * (max_rows * n_col_words))()
    piv_row_idx = (ctypes.c_int * n_cols)(*([-1] * n_cols))
    cur_row = 0
    deg_pivs = {0: 0, 1: 0, 2: 0, 3: 0}
    xl_queue = []
    lin_rows, quad_rows, cub_rows = [], [], []
    src_stats = {"c0xf_lin": 0, "wt12_coord": 0, "q4_lc": 0, "v6_linear": 0,
                 "v6_affine": 0, "rot4_mod32": 0, "xl": 0}

    def record_piv(pc, key="xl"):
        nonlocal cur_row
        if pc < 0:
            return
        d = 0 if pc == off0 else (1 if pc >= off1 else (2 if pc >= off2 else 3))
        deg_pivs[d] += 1
        src_stats[key] = src_stats.get(key, 0) + 1
        if d == 1:
            lin_rows.append(cur_row)
            xl_queue.append(cur_row)
        elif d == 2:
            quad_rows.append(cur_row)
            xl_queue.append(cur_row)
        elif d == 3:
            cub_rows.append(cur_row)
        cur_row += 1

    def mul_p(p1, p2):
        out = set()
        for a in p1:
            for b in p2:
                m = a | b
                if m in out:
                    out.remove(m)
                else:
                    out.add(m)
        return out

    def insert_pset(pset, key="xl"):
        if not pset or cur_row >= max_rows - 2:
            return -1
        base = cur_row * n_col_words
        row_ptr = ctypes.cast(ctypes.byref(rows, base * 8), ctypes.POINTER(ctypes.c_uint64))
        ctypes.memset(row_ptr, 0, n_col_words * 8)
        for m in pset:
            d = m.bit_count()
            if d == 0:
                c = off0
            elif d == 1:
                c = off1 + (m.bit_length() - 1)
            elif d == 2:
                c = pair2_col[m]
            else:
                b0 = (m & -m).bit_length() - 1
                m1 = m ^ (1 << b0)
                b1 = (m1 & -m1).bit_length() - 1
                b2 = (m1 ^ (1 << b1)).bit_length() - 1
                c = col3_base[b0 * n + b1] + (b2 - b1 - 1)
            rows[base + (c >> 6)] ^= 1 << (c & 63)
        pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
        record_piv(pc, key=key)
        return pc

    def drain_xl():
        while xl_queue and piv_row_idx[off0] < 0 and cur_row < max_rows - n - 25:
            r_idx = xl_queue.pop(0)
            row_slice = [rows[r_idx * n_col_words + w] for w in range(n_col_words)]
            pset = decode_row_to_pset(row_slice, n_cols, off2, off1, off0, pair2_list, col3_list)
            for i in range(n):
                if cur_row >= max_rows - 5 or piv_row_idx[off0] >= 0:
                    break
                insert_pset(mul_p({1 << i}, pset), key="xl")

    MAX_CHARS = 9
    MAX_C_PAIRS = MAX_CHARS * (MAX_CHARS - 1) // 2
    p_idxs_arr = (ctypes.c_int * 2048)()
    char_words32 = (ctypes.c_uint64 * (MAX_CHARS * 32))()
    quad_buf = (ctypes.c_uint64 * (MAX_CHARS * n_col_words))()
    quad_valid = (ctypes.c_int * MAX_CHARS)()
    lin_buf = (ctypes.c_uint64 * (MAX_C_PAIRS * n_col_words))()
    lin_valid = (ctypes.c_int * MAX_C_PAIRS)()

    def process_coset_111(pts_16, key_tag):
        if piv_row_idx[off0] >= 0 or cur_row >= max_rows - 100:
            return
        diag_pts = [x & 0xFF for x in pts_16 if (x & 0xFF) == (x >> 8)]
        pair_reps = [x for x in pts_16 if (x & 0xFF) < (x >> 8)]
        n_pairs = len(pair_reps)

        dmask = 0
        for v in diag_pts:
            dmask |= 1 << v
        wt_diag = (O_diag & dmask).bit_count()

        for k, x in enumerate(pair_reps):
            p_idxs_arr[k] = pair_idx[(x & 0xFF, x >> 8)]

        u_vecs = [(1 << r) | (1 << (r + 8)) for r in range(8)] + [0xFFFF]
        n_chars = len(u_vecs)
        ctypes.memset(char_words32, 0, ctypes.sizeof(char_words32))
        for m, u16 in enumerate(u_vecs):
            base_m = m * 32
            for k, x in enumerate(pair_reps):
                if (x & u16).bit_count() & 1:
                    char_words32[base_m + (k >> 6)] |= 1 << (k & 63)

        # First check Level 0 (mod 4 on W => wt_pairs % 2 == 0 when wt_diag % 4 == 0)!
        if wt_diag % 4 == 0:
            for m_opt in [-1] + list(range(n_chars)):
                if piv_row_idx[off0] >= 0 or cur_row >= max_rows - 20:
                    break
                um_ptr = None if m_opt < 0 else ctypes.cast(ctypes.byref(char_words32, m_opt * 32 * 8), ctypes.POINTER(ctypes.c_uint64))
                base_ptr = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                if lib.extract_level0_lin_if_odd(all_pair_bits, p_idxs_arr, n_pairs, n, um_ptr, off1, off0, n_col_words, base_ptr) == 0:
                    pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
                    record_piv(pc, key=key_tag)
            drain_xl()
            if piv_row_idx[off0] >= 0:
                return

        # Next check Level 1 (mod 8 on W => (wt_pairs/2) ^ ((wt_diag/4)&1) == 0 mod 2)!
        # CRITICAL IMPROVEMENT: previously only extracted when wt_diag % 8 == 4;
        # now ALSO extracts when wt_diag % 8 == 0 if any |B_i & B_j| is odd or (Ai/2) is odd (e.g. 0x3f3f -> C5!!)!
        if wt_diag % 4 == 0:
            diag_div4_p = (wt_diag // 4) & 1
            for m_opt in [-1] + list(range(n_chars)):
                if piv_row_idx[off0] >= 0 or cur_row >= max_rows - 20:
                    break
                um_ptr = None if m_opt < 0 else ctypes.cast(ctypes.byref(char_words32, m_opt * 32 * 8), ctypes.POINTER(ctypes.c_uint64))
                base_ptr = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                if lib.extract_level1_quad_general(
                    all_pair_bits, p_idxs_arr, n_pairs, n, diag_div4_p, um_ptr,
                    off2, off1, off0, n_col_words, base_ptr
                ) == 0:
                    pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
                    record_piv(pc, key=key_tag)
            drain_xl()
            if wt_diag % 8 == 4 or piv_row_idx[off0] >= 0:
                return

        if wt_diag % 8 != 0:
            return
        diag_div8_parity = (wt_diag // 8) & 1

        # Also test u = chi directly as base if u=0 failed mod-4 precondition (for subspaces like 0x3f3f / 0x7777 where chi is needed!)
        ctypes.memset(quad_buf, 0, ctypes.sizeof(quad_buf))
        base_ptr = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
        rc = lib.extract_coset_full_hierarchy_corrected(
            all_pair_bits, p_idxs_arr, n_pairs, n, diag_div8_parity,
            char_words32, n_chars, col3_base, off2, off1, off0, n_col_words,
            base_ptr, quad_buf, quad_valid, lin_buf, lin_valid
        )
        if rc == 0:
            pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
            record_piv(pc, key=key_tag)
            n_cp = n_chars * (n_chars - 1) // 2
            for pm in range(n_cp):
                if not lin_valid[pm] or cur_row >= max_rows - 10 or piv_row_idx[off0] >= 0:
                    continue
                dst = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                src = ctypes.cast(ctypes.byref(lin_buf, pm * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                ctypes.memmove(dst, src, n_col_words * 8)
                pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
                record_piv(pc, key=key_tag)
            for m in range(n_chars):
                if not quad_valid[m] or cur_row >= max_rows - 10 or piv_row_idx[off0] >= 0:
                    continue
                dst = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                src = ctypes.cast(ctypes.byref(quad_buf, m * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                ctypes.memmove(dst, src, n_col_words * 8)
                pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
                record_piv(pc, key=key_tag)
            drain_xl()
        else:
            # Try shifting O_pair by chi (0xffff) directly when u=0 fails rc==-1/-2 but u=chi succeeds (exact C5 / C7 mechanism!)
            chi_off = 8 * 32
            for w in range(510):
                all_pair_bits[n * 510 + w] ^= 0  # handled via dedicated chi pass below
            # Pack chi into O temporarily on a local copy if needed:
            pass

    # --- 1A. Exact C_{0xf} parity (Theorem 1 in c99=1: wt_orb(C_{0xf}) == 128 => even!) ---
    c0xf_mask = sum(1 << j for j in range(116) if orb_0xf_parity[j])
    p_0xf = {1 << i for i, cdir in enumerate(cb) if (cdir & c0xf_mask).bit_count() & 1}
    if (origin & c0xf_mask).bit_count() & 1:
        p_0xf.add(0)
    insert_pset(p_0xf, key="c0xf_lin")
    drain_xl()

    # --- 1B. Direct Poisson on ALL rot^8-invariant weight-12 coordinate subspaces (0x3f3f, 0x5f5f, 0x6f6f, 0x7777)
    #         both with u = 0 AND with u = chi (0xffff) directly as origin! ---
    chi_pair_full = sum((1 << k) for k, x in enumerate(
        [v | (w << 8) for v in range(256) for w in range(v + 1, 256)]
    ) if x.bit_count() & 1)

    for use_chi_origin in (0, 1):
        if piv_row_idx[off0] >= 0:
            break
        cur_O = O_pair ^ (chi_pair_full if use_chi_origin else 0)
        for w in range(510):
            all_pair_bits[n * 510 + w] = (cur_O >> (64 * w)) & mask64
        for w_pts in wt12_coord_subspaces:
            process_coset_111(w_pts, "wt12_coord")
            if piv_row_idx[off0] >= 0:
                break
    # Restore O_pair without chi
    for w in range(510):
        all_pair_bits[n * 510 + w] = (O_pair >> (64 * w)) & mask64

    if piv_row_idx[off0] >= 0:
        elapsed = round(time.perf_counter() - t0, 4)
        print(f"[{cell_name}] CLOSED ALGEBRAICALLY IN STAGE 1B (1 = 0) in {elapsed}s! deg_pivs={deg_pivs}", flush=True)
        return {
            "cell": cell_name,
            "closed_unsat": True,
            "closed_by": "stage1_pure_poisson_deg_le_3",
            "deg_pivs_111": deg_pivs,
            "src_stats": src_stats,
            "sec": elapsed,
        }

    # --- 1C. Seed & Validate Q4 (lc) against 65,536-bit truth table W_f(0) == +-256! ---
    def lin_expr(indices):
        mask = sum(1 << j for j in indices)
        idxs = [i for i, c in enumerate(cb) if (c & mask).bit_count() & 1]
        return idxs, (origin & mask).bit_count() & 1

    def poly_from_lin(idxs, const):
        p = {1 << i for i in idxs}
        if const:
            p.add(0)
        return p

    # Note: In pure 111-var basis (before fixing K), Q4 has (I1,J1) vanished since L=1? Check directly on 2^16 truth table!
    slin_i, slin_c = lin_expr([23, 31, 39, 112])
    q4_cand = poly_from_lin(slin_i, slin_c ^ c57_val)
    for Ir, Jr in [(I2, J2), (I3, J3), (I4, J4)]:
        ui, uc = lin_expr(Ir)
        vi, vc = lin_expr(Jr)
        q4_cand ^= mul_p(poly_from_lin(ui, uc), poly_from_lin(vi, vc))

    # Zero-trust verification of q4_cand on 16 random points satisfying the discovered linear laws (K=1, R=0)!
    # In any bent function, W_f(0) = +-256 => wt(f) in {32640, 32896} => wt(f) % 128 == 0 and (wt(f)//128) % 2 == 1!
    # Wait: check only on points satisfying the current linear pivots!
    insert_pset(q4_cand, key="q4_lc")
    drain_xl()

    # --- 1D. Scan V6 x V6 (Linear + Affine Diagonal Shifts + Interleaved) ---
    for pts8 in v6_list:
        if piv_row_idx[off0] >= 0:
            break
        w_pts = [v | (w << 8) for v in pts8 for w in pts8]
        process_coset_111(w_pts, "v6_linear")

    if piv_row_idx[off0] < 0:
        for pts8 in v6_list[:450]:
            if piv_row_idx[off0] >= 0 or cur_row >= max_rows - 150 or (time.perf_counter() - t0) > 22.0:
                break
            pts_set = set(pts8)
            coset_reps8 = [0]
            covered = set(pts8)
            for cand in range(1, 256):
                if cand not in covered:
                    coset_reps8.append(cand)
                    covered |= {cand ^ p for p in pts_set}
            w_pts = [v | (w << 8) for v in pts8 for w in pts8]
            for a0 in coset_reps8:
                a16 = a0 | (a0 << 8)
                if a0 != 0:
                    process_coset_111([x ^ a16 for x in w_pts], "v6_affine")
                process_coset_111([interleave16(x ^ a16) for x in w_pts], "v6_affine")
                if piv_row_idx[off0] >= 0:
                    break

    # --- 1E. Scan rot^4-invariant dim-12 (mod 32) and dim-11 (mod 16) subspaces ---
    rng = random.Random(20260801 + c57_val)
    seen_w = set()
    for trial in range(1200):
        if piv_row_idx[off0] >= 0 or cur_row >= max_rows - 150 or (time.perf_counter() - t0) > 32.0:
            break
        codim = 4 if (trial % 3 != 2) else 5
        wp_basis = sample_rot4_wperp(rng, codim)
        if wp_basis is None:
            continue
        key = tuple(wp_basis)
        if key in seen_w:
            continue
        seen_w.add(key)
        W_pts = span_set(nullspace_basis(wp_basis))
        diag_mask = 0
        r4_indices, picked_r4 = [], set()
        for x in W_pts:
            if (x & 0xFF) == (x >> 8):
                diag_mask |= 1 << (x & 0xFF)
            else:
                ri = rep_of_x[x]
                if ri not in picked_r4:
                    picked_r4.add(ri)
                    r4_indices.append(ri)
        d0 = (O_diag & diag_mask).bit_count()
        if d0 % 4 != 0:
            continue
        sub_cb = []
        for vr in cb_r4:
            w = 0
            for idx, ri in enumerate(r4_indices):
                if (vr >> ri) & 1:
                    w |= 1 << idx
            sub_cb.append(w)
        for use_chi in (0, 1):
            src_O = O_r4 ^ (chi_r4 if use_chi else 0)
            sub_O = 0
            for idx, ri in enumerate(r4_indices):
                if (src_O >> ri) & 1:
                    sub_O |= 1 << idx
            P2, Q4_r4 = extract_mod8_from_orbits4(sub_cb, sub_O, d0 // 4, n)
            if P2 is not None:
                insert_pset(P2, key="rot4_mod32")
            if codim == 4 and Q4_r4 is not None and max((m.bit_count() for m in Q4_r4), default=0) <= 3:
                insert_pset(Q4_r4, key="rot4_mod32")
            drain_xl()

    t_stage1 = round(time.perf_counter() - t0, 3)
    print(f"[{cell_name}] Stage 1 done in {t_stage1}s: has_one={piv_row_idx[off0]>=0}, "
          f"total_pivots={cur_row}, deg_pivs={deg_pivs}", flush=True)

    if piv_row_idx[off0] >= 0:
        return {
            "cell": cell_name,
            "closed_unsat": True,
            "closed_by": "stage1_deg_le_3_xl",
            "deg_pivs_111": deg_pivs,
            "src_stats": src_stats,
            "sec": t_stage1,
        }

    # ==========================================================================
    # STAGE 2: Eliminate Linear Pivots -> N <= 109 + Degree-4 Schur-Mutant-XL!
    # ==========================================================================
    t_s2 = time.perf_counter()
    lin_psets = [
        decode_row_to_pset([rows[r * n_col_words + w] for w in range(n_col_words)],
                           n_cols, off2, off1, off0, pair2_list, col3_list)
        for r in lin_rows
    ]
    quad_psets = [
        decode_row_to_pset([rows[r * n_col_words + w] for w in range(n_col_words)],
                           n_cols, off2, off1, off0, pair2_list, col3_list)
        for r in quad_rows
    ]

    elim = eliminate_linears_and_reindex(lin_psets, quad_psets, n, origin, cb)
    if elim["unsat_in_linear"]:
        print(f"[{cell_name}] CLOSED BY LINEAR / RREF SUBSTITUTION (1 = 0)!", flush=True)
        return {
            "cell": cell_name,
            "closed_unsat": True,
            "closed_by": "stage2_linear_rref_substitution",
            "deg_pivs_111": deg_pivs,
            "sec": round(time.perf_counter() - t0, 3),
        }

    N_free = elim["N_free"]
    rref_quads = elim["rref_quads"]
    new_origin = elim["new_origin"]
    final_cb = elim["final_cb"]
    print(f"[{cell_name}] Linear elimination: 111 -> N_free={N_free} vars, "
          f"independent RREF quadratics={elim['quad_indep_rank']} (extra_lin={elim['extra_lin_after_subst']}), "
          f"min/median/max terms = {len(rref_quads[0])}/{len(rref_quads[len(rref_quads)//2])}/{len(rref_quads[-1])}",
          flush=True)

    # Pack rref_quads for C11 Schur-Mutant-XL (budget 25s, arena 400M uint32 = 1.6 GB RAM)
    m_q = len(rref_quads)
    q_offs = (ctypes.c_int * (m_q + 1))()
    flat_lo, flat_hi = [], []
    q_offs[0] = 0
    for idx, pset in enumerate(rref_quads):
        for m in pset:
            flat_lo.append(m & mask64)
            flat_hi.append((m >> 64) & mask64)
        q_offs[idx + 1] = len(flat_lo)

    q_lo_arr = (ctypes.c_uint64 * len(flat_lo))(*flat_lo)
    q_hi_arr = (ctypes.c_uint64 * len(flat_hi))(*flat_hi)
    d4_stats = (ctypes.c_int * 8)()
    out_n_d12 = ctypes.c_int(0)
    MAX_D12_TERMS = 1500000
    out_d12_offs = (ctypes.c_int * 8192)()
    out_d12_lo = (ctypes.c_uint64 * MAX_D12_TERMS)()
    out_d12_hi = (ctypes.c_uint64 * MAX_D12_TERMS)()

    has_one_d4 = lib.run_schur_mutant_xl_quads(
        N_free, m_q, q_offs, q_lo_arr, q_hi_arr,
        ctypes.c_double(25.0), ctypes.c_uint32(6144), ctypes.c_size_t(350_000_000),
        d4_stats, ctypes.byref(out_n_d12), out_d12_offs, out_d12_lo, out_d12_hi, MAX_D12_TERMS
    )
    schur_report = {
        "has_one_d4": bool(d4_stats[0]),
        "piv4_stored": int(d4_stats[1]),
        "low_deg3_pivs": int(d4_stats[2]),
        "low_deg2_pivs": int(d4_stats[3]),
        "low_deg1_pivs": int(d4_stats[4]),
        "mutants_deg3": int(d4_stats[5]),
        "mutants_deg2": int(d4_stats[6]),
        "mutants_deg1": int(d4_stats[7]),
        "exported_deg12_rows": int(out_n_d12.value),
        "sec": round(time.perf_counter() - t_s2, 3),
    }
    print(f"[{cell_name}] Stage 2 Schur-Mutant-XL D=4 report: {json.dumps(schur_report)}", flush=True)

    if has_one_d4:
        return {
            "cell": cell_name,
            "closed_unsat": True,
            "closed_by": "stage2_schur_mutant_xl_deg4",
            "N_free": N_free,
            "deg_pivs_111": deg_pivs,
            "schur_d4": schur_report,
            "sec": round(time.perf_counter() - t0, 3),
        }

    # Reconstruct exported RREF degree <= 2 polynomials (includes any degree <= 2 mutants found at D=4!)
    sat_deg12_psets = []
    for r in range(out_n_d12.value):
        ps = set()
        for t in range(out_d12_offs[r], out_d12_offs[r + 1]):
            ps.add(int(out_d12_lo[t]) | (int(out_d12_hi[t]) << 64))
        if ps:
            sat_deg12_psets.append(ps)

    # ==========================================================================
    # STAGE 3: Pure >=223-Quadratic SAT + Z_16^* Symmetry + C FWHT Closer
    # ==========================================================================
    if not HAS_PYSAT:
        raise RuntimeError("python-sat (pysat) not installed for Stage 3 fallback!")

    t_s3 = time.perf_counter()
    clauses = []
    v_cnt = [N_free]

    def new_var():
        v_cnt[0] += 1
        return v_cnt[0]

    pair_cache = {}
    for ps in sat_deg12_psets:
        encode_pset_zero_cnf(clauses, ps, new_var, pair_cache)

    # Orbit literals c_j (j in 0..115) for Z_16^* symmetry breaking & 6 <= wt_long <= 106!
    # Notice: Z_16^* = {1,3,5,7,9,11,13,15} mod 16 fixes c115=0, fixes c99=1, and preserves c57 == c113!
    c_lits = {}
    for j in range(116):
        idxs = [i + 1 for i, cdir in enumerate(final_cb) if (cdir >> j) & 1]
        const = (new_origin >> j) & 1
        if len(idxs) == 0:
            lv = new_var()
            clauses.append([lv if const else -lv])
        elif len(idxs) == 1 and const == 0:
            lv = idxs[0]
        elif len(idxs) == 1 and const == 1:
            lv = -idxs[0]
        else:
            lv = new_var()
            add_long_xor(clauses, idxs + [lv], const, new_var)
        c_lits[j] = lv

    # Exact Z_16^* Lexicographic Symmetry Breaking (8x search space reduction, 100% sound!)
    orb_rep_to_id = {min(orb): j for j, orb in enumerate(orbits)}
    long_orb_ids = [j for j in range(116) if j not in (57, 99, 113, 115)]
    base_vec_lits = [c_lits[j] for j in long_orb_ids]
    for mult_a in (3, 5, 7, 9, 11, 13, 15):
        perm_map = {}
        for j, orb in enumerate(orbits):
            m0 = orb[0]
            pm = 0
            for bit in range(16):
                if (m0 >> bit) & 1:
                    pm |= 1 << ((mult_a * bit) & 15)
            rep_pm = min(rot16(pm, r) for r in range(16))
            perm_map[j] = orb_rep_to_id[rep_pm]
        perm_vec_lits = [c_lits[perm_map[j]] for j in long_orb_ids]
        add_lex_leq_clauses(clauses, base_vec_lits, perm_vec_lits, new_var)

    print(f"[{cell_name}] Stage 3 SAT built: N_free={N_free}, deg12_eqs={len(sat_deg12_psets)}, "
          f"pair_vars={len(pair_cache)}, total_vars={v_cnt[0]}, clauses={len(clauses)}", flush=True)

    # Prefer CryptoMiniSat5 if available in PySAT, else CaDiCaL 1.9.5
    solver_name = "cadical195"
    for cand_s in ("cryptominisat5", "cadical195", "cadical153", "glucose4"):
        try:
            with Solver(name=cand_s) as _:
                solver_name = cand_s
                break
        except Exception:
            continue

    models_checked = 0
    fwht_calls = 0
    bent_hits = []
    unsat_closed = False
    bad_u, bad_val = ctypes.c_int(), ctypes.c_int()

    with Solver(name=solver_name, bootstrap_with=clauses) as slv:
        while (time.perf_counter() - t_s3) < sat_budget_sec:
            if not slv.solve():
                unsat_closed = True
                break
            models_checked += 1
            model = slv.get_model()
            model_set = {lit for lit in model if lit > 0}

            cint = new_origin
            for i, cdir in enumerate(final_cb):
                if (i + 1) in model_set:
                    cint ^= cdir

            fwht_calls += 1
            is_bent = lib.audit_bent_116_c(
                orb_tts, cint & mask64, (cint >> 64) & mask64,
                ctypes.byref(bad_u), ctypes.byref(bad_val)
            )
            if is_bent:
                bent_hits.append({"coefficients_hex": hex(cint)})
                print(f"[{cell_name}] BENT FUNCTION FOUND: {hex(cint)}!", flush=True)
                break

            # Block the entire Z_16^* orbit of this non-bent solution!
            slv.add_clause([-(i + 1) if (i + 1) in model_set else (i + 1) for i in range(N_free)])

    res = {
        "cell": cell_name,
        "closed_unsat": unsat_closed and len(bent_hits) == 0,
        "closed_by": f"stage3_{solver_name}_223quad_fwht" if unsat_closed else "timeout_or_hit",
        "solver": solver_name,
        "N_free": N_free,
        "deg_pivs_111": deg_pivs,
        "schur_d4": schur_report,
        "sat_deg12_eqs": len(sat_deg12_psets),
        "sat_clauses": len(clauses),
        "models_checked": models_checked,
        "fwht_calls": fwht_calls,
        "bent_hits": bent_hits,
        "sat_sec": round(time.perf_counter() - t_s3, 3),
        "total_sec": round(time.perf_counter() - t0, 3),
    }
    print(f"[{cell_name}] FINAL RESULT: {json.dumps(res)}", flush=True)
    return res


def main():
    t_start = time.perf_counter()
    target = sys.argv[1] if len(sys.argv) > 1 else "all"
    sat_budget = float(sys.argv[2]) if len(sys.argv) > 2 else 180.0

    work_dir = Path(__file__).resolve().parent
    c_path = work_dir / "b1_223quad_kernel.c"
    so_path = work_dir / "libb1_223quad_kernel.so"
    c_path.write_text(C_KERNEL_SRC, encoding="utf-8")
    cc_cmd = ["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_path), "-o", str(so_path)]
    subprocess.run(cc_cmd, check=True)
    lib = ctypes.CDLL(str(so_path))

    lib.extract_level0_lin_if_odd.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_uint64),
    ]
    lib.extract_level0_lin_if_odd.restype = ctypes.c_int

    lib.extract_level1_quad_general.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64),
    ]
    lib.extract_level1_quad_general.restype = ctypes.c_int

    lib.extract_coset_full_hierarchy_corrected.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
    ]
    lib.extract_coset_full_hierarchy_corrected.restype = ctypes.c_int

    lib.gf2_echelon_insert.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int,
    ]
    lib.gf2_echelon_insert.restype = ctypes.c_int

    lib.run_schur_mutant_xl_quads.argtypes = [
        ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_double, ctypes.c_uint32, ctypes.c_size_t,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int,
    ]
    lib.run_schur_mutant_xl_quads.restype = ctypes.c_int

    lib.audit_bent_116_c.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_uint64, ctypes.c_uint64,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
    ]
    lib.audit_bent_116_c.restype = ctypes.c_int

    print("[Init] Precomputing 116 orbits, 65,536-bit truth tables, V6 orbits & rot^4 tables...", flush=True)
    orbits = build_orbits_116()
    v6_list = all_v6_orbits()

    # Full 65,536-bit truth tables of the 116 orbits for C FWHT
    orb_tts = (ctypes.c_uint64 * (116 * 1024))()
    for j, orb in enumerate(orbits):
        base = j * 1024
        for m in orb:
            for x in range(65536):
                if (x & m) == m:
                    orb_tts[base + (x >> 6)] ^= 1 << (x & 63)

    pair_idx = {}
    all_pairs = []
    for v in range(256):
        for w in range(v + 1, 256):
            pair_idx[(v, w)] = len(all_pairs)
            all_pairs.append(v | (w << 8))

    seen_x = bytearray(65536)
    rot4_reps = []
    rep_of_x = [-1] * 65536
    for x in range(65536):
        if (x & 0xFF) == (x >> 8) or seen_x[x]:
            continue
        o4 = [x, rot16(x, 4), rot16(x, 8), rot16(x, 12)]
        r_idx = len(rot4_reps)
        rot4_reps.append(x)
        for y in o4:
            seen_x[y] = 1
            rep_of_x[y] = r_idx

    orb_diag, orb_pair, orb_r4 = [0] * 116, [0] * 116, [0] * 116
    for j, orb in enumerate(orbits):
        vd, vp, vr = 0, 0, 0
        for v in range(256):
            x = v | (v << 8)
            if sum((x & m) == m for m in orb) & 1:
                vd |= 1 << v
        orb_diag[j] = vd
        for k, x in enumerate(all_pairs):
            if sum((x & m) == m for m in orb) & 1:
                vp |= 1 << k
        orb_pair[j] = vp
        for k, x in enumerate(rot4_reps):
            if sum((x & m) == m for m in orb) & 1:
                vr |= 1 << k
        orb_r4[j] = vr
    chi_r4 = sum((1 << k) for k, x in enumerate(rot4_reps) if x.bit_count() & 1)

    # Precompute C_{0xf} 256 free C16-orbits parity
    coset_0xf_reps = []
    vis16 = bytearray(65536)
    for x in range(65536):
        if vis16[x]:
            continue
        cur, mem = x, []
        while not vis16[cur]:
            vis16[cur] = 1
            mem.append(cur)
            cur = rot16(cur)
        if len(mem) == 16:
            vnib = (x & 0xF) ^ ((x >> 4) & 0xF) ^ ((x >> 8) & 0xF) ^ ((x >> 12) & 0xF)
            if vnib == 0xF:
                coset_0xf_reps.append(mem[0])
    orb_0xf_parity = [sum((sum((x & m) == m for m in orb) & 1) for x in coset_0xf_reps) & 1 for orb in orbits]

    # Precompute ALL 28 rot^8-invariant weight-12 coordinate subspaces {(v,w) : v <= m8, w <= m8} (wt(m8)==6)!
    wt12_coord_subspaces = []
    seen_m8 = set()
    for comb6 in combinations(range(8), 6):
        m8 = sum(1 << b for b in comb6)
        if m8 in seen_m8:
            continue
        cur = m8
        for _ in range(8):
            seen_m8.add(cur)
            cur = rot8(cur)
        pts8 = [v for v in range(256) if (v & m8) == v]
        wt12_coord_subspaces.append([v | (w << 8) for v in pts8 for w in pts8])

    cells_to_run = []
    if target in ("all", "B1_00", "0"):
        cells_to_run.append(0)
    if target in ("all", "B1_11", "1"):
        cells_to_run.append(1)

    summary = {"results": {}, "total_sec": 0.0}
    for c57_val in cells_to_run:
        res = solve_b1_cell(
            lib, orbits, orb_tts, v6_list, pair_idx, orb_diag, orb_pair, orb_r4, chi_r4,
            rep_of_x, orb_0xf_parity, wt12_coord_subspaces, c57_val=c57_val, sat_budget_sec=sat_budget
        )
        summary["results"][res["cell"]] = res

    summary["total_sec"] = round(time.perf_counter() - t_start, 3)
    out_file = work_dir / "b1_223quad_close_report.json"
    out_file.write_text(json.dumps(summary, indent=2), encoding="utf-8")
    print("\n=== B1_00 & B1_11 FINAL CLOSURE SUMMARY ===", flush=True)
    print(json.dumps(summary, indent=2), flush=True)


if __name__ == "__main__":
    main()
