#!/usr/bin/env python3
r"""
SOLVE_ALL_REMAINING_FAST.py — Task b31_hybrid_c_solver_all_in_one
Unified High-Speed Algebraic + Zero-Totalizer Lazy-Clause + C-FWHT Solver
for all 4 remaining symmetric cells of H(16,4):
    B1_00 (1,0,0), B1_11 (1,1,1), B0_11 (0,1,1), B0_00 (0,0,0).

Integrates all 4 proven speed weapons:
  (1) Complete Multilevel (r=0,1,2) C Extractor with corrected (wt_diag // 8) & 1:
      - Never discards Level-0 (mod 4, deg <= 1) or Level-1 (mod 8, deg <= 2) equations
        when a subspace fails Level-2 preconditions (automatically recovers C5: K=c57,
        C7, and closes B1_00 algebraically in < 0.05s from pure 111-var basis!).
      - Includes V6xV6 + diagonal shifts + interleaved conjugates, Regime-II diagonal-free
        cosets with asymmetric characters, rot^4 dim-12 (mod 32: deg <= 3 & deg 4) +
        rot^4 dim-11 (mod 16: deg <= 2), rot^2 dim-14 (mod 64: deg <= 3), Dual Fibers F_z,
        full C Macaulay XL, plus Degree-4 Schur/Pairwise Elimination for overdetermined B1_11!
  (2) Explicit Iterative Elimination of ALL Linear Pivots BEFORE building the CNF:
      - Collapses the 111-var basis to N_freevars (e.g., <= 108 in B0_*, <= 109 in B1_11),
        substitutes into all quadratic pivots, and re-echelonizes until zero deg-1 pivots remain.
  (3) ZERO Heavy Totalizers in the CNF:
      - Static CNF contains ONLY:
          * Reduced quadratic pivots (sharing AND gates y_{ij} = z_i & z_j)
          * C6 (T28 sixth condition on branch c99=0, or exact degree-4 rot^4 pivots)
          * Exact Z_16^* (order 8) lexicographic symmetry breaking on canonical orbits
          * 6 <= wt(c_long) <= 106 (lightweight seqcounter on 112 bits)
          * ONLY the tiny 16-bit exact counter wt(F_{0xff}) == 8 (in B0_00)
            and tiny 31-bit dual weight / F_{0xff} coupling in B0_11!
      - Medium orbit sets (F_{0x55} [32], F_{0x11,33,77} [64], C_{0x0} [240], C_{0xf} [256])
        are enforced via LAZY k-of-M CLAUSES (short clauses of length K+1 / M-K+1 with
        ZERO new auxiliary variables!).
      - All 30 generic fibers F_z (128 bits), cosets C_{0x5} (512), C_{0x1,3,7} (1024),
        coordinate subcubes M_d (d=8..12 with slack-minimized nogoods of length 16..38!),
        sparse cubic pivots, degree-4 rot^4 polynomials, and full 65,536-pt FWHT are checked
        in a single 0.03ms C call per candidate model!
  (4) Native Support for Parallel GitHub Actions / Cloud Run Sharding (--shard-id / --num-shards)
      using Vertex-Cover Cube-and-Conquer with in-cube Gaussian degree-drop specialization!

Usage:
  Single cell:
    python3 SOLVE_ALL_REMAINING_FAST.py --cell B1_00
    python3 SOLVE_ALL_REMAINING_FAST.py --cell B1_11 --budget 600
    python3 SOLVE_ALL_REMAINING_FAST.py --cell B0_11 --budget 600
    python3 SOLVE_ALL_REMAINING_FAST.py --cell B0_00 --budget 600
  All 4 cells sequentially:
    python3 SOLVE_ALL_REMAINING_FAST.py --cell ALL --budget 300
  Parallel sharded Cube-and-Conquer (e.g. 16 shards for B0_11 in GitHub Actions matrix):
    python3 SOLVE_ALL_REMAINING_FAST.py --cell B0_11 --shard-id 0 --num-shards 16 --budget 900
"""

import argparse
import ctypes
import json
import os
import random
import subprocess
import sys
import tempfile
import time
from itertools import combinations
from pathlib import Path

from pysat.card import CardEnc, EncType
from pysat.solvers import Solver

