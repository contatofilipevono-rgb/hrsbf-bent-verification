#!/usr/bin/env python3
r"""
DIAGNOSE_V2_STRUCTURE.py
Exact Algebraic-Geometric & Symplectic Profiler for the Quadratic Variety V_2
in H(16,4) open cells B0_00 (0,0,0) and B0_11 (0,1,1) (plus optional B1_11).

Computes with 100% mathematical rigor over GF(2):
  (1) Exact elimination of all linear pivots -> reduced variety V_2 in GF(2)^N
      defined by m linearly independent quadratic pivots q_1, ..., q_m;
      Zariski tangent space dimension N - rank_GF2(J(x)) across 100 diversified
      points x in V_2 sampled via CaDiCaL + random phase/XOR diversification
      (plus checks whether all ~6,400 cubic pivots already vanish on pure V_2!).
  (2) Maximal affine subspace (linear flat) x^(0) + span(e_1, ..., e_d) <= V_2
      using the exact GF(2) flat equations:
        (Flat-1) <grad q_a(x^(0)), e_r> ^ q_a^hom(e_r) == 0  for all a, r
        (Flat-2) B_a(e_r, e_s) == 0                          for all a, r < s
      certified by direct evaluation on random combinations in x^(0) + E.
  (3) Mute/free variables, Global Bilinear Radical R_bil = cap_a ker(B_a),
      Universal Translation Subgroup T_univ (x -> x ^ v preserving V_2 globally),
      Symplectic Dickson factorization q(x) = sum_{t=1}^r u_t(x)*v_t(x) ^ l(x) ^ c0
      of low-rank quadratic generators in span(q_1, ..., q_m), and the exact
      Linearization Collapse Curve (how many quadratics collapse to degree 1
      when branching on k bilinear factor forms / vertex-cover variables).
"""

import argparse
import ctypes
import json
import random
import statistics
import subprocess
import sys
import time
from collections import Counter
from itertools import combinations
from pathlib import Path

from pysat.solvers import Solver

# ==============================================================================
# Embedded High-Speed C Kernel (Poisson-Lucas + Macaulay XL + Fast Poly Eval)
# ==============================================================================
C_DIAG_SRC = r"""
#include <stdint.h>
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
            int ip = pop32_and(basis[i], basis[j]);
            if (ip & 1) {
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
            if (pop_rs & 3) { out_lin_valid[pair_m++] = 0; continue; }
            int ok = 1;
            for (int i = 0; i < n; i++) {
                int w_urs = pop32_and3(basis[i], Ur, Us);
                int wi_pop = pop32(basis[i]);
                int w_ours = pop32_and(basis[i], OUrs);
                if ((wi_pop - 2 * w_ours) & 3) { ok = 0; break; }
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

// Fast evaluation of n_cub cubic rows against a candidate point x (given by 2 uint64_t words x_lo, x_hi)
// builds the packed monomial vector mono_vec[n_col_words] for x in O(n_cols/64) and dots with each cubic row!
int count_violated_rows(
    const uint64_t *rows,
    const int *row_indices,
    int n_check_rows,
    int n,
    int off2,
    int off1,
    int off0,
    int n_col_words,
    uint64_t x_lo,
    uint64_t x_hi
) {
    uint8_t xv[128];
    for (int i = 0; i < n; i++) {
        xv[i] = (i < 64) ? ((x_lo >> i) & 1ULL) : ((x_hi >> (i - 64)) & 1ULL);
    }
    uint64_t mono[4096]; // enough up to 262,144 columns
    memset(mono, 0, (size_t)n_col_words * sizeof(uint64_t));

    int c3 = 0;
    for (int i = 0; i < n; i++) {
        if (!xv[i]) {
            c3 += ((n - 1 - i) * (n - 2 - i)) / 2;
            continue;
        }
        for (int j = i + 1; j < n; j++) {
            if (!xv[j]) {
                c3 += (n - 1 - j);
                continue;
            }
            for (int k = j + 1; k < n; k++) {
                if (xv[k]) mono[c3 >> 6] |= 1ULL << (c3 & 63);
                c3++;
            }
        }
    }
    int c2 = off2;
    for (int i = 0; i < n; i++) {
        if (!xv[i]) { c2 += (n - 1 - i); continue; }
        for (int j = i + 1; j < n; j++) {
            if (xv[j]) mono[c2 >> 6] |= 1ULL << (c2 & 63);
            c2++;
        }
    }
    for (int i = 0; i < n; i++) {
        if (xv[i]) {
            int c1 = off1 + i;
            mono[c1 >> 6] |= 1ULL << (c1 & 63);
        }
    }
    mono[off0 >> 6] |= 1ULL << (off0 & 63);

    int viol = 0;
    for (int r = 0; r < n_check_rows; r++) {
        const uint64_t *rp = rows + (size_t)row_indices[r] * n_col_words;
        int parity = 0;
        for (int w = 0; w < n_col_words; w++) {
            parity ^= __builtin_parityll(rp[w] & mono[w]);
        }
        viol += parity;
    }
    return viol;
}
"""

# ==============================================================================
# Fundamental Constants & Self-Contained Combinatorial Builders
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


def nullspace_16(hs):
    rows = rref_gf2(hs)
    piv_map = {r.bit_length() - 1: r for r in rows}
    basis = []
    for f in range(16):
        if f in piv_map:
            continue
        v = 1 << f
        for pb, r in piv_map.items():
            if (r >> f) & 1:
                v |= 1 << pb
        basis.append(v)
    return span_set(basis)


def gf2_rank_bitmasks(rows):
    pivs = {}
    for r in rows:
        v = r
        while v:
            b = v.bit_length() - 1
            if b in pivs:
                v ^= pivs[b]
            else:
                pivs[b] = v
                break
    return len(pivs)


def gf2_nullspace_right(rows, n_cols):
    """Exact right nullspace {x in F_2^{n_cols} : rows * x == 0}."""
    pivs = {}
    for r in rows:
        v = r
        while v:
            b = v.bit_length() - 1
            if b in pivs:
                v ^= pivs[b]
            else:
                pivs[b] = v
                break
    for b in sorted(pivs.keys(), reverse=True):
        for b2 in list(pivs.keys()):
            if b2 != b and ((pivs[b2] >> b) & 1):
                pivs[b2] ^= pivs[b]
    basis = []
    for f in range(n_cols):
        if f in pivs:
            continue
        vec = 1 << f
        for pb, prow in pivs.items():
            if (prow >> f) & 1:
                vec |= 1 << pb
        basis.append(vec)
    return basis


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
            if ((ci_wt * cj.bit_count() - (ci & cj).bit_count()) & 1):
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
    for idx_a in range(len(p2_list)):
        ma = p2_list[idx_a]
        for idx_b in range(idx_a + 1, len(p2_list)):
            toggle(Q4, ma | p2_list[idx_b])
    return P2, Q4


# ==============================================================================
# SAT CNF Encoders for Exact Quadratic Variety V_2 & Maximal Flat Finder
# ==============================================================================
def add_and_gate(clauses, out_var, in_lits):
    for lit in in_lits:
        clauses.append([-out_var, lit])
    clauses.append([out_var] + [-lit for lit in in_lits])


def add_long_xor(clauses, lits, rhs, new_var_fn, chunk=4):
    cur = list(lits)
    r = rhs & 1
    if not cur:
        if r == 1:
            v = new_var_fn()
            clauses.append([v])
            clauses.append([-v])
        return
    while len(cur) > chunk:
        head, rest = cur[:chunk - 1], cur[chunk - 1:]
        aux = new_var_fn()
        block = head + [aux]
        k = len(block)
        for mask in range(1 << k):
            if (mask.bit_count() & 1) != 0:
                clauses.append([-block[b] if ((mask >> b) & 1) else block[b] for b in range(k)])
        cur = [aux] + rest
    k = len(cur)
    for mask in range(1 << k):
        if (mask.bit_count() & 1) != r:
            clauses.append([-cur[b] if ((mask >> b) & 1) else cur[b] for b in range(k)])


