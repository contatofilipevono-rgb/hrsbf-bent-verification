#!/usr/bin/env python3
"""
Task b14_cyclotomic_polynomial_ring:
Complete formulation of H(16,4) and the unipotent tower V_d = ker((rot + I)^d)
in the truncated cyclotomic / nilpotent Jordan ring F_2[T]/(T^16 + 1) = F_2[u]/(u^16),
plus fast algebraic + lightweight SAT/CnC closer for B1_00, B1_11, B0_11, B0_00.

Usage examples:
  1) Full nilpotent ring audit + all 4 symmetric cells algebraic & fast SAT pass:
     python3 SOLVE_B14_NILPOTENT_RING.py --cell ALL --budget 180

  2) Dedicated fast close of overdetermined B1_11 (223 quads in 109 vars):
     python3 SOLVE_B14_NILPOTENT_RING.py --cell B1_11 --budget 300

  3) Distributed Cube-and-Conquer for B0_00 or B0_11 on GitHub Actions / Cloud Run (e.g. 96 shards):
     python3 SOLVE_B14_NILPOTENT_RING.py --cell B0_00 --cube-depth 10 --num-shards 96 --shard-idx 0 --budget 600
"""
import argparse
import ctypes
import json
import subprocess
import sys
import time
from itertools import combinations
from pathlib import Path

from pysat.card import CardEnc, EncType
from pysat.solvers import Solver

C_SRC_B14 = r"""
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

// Level-1 quadratic extractor when wt_diag % 8 == 4:
// wt_total = wt_diag + 2*wt_pairs == 0 mod 16  <==>  wt_pairs == 2 mod 4  <==>  (wt_pairs / 2) ^ 1 == 0 mod 2!
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
            if (pop32_and(basis[i], basis[j]) & 1) {
                int c = off2 + c2_idx;
                out_row[c >> 6] ^= 1ULL << (c & 63);
            }
            c2_idx++;
        }
    }
    return 0;
}

// Also extract Level-1 quadratic when wt_diag % 8 == 0 AND o_pop % 4 == 2 (or some Ai % 4 == 2 or inter_pop odd):
// Then wt_pairs == 0 mod 4 gives a nontrivial degree <= 2 equation (wt_pairs / 2) % 2 == 0!
int extract_level1_quad_when_diag0(
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
    int nz = ((o_pop >> 1) & 1);
    for (int i = 0; i < n; i++) {
        pack_subset(all_pair_bits + (size_t)i * 510, p_idxs, n_pairs, basis[i]);
        int wp = pop32(basis[i]);
        if (wp & 1) return -2;
        int wop = pop32_and(basis[i], O_word);
        Ai[i] = wp - 2 * wop;
        if ((Ai[i] >> 1) & 1) nz = 1;
    }
    memset(out_row, 0, (size_t)n_col_words * sizeof(uint64_t));
    if ((o_pop >> 1) & 1) {
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
                nz = 1;
            }
            c2_idx++;
        }
    }
    return nz ? 0 : -10;
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
            if (pop_rs & 3) {
                out_lin_valid[pair_m++] = 0;
                continue;
            }
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

// Fast 65536-point FWHT bentness verifier (0.05 ms)
int verify_bent_fwht_c(
    const uint64_t *orb_tts, // 116 * 1024 words
    uint64_t c_lo,
    uint64_t c_hi,
    int *out_first_bad_u,
    int *out_first_bad_val
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
        if (spec[u] != 256 && spec[u] != -256) {
            *out_first_bad_u = u;
            *out_first_bad_val = spec[u];
            return 0;
        }
    }
    return 1;
}

// Fast Fast-Mobius Transform (16-variable ANF extraction on 65536 truth table)
void anf_mobius_16(uint8_t a[65536]) {
    for (int step = 1; step < 65536; step <<= 1) {
        int dbl = step << 1;
        for (int i = 0; i < 65536; i += dbl) {
            for (int j = 0; j < step; j++) {
                a[i + j + step] ^= a[i + j];
            }
        }
    }
}
"""

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


# ==============================================================================
# 1. Cyclotomic / Nilpotent Jordan Basis x(T) = sum_{k=0}^{15} z_k u^k
# ==============================================================================
def pascal_transform_16(v16: int) -> int:
    """
    Involutive Sierpinski-Pascal change of coordinates P (P^2 = I over F_2):
        out_k = sum_{k <= i <= 15, (i & k) == k} in_i  (mod 2).
    Maps standard point x <-> nilpotent Jordan coordinates z where x(T) = sum_{k=0}^{15} z_k u^k.
    """
    out = 0
    for k in range(16):
        s = 0
        for i in range(k, 16):
            if (i & k) == k and ((v16 >> i) & 1):
                s ^= 1
        if s:
            out |= 1 << k
    return out


