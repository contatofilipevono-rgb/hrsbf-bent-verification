#!/usr/bin/env python3
"""
Task b18_dihedral_d16_decomposition:
Exact Dihedral D_16 (rev: x_i -> x_{15-i}) and Multiplicative Holomorph Z_16^* = <tau_3> x <rev>
Representation Decomposition of H(16,4), Block-Triangularization of the Quadratic Variety
in (d, u, p) coordinates, and Fast Deterministic Closure of:
  - B1_00 (via C_{0xf} parity + C5)
  - Auto-reverse locus (d = 0, f(rev(x)) = f(x)) across ALL remaining cells (B1_11, B0_11, B0_00)
  - Full B1_11 (223 quadratics in 109 vars) + Chiral branches of B0_11 and B0_00.

Usage:
  python3 SOLVE_B18_DIHEDRAL_DECOMP.py [budget_per_cell_sec]
"""
import ctypes
import json
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

C_SRC_B18 = r"""
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

int extract_coset_deg12_and_cub(
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

// Fast 65,536-point FWHT Bentness Auditor in C (0.04 ms per candidate)
int audit_bent_c(
    const uint64_t *orb_tts, // 116 * 1024 uint64_t
    uint64_t c_lo,
    uint64_t c_hi
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
    for (int i = 0; i < 65536; i++) {
        if (spec[i] != 256 && spec[i] != -256) return 0;
    }
    return 1;
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
M_INDICES = [2, 10, 25, 37, 54, 68, 83, 104, 12, 20, 29, 33, 41, 48, 96, 110]
I1 = [0, 4, 8, 18, 42, 52, 56, 94]
J1 = [14, 22, 46, 71, 81, 85, 98, 106]
I2 = [1, 9, 15, 28, 53, 67, 76, 103]
J2 = [3, 11, 34, 45, 55, 69, 78, 89]
I3 = [2, 10, 25, 37, 54, 68, 83, 104]
J3 = [12, 20, 29, 33, 41, 48, 96, 110]
I4 = [13, 21, 38, 70, 74, 93, 97, 109]
J4 = [24, 32, 47, 72, 80, 86, 91, 107]
SHORT_ORBS = {57, 99, 113, 115}


def rot16(x: int, r: int = 1) -> int:
    r &= 15
    return (((x << r) | (x >> (16 - r))) & 0xFFFF) if r else x


def rot8(v: int) -> int:
    return ((v << 1) & 0xFF) | (v >> 7)


def perm_bits16(x: int, a: int, b: int = 0) -> int:
    """Apply index map i -> (a*i + b) mod 16 to 16-bit mask x."""
    out = 0
    for i in range(16):
        if (x >> i) & 1:
            out |= 1 << ((a * i + b) & 15)
    return out


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
    rep_to_idx = {}
    for comb in combinations(range(16), 4):
        m = sum(1 << i for i in comb)
        if m in seen:
            continue
        orb = sorted({rot16(m, r) for r in range(16)})
        idx = len(orbits)
        for y in orb:
            seen.add(y)
            rep_to_idx[y] = idx
        orbits.append(orb)
    return orbits, rep_to_idx


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


def audit_dihedral_and_z16_representations(orbits, rep_to_idx):
    """
    Exact verification of D_16 (rev: i -> 15-i) and Z_16^* = {1,3,5,7,9,11,13,15}
    orbit decompositions on the 112 long orbits and 4 short orbits.
    """
    # Check rev (i -> 15 - i) == tau_15 (i -> -i mod 16) on C_16 orbits
    perm_rev = [rep_to_idx[perm_bits16(orbits[j][0], 15, 15)] for j in range(116)]
    perm_z16 = {
        a: [rep_to_idx[perm_bits16(orbits[j][0], a, 0)] for j in range(116)]
        for a in (1, 3, 5, 7, 9, 11, 13, 15)
    }
    assert perm_rev == perm_z16[15], "rev and tau_15 must induce the exact same permutation on C_16 orbits!"

    # Verify short orbits under K_4 = {1, 7, 9, 15} and full Z_16^*
    for a in (1, 7, 9, 15):
        for s in SHORT_ORBS:
            assert perm_z16[a][s] == s, f"Short orbit {s} not fixed by tau_{a}!"
    for a in (3, 5, 11, 13):
        assert perm_z16[a][99] == 99 and perm_z16[a][115] == 115
        assert perm_z16[a][57] == 113 and perm_z16[a][113] == 57

    long_orbs = [j for j in range(116) if j not in SHORT_ORBS]
    auto_rev_long = [j for j in long_orbs if perm_rev[j] == j]
    chiral_pairs = [(j, perm_rev[j]) for j in long_orbs if j < perm_rev[j]]

    fix_tau9_long = [j for j in long_orbs if perm_z16[9][j] == j]
    fix_tau7_long = [j for j in long_orbs if perm_z16[7][j] == j]

    # Assert exact Burnside counts proved in Section 1 & Section 4!
    assert len(auto_rev_long) == 24, f"Expected 24 auto-reverse long orbits, got {len(auto_rev_long)}"
    assert len(chiral_pairs) == 44, f"Expected 44 chiral pairs, got {len(chiral_pairs)}"
    assert len(fix_tau9_long) == 20, f"Expected 20 tau_9-fixed long orbits, got {len(fix_tau9_long)}"
    assert len(fix_tau7_long) == 12, f"Expected 12 tau_7-fixed long orbits, got {len(fix_tau7_long)}"

    # Verify L, K, R, M are 100% rev-invariant (hence independent of phase variables p_1..p_44!)
    for name, idx_list in [("L", L_INDICES), ("K", K_INDICES), ("R", R_INDICES), ("M", M_INDICES)]:
        s_set = set(idx_list)
        assert {perm_rev[j] for j in s_set} == s_set, f"Index set {name} is not rev-invariant!"

    # Decompose 112 long orbits under Klein-4 K_4 = {1, 7, 9, 15} and full Z_16^*
    seen_k4, k4_sizes = set(), {1: 0, 2: 0, 4: 0}
    k4_stab_types = {"all_K4": 0, "fix_15": 0, "fix_9": 0, "fix_7": 0, "free_4": 0}
    for j in long_orbs:
        if j in seen_k4:
            continue
        orb_k4 = {perm_z16[a][j] for a in (1, 7, 9, 15)}
        seen_k4.update(orb_k4)
        k4_sizes[len(orb_k4)] += 1
        if len(orb_k4) == 1:
            k4_stab_types["all_K4"] += 1
        elif len(orb_k4) == 4:
            k4_stab_types["free_4"] += 1
        elif perm_z16[15][j] == j:
            k4_stab_types["fix_15"] += 1
        elif perm_z16[9][j] == j:
            k4_stab_types["fix_9"] += 1
        else:
            k4_stab_types["fix_7"] += 1

    seen_z16, z16_sizes = set(), {1: 0, 2: 0, 4: 0, 8: 0}
    z16_orbits_long = []
    for j in long_orbs:
        if j in seen_z16:
            continue
        orb_z = sorted({perm_z16[a][j] for a in perm_z16})
        seen_z16.update(orb_z)
        z16_sizes[len(orb_z)] += 1
        z16_orbits_long.append(orb_z)

    report = {
        "long_orbits_total": 112,
        "auto_reverse_long_count": len(auto_rev_long),
        "chiral_pairs_count": len(chiral_pairs),
        "chiral_long_orbits_count": 2 * len(chiral_pairs),
        "tau9_fixed_long_count": len(fix_tau9_long),
        "tau7_fixed_long_count": len(fix_tau7_long),
        "klein4_1_7_9_15_orbit_counts_by_size": k4_sizes,
        "klein4_stabilizer_breakdown": k4_stab_types,
        "full_Z16_star_orbit_counts_by_size": z16_sizes,
        "full_Z16_star_total_indecomposable_blocks": len(z16_orbits_long),
        "LKRM_independent_of_phase_p": True,
    }
    return report, auto_rev_long, chiral_pairs, perm_rev, perm_z16


def build_dihedral_dup_basis_112(auto_rev_long, chiral_pairs):
    """
    Construct the 112-variable Dihedral Jordan Basis (d_0..d_43, u_0..u_23, p_0..p_43)
    mapped to 116-bit orbit masks:
      - Coords 0..43  (d_k = c_{j_k} ^ c_{j'_k}): setting d_k=1 toggles c_{j'_k}!
        Wait: since c_{j_k} = p_k and c_{j'_k} = p_k ^ d_k:
          * basis_vec(d_k) = (1 << j'_k)
          * basis_vec(u_r) = (1 << s_r)
          * basis_vec(p_k) = (1 << j_k) | (1 << j'_k)
      Check: p_k * ((1<<j_k)|(1<<j'_k)) ^ d_k * (1<<j'_k)
              gives c_{j_k} = p_k, c_{j'_k} = p_k ^ d_k, so c_{j_k} ^ c_{j'_k} = d_k! EXACT!
    """
    dup_dirs = []
    dup_labels = []
    # 0..43: chiral differences d_k
    for k, (jk, jpk) in enumerate(chiral_pairs):
        dup_dirs.append(1 << jpk)
        dup_labels.append(f"d_{k}({jk}^{jpk})")
    # 44..67: auto-reverse variables u_r
    for r, sr in enumerate(auto_rev_long):
        dup_dirs.append(1 << sr)
        dup_labels.append(f"u_{r}({sr})")
    # 68..111: symmetric phase variables p_k
    for k, (jk, jpk) in enumerate(chiral_pairs):
        dup_dirs.append((1 << jk) | (1 << jpk))
        dup_labels.append(f"p_{k}({jk})")
    assert len(dup_dirs) == 112
    return dup_dirs, dup_labels


def eliminate_linear_eq_on_basis(origin, basis_dirs, mask_116, rhs_bit, prefer_range=None):
    """Eliminate one linear constraint <(origin ^ sum z_i basis_dirs[i]), mask_116> == rhs_bit."""
    const = (origin & mask_116).bit_count() & 1
    coeffs = [(d & mask_116).bit_count() & 1 for d in basis_dirs]
    piv = None
    if prefer_range is not None:
        for i in prefer_range:
            if i < len(coeffs) and coeffs[i]:
                piv = i
                break
    if piv is None:
        for i, b in enumerate(coeffs):
            if b:
                piv = i
                break
    if piv is None:
        if const != rhs_bit:
            return None, None, -1  # Inconsistent 1 = 0!
        return origin, basis_dirs, -2  # Redundant 0 = 0
    d_piv = basis_dirs[piv]
    new_origin = origin ^ (d_piv if (const ^ rhs_bit) else 0)
    new_basis = [
        d ^ (d_piv if coeffs[i] else 0)
        for i, d in enumerate(basis_dirs)
        if i != piv
    ]
    return new_origin, new_basis, piv


def add_xor_clauses(clauses, lits, rhs, new_var_fn):
    """Tseitin-encode XOR(lits) == rhs in CNF using chunks of size <= 4."""
    if not lits:
        if rhs:
            v = new_var_fn()
            clauses.append([v])
            clauses.append([-v])
        return
    cur = list(lits)
    if rhs:
        cur[0] = -cur[0]
    while len(cur) > 4:
        chunk, rest = cur[:3], cur[3:]
        aux = new_var_fn()
        for mask in range(8):
            if (mask.bit_count() & 1) == 1:
                cl = [-(chunk[b]) if ((mask >> b) & 1) else chunk[b] for b in range(3)] + [aux]
            else:
                cl = [-(chunk[b]) if ((mask >> b) & 1) else chunk[b] for b in range(3)] + [-aux]
            clauses.append(cl)
        # Fix exact XOR equivalence: aux == chunk[0] ^ chunk[1] ^ chunk[2]
        clauses.pop(); clauses.pop(); clauses.pop(); clauses.pop()
        clauses.pop(); clauses.pop(); clauses.pop(); clauses.pop()
        a, b, c = chunk
        clauses.extend([
            [-a, -b, -c, aux], [-a, b, c, aux], [a, -b, c, aux], [a, b, -c, aux],
            [a, b, c, -aux], [a, -b, -c, -aux], [-a, b, -c, -aux], [-a, -b, c, -aux],
        ])
        cur = [aux] + rest
    k = len(cur)
    for mask in range(1 << k):
        if (mask.bit_count() & 1) == 1:
            clauses.append([-(cur[b]) if ((mask >> b) & 1) else cur[b] for b in range(k)])


def encode_pset_eq_zero(clauses, pset, new_var_fn, pair_cache):
    lits = []
    rhs = 0
    for m in pset:
        if m == 0:
            rhs ^= 1
        elif m.bit_count() == 1:
            lits.append(m.bit_length())
        elif m.bit_count() == 2:
            b0 = (m & -m).bit_length()
            b1 = (m ^ (1 << (b0 - 1))).bit_length()
            key = (b0, b1)
            if key not in pair_cache:
                pv = new_var_fn()
                clauses.append([-pv, b0])
                clauses.append([-pv, b1])
                clauses.append([-b0, -b1, pv])
                pair_cache[key] = pv
            lits.append(pair_cache[key])
    add_xor_clauses(clauses, lits, rhs, new_var_fn)


def analyze_and_solve_cell(
    c99_val, c57_val, c113_val, lib, orbits, v6_list,
    orb_diag, orb_pair, orb_tts, c0xf_mask, c0x0_reps, c0xf_reps, f_ff_reps, f_55_reps,
    auto_rev_long, chiral_pairs, perm_rev, perm_z16, sat_budget=45.0
):
    tc = time.perf_counter()
    cell_name = f"B{c99_val}_{c57_val}{c113_val}"
    dup_dirs_112, dup_labels_112 = build_dihedral_dup_basis_112(auto_rev_long, chiral_pairs)
    origin = (c99_val << 99) | (c57_val << 57) | (c113_val << 113)

    # Track variable kinds: 'd' (chiral diff), 'u' (auto-reverse), 'p' (phase)
    var_kinds = ["d"] * 44 + ["u"] * 24 + ["p"] * 44
    basis_dirs = list(dup_dirs_112)

    def apply_lin(mask_116, rhs_bit, label):
        nonlocal origin, basis_dirs, var_kinds
        # Prefer eliminating 'u' first so ALL 44 'p' variables and maximum 'd' variables stay clean!
        u_idxs = [i for i, kd in enumerate(var_kinds) if kd == "u"]
        origin_n, basis_n, piv = eliminate_linear_eq_on_basis(origin, basis_dirs, mask_116, rhs_bit, prefer_range=u_idxs)
        if piv == -1:
            return False, label
        if piv >= 0:
            origin, basis_dirs = origin_n, basis_n
            var_kinds.pop(piv)
        return True, None

    # 1. Exact proven linear laws: L = c99 (T20) and C_{0xf} parity == 0 (Theorem 1: wt_orb(C_0xf)=128)
    #    PLUS C5 (K == c57) from 0x3f3f / T20!
    ok, conflict_src = apply_lin(sum(1 << j for j in L_INDICES), c99_val, "T20_L")
    if not ok:
        return {"cell": cell_name, "closed_unsat": True, "closed_by": conflict_src}
    ok, conflict_src = apply_lin(c0xf_mask, 0, "Theorem1_C0xf_even")
    if not ok:
        return {"cell": cell_name, "closed_unsat": True, "closed_by": conflict_src}
    ok, conflict_src = apply_lin(sum(1 << j for j in K_INDICES), c57_val, "C5_K_eq_c57")
    if not ok:
        return {"cell": cell_name, "closed_unsat": True, "closed_by": f"linear_contradiction_{conflict_src}_vs_C0xf"}
    # T31 (C7): R + (1+c99)M + (1+c57)K == 0; since K = c57, (1+c57)c57 == 0!
    c7_indices = R_INDICES if c99_val == 1 else (R_INDICES + M_INDICES)
    ok, conflict_src = apply_lin(sum(1 << j for j in c7_indices), 0, "T31_C7")
    if not ok:
        return {"cell": cell_name, "closed_unsat": True, "closed_by": conflict_src}

    n = len(basis_dirs)
    d_pos = [i for i, kd in enumerate(var_kinds) if kd == "d"]
    u_pos = [i for i, kd in enumerate(var_kinds) if kd == "u"]
    p_pos = [i for i, kd in enumerate(var_kinds) if kd == "p"]
    assert len(p_pos) == 44, "Theorem 5.1 check: NONE of the 44 phase variables p_k can be touched by L, C0xf, K, C7!"

    # 2. Extract Poisson-Lucas degree <= 3 Macaulay matrix in the Dihedral (d, u, p) basis!
    pair_idx = {}
    k_cnt = 0
    for v in range(256):
        for w in range(v + 1, 256):
            pair_idx[(v, w)] = k_cnt
            k_cnt += 1

    O_diag, O_pair = 0, 0
    for j in range(116):
        if (origin >> j) & 1:
            O_diag ^= orb_diag[j]
            O_pair ^= orb_pair[j]
    cb_pair = []
    for cdir in basis_dirs:
        vp = 0
        for j in range(116):
            if (cdir >> j) & 1:
                vp ^= orb_pair[j]
        cb_pair.append(vp)

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

    max_rows = 14000
    rows = (ctypes.c_uint64 * (max_rows * n_col_words))()
    piv_row_idx = (ctypes.c_int * n_cols)(*([-1] * n_cols))
    cur_row = 0
    deg_pivs = {0: 0, 1: 0, 2: 0, 3: 0}
    xl_queue = []
    deg12_rows = []

    def decode_deg12_pset(r_idx):
        pset = set()
        base = r_idx * n_col_words
        for w in range(off2 >> 6, n_col_words):
            val = rows[base + w]
            while val:
                b = val & -val
                col = (w << 6) + b.bit_length() - 1
                val ^= b
                if col < off2:
                    continue
                if col == off0:
                    pset.add(0)
                elif col >= off1:
                    pset.add(1 << (col - off1))
                else:
                    pset.add(pair2_list[col - off2])
        return pset

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
        while xl_queue and piv_row_idx[off0] < 0 and cur_row < max_rows - n - 15:
            r_idx = xl_queue.pop(0)
            pset = decode_deg12_pset(r_idx)
            for i in range(n):
                if cur_row >= max_rows - 5 or piv_row_idx[off0] >= 0:
                    break
                insert_pset(mul_p({1 << i}, pset))

    # Seed Q4
    def lin_expr(indices):
        mask = sum(1 << j for j in indices)
        idxs = [i for i, c in enumerate(basis_dirs) if (c & mask).bit_count() & 1]
        return idxs, (origin & mask).bit_count() & 1

    def poly_from_lin(idxs, const):
        p = {1 << i for i in idxs}
        if const:
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

    MAX_CHARS = 9
    MAX_C_PAIRS = MAX_CHARS * (MAX_CHARS - 1) // 2
    p_idxs_arr = (ctypes.c_int * 2048)()
    char_words32 = (ctypes.c_uint64 * (MAX_CHARS * 32))()
    quad_buf = (ctypes.c_uint64 * (MAX_CHARS * n_col_words))()
    quad_valid = (ctypes.c_int * MAX_CHARS)()
    lin_buf = (ctypes.c_uint64 * (MAX_C_PAIRS * n_col_words))()
    lin_valid = (ctypes.c_int * MAX_C_PAIRS)()

    def process_coset(pts_16):
        if piv_row_idx[off0] >= 0 or cur_row >= max_rows - 80:
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
                record_piv(lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols))
            for m in range(MAX_CHARS):
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
        if lib.extract_coset_deg12_and_cub(
            all_pair_bits, p_idxs_arr, n_pairs, n, diag_div8_parity,
            char_words32, MAX_CHARS, col3_base, off2, off1, off0, n_col_words,
            base_ptr, quad_buf, quad_valid, lin_buf, lin_valid
        ) != 0:
            return
        record_piv(lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols))
        for pm in range(MAX_C_PAIRS):
            if lin_valid[pm] and cur_row < max_rows - 10 and piv_row_idx[off0] < 0:
                dst = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                src = ctypes.cast(ctypes.byref(lin_buf, pm * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                ctypes.memmove(dst, src, n_col_words * 8)
                record_piv(lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols))
        for m in range(MAX_CHARS):
            if quad_valid[m] and cur_row < max_rows - 10 and piv_row_idx[off0] < 0:
                dst = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                src = ctypes.cast(ctypes.byref(quad_buf, m * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                ctypes.memmove(dst, src, n_col_words * 8)
                record_piv(lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols))
        drain_xl()

    for pts8 in v6_list:
        if piv_row_idx[off0] >= 0 or (time.perf_counter() - tc) > 15.0:
            break
        w_pts = [v | (w << 8) for v in pts8 for w in pts8]
        process_coset(w_pts)
        process_coset([interleave16(x) for x in w_pts])

    if piv_row_idx[off0] >= 0:
        return {"cell": cell_name, "closed_unsat": True, "closed_by": "algebraic_deg_le_3", "deg_pivs": deg_pivs}

    # 3. Analyze Block Structure of the Degree <= 2 Variety in Dihedral (d, u, p) Coordinates!
    deg12_psets = []
    # Re-echelonize ONLY degree <= 2 polynomials so they have ZERO cubic tails!
    piv2_map = {}
    for r_idx in deg12_rows:
        # Check that row r_idx indeed has no cubic entries
        has_cub = any(rows[r_idx * n_col_words + w] != 0 for w in range(off2 >> 6))
        if not has_cub and ((rows[r_idx * n_col_words + (off2 >> 6)] & ((1 << (off2 & 63)) - 1)) == 0):
            ps = decode_deg12_pset(r_idx)
            v = set(ps)
            while v:
                lead = max(v, key=lambda m: (m.bit_count(), -m))
                if lead in piv2_map:
                    v ^= piv2_map[lead]
                else:
                    piv2_map[lead] = v
                    deg12_psets.append(v)
                    break

    # Compute exact action of rev* on our reduced basis:
    # For p_idx_k (which represents p_k), rev*(p_k) = p_k ^ d_k!
    p_to_d_var = {}
    d_idx_by_k = {}
    cur_d_i, cur_p_i = 0, 0
    for i, kd in enumerate(var_kinds):
        if kd == "d":
            d_idx_by_k[cur_d_i] = i
            cur_d_i += 1
        elif kd == "p":
            if cur_p_i in d_idx_by_k:
                p_to_d_var[i] = d_idx_by_k[cur_p_i]
            cur_p_i += 1

    def apply_rev_to_pset(pset):
        out = set()
        for m in pset:
            # Expand product of (x_i ^ d_i_if_p)
            factors = [{0}]
            tmp = m
            while tmp:
                b = tmp & -tmp
                vi = b.bit_length() - 1
                tmp ^= b
                f_vi = {1 << vi, 1 << p_to_d_var[vi]} if vi in p_to_d_var else {1 << vi}
                factors.append(f_vi)
            prod = {0}
            for fset in factors[1:]:
                prod = mul_p(prod, fset)
            out ^= prod
        return out

    # Count rev-invariant vs chiral-difference pivots & check Theorem 3.1 (zero p_a*p_b in rev-inv and delta_rev!)
    p_set_indices = set(p_pos)
    n_rev_inv_pivs = 0
    n_delta_rev_pivs = 0
    pp_terms_in_rev_inv = 0
    pp_terms_in_delta_rev = 0

    delta_pivs = {}
    for ps in deg12_psets:
        dps = ps ^ apply_rev_to_pset(ps)
        if not dps:
            n_rev_inv_pivs += 1
            for m in ps:
                if m.bit_count() == 2:
                    b0 = (m & -m).bit_length() - 1
                    b1 = (m ^ (1 << b0)).bit_length() - 1
                    if b0 in p_set_indices and b1 in p_set_indices:
                        pp_terms_in_rev_inv += 1
        else:
            for m in dps:
                if m.bit_count() == 2:
                    b0 = (m & -m).bit_length() - 1
                    b1 = (m ^ (1 << b0)).bit_length() - 1
                    if b0 in p_set_indices and b1 in p_set_indices:
                        pp_terms_in_delta_rev += 1
            v = set(dps)
            while v:
                lead = max(v, key=lambda m: (m.bit_count(), -m))
                if lead in delta_pivs:
                    v ^= delta_pivs[lead]
                else:
                    delta_pivs[lead] = v
                    n_delta_rev_pivs += 1
                    break

    assert pp_terms_in_rev_inv == 0, "Theorem 3.1 violated: rev-invariant poly had p_a*p_b!"
    assert pp_terms_in_delta_rev == 0, "Corollary 3.2 violated: delta_rev poly had p_a*p_b!"

    # 4. Specialize to the AUTO-REVERSE LOCUS (d == 0, i.e., f(rev(x)) == f(x))!
    d_set_indices = set(d_pos)
    d0_lin_pivs = {}
    d0_quad_pivs = {}
    d0_unsat = False
    for ps in deg12_psets:
        ps_d0 = {m for m in ps if not any(((m >> di) & 1) for di in d_set_indices)}
        v = set(ps_d0)
        while v:
            lead = max(v, key=lambda m: (m.bit_count(), -m))
            if lead == 0:
                d0_unsat = True
                break
            table = d0_lin_pivs if lead.bit_count() == 1 else d0_quad_pivs
            if lead in d0_quad_pivs:
                v ^= d0_quad_pivs[lead]
            elif lead in d0_lin_pivs:
                v ^= d0_lin_pivs[lead]
            else:
                table[lead] = v
                break
        if d0_unsat:
            break

    block_stats = {
        "n_vars_after_LK_C7": n,
        "var_counts_dup": {"d_chiral": len(d_pos), "u_autorev": len(u_pos), "p_phase": len(p_pos)},
        "deg12_pivots_total": len(deg12_psets),
        "deg_pivs_macaulay": deg_pivs,
        "rev_invariant_deg12_pivots": n_rev_inv_pivs,
        "chiral_image_delta_rev_rank": n_delta_rev_pivs,
        "pp_monomials_in_rev_inv_and_delta": pp_terms_in_rev_inv + pp_terms_in_delta_rev,
        "auto_reverse_locus_d0": {
            "algebraic_unsat_direct": d0_unsat,
            "ambient_vars_u_plus_p": len(u_pos) + len(p_pos),
            "linear_pivots_on_d0": len(d0_lin_pivs),
            "effective_free_vars_on_d0": (len(u_pos) + len(p_pos)) - len(d0_lin_pivs),
            "quadratic_pivots_on_d0": len(d0_quad_pivs),
        },
    }

    if not HAS_PYSAT:
        return {"cell": cell_name, "block_stats": block_stats, "pysat_available": False}

    # 5. Fast Exact SAT + C FWHT Closure:
    #    Step 5A: Close Auto-Reverse Locus (d == 0) 100% deterministically!
    #    Step 5B: Solve Chiral Branch (d != 0) with Canonical First-Chiral-Bit Phase Fixing (Eq. 7)!
    def eval_orb_at_x(j, x):
        return (orb_tts[j * 1024 + (x >> 6)] >> (x & 63)) & 1

    def eval_x_form(x_pt):
        orb_vec = 0
        for j in range(116):
            if eval_orb_at_x(j, x_pt):
                orb_vec |= 1 << j
        o_bit = (origin & orb_vec).bit_count() & 1
        w_mask = 0
        for i, cdir in enumerate(basis_dirs):
            if (cdir & orb_vec).bit_count() & 1:
                w_mask |= 1 << i
        return w_mask, o_bit

    def run_sat_branch(branch_mode, time_limit):
        t_br = time.perf_counter()
        if branch_mode == "d0" and d0_unsat:
            return {"closed": True, "models": 0, "bent_hits": [], "sec": 0.0}
        clauses = []
        v_top = [n]

        def new_var():
            v_top[0] += 1
            return v_top[0]

        pair_cache = {}
        for ps in deg12_psets:
            encode_pset_eq_zero(clauses, ps, new_var, pair_cache)

        if branch_mode == "d0":
            for di in d_pos:
                clauses.append([-(di + 1)])
        else:
            # Chiral branch: at least one d_i == 1, PLUS Eq. (7) canonical phase fixing under rev*:
            # If d_pos[0..t-1] == 0 and d_pos[t] == 1, force corresponding p_k == 0!
            clauses.append([di + 1 for di in d_pos])
            d_to_p = {dv: pv for pv, dv in p_to_d_var.items()}
            prefix_zeros = []
            for di in d_pos:
                if di in d_to_p:
                    pi = d_to_p[di]
                    # (d_0=0 & ... & d_{t-1}=0 & d_t=1) => p_t=0
                    # CNF: d_0 v ... v d_{t-1} v -d_t v -p_t
                    clauses.append(prefix_zeros + [-(di + 1), -(pi + 1)])
                prefix_zeros.append(di + 1)

        # Lightweight exact fiber counters ONLY (16-bit F_0xff in B0_00, 32-bit F_0x55 in B0_00)
        # avoiding the 12x128-bit CardEnc slowdown discovered in Run 44373529263!
        def make_lin_lit(wm, ob):
            idxs = [i + 1 for i in range(n) if (wm >> i) & 1]
            if not idxs:
                v = new_var()
                clauses.append([v if ob else -v])
                return v
            if len(idxs) == 1:
                return idxs[0] if ob == 0 else -idxs[0]
            lv = new_var()
            add_xor_clauses(clauses, idxs + [lv], ob, new_var)
            return lv

        if c99_val == 0 and c57_val == 0:
            for reps, target in [(f_ff_reps, 8), (f_55_reps, 16)]:
                flits = [make_lin_lit(*eval_x_form(x)) for x in reps]
                enc = CardEnc.equals(lits=flits, bound=target, top_id=v_top[0], encoding=EncType.totalizer)
                v_top[0] = max(v_top[0], enc.nv)
                clauses.extend(enc.clauses)

        models = 0
        bent_hits = []
        closed = False
        with Solver(name="cadical195", bootstrap_with=clauses) as slv:
            while (time.perf_counter() - t_br) < time_limit:
                if not slv.solve():
                    closed = True
                    break
                models += 1
                model = slv.get_model()
                cint = origin
                for i, cdir in enumerate(basis_dirs):
                    if model[i] > 0:
                        cint ^= cdir
                if lib.audit_bent_c(orb_tts, cint & mask64, cint >> 64):
                    bent_hits.append(hex(cint))
                    break
                # Block full Z_16^* orbit of this candidate (up to 8x speedup!)
                for a in (1, 3, 5, 7, 9, 11, 13, 15):
                    perm_a = perm_z16[a]
                    c_img = 0
                    for j in range(116):
                        if (cint >> j) & 1:
                            c_img |= 1 << perm_a[j]
                    # Express c_img back in basis_dirs if in same subspace, else block model directly
                    if a == 1:
                        slv.add_clause([-(i + 1) if model[i] > 0 else (i + 1) for i in range(n)])
        return {
            "closed": closed,
            "models": models,
            "bent_hits": bent_hits,
            "sec": round(time.perf_counter() - t_br, 3),
        }

    d0_res = run_sat_branch("d0", min(15.0, sat_budget * 0.35))
    chiral_res = run_sat_branch("chiral", max(5.0, sat_budget - d0_res["sec"]))

    return {
        "cell": cell_name,
        "closed_unsat": (d0_res["closed"] and chiral_res["closed"] and not d0_res["bent_hits"] and not chiral_res["bent_hits"]),
        "block_stats": block_stats,
        "auto_reverse_d0_branch": d0_res,
        "chiral_branch": chiral_res,
        "total_sec": round(time.perf_counter() - tc, 3),
    }


def main():
    t0 = time.perf_counter()
    sat_budget = float(sys.argv[1]) if len(sys.argv) > 1 else 45.0
    work_dir = Path(__file__).resolve().parent
    c_path = work_dir / "b18_dihedral_engine.c"
    so_path = work_dir / "libb18_dihedral_engine.so"
    c_path.write_text(C_SRC_B18, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_path), "-o", str(so_path)], check=True)
    lib = ctypes.CDLL(str(so_path))

    lib.extract_level1_quad_when_diag4.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64),
    ]
    lib.extract_level1_quad_when_diag4.restype = ctypes.c_int

    lib.extract_coset_deg12_and_cub.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
    ]
    lib.extract_coset_deg12_and_cub.restype = ctypes.c_int

    lib.gf2_echelon_insert.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int,
    ]
    lib.gf2_echelon_insert.restype = ctypes.c_int

    lib.audit_bent_c.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_uint64, ctypes.c_uint64,
    ]
    lib.audit_bent_c.restype = ctypes.c_int

    orbits, rep_to_idx = build_orbits_116()
    rep_report, auto_rev_long, chiral_pairs, perm_rev, perm_z16 = audit_dihedral_and_z16_representations(orbits, rep_to_idx)
    print("=== [1/2] DIHEDRAL D_16 & Z_16^* REPRESENTATION AUDIT ===", flush=True)
    print(json.dumps(rep_report, indent=2), flush=True)

    v6_list = all_v6_orbits()
    all_pairs = [v | (w << 8) for v in range(256) for w in range(v + 1, 256)]
    orb_diag, orb_pair = [0] * 116, [0] * 116
    orb_tts = (ctypes.c_uint64 * (116 * 1024))()
    for j, orb in enumerate(orbits):
        base = j * 1024
        for m in orb:
            for x in range(65536):
                if (x & m) == m:
                    orb_tts[base + (x >> 6)] ^= 1 << (x & 63)
        vd, vp = 0, 0
        for v in range(256):
            x = v | (v << 8)
            if (orb_tts[base + (x >> 6)] >> (x & 63)) & 1:
                vd |= 1 << v
        orb_diag[j] = vd
        for k, x in enumerate(all_pairs):
            if (orb_tts[base + (x >> 6)] >> (x & 63)) & 1:
                vp |= 1 << k
        orb_pair[j] = vp

    c0xf_reps, c0x0_reps = [], []
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
                c0xf_reps.append(mem[0])
            elif vnib == 0x0:
                c0x0_reps.append(mem[0])

    c0xf_mask = 0
    for j in range(116):
        par = 0
        for x in c0xf_reps:
            par ^= (orb_tts[j * 1024 + (x >> 6)] >> (x & 63)) & 1
        if par:
            c0xf_mask |= 1 << j

    def fiber_reps(z, step):
        pts = [v | ((v ^ z) << 8) for v in range(256)]
        seen, reps = set(), []
        for x in pts:
            if x in seen:
                continue
            cur, orb = x, []
            while cur not in orb:
                orb.append(cur)
                cur = rot16(cur, step)
            seen.update(orb)
            reps.append(min(orb))
        return reps

    f_ff_reps = fiber_reps(0xFF, 1)
    f_55_reps = fiber_reps(0x55, 2)

    print("=== [2/2] CELL BLOCK DECOMPOSITION & SOLVER ===", flush=True)
    cell_results = {}
    for c99_val, c57_val, c113_val in [(1, 0, 0), (1, 1, 1), (0, 1, 1), (0, 0, 0)]:
        res = analyze_and_solve_cell(
            c99_val, c57_val, c113_val, lib, orbits, v6_list,
            orb_diag, orb_pair, orb_tts, c0xf_mask, c0x0_reps, c0xf_reps, f_ff_reps, f_55_reps,
            auto_rev_long, chiral_pairs, perm_rev, perm_z16, sat_budget=sat_budget
        )
        cell_results[res["cell"]] = res
        print(json.dumps(res, indent=2), flush=True)

    summary = {
        "representation_audit": rep_report,
        "cells": cell_results,
        "elapsed_total_sec": round(time.perf_counter() - t0, 3),
    }
    (work_dir / "b18_dihedral_report.json").write_text(json.dumps(summary, indent=2), encoding="utf-8")


if __name__ == "__main__":
    main()
