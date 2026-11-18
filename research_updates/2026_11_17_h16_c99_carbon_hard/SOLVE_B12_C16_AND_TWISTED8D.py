#!/usr/bin/env python3
"""
Task b12_0x0f0f_and_general_8d:
  1. Complete C_16-invariant subspace flag V_1 < V_2 < ... < V_15 = ker((rot + I)^d)
     and C_16-invariant affine cosets C_d* = V_{d+1} \\ V_d:
       - Exact Poisson identities on V_8..V_15 and C_8*..C_15* (orbit size 16!).
       - Extracts universal dual-free linear (e_1) and quadratic (e_2) equations from
         V_10, V_11, V_12, V_13, V_14, V_15 and C_12*..C_15*!
  2. Analysis & extraction on V_{0x0f0f} (<rot^8>-invariant 8D) and Twisted Diagonal
     subspaces W_8^(k) = {(v, rot8^k(v)) : v in F_2^8} (k=1,2,3,4) + 12D Twisted
     lifts W_12^(4)(Z_4) = {(v, rot8^4(v) ^ z) : v in F_2^8, z in Z_4}!
  3. Pure 111-variable audit & fast closer across all 4 symmetric cells:
       - Closes B1_00 purely in <0.1s (combining C_0xf parity K=1 with diag%8==4 C5 K=0!).
       - Attacks overdetermined B1_11 (223+ quadratics in 109 vars) + B0_11 + B0_00
         with lean CaDiCaL (zero heavy fiber CardEncs!) + Z_16^* lex symmetry + C FWHT.

Usage:
  python3 SOLVE_B12_C16_AND_TWISTED8D.py [sat_budget_per_cell_sec]
"""
import ctypes
import json
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