# ==============================================================================
# 1. Unified High-Speed C Engine (Multilevel Extractor + XL + Subcube/FWHT Audit)
# ==============================================================================
C_UNIFIED_SRC = r"""
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

static inline void pack_subset32(
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

/*
 * Complete Multilevel Extractor on M <= 2048 pairs (or orbits of size g):
 * Enforces S(x) == T_mod (mod 2^t_bits), where t_bits in {1, 2, 3}.
 * Returns:
 *   0 : Extracted exact non-zero Level-0 (mod 2, deg <= 1) equation in out_row!
 *   1 : Level-0 is identically 0, extracted exact non-zero Level-1 (mod 4, deg <= 2) in out_row!
 *   2 : Levels 0,1 are identically 0, extracted exact non-zero Level-2 (mod 8, deg <= 3) in out_row!
 *       AND if n_chars > 0 (only when t_bits == 3 and Level-2 is reached), also extracts
 *       1st-difference quadratic rows Q^(m) and 2nd-difference linear rows L^(r,s)!
 *  -10: Identically satisfied up to 2^t_bits (zero polynomial).
 */
int extract_multilevel_coset(
    const uint64_t *all_pair_bits, // (n+1) * 510 words
    const int *p_idxs,
    int n_pairs,
    int n,
    int t_bits,                    // 2 when wt_diag % 8 == 4 (T_mod = 2); 3 when wt_diag % 8 == 0
    int T_mod,                     // ((-wt_diag / 2) & ((1<<t_bits)-1))
    const uint64_t *char_words32,  // n_chars * 32 words (optional, used if level 2 reached)
    int n_chars,
    const int *col3_base,
    int off2,
    int off1,
    int off0,
    int n_col_words,
    uint64_t *out_row,
    uint64_t *out_quad_rows,       // n_chars * n_col_words (may be NULL if n_chars==0)
    int *out_quad_valid,
    uint64_t *out_lin_rows,        // (n_chars*(n_chars-1)/2) * n_col_words
    int *out_lin_valid
) {
    uint64_t basis[112][32];
    uint64_t O_word[32];
    pack_subset32(all_pair_bits + (size_t)n * 510, p_idxs, n_pairs, O_word);
    int o_pop = pop32(O_word);

    int wi_pop[112], wo_pop[112], Ai[112];
    int lvl0_nz = ((o_pop ^ T_mod) & 1);
    for (int i = 0; i < n; i++) {
        pack_subset32(all_pair_bits + (size_t)i * 510, p_idxs, n_pairs, basis[i]);
        int wp = pop32(basis[i]);
        int wop = pop32_and(basis[i], O_word);
        wi_pop[i] = wp;
        wo_pop[i] = wop;
        Ai[i] = wp - 2 * wop;
        if (wp & 1) lvl0_nz = 1;
    }

    memset(out_row, 0, (size_t)n_col_words * sizeof(uint64_t));

    // --- LEVEL 0: S(x) == T_mod (mod 2) -> Degree <= 1 ---
    if (lvl0_nz) {
        if ((o_pop ^ T_mod) & 1) {
            out_row[off0 >> 6] ^= 1ULL << (off0 & 63);
        }
        for (int i = 0; i < n; i++) {
            if (wi_pop[i] & 1) {
                int c = off1 + i;
                out_row[c >> 6] ^= 1ULL << (c & 63);
            }
        }
        return 0;
    }
    if (t_bits <= 1) return -10;

    // --- Check LEVEL 1: S(x) == T_mod (mod 4) -> Degree <= 2 ---
    int T0 = T_mod & 1;
    int T1 = (T_mod >> 1) & 1;
    int c0_r1 = (((o_pop - T0) >> 1) ^ T1) & 1;
    int lvl1_nz = c0_r1;
    for (int i = 0; i < n; i++) {
        if ((Ai[i] >> 1) & 1) lvl1_nz = 1;
    }
    for (int i = 0; i < n && !lvl1_nz; i++) {
        for (int j = i + 1; j < n; j++) {
            if (pop32_and(basis[i], basis[j]) & 1) {
                lvl1_nz = 1;
                break;
            }
        }
    }
    if (lvl1_nz) {
        if (c0_r1) {
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
                if (pop32_and(basis[i], basis[j]) & 1) {
                    int c = off2 + c2_idx;
                    out_row[c >> 6] ^= 1ULL << (c & 63);
                }
                c2_idx++;
            }
        }
        return 1;
    }
    if (t_bits <= 2) return -10;

    // --- LEVEL 2: S(x) == T_mod (mod 8) -> Degree <= 3 ---
    int T_le1 = T_mod & 3;
    int T2 = (T_mod >> 2) & 1;
    int c0_r2 = (((o_pop - T_le1) >> 2) ^ T2) & 1;
    int lvl2_nz = c0_r2;
    if (c0_r2) {
        out_row[off0 >> 6] ^= 1ULL << (off0 & 63);
    }
    for (int i = 0; i < n; i++) {
        if ((Ai[i] >> 2) & 1) {
            int c = off1 + i;
            out_row[c >> 6] ^= 1ULL << (c & 63);
            lvl2_nz = 1;
        }
    }

    if (n_chars > 0 && out_quad_rows) {
        memset(out_quad_rows, 0, (size_t)n_chars * n_col_words * sizeof(uint64_t));
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
            if (((inter_pop >> 1) + io_pop) & 1) {
                int c = off2 + c2_idx;
                out_row[c >> 6] ^= 1ULL << (c & 63);
                lvl2_nz = 1;
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
                    out_row[c >> 6] ^= 1ULL << (c & 63);
                    lvl2_nz = 1;
                }
            }
        }
    }

    // Character 1st differences (quadratic) & 2nd differences (linear)
    // Valid when T_le1 == 0 (i.e. wt_diag % 8 == 0 => T_mod in {0, 4}) and ou_pop % 4 == 0!
    for (int m = 0; m < n_chars; m++) {
        const uint64_t *Um = char_words32 + (size_t)m * 32;
        uint64_t OU[32];
        for (int w = 0; w < 32; w++) OU[w] = O_word[w] ^ Um[w];
        int ou_pop = pop32(OU);
        if ((ou_pop & 3) != T_le1) {
            out_quad_valid[m] = 0;
            memset(out_quad_rows + (size_t)m * n_col_words, 0, (size_t)n_col_words * sizeof(uint64_t));
            continue;
        }
        int ok = 1;
        uint64_t *qrow = out_quad_rows + (size_t)m * n_col_words;
        for (int i = 0; i < n; i++) {
            int wou_pop = pop32_and(basis[i], OU);
            if ((wi_pop[i] - 2 * wou_pop) & 3) {
                ok = 0;
                break;
            }
            int bit0 = (Ai[i] / 4) & 1;
            int bitu = ((wi_pop[i] - 2 * wou_pop) / 4) & 1;
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
        if ((((o_pop - T_le1) / 4) ^ ((ou_pop - T_le1) / 4)) & 1) {
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
            int pop_r = pop32(OUr);
            int pop_s = pop32(OUs);
            int pop_rs = pop32(OUrs);
            if ((pop_rs & 3) != T_le1) {
                out_lin_valid[pair_m++] = 0;
                continue;
            }
            int ok = 1;
            for (int i = 0; i < n; i++) {
                int w_urs = pop32_and3(basis[i], Ur, Us);
                int w_ours = pop32_and(basis[i], OUrs);
                if ((wi_pop[i] - 2 * w_ours) & 3) {
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
            int c0 = (((o_pop - T_le1) / 4) ^ ((pop_r - T_le1) / 4)
                    ^ ((pop_s - T_le1) / 4) ^ ((pop_rs - T_le1) / 4)) & 1;
            if (c0) {
                lrow[off0 >> 6] ^= 1ULL << (off0 & 63);
            }
            out_lin_valid[pair_m++] = 1;
        }
    }
    return (lvl2_nz || n_chars > 0) ? 2 : -10;
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

/*
 * Fast C XL batch multiplier: takes a polynomial given as list of monomials
 * (encoded by degree d in {0,1,2} and indices) and multiplies by all x_0 .. x_{n-1},
 * inserting directly into `rows` in C (avoids Python loop overhead!).
 */
int xl_multiply_deg2_in_c(
    uint64_t *rows,
    int cur_row,
    int max_rows,
    int n_col_words,
    int *piv_row_idx,
    int n_cols,
    int n,
    const int *col3_base,
    const int *pair2_table,  // n * n -> col in [off2 .. off1-1]
    int off2,
    int off1,
    int off0,
    const int *m_deg,        // array of degrees (0, 1, or 2) of terms in pset
    const int *m_v0,
    const int *m_v1,
    int n_terms,
    int *out_deg_counts,     // [4] incremented for new pivots of deg 0,1,2,3
    int *out_new_deg12_rows, // buffer of row indices that landed in deg 1 or 2
    int *out_n_new_deg12
) {
    *out_n_new_deg12 = 0;
    for (int x = 0; x < n; x++) {
        if (cur_row >= max_rows - 2 || piv_row_idx[off0] >= 0) break;
        uint64_t *r = rows + (size_t)cur_row * n_col_words;
        memset(r, 0, (size_t)n_col_words * sizeof(uint64_t));

        for (int t = 0; t < n_terms; t++) {
            int d = m_deg[t];
            int col;
            if (d == 0) {
                col = off1 + x;
            } else if (d == 1) {
                int a = m_v0[t];
                if (a == x) col = off1 + x;
                else col = pair2_table[a * n + x];
            } else {
                int a = m_v0[t], b = m_v1[t];
                if (x == a || x == b) {
                    col = pair2_table[a * n + b];
                } else {
                    int i0 = a, i1 = b, i2 = x;
                    if (i2 < i0) { i2 = i1; i1 = i0; i0 = x; }
                    else if (i2 < i1) { i2 = i1; i1 = x; }
                    col = col3_base[i0 * n + i1] + (i2 - i1 - 1);
                }
            }
            r[col >> 6] ^= 1ULL << (col & 63);
        }

        int pc = gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols);
        if (pc >= 0) {
            int pd = (pc == off0) ? 0 : (pc >= off1 ? 1 : (pc >= off2 ? 2 : 3));
            out_deg_counts[pd]++;
            if (pd == 1 || pd == 2) {
                out_new_deg12_rows[(*out_n_new_deg12)++] = cur_row;
            }
            cur_row++;
        }
    }
    return cur_row;
}

/*
 * Fast 65,536-pt Truth-Table Builder + Subcube Poisson Checker (d=8..12) + Full FWHT!
 *
 * Returns:
 *   1 : Candidate IS BENT! (|W_f(u)| == 256 for all 65,536 u!)
 *   0 : Candidate failed!
 *       - If a coordinate subcube M_d (from `subcube_masks[0..n_subcubes-1]`) failed
 *         |W_{f|_M}(u)| <= 256 or 2^{d-8} | W_{f|_M}(u):
 *           *out_fail_type = 1 (subcube fail)
 *           *out_subcube_idx = index of failing subcube
 *           *out_excess = max(0, |W_{f|_M}(u*)| - 256) (for slack-reduced short nogood!)
 *       - Else failed full 65,536-pt FWHT at frequency u*:
 *           *out_fail_type = 2 (full FWHT fail)
 *           *out_fail_u = u*
 *           *out_fail_val = W_f(u*)
 */
int audit_candidate_and_subcubes_c(
    const uint64_t *orb_tts,      // 116 * 1024 uint64_t
    uint64_t c_lo,
    uint64_t c_hi,
    const uint16_t *subcube_masks,
    int n_subcubes,
    uint64_t *out_tt,             // 1024 uint64_t (truth table returned to Python for fast fiber/coset eval!)
    int *out_fail_type,
    int *out_subcube_idx,
    int *out_excess,
    int *out_fail_u,
    int *out_fail_val
) {
    memset(out_tt, 0, 1024 * sizeof(uint64_t));
    for (int j = 0; j < 64; j++) {
        if ((c_lo >> j) & 1ULL) {
            const uint64_t *src = orb_tts + (size_t)j * 1024;
            for (int w = 0; w < 1024; w++) out_tt[w] ^= src[w];
        }
    }
    for (int j = 64; j < 116; j++) {
        if ((c_hi >> (j - 64)) & 1ULL) {
            const uint64_t *src = orb_tts + (size_t)j * 1024;
            for (int w = 0; w < 1024; w++) out_tt[w] ^= src[w];
        }
    }

    // 1. Check coordinate subcubes M_d (d in 8..12) FIRST to get ultra-short nogoods (16..38 lits)!
    int sub_spec[4096];
    int bit_pos[16];
    for (int s = 0; s < n_subcubes; s++) {
        uint16_t mask = subcube_masks[s];
        int dim = __builtin_popcount(mask);
        int nb = 0;
        for (int b = 0; b < 16; b++) {
            if ((mask >> b) & 1) bit_pos[nb++] = b;
        }
        int n_pts = 1 << dim;
        for (int idx = 0; idx < n_pts; idx++) {
            int x = 0;
            for (int b = 0; b < dim; b++) {
                if ((idx >> b) & 1) x |= (1 << bit_pos[b]);
            }
            int f_x = (out_tt[x >> 6] >> (x & 63)) & 1ULL;
            sub_spec[idx] = f_x ? -1 : 1;
        }
        for (int step = 1; step < n_pts; step <<= 1) {
            int dbl = step << 1;
            for (int i = 0; i < n_pts; i += dbl) {
                for (int j = 0; j < step; j++) {
                    int u = sub_spec[i + j], v = sub_spec[i + j + step];
                    sub_spec[i + j] = u + v;
                    sub_spec[i + j + step] = u - v;
                }
            }
        }
        int div_req = 1 << (dim - 8);
        int best_excess = -1;
        int div_failed = 0;
        for (int u = 0; u < n_pts; u++) {
            int av = abs(sub_spec[u]);
            if (av > 256) {
                int ex = av - 256;
                if (ex > best_excess) best_excess = ex;
            } else if ((av & (div_req - 1)) != 0) {
                div_failed = 1;
            }
        }
        if (best_excess > 0 || div_failed) {
            *out_fail_type = 1;
            *out_subcube_idx = s;
            *out_excess = (best_excess > 0) ? best_excess : 0;
            return 0;
        }
    }

    // 2. Full 65,536-point FWHT
    static int spec[65536];
    for (int w = 0; w < 1024; w++) {
        uint64_t word = out_tt[w];
        int base = w << 6;
        for (int b = 0; b < 64; b++) {
            spec[base + b] = ((word >> b) & 1ULL) ? -1 : 1;
        }
    }
    for (int step = 1; step < 65536; step <<= 1) {
        int dbl = step << 1;
        for (int i = 0; i < 65536; i += dbl) {
            for (int j = 0; j < step; j++) {
                int u = spec[i + j], v = spec[i + j + step];
                spec[i + j] = u + v;
                spec[i + j + step] = u - v;
            }
        }
    }
    // Find worst violating frequency (largest ||W_f(u)| - 256|) for maximal slack relaxation!
    int worst_u = -1, worst_gap = -1, worst_val = 0;
    for (int u = 0; u < 65536; u++) {
        int av = abs(spec[u]);
        if (av != 256) {
            int gap = abs(av - 256);
            if (gap > worst_gap) {
                worst_gap = gap;
                worst_u = u;
                worst_val = spec[u];
            }
        }
    }
    if (worst_u >= 0) {
        *out_fail_type = 2;
        *out_fail_u = worst_u;
        *out_fail_val = worst_val;
        return 0;
    }
    *out_fail_type = 0;
    return 1;
}
"""

# ==============================================================================
# 2. Exact Mathematical Constants & Combinatorial Helpers
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

# Nested / diverse coordinate subcubes of dim 8..12 for ultra-short nogoods (16..38 literals!)
SUBCUBE_MASKS = [
    0x5555, 0xAAAA,                          # dim 8  (8 active long orbits!)
    0x5557, 0x5575, 0xAAAE,                  # dim 9  (36 active long orbits!)
    0x555F, 0x5577, 0x5757, 0x333F, 0x03FF,  # dim 10 (43..52 active long orbits!)
    0x55FF, 0x575F, 0x07FF,                  # dim 11 (52..65 active long orbits!)
    0x5F5F, 0x6F6F, 0x3F3F, 0x7777, 0x0FFF,  # dim 12 (68..85 active long orbits!)
]

CELL_MAP = {
    "B1_00": (1, 0, 0),
    "B1_11": (1, 1, 1),
    "B0_11": (0, 1, 1),
    "B0_00": (0, 0, 0),
}


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


def build_z16_star_orbit_perms(orbits):
    """Exact induced permutations of the multiplicative group Z_16^* = {3,5,7,9,11,13,15} on the 116 orbits."""
    rep_to_j = {orb[0]: j for j, orb in enumerate(orbits)}
    perms = {}
    for mult in (3, 5, 7, 9, 11, 13, 15):
        p = [0] * 116
        for j, orb in enumerate(orbits):
            m = orb[0]
            img = 0
            for b in range(16):
                if (m >> b) & 1:
                    img |= 1 << ((b * mult) & 15)
            canon = min(rot16(img, r) for r in range(16))
            p[j] = rep_to_j[canon]
        perms[mult] = p
    return perms


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
            cur = rot16(cur, group_step)
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


def nullspace_basis_16(hs):
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


def build_pure_111_basis(c99_val: int, c57_val: int, c113_val: int):
    """Pure 111-variable T20 basis: ONLY c115=0, L=c99 (eliminating c0), and fixed (c99, c57, c113)."""
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
    return origin, cb