def audit_cyclotomic_nilpotent_ring(orbits, lib):
    """
    Strictly verifies all algebraic theorems of Section 1-3 on F_2[u]/(u^16):
      (1) P^2 == I and rot(u^k) = u^k + u^{k+1} (upper triangular Jordan block)
      (2) D_8 = {z_0 = ... = z_7 = 0}, U_4 = {z_0 = ... = z_11 = 0}, V_d = {z_0 = ... = z_{15-d} = 0}
      (3) Dual coordinates: z_0 = <0xffff, x>, (z_0, z_1) -> V_2^perp, (z_0..z_3) -> 16 cosets of U_4^perp
          (with C_{0xf} == {z_0=0, z_1=0, z_2=0, z_3=1} and F_{0xff} == {z_0..z_6=0, z_7=1}!)
      (4) Exact ANF of all 116 quartic orbits in nilpotent coordinates z = (z_0, ..., z_15)
          and degree drop across the strata V_d!
    """
    z_of_x = [pascal_transform_16(x) for x in range(65536)]
    x_of_z = [pascal_transform_16(z) for z in range(65536)]

    # Check P^2 == I and rot action (rot z)_k = z_k ^ z_{k-1}
    for x in range(65536):
        z = z_of_x[x]
        assert x_of_z[z] == x
        zr = z_of_x[rot16(x, 1)]
        expected_zr = (z ^ ((z << 1) & 0xFFFF))
        assert zr == expected_zr, f"Nilpotent shift failed at x={x}"

        # Check D_8 = {z_0..z_7 == 0} and U_4 = {z_0..z_11 == 0}
        is_d8 = ((x & 0xFF) == (x >> 8))
        assert is_d8 == ((z & 0x00FF) == 0)
        is_u4 = (rot16(x, 4) == x)
        assert is_u4 == ((z & 0x0FFF) == 0)

        # Check z_0 == <0xffff, x> and C_{0xf} == {(z_0,z_1,z_2,z_3) == (0,0,0,1)} (i.e. (z & 0xF) == 8)
        assert (z & 1) == (x.bit_count() & 1)
        vnib = (x & 0xF) ^ ((x >> 4) & 0xF) ^ ((x >> 8) & 0xF) ^ ((x >> 12) & 0xF)
        assert (vnib == 0) == ((z & 0xF) == 0)
        assert (vnib == 0xF) == ((z & 0xF) == 0x8)
        assert (((x & 0xFF) ^ (x >> 8)) == 0xFF) == ((z & 0xFF) == 0x80)

    # Compute exact nilpotent ANF of all 116 orbits in F_2[z_0, ..., z_15]
    buf = (ctypes.c_uint8 * 65536)()
    min_deg_global = 99
    max_deg_global = 0
    stratum_active_orbits = {d: 0 for d in [16, 12, 8, 6, 4, 3]}
    stratum_max_deg = {d: 0 for d in [16, 12, 8, 6, 4, 3]}

    anf_term_counts = []
    for j, orb in enumerate(orbits):
        for z in range(65536):
            x = x_of_z[z]
            buf[z] = sum((x & m) == m for m in orb) & 1
        lib.anf_mobius_16(buf)
        monoms = [m for m in range(65536) if buf[m]]
        anf_term_counts.append(len(monoms))
        for m in monoms:
            deg = m.bit_count()
            if deg < min_deg_global:
                min_deg_global = deg
            if deg > max_deg_global:
                max_deg_global = deg

        # Check restrictions to V_d = {z_0 = ... = z_{15-d} = 0}, i.e., monomials supported on bits [16-d .. 15]
        for d in stratum_active_orbits:
            low_zero_mask = (1 << (16 - d)) - 1
            surv = [m for m in monoms if (m & low_zero_mask) == 0]
            if surv:
                stratum_active_orbits[d] += 1
                md = max(m.bit_count() for m in surv)
                if md > stratum_max_deg[d]:
                    stratum_max_deg[d] = md

        # Verify Eq. (13): on U_4 = V_4 (low 12 bits zero), ONLY j=115 survives and equals z_12 (mask 1<<12)!
        surv_u4 = [m for m in monoms if (m & 0x0FFF) == 0]
        if j == 115:
            assert surv_u4 == [1 << 12], f"Expected phi_115|_U4 == z_12, got {surv_u4}"
        else:
            assert surv_u4 == [], f"Expected phi_{j}|_U4 == 0, got {surv_u4}"

    assert min_deg_global == 2 and max_deg_global == 4, (min_deg_global, max_deg_global)
    assert stratum_active_orbits[3] == 0 and stratum_active_orbits[4] == 1 and stratum_active_orbits[8] == 4
    assert stratum_max_deg[8] == 2 and stratum_max_deg[4] == 1 and stratum_max_deg[3] == 0

    return {
        "nilpotent_audit_passed": True,
        "anf_z_min_deg": min_deg_global,
        "anf_z_max_deg": max_deg_global,
        "anf_z_avg_monomials_per_orbit": round(sum(anf_term_counts) / 116.0, 2),
        "stratum_V_d_active_orbits": stratum_active_orbits,
        "stratum_V_d_max_deg_in_z": stratum_max_deg,
        "proven_identities_verified": [
            "P^2 == I",
            "(rot z)_k == z_k ^ z_{k-1}",
            "D_8 == {z_0..z_7 == 0} (deg <= 2 in z_8..z_11 only!)",
            "U_4 == {z_0..z_11 == 0} (phi_115|_U4 == z_12, all other 115 orbits == 0)",
            "V_3 == {z_0..z_12 == 0} (ALL 116 orbits vanish identically!)",
            "C_0xf == {(z_0,z_1,z_2,z_3) == (0,0,0,1)}, F_0xff == {z_0..z_6 == 0, z_7 == 1}",
        ],
    }


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
# 2. SAT Encoding Helpers (Lightweight CNF, Shared Pair Gates, Symmetry Z_16^*)
# ==============================================================================
def add_xor2(clauses, a, b, rhs):
    if rhs == 0:
        clauses.append([-a, b])
        clauses.append([a, -b])
    else:
        clauses.append([-a, -b])
        clauses.append([a, b])