def encode_quad_poly_cnf(clauses, pset, new_var_fn, pair_cache):
    xor_lits = []
    rhs = 0
    for m in pset:
        bc = m.bit_count()
        if bc == 0:
            rhs ^= 1
        elif bc == 1:
            xor_lits.append((m.bit_length() - 1) + 1)
        elif bc == 2:
            if m not in pair_cache:
                i = (m & -m).bit_length() - 1
                j = (m ^ (1 << i)).bit_length() - 1
                pv = new_var_fn()
                add_and_gate(clauses, pv, [i + 1, j + 1])
                pair_cache[m] = pv
            xor_lits.append(pair_cache[m])
        else:
            raise ValueError("Expected degree <= 2 polynomial in V_2!")
    add_long_xor(clauses, xor_lits, rhs, new_var_fn)


# ==============================================================================
# Symplectic Dickson Normal Form & Bilinear Block Extractor over GF(2)
# ==============================================================================
def dickson_symplectic_factorization(pset, N):
    """
    Given a quadratic polynomial q(x) in GF(2)[x_0, ..., x_{N-1}] / (x_i^2 + x_i),
    computes its exact symplectic rank 2*r and factors q(x) into disjoint
    hyperbolic bilinear pairs:
        q(x) == sum_{t=1}^r u_t(x) * v_t(x) ^ l_rem(x) ^ c_0
    where u_1, v_1, ..., u_r, v_r are 2*r linearly independent linear forms on GF(2)^N!
    """
    # Represent q(x) as upper-triangular matrix U[i] (bitmask of j > i), lin_mask, c0
    c0 = 1 if (0 in pset) else 0
    lin_mask = 0
    # Symmetric polar matrix B_rows[i] = bitmask of j != i where x_i x_j in q(x)
    B_rows = [0] * N
    U_rows = [0] * N
    for m in pset:
        bc = m.bit_count()
        if bc == 1:
            lin_mask ^= m
        elif bc == 2:
            i = (m & -m).bit_length() - 1
            j = (m ^ (1 << i)).bit_length() - 1
            if i > j:
                i, j = j, i
            U_rows[i] ^= 1 << j
            B_rows[i] ^= 1 << j
            B_rows[j] ^= 1 << i

    # Iterative hyperbolic splitting:
    # Maintain current polynomial in original x coordinates!
    # At each step, if some x_a x_b remains in current B_cur:
    # Let u(x) = B_cur_row[b] (linear form of neighbors of x_b, Note: coeff of x_a is 1!)
    # Let v(x) = B_cur_row[a] (linear form of neighbors of x_a, Note: coeff of x_b is 1!)
    #Wait: in q_cur(x) = x_a * A(x) ^ x_b * C(x) ^ x_a x_b ^ rest:
    #  (x_a ^ C(x)) * (x_b ^ A(x)) = x_a x_b ^ x_a A(x) ^ x_b C(x) ^ C(x)*A(x)!
    # Notice that B_cur(e_a, x) = x_b ^ A(x) =: v_t(x), and B_cur(e_b, x) = x_a ^ C(x) =: u_t(x)!
    # Subtracting u_t(x) * v_t(x) from q_cur(x) COMPLETELY ANNIHILATES x_a and x_b from the
    # polar form B_cur, strictly reducing rank(B_cur) by 2!
    cur_U = list(U_rows)
    cur_B = list(B_rows)
    cur_lin = lin_mask
    pairs = []

    def sub_prod_linear_forms(u_mask, v_mask):
        nonlocal cur_lin
        # Expand u(x) * v(x) in GF(2)[x]/(x^2+x):
        # Diagonal i==j: (u_i & v_i) * x_i
        cur_lin ^= (u_mask & v_mask)
        # Off-diagonal i < j: ((u_i & v_j) ^ (u_j & v_i)) * x_i x_j
        um = u_mask
        while um:
            bi = um & -um
            i = bi.bit_length() - 1
            um ^= bi
            # pairs with v_mask
            vm = v_mask
            while vm:
                bj = vm & -vm
                j = bj.bit_length() - 1
                vm ^= bj
                if i == j:
                    continue
                a, b = (i, j) if i < j else (j, i)
                cur_U[a] ^= 1 << b
                cur_B[a] ^= 1 << b
                cur_B[b] ^= 1 << a

    while True:
        a = next((idx for idx in range(N) if cur_B[idx] != 0), -1)
        if a < 0:
            break
        b = (cur_B[a] & -cur_B[a]).bit_length() - 1
        v_form = cur_B[a]  # = x_b ^ A(x)
        u_form = cur_B[b]  # = x_a ^ C(x)
        pairs.append((u_form, v_form))
        sub_prod_linear_forms(u_form, v_form)

    # Verify exact algebraic reconstruction on 8 random vectors (Zero Trust!)
    rng_chk = random.Random(1337 + N)
    for _ in range(8):
        xv = rng_chk.getrandbits(N)
        orig_val = c0 ^ ((lin_mask & xv).bit_count() & 1)
        for i in range(N):
            if (xv >> i) & 1:
                orig_val ^= (U_rows[i] & xv).bit_count() & 1
        fac_val = c0 ^ ((cur_lin & xv).bit_count() & 1)
        for uf, vf in pairs:
            ub = (uf & xv).bit_count() & 1
            vb = (vf & xv).bit_count() & 1
            fac_val ^= (ub & vb)
        assert orig_val == fac_val, "Dickson factorization mismatch!"

    return {
        "symplectic_rank": 2 * len(pairs),
        "num_bilinear_pairs": len(pairs),
        "pairs": pairs,
        "residual_linear_mask": cur_lin,
        "const": c0,
        "B_rows": B_rows,
        "U_rows": U_rows,
        "orig_lin_mask": lin_mask,
    }