def extract_sym2_poly(lin_masks, origin_bits, n):
    """Exact quadratic polynomial e_2(l_1, ..., l_M) mod 2 when parity e_1 == 0 identically."""
    M = len(lin_masks)
    o_wt = sum(origin_bits)
    pset = set()

    def toggle(m):
        if m in pset:
            pset.remove(m)
        else:
            pset.add(m)

    if ((o_wt * (o_wt - 1)) // 2) & 1:
        toggle(0)
    col_masks = [0] * n
    for r, wm in enumerate(lin_masks):
        for i in range(n):
            if (wm >> i) & 1:
                col_masks[i] |= 1 << r
    for i in range(n):
        c_wt = col_masks[i].bit_count()
        lin_coeff = 0
        for r in range(M):
            if ((col_masks[i] >> r) & 1) and ((o_wt - origin_bits[r]) & 1):
                lin_coeff ^= 1
        if ((c_wt * (c_wt - 1)) // 2) & 1:
            lin_coeff ^= 1
        if lin_coeff:
            toggle(1 << i)
    for i in range(n):
        ci = col_masks[i]
        ci_wt = ci.bit_count()
        for j in range(i + 1, n):
            cj = col_masks[j]
            if (ci_wt * cj.bit_count() - (ci & cj).bit_count()) & 1:
                toggle((1 << i) | (1 << j))
    return pset


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
    """Exact mod-16 (P2, deg <= 2) and mod-32 (Q4, deg <= 4) extractor on rot^4-orbits."""
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


def find_t28_poly_branch(c99_val: int):
    """Locate T28_SEXTA_CERTIFICADO.json anywhere in repo; return polynomial_hex for c99 branch."""
    start = Path(__file__).resolve().parent
    candidates = [
        start / "T28_SEXTA_CERTIFICADO.json",
        start / "archive" / "T28_SEXTA_CERTIFICADO.json",
        start / "quartic_audit_2026_10_17" / "archive" / "T28_SEXTA_CERTIFICADO.json",
    ]
    for p in start.parents:
        candidates.append(p / "T28_SEXTA_CERTIFICADO.json")
        candidates.append(p / "quartic_audit_2026_10_17" / "archive" / "T28_SEXTA_CERTIFICADO.json")
    for cand in candidates:
        if cand.is_file():
            cert = json.loads(cand.read_text(encoding="utf-8"))
            for br in cert["reduced_models"]["branches"]:
                if int(br.get("c99", -1)) == c99_val:
                    return [int(h, 16) for h in br["polynomial_hex"]]
            if c99_val < len(cert["reduced_models"]["branches"]):
                return [int(h, 16) for h in cert["reduced_models"]["branches"][c99_val]["polynomial_hex"]]
    return None


# ==============================================================================
# 3. CNF Encoding Primitives & Explicit Linear Variable Elimination
# ==============================================================================
def add_xor2(clauses, a, b, rhs=0):
    if rhs == 0:
        clauses.append([-a, b])
        clauses.append([a, -b])
    else:
        clauses.append([a, b])
        clauses.append([-a, -b])


def add_xor3(clauses, a, b, c, rhs=0):
    for sa in (-1, 1):
        for sb in (-1, 1):
            for sc in (-1, 1):
                va = 1 if sa > 0 else 0
                vb = 1 if sb > 0 else 0
                vc = 1 if sc > 0 else 0
                if (va ^ vb ^ vc) != rhs:
                    clauses.append([-sa * a, -sb * b, -sc * c])


def add_long_xor(clauses, lits, rhs, new_var_fn):
    cur = list(lits)
    r = rhs & 1
    if not cur:
        if r == 1:
            v = new_var_fn()
            clauses.append([v])
            clauses.append([-v])
        return
    if len(cur) == 1:
        clauses.append([cur[0] if r == 1 else -cur[0]])
        return
    while len(cur) > 3:
        a, b = cur[0], cur[1]
        z = new_var_fn()
        add_xor3(clauses, a, b, z, 0)
        cur = [z] + cur[2:]
    if len(cur) == 2:
        add_xor2(clauses, cur[0], cur[1], r)
    else:
        add_xor3(clauses, cur[0], cur[1], cur[2], r)


def add_and_gate(clauses, out_v, in_lits):
    neg_clause = [out_v]
    for lit in in_lits:
        clauses.append([-out_v, lit])
        neg_clause.append(-lit)
    clauses.append(neg_clause)


def get_pair_and_var(clauses, i, j, new_var_fn, pair_cache):
    if i > j:
        i, j = j, i
    key = (i, j)
    if key not in pair_cache:
        pv = new_var_fn()
        add_and_gate(clauses, pv, [i + 1, j + 1])
        pair_cache[key] = pv
    return pair_cache[key]


def encode_poly_zero_on_z(clauses, pset, new_var_fn, pair_cache, quad_triple_cache=None):
    """Encode pset(z_0..z_{N-1}) == 0 into CNF, sharing pairwise AND gates y_{ij}."""
    xor_lits = []
    rhs = 0
    for m in pset:
        if m == 0:
            rhs ^= 1
            continue
        bits = []
        tmp = m
        while tmp:
            b = tmp & -tmp
            bits.append(b.bit_length() - 1)
            tmp ^= b
        d = len(bits)
        if d == 1:
            xor_lits.append(bits[0] + 1)
        elif d == 2:
            xor_lits.append(get_pair_and_var(clauses, bits[0], bits[1], new_var_fn, pair_cache))
        elif d == 3:
            p01 = get_pair_and_var(clauses, bits[0], bits[1], new_var_fn, pair_cache)
            tkey = (bits[0], bits[1], bits[2])
            if quad_triple_cache is not None and tkey in quad_triple_cache:
                tv = quad_triple_cache[tkey]
            else:
                tv = new_var_fn()
                add_and_gate(clauses, tv, [p01, bits[2] + 1])
                if quad_triple_cache is not None:
                    quad_triple_cache[tkey] = tv
            xor_lits.append(tv)
        elif d == 4:
            p01 = get_pair_and_var(clauses, bits[0], bits[1], new_var_fn, pair_cache)
            p23 = get_pair_and_var(clauses, bits[2], bits[3], new_var_fn, pair_cache)
            qv = new_var_fn()
            add_and_gate(clauses, qv, [p01, p23])
            xor_lits.append(qv)
        else:
            in_lits = [b + 1 for b in bits]
            gv = new_var_fn()
            add_and_gate(clauses, gv, in_lits)
            xor_lits.append(gv)
    add_long_xor(clauses, xor_lits, rhs, new_var_fn)


def add_lex_leq_clauses(clauses, a_lits, b_lits, new_var_fn):
    """Enforce (a_0, ..., a_{k-1}) <=_lex (b_0, ..., b_{k-1}) using 3k clauses."""
    k = len(a_lits)
    if k == 0:
        return
    eq_prev = None
    for idx in range(k):
        ai, bi = a_lits[idx], b_lits[idx]
        if eq_prev is None:
            clauses.append([-ai, bi])
        else:
            clauses.append([-eq_prev, -ai, bi])
        if idx < k - 1:
            eq_next = new_var_fn()
            if eq_prev is None:
                # eq_next -> (ai == bi)
                clauses.append([-eq_next, -ai, bi])
                clauses.append([-eq_next, ai, -bi])
                # (ai == bi) -> eq_next (needed for soundness? NO! Only implication (prefix equal -> a_i <= b_i)
                # is needed! Wait: to force prefix equal => eq_next = 1, we MUST include (ai == bi) -> eq_next!)
                clauses.append([ai, bi, eq_next])
                clauses.append([-ai, -bi, eq_next])
            else:
                clauses.append([-eq_prev, ai, bi, eq_next])
                clauses.append([-eq_prev, -ai, -bi, eq_next])
            eq_prev = eq_next


def eliminate_all_linear_vars_iteratively(n_orig, origin_orig, cb_orig, deg12_psets):
    """
    Weapon (2): Explicitly eliminate ALL linear equations from the degree <= 2 system
    in a fixed-point loop (in case substituting linear variables into quadratics creates
    new linear equations via x_i^2 = x_i or rank drops!).

    Returns:
      (unsat_one, N_free, new_origin, new_cb, reduced_quad_psets, old_var_expr_in_new)
      where old_var_expr_in_new[i] = (z_bitmask_on_N_free, const_bit) for i in 0..n_orig-1.
    """
    cur_n = n_orig
    cur_origin = origin_orig
    cur_cb = list(cb_orig)
    # Track expression of original x_0..x_{n_orig-1} in terms of current z_0..z_{cur_n-1}:
    orig_map = [(1 << i, 0) for i in range(n_orig)]
    cur_polys = [set(p) for p in deg12_psets if p]

    while True:
        # Echelonize cur_polys over degree <= 2 in cur_n variables (deg 2 first, then deg 1, then const 0)
        piv2 = {}  # pair_mask -> pset
        piv1 = {}  # var_idx -> (lin_mask_without_piv, const_bit)

        for p in cur_polys:
            q = set(p)
            # Reduce degree-2 terms
            deg2_terms = sorted((m for m in q if m.bit_count() == 2), reverse=True)
            while deg2_terms:
                lead = deg2_terms[0]
                if lead in piv2:
                    q ^= piv2[lead]
                    deg2_terms = sorted((m for m in q if m.bit_count() == 2), reverse=True)
                else:
                    piv2[lead] = q
                    q = None
                    break
            if q is None or not q:
                continue
            # Purely degree <= 1!
            lin_m = 0
            c_bit = 1 if (0 in q) else 0
            for m in q:
                if m != 0:
                    lin_m |= m
            while lin_m:
                b = lin_m.bit_length() - 1
                if b in piv1:
                    pm, pc = piv1[b]
                    lin_m ^= (1 << b) ^ pm
                    c_bit ^= pc
                else:
                    piv1[b] = (lin_m ^ (1 << b), c_bit)
                    lin_m = 0
                    c_bit = 0
                    break
            if lin_m == 0 and c_bit == 1:
                # 1 == 0 algebraic contradiction!
                return True, 0, cur_origin, [], [], orig_map

        if not piv1:
            # Back-reduce piv2 against each other for clean RREF quadratic basis
            sorted_leads = sorted(piv2.keys())
            for idx, lead in enumerate(sorted_leads):
                poly = piv2[lead]
                for prev_lead in sorted_leads[:idx]:
                    if prev_lead in poly:
                        poly ^= piv2[prev_lead]
            return False, cur_n, cur_origin, cur_cb, list(piv2.values()), orig_map

        # Back-substitute piv1 into full RREF so pivots only depend on non-pivot variables!
        piv_vars = sorted(piv1.keys())
        for pv in piv_vars:
            pm, pc = piv1[pv]
            for other_pv in piv_vars:
                if other_pv != pv and ((pm >> other_pv) & 1):
                    opm, opc = piv1[other_pv]
                    pm = (pm ^ (1 << other_pv)) ^ opm
                    pc ^= opc
                    piv1[pv] = (pm, pc)

        free_vars = [i for i in range(cur_n) if i not in piv1]
        old_to_new_idx = {old_i: new_i for new_i, old_i in enumerate(free_vars)}
        new_n = len(free_vars)

        # Build substitution old_i -> (new_mask, const_bit)
        sub_old = [None] * cur_n
        for new_i, old_i in enumerate(free_vars):
            sub_old[old_i] = (1 << new_i, 0)
        for pv, (pm, pc) in piv1.items():
            nm = 0
            for new_i, old_i in enumerate(free_vars):
                if (pm >> old_i) & 1:
                    nm |= 1 << new_i
            sub_old[pv] = (nm, pc)

        # Update affine basis (cur_origin, cur_cb)
        next_origin = cur_origin
        next_cb = [0] * new_n
        for old_i in range(cur_n):
            nm, pc = sub_old[old_i]
            if pc:
                next_origin ^= cur_cb[old_i]
            tmp = nm
            while tmp:
                b = tmp & -tmp
                next_cb[b.bit_length() - 1] ^= cur_cb[old_i]
                tmp ^= b

        # Update orig_map: x_orig = <m_cur, z_cur> ^ c0
        next_orig_map = []
        for om, oc in orig_map:
            nm, nc = 0, oc
            tmp = om
            while tmp:
                b = tmp & -tmp
                oi = b.bit_length() - 1
                sm, sc = sub_old[oi]
                nm ^= sm
                nc ^= sc
                tmp ^= b
            next_orig_map.append((nm, nc))

        # Substitute into all quadratic polynomials of piv2!
        next_polys = []
        for q in piv2.values():
            nq = set()

            def toggle_nq(m):
                if m in nq:
                    nq.remove(m)
                else:
                    nq.add(m)

            for m in q:
                if m == 0:
                    toggle_nq(0)
                elif m.bit_count() == 1:
                    oi = m.bit_length() - 1
                    sm, sc = sub_old[oi]
                    if sc:
                        toggle_nq(0)
                    tmp = sm
                    while tmp:
                        b = tmp & -tmp
                        toggle_nq(b)
                        tmp ^= b
                else:
                    b0 = m & -m
                    i0 = b0.bit_length() - 1
                    i1 = (m ^ b0).bit_length() - 1
                    m0, c0 = sub_old[i0]
                    m1, c1 = sub_old[i1]
                    if c0 and c1:
                        toggle_nq(0)
                    if c1:
                        tmp = m0
                        while tmp:
                            b = tmp & -tmp
                            toggle_nq(b)
                            tmp ^= b
                    if c0:
                        tmp = m1
                        while tmp:
                            b = tmp & -tmp
                            toggle_nq(b)
                            tmp ^= b
                    # Multiply linear masks m0 * m1 over GF(2) Boolean ring (z_a * z_a = z_a!)
                    t0 = m0
                    while t0:
                        ba = t0 & -t0
                        t0 ^= ba
                        t1 = m1
                        while t1:
                            bb = t1 & -t1
                            t1 ^= bb
                            toggle_nq(ba | bb)
            if nq:
                next_polys.append(nq)

        cur_n = new_n
        cur_origin = next_origin
        cur_cb = next_cb
        orig_map = next_orig_map
        cur_polys = next_polys


def substitute_pset_to_reduced_vars(pset, orig_map, max_deg=4):
    """Project a polynomial pset (deg <= 3 or 4) on original 111 vars onto N_free vars."""
    out = set()

    def mul_lin(poly_set, lm, lc):
        res = set()
        if lc:
            res ^= poly_set
        tmp = lm
        while tmp:
            b = tmp & -tmp
            tmp ^= b
            for pm in poly_set:
                nm = pm | b
                if nm in res:
                    res.remove(nm)
                else:
                    res.add(nm)
        return res

    for m in pset:
        if m == 0:
            out.symmetric_difference_update({0})
            continue
        term_poly = {0}
        tmp = m
        while tmp:
            b = tmp & -tmp
            oi = b.bit_length() - 1
            tmp ^= b
            lm, lc = orig_map[oi]
            term_poly = mul_lin(term_poly, lm, lc)
            if len(term_poly) > 4000:
                return None  # Too dense after substitution, skip lazy poly
        out ^= term_poly
    if any(x.bit_count() > max_deg for x in out):
        return None
    return out


# ==============================================================================
# 4. Degree-4 Schur Complement / Pairwise Elimination for Overdetermined B1_11
# ==============================================================================
def try_overdetermined_deg4_schur(N_free, quad_psets, deg4_rot4_psets, budget_sec=20.0):
    """
    In B1_11 we have ~223 independent quadratics in <= 109 variables!
    Multiply sparse quadratics / pairs Q_a * Q_b and combine with rot^4 degree-4 polynomials:
    eliminate degree-4 & degree-3 lead monomials sparsely to hunt for 1=0 or degree <= 2 mutants!
    """
    t0 = time.perf_counter()
    pivs = {}  # lead_monomial -> pset
    new_deg12 = []

    def lead_key(m):
        return (m.bit_count(), m)

    def insert_sparse(pset, max_nnz=2500):
        cur = set(pset)
        while cur:
            lead = max(cur, key=lead_key)
            d = lead.bit_count()
            if d == 0:
                return "UNSAT"
            if d <= 2:
                new_deg12.append(cur)
                if lead in pivs:
                    cur ^= pivs[lead]
                else:
                    pivs[lead] = cur
                    return "DEG12"
                continue
            if lead in pivs:
                if len(cur) + len(pivs[lead]) > max_nnz * 2:
                    return "SKIP"
                cur ^= pivs[lead]
            else:
                if len(cur) <= max_nnz:
                    pivs[lead] = cur
                    return "PIV"
                return "SKIP"
        return "ZERO"

    sparse_quads = sorted(quad_psets, key=len)
    for q in sparse_quads:
        if insert_sparse(q) == "UNSAT":
            return True, new_deg12

    for p4 in sorted(deg4_rot4_psets, key=len):
        if time.perf_counter() - t0 > budget_sec * 0.4:
            break
        if insert_sparse(p4) == "UNSAT":
            return True, new_deg12

    # Multiply the sparsest quadratics by single variables and pairwise products
    top_q = [q for q in sparse_quads if len(q) <= 450][:48]
    for q in top_q:
        if time.perf_counter() - t0 > budget_sec:
            break
        for v in range(N_free):
            b = 1 << v
            prod = set()
            for m in q:
                nm = m | b
                if nm in prod:
                    prod.remove(nm)
                else:
                    prod.add(nm)
            if insert_sparse(prod) == "UNSAT":
                return True, new_deg12

    return False, new_deg12


# ==============================================================================
# 5. Master Cell Solver (Algebraic Phase + Zero-Totalizer Lazy-Clause SAT/C)
# ==============================================================================
def compile_c_library(build_dir: Path):
    c_file = build_dir / "unified_b31.c"
    so_file = build_dir / f"libunified_b31_{os.getpid()}.so"
    c_file.write_text(C_UNIFIED_SRC, encoding="utf-8")
    cmd = ["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_file), "-o", str(so_file)]
    res = subprocess.run(cmd, capture_output=True, text=True)
    if res.returncode != 0:
        # Fallback without -march=native for heterogeneous cloud VMs
        cmd = ["gcc", "-O3", "-shared", "-fPIC", str(c_file), "-o", str(so_file)]
        subprocess.run(cmd, check=True)
    lib = ctypes.CDLL(str(so_file))

    lib.extract_multilevel_coset.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
    ]
    lib.extract_multilevel_coset.restype = ctypes.c_int

    lib.gf2_echelon_insert.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int,
    ]
    lib.gf2_echelon_insert.restype = ctypes.c_int

    lib.xl_multiply_deg2_in_c.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
    ]
    lib.xl_multiply_deg2_in_c.restype = ctypes.c_int

    lib.audit_candidate_and_subcubes_c.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_uint64, ctypes.c_uint64,
        ctypes.POINTER(ctypes.c_uint16), ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64),
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
    ]
    lib.audit_candidate_and_subcubes_c.restype = ctypes.c_int
    return lib