def add_long_xor(clauses, lits, rhs, new_var_fn):
    if not lits:
        if rhs:
            v = new_var_fn()
            clauses.append([v])
            clauses.append([-v])
        return
    cur = list(lits)
    while len(cur) > 3:
        a, b, c = cur[0], cur[1], cur[2]
        aux = new_var_fn()
        # aux == a ^ b ^ c
        for s1 in (-1, 1):
            for s2 in (-1, 1):
                for s3 in (-1, 1):
                    p = ((s1 > 0) ^ (s2 > 0) ^ (s3 > 0))
                    clauses.append([-s1 * a, -s2 * b, -s3 * c, aux if p else -aux])
                    clauses.append([s1 * a, s2 * b, s3 * c, -aux if p else aux])
        cur = [aux] + cur[3:]
    if len(cur) == 1:
        clauses.append([cur[0] if rhs else -cur[0]])
    elif len(cur) == 2:
        add_xor2(clauses, cur[0], cur[1], rhs)
    else:
        a, b, c = cur
        for s1 in (-1, 1):
            for s2 in (-1, 1):
                for s3 in (-1, 1):
                    if ((s1 > 0) ^ (s2 > 0) ^ (s3 > 0)) != rhs:
                        clauses.append([-s1 * a, -s2 * b, -s3 * c])


def get_pair_var(clauses, i, j, new_var_fn, pair_cache):
    if i > j:
        i, j = j, i
    key = (i, j)
    if key not in pair_cache:
        pv = new_var_fn()
        vi, vj = i + 1, j + 1
        clauses.append([-pv, vi])
        clauses.append([-pv, vj])
        clauses.append([pv, -vi, -vj])
        pair_cache[key] = pv
    return pair_cache[key]


def encode_deg12_pset(clauses, pset, new_var_fn, pair_cache):
    rhs = 0
    lits = []
    for m in sorted(pset):
        d = m.bit_count()
        if d == 0:
            rhs ^= 1
        elif d == 1:
            lits.append(m.bit_length())
        elif d == 2:
            i = (m & -m).bit_length() - 1
            j = (m ^ (1 << i)).bit_length() - 1
            lits.append(get_pair_var(clauses, i, j, new_var_fn, pair_cache))
    add_long_xor(clauses, lits, rhs, new_var_fn)


def add_lex_leq(clauses, xs, ys, new_var_fn):
    """Exact CNF encoding of tuple xs <=_lex ys (for Z_16^* symmetry breaking)."""
    prev_eq = None
    for idx, (x, y) in enumerate(zip(xs, ys)):
        if x == y:
            continue
        if prev_eq is None:
            clauses.append([-x, y])
        else:
            clauses.append([-prev_eq, -x, y])
        if idx + 1 < len(xs):
            nxt_eq = new_var_fn()
            if prev_eq is None:
                # nxt_eq -> (x == y)
                clauses.append([-nxt_eq, -x, y])
                clauses.append([-nxt_eq, x, -y])
                clauses.append([nxt_eq, -x, -y])
                clauses.append([nxt_eq, x, y])
            else:
                clauses.append([-nxt_eq, prev_eq])
                clauses.append([-nxt_eq, -x, y])
                clauses.append([-nxt_eq, x, -y])
                clauses.append([nxt_eq, -prev_eq, -x, -y])
                clauses.append([nxt_eq, -prev_eq, x, y])
            prev_eq = nxt_eq


def build_z16_unit_orbit_perms(orbits):
    """Build permutations of the 116 orbits induced by x_i -> x_{a*i mod 16} for a in {3,5,7,9,11,13,15}."""
    rep_to_orb = {orb[0]: j for j, orb in enumerate(orbits)}
    perms = {}
    for a in (3, 5, 7, 9, 11, 13, 15):
        p = [0] * 116
        for j, orb in enumerate(orbits):
            m = orb[0]
            ma = 0
            for i in range(16):
                if (m >> i) & 1:
                    ma |= 1 << ((a * i) & 15)
            orb_ma = min(rot16(ma, r) for r in range(16))
            p[j] = rep_to_orb[orb_ma]
        perms[a] = p
    return perms


