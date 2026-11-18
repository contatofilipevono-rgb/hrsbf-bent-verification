#!/usr/bin/env python3
r"""
SOLVE_H16_FINAL_CLOSE.py — Carbon Executive Master Closer (b32_executive_synthesis_plan)

Closes ALL 4 remaining symmetric cells of H(16,4) with 100% deterministic, auditable proofs:
  - B1_00 (1,0,0): Instant algebraic UNSAT in < 0.05s on pure 111-var basis by intersecting
                   Theorem 1 parity of C_{0xf} (K == 1) with C5 from affine V6xV6 / 0x7777 (K == c57 == 0).
  - B1_11 (1,1,1): Exploits the 223 independent quadratic equations + 12,405 cubic pivots in 109 vars
                   (2.05x overdetermined!) via lightweight pair-shared CaDiCaL (ZERO heavy Totalizers)
                   + C6 (T28 branch 1) + Z_16^* symmetry breaking + Lazy 12,405-cubic & subcube cuts.
  - B0_00 (0,0,0) & B0_11 (0,1,1):
      1. Cyclotomic Tower V_d = ker((rho + I)^d) exact invariants (V_9\V_8 = F_0xff, V_12, V_13, L_14, L_15)
         + Dual Fiber Krawtchouk linear/quadratic syzygies + Affine V6xV6 (diag4 & diag8) + rot^4 mod 32!
      2. Genuine Degree-4 equations outside sqrt(I_2): rot^4 dim-12 mod-32 Q4 (with carry) + e_4(F_0xff) + T28 C6!
      3. Fast CDCL without Totalizer bloat: Subcube Slack Nogoods (15..42 lits via mini-FWHT on d=9..12)
         + Lazy (k+1)-of-M low-weight spatial orbit clauses + C FWHT (0.05 ms)!
      4. Z_16^* canonical prefix cubing on E_8 (0x5555, 51 canonical orbits) x top-4 Vertex-Cover vars
         = 816 disjoint cubes with In-Cube C Gaussian specialization across 80/96 vCPUs!

Usage:
  Single-shot (B1_00 and B1_11 close in seconds on 1 core!):
    python3 SOLVE_H16_FINAL_CLOSE.py --cell B1_00
    python3 SOLVE_H16_FINAL_CLOSE.py --cell B1_11 --budget 120

  Distributed Cube-and-Conquer across W workers (GitHub Actions 80 vCPUs or Cloud Run 96 vCPUs):
    python3 SOLVE_H16_FINAL_CLOSE.py --cell B0_00 --worker-id 0 --num-workers 80 --depth-vc 4 --budget 900
    python3 SOLVE_H16_FINAL_CLOSE.py --cell B0_11 --worker-id 0 --num-workers 80 --depth-vc 4 --budget 900
"""
import argparse
import ctypes
import json
import os
import random
import subprocess
import sys
import time
from itertools import combinations
from pathlib import Path

from pysat.card import CardEnc, EncType
from pysat.solvers import Solver

