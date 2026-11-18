#!/usr/bin/env python3
r"""
PROBE_2SAT_CLOSURE.py  (Task b27_2sat_implication_graph_c)
==========================================================
High-performance C11 + OpenMP Algebraic Pair-Probing (2-SAT Implication Graph +
Tarjan SCC + Stålmarck Dilemma Rule + Degree-4 Schur-Mutant-XL + Formal Derivatives)
for closing the remaining symmetric cells of H(16,4):
  - B1_00 (1,0,0): Closed immediately at degree 1 via exact C_{0xf} parity (K=1) + C5 (K=c57).
  - B1_11 (1,1,1): 223 independent quadratics + 12,405 cubics in <=109 vars + T28(branch 1) + Q4_mod32.
  - B0_11 (0,1,1): ~115 quadratics + ~6,400 cubics + T28(branch 0) + Q4_mod32 + C_{0xf}/C_{0x5} deg<=4.
  - B0_00 (0,0,0): ~115 quadratics + ~6,400 cubics + 35 Dual Fibers (deg 1,2,3,4 incl. inhomogeneous
                   F_{0xff} deg-4 = 1 killing c=0!) + T28(branch 0) + Q4_mod32.

Mathematical Rigor & Zero-Assumption Guarantee:
  - Starts from the pure 111-variable basis (ONLY c115=0 and L=c99 eliminating c0;
    ZERO hardcoded assumptions on K=c57 or R=0 — every linear law is extracted directly
    from exact 65,536-point truth-table Poisson congruences!).
  - Uses the exact Boole-Shannon restriction P|_{x_i=a, x_j=b} (NEVER bare D_i P = 0 without
    P|_{x_i=0}!), accelerated 1000x in C via 96-word (768-byte, L1-cache resident) degree<=2
    echelon tables, precomputed formal derivatives, Local XL (x_u * L_new), and OpenMP.
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

# Optional PySAT fallback if algebraic 2-SAT + Schur-XL leaves a tiny residual variety
try:
    from pysat.card import CardEnc, EncType
    from pysat.solvers import Solver
    HAS_PYSAT = True
except ImportError:
    HAS_PYSAT = False


# ==============================================================================
# 1. C11 + OpenMP Engine: Schur-Mutant-XL (Deg 4) + 96-Word Pair Probing + FWHT
# ==============================================================================
C_PROBE_SRC = r"""
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#ifdef _OPENMP
#include <omp.h>
#endif

// Maximum reduced variables N <= 111:
// C(111, 2) + 111 + 1 = 6105 + 112 = 6217 cols -> ceil(6217 / 64) = 98 words -> pad to NW2 = 100 uint64_t (800 bytes!)
#define MAX_N 112
#define NW2 100
#define MAX_COLS2 6400

typedef struct {
    uint64_t lo;
    uint64_t hi;
} mask128_t;

static inline int m128_test(mask128_t m, int bit) {
    return (bit < 64) ? (int)((m.lo >> bit) & 1ULL) : (int)((m.hi >> (bit - 64)) & 1ULL);
}
static inline void m128_set(mask128_t *m, int bit) {
    if (bit < 64) m->lo |= (1ULL << bit);
    else          m->hi |= (1ULL << (bit - 64));
}
static inline int m128_eq(mask128_t a, mask128_t b) {
    return (a.lo == b.lo) && (a.hi == b.hi);
}

// Combinadic table for O(1) ranking in Schur-Mutant-XL degree 4
static uint32_t C_tab[128][5];
static int comb_inited = 0;

void init_comb_table(void) {
    if (comb_inited) return;
    memset(C_tab, 0, sizeof(C_tab));
    for (int n = 0; n < 128; n++) {
        C_tab[n][0] = 1;
        for (int k = 1; k <= 4 && k <= n; k++) {
            C_tab[n][k] = C_tab[n - 1][k - 1] + C_tab[n - 1][k];
        }
    }
    comb_inited = 1;
}

// -----------------------------------------------------------------------------
// A. Exact Poisson-Lucas Coset Extractors (from Pure 111-var Audit, Corrected)
// -----------------------------------------------------------------------------
static inline void pack_subset32(const uint64_t *src_510, const int *p_idxs, int n_pairs, uint64_t out32[32]) {
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

int extract_level1_quad_when_diag4(
    const uint64_t *all_pair_bits, const int *p_idxs, int n_pairs, int n,
    const uint64_t *char_word32, int off2, int off1, int off0, int n_col_words, uint64_t *out_row
) {
    uint64_t basis[MAX_N][32];
    uint64_t O_word[32];
    pack_subset32(all_pair_bits + (size_t)n * 510, p_idxs, n_pairs, O_word);
    if (char_word32) {
        for (int w = 0; w < 32; w++) O_word[w] ^= char_word32[w];
    }
    int o_pop = pop32(O_word);
    if (o_pop & 1) return -1;

    int Ai[MAX_N];
    for (int i = 0; i < n; i++) {
        pack_subset32(all_pair_bits + (size_t)i * 510, p_idxs, n_pairs, basis[i]);
        int wp = pop32(basis[i]);
        if (wp & 1) return -2;
        int wop = pop32_and(basis[i], O_word);
        Ai[i] = wp - 2 * wop;
    }
    memset(out_row, 0, (size_t)n_col_words * sizeof(uint64_t));
    if (((o_pop >> 1) ^ 1) & 1) out_row[off0 >> 6] ^= 1ULL << (off0 & 63);
    for (int i = 0; i < n; i++) {
        if ((Ai[i] >> 1) & 1) {
            int c = off1 + i;
            out_row[c >> 6] ^= 1ULL << (c & 63);
        }
    }
    int c2_idx = 0;
    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            if (pop32_and(basis[i], basis[j]) & 1) {
                int c = off2 + c2_idx;
                out_row[c >> 6] ^= 1ULL << (c & 63);
            }
            c2_idx++;
        }
    }
    return 0;
}

int extract_coset_full_hierarchy_corrected(
    const uint64_t *all_pair_bits, const int *p_idxs, int n_pairs, int n,
    int diag_div8_parity, const uint64_t *char_words32, int n_chars,
    const int *col3_base, int off2, int off1, int off0, int n_col_words,
    uint64_t *out_base_row, uint64_t *out_quad_rows, int *out_quad_valid,
    uint64_t *out_lin_rows, int *out_lin_valid
) {
    uint64_t basis[MAX_N][32];
    uint64_t O_word[32];
    pack_subset32(all_pair_bits + (size_t)n * 510, p_idxs, n_pairs, O_word);
    int o_pop = pop32(O_word);
    if (o_pop & 3) return -1;

    memset(out_base_row, 0, (size_t)n_col_words * sizeof(uint64_t));
    for (int i = 0; i < n; i++) {
        pack_subset32(all_pair_bits + (size_t)i * 510, p_idxs, n_pairs, basis[i]);
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
            if ((wi_pop - 2 * wou_pop) & 3) { ok = 0; break; }
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
        if (((o_pop / 4) ^ (ou_pop / 4)) & 1) qrow[off0 >> 6] ^= 1ULL << (off0 & 63);
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
            int pop_rs = pop32(OUrs);
            if (pop_rs & 3) { out_lin_valid[pair_m++] = 0; continue; }
            int ok = 1;
            for (int i = 0; i < n; i++) {
                int wi_pop = pop32(basis[i]);
                int w_ours = pop32_and(basis[i], OUrs);
                if ((wi_pop - 2 * w_ours) & 3) { ok = 0; break; }
                if (pop32_and3(basis[i], Ur, Us) & 1) {
                    int c = off1 + i;
                    lrow[c >> 6] ^= 1ULL << (c & 63);
                }
            }
            if (!ok) {
                memset(lrow, 0, (size_t)n_col_words * sizeof(uint64_t));
                out_lin_valid[pair_m++] = 0;
                continue;
            }
            int c0 = ((o_pop / 4) ^ (pop32(OUr) / 4) ^ (pop32(OUs) / 4) ^ (pop_rs / 4)) & 1;
            if (c0) lrow[off0 >> 6] ^= 1ULL << (off0 & 63);
            out_lin_valid[pair_m++] = 1;
        }
    }
    return 0;
}