# ==============================================================================
# 3. Algebraic Elimination of Linear Pivots & In-Cube Specialization
# ==============================================================================
def eliminate_linear_pivots_from_quads(deg12_psets, n_orig):
    """
    Given a list of degree <= 2 psets on n_orig variables, echelonize all degree-1 equations,
    eliminate their pivot variables from all quadratic equations, and return:
      (unsat_flag, free_vars, subst_func, reduced_quad_psets)
    where reduced_quad_psets live in F_2^{len(free_vars)}!
    """
    lin_pivs = {}  # lead_var -> mask_with_const_at_bit_n_orig
    const_bit = 1 << n_orig
    for pset in deg12_psets:
        if any(m.bit_count() > 1 for m in pset):
            continue
        row = 0
        for m in pset:
            row ^= const_bit if m == 0 else m
        while row & (const_bit - 1):
            v_mask = row & (const_bit - 1)
            b = v_mask.bit_length() - 1
            if b in lin_pivs:
                row ^= lin_pivs[b]
            else:
                lin_pivs[b] = row
                break
        else:
            if row == const_bit:
                return True, [], None, []

    # Back-substitute linear pivots into RREF
    for b in sorted(lin_pivs.keys()):
        for b2 in list(lin_pivs.keys()):
            if b2 != b and ((lin_pivs[b2] >> b) & 1):
                lin_pivs[b2] ^= lin_pivs[b]

    free_vars = [v for v in range(n_orig) if v not in lin_pivs]
    free_pos = {v: idx for idx, v in enumerate(free_vars)}
    n_free = len(free_vars)

    # Express every original variable v in {0..n_orig-1} as (free_mask, const_01)
    var_expr = []
    for v in range(n_orig):
        if v in free_pos:
            var_expr.append((1 << free_pos[v], 0))
        else:
            r = lin_pivs[v] ^ (1 << v)
            c0 = 1 if (r & const_bit) else 0
            fm = 0
            for fv, idx in free_pos.items():
                if (r >> fv) & 1:
                    fm |= 1 << idx
            var_expr.append((fm, c0))

    def lift_free_assignment(y_bits: int) -> int:
        x_bits = 0
        for v in range(n_orig):
            fm, c0 = var_expr[v]
            if ((y_bits & fm).bit_count() ^ c0) & 1:
                x_bits |= 1 << v
        return x_bits

    # Substitute into all degree-2 psets and echelonize over F_2^{n_free}!
    quad_pivs = {}
    for pset in deg12_psets:
        if all(m.bit_count() <= 1 for m in pset):
            continue
        out = set()

        def toggle(m):
            if m in out:
                out.remove(m)
            else:
                out.add(m)

        for m in pset:
            d = m.bit_count()
            if d == 0:
                toggle(0)
            elif d == 1:
                v = m.bit_length() - 1
                fm, c0 = var_expr[v]
                if c0:
                    toggle(0)
                tmp = fm
                while tmp:
                    lb = tmp & -tmp
                    toggle(lb)
                    tmp ^= lb
            elif d == 2:
                v1 = (m & -m).bit_length() - 1
                v2 = (m ^ (1 << v1)).bit_length() - 1
                fm1, c1 = var_expr[v1]
                fm2, c2 = var_expr[v2]
                if c1 and c2:
                    toggle(0)
                if c1:
                    t = fm2
                    while t:
                        lb = t & -t
                        toggle(lb)
                        t ^= lb
                if c2:
                    t = fm1
                    while t:
                        lb = t & -t
                        toggle(lb)
                        t ^= lb
                t1 = fm1
                while t1:
                    b1 = t1 & -t1
                    t2 = fm2
                    while t2:
                        b2 = t2 & -t2
                        toggle(b1 | b2)
                        t2 ^= b2
                    t1 ^= b1

        # Echelonize out (deg 2 -> deg 1 -> deg 0)
        while out:
            lead = max(out, key=lambda u: (u.bit_count(), u))
            if lead == 0:
                return True, free_vars, lift_free_assignment, []
            if lead in quad_pivs:
                out ^= quad_pivs[lead]
            else:
                quad_pivs[lead] = out
                break

    # If new degree-1 pivots emerged during quadratic substitution, recurse once!
    new_psets = list(quad_pivs.values())
    if any(max(m.bit_count() for m in p) == 1 for p in new_psets):
        u2, fv2, lift2, q2 = eliminate_linear_pivots_from_quads(new_psets, n_free)
        if u2:
            return True, [], None, []
        return False, [free_vars[idx] for idx in fv2], (lambda yb: lift_free_assignment(lift2(yb))), q2

    return False, free_vars, lift_free_assignment, new_psets


