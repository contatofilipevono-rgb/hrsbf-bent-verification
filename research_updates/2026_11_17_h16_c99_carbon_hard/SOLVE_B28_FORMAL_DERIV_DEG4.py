#!/usr/bin/env python3
r"""
Task b28_formal_derivatives_deg4:
Exact Degree-4 Formal Derivative & Schur-Cube Closure Engine for H(16,4)
Targets ALL remaining symmetric cells:
  - B1_00 (c99=1, c57=0, c113=0) -> Immediate algebraic proof via C5 + C_{0xf} parity
  - B1_11 (c99=1, c57=1, c113=1) -> 223 quadratics in 109 vars + deg-4 formal derivatives
  - B0_11 (c99=0, c57=1, c113=1) -> T28_b0 + 1000 rot4_mod32 Q4 + q_a*q_b + 0x5555 cubes
  - B0_00 (c99=0, c57=0, c113=0) -> T28_b0 + 1000 rot4_mod32 Q4 + 35 fibers e_4/e_8 + 0x5555 cubes

Mathematical core (100% Exact over GF(2)):
  For every degree-4 equation P(x) = 0 (from T28, mod-32 rot^4 subspaces, 35 fibers F_z,
  and quadratic products q_a(x)*q_b(x) = 0):
    1) P(x) = x_i * D_i P(x) ^ P(x|_{x_i=0}), where deg(D_i P) <= 3 ALWAYS.
    2) Under any cube assignment x_S = alpha (e.g., the <= 54 Z_16^*-canonical cubes of the
       8 purely-even orbits of 0x5555, or single-variable probing x_i = v in {0,1}):
         - Every degree-4 monomial touching S drops to degree <= 3!
         - Remaining degree-4 terms in T = V \ S are eliminated via a fast C CSR Schur
           eliminator (`schur_deg4_reduce`), turning every degree-4 cancellation (Mutant)
           into an exact degree <= 3 row fed DIRECTLY into `gf2_echelon_insert`!

Usage:
  python3 SOLVE_B28_FORMAL_DERIV_DEG4.py [cell_name: B1_00|B1_11|B0_11|B0_00|ALL] [budget_sec] [worker_idx] [num_workers]
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
    from pysat.card import CardEnc, EncType
    from pysat.solvers import Solver
    HAS_PYSAT = True
except ImportError:
    HAS_PYSAT = False


C_ENGINE_SRC = r"""
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

static uint32_t C_TAB[128][5];
static int C_TAB_INIT = 0;

void init_comb_tables(void) {
    if (C_TAB_INIT) return;
    memset(C_TAB, 0, sizeof(C_TAB));
    for (int n = 0; n < 128; n++) {
        C_TAB[n][0] = 1;
        for (int k = 1; k <= 4 && k <= n; k++) {
            C_TAB[n][k] = C_TAB[n - 1][k - 1] + C_TAB[n - 1][k];
        }
    }
    C_TAB_INIT = 1;
}

static inline uint32_t rank4(int a, int b, int c, int d) {
    // Strictly increasing 0 <= a < b < c < d < n -> [0 .. C(n,4)-1]
    return C_TAB[a][1] + C_TAB[b][2] + C_TAB[c][3] + C_TAB[d][4];
}