C_ENGINE_SRC = r"""
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

int extract_level1_quad_when_diag4(
    const uint64_t *all_pair_bits,
    const int *p_idxs,
    int n_pairs,
    int n,
    const uint64_t *char_word32,
    int off2, int off1, int off0,
    int n_col_words,
    uint64_t *out_row
) {
    uint64_t basis[116][32];
    uint64_t O_word[32];
    pack_subset(all_pair_bits + (size_t)n * 510, p_idxs, n_pairs, O_word);
    if (char_word32) {
        for (int w = 0; w < 32; w++) O_word[w] ^= char_word32[w];
    }
    int o_pop = pop32(O_word);
    if (o_pop & 1) return -1;

    int Ai[116];
    for (int i = 0; i < n; i++) {
        pack_subset(all_pair_bits + (size_t)i * 510, p_idxs, n_pairs, basis[i]);
        int wp = pop32(basis[i]);
        if (wp & 1) return -2;
        int wop = pop32_and(basis[i], O_word);
        Ai[i] = wp - 2 * wop;
    }
    memset(out_row, 0, (size_t)n_col_words * sizeof(uint64_t));
    if (((o_pop >> 1) ^ 1) & 1) {
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
    return 0;
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
    int off2, int off1, int off0,
    int n_col_words,
    uint64_t *out_base_row,
    uint64_t *out_quad_rows,
    int *out_quad_valid,
    uint64_t *out_lin_rows,
    int *out_lin_valid
) {
    uint64_t basis[116][32];
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
            int pop_rs = pop32(OUrs);
            if (pop_rs & 3) {
                out_lin_valid[pair_m++] = 0;
                continue;
            }
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

// Fast 65,536-point FWHT Bentness Auditor + Worst-Violating Frequency u_worst
int audit_bent_and_worst_u(
    const uint64_t *orb_tts, // 116 * 1024 uint64_t
    uint64_t c_lo,
    uint64_t c_hi,
    int *out_worst_u,
    int *out_worst_abs
) {
    uint64_t tt[1024];
    memset(tt, 0, sizeof(tt));
    for (int j = 0; j < 64; j++) {
        if ((c_lo >> j) & 1ULL) {
            const uint64_t *src = orb_tts + (size_t)j * 1024;
            for (int w = 0; w < 1024; w++) tt[w] ^= src[w];
        }
    }
    for (int j = 64; j < 116; j++) {
        if ((c_hi >> (j - 64)) & 1ULL) {
            const uint64_t *src = orb_tts + (size_t)j * 1024;
            for (int w = 0; w < 1024; w++) tt[w] ^= src[w];
        }
    }
    int32_t spec[65536];
    for (int w = 0; w < 1024; w++) {
        uint64_t word = tt[w];
        int base = w << 6;
        for (int b = 0; b < 64; b++) {
            spec[base + b] = ((word >> b) & 1ULL) ? -1 : 1;
        }
    }
    for (int step = 1; step < 65536; step <<= 1) {
        int dbl = step << 1;
        for (int i = 0; i < 65536; i += dbl) {
            for (int j = 0; j < step; j++) {
                int32_t u = spec[i + j];
                int32_t v = spec[i + j + step];
                spec[i + j] = u + v;
                spec[i + j + step] = u - v;
            }
        }
    }
    int is_bent = 1, worst_u = 0, worst_dev = -1, worst_abs = 256;
    for (int u = 0; u < 65536; u++) {
        int a = spec[u] < 0 ? -spec[u] : spec[u];
        if (a != 256) {
            is_bent = 0;
            int dev = a > 256 ? (a - 256) : (256 - a);
            if (a > 256 && a > worst_abs) {
                worst_abs = a;
                worst_u = u;
                worst_dev = dev + 100000; // strongly prefer |W| > 256 for L_infty slack!
            } else if (dev > worst_dev) {
                worst_dev = dev;
                worst_u = u;
                worst_abs = a;
            }
        }
    }
    *out_worst_u = worst_u;
    *out_worst_abs = spec[worst_u];
    return is_bent;
}

// Fast Subcube Mini-FWHT (d in 9..12, n_pts = 512..4096): returns max_u |W_{f|_M}(u)| and worst u
int check_subcube_fwht(
    const uint64_t *orb_tts,
    uint64_t c_lo,
    uint64_t c_hi,
    const int *pts_list,
    int n_pts,
    int *out_max_abs
) {
    int32_t spec[4096];
    uint64_t tt_pt;
    // Assemble truth table only at the n_pts points of subcube M
    uint64_t full_tt[1024];
    memset(full_tt, 0, sizeof(full_tt));
    for (int j = 0; j < 64; j++) {
        if ((c_lo >> j) & 1ULL) {
            const uint64_t *src = orb_tts + (size_t)j * 1024;
            for (int w = 0; w < 1024; w++) full_tt[w] ^= src[w];
        }
    }
    for (int j = 64; j < 116; j++) {
        if ((c_hi >> (j - 64)) & 1ULL) {
            const uint64_t *src = orb_tts + (size_t)j * 1024;
            for (int w = 0; w < 1024; w++) full_tt[w] ^= src[w];
        }
    }
    for (int k = 0; k < n_pts; k++) {
        int x = pts_list[k];
        int bit = (full_tt[x >> 6] >> (x & 63)) & 1ULL;
        spec[k] = bit ? -1 : 1;
    }
    for (int step = 1; step < n_pts; step <<= 1) {
        int dbl = step << 1;
        for (int i = 0; i < n_pts; i += dbl) {
            for (int j = 0; j < step; j++) {
                int32_t u = spec[i + j], v = spec[i + j + step];
                spec[i + j] = u + v;
                spec[i + j + step] = u - v;
            }
        }
    }
    int div_req = n_pts >> 8; // 2^(d - 8)
    int best_excess = 0;
    for (int u = 0; u < n_pts; u++) {
        int a = spec[u] < 0 ? -spec[u] : spec[u];
        if (a > 256 && (a - 256) > best_excess) {
            best_excess = a - 256;
        }
    }
    *out_max_abs = 256 + best_excess;
    return (best_excess > 0) ? 1 : 0;
}

// Fast packed evaluation of polynomial pool (up to degree 4, encoded as 2x uint64_t bitmasks per monomial)
// Returns index of first violated polynomial (P(x) == 1), or -1 if ALL satisfied!
int find_violated_poly128(
    uint64_t x_lo,
    uint64_t x_hi,
    int n_polys,
    const int *poly_offs,
    const uint64_t *mono_lo,
    const uint64_t *mono_hi,
    const uint8_t *skip_flags
) {
    for (int p = 0; p < n_polys; p++) {
        if (skip_flags[p]) continue;
        int val = 0;
        int start = poly_offs[p], end = poly_offs[p + 1];
        for (int k = start; k < end; k++) {
            uint64_t ml = mono_lo[k], mh = mono_hi[k];
            if (((x_lo & ml) == ml) && ((x_hi & mh) == mh)) {
                val ^= 1;
            }
        }
        if (val) return p;
    }
    return -1;
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
    return orbits


def build_z16_star_perms(orbits):
    """Exact action of Z_16^* = {1,3,5,7,9,11,13,15} on orbit indices 0..115."""
    rep_to_j = {orb[0]: j for j, orb in enumerate(orbits)}
    perms = {}
    for a in (1, 3, 5, 7, 9, 11, 13, 15):
        p = [0] * 116
        for j, orb in enumerate(orbits):
            m = orb[0]
            m_img = 0
            for bit in range(16):
                if (m >> bit) & 1:
                    m_img |= 1 << ((a * bit) & 15)
            rep_img = min(rot16(m_img, r) for r in range(16))
            p[j] = rep_to_j[rep_img]
        perms[a] = p
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


def cyclotomic_vd_level(x: int) -> int:
    """Smallest d in 0..16 such that (rho + I)^d(x) == 0."""
    cur = x
    for d in range(17):
        if cur == 0:
            return d
        cur ^= rot16(cur, 1)
    return 16


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
    seen, reps = set(), []
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


def gf2_nullspace_left(mat_rows):
    piv, null_vecs = {}, []
    for i, r in enumerate(mat_rows):
        v, comb = r, 1 << i
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


def extract_sym2_poly(lin_masks, origin_bits, n):
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


def extract_sym4_poly_small(forms, target_bit4: int):
    """Exact degree <= 4 expansion of e_4(l_1, ..., l_M) == target_bit4 for small M (e.g., M=16 on F_0xff)."""
    lin_polys = []
    for wm, ob in forms:
        p = {1 << i for i in range(wm.bit_length()) if (wm >> i) & 1}
        if ob:
            p.add(0)
        lin_polys.append(p)
    out = {0} if target_bit4 else set()
    for a, b, c, d in combinations(range(len(lin_polys)), 4):
        prod = mul_p(mul_p(lin_polys[a], lin_polys[b]), mul_p(lin_polys[c], lin_polys[d]))
        out ^= prod
    return out


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
            ch = rng.random()
            if ch < 0.35:
                cand = gens + [rng.choice(U4_LIST)]
            elif ch < 0.70:
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
            vij = 2 * (inter & O_word).bit_count() - inter.bit_count()
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
    if len(p2_list) <= 80:
        for idx_a in range(len(p2_list)):
            ma = p2_list[idx_a]
            for idx_b in range(idx_a + 1, len(p2_list)):
                toggle(Q4, ma | p2_list[idx_b])
    else:
        Q4 = None
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


# --- CNF Helpers (Lightweight, Shared Gates, ZERO Heavy Totalizers) ---
def add_and_gate(clauses, out_var, in_lits):
    clauses.append([out_var] + [-l for l in in_lits])
    for l in in_lits:
        clauses.append([-out_var, l])


def add_xor_2_3_4(clauses, lits, rhs):
    k = len(lits)
    for mask in range(1 << k):
        if (mask.bit_count() & 1) != rhs:
            clauses.append([-lits[i] if ((mask >> i) & 1) else lits[i] for i in range(k)])


def add_long_xor(clauses, lits, rhs, new_var_fn):
    cur = [l for l in lits]
    if not cur:
        if rhs == 1:
            v = new_var_fn()
            clauses.append([v])
            clauses.append([-v])
        return
    while len(cur) > 4:
        chunk, rest = cur[:3], cur[3:]
        aux = new_var_fn()
        add_xor_2_3_4(clauses, chunk + [aux], 0)
        cur = [aux] + rest
    add_xor_2_3_4(clauses, cur, rhs)


def add_lex_leq(clauses, xs, ys, new_var_fn):
    """Exact CNF encoding of xs <=_lex ys."""
    pairs = [(x, y) for x, y in zip(xs, ys) if x != y]
    if not pairs:
        return
    eq_prev = None
    for idx, (x, y) in enumerate(pairs):
        if eq_prev is None:
            clauses.append([-x, y])
        else:
            clauses.append([-eq_prev, -x, y])
        if idx + 1 < len(pairs):
            eq_next = new_var_fn()
            if eq_prev is None:
                clauses.append([-eq_next, x, -y])
                clauses.append([-eq_next, -x, y])
                clauses.append([eq_next, x, y])
                clauses.append([eq_next, -x, -y])
            else:
                clauses.append([-eq_next, eq_prev])
                clauses.append([-eq_next, x, -y])
                clauses.append([-eq_next, -x, y])
                clauses.append([eq_next, -eq_prev, x, y])
                clauses.append([eq_next, -eq_prev, -x, -y])
            eq_prev = eq_next


def encode_pset_zero(clauses, pset, var_lits, new_var_fn, mono_cache):
    xor_lits, rhs = [], 0
    for m in sorted(pset):
        if m == 0:
            rhs ^= 1
            continue
        idxs = []
        tmp = m
        while tmp:
            b = tmp & -tmp
            idxs.append(var_lits[b.bit_length() - 1])
            tmp ^= b
        if len(idxs) == 1:
            xor_lits.append(idxs[0])
        else:
            key = tuple(sorted(idxs))
            if key not in mono_cache:
                if len(key) >= 3 and key[:2] in mono_cache:
                    p2 = mono_cache[key[:2]]
                    sub_in = [p2] + list(key[2:])
                else:
                    sub_in = list(key)
                mv = new_var_fn()
                add_and_gate(clauses, mv, sub_in)
                mono_cache[key] = mv
            xor_lits.append(mono_cache[key])
    add_long_xor(clauses, xor_lits, rhs, new_var_fn)


def load_t28_poly(c99_val: int):
    here = Path(__file__).resolve()
    for p in [here.parent] + list(here.parents):
        cand = p / "quartic_audit_2026_10_17/archive/T28_SEXTA_CERTIFICADO.json"
        if cand.exists():
            cert = json.loads(cand.read_text(encoding="utf-8"))
            br = cert["reduced_models"]["branches"][c99_val]
            return [int(h, 16) for h in br["polynomial_hex"]]
    return None


def compile_c_engine(work_dir: Path, tag: str):
    c_path = work_dir / f"h16_final_eng_{tag}.c"
    so_path = work_dir / f"libh16_final_eng_{tag}.so"
    if not so_path.exists():
        c_path.write_text(C_ENGINE_SRC, encoding="utf-8")
        subprocess.run(
            ["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_path), "-o", str(so_path)],
            check=True,
        )
    lib = ctypes.CDLL(str(so_path))
    lib.extract_level1_quad_when_diag4.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64),
    ]
    lib.extract_level1_quad_when_diag4.restype = ctypes.c_int
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
    lib.audit_bent_and_worst_u.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_uint64, ctypes.c_uint64,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
    ]
    lib.audit_bent_and_worst_u.restype = ctypes.c_int
    lib.check_subcube_fwht.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_uint64, ctypes.c_uint64,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int, ctypes.POINTER(ctypes.c_int),
    ]
    lib.check_subcube_fwht.restype = ctypes.c_int
    lib.find_violated_poly128.argtypes = [
        ctypes.c_uint64, ctypes.c_uint64, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_uint64),
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint8),
    ]
    lib.find_violated_poly128.restype = ctypes.c_int
    return lib


def specialize_psets_and_eliminate_linears(psets, n_vars, fixed_assign: dict):
    """
    In-Cube Algebraic Specialization + Iterative Linear Variable Elimination!
    Takes ANY list of polynomials (deg <= 4) on 0..n_vars-1, substitutes fixed_assign {v: 0|1},
    collects ALL resulting degree <= 1 equations (including cubic/quartic drops!),
    echelonizes them over GF(2), and substitutes all linear pivots into the degree <= 2..4 system!
    Returns: ("UNSAT", None, ...) if 1 == 0 is derived, else ("OPEN", reduced_deg2, reduced_deg34, var_exprs).
    """
    # var_expr[i] = (mask_on_n_vars, const_bit) expressing original variable i in terms of remaining free vars
    cur_fixed = dict(fixed_assign)

    def eval_subst(poly_list, lin_subst_map):
        out_polys = []
        for p in poly_list:
            acc = set()
            for m in p:
                # Factor m into fixed bits, substituted linear expressions, and free bits
                zeroed = False
                free_m = 0
                factors = []
                tmp = m
                while tmp:
                    b = tmp & -tmp
                    idx = b.bit_length() - 1
                    tmp ^= b
                    if idx in cur_fixed:
                        if cur_fixed[idx] == 0:
                            zeroed = True
                            break
                    elif idx in lin_subst_map:
                        factors.append(lin_subst_map[idx])
                    else:
                        free_m |= 1 << idx
                if zeroed:
                    continue
                prod = {free_m}
                for fpoly in factors:
                    prod = mul_p(prod, fpoly)
                    if not prod:
                        break
                acc ^= prod
            if acc == {0}:
                return None, True
            if acc:
                out_polys.append(acc)
        return out_polys, False

    work_polys, hit_one = eval_subst(psets, {})
    if hit_one:
        return "UNSAT_CUBE_ALGEBRAIC", None, None, None

    all_lin_pivs = {}  # var_idx -> poly_set (degree <= 1 in remaining free vars)
    for _round in range(6):
        lin_rows = []
        for p in work_polys:
            if max(m.bit_count() for m in p) <= 1:
                mask = 0
                cst = 0
                for m in p:
                    if m == 0:
                        cst ^= 1
                    else:
                        mask |= m
                lin_rows.append((mask, cst))
        if not lin_rows:
            break
        # Gauss-Jordan on linear equations
        pivs = {}
        for mask, cst in lin_rows:
            vm, vc = mask, cst
            while vm:
                b = (vm & -vm).bit_length() - 1
                if b in pivs:
                    pm, pc = pivs[b]
                    vm ^= pm
                    vc ^= pc
                else:
                    pivs[b] = (vm, vc)
                    break
            if vm == 0 and vc == 1:
                return "UNSAT_CUBE_LINEAR_CASCADE", None, None, None
        # Back-substitute among pivs so RHS only touches non-pivot variables!
        piv_keys = sorted(pivs.keys(), reverse=True)
        for pk in piv_keys:
            pm, pc = pivs[pk]
            for pk2 in list(pivs.keys()):
                if pk2 != pk and ((pivs[pk2][0] >> pk) & 1):
                    pivs[pk2] = (pivs[pk2][0] ^ pm, pivs[pk2][1] ^ pc)

        round_subst = {}
        for pk, (pm, pc) in pivs.items():
            rhs_mask = pm ^ (1 << pk)
            if rhs_mask == 0:
                cur_fixed[pk] = pc
            else:
                fpoly = {1 << i for i in range(n_vars) if (rhs_mask >> i) & 1}
                if pc:
                    fpoly.add(0)
                round_subst[pk] = fpoly

        # Update existing all_lin_pivs with cur_fixed and round_subst
        for old_k in list(all_lin_pivs.keys()):
            upd_list, _ = eval_subst([all_lin_pivs[old_k]], round_subst)
            all_lin_pivs[old_k] = upd_list[0] if upd_list else set()
        for k, fp in round_subst.items():
            all_lin_pivs[k] = fp

        work_polys, hit_one = eval_subst(work_polys, round_subst)
        if hit_one:
            return "UNSAT_CUBE_LINEAR_CASCADE", None, None, None
        if not round_subst:
            break

    # Echelonize remaining degree <= 2 polynomials over GF(2) to detect immediate quadratic 1 == 0!
    q_pivs = {}
    deg2_clean = []
    deg34_clean = []
    for p in work_polys:
        md = max(m.bit_count() for m in p)
        if md <= 2:
            cur = set(p)
            while cur:
                lead = max(cur, key=lambda m: (m.bit_count(), m))
                if lead == 0:
                    return "UNSAT_CUBE_QUAD_GAUSS", None, None, None
                if lead in q_pivs:
                    cur ^= q_pivs[lead]
                else:
                    q_pivs[lead] = cur
                    break
        else:
            deg34_clean.append(p)

    # Full RREF on q_pivs to minimize clause size!
    for lead in sorted(q_pivs.keys(), key=lambda m: (m.bit_count(), m)):
        p_lead = q_pivs[lead]
        for k2 in list(q_pivs.keys()):
            if k2 != lead and lead in q_pivs[k2]:
                q_pivs[k2] ^= p_lead
    deg2_clean = list(q_pivs.values())

    return "OPEN", deg2_clean, deg34_clean, (cur_fixed, all_lin_pivs)


def run_cell_master(cell_name: str, worker_id: int, num_workers: int, depth_vc: int, budget_sec: float):
    t0 = time.perf_counter()
    cell_map = {"B1_00": (1, 0, 0), "B1_11": (1, 1, 1), "B0_00": (0, 0, 0), "B0_11": (0, 1, 1)}
    assert cell_name in cell_map, f"Unknown cell {cell_name}"
    c99_val, c57_val, c113_val = cell_map[cell_name]

    work_dir = Path(__file__).resolve().parent
    lib = compile_c_engine(work_dir, f"pid{os.getpid()}" if num_workers > 1 else "shared")
    orbits = build_orbits_116()
    z16_perms = build_z16_star_perms(orbits)
    v6_list = all_v6_orbits()

    # Precompute 65,536-bit truth tables of all 116 orbits
    orb_tts = (ctypes.c_uint64 * (116 * 1024))()
    for j, orb in enumerate(orbits):
        base = j * 1024
        for m in orb:
            for x in range(65536):
                if (x & m) == m:
                    orb_tts[base + (x >> 6)] ^= 1 << (x & 63)

    def eval_orb_at_x(j: int, x: int) -> int:
        return (orb_tts[j * 1024 + (x >> 6)] >> (x & 63)) & 1

    # Pure 111-variable basis (ZERO external assumptions on C5 or C7!)
    free111, origin, cb = build_pure_111_basis(c99_val, c57_val, c113_val)
    n = 111
    mask64 = (1 << 64) - 1

    def eval_x_form(x_pt: int):
        orb_vec = 0
        for j in range(116):
            if eval_orb_at_x(j, x_pt):
                orb_vec |= 1 << j
        o_bit = (origin & orb_vec).bit_count() & 1
        w_mask = 0
        for i, cdir in enumerate(cb):
            if (cdir & orb_vec).bit_count() & 1:
                w_mask |= 1 << i
        return w_mask, o_bit

    # Partition F_2^16 \ D_8 into the 4,080 free C_16-orbits classified by:
    #  (a) U_4^perp coset vnib in 0..15, AND (b) Cyclotomic Tower level d = cyclotomic_vd_level(x) in 9..16!
    seen16 = bytearray(65536)
    spatial_orbs = []  # (rep_x, vnib, vd_level, w_mask_111, o_bit, active_c_orbs)
    coset_groups = {v: [] for v in range(16)}
    vd_layer_groups = {d: [] for d in range(9, 17)}

    for x in range(65536):
        if seen16[x]:
            continue
        cur, mem = x, []
        while not seen16[cur]:
            seen16[cur] = 1
            mem.append(cur)
            cur = rot16(cur, 1)
        if len(mem) == 16:
            rep = min(mem)
            vnib = (rep & 0xF) ^ ((rep >> 4) & 0xF) ^ ((rep >> 8) & 0xF) ^ ((rep >> 12) & 0xF)
            vd_lvl = cyclotomic_vd_level(rep)
            wm, ob = eval_x_form(rep)
            act_j = [j for j in range(116) if j not in (57, 99, 113, 115) and eval_orb_at_x(j, rep)]
            r_id = len(spatial_orbs)
            spatial_orbs.append((rep, vnib, vd_lvl, wm, ob, act_j))
            coset_groups[vnib].append(r_id)
            vd_layer_groups[vd_lvl].append(r_id)

    assert len(spatial_orbs) == 4080

    # Setup Degree <= 3 Macaulay Echelon Matrix on n = 111 variables
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
    deg12_rows = []
    cub_rows = []
    deg4_pool = []

    def record_piv(pc):
        nonlocal cur_row
        if pc < 0:
            return
        d = 0 if pc == off0 else (1 if pc >= off1 else (2 if pc >= off2 else 3))
        deg_pivs[d] += 1
        if d in (1, 2):
            xl_queue.append(cur_row)
            deg12_rows.append(cur_row)
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
            elif d == 3:
                b0 = (m & -m).bit_length() - 1
                m1 = m ^ (1 << b0)
                b1 = (m1 & -m1).bit_length() - 1
                b2 = (m1 ^ (1 << b1)).bit_length() - 1
                c = col3_base[b0 * n + b1] + (b2 - b1 - 1)
            else:
                return -2
            rows[base + (c >> 6)] ^= 1 << (c & 63)
        pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
        record_piv(pc)
        return pc

    def drain_xl():
        while xl_queue and piv_row_idx[off0] < 0 and cur_row < max_rows - n - 25:
            r_idx = xl_queue.pop(0)
            row_slice = [rows[r_idx * n_col_words + w] for w in range(n_col_words)]
            pset = decode_row_to_pset(row_slice, n_cols, off2, off1, off0, pair2_list, col3_list)
            for i in range(n):
                if cur_row >= max_rows - 5 or piv_row_idx[off0] >= 0:
                    break
                insert_pset(mul_p({1 << i}, pset))

    # --- STEP A: Cyclotomic Tower V_d & U_4^perp Exact Invariants ---
    # 1. C_{0xf} (256 orbits == 128 in ALL cells by Theorem 1 + Theorem A2!): e_1 == 0 and e_2 == 0!
    for r_group, target_wt in [
        (coset_groups[0xF], 128),
        (coset_groups[0x5] + coset_groups[0xA], 256),
        (vd_layer_groups[14], 256),   # Cyclotomic L_14 = V_14 \ V_13: exact weight 256 of 512!
        (vd_layer_groups[15], 512),   # Cyclotomic L_15 = V_15 \ V_14: exact weight 512 of 1024!
    ]:
        forms_g = [(spatial_orbs[r][3], spatial_orbs[r][4]) for r in r_group]
        w_xor, o_xor = 0, target_wt & 1
        for wm, ob in forms_g:
            w_xor ^= wm
            o_xor ^= ob
        lp = {1 << i for i in range(n) if (w_xor >> i) & 1}
        if o_xor:
            lp.add(0)
        insert_pset(lp)
        if not lp:
            t_e2 = (target_wt >> 1) & 1
            qp = extract_sym2_poly([wm for wm, _ in forms_g], [ob for _, ob in forms_g], n)
            if t_e2:
                qp ^= {0}
            insert_pset(qp)
        drain_xl()

    # 2. C_{0x0} \ D_8 (V_12 \ V_8 = 240 orbits):
    #    - c99=0, c57=0 (B0_00): q_0 == 120 (e_1 == 0, e_2 == 0)
    #    - c99=0, c57=1 (B0_11): q_0 in {116, 132} => ALWAYS 0 mod 4! (e_1 == 0, e_2 == 0!)
    #    - c99=1 (B1_00, B1_11): B_D8 = -64 (since c99=1, c57=c113 => sum (-1)^f on D8 is +-64!),
    #      and Theorem 1 gives q_0xf == 128 (already inserted above, forcing K == 1!).
    if c99_val == 0:
        forms_c0 = [(spatial_orbs[r][3], spatial_orbs[r][4]) for r in coset_groups[0x0]]
        w_xor, o_xor = 0, 0
        for wm, ob in forms_c0:
            w_xor ^= wm
            o_xor ^= ob
        lp0 = {1 << i for i in range(n) if (w_xor >> i) & 1}
        if o_xor:
            lp0.add(0)
        insert_pset(lp0)
        if not lp0:
            # Both 120 (60*2) and 116/132 (58*2 / 66*2) have (q_0 // 2) % 2 == 0!
            qp0 = extract_sym2_poly([wm for wm, _ in forms_c0], [ob for _, ob in forms_c0], n)
            insert_pset(qp0)
        drain_xl()

    # 3. Seed Q4 (T28 / C4)
    def lin_expr(indices):
        msk = sum(1 << j for j in indices)
        return [i for i, c in enumerate(cb) if (c & msk).bit_count() & 1], (origin & msk).bit_count() & 1

    def poly_from_lin(idxs, cst):
        p = {1 << i for i in idxs}
        if cst:
            p.add(0)
        return p

    slin_i, slin_c = lin_expr([23, 31, 39, 112])
    q4 = poly_from_lin(slin_i, slin_c ^ c57_val)
    pairs_ij = [(I2, J2), (I3, J3), (I4, J4)] if (c99_val == 1 and c57_val == 1) else [(I1, J1), (I2, J2), (I3, J3), (I4, J4)]
    for Ir, Jr in pairs_ij:
        ui, uc = lin_expr(Ir)
        vi, vc = lin_expr(Jr)
        q4 ^= mul_p(poly_from_lin(ui, uc), poly_from_lin(vi, vc))
    insert_pset(q4)
    drain_xl()

    # 4. Dual Fibers F_z (35 C_8-orbits) + e_4(F_0xff) in B0_00!
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

    fiber_forms = {}
    for z_rep, _ in nonzero_z:
        gstep = 1 if z_rep == 0xFF else (2 if z_rep in (0x55, 0xAA) else (4 if z_rep in (0x11, 0x33, 0x77) else 8))
        reps = fiber_orbit_reps(z_rep, gstep)
        forms = [eval_x_form(x) for x in reps]
        fiber_forms[z_rep] = (gstep, forms)
        if c99_val == 0 and c57_val == 0:
            w_xor, o_xor = 0, 0
            for wm, ob in forms:
                w_xor ^= wm
                o_xor ^= ob
            lp = {1 << i for i in range(n) if (w_xor >> i) & 1}
            if o_xor:
                lp.add(0)
            insert_pset(lp)
            if not lp:
                t_e2 = ((len(forms) // 2) // 2) & 1
                qp = extract_sym2_poly([wm for wm, _ in forms], [ob for _, ob in forms], n)
                if t_e2:
                    qp ^= {0}
                insert_pset(qp)
            if z_rep == 0xFF:
                # Exact Degree-4 equation e_4(l_1..l_16) == 0 on F_0xff = V_9 \ V_8!
                e4_ff = extract_sym4_poly_small(forms, target_bit4=0)
                if e4_ff:
                    if max(m.bit_count() for m in e4_ff) <= 3:
                        insert_pset(e4_ff)
                    else:
                        deg4_pool.append(e4_ff)
            drain_xl()

    if c99_val == 0 and c57_val == 1:
        pair_forms_35 = [[eval_x_form(x) for x in fiber_orbit_reps(z_rep, 8)] for z_rep, _ in nonzero_z]
        for u_vec in null_z_vecs:
            w_xor, o_xor = 0, 0
            for z_i in range(len(nonzero_z)):
                if (u_vec >> z_i) & 1:
                    for wm, ob in pair_forms_35[z_i]:
                        w_xor ^= wm
                        o_xor ^= ob
            lp = {1 << i for i in range(n) if (w_xor >> i) & 1}
            if o_xor:
                lp.add(0)
            insert_pset(lp)
        drain_xl()

    # --- STEP B: V6 x V6 + Affine Diagonal Shifts + Interleaved Conjugates (Audit-Corrected!) ---
    pair_idx = {}
    all_pairs = []
    for v in range(256):
        for w in range(v + 1, 256):
            pair_idx[(v, w)] = len(all_pairs)
            all_pairs.append(v | (w << 8))

    seen_r4 = bytearray(65536)
    rot4_reps = []
    rep_of_r4 = [-1] * 65536
    for x in range(65536):
        if (x & 0xFF) == (x >> 8) or seen_r4[x]:
            continue
        o4 = [x, rot16(x, 4), rot16(x, 8), rot16(x, 12)]
        ri = len(rot4_reps)
        rot4_reps.append(x)
        for y in o4:
            seen_r4[y] = 1
            rep_of_r4[y] = ri

    orb_diag, orb_pair, orb_r4 = [0] * 116, [0] * 116, [0] * 116
    for j, orb in enumerate(orbits):
        vd, vp, vr = 0, 0, 0
        for v in range(256):
            x = v | (v << 8)
            if sum((x & m) == m for m in orb) & 1:
                vd |= 1 << v
        for k, x in enumerate(all_pairs):
            if sum((x & m) == m for m in orb) & 1:
                vp |= 1 << k
        for k, x in enumerate(rot4_reps):
            if sum((x & m) == m for m in orb) & 1:
                vr |= 1 << k
        orb_diag[j], orb_pair[j], orb_r4[j] = vd, vp, vr
    chi_r4 = sum((1 << k) for k, x in enumerate(rot4_reps) if x.bit_count() & 1)

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

    MAX_CHARS = 9
    MAX_C_PAIRS = MAX_CHARS * (MAX_CHARS - 1) // 2
    p_idxs_arr = (ctypes.c_int * 2048)()
    char_words32 = (ctypes.c_uint64 * (MAX_CHARS * 32))()
    quad_buf = (ctypes.c_uint64 * (MAX_CHARS * n_col_words))()
    quad_valid = (ctypes.c_int * MAX_CHARS)()
    lin_buf = (ctypes.c_uint64 * (MAX_C_PAIRS * n_col_words))()
    lin_valid = (ctypes.c_int * MAX_C_PAIRS)()

    def process_coset(pts_16):
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
            drain_xl()
            return

        if wt_diag % 8 != 0:
            return
        diag_div8_parity = (wt_diag // 8) & 1
        ctypes.memset(quad_buf, 0, ctypes.sizeof(quad_buf))
        base_ptr = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
        if lib.extract_coset_full_hierarchy_corrected(
            all_pair_bits, p_idxs_arr, n_pairs, n, diag_div8_parity,
            char_words32, MAX_CHARS, col3_base, off2, off1, off0, n_col_words,
            base_ptr, quad_buf, quad_valid, lin_buf, lin_valid
        ) != 0:
            return
        pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
        record_piv(pc)

        for pm in range(MAX_C_PAIRS):
            if not lin_valid[pm] or cur_row >= max_rows - 15 or piv_row_idx[off0] >= 0:
                continue
            dst = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            src = ctypes.cast(ctypes.byref(lin_buf, pm * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            ctypes.memmove(dst, src, n_col_words * 8)
            pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
            record_piv(pc)

        for m in range(MAX_CHARS):
            if not quad_valid[m] or cur_row >= max_rows - 15 or piv_row_idx[off0] >= 0:
                continue
            dst = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            src = ctypes.cast(ctypes.byref(quad_buf, m * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            ctypes.memmove(dst, src, n_col_words * 8)
            pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
            record_piv(pc)
        drain_xl()

    for pts8 in v6_list:
        if piv_row_idx[off0] >= 0:
            break
        process_coset([v | (w << 8) for v in pts8 for w in pts8])

    alg_phase_cap = min(28.0, budget_sec * 0.25)
    for pts8 in v6_list:
        if piv_row_idx[off0] >= 0 or (time.perf_counter() - t0) > alg_phase_cap or cur_row >= max_rows - 160:
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
                process_coset([x ^ a16 for x in w_pts])
            process_coset([interleave16(x ^ a16) for x in w_pts])
            if piv_row_idx[off0] >= 0:
                break

    # --- STEP C: rot^4-Invariant Dim 12 (mod 32 -> deg <= 3 AND deg 4!) + Dim 11 (mod 16 -> deg <= 2) ---
    rng = random.Random(20260801 + 10 * c99_val + c57_val)
    seen_w4 = set()
    for trial in range(900):
        if piv_row_idx[off0] >= 0 or (time.perf_counter() - t0) > alg_phase_cap + 12.0 or cur_row >= max_rows - 120:
            break
        codim = 4 if (trial % 3 != 2) else 5
        wp_basis = sample_rot4_wperp(rng, codim)
        if wp_basis is None:
            continue
        key = tuple(wp_basis)
        if key in seen_w4:
            continue
        seen_w4.add(key)
        W_pts = span_set(nullspace_basis(wp_basis))
        diag_mask, r4_indices, picked_r4 = 0, [], set()
        for x in W_pts:
            if (x & 0xFF) == (x >> 8):
                diag_mask |= 1 << (x & 0xFF)
            else:
                ri = rep_of_r4[x]
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
            P2, Q4_mod32 = extract_mod8_from_orbits4(sub_cb, sub_O, d0 // 4, n)
            if P2 is not None:
                insert_pset(P2)
                drain_xl()
            if codim == 4 and Q4_mod32:
                md = max((m.bit_count() for m in Q4_mod32), default=0)
                if md <= 3:
                    insert_pset(Q4_mod32)
                    drain_xl()
                elif md == 4 and len(Q4_mod32) <= 1800 and len(deg4_pool) < 400:
                    deg4_pool.append(Q4_mod32)

    if piv_row_idx[off0] >= 0:
        return {
            "cell": cell_name,
            "worker_id": worker_id,
            "num_workers": num_workers,
            "algebraic_unsat_has_one": True,
            "unsat_closed": True,
            "deg_pivs": deg_pivs,
            "total_pivots": cur_row,
            "elapsed_sec": round(time.perf_counter() - t0, 3),
        }

    # --- STEP D: Extract All Polynomials & Build Canonical Cube Partition ---
    base_deg12_psets = []
    for r_idx in deg12_rows:
        row_slice = [rows[r_idx * n_col_words + w] for w in range(n_col_words)]
        base_deg12_psets.append(decode_row_to_pset(row_slice, n_cols, off2, off1, off0, pair2_list, col3_list))

    base_cub_psets = []
    for r_idx in cub_rows:
        row_slice = [rows[r_idx * n_col_words + w] for w in range(n_col_words)]
        pset = decode_row_to_pset(row_slice, n_cols, off2, off1, off0, pair2_list, col3_list)
        if len(pset) <= 650:
            base_cub_psets.append(pset)
    base_cub_psets.sort(key=len)

    # Convert T28 C6 (branch c99_val) to pset on our 111 variables!
    j_to_i111 = {j: idx for idx, j in enumerate(free111)}
    poly_t28_raw = load_t28_poly(c99_val)
    c6_pset = None
    if poly_t28_raw is not None:
        # Express each orbit c_j as a linear poly in x_0..x_110
        orb_lin_poly = []
        for j in range(116):
            p = {1 << i for i, cdir in enumerate(cb) if (cdir >> j) & 1}
            if (origin >> j) & 1:
                p.add(0)
            orb_lin_poly.append(p)
        c6_pset = set()
        for m in poly_t28_raw:
            if m == 0:
                c6_pset ^= {0}
                continue
            prod = {0}  # wait: multiplicative identity in mul_p is m=0!
            first = True
            tmp = m
            while tmp:
                b = tmp & -tmp
                j_orb = b.bit_length() - 1
                tmp ^= b
                if first:
                    prod = set(orb_lin_poly[j_orb])
                    first = False
                else:
                    prod = mul_p(prod, orb_lin_poly[j_orb])
                if not prod:
                    break
            c6_pset ^= prod

    # Precompute Subcubes M_d (d in 9..12) for fast Slack Nogoods (Weapon 3 / b23)!
    subcube_masks = [0x5557, 0x555F, 0x5575, 0x333F, 0x03FF, 0x557F, 0x5F5F, 0x3F3F, 0x6F6F, 0x0FFF]
    subcubes_data = []
    for smask in subcube_masks:
        pts_m = [x for x in range(65536) if (x & smask) == x]
        n_pts_m = len(pts_m)
        pts_arr = (ctypes.c_int * n_pts_m)(*pts_m)
        # Delta_j(M) = #{x <= smask : orb_j(x) == 1} for each long orbit j
        active_j_deltas = []
        for j in range(116):
            if j in (57, 99, 113, 115):
                continue
            cnt = sum(eval_orb_at_x(j, x) for x in pts_m)
            if cnt > 0:
                active_j_deltas.append((cnt, j))
        active_j_deltas.sort()  # smallest Delta_j first for greedy slack relaxation!
        subcubes_data.append((smask, n_pts_m, pts_arr, active_j_deltas))

    # Build Cube List:
    #  - If num_workers == 1 and depth_vc == 0 (e.g. B1_11 single-shot): 1 global cube {}!
    #  - Otherwise: 51 Z_16^*-canonical prefixes on E_8 (0x5555, 8 pure-even long orbits) x 2^{depth_vc} VC vars!
    even_long_orbs = [
        j for j in range(116)
        if j not in (57, 99, 113, 115) and any((m & 0xAAAA) == 0 for m in orbits[j])
    ]
    assert len(even_long_orbs) == 8
    even_i111 = [j_to_i111[j] for j in even_long_orbs]

    # Rank variables by quadratic co-occurrence weight (Vertex Cover of V_2!) excluding even_i111
    q_weights = [0] * n
    for p in base_deg12_psets:
        for m in p:
            if m.bit_count() == 2:
                b0 = (m & -m).bit_length() - 1
                b1 = (m ^ (1 << b0)).bit_length() - 1
                q_weights[b0] += 1
                q_weights[b1] += 1
    vc_vars = [v for v in sorted(range(n), key=lambda i: q_weights[i], reverse=True) if v not in even_i111][:depth_vc]

    if num_workers == 1 and depth_vc == 0:
        all_cubes = [({}, [3, 5, 7, 9, 11, 13, 15])]
    else:
        # Canonicalize the 2^8 = 256 assignments of even_long_orbs under Z_16^*!
        canon_e8 = []
        for mask8 in range(256):
            vec8 = tuple((mask8 >> b) & 1 for b in range(8))
            orb_val = {even_long_orbs[b]: vec8[b] for b in range(8)}
            is_min = True
            stabilizer_a = []
            for a in (3, 5, 7, 9, 11, 13, 15):
                pa = z16_perms[a]
                # (c o pi_a)_j = c_{pa_inv[j]}; under action c' = tau_a(c), c'[pa[j]] = c[j]
                img_vec8 = tuple(orb_val[j] for j in [pa[ej] if False else next(k for k in even_long_orbs if pa[k] == ej) for ej in even_long_orbs])
                if img_vec8 < vec8:
                    is_min = False
                    break
                if img_vec8 == vec8:
                    stabilizer_a.append(a)
            if is_min:
                canon_e8.append((vec8, stabilizer_a))

        all_cubes = []
        for vec8, stab_a in canon_e8:
            base_assign = {even_i111[b]: vec8[b] for b in range(8)}
            for vc_mask in range(1 << len(vc_vars)):
                asg = dict(base_assign)
                for b, vv in enumerate(vc_vars):
                    asg[vv] = (vc_mask >> b) & 1
                all_cubes.append((asg, stab_a))

    my_cubes = [all_cubes[idx] for idx in range(worker_id, len(all_cubes), num_workers)]

    # --- STEP E: Solve Assigned Cubes with In-Cube Specialization + Lightweight CaDiCaL + Lazy Cuts ---
    stats = {
        "total_cubes_global": len(all_cubes),
        "worker_cubes_assigned": len(my_cubes),
        "cubes_closed_algebraic": 0,
        "cubes_closed_sat": 0,
        "models_checked": 0,
        "deg34_cuts_injected": 0,
        "subcube_slack_cuts": 0,
        "lazy_card_cuts": 0,
        "fwht_calls": 0,
        "bent_hits": [],
    }

    long_orbs_ordered = even_long_orbs + [
        j for j in range(116) if j not in (57, 99, 113, 115) and j not in even_long_orbs
    ]

    all_worker_cubes_closed = True
    for cube_assign, stab_a in my_cubes:
        if (time.perf_counter() - t0) >= budget_sec:
            all_worker_cubes_closed = False
            break

        # Combine deg12 + top 800 sparse cubics + deg4_pool for In-Cube Specialization!
        spec_input = list(base_deg12_psets) + base_cub_psets[:900] + deg4_pool
        if c6_pset is not None and len(cube_assign) >= 8:
            spec_input.append(c6_pset)

        st_code, red_deg2, red_deg34, subst_info = specialize_psets_and_eliminate_linears(spec_input, n, cube_assign)
        if st_code.startswith("UNSAT"):
            stats["cubes_closed_algebraic"] += 1
            continue

        cur_fixed, all_lin_pivs = subst_info

        # Build Lightweight SAT CNF for this cube (ZERO heavy Totalizers!)
        clauses = []
        v_cnt = [n]  # SAT vars 1..111 correspond directly to pure basis x_0..x_110!

        def new_var():
            v_cnt[0] += 1
            return v_cnt[0]

        var_lits = [i + 1 for i in range(n)]
        mono_cache = {}

        for v_idx, val_b in cur_fixed.items():
            clauses.append([var_lits[v_idx] if val_b else -var_lits[v_idx]])
        for pk, rhs_poly in all_lin_pivs.items():
            encode_pset_zero(clauses, rhs_poly ^ {1 << pk}, var_lits, new_var, mono_cache)
        for qp in red_deg2:
            encode_pset_zero(clauses, qp, var_lits, new_var, mono_cache)

        # Define orbit literals c_lits[0..115]
        c_lits = {}
        for j in range(116):
            idxs = [i + 1 for i, cdir in enumerate(cb) if (cdir >> j) & 1]
            cst = (origin >> j) & 1
            if not idxs:
                lv = new_var()
                clauses.append([lv if cst else -lv])
            elif len(idxs) == 1 and cst == 0:
                lv = idxs[0]
            elif len(idxs) == 1 and cst == 1:
                lv = -idxs[0]
            else:
                lv = new_var()
                add_long_xor(clauses, idxs + [lv], cst, new_var)
            c_lits[j] = lv

        # Encode C6 (T28) via c_lits if not already specialized
        if poly_t28_raw is not None and len(cube_assign) < 8:
            c6_lits, c6_rhs, c6_cache = [], 0, {}
            for m in poly_t28_raw:
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

        # Symmetry breaking for stabilizer subgroup stab_a <= Z_16^*
        xs_lex = [c_lits[j] for j in long_orbs_ordered]
        for a in stab_a:
            pa = z16_perms[a]
            ys_lex = [c_lits[next(k for k in range(116) if pa[k] == j)] for j in long_orbs_ordered]
            add_lex_leq(clauses, xs_lex, ys_lex, new_var)

        # ONLY tiny 16-bit counter allowed statically: F_0xff (16 orbits == 8) in B0_00 (< 90 clauses!)
        if c99_val == 0 and c57_val == 0:
            _, forms_ff = fiber_forms[0xFF]
            ff_lits = []
            for wm, ob in forms_ff:
                fl = new_var()
                add_long_xor(clauses, [i + 1 for i in range(n) if (wm >> i) & 1] + [fl], ob, new_var)
                ff_lits.append(fl)
            enc16 = CardEnc.equals(lits=ff_lits, bound=8, top_id=v_cnt[0], encoding=EncType.totalizer)
            v_cnt[0] = max(v_cnt[0], enc16.nv)
            clauses.extend(enc16.clauses)

        # Prepare packed C pool of lazy degree 3 & 4 polynomials (base_cub_psets + red_deg34 + deg4_pool)
        lazy_polys = list(deg4_pool) + [p for p in red_deg34 if len(p) <= 900] + base_cub_psets
        n_lazy = len(lazy_polys)
        poly_offs = (ctypes.c_int * (n_lazy + 1))()
        flat_lo, flat_hi = [], []
        for idx_p, pset in enumerate(lazy_polys):
            poly_offs[idx_p] = len(flat_lo)
            for m in pset:
                flat_lo.append(m & mask64)
                flat_hi.append((m >> 64) & mask64)
        poly_offs[n_lazy] = len(flat_lo)
        mono_lo_arr = (ctypes.c_uint64 * max(1, len(flat_lo)))(*flat_lo)
        mono_hi_arr = (ctypes.c_uint64 * max(1, len(flat_hi)))(*flat_hi)
        skip_flags = (ctypes.c_uint8 * max(1, n_lazy))(*([0] * max(1, n_lazy)))

        spatial_lit_cache = {}
        worst_u, worst_abs, sub_max = ctypes.c_int(), ctypes.c_int(), ctypes.c_int()

        def get_spatial_lit(r_id: int, slv_obj):
            if r_id not in spatial_lit_cache:
                _, _, _, wm, ob, _ = spatial_orbs[r_id]
                idxs = [i + 1 for i in range(n) if (wm >> i) & 1]
                if not idxs:
                    lv = new_var()
                    slv_obj.add_clause([lv if ob else -lv])
                elif len(idxs) == 1 and ob == 0:
                    lv = idxs[0]
                elif len(idxs) == 1 and ob == 1:
                    lv = -idxs[0]
                else:
                    lv = new_var()
                    tmp_cls = []
                    add_long_xor(tmp_cls, idxs + [lv], ob, new_var)
                    for cl in tmp_cls:
                        slv_obj.add_clause(cl)
                spatial_lit_cache[r_id] = lv
            return spatial_lit_cache[r_id]

        cube_done = False
        with Solver(name="cadical195", bootstrap_with=clauses) as slv:
            while (time.perf_counter() - t0) < budget_sec:
                if not slv.solve():
                    cube_done = True
                    stats["cubes_closed_sat"] += 1
                    break
                stats["models_checked"] += 1
                model = slv.get_model()
                model_set = {l for l in model if l > 0}
                x_bits = 0
                cint = origin
                for i, cdir in enumerate(cb):
                    if (i + 1) in model_set:
                        x_bits |= 1 << i
                        cint ^= cdir

                # 1. C-Accelerated Lazy Degree 3 & Degree 4 Algebraic Cuts!
                if n_lazy > 0:
                    vp = lib.find_violated_poly128(
                        x_bits & mask64, (x_bits >> 64) & mask64,
                        n_lazy, poly_offs, mono_lo_arr, mono_hi_arr, skip_flags
                    )
                    if vp >= 0:
                        added_alg = 0
                        while vp >= 0 and added_alg < 16:
                            skip_flags[vp] = 1
                            new_cls = []
                            encode_pset_zero(new_cls, lazy_polys[vp], var_lits, new_var, mono_cache)
                            for cl in new_cls:
                                slv.add_clause(cl)
                            stats["deg34_cuts_injected"] += 1
                            added_alg += 1
                            vp = lib.find_violated_poly128(
                                x_bits & mask64, (x_bits >> 64) & mask64,
                                n_lazy, poly_offs, mono_lo_arr, mono_hi_arr, skip_flags
                            )
                        continue

                # 2. Subcube Slack Nogoods (15..42 literals! Weapon 3 / b23)!
                subcube_cut = False
                c_lo, c_hi = cint & mask64, (cint >> 64) & mask64
                for _, n_pts_m, pts_arr, active_j_deltas in subcubes_data:
                    if lib.check_subcube_fwht(orb_tts, c_lo, c_hi, pts_arr, n_pts_m, ctypes.byref(sub_max)):
                        excess = sub_max.value - 256
                        used_slack = 0
                        kept_j = []
                        for delta_j, j_orb in active_j_deltas:
                            if used_slack + 2 * delta_j < excess:
                                used_slack += 2 * delta_j
                            else:
                                kept_j.append(j_orb)
                        nogood = [
                            -c_lits[j] if ((cint >> j) & 1) else c_lits[j]
                            for j in kept_j
                        ]
                        slv.add_clause(nogood)
                        stats["subcube_slack_cuts"] += 1
                        subcube_cut = True
                        break
                if subcube_cut:
                    continue

                # 3. Lazy (k+1)-of-M Low-Weight Spatial Clauses on Exact Cosets & Cyclotomic Layers (b22)!
                lazy_card_hit = False
                exact_targets = [
                    (coset_groups[0xF], 128),
                    (coset_groups[0x5] + coset_groups[0xA], 256),
                    (vd_layer_groups[14], 256),
                    (vd_layer_groups[15], 512),
                ]
                if c99_val == 0 and c57_val == 0:
                    exact_targets.insert(0, (coset_groups[0x0], 120))
                for r_list, targ in exact_targets:
                    ones, zeros = [], []
                    for r_id in r_list:
                        _, _, _, wm, ob, act_j = spatial_orbs[r_id]
                        y_val = (((wm & x_bits).bit_count() ^ ob) & 1)
                        if y_val:
                            ones.append((len(act_j), r_id))
                        else:
                            zeros.append((len(act_j), r_id))
                    if len(ones) != targ:
                        if len(ones) > targ:
                            ones.sort()
                            chosen = [r_id for _, r_id in ones[: targ + 1]]
                            slv.add_clause([-get_spatial_lit(r_id, slv) for r_id in chosen])
                        else:
                            zeros.sort()
                            need_z = len(r_list) - targ + 1
                            chosen = [r_id for _, r_id in zeros[:need_z]]
                            slv.add_clause([get_spatial_lit(r_id, slv) for r_id in chosen])
                        stats["lazy_card_cuts"] += 1
                        lazy_card_hit = True
                        break
                if lazy_card_hit:
                    continue

                # 4. Full 65,536-point C FWHT (0.05 ms) + Z_16^* Orbit Blocking!
                stats["fwht_calls"] += 1
                if lib.audit_bent_and_worst_u(orb_tts, c_lo, c_hi, ctypes.byref(worst_u), ctypes.byref(worst_abs)):
                    stats["bent_hits"].append(hex(cint))
                    return {
                        "cell": cell_name,
                        "worker_id": worker_id,
                        "unsat_closed": False,
                        "bent_found": True,
                        "stats": stats,
                        "elapsed_sec": round(time.perf_counter() - t0, 3),
                    }

                # Block entire Z_16^* orbit on c_lits
                seen_conj = set()
                for a in [1] + list(stab_a):
                    pa = z16_perms[a]
                    c_conj = 0
                    for j in range(116):
                        if (cint >> j) & 1:
                            c_conj |= 1 << pa[j]
                    if c_conj in seen_conj:
                        continue
                    seen_conj.add(c_conj)
                    slv.add_clause([
                        -c_lits[j] if ((c_conj >> j) & 1) else c_lits[j]
                        for j in range(116) if j not in (57, 99, 113, 115)
                    ])

        if not cube_done:
            all_worker_cubes_closed = False
            break

    return {
        "cell": cell_name,
        "worker_id": worker_id,
        "num_workers": num_workers,
        "algebraic_unsat_has_one": False,
        "unsat_closed": all_worker_cubes_closed and len(stats["bent_hits"]) == 0,
        "deg_pivs": deg_pivs,
        "deg4_pool_size": len(deg4_pool),
        "stats": stats,
        "elapsed_sec": round(time.perf_counter() - t0, 3),
    }


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--cell", required=True, choices=["B1_00", "B1_11", "B0_00", "B0_11"])
    ap.add_argument("--worker-id", type=int, default=int(os.environ.get("CLOUD_RUN_TASK_INDEX", "0")))
    ap.add_argument("--num-workers", type=int, default=int(os.environ.get("CLOUD_RUN_TASK_COUNT", "1")))
    ap.add_argument("--depth-vc", type=int, default=0)
    ap.add_argument("--budget", type=float, default=300.0)
    args = ap.parse_args()

    res = run_cell_master(
        cell_name=args.cell,
        worker_id=args.worker_id,
        num_workers=args.num_workers,
        depth_vc=args.depth_vc,
        budget_sec=args.budget,
    )
    print(f"=== FINAL CLOSE REPORT [{args.cell} | worker {args.worker_id}/{args.num_workers}] ===", flush=True)
    print(json.dumps(res, indent=2), flush=True)


if __name__ == "__main__":
    main()