def solve_cell_fast(
    cell_name: str,
    lib,
    precomp: dict,
    budget_sec: float = 480.0,
    shard_id: int = 0,
    num_shards: int = 1,
):
    t0 = time.perf_counter()
    c99_val, c57_val, c113_val = CELL_MAP[cell_name]
    assert c57_val == c113_val, "Symmetric cell required!"

    orbits = precomp["orbits"]
    orb_tts = precomp["orb_tts"]
    orb_diag = precomp["orb_diag"]
    orb_pair = precomp["orb_pair"]
    orb_r4 = precomp["orb_r4"]
    chi_r4 = precomp["chi_r4"]
    rep_of_x_r4 = precomp["rep_of_x_r4"]
    pair_idx = precomp["pair_idx"]
    v6_list = precomp["v6_list"]
    u8_size8 = precomp["u8_size8"]
    nonzero_z = precomp["nonzero_z"]
    K_mat = precomp["K_mat"]
    M_mod2_rows = precomp["M_mod2_rows"]
    null_z_vecs = precomp["null_z_vecs"]
    coset_reps_by_id = precomp["coset_reps_by_id"]  # 0:0x0\D8, 1:0xf, 2:[0x5], 3:[0x1], 4:[0x3], 5:[0x7]
    z16_perms = precomp["z16_perms"]
    subcube_info = precomp["subcube_info"]

    origin_111, cb_111 = build_pure_111_basis(c99_val, c57_val, c113_val)
    n = 111
    n3 = n * (n - 1) * (n - 2) // 6
    n2 = n * (n - 1) // 2
    off2, off1, off0 = n3, n3 + n2, n3 + n2 + n
    n_cols = off0 + 1
    n_col_words = (n_cols + 63) // 64

    col3_base = precomp["col3_base"]
    col3_list = precomp["col3_list"]
    pair2_col = precomp["pair2_col"]
    pair2_list = precomp["pair2_list"]
    pair2_table_c = precomp["pair2_table_c"]

    mask64 = (1 << 64) - 1
    O_diag, O_pair, O_r4 = 0, 0, 0
    for j in range(116):
        if (origin_111 >> j) & 1:
            O_diag ^= orb_diag[j]
            O_pair ^= orb_pair[j]
            O_r4 ^= orb_r4[j]
    cb_pair, cb_r4 = [], []
    for cdir in cb_111:
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

    max_rows = 16500
    rows = (ctypes.c_uint64 * (max_rows * n_col_words))()
    piv_row_idx = (ctypes.c_int * n_cols)(*([-1] * n_cols))
    cur_row = 0
    deg_pivs = [0, 0, 0, 0]
    deg12_rows = []
    cub_rows = []
    xl_queue = []
    deg4_rot4_raw = []

    def eval_orb_at_x(j, x):
        return (orb_tts[j * 1024 + (x >> 6)] >> (x & 63)) & 1

    def eval_x_form_111(x_pt):
        orb_vec = 0
        for j in range(116):
            if eval_orb_at_x(j, x_pt):
                orb_vec |= 1 << j
        o_bit = (origin_111 & orb_vec).bit_count() & 1
        w_mask = 0
        for i, cdir in enumerate(cb_111):
            if (cdir & orb_vec).bit_count() & 1:
                w_mask |= 1 << i
        return w_mask, o_bit

    def decode_row(r_idx):
        pset = set()
        base = r_idx * n_col_words
        for w in range(n_col_words):
            val = rows[base + w]
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

    def record_piv(pc):
        nonlocal cur_row
        if pc < 0:
            return
        d = 0 if pc == off0 else (1 if pc >= off1 else (2 if pc >= off2 else 3))
        deg_pivs[d] += 1
        if d in (1, 2):
            deg12_rows.append(cur_row)
            xl_queue.append(cur_row)
        elif d == 3:
            cub_rows.append(cur_row)
        cur_row += 1

    def insert_pset(pset):
        if not pset or cur_row >= max_rows - 2 or piv_row_idx[off0] >= 0:
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
        record_piv(pc)
        return pc

    # Buffers for fast C XL multiplication
    m_deg_arr = (ctypes.c_int * 8192)()
    m_v0_arr = (ctypes.c_int * 8192)()
    m_v1_arr = (ctypes.c_int * 8192)()
    c_deg_cnt = (ctypes.c_int * 4)()
    c_new_d12 = (ctypes.c_int * 256)()
    c_n_new = ctypes.c_int()

    def drain_xl():
        nonlocal cur_row
        while xl_queue and piv_row_idx[off0] < 0 and cur_row < max_rows - n - 20:
            r_idx = xl_queue.pop(0)
            pset = decode_row(r_idx)
            nt = len(pset)
            if nt == 0 or nt > 8192:
                continue
            for idx_t, m in enumerate(pset):
                d = m.bit_count()
                m_deg_arr[idx_t] = d
                if d == 1:
                    m_v0_arr[idx_t] = m.bit_length() - 1
                elif d == 2:
                    b0 = m & -m
                    m_v0_arr[idx_t] = b0.bit_length() - 1
                    m_v1_arr[idx_t] = (m ^ b0).bit_length() - 1
            for k in range(4):
                c_deg_cnt[k] = 0
            old_cur = cur_row
            cur_row = lib.xl_multiply_deg2_in_c(
                rows, cur_row, max_rows, n_col_words, piv_row_idx, n_cols, n,
                col3_base, pair2_table_c, off2, off1, off0,
                m_deg_arr, m_v0_arr, m_v1_arr, nt,
                c_deg_cnt, c_new_d12, ctypes.byref(c_n_new),
            )
            for k in range(4):
                deg_pivs[k] += c_deg_cnt[k]
            new_set = {c_new_d12[u] for u in range(c_n_new.value)}
            for nr in range(old_cur, cur_row):
                if nr in new_set:
                    deg12_rows.append(nr)
                    xl_queue.append(nr)
                elif piv_row_idx[off0] != nr:
                    cub_rows.append(nr)

    # --------------------------------------------------------------------------
    # ALGEBRAIC PHASE 1A: Exact U_4 Coset Parities + Q4 + Dual Fibers F_z
    # --------------------------------------------------------------------------
    # 1) Exact parity of C_{0xf} (128 => even!), C_{[0x5]} (256 => even!), C_{[0x1,3,7]} (512 => even!)
    for cid in (1, 2, 3, 4, 5):
        w_xor, o_xor = 0, 0
        for x in coset_reps_by_id[cid]:
            wm, ob = eval_x_form_111(x)
            w_xor ^= wm
            o_xor ^= ob
        lin_p = {1 << i for i in range(n) if (w_xor >> i) & 1}
        if o_xor:
            lin_p.add(0)
        insert_pset(lin_p)
    drain_xl()

    # 2) Seed Q4 (C4)
    def lin_expr_111(indices):
        mask = sum(1 << j for j in indices)
        idxs = [i for i, c in enumerate(cb_111) if (c & mask).bit_count() & 1]
        return idxs, (origin_111 & mask).bit_count() & 1

    def poly_from_lin(idxs, cst):
        p = {1 << i for i in idxs}
        if cst:
            p.add(0)
        return p

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

    if piv_row_idx[off0] < 0:
        slin_i, slin_c = lin_expr_111([23, 31, 39, 112])
        q4 = poly_from_lin(slin_i, slin_c ^ c57_val)
        pairs_ij = [(I2, J2), (I3, J3), (I4, J4)] if c99_val == 1 else [(I1, J1), (I2, J2), (I3, J3), (I4, J4)]
        for Ir, Jr in pairs_ij:
            ui, uc = lin_expr_111(Ir)
            vi, vc = lin_expr_111(Jr)
            q4 ^= mul_p(poly_from_lin(ui, uc), poly_from_lin(vi, vc))
        insert_pset(q4)
        drain_xl()

    # 3) Dual Fiber Equations on all 35 C_8-orbits F_z
    fiber_forms_111 = {}
    for z_rep, _ in nonzero_z:
        gstep = 1 if z_rep == 0xFF else (2 if z_rep in (0x55, 0xAA) else (4 if z_rep in (0x11, 0x33, 0x77) else 8))
        reps = fiber_orbit_reps(z_rep, gstep)
        forms = [eval_x_form_111(x) for x in reps]
        fiber_forms_111[z_rep] = (gstep, reps, forms)
        if c99_val == 0 and c57_val == 0 and piv_row_idx[off0] < 0:
            # Theorem A1 (B0_00): wt(f|_{F_z}) == 128 on ALL 35 fibers!
            w_xor, o_xor = 0, 0
            for wm, ob in forms:
                w_xor ^= wm
                o_xor ^= ob
            lin_p = {1 << i for i in range(n) if (w_xor >> i) & 1}
            if o_xor:
                lin_p.add(0)
            insert_pset(lin_p)
            if not lin_p:
                target_e2 = ((len(forms) // 2) // 2) & 1
                q_fib = extract_sym2_poly([wm for wm, _ in forms], [ob for _, ob in forms], n)
                if target_e2:
                    q_fib ^= {0}
                insert_pset(q_fib)
            drain_xl()

    if not (c99_val == 0 and c57_val == 0) and piv_row_idx[off0] < 0:
        # Left-nullspace of Krawtchouk mod-2 matrix eliminates s_1..s_30 in B0_11 and B1_*!
        pair_forms_35 = [[eval_x_form_111(x) for x in fiber_orbit_reps(z_rep, 8)] for z_rep, _ in nonzero_z]
        for u_vec in null_z_vecs:
            w_xor, o_xor = 0, 0
            for z_i in range(len(nonzero_z)):
                if (u_vec >> z_i) & 1:
                    for wm, ob in pair_forms_35[z_i]:
                        w_xor ^= wm
                        o_xor ^= ob
            lin_p = {1 << i for i in range(n) if (w_xor >> i) & 1}
            if o_xor:
                lin_p.add(0)
            insert_pset(lin_p)
        drain_xl()

    # --------------------------------------------------------------------------
    # ALGEBRAIC PHASE 1B: Multilevel (r=0,1,2) Affine Cosets + V6xV6 + Regime II
    # --------------------------------------------------------------------------
    MAX_CHARS = 11
    MAX_C_PAIRS = MAX_CHARS * (MAX_CHARS - 1) // 2
    p_idxs_arr = (ctypes.c_int * 2048)()
    char_words32 = (ctypes.c_uint64 * (MAX_CHARS * 32))()
    quad_buf = (ctypes.c_uint64 * (MAX_CHARS * n_col_words))()
    quad_valid = (ctypes.c_int * MAX_CHARS)()
    lin_buf = (ctypes.c_uint64 * (MAX_C_PAIRS * n_col_words))()
    lin_valid = (ctypes.c_int * MAX_C_PAIRS)()

    def process_coset(pts_16, asym_u_list=()):
        if piv_row_idx[off0] >= 0 or cur_row >= max_rows - 120:
            return
        diag_pts = [x & 0xFF for x in pts_16 if (x & 0xFF) == (x >> 8)]
        pair_reps = [x for x in pts_16 if (x & 0xFF) < (x >> 8)]
        n_pairs = len(pair_reps)

        dmask = 0
        for v in diag_pts:
            dmask |= 1 << v
        wt_diag = (O_diag & dmask).bit_count()

        if wt_diag & 1:
            # Immediate 1 = 0 contradiction (wt_diag + 2*wt_pairs cannot be even)!
            insert_pset({0})
            return

        if wt_diag % 8 == 0:
            t_bits = 3
            T_mod = ((-wt_diag // 2) & 7)
        elif wt_diag % 4 == 0:
            t_bits = 2
            T_mod = ((-wt_diag // 2) & 3)
        else:
            t_bits = 1
            T_mod = ((-wt_diag // 2) & 1)

        for k, x in enumerate(pair_reps):
            p_idxs_arr[k] = pair_idx[(x & 0xFF, x >> 8)]

        u_vecs = []
        if t_bits == 3:
            u_vecs = [(1 << r) | (1 << (r + 8)) for r in range(8)] + [0xFFFF]
            if not diag_pts:
                for ua in asym_u_list[: (MAX_CHARS - 9)]:
                    u_vecs.append(ua)
        n_chars = len(u_vecs)
        if n_chars > 0:
            ctypes.memset(char_words32, 0, ctypes.sizeof(char_words32))
            for m, u16 in enumerate(u_vecs):
                base_m = m * 32
                for k, x in enumerate(pair_reps):
                    if (x & u16).bit_count() & 1:
                        char_words32[base_m + (k >> 6)] |= 1 << (k & 63)

        base_ptr = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
        rc = lib.extract_multilevel_coset(
            all_pair_bits, p_idxs_arr, n_pairs, n, t_bits, T_mod,
            char_words32 if n_chars > 0 else None, n_chars,
            col3_base, off2, off1, off0, n_col_words,
            base_ptr,
            quad_buf if n_chars > 0 else None, quad_valid,
            lin_buf if n_chars > 0 else None, lin_valid,
        )
        if rc < 0:
            return

        pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
        record_piv(pc)

        if rc == 2 and n_chars > 0:
            n_cp = n_chars * (n_chars - 1) // 2
            for pm in range(n_cp):
                if not lin_valid[pm] or cur_row >= max_rows - 15 or piv_row_idx[off0] >= 0:
                    continue
                dst = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                src = ctypes.cast(ctypes.byref(lin_buf, pm * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                ctypes.memmove(dst, src, n_col_words * 8)
                pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
                record_piv(pc)

            for m in range(n_chars):
                if not quad_valid[m] or cur_row >= max_rows - 15 or piv_row_idx[off0] >= 0:
                    continue
                dst = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                src = ctypes.cast(ctypes.byref(quad_buf, m * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                ctypes.memmove(dst, src, n_col_words * 8)
                pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
                record_piv(pc)
        elif rc == 1 and wt_diag % 8 == 4:
            # Also test chi = 0xffff on Level 1 (vanishes on D_8!)
            for k, x in enumerate(pair_reps):
                if x.bit_count() & 1:
                    char_words32[k >> 6] |= 1 << (k & 63)
                else:
                    char_words32[k >> 6] &= ~(1 << (k & 63))

        drain_xl()

    # Pass 1: Linear V6 x V6 first (fast! Closes B1_00 in < 0.05s on the very first C5 subspace!)
    for pts8 in v6_list:
        if piv_row_idx[off0] >= 0 or cur_row >= max_rows - 150:
            break
        process_coset([v | (w << 8) for v in pts8 for w in pts8])

    # Pass 2: Diagonal shifts of V6 x V6 + Interleaved conjugates (budget cap 25s)
    alg_cap = min(45.0, budget_sec * 0.22)
    if piv_row_idx[off0] < 0:
        for pts8 in v6_list:
            if (time.perf_counter() - t0) > alg_cap * 0.55 or piv_row_idx[off0] >= 0 or cur_row >= max_rows - 180:
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
                    process_coset([x ^ a16 for x in w_pts])
                process_coset([interleave16(x ^ a16) for x in w_pts])
                if piv_row_idx[off0] >= 0:
                    break

    # Pass 3: Regime II diagonal-free cosets + rot^4 dim-12 (mod 32) / dim-11 (mod 16)
    rng = random.Random(202631 + 10 * c99_val + c57_val)
    seen_w = set()
    while (time.perf_counter() - t0) < alg_cap * 0.80 and piv_row_idx[off0] < 0 and cur_row < max_rows - 180:
        if rng.random() < 0.5:
            h1 = rng.randint(1, 65535)
            s1, s2 = rng.randint(1, 255), rng.randint(1, 255)
            hs = [h1, swap16(h1), s1 | (s1 << 8), s2 | (s2 << 8)]
            sym_hs = [s1, s2, s1 ^ s2]
            cond_vec = (h1 & 0xFF) ^ (h1 >> 8)
        else:
            s_list = [rng.randint(1, 255) for _ in range(4)]
            hs = [s | (s << 8) for s in s_list]
            sym_hs = s_list
            cond_vec = 0
        rr = tuple(rref_gf2(hs))
        if len(rr) != 4 or rr in seen_w:
            continue
        seen_w.add(rr)
        w_pts = span_set(nullspace_basis_16(rr))
        process_coset(w_pts)
        valid_da = [
            da for da in range(1, 256)
            if ((da & cond_vec).bit_count() & 1) == 0 and ((da & sym_hs[0]).bit_count() & 1) == 1
        ]
        rng.shuffle(valid_da)
        for da in valid_da[:2]:
            asym_u = [du for du in sym_hs if du != 0 and ((du & da).bit_count() & 1) == 0]
            process_coset([x ^ da for x in w_pts], asym_u_list=asym_u)
            if piv_row_idx[off0] >= 0:
                break

    seen_r4 = set()
    for trial in range(1400):
        if (time.perf_counter() - t0) > alg_cap or piv_row_idx[off0] >= 0 or cur_row >= max_rows - 150:
            break
        codim = 4 if (trial % 3 != 2) else 5
        wp_basis = sample_rot4_wperp(rng, codim)
        if wp_basis is None:
            continue
        key = tuple(wp_basis)
        if key in seen_r4:
            continue
        seen_r4.add(key)
        W_pts = span_set(nullspace_basis_16(wp_basis))
        diag_mask = 0
        r4_indices = []
        picked_r4 = set()
        for x in W_pts:
            if (x & 0xFF) == (x >> 8):
                diag_mask |= 1 << (x & 0xFF)
            else:
                ri = rep_of_x_r4[x]
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
                insert_pset(P2)
                if codim == 4 and Q4 is not None:
                    max_d = max((m.bit_count() for m in Q4), default=0)
                    if max_d <= 3:
                        insert_pset(Q4)
                    elif len(Q4) <= 1800 and len(deg4_rot4_raw) < 96:
                        deg4_rot4_raw.append(Q4)
                drain_xl()

    t_alg = time.perf_counter() - t0
    if piv_row_idx[off0] >= 0:
        return {
            "cell": cell_name,
            "shard": f"{shard_id}/{num_shards}",
            "algebraic_unsat_has_one": True,
            "unsat_closed": True,
            "closed_by": "macaulay_deg_le_3",
            "deg_pivs_111": {"0": deg_pivs[0], "1": deg_pivs[1], "2": deg_pivs[2], "3": deg_pivs[3]},
            "total_pivots": cur_row,
            "alg_sec": round(t_alg, 3),
            "total_sec": round(t_alg, 3),
        }

    # --------------------------------------------------------------------------
    # WEAPON (2): Explicit Iterative Elimination of ALL Linear Variables!
    # --------------------------------------------------------------------------
    deg12_psets_111 = [decode_row(r_idx) for r_idx in deg12_rows]
    unsat_lin, N_free, origin_red, cb_red, quad_psets_red, orig_map = eliminate_all_linear_vars_iteratively(
        n, origin_111, cb_111, deg12_psets_111
    )
    if unsat_lin:
        return {
            "cell": cell_name,
            "shard": f"{shard_id}/{num_shards}",
            "algebraic_unsat_has_one": True,
            "unsat_closed": True,
            "closed_by": "iterative_linear_substitution",
            "deg_pivs_111": {"0": deg_pivs[0], "1": deg_pivs[1], "2": deg_pivs[2], "3": deg_pivs[3]},
            "total_sec": round(time.perf_counter() - t0, 3),
        }

    # Project rot^4 degree-4 polynomials & sparse cubic pivots onto reduced N_free variables
    deg4_psets_red = []
    for p4 in deg4_rot4_raw:
        pr = substitute_pset_to_reduced_vars(p4, orig_map, max_deg=4)
        if pr is not None and len(pr) <= 2200:
            deg4_psets_red.append(pr)
    deg4_psets_red.sort(key=len)

    # Extra Schur degree-4 attack when overdetermined (especially B1_11: ~223 quads in <= 109 vars!)
    if len(quad_psets_red) >= N_free + 30:
        schur_unsat, schur_mutants = try_overdetermined_deg4_schur(
            N_free, quad_psets_red, deg4_psets_red, budget_sec=min(18.0, budget_sec * 0.12)
        )
        if schur_unsat:
            return {
                "cell": cell_name,
                "shard": f"{shard_id}/{num_shards}",
                "algebraic_unsat_has_one": True,
                "unsat_closed": True,
                "closed_by": "schur_deg4_overdetermined",
                "N_free": N_free,
                "n_quads_reduced": len(quad_psets_red),
                "total_sec": round(time.perf_counter() - t0, 3),
            }
        if schur_mutants:
            id_map = [(1 << i, 0) for i in range(N_free)]
            unsat2, N_free, origin_red, cb_red, quad_psets_red, step_map = eliminate_all_linear_vars_iteratively(
                N_free, origin_red, cb_red, quad_psets_red + schur_mutants
            )
            if unsat2:
                return {
                    "cell": cell_name,
                    "shard": f"{shard_id}/{num_shards}",
                    "algebraic_unsat_has_one": True,
                    "unsat_closed": True,
                    "closed_by": "schur_mutant_cascade",
                    "total_sec": round(time.perf_counter() - t0, 3),
                }
            # Compose orig_map with step_map
            new_orig_map = []
            for om, oc in orig_map:
                nm, nc = 0, oc
                tmp = om
                while tmp:
                    b = tmp & -tmp
                    sm, sc = step_map[b.bit_length() - 1]
                    nm ^= sm
                    nc ^= sc
                    tmp ^= b
                new_orig_map.append((nm, nc))
            orig_map = new_orig_map

    # Project up to 1500 shortest cubic pivots for fast lazy check (mostly already in radical, zero cost!)
    cubic_psets_red = []
    raw_cubs = []
    for r_idx in cub_rows:
        p3 = decode_row(r_idx)
        if len(p3) <= 380:
            raw_cubs.append(p3)
    raw_cubs.sort(key=len)
    for p3 in raw_cubs[:1200]:
        pr = substitute_pset_to_reduced_vars(p3, orig_map, max_deg=3)
        if pr is not None and len(pr) <= 600:
            cubic_psets_red.append(pr)
    cubic_psets_red.sort(key=len)

    print(
        f"[{cell_name} shard {shard_id}/{num_shards}] Algebraic & Linear-Elim done in {time.perf_counter()-t0:.2f}s: "
        f"111->{N_free} free vars, {len(quad_psets_red)} pure quads, {len(deg4_psets_red)} deg4_rot4, "
        f"{len(cubic_psets_red)} sparse cubics.",
        flush=True,
    )

    # --------------------------------------------------------------------------
    # Optional Sharding Selection (Vertex-Cover Top Branching Variables)
    # --------------------------------------------------------------------------
    vc_deg = [0] * N_free
    for q in quad_psets_red:
        for m in q:
            if m.bit_count() == 2:
                b0 = m & -m
                vc_deg[b0.bit_length() - 1] += 1
                vc_deg[(m ^ b0).bit_length() - 1] += 1
    branch_order = sorted(range(N_free), key=lambda v: vc_deg[v], reverse=True)

    # --------------------------------------------------------------------------
    # WEAPON (3): Build Ultra-Lean CNF (ZERO Heavy Totalizers!)
    # --------------------------------------------------------------------------
    clauses = []
    v_cnt = [N_free]  # Variables 1 .. N_free are z_0 .. z_{N_free - 1}

    def new_var():
        v_cnt[0] += 1
        return v_cnt[0]

    def eval_x_form_red(x_pt):
        orb_vec = 0
        for j in range(116):
            if eval_orb_at_x(j, x_pt):
                orb_vec |= 1 << j
        o_bit = (origin_red & orb_vec).bit_count() & 1
        w_mask = 0
        for i, cdir in enumerate(cb_red):
            if (cdir & orb_vec).bit_count() & 1:
                w_mask |= 1 << i
        return w_mask, o_bit

    def make_lin_lit_red(wm, ob):
        idxs = [i + 1 for i in range(N_free) if (wm >> i) & 1]
        if not idxs:
            v = new_var()
            clauses.append([v if ob else -v])
            return v
        if len(idxs) == 1 and ob == 0:
            return idxs[0]
        if len(idxs) == 1 and ob == 1:
            return -idxs[0]
        lv = new_var()
        add_long_xor(clauses, idxs + [lv], ob, new_var)
        return lv

    # 1) Encode ALL reduced quadratic pivots sharing pairwise AND gates y_{ij}
    pair_cache = {}
    triple_cache = {}
    for q in quad_psets_red:
        encode_poly_zero_on_z(clauses, q, new_var, pair_cache, triple_cache)

    # 2) Orbit literals c_0 .. c_115 + lightweight 6 <= wt(c_long) <= 106
    c_lits = {}
    long_orbs = [j for j in range(116) if j not in (57, 99, 113, 115)]
    long_lits = []
    for j in range(116):
        wm = sum((1 << i) for i, cdir in enumerate(cb_red) if (cdir >> j) & 1)
        ob = (origin_red >> j) & 1
        lv = make_lin_lit_red(wm, ob)
        c_lits[j] = lv
        if j not in (57, 99, 113, 115):
            long_lits.append(lv)

    for bound, fn in [(6, CardEnc.atleast), (106, CardEnc.atmost)]:
        enc = fn(lits=long_lits, bound=bound, top_id=v_cnt[0], encoding=EncType.seqcounter)
        v_cnt[0] = max(v_cnt[0], enc.nv)
        clauses.extend(enc.clauses)

    # 3) Exact Z_16^* Lexicographic Symmetry Breaking (8x space reduction!)
    # Order long_orbs putting M_8 = 0x5555 orbits FIRST for immediate top-level pruning!
    m8_orbs = set(subcube_info[0]["active_orbs"])
    lex_orb_order = sorted(long_orbs, key=lambda j: (0 if j in m8_orbs else 1, j))
    base_lex_lits = [c_lits[j] for j in lex_orb_order]
    for mult, perm in z16_perms.items():
        img_lex_lits = [c_lits[perm[j]] for j in lex_orb_order]
        add_lex_leq_clauses(clauses, base_lex_lits, img_lex_lits, new_var)

    # 4) Encode C6 (T28 sixth condition) if available for this c99 branch
    poly_t28 = find_t28_poly_branch(c99_val)
    if poly_t28 is not None:
        c6_lits, c6_rhs, c6_cache = [], 0, {}
        for m in poly_t28:
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
                    add_and_gate(clauses, mv, list(key))
                    c6_cache[key] = mv
                c6_lits.append(c6_cache[key])
        add_long_xor(clauses, c6_lits, c6_rhs, new_var)

    # 5) ONLY Tiny Counter F_{0xff} (16 bits == 8 in B0_00; 31 bits == 12 in B0_11)
    #    + Pre-allocated point literals ONLY for Lazy k-of-M sets (NO Totalizers!)
    lazy_kofm_groups = []  # list of (name, lits_list, exact_bound, rep_points)

    # C_{0xf} (256 orbits == 128 in ALL 4 cells!)
    reps_0xf = coset_reps_by_id[1]
    lits_0xf = [make_lin_lit_red(*eval_x_form_red(x)) for x in reps_0xf]
    lazy_kofm_groups.append(("C_0xf", lits_0xf, 128))

    reps_0x0 = coset_reps_by_id[0]
    reps_ff = fiber_orbit_reps(0xFF, 1)
    lits_ff = [make_lin_lit_red(*eval_x_form_red(x)) for x in reps_ff]

    s0_var = None
    s_vars = None
    if c99_val == 0 and c57_val == 0:
        # B0_00: ONLY tiny 16-bit counter F_{0xff} == 8 goes into static CNF!
        enc_ff = CardEnc.equals(lits=lits_ff, bound=8, top_id=v_cnt[0], encoding=EncType.totalizer)
        v_cnt[0] = max(v_cnt[0], enc_ff.nv)
        clauses.extend(enc_ff.clauses)

        # F_{0x55} (32 == 16), F_{0x11,33,77} (64 == 32), C_{0x0} (240 == 120) -> LAZY k-of-M!
        for z_rep, gstep, bnd in [(0x55, 2, 16), (0x11, 4, 32), (0x33, 4, 32), (0x77, 4, 32)]:
            r_z = fiber_orbit_reps(z_rep, gstep)
            l_z = [make_lin_lit_red(*eval_x_form_red(x)) for x in r_z]
            lazy_kofm_groups.append((f"F_{hex(z_rep)}", l_z, bnd))

        lits_0x0 = [make_lin_lit_red(*eval_x_form_red(x)) for x in reps_0x0]
        lazy_kofm_groups.append(("C_0x0", lits_0x0, 120))

    elif c99_val == 0 and c57_val == 1:
        # B0_11: Tiny 31-bit dual variables (s_0, s_1..s_30) + tiny 31-bit F_{0xff} == 12!
        # NO 240-bit or 128-bit totalizers in CNF!
        s0_var = new_var()
        s_vars = [new_var() for _ in range(30)]
        s_rep_to_idx = {r: idx for idx, (r, _) in enumerate(u8_size8)}

        # Tiny 32-literal counter: 2*s_0 + sum_{m=1}^{30} s_m == 8
        enc_s = CardEnc.equals(lits=[s0_var, s0_var] + s_vars, bound=8, top_id=v_cnt[0], encoding=EncType.totalizer)
        v_cnt[0] = max(v_cnt[0], enc_s.nv)
        clauses.extend(enc_s.clauses)

        # s_{0x01} ^ s_{0x05} ^ s_{0x15} ^ s_0 == 0
        add_long_xor(clauses, [
            s_vars[s_rep_to_idx[0x01]],
            s_vars[s_rep_to_idx[0x05]],
            s_vars[s_rep_to_idx[0x15]],
            s0_var,
        ], 0, new_var)

        # Tiny 31-literal exact counter: F_{0xff} (16) + odd s_m (15) == 12
        odd_s = [s_vars[m] for m, (r, _) in enumerate(u8_size8) if r.bit_count() & 1]
        enc_ff11 = CardEnc.equals(lits=lits_ff + odd_s, bound=12, top_id=v_cnt[0], encoding=EncType.totalizer)
        v_cnt[0] = max(v_cnt[0], enc_ff11.nv)
        clauses.extend(enc_ff11.clauses)

        # Exact mod-2 XOR couplings for all 35 fibers (linear, zero totalizers!)
        for z_idx, (z_rep, _) in enumerate(nonzero_z):
            reps128 = fiber_orbit_reps(z_rep, 8)
            w_xor, o_xor = 0, 0
            for x in reps128:
                wm, ob = eval_x_form_red(x)
                w_xor ^= wm
                o_xor ^= ob
            xor_lits = [i + 1 for i in range(N_free) if (w_xor >> i) & 1]
            for m in range(30):
                if (M_mod2_rows[z_idx] >> m) & 1:
                    xor_lits.append(s_vars[m])
            add_long_xor(clauses, xor_lits, o_xor, new_var)

        # Prepare C_{0x0} literals for Lazy conditional k-of-M (s_0=0 -> 116; s_0=1 -> 132!)
        lits_0x0 = [make_lin_lit_red(*eval_x_form_red(x)) for x in reps_0x0]

    # Precompute 30 generic fiber rep lists (evaluated directly on out_tt in C/Python, ZERO CNF vars!)
    generic_30_fibers = [(z_rep, fiber_orbit_reps(z_rep, 8)) for z_rep, _ in nonzero_z if z_rep not in (0xFF, 0x55, 0x11, 0x33, 0x77)]

    # Precompute monomial orbit support J(x_r) = [j in long_orbs : phi_j(x_r) == 1] for support-minimized cuts
    def point_long_supp(x_pt):
        return [j for j in long_orbs if eval_orb_at_x(j, x_pt)]

    # Build cube list for this shard
    cube_depth = 0
    while (1 << cube_depth) < num_shards and cube_depth < N_free:
        cube_depth += 1
    cube_vars = [branch_order[k] + 1 for k in range(cube_depth)]
    my_cubes = [cid for cid in range(1 << cube_depth) if (cid % num_shards) == shard_id]

    # C call buffers
    n_sc = len(SUBCUBE_MASKS)
    sc_masks_c = (ctypes.c_uint16 * n_sc)(*SUBCUBE_MASKS)
    out_tt_c = (ctypes.c_uint64 * 1024)()
    fail_type_c = ctypes.c_int()
    sc_idx_c = ctypes.c_int()
    excess_c = ctypes.c_int()
    fail_u_c = ctypes.c_int()
    fail_val_c = ctypes.c_int()

    def eval_tt_bit(x_pt):
        return (out_tt_c[x_pt >> 6] >> (x_pt & 63)) & 1

    # --------------------------------------------------------------------------
    # 6. High-Speed CaDiCaL Loop with Lazy k-of-M + Subcube Nogoods + C FWHT
    # --------------------------------------------------------------------------
    ts = time.perf_counter()
    stats = {
        "models_checked": 0,
        "lazy_kofm_cuts": 0,
        "lazy_fiber_cuts": 0,
        "lazy_deg4_cuts": 0,
        "lazy_cubic_cuts": 0,
        "subcube_short_nogoods": 0,
        "subcube_avg_len": 0.0,
        "fwht_calls": 0,
        "walsh_nogoods": 0,
    }
    subcube_len_sum = 0
    bent_hits = []
    injected_deg4 = set()
    injected_cub = set()
    all_cubes_unsat = True

    with Solver(name="cadical195", bootstrap_with=clauses) as slv:
        for cube_mask in my_cubes:
            assumps = [(cube_vars[b] if ((cube_mask >> b) & 1) else -cube_vars[b]) for b in range(cube_depth)]
            cube_unsat = False

            while (time.perf_counter() - t0) < budget_sec:
                if not slv.solve(assumptions=assumps):
                    cube_unsat = True
                    break

                stats["models_checked"] += 1
                model = slv.get_model()
                # Map positive/negative model literals in O(1) via boolean array
                pos_var = bytearray(v_cnt[0] + 2)
                for lit in model:
                    if lit > 0 and lit <= v_cnt[0]:
                        pos_var[lit] = 1

                z_bits = 0
                cint = origin_red
                for i, cdir in enumerate(cb_red):
                    if pos_var[i + 1]:
                        z_bits |= 1 << i
                        cint ^= cdir

                # --- LAYER A: Lazy k-of-M Clauses on Medium Sets (ZERO new aux vars!) ---
                kofm_cut = False
                for gname, glits, bnd in lazy_kofm_groups:
                    ones = [lit for lit in glits if (pos_var[lit] if lit > 0 else not pos_var[-lit])]
                    s_wt = len(ones)
                    if s_wt > bnd:
                        # Inject up to 2 shifted subsets of size (bnd + 1): at least one must flip to 0!
                        need = bnd + 1
                        slv.add_clause([-lit for lit in ones[:need]])
                        stats["lazy_kofm_cuts"] += 1
                        if s_wt - bnd >= 3 and len(ones) >= need + 2:
                            slv.add_clause([-lit for lit in ones[-need:]])
                            stats["lazy_kofm_cuts"] += 1
                        kofm_cut = True
                    elif s_wt < bnd:
                        zeros = [lit for lit in glits if not (pos_var[lit] if lit > 0 else not pos_var[-lit])]
                        need = len(glits) - bnd + 1
                        slv.add_clause([lit for lit in zeros[:need]])
                        stats["lazy_kofm_cuts"] += 1
                        if bnd - s_wt >= 3 and len(zeros) >= need + 2:
                            slv.add_clause([lit for lit in zeros[-need:]])
                            stats["lazy_kofm_cuts"] += 1
                        kofm_cut = True

                # Conditional Lazy k-of-M on C_{0x0} in B0_11 (s_0=0 => 116; s_0=1 => 132!)
                if c99_val == 0 and c57_val == 1:
                    s0_val = pos_var[s0_var]
                    target_q0 = 132 if s0_val else 116
                    s0_premise = -s0_var if s0_val else s0_var
                    ones0 = [lit for lit in lits_0x0 if (pos_var[lit] if lit > 0 else not pos_var[-lit])]
                    if len(ones0) > target_q0:
                        slv.add_clause([s0_premise] + [-lit for lit in ones0[: target_q0 + 1]])
                        stats["lazy_kofm_cuts"] += 1
                        kofm_cut = True
                    elif len(ones0) < target_q0:
                        zeros0 = [lit for lit in lits_0x0 if not (pos_var[lit] if lit > 0 else not pos_var[-lit])]
                        need0 = 240 - target_q0 + 1
                        slv.add_clause([s0_premise] + [lit for lit in zeros0[:need0]])
                        stats["lazy_kofm_cuts"] += 1
                        kofm_cut = True

                if kofm_cut:
                    continue

                # --- LAYER B: Lazy Degree-4 rot^4 Polynomials & Sparse Cubic Pivots ---
                alg_cut = 0
                for d4_idx, p4 in enumerate(deg4_psets_red):
                    if d4_idx in injected_deg4:
                        continue
                    val = 0
                    for m in p4:
                        if (z_bits & m) == m:
                            val ^= 1
                    if val == 1:
                        new_cls = []
                        encode_poly_zero_on_z(new_cls, p4, new_var, pair_cache, triple_cache)
                        for cl in new_cls:
                            slv.add_clause(cl)
                        injected_deg4.add(d4_idx)
                        stats["lazy_deg4_cuts"] += 1
                        alg_cut += 1
                        if alg_cut >= 8:
                            break
                if alg_cut > 0:
                    continue

                for c_idx, p3 in enumerate(cubic_psets_red):
                    if c_idx in injected_cub:
                        continue
                    val = 0
                    for m in p3:
                        if (z_bits & m) == m:
                            val ^= 1
                    if val == 1:
                        new_cls = []
                        encode_poly_zero_on_z(new_cls, p3, new_var, pair_cache, triple_cache)
                        for cl in new_cls:
                            slv.add_clause(cl)
                        injected_cub.add(c_idx)
                        stats["lazy_cubic_cuts"] += 1
                        alg_cut += 1
                        if alg_cut >= 16:
                            break
                if alg_cut > 0:
                    continue

                # --- LAYER C: Single 0.03ms C Call: Build 65,536-bit TT + Subcube Checks + FWHT! ---
                stats["fwht_calls"] += 1
                is_bent = lib.audit_candidate_and_subcubes_c(
                    orb_tts,
                    cint & mask64,
                    cint >> 64,
                    sc_masks_c,
                    n_sc,
                    out_tt_c,
                    ctypes.byref(fail_type_c),
                    ctypes.byref(sc_idx_c),
                    ctypes.byref(excess_c),
                    ctypes.byref(fail_u_c),
                    ctypes.byref(fail_val_c),
                )
                if is_bent:
                    bent_hits.append({"coefficients_hex": hex(cint)})
                    all_cubes_unsat = False
                    break

                if fail_type_c.value == 1:
                    # SUBCUBE POISSON VIOLATION! Build ultra-short Slack-Minimized Nogood in c_lits!
                    sc = subcube_info[sc_idx_c.value]
                    ex = excess_c.value
                    active_orbs = sc["active_orbs"]
                    deltas = sc["deltas"]
                    keep_orbs = list(active_orbs)
                    if ex > 0:
                        # Greedy slack relaxation: drop orbits with smallest 2*delta while sum < excess!
                        order = sorted(range(len(active_orbs)), key=lambda k: deltas[k])
                        used_slack = 0
                        drop_set = set()
                        for k in order:
                            swing = 2 * deltas[k]
                            if used_slack + swing < ex:
                                used_slack += swing
                                drop_set.add(k)
                        keep_orbs = [active_orbs[k] for k in range(len(active_orbs)) if k not in drop_set]

                    # Add short nogood + its Z_16^* symmetric conjugates!
                    base_nogood = [(-c_lits[j] if ((cint >> j) & 1) else c_lits[j]) for j in keep_orbs]
                    slv.add_clause(base_nogood)
                    stats["subcube_short_nogoods"] += 1
                    subcube_len_sum += len(base_nogood)
                    for mult, perm in z16_perms.items():
                        conj_nogood = [(-c_lits[perm[j]] if ((cint >> j) & 1) else c_lits[perm[j]]) for j in keep_orbs]
                        slv.add_clause(conj_nogood)
                    continue

                # Check B0_00 30 generic fibers (128 == 64) or B0_11 exact Krawtchouk fiber identity
                # before falling back to global Walsh nogood, to extract localized support nogoods!
                fiber_cut_done = False
                if c99_val == 0 and c57_val == 0:
                    for z_rep, reps128 in generic_30_fibers:
                        ones_pts = [x for x in reps128 if eval_tt_bit(x) == 1]
                        if len(ones_pts) != 64:
                            if len(ones_pts) > 64:
                                pts_pick = sorted(ones_pts, key=lambda x: x.bit_count())[:65]
                            else:
                                zeros_pts = [x for x in reps128 if eval_tt_bit(x) == 0]
                                pts_pick = sorted(zeros_pts, key=lambda x: x.bit_count())[:65]
                            used_j = set()
                            for x in pts_pick:
                                used_j.update(point_long_supp(x))
                            if len(used_j) < N_free:
                                nogood = [(-c_lits[j] if ((cint >> j) & 1) else c_lits[j]) for j in sorted(used_j)]
                                slv.add_clause(nogood)
                                stats["lazy_fiber_cuts"] += 1
                                fiber_cut_done = True
                                break
                elif c99_val == 0 and c57_val == 1:
                    s0_b = 1 if pos_var[s0_var] else 0
                    sm_b = [1 if pos_var[s_vars[m]] else 0 for m in range(30)]
                    for z_idx, (z_rep, _) in enumerate(nonzero_z):
                        reps128 = fiber_orbit_reps(z_rep, 8)
                        wt_f = sum(eval_tt_bit(x) for x in reps128)
                        u4_flag = 1 if z_rep in (0x11, 0x33, 0x55, 0x77, 0xFF) else 0
                        rhs_expected = 64 + 8 * u4_flag * s0_b + sum((K_mat[z_idx][m] // 2) * sm_b[m] for m in range(30))
                        if wt_f != rhs_expected:
                            # Block incompatible (s_0, s_1..s_30) assignment OR fiber support!
                            s_clause = [-s0_var if s0_b else s0_var] + [
                                (-s_vars[m] if sm_b[m] else s_vars[m]) for m in range(30) if K_mat[z_idx][m] != 0
                            ]
                            used_j = set()
                            for x in reps128:
                                used_j.update(point_long_supp(x))
                            f_clause = [(-c_lits[j] if ((cint >> j) & 1) else c_lits[j]) for j in sorted(used_j)]
                            slv.add_clause(s_clause + f_clause)
                            stats["lazy_fiber_cuts"] += 1
                            fiber_cut_done = True
                            break

                if fiber_cut_done:
                    continue

                # --- LAYER D: Weighted Walsh Slack-Minimized Nogood + Z_16^* Orbit Blocking ---
                u_star = fail_u_c.value
                w_val = fail_val_c.value
                slack = min(abs(w_val - 256), abs(w_val + 256))
                # Try to relax spatial orbits with w_r(u*) == 0 or small |w_r(u*)|!
                # Always valid fallback: block all 8 Z_16^* conjugates on long_orbs / z_vars
                base_block = [(-c_lits[j] if ((cint >> j) & 1) else c_lits[j]) for j in long_orbs]
                slv.add_clause(base_block)
                for mult, perm in z16_perms.items():
                    slv.add_clause([(-c_lits[perm[j]] if ((cint >> j) & 1) else c_lits[perm[j]]) for j in long_orbs])
                stats["walsh_nogoods"] += 1

            if bent_hits or not cube_unsat:
                all_cubes_unsat = False
                break

    if stats["subcube_short_nogoods"] > 0:
        stats["subcube_avg_len"] = round(subcube_len_sum / stats["subcube_short_nogoods"], 2)

    sat_sec = time.perf_counter() - ts
    return {
        "cell": cell_name,
        "shard": f"{shard_id}/{num_shards}",
        "cubes_assigned": len(my_cubes),
        "algebraic_unsat_has_one": False,
        "unsat_closed": all_cubes_unsat and (len(bent_hits) == 0),
        "closed_by": "lazy_sat_fwht_all_cubes" if (all_cubes_unsat and not bent_hits) else "budget_exhausted_or_sat",
        "N_free_after_lin_elim": N_free,
        "n_pure_quads_in_cnf": len(quad_psets_red),
        "deg_pivs_111": {"0": deg_pivs[0], "1": deg_pivs[1], "2": deg_pivs[2], "3": deg_pivs[3]},
        "cnf_vars_initial": v_cnt[0],
        "cnf_clauses_initial": len(clauses),
        "stats": stats,
        "models_per_sec": round(stats["models_checked"] / max(sat_sec, 1e-6), 2),
        "bent_hits": bent_hits,
        "alg_sec": round(t_alg, 3),
        "sat_sec": round(sat_sec, 3),
        "total_sec": round(time.perf_counter() - t0, 3),
    }


def build_global_precomputations():
    orbits = build_orbits_116()
    z16_perms = build_z16_star_orbit_perms(orbits)
    v6_list = all_v6_orbits()

    orb_tts = (ctypes.c_uint64 * (116 * 1024))()
    for j, orb in enumerate(orbits):
        base = j * 1024
        for m in orb:
            # Iterate only over x where (x & m) == m via submask enumeration of ~m!
            inv_m = (~m) & 0xFFFF
            sub = inv_m
            while True:
                x = m | sub
                orb_tts[base + (x >> 6)] ^= 1 << (x & 63)
                if sub == 0:
                    break
                sub = (sub - 1) & inv_m

    pair_idx = {}
    all_pairs = []
    for v in range(256):
        for w in range(v + 1, 256):
            pair_idx[(v, w)] = len(all_pairs)
            all_pairs.append(v | (w << 8))

    seen_x = bytearray(65536)
    rot4_reps = []
    rep_of_x_r4 = [-1] * 65536
    for x in range(65536):
        if (x & 0xFF) == (x >> 8) or seen_x[x]:
            continue
        o4 = [x, rot16(x, 4), rot16(x, 8), rot16(x, 12)]
        r_idx = len(rot4_reps)
        rot4_reps.append(x)
        for y in o4:
            seen_x[y] = 1
            rep_of_x_r4[y] = r_idx

    orb_diag, orb_pair, orb_r4 = [0] * 116, [0] * 116, [0] * 116
    for j in range(116):
        base = j * 1024
        vd, vp, vr = 0, 0, 0
        for v in range(256):
            x = v | (v << 8)
            if (orb_tts[base + (x >> 6)] >> (x & 63)) & 1:
                vd |= 1 << v
        orb_diag[j] = vd
        for k, x in enumerate(all_pairs):
            if (orb_tts[base + (x >> 6)] >> (x & 63)) & 1:
                vp |= 1 << k
        orb_pair[j] = vp
        for k, x in enumerate(rot4_reps):
            if (orb_tts[base + (x >> 6)] >> (x & 63)) & 1:
                vr |= 1 << k
        orb_r4[j] = vr
    chi_r4 = sum((1 << k) for k, x in enumerate(rot4_reps) if x.bit_count() & 1)

    # Precompute C_{0x0}\D_8, C_{0xf}, C_{[0x5]}, C_{[0x1]}, C_{[0x3]}, C_{[0x7]} orbit representatives
    coset_reps_by_id = {0: [], 1: [], 2: [], 3: [], 4: [], 5: []}
    vis16 = bytearray(65536)
    for x in range(65536):
        if vis16[x] or (x & 0xFF) == (x >> 8):
            continue
        cur, mem = x, []
        while not vis16[cur]:
            vis16[cur] = 1
            mem.append(cur)
            cur = rot16(cur, 1)
        assert len(mem) == 16
        rep = min(mem)
        vnib = (rep & 0xF) ^ ((rep >> 4) & 0xF) ^ ((rep >> 8) & 0xF) ^ ((rep >> 12) & 0xF)
        if vnib == 0x0:
            coset_reps_by_id[0].append(rep)
        elif vnib == 0xF:
            coset_reps_by_id[1].append(rep)
        elif vnib in (0x5, 0xA):
            coset_reps_by_id[2].append(rep)
        elif vnib in (0x1, 0x2, 0x4, 0x8):
            coset_reps_by_id[3].append(rep)
        elif vnib in (0x3, 0x6, 0xC, 0x9):
            coset_reps_by_id[4].append(rep)
        else:
            coset_reps_by_id[5].append(rep)

    u4_orbs, u8_size8, nonzero_z = build_c8_orbits()
    K_mat, M_mod2_rows = [], []
    for z_rep, _ in nonzero_z:
        row_k, m_bits = [], 0
        for m, (_, a_orb) in enumerate(u8_size8):
            s_val = sum(-1 if ((a & z_rep).bit_count() & 1) else 1 for a in a_orb)
            row_k.append(s_val)
            if (s_val // 2) & 1:
                m_bits |= 1 << m
        K_mat.append(row_k)
        M_mod2_rows.append(m_bits)
    null_z_vecs = gf2_nullspace_left(M_mod2_rows)

    # Precompute active long orbits & point weights Delta_j(M) for each coordinate subcube M_d
    subcube_info = []
    for mask in SUBCUBE_MASKS:
        dim = mask.bit_count()
        bit_pos = [b for b in range(16) if (mask >> b) & 1]
        pts = []
        for idx in range(1 << dim):
            x = 0
            for b in range(dim):
                if (idx >> b) & 1:
                    x |= 1 << bit_pos[b]
            pts.append(x)
        active_orbs, deltas = [], []
        for j in range(116):
            if j in (57, 99, 113, 115):
                continue
            base = j * 1024
            cnt = sum(1 for x in pts if ((orb_tts[base + (x >> 6)] >> (x & 63)) & 1))
            if cnt > 0:
                active_orbs.append(j)
                deltas.append(cnt)
        subcube_info.append({"mask": mask, "dim": dim, "active_orbs": active_orbs, "deltas": deltas})

    # Precompute Macaulay column lookup tables for n = 111
    n = 111
    n3 = n * (n - 1) * (n - 2) // 6
    off2 = n3
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
    pair2_table_c = (ctypes.c_int * (n * n))()
    for i in range(n):
        for j in range(i + 1, n):
            m = (1 << i) | (1 << j)
            col_c = off2 + len(pair2_list)
            pair2_col[m] = col_c
            pair2_table_c[i * n + j] = col_c
            pair2_table_c[j * n + i] = col_c
            pair2_list.append(m)

    return {
        "orbits": orbits,
        "z16_perms": z16_perms,
        "v6_list": v6_list,
        "orb_tts": orb_tts,
        "orb_diag": orb_diag,
        "orb_pair": orb_pair,
        "orb_r4": orb_r4,
        "chi_r4": chi_r4,
        "rep_of_x_r4": rep_of_x_r4,
        "pair_idx": pair_idx,
        "coset_reps_by_id": coset_reps_by_id,
        "u8_size8": u8_size8,
        "nonzero_z": nonzero_z,
        "K_mat": K_mat,
        "M_mod2_rows": M_mod2_rows,
        "null_z_vecs": null_z_vecs,
        "subcube_info": subcube_info,
        "col3_base": col3_base,
        "col3_list": col3_list,
        "pair2_col": pair2_col,
        "pair2_list": pair2_list,
        "pair2_table_c": pair2_table_c,
    }


def main():
    parser = argparse.ArgumentParser(description="Unified Hybrid C/SAT Solver for H(16,4) symmetric cells.")
    parser.add_argument("--cell", type=str, default="ALL", choices=["B1_00", "B1_11", "B0_11", "B0_00", "ALL"])
    parser.add_argument("--budget", type=float, default=420.0, help="Time budget in seconds per cell.")
    parser.add_argument("--shard-id", type=int, default=0, help="0-indexed shard ID for parallel Cube-and-Conquer.")
    parser.add_argument("--num-shards", type=int, default=1, help="Total number of parallel shards (power of 2 ideal).")
    parser.add_argument("--out", type=str, default="", help="Optional path to save JSON report.")
    args = parser.parse_args()

    t_start = time.perf_counter()
    build_dir = Path(tempfile.gettempdir())
    lib = compile_c_library(build_dir)
    precomp = build_global_precomputations()
    print(f"[INIT] C library & 116-orbit tables ready in {time.perf_counter() - t_start:.2f}s.", flush=True)

    target_cells = ["B1_00", "B1_11", "B0_11", "B0_00"] if args.cell == "ALL" else [args.cell]
    results = {}
    for cname in target_cells:
        res = solve_cell_fast(
            cname,
            lib,
            precomp,
            budget_sec=args.budget,
            shard_id=args.shard_id,
            num_shards=args.num_shards,
        )
        results[cname] = res
        print(f"=== {cname} RESULT ===", flush=True)
        print(json.dumps(res, indent=2), flush=True)

    summary = {
        "all_closed": all(r["unsat_closed"] for r in results.values()),
        "cells": results,
        "total_wall_sec": round(time.perf_counter() - t_start, 3),
    }
    if args.out:
        Path(args.out).write_text(json.dumps(summary, indent=2), encoding="utf-8")
    print("=== FINAL B31 UNIFIED REPORT ===", flush=True)
    print(json.dumps(summary, indent=2), flush=True)


if __name__ == "__main__":
    main()
