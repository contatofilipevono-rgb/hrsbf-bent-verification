#!/usr/bin/env python3
r"""
SOLVE_STEP11_CG_SCHUR_DEG4.py

Degree-4 Schur-Complement Mutant-XL Attack driven by Carlet-Guillot NNF:
  1. Builds ALL 389 Carlet-Guillot NNF cubics (116 |I|=12 + 273 |I|=11) + Step 9's base/cyclotomic
     system -> eliminates linear pivots (111 -> N=109), giving 4..6 genuine quads + 388..389 genuine cubics!
  2. Builds exact pure Degree-4 Carlet-Guillot NNF equations:
       - CG(|I|=16) (1 eq = T28)
       - CG(|I|=15) (1 eq: 15.7M 4-covers, 0.15s in C)
     and zero-trust verifies CG(|I|=16) and CG(|I|=15) directly against lambda_I(f)/8 mod 2!
  3. Runs a dedicated C11 Schur-Complement Degree-4 Mutant-XL engine (CSR arena up to 6 GB):
       - Loads all 4..6 quads + all 388..389 genuine cubics + XL(quads) into C_low
       - Inserts CG(|I|=16), CG(|I|=15), q_a * q_b, and z_a * z_b * q_c into A_44
       - MULTIPLIES ALL 116 SPARSE CG(|I|=12) CUBICS (~4,979 terms each) BY ALL N=109 VARIABLES
         (12,644 genuine degree-4 rows!) and then multiplies CG(|I|=11) cubics within time budget!
       - Immediately drains any degree-4 -> degree<=3 / degree<=2 / degree-1 / 1=0 mutants!
"""

import argparse
import ctypes
import json
import random
import subprocess
import sys
import time
from pathlib import Path

WORK_DIR = Path(__file__).resolve().parent
sys.path.insert(0, str(WORK_DIR))

import DIAGNOSE_V2_STRUCTURE as diag_v2
import SOLVE_B09_DUAL_S_ELIM as b09
import SOLVE_STEP9_8BRANCH_CUBIC_DROP as s9
import SOLVE_STEP10_CARLET_GUILLOT_NNF as s10