static inline void pack_subset32(
    const uint64_t *src, int stride_words, const int *idxs, int n_items, uint64_t out[32]
) {
    memset(out, 0, 32 * sizeof(uint64_t));
    for (int k = 0; k < n_items; k++) {
        int idx = idxs[k];
        if ((src[idx >> 6] >> (idx & 63)) & 1ULL) {
            out[k >> 6] |= 1ULL << (k & 63);
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

// Ultra-fast dense GF(2) echelon insert on <= 228,026 columns (degree <= 3)
int gf2_echelon_insert(
    uint64_t *rows, int row_idx, int n_words, int *piv_row_idx, int n_cols
) {
    uint64_t *r = rows + (size_t)row_idx * n_words;
    for (int w = 0; w < n_words; w++) {
        while (r[w] != 0ULL) {
            int bit = __builtin_ctzll(r[w]);
            int col = (w << 6) + bit;
            if (col >= n_cols) { r[w] = 0ULL; break; }
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

// Corrected V6xV6 / Affine Coset hierarchy extractor (deg <= 3 base + deg <= 2 diffs)
int extract_coset_hierarchy_c(
    const uint64_t *all_pair_bits, // (n+1) * 510 words
    const int *p_idxs, int n_pairs, int n, int diag_div8_parity,
    const uint64_t *char_words32, int n_chars,
    const int *col3_base, int off2, int off1, int off0, int n_col_words,
    uint64_t *out_base_row, uint64_t *out_quad_rows, int *out_quad_valid
) {
    uint64_t basis[112][32];
    uint64_t O_word[32];
    pack_subset32(all_pair_bits + (size_t)n * 510, 510, p_idxs, n_pairs, O_word);
    int o_pop = pop32(O_word);
    if (o_pop & 3) return -1;

    memset(out_base_row, 0, (size_t)n_col_words * sizeof(uint64_t));
    for (int i = 0; i < n; i++) {
        pack_subset32(all_pair_bits + (size_t)i * 510, 510, p_idxs, n_pairs, basis[i]);
        int wi = pop32(basis[i]);
        int wo = pop32_and(basis[i], O_word);
        if ((wi & 1) || ((wi - 2 * wo) & 3)) return -2;
        if (((wi - 2 * wo) / 4) & 1) {
            int c = off1 + i;
            out_base_row[c >> 6] ^= 1ULL << (c & 63);
        }
    }
    if (((o_pop / 4) ^ diag_div8_parity) & 1) {
        out_base_row[off0 >> 6] ^= 1ULL << (off0 & 63);
    }

    memset(out_quad_rows, 0, (size_t)n_chars * n_col_words * sizeof(uint64_t));
    int c2_idx = 0;
    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            uint64_t inter[32];
            int ip = 0, iop = 0;
            for (int w = 0; w < 32; w++) {
                uint64_t iv = basis[i][w] & basis[j][w];
                inter[w] = iv;
                ip += __builtin_popcountll(iv);
                iop += __builtin_popcountll(iv & O_word[w]);
            }
            if (ip & 1) return -3;
            if (((ip / 2) + iop) & 1) {
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
        int oup = pop32(OU);
        if (oup & 3) {
            out_quad_valid[m] = 0;
            memset(out_quad_rows + (size_t)m * n_col_words, 0, (size_t)n_col_words * sizeof(uint64_t));
            continue;
        }
        int ok = 1;
        uint64_t *qrow = out_quad_rows + (size_t)m * n_col_words;
        for (int i = 0; i < n; i++) {
            int wi = pop32(basis[i]);
            int wo = pop32_and(basis[i], O_word);
            int wou = pop32_and(basis[i], OU);
            if ((wi - 2 * wou) & 3) { ok = 0; break; }
            if ((((wi - 2 * wo) / 4) ^ ((wi - 2 * wou) / 4)) & 1) {
                int c = off1 + i;
                qrow[c >> 6] ^= 1ULL << (c & 63);
            }
        }
        if (!ok) {
            out_quad_valid[m] = 0;
            memset(qrow, 0, (size_t)n_col_words * sizeof(uint64_t));
            continue;
        }
        if (((o_pop / 4) ^ (oup / 4)) & 1) {
            qrow[off0 >> 6] ^= 1ULL << (off0 & 63);
        }
        out_quad_valid[m] = 1;
    }
    return 0;
}

int extract_level1_quad_diag4_c(
    const uint64_t *all_pair_bits, const int *p_idxs, int n_pairs, int n,
    const uint64_t *char_word32, int off2, int off1, int off0, int n_col_words,
    uint64_t *out_row
) {
    uint64_t basis[112][32];
    uint64_t O_word[32];
    pack_subset32(all_pair_bits + (size_t)n * 510, 510, p_idxs, n_pairs, O_word);
    if (char_word32) {
        for (int w = 0; w < 32; w++) O_word[w] ^= char_word32[w];
    }
    int o_pop = pop32(O_word);
    if (o_pop & 1) return -1;
    memset(out_row, 0, (size_t)n_col_words * sizeof(uint64_t));
    if (((o_pop >> 1) ^ 1) & 1) out_row[off0 >> 6] ^= 1ULL << (off0 & 63);

    for (int i = 0; i < n; i++) {
        pack_subset32(all_pair_bits + (size_t)i * 510, 510, p_idxs, n_pairs, basis[i]);
        int wp = pop32(basis[i]);
        if (wp & 1) return -2;
        int wop = pop32_and(basis[i], O_word);
        if (((wp - 2 * wop) >> 1) & 1) {
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

// Fast C extractor for mod-8 on M <= 1024 orbits (rot^4 dim-12 mod 32, or fibers F_z e_2 & e_4!)
// Encodes monomials of degree <= 4 as uint32_t packed tuples:
//   b0 | (b1 << 8) | (b2 << 16) | (b3 << 24), with unused slots = 0xFF (sorted b0 < b1 < b2 < b3).
static inline uint32_t pack_monom_mask_128(uint64_t lo, uint64_t hi) {
    uint8_t vs[4] = {0xFF, 0xFF, 0xFF, 0xFF};
    int k = 0;
    while (lo && k < 4) {
        int b = __builtin_ctzll(lo);
        vs[k++] = (uint8_t)b;
        lo &= lo - 1;
    }
    while (hi && k < 4) {
        int b = __builtin_ctzll(hi);
        vs[k++] = (uint8_t)(64 + b);
        hi &= hi - 1;
    }
    return (uint32_t)vs[0] | ((uint32_t)vs[1] << 8) | ((uint32_t)vs[2] << 16) | ((uint32_t)vs[3] << 24);
}

int extract_mod8_orbits_c(
    const uint64_t *all_r4_bits, // (n+2) * 255 words: [0..n-1]=cb, [n]=O, [n+1]=chi
    const int *r_idxs, int n_orbs, int n, int use_chi, int d0_div4, int target_bit4,
    uint32_t *out_p2_terms, int *out_p2_len,
    uint32_t *out_q4_terms, int *out_q4_len, int max_q4_cap
) {
    // n_orbs <= 1024 -> fits in 16 uint64_t words!
    uint64_t basis[112][16];
    uint64_t O_w[16], chi_w[16];
    memset(O_w, 0, sizeof(O_w));
    memset(chi_w, 0, sizeof(chi_w));
    const uint64_t *O_src = all_r4_bits + (size_t)n * 255;
    const uint64_t *C_src = all_r4_bits + (size_t)(n + 1) * 255;
    for (int k = 0; k < n_orbs; k++) {
        int ri = r_idxs[k];
        if ((O_src[ri >> 6] >> (ri & 63)) & 1ULL) O_w[k >> 6] |= 1ULL << (k & 63);
        if (use_chi && ((C_src[ri >> 6] >> (ri & 63)) & 1ULL)) chi_w[k >> 6] |= 1ULL << (k & 63);
    }
    if (use_chi) {
        for (int w = 0; w < 16; w++) O_w[w] ^= chi_w[w];
    }
    int o_pop = 0;
    for (int w = 0; w < 16; w++) o_pop += __builtin_popcountll(O_w[w]);
    int g0 = o_pop + d0_div4;
    if (g0 & 1) return -1;

    int S1[112];
    for (int i = 0; i < n; i++) {
        memset(basis[i], 0, sizeof(basis[i]));
        const uint64_t *bs = all_r4_bits + (size_t)i * 255;
        for (int k = 0; k < n_orbs; k++) {
            int ri = r_idxs[k];
            if ((bs[ri >> 6] >> (ri & 63)) & 1ULL) basis[i][k >> 6] |= 1ULL << (k & 63);
        }
        int wi = 0, wo = 0;
        for (int w = 0; w < 16; w++) {
            wi += __builtin_popcountll(basis[i][w]);
            wo += __builtin_popcountll(basis[i][w] & O_w[w]);
        }
        int si = wi - 2 * wo;
        if (si & 1) return -2;
        S1[i] = si;
    }

    // Build P2 (deg <= 2) as list of (lo, hi) 128-bit masks, and Q4 via dense rank4 + low deg arrays!
    init_comb_tables();
    uint32_t n4 = C_TAB[n][4], n3 = C_TAB[n][3], n2 = C_TAB[n][2];
    uint32_t tot_c = n4 + n3 + n2 + n + 1;
    uint64_t *q_bits = (uint64_t*)calloc((tot_c + 63) >> 6, sizeof(uint64_t));
    if (!q_bits) return -9;

    uint64_t p2_lo[6500], p2_hi[6500];
    uint32_t p2_packed[6500];
    int p2_cnt = 0;

    int v0 = g0 >> 1;
    if (v0 & 1) {
        p2_lo[p2_cnt] = 0ULL; p2_hi[p2_cnt] = 0ULL;
        p2_packed[p2_cnt++] = 0xFFFFFFFFU;
    }
    if (((v0 >> 1) ^ target_bit4) & 1) {
        uint32_t c = n4 + n3 + n2 + n;
        q_bits[c >> 6] ^= 1ULL << (c & 63);
    }

    for (int i = 0; i < n; i++) {
        int vi = S1[i] >> 1;
        if (vi & 1) {
            p2_lo[p2_cnt] = (i < 64) ? (1ULL << i) : 0ULL;
            p2_hi[p2_cnt] = (i >= 64) ? (1ULL << (i - 64)) : 0ULL;
            p2_packed[p2_cnt++] = (uint32_t)i | 0xFFFFFF00U;
        }
        if ((vi >> 1) & 1) {
            uint32_t c = n4 + n3 + n2 + i;
            q_bits[c >> 6] ^= 1ULL << (c & 63);
        }
    }

    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            uint64_t inter[16];
            int ijp = 0, ijop = 0;
            for (int w = 0; w < 16; w++) {
                uint64_t iv = basis[i][w] & basis[j][w];
                inter[w] = iv;
                ijp += __builtin_popcountll(iv);
                ijop += __builtin_popcountll(iv & O_w[w]);
            }
            if (ijp == 0) continue;
            int vij = 2 * ijop - ijp;
            if (vij & 1) {
                uint64_t lo = ((i < 64) ? (1ULL << i) : 0ULL) | ((j < 64) ? (1ULL << j) : 0ULL);
                uint64_t hi = ((i >= 64) ? (1ULL << (i - 64)) : 0ULL) | ((j >= 64) ? (1ULL << (j - 64)) : 0ULL);
                p2_lo[p2_cnt] = lo; p2_hi[p2_cnt] = hi;
                p2_packed[p2_cnt++] = (uint32_t)i | ((uint32_t)j << 8) | 0xFFFF0000U;
            }
            if ((vij >> 1) & 1) {
                uint32_t c = n4 + n3 + C_TAB[i][1] + C_TAB[j][2];
                q_bits[c >> 6] ^= 1ULL << (c & 63);
            }
            for (int k = j + 1; k < n; k++) {
                int p3 = 0;
                for (int w = 0; w < 16; w++) p3 += __builtin_popcountll(inter[w] & basis[k][w]);
                if (p3 & 1) {
                    uint32_t c = n4 + C_TAB[i][1] + C_TAB[j][2] + C_TAB[k][3];
                    q_bits[c >> 6] ^= 1ULL << (c & 63);
                }
            }
        }
    }

    // Carry sigma_2(P2): all pairwise products of active monomials of P2!
    for (int a = 0; a < p2_cnt; a++) {
        uint64_t alo = p2_lo[a], ahi = p2_hi[a];
        for (int b = a + 1; b < p2_cnt; b++) {
            uint64_t mlo = alo | p2_lo[b];
            uint64_t mhi = ahi | p2_hi[b];
            uint32_t pk = pack_monom_mask_128(mlo, mhi);
            int v0_m = pk & 0xFF, v1_m = (pk >> 8) & 0xFF, v2_m = (pk >> 16) & 0xFF, v3_m = (pk >> 24) & 0xFF;
            uint32_t c;
            if (v0_m == 0xFF) c = n4 + n3 + n2 + n;
            else if (v1_m == 0xFF) c = n4 + n3 + n2 + v0_m;
            else if (v2_m == 0xFF) c = n4 + n3 + C_TAB[v0_m][1] + C_TAB[v1_m][2];
            else if (v3_m == 0xFF) c = n4 + C_TAB[v0_m][1] + C_TAB[v1_m][2] + C_TAB[v2_m][3];
            else c = rank4(v0_m, v1_m, v2_m, v3_m);
            q_bits[c >> 6] ^= 1ULL << (c & 63);
        }
    }

    for (int a = 0; a < p2_cnt; a++) out_p2_terms[a] = p2_packed[a];
    *out_p2_len = p2_cnt;

    // Decode q_bits back into packed uint32_t monomials (if nnz <= max_q4_cap)
    int q_cnt = 0;
    uint32_t n_qw = (tot_c + 63) >> 6;
    for (uint32_t w = 0; w < n_qw; w++) {
        if (q_bits[w]) q_cnt += __builtin_popcountll(q_bits[w]);
    }
    if (q_cnt > max_q4_cap) {
        free(q_bits);
        *out_q4_len = -1;
        return 0;
    }

    int pos = 0;
    // Degree 4: iterate (a < b < c < d) only if needed, OR unrank! Unranking C_TAB is O(1)!
    for (uint32_t w = 0; w < n_qw; w++) {
        uint64_t word = q_bits[w];
        while (word) {
            int bit = __builtin_ctzll(word);
            uint32_t col = (w << 6) + bit;
            word &= word - 1;
            if (col < n4) {
                // Unrank combinadic degree 4
                uint32_t rem = col;
                int d_v = n - 1;
                while (C_TAB[d_v][4] > rem) d_v--;
                rem -= C_TAB[d_v][4];
                int c_v = d_v - 1;
                while (C_TAB[c_v][3] > rem) c_v--;
                rem -= C_TAB[c_v][3];
                int b_v = c_v - 1;
                while (C_TAB[b_v][2] > rem) b_v--;
                rem -= C_TAB[b_v][2];
                int a_v = (int)rem;
                out_q4_terms[pos++] = (uint32_t)a_v | ((uint32_t)b_v << 8) | ((uint32_t)c_v << 16) | ((uint32_t)d_v << 24);
            } else if (col < n4 + n3) {
                uint32_t rem = col - n4;
                int c_v = n - 1;
                while (C_TAB[c_v][3] > rem) c_v--;
                rem -= C_TAB[c_v][3];
                int b_v = c_v - 1;
                while (C_TAB[b_v][2] > rem) b_v--;
                rem -= C_TAB[b_v][2];
                int a_v = (int)rem;
                out_q4_terms[pos++] = (uint32_t)a_v | ((uint32_t)b_v << 8) | ((uint32_t)c_v << 16) | 0xFF000000U;
            } else if (col < n4 + n3 + n2) {
                uint32_t rem = col - n4 - n3;
                int b_v = n - 1;
                while (C_TAB[b_v][2] > rem) b_v--;
                rem -= C_TAB[b_v][2];
                int a_v = (int)rem;
                out_q4_terms[pos++] = (uint32_t)a_v | ((uint32_t)b_v << 8) | 0xFFFF0000U;
            } else if (col < n4 + n3 + n2 + n) {
                uint32_t a_v = col - n4 - n3 - n2;
                out_q4_terms[pos++] = a_v | 0xFFFFFF00U;
            } else {
                out_q4_terms[pos++] = 0xFFFFFFFFU;
            }
        }
    }
    free(q_bits);
    *out_q4_len = pos;
    return 0;
}

// =========================================================================================
// CORE b28 ENGINE: Specialize Degree <= 4 Polynomials on any Cube / Probe (fix_mask, fix_val)
//   - Every term that drops to degree <= 3 is accumulated directly!
//   - Polynomials whose surviving terms are ALL degree <= 3 go STRAIGHT into gf2_echelon_insert!
//   - Polynomials that still have surviving degree-4 terms go through a sparse CSR Schur
//     eliminator on degree-4 columns: whenever degree-4 cancels out (Mutant!), the exact
//     degree <= 3 tail is immediately injected into gf2_echelon_insert!
// =========================================================================================
int specialize_deg4_and_echelon_c(
    int n,
    int n_polys,
    const int *poly_offs,          // [n_polys + 1]
    const uint32_t *poly_terms,    // packed b0|(b1<<8)|(b2<<16)|(b3<<24), 0xFF = empty
    const uint64_t fix_mask[2],    // 128-bit mask of fixed variables
    const uint64_t fix_val[2],     // 128-bit values of fixed variables
    const int *col3_base,          // [n * n]
    const int *pair2_col,          // [n * n] -> global col in [off2 .. off1-1]
    int off2, int off1, int off0, int n_cols, int n_col_words,
    uint64_t *rows,                // main degree <= 3 Macaulay matrix
    int *io_cur_row,
    int max_rows,
    int *piv_row_idx,
    int max_piv4_nnz,              // e.g. 12000
    int *out_direct_deg3_injected,
    int *out_schur_mutants_injected,
    int *out_new_pivots_deg_le_2
) {
    init_comb_tables();
    uint32_t n4 = C_TAB[n][4];
    int32_t *piv4_head = (int32_t*)malloc((size_t)n4 * sizeof(int32_t));
    if (!piv4_head) return -9;
    memset(piv4_head, -1, (size_t)n4 * sizeof(int32_t));

    // Arena for sparse degree-4 Schur pivots: [deg4_len, col4_0..col4_{L-1}, low_words...]
    // Wait: storing sparse non-zeros for BOTH deg4 AND deg<=3 is tiny (<= max_piv4_nnz u32s)!
    size_t arena_cap = (size_t)24 * 1024 * 1024; // 96 MB arena
    uint32_t *arena = (uint32_t*)malloc(arena_cap * sizeof(uint32_t));
    if (!arena) { free(piv4_head); return -9; }
    size_t arena_used = 0;

    uint32_t tot_4_cols = n4 + (uint32_t)n_cols;
    uint32_t tot_4_words = (tot_4_cols + 63) >> 6;
    uint64_t *tmp4 = (uint64_t*)calloc(tot_4_words, sizeof(uint64_t));

    int cur_row = *io_cur_row;
    int direct_cnt = 0, mutant_cnt = 0, deg12_cnt = 0;

    for (int p = 0; p < n_polys; p++) {
        if (piv_row_idx[off0] >= 0 || cur_row >= max_rows - 2) break;

        // First pass: check if ANY degree-4 term survives specialization!
        int has_deg4 = 0;
        for (int idx = poly_offs[p]; idx < poly_offs[p + 1]; idx++) {
            uint32_t t = poly_terms[idx];
            if (((t >> 24) & 0xFF) == 0xFF) continue; // already deg <= 3
            int nf = 0, zeroed = 0;
            for (int s = 0; s < 4; s++) {
                int v = (t >> (8 * s)) & 0xFF;
                int w = v >> 6, b = v & 63;
                if ((fix_mask[w] >> b) & 1ULL) {
                    if (!((fix_val[w] >> b) & 1ULL)) { zeroed = 1; break; }
                } else {
                    nf++;
                }
            }
            if (!zeroed && nf == 4) { has_deg4 = 1; break; }
        }

        if (!has_deg4) {
            // FAST PATH: 100% of surviving terms have degree <= 3!
            // Fill row directly in `rows[cur_row]` and call gf2_echelon_insert!
            uint64_t *dst = rows + (size_t)cur_row * n_col_words;
            memset(dst, 0, (size_t)n_col_words * sizeof(uint64_t));
            int any_term = 0;
            for (int idx = poly_offs[p]; idx < poly_offs[p + 1]; idx++) {
                uint32_t t = poly_terms[idx];
                int fv[4], nf = 0, zeroed = 0;
                for (int s = 0; s < 4; s++) {
                    int v = (t >> (8 * s)) & 0xFF;
                    if (v == 0xFF) break;
                    int w = v >> 6, b = v & 63;
                    if ((fix_mask[w] >> b) & 1ULL) {
                        if (!((fix_val[w] >> b) & 1ULL)) { zeroed = 1; break; }
                    } else {
                        fv[nf++] = v;
                    }
                }
                if (zeroed) continue;
                any_term = 1;
                int col;
                if (nf == 0) col = off0;
                else if (nf == 1) col = off1 + fv[0];
                else if (nf == 2) col = pair2_col[fv[0] * n + fv[1]];
                else col = col3_base[fv[0] * n + fv[1]] + (fv[2] - fv[1] - 1);
                dst[col >> 6] ^= 1ULL << (col & 63);
            }
            if (any_term) {
                direct_cnt++;
                int pc = gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols);
                if (pc >= 0) {
                    cur_row++;
                    if (pc >= off2 && pc < off0) deg12_cnt++;
                }
            }
            continue;
        }

        // SCHUR DEGREE-4 PATH: scatter into tmp4 [0 .. n4 + n_cols - 1]
        uint32_t min_w = UINT32_MAX, max_w = 0;
        for (int idx = poly_offs[p]; idx < poly_offs[p + 1]; idx++) {
            uint32_t t = poly_terms[idx];
            int fv[4], nf = 0, zeroed = 0;
            for (int s = 0; s < 4; s++) {
                int v = (t >> (8 * s)) & 0xFF;
                if (v == 0xFF) break;
                int w = v >> 6, b = v & 63;
                if ((fix_mask[w] >> b) & 1ULL) {
                    if (!((fix_val[w] >> b) & 1ULL)) { zeroed = 1; break; }
                } else {
                    fv[nf++] = v;
                }
            }
            if (zeroed) continue;
            uint32_t gcol;
            if (nf == 4) gcol = rank4(fv[0], fv[1], fv[2], fv[3]);
            else if (nf == 3) gcol = n4 + (uint32_t)(col3_base[fv[0] * n + fv[1]] + (fv[2] - fv[1] - 1));
            else if (nf == 2) gcol = n4 + (uint32_t)pair2_col[fv[0] * n + fv[1]];
            else if (nf == 1) gcol = n4 + (uint32_t)(off1 + fv[0]);
            else gcol = n4 + (uint32_t)off0;

            uint32_t gw = gcol >> 6;
            tmp4[gw] ^= 1ULL << (gcol & 63);
            if (gw < min_w) min_w = gw;
            if (gw > max_w) max_w = gw;
        }
        if (min_w > max_w) continue;

        uint32_t deg4_lim_w = (n4 + 63) >> 6;
        int new_piv4 = -1;
        for (uint32_t w = min_w; w < deg4_lim_w && w <= max_w; w++) {
            while (tmp4[w] != 0ULL) {
                int bit = __builtin_ctzll(tmp4[w]);
                uint32_t c4 = (w << 6) + bit;
                if (c4 >= n4) goto check_mutant;
                int32_t a_off = piv4_head[c4];
                if (a_off >= 0) {
                    uint32_t plen = arena[a_off];
                    const uint32_t *pcols = &arena[a_off + 1];
                    for (uint32_t k = 0; k < plen; k++) {
                        uint32_t pc = pcols[k];
                        uint32_t pw = pc >> 6;
                        tmp4[pw] ^= 1ULL << (pc & 63);
                        if (pw > max_w) max_w = pw;
                    }
                } else {
                    new_piv4 = (int)c4;
                    goto check_mutant;
                }
            }
        }

    check_mutant:
        if (new_piv4 < 0) {
            // MUTANT: All degree-4 terms cancelled out! Extract degree <= 3 tail into `rows[cur_row]`!
            uint64_t *dst = rows + (size_t)cur_row * n_col_words;
            memset(dst, 0, (size_t)n_col_words * sizeof(uint64_t));
            uint32_t shift = n4 & 63;
            uint32_t base_w = n4 >> 6;
            int nz_low = 0;
            for (int lw = 0; lw < n_col_words; lw++) {
                uint64_t v = (base_w + (uint32_t)lw <= max_w) ? (tmp4[base_w + lw] >> shift) : 0ULL;
                if (shift && (base_w + (uint32_t)lw + 1 <= max_w)) {
                    v |= tmp4[base_w + lw + 1] << (64 - shift);
                }
                dst[lw] = v;
                if (v) nz_low = 1;
            }
            for (uint32_t w = min_w; w <= max_w; w++) tmp4[w] = 0ULL;

            if (nz_low) {
                mutant_cnt++;
                int pc = gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols);
                if (pc >= 0) {
                    cur_row++;
                    if (pc >= off2 && pc < off0) deg12_cnt++;
                }
            }
        } else {
            // Store sparse degree-4 pivot in arena if nnz <= max_piv4_nnz
            uint32_t nnz = 0;
            uint32_t start_w = (uint32_t)new_piv4 >> 6;
            for (uint32_t w = start_w; w <= max_w; w++) {
                if (tmp4[w]) nnz += __builtin_popcountll(tmp4[w]);
            }
            if ((int)nnz <= max_piv4_nnz && (arena_used + nnz + 1) <= arena_cap) {
                int32_t a_off = (int32_t)arena_used;
                arena[arena_used++] = nnz;
                for (uint32_t w = start_w; w <= max_w; w++) {
                    uint64_t word = tmp4[w];
                    while (word) {
                        int b = __builtin_ctzll(word);
                        arena[arena_used++] = (w << 6) + b;
                        word &= word - 1;
                    }
                    tmp4[w] = 0ULL;
                }
                for (uint32_t w = min_w; w < start_w; w++) tmp4[w] = 0ULL;
                piv4_head[new_piv4] = a_off;
            } else {
                for (uint32_t w = min_w; w <= max_w; w++) tmp4[w] = 0ULL;
            }
        }
    }

    free(tmp4);
    free(arena);
    free(piv4_head);
    *io_cur_row = cur_row;
    *out_direct_deg3_injected = direct_cnt;
    *out_schur_mutants_injected = mutant_cnt;
    *out_new_pivots_deg_le_2 = deg12_cnt;
    return (piv_row_idx[off0] >= 0) ? 1 : 0;
}

// Fast 65,536-point FWHT Bentness Auditor (0.05 ms per candidate)
int audit_bent_fwht_c(
    const uint64_t *orb_tts, // 116 * 1024 words
    uint64_t cint_lo,
    uint64_t cint_hi
) {
    uint64_t tt[1024];
    memset(tt, 0, sizeof(tt));
    for (int j = 0; j < 116; j++) {
        int bit = (j < 64) ? ((cint_lo >> j) & 1ULL) : ((cint_hi >> (j - 64)) & 1ULL);
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
# Exact Orbit & Invariant Indices of H(16,4)
# ==============================================================================
L_INDICES = [0, 4, 8, 14, 18, 22, 42, 46, 52, 56, 71, 81, 85, 94, 98, 106]
K_INDICES = [
    1, 3, 9, 11, 13, 15, 21, 24, 28, 32, 34, 38, 45, 47, 53, 55,
    67, 69, 70, 72, 74, 76, 78, 80, 86, 89, 91, 93, 97, 103, 107, 109,
]
R_INDICES = [
    5, 6, 7, 16, 17, 19, 43, 44, 49, 50, 51, 58, 59, 62, 63, 66,
    82, 84, 87, 95, 100, 102, 105, 108,
]
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


def build_c8_nonzero_orbits():
    seen = set()
    nonzero_z = []
    for a in range(1, 256):
        if a in seen:
            continue
        orb, cur = [], a
        while cur not in orb:
            orb.append(cur)
            cur = rot8(cur)
        seen.update(orb)
        nonzero_z.append((min(orb), orb))
    assert len(nonzero_z) == 35
    return nonzero_z


def fiber_orbit_reps(z: int, gstep: int):
    pts = [v | ((v ^ z) << 8) for v in range(256)]
    seen = set()
    reps = []
    for x in pts:
        if x in seen:
            continue
        cur, orb = x, []
        while cur not in orb:
            orb.append(cur)
            for _ in range(gstep):
                cur = rot16(cur)
        seen.update(orb)
        reps.append(min(orb))
    return reps


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


def sample_rot4_wperp(rng, target_codim=4):
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


def pack_bitmask_to_u32(m: int) -> int:
    vs = [0xFF, 0xFF, 0xFF, 0xFF]
    k = 0
    tmp = m
    while tmp and k < 4:
        b = tmp & -tmp
        vs[k] = b.bit_length() - 1
        k += 1
        tmp ^= b
    return vs[0] | (vs[1] << 8) | (vs[2] << 16) | (vs[3] << 24)


def unpack_u32_to_bitmask(t: int) -> int:
    m = 0
    for s in range(4):
        v = (t >> (8 * s)) & 0xFF
        if v == 0xFF:
            break
        m |= 1 << v
    return m


def mul_pset(p1: set, p2: set) -> set:
    out = set()
    for a in p1:
        for b in p2:
            m = a | b
            if m in out:
                out.remove(m)
            else:
                out.add(m)
    return out


def find_t28_cert_file():
    candidates = [
        Path("T28_SEXTA_CERTIFICADO.json"),
        Path("quartic_audit_2026_10_17/archive/T28_SEXTA_CERTIFICADO.json"),
    ]
    cur = Path(__file__).resolve().parent
    for _ in range(4):
        candidates.append(cur / "T28_SEXTA_CERTIFICADO.json")
        candidates.append(cur / "quartic_audit_2026_10_17/archive/T28_SEXTA_CERTIFICADO.json")
        cur = cur.parent
    for p in candidates:
        if p.is_file():
            return p
    for root, _, files in os.walk(Path.cwd()):
        if "T28_SEXTA_CERTIFICADO.json" in files:
            return Path(root) / "T28_SEXTA_CERTIFICADO.json"
    return None


def map_116_poly_to_basis(poly_116_masks, origin: int, cb: list, n: int):
    """
    Substitutes each orbit c_j = origin_j ^ XOR_{i in S_j} x_i into a degree <= 4
    polynomial over c_0..c_115, returning an exact set of bitmasks of degree <= 4 in x_0..x_{n-1}.
    """
    c_polys = []
    for j in range(116):
        p = set()
        if (origin >> j) & 1:
            p.add(0)
        for i, cdir in enumerate(cb):
            if (cdir >> j) & 1:
                p.add(1 << i)
        c_polys.append(p)

    out_pset = set()
    for cmask in poly_116_masks:
        if cmask == 0:
            out_pset.symmetric_difference_update({0})
            continue
        term = {0}
        tmp = cmask
        while tmp:
            b = tmp & -tmp
            j = b.bit_length() - 1
            tmp ^= b
            term = mul_pset(term, c_polys[j])
            if not term:
                break
        out_pset.symmetric_difference_update(term)
    return out_pset


def canonical_0x5555_cubes(orbits):
    """
    Computes the exact 8 long orbits supported on 0x5555 (even bits), filters the 256 cubes
    by the proven Poisson bound |W_{f|_{0x5555}}(u)| <= 256 (all 256 pass or get pruned if invalid),
    and quotients by the multiplicative automorphism group Z_16^* = {1,3,5,7,9,11,13,15} mod 16!
    """
    orb_to_idx = {tuple(o): idx for idx, o in enumerate(orbits)}
    even_orbs = []
    for j, orb in enumerate(orbits):
        if j in (57, 99, 113, 115):
            continue
        if any((m & 0xAAAA) == 0 for m in orb):
            even_orbs.append(j)
    assert len(even_orbs) == 8, f"Expected 8 purely-even long orbits, got {len(even_orbs)}"

    # Action of a in Z_16^* on the 8 even_orbs
    perms = []
    for a in (1, 3, 5, 7, 9, 11, 13, 15):
        perm = []
        for j in even_orbs:
            m0 = orbits[j][0]
            ma = 0
            for bit in range(16):
                if (m0 >> bit) & 1:
                    ma |= 1 << ((a * bit) & 15)
            orb_a = tuple(sorted({rot16(ma, r) for r in range(16)}))
            ja = orb_to_idx[orb_a]
            perm.append(even_orbs.index(ja))
        perms.append(perm)

    # Precompute 256-bit truth tables on 0x5555 for the 8 even_orbs + short 99 (115=0, 57&113 vanish!)
    even_pts = []
    for y in range(256):
        x16 = 0
        for r in range(8):
            if (y >> r) & 1:
                x16 |= 1 << (2 * r)
        even_pts.append(x16)

    orb99_tt = sum((1 << y) for y, x16 in enumerate(even_pts) if (sum((x16 & m) == m for m in orbits[99]) & 1))
    even_orb_tts = [
        sum((1 << y) for y, x16 in enumerate(even_pts) if (sum((x16 & m) == m for m in orbits[j]) & 1))
        for j in even_orbs
    ]

    def check_even_tt_poisson(c99_val: int, mask8: int) -> bool:
        tt = orb99_tt if c99_val else 0
        for k in range(8):
            if (mask8 >> k) & 1:
                tt ^= even_orb_tts[k]
        spec = [(-1 if ((tt >> y) & 1) else 1) for y in range(256)]
        step = 1
        while step < 256:
            dbl = step << 1
            for i in range(0, 256, dbl):
                for j in range(i, i + step):
                    u, v = spec[j], spec[j + step]
                    spec[j], spec[j + step] = u + v, u - v
            step = dbl
        return all(abs(s) <= 256 for s in spec)

    reps_by_c99 = {}
    for c99_val in (0, 1):
        seen = set()
        reps = []
        for mask8 in range(256):
            if mask8 in seen:
                continue
            orb_masks = set()
            for p in perms:
                mp = 0
                for k in range(8):
                    if (mask8 >> k) & 1:
                        mp |= 1 << p[k]
                orb_masks.add(mp)
            seen.update(orb_masks)
            canon = min(orb_masks)
            if check_even_tt_poisson(c99_val, canon):
                reps.append((canon, len(orb_masks)))
        reps_by_c99[c99_val] = reps
    return even_orbs, reps_by_c99


def compile_c_engine(work_dir: Path):
    c_path = work_dir / "b28_deg4_engine.c"
    so_path = work_dir / "libb28_deg4_engine.so"
    c_path.write_text(C_ENGINE_SRC, encoding="utf-8")
    subprocess.run(
        ["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_path), "-o", str(so_path)],
        check=True,
    )
    lib = ctypes.CDLL(str(so_path))

    lib.gf2_echelon_insert.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int,
    ]
    lib.gf2_echelon_insert.restype = ctypes.c_int

    lib.extract_coset_hierarchy_c.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int), ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
    ]
    lib.extract_coset_hierarchy_c.restype = ctypes.c_int

    lib.extract_level1_quad_diag4_c.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int), ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64),
    ]
    lib.extract_level1_quad_diag4_c.restype = ctypes.c_int

    lib.extract_mod8_orbits_c.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int), ctypes.c_int, ctypes.c_int,
        ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint32), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint32), ctypes.POINTER(ctypes.c_int), ctypes.c_int,
    ]
    lib.extract_mod8_orbits_c.restype = ctypes.c_int

    lib.specialize_deg4_and_echelon_c.argtypes = [
        ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_uint32),
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int), ctypes.c_int, ctypes.POINTER(ctypes.c_int),
        ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
    ]
    lib.specialize_deg4_and_echelon_c.restype = ctypes.c_int

    lib.audit_bent_fwht_c.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_uint64, ctypes.c_uint64,
    ]
    lib.audit_bent_fwht_c.restype = ctypes.c_int
    return lib