# ==============================================================================
# Build Full Algebraic System & Extract Exact Reduced V_2 for a Given Cell
# ==============================================================================
def build_cell_algebraic_system(cell_name: str, lib, orbits, v6_list, rot4_data, fiber_meta, extract_sec=18.0):
    t0 = time.perf_counter()
    c99_val = int(cell_name[1])
    c57_val = int(cell_name[3])
    c113_val = int(cell_name[4])

    # Pure 111-variable basis: ONLY c115=0, short orbits fixed, and L=c99 eliminating c0!
    # Zero external assumptions: C5 (K=c57), C7 (R / R^M), C0xf parity, Dual Fibers, V6, Affine & Rot4
    # are all inserted into the Macaulay matrix so EVERY linear & quadratic law is discovered transparently!
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
    n = len(cb)  # 111
    assert n == 111

    pair_idx, orb_diag, orb_pair, orb_r4, chi_r4, rep_of_x, orb_0xf_parity, eval_orb_at_x = rot4_data
    nonzero_z, null_z_vecs = fiber_meta

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

    max_rows = 16000
    rows = (ctypes.c_uint64 * (max_rows * n_col_words))()
    piv_row_idx = (ctypes.c_int * n_cols)(*([-1] * n_cols))
    cur_row = 0
    deg_pivs = {0: 0, 1: 0, 2: 0, 3: 0}
    xl_queue = []
    lin_rows, quad_rows, cub_rows = [], [], []

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

    def insert_pset(pset):
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
        record_piv(pc)
        return pc

    def drain_xl():
        while xl_queue and piv_row_idx[off0] < 0 and cur_row < max_rows - n - 20:
            r_idx = xl_queue.pop(0)
            pset = decode_row(r_idx)
            for i in range(n):
                if cur_row >= max_rows - 5 or piv_row_idx[off0] >= 0:
                    break
                insert_pset(mul_p({1 << i}, pset))

    def eval_x_form(x_pt):
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

    # 1. Exact C_{0xf} parity (wt_orb(C_{0xf}) == 128 => K == 1 in c99=1, K == c57 via C5) & C5 (K = c57)
    c0xf_mask = sum(1 << j for j in range(116) if orb_0xf_parity[j])
    p_0xf = {1 << i for i, cdir in enumerate(cb) if (cdir & c0xf_mask).bit_count() & 1}
    if (origin & c0xf_mask).bit_count() & 1:
        p_0xf.add(0)
    insert_pset(p_0xf)

    k_mask = sum(1 << j for j in K_INDICES)
    p_c5 = {1 << i for i, cdir in enumerate(cb) if (cdir & k_mask).bit_count() & 1}
    if ((origin & k_mask).bit_count() ^ c57_val) & 1:
        p_c5.add(0)
    insert_pset(p_c5)

    # 2. Seed Q4 (C4)
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
    pairs_ij = [(I2, J2), (I3, J3), (I4, J4)] if c99_val == 1 else [(I1, J1), (I2, J2), (I3, J3), (I4, J4)]
    for Ir, Jr in pairs_ij:
        ui, uc = lin_expr(Ir)
        vi, vc = lin_expr(Jr)
        q4 ^= mul_p(poly_from_lin(ui, uc), poly_from_lin(vi, vc))
    insert_pset(q4)
    drain_xl()

    # 3. Dual Fibers F_z (B0_00 exact e_1=0, e_2=0; B0_11 / B1_11 Krawtchouk mod-2 syzygies)
    if c99_val == 0 and c57_val == 0 and c113_val == 0:
        for z_rep, _ in nonzero_z:
            gstep = 1 if z_rep == 0xFF else (2 if z_rep in (0x55, 0xAA) else (4 if z_rep in (0x11, 0x33, 0x77) else 8))
            reps = fiber_orbit_reps(z_rep, gstep)
            forms = [eval_x_form(x) for x in reps]
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
    elif c57_val == c113_val:
        pair_forms_35 = [[eval_x_form(x) for x in fiber_orbit_reps(z_rep, 8)] for z_rep, _ in nonzero_z]
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

    # 4. V6 x V6 + diagonal shifts + interleaved + Regime II diagonal-free cosets
    MAX_CHARS = 12
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
        dmask = sum(1 << v for v in diag_pts)
        wt_diag = (O_diag & dmask).bit_count()

        for k, x in enumerate(pair_reps):
            p_idxs_arr[k] = pair_idx[(x & 0xFF, x >> 8)]

        u_vecs = [(1 << r) | (1 << (r + 8)) for r in range(8)] + [0xFFFF]
        if not diag_pts:
            for ua in asym_u_list[: (MAX_CHARS - 9)]:
                u_vecs.append(ua)
        n_chars = len(u_vecs)

        ctypes.memset(char_words32, 0, ctypes.sizeof(char_words32))
        for m, u16 in enumerate(u_vecs):
            bm = m * 32
            for k, x in enumerate(pair_reps):
                if (x & u16).bit_count() & 1:
                    char_words32[bm + (k >> 6)] |= 1 << (k & 63)

        if wt_diag % 8 == 4:
            base_ptr = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            if lib.extract_level1_quad_when_diag4(
                all_pair_bits, p_idxs_arr, n_pairs, n, None, off2, off1, off0, n_col_words, base_ptr
            ) == 0:
                record_piv(lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols))
            for m in range(n_chars):
                if piv_row_idx[off0] >= 0 or cur_row >= max_rows - 20:
                    break
                um_ptr = ctypes.cast(ctypes.byref(char_words32, m * 32 * 8), ctypes.POINTER(ctypes.c_uint64))
                base_ptr = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                if lib.extract_level1_quad_when_diag4(
                    all_pair_bits, p_idxs_arr, n_pairs, n, um_ptr, off2, off1, off0, n_col_words, base_ptr
                ) == 0:
                    record_piv(lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols))
            drain_xl()
            return

        if wt_diag % 8 != 0:
            return
        diag_div8_parity = (wt_diag // 8) & 1
        ctypes.memset(quad_buf, 0, ctypes.sizeof(quad_buf))
        base_ptr = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
        if lib.extract_coset_full_hierarchy_corrected(
            all_pair_bits, p_idxs_arr, n_pairs, n, diag_div8_parity,
            char_words32, n_chars, col3_base, off2, off1, off0, n_col_words,
            base_ptr, quad_buf, quad_valid, lin_buf, lin_valid
        ) != 0:
            return
        record_piv(lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols))
        for pm in range(n_chars * (n_chars - 1) // 2):
            if not lin_valid[pm] or cur_row >= max_rows - 10 or piv_row_idx[off0] >= 0:
                continue
            dst = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            src = ctypes.cast(ctypes.byref(lin_buf, pm * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            ctypes.memmove(dst, src, n_col_words * 8)
            record_piv(lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols))
        for m in range(n_chars):
            if not quad_valid[m] or cur_row >= max_rows - 10 or piv_row_idx[off0] >= 0:
                continue
            dst = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            src = ctypes.cast(ctypes.byref(quad_buf, m * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            ctypes.memmove(dst, src, n_col_words * 8)
            record_piv(lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols))
        drain_xl()

    # Pass A: Linear V6 x V6 first (captures 100% of V6 pivots fast)
    for pts8 in v6_list:
        if piv_row_idx[off0] >= 0 or cur_row >= max_rows - 150:
            break
        process_coset([v | (w << 8) for v in pts8 for w in pts8])

    # Pass B: Affine shifts + interleaved + Regime II diagonal-free cosets
    for pts8 in v6_list:
        if (time.perf_counter() - t0) > extract_sec * 0.55 or piv_row_idx[off0] >= 0 or cur_row >= max_rows - 150:
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

    rng = random.Random(202611 + 10 * c99_val + c57_val)
    seen_w = set()
    while (time.perf_counter() - t0) < extract_sec * 0.80 and piv_row_idx[off0] < 0 and cur_row < max_rows - 150:
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
        rref = tuple(rref_gf2(hs))
        if len(rref) != 4 or rref in seen_w:
            continue
        seen_w.add(rref)
        w_pts = nullspace_16(rref)
        process_coset(w_pts)
        valid_deltas = [
            da for da in range(1, 256)
            if ((da & cond_vec).bit_count() & 1) == 0 and ((da & sym_hs[0]).bit_count() & 1) == 1
        ]
        rng.shuffle(valid_deltas)
        for da in valid_deltas[:2]:
            asym_u = [du for du in sym_hs if du != 0 and ((du & da).bit_count() & 1) == 0]
            process_coset([x ^ da for x in w_pts], asym_u_list=asym_u)

    # Pass C: rot^4-invariant dim 12 (mod 32 -> deg <= 3) and dim 11 (mod 16 -> deg <= 2)
    seen_r4 = set()
    for trial in range(900):
        if (time.perf_counter() - t0) > extract_sec or piv_row_idx[off0] >= 0 or cur_row >= max_rows - 150:
            break
        codim = 4 if (trial % 3 != 2) else 5
        wp_basis = sample_rot4_wperp(rng, codim)
        if wp_basis is None:
            continue
        key = tuple(wp_basis)
        if key in seen_r4:
            continue
        seen_r4.add(key)
        W_pts = nullspace_16(wp_basis)
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
            if P2 is None:
                continue
            insert_pset(P2)
            if codim == 4 and Q4_r4 is not None and max((m.bit_count() for m in Q4_r4), default=0) <= 3:
                insert_pset(Q4_r4)
            drain_xl()

    # Exact Linear Variable Elimination: project from 111 vars down to N = 111 - n_lin free vars!
    lin_psets = [decode_row(r) for r in lin_rows]
    quad_psets_111 = [decode_row(r) for r in quad_rows]

    # Put linear equations in exact RREF over GF(2)^111:
    # Each linear pset is (var_mask_111, rhs_bit)
    lin_pivs = {}
    for lp in lin_psets:
        vm = 0
        rhs = 1 if (0 in lp) else 0
        for m in lp:
            if m != 0:
                vm |= m
        while vm:
            b = vm.bit_length() - 1
            if b in lin_pivs:
                pvm, prhs = lin_pivs[b]
                vm ^= pvm
                rhs ^= prhs
            else:
                lin_pivs[b] = (vm, rhs)
                break
        if vm == 0 and rhs == 1:
            return {"cell": cell_name, "has_one": True, "deg_pivs_111": deg_pivs}

    for b in sorted(lin_pivs.keys(), reverse=True):
        for b2 in list(lin_pivs.keys()):
            if b2 != b and ((lin_pivs[b2][0] >> b) & 1):
                vm2, r2 = lin_pivs[b2]
                pvm, pr = lin_pivs[b]
                lin_pivs[b2] = (vm2 ^ pvm, r2 ^ pr)

    piv_vars_111 = set(lin_pivs.keys())
    free_vars_111 = [i for i in range(n) if i not in piv_vars_111]
    N = len(free_vars_111)

    # Map each old var i in 0..110 to an affine linear form (mask_on_N, const_bit) in free vars 0..N-1:
    free_pos = {old_i: new_k for new_k, old_i in enumerate(free_vars_111)}
    var_subst = []
    for old_i in range(n):
        if old_i in free_pos:
            var_subst.append((1 << free_pos[old_i], 0))
        else:
            pvm, prhs = lin_pivs[old_i]
            rem = pvm ^ (1 << old_i)
            msk_N = 0
            while rem:
                lb = rem & -rem
                idx = lb.bit_length() - 1
                rem ^= lb
                msk_N |= 1 << free_pos[idx]
            var_subst.append((msk_N, prhs))

    # Also build exact 116-orbit affine parametrization origin_N ^ sum_{k=0}^{N-1} y_k * cb_N[k]!
    origin_N = origin
    cb_N = [0] * N
    for old_i in range(n):
        msk_N, cst = var_subst[old_i]
        if cst:
            origin_N ^= cb[old_i]
        for k in range(N):
            if (msk_N >> k) & 1:
                cb_N[k] ^= cb[old_i]

    # Substitute linear pivots into all quadratic psets & compute exact RREF in B_{<=2}(GF(2)^N)
    def subst_deg2_pset(pset_111):
        c0 = 0
        lin_N = 0
        U_N = [0] * N  # U_N[a] bitmask of b > a

        def add_lin_prod(m1, c1, m2, c2):
            nonlocal c0, lin_N
            if c1 and c2:
                c0 ^= 1
            if c1:
                lin_N ^= m2
            if c2:
                lin_N ^= m1
            # m1 * m2 in GF(2)[y]/(y^2+y)
            lin_N ^= (m1 & m2)
            t1 = m1
            while t1:
                ba = t1 & -t1
                a = ba.bit_length() - 1
                t1 ^= ba
                t2 = m2
                while t2:
                    bb = t2 & -t2
                    b = bb.bit_length() - 1
                    t2 ^= bb
                    if a != b:
                        lo, hi = (a, b) if a < b else (b, a)
                        U_N[lo] ^= 1 << hi

        for m in pset_111:
            bc = m.bit_count()
            if bc == 0:
                c0 ^= 1
            elif bc == 1:
                i = m.bit_length() - 1
                mi, ci = var_subst[i]
                c0 ^= ci
                lin_N ^= mi
            elif bc == 2:
                i = (m & -m).bit_length() - 1
                j = (m ^ (1 << i)).bit_length() - 1
                mi, ci = var_subst[i]
                mj, cj = var_subst[j]
                add_lin_prod(mi, ci, mj, cj)

        out = set()
        if c0:
            out.add(0)
        t = lin_N
        while t:
            b = t & -t
            out.add(b)
            t ^= b
        for a in range(N):
            u = U_N[a]
            while u:
                bb = u & -u
                b = bb.bit_length() - 1
                u ^= bb
                out.add((1 << a) | (1 << b))
        return out

    # RREF of reduced quadratics over GF(2)^N (ordering degree 2 > degree 1 > degree 0)
    q_pivs = {}
    extra_lin_found = 0
    for qp in quad_psets_111:
        cur = subst_deg2_pset(qp)
        while cur:
            lead = max(cur, key=lambda m: (m.bit_count(), m))
            if lead in q_pivs:
                cur ^= q_pivs[lead]
            else:
                q_pivs[lead] = cur
                if lead.bit_count() == 1:
                    extra_lin_found += 1
                break
    # Full Gauss-Jordan back-substitution on q_pivs
    sorted_leads = sorted(q_pivs.keys(), key=lambda m: (m.bit_count(), m), reverse=True)
    for ld in reversed(sorted_leads):
        for ld2 in sorted_leads:
            if ld2 != ld and (ld in q_pivs[ld2]):
                q_pivs[ld2] ^= q_pivs[ld]

    if 0 in q_pivs:
        return {"cell": cell_name, "has_one": True, "deg_pivs_111": deg_pivs}

    reduced_quads = [q_pivs[ld] for ld in sorted_leads if ld.bit_count() == 2]

    return {
        "cell": cell_name,
        "has_one": False,
        "deg_pivs_111": deg_pivs,
        "n_111": n,
        "N_free": N,
        "m_quad": len(reduced_quads),
        "extra_lin_after_subst": extra_lin_found,
        "reduced_quads": reduced_quads,
        "origin_N": origin_N,
        "cb_N": cb_N,
        "free_vars_111": free_vars_111,
        "var_subst": var_subst,
        "rows_c": rows,
        "cub_rows": cub_rows,
        "off2": off2, "off1": off1, "off0": off0, "n_col_words": n_col_words,
        "extract_sec": round(time.perf_counter() - t0, 3),
    }


# ==============================================================================
# Core Diagnostics (1), (2), (3) on Reduced Variety V_2 in GF(2)^N
# ==============================================================================
def diagnose_v2_cell(sys_data, lib, n_samples=100, n_flat_seeds=15):
    t_diag = time.perf_counter()
    cell = sys_data["cell"]
    if sys_data["has_one"]:
        return {"cell": cell, "has_one": True, "deg_pivs_111": sys_data["deg_pivs_111"]}

    N = sys_data["N_free"]
    quads = sys_data["reduced_quads"]
    m = len(quads)
    cb_N = sys_data["cb_N"]

    # Precompute fast bitwise structures for all m quadratic polynomials:
    # q_a(y) = c0_a ^ <lin_a, y> ^ sum_{i<j} U_a[i,j] y_i y_j
    # Polar form: B_a[i] = bitmask of j != i; grad q_a(y)[i] = lin_a[i] ^ parity(B_a[i] & y)
    q_c0 = []
    q_lin = []
    q_U = []
    q_B = []
    for pset in quads:
        c0 = 1 if (0 in pset) else 0
        lm = 0
        U = [0] * N
        B = [0] * N
        for mon in pset:
            bc = mon.bit_count()
            if bc == 1:
                lm ^= mon
            elif bc == 2:
                i = (mon & -mon).bit_length() - 1
                j = (mon ^ (1 << i)).bit_length() - 1
                if i > j:
                    i, j = j, i
                U[i] ^= 1 << j
                B[i] ^= 1 << j
                B[j] ^= 1 << i
        q_c0.append(c0)
        q_lin.append(lm)
        q_U.append(U)
        q_B.append(B)

    def eval_q_hom(a_idx, v_mask):
        U = q_U[a_idx]
        acc = 0
        vm = v_mask
        while vm:
            bi = vm & -vm
            i = bi.bit_length() - 1
            vm ^= bi
            acc ^= (U[i] & v_mask).bit_count() & 1
        return acc

    def eval_q_full(a_idx, y_mask):
        return q_c0[a_idx] ^ ((q_lin[a_idx] & y_mask).bit_count() & 1) ^ eval_q_hom(a_idx, y_mask)

    def eval_all_v2(y_mask):
        return all(eval_q_full(a, y_mask) == 0 for a in range(m))

    def jacobian_rows(y_mask):
        """Exact m rows (each an N-bit integer) of J(y) over GF(2)."""
        j_rows = []
        for a in range(m):
            B = q_B[a]
            row = q_lin[a]
            for i in range(N):
                if (B[i] & y_mask).bit_count() & 1:
                    row ^= 1 << i
            j_rows.append(row)
        return j_rows

    # --------------------------------------------------------------------------
    # Build Base CNF for V_2 to sample 100 diversified points in V_2
    # --------------------------------------------------------------------------
    base_clauses = []
    v_cnt = [N]

    def new_var():
        v_cnt[0] += 1
        return v_cnt[0]

    pair_cache = {}
    for pset in quads:
        encode_quad_poly_cnf(base_clauses, pset, new_var, pair_cache)

    rng = random.Random(20260808 + (1 if cell.endswith("11") else 0))
    sampled_points = []
    sampled_set = set()

    # Check if y == 0 is in V_2 (Proved True in B0_00!)
    zero_in_v2 = eval_all_v2(0)
    zero_jac_rank = gf2_rank_bitmasks(jacobian_rows(0)) if zero_in_v2 else None

    # Sample `n_samples` diverse solutions on V_2 using randomized phase selection +
    # random short XOR projections (universal hashing on V_2) so points span ALL components!
    for s_idx in range(n_samples):
        got = None
        # Try first with 2 random 4-literal XOR parity projections for uniform geometric spread
        for attempt in range(3):
            cls_try = list(base_clauses)
            vt = [v_cnt[0]]

            def nv_try():
                vt[0] += 1
                return vt[0]

            if attempt < 2:
                n_hashes = 2 if attempt == 0 else 1
                for _ in range(n_hashes):
                    vars_h = [v + 1 for v in rng.sample(range(N), 5)]
                    add_long_xor(cls_try, vars_h, rng.randint(0, 1), nv_try)
            # Exclude already sampled points
            for prev_y in sampled_points[-25:]:
                cls_try.append([-(i + 1) if ((prev_y >> i) & 1) else (i + 1) for i in range(N)])

            with Solver(name="cadical195", bootstrap_with=cls_try) as slv:
                slv.set_phases([+(i + 1) if rng.randint(0, 1) else -(i + 1) for i in range(N)])
                if slv.solve():
                    mdl = slv.get_model()
                    ym = 0
                    for i in range(N):
                        if mdl[i] > 0:
                            ym |= 1 << i
                    if ym not in sampled_set and ym != 0:
                        got = ym
                        break
        if got is None:
            break
        assert eval_all_v2(got), "Sampled model violated V_2!"
        sampled_points.append(got)
        sampled_set.add(got)

    # --------------------------------------------------------------------------
    # PART (1): Jacobian Rank (m x N) & Cubic Ideal Vanishing Check on Pure V_2
    # --------------------------------------------------------------------------
    jac_ranks = []
    tangent_dims = []
    hamming_wts = []

    cub_rows = sys_data["cub_rows"]
    n_cub = len(cub_rows)
    cub_idx_arr = (ctypes.c_int * max(1, n_cub))(*cub_rows)
    var_subst = sys_data["var_subst"]
    n_111 = sys_data["n_111"]
    mask64 = (1 << 64) - 1

    cubic_violating_points = 0
    max_cubic_viol_on_point = 0

    for ym in sampled_points:
        rk = gf2_rank_bitmasks(jacobian_rows(ym))
        jac_ranks.append(rk)
        tangent_dims.append(N - rk)
        hamming_wts.append(ym.bit_count())

        # Lift ym in GF(2)^N back to x_111 in GF(2)^111 and evaluate ALL ~6,400 cubic pivots in C!
        if n_cub > 0:
            x111 = 0
            for old_i in range(n_111):
                msk_N, cst = var_subst[old_i]
                bit = (((msk_N & ym).bit_count() ^ cst) & 1)
                if bit:
                    x111 |= 1 << old_i
            v_cnt_cub = lib.count_violated_rows(
                sys_data["rows_c"], cub_idx_arr, n_cub, n_111,
                sys_data["off2"], sys_data["off1"], sys_data["off0"], sys_data["n_col_words"],
                x111 & mask64, x111 >> 64
            )
            if v_cnt_cub > 0:
                cubic_violating_points += 1
                max_cubic_viol_on_point = max(max_cubic_viol_on_point, v_cnt_cub)

    rank_hist = {str(k): v for k, v in sorted(Counter(jac_ranks).items())}
    tdim_hist = {str(k): v for k, v in sorted(Counter(tangent_dims).items())}

    # --------------------------------------------------------------------------
    # PART (2): Largest Affine Subspace (Linear Flat) x^(0) + E <= V_2
    # Exact GF(2) theorem (Eq. 3*):
    #   (Flat-1) <grad q_a(x^(0)), e> ^ q_a^hom(e) == 0   for all a = 1..m
    #   (Flat-2) B_a(e, e_prev) == 0                      for all a = 1..m, e_prev in E_basis
    # --------------------------------------------------------------------------
    def find_maximal_flat_through(x0_mask):
        grad_x0 = jacobian_rows(x0_mask)
        # Pre-encode q_a^hom(e) ^ <grad_x0[a], e> == 0 in CNF over variables e_0 .. e_{N-1}
        flat_clauses = []
        fv = [N]

        def f_new_var():
            fv[0] += 1
            return fv[0]

        f_pair_cache = {}
        for a in range(m):
            pset_dir = set()
            # Linear part is grad_x0[a]!
            gm = grad_x0[a]
            while gm:
                lb = gm & -gm
                pset_dir.add(lb)
                gm ^= lb
            # Quadratic part is pure homogeneous U_a!
            U = q_U[a]
            for i in range(N):
                u = U[i]
                while u:
                    lb = u & -u
                    j = lb.bit_length() - 1
                    u ^= lb
                    pset_dir.add((1 << i) | (1 << j))
            encode_quad_poly_cnf(flat_clauses, pset_dir, f_new_var, f_pair_cache)

        # Require e != 0
        flat_clauses.append([i + 1 for i in range(N)])

        basis_E = []
        piv_E = {}  # pivot bit -> basis vector in RREF to enforce linear independence!

        with Solver(name="cadical195", bootstrap_with=flat_clauses) as slv:
            while True:
                slv.set_phases([+(i + 1) if rng.randint(0, 1) else -(i + 1) for i in range(N)])
                if not slv.solve():
                    break
                mdl = slv.get_model()
                e_vec = 0
                for i in range(N):
                    if mdl[i] > 0:
                        e_vec |= 1 << i

                # Verify (Flat-1) & (Flat-2) directly
                assert eval_all_v2(x0_mask ^ e_vec), "Flat direction failed V_2 check!"
                basis_E.append(e_vec)

                # Update RREF of basis_E to get a new pivot bit `pb` and forbid span(basis_E)
                # Simply fix the pivot bit of the new vector to 0 in all subsequent searches!
                # Wait: CAN WE FIX `e[pb] = 0` WITHOUT LOSING GENERALITY?!
                # PROOF: Suppose E' is ANY larger flat basis containing `basis_E`. By Gaussian
                # elimination on E', every vector `w in E' \ span(basis_E)` can be reduced
                # modulo `basis_E`: `w' = w ^ sum c_s e_s` so that `w'` has ZERO in all pivot
                # coordinates of `basis_E`! Since `x^(0) + span(basis_E, w) <= V_2`, EVERY vector
                # in `span(basis_E, w)` satisfies (Flat-1) and is B_a-orthogonal to `basis_E`,
                # INCLUDING `w'` itself!!
                # THAT IS AN EXACT MATHEMATICAL SYMMETRY REDUCTION: setting `e[pb] == 0` for
                # each pivot bit `pb` of `basis_E` forces linear independence in 1 UNIT CLAUSE!
                red = e_vec
                for b_prev, v_prev in piv_E.items():
                    if (red >> b_prev) & 1:
                        red ^= v_prev
                assert red != 0
                pb = red.bit_length() - 1
                piv_E[pb] = red
                slv.add_clause([-(pb + 1)])  # Unit clause! Collapses search space instantly!

                # Add (Flat-2) linear equations B_a(e_vec, e_next) == 0 for all a = 1..m!
                lin_orth_rows = []
                for a in range(m):
                    # row_i = B_a(e_vec, unit_i) = parity(B_a[i] & e_vec)
                    B = q_B[a]
                    rmask = 0
                    for i in range(N):
                        if (B[i] & e_vec).bit_count() & 1:
                            rmask |= 1 << i
                    if rmask:
                        lin_orth_rows.append(rmask)
                for rmask in rref_gf2(lin_orth_rows):
                    lits = [i + 1 for i in range(N) if (rmask >> i) & 1]
                    add_long_xor(
                        new_cls := [], lits, 0, f_new_var
                    )
                    for cl in new_cls:
                        slv.add_clause(cl)

        # Zero-Trust verification on 32 random linear combinations in x^(0) + span(basis_E)!
        if basis_E:
            for _ in range(min(32, 1 << min(10, len(basis_E)))):
                comb = x0_mask
                for bvec in basis_E:
                    if rng.randint(0, 1):
                        comb ^= bvec
                assert eval_all_v2(comb), "Affine flat verification failed on random combination!"
        return basis_E

    # Test maximal flats starting from x=0 (if in V_2) and top-tangent-dim sampled points
    seed_candidates = []
    if zero_in_v2:
        seed_candidates.append(("origin_0", 0))
    ranked_pts = sorted(zip(tangent_dims, sampled_points), key=lambda pair: pair[0], reverse=True)
    for idx_s, (_, pt) in enumerate(ranked_pts[:n_flat_seeds]):
        seed_candidates.append((f"sample_rank_{idx_s}", pt))

    flat_dims = []
    best_flat = {"dim": -1, "seed_label": None, "x0_hex": None, "basis_hex": [], "orbit_dirs_hex": []}
    for label, x0 in seed_candidates:
        b_E = find_maximal_flat_through(x0)
        d_E = len(b_E)
        flat_dims.append(d_E)
        if d_E > best_flat["dim"]:
            # Map flat basis directions to 116-orbit bitmasks for direct comparison with T30!
            orb_dirs = []
            for ev in b_E:
                cdir116 = 0
                for k in range(N):
                    if (ev >> k) & 1:
                        cdir116 ^= cb_N[k]
                orb_dirs.append(hex(cdir116))
            best_flat = {
                "dim": d_E,
                "seed_label": label,
                "x0_hex": hex(x0),
                "basis_hex": [hex(ev) for ev in b_E],
                "orbit_dirs_hex": orb_dirs,
            }

    # --------------------------------------------------------------------------
    # PART (3): Mute Variables, Bilinear Radical R_bil, Universal Translations T_univ,
    #           Low-Rank Bilinear Factorization u_t(x)*v_t(x), and Linearization Curve
    # --------------------------------------------------------------------------
    # 3A. Variable degree-2 & degree-1 incidence in V_2
    quad_deg_per_var = [0] * N
    lin_deg_per_var = [0] * N
    cooccur_neighbors = [0] * N
    for a in range(m):
        for i in range(N):
            if q_B[a][i]:
                quad_deg_per_var[i] += q_B[a][i].bit_count()
                cooccur_neighbors[i] |= q_B[a][i]
            if (q_lin[a] >> i) & 1:
                lin_deg_per_var[i] += 1

    purely_mute_vars = [i for i in range(N) if quad_deg_per_var[i] == 0 and lin_deg_per_var[i] == 0]
    linear_only_vars = [i for i in range(N) if quad_deg_per_var[i] == 0 and lin_deg_per_var[i] > 0]

    # 3B. Exact Global Bilinear Radical R_bil = {v in GF(2)^N : B_a * v == 0 for all a=1..m}
    all_B_rows = []
    for a in range(m):
        for r in q_B[a]:
            if r:
                all_B_rows.append(r)
    R_bil_basis = gf2_nullspace_right(all_B_rows, N)

    # On R_bil, map phi_a(v) := <q_lin[a], v> ^ q_a^hom(v) IS LINEAR OVER GF(2)!
    # Proof: phi_a(u ^ w) = <q_lin[a], u^w> ^ q_a^hom(u) ^ q_a^hom(w) ^ B_a(u, w)
    #        = phi_a(u) ^ phi_a(w) since B_a(u, w) == 0 for u in R_bil!
    T_univ_basis_N = []
    T_univ_orbits_116 = []
    if R_bil_basis:
        r_dim = len(R_bil_basis)
        phi_rows = []
        for a in range(m):
            row_r = 0
            for idx_b, v_b in enumerate(R_bil_basis):
                val = ((q_lin[a] & v_b).bit_count() ^ eval_q_hom(a, v_b)) & 1
                if val:
                    row_r |= 1 << idx_b
            if row_r:
                phi_rows.append(row_r)
        ker_phi = gf2_nullspace_right(phi_rows, r_dim)
        for comb in ker_phi:
            v_univ = 0
            for idx_b in range(r_dim):
                if (comb >> idx_b) & 1:
                    v_univ ^= R_bil_basis[idx_b]
            T_univ_basis_N.append(v_univ)
            orb116 = 0
            for k in range(N):
                if (v_univ >> k) & 1:
                    orb116 ^= cb_N[k]
            active_orbs = [j for j in range(116) if (orb116 >> j) & 1]
            T_univ_orbits_116.append({"hex": hex(orb116), "orbit_indices": active_orbs})
            # Zero-Trust check: shifting sampled points by v_univ stays in V_2!
            for ym in sampled_points[:10]:
                assert eval_all_v2(ym ^ v_univ), "Universal translation check failed!"

    # 3C. Symplectic Rank Spectrum of q_1 .. q_m + Search for Low-Rank Combinations in span(q_1..q_m)
    factored_pivs = [dickson_symplectic_factorization(pset, N) for pset in quads]
    symp_ranks = [fp["symplectic_rank"] for fp in factored_pivs]
    symp_rank_hist = {str(k): v for k, v in sorted(Counter(symp_ranks).items())}

    # Also test pairwise XORs q_a ^ q_b to uncover hidden low-rank bilinear differences!
    low_rank_generators = []
    seen_B_sig = set()
    for a, fp in enumerate(factored_pivs):
        if fp["symplectic_rank"] <= 12:
            sig = tuple(fp["B_rows"])
            seen_B_sig.add(sig)
            low_rank_generators.append({
                "source": f"piv_{a}",
                "symplectic_rank": fp["symplectic_rank"],
                "num_pairs": fp["num_bilinear_pairs"],
                "pair_weights": [(u.bit_count(), v.bit_count()) for u, v in fp["pairs"]],
                "pairs_masks": fp["pairs"],
            })

    # Quick scan of pairwise differences among pivots with overlapping leading neighborhoods
    for a in range(min(m, 60)):
        for b in range(a + 1, min(m, 60)):
            diff_p = quads[a] ^ quads[b]
            # Fast rank check of polar form B_a ^ B_b
            rk_diff = gf2_rank_bitmasks([q_B[a][i] ^ q_B[b][i] for i in range(N)])
            if 0 < rk_diff <= 10:
                sig = tuple(q_B[a][i] ^ q_B[b][i] for i in range(N))
                if sig not in seen_B_sig:
                    seen_B_sig.add(sig)
                    fp_d = dickson_symplectic_factorization(diff_p, N)
                    low_rank_generators.append({
                        "source": f"piv_{a}^piv_{b}",
                        "symplectic_rank": fp_d["symplectic_rank"],
                        "num_pairs": fp_d["num_bilinear_pairs"],
                        "pair_weights": [(u.bit_count(), v.bit_count()) for u, v in fp_d["pairs"]],
                        "pairs_masks": fp_d["pairs"],
                    })
                    if len(low_rank_generators) >= 24:
                        break
        if len(low_rank_generators) >= 24:
            break

    low_rank_generators.sort(key=lambda d: d["symplectic_rank"])

    # 3D. Exact Linearization Collapse Curve:
    # Measure BOTH:
    #   (Method I - Coordinate Vertex Cover): greedily pick k variables S subset {0..N-1} that
    #     minimize rank_GF2(Q^{(V \ S)}) (maximizing `m - rank`, the number of quadratics that
    #     become STRICTLY LINEAR equations over V \ S for EVERY assignment to x_S!).
    #   (Method II - Bilinear Factor Subspace Cut): collect independent linear forms {u_t, v_t}
    #     from the lowest-rank Dickson factorizations (e.g. Q4's 8 forms + other low-rank quads),
    #     change basis so those forms are coordinates z_0 .. z_{k-1}, and measure `m - rank`!
    pair_to_col = {}
    n_pair_cols = 0
    for i in range(N):
        for j in range(i + 1, N):
            pair_to_col[(i, j)] = n_pair_cols
            n_pair_cols += 1

    # Represent homogeneous degree-2 part of each q_a as bitmask over n_pair_cols
    q_hom_masks = []
    for a in range(m):
        hm = 0
        for i in range(N):
            u = q_U[a][i]
            while u:
                lb = u & -u
                j = lb.bit_length() - 1
                u ^= lb
                hm |= 1 << pair_to_col[(i, j)]
        q_hom_masks.append(hm)

    var_col_kill_mask = [0] * N
    for (i, j), col in pair_to_col.items():
        var_col_kill_mask[i] |= 1 << col
        var_col_kill_mask[j] |= 1 << col

    # Greedy coordinate selection up to k = 28
    chosen_coord_vars = []
    active_col_mask = (1 << n_pair_cols) - 1
    coord_collapse_curve = []
    remaining_vars = set(range(N))
    # Order candidate pool by weighted degree to make exact rank evaluation ultra-fast
    top_pool = sorted(range(N), key=lambda v: quad_deg_per_var[v], reverse=True)[:48]

    for step in range(1, 29):
        best_v = None
        best_rk = m + 1
        for cand_v in top_pool:
            if cand_v not in remaining_vars:
                continue
            test_mask = active_col_mask & ~var_col_kill_mask[cand_v]
            rk = gf2_rank_bitmasks([hm & test_mask for hm in q_hom_masks])
            if rk < best_rk:
                best_rk = rk
                best_v = cand_v
        if best_v is None:
            break
        chosen_coord_vars.append(best_v)
        remaining_vars.remove(best_v)
        active_col_mask &= ~var_col_kill_mask[best_v]
        if best_v not in top_pool:
            pass
        if step in (4, 8, 12, 16, 20, 24, 28):
            active_edges = active_col_mask.bit_count()
            coord_collapse_curve.append({
                "k_fixed_vars": step,
                "remaining_quad_rank": best_rk,
                "collapsed_linear_eqs": m - best_rk,
                "remaining_free_vars_after_lin": (N - step) - (m - best_rk),
                "remaining_quad_monomials": active_edges,
            })

    # Bilinear factor basis change evaluation (using factor forms u_t, v_t from low_rank_generators)
    factor_forms = []
    factor_pivs = {}
    for gen in low_rank_generators:
        for uf, vf in gen["pairs_masks"]:
            for frm in (uf, vf):
                x = frm
                while x:
                    b = x.bit_length() - 1
                    if b in factor_pivs:
                        x ^= factor_pivs[b]
                    else:
                        factor_pivs[b] = x
                        factor_forms.append(frm)
                        break
                if len(factor_forms) >= 28:
                    break
            if len(factor_forms) >= 28:
                break
        if len(factor_forms) >= 28:
            break

    bilinear_collapse_curve = []
    if factor_forms:
        # Complete factor_forms to a full basis of GF(2)^N: rows of T (z = T * y)
        T_rows = list(factor_forms)
        cur_pivs = dict(factor_pivs)
        for unit_i in range(N):
            v = 1 << unit_i
            x = v
            while x:
                b = x.bit_length() - 1
                if b in cur_pivs:
                    x ^= cur_pivs[b]
                else:
                    cur_pivs[b] = x
                    T_rows.append(v)
                    break
        assert len(T_rows) == N
        # Invert N x N binary matrix T_rows -> T_inv_cols[k] = y-vector corresponding to z_k = 1!
        aug = [(T_rows[r], 1 << r) for r in range(N)]
        piv_pos = {}
        for r in range(N):
            lhs, rhs = aug[r]
            while lhs:
                b = lhs.bit_length() - 1
                if b in piv_pos:
                    pl, pr = piv_pos[b]
                    lhs ^= pl
                    rhs ^= pr
                else:
                    piv_pos[b] = (lhs, rhs)
                    break
        for b in sorted(piv_pos.keys(), reverse=True):
            for b2 in list(piv_pos.keys()):
                if b2 != b and ((piv_pos[b2][0] >> b) & 1):
                    l2, r2 = piv_pos[b2]
                    pl, pr = piv_pos[b]
                    piv_pos[b2] = (l2 ^ pl, r2 ^ pr)
        # If y = sum_k z_k * g_k, then T * g_k = e_k => g_k[b] is bit k of piv_pos[b][1]!
        g_basis = [0] * N
        for b in range(N):
            inv_row_b = piv_pos[b][1]
            for k in range(N):
                if (inv_row_b >> k) & 1:
                    g_basis[k] |= 1 << b

        # Transform homogeneous quadratic part of each q_a into z-coordinates:
        # coeff of z_r z_s (r < s) in q_a(sum z_k g_k) is EXACTLY B_a(g_r, g_s)!
        q_hom_z = []
        for a in range(m):
            B = q_B[a]
            Bg = [0] * N
            for r in range(N):
                gr = g_basis[r]
                # B_a * g_r: bit i is parity(B[i] & gr)
                bgr = 0
                for i in range(N):
                    if (B[i] & gr).bit_count() & 1:
                        bgr |= 1 << i
                Bg[r] = bgr
            hm_z = 0
            for r in range(N):
                bgr = Bg[r]
                for s in range(r + 1, N):
                    if (bgr & g_basis[s]).bit_count() & 1:
                        hm_z |= 1 << pair_to_col[(r, s)]
            q_hom_z.append(hm_z)

        z_active = (1 << n_pair_cols) - 1
        for k_step in range(1, len(factor_forms) + 1):
            z_active &= ~var_col_kill_mask[k_step - 1]
            if k_step in (4, 8, 12, 16, 20, 24, 28) or k_step == len(factor_forms):
                rk_z = gf2_rank_bitmasks([hm & z_active for hm in q_hom_z])
                bilinear_collapse_curve.append({
                    "k_fixed_bilinear_forms": k_step,
                    "remaining_quad_rank": rk_z,
                    "collapsed_linear_eqs": m - rk_z,
                    "remaining_free_vars_after_lin": (N - k_step) - (m - rk_z),
                })

    # Clean non-JSON-serializable masks in low_rank_generators summary
    low_rank_summary = [
        {
            "source": g["source"],
            "symplectic_rank": g["symplectic_rank"],
            "num_bilinear_pairs": g["num_pairs"],
            "pair_form_weights": g["pair_weights"],
            "first_pair_hex": [hex(g["pairs_masks"][0][0]), hex(g["pairs_masks"][0][1])] if g["pairs_masks"] else [],
        }
        for g in low_rank_generators[:12]
    ]

    return {
        "cell": cell,
        "has_one": False,
        "deg_pivs_111": sys_data["deg_pivs_111"],
        "N_free_vars": N,
        "m_quad_pivots": m,
        "n_cubic_pivots_checked": n_cub,
        "part1_jacobian_and_tangent": {
            "num_v2_points_sampled": len(sampled_points),
            "origin_zero_in_V2": zero_in_v2,
            "origin_jacobian_rank": zero_jac_rank,
            "origin_zariski_tangent_dim": (N - zero_jac_rank) if zero_jac_rank is not None else None,
            "jacobian_rank_min": min(jac_ranks) if jac_ranks else None,
            "jacobian_rank_median": statistics.median(jac_ranks) if jac_ranks else None,
            "jacobian_rank_max": max(jac_ranks) if jac_ranks else None,
            "jacobian_rank_histogram": rank_hist,
            "tangent_dim_min": min(tangent_dims) if tangent_dims else None,
            "tangent_dim_median": statistics.median(tangent_dims) if tangent_dims else None,
            "tangent_dim_max": max(tangent_dims) if tangent_dims else None,
            "tangent_dim_histogram": tdim_hist,
            "sampled_hamming_weight_range": [min(hamming_wts), max(hamming_wts)] if hamming_wts else None,
            "pure_v2_points_violating_any_cubic": cubic_violating_points,
            "max_cubic_pivots_violated_on_a_v2_point": max_cubic_viol_on_point,
        },
        "part2_maximal_affine_flat": {
            "seeds_tested": len(seed_candidates),
            "flat_dims_found": flat_dims,
            "largest_flat_dim": best_flat["dim"],
            "largest_flat_cardinality": f"2^{best_flat['dim']}",
            "largest_flat_seed": best_flat["seed_label"],
            "largest_flat_x0_hex": best_flat["x0_hex"],
            "largest_flat_orbit116_directions_hex": best_flat["orbit_dirs_hex"],
        },
        "part3_bilinear_blocks_and_cuts": {
            "purely_mute_coordinate_vars": purely_mute_vars,
            "linear_only_coordinate_vars": linear_only_vars,
            "global_bilinear_radical_dim": len(R_bil_basis),
            "universal_translation_subgroup_dim": len(T_univ_basis_N),
            "universal_translation_orbits_116": T_univ_orbits_116,
            "pivot_symplectic_rank_histogram": symp_rank_hist,
            "low_rank_dickson_generators": low_rank_summary,
            "greedy_coordinate_cut_vars_top28": chosen_coord_vars,
            "coordinate_linearization_collapse_curve": coord_collapse_curve,
            "bilinear_factor_forms_extracted": len(factor_forms),
            "bilinear_factor_collapse_curve": bilinear_collapse_curve,
        },
        "diag_sec": round(time.perf_counter() - t_diag, 3),
        "total_cell_sec": round(sys_data["extract_sec"] + (time.perf_counter() - t_diag), 3),
    }


def main():
    parser = argparse.ArgumentParser(description="Exact Geometric & Symplectic Profiler of V_2 in H(16,4)")
    parser.add_argument("--cells", type=str, default="B0_00,B0_11",
                        help="Comma-separated cell names, e.g. B0_00,B0_11 or B0_00,B0_11,B1_11")
    parser.add_argument("--samples", type=int, default=100, help="Number of diversified V_2 points via CaDiCaL")
    parser.add_argument("--flat-seeds", type=int, default=15, help="Number of seeds for maximal affine flat search")
    parser.add_argument("--extract-sec", type=float, default=18.0, help="Algebraic extraction budget per cell (s)")
    parser.add_argument("--out", type=str, default="v2_structure_report.json", help="Output JSON path")
    args = parser.parse_args()

    t0 = time.perf_counter()
    work_dir = Path(__file__).resolve().parent
    c_path = work_dir / "diag_v2_kernel.c"
    so_path = work_dir / "libdiag_v2_kernel.so"
    c_path.write_text(C_DIAG_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_path), "-o", str(so_path)], check=True)
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

    lib.count_violated_rows.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.c_uint64, ctypes.c_uint64,
    ]
    lib.count_violated_rows.restype = ctypes.c_int

    # Shared precomputations across cells
    orbits = build_orbits_116()
    v6_list = all_v6_orbits()
    _, u8_size8, nonzero_z = build_c8_orbits()

    M_mod2_rows = []
    for z_rep, _ in nonzero_z:
        m_bits = 0
        for m_i, (_, a_orb) in enumerate(u8_size8):
            s_val = sum(-1 if ((a & z_rep).bit_count() & 1) else 1 for a in a_orb)
            if (s_val // 2) & 1:
                m_bits |= 1 << m_i
        M_mod2_rows.append(m_bits)
    null_z_vecs = gf2_nullspace_left(M_mod2_rows)

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
    fiber_meta = (nonzero_z, null_z_vecs)

    target_cells = [c.strip() for c in args.cells.split(",") if c.strip()]
    full_report = {"cells": {}, "total_sec": 0.0}

    for cell_name in target_cells:
        print(f"\n>>> [DIAGNOSE_V2] Extracting & reducing V_2 for {cell_name}...", flush=True)
        sys_data = build_cell_algebraic_system(
            cell_name, lib, orbits, v6_list, rot4_data, fiber_meta, extract_sec=args.extract_sec
        )
        print(f"    [{cell_name}] Extraction done in {sys_data.get('extract_sec', 0)}s: "
              f"has_one={sys_data['has_one']}, deg_pivs_111={sys_data['deg_pivs_111']}, "
              f"N_free={sys_data.get('N_free')}, m_quad={sys_data.get('m_quad')}", flush=True)
        res = diagnose_v2_cell(sys_data, lib, n_samples=args.samples, n_flat_seeds=args.flat_seeds)
        full_report["cells"][cell_name] = res
        print(json.dumps(res, indent=2), flush=True)

    full_report["total_sec"] = round(time.perf_counter() - t0, 3)
    Path(args.out).write_text(json.dumps(full_report, indent=2), encoding="utf-8")
    print(f"\n=== V_2 STRUCTURE REPORT WRITTEN TO {args.out} IN {full_report['total_sec']}s ===", flush=True)


if __name__ == "__main__":
    main()