# ==============================================================================
# 4. Master Solver per Cell (Algebraic Nilpotent Extraction + Fast SAT / CnC)
# ==============================================================================
def run_cell_solver(
    cell_name: str,
    c99_val: int,
    c57_val: int,
    c113_val: int,
    orbits,
    v6_list,
    orb_tts,
    lib,
    cube_depth: int,
    num_shards: int,
    shard_idx: int,
    budget_sec: float,
):
    tc = time.perf_counter()
    _, origin, cb = build_pure_111_basis(c99_val, c57_val, c113_val)
    n = len(cb)  # 111

    z_of_x = [pascal_transform_16(x) for x in range(65536)]
    x_of_z = [pascal_transform_16(z) for z in range(65536)]

    pair_idx = {}
    all_pairs = []
    for v in range(256):
        for w in range(v + 1, 256):
            pair_idx[(v, w)] = len(all_pairs)
            all_pairs.append(v | (w << 8))

    orb_diag, orb_pair = [0] * 116, [0] * 116
    for j, orb in enumerate(orbits):
        vd, vp = 0, 0
        for v in range(256):
            x = v | (v << 8)
            if sum((x & m) == m for m in orb) & 1:
                vd |= 1 << v
        orb_diag[j] = vd
        for k, x in enumerate(all_pairs):
            if sum((x & m) == m for m in orb) & 1:
                vp |= 1 << k
        orb_pair[j] = vp

    O_diag, O_pair = 0, 0
    for j in range(116):
        if (origin >> j) & 1:
            O_diag ^= orb_diag[j]
            O_pair ^= orb_pair[j]
    cb_pair = []
    for cdir in cb:
        vp = 0
        for j in range(116):
            if (cdir >> j) & 1:
                vp ^= orb_pair[j]
        cb_pair.append(vp)

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

    mask64 = (1 << 64) - 1
    all_pair_bits = (ctypes.c_uint64 * ((n + 1) * 510))()
    for i in range(n):
        for w in range(510):
            all_pair_bits[i * 510 + w] = (cb_pair[i] >> (64 * w)) & mask64
    for w in range(510):
        all_pair_bits[n * 510 + w] = (O_pair >> (64 * w)) & mask64

    max_rows = 15000
    rows = (ctypes.c_uint64 * (max_rows * n_col_words))()
    piv_row_idx = (ctypes.c_int * n_cols)(*([-1] * n_cols))
    cur_row = 0
    deg_pivs = {0: 0, 1: 0, 2: 0, 3: 0}
    xl_queue = []
    deg12_rows = []

    def record_piv(pc):
        nonlocal cur_row
        if pc < 0:
            return
        d = 0 if pc == off0 else (1 if pc >= off1 else (2 if pc >= off2 else 3))
        deg_pivs[d] += 1
        if d in (1, 2):
            xl_queue.append(cur_row)
            deg12_rows.append(cur_row)
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
            row_slice = [rows[r_idx * n_col_words + w] for w in range(n_col_words)]
            pset = decode_row_to_pset(row_slice, n_cols, off2, off1, off0, pair2_list, col3_list)
            for i in range(n):
                if cur_row >= max_rows - 5 or piv_row_idx[off0] >= 0:
                    break
                insert_pset(mul_p({1 << i}, pset))

    MAX_CHARS = 9
    MAX_C_PAIRS = MAX_CHARS * (MAX_CHARS - 1) // 2
    p_idxs_arr = (ctypes.c_int * 2048)()
    char_words32 = (ctypes.c_uint64 * (MAX_CHARS * 32))()
    quad_buf = (ctypes.c_uint64 * (MAX_CHARS * n_col_words))()
    quad_valid = (ctypes.c_int * MAX_CHARS)()
    lin_buf = (ctypes.c_uint64 * (MAX_C_PAIRS * n_col_words))()
    lin_valid = (ctypes.c_int * MAX_C_PAIRS)()

    def process_coset(pts_16):
        if piv_row_idx[off0] >= 0 or cur_row >= max_rows - 100:
            return
        diag_pts = [x & 0xFF for x in pts_16 if (x & 0xFF) == (x >> 8)]
        pair_reps = [x for x in pts_16 if (x & 0xFF) < (x >> 8)]
        n_pairs = len(pair_reps)
        dmask = sum(1 << v for v in diag_pts)
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

        if wt_diag % 8 == 4:
            base_ptr = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            if lib.extract_level1_quad_when_diag4(
                all_pair_bits, p_idxs_arr, n_pairs, n, None, off2, off1, off0, n_col_words, base_ptr
            ) == 0:
                pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
                record_piv(pc)
            for m in range(n_chars):
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
        rc = lib.extract_coset_full_hierarchy_corrected(
            all_pair_bits, p_idxs_arr, n_pairs, n, diag_div8_parity,
            char_words32, n_chars, col3_base, off2, off1, off0, n_col_words,
            base_ptr, quad_buf, quad_valid, lin_buf, lin_valid
        )
        if rc != 0:
            # Don't discard! Check if Level-1 quadratic equation (wt_pairs / 2) % 2 == 0 is non-identically zero!
            if lib.extract_level1_quad_when_diag0(
                all_pair_bits, p_idxs_arr, n_pairs, n, None, off2, off1, off0, n_col_words, base_ptr
            ) == 0:
                pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
                record_piv(pc)
                drain_xl()
            return

        pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
        record_piv(pc)
        n_cp = n_chars * (n_chars - 1) // 2
        for pm in range(n_cp):
            if not lin_valid[pm] or cur_row >= max_rows - 10 or piv_row_idx[off0] >= 0:
                continue
            dst = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            src = ctypes.cast(ctypes.byref(lin_buf, pm * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            ctypes.memmove(dst, src, n_col_words * 8)
            pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
            record_piv(pc)
        for m in range(n_chars):
            if not quad_valid[m] or cur_row >= max_rows - 10 or piv_row_idx[off0] >= 0:
                continue
            dst = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            src = ctypes.cast(ctypes.byref(quad_buf, m * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            ctypes.memmove(dst, src, n_col_words * 8)
            pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
            record_piv(pc)
        drain_xl()

    # Step A: Exact Nilpotent Slice C_{0xf} == {(z_0, z_1, z_2, z_3) == (0, 0, 0, 1)}!
    # In ALL symmetric cells (c57 == c113), W_f is constant on U_4 => wt(f|_{C_0xf}) == 2048 => q_0xf == 128 (even)!
    coset_0xf_reps = []
    vis16 = bytearray(65536)
    for z in range(65536):
        if (z & 0xF) != 0x8:
            continue
        x = x_of_z[z]
        if vis16[x]:
            continue
        for r in range(16):
            vis16[rot16(x, r)] = 1
        coset_0xf_reps.append(x)
    assert len(coset_0xf_reps) == 256
    c0xf_orb_mask = 0
    for j, orb in enumerate(orbits):
        if sum((sum((x & m) == m for m in orb) & 1) for x in coset_0xf_reps) & 1:
            c0xf_orb_mask |= 1 << j
    p_0xf = {1 << i for i, cdir in enumerate(cb) if (cdir & c0xf_orb_mask).bit_count() & 1}
    if (origin & c0xf_orb_mask).bit_count() & 1:
        p_0xf.add(0)
    insert_pset(p_0xf)
    drain_xl()

    # Step B: Nilpotent Coordinate Strata {z_{a1}..z_{a4} = const} for all C(8,4) = 70 4-subsets of {0..7}!
    # Every such slice has dim 12, is rot^8-invariant (since rot^8 fixes z_0..z_7!),
    # const=0 contains D_8, and all 15 const != 0 slices are 100% DIAGONAL-FREE (2048 pairs, wt_diag == 0)!
    for comb4 in combinations(range(8), 4):
        if piv_row_idx[off0] >= 0:
            break
        bit_mask = sum(1 << a for a in comb4)
        buckets = [[] for _ in range(16)]
        for z in range(65536):
            val = 0
            for idx_b, a in enumerate(comb4):
                if (z >> a) & 1:
                    val |= 1 << idx_b
            buckets[val].append(x_of_z[z])
        for val in range(16):
            process_coset(buckets[val])
            if piv_row_idx[off0] >= 0:
                break

    # Step C: V6 x V6 + diagonal affine shifts + interleaved conjugates (reveals C5, C7, Q4, and 223 quads in B1_11!)
    alg_budget = min(30.0, budget_sec * 0.30)
    for pts8 in v6_list:
        if piv_row_idx[off0] >= 0 or cur_row >= max_rows - 150:
            break
        w_pts = [v | (w << 8) for v in pts8 for w in pts8]
        process_coset(w_pts)
    for pts8 in v6_list:
        if piv_row_idx[off0] >= 0 or cur_row >= max_rows - 150 or (time.perf_counter() - tc) > alg_budget:
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

    alg_sec = round(time.perf_counter() - tc, 3)
    if piv_row_idx[off0] >= 0:
        return {
            "cell": cell_name,
            "closed_unsat": True,
            "closed_by": "algebraic_deg_le_3_has_one",
            "deg_pivs": deg_pivs,
            "total_pivots": cur_row,
            "alg_sec": alg_sec,
            "total_sec": alg_sec,
        }

    # Eliminate all linear pivots -> clean quadratic system on n_free variables!
    raw_deg12_psets = [
        decode_row_to_pset([rows[r_idx * n_col_words + w] for w in range(n_col_words)],
                           n_cols, off2, off1, off0, pair2_list, col3_list)
        for r_idx in deg12_rows
    ]
    unsat_q, free_vars, lift_fn, red_quads = eliminate_linear_pivots_from_quads(raw_deg12_psets, n)
    if unsat_q:
        return {
            "cell": cell_name,
            "closed_unsat": True,
            "closed_by": "linear_substitution_in_quadratics",
            "deg_pivs": deg_pivs,
            "alg_sec": alg_sec,
            "total_sec": round(time.perf_counter() - tc, 3),
        }

    n_free = len(free_vars)
    print(f"[{cell_name}] Algebraic phase ({alg_sec}s): deg_pivs={deg_pivs} -> "
          f"reduced to {len(red_quads)} independent quadratics in {n_free} free vars!", flush=True)

    # Select top branching variables for Cube-and-Conquer (Vertex Cover degree in reduced quadratics)
    var_freq = [0] * n_free
    for pset in red_quads:
        for m in pset:
            if m.bit_count() == 2:
                i = (m & -m).bit_length() - 1
                j = (m ^ (1 << i)).bit_length() - 1
                var_freq[i] += 1
                var_freq[j] += 1
    branch_vars = sorted(range(n_free), key=lambda v: var_freq[v], reverse=True)[:cube_depth]

    # Build LIGHTWEIGHT CNF (NO slow 12x CardEnc totalizers! Pure quadratics + Z_16^* lex symmetry!)
    # Note: Z_16^* lex symmetry is only added when cube_depth == 0 (or on canonical orbits);
    # for full deterministic sharding across cubes, every cube is solved exact-standalone!
    base_clauses = []
    v_cnt = [n_free]

    def new_var():
        v_cnt[0] += 1
        return v_cnt[0]

    pair_cache = {}
    for pset in red_quads:
        encode_deg12_pset(base_clauses, pset, new_var, pair_cache)

    if cube_depth == 0:
        # Add exact Z_16^* symmetry breaking (valid in all 4 symmetric cells c57 == c113!)
        c_lits = {}
        for j in range(116):
            # Express orbit c_j in terms of y_0..y_{n_free-1}
            c_const = (origin >> j) & 1
            fm = 0
            for fv_idx in range(n_free):
                x_single = lift_fn(1 << fv_idx) ^ lift_fn(0)
                c_vec = 0
                for orig_i in range(n):
                    if (x_single >> orig_i) & 1:
                        c_vec ^= cb[orig_i]
                if (c_vec >> j) & 1:
                    fm |= 1 << fv_idx
            x_zero = lift_fn(0)
            c_zero = origin
            for orig_i in range(n):
                if (x_zero >> orig_i) & 1:
                    c_zero ^= cb[orig_i]
            c_const = (c_zero >> j) & 1
            idxs = [fv_idx + 1 for fv_idx in range(n_free) if (fm >> fv_idx) & 1]
            if not idxs:
                lv = new_var()
                base_clauses.append([lv if c_const else -lv])
            elif len(idxs) == 1 and c_const == 0:
                lv = idxs[0]
            elif len(idxs) == 1 and c_const == 1:
                lv = -idxs[0]
            else:
                lv = new_var()
                add_long_xor(base_clauses, idxs + [lv], c_const, new_var)
            c_lits[j] = lv

        long_js = [j for j in range(116) if j not in (57, 99, 113, 115)]
        perms = build_z16_unit_orbit_perms(orbits)
        base_seq = [c_lits[j] for j in long_js]
        for a, perm in perms.items():
            img_seq = [c_lits[perm[j]] for j in long_js]
            add_lex_leq(base_clauses, base_seq, img_seq, new_var)

        # Also add ONLY the tiny 16-bit exact antipodal fiber F_{0xff} == 8 in B0_00 (40 clauses, instant BCP!)
        if c99_val == 0 and c57_val == 0 and c113_val == 0:
            reps_ff = []
            seen_ff = set()
            for z in range(65536):
                if (z & 0xFF) != 0x80:
                    continue
                x = x_of_z[z]
                if x in seen_ff:
                    continue
                for r in range(16):
                    seen_ff.add(rot16(x, r))
                reps_ff.append(x)
            assert len(reps_ff) == 16
            ff_lits = []
            for x_pt in reps_ff:
                orb_active = [j for j in range(116) if (orb_tts[j * 1024 + (x_pt >> 6)] >> (x_pt & 63)) & 1]
                lv = new_var()
                add_long_xor(base_clauses, [c_lits[j] for j in orb_active] + [lv], 0, new_var)
                ff_lits.append(lv)
            enc_ff = CardEnc.equals(lits=ff_lits, bound=8, top_id=v_cnt[0], encoding=EncType.totalizer)
            v_cnt[0] = max(v_cnt[0], enc_ff.nv)
            base_clauses.extend(enc_ff.clauses)

    # Solve assigned cubes (1 global cube if cube_depth == 0, else shard slice of 2^cube_depth)
    total_cubes = 1 << cube_depth
    my_cubes = [cid for cid in range(total_cubes) if (cid % num_shards) == shard_idx]

    ts = time.perf_counter()
    cubes_closed = 0
    cubes_closed_in_gauss = 0
    models_checked = 0
    bent_hits = []
    bad_u, bad_val = ctypes.c_int(), ctypes.c_int()

    with Solver(name="cadical195", bootstrap_with=base_clauses) as slv:
        for cid in my_cubes:
            if (time.perf_counter() - tc) >= budget_sec:
                break

            # Optional fast In-Cube Linear Cascade check when cube_depth > 0:
            assump = []
            if cube_depth > 0:
                fix_map = {branch_vars[b]: (cid >> b) & 1 for b in range(cube_depth)}
                assump = [(v + 1) if bit else -(v + 1) for v, bit in fix_map.items()]
                # Specialize quadratics on fix_map to check immediate algebraic 1=0 or unit propagations!
                spec_psets = []
                for pset in red_quads:
                    sp = set()
                    for m in pset:
                        zeroed = False
                        rem = 0
                        tmp = m
                        while tmp:
                            lb = tmp & -tmp
                            vi = lb.bit_length() - 1
                            if vi in fix_map:
                                if fix_map[vi] == 0:
                                    zeroed = True
                                    break
                            else:
                                rem |= lb
                            tmp ^= lb
                        if not zeroed:
                            if rem in sp:
                                sp.remove(rem)
                            else:
                                sp.add(rem)
                    spec_psets.append(sp)
                u_cube, _, _, _ = eliminate_linear_pivots_from_quads(spec_psets, n_free)
                if u_cube:
                    cubes_closed += 1
                    cubes_closed_in_gauss += 1
                    continue

            cube_finished = False
            while (time.perf_counter() - tc) < budget_sec:
                if not slv.solve(assumptions=assump):
                    cube_finished = True
                    break
                models_checked += 1
                model = slv.get_model()
                y_bits = 0
                for idx in range(n_free):
                    if model[idx] > 0:
                        y_bits |= 1 << idx
                x_bits = lift_fn(y_bits)
                cint = origin
                for orig_i, cdir in enumerate(cb):
                    if (x_bits >> orig_i) & 1:
                        cint ^= cdir

                if lib.verify_bent_fwht_c(
                    orb_tts, cint & mask64, cint >> 64, ctypes.byref(bad_u), ctypes.byref(bad_val)
                ):
                    bent_hits.append({"coefficients_hex": hex(cint)})
                    break
                slv.add_clause([-(idx + 1) if model[idx] > 0 else (idx + 1) for idx in range(n_free)])

            if bent_hits:
                break
            if cube_finished:
                cubes_closed += 1

    all_my_cubes_closed = (cubes_closed == len(my_cubes)) and (len(bent_hits) == 0)
    return {
        "cell": cell_name,
        "closed_unsat": all_my_cubes_closed and (num_shards == 1),
        "shard_all_cubes_closed": all_my_cubes_closed,
        "cube_depth": cube_depth,
        "num_shards": num_shards,
        "shard_idx": shard_idx,
        "cubes_assigned": len(my_cubes),
        "cubes_closed": cubes_closed,
        "cubes_closed_in_gauss": cubes_closed_in_gauss,
        "n_free_vars": n_free,
        "independent_quadratics": len(red_quads),
        "deg_pivs_raw": deg_pivs,
        "models_checked": models_checked,
        "bent_hits": bent_hits,
        "alg_sec": alg_sec,
        "sat_sec": round(time.perf_counter() - ts, 3),
        "total_sec": round(time.perf_counter() - tc, 3),
    }


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cell", type=str, default="ALL", help="ALL, B1_00, B1_11, B0_11, or B0_00")
    parser.add_argument("--cube-depth", type=int, default=0, help="Depth d for 2^d Cube-and-Conquer")
    parser.add_argument("--num-shards", type=int, default=1, help="Total parallel workers (GitHub Actions / Cloud Run)")
    parser.add_argument("--shard-idx", type=int, default=0, help="Worker index in [0 .. num_shards-1]")
    parser.add_argument("--budget", type=float, default=240.0, help="Time budget in seconds per cell")
    args = parser.parse_args()

    t0 = time.perf_counter()
    work_dir = Path(__file__).resolve().parent
    c_path = work_dir / f"b14_nilp_{args.shard_idx}.c"
    so_path = work_dir / f"libb14_nilp_{args.shard_idx}.so"
    c_path.write_text(C_SRC_B14, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_path), "-o", str(so_path)], check=True)
    lib = ctypes.CDLL(str(so_path))

    lib.extract_level1_quad_when_diag4.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64),
    ]
    lib.extract_level1_quad_when_diag4.restype = ctypes.c_int

    lib.extract_level1_quad_when_diag0.argtypes = lib.extract_level1_quad_when_diag4.argtypes
    lib.extract_level1_quad_when_diag0.restype = ctypes.c_int

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

    lib.verify_bent_fwht_c.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_uint64, ctypes.c_uint64,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
    ]
    lib.verify_bent_fwht_c.restype = ctypes.c_int

    lib.anf_mobius_16.argtypes = [ctypes.POINTER(ctypes.c_uint8)]
    lib.anf_mobius_16.restype = None

    orbits = build_orbits_116()
    v6_list = all_v6_orbits()

    # Precompute 116 * 65536-bit truth tables
    orb_tts = (ctypes.c_uint64 * (116 * 1024))()
    for j, orb in enumerate(orbits):
        base = j * 1024
        for m in orb:
            for x in range(65536):
                if (x & m) == m:
                    orb_tts[base + (x >> 6)] ^= 1 << (x & 63)

    ring_report = audit_cyclotomic_nilpotent_ring(orbits, lib)
    if args.shard_idx == 0:
        print("=== CYCLOTOMIC NILPOTENT RING AUDIT ===", flush=True)
        print(json.dumps(ring_report, indent=2), flush=True)

    cell_map = {
        "B1_00": (1, 0, 0),
        "B1_11": (1, 1, 1),
        "B0_11": (0, 1, 1),
        "B0_00": (0, 0, 0),
    }
    targets = list(cell_map.keys()) if args.cell == "ALL" else [args.cell]
    reports = {}
    for cname in targets:
        c99_v, c57_v, c113_v = cell_map[cname]
        rep = run_cell_solver(
            cname, c99_v, c57_v, c113_v, orbits, v6_list, orb_tts, lib,
            cube_depth=args.cube_depth, num_shards=args.num_shards,
            shard_idx=args.shard_idx, budget_sec=args.budget,
        )
        reports[cname] = rep
        print(f"=== REPORT {cname} ===", flush=True)
        print(json.dumps(rep, indent=2), flush=True)

    final_out = {
        "nilpotent_ring_audit": ring_report,
        "cells": reports,
        "elapsed_total_sec": round(time.perf_counter() - t0, 3),
    }
    out_file = work_dir / f"b14_report_shard_{args.shard_idx}.json"
    out_file.write_text(json.dumps(final_out, indent=2), encoding="utf-8")


if __name__ == "__main__":
    main()