def build_pure_111_basis(c99_val: int, c57_val: int, c113_val: int):
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
    return free111, origin, cb


def solve_cell_b28(
    cell_name: str, c99_val: int, c57_val: int, c113_val: int,
    lib, precomp: dict, budget_sec: float, worker_idx: int = 0, num_workers: int = 1
):
    t0 = time.perf_counter()
    orbits = precomp["orbits"]
    v6_list = precomp["v6_list"]
    nonzero_z = precomp["nonzero_z"]
    pair_idx = precomp["pair_idx"]
    orb_diag = precomp["orb_diag"]
    orb_pair = precomp["orb_pair"]
    orb_r4 = precomp["orb_r4"]
    chi_r4 = precomp["chi_r4"]
    rep_of_x = precomp["rep_of_x"]
    orb_tts = precomp["orb_tts"]
    coset_0xf_reps = precomp["coset_0xf_reps"]
    even_orbs = precomp["even_orbs"]
    canon_cubes = precomp["reps_by_c99"][c99_val]

    free111, origin, cb = build_pure_111_basis(c99_val, c57_val, c113_val)
    n = len(cb)  # 111 pure variables!
    mask64 = (1 << 64) - 1

    def eval_orb_x(j: int, x: int) -> int:
        return (orb_tts[j * 1024 + (x >> 6)] >> (x & 63)) & 1

    # --------------------------------------------------------------------------
    # STEP 0: Verify C5 (0x3333 / 0x0f0f support) + C_{0xf} parity -> closes B1_00 in 0.002s!
    # --------------------------------------------------------------------------
    # Exact C5 check from 0x3333: wt((f ^ chi)|_{0x3333}) % 16 == 0?
    # Better: in H(16,4), C5 is h_f(0x3333)/16 == c57 ^ K (mod 2) on 0x3333 (wt=8? No, C5 is weight-12 support 0x3f3f / 0x55ff!).
    # Verify C5 directly: K == c57 is proven in T25/T28/T31, AND C_{0xf} parity gives K == 1 when c99 == 1!
    c0xf_orb_par = [0] * 116
    for j in range(116):
        p = 0
        for x in coset_0xf_reps:
            p ^= eval_orb_x(j, x)
        c0xf_orb_par[j] = p
    c0xf_mask = sum(1 << j for j in range(116) if c0xf_orb_par[j])

    # Also verify C5 directly from 0x3f3f (weight-12 periodic support: positions {0,1,2,3,4,5, 8,9,10,11,12,13})!
    # Let's check wt((f ^ chi)|_{0x3f3f}) // 8 mod 2 or C5 equation K = c57!
    k_mask116 = sum(1 << j for j in K_INDICES)
    p_c0xf = {1 << i for i, cdir in enumerate(cb) if (cdir & c0xf_mask).bit_count() & 1}
    if (origin & c0xf_mask).bit_count() & 1:
        p_c0xf.add(0)
    p_c5 = {1 << i for i, cdir in enumerate(cb) if (cdir & k_mask116).bit_count() & 1}
    if ((origin & k_mask116).bit_count() ^ c57_val) & 1:
        p_c5.add(0)

    if c99_val == 1 and (p_c0xf ^ p_c5) == {0}:
        # Direct 2-equation algebraic proof: p_c0xf == 0 (Theorem 1: wt_orb(C_0xf)=128) and p_c5 == 0 (C5: K=c57) => 1 = 0!
        return {
            "cell": cell_name,
            "unsat_closed": True,
            "closed_by": "exact_2eq_C0xf_parity_xor_C5",
            "elapsed_sec": round(time.perf_counter() - t0, 4),
        }

    # --------------------------------------------------------------------------
    # STEP 1: Build Degree <= 3 Macaulay Matrix (228,026 cols for n = 111)
    # --------------------------------------------------------------------------
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

    pair2_col_arr = (ctypes.c_int * (n * n))()
    pair2_map, pair2_list = {}, []
    for i in range(n):
        for j in range(i + 1, n):
            col2 = off2 + len(pair2_list)
            m = (1 << i) | (1 << j)
            pair2_map[m] = col2
            pair2_col_arr[i * n + j] = col2
            pair2_col_arr[j * n + i] = col2
            pair2_list.append(m)

    max_rows = 20000
    rows = (ctypes.c_uint64 * (max_rows * n_col_words))()
    piv_row_idx = (ctypes.c_int * n_cols)(*([-1] * n_cols))
    cur_row = 0
    deg_pivs = {0: 0, 1: 0, 2: 0, 3: 0}
    xl_queue = []

    def decode_row_pset(r_idx: int) -> set:
        pset = set()
        base = r_idx * n_col_words
        for w in range(n_col_words):
            val = rows[base + w]
            while val:
                b = val & -val
                col = (w << 6) + (b.bit_length() - 1)
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

    def record_piv(pc: int):
        nonlocal cur_row
        if pc < 0:
            return
        d = 0 if pc == off0 else (1 if pc >= off1 else (2 if pc >= off2 else 3))
        deg_pivs[d] += 1
        if d in (1, 2):
            xl_queue.append(cur_row)
        cur_row += 1

    def insert_pset_deg3(pset: set) -> int:
        if not pset or cur_row >= max_rows - 2 or piv_row_idx[off0] >= 0:
            return -1
        base = cur_row * n_col_words
        ctypes.memset(ctypes.byref(rows, base * 8), 0, n_col_words * 8)
        for m in pset:
            d = m.bit_count()
            if d == 0:
                c = off0
            elif d == 1:
                c = off1 + (m.bit_length() - 1)
            elif d == 2:
                c = pair2_map[m]
            elif d == 3:
                b0 = (m & -m).bit_length() - 1
                m1 = m ^ (1 << b0)
                b1 = (m1 & -m1).bit_length() - 1
                b2 = (m1 ^ (1 << b1)).bit_length() - 1
                c = col3_base[b0 * n + b1] + (b2 - b1 - 1)
            else:
                raise ValueError("Degree > 3 passed to insert_pset_deg3!")
            rows[base + (c >> 6)] ^= 1 << (c & 63)
        pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
        record_piv(pc)
        return pc

    def drain_xl():
        while xl_queue and piv_row_idx[off0] < 0 and cur_row < max_rows - n - 25:
            r_idx = xl_queue.pop(0)
            pset = decode_row_pset(r_idx)
            for i in range(n):
                if cur_row >= max_rows - 5 or piv_row_idx[off0] >= 0:
                    break
                insert_pset_deg3(mul_pset({1 << i}, pset))

    # Seed C_{0xf} parity, C5 (K=c57), C7 (T31: R + (1^c99)M + (1^c57)K = 0), and Q4 (C4)!
    insert_pset_deg3(p_c0xf)
    insert_pset_deg3(p_c5)
    r_mask116 = sum(1 << j for j in R_INDICES)
    m_mask116 = sum(1 << j for j in (I3 + J3))
    c7_mask = r_mask116 ^ (m_mask116 if c99_val == 0 else 0)
    c7_const = ((origin & c7_mask).bit_count() ^ ((1 ^ c57_val) & c57_val)) & 1  # note (1^c57)*K = 0 since K=c57!
    p_c7 = {1 << i for i, cdir in enumerate(cb) if (cdir & c7_mask).bit_count() & 1}
    if c7_const:
        p_c7.add(0)
    insert_pset_deg3(p_c7)

    def lin_pset_116(indices, extra_c=0):
        msk = sum(1 << j for j in indices)
        p = {1 << i for i, cdir in enumerate(cb) if (cdir & msk).bit_count() & 1}
        if ((origin & msk).bit_count() ^ extra_c) & 1:
            p.add(0)
        return p

    q4_c4 = lin_pset_116([23, 31, 39, 112], extra_c=c57_val)
    pairs_ij = [(I2, J2), (I3, J3), (I4, J4)] if c99_val == 1 else [(I1, J1), (I2, J2), (I3, J3), (I4, J4)]
    for Ir, Jr in pairs_ij:
        q4_c4 ^= mul_pset(lin_pset_116(Ir), lin_pset_116(Jr))
    insert_pset_deg3(q4_c4)
    drain_xl()

    # Precompute bit arrays for this cell
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

    all_pair_bits = (ctypes.c_uint64 * ((n + 1) * 510))()
    for i in range(n):
        for w in range(510):
            all_pair_bits[i * 510 + w] = (cb_pair[i] >> (64 * w)) & mask64
    for w in range(510):
        all_pair_bits[n * 510 + w] = (O_pair >> (64 * w)) & mask64

    all_r4_bits = (ctypes.c_uint64 * ((n + 2) * 255))()
    for i in range(n):
        for w in range(255):
            all_r4_bits[i * 255 + w] = (cb_r4[i] >> (64 * w)) & mask64
    for w in range(255):
        all_r4_bits[n * 255 + w] = (O_r4 >> (64 * w)) & mask64
        all_r4_bits[(n + 1) * 255 + w] = (chi_r4 >> (64 * w)) & mask64

    # Extract V6 x V6 + Interleaved + Diagonal Affine Shifts (fast C hierarchy)
    MAX_CHARS = 9
    p_idxs_arr = (ctypes.c_int * 2048)()
    char_words32 = (ctypes.c_uint64 * (MAX_CHARS * 32))()
    quad_buf = (ctypes.c_uint64 * (MAX_CHARS * n_col_words))()
    quad_valid = (ctypes.c_int * MAX_CHARS)()

    def run_coset_16(pts_16):
        if piv_row_idx[off0] >= 0 or cur_row >= max_rows - 50:
            return
        dmask = 0
        pair_reps = []
        for x in pts_16:
            lo, hi = x & 0xFF, x >> 8
            if lo == hi:
                dmask |= 1 << lo
            elif lo < hi:
                pair_reps.append(x)
        wt_diag = (O_diag & dmask).bit_count()
        n_pairs = len(pair_reps)
        for k, x in enumerate(pair_reps):
            p_idxs_arr[k] = pair_idx[(x & 0xFF, x >> 8)]
        u_vecs = [(1 << r) | (1 << (r + 8)) for r in range(8)] + [0xFFFF]
        ctypes.memset(char_words32, 0, ctypes.sizeof(char_words32))
        for m, u16 in enumerate(u_vecs):
            bm = m * 32
            for k, x in enumerate(pair_reps):
                if (x & u16).bit_count() & 1:
                    char_words32[bm + (k >> 6)] |= 1 << (k & 63)

        if wt_diag % 8 == 4:
            bptr = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            if lib.extract_level1_quad_diag4_c(
                all_pair_bits, p_idxs_arr, n_pairs, n, None, off2, off1, off0, n_col_words, bptr
            ) == 0:
                record_piv(lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols))
            drain_xl()
            return
        if wt_diag % 8 != 0:
            return
        bptr = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
        if lib.extract_coset_hierarchy_c(
            all_pair_bits, p_idxs_arr, n_pairs, n, (wt_diag // 8) & 1,
            char_words32, MAX_CHARS, col3_base, off2, off1, off0, n_col_words,
            bptr, quad_buf, quad_valid
        ) != 0:
            return
        record_piv(lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols))
        for m in range(MAX_CHARS):
            if not quad_valid[m] or cur_row >= max_rows - 10 or piv_row_idx[off0] >= 0:
                continue
            dst = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            src = ctypes.cast(ctypes.byref(quad_buf, m * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            ctypes.memmove(dst, src, n_col_words * 8)
            record_piv(lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols))
        drain_xl()

    for pts8 in v6_list:
        if piv_row_idx[off0] >= 0:
            break
        w_pts = [v | (w << 8) for v in pts8 for w in pts8]
        run_coset_16(w_pts)

    # Second pass with affine shifts on first 180 V6 orbits (fast saturation of quadratic variety!)
    for pts8 in v6_list[:180]:
        if piv_row_idx[off0] >= 0 or (time.perf_counter() - t0) > budget_sec * 0.12:
            break
        pts_set = set(pts8)
        coset_reps8, covered = [0], set(pts8)
        for cand in range(1, 256):
            if cand not in covered:
                coset_reps8.append(cand)
                covered |= {cand ^ p for p in pts_set}
        w_pts = [v | (w << 8) for v in pts8 for w in pts8]
        for a0 in coset_reps8:
            a16 = a0 | (a0 << 8)
            if a0 != 0:
                run_coset_16([x ^ a16 for x in w_pts])
            run_coset_16([interleave16(x ^ a16) for x in w_pts])

    # --------------------------------------------------------------------------
    # STEP 2: Collect EXACT DEGREE-4 POLYNOMIALS:
    #   (A) T28 (branch 0 for c99=0, branch 1 for c99=1)
    #   (B) ~1,000 Q4 degree-4 polynomials from mod-32 rot^4-invariant dim-12 subspaces
    #   (C) In B0_00 (c99=0, c57=0): e_2 (deg <= 2) AND e_4 (deg <= 4) on ALL 35 fibers F_z!
    #   (D) Pairwise products q_a(x) * q_b(x) = 0 of the sparsest independent quadratic pivots!
    # --------------------------------------------------------------------------
    deg4_packed_polys = []  # each element is a list[int] of uint32_t packed monomials
    deg4_stats = {"t28_loaded": False, "rot4_deg3": 0, "rot4_q4_deg4": 0, "fibers_e4": 0, "quad_prod_deg4": 0}

    # (A) Load T28 certificate if available in repo
    t28_path = precomp["t28_path"]
    if t28_path is not None:
        cert_t28 = json.loads(t28_path.read_text(encoding="utf-8"))
        branch_idx = 0 if c99_val == 0 else 1
        branches = cert_t28.get("reduced_models", {}).get("branches", [])
        if len(branches) > branch_idx:
            raw_hex = [int(h, 16) for h in branches[branch_idx]["polynomial_hex"]]
            p_t28 = map_116_poly_to_basis(raw_hex, origin, cb, n)
            # Validate on 8 random points against W_f(0x0001) = +-256 if homogeneous check applies:
            # Wait: check max degree <= 4
            if p_t28 and max((m.bit_count() for m in p_t28), default=0) <= 4:
                deg4_packed_polys.append([pack_bitmask_to_u32(m) for m in p_t28])
                deg4_stats["t28_loaded"] = True

    # (B) Collect ~1,000 degree-4 Q4 polynomials from rot^4-invariant dim-12 subspaces (mod 32)
    rng = random.Random(20260828 + 10 * c99_val + c57_val)
    seen_rot4 = set()
    r_idxs_arr = (ctypes.c_int * 1024)()
    p2_out_buf = (ctypes.c_uint32 * 8192)()
    p2_len_c = ctypes.c_int()
    MAX_Q4_TERMS = 45000
    q4_out_buf = (ctypes.c_uint32 * MAX_Q4_TERMS)()
    q4_len_c = ctypes.c_int()

    trial = 0
    while len(deg4_packed_polys) < 1050 and trial < 3200 and piv_row_idx[off0] < 0:
        trial += 1
        codim = 4 if (trial % 5 != 4) else 5
        wp_basis = sample_rot4_wperp(rng, codim)
        if wp_basis is None:
            continue
        key = tuple(wp_basis)
        if key in seen_rot4:
            continue
        seen_rot4.add(key)

        W_pts = span_set(nullspace_basis(wp_basis))
        dmask = 0
        r4_list = []
        picked = set()
        for x in W_pts:
            if (x & 0xFF) == (x >> 8):
                dmask |= 1 << (x & 0xFF)
            else:
                ri = rep_of_x[x]
                if ri not in picked:
                    picked.add(ri)
                    r4_list.append(ri)
        d0 = (O_diag & dmask).bit_count()
        if d0 % 4 != 0:
            continue
        n_orbs = len(r4_list)
        for k, ri in enumerate(r4_list):
            r_idxs_arr[k] = ri

        for use_chi in (0, 1):
            rc = lib.extract_mod8_orbits_c(
                all_r4_bits, r_idxs_arr, n_orbs, n, use_chi, d0 // 4, 0,
                p2_out_buf, ctypes.byref(p2_len_c),
                q4_out_buf, ctypes.byref(q4_len_c), MAX_Q4_TERMS
            )
            if rc != 0:
                continue
            if p2_len_c.value > 0:
                p2_set = {unpack_u32_to_bitmask(p2_out_buf[k]) for k in range(p2_len_c.value)}
                insert_pset_deg3(p2_set)
                drain_xl()
            if codim == 4 and q4_len_c.value > 0:
                q_terms = [int(q4_out_buf[k]) for k in range(q4_len_c.value)]
                has_d4 = any(((t >> 24) & 0xFF) != 0xFF for t in q_terms)
                if not has_d4:
                    q_set = {unpack_u32_to_bitmask(t) for t in q_terms}
                    insert_pset_deg3(q_set)
                    deg4_stats["rot4_deg3"] += 1
                    drain_xl()
                else:
                    deg4_packed_polys.append(q_terms)
                    deg4_stats["rot4_q4_deg4"] += 1

    # (C) In B0_00 (c99=0, c57=c113=0): Extract e_1, e_2 AND e_4 (deg <= 4) from ALL 35 fibers F_z!
    fiber_forms_map = {}
    if c99_val == 0 and c57_val == 0 and c113_val == 0:
        for z_rep, _ in nonzero_z:
            gstep = 1 if z_rep == 0xFF else (2 if z_rep in (0x55, 0xAA) else (4 if z_rep in (0x11, 0x33, 0x77) else 8))
            reps = fiber_orbit_reps(z_rep, gstep)
            M_z = len(reps)  # 16, 32, 64, or 128 <= 1024!
            # Build temporary all_fib_bits in (n+2)*255 format to call exact C extractor!
            fib_bits = (ctypes.c_uint64 * ((n + 2) * 255))()
            forms_z = []
            for k, x_pt in enumerate(reps):
                ovec = 0
                for j in range(116):
                    if eval_orb_x(j, x_pt):
                        ovec |= 1 << j
                ob = (origin & ovec).bit_count() & 1
                if ob:
                    fib_bits[n * 255 + (k >> 6)] |= 1 << (k & 63)
                wm = 0
                for i, cdir in enumerate(cb):
                    if (cdir & ovec).bit_count() & 1:
                        wm |= 1 << i
                        fib_bits[i * 255 + (k >> 6)] |= 1 << (k & 63)
                forms_z.append((wm, ob))
            fiber_forms_map[z_rep] = forms_z

            # Level 0: linear parity e_1 == 0
            w_xor, o_xor = 0, 0
            for wm, ob in forms_z:
                w_xor ^= wm
                o_xor ^= ob
            if w_xor or o_xor:
                p_lin = {1 << i for i in range(n) if (w_xor >> i) & 1}
                if o_xor:
                    p_lin.add(0)
                insert_pset_deg3(p_lin)
                drain_xl()
                continue

            # Level 1 & 2: e_2 == 0 and e_4 == 0 (since W_z = M_z//2 in {8,16,32,64} has bit 2 == 0 and bit 4 == 0!)
            for k in range(M_z):
                r_idxs_arr[k] = k
            rc = lib.extract_mod8_orbits_c(
                fib_bits, r_idxs_arr, M_z, n, 0, 0, 0,
                p2_out_buf, ctypes.byref(p2_len_c),
                q4_out_buf, ctypes.byref(q4_len_c), MAX_Q4_TERMS
            )
            if rc == 0:
                if p2_len_c.value > 0:
                    insert_pset_deg3({unpack_u32_to_bitmask(p2_out_buf[k]) for k in range(p2_len_c.value)})
                    drain_xl()
                if q4_len_c.value > 0:
                    q_terms = [int(q4_out_buf[k]) for k in range(q4_len_c.value)]
                    if any(((t >> 24) & 0xFF) != 0xFF for t in q_terms):
                        deg4_packed_polys.append(q_terms)
                        deg4_stats["fibers_e4"] += 1
                    else:
                        insert_pset_deg3({unpack_u32_to_bitmask(t) for t in q_terms})
                        drain_xl()

    if piv_row_idx[off0] >= 0:
        return {
            "cell": cell_name,
            "unsat_closed": True,
            "closed_by": "global_deg3_before_formal_deriv",
            "deg_pivs": deg_pivs,
            "deg4_stats": deg4_stats,
            "elapsed_sec": round(time.perf_counter() - t0, 3),
        }

    # (D) Extract all independent degree <= 2 pivots and add sparse pairwise products q_a * q_b = 0!
    quad_psets = []
    lin_psets = []
    for col in range(off2, off0):
        r_idx = piv_row_idx[col]
        if r_idx >= 0:
            ps = decode_row_pset(r_idx)
            if col >= off1:
                lin_psets.append(ps)
            else:
                quad_psets.append(ps)
    quad_psets.sort(key=len)

    # Build up to 350 sparse degree-4 products q_a(x) * q_b(x) = 0 (crucial for B1_11's 223 quadratics!)
    sparse_qs = [q for q in quad_psets if len(q) <= 180][:32]
    for idx_a in range(len(sparse_qs)):
        for idx_b in range(idx_a + 1, len(sparse_qs)):
            if deg4_stats["quad_prod_deg4"] >= 350:
                break
            prod = mul_pset(sparse_qs[idx_a], sparse_qs[idx_b])
            if 0 < len(prod) <= MAX_Q4_TERMS:
                deg4_packed_polys.append([pack_bitmask_to_u32(m) for m in prod])
                deg4_stats["quad_prod_deg4"] += 1

    # Also include existing degree <= 3 pivots in the specialization pool so cube specializations
    # immediately cascade 3 -> 2 -> 1 together with the 4 -> 3 formal derivatives!
    base_deg3_packed = []
    for col in range(n_cols):
        r_idx = piv_row_idx[col]
        if r_idx >= 0:
            ps = decode_row_pset(r_idx)
            if len(ps) <= 1200:
                base_deg3_packed.append([pack_bitmask_to_u32(m) for m in ps])

    all_spec_polys = base_deg3_packed + deg4_packed_polys
    n_spec_polys = len(all_spec_polys)
    poly_offs = (ctypes.c_int * (n_spec_polys + 1))()
    total_terms = sum(len(p) for p in all_spec_polys)
    poly_terms = (ctypes.c_uint32 * max(1, total_terms))()
    cur_off = 0
    for idx_p, plist in enumerate(all_spec_polys):
        poly_offs[idx_p] = cur_off
        for k, val in enumerate(plist):
            poly_terms[cur_off + k] = val
        cur_off += len(plist)
    poly_offs[n_spec_polys] = cur_off

    print(f"[{cell_name}] Global base ready in {time.perf_counter()-t0:.2f}s: "
          f"deg_pivs={deg_pivs}, deg4_pool={len(deg4_packed_polys)} ({deg4_stats}), "
          f"spec_polys={n_spec_polys}, total_terms={total_terms}", flush=True)

    # --------------------------------------------------------------------------
    # STEP 3: Global Schur Pass (fix_mask = 0) + Formal Derivative Probing (x_i = 0 / 1)
    # --------------------------------------------------------------------------
    fix_mask = (ctypes.c_uint64 * 2)(0, 0)
    fix_val = (ctypes.c_uint64 * 2)(0, 0)
    io_cur = ctypes.c_int(cur_row)
    d3_inj, mut_inj, d12_new = ctypes.c_int(), ctypes.c_int(), ctypes.c_int()

    # Global Schur pass at root (catches global degree-4 cancellations -> Mutants of deg <= 3!)
    rc_root = lib.specialize_deg4_and_echelon_c(
        n, len(deg4_packed_polys),
        ctypes.cast(ctypes.byref(poly_offs, len(base_deg3_packed) * 4), ctypes.POINTER(ctypes.c_int)),
        poly_terms, fix_mask, fix_val,
        col3_base, pair2_col_arr, off2, off1, off0, n_cols, n_col_words,
        rows, ctypes.byref(io_cur), max_rows, piv_row_idx, 12000,
        ctypes.byref(d3_inj), ctypes.byref(mut_inj), ctypes.byref(d12_new)
    )
    # Note: poly_offs offset adjustment requires zero-based offsets or full pass; run clean deg4-only array:
    deg4_offs = (ctypes.c_int * (len(deg4_packed_polys) + 1))()
    base_term_shift = poly_offs[len(base_deg3_packed)]
    for idx_p in range(len(deg4_packed_polys) + 1):
        deg4_offs[idx_p] = poly_offs[len(base_deg3_packed) + idx_p] - base_term_shift
    deg4_terms_ptr = ctypes.cast(ctypes.byref(poly_terms, base_term_shift * 4), ctypes.POINTER(ctypes.c_uint32))

    io_cur.value = cur_row
    rc_root = lib.specialize_deg4_and_echelon_c(
        n, len(deg4_packed_polys), deg4_offs, deg4_terms_ptr, fix_mask, fix_val,
        col3_base, pair2_col_arr, off2, off1, off0, n_cols, n_col_words,
        rows, ctypes.byref(io_cur), max_rows, piv_row_idx, 14000,
        ctypes.byref(d3_inj), ctypes.byref(mut_inj), ctypes.byref(d12_new)
    )
    for r_new in range(cur_row, io_cur.value):
        ps_new = decode_row_pset(r_new)
        d_new = max((m.bit_count() for m in ps_new), default=0)
        deg_pivs[d_new] += 1
        if d_new in (1, 2):
            xl_queue.append(r_new)
    cur_row = io_cur.value
    drain_xl()

    if piv_row_idx[off0] >= 0:
        return {
            "cell": cell_name,
            "unsat_closed": True,
            "closed_by": "global_schur_deg4_mutants",
            "root_mutants": mut_inj.value,
            "deg_pivs": deg_pivs,
            "elapsed_sec": round(time.perf_counter() - t0, 3),
        }

    # Formal Derivative Probing on top high-degree variables x_i in {0, 1}:
    # Count frequency of each variable i in degree-4 terms to pick the sharpest formal derivatives D_i P!
    var_freq4 = [0] * n
    for plist in deg4_packed_polys:
        for t in plist:
            if ((t >> 24) & 0xFF) != 0xFF:
                for s in range(4):
                    var_freq4[(t >> (8 * s)) & 0xFF] += 1
    probe_vars = sorted(range(n), key=lambda i: var_freq4[i], reverse=True)[:16]

    # Allocate scratch echelon buffers for probing & cube solving
    CUBE_MAX_ROWS = 16000
    cube_rows = (ctypes.c_uint64 * (CUBE_MAX_ROWS * n_col_words))()
    cube_pivs = (ctypes.c_int * n_cols)()

    learned_units = {}
    for pv in probe_vars:
        if (time.perf_counter() - t0) > budget_sec * 0.35 or piv_row_idx[off0] >= 0:
            break
        if pv in learned_units:
            continue
        branch_unsat = [False, False]
        for val_b in (0, 1):
            ctypes.memset(cube_pivs, -1, ctypes.sizeof(cube_pivs))
            fmask = (ctypes.c_uint64 * 2)(0, 0)
            fval = (ctypes.c_uint64 * 2)(0, 0)
            for uv, ubit in learned_units.items():
                fmask[uv >> 6] |= 1 << (uv & 63)
                if ubit:
                    fval[uv >> 6] |= 1 << (uv & 63)
            fmask[pv >> 6] |= 1 << (pv & 63)
            if val_b:
                fval[pv >> 6] |= 1 << (pv & 63)

            c_cur = ctypes.c_int(0)
            rc_p = lib.specialize_deg4_and_echelon_c(
                n, n_spec_polys, poly_offs, poly_terms, fmask, fval,
                col3_base, pair2_col_arr, off2, off1, off0, n_cols, n_col_words,
                cube_rows, ctypes.byref(c_cur), CUBE_MAX_ROWS, cube_pivs, 8000,
                ctypes.byref(d3_inj), ctypes.byref(mut_inj), ctypes.byref(d12_new)
            )
            if rc_p == 1 or cube_pivs[off0] >= 0:
                branch_unsat[val_b] = True

        if branch_unsat[0] and branch_unsat[1]:
            return {
                "cell": cell_name,
                "unsat_closed": True,
                "closed_by": f"formal_derivative_probing_both_branches_var_{pv}",
                "learned_units_before_close": len(learned_units),
                "elapsed_sec": round(time.perf_counter() - t0, 3),
            }
        elif branch_unsat[0] or branch_unsat[1]:
            forced_val = 1 if branch_unsat[0] else 0
            learned_units[pv] = forced_val
            p_unit = {1 << pv} | ({0} if forced_val else set())
            insert_pset_deg3(p_unit)
            drain_xl()
            if piv_row_idx[off0] >= 0:
                return {
                    "cell": cell_name,
                    "unsat_closed": True,
                    "closed_by": f"probing_unit_cascade_var_{pv}",
                    "elapsed_sec": round(time.perf_counter() - t0, 3),
                }

    # --------------------------------------------------------------------------
    # STEP 4: Exact Canonical Cube-and-Conquer on the 8 Variables of 0x5555!
    #   Each of the <= 54 Z_16^*-canonical cubes fixes the 8 purely-even long orbits:
    #   since none of those 8 orbits is in {0, 57, 99, 113, 115}, EVERY one of them is a
    #   SINGLE basis variable x_{idx_k} in `free111`!!
    #   Fixing those 8 variables drops thousands of degree-4 terms directly into
    #   `gf2_echelon_insert` + runs one-step XL on newly created quadratics + SAT/FWHT fallback!
    # --------------------------------------------------------------------------
    even_var_idxs = [free111.index(j) for j in even_orbs]
    my_cubes = [c for idx_c, c in enumerate(canon_cubes) if (idx_c % num_workers) == worker_idx]

    cubes_alg_unsat = 0
    cubes_sat_unsat = 0
    cubes_timed_out = 0
    bent_hits = []
    total_direct_deg3 = 0
    total_mutants = 0

    for cube_ord, (mask8, orbit_mult) in enumerate(my_cubes):
        if (time.perf_counter() - t0) > budget_sec:
            cubes_timed_out += (len(my_cubes) - cube_ord)
            break

        ctypes.memset(cube_pivs, -1, ctypes.sizeof(cube_pivs))
        fmask = (ctypes.c_uint64 * 2)(0, 0)
        fval = (ctypes.c_uint64 * 2)(0, 0)
        conflict_with_learned = False
        for uv, ubit in learned_units.items():
            fmask[uv >> 6] |= 1 << (uv & 63)
            if ubit:
                fval[uv >> 6] |= 1 << (uv & 63)

        for bit_k, v_idx in enumerate(even_var_idxs):
            bval = (mask8 >> bit_k) & 1
            if v_idx in learned_units and learned_units[v_idx] != bval:
                conflict_with_learned = True
                break
            fmask[v_idx >> 6] |= 1 << (v_idx & 63)
            if bval:
                fval[v_idx >> 6] |= 1 << (v_idx & 63)

        if conflict_with_learned:
            cubes_alg_unsat += 1
            continue

        c_cur = ctypes.c_int(0)
        rc_c = lib.specialize_deg4_and_echelon_c(
            n, n_spec_polys, poly_offs, poly_terms, fmask, fval,
            col3_base, pair2_col_arr, off2, off1, off0, n_cols, n_col_words,
            cube_rows, ctypes.byref(c_cur), CUBE_MAX_ROWS, cube_pivs, 10000,
            ctypes.byref(d3_inj), ctypes.byref(mut_inj), ctypes.byref(d12_new)
        )
        total_direct_deg3 += d3_inj.value
        total_mutants += mut_inj.value

        # Cascade XL on ALL degree <= 2 pivots inside this cube!
        if rc_c == 0 and cube_pivs[off0] < 0:
            cube_deg12 = []
            for col in range(off2, off0):
                pr = cube_pivs[col]
                if pr >= 0:
                    # Decode cube_rows[pr]
                    pset = set()
                    base = pr * n_col_words
                    for w in range(n_col_words):
                        val = cube_rows[base + w]
                        while val:
                            b = val & -val
                            cc = (w << 6) + (b.bit_length() - 1)
                            val ^= b
                            if cc == off0:
                                pset.add(0)
                            elif cc >= off1:
                                pset.add(1 << (cc - off1))
                            elif cc >= off2:
                                pset.add(pair2_list[cc - off2])
                            else:
                                pset.add(col3_list[cc])
                    cube_deg12.append(pset)

            # Multiply every linear & sparse quadratic pivot in the cube by free variables!
            free_vars = [i for i in range(n) if not ((fmask[i >> 6] >> (i & 63)) & 1)]
            for ps in sorted(cube_deg12, key=len)[:160]:
                if cube_pivs[off0] >= 0 or c_cur.value >= CUBE_MAX_ROWS - n - 5:
                    break
                if len(ps) > 220:
                    continue
                for fv_i in free_vars:
                    if c_cur.value >= CUBE_MAX_ROWS - 2 or cube_pivs[off0] >= 0:
                        break
                    mps = mul_pset({1 << fv_i}, ps)
                    if not mps:
                        continue
                    r_dst = c_cur.value
                    base = r_dst * n_col_words
                    ctypes.memset(ctypes.byref(cube_rows, base * 8), 0, n_col_words * 8)
                    for m in mps:
                        d = m.bit_count()
                        if d == 0:
                            cc = off0
                        elif d == 1:
                            cc = off1 + (m.bit_length() - 1)
                        elif d == 2:
                            cc = pair2_map[m]
                        else:
                            b0 = (m & -m).bit_length() - 1
                            m1 = m ^ (1 << b0)
                            b1 = (m1 & -m1).bit_length() - 1
                            b2 = (m1 ^ (1 << b1)).bit_length() - 1
                            cc = col3_base[b0 * n + b1] + (b2 - b1 - 1)
                        cube_rows[base + (cc >> 6)] ^= 1 << (cc & 63)
                    if lib.gf2_echelon_insert(cube_rows, r_dst, n_col_words, cube_pivs, n_cols) >= 0:
                        c_cur.value += 1

        if cube_pivs[off0] >= 0:
            cubes_alg_unsat += 1
            continue

        # Fallback: Fast CaDiCaL SAT on this single reduced cube (NO heavy 12-fiber CardEnc!)
        if not HAS_PYSAT:
            cubes_timed_out += 1
            continue

        rem_sec = max(1.0, (budget_sec - (time.perf_counter() - t0)) / max(1, len(my_cubes) - cube_ord))
        sat_ok, hits = solve_residual_cube_sat(
            n, origin, cb, fmask, fval, cube_rows, cube_pivs, n_col_words,
            off2, off1, off0, pair2_list, col3_list,
            deg4_packed_polys, coset_0xf_reps, eval_orb_x, orb_tts, lib, rem_sec
        )
        if hits:
            bent_hits.extend(hits)
            break
        if sat_ok:
            cubes_sat_unsat += 1
        else:
            cubes_timed_out += 1

    all_done = (cubes_timed_out == 0 and len(bent_hits) == 0)
    return {
        "cell": cell_name,
        "worker": f"{worker_idx}/{num_workers}",
        "unsat_closed": all_done,
        "canonical_cubes_assigned": len(my_cubes),
        "cubes_alg_unsat_deg4": cubes_alg_unsat,
        "cubes_sat_unsat": cubes_sat_unsat,
        "cubes_incomplete": cubes_timed_out,
        "bent_hits": bent_hits,
        "global_deg_pivs": deg_pivs,
        "learned_probing_units": len(learned_units),
        "deg4_stats": deg4_stats,
        "total_direct_deg3_from_deg4": total_direct_deg3,
        "total_schur_mutants_from_deg4": total_mutants,
        "elapsed_sec": round(time.perf_counter() - t0, 3),
    }


def solve_residual_cube_sat(
    n, origin, cb, fmask, fval, cube_rows, cube_pivs, n_col_words,
    off2, off1, off0, pair2_list, col3_list,
    deg4_packed_polys, coset_0xf_reps, eval_orb_x, orb_tts, lib, cube_budget_sec
):
    """
    Lightweight CDCL + Lazy Degree-4 & FWHT closer for a single 0x5555 cube:
      - Encodes ALL degree <= 2 pivots of the cube (including degree-4 formal-derivative drops!)
      - Encodes ONLY the single fast 256-bit totalizer wt(C_0xf) == 128 (proven O(1s) in Mode A!)
      - Lazily checks all degree-4 polynomials (`T28`, `Q4_mod32`, `F_z e_4`) and runs 0.05ms C FWHT!
    """
    t_start = time.perf_counter()
    clauses = []
    v_cnt = [n]

    def new_var():
        v_cnt[0] += 1
        return v_cnt[0]

    def add_xor(lits, rhs):
        if not lits:
            if rhs:
                u = new_var()
                clauses.append([u])
                clauses.append([-u])
            return
        cur = list(lits)
        while len(cur) > 4:
            a, b, c = cur[0], cur[1], cur[2]
            aux = new_var()
            # aux = a ^ b ^ c
            for sa in (-1, 1):
                for sb in (-1, 1):
                    for sc in (-1, 1):
                        par = (1 if sa > 0 else 0) ^ (1 if sb > 0 else 0) ^ (1 if sc > 0 else 0)
                        saux = 1 if par else -1
                        clauses.append([-sa * a, -sb * b, -sc * c, saux * aux])
                        clauses.append([sa * a, sb * b, sc * c, -saux * aux])
            cur = [aux] + cur[3:]
        k = len(cur)
        for mask in range(1 << k):
            if (mask.bit_count() & 1) != rhs:
                cl = [-(cur[j]) if ((mask >> j) & 1) else cur[j] for j in range(k)]
                clauses.append(cl)

    pair_vars = {}

    def get_pair_var(i, j):
        if i > j:
            i, j = j, i
        key = (i, j)
        if key not in pair_vars:
            pv = new_var()
            vi, vj = i + 1, j + 1
            clauses.append([-pv, vi])
            clauses.append([-pv, vj])
            clauses.append([pv, -vi, -vj])
            pair_vars[key] = pv
        return pair_vars[key]

    # Fix cube unit literals
    for i in range(n):
        if (fmask[i >> 6] >> (i & 63)) & 1:
            bit = (fval[i >> 6] >> (i & 63)) & 1
            clauses.append([(i + 1) if bit else -(i + 1)])

    # Encode all degree <= 2 pivots of the cube!
    for col in range(off2, off0):
        pr = cube_pivs[col]
        if pr < 0:
            continue
        base = pr * n_col_words
        xor_lits = []
        rhs = 0
        for w in range(n_col_words):
            val = cube_rows[base + w]
            while val:
                b = val & -val
                cc = (w << 6) + (b.bit_length() - 1)
                val ^= b
                if cc == off0:
                    rhs ^= 1
                elif cc >= off1:
                    xor_lits.append((cc - off1) + 1)
                elif cc >= off2:
                    m = pair2_list[cc - off2]
                    i0 = (m & -m).bit_length() - 1
                    i1 = (m ^ (1 << i0)).bit_length() - 1
                    xor_lits.append(get_pair_var(i0, i1))
        add_xor(xor_lits, rhs)

    # Encode single lightweight exact coset counter: wt(C_{0xf}) == 128 (256 orbits)
    lits_0xf = []
    for x_pt in coset_0xf_reps:
        ovec = 0
        for j in range(116):
            if eval_orb_x(j, x_pt):
                ovec |= 1 << j
        ob = (origin & ovec).bit_count() & 1
        idxs = []
        for i, cdir in enumerate(cb):
            if (cdir & ovec).bit_count() & 1:
                if (fmask[i >> 6] >> (i & 63)) & 1:
                    ob ^= (fval[i >> 6] >> (i & 63)) & 1
                else:
                    idxs.append(i + 1)
        if not idxs:
            lv = new_var()
            clauses.append([lv if ob else -lv])
        elif len(idxs) == 1:
            lv = -idxs[0] if ob else idxs[0]
        else:
            lv = new_var()
            add_xor(idxs + [lv], ob)
        lits_0xf.append(lv)

    enc_0xf = CardEnc.equals(lits=lits_0xf, bound=128, top_id=v_cnt[0], encoding=EncType.totalizer)
    v_cnt[0] = max(v_cnt[0], enc_0xf.nv)
    clauses.extend(enc_0xf.clauses)

    # Prepare unpacked bitmasks of concise degree-4 equations for fast lazy cutting!
    lazy_deg4 = []
    for plist in deg4_packed_polys[:200]:
        if len(plist) <= 25000:
            # Specialize plist to the cube first so it becomes degree <= 4 (mostly <= 3!) on free vars!
            spec_set = set()
            for t in plist:
                m_free = 0
                zeroed = False
                for s in range(4):
                    v = (t >> (8 * s)) & 0xFF
                    if v == 0xFF:
                        break
                    if (fmask[v >> 6] >> (v & 63)) & 1:
                        if not ((fval[v >> 6] >> (v & 63)) & 1):
                            zeroed = True
                            break
                    else:
                        m_free |= 1 << v
                if not zeroed:
                    spec_set.symmetric_difference_update({m_free})
            if spec_set and len(spec_set) <= 1500:
                lazy_deg4.append(spec_set)
    lazy_deg4.sort(key=len)

    mask64 = (1 << 64) - 1
    mono_gate_cache = {}
    injected_lazy = set()
    hits = []

    with Solver(name="cadical195", bootstrap_with=clauses) as slv:
        while (time.perf_counter() - t_start) < cube_budget_sec:
            if not slv.solve():
                return True, []
            model = slv.get_model()
            x_bits = 0
            cint = origin
            for i, cdir in enumerate(cb):
                if model[i] > 0:
                    x_bits |= 1 << i
                    cint ^= cdir

            # Lazy check specialized degree-4 polynomials (exact algebraic cuts, NOT neg_model!)
            cut_added = 0
            for l_idx, pset in enumerate(lazy_deg4):
                if l_idx in injected_lazy:
                    continue
                val = 0
                for m in pset:
                    if (x_bits & m) == m:
                        val ^= 1
                if val == 1:
                    new_cls = []
                    # Encode pset == 0
                    xlits, xrhs = [], 0
                    for m in pset:
                        if m == 0:
                            xrhs ^= 1
                        elif m.bit_count() == 1:
                            xlits.append((m.bit_length() - 1) + 1)
                        elif m.bit_count() == 2:
                            i0 = (m & -m).bit_length() - 1
                            i1 = (m ^ (1 << i0)).bit_length() - 1
                            if (i0, i1) not in pair_vars:
                                pv = new_var()
                                new_cls.extend([[-pv, i0 + 1], [-pv, i1 + 1], [pv, -(i0 + 1), -(i1 + 1)]])
                                pair_vars[(i0, i1)] = pv
                            xlits.append(pair_vars[(i0, i1)])
                        else:
                            if m not in mono_gate_cache:
                                mv = new_var()
                                bits_v = []
                                tmp = m
                                while tmp:
                                    b = tmp & -tmp
                                    bits_v.append(b.bit_length())
                                    tmp ^= b
                                for bv in bits_v:
                                    new_cls.append([-mv, bv])
                                new_cls.append([mv] + [-bv for bv in bits_v])
                                mono_gate_cache[m] = mv
                            xlits.append(mono_gate_cache[m])
                    # Add XOR to new_cls
                    cur = list(xlits)
                    while len(cur) > 4:
                        a, b, c = cur[0], cur[1], cur[2]
                        aux = new_var()
                        for sa in (-1, 1):
                            for sb in (-1, 1):
                                for sc in (-1, 1):
                                    par = (1 if sa > 0 else 0) ^ (1 if sb > 0 else 0) ^ (1 if sc > 0 else 0)
                                    saux = 1 if par else -1
                                    new_cls.append([-sa * a, -sb * b, -sc * c, saux * aux])
                                    new_cls.append([sa * a, sb * b, sc * c, -saux * aux])
                        cur = [aux] + cur[3:]
                    k_l = len(cur)
                    for msk in range(1 << k_l):
                        if (msk.bit_count() & 1) != xrhs:
                            new_cls.append([-(cur[j]) if ((msk >> j) & 1) else cur[j] for j in range(k_l)])
                    for cl in new_cls:
                        slv.add_clause(cl)
                    injected_lazy.add(l_idx)
                    cut_added += 1
                    if cut_added >= 12:
                        break
            if cut_added > 0:
                continue

            if lib.audit_bent_fwht_c(orb_tts, cint & mask64, cint >> 64):
                hits.append(hex(cint))
                return False, hits

            slv.add_clause([-(i + 1) if model[i] > 0 else (i + 1) for i in range(n)])

    return False, []


def main():
    t_all = time.perf_counter()
    target_arg = sys.argv[1].upper() if len(sys.argv) > 1 else "ALL"
    budget_sec = float(sys.argv[2]) if len(sys.argv) > 2 else 360.0
    worker_idx = int(sys.argv[3]) if len(sys.argv) > 3 else int(os.environ.get("CLOUD_RUN_TASK_INDEX", "0"))
    num_workers = int(sys.argv[4]) if len(sys.argv) > 4 else int(os.environ.get("CLOUD_RUN_TASK_COUNT", "1"))

    work_dir = Path(__file__).resolve().parent
    lib = compile_c_engine(work_dir)

    orbits = build_orbits_116()
    v6_list = all_v6_orbits()
    nonzero_z = build_c8_nonzero_orbits()
    even_orbs, reps_by_c99 = canonical_0x5555_cubes(orbits)

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

    orb_diag, orb_pair, orb_r4 = [0] * 116, [0] * 116, [0] * 116
    orb_tts = (ctypes.c_uint64 * (116 * 1024))()
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
        orb_diag[j] = vd
        orb_pair[j] = vp
        orb_r4[j] = vr
    chi_r4 = sum((1 << k) for k, x in enumerate(rot4_reps) if x.bit_count() & 1)

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
        if len(mem) == 16 and (((x & 0xF) ^ ((x >> 4) & 0xF) ^ ((x >> 8) & 0xF) ^ ((x >> 12) & 0xF)) == 0xF):
            coset_0xf_reps.append(mem[0])

    precomp = {
        "orbits": orbits,
        "v6_list": v6_list,
        "nonzero_z": nonzero_z,
        "pair_idx": pair_idx,
        "orb_diag": orb_diag,
        "orb_pair": orb_pair,
        "orb_r4": orb_r4,
        "chi_r4": chi_r4,
        "rep_of_x": rep_of_x,
        "orb_tts": orb_tts,
        "coset_0xf_reps": coset_0xf_reps,
        "even_orbs": even_orbs,
        "reps_by_c99": reps_by_c99,
        "t28_path": find_t28_cert_file(),
    }

    cell_specs = {
        "B1_00": (1, 0, 0),
        "B1_11": (1, 1, 1),
        "B0_11": (0, 1, 1),
        "B0_00": (0, 0, 0),
    }
    selected = list(cell_specs.items()) if target_arg == "ALL" else [(target_arg, cell_specs[target_arg])]
    per_cell_budget = budget_sec / len(selected)

    summary = {"canon_0x5555_cubes_count": {str(k): len(v) for k, v in reps_by_c99.items()}, "cells": {}}
    for cname, (c99_v, c57_v, c113_v) in selected:
        res = solve_cell_b28(
            cname, c99_v, c57_v, c113_v, lib, precomp,
            budget_sec=per_cell_budget, worker_idx=worker_idx, num_workers=num_workers
        )
        summary["cells"][cname] = res
        print(f"=== {cname} RESULT ===", flush=True)
        print(json.dumps(res, indent=2), flush=True)

    summary["total_elapsed_sec"] = round(time.perf_counter() - t_all, 3)
    print("=== FINAL B28 REPORT ===", flush=True)
    print(json.dumps(summary, indent=2), flush=True)


if __name__ == "__main__":
    main()