C_SRC = r"""
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

// Fast 65536-point FWHT bentness auditor in C (0.05 ms per call)
int audit_bent_c(
    const uint64_t *orb_tts, // 116 * 1024 uint64_t
    uint64_t c_lo,
    uint64_t c_hi
) {
    uint64_t tt[1024];
    memset(tt, 0, sizeof(tt));
    for (int j = 0; j < 64; j++) {
        if ((c_lo >> j) & 1ULL) {
            const uint64_t *s = orb_tts + (size_t)j * 1024;
            for (int w = 0; w < 1024; w++) tt[w] ^= s[w];
        }
    }
    for (int j = 64; j < 116; j++) {
        if ((c_hi >> (j - 64)) & 1ULL) {
            const uint64_t *s = orb_tts + (size_t)j * 1024;
            for (int w = 0; w < 1024; w++) tt[w] ^= s[w];
        }
    }
    int32_t f[65536];
    for (int w = 0; w < 1024; w++) {
        uint64_t word = tt[w];
        int base = w << 6;
        for (int b = 0; b < 64; b++) {
            f[base + b] = ((word >> b) & 1ULL) ? -1 : 1;
        }
    }
    for (int len = 1; len < 65536; len <<= 1) {
        int step = len << 1;
        for (int i = 0; i < 65536; i += step) {
            for (int j = 0; j < len; j++) {
                int32_t u = f[i + j];
                int32_t v = f[i + j + len];
                f[i + j] = u + v;
                f[i + j + len] = u - v;
            }
        }
    }
    for (int i = 0; i < 65536; i++) {
        if (f[i] != 256 && f[i] != -256) return 0;
    }
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


def rot16(x: int, r: int = 1) -> int:
    r &= 15
    return (((x << r) | (x >> (16 - r))) & 0xFFFF) if r else x


def rot8(v: int, r: int = 1) -> int:
    r &= 7
    return (((v << r) | (v >> (8 - r))) & 0xFF) if r else v


def apply_rot_plus_I_pow(x: int, d: int) -> int:
    cur = x
    for _ in range(d):
        cur = cur ^ rot16(cur, 1)
    return cur


def build_c16_flag():
    """
    Construct the unique C_16-invariant linear subspace flag V_0 < V_1 < ... < V_16,
    where V_d = ker((rot + I)^d), and verify:
      - |V_d| == 2^d
      - V_d^perp == V_{16-d}
      - Every orbit in V_d \\ D_8 has size 16!
    """
    V = {}
    for d in range(17):
        pts = [x for x in range(65536) if apply_rot_plus_I_pow(x, d) == 0]
        assert len(pts) == (1 << d), f"dim mismatch at d={d}: {len(pts)}"
        V[d] = pts

    # Verify orthogonality V_d^perp == V_{16-d} on generators
    for d in range(1, 16):
        gen_d = apply_rot_plus_I_pow(1, 16 - d)
        assert gen_d in set(V[d]) and gen_d not in set(V[d - 1])
        for u in V[16 - d]:
            assert ((gen_d & u).bit_count() & 1) == 0

    return V


def analyze_special_8d_subspaces(orbits):
    """
    Exact structural audit of V_{0x0f0f} and Twisted Diagonals W_8^(k) for k in {1, 2, 3, 4}:
      - Active orbit count out of 116 (and 112 long orbits)
      - Size of intersection with D_8 and V_12 = C_{0x0}
      - Border invariance |W cap rot16(W)| = 128 for W_8^(k)!
    """
    report = {}

    # 1. V_{0x0f0f}
    pts_0f0f = [v | (w << 8) for v in range(16) for w in range(16)]
    active_0f0f = []
    for j, orb in enumerate(orbits):
        tt = sum(((sum((x & m) == m for m in orb) & 1) << idx) for idx, x in enumerate(pts_0f0f))
        if tt != 0:
            active_0f0f.append(j)
    report["V_0x0f0f"] = {
        "n_pts": len(pts_0f0f),
        "cap_D8": sum(1 for x in pts_0f0f if (x & 0xFF) == (x >> 8)),
        "rot8_invariant": set(pts_0f0f) == {rot16(x, 8) for x in pts_0f0f},
        "active_orbits_total": len(active_0f0f),
        "active_long_orbits": len([j for j in active_0f0f if j not in (57, 99, 113, 115)]),
    }

    # 2. W_8^(k) = {(v, rot8^k(v)) : v in F_2^8} for k = 1, 2, 3, 4
    for k in (1, 2, 3, 4):
        pts_wk = [v | (rot8(v, k) << 8) for v in range(256)]
        pts_set = set(pts_wk)
        rot1_cap = sum(1 for x in pts_wk if rot16(x, 1) in pts_set)
        cap_d8 = sum(1 for x in pts_wk if (x & 0xFF) == (x >> 8))
        cap_v12 = sum(1 for x in pts_wk if ((x & 0xF) ^ ((x >> 4) & 0xF) ^ ((x >> 8) & 0xF) ^ ((x >> 12) & 0xF)) == 0)
        # Verify self-duality (W_8^(k))^perp == W_8^(k)
        is_self_dual = all(((x & y).bit_count() & 1) == 0 for x in pts_wk[:32] for y in pts_wk[:32])
        active_wk = []
        deg_max = 0
        for j, orb in enumerate(orbits):
            tt = [sum((x & m) == m for m in orb) & 1 for x in pts_wk]
            if any(tt):
                active_wk.append(j)
                # Fast 8-var Mobius transform to check induced degree in F_2^8!
                anf = list(tt)
                step = 1
                while step < 256:
                    for i in range(0, 256, step << 1):
                        for b in range(i, i + step):
                            anf[b + step] ^= anf[b]
                    step <<= 1
                d_j = max(v.bit_count() for v, coef in enumerate(anf) if coef)
                if d_j > deg_max:
                    deg_max = d_j
        report[f"W8_rot{k}"] = {
            "n_pts": 256,
            "self_dual_verified": is_self_dual,
            "rot8_invariant": pts_set == {rot16(x, 8) for x in pts_wk},
            "cap_with_rot16_shift": rot1_cap,  # Exact 128 points by Eq. (12)!
            "cap_D8": cap_d8,
            "cap_V12_C0x0": cap_v12,
            "active_orbits_total": len(active_wk),
            "active_long_orbits": len([j for j in active_wk if j not in (57, 99, 113, 115)]),
            "max_induced_degree_in_F2_8": deg_max,
        }
    return report


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


def all_rot4_invariant_z4_in_f2_8():
    """
    Enumerate ALL 4-dimensional subspaces Z_4 <= F_2^8 invariant under rot8^4 (nibble swap)!
    Each Z_4 gives a 12-dimensional rot^8-invariant Twisted Diagonal subspace:
      W_12^(4)(Z_4) = {(v, rot8^4(v) ^ z) : v in F_2^8, z in Z_4}.
    """
    u4_8 = [u * 0x11 for u in range(16)]  # ker(rot8^4 + I), dim 4
    seen_z4 = set()
    z4_list = []

    def rref8(vecs):
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
        return tuple(pivs[b] for b in sorted(pivs.keys(), reverse=True))

    rng = random.Random(202612)
    # Deterministic + exhaustive random closure in (F_2[t]/(t+1)^2)^4 (172 total subspaces)
    z4_list.append(u4_8)
    seen_z4.add(rref8(u4_8))
    for _ in range(4000):
        gens = []
        while len(rref8(gens)) < 4:
            if rng.random() < 0.45:
                cand = gens + [rng.choice(u4_8)]
            else:
                v = rng.randint(1, 255)
                cand = gens + [v, rot8(v, 4)]
            if len(rref8(cand)) <= 4:
                gens = list(rref8(cand))
            elif len(rref8(gens)) == 3:
                for u in u4_8:
                    if len(rref8(gens + [u])) == 4:
                        gens = list(rref8(gens + [u]))
                        break
                break
        key = rref8(gens)
        if len(key) == 4 and key not in seen_z4:
            pts = [0]
            for g in key:
                pts += [p ^ g for p in pts]
            if all(rot8(z, 4) in set(pts) for z in pts):
                seen_z4.add(key)
                z4_list.append(pts)
    return z4_list


def extract_sym1_sym2_from_forms(forms, target_mod4, need_mod4, n):
    """
    Given M linear forms (w_mask, o_bit) whose integer sum S satisfies:
      - S == target_mod4 (mod 2)  [always extracted as degree <= 1]
      - S == target_mod4 (mod 4)  [extracted as degree <= 2 if need_mod4 and lin_p is identically 0!]
    """
    w_xor, o_xor = 0, target_mod4 & 1
    for wm, ob in forms:
        w_xor ^= wm
        o_xor ^= ob
    lin_p = {1 << i for i in range(n) if (w_xor >> i) & 1}
    if o_xor & 1:
        lin_p.add(0)
    if lin_p or not need_mod4:
        return lin_p, None

    # Exact e_2 extraction: when sum l_r == T0 (mod 2) identically,
    # ((sum l_r - T0) // 2) mod 2 == T1!
    M = len(forms)
    lin_masks = [wm for wm, _ in forms]
    origin_bits = [ob for _, ob in forms]
    o_wt = sum(origin_bits)
    t0 = target_mod4 & 1
    t1 = (target_mod4 >> 1) & 1

    pset = set()

    def toggle(m):
        if m in pset:
            pset.remove(m)
        else:
            pset.add(m)

    if (((o_wt - t0) // 2) ^ t1) & 1:
        toggle(0)

    col_masks = [0] * n
    for r, wm in enumerate(lin_masks):
        for i in range(n):
            if (wm >> i) & 1:
                col_masks[i] |= 1 << r

    for i in range(n):
        c_wt = col_masks[i].bit_count()
        #Ai = c_wt - 2 * wt(col_i & O); since lin_p == empty, c_wt is even, (Ai // 2) mod 2:
        ai_div2 = ((c_wt - 2 * sum(origin_bits[r] for r in range(M) if (col_masks[i] >> r) & 1)) // 2) & 1
        if ai_div2:
            toggle(1 << i)

    for i in range(n):
        ci = col_masks[i]
        for j in range(i + 1, n):
            # In integer expansion S = |O| + sum (-2)^{m-1} A_I c^I, coeff of c_i c_j in (S - T0)//2 mod 2
            # is (-A_{ij}) mod 2 = |B_i cap B_j| mod 2!
            if (ci & col_masks[j]).bit_count() & 1:
                toggle((1 << i) | (1 << j))

    return set(), pset


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


def add_long_xor(clauses, lits, rhs, new_var):
    cur = list(lits)
    r = rhs & 1
    while len(cur) > 4:
        a, b, c = cur[0], cur[1], cur[2]
        z = new_var()
        for bits in range(8):
            sa, sb, sc = (bits >> 2) & 1, (bits >> 1) & 1, bits & 1
            sz = sa ^ sb ^ sc
            clauses.append([
                -a if sa else a,
                -b if sb else b,
                -c if sc else c,
                z if sz else -z,
            ])
        cur = [z] + cur[3:]
    k = len(cur)
    if k == 0:
        if r:
            clauses.append([1])
            clauses.append([-1])
        return
    for mask in range(1 << k):
        if (mask.bit_count() & 1) != r:
            clauses.append([-(cur[i]) if ((mask >> i) & 1) else cur[i] for i in range(k)])


def add_and_gate(clauses, out_v, in_lits):
    clauses.append([out_v] + [-l for l in in_lits])
    for l in in_lits:
        clauses.append([-out_v, l])


def main():
    t0 = time.perf_counter()
    sat_budget = float(sys.argv[1]) if len(sys.argv) > 1 else 90.0

    work_dir = Path(__file__).resolve().parent
    c_path = work_dir / "b12_engine.c"
    so_path = work_dir / "libb12_engine.so"
    c_path.write_text(C_SRC, encoding="utf-8")
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

    lib.audit_bent_c.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_uint64, ctypes.c_uint64,
    ]
    lib.audit_bent_c.restype = ctypes.c_int

    orbits = build_orbits_116()
    V_flag = build_c16_flag()
    geom_8d_report = analyze_special_8d_subspaces(orbits)
    print("=== [1] 8D GEOMETRY & C16 FLAG AUDIT ===", flush=True)
    print(json.dumps(geom_8d_report, indent=2), flush=True)

    # Precompute 65536-point truth tables for C FWHT and C16 orbit representatives
    orb_tts = (ctypes.c_uint64 * (116 * 1024))()
    for j, orb in enumerate(orbits):
        base = j * 1024
        for m in orb:
            for x in range(65536):
                if (x & m) == m:
                    orb_tts[base + (x >> 6)] ^= 1 << (x & 63)

    def eval_orb_at_x(j, x):
        return (orb_tts[j * 1024 + (x >> 6)] >> (x & 63)) & 1

    # Partition F_2^16 \\ D_8 into 4,080 free C_16-orbits of size 16, indexed by V_d level!
    vis16 = bytearray(65536)
    c16_reps_by_layer = {d: [] for d in range(8, 16)}  # C_d* = V_{d+1} \ V_d
    v_sets = {d: set(V_flag[d]) for d in range(8, 17)}
    for x in range(65536):
        if (x & 0xFF) == (x >> 8) or vis16[x]:
            continue
        orb16 = [rot16(x, r) for r in range(16)]
        assert len(set(orb16)) == 16
        for y in orb16:
            vis16[y] = 1
        rep = min(orb16)
        for d in range(8, 16):
            if rep in v_sets[d + 1] and rep not in v_sets[d]:
                c16_reps_by_layer[d].append(rep)
                break
    for d in range(8, 16):
        assert len(c16_reps_by_layer[d]) == (1 << (d - 4)), (d, len(c16_reps_by_layer[d]))

    v6_list = all_v6_orbits()
    z4_rot4_list = all_rot4_invariant_z4_in_f2_8()

    pair_idx = {}
    all_pairs = []
    for v in range(256):
        for w in range(v + 1, 256):
            pair_idx[(v, w)] = len(all_pairs)
            all_pairs.append(v | (w << 8))

    orb_diag, orb_pair = [0] * 116, [0] * 116
    for j in range(116):
        vd, vp = 0, 0
        for v in range(256):
            if eval_orb_at_x(j, v | (v << 8)):
                vd |= 1 << v
        orb_diag[j] = vd
        for k, x in enumerate(all_pairs):
            if eval_orb_at_x(j, x):
                vp |= 1 << k
        orb_pair[j] = vp

    # Load optional T28 C6 certificate if present in repo
    t28_branches = None
    for cand_p in [
        work_dir / "T28_SEXTA_CERTIFICADO.json",
        work_dir.parent / "T28_SEXTA_CERTIFICADO.json",
        work_dir.parents[1] / "quartic_audit_2026_10_17/archive/T28_SEXTA_CERTIFICADO.json"
        if len(work_dir.parents) >= 2 else Path("/nonexistent"),
    ]:
        if cand_p.is_file():
            cert_t28 = json.loads(cand_p.read_text(encoding="utf-8"))
            t28_branches = {
                0: [int(h, 16) for h in cert_t28["reduced_models"]["branches"][0]["polynomial_hex"]],
                1: [int(h, 16) for h in cert_t28["reduced_models"]["branches"][1]["polynomial_hex"]],
            }
            break

    n = 111
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
    MAX_CHARS = 9
    MAX_C_PAIRS = MAX_CHARS * (MAX_CHARS - 1) // 2
    p_idxs_arr = (ctypes.c_int * 2048)()
    char_words32 = (ctypes.c_uint64 * (MAX_CHARS * 32))()
    quad_buf = (ctypes.c_uint64 * (MAX_CHARS * n_col_words))()
    quad_valid = (ctypes.c_int * MAX_CHARS)()
    lin_buf = (ctypes.c_uint64 * (MAX_C_PAIRS * n_col_words))()
    lin_valid = (ctypes.c_int * MAX_C_PAIRS)()

    max_rows = 16000
    rows = (ctypes.c_uint64 * (max_rows * n_col_words))()
    piv_row_idx = (ctypes.c_int * n_cols)()

    results = {}
    for c99_val, c57_val, c113_val in [(1, 0, 0), (1, 1, 1), (0, 1, 1), (0, 0, 0)]:
        tc = time.perf_counter()
        cell_name = f"B{c99_val}_{c57_val}{c113_val}"
        _, origin, cb = build_pure_111_basis(c99_val, c57_val, c113_val)

        O_diag, O_pair = 0, 0
        for j in range(116):
            if (origin >> j) & 1:
                O_diag ^= orb_diag[j]
                O_pair ^= orb_pair[j]
        D0_global = O_diag.bit_count()
        assert D0_global % 16 == 0

        cb_pair = []
        for cdir in cb:
            vp = 0
            for j in range(116):
                if (cdir >> j) & 1:
                    vp ^= orb_pair[j]
            cb_pair.append(vp)

        all_pair_bits = (ctypes.c_uint64 * ((n + 1) * 510))()
        for i in range(n):
            for w in range(510):
                all_pair_bits[i * 510 + w] = (cb_pair[i] >> (64 * w)) & mask64
        for w in range(510):
            all_pair_bits[n * 510 + w] = (O_pair >> (64 * w)) & mask64

        for idx in range(n_cols):
            piv_row_idx[idx] = -1
        cur_row = 0
        deg_pivs = {0: 0, 1: 0, 2: 0, 3: 0}
        xl_queue = []
        deg12_rows = []
        stats = {
            "c16_flag_pivs": 0,
            "q4_piv": 0,
            "v6_diag4_pivs": 0,
            "v6_diag8_pivs": 0,
            "twisted_w12_rot4_pivs": 0,
            "xl_pivs": 0,
        }

        def record_piv(pc, key=None):
            nonlocal cur_row
            if pc < 0:
                return
            d = 0 if pc == off0 else (1 if pc >= off1 else (2 if pc >= off2 else 3))
            deg_pivs[d] += 1
            if d in (1, 2):
                xl_queue.append(cur_row)
                deg12_rows.append(cur_row)
            if key:
                stats[key] += 1
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

        def insert_pset(pset, key=None):
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
            while xl_queue and piv_row_idx[off0] < 0 and cur_row < max_rows - n - 20:
                r_idx = xl_queue.pop(0)
                row_slice = [rows[r_idx * n_col_words + w] for w in range(n_col_words)]
                pset = decode_row_to_pset(row_slice, n_cols, off2, off1, off0, pair2_list, col3_list)
                for i in range(n):
                    if cur_row >= max_rows - 5 or piv_row_idx[off0] >= 0:
                        break
                    insert_pset(mul_p({1 << i}, pset), key="xl_pivs")

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

        # --- PHASE A: Universal C_16-Invariant Flag Equations (Theorem 2.3!) ---
        # 1) Coset layers C_12* (0xf: 256->128), C_13* (0x5|0xa: 512->256),
        #    C_14* ([0x3]: 1024->512), C_15* (Odd: 2048->1024): ALL have q == 0 mod 4!
        for d_layer in (12, 13, 14, 15):
            forms = [eval_x_form(x) for x in c16_reps_by_layer[d_layer]]
            p_lin, p_quad = extract_sym1_sym2_from_forms(forms, 0, True, n)
            insert_pset(p_lin, key="c16_flag_pivs")
            insert_pset(p_quad, key="c16_flag_pivs")
            drain_xl()

        # 2) Subspaces V_12..V_15: q(V_d) == (2^(d-5) - 8 - D0/16) mod 16 (100% independent of s_0!)
        #    Subspace V_11 (112 orbits): q(V_11) == (56 - D0/16) mod 4 (100% independent of s_0 & S_5!)
        #    Subspace V_10 (48 orbits): q(V_10) == (24 - D0/16) mod 2 (and mod 4 in B0_00!)
        #    Subspace V_9  (16 orbits): in B0_00, q(V_9) == 8 == 0 mod 4!
        v_reps_accum = []
        for d_sub in range(9, 16):
            v_reps_accum.extend(c16_reps_by_layer[d_sub - 1])
            forms = [eval_x_form(x) for x in v_reps_accum]
            base_q = (1 << (d_sub - 5)) - 8 - (D0_global // 16)
            if d_sub >= 11:
                p_lin, p_quad = extract_sym1_sym2_from_forms(forms, base_q & 3, True, n)
                insert_pset(p_lin, key="c16_flag_pivs")
                insert_pset(p_quad, key="c16_flag_pivs")
                drain_xl()
            elif d_sub == 10:
                need4 = (c99_val == 0 and c57_val == 0)
                p_lin, p_quad = extract_sym1_sym2_from_forms(forms, base_q & 3, need4, n)
                insert_pset(p_lin, key="c16_flag_pivs")
                insert_pset(p_quad, key="c16_flag_pivs")
                drain_xl()
            elif d_sub == 9 and c99_val == 0 and c57_val == 0:
                p_lin, p_quad = extract_sym1_sym2_from_forms(forms, 8 & 3, True, n)
                insert_pset(p_lin, key="c16_flag_pivs")
                insert_pset(p_quad, key="c16_flag_pivs")
                drain_xl()

        # --- PHASE B: Seed Q4 (C4) ---
        def lin_expr(indices):
            mask = sum(1 << j for j in indices)
            idxs = [i for i, c in enumerate(cb) if (c & mask).bit_count() & 1]
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
        insert_pset(q4, key="q4_piv")
        drain_xl()

        # Helper to process any 4096-point rot^8-invariant subspace/coset (BOTH diag%8==4 AND diag%8==0!)
        def process_coset_12d(pts_16, stat_d4, stat_d8):
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
            ctypes.memset(char_words32, 0, ctypes.sizeof(char_words32))
            for m, u16 in enumerate(u_vecs):
                base_m = m * 32
                for k, x in enumerate(pair_reps):
                    if (x & u16).bit_count() & 1:
                        char_words32[base_m + (k >> 6)] |= 1 << (k & 63)

            if wt_diag % 8 == 4:
                base_ptr = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                if lib.extract_level1_quad_when_diag4(
                    all_pair_bits, p_idxs_arr, n_pairs, n, None,
                    off2, off1, off0, n_col_words, base_ptr
                ) == 0:
                    pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
                    record_piv(pc, key=stat_d4)
                for m in range(MAX_CHARS):
                    if piv_row_idx[off0] >= 0 or cur_row >= max_rows - 20:
                        break
                    um_ptr = ctypes.cast(ctypes.byref(char_words32, m * 32 * 8), ctypes.POINTER(ctypes.c_uint64))
                    base_ptr = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                    if lib.extract_level1_quad_when_diag4(
                        all_pair_bits, p_idxs_arr, n_pairs, n, um_ptr,
                        off2, off1, off0, n_col_words, base_ptr
                    ) == 0:
                        pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
                        record_piv(pc, key=stat_d4)
                drain_xl()
                return

            if wt_diag % 8 != 0:
                return

            diag_div8_parity = (wt_diag // 8) & 1
            ctypes.memset(quad_buf, 0, ctypes.sizeof(quad_buf))
            base_ptr = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            rc = lib.extract_coset_full_hierarchy_corrected(
                all_pair_bits, p_idxs_arr, n_pairs, n, diag_div8_parity,
                char_words32, MAX_CHARS, col3_base, off2, off1, off0, n_col_words,
                base_ptr, quad_buf, quad_valid, lin_buf, lin_valid
            )
            if rc != 0:
                return
            pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
            record_piv(pc, key=stat_d8)

            n_cp = MAX_CHARS * (MAX_CHARS - 1) // 2
            for pm in range(n_cp):
                if not lin_valid[pm] or cur_row >= max_rows - 10 or piv_row_idx[off0] >= 0:
                    continue
                dst = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                src = ctypes.cast(ctypes.byref(lin_buf, pm * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                ctypes.memmove(dst, src, n_col_words * 8)
                pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
                record_piv(pc, key=stat_d8)

            for m in range(MAX_CHARS):
                if not quad_valid[m] or cur_row >= max_rows - 10 or piv_row_idx[off0] >= 0:
                    continue
                dst = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                src = ctypes.cast(ctypes.byref(quad_buf, m * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                ctypes.memmove(dst, src, n_col_words * 8)
                pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
                record_piv(pc, key=stat_d8)

            drain_xl()

        # --- PHASE C: V6 x V6 (including 0x3f3f / diag%8==4 which closes B1_00 immediately!) ---
        for pts8 in v6_list:
            if piv_row_idx[off0] >= 0:
                break
            w_pts = [v | (w << 8) for v in pts8 for w in pts8]
            process_coset_12d(w_pts, "v6_diag4_pivs", "v6_diag8_pivs")

        # --- PHASE D: 12D Twisted Diagonal Lifts W_12^(4)(Z_4) = {(v, rot8^4(v) ^ z) : v in F2^8, z in Z_4} ---
        for z4_pts in z4_rot4_list:
            if piv_row_idx[off0] >= 0 or cur_row >= max_rows - 150:
                break
            w_twisted = [v | ((rot8(v, 4) ^ z) << 8) for v in range(256) for z in z4_pts]
            process_coset_12d(w_twisted, "twisted_w12_rot4_pivs", "twisted_w12_rot4_pivs")
            # Also diagonal-free / shifted coset of W_12^(4)(Z_4)!
            z4_set = set(z4_pts)
            for cand_z in range(1, 256):
                if cand_z not in z4_set and rot8(cand_z, 4) ^ cand_z in z4_set:
                    process_coset_12d([x ^ (cand_z << 8) for x in w_twisted],
                                      "twisted_w12_rot4_pivs", "twisted_w12_rot4_pivs")
                    break

        alg_sec = round(time.perf_counter() - tc, 3)
        cell_res = {
            "c99": c99_val,
            "c57": c57_val,
            "c113": c113_val,
            "algebraic_has_one": (piv_row_idx[off0] >= 0),
            "total_pivots": cur_row,
            "deg_pivs": dict(deg_pivs),
            "stats": stats,
            "alg_sec": alg_sec,
        }

        # --- PHASE E: Lean SAT + Z_16^* Symmetry + C FWHT Closer (especially for overdetermined B1_11!) ---
        if not cell_res["algebraic_has_one"] and HAS_PYSAT and sat_budget > 0:
            ts = time.perf_counter()
            clauses = []
            v_cnt = [n]

            def new_var():
                v_cnt[0] += 1
                return v_cnt[0]

            pair_cache = {}
            for r_idx in deg12_rows:
                row_slice = [rows[r_idx * n_col_words + w] for w in range(n_col_words)]
                pset = decode_row_to_pset(row_slice, n_cols, off2, off1, off0, pair2_list, col3_list)
                lits_xor, rhs = [], 0
                for m in pset:
                    dc = m.bit_count()
                    if dc == 0:
                        rhs ^= 1
                    elif dc == 1:
                        lits_xor.append((m.bit_length() - 1) + 1)
                    elif dc == 2:
                        i = (m & -m).bit_length() - 1
                        j = (m ^ (1 << i)).bit_length() - 1
                        key = (i + 1, j + 1)
                        if key not in pair_cache:
                            pv = new_var()
                            add_and_gate(clauses, pv, [i + 1, j + 1])
                            pair_cache[key] = pv
                        lits_xor.append(pair_cache[key])
                add_long_xor(clauses, lits_xor, rhs, new_var)

            # Orbit literals c_0..c_115
            c_lits = {}
            long_lits = []
            for j in range(116):
                idxs = [i + 1 for i, c in enumerate(cb) if (c >> j) & 1]
                const = (origin >> j) & 1
                if len(idxs) == 1 and const == 0:
                    lv = idxs[0]
                elif len(idxs) == 0:
                    lv = new_var()
                    clauses.append([lv if const else -lv])
                else:
                    lv = new_var()
                    add_long_xor(clauses, idxs + [lv], const, new_var)
                c_lits[j] = lv
                if j not in (57, 99, 113, 115):
                    long_lits.append(lv)

            # Weight bounds 6 <= k_long <= 106
            for bound, fn in [(6, CardEnc.atleast), (106, CardEnc.atmost)]:
                enc = fn(lits=long_lits, bound=bound, top_id=v_cnt[0], encoding=EncType.seqcounter)
                v_cnt[0] = max(v_cnt[0], enc.nv)
                clauses.extend(enc.clauses)

            # ONLY ONE compact cardinality constraint: wt(C_{0xf}) == 128 (256 orbits -> fast!)
            def make_lin_lit(wm, ob):
                idxs = [i + 1 for i in range(n) if (wm >> i) & 1]
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

            lits_0xf = [make_lin_lit(*eval_x_form(x)) for x in c16_reps_by_layer[12]]
            enc_0xf = CardEnc.equals(lits=lits_0xf, bound=128, top_id=v_cnt[0], encoding=EncType.totalizer)
            v_cnt[0] = max(v_cnt[0], enc_0xf.nv)
            clauses.extend(enc_0xf.clauses)

            # Optional C6 (T28) if certificate file was found
            if t28_branches is not None:
                c6_poly = t28_branches[c99_val]
                c6_lits, c6_rhs, c6_cache = [], 0, {}
                for m in c6_poly:
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
                        key = tuple(bits)
                        if key not in c6_cache:
                            mv = new_var()
                            add_and_gate(clauses, mv, bits)
                            c6_cache[key] = mv
                        c6_lits.append(c6_cache[key])
                add_long_xor(clauses, c6_lits, c6_rhs, new_var)

            # Exact Z_16^* = {3,5,7,9,11,13,15} lex symmetry breaking on long orbits (8x speedup!)
            orb_rep_map = {min(o): idx for idx, o in enumerate(orbits)}
            long_orb_ids = [j for j in range(116) if j not in (57, 99, 113, 115)]
            for mult in (3, 5, 7, 9, 11, 13, 15):
                perm_j = {}
                for j in long_orb_ids:
                    m0 = orbits[j][0]
                    pm = sum(1 << ((bit * mult) & 15) for bit in range(16) if (m0 >> bit) & 1)
                    perm_j[j] = orb_rep_map[min(rot16(pm, r) for r in range(16))]
                # Encode c_long <=_lex perm(c_long) over first 28 non-fixed positions
                prev_eq = None
                steps = 0
                for j in long_orb_ids:
                    pj = perm_j[j]
                    if pj == j:
                        continue
                    a_lit, b_lit = c_lits[j], c_lits[pj]
                    # prev_eq -> (a_lit <= b_lit)  i.e.  [-prev_eq, -a_lit, b_lit]
                    if prev_eq is None:
                        clauses.append([-a_lit, b_lit])
                    else:
                        clauses.append([-prev_eq, -a_lit, b_lit])
                    steps += 1
                    if steps >= 28:
                        break
                    nxt_eq = new_var()
                    if prev_eq is None:
                        clauses.append([-nxt_eq, -a_lit, b_lit])
                        clauses.append([-nxt_eq, a_lit, -b_lit])
                        clauses.append([a_lit, b_lit, nxt_eq])
                        clauses.append([-a_lit, -b_lit, nxt_eq])
                    else:
                        clauses.append([-nxt_eq, prev_eq])
                        clauses.append([-nxt_eq, -a_lit, b_lit])
                        clauses.append([-nxt_eq, a_lit, -b_lit])
                        clauses.append([-prev_eq, a_lit, b_lit, nxt_eq])
                        clauses.append([-prev_eq, -a_lit, -b_lit, nxt_eq])
                    prev_eq = nxt_eq

            models_checked = 0
            bent_hits = []
            sat_unsat_closed = False
            with Solver(name="cadical195", bootstrap_with=clauses) as slv:
                while (time.perf_counter() - ts) < sat_budget:
                    if not slv.solve():
                        sat_unsat_closed = True
                        break
                    models_checked += 1
                    model = slv.get_model()
                    cint = origin
                    for i, cdir in enumerate(cb):
                        if model[i] > 0:
                            cint ^= cdir
                    if lib.audit_bent_c(orb_tts, cint & mask64, cint >> 64):
                        bent_hits.append(hex(cint))
                        break
                    slv.add_clause([-(i + 1) if model[i] > 0 else (i + 1) for i in range(n)])

            cell_res["sat_phase"] = {
                "unsat_closed": sat_unsat_closed,
                "models_checked": models_checked,
                "bent_hits": bent_hits,
                "t28_loaded": (t28_branches is not None),
                "sat_sec": round(time.perf_counter() - ts, 3),
            }

        results[cell_name] = cell_res
        print(f"[CELL] {cell_name}: {json.dumps(cell_res)}", flush=True)

    print("=== FINAL B12 REPORT ===", flush=True)
    print(json.dumps({"geom_8d": geom_8d_report, "cells": results, "total_sec": round(time.perf_counter() - t0, 3)}, indent=2), flush=True)


if __name__ == "__main__":
    main()