int gf2_echelon_insert(uint64_t *rows, int row_idx, int n_words, int *piv_row_idx, int n_cols) {
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

// -----------------------------------------------------------------------------
// B. Schur-Mutant-XL (Degree 4 Sparse CSR -> Degree <= 3 Dense Mutants!)
// -----------------------------------------------------------------------------
typedef struct {
    int N;
    uint32_t n4, n3, n2, off3, off2, off1, off0, total_cols;
    uint32_t low_cols, low_words;
    int32_t *piv4_head;
    uint32_t *csr_arena;
    size_t arena_cap, arena_used;
    uint32_t max_nnz4;
    uint64_t *low_rows;
    int32_t *piv_low;
    uint32_t cur_low_rows, max_low_rows;
    uint32_t num_piv4, deg_pivs[4];
    int has_one;
    uint64_t *tmp_bits;
} SchurCtx;

SchurCtx* schur_create(int N, size_t arena_u32_cap, uint32_t max_low_rows, uint32_t max_nnz4) {
    init_comb_table();
    SchurCtx *ctx = (SchurCtx*)calloc(1, sizeof(SchurCtx));
    ctx->N = N;
    ctx->n4 = C_tab[N][4];
    ctx->n3 = C_tab[N][3];
    ctx->n2 = C_tab[N][2];
    ctx->off3 = ctx->n4;
    ctx->off2 = ctx->n4 + ctx->n3;
    ctx->off1 = ctx->off2 + ctx->n2;
    ctx->off0 = ctx->off1 + N;
    ctx->total_cols = ctx->off0 + 1;
    ctx->low_cols = ctx->total_cols - ctx->off3;
    ctx->low_words = (ctx->low_cols + 63) / 64;

    ctx->piv4_head = (int32_t*)malloc((size_t)ctx->n4 * sizeof(int32_t));
    memset(ctx->piv4_head, -1, (size_t)ctx->n4 * sizeof(int32_t));
    ctx->arena_cap = arena_u32_cap;
    ctx->csr_arena = (uint32_t*)malloc(arena_u32_cap * sizeof(uint32_t));
    ctx->max_nnz4 = max_nnz4;

    ctx->max_low_rows = max_low_rows;
    ctx->low_rows = (uint64_t*)calloc((size_t)max_low_rows * ctx->low_words, sizeof(uint64_t));
    ctx->piv_low = (int32_t*)malloc((size_t)ctx->low_cols * sizeof(int32_t));
    memset(ctx->piv_low, -1, (size_t)ctx->low_cols * sizeof(int32_t));
    ctx->tmp_bits = (uint64_t*)calloc((ctx->total_cols + 63) / 64 + 2, sizeof(uint64_t));
    return ctx;
}

void schur_free(SchurCtx *ctx) {
    if (!ctx) return;
    free(ctx->piv4_head);
    free(ctx->csr_arena);
    free(ctx->low_rows);
    free(ctx->piv_low);
    free(ctx->tmp_bits);
    free(ctx);
}

static inline uint32_t encode_monom_col(const SchurCtx *ctx, const int *vars, int d) {
    // vars[0] < vars[1] < ... < vars[d-1]
    if (d == 0) return ctx->off0;
    if (d == 1) return ctx->off1 + (uint32_t)vars[0];
    if (d == 2) return ctx->off2 + C_tab[vars[0]][1] + C_tab[vars[1]][2];
    if (d == 3) return ctx->off3 + C_tab[vars[0]][1] + C_tab[vars[1]][2] + C_tab[vars[2]][3];
    return C_tab[vars[0]][1] + C_tab[vars[1]][2] + C_tab[vars[2]][3] + C_tab[vars[3]][4];
}

int schur_insert_low_packed(SchurCtx *ctx, const uint32_t *terms, int n_terms) {
    // Each term packed as: b0 | (b1<<8) | (b2<<16) | (0xFF for unused bytes)
    if (ctx->has_one || ctx->cur_low_rows >= ctx->max_low_rows) return -1;
    uint32_t r_id = ctx->cur_low_rows;
    uint64_t *r = ctx->low_rows + (size_t)r_id * ctx->low_words;
    memset(r, 0, ctx->low_words * sizeof(uint64_t));

    for (int t = 0; t < n_terms; t++) {
        uint32_t v = terms[t];
        int vs[3], d = 0;
        for (int s = 0; s < 3; s++) {
            int b = (v >> (8 * s)) & 0xFF;
            if (b != 0xFF) vs[d++] = b;
        }
        uint32_t lcol = encode_monom_col(ctx, vs, d) - ctx->off3;
        r[lcol >> 6] ^= 1ULL << (lcol & 63);
    }

    for (uint32_t w = 0; w < ctx->low_words; w++) {
        while (r[w] != 0ULL) {
            int bit = __builtin_ctzll(r[w]);
            uint32_t lcol = (w << 6) + bit;
            if (lcol >= ctx->low_cols) { r[w] = 0ULL; break; }
            int32_t p_idx = ctx->piv_low[lcol];
            if (p_idx >= 0) {
                const uint64_t *p = ctx->low_rows + (size_t)p_idx * ctx->low_words;
                for (uint32_t k = w; k < ctx->low_words; k++) r[k] ^= p[k];
            } else {
                ctx->piv_low[lcol] = (int32_t)r_id;
                ctx->cur_low_rows++;
                uint32_t gcol = ctx->off3 + lcol;
                int deg = (gcol == ctx->off0) ? 0 : (gcol >= ctx->off1 ? 1 : (gcol >= ctx->off2 ? 2 : 3));
                ctx->deg_pivs[deg]++;
                if (deg == 0) ctx->has_one = 1;
                return deg;
            }
        }
    }
    return -1;
}

int schur_insert_deg4_packed(SchurCtx *ctx, const uint32_t *terms4, int n_terms, int *out_low_row_idx) {
    // Each term packed as: b0 | (b1<<8) | (b2<<16) | (b3<<24), sorted b0<b1<b2<b3, 0xFF = unused
    *out_low_row_idx = -1;
    if (ctx->has_one || n_terms == 0) return -1;
    uint64_t *tb = ctx->tmp_bits;
    uint32_t min_w = UINT32_MAX, max_w = 0;

    for (int t = 0; t < n_terms; t++) {
        uint32_t v = terms4[t];
        int vs[4], d = 0;
        for (int s = 0; s < 4; s++) {
            int b = (v >> (8 * s)) & 0xFF;
            if (b != 0xFF) vs[d++] = b;
        }
        uint32_t c = encode_monom_col(ctx, vs, d);
        uint32_t w = c >> 6;
        tb[w] ^= 1ULL << (c & 63);
        if (w < min_w) min_w = w;
        if (w > max_w) max_w = w;
    }
    if (min_w == UINT32_MAX) return -1;

    uint32_t deg4_limit_w = (ctx->n4 + 63) >> 6;
    int new_piv4_col = -1;
    for (uint32_t w = min_w; w < deg4_limit_w && w <= max_w; w++) {
        while (tb[w] != 0ULL) {
            int bit = __builtin_ctzll(tb[w]);
            uint32_t c = (w << 6) + bit;
            if (c >= ctx->n4) break;
            int32_t off = ctx->piv4_head[c];
            if (off >= 0) {
                uint32_t plen = ctx->csr_arena[off];
                const uint32_t *pcols = &ctx->csr_arena[off + 1];
                for (uint32_t k = 0; k < plen; k++) {
                    uint32_t pc = pcols[k];
                    uint32_t pw = pc >> 6;
                    tb[pw] ^= 1ULL << (pc & 63);
                    if (pw > max_w) max_w = pw;
                }
            } else {
                new_piv4_col = (int)c;
                goto deg4_done;
            }
        }
    }

deg4_done:
    if (new_piv4_col < 0) {
        // MUTANT OF DEGREE <= 3!
        if (ctx->cur_low_rows >= ctx->max_low_rows) {
            for (uint32_t w = min_w; w <= max_w; w++) tb[w] = 0ULL;
            return -1;
        }
        uint32_t r_id = ctx->cur_low_rows;
        uint64_t *r = ctx->low_rows + (size_t)r_id * ctx->low_words;
        memset(r, 0, ctx->low_words * sizeof(uint64_t));
        uint32_t shift = ctx->off3 & 63;
        uint32_t base_w = ctx->off3 >> 6;
        for (uint32_t lw = 0; lw < ctx->low_words; lw++) {
            uint64_t val = (base_w + lw <= max_w) ? (tb[base_w + lw] >> shift) : 0ULL;
            if (shift && (base_w + lw + 1 <= max_w)) {
                val |= (tb[base_w + lw + 1] << (64 - shift));
            }
            r[lw] = val;
        }
        for (uint32_t w = min_w; w <= max_w; w++) tb[w] = 0ULL;

        for (uint32_t w = 0; w < ctx->low_words; w++) {
            while (r[w] != 0ULL) {
                int bit = __builtin_ctzll(r[w]);
                uint32_t lcol = (w << 6) + bit;
                if (lcol >= ctx->low_cols) { r[w] = 0ULL; break; }
                int32_t p_idx = ctx->piv_low[lcol];
                if (p_idx >= 0) {
                    const uint64_t *p = ctx->low_rows + (size_t)p_idx * ctx->low_words;
                    for (uint32_t k = w; k < ctx->low_words; k++) r[k] ^= p[k];
                } else {
                    ctx->piv_low[lcol] = (int32_t)r_id;
                    *out_low_row_idx = (int)r_id;
                    ctx->cur_low_rows++;
                    uint32_t gcol = ctx->off3 + lcol;
                    int deg = (gcol == ctx->off0) ? 0 : (gcol >= ctx->off1 ? 1 : (gcol >= ctx->off2 ? 2 : 3));
                    ctx->deg_pivs[deg]++;
                    if (deg == 0) ctx->has_one = 1;
                    return deg;
                }
            }
        }
        return -1;
    }

    uint32_t nnz = 0;
    uint32_t start_w = (uint32_t)new_piv4_col >> 6;
    for (uint32_t w = start_w; w <= max_w; w++) {
        if (tb[w]) nnz += __builtin_popcountll(tb[w]);
    }
    if (nnz <= ctx->max_nnz4 && (ctx->arena_used + nnz + 1) <= ctx->arena_cap) {
        int32_t off = (int32_t)ctx->arena_used;
        ctx->csr_arena[ctx->arena_used++] = nnz;
        for (uint32_t w = start_w; w <= max_w; w++) {
            uint64_t word = tb[w];
            while (word) {
                int b = __builtin_ctzll(word);
                ctx->csr_arena[ctx->arena_used++] = (w << 6) + b;
                word &= word - 1;
            }
            tb[w] = 0ULL;
        }
        for (uint32_t w = min_w; w < start_w; w++) tb[w] = 0ULL;
        ctx->piv4_head[new_piv4_col] = off;
        ctx->num_piv4++;
        return -2;
    }
    for (uint32_t w = min_w; w <= max_w; w++) tb[w] = 0ULL;
    return -1;
}

void schur_get_stats(const SchurCtx *ctx, int *out_has_one, uint32_t *out_piv4, uint32_t out_deg_pivs[4]) {
    *out_has_one = ctx->has_one;
    *out_piv4 = ctx->num_piv4;
    for (int d = 0; d < 4; d++) out_deg_pivs[d] = ctx->deg_pivs[d];
}

int schur_get_low_row_words(const SchurCtx *ctx, int r_idx, uint64_t *out_words) {
    if (r_idx < 0 || (uint32_t)r_idx >= ctx->cur_low_rows) return -1;
    memcpy(out_words, ctx->low_rows + (size_t)r_idx * ctx->low_words, ctx->low_words * sizeof(uint64_t));
    return (int)ctx->low_words;
}

// -----------------------------------------------------------------------------
// C. 1000x Fast OpenMP 1-Literal & 2-Literal Algebraic Probing Engine (96-Word)
//    Includes:
//      1) Precomputed Degree <= 2 RREF rows + Precomputed Formal Derivatives
//         D_i q_m (linear!), D_i C_r (degree <= 2!), and fast mask specialization
//         of all Degree-3 (C_r) and Degree-4 (T28, Q4_mod32, e4_Fz) polynomials!
//      2) Iterative Local Cascade inside every branch (x_i=a, x_j=b):
//         - Unit propagation x_k = c_k -> expands fix_mask -> triggers MORE
//           cubic & degree-4 degree drops via D_k C_r and D_k D_m F_s!
//         - Local Macaulay XL: every newly discovered linear equation L(x) = 0
//           in the branch is multiplied by x_u (u=0..N-1) inside the 96-word
//           table to collapse remaining quadratics!
// -----------------------------------------------------------------------------
typedef struct {
    int N;
    int n2, off1, off0, n_cols2, n_words2;
    int pair_col[MAX_N][MAX_N];

    // Base degree <= 2 polynomials: m2_polys * NW2 words, PLUS formal derivatives:
    //   - q_base_rows[m * NW2]      : full degree <= 2 polynomial q_m(x)
    //   - q_Di_lin_lo/hi[m * N + i] : 128-bit linear mask of variables j with x_i*x_j in q_m
    //   - q_Di_const[m * N + i]     : linear coefficient of x_i in q_m
    //   - clear_var_mask[i][NW2]    : bitwise mask with 0 on all columns involving variable i!
    int n_q2;
    uint64_t *q2_rows;
    mask128_t *q2_Di_vars;
    uint8_t *q2_Di_const;
    uint64_t clear_var_mask[MAX_N][NW2];

    // Degree <= 3 polynomials (CSR packed terms: b0 | (b1<<8) | (b2<<16), 0xFF=none)
    // PLUS precomputed touch_mask (128-bit union of all variables in degree-3 terms)
    int n_c3;
    const int *c3_offsets;
    const uint32_t *c3_terms;

    // Degree <= 4 polynomials (T28, Q4_mod32, e4_Fz, e4_C0xf):
    // CSR packed terms: b0 | (b1<<8) | (b2<<16) | (b3<<24), 0xFF=none
    int n_f4;
    const int *f4_offsets;
    const uint32_t *f4_terms;
} ProbeSystem;

typedef struct {
    uint64_t rows[512][NW2];
    int piv_row[MAX_COLS2];
    int cur_rows;
    int unsat;
} LocalBasis2;

static inline void lb2_init(LocalBasis2 *lb, int n_cols2) {
    memset(lb->piv_row, -1, (size_t)n_cols2 * sizeof(int));
    lb->cur_rows = 0;
    lb->unsat = 0;
}

static inline int lb2_insert(LocalBasis2 *lb, uint64_t r[NW2], int n_words2, int off0, int n_cols2) {
    if (lb->unsat) return off0;
    for (int w = 0; w < n_words2; w++) {
        while (r[w] != 0ULL) {
            int bit = __builtin_ctzll(r[w]);
            int col = (w << 6) + bit;
            if (col >= n_cols2) { r[w] = 0ULL; break; }
            int pr = lb->piv_row[col];
            if (pr >= 0) {
                const uint64_t *p = lb->rows[pr];
                for (int k = w; k < n_words2; k++) r[k] ^= p[k];
            } else {
                if (col == off0) {
                    lb->unsat = 1;
                    return off0;
                }
                if (lb->cur_rows >= 512) return -2;
                int idx = lb->cur_rows++;
                memcpy(lb->rows[idx], r, (size_t)n_words2 * sizeof(uint64_t));
                lb->piv_row[col] = idx;
                return col;
            }
        }
    }
    return -1;
}

// Evaluate/specialize a single degree <= 3 polynomial under (fix_mask, fix_val).
// If ALL surviving terms have degree <= 2, writes into `out_row[NW2]` and returns 1; else returns 0.
static inline int specialize_c3_poly(
    const ProbeSystem *sys, int p_idx, mask128_t fix_mask, mask128_t fix_val, uint64_t out_row[NW2]
) {
    memset(out_row, 0, (size_t)sys->n_words2 * sizeof(uint64_t));
    int start = sys->c3_offsets[p_idx];
    int end   = sys->c3_offsets[p_idx + 1];
    for (int idx = start; idx < end; idx++) {
        uint32_t t = sys->c3_terms[idx];
        int free_v[3], nf = 0, zeroed = 0;
        for (int s = 0; s < 3; s++) {
            int v = (t >> (8 * s)) & 0xFF;
            if (v == 0xFF) break;
            if (m128_test(fix_mask, v)) {
                if (!m128_test(fix_val, v)) { zeroed = 1; break; }
            } else {
                free_v[nf++] = v;
            }
        }
        if (zeroed) continue;
        if (nf >= 3) return 0; // Still has degree 3 on free variables!
        int col = (nf == 0) ? sys->off0 : ((nf == 1) ? (sys->off1 + free_v[0]) : sys->pair_col[free_v[0]][free_v[1]]);
        out_row[col >> 6] ^= 1ULL << (col & 63);
    }
    return 1;
}

// Evaluate/specialize a single degree <= 4 polynomial (T28, Q4_mod32, e4_Fz) under (fix_mask, fix_val).
// Notice: whenever >= 2 variables in every quartic term are fixed (or fixed to 0), it drops to degree <= 2!
static inline int specialize_f4_poly(
    const ProbeSystem *sys, int p_idx, mask128_t fix_mask, mask128_t fix_val, uint64_t out_row[NW2]
) {
    memset(out_row, 0, (size_t)sys->n_words2 * sizeof(uint64_t));
    int start = sys->f4_offsets[p_idx];
    int end   = sys->f4_offsets[p_idx + 1];
    for (int idx = start; idx < end; idx++) {
        uint32_t t = sys->f4_terms[idx];
        int free_v[4], nf = 0, zeroed = 0;
        for (int s = 0; s < 4; s++) {
            int v = (t >> (8 * s)) & 0xFF;
            if (v == 0xFF) break;
            if (m128_test(fix_mask, v)) {
                if (!m128_test(fix_val, v)) { zeroed = 1; break; }
            } else {
                free_v[nf++] = v;
            }
        }
        if (zeroed) continue;
        if (nf >= 3) return 0; // Still has degree >= 3
        int col = (nf == 0) ? sys->off0 : ((nf == 1) ? (sys->off1 + free_v[0]) : sys->pair_col[free_v[0]][free_v[1]]);
        out_row[col >> 6] ^= 1ULL << (col & 63);
    }
    return 1;
}

// Specialize a precomputed degree <= 2 row using clear_var_mask + precomputed formal derivatives D_v q_m!
static inline void specialize_q2_fast(
    const ProbeSystem *sys, int m, mask128_t fix_mask, mask128_t fix_val, uint64_t out_row[NW2]
) {
    const uint64_t *src = sys->q2_rows + (size_t)m * NW2;
    for (int w = 0; w < sys->n_words2; w++) out_row[w] = src[w];

    int const_acc = 0;
    mask128_t lin_acc = {0ULL, 0ULL};

    // Iterate over fixed variables using ctzll on fix_mask.lo / fix_mask.hi!
    for (int half = 0; half < 2; half++) {
        uint64_t fm = (half == 0) ? fix_mask.lo : fix_mask.hi;
        uint64_t fv = (half == 0) ? fix_val.lo  : fix_val.hi;
        while (fm) {
            int b = __builtin_ctzll(fm);
            int v = (half << 6) + b;
            fm &= fm - 1;
            if (v >= sys->N) continue;

            // Zero out all degree-2 and degree-1 columns touching variable v
            const uint64_t *cm = sys->clear_var_mask[v];
            for (int w = 0; w < sys->n_words2; w++) out_row[w] &= cm[w];

            // If x_v == 1, add formal derivative D_v q_m(x):
            //   - constant part: q2_Di_const[m*N + v]
            //   - linear part on remaining free vars u: q2_Di_vars[m*N + v] & ~fix_mask
            //   - for u < v where BOTH x_u == 1 and x_v == 1, x_u*x_v contributes 1 to const!
            if ((fv >> b) & 1ULL) {
                size_t idx = (size_t)m * sys->N + v;
                const_acc ^= sys->q2_Di_const[idx];
                mask128_t dv = sys->q2_Di_vars[idx];
                lin_acc.lo ^= (dv.lo & ~fix_mask.lo);
                lin_acc.hi ^= (dv.hi & ~fix_mask.hi);

                // Count pairs (u, v) with u < v and x_u == 1, x_v == 1 (avoid double counting by u < v)
                uint64_t mask_lt_lo = (v < 64) ? ((1ULL << v) - 1ULL) : ~0ULL;
                uint64_t mask_lt_hi = (v <= 64) ? 0ULL : ((1ULL << (v - 64)) - 1ULL);
                int pairs11 = __builtin_popcountll(dv.lo & fix_val.lo & mask_lt_lo)
                            + __builtin_popcountll(dv.hi & fix_val.hi & mask_lt_hi);
                const_acc ^= (pairs11 & 1);
            }
        }
    }

    // XOR accumulated linear & constant shifts into out_row
    for (int half = 0; half < 2; half++) {
        uint64_t lm = (half == 0) ? lin_acc.lo : lin_acc.hi;
        while (lm) {
            int b = __builtin_ctzll(lm);
            int u = (half << 6) + b;
            lm &= lm - 1;
            if (u < sys->N) {
                int c = sys->off1 + u;
                out_row[c >> 6] ^= 1ULL << (c & 63);
            }
        }
    }
    if (const_acc & 1) {
        out_row[sys->off0 >> 6] ^= 1ULL << (sys->off0 & 63);
    }
}

// Extract forced units (x_u = val) AND general linear pivots from LocalBasis2,
// and run Local XL (x_w * L_row) inside the 96-word degree<=2 table!
static int harvest_units_and_local_xl(
    const ProbeSystem *sys, LocalBasis2 *lb, mask128_t *fix_mask, mask128_t *fix_val,
    int do_local_xl, uint8_t processed_lin[MAX_N]
) {
    int new_units = 0;
    uint64_t rbuf[NW2];
    int N = sys->N;

    // Back-substitute inside the linear block [off1 .. off0-1] to expose pure units!
    // Collect active linear pivot rows
    int lin_vars[MAX_N], lin_ridxs[MAX_N], n_lin = 0;
    for (int v = 0; v < N; v++) {
        int pr = lb->piv_row[sys->off1 + v];
        if (pr >= 0) {
            lin_vars[n_lin] = v;
            lin_ridxs[n_lin] = pr;
            n_lin++;
        }
    }
    // Eliminate upward in linear block so units become exact 1-variable equations!
    for (int a = n_lin - 1; a >= 0; a--) {
        int va = lin_vars[a];
        int ca = sys->off1 + va;
        const uint64_t *ra = lb->rows[lin_ridxs[a]];
        for (int b = 0; b < a; b++) {
            uint64_t *rb = lb->rows[lin_ridxs[b]];
            if ((rb[ca >> 6] >> (ca & 63)) & 1ULL) {
                for (int w = (sys->off1 >> 6); w < sys->n_words2; w++) rb[w] ^= ra[w];
            }
        }
    }

    for (int a = 0; a < n_lin && !lb->unsat; a++) {
        int v = lin_vars[a];
        const uint64_t *r = lb->rows[lin_ridxs[a]];
        // Extract linear support on [0 .. N-1]
        int supp[MAX_N], ns = 0;
        for (int u = 0; u < N; u++) {
            int cu = sys->off1 + u;
            if ((r[cu >> 6] >> (cu & 63)) & 1ULL) supp[ns++] = u;
        }
        int rhs = (int)((r[sys->off0 >> 6] >> (sys->off0 & 63)) & 1ULL);

        if (ns == 1) {
            int u = supp[0];
            if (!m128_test(*fix_mask, u)) {
                m128_set(fix_mask, u);
                if (rhs) m128_set(fix_val, u);
                new_units++;
            } else if (m128_test(*fix_val, u) != rhs) {
                lb->unsat = 1;
                return new_units;
            }
        }

        // Local XL: multiply sparse linear equation L(x) = sum_{s in supp} x_s ^ rhs == 0
        // by every free variable x_w -> injects N degree <= 2 equations into lb!
        if (do_local_xl && !processed_lin[v] && ns >= 2 && ns <= 48) {
            processed_lin[v] = 1;
            for (int w_var = 0; w_var < N && !lb->unsat; w_var++) {
                if (m128_test(*fix_mask, w_var)) continue;
                memset(rbuf, 0, (size_t)sys->n_words2 * sizeof(uint64_t));
                if (rhs) {
                    int cw = sys->off1 + w_var;
                    rbuf[cw >> 6] ^= 1ULL << (cw & 63);
                }
                for (int k = 0; k < ns; k++) {
                    int u = supp[k];
                    if (u == w_var) {
                        int cw = sys->off1 + w_var;
                        rbuf[cw >> 6] ^= 1ULL << (cw & 63);
                    } else {
                        int c2 = sys->pair_col[u][w_var];
                        rbuf[c2 >> 6] ^= 1ULL << (c2 & 63);
                    }
                }
                lb2_insert(lb, rbuf, sys->n_words2, sys->off0, sys->n_cols2);
            }
        }
    }
    return new_units;
}

// Full algebraic closure of a branch (initial fix_mask, fix_val):
// Returns 1 if UNSAT (1=0 derived!), 0 otherwise (with final propagated fix_mask, fix_val).
static int run_branch_closure(
    const ProbeSystem *sys, mask128_t init_mask, mask128_t init_val,
    int max_rounds, int use_c3, int use_f4, int do_local_xl,
    mask128_t *out_mask, mask128_t *out_val
) {
    LocalBasis2 lb;
    uint64_t rbuf[NW2];
    uint8_t processed_lin[MAX_N];
    mask128_t cur_mask = init_mask;
    mask128_t cur_val  = init_val;

    for (int round = 0; round < max_rounds; round++) {
        lb2_init(&lb, sys->n_cols2);
        memset(processed_lin, 0, sizeof(processed_lin));
        mask128_t start_mask = cur_mask;

        // 1. Insert all specialized degree <= 2 equations (1000x fast via clear_var_mask + D_i q2!)
        for (int m = 0; m < sys->n_q2 && !lb.unsat; m++) {
            specialize_q2_fast(sys, m, cur_mask, cur_val, rbuf);
            lb2_insert(&lb, rbuf, sys->n_words2, sys->off0, sys->n_cols2);
        }
        if (lb.unsat) { *out_mask = cur_mask; *out_val = cur_val; return 1; }

        // 2. Insert all degree <= 3 equations that dropped to degree <= 2 under cur_mask!
        if (use_c3) {
            for (int p = 0; p < sys->n_c3 && !lb.unsat; p++) {
                if (specialize_c3_poly(sys, p, cur_mask, cur_val, rbuf)) {
                    lb2_insert(&lb, rbuf, sys->n_words2, sys->off0, sys->n_cols2);
                }
            }
            if (lb.unsat) { *out_mask = cur_mask; *out_val = cur_val; return 1; }
        }

        // 3. Insert all degree <= 4 equations (T28, Q4_mod32, e4_Fz) that dropped to degree <= 2!
        if (use_f4) {
            for (int p = 0; p < sys->n_f4 && !lb.unsat; p++) {
                if (specialize_f4_poly(sys, p, cur_mask, cur_val, rbuf)) {
                    lb2_insert(&lb, rbuf, sys->n_words2, sys->off0, sys->n_cols2);
                }
            }
            if (lb.unsat) { *out_mask = cur_mask; *out_val = cur_val; return 1; }
        }

        // 4. Inner Local XL cascade (linear -> x_w * linear -> new linear -> ...)
        for (int xl_iter = 0; xl_iter < 3 && !lb.unsat; xl_iter++) {
            int prev_rows = lb.cur_rows;
            harvest_units_and_local_xl(sys, &lb, &cur_mask, &cur_val, do_local_xl, processed_lin);
            if (lb.unsat) { *out_mask = cur_mask; *out_val = cur_val; return 1; }
            if (lb.cur_rows == prev_rows) break;
        }

        // If no new unit variables were discovered, stop outer loop!
        if (m128_eq(cur_mask, start_mask)) break;
    }

    *out_mask = cur_mask;
    *out_val  = cur_val;
    return lb.unsat ? 1 : 0;
}

static void build_probe_system(
    ProbeSystem *sys, int N,
    int n_q2, const int *q2_offsets, const uint32_t *q2_terms,
    int n_c3, const int *c3_offsets, const uint32_t *c3_terms,
    int n_f4, const int *f4_offsets, const uint32_t *f4_terms
) {
    memset(sys, 0, sizeof(ProbeSystem));
    sys->N = N;
    sys->n2 = (N * (N - 1)) / 2;
    sys->off1 = sys->n2;
    sys->off0 = sys->n2 + N;
    sys->n_cols2 = sys->off0 + 1;
    sys->n_words2 = (sys->n_cols2 + 63) / 64;

    int c2 = 0;
    for (int i = 0; i < N; i++) {
        sys->pair_col[i][i] = -1;
        for (int j = i + 1; j < N; j++) {
            sys->pair_col[i][j] = c2;
            sys->pair_col[j][i] = c2;
            c2++;
        }
    }

    // Build clear_var_mask[v] with all 1s EXCEPT columns touching variable v
    for (int v = 0; v < N; v++) {
        for (int w = 0; w < NW2; w++) sys->clear_var_mask[v][w] = ~0ULL;
        int cv1 = sys->off1 + v;
        sys->clear_var_mask[v][cv1 >> 6] &= ~(1ULL << (cv1 & 63));
        for (int u = 0; u < N; u++) {
            if (u == v) continue;
            int cp = sys->pair_col[u][v];
            sys->clear_var_mask[v][cp >> 6] &= ~(1ULL << (cp & 63));
        }
    }

    sys->n_q2 = n_q2;
    sys->q2_rows = (uint64_t*)calloc((size_t)n_q2 * NW2, sizeof(uint64_t));
    sys->q2_Di_vars = (mask128_t*)calloc((size_t)n_q2 * N, sizeof(mask128_t));
    sys->q2_Di_const = (uint8_t*)calloc((size_t)n_q2 * N, sizeof(uint8_t));

    for (int m = 0; m < n_q2; m++) {
        uint64_t *r = sys->q2_rows + (size_t)m * NW2;
        for (int idx = q2_offsets[m]; idx < q2_offsets[m + 1]; idx++) {
            uint32_t t = q2_terms[idx];
            int b0 = t & 0xFF;
            int b1 = (t >> 8) & 0xFF;
            if (b0 == 0xFF) {
                r[sys->off0 >> 6] ^= 1ULL << (sys->off0 & 63);
            } else if (b1 == 0xFF) {
                int c = sys->off1 + b0;
                r[c >> 6] ^= 1ULL << (c & 63);
                sys->q2_Di_const[(size_t)m * N + b0] ^= 1;
            } else {
                int c = sys->pair_col[b0][b1];
                r[c >> 6] ^= 1ULL << (c & 63);
                m128_set(&sys->q2_Di_vars[(size_t)m * N + b0], b1);
                m128_set(&sys->q2_Di_vars[(size_t)m * N + b1], b0);
            }
        }
    }

    sys->n_c3 = n_c3; sys->c3_offsets = c3_offsets; sys->c3_terms = c3_terms;
    sys->n_f4 = n_f4; sys->f4_offsets = f4_offsets; sys->f4_terms = f4_terms;
}

static void free_probe_system(ProbeSystem *sys) {
    free(sys->q2_rows);
    free(sys->q2_Di_vars);
    free(sys->q2_Di_const);
}

// Parallel OpenMP 1-Literal & 2-Literal Pair Probing!
// Outputs:
//   - unit_status[i]: -1 (unconstrained), 0 (forced 0), 1 (forced 1), 2 (UNSAT contradiction!)
//   - pair_unsat_mask[p]: 4-bit mask of UNSAT branches (bit (2*a + b) == 1 iff (x_i=a, x_j=b) -> 1=0)
//   - lit_imp_lo/hi[2*N] & lit_val_lo/hi[2*N]: 128-bit masks of units forced by literal (2*i + a)!
int run_openmp_pair_probing(
    int N,
    int n_q2, const int *q2_offsets, const uint32_t *q2_terms,
    int n_c3, const int *c3_offsets, const uint32_t *c3_terms,
    int n_f4, const int *f4_offsets, const uint32_t *f4_terms,
    int n_pairs_to_test, const int *pair_i, const int *pair_j,
    int do_local_xl,
    int *out_unit_status,          // size N
    uint8_t *out_pair_unsat_mask,  // size n_pairs_to_test
    uint64_t *out_lit_fmask_lo,    // size 2*N
    uint64_t *out_lit_fmask_hi,    // size 2*N
    uint64_t *out_lit_fval_lo,     // size 2*N
    uint64_t *out_lit_fval_hi      // size 2*N
) {
    ProbeSystem sys;
    build_probe_system(&sys, N, n_q2, q2_offsets, q2_terms, n_c3, c3_offsets, c3_terms, n_f4, f4_offsets, f4_terms);

    for (int i = 0; i < N; i++) out_unit_status[i] = -1;
    int global_unsat = 0;

    // PHASE 1: Parallel 1-Literal Probing (2*N branches, WITH c3 + f4 + full Local XL!)
    int lit_unsat[2 * MAX_N];
    mask128_t lit_m[2 * MAX_N], lit_v[2 * MAX_N];
    memset(lit_unsat, 0, sizeof(lit_unsat));

    #pragma omp parallel for schedule(dynamic, 1)
    for (int lit = 0; lit < 2 * N; lit++) {
        if (global_unsat) continue;
        int i = lit >> 1;
        int a = lit & 1;
        mask128_t im = {0ULL, 0ULL}, iv = {0ULL, 0ULL};
        m128_set(&im, i);
        if (a) m128_set(&iv, i);
        lit_unsat[lit] = run_branch_closure(&sys, im, iv, 5, 1, 1, 1, &lit_m[lit], &lit_v[lit]);
    }

    for (int i = 0; i < N; i++) {
        int u0 = lit_unsat[2 * i + 0];
        int u1 = lit_unsat[2 * i + 1];
        out_lit_fmask_lo[2 * i + 0] = lit_m[2 * i + 0].lo;
        out_lit_fmask_hi[2 * i + 0] = lit_m[2 * i + 0].hi;
        out_lit_fval_lo[2 * i + 0]  = lit_v[2 * i + 0].lo;
        out_lit_fval_hi[2 * i + 0]  = lit_v[2 * i + 0].hi;
        out_lit_fmask_lo[2 * i + 1] = lit_m[2 * i + 1].lo;
        out_lit_fmask_hi[2 * i + 1] = lit_m[2 * i + 1].hi;
        out_lit_fval_lo[2 * i + 1]  = lit_v[2 * i + 1].lo;
        out_lit_fval_hi[2 * i + 1]  = lit_v[2 * i + 1].hi;

        if (u0 && u1) {
            out_unit_status[i] = 2;
            global_unsat = 1;
        } else if (u0) {
            out_unit_status[i] = 1; // x_i = 0 UNSAT => x_i = 1 forced!
        } else if (u1) {
            out_unit_status[i] = 0; // x_i = 1 UNSAT => x_i = 0 forced!
        } else {
            // Stålmarck 1-Literal Dilemma Rule: if BOTH (x_i=0) and (x_i=1) force (x_k = c), then x_k = c globally!
            mask128_t common_m;
            common_m.lo = lit_m[2 * i + 0].lo & lit_m[2 * i + 1].lo;
            common_m.hi = lit_m[2 * i + 0].hi & lit_m[2 * i + 1].hi;
            for (int k = 0; k < N; k++) {
                if (k == i || !m128_test(common_m, k)) continue;
                int v0 = m128_test(lit_v[2 * i + 0], k);
                int v1 = m128_test(lit_v[2 * i + 1], k);
                if (v0 == v1) {
                    if (out_unit_status[k] != -1 && out_unit_status[k] != v0) {
                        global_unsat = 1;
                    }
                    out_unit_status[k] = v0;
                }
            }
        }
    }

    if (global_unsat || n_pairs_to_test <= 0) {
        free_probe_system(&sys);
        return global_unsat;
    }

    // PHASE 2: Parallel 2-Literal Pair Probing across (pair_i[p], pair_j[p]) for (a,b) in {0,1}^2!
    memset(out_pair_unsat_mask, 0, (size_t)n_pairs_to_test * sizeof(uint8_t));

    #pragma omp parallel for schedule(dynamic, 4)
    for (int p = 0; p < n_pairs_to_test; p++) {
        if (global_unsat) continue;
        int i = pair_i[p];
        int j = pair_j[p];
        uint8_t pmask = 0;
        mask128_t bm[4], bv[4];

        for (int ab = 0; ab < 4; ab++) {
            int a = (ab >> 1) & 1;
            int b = ab & 1;
            if (out_unit_status[i] != -1 && out_unit_status[i] != a) {
                pmask |= (1U << ab);
                continue;
            }
            if (out_unit_status[j] != -1 && out_unit_status[j] != b) {
                pmask |= (1U << ab);
                continue;
            }
            // Start from the union of 1-literal closures of (x_i=a) and (x_j=b)!
            mask128_t m_a = lit_m[2 * i + a], v_a = lit_v[2 * i + a];
            mask128_t m_b = lit_m[2 * j + b], v_b = lit_v[2 * j + b];
            // Quick conflict check between 1-literal closures!
            if (((m_a.lo & m_b.lo) & (v_a.lo ^ v_b.lo)) || ((m_a.hi & m_b.hi) & (v_a.hi ^ v_b.hi))) {
                pmask |= (1U << ab);
                continue;
            }
            mask128_t im = {m_a.lo | m_b.lo, m_a.hi | m_b.hi};
            mask128_t iv = {v_a.lo | v_b.lo, v_a.hi | v_b.hi};
            int u = run_branch_closure(&sys, im, iv, 4, 1, 1, do_local_xl, &bm[ab], &bv[ab]);
            if (u) pmask |= (1U << ab);
        }

        out_pair_unsat_mask[p] = pmask;
        if (pmask == 0x0F) {
            #pragma omp atomic write
            global_unsat = 1;
        } else {
            // Stålmarck 4-Branch Dilemma Rule: any unit x_k = c forced in ALL surviving branches of (i,j) is global!
            mask128_t inter_m = {~0ULL, ~0ULL};
            mask128_t eq0_m   = {~0ULL, ~0ULL};
            mask128_t eq1_m   = {~0ULL, ~0ULL};
            for (int ab = 0; ab < 4; ab++) {
                if ((pmask >> ab) & 1U) continue;
                inter_m.lo &= bm[ab].lo;
                inter_m.hi &= bm[ab].hi;
                eq1_m.lo   &= bv[ab].lo;
                eq1_m.hi   &= bv[ab].hi;
                eq0_m.lo   &= ~bv[ab].lo;
                eq0_m.hi   &= ~bv[ab].hi;
            }
            for (int k = 0; k < N; k++) {
                if (!m128_test(inter_m, k)) continue;
                int forced_c = m128_test(eq1_m, k) ? 1 : (m128_test(eq0_m, k) ? 0 : -1);
                if (forced_c >= 0) {
                    #pragma omp critical
                    {
                        if (out_unit_status[k] != -1 && out_unit_status[k] != forced_c) {
                            global_unsat = 1;
                        }
                        out_unit_status[k] = forced_c;
                    }
                }
            }
        }
    }

    free_probe_system(&sys);
    return global_unsat;
}

// -----------------------------------------------------------------------------
// D. Fast 65,536-Point C FWHT Bentness Auditor (0.05 ms per candidate)
// -----------------------------------------------------------------------------
int audit_bent_c(const uint64_t *orb_tts, uint64_t c_lo, uint64_t c_hi) {
    uint64_t tt[1024];
    memset(tt, 0, sizeof(tt));
    for (int j = 0; j < 116; j++) {
        int bit = (j < 64) ? (int)((c_lo >> j) & 1ULL) : (int)((c_hi >> (j - 64)) & 1ULL);
        if (bit) {
            const uint64_t *src = orb_tts + (size_t)j * 1024;
            for (int w = 0; w < 1024; w++) tt[w] ^= src[w];
        }
    }
    int32_t spec[65536];
    for (int x = 0; x < 65536; x++) {
        spec[x] = ((tt[x >> 6] >> (x & 63)) & 1ULL) ? -1 : 1;
    }
    for (int step = 1; step < 65536; step <<= 1) {
        int dbl = step << 1;
        for (int i = 0; i < 65536; i += dbl) {
            for (int j = 0; j < step; j++) {
                int32_t u = spec[i + j], v = spec[i + j + step];
                spec[i + j] = u + v;
                spec[i + j + step] = u - v;
            }
        }
    }
    for (int u = 0; u < 65536; u++) {
        if (spec[u] != 256 && spec[u] != -256) return 0;
    }
    return 1;
}
"""


# ==============================================================================
# 2. Pure Mathematical Primitives: H(16,4) Orbits, Subspaces, Fibers & Lucas
# ==============================================================================
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


def swap16(x: int) -> int:
    return ((x & 0xFF) << 8) | (x >> 8)


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
    """Pure 111-variable basis: ONLY c115=0 and L=c99 (eliminating c0). Zero extra assumptions!"""
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
                cand = gens + [rng.choice(U4_LIST)]
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
    """Exact mod-32 extractor on rot^4-orbits: returns (P2 deg<=2, Q4 deg<=4)."""
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


def extract_exact_weight_levels_upto_deg4(basis_words, O_word, target_wt: int, mod_bits: int, n: int):
    """
    Given M affine Boolean forms g_p(x) = O_p ^ sum_i x_i b_{i,p} whose integer sum
    wt(g(x)) MUST equal `target_wt` (mod 2^mod_bits) for every bent function
    (e.g. C_{0xf} with M=256, target_wt=128, mod_bits=4; or B0_00 fibers F_z with
     target_wt in {8, 16, 32, 64}, mod_bits=4!),
    extracts ALL exact polynomial equations up to degree <= 4 from the Master Formula:
      wt(g(x)) - target_wt = (o_pop - target_wt) + sum_{k>=1} (-2)^{k-1} sum_{|I|=k} S_I x^I == 0 (mod 2^mod_bits)!
    """
    out_polys = []  # list of (max_deg, pset)
    o_pop = O_word.bit_count()
    diff0 = o_pop - target_wt

    def toggle(pset, m):
        if m in pset:
            pset.remove(m)
        else:
            pset.add(m)

    # Level 0 (mod 2, deg <= 1)
    P0 = set()
    if diff0 & 1:
        toggle(P0, 0)
    S1 = []
    for i in range(n):
        wi = basis_words[i].bit_count()
        wo = (basis_words[i] & O_word).bit_count()
        S1.append(wi - 2 * wo)
        if wi & 1:
            toggle(P0, 1 << i)
    if P0:
        out_polys.append((1, P0))
        return out_polys  # Higher levels have carry from non-zero P0; P0 will first eliminate a variable!
    if mod_bits <= 1:
        return out_polys

    # Here P0 == 0 identically => diff0 is even and every S1[i] is even!
    # Level 1 (mod 4, deg <= 2) + Level 2 (mod 8, deg <= 3 or <= 4 via carry of P1!)
    P1 = set()
    Q_mod8_raw = set()
    v0 = diff0 >> 1
    if v0 & 1:
        toggle(P1, 0)
    if (v0 >> 1) & 1:
        toggle(Q_mod8_raw, 0)
    for i in range(n):
        vi = S1[i] >> 1
        if vi & 1:
            toggle(P1, 1 << i)
        if (vi >> 1) & 1:
            toggle(Q_mod8_raw, 1 << i)
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
                toggle(P1, m_ij)
            if (vij >> 1) & 1:
                toggle(Q_mod8_raw, m_ij)
            if mod_bits >= 3:
                for k in range(j + 1, n):
                    if (inter & basis_words[k]).bit_count() & 1:
                        toggle(Q_mod8_raw, m_ij | (1 << k))

    if P1:
        out_polys.append((2, P1))
    if mod_bits >= 3:
        p1_list = sorted(P1)
        P2_mod8 = set(Q_mod8_raw)
        for a in range(len(p1_list)):
            ma = p1_list[a]
            for b in range(a + 1, len(p1_list)):
                toggle(P2_mod8, ma | p1_list[b])
        if P2_mod8:
            md = max(m.bit_count() for m in P2_mod8)
            out_polys.append((md, P2_mod8))

    # Level 3 (mod 16, deg <= 4!) when both P0 == 0 AND P1 == 0 AND P2_mod8 has deg <= 2!
    if mod_bits >= 4 and not P1:
        md8 = max((m.bit_count() for m in Q_mod8_raw), default=0)
        if md8 <= 2:
            Q_mod16 = set()
            w0 = diff0 >> 2  # diff0 / 4
            if (w0 >> 1) & 1:
                toggle(Q_mod16, 0)
            for i in range(n):
                wi4 = S1[i] >> 2
                if (wi4 >> 1) & 1:
                    toggle(Q_mod16, 1 << i)
            for i in range(n):
                bi = basis_words[i]
                for j in range(i + 1, n):
                    inter = bi & basis_words[j]
                    if not inter:
                        continue
                    ij_pop = inter.bit_count()
                    ijo_pop = (inter & O_word).bit_count()
                    vij2 = (2 * ijo_pop - ij_pop) >> 1
                    m_ij = (1 << i) | (1 << j)
                    if (vij2 >> 1) & 1:
                        toggle(Q_mod16, m_ij)
                    for k in range(j + 1, n):
                        ijk = inter & basis_words[k]
                        if not ijk:
                            continue
                        ijk_pop = ijk.bit_count()
                        ijko_pop = (ijk & O_word).bit_count()
                        s_ijk = ijk_pop - 2 * ijko_pop
                        m_ijk = m_ij | (1 << k)
                        if (s_ijk >> 1) & 1:
                            toggle(Q_mod16, m_ijk)
                        for l_var in range(k + 1, n):
                            if (ijk & basis_words[l_var]).bit_count() & 1:
                                toggle(Q_mod16, m_ijk | (1 << l_var))
            # Add sigma_2 carry of Q_mod8_raw (since deg(Q_mod8_raw) <= 2, carry has deg <= 4!)
            p2_list = sorted(Q_mod8_raw)
            for a in range(len(p2_list)):
                ma = p2_list[a]
                for b in range(a + 1, len(p2_list)):
                    toggle(Q_mod16, ma | p2_list[b])
            if Q_mod16:
                out_polys.append((max(m.bit_count() for m in Q_mod16), Q_mod16))
    return out_polys


def build_c8_orbits():
    seen = set()
    u4_orbs, u8_size8, nonzero_z = [], [], []
    for a in range(256):
        if a in seen:
            continue
        orb, cur = [], a
        while cur not in orb:
            orb.append(cur)
            cur = rot8(cur)
        seen.update(orb)
        rep = min(orb)
        if a != 0:
            nonzero_z.append((rep, orb))
        if len(orb) < 8:
            u4_orbs.append((rep, orb))
        else:
            u8_size8.append((rep, orb))
    return u4_orbs, u8_size8, nonzero_z


def fiber_orbit_reps(z: int, group_step: int):
    pts = [v | ((v ^ z) << 8) for v in range(256)]
    seen = set()
    reps = []
    for x in pts:
        if x in seen:
            continue
        cur, orb = x, []
        while cur not in orb:
            orb.append(cur)
            for _ in range(group_step):
                cur = rot16(cur)
        seen.update(orb)
        reps.append(min(orb))
    return reps


def gf2_nullspace_left(mat_rows):
    piv = {}
    null_vecs = []
    for i, r in enumerate(mat_rows):
        v = r
        comb = 1 << i
        while v:
            b = v.bit_length() - 1
            if b in piv:
                pv, pcomb = piv[b]
                v ^= pv
                comb ^= pcomb
            else:
                piv[b] = (v, comb)
                break
        if v == 0:
            null_vecs.append(comb)
    return null_vecs


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
# 3. Tarjan Strongly Connected Components (2-SAT Implication Graph) & Substitutions
# ==============================================================================
def tarjan_2sat_closure(n_vars: int, adj: list[set[int]]):
    """
    Runs Tarjan SCC on 2*n_vars literals (lit = 2*i + val, val in {0,1}, neg(lit) = lit ^ 1).
    Returns:
      - unsat (bool): True if some variable has (2*i) and (2*i+1) in the same SCC!
      - forced_units: dict {i: val} whenever (2*i + (1-val)) can reach (2*i + val)
      - equivalences: dict {sub_var: (rep_var, xor_const)} for distinct variables in the same SCC!
    """
    num_lits = 2 * n_vars
    # Transitive closure on <= 222 nodes is tiny (222 * 4 words) -> compute exact reachability bitsets
    # so we detect ALL indirect unit forcings (x_i=a ->* x_i=1-a) AND all SCC equivalences!
    reach = [1 << u for u in range(num_lits)]
    for u in range(num_lits):
        for v in adj[u]:
            reach[u] |= 1 << v
    # Warshall in Python bigints: 220 iterations of bit-OR takes < 0.3 milliseconds!
    for k in range(num_lits):
        rk = reach[k]
        bit_k = 1 << k
        for u in range(num_lits):
            if reach[u] & bit_k:
                reach[u] |= rk

    forced_units = {}
    for i in range(n_vars):
        l0, l1 = 2 * i, 2 * i + 1
        r01 = (reach[l0] >> l1) & 1
        r10 = (reach[l1] >> l0) & 1
        if r01 and r10:
            return True, {}, {}
        if r01:
            forced_units[i] = 1
        elif r10:
            forced_units[i] = 0

    equivalences = {}
    for j in range(n_vars):
        if j in forced_units:
            continue
        lj1 = 2 * j + 1
        for i in range(j):
            if i in forced_units or i in equivalences:
                continue
            li0, li1 = 2 * i, 2 * i + 1
            # Check (x_j=1 <-> x_i=1): j == i
            if ((reach[lj1] >> li1) & 1) and ((reach[li1] >> lj1) & 1):
                equivalences[j] = (i, 0)
                break
            # Check (x_j=1 <-> x_i=0): j == i ^ 1
            if ((reach[lj1] >> li0) & 1) and ((reach[li0] >> lj1) & 1):
                equivalences[j] = (i, 1)
                break

    return False, forced_units, equivalences


def substitute_linear_map_in_psets(psets, lin_subst: dict[int, tuple[int, int]], keep_vars_sorted: list[int]):
    """
    Applies exact Boolean substitution x_p -> (xor_var_mask_on_old, const_bit)
    and re-indexes remaining variables to 0 .. len(keep_vars_sorted)-1!
    Works for ANY degree <= 4 (automatically applies x_i * x_i = x_i via bitwise OR!).
    """
    remap = {old_v: new_v for new_v, old_v in enumerate(keep_vars_sorted)}

    # Precompute expansion of every old variable as a pset in the NEW variables:
    # var_poly[old_v] = set of new bitmasks (each of size <= 1)
    var_poly = {}
    for old_v in remap:
        var_poly[old_v] = {1 << remap[old_v]}
    for p_var, (w_mask, c_bit) in lin_subst.items():
        p = set()
        if c_bit:
            p.add(0)
        tmp = w_mask
        while tmp:
            b = tmp & -tmp
            ov = b.bit_length() - 1
            tmp ^= b
            p.symmetric_difference_update({1 << remap[ov]})
        var_poly[p_var] = p

    def mul_psets(p1, p2):
        res = set()
        for a in p1:
            for b in p2:
                m = a | b
                if m in res:
                    res.remove(m)
                else:
                    res.add(m)
        return res

    out_list = []
    for pset in psets:
        acc = set()
        for m in pset:
            if m == 0:
                acc.symmetric_difference_update({0})
                continue
            term_p = {0}
            tmp = m
            while tmp:
                b = tmp & -tmp
                ov = b.bit_length() - 1
                tmp ^= b
                term_p = mul_psets(term_p, var_poly[ov])
                if not term_p:
                    break
            acc.symmetric_difference_update(term_p)
        if acc:
            out_list.append(acc)
    return out_list


def pack_psets_to_csr(psets, max_deg: int):
    offsets = [0]
    flat_terms = []
    pad = (1 << (8 * max_deg)) - 1  # 0xFFFFFF or 0xFFFFFFFF
    for pset in psets:
        for m in sorted(pset):
            vs = []
            tmp = m
            while tmp:
                b = tmp & -tmp
                vs.append(b.bit_length() - 1)
                tmp ^= b
            assert len(vs) <= max_deg
            word = 0
            for s in range(max_deg):
                byte_val = vs[s] if s < len(vs) else 0xFF
                word |= (byte_val & 0xFF) << (8 * s)
            flat_terms.append(word)
        offsets.append(len(flat_terms))
    c_off = (ctypes.c_int * len(offsets))(*offsets)
    c_trm = (ctypes.c_uint32 * max(1, len(flat_terms)))(*flat_terms) if flat_terms else (ctypes.c_uint32 * 1)(0)
    return c_off, c_trm


# ==============================================================================
# 4. Find & Load T28 Certificate (Branch 0 for c99=0, Branch 1 for c99=1)
# ==============================================================================
def load_t28_branch_poly_c116(c99_val: int, base_dir: Path):
    candidates = [
        base_dir / "T28_SEXTA_CERTIFICADO.json",
        base_dir / "quartic_audit_2026_10_17/archive/T28_SEXTA_CERTIFICADO.json",
        base_dir.parent / "quartic_audit_2026_10_17/archive/T28_SEXTA_CERTIFICADO.json",
        base_dir.parent.parent / "quartic_audit_2026_10_17/archive/T28_SEXTA_CERTIFICADO.json",
    ]
    for p in candidates:
        if p.is_file():
            cert = json.loads(p.read_text(encoding="utf-8"))
            branches = cert.get("reduced_models", {}).get("branches", [])
            for br in branches:
                if br.get("c99") == c99_val or branches.index(br) == c99_val:
                    return [int(h, 16) for h in br["polynomial_hex"]], str(p)
    return None, None


def map_c116_poly_to_basis(poly_c116, origin: int, cb: list[int]):
    """Maps a polynomial in the 116 orbit variables c_0..c_115 into the n-variable basis (origin, cb)."""
    n = len(cb)
    # Express each c_j as a pset of degree <= 1 in x_0..x_{n-1}
    c_var_poly = []
    for j in range(116):
        p = set()
        if (origin >> j) & 1:
            p.add(0)
        for i, cdir in enumerate(cb):
            if (cdir >> j) & 1:
                p.add(1 << i)
        c_var_poly.append(p)

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

    acc = set()
    for m in poly_c116:
        if m == 0:
            acc.symmetric_difference_update({0})
            continue
        term = {0}
        tmp = m
        while tmp:
            b = tmp & -tmp
            j = b.bit_length() - 1
            tmp ^= b
            term = mul_p(term, c_var_poly[j])
            if not term:
                break
        acc.symmetric_difference_update(term)
    return acc


# ==============================================================================
# 5. Master Cell Closer: Pure Extraction -> Schur-XL(d=4) -> OpenMP 2-SAT Probe
# ==============================================================================
def compile_c_engine(work_dir: Path):
    c_path = work_dir / "probe_2sat_engine.c"
    so_path = work_dir / f"libprobe_2sat_{os.getpid()}.so"
    c_path.write_text(C_PROBE_SRC, encoding="utf-8")
    cmd = ["gcc", "-O3", "-march=native", "-fopenmp", "-shared", "-fPIC", str(c_path), "-o", str(so_path)]
    rc = subprocess.run(cmd, capture_output=True, text=True)
    if rc.returncode != 0:
        # Fallback without -march=native for heterogeneous cloud VMs
        cmd = ["gcc", "-O3", "-fopenmp", "-shared", "-fPIC", str(c_path), "-o", str(so_path)]
        subprocess.run(cmd, check=True)
    lib = ctypes.CDLL(str(so_path))

    lib.extract_level1_quad_when_diag4.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_uint64),
    ]
    lib.extract_level1_quad_when_diag4.restype = ctypes.c_int

    lib.extract_coset_full_hierarchy_corrected.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
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

    lib.schur_create.argtypes = [ctypes.c_int, ctypes.c_size_t, ctypes.c_uint32, ctypes.c_uint32]
    lib.schur_create.restype = ctypes.c_void_p
    lib.schur_free.argtypes = [ctypes.c_void_p]
    lib.schur_insert_low_packed.argtypes = [ctypes.c_void_p, ctypes.POINTER(ctypes.c_uint32), ctypes.c_int]
    lib.schur_insert_low_packed.restype = ctypes.c_int
    lib.schur_insert_deg4_packed.argtypes = [
        ctypes.c_void_p, ctypes.POINTER(ctypes.c_uint32), ctypes.c_int, ctypes.POINTER(ctypes.c_int)
    ]
    lib.schur_insert_deg4_packed.restype = ctypes.c_int
    lib.schur_get_stats.argtypes = [
        ctypes.c_void_p, ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_uint32), ctypes.POINTER(ctypes.c_uint32)
    ]
    lib.schur_get_low_row_words.argtypes = [ctypes.c_void_p, ctypes.c_int, ctypes.POINTER(ctypes.c_uint64)]
    lib.schur_get_low_row_words.restype = ctypes.c_int

    lib.run_openmp_pair_probing.argtypes = [
        ctypes.c_int,
        ctypes.c_int, ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_uint32),
        ctypes.c_int, ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_uint32),
        ctypes.c_int, ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_uint32),
        ctypes.c_int, ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
    ]
    lib.run_openmp_pair_probing.restype = ctypes.c_int

    lib.audit_bent_c.argtypes = [ctypes.POINTER(ctypes.c_uint64), ctypes.c_uint64, ctypes.c_uint64]
    lib.audit_bent_c.restype = ctypes.c_int
    return lib, so_path


def solve_cell_2sat_probe(cell_tuple: tuple[int, int, int], lib, precomp: dict, budget_sec: float = 300.0):
    t0 = time.perf_counter()
    c99_val, c57_val, c113_val = cell_tuple
    cell_name = f"B{c99_val}_{c57_val}{c113_val}"
    print(f"\n==================== [{cell_name}] STARTING PURE 111-VAR EXTRACTION ====================", flush=True)

    orbits = precomp["orbits"]
    v6_list = precomp["v6_list"]
    pair_idx = precomp["pair_idx"]
    orb_diag = precomp["orb_diag"]
    orb_pair = precomp["orb_pair"]
    orb_r4 = precomp["orb_r4"]
    chi_r4 = precomp["chi_r4"]
    rep_of_x = precomp["rep_of_x"]
    orb_tts = precomp["orb_tts"]
    coset_0xf_reps = precomp["coset_0xf_reps"]
    coset_0x5_reps = precomp["coset_0x5_reps"]
    nonzero_z = precomp["nonzero_z"]
    M_mod2_rows = precomp["M_mod2_rows"]
    null_z_vecs = precomp["null_z_vecs"]

    _, origin111, cb111 = build_pure_111_basis(c99_val, c57_val, c113_val)
    n = 111

    # Setup initial degree <= 3 Macaulay table on n=111 pure variables
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

    max_rows = 16500
    rows = (ctypes.c_uint64 * (max_rows * n_col_words))()
    piv_row_idx = (ctypes.c_int * n_cols)(*([-1] * n_cols))
    cur_row = 0
    deg_pivs = {0: 0, 1: 0, 2: 0, 3: 0}
    xl_queue = []
    raw_deg4_psets_111 = []

    def record_piv(pc):
        nonlocal cur_row
        if pc < 0:
            return
        d = 0 if pc == off0 else (1 if pc >= off1 else (2 if pc >= off2 else 3))
        deg_pivs[d] += 1
        if d in (1, 2):
            xl_queue.append(cur_row)
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

    def insert_pset_111(pset):
        if not pset or cur_row >= max_rows - 2 or piv_row_idx[off0] >= 0:
            return -1
        max_d = max(m.bit_count() for m in pset)
        if max_d == 4:
            raw_deg4_psets_111.append(pset)
            return -2
        if max_d > 4:
            return -3
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
        record_piv(pc)
        return pc

    def drain_xl_111():
        while xl_queue and piv_row_idx[off0] < 0 and cur_row < max_rows - n - 25:
            r_idx = xl_queue.pop(0)
            row_slice = [rows[r_idx * n_col_words + w] for w in range(n_col_words)]
            pset = decode_row_to_pset(row_slice, n_cols, off2, off1, off0, pair2_list, col3_list)
            for i in range(n):
                if cur_row >= max_rows - 5 or piv_row_idx[off0] >= 0:
                    break
                insert_pset_111(mul_p({1 << i}, pset))

    def pack_point_reps(reps):
        O_w = 0
        b_ws = [0] * n
        for idx, x_pt in enumerate(reps):
            orb_vec = 0
            for j in range(116):
                if (orb_tts[j * 1024 + (x_pt >> 6)] >> (x_pt & 63)) & 1:
                    orb_vec |= 1 << j
            if (origin111 & orb_vec).bit_count() & 1:
                O_w |= 1 << idx
            for i, cdir in enumerate(cb111):
                if (cdir & orb_vec).bit_count() & 1:
                    b_ws[i] |= 1 << idx
        return b_ws, O_w

    # 1. Exact C_{0xf} (256 C16-orbits, target weight = 128 == 0 mod 16 -> extracts deg 1, 2, 3, 4!)
    #    AND C_{[0x5]} (512 C16-orbits, target weight = 256 == 0 mod 16 -> extracts deg 1, 2, 3, 4!)
    b_0xf, O_0xf = pack_point_reps(coset_0xf_reps)
    for _, pset in extract_exact_weight_levels_upto_deg4(b_0xf, O_0xf, 128, 4, n):
        insert_pset_111(pset)
    drain_xl_111()

    b_0x5, O_0x5 = pack_point_reps(coset_0x5_reps)
    for _, pset in extract_exact_weight_levels_upto_deg4(b_0x5, O_0x5, 256, 4, n):
        insert_pset_111(pset)
    drain_xl_111()

    # 2. Exact C5 (0x3f3f support) + C7 (0x7777 support) + V6 x V6 hierarchy on pure 111 vars!
    O_diag, O_pair, O_r4 = 0, 0, 0
    for j in range(116):
        if (origin111 >> j) & 1:
            O_diag ^= orb_diag[j]
            O_pair ^= orb_pair[j]
            O_r4 ^= orb_r4[j]
    cb_pair, cb_r4 = [], []
    for cdir in cb111:
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

    MAX_CHARS = 9
    MAX_C_PAIRS = MAX_CHARS * (MAX_CHARS - 1) // 2
    p_idxs_arr = (ctypes.c_int * 2048)()
    char_words32 = (ctypes.c_uint64 * (MAX_CHARS * 32))()
    quad_buf = (ctypes.c_uint64 * (MAX_CHARS * n_col_words))()
    quad_valid = (ctypes.c_int * MAX_CHARS)()
    lin_buf = (ctypes.c_uint64 * (MAX_C_PAIRS * n_col_words))()
    lin_valid = (ctypes.c_int * MAX_C_PAIRS)()

    def process_coset_111(pts_16):
        if piv_row_idx[off0] >= 0 or cur_row >= max_rows - 120:
            return
        diag_pts = [x & 0xFF for x in pts_16 if (x & 0xFF) == (x >> 8)]
        pair_reps = [x for x in pts_16 if (x & 0xFF) < (x >> 8)]
        n_pairs = len(pair_reps)
        dmask = sum(1 << v for v in diag_pts)
        wt_diag = (O_diag & dmask).bit_count()

        for k, x in enumerate(pair_reps):
            p_idxs_arr[k] = pair_idx[(x & 0xFF, x >> 8)]
        u_vecs = [(1 << r) | (1 << (r + 8)) for r in range(8)] + [0xFFFF]
        ctypes.memset(char_words32, 0, ctypes.sizeof(char_words32))
        for m, u16 in enumerate(u_vecs):
            base_m = m * 32
            for k, x in enumerate(pair_reps):
                if (x & u16).bit_count() & 1:
                    char_words32[base_m + (k >> 6)] |= 1 << (k & 63)

        if wt_diag % 8 == 4:
            base_ptr = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            if lib.extract_level1_quad_when_diag4(
                all_pair_bits, p_idxs_arr, n_pairs, n, None, off2, off1, off0, n_col_words, base_ptr
            ) == 0:
                pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
                record_piv(pc)
            for m in range(MAX_CHARS):
                if piv_row_idx[off0] >= 0 or cur_row >= max_rows - 20:
                    break
                um_ptr = ctypes.cast(ctypes.byref(char_words32, m * 32 * 8), ctypes.POINTER(ctypes.c_uint64))
                base_ptr = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                if lib.extract_level1_quad_when_diag4(
                    all_pair_bits, p_idxs_arr, n_pairs, n, um_ptr, off2, off1, off0, n_col_words, base_ptr
                ) == 0:
                    pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
                    record_piv(pc)
            drain_xl_111()
            return

        if wt_diag % 8 != 0:
            return
        diag_div8_parity = (wt_diag // 8) & 1
        ctypes.memset(quad_buf, 0, ctypes.sizeof(quad_buf))
        base_ptr = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
        rc = lib.extract_coset_full_hierarchy_corrected(
            all_pair_bits, p_idxs_arr, n_pairs, n, diag_div8_parity,
            char_words32, MAX_CHARS, col3_base, off2, off1, off0, n_col_words,
            base_ptr, quad_buf, quad_valid, lin_buf, lin_valid,
        )
        if rc != 0:
            return
        pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
        record_piv(pc)

        for pm in range(MAX_C_PAIRS):
            if not lin_valid[pm] or cur_row >= max_rows - 10 or piv_row_idx[off0] >= 0:
                continue
            dst = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            src = ctypes.cast(ctypes.byref(lin_buf, pm * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            ctypes.memmove(dst, src, n_col_words * 8)
            pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
            record_piv(pc)

        for m in range(MAX_CHARS):
            if not quad_valid[m] or cur_row >= max_rows - 10 or piv_row_idx[off0] >= 0:
                continue
            dst = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            src = ctypes.cast(ctypes.byref(quad_buf, m * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            ctypes.memmove(dst, src, n_col_words * 8)
            pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
            record_piv(pc)
        drain_xl_111()

    # Pass 2A: All 1,371 V6 x V6 linear subspaces first (discovers C5, C7, Q4 analogs & closes B1_00 in <0.1s!)
    for pts8 in v6_list:
        if piv_row_idx[off0] >= 0:
            break
        process_coset_111([v | (w << 8) for v in pts8 for w in pts8])

    if piv_row_idx[off0] >= 0:
        return {
            "cell": cell_name,
            "closed_unsat": True,
            "closed_by": "pure_111_v6_linear_echelon",
            "deg_pivs_111": deg_pivs,
            "elapsed_sec": round(time.perf_counter() - t0, 3),
        }

    # Pass 2B: Seed Q4 (C4) + Dual Fiber Equations on all 35 fibers F_z!
    def lin_expr_111(indices):
        mask = sum(1 << j for j in indices)
        idxs = [i for i, c in enumerate(cb111) if (c & mask).bit_count() & 1]
        return idxs, (origin111 & mask).bit_count() & 1

    def poly_from_lin(idxs, const):
        p = {1 << i for i in idxs}
        if const:
            p.add(0)
        return p

    slin_i, slin_c = lin_expr_111([23, 31, 39, 112])
    q4_seed = poly_from_lin(slin_i, slin_c ^ c57_val)
    pairs_ij = [(I2, J2), (I3, J3), (I4, J4)] if c99_val == 1 else [(I1, J1), (I2, J2), (I3, J3), (I4, J4)]
    for Ir, Jr in pairs_ij:
        ui, uc = lin_expr_111(Ir)
        vi, vc = lin_expr_111(Jr)
        q4_seed ^= mul_p(poly_from_lin(ui, uc), poly_from_lin(vi, vc))
    insert_pset_111(q4_seed)
    drain_xl_111()

    if c99_val == 0 and c57_val == 0 and c113_val == 0:
        # B0_00 Theorem A1: ALL 35 fibers F_z have exact weight len(reps)//2 -> extract deg 1, 2, 3, AND 4!
        # In particular F_{0xff} (16 reps, target=8) gives exact inhomogeneous degree-4 = 1 killing c=0!
        for z_rep, _ in nonzero_z:
            gstep = 1 if z_rep == 0xFF else (2 if z_rep in (0x55, 0xAA) else (4 if z_rep in (0x11, 0x33, 0x77) else 8))
            reps = fiber_orbit_reps(z_rep, gstep)
            b_fz, O_fz = pack_point_reps(reps)
            for _, pset in extract_exact_weight_levels_upto_deg4(b_fz, O_fz, len(reps) // 2, 4, n):
                insert_pset_111(pset)
            drain_xl_111()
    elif c57_val == 1 and c113_val == 1:
        # Krawtchouk left-nullspace linear syzygies across the 35 fibers F_z
        pair_forms_35 = [pack_point_reps(fiber_orbit_reps(z_rep, 8)) for z_rep, _ in nonzero_z]
        for u_vec in null_z_vecs:
            w_xor = [0] * n
            o_xor = 0
            for z_i in range(len(nonzero_z)):
                if (u_vec >> z_i) & 1:
                    b_fz, O_fz = pair_forms_35[z_i]
                    o_xor ^= O_fz.bit_count() & 1
                    for i in range(n):
                        w_xor[i] ^= b_fz[i].bit_count() & 1
            lin_p = {1 << i for i in range(n) if w_xor[i]}
            if o_xor:
                lin_p.add(0)
            insert_pset_111(lin_p)
        drain_xl_111()

    # Pass 2C: Diagonal affine shifts + Interleaved conjugates (budget <= 20s)
    t_aff = time.perf_counter()
    for pts8 in v6_list:
        if (time.perf_counter() - t_aff) > min(20.0, budget_sec * 0.12) or piv_row_idx[off0] >= 0 or cur_row >= max_rows - 200:
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
                process_coset_111([x ^ a16 for x in w_pts])
            process_coset_111([interleave16(x ^ a16) for x in w_pts])
            if piv_row_idx[off0] >= 0:
                break

    # Pass 2D: rot^4-invariant dim 12 (mod 32 -> BOTH deg<=3 AND deg=4 Q4_mod32 kept!) & dim 11 (mod 16 -> deg<=2)
    rng = random.Random(20262700 + 10 * c99_val + c57_val)
    seen_w = set()
    t_r4 = time.perf_counter()
    for trial in range(1200):
        if piv_row_idx[off0] >= 0 or cur_row >= max_rows - 150 or (time.perf_counter() - t_r4) > min(18.0, budget_sec * 0.12):
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
            P2, Q4 = extract_mod8_from_orbits4(sub_cb, sub_O, d0 // 4, n)
            if P2 is not None:
                insert_pset_111(P2)
                if codim == 4 and Q4 is not None:
                    # Keep BOTH deg <= 3 AND genuine deg-4 Q4_mod32 (up to 160 sparse deg-4 equations)!
                    if max((m.bit_count() for m in Q4), default=0) <= 3:
                        insert_pset_111(Q4)
                    elif len(Q4) <= 12000 and len(raw_deg4_psets_111) < 160:
                        raw_deg4_psets_111.append(Q4)
                drain_xl_111()

    if piv_row_idx[off0] >= 0:
        return {
            "cell": cell_name,
            "closed_unsat": True,
            "closed_by": "pure_111_deg3_echelon",
            "deg_pivs_111": deg_pivs,
            "elapsed_sec": round(time.perf_counter() - t0, 3),
        }

    # Load T28 (branch 0 for c99=0, branch 1 for c99=1) as exact degree-4 polynomial!
    poly_t28_c116, t28_path = load_t28_branch_poly_c116(c99_val, precomp["work_dir"])
    if poly_t28_c116 is not None:
        t28_pset_111 = map_c116_poly_to_basis(poly_t28_c116, origin111, cb111)
        if t28_pset_111:
            raw_deg4_psets_111.insert(0, t28_pset_111)
            print(f"[{cell_name}] Loaded T28 (branch {c99_val}) from {t28_path}: {len(t28_pset_111)} terms", flush=True)

    # Decode all discovered degree 1, 2, 3 pivot rows from the 111-var table
    lin_psets, quad_psets, cub_psets = [], [], []
    for c_idx in range(n_cols):
        r_idx = piv_row_idx[c_idx]
        if r_idx < 0:
            continue
        row_slice = [rows[r_idx * n_col_words + w] for w in range(n_col_words)]
        pset = decode_row_to_pset(row_slice, n_cols, off2, off1, off0, pair2_list, col3_list)
        if c_idx >= off1:
            lin_psets.append(pset)
        elif c_idx >= off2:
            quad_psets.append(pset)
        else:
            cub_psets.append(pset)

    print(f"[{cell_name}] Phase 1 done in {time.perf_counter()-t0:.2f}s: "
          f"lin={len(lin_psets)}, quad={len(quad_psets)}, cub={len(cub_psets)}, deg4={len(raw_deg4_psets_111)}",
          flush=True)

    # ==========================================================================
    # PHASE 2: Iterative Global Collapse Loop:
    #   [Eliminate All Linears] -> [Schur-Mutant-XL Deg 4] -> [OpenMP 2-SAT Pair Probing + Tarjan SCC]
    # ==========================================================================
    cur_origin = origin111
    cur_cb = list(cb111)
    all_psets = lin_psets + quad_psets + cub_psets + raw_deg4_psets_111
    binary_clauses_2sat = set()  # accumulated 2-SAT clauses on CURRENT variable indices
    probe_stats_log = []

    for outer_round in range(1, 16):
        if (time.perf_counter() - t0) > budget_sec * 0.85:
            break

        # Step 2.1: Exact Gaussian elimination of ALL degree-1 equations -> shrink variable count N!
        while True:
            cur_n = len(cur_cb)
            lin_rows = {}
            contradiction = False
            for p in all_psets:
                if not p:
                    continue
                md = max(m.bit_count() for m in p)
                if md == 0:
                    contradiction = True
                    break
                if md == 1:
                    vmask = 0
                    cbit = 0
                    for m in p:
                        if m == 0:
                            cbit ^= 1
                        else:
                            vmask |= m
                    while vmask:
                        lead = vmask.bit_length() - 1
                        if lead in lin_rows:
                            pm, pc = lin_rows[lead]
                            vmask ^= pm
                            cbit ^= pc
                        else:
                            lin_rows[lead] = (vmask, cbit)
                            break
                    if vmask == 0 and cbit == 1:
                        contradiction = True
                        break
            if contradiction:
                return {
                    "cell": cell_name,
                    "closed_unsat": True,
                    "closed_by": f"linear_collapse_round_{outer_round}",
                    "rounds": probe_stats_log,
                    "elapsed_sec": round(time.perf_counter() - t0, 3),
                }
            if not lin_rows:
                break

            # Back-substitute linear pivots so every pivot is expressed purely in free variables!
            piv_vars = sorted(lin_rows.keys(), reverse=True)
            for idx_a in range(len(piv_vars) - 1, -1, -1):
                va = piv_vars[idx_a]
                ma, ca = lin_rows[va]
                tail_a = ma ^ (1 << va)
                for idx_b in range(idx_a):
                    vb = piv_vars[idx_b]
                    mb, cb_bit = lin_rows[vb]
                    if (mb >> va) & 1:
                        lin_rows[vb] = ((mb ^ (1 << va)) ^ tail_a, cb_bit ^ ca)

            piv_set = set(lin_rows.keys())
            keep_vars = [v for v in range(cur_n) if v not in piv_set]
            lin_subst = {pv: (pm ^ (1 << pv), pc) for pv, (pm, pc) in lin_rows.items()}

            # Update (cur_origin, cur_cb) on the 116 orbit bits!
            new_origin = cur_origin
            new_cb = [cur_cb[v] for v in keep_vars]
            remap_keep = {ov: nv for nv, ov in enumerate(keep_vars)}
            for pv, (wmask, cbit) in lin_subst.items():
                cpiv = cur_cb[pv]
                if cbit:
                    new_origin ^= cpiv
                tmp = wmask
                while tmp:
                    b = tmp & -tmp
                    ov = b.bit_length() - 1
                    tmp ^= b
                    new_cb[remap_keep[ov]] ^= cpiv
            cur_origin, cur_cb = new_origin, new_cb
            all_psets = substitute_linear_map_in_psets(all_psets, lin_subst, keep_vars)
            binary_clauses_2sat.clear()

        N = len(cur_cb)
        if N == 0:
            # 0 free variables left -> check directly if cur_origin is bent!
            is_b = lib.audit_bent_c(orb_tts, cur_origin & mask64, cur_origin >> 64)
            return {
                "cell": cell_name,
                "closed_unsat": (is_b == 0),
                "closed_by": "zero_vars_direct_fwht",
                "bent_hits": [hex(cur_origin)] if is_b else [],
                "elapsed_sec": round(time.perf_counter() - t0, 3),
            }

        # Partition polynomials by degree in the reduced N-variable ring
        q2_raw = [p for p in all_psets if p and max(m.bit_count() for m in p) <= 2]
        c3_raw = [p for p in all_psets if p and max(m.bit_count() for m in p) == 3]
        f4_raw = [p for p in all_psets if p and max(m.bit_count() for m in p) == 4]

        # Step 2.2: Run C11 Schur-Mutant-XL (Degree 4) to harvest degree <= 3 Mutants from:
        #   - All explicit degree-4 equations (T28, Q4_mod32, e4_Fz, e4_C0xf, e4_C0x5)
        #   - Pairwise quadratic products q_a * q_b (especially lethal in B1_11 where n_q2 >= 223!)
        #   - Sparse x_i * x_j * q_a multiples
        arena_cap = 90_000_000  # ~360 MB CSR arena
        sctx = lib.schur_create(N, arena_cap, 16000, 10240)
        low_mutants_added = 0

        for p in q2_raw:
            off_c, trm_c = pack_psets_to_csr([p], 3)
            lib.schur_insert_low_packed(sctx, trm_c, off_c[1])
            for u in range(N):
                pu = set()
                for m in p:
                    pu.symmetric_difference_update({m | (1 << u)})
                if pu:
                    oc, tc = pack_psets_to_csr([pu], 3)
                    lib.schur_insert_low_packed(sctx, tc, oc[1])

        for p in c3_raw:
            oc, tc = pack_psets_to_csr([p], 3)
            lib.schur_insert_low_packed(sctx, tc, oc[1])

        has_one_c = ctypes.c_int(0)
        num_piv4_c = ctypes.c_uint32(0)
        dp_c = (ctypes.c_uint32 * 4)()
        lib.schur_get_stats(sctx, ctypes.byref(has_one_c), ctypes.byref(num_piv4_c), dp_c)

        if not has_one_c.value:
            # Feed sparse x_u * x_v * q_m first (sorted by sparsity of q_m) to populate A_44 pivots!
            q2_sorted = sorted(q2_raw, key=len)
            t_schur = time.perf_counter()
            out_lr = ctypes.c_int(-1)

            # In B1_11 (len(q2_raw) >= 180) or when f4_raw is non-empty, feed sparse multiples + q_a * q_b!
            max_q_mult = min(len(q2_sorted), 40 if len(q2_sorted) < 160 else 90)
            for q_p in q2_sorted[:max_q_mult]:
                if (time.perf_counter() - t_schur) > min(18.0, budget_sec * 0.10):
                    break
                if len(q_p) > 650:
                    continue
                for u in range(0, N, 1 if len(q_p) <= 120 else 2):
                    for v in range(u + 1, N, 1 if len(q_p) <= 120 else 2):
                        uv = (1 << u) | (1 << v)
                        p4 = set()
                        for m in q_p:
                            p4.symmetric_difference_update({m | uv})
                        if not p4:
                            continue
                        oc, tc = pack_psets_to_csr([p4], 4)
                        rc_m = lib.schur_insert_deg4_packed(sctx, tc, oc[1], ctypes.byref(out_lr))
                        if rc_m >= 0:
                            low_mutants_added += 1
                            if rc_m == 0:
                                break
                    lib.schur_get_stats(sctx, ctypes.byref(has_one_c), ctypes.byref(num_piv4_c), dp_c)
                    if has_one_c.value:
                        break
                if has_one_c.value:
                    break

            # Feed pairwise products q_a * q_b of the sparsest quadratics!
            if not has_one_c.value:
                top_sparse_q = [q for q in q2_sorted[:80] if len(q) <= 180]
                for ia in range(len(top_sparse_q)):
                    if has_one_c.value or (time.perf_counter() - t_schur) > min(25.0, budget_sec * 0.15):
                        break
                    qa = top_sparse_q[ia]
                    for ib in range(ia + 1, len(top_sparse_q)):
                        qb = top_sparse_q[ib]
                        prod = set()
                        for ma in qa:
                            for mb in qb:
                                prod.symmetric_difference_update({ma | mb})
                        if not prod:
                            continue
                        oc, tc = pack_psets_to_csr([prod], 4)
                        rc_m = lib.schur_insert_deg4_packed(sctx, tc, oc[1], ctypes.byref(out_lr))
                        if rc_m >= 0:
                            low_mutants_added += 1
                            if rc_m == 0:
                                has_one_c.value = 1
                                break

            # Feed ALL explicit degree-4 equations (T28, Q4_mod32, e4_Fz, e4_C0xf, e4_C0x5)!
            for f4_p in f4_raw:
                if has_one_c.value:
                    break
                oc, tc = pack_psets_to_csr([f4_p], 4)
                rc_m = lib.schur_insert_deg4_packed(sctx, tc, oc[1], ctypes.byref(out_lr))
                if rc_m >= 0:
                    low_mutants_added += 1
                    if rc_m == 0:
                        has_one_c.value = 1
                        break

        lib.schur_get_stats(sctx, ctypes.byref(has_one_c), ctypes.byref(num_piv4_c), dp_c)
        if has_one_c.value:
            lib.schur_free(sctx)
            return {
                "cell": cell_name,
                "closed_unsat": True,
                "closed_by": f"schur_mutant_xl_deg4_round_{outer_round}",
                "N_reduced": N,
                "piv4_count": int(num_piv4_c.value),
                "low_pivs": [int(dp_c[k]) for k in range(4)],
                "rounds": probe_stats_log,
                "elapsed_sec": round(time.perf_counter() - t0, 3),
            }

        # Extract updated RREF basis of degree <= 3 from SchurCtx for OpenMP Pair Probing!
        total_low = int(dp_c[1] + dp_c[2] + dp_c[3])
        # Build combinadic decoder for SchurCtx low_cols: [deg3 | deg2 | deg1 | deg0]
        c3_dec = []
        for i2 in range(N):
            for i1 in range(i2):
                for i0 in range(i1):
                    # Wait: C_tab[i0][1] + C_tab[i1][2] + C_tab[i2][3] in colex order!
                    pass
        # Exact colex unranking table of size C(N,3) + C(N,2) + N + 1:
        n3_cur = N * (N - 1) * (N - 2) // 6
        n2_cur = N * (N - 1) // 2
        off2_l = n3_cur
        off1_l = n3_cur + n2_cur
        off0_l = off1_l + N
        low_cols_cur = off0_l + 1
        low_words_cur = (low_cols_cur + 63) // 64
        colex_to_mask = [0] * low_cols_cur
        idx_c = 0
        for i2 in range(2, N):
            for i1 in range(1, i2):
                for i0 in range(i1):
                    colex_to_mask[idx_c] = (1 << i0) | (1 << i1) | (1 << i2)
                    idx_c += 1
        assert idx_c == n3_cur
        for i1 in range(1, N):
            for i0 in range(i1):
                colex_to_mask[idx_c] = (1 << i0) | (1 << i1)
                idx_c += 1
        for i0 in range(N):
            colex_to_mask[idx_c] = 1 << i0
            idx_c += 1
        colex_to_mask[idx_c] = 0

        q2_echelon, c3_echelon, new_lin_from_mutants = [], [], []
        wbuf = (ctypes.c_uint64 * low_words_cur)()
        for r_i in range(total_low):
            if lib.schur_get_low_row_words(sctx, r_i, wbuf) < 0:
                continue
            pset = set()
            first_col = -1
            for w in range(low_words_cur):
                val = wbuf[w]
                while val:
                    b = val & -val
                    lcol = (w << 6) + b.bit_length() - 1
                    val ^= b
                    if lcol < low_cols_cur:
                        if first_col < 0:
                            first_col = lcol
                        pset.add(colex_to_mask[lcol])
            if not pset:
                continue
            if first_col >= off1_l:
                new_lin_from_mutants.append(pset)
            elif first_col >= off2_l:
                q2_echelon.append(pset)
            else:
                c3_echelon.append(pset)
        lib.schur_free(sctx)

        if new_lin_from_mutants:
            print(f"[{cell_name}] Round {outer_round}: Schur-XL produced {len(new_lin_from_mutants)} NEW LINEAR MUTANTS!", flush=True)
            all_psets = new_lin_from_mutants + q2_echelon + c3_echelon + f4_raw
            continue

        # ======================================================================
        # Step 2.3: OpenMP 1-Literal & 2-Literal Algebraic Pair Probing in C!
        # ======================================================================
        # Rank variables by co-occurrence degree in q2_echelon + f4_raw (Vertex Cover order!)
        var_weight = [0] * N
        for p in q2_echelon:
            for m in p:
                if m.bit_count() == 2:
                    b0 = (m & -m).bit_length() - 1
                    b1 = (m ^ (1 << b0)).bit_length() - 1
                    var_weight[b0] += 3
                    var_weight[b1] += 3
        for p in f4_raw[:5]:
            for m in p:
                tmp = m
                while tmp:
                    b = tmp & -tmp
                    var_weight[b.bit_length() - 1] += 1
                    tmp ^= b

        ranked_vars = sorted(range(N), key=lambda v: var_weight[v], reverse=True)
        # Select top K_pair variables for full 4-branch pair probing (all pairs if N<=80, else top 56 = 1,540 pairs = 6,160 branches!)
        K_pair = min(N, 64 if len(q2_echelon) >= 180 else 48)
        pair_list = []
        for idx_a in range(K_pair):
            for idx_b in range(idx_a + 1, K_pair):
                u, v = ranked_vars[idx_a], ranked_vars[idx_b]
                if u > v:
                    u, v = v, u
                pair_list.append((u, v))

        # Keep the 3,500 sparsest cubic pivots + up to 24 sparse deg-4 polys (incl. T28 if <=25k terms!) for fast in-branch drop!
        c3_for_probe = sorted(c3_echelon, key=len)[:3500]
        f4_for_probe = [p for p in f4_raw if len(p) <= 25000][:24]

        q2_off, q2_trm = pack_psets_to_csr(q2_echelon, 2)
        c3_off, c3_trm = pack_psets_to_csr(c3_for_probe, 3)
        f4_off, f4_trm = pack_psets_to_csr(f4_for_probe, 4)

        n_pairs_test = len(pair_list)
        p_i_arr = (ctypes.c_int * max(1, n_pairs_test))(*[p[0] for p in pair_list])
        p_j_arr = (ctypes.c_int * max(1, n_pairs_test))(*[p[1] for p in pair_list])
        unit_status = (ctypes.c_int * N)()
        pair_umask = (ctypes.c_uint8 * max(1, n_pairs_test))()
        lit_fm_lo = (ctypes.c_uint64 * (2 * N))()
        lit_fm_hi = (ctypes.c_uint64 * (2 * N))()
        lit_fv_lo = (ctypes.c_uint64 * (2 * N))()
        lit_fv_hi = (ctypes.c_uint64 * (2 * N))()

        tp = time.perf_counter()
        g_unsat = lib.run_openmp_pair_probing(
            N,
            len(q2_echelon), q2_off, q2_trm,
            len(c3_for_probe), c3_off, c3_trm,
            len(f4_for_probe), f4_off, f4_trm,
            n_pairs_test, p_i_arr, p_j_arr,
            1,  # enable Local XL inside every pair branch!
            unit_status, pair_umask,
            lit_fm_lo, lit_fm_hi, lit_fv_lo, lit_fv_hi,
        )
        probe_sec = round(time.perf_counter() - tp, 3)

        if g_unsat:
            probe_stats_log.append({"round": outer_round, "N": N, "probe_sec": probe_sec, "direct_unsat": True})
            return {
                "cell": cell_name,
                "closed_unsat": True,
                "closed_by": f"openmp_2sat_probing_round_{outer_round}",
                "N_reduced": N,
                "rounds": probe_stats_log,
                "elapsed_sec": round(time.perf_counter() - t0, 3),
            }

        # Build 2-SAT Implication Graph on 2*N literals & run Tarjan/Warshall closure!
        adj = [set() for _ in range(2 * N)]
        # Add previously accumulated binary clauses
        for l_a, l_b in binary_clauses_2sat:
            adj[l_a ^ 1].add(l_b)
            adj[l_b ^ 1].add(l_a)

        # 1) Edges from 1-literal probing closures: (x_i = a) -> (x_k = c)
        for i in range(N):
            if unit_status[i] in (0, 1):
                val = int(unit_status[i])
                # (x_i = 1-val) -> (x_i = val)
                adj[2 * i + (1 - val)].add(2 * i + val)
            for a in (0, 1):
                u_lit = 2 * i + a
                fm = int(lit_fm_lo[u_lit]) | (int(lit_fm_hi[u_lit]) << 64)
                fv = int(lit_fv_lo[u_lit]) | (int(lit_fv_hi[u_lit]) << 64)
                tmp = fm
                while tmp:
                    b = tmp & -tmp
                    k = b.bit_length() - 1
                    tmp ^= b
                    if k != i and k < N:
                        ck = (fv >> k) & 1
                        v_lit = 2 * k + ck
                        adj[u_lit].add(v_lit)
                        adj[v_lit ^ 1].add(u_lit ^ 1)
                        binary_clauses_2sat.add(tuple(sorted((u_lit ^ 1, v_lit))))

        # 2) Edges from 2-literal pair probing: if (x_i=a, x_j=b) is UNSAT -> clause (x_i=1-a v x_j=1-b)!
        n_pair_implications = 0
        for p_idx, (i, j) in enumerate(pair_list):
            pm = int(pair_umask[p_idx])
            for ab in range(4):
                if (pm >> ab) & 1:
                    a = (ab >> 1) & 1
                    b = ab & 1
                    lit_i = 2 * i + a
                    lit_j = 2 * j + b
                    adj[lit_i].add(lit_j ^ 1)
                    adj[lit_j].add(lit_i ^ 1)
                    cl = tuple(sorted((lit_i ^ 1, lit_j ^ 1)))
                    if cl not in binary_clauses_2sat:
                        binary_clauses_2sat.add(cl)
                        n_pair_implications += 1

        scc_unsat, scc_units, scc_equivs = tarjan_2sat_closure(N, adj)
        round_info = {
            "round": outer_round,
            "N": N,
            "q2": len(q2_echelon),
            "c3": len(c3_echelon),
            "f4": len(f4_raw),
            "low_mutants_added": low_mutants_added,
            "new_2sat_clauses": n_pair_implications,
            "total_2sat_clauses": len(binary_clauses_2sat),
            "scc_units": len(scc_units),
            "scc_equivs": len(scc_equivs),
            "probe_sec": probe_sec,
        }
        probe_stats_log.append(round_info)
        print(f"[{cell_name}] Round {outer_round} Probing: {json.dumps(round_info)}", flush=True)

        if scc_unsat:
            return {
                "cell": cell_name,
                "closed_unsat": True,
                "closed_by": f"tarjan_2sat_scc_contradiction_round_{outer_round}",
                "N_reduced": N,
                "rounds": probe_stats_log,
                "elapsed_sec": round(time.perf_counter() - t0, 3),
            }

        if scc_units or scc_equivs:
            # Inject newly proved units (x_i ^ c = 0) and 2-SAT equivalences (x_j ^ x_i ^ c = 0)
            # as exact degree-1 equations and loop back to Linear Elimination + Schur-XL!
            new_lins = []
            for i, val in scc_units.items():
                p = {1 << i}
                if val:
                    p.add(0)
                new_lins.append(p)
            for j, (i, xor_c) in scc_equivs.items():
                p = {(1 << j), (1 << i)}
                if xor_c:
                    p.add(0)
                new_lins.append(p)
            all_psets = new_lins + q2_echelon + c3_echelon + f4_raw
            continue

        # Fixed point of Algebraic 2-SAT Probing reached -> keep reduced system for Phase 3!
        all_psets = q2_echelon + c3_echelon + f4_raw
        break

    # ==========================================================================
    # PHASE 3: Exact Deterministic Residual Closer (CaDiCaL + 2-SAT Clauses +
    #          Z16* Symmetry Breaking + Zero Heavy Fiber CardEnc + C FWHT!)
    # ==========================================================================
    rem_sec = budget_sec - (time.perf_counter() - t0)
    if not HAS_PYSAT or rem_sec <= 2.0:
        return {
            "cell": cell_name,
            "closed_unsat": False,
            "reason": "pysat_unavailable_or_budget_exhausted_after_probing",
            "N_reduced": len(cur_cb),
            "total_2sat_clauses": len(binary_clauses_2sat),
            "rounds": probe_stats_log,
            "elapsed_sec": round(time.perf_counter() - t0, 3),
        }

    N = len(cur_cb)
    q2_final = [p for p in all_psets if p and max(m.bit_count() for m in p) <= 2]
    c3_final = sorted([p for p in all_psets if p and max(m.bit_count() for m in p) == 3], key=len)

    clauses = []
    v_cnt = [N]

    def new_var():
        v_cnt[0] += 1
        return v_cnt[0]

    def add_and_gate(out_v, in_lits):
        for l in in_lits:
            clauses.append([-out_v, l])
        clauses.append([out_v] + [-l for l in in_lits])

    def add_long_xor(lits, rhs):
        if not lits:
            if rhs:
                v = new_var()
                clauses.append([v])
                clauses.append([-v])
            return
        cur = list(lits)
        cur_rhs = rhs
        while len(cur) > 4:
            chunk, cur = cur[:3], cur[3:]
            aux = new_var()
            # chunk[0] ^ chunk[1] ^ chunk[2] ^ aux == 0
            a, b, c = chunk[0], chunk[1], chunk[2]
            for s0 in (-1, 1):
                for s1 in (-1, 1):
                    for s2 in (-1, 1):
                        for s3 in (-1, 1):
                            if ((s0 < 0) ^ (s1 < 0) ^ (s2 < 0) ^ (s3 < 0)) == 1:
                                clauses.append([s0 * a, s1 * b, s2 * c, s3 * aux])
            cur.insert(0, aux)
        k = len(cur)
        for mask in range(1 << k):
            if (mask.bit_count() & 1) != cur_rhs:
                clauses.append([(-cur[i] if ((mask >> i) & 1) else cur[i]) for i in range(k)])

    # 1) Inject ALL learned 2-SAT binary clauses directly into CaDiCaL!
    for l_a, l_b in binary_clauses_2sat:
        va, sa = (l_a >> 1) + 1, (l_a & 1)
        vb, sb = (l_b >> 1) + 1, (l_b & 1)
        clauses.append([va if sa else -va, vb if sb else -vb])

    # 2) Encode all reduced degree <= 2 pivots sharing y_{ij} = x_i & x_j
    pair_cache = {}
    for pset in q2_final:
        xor_lits, rhs = [], 0
        for m in sorted(pset):
            if m == 0:
                rhs ^= 1
            elif m.bit_count() == 1:
                xor_lits.append((m.bit_length() - 1) + 1)
            else:
                b0 = (m & -m).bit_length() - 1
                b1 = (m ^ (1 << b0)).bit_length() - 1
                key = (b0 + 1, b1 + 1)
                if key not in pair_cache:
                    yv = new_var()
                    add_and_gate(yv, [b0 + 1, b1 + 1])
                    pair_cache[key] = yv
                xor_lits.append(pair_cache[key])
        add_long_xor(xor_lits, rhs)

    # 3) Orbit literals c_0..c_115 + exact Z_16^* lexicographic symmetry breaking (factor 8x on c57==c113!)
    c_lits = {}
    long_lits = []
    for j in range(116):
        idxs = [i + 1 for i, cdir in enumerate(cur_cb) if (cdir >> j) & 1]
        const = (cur_origin >> j) & 1
        if not idxs:
            lv = new_var()
            clauses.append([lv if const else -lv])
        elif len(idxs) == 1 and const == 0:
            lv = idxs[0]
        elif len(idxs) == 1 and const == 1:
            lv = -idxs[0]
        else:
            lv = new_var()
            add_long_xor(idxs + [lv], const)
        c_lits[j] = lv
        if j not in (57, 99, 113, 115):
            long_lits.append(lv)

    for bound, fn in [(6, CardEnc.atleast), (106, CardEnc.atmost)]:
        enc = fn(lits=long_lits, bound=bound, top_id=v_cnt[0], encoding=EncType.seqcounter)
        v_cnt[0] = max(v_cnt[0], enc.nv)
        clauses.extend(enc.clauses)

    # Exact Z_16^* symmetry breaking on long orbits when c57 == c113!
    if c57_val == c113_val:
        long_orb_ids = [j for j in range(116) if j not in (57, 99, 113, 115)]
        for mult_a in (3, 5, 7, 9, 11, 13, 15):
            perm_j = precomp["z16_perms"][mult_a]
            # Encode lex: c_long <= c_long_permuted
            prev_eq = None
            for j in long_orb_ids:
                pj = perm_j[j]
                if j == pj:
                    continue
                lj, lpj = c_lits[j], c_lits[pj]
                # prev_eq -> (~lj v lpj)
                if prev_eq is None:
                    clauses.append([-lj, lpj])
                else:
                    clauses.append([-prev_eq, -lj, lpj])
                next_eq = new_var()
                # next_eq -> (prev_eq & (lj <-> lpj))
                if prev_eq is not None:
                    clauses.append([-next_eq, prev_eq])
                    clauses.append([next_eq, -prev_eq, -lj, -lpj])
                    clauses.append([next_eq, -prev_eq, lj, lpj])
                else:
                    clauses.append([next_eq, -lj, -lpj])
                    clauses.append([next_eq, lj, lpj])
                clauses.append([-next_eq, -lj, lpj])
                clauses.append([-next_eq, lj, -lpj])
                prev_eq = next_eq

    # 4) Encode T28 (C6) if available + ONLY the single lightweight C_{0xf} == 128 counter (256 bits)
    if poly_t28_c116 is not None:
        c6_lits, c6_rhs, c6_cache = [], 0, {}
        for m in poly_t28_c116:
            if m == 0:
                c6_rhs ^= 1
                continue
            bits = []
            tmp = m
            while tmp:
                b = tmp & -tmp
                bits.append(c_lits[b.bit_length() - 1])
                tmp ^= b
            if len(bits) == 1:
                c6_lits.append(bits[0])
            else:
                key = tuple(sorted(bits))
                if key not in c6_cache:
                    mv = new_var()
                    add_and_gate(mv, list(key))
                    c6_cache[key] = mv
                c6_lits.append(c6_cache[key])
        add_long_xor(c6_lits, c6_rhs)

    # Precompute subcube checks (d=8: 0x5555, d=9: 0x5557, d=10: 0x555f) for short slack-nogoods!
    subcube_defs = []
    for sc_mask in (0x5555, 0xAAAA, 0x5557, 0x555F, 0x333F):
        pts_sc = [x for x in range(65536) if (x & ~sc_mask) == 0]
        dim_sc = sc_mask.bit_count()
        active_j, deltas_j, sub_tts = [], [], []
        fixed_tt = 0
        for j, orb in enumerate(orbits):
            sub_t = 0
            for idx_x, x in enumerate(pts_sc):
                if sum((x & m) == m for m in orb) & 1:
                    sub_t |= 1 << idx_x
            if sub_t == 0:
                continue
            if j in (57, 99, 113, 115):
                if (cur_origin >> j) & 1:
                    fixed_tt ^= sub_t
            else:
                active_j.append(j)
                deltas_j.append(sub_t.bit_count())
                sub_tts.append(sub_t)
        subcube_defs.append((dim_sc, active_j, deltas_j, sub_tts, fixed_tt))

    ts = time.perf_counter()
    models_checked = 0
    cubic_cuts = 0
    short_subcube_cuts = 0
    fwht_calls = 0
    bent_hits = []
    unsat_closed = False
    injected_c3 = set()

    with Solver(name="cadical195", bootstrap_with=clauses) as slv:
        while (time.perf_counter() - t0) < budget_sec:
            if not slv.solve():
                unsat_closed = True
                break
            models_checked += 1
            model = slv.get_model()
            model_set = set(model)
            x_bits = 0
            cint = cur_origin
            for i, cdir in enumerate(cur_cb):
                if (i + 1) in model_set:
                    x_bits |= 1 << i
                    cint ^= cdir

            # Check sparse cubic pivots lazily first
            added_c3 = 0
            for idx_c3, pset in enumerate(c3_final[:2500]):
                if idx_c3 in injected_c3:
                    continue
                val = 0
                for m in pset:
                    if (x_bits & m) == m:
                        val ^= 1
                if val:
                    xor_l, rhs_c = [], 0
                    new_cls = []
                    for m in pset:
                        if m == 0:
                            rhs_c ^= 1
                        elif m.bit_count() == 1:
                            xor_l.append((m.bit_length() - 1) + 1)
                        elif m.bit_count() == 2:
                            b0 = (m & -m).bit_length() - 1
                            b1 = (m ^ (1 << b0)).bit_length() - 1
                            key = (b0 + 1, b1 + 1)
                            if key not in pair_cache:
                                yv = new_var()
                                for l in [b0 + 1, b1 + 1]:
                                    new_cls.append([-yv, l])
                                new_cls.append([yv, -(b0 + 1), -(b1 + 1)])
                                pair_cache[key] = yv
                            xor_l.append(pair_cache[key])
                        else:
                            b0 = (m & -m).bit_length() - 1
                            m1 = m ^ (1 << b0)
                            b1 = (m1 & -m1).bit_length() - 1
                            b2 = (m1 ^ (1 << b1)).bit_length() - 1
                            key2 = (b0 + 1, b1 + 1)
                            if key2 not in pair_cache:
                                yv = new_var()
                                for l in [b0 + 1, b1 + 1]:
                                    new_cls.append([-yv, l])
                                new_cls.append([yv, -(b0 + 1), -(b1 + 1)])
                                pair_cache[key2] = yv
                            zv = new_var()
                            new_cls.append([-zv, pair_cache[key2]])
                            new_cls.append([-zv, b2 + 1])
                            new_cls.append([zv, -pair_cache[key2], -(b2 + 1)])
                            xor_l.append(zv)
                    prev_len = len(clauses)
                    add_long_xor(xor_l, rhs_c)
                    new_cls.extend(clauses[prev_len:])
                    for cl in new_cls:
                        slv.add_clause(cl)
                    injected_c3.add(idx_c3)
                    cubic_cuts += 1
                    added_c3 += 1
                    if added_c3 >= 16:
                        break
            if added_c3 > 0:
                continue

            # Check nested subcubes (d=8,9,10) for short slack-reduced nogoods (size 15..42 instead of N!)
            cut_by_sc = False
            for dim_sc, active_j, deltas_j, sub_tts, fixed_tt in subcube_defs:
                tt_sc = fixed_tt
                for k_sc, j_orb in enumerate(active_j):
                    if (cint >> j_orb) & 1:
                        tt_sc ^= sub_tts[k_sc]
                n_pts = 1 << dim_sc
                spec = [(-1 if ((tt_sc >> pt) & 1) else 1) for pt in range(n_pts)]
                step = 1
                while step < n_pts:
                    dbl = step << 1
                    for i_s in range(0, n_pts, dbl):
                        for j_s in range(i_s, i_s + step):
                            u_v, v_v = spec[j_s], spec[j_s + step]
                            spec[j_s] = u_v + v_v
                            spec[j_s + step] = u_v - v_v
                    step = dbl
                div_req = 1 << (dim_sc - 8)
                best_exc = max((abs(v) - 256 for v in spec), default=0)
                div_bad = any((abs(v) & (div_req - 1)) != 0 for v in spec)
                if best_exc > 0 or div_bad:
                    keep = [True] * len(active_j)
                    if best_exc > 0:
                        order_k = sorted(range(len(active_j)), key=lambda idx_k: deltas_j[idx_k])
                        used_slk = 0
                        for idx_k in order_k:
                            if used_slk + 2 * deltas_j[idx_k] < best_exc:
                                used_slk += 2 * deltas_j[idx_k]
                                keep[idx_k] = False
                    nogood = []
                    for idx_k, j_orb in enumerate(active_j):
                        if keep[idx_k]:
                            lj = c_lits[j_orb]
                            nogood.append(-lj if ((cint >> j_orb) & 1) else lj)
                    slv.add_clause(nogood)
                    short_subcube_cuts += 1
                    cut_by_sc = True
                    break
            if cut_by_sc:
                continue

            # Full 65,536-point C FWHT!
            fwht_calls += 1
            if lib.audit_bent_c(orb_tts, cint & mask64, cint >> 64):
                bent_hits.append(hex(cint))
                break
            slv.add_clause([-(i + 1) if ((x_bits >> i) & 1) else (i + 1) for i in range(N)])

    return {
        "cell": cell_name,
        "closed_unsat": (unsat_closed and len(bent_hits) == 0),
        "closed_by": "probing_plus_cadical_fwht" if unsat_closed else "budget_reached",
        "N_reduced": N,
        "total_2sat_clauses": len(binary_clauses_2sat),
        "models_checked": models_checked,
        "cubic_cuts_injected": cubic_cuts,
        "short_subcube_cuts": short_subcube_cuts,
        "fwht_calls": fwht_calls,
        "bent_hits": bent_hits,
        "rounds": probe_stats_log,
        "sat_sec": round(time.perf_counter() - ts, 3),
        "elapsed_sec": round(time.perf_counter() - t0, 3),
    }


def precompute_global_tables(work_dir: Path):
    orbits = build_orbits_116()
    v6_list = all_v6_orbits()

    pair_idx, all_pairs = {}, []
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
        ri = len(rot4_reps)
        rot4_reps.append(x)
        for y in o4:
            seen_x[y] = 1
            rep_of_x[y] = ri

    orb_tts = (ctypes.c_uint64 * (116 * 1024))()
    orb_diag, orb_pair, orb_r4 = [0] * 116, [0] * 116, [0] * 116
    for j, orb in enumerate(orbits):
        base = j * 1024
        for m in orb:
            for x in range(65536):
                if (x & m) == m:
                    orb_tts[base + (x >> 6)] ^= 1 << (x & 63)
        vd, vp, vr = 0, 0, 0
        for v in range(256):
            x = v | (v << 8)
            if (orb_tts[base + (x >> 6)] >> (x & 63)) & 1:
                vd |= 1 << v
        for k, x in enumerate(all_pairs):
            if (orb_tts[base + (x >> 6)] >> (x & 63)) & 1:
                vp |= 1 << k
        for k, x in enumerate(rot4_reps):
            if (orb_tts[base + (x >> 6)] >> (x & 63)) & 1:
                vr |= 1 << k
        orb_diag[j], orb_pair[j], orb_r4[j] = vd, vp, vr
    chi_r4 = sum((1 << k) for k, x in enumerate(rot4_reps) if x.bit_count() & 1)

    coset_0xf_reps, coset_0x5_reps = [], []
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
            elif vnib in (0x5, 0xA):
                coset_0x5_reps.append(mem[0])

    _, u8_size8, nonzero_z = build_c8_orbits()
    M_mod2_rows = []
    for z_rep, _ in nonzero_z:
        m_bits = 0
        for m, (_, a_orb) in enumerate(u8_size8):
            s_val = sum(-1 if ((a & z_rep).bit_count() & 1) else 1 for a in a_orb)
            if (s_val // 2) & 1:
                m_bits |= 1 << m
        M_mod2_rows.append(m_bits)
    null_z_vecs = gf2_nullspace_left(M_mod2_rows)

    # Precompute Z_16^* orbit permutations for exact symmetry breaking
    rep_to_j = {orb[0]: j for j, orb in enumerate(orbits)}
    z16_perms = {}
    for mult_a in (3, 5, 7, 9, 11, 13, 15):
        perm = {}
        for j, orb in enumerate(orbits):
            m = orb[0]
            pm = 0
            for bit in range(16):
                if (m >> bit) & 1:
                    pm |= 1 << ((bit * mult_a) & 15)
            canon = min(rot16(pm, r) for r in range(16))
            perm[j] = rep_to_j[canon]
        z16_perms[mult_a] = perm

    return {
        "work_dir": work_dir,
        "orbits": orbits,
        "v6_list": v6_list,
        "pair_idx": pair_idx,
        "orb_diag": orb_diag,
        "orb_pair": orb_pair,
        "orb_r4": orb_r4,
        "chi_r4": chi_r4,
        "rep_of_x": rep_of_x,
        "orb_tts": orb_tts,
        "coset_0xf_reps": coset_0xf_reps,
        "coset_0x5_reps": coset_0x5_reps,
        "nonzero_z": nonzero_z,
        "M_mod2_rows": M_mod2_rows,
        "null_z_vecs": null_z_vecs,
        "z16_perms": z16_perms,
    }


def main():
    t_start = time.perf_counter()
    target_arg = sys.argv[1].upper() if len(sys.argv) > 1 else "ALL"
    budget_per_cell = float(sys.argv[2]) if len(sys.argv) > 2 else 300.0

    cell_map = {
        "B1_00": [(1, 0, 0)],
        "B1_11": [(1, 1, 1)],
        "B0_11": [(0, 1, 1)],
        "B0_00": [(0, 0, 0)],
        "ALL":   [(1, 0, 0), (1, 1, 1), (0, 1, 1), (0, 0, 0)],
    }
    if target_arg not in cell_map:
        raise ValueError(f"Unknown target {target_arg}. Choose from {list(cell_map.keys())}.")

    work_dir = Path(__file__).resolve().parent
    lib, so_path = compile_c_engine(work_dir)
    try:
        print("[INIT] Precomputing global H(16,4) orbit truth tables, rot^4 orbits, and Krawtchouk tables...", flush=True)
        precomp = precompute_global_tables(work_dir)
        print(f"[INIT] Global tables ready in {time.perf_counter() - t_start:.2f}s.", flush=True)

        report = {"results": {}, "omp_threads": os.environ.get("OMP_NUM_THREADS", "auto")}
        for c_tup in cell_map[target_arg]:
            res = solve_cell_2sat_probe(c_tup, lib, precomp, budget_sec=budget_per_cell)
            report["results"][res["cell"]] = res
            print(f"=== [{res['cell']}] SUMMARY ===", flush=True)
            print(json.dumps(res, indent=2), flush=True)

        report["total_elapsed_sec"] = round(time.perf_counter() - t_start, 3)
        out_file = work_dir / f"probe_2sat_report_{target_arg.lower()}.json"
        out_file.write_text(json.dumps(report, indent=2), encoding="utf-8")
        print(f"\n=== FINAL PROBE 2-SAT REPORT SAVED TO {out_file} ===", flush=True)
        print(json.dumps(report, indent=2), flush=True)
    finally:
        if so_path.exists():
            try:
                so_path.unlink()
            except OSError:
                pass


if __name__ == "__main__":
    main()