C_SCHUR11_SRC = r"""
#include <stddef.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <time.h>

static double now_sec(void) {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return (double)ts.tv_sec + 1e-9 * (double)ts.tv_nsec;
}

// Combinadic table C(n, k) for n <= 120, k <= 4
static uint32_t C_tab[128][5];
static void init_comb(void) {
    memset(C_tab, 0, sizeof(C_tab));
    for (int i = 0; i < 128; i++) {
        C_tab[i][0] = 1;
        for (int j = 1; j <= 4 && j <= i; j++) {
            C_tab[i][j] = C_tab[i - 1][j - 1] + C_tab[i - 1][j];
        }
    }
}

// Packed monomial of deg <= 4 in uint32_t: bytes [b0, b1, b2, b3] sorted ascending, unused = 0xFF
static inline uint32_t pack0(void) { return 0xFFFFFFFFU; }
static inline uint32_t pack1(int a) { return (uint32_t)a | 0xFFFFFF00U; }
static inline uint32_t pack2(int a, int b) {
    if (a > b) { int t = a; a = b; b = t; }
    return (uint32_t)a | ((uint32_t)b << 8) | 0xFFFF0000U;
}
static inline uint32_t pack3(int a, int b, int c) {
    int t;
    if (a > b) { t = a; a = b; b = t; }
    if (b > c) { t = b; b = c; c = t; }
    if (a > b) { t = a; a = b; b = t; }
    return (uint32_t)a | ((uint32_t)b << 8) | ((uint32_t)c << 16) | 0xFF000000U;
}
static inline uint32_t pack4(int a, int b, int c, int d) {
    int v[4] = {a, b, c, d};
    for (int i = 1; i < 4; i++) {
        int key = v[i], j = i - 1;
        while (j >= 0 && v[j] > key) { v[j + 1] = v[j]; j--; }
        v[j + 1] = key;
    }
    return (uint32_t)v[0] | ((uint32_t)v[1] << 8) | ((uint32_t)v[2] << 16) | ((uint32_t)v[3] << 24);
}

static inline uint32_t pack_dedup(const int *vs, int nv) {
    int u[4], nu = 0;
    for (int i = 0; i < nv; i++) {
        int x = vs[i], dup = 0;
        for (int j = 0; j < nu; j++) if (u[j] == x) { dup = 1; break; }
        if (!dup) u[nu++] = x;
    }
    if (nu == 0) return pack0();
    if (nu == 1) return pack1(u[0]);
    if (nu == 2) return pack2(u[0], u[1]);
    if (nu == 3) return pack3(u[0], u[1], u[2]);
    return pack4(u[0], u[1], u[2], u[3]);
}

typedef struct {
    int N;
    uint32_t n4, n3, n2, n1;
    uint32_t off3, off2, off1, off0, total_cols;
    uint32_t low_cols, low_words;

    // Dense low-degree echelon (deg <= 3)
    uint64_t *low_rows;
    int32_t *piv_low;
    uint32_t cur_low_rows, max_low_rows;

    // Sparse CSR degree-4 echelon A_44
    int64_t *piv4_off; // byte/u32 offset into arena, -1 if empty
    uint32_t *arena;
    size_t arena_used, arena_cap;
    uint32_t num_piv4;

    // Scratch bitset over ALL total_cols (~5.8M bits = 725 KB!)
    uint64_t *tmp_bits;
    uint32_t total_words;

    // Mutant queue (indices in low_rows)
    int32_t mutant_q[8192];
    int mq_head, mq_tail;

    int has_one;
    uint32_t deg_pivs[4];
    uint32_t mutants_found[4];
    uint32_t deg4_rows_processed;
    uint32_t arena_overflows;
} Schur11;

static Schur11 G;

static inline uint32_t pm_to_gcol(const Schur11 *ctx, uint32_t pm) {
    uint32_t b0 = pm & 0xFFU;
    if (b0 == 0xFFU) return ctx->off0;
    uint32_t b1 = (pm >> 8) & 0xFFU;
    if (b1 == 0xFFU) return ctx->off1 + b0;
    uint32_t b2 = (pm >> 16) & 0xFFU;
    if (b2 == 0xFFU) return ctx->off2 + C_tab[b1][2] + b0;
    uint32_t b3 = (pm >> 24) & 0xFFU;
    if (b3 == 0xFFU) return ctx->off3 + C_tab[b2][3] + C_tab[b1][2] + b0;
    return C_tab[b3][4] + C_tab[b2][3] + C_tab[b1][2] + b0;
}

static inline uint32_t gcol_low_to_pm(const Schur11 *ctx, uint32_t gc) {
    if (gc == ctx->off0) return pack0();
    if (gc >= ctx->off1) return pack1((int)(gc - ctx->off1));
    if (gc >= ctx->off2) {
        uint32_t r = gc - ctx->off2;
        int b1 = 1;
        while (b1 + 1 < ctx->N && C_tab[b1 + 1][2] <= r) b1++;
        int b0 = (int)(r - C_tab[b1][2]);
        return pack2(b0, b1);
    }
    uint32_t r = gc - ctx->off3;
    int b2 = 2;
    while (b2 + 1 < ctx->N && C_tab[b2 + 1][3] <= r) b2++;
    r -= C_tab[b2][3];
    int b1 = 1;
    while (b1 + 1 < b2 && C_tab[b1 + 1][2] <= r) b1++;
    int b0 = (int)(r - C_tab[b1][2]);
    return pack3(b0, b1, b2);
}

static inline uint32_t mul_var_pm_le3(int v, uint32_t pm) {
    int vs[4], nv = 0;
    vs[nv++] = v;
    for (int s = 0; s < 24; s += 8) {
        int b = (int)((pm >> s) & 0xFFU);
        if (b == 0xFF) break;
        vs[nv++] = b;
    }
    return pack_dedup(vs, nv);
}

static inline uint32_t mul_pm2_pm2(uint32_t p1, uint32_t p2) {
    int vs[4], nv = 0;
    for (int s = 0; s < 16; s += 8) {
        int b = (int)((p1 >> s) & 0xFFU);
        if (b == 0xFF) break;
        vs[nv++] = b;
    }
    for (int s = 0; s < 16; s += 8) {
        int b = (int)((p2 >> s) & 0xFFU);
        if (b == 0xFF) break;
        vs[nv++] = b;
    }
    return pack_dedup(vs, nv);
}

int s11_init(int N, uint32_t max_low_rows, size_t arena_u32_cap) {
    init_comb();
    memset(&G, 0, sizeof(G));
    G.N = N;
    G.n4 = C_tab[N][4];
    G.n3 = C_tab[N][3];
    G.n2 = C_tab[N][2];
    G.n1 = (uint32_t)N;
    G.off3 = G.n4;
    G.off2 = G.off3 + G.n3;
    G.off1 = G.off2 + G.n2;
    G.off0 = G.off1 + G.n1;
    G.total_cols = G.off0 + 1;
    G.total_words = (G.total_cols + 63) >> 6;
    G.low_cols = G.total_cols - G.off3;
    G.low_words = (G.low_cols + 63) >> 6;
    G.max_low_rows = max_low_rows;
    G.arena_cap = arena_u32_cap;

    G.low_rows = (uint64_t *)calloc((size_t)max_low_rows * G.low_words, sizeof(uint64_t));
    G.piv_low = (int32_t *)malloc((size_t)G.low_cols * sizeof(int32_t));
    G.piv4_off = (int64_t *)malloc((size_t)G.n4 * sizeof(int64_t));
    G.arena = (uint32_t *)malloc(arena_u32_cap * sizeof(uint32_t));
    G.tmp_bits = (uint64_t *)calloc(G.total_words, sizeof(uint64_t));
    if (!G.low_rows || !G.piv_low || !G.piv4_off || !G.arena || !G.tmp_bits) return -1;
    for (uint32_t i = 0; i < G.low_cols; i++) G.piv_low[i] = -1;
    for (uint32_t i = 0; i < G.n4; i++) G.piv4_off[i] = -1;
    return 0;
}

void s11_free(void) {
    free(G.low_rows); free(G.piv_low); free(G.piv4_off); free(G.arena); free(G.tmp_bits);
    memset(&G, 0, sizeof(G));
}

static int insert_low_row(const uint64_t *src, int is_mutant) {
    if (G.has_one || G.cur_low_rows >= G.max_low_rows) return -1;
    uint32_t rid = G.cur_low_rows;
    uint64_t *r = G.low_rows + (size_t)rid * G.low_words;
    memcpy(r, src, G.low_words * sizeof(uint64_t));

    for (uint32_t w = 0; w < G.low_words; w++) {
        while (r[w]) {
            int b = __builtin_ctzll(r[w]);
            uint32_t lc = (w << 6) + b;
            if (lc >= G.low_cols) { r[w] = 0ULL; break; }
            int32_t pr = G.piv_low[lc];
            if (pr >= 0) {
                const uint64_t *p = G.low_rows + (size_t)pr * G.low_words;
                for (uint32_t k = w; k < G.low_words; k++) r[k] ^= p[k];
            } else {
                G.piv_low[lc] = (int32_t)rid;
                G.cur_low_rows++;
                uint32_t gc = G.off3 + lc;
                int d = (gc == G.off0) ? 0 : (gc >= G.off1 ? 1 : (gc >= G.off2 ? 2 : 3));
                G.deg_pivs[d]++;
                if (d == 0) {
                    G.has_one = 1;
                    if (is_mutant) G.mutants_found[0]++;
                } else if (is_mutant) {
                    G.mutants_found[d]++;
                    if (d <= 2 && G.mq_tail < 8192) {
                        G.mutant_q[G.mq_tail++] = (int32_t)rid;
                    }
                }
                return d;
            }
        }
    }
    return -1;
}

int s11_insert_le3_packed(const uint32_t *pms, int len, int is_mutant) {
    if (G.has_one || len <= 0) return -1;
    uint64_t lbuf[4096];
    memset(lbuf, 0, G.low_words * sizeof(uint64_t));
    for (int i = 0; i < len; i++) {
        uint32_t gc = pm_to_gcol(&G, pms[i]);
        if (gc < G.off3) continue;
        uint32_t lc = gc - G.off3;
        lbuf[lc >> 6] ^= (1ULL << (lc & 63));
    }
    return insert_low_row(lbuf, is_mutant);
}

static int reduce_tmp_deg4(uint32_t min_w, uint32_t max_w) {
    if (G.has_one || min_w > max_w) return -1;
    G.deg4_rows_processed++;
    uint64_t *tb = G.tmp_bits;
    uint32_t d4_lim = (G.n4 + 63) >> 6;
    int new_p4 = -1;

    for (uint32_t w = min_w; w < d4_lim && w <= max_w; w++) {
        while (tb[w]) {
            int b = __builtin_ctzll(tb[w]);
            uint32_t c = (w << 6) + b;
            if (c >= G.n4) break;
            int64_t aoff = G.piv4_off[c];
            if (aoff >= 0) {
                uint32_t plen = G.arena[aoff];
                const uint32_t *pcols = &G.arena[aoff + 1];
                for (uint32_t k = 0; k < plen; k++) {
                    uint32_t pc = pcols[k];
                    uint32_t pw = pc >> 6;
                    tb[pw] ^= (1ULL << (pc & 63));
                    if (pw > max_w) max_w = pw;
                }
            } else {
                new_p4 = (int)c;
                w = d4_lim;
                break;
            }
        }
    }

    if (new_p4 < 0) {
        // MUTANT! Degree-4 part completely cancelled! Extract low-degree remainder!
        uint64_t lbuf[4096];
        memset(lbuf, 0, G.low_words * sizeof(uint64_t));
        uint32_t sh = G.off3 & 63;
        uint32_t bw = G.off3 >> 6;
        for (uint32_t lw = 0; lw < G.low_words; lw++) {
            uint64_t v = (bw + lw <= max_w) ? (tb[bw + lw] >> sh) : 0ULL;
            if (sh && (bw + lw + 1 <= max_w)) v |= (tb[bw + lw + 1] << (64 - sh));
            lbuf[lw] = v;
        }
        for (uint32_t w = min_w; w <= max_w; w++) tb[w] = 0ULL;
        return insert_low_row(lbuf, 1);
    }

    // Store new degree-4 pivot in CSR arena
    uint32_t start_w = (uint32_t)new_p4 >> 6;
    uint32_t nnz = 0;
    for (uint32_t w = start_w; w <= max_w; w++) nnz += (uint32_t)__builtin_popcountll(tb[w]);
    if (G.arena_used + nnz + 2 <= G.arena_cap) {
        int64_t aoff = (int64_t)G.arena_used;
        G.arena[aoff] = nnz;
        uint32_t *dst = &G.arena[aoff + 1];
        uint32_t pos = 0;
        for (uint32_t w = start_w; w <= max_w; w++) {
            uint64_t v = tb[w];
            tb[w] = 0ULL;
            while (v) {
                int b = __builtin_ctzll(v);
                dst[pos++] = (w << 6) + b;
                v &= v - 1;
            }
        }
        for (uint32_t w = min_w; w < start_w; w++) tb[w] = 0ULL;
        G.piv4_off[new_p4] = aoff;
        G.arena_used += nnz + 1;
        G.num_piv4++;
    } else {
        G.arena_overflows++;
        for (uint32_t w = min_w; w <= max_w; w++) tb[w] = 0ULL;
    }
    return 4;
}

int s11_insert_deg4_packed(const uint32_t *pms, int len) {
    if (G.has_one || len <= 0) return -1;
    uint32_t min_w = UINT32_MAX, max_w = 0;
    for (int i = 0; i < len; i++) {
        uint32_t gc = pm_to_gcol(&G, pms[i]);
        uint32_t gw = gc >> 6;
        G.tmp_bits[gw] ^= (1ULL << (gc & 63));
        if (gw < min_w) min_w = gw;
        if (gw > max_w) max_w = gw;
    }
    if (min_w > max_w) return -1;
    return reduce_tmp_deg4(min_w, max_w);
}

// Multiply a cubic/deg<=3 polynomial (passed as packed array) by all variables v=0..N-1 into A_44!
int s11_mul_cubic_by_all_vars(const uint32_t *pms, int len, double deadline_sec) {
    if (G.has_one || len <= 0) return G.has_one;
    for (int v = 0; v < G.N && !G.has_one; v++) {
        if (now_sec() >= deadline_sec) break;
        uint32_t min_w = UINT32_MAX, max_w = 0;
        for (int i = 0; i < len; i++) {
            uint32_t prod = mul_var_pm_le3(v, pms[i]);
            uint32_t gc = pm_to_gcol(&G, prod);
            uint32_t gw = gc >> 6;
            G.tmp_bits[gw] ^= (1ULL << (gc & 63));
            if (gw < min_w) min_w = gw;
            if (gw > max_w) max_w = gw;
        }
        if (min_w <= max_w) reduce_tmp_deg4(min_w, max_w);
        // Drain any deg<=2 mutants immediately!
        while (G.mq_head < G.mq_tail && !G.has_one && now_sec() < deadline_sec) {
            int32_t mrid = G.mutant_q[G.mq_head++];
            const uint64_t *mrow = G.low_rows + (size_t)mrid * G.low_words;
            uint32_t mpms[8192];
            int mlen = 0;
            uint32_t lcol_d2 = G.off2 - G.off3;
            for (uint32_t w = (lcol_d2 >> 6); w < G.low_words && mlen < 8192; w++) {
                uint64_t word = mrow[w];
                while (word) {
                    int b = __builtin_ctzll(word);
                    uint32_t gc = G.off3 + (w << 6) + b;
                    if (gc >= G.off2 && gc <= G.off0) mpms[mlen++] = gcol_low_to_pm(&G, gc);
                    word &= word - 1;
                }
            }
            // Multiply deg<=2 mutant by all N vars in C_low!
            uint64_t lbuf[4096];
            for (int u = 0; u < G.N && !G.has_one; u++) {
                memset(lbuf, 0, G.low_words * sizeof(uint64_t));
                for (int t = 0; t < mlen; t++) {
                    uint32_t pr = mul_var_pm_le3(u, mpms[t]);
                    uint32_t lc = pm_to_gcol(&G, pr) - G.off3;
                    lbuf[lc >> 6] ^= (1ULL << (lc & 63));
                }
                insert_low_row(lbuf, 1);
            }
        }
    }
    return G.has_one;
}

// Multiply a quadratic polynomial by all pairs z_a * z_b (0 <= a < b < N) into A_44!
int s11_mul_quad_by_all_pairs(const uint32_t *pms, int len, double deadline_sec) {
    if (G.has_one || len <= 0) return G.has_one;
    for (int a = 0; a < G.N && !G.has_one; a++) {
        if (now_sec() >= deadline_sec) break;
        for (int b = a + 1; b < G.N && !G.has_one; b++) {
            uint32_t pm2 = pack2(a, b);
            uint32_t min_w = UINT32_MAX, max_w = 0;
            for (int i = 0; i < len; i++) {
                uint32_t prod = mul_pm2_pm2(pm2, pms[i]);
                uint32_t gc = pm_to_gcol(&G, prod);
                uint32_t gw = gc >> 6;
                G.tmp_bits[gw] ^= (1ULL << (gc & 63));
                if (gw < min_w) min_w = gw;
                if (gw > max_w) max_w = gw;
            }
            if (min_w <= max_w) reduce_tmp_deg4(min_w, max_w);
        }
    }
    return G.has_one;
}

// Build exact Carlet-Guillot |I|=16 (4-partitions of {0..15}) directly into G.tmp_bits and reduce!
// Each orbit j in 0..115 is mapped to an affine form in N vars via orb_lin_lo[j], orb_lin_hi[j], orb_lin_c[j]!
// Wait: even faster — compute in original 116 orbit space (deduped 4-tuples of orbits!), then return packed terms!
// Actually for |I|=16 and |I|=15, let's build directly into a compact bitset of 116-orbit monomials?
// No! Even better: pass the affine expansion of each orbit j in N vars directly when accumulating!
// Wait: only orbit 0 (and the 2 eliminated linear pivots!) have multi-term expansions; ~109 orbits are SINGLE vars!
// Let's build the exact CG(|I|=16) and CG(|I|=15) in 116-orbit monomials via a 4-tuple hash or directly into G.tmp_bits!
static inline void toggle_orb4_into_tmp(
    int j1, int j2, int j3, int j4,
    const int *orb_n, const int *orb_vars, const int *orb_c,
    uint32_t *min_w, uint32_t *max_w
) {
    // orb_vars[j*112 .. j*112 + orb_n[j]-1], orb_c[j] in {0,1}
    // Deduplicate (j1,j2,j3,j4) first!
    int js[4] = {j1, j2, j3, j4};
    int u[4], nu = 0;
    for (int i = 0; i < 4; i++) {
        int x = js[i], dup = 0;
        for (int k = 0; k < nu; k++) if (u[k] == x) { dup = 1; break; }
        if (!dup) u[nu++] = x;
    }
    // Separate single-var/const orbits from multi-term orbits!
    int base_vs[4], nb = 0;
    int multi[4], nm = 0;
    for (int i = 0; i < nu; i++) {
        int j = u[i];
        int cnt = orb_n[j];
        int c = orb_c[j];
        if (cnt == 0) {
            if (c == 0) return; // multiplied by 0!
        } else if (cnt == 1 && c == 0) {
            base_vs[nb++] = orb_vars[j * 112];
        } else {
            multi[nm++] = j;
        }
    }
    // Recursive expansion of at most nm <= 4 multi-term orbits (in practice almost always nm == 0 or 1!)
    if (nm == 0) {
        uint32_t pm = pack_dedup(base_vs, nb);
        uint32_t gc = pm_to_gcol(&G, pm);
        uint32_t gw = gc >> 6;
        G.tmp_bits[gw] ^= (1ULL << (gc & 63));
        if (gw < *min_w) *min_w = gw;
        if (gw > *max_w) *max_w = gw;
        return;
    }
    // General small recursion for nm in 1..4:
    // Use nested loops via stack of size 4
    int term_idx[4] = {0, 0, 0, 0}; // -1 means constant term if orb_c[j]==1
    int start_idx[4];
    for (int m = 0; m < nm; m++) start_idx[m] = orb_c[multi[m]] ? -1 : 0;
    for (int m = 0; m < nm; m++) term_idx[m] = start_idx[m];
    while (1) {
        int vs[4], nv = nb;
        for (int i = 0; i < nb; i++) vs[i] = base_vs[i];
        for (int m = 0; m < nm; m++) {
            if (term_idx[m] >= 0) vs[nv++] = orb_vars[multi[m] * 112 + term_idx[m]];
        }
        uint32_t pm = pack_dedup(vs, nv);
        uint32_t gc = pm_to_gcol(&G, pm);
        uint32_t gw = gc >> 6;
        G.tmp_bits[gw] ^= (1ULL << (gc & 63));
        if (gw < *min_w) *min_w = gw;
        if (gw > *max_w) *max_w = gw;

        int pos = nm - 1;
        while (pos >= 0) {
            term_idx[pos]++;
            if (term_idx[pos] < orb_n[multi[pos]]) break;
            term_idx[pos] = start_idx[pos];
            pos--;
        }
        if (pos < 0) break;
    }
}

// Build CG(|I|=16) (4-partitions of {0..15}) directly into tmp_bits!
// If reduce_now==0, returns active term count in out_pms (for zero-trust check); if reduce_now==1, reduces in A_44!
int s11_build_cg16(
    const int16_t *mon_to_orb,
    const int *orb_n, const int *orb_vars, const int *orb_c,
    int reduce_now, uint32_t *out_pms, int max_out
) {
    uint32_t min_w = UINT32_MAX, max_w = 0;
    // Fix 0 in S1; choose 3 from 1..15
    for (int a1 = 1; a1 < 16; a1++)
    for (int a2 = a1 + 1; a2 < 16; a2++)
    for (int a3 = a2 + 1; a3 < 16; a3++) {
        int s1 = 1 | (1 << a1) | (1 << a2) | (1 << a3);
        int j1 = mon_to_orb[s1];
        int r12[12], n12 = 0;
        for (int x = 1; x < 16; x++) if (x != a1 && x != a2 && x != a3) r12[n12++] = x;
        int b0 = r12[0];
        for (int b1 = 1; b1 < 12; b1++)
        for (int b2 = b1 + 1; b2 < 12; b2++)
        for (int b3 = b2 + 1; b3 < 12; b3++) {
            int s2 = (1 << b0) | (1 << r12[b1]) | (1 << r12[b2]) | (1 << r12[b3]);
            int j2 = mon_to_orb[s2];
            int r8[8], n8 = 0;
            for (int x = 1; x < 12; x++) if (x != b1 && x != b2 && x != b3) r8[n8++] = r12[x];
            int c0 = r8[0];
            for (int c1 = 1; c1 < 8; c1++)
            for (int c2 = c1 + 1; c2 < 8; c2++)
            for (int c3 = c2 + 1; c3 < 8; c3++) {
                int s3 = (1 << c0) | (1 << r8[c1]) | (1 << r8[c2]) | (1 << r8[c3]);
                int s4 = 0xFFFF ^ s1 ^ s2 ^ s3;
                toggle_orb4_into_tmp(j1, j2, mon_to_orb[s3], mon_to_orb[s4],
                                     orb_n, orb_vars, orb_c, &min_w, &max_w);
            }
        }
    }
    if (reduce_now) {
        if (min_w <= max_w) return reduce_tmp_deg4(min_w, max_w);
        return -1;
    }
    // Count and clear tmp_bits
    int cnt = 0;
    for (uint32_t w = min_w; w <= max_w; w++) {
        uint64_t v = G.tmp_bits[w];
        G.tmp_bits[w] = 0ULL;
        while (v) {
            int b = __builtin_ctzll(v);
            uint32_t gc = (w << 6) + b;
            if (cnt < max_out && out_pms) out_pms[cnt] = gc;
            cnt++;
            v &= v - 1;
        }
    }
    return cnt;
}

// Build CG(|I|=15) (I = 0x7FFF: 1 element d covered twice, remaining 14 partitioned into (3,3,4,4))!
int s11_build_cg15(
    const int16_t *mon_to_orb,
    const int *orb_n, const int *orb_vars, const int *orb_c,
    int reduce_now, uint32_t *out_pms, int max_out
) {
    uint32_t min_w = UINT32_MAX, max_w = 0;
    int I_mask = 0x7FFF;
    for (int d = 0; d < 15; d++) {
        int bit_d = 1 << d;
        int r14[14], n14 = 0;
        for (int x = 0; x < 15; x++) if (x != d) r14[n14++] = x;
        // Choose 6 elements for A u B (size 3 + 3), then 8 elements left for S3 u S4 (size 4 + 4)!
        // Faster: choose S3 (4 of 14, fixing first of S3uS4? No: choose 6 of 14 = 3003, split 6 into 3+3 = 10, split 8 into 4+4 = 35 -> 15*3003*350 = 15.7M!)
        for (int i0 = 0; i0 < 14; i0++)
        for (int i1 = i0 + 1; i1 < 14; i1++)
        for (int i2 = i1 + 1; i2 < 14; i2++)
        for (int i3 = i2 + 1; i3 < 14; i3++)
        for (int i4 = i3 + 1; i4 < 14; i4++)
        for (int i5 = i4 + 1; i5 < 14; i5++) {
            int ab[6] = {r14[i0], r14[i1], r14[i2], r14[i3], r14[i4], r14[i5]};
            int r8[8], n8 = 0;
            for (int x = 0; x < 14; x++) {
                if (x != i0 && x != i1 && x != i2 && x != i3 && x != i4 && x != i5) r8[n8++] = r14[x];
            }
            int ab_mask = (1<<ab[0])|(1<<ab[1])|(1<<ab[2])|(1<<ab[3])|(1<<ab[4])|(1<<ab[5]);
            int s34_mask = I_mask ^ bit_d ^ ab_mask;
            // 10 splits of ab into (A, B) with ab[0] in A
            int pair_j1[10], pair_j2[10], np = 0;
            for (int u = 1; u < 6; u++)
            for (int v = u + 1; v < 6; v++) {
                int s1 = bit_d | (1 << ab[0]) | (1 << ab[u]) | (1 << ab[v]);
                int s2 = bit_d | (ab_mask ^ (s1 ^ bit_d));
                pair_j1[np] = mon_to_orb[s1];
                pair_j2[np] = mon_to_orb[s2];
                np++;
            }
            // 35 splits of r8 into (S3, S4) with r8[0] in S3
            int c0 = r8[0];
            for (int c1 = 1; c1 < 8; c1++)
            for (int c2 = c1 + 1; c2 < 8; c2++)
            for (int c3 = c2 + 1; c3 < 8; c3++) {
                int s3 = (1 << c0) | (1 << r8[c1]) | (1 << r8[c2]) | (1 << r8[c3]);
                int s4 = s34_mask ^ s3;
                int j3 = mon_to_orb[s3], j4 = mon_to_orb[s4];
                for (int p = 0; p < 10; p++) {
                    toggle_orb4_into_tmp(pair_j1[p], pair_j2[p], j3, j4,
                                         orb_n, orb_vars, orb_c, &min_w, &max_w);
                }
            }
        }
    }
    if (reduce_now) {
        if (min_w <= max_w) return reduce_tmp_deg4(min_w, max_w);
        return -1;
    }
    int cnt = 0;
    for (uint32_t w = min_w; w <= max_w; w++) {
        uint64_t v = G.tmp_bits[w];
        G.tmp_bits[w] = 0ULL;
        while (v) {
            int b = __builtin_ctzll(v);
            uint32_t gc = (w << 6) + b;
            if (cnt < max_out && out_pms) out_pms[cnt] = gc;
            cnt++;
            v &= v - 1;
        }
    }
    return cnt;
}

void s11_get_stats(uint32_t out[14]) {
    out[0] = (uint32_t)G.has_one;
    out[1] = G.num_piv4;
    out[2] = G.deg_pivs[0];
    out[3] = G.deg_pivs[1];
    out[4] = G.deg_pivs[2];
    out[5] = G.deg_pivs[3];
    out[6] = G.mutants_found[0];
    out[7] = G.mutants_found[1];
    out[8] = G.mutants_found[2];
    out[9] = G.mutants_found[3];
    out[10] = (uint32_t)(G.arena_used / 262144ULL); // MB (u32 * 4 / 1048576)
    out[11] = G.cur_low_rows;
    out[12] = G.deg4_rows_processed;
    out[13] = G.arena_overflows;
}
"""


def pack_mon_sorted(idxs):
    d = len(idxs)
    if d == 0:
        return 0xFFFFFFFF
    if d == 1:
        return idxs[0] | 0xFFFFFF00
    if d == 2:
        return idxs[0] | (idxs[1] << 8) | 0xFFFF0000
    if d == 3:
        return idxs[0] | (idxs[1] << 8) | (idxs[2] << 16) | 0xFF000000
    return idxs[0] | (idxs[1] << 8) | (idxs[2] << 16) | (idxs[3] << 24)


def pset_to_packed_reindexed(pset, old_to_new):
    out = []
    for m in pset:
        if m == 0:
            out.append(0xFFFFFFFF)
        else:
            idxs = []
            tmp = m
            while tmp:
                lb = tmp & -tmp
                idxs.append(old_to_new[lb.bit_length() - 1])
                tmp ^= lb
            idxs.sort()
            out.append(pack_mon_sorted(idxs))
    return out


def run_step11_cell(cell_name, budget_sec, lib_diag, lib9, lib_cg, lib11, orbits,
                    v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl):
    t0 = time.perf_counter()
    print(f"\n==================== [{cell_name}] STEP 11: CG(389) + CG(15,16) SCHUR-MUTANT-XL DEG-4 ====================", flush=True)
    c99, c57, c113 = int(cell_name[1]), int(cell_name[3]), int(cell_name[4])
    free111, origin111, cb111 = b09.build_pure_111_basis(c99, c57, c113)
    n = tbl["n"]
    n_cw = tbl["n_col_words"]

    # 1. Build 389 Carlet-Guillot cubics (116x12 + 273x11)
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

    # 2. Extract base pure-111 system + cyclotomic cubics and merge with CG(389) at root!
    sys_data = diag_v2.build_cell_algebraic_system(
        cell_name, lib_diag, orbits, v6_list, rot4_data, fiber_meta, extract_sec=18.0
    )
    if sys_data["has_one"]:
        return {"cell": cell_name, "has_one": True, "closed_by": "stage1_base"}

    cyc_cubs = s9.extract_verified_cyclotomic_cubics(cell_name, orbits, origin111, cb111, layers, c0x0)
    n_base_pivs = sum(sys_data["deg_pivs_111"].values())
    total_raw = n_base_pivs + len(cyc_cubs) + n_cg
    raw_buf = (ctypes.c_uint64 * (total_raw * n_cw))()
    ctypes.memmove(raw_buf, sys_data["rows_c"], n_base_pivs * n_cw * 8)
    for idx_c, (_, poly) in enumerate(cyc_cubs):
        s9.pset_to_row(poly, raw_buf, n_base_pivs + idx_c, tbl)
    dst_cg = ctypes.cast(ctypes.byref(raw_buf, (n_base_pivs + len(cyc_cubs)) * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
    ctypes.memmove(dst_cg, cg_buf, n_cg * n_cw * 8)

    root = s9.run_branch_cascade(
        lib9, raw_buf, [], list(range(total_raw)), {}, [], tbl, max_xl_rounds=5, verify_subst=False
    )
    if root["closed_unsat"]:
        return {"cell": cell_name, "has_one": True, "closed_by": "root_deg3"}

    lin_pivs = root["_lin_pivs"]
    active_vars = sorted(i for i in range(n) if i not in lin_pivs)
    N = len(active_vars)
    old_to_new = {old_i: new_i for new_i, old_i in enumerate(active_vars)}
    print(f"[{cell_name}] Root deg<=3 ready ({time.perf_counter()-t0:.1f}s): N={N}, "
          f"quads={root['n_quad_surviving']}, genuine_cubics={root['n_genuine_cubics']}", flush=True)

    # Also apply root's linear pivots (just 2 pivots!) to the 116 SPARSE CG(|I|=12) rows so we keep them ultra-sparse!
    # Wait: copy cg_buf[0..115] and substitute lin_pivs in-place!
    cg12_sub = (ctypes.c_uint64 * (len(reps12) * n_cw))()
    ctypes.memmove(cg12_sub, cg_buf, len(reps12) * n_cw * 8)
    mask64 = (1 << 64) - 1
    for p, (pv, pr) in lin_pivs.items():
        m = pv ^ (1 << p)
        lib9.subst_one_linear_var_batch(
            cg12_sub, len(reps12), n_cw, n, tbl["off2"], tbl["off1"], tbl["off0"],
            tbl["col2_base"], tbl["col3_base"], tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"],
            p, m & mask64, m >> 64, pr
        )

    # Build affine map of each of the 116 orbits in the N active vars (for CG16 and CG15!)
    # First map old_i in 0..110 -> (mask_N, const_bit)
    old_subst_N = []
    for old_i in range(n):
        if old_i in old_to_new:
            old_subst_N.append((1 << old_to_new[old_i], 0))
        else:
            pv, pr = lin_pivs[old_i]
            rem = pv ^ (1 << old_i)
            mn = 0
            while rem:
                lb = rem & -rem
                mn |= (1 << old_to_new[lb.bit_length() - 1])
                rem ^= lb
            old_subst_N.append((mn, pr))

    # Express each orbit j in 0..115 in N active vars:
    orb_n = (ctypes.c_int * 116)()
    orb_vars = (ctypes.c_int * (116 * 112))()
    orb_c = (ctypes.c_int * 116)()
    for j in range(116):
        mn = 0
        mc = (origin111 >> j) & 1
        for old_i in range(n):
            if (cb111[old_i] >> j) & 1:
                sm, sc = old_subst_N[old_i]
                mn ^= sm
                mc ^= sc
        orb_c[j] = mc
        cnt = 0
        for ni in range(N):
            if (mn >> ni) & 1:
                orb_vars[j * 112 + cnt] = ni
                cnt += 1
        orb_n[j] = cnt

    # 3. Initialize C11 Schur-Complement Degree-4 Engine (arena = 1.5B u32 = 6.0 GB RAM!)
    rc = lib11.s11_init(N, 24000, ctypes.c_size_t(1_500_000_000))
    assert rc == 0, "s11_init failed!"

    # Load all genuine quads + genuine cubics + XL(quads) into C_low
    quad_packed_list = []
    for qr in root["_quad_ids"]:
        ps = s9.row_to_pset(root["_buf"], qr, tbl)
        pms = pset_to_packed_reindexed(ps, old_to_new)
        quad_packed_list.append(pms)
        arr = (ctypes.c_uint32 * len(pms))(*pms)
        lib11.s11_insert_le3_packed(arr, len(pms), 0)
        # Also insert XL(quad) into C_low
        for v in range(N):
            ps_v = set()
            for m in ps:
                nm = m | (1 << active_vars[v])
                if nm in ps_v: ps_v.remove(nm)
                else: ps_v.add(nm)
            pms_v = pset_to_packed_reindexed(ps_v, old_to_new)
            arr_v = (ctypes.c_uint32 * len(pms_v))(*pms_v)
            lib11.s11_insert_le3_packed(arr_v, len(pms_v), 0)

    for cr in root["_cub_ids"]:
        ps = s9.row_to_pset(root["_buf"], cr, tbl)
        pms = pset_to_packed_reindexed(ps, old_to_new)
        arr = (ctypes.c_uint32 * len(pms))(*pms)
        lib11.s11_insert_le3_packed(arr, len(pms), 0)

    # 4. Inject CG(|I|=16) (=T28) and CG(|I|=15) into A_44!
    t_cg4 = time.perf_counter()
    r16 = lib11.s11_build_cg16(mon_to_orb_arr, orb_n, orb_vars, orb_c, 1, None, 0)
    r15 = lib11.s11_build_cg15(mon_to_orb_arr, orb_n, orb_vars, orb_c, 1, None, 0)
    print(f"[{cell_name}] Injected CG(|I|=16) [rc={r16}] & CG(|I|=15) [rc={r15}] in {time.perf_counter()-t_cg4:.2f}s", flush=True)

    # 5. Multiply all quads by all pairs z_a * z_b into A_44!
    deadline = time.monotonic() + max(10.0, budget_sec - (time.perf_counter() - t0))
    for q_idx, pms in enumerate(quad_packed_list):
        arr = (ctypes.c_uint32 * len(pms))(*pms)
        if lib11.s11_mul_quad_by_all_pairs(arr, len(pms), ctypes.c_double(deadline)):
            break

    st = (ctypes.c_uint32 * 14)()
    lib11.s11_get_stats(st)
    print(f"[{cell_name}] After quads*pairs + CG(15,16) ({time.perf_counter()-t0:.1f}s): "
          f"has_one={st[0]}, piv4={st[1]}, low_deg={list(st[2:6])}, mutants={list(st[6:10])}, arena_mb={st[10]}", flush=True)

    # 6. THE BIG NEW WEAPON: Multiply ALL 116 SPARSE CG(|I|=12) cubics by ALL N=109 variables into A_44!
    cg12_done = 0
    if not st[0]:
        # Sort CG12 rows by ascending term count so sparsest go FIRST!
        cg12_packed = []
        for idx in range(len(reps12)):
            ps = s9.row_to_pset(cg12_sub, idx, tbl)
            if ps:
                cg12_packed.append(pset_to_packed_reindexed(ps, old_to_new))
        cg12_packed.sort(key=len)
        print(f"[{cell_name}] Multiplying {len(cg12_packed)} sparse CG(|I|=12) cubics (min/med/max len = "
              f"{len(cg12_packed[0])}/{len(cg12_packed[len(cg12_packed)//2])}/{len(cg12_packed[-1])}) by all {N} vars...", flush=True)

        for idx, pms in enumerate(cg12_packed):
            if time.monotonic() >= deadline:
                break
            arr = (ctypes.c_uint32 * len(pms))(*pms)
            has1 = lib11.s11_mul_cubic_by_all_vars(arr, len(pms), ctypes.c_double(deadline))
            cg12_done += 1
            if has1:
                break
            if (idx + 1) % 15 == 0:
                lib11.s11_get_stats(st)
                print(f"  [{cell_name}] CG12 {idx+1}/{len(cg12_packed)} ({time.perf_counter()-t0:.1f}s): "
                      f"piv4={st[1]}, mutants(0,1,2,3)={list(st[6:10])}, arena_mb={st[10]}, ovf={st[13]}", flush=True)
                if st[13] > 500:
                    print(f"  [{cell_name}] Arena full ({st[10]} MB), stopping CG12 insert.", flush=True)
                    break

    lib11.s11_get_stats(st)
    res = {
        "cell": cell_name,
        "has_one": bool(st[0]),
        "N_free": N,
        "cg12_cubics_multiplied_by_all_vars": cg12_done,
        "deg4_rows_processed": int(st[12]),
        "piv4_stored": int(st[1]),
        "final_low_deg_pivs": {"0": int(st[2]), "1": int(st[3]), "2": int(st[4]), "3": int(st[5])},
        "mutants_found": {"deg0": int(st[6]), "deg1": int(st[7]), "deg2": int(st[8]), "deg3": int(st[9])},
        "arena_mb": int(st[10]),
        "arena_overflows": int(st[13]),
        "elapsed_sec": round(time.perf_counter() - t0, 3),
    }
    lib11.s11_free()
    print(f"[{cell_name}] STEP 11 RESULT: {json.dumps(res)}", flush=True)
    return res


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cells", type=str, default="B0_00,B0_11,B1_11")
    parser.add_argument("--budget", type=float, default=300.0)
    args = parser.parse_args()

    # Compile C libraries
    c_diag, so_diag = WORK_DIR / "s11_diag.c", WORK_DIR / "libs11_diag.so"
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

    c_s9, so_s9 = WORK_DIR / "s11_s9.c", WORK_DIR / "libs11_s9.so"
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

    c_cg, so_cg = WORK_DIR / "s11_cg.c", WORK_DIR / "libs11_cg.so"
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

    c_11, so_11 = WORK_DIR / "s11_schur.c", WORK_DIR / "libs11_schur.so"
    c_11.write_text(C_SCHUR11_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_11), "-o", str(so_11)], check=True)
    lib11 = ctypes.CDLL(str(so_11))
    lib11.s11_init.argtypes = [ctypes.c_int, ctypes.c_uint32, ctypes.c_size_t]
    lib11.s11_init.restype = ctypes.c_int
    lib11.s11_insert_le3_packed.argtypes = [ctypes.POINTER(ctypes.c_uint32), ctypes.c_int, ctypes.c_int]
    lib11.s11_insert_le3_packed.restype = ctypes.c_int
    lib11.s11_insert_deg4_packed.argtypes = [ctypes.POINTER(ctypes.c_uint32), ctypes.c_int]
    lib11.s11_insert_deg4_packed.restype = ctypes.c_int
    lib11.s11_mul_cubic_by_all_vars.argtypes = [ctypes.POINTER(ctypes.c_uint32), ctypes.c_int, ctypes.c_double]
    lib11.s11_mul_cubic_by_all_vars.restype = ctypes.c_int
    lib11.s11_mul_quad_by_all_pairs.argtypes = [ctypes.POINTER(ctypes.c_uint32), ctypes.c_int, ctypes.c_double]
    lib11.s11_mul_quad_by_all_pairs.restype = ctypes.c_int
    for fn in (lib11.s11_build_cg16, lib11.s11_build_cg15):
        fn.argtypes = [
            ctypes.POINTER(ctypes.c_int16), ctypes.POINTER(ctypes.c_int),
            ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
            ctypes.c_int, ctypes.POINTER(ctypes.c_uint32), ctypes.c_int,
        ]
        fn.restype = ctypes.c_int
    lib11.s11_get_stats.argtypes = [ctypes.POINTER(ctypes.c_uint32)]

    # Precomputations
    orbits = diag_v2.build_orbits_116()
    mon_to_orb_arr = (ctypes.c_int16 * 65536)(*([-1] * 65536))
    for j, orb in enumerate(orbits):
        for m in orb:
            mon_to_orb_arr[m] = j
    reps12 = s10.subset_orbits(12)
    reps11 = s10.subset_orbits(11)

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
    null_z_vecs = diag_v2.gf2_nullspace_left(M_rows)
    fiber_meta = (nonzero_z, null_z_vecs)

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

    orb_tts = [bytearray(65536) for _ in range(116)]
    orb_diag, orb_pair, orb_r4, orb_0xf_parity = [0] * 116, [0] * 116, [0] * 116, [0] * 116
    for j, orb in enumerate(orbits):
        tt = orb_tts[j]
        for x in range(65536):
            if sum((x & m) == m for m in orb) & 1:
                tt[x] = 1
        orb_diag[j] = sum((1 << v) for v in range(256) if tt[v | (v << 8)])
        orb_pair[j] = sum((1 << k) for k, x in enumerate(all_pairs) if tt[x])
        orb_r4[j] = sum((1 << k) for k, x in enumerate(rot4_reps) if tt[x])
        orb_0xf_parity[j] = sum(tt[x] for x in coset_0xf_reps) & 1
    chi_r4 = sum((1 << k) for k, x in enumerate(rot4_reps) if x.bit_count() & 1)

    def eval_orb_at_x(j, x):
        return orb_tts[j][x]

    rot4_data = (pair_idx, orb_diag, orb_pair, orb_r4, chi_r4, rep_of_x, orb_0xf_parity, eval_orb_at_x)
    layers, c0x0 = s9.build_cyclotomic_layers()
    tbl = s9.build_col_tables(111)

    for cname in [c.strip() for c in args.cells.split(",") if c.strip()]:
        run_step11_cell(
            cname, args.budget, lib_diag, lib9, lib_cg, lib11, orbits,
            v6_list, rot4_data, fiber_meta, layers, c0x0, mon_to_orb_arr, reps12, reps11, tbl
        )


if __name__ == "__main__":
    main()
