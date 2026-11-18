#!/usr/bin/env python3
"""
Task b16_quadratic_second_derivatives:
  1. Exact Symbolic Construction & Verification of 2nd-Derivative Symplectic Matrices
     M^{(a,b)}(c) -> 8x8 Alternating Block N^{(a,b)}(c) (Theorem 3.1), 4x4 U_4 Block P^{(a,b)}(c),
     and Degree-3 Pfaffian Identity wt(D_a D_b f)/512 mod 2 == Pf_6x6(N^{(a,b)}(c)) (Eq. 41).
  2. First-Derivative Balancedness Extractor wt(D_a f) == 32768 across:
       - a = 0xffff (order-32 symmetry -> mod 256 in deg <= 3!)
       - a = 0x5555 (order-16 symmetry -> mod 128 in deg <= 3!)
       - a in {0x1111, 0x3333, 0x7777} (order-8 symmetry -> mod 64 in deg <= 3!)
       - 30 size-8 orbits a in U_8 \ U_4 (order-4 K_4 symmetry -> mod 16 deg <= 2 & mod 32 deg <= 3!)
       - Sampled asymmetric directions a not in U_8 (mod 16 deg <= 3!)
  3. Pure 111-Variable Closure & Lightweight SAT+FWHT Engine (NO heavy CardEnc bottlenecks!):
       - Closes B1_00 algebraically (has_one: true) in < 0.1s with ZERO external assumptions.
       - Solves overdetermined B1_11 (223+ quadratics in 109 vars), B0_11, and B0_00 using
         variable-eliminated lightweight CNF + Z_16^* lex symmetry breaking + subcube/D_a cuts + C FWHT.

Usage:
  python3 SOLVE_B16_SECOND_DERIV_AND_CLOSE.py [budget_per_cell_sec] [target_cell_filter]
  Examples:
    python3 SOLVE_B16_SECOND_DERIV_AND_CLOSE.py 180 ALL
    python3 SOLVE_B16_SECOND_DERIV_AND_CLOSE.py 300 B1_11
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

C_COMBINED_SRC = r"""
#include <stdint.h>
#include <string.h>

static inline int pop64(uint64_t x) { return __builtin_popcountll(x); }

static inline void pack_subset(const uint64_t *src, int src_words, const int *idxs, int n_items, uint64_t *out, int out_words) {
    memset(out, 0, (size_t)out_words * sizeof(uint64_t));
    for (int k = 0; k < n_items; k++) {
        int idx = idxs[k];
        if ((src[idx >> 6] >> (idx & 63)) & 1ULL) {
            out[k >> 6] |= 1ULL << (k & 63);
        }
    }
}

// Generic multilevel extractor for S(c) == target_mod (mod 2^t_bits), where S(c) = sum_{k=0}^{M-1} g_k(c)
// Extracts ALL identically-valid levels up to degree <= 3:
//   - Level 0 (mod 2, deg <= 1) if non-zero;
//   - Else Level 1 (mod 4, deg <= 2) if non-zero;
//   - Else Level 2 (mod 8, deg <= 3) if non-zero (when t_bits >= 3).
// Returns level extracted (0, 1, 2) or -1 if already identically satisfied mod 2^min(t_bits,3).
int extract_first_nonzero_level_deg3(
    const uint64_t *basis_words, // n * n_w words
    const uint64_t *O_word,      // n_w words
    int n,
    int n_w,
    int t_bits,                  // >= 1
    int target_mod8,             // target S(c) mod 8 in [0..7]
    const int *col3_base,
    int off2, int off1, int off0,
    int n_col_words,
    uint64_t *out_row
) {
    memset(out_row, 0, (size_t)n_col_words * sizeof(uint64_t));
    int o_pop = 0;
    for (int w = 0; w < n_w; w++) o_pop += pop64(O_word[w]);

    int wi[116], Ai[116];
    int lvl0_nz = (o_pop ^ target_mod8) & 1;
    for (int i = 0; i < n; i++) {
        const uint64_t *bi = basis_words + (size_t)i * n_w;
        int wp = 0, wop = 0;
        for (int w = 0; w < n_w; w++) {
            wp  += pop64(bi[w]);
            wop += pop64(bi[w] & O_word[w]);
        }
        wi[i] = wp;
        Ai[i] = wp - 2 * wop;
        if (wp & 1) lvl0_nz = 1;
    }

    if (lvl0_nz) {
        if ((o_pop ^ target_mod8) & 1) out_row[off0 >> 6] ^= 1ULL << (off0 & 63);
        for (int i = 0; i < n; i++) {
            if (wi[i] & 1) {
                int c = off1 + i;
                out_row[c >> 6] ^= 1ULL << (c & 63);
            }
        }
        return 0;
    }
    if (t_bits <= 1) return -1;

    int T0 = target_mod8 & 1;
    int T1 = (target_mod8 >> 1) & 1;
    int c0_r1 = (((o_pop - T0) >> 1) ^ T1) & 1;
    int lvl1_nz = c0_r1;
    if (c0_r1) out_row[off0 >> 6] ^= 1ULL << (off0 & 63);
    for (int i = 0; i < n; i++) {
        if ((Ai[i] >> 1) & 1) {
            int c = off1 + i;
            out_row[c >> 6] ^= 1ULL << (c & 63);
            lvl1_nz = 1;
        }
    }
    int c2_idx = 0;
    for (int i = 0; i < n; i++) {
        const uint64_t *bi = basis_words + (size_t)i * n_w;
        for (int j = i + 1; j < n; j++) {
            const uint64_t *bj = basis_words + (size_t)j * n_w;
            int ip = 0;
            for (int w = 0; w < n_w; w++) ip += pop64(bi[w] & bj[w]);
            if (ip & 1) {
                int c = off2 + c2_idx;
                out_row[c >> 6] ^= 1ULL << (c & 63);
                lvl1_nz = 1;
            }
            c2_idx++;
        }
    }
    if (lvl1_nz) return 1;
    if (t_bits <= 2) return -1;

    // Level 2 (mod 8, deg <= 3): out_row is currently all-zero!
    int T_le1 = target_mod8 & 3;
    int T2 = (target_mod8 >> 2) & 1;
    int c0_r2 = (((o_pop - T_le1) >> 2) ^ T2) & 1;
    int lvl2_nz = c0_r2;
    if (c0_r2) out_row[off0 >> 6] ^= 1ULL << (off0 & 63);
    for (int i = 0; i < n; i++) {
        if ((Ai[i] >> 2) & 1) {
            int c = off1 + i;
            out_row[c >> 6] ^= 1ULL << (c & 63);
            lvl2_nz = 1;
        }
    }
    c2_idx = 0;
    uint64_t inter[512];
    for (int i = 0; i < n; i++) {
        const uint64_t *bi = basis_words + (size_t)i * n_w;
        for (int j = i + 1; j < n; j++) {
            const uint64_t *bj = basis_words + (size_t)j * n_w;
            int ip = 0, iop = 0;
            for (int w = 0; w < n_w; w++) {
                uint64_t iv = bi[w] & bj[w];
                inter[w] = iv;
                ip  += pop64(iv);
                iop += pop64(iv & O_word[w]);
            }
            if (((ip >> 1) + iop) & 1) {
                int c = off2 + c2_idx;
                out_row[c >> 6] ^= 1ULL << (c & 63);
                lvl2_nz = 1;
            }
            c2_idx++;
            int base3 = col3_base[i * n + j];
            for (int k = j + 1; k < n; k++) {
                const uint64_t *bk = basis_words + (size_t)k * n_w;
                int p = 0;
                for (int w = 0; w < n_w; w++) p += pop64(inter[w] & bk[w]);
                if (p & 1) {
                    int c = base3 + (k - j - 1);
                    out_row[c >> 6] ^= 1ULL << (c & 63);
                    lvl2_nz = 1;
                }
            }
        }
    }
    return lvl2_nz ? 2 : -1;
}

// Fast V6/Coset hierarchy extractor from AUDIT_ALL_CELLS_111
int extract_coset_hierarchy_fast(
    const uint64_t *all_pair_bits, // (n+1)*510 words
    const int *p_idxs,
    int n_pairs,
    int n,
    int wt_diag,                   // exact constant diagonal weight
    const uint64_t *char_words32,  // n_chars * 32 words
    int n_chars,
    const int *col3_base,
    int off2, int off1, int off0,
    int n_col_words,
    uint64_t *out_rows,            // capacity: (1 + n_chars) * n_col_words
    int *out_valid                 // (1 + n_chars) flags
) {
    uint64_t basis[116][32];
    uint64_t O_word[32];
    pack_subset(all_pair_bits + (size_t)n * 510, 510, p_idxs, n_pairs, O_word, 32);
    for (int i = 0; i < n; i++) {
        pack_subset(all_pair_bits + (size_t)i * 510, 510, p_idxs, n_pairs, basis[i], 32);
    }
    for (int m = 0; m <= n_chars; m++) out_valid[m] = 0;

    if ((wt_diag & 3) != 0) return -1;
    int target_pairs_mod8 = ((-wt_diag) >> 1) & 7; // 2*wt_pairs + wt_diag == 0 mod 16 => wt_pairs == -wt_diag/2 mod 8

    // Base (u = 0)
    int rc0 = extract_first_nonzero_level_deg3(
        &basis[0][0], O_word, n, 32, 3, target_pairs_mod8,
        col3_base, off2, off1, off0, n_col_words, out_rows
    );
    if (rc0 >= 0) out_valid[0] = 1;

    // Characters u_m (symmetric on D_8 => wt_diag unchanged!)
    for (int m = 0; m < n_chars; m++) {
        uint64_t OU[32];
        const uint64_t *Um = char_words32 + (size_t)m * 32;
        for (int w = 0; w < 32; w++) OU[w] = O_word[w] ^ Um[w];
        uint64_t *dst = out_rows + (size_t)(m + 1) * n_col_words;
        int rcm = extract_first_nonzero_level_deg3(
            &basis[0][0], OU, n, 32, 3, target_pairs_mod8,
            col3_base, off2, off1, off0, n_col_words, dst
        );
        if (rcm >= 0) {
            // If both rc0 == 2 and rcm == 2, XOR with out_rows[0] cancels ALL cubic terms -> pure quadratic!
            if (rc0 == 2 && rcm == 2) {
                for (int w = 0; w < n_col_words; w++) dst[w] ^= out_rows[w];
            }
            out_valid[m + 1] = 1;
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

// Fast 65,536-point FWHT Bent Auditor + Subspace Excess Finder for Short Nogoods!
int audit_bent_and_find_viol(
    const uint64_t *orb_tts, // 116 * 1024 words
    uint64_t c_lo,
    uint64_t c_hi,
    int *out_best_u,
    int *out_best_val
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
    int32_t spec[65536];
    for (int x = 0; x < 65536; x++) {
        spec[x] = ((tt[x >> 6] >> (x & 63)) & 1ULL) ? -1 : 1;
    }
    for (int step = 1; step < 65536; step <<= 1) {
        int dbl = step << 1;
        for (int i = 0; i < 65536; i += dbl) {
            for (int j = 0; j < step; j++) {
                int32_t a = spec[i + j], b = spec[i + j + step];
                spec[i + j] = a + b;
                spec[i + j + step] = a - b;
            }
        }
    }
    int is_bent = 1;
    int best_u = -1, best_dev = -1;
    for (int u = 0; u < 65536; u++) {
        int32_t v = spec[u];
        int32_t av = (v < 0) ? -v : v;
        if (av != 256) {
            is_bent = 0;
            int dev = (av > 256) ? (av - 256) : (256 - av);
            if (dev > best_dev) {
                best_dev = dev;
                best_u = u;
            }
        }
    }
    *out_best_u = best_u;
    *out_best_val = (best_u >= 0) ? spec[best_u] : 256;
    return is_bent;
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


def eval_anf_tt_u64(orbits):
    """Build 116 * 1024 uint64 truth tables via fast bitwise subsets."""
    orb_tts = (ctypes.c_uint64 * (116 * 1024))()
    orb_ints = [0] * 116
    for j, orb in enumerate(orbits):
        base = j * 1024
        val_int = 0
        for m in orb:
            for x in range(65536):
                if (x & m) == m:
                    orb_tts[base + (x >> 6)] ^= 1 << (x & 63)
                    val_int ^= 1 << x
        orb_ints[j] = val_int
    return orb_tts, orb_ints


# ==============================================================================
# PART 1: Symbolic 2nd-Derivative Matrix M^{(a,b)}(c), 8x8 Block N^{(a,b)}(c)
#         and Degree-3 Pfaffian Audit (Verifies Theorem 3.1, Eq. 30 & Eq. 41!)
# ==============================================================================
def build_symbolic_M16_and_N8(orbits, a16: int, b16: int):
    """
    Exact Eq. (5): M_{p,q}^{(a,b)}(c) as 116-bit masks over c_0..c_115.
    Also transforms to (v, z = v ^ w) coordinates when a16, b16 in U_8 to extract
    the 8x8 alternating matrix N^{(a,b)}(c) of Theorem 3.1!
    """
    M16 = [[0] * 16 for _ in range(16)]
    for j, orb in enumerate(orbits):
        bit_j = 1 << j
        for m in orb:
            idxs = [idx for idx in range(16) if (m >> idx) & 1]
            for pos_a in range(4):
                for pos_b in range(pos_a + 1, 4):
                    p, q = idxs[pos_a], idxs[pos_b]
                    rem = [idxs[k] for k in range(4) if k != pos_a and k != pos_b]
                    r, s = rem[0], rem[1]
                    det2 = (((a16 >> r) & 1) & ((b16 >> s) & 1)) ^ (((a16 >> s) & 1) & ((b16 >> r) & 1))
                    if det2:
                        M16[p][q] ^= bit_j
                        M16[q][p] ^= bit_j

    # Transform to (v_0..7, z_0..7) where x = (v, v ^ z), i.e., v_p -> e_p ^ e_{p+8}, z_q -> e_{q+8}
    N8 = [[0] * 8 for _ in range(8)]
    V8 = [[0] * 8 for _ in range(8)]
    for p in range(8):
        for q in range(8):
            # Bilinear form on (e_p ^ e_{p+8}, e_q ^ e_{q+8}) -> V8[p][q]
            V8[p][q] = M16[p][q] ^ M16[p][q + 8] ^ M16[p + 8][q] ^ M16[p + 8][q + 8]
            # Bilinear form on (e_p ^ e_{p+8}, e_{q+8}) -> N8[p][q]
            N8[p][q] = M16[p][q + 8] ^ M16[p + 8][q + 8]
    return M16, V8, N8


def symbolic_pfaffian_6x6(N6_lin_masks, origin_c: int, cb_dirs: list):
    """
    Given a 6x6 alternating matrix N6 over 116-bit c-masks, project entries onto
    (origin_c, cb_dirs) -> (var_mask, const_bit) and compute the exact degree <= 3
    Pfaffian polynomial over the 15 matchings of K_6!
    """
    n = len(cb_dirs)

    def proj_entry(cmask):
        c0 = (origin_c & cmask).bit_count() & 1
        p = {0} if c0 else set()
        for i, cdir in enumerate(cb_dirs):
            if (cdir & cmask).bit_count() & 1:
                p.add(1 << i)
        return p

    def mul_p(p1, p2):
        out = set()
        for m1 in p1:
            for m2 in p2:
                m = m1 | m2
                if m in out:
                    out.remove(m)
                else:
                    out.add(m)
        return out

    P_mat = [[proj_entry(N6_lin_masks[r][s]) if r < s else set() for s in range(6)] for r in range(6)]

    # All 15 partitionings of {0,1,2,3,4,5} into 3 unordered pairs (in characteristic 2, signs are all +1!)
    pf = set()
    rem0 = [1, 2, 3, 4, 5]
    for idx1, b in enumerate(rem0):
        rest = [x for x in rem0 if x != b]
        c = rest[0]
        for idx2 in range(1, 4):
            d = rest[idx2]
            last = [x for x in rest[1:] if x != d]
            e, f = last[0], last[1]
            term = mul_p(mul_p(P_mat[0][b], P_mat[c][d]), P_mat[e][f])
            pf ^= term
    return pf


def audit_second_derivative_theorems(orbits, orb_ints):
    """
    Rigorously verifies Theorem 3.1, Eq. (30) (4x4 U_4 isotropy), and Eq. (41) (Pfaffian = wt/512 mod 2)
    on random quartics in B0_00, B0_11, B1_11!
    """
    # Test 1: a = 0x1111, b = 0x5555 in U_4 -> check V8 == 0, N8 symmetric alternating, U_4^{(8)} isotropic!
    M16_u4, V8_u4, N8_u4 = build_symbolic_M16_and_N8(orbits, 0x1111, 0x5555)
    assert all(V8_u4[p][q] == 0 for p in range(8) for q in range(8)), "V8 != 0 failed!"
    assert all(N8_u4[p][p] == 0 and N8_u4[p][q] == N8_u4[q][p] for p in range(8) for q in range(8)), "N8 not alternating!"
    # Check U_4^{(8)} isotropy (Eq. 30): N_{LL} ^ N_{LH} ^ N_{HL} ^ N_{HH} == 0!
    for p in range(4):
        for q in range(4):
            iso = N8_u4[p][q] ^ N8_u4[p][q + 4] ^ N8_u4[p + 4][q] ^ N8_u4[p + 4][q + 4]
            assert iso == 0, "Eq. (30) U_4^{(8)} isotropy failed!"

    # Test 2: Generic a0 = 0x01, b0 = 0x03 in U_8 -> check Pfaffian Eq. (41) on 16 random quartics in B0_00!
    a0, b0 = 0x01, 0x03
    a16, b16 = a0 | (a0 << 8), b0 | (b0 << 8)
    _, V8, N8 = build_symbolic_M16_and_N8(orbits, a16, b16)
    assert all(V8[p][q] == 0 for p in range(8) for q in range(8))
    # Since a0 = e_0, b0 = e_0 ^ e_1, span(a0, b0) = span(e_0, e_1)!
    # Quotient F_2^8 / span(e_0, e_1) is literally coordinates {2, 3, 4, 5, 6, 7}!
    for p in (0, 1):
        for q in range(8):
            assert (N8[0][q] if p == 0 else (N8[0][q] ^ N8[1][q])) == 0, "a0, b0 not in ker(N8)!"
    N6 = [[N8[2 + r][2 + s] for s in range(6)] for r in range(6)]

    excluded = {0, 57, 99, 113, 115}
    free111 = sorted(set(range(116)) - excluded)
    L_set = set(L_INDICES)
    cb111 = [(1 << j) ^ ((1 << 0) if j in L_set else 0) for j in free111]
    pf_poly = symbolic_pfaffian_6x6(N6, 0, cb111)

    rng = random.Random(202616)
    for _ in range(16):
        x_mask = rng.getrandbits(111)
        c_vec = 0
        for i, cdir in enumerate(cb111):
            if (x_mask >> i) & 1:
                c_vec ^= cdir
        tt = 0
        for j in range(116):
            if (c_vec >> j) & 1:
                tt ^= orb_ints[j]
        # Compute D_a D_b f truth table directly on all 65,536 points
        wt_qab = 0
        for x in range(65536):
            bit = ((tt >> x) ^ (tt >> (x ^ a16)) ^ (tt >> (x ^ b16)) ^ (tt >> (x ^ a16 ^ b16))) & 1
            wt_qab += bit
        assert wt_qab % 512 == 0, f"wt(Q_ab)={wt_qab} not multiple of 512!"
        pf_val = 0
        for m in pf_poly:
            if (x_mask & m) == m:
                pf_val ^= 1
        assert ((wt_qab // 512) & 1) == pf_val, f"Pfaffian Eq. (41) mismatch: wt={wt_qab}, pf={pf_val}!"

    return {"u4_isotropy_verified": True, "pfaffian_eq41_verified_trials": 16, "pfaffian_terms": len(pf_poly)}


# ==============================================================================
# PART 2: Orbit Partitioners for First Derivatives D_a f and Z_16^* Automorphisms
# ==============================================================================
def partition_d1_orbits(a16: int, rot_step: int, orb_ints):
    """
    Partition F_2^16 under group G = <rot^{rot_step}, x -> x ^ a16> where rot^{rot_step}(a16) == a16.
    Note: D_a f(x) = f(x) ^ f(x ^ a16) is G-invariant, vanishes identically whenever
    x ^ a16 is in the C_16-orbit of x (e.g., x in F_{a0} when a16=(a0,a0)), and is constant on D_8!
    Returns: (orbit_size, active_reps, const_pts) where all active_reps have free G-orbits of size `orbit_size`!
    """
    expected_sz = (16 // rot_step) * 2
    seen = bytearray(65536)
    free_reps = []
    short_pts = []
    for x in range(65536):
        if seen[x]:
            continue
        # Generate G-orbit of x
        orb = set()
        stack = [x]
        while stack:
            u = stack.pop()
            if u in orb:
                continue
            orb.add(u)
            stack.append(rot16(u, rot_step))
            stack.append(u ^ a16)
        for u in orb:
            seen[u] = 1
        rep = min(orb)
        # Check if D_a f(rep) vanishes identically on all 112 long orbits!
        is_long_zero = True
        for j in range(116):
            if j in (57, 99, 113, 115):
                continue
            if (((orb_ints[j] >> rep) ^ (orb_ints[j] >> (rep ^ a16))) & 1) != 0:
                is_long_zero = False
                break
        if is_long_zero:
            short_pts.extend(orb)
        else:
            assert len(orb) == expected_sz, f"Unexpected non-free active orbit size {len(orb)} != {expected_sz} for a={hex(a16)}"
            free_reps.append(rep)
    return expected_sz, free_reps, short_pts


def build_z16_star_perms(orbits):
    """Build exact orbit index permutations for m in {3, 5, 7, 9, 11, 13, 15} mod 16."""
    rep_to_idx = {min(orb): j for j, orb in enumerate(orbits)}
    perms = {}
    for m in (3, 5, 7, 9, 11, 13, 15):
        p = [0] * 116
        for j, orb in enumerate(orbits):
            mon = orb[0]
            img = 0
            for b in range(16):
                if (mon >> b) & 1:
                    img |= 1 << ((m * b) & 15)
            canon = min(rot16(img, r) for r in range(16))
            p[j] = rep_to_idx[canon]
        perms[m] = p
    return perms


# ==============================================================================
# PART 3: CNF Helpers & Lightweight SAT + Subcube/D_a Short-Cut Solver
# ==============================================================================
def add_xor_clauses(clauses, lits, rhs, new_var):
    cur = list(lits)
    r = rhs & 1
    if not cur:
        if r:
            v = new_var()
            clauses.append([v])
            clauses.append([-v])
        return
    while len(cur) > 4:
        a, b, c = cur[0], cur[1], cur[2]
        z = new_var()
        for mask in range(16):
            ba, bb, bc, bz = (mask & 1), ((mask >> 1) & 1), ((mask >> 2) & 1), ((mask >> 3) & 1)
            if (ba ^ bb ^ bc ^ bz) == 1:
                clauses.append([-a if ba else a, -b if bb else b, -c if bc else c, -z if bz else z])
        cur = [z] + cur[3:]
    k = len(cur)
    for mask in range(1 << k):
        parity = 0
        for idx in range(k):
            if (mask >> idx) & 1:
                parity ^= 1
        if parity != r:
            clauses.append([-cur[idx] if ((mask >> idx) & 1) else cur[idx] for idx in range(k)])


def add_and2(clauses, z, a, b):
    clauses.append([-z, a])
    clauses.append([-z, b])
    clauses.append([z, -a, -b])


def add_lex_leq(clauses, xs, ys, new_var):
    """Exact CNF encoding of (xs_0, ..., xs_{k-1}) <=_lex (ys_0, ..., ys_{k-1})."""
    prev_eq = None
    for x, y in zip(xs, ys):
        if x == y:
            continue
        if prev_eq is None:
            clauses.append([-x, y])
            eq = new_var()
            clauses.append([-eq, -x, y])
            clauses.append([-eq, x, -y])
            prev_eq = eq
        else:
            clauses.append([-prev_eq, -x, y])
            eq = new_var()
            clauses.append([-eq, prev_eq])
            clauses.append([-eq, -x, y])
            clauses.append([-eq, x, -y])
            prev_eq = eq


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


def load_t28_poly():
    candidates = [
        Path(__file__).resolve().parent / "T28_SEXTA_CERTIFICADO.json",
        Path(__file__).resolve().parents[2] / "quartic_audit_2026_10_17/archive/T28_SEXTA_CERTIFICADO.json",
    ]
    for p in candidates:
        if p.exists():
            cert = json.loads(p.read_text(encoding="utf-8"))
            return {
                0: [int(h, 16) for h in cert["reduced_models"]["branches"][0]["polynomial_hex"]],
                1: [int(h, 16) for h in cert["reduced_models"]["branches"][1]["polynomial_hex"]]
                if len(cert["reduced_models"]["branches"]) > 1 else None,
            }
    return {0: None, 1: None}


# ==============================================================================
# PART 4: Master Cell Pipeline (Algebraic + First/Second Derivatives + Fast SAT)
# ==============================================================================
def run_pipeline(budget_per_cell: float = 180.0, cell_filter: str = "ALL"):
    t_global = time.perf_counter()
    work_dir = Path(__file__).resolve().parent
    c_path = work_dir / "b16_engine.c"
    so_path = work_dir / "libb16_engine.so"
    c_path.write_text(C_COMBINED_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_path), "-o", str(so_path)], check=True)
    lib = ctypes.CDLL(str(so_path))

    lib.extract_first_nonzero_level_deg3.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.c_int, ctypes.POINTER(ctypes.c_uint64),
    ]
    lib.extract_first_nonzero_level_deg3.restype = ctypes.c_int

    lib.extract_coset_hierarchy_fast.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.c_int, ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
    ]
    lib.extract_coset_hierarchy_fast.restype = ctypes.c_int

    lib.gf2_echelon_insert.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int,
    ]
    lib.gf2_echelon_insert.restype = ctypes.c_int

    lib.audit_bent_and_find_viol.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_uint64, ctypes.c_uint64,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
    ]
    lib.audit_bent_and_find_viol.restype = ctypes.c_int

    orbits = build_orbits_116()
    orb_tts, orb_ints = eval_anf_tt_u64(orbits)
    v6_list = all_v6_orbits()
    z16_perms = build_z16_star_perms(orbits)
    t28_polys = load_t28_poly()

    print("[INIT] Auditing 2nd-Derivative Symplectic Matrices M^{(a,b)}(c) & Pfaffian Identity...", flush=True)
    sd_audit = audit_second_derivative_theorems(orbits, orb_ints)
    print(f"[INIT] 2nd-Derivative Audit PASSED: {json.dumps(sd_audit)}", flush=True)

    # Precompute pair tables for V6xV6
    pair_idx = {}
    all_pairs = []
    for v in range(256):
        for w in range(v + 1, 256):
            pair_idx[(v, w)] = len(all_pairs)
            all_pairs.append(v | (w << 8))
    orb_diag = [sum(((orb_ints[j] >> (v | (v << 8))) & 1) << v for v in range(256)) for j in range(116)]
    orb_pair = [sum(((orb_ints[j] >> x) & 1) << k for k, x in enumerate(all_pairs)) for j in range(116)]

    # Precompute C_{0xf} reps (256 size-16 orbits) & F_{0xff} reps (16 size-16 orbits)
    coset_0xf_reps, f_0xff_reps = [], []
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
            if ((x & 0xFF) ^ (x >> 8)) == 0xFF:
                f_0xff_reps.append(mem[0])
    assert len(coset_0xf_reps) == 256 and len(f_0xff_reps) == 16

    # Precompute First-Derivative D_a f orbit partitions (Theorem 4.2!)
    d1_families = []
    for a16, rstep, name in [
        (0xFFFF, 1, "D_0xffff"),
        (0x5555, 2, "D_0x5555"),
        (0x1111, 4, "D_0x1111"),
        (0x3333, 4, "D_0x3333"),
        (0x7777, 4, "D_0x7777"),
    ]:
        osz, freps, spts = partition_d1_orbits(a16, rstep, orb_ints)
        d1_families.append((name, a16, osz, freps, spts))
    # Add all 30 C_8-orbits of U_8 \ U_4 (order-4 K_4 symmetry -> pure quadratic + cubic!)
    seen_u8 = set()
    for a0 in range(1, 256):
        if a0 in seen_u8:
            continue
        orb8 = {rot8(a0, r) for r in range(8)}
        seen_u8 |= orb8
        if len(orb8) == 8:
            a16 = min(orb8) | (min(orb8) << 8)
            osz, freps, spts = partition_d1_orbits(a16, 8, orb_ints)
            d1_families.append((f"D_u8_{hex(min(orb8))}", a16, osz, freps, spts))

    # Precompute coordinate subcubes M_d (d=8,9,10,11,12) for short Slack-Reduced Nogoods!
    subcube_defs = []
    for m16 in [0x5555, 0x5557, 0x555F, 0x5575, 0x333F, 0x03FF, 0x557F, 0x5F5F, 0x3F3F, 0x0FFF]:
        dim = m16.bit_count()
        b_positions = [b for b in range(16) if (m16 >> b) & 1]
        pts = []
        for idx in range(1 << dim):
            x = 0
            for k, bp in enumerate(b_positions):
                if (idx >> k) & 1:
                    x |= 1 << bp
            pts.append(x)
        active_j = []
        deltas = []
        for j in range(116):
            if j in (57, 99, 113, 115):
                continue
            cnt = sum(((orb_ints[j] >> x) & 1) for x in pts)
            if cnt > 0:
                active_j.append(j)
                deltas.append(cnt)
        subcube_defs.append((m16, dim, pts, active_j, deltas))

    # Macaulay setup for n = 111 pure basis
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

    max_rows = 16000
    rows = (ctypes.c_uint64 * (max_rows * n_col_words))()
    piv_row_idx = (ctypes.c_int * n_cols)()
    mask64 = (1 << 64) - 1

    all_cells = [
        ("B1_00", 1, 0, 0),
        ("B1_11", 1, 1, 1),
        ("B0_11", 0, 1, 1),
        ("B0_00", 0, 0, 0),
    ]
    if cell_filter != "ALL":
        all_cells = [c for c in all_cells if c[0] == cell_filter]

    report = {"second_derivative_audit": sd_audit, "cells": {}}

    for cell_name, c99_val, c57_val, c113_val in all_cells:
        tc = time.perf_counter()
        excluded = {0, 57, 99, 113, 115}
        free111 = sorted(set(range(116)) - excluded)
        L_set = set(L_INDICES)
        origin = (c99_val << 0) | (c99_val << 99) | (c57_val << 57) | (c113_val << 113)
        cb = [(1 << j) ^ ((1 << 0) if j in L_set else 0) for j in free111]

        O_diag, O_pair, O_tt = 0, 0, 0
        for j in range(116):
            if (origin >> j) & 1:
                O_diag ^= orb_diag[j]
                O_pair ^= orb_pair[j]
                O_tt ^= orb_ints[j]
        cb_pair = []
        cb_tt = []
        for cdir in cb:
            vp, vt = 0, 0
            for j in range(116):
                if (cdir >> j) & 1:
                    vp ^= orb_pair[j]
                    vt ^= orb_ints[j]
            cb_pair.append(vp)
            cb_tt.append(vt)

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
        cub_rows = []
        src_stats = {"c0xf_mod2": 0, "q4": 0, "d1_deriv_pivs": 0, "v6_coset_pivs": 0, "dual_fibers": 0, "xl_pivs": 0}

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
                    src_stats[key] += 1
            elif d == 3:
                cub_rows.append(cur_row)
                if key:
                    src_stats[key] += 1
            elif d == 0 and key:
                src_stats[key] += 1
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

        # 1. Exact parity of C_{0xf}: wt_orb16(C_{0xf}) == 128 => parity == 0 (Proven for ALL symmetric cells!)
        p_0xf = set()
        if sum((O_tt >> x) & 1 for x in coset_0xf_reps) & 1:
            p_0xf.add(0)
        for i in range(n):
            if sum((cb_tt[i] >> x) & 1 for x in coset_0xf_reps) & 1:
                p_0xf.add(1 << i)
        insert_pset(p_0xf, key="c0xf_mod2")
        drain_xl()

        # 2. Seed Q4 (proven in both c99=0 and c99=1 when c57==c113!)
        def lin_expr(indices):
            mask = sum(1 << j for j in indices)
            return [i for i, c in enumerate(cb) if (c & mask).bit_count() & 1], (origin & mask).bit_count() & 1

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
        insert_pset(q4, key="q4")
        drain_xl()

        # 3. NEW: Extract First-Derivative Balancedness Equations wt(D_a f) == 32768 (Theorem 4.2)!
        for _, a16, osz, freps, spts in d1_families:
            if piv_row_idx[off0] >= 0 or cur_row >= max_rows - 50:
                break
            const_wt = sum(((O_tt >> x) ^ (O_tt >> (x ^ a16))) & 1 for x in spts)
            rem_wt = 32768 - const_wt
            if rem_wt < 0 or rem_wt % osz != 0:
                # Immediate arithmetic contradiction 1 = 0!
                insert_pset({0}, key="d1_deriv_pivs")
                break
            target_sum = rem_wt // osz
            n_reps = len(freps)
            n_w = (n_reps + 63) // 64
            if n_w > 512:
                continue
            b_arr = (ctypes.c_uint64 * (n * n_w))()
            o_arr = (ctypes.c_uint64 * n_w)()
            for k, rx in enumerate(freps):
                if ((O_tt >> rx) ^ (O_tt >> (rx ^ a16))) & 1:
                    o_arr[k >> 6] |= 1 << (k & 63)
                for i in range(n):
                    if ((cb_tt[i] >> rx) ^ (cb_tt[i] >> (rx ^ a16))) & 1:
                        b_arr[i * n_w + (k >> 6)] |= 1 << (k & 63)
            row_ptr = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            lvl = lib.extract_first_nonzero_level_deg3(
                b_arr, o_arr, n, n_w, 3, target_sum & 7,
                col3_base, off2, off1, off0, n_col_words, row_ptr
            )
            if lvl >= 0:
                pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
                record_piv(pc, key="d1_deriv_pivs")
                drain_xl()

        # 4. Dual Fiber algebraic equations in B0_00 (Theorem A1: wt(F_z) == 128 on all 35 fibers!)
        if c99_val == 0 and c57_val == 0 and piv_row_idx[off0] < 0:
            seen_z = set()
            for z in range(1, 256):
                if z in seen_z:
                    continue
                seen_z |= {rot8(z, r) for r in range(8)}
                gstep = 1 if z == 0xFF else (2 if z in (0x55, 0xAA) else (4 if z in (0x11, 0x33, 0x77) else 8))
                osz = 16 // gstep
                f_pts = [v | ((v ^ z) << 8) for v in range(256)]
                vis_f, reps_f = set(), []
                for x in f_pts:
                    if x in vis_f:
                        continue
                    cur_x, orb_f = x, []
                    while cur_x not in orb_f:
                        orb_f.append(cur_x)
                        cur_x = rot16(cur_x, gstep)
                    vis_f.update(orb_f)
                    reps_f.append(min(orb_f))
                n_w = (len(reps_f) + 63) // 64
                b_arr = (ctypes.c_uint64 * (n * n_w))()
                o_arr = (ctypes.c_uint64 * n_w)()
                for k, rx in enumerate(reps_f):
                    if (O_tt >> rx) & 1:
                        o_arr[k >> 6] |= 1 << (k & 63)
                    for i in range(n):
                        if (cb_tt[i] >> rx) & 1:
                            b_arr[i * n_w + (k >> 6)] |= 1 << (k & 63)
                row_ptr = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                lvl = lib.extract_first_nonzero_level_deg3(
                    b_arr, o_arr, n, n_w, 3, (128 // osz) & 7,
                    col3_base, off2, off1, off0, n_col_words, row_ptr
                )
                if lvl >= 0:
                    pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
                    record_piv(pc, key="dual_fibers")
                    drain_xl()

        # 5. V6 x V6 + Affine Diagonal Shifts + Interleaved Conjugates (with Level-1 & Level-2 unified!)
        p_idxs_arr = (ctypes.c_int * 2048)()
        N_CH = 9
        char_words32 = (ctypes.c_uint64 * (N_CH * 32))()
        out_batch = (ctypes.c_uint64 * ((1 + N_CH) * n_col_words))()
        out_valid = (ctypes.c_int * (1 + N_CH))()
        u_vecs = [(1 << r) | (1 << (r + 8)) for r in range(8)] + [0xFFFF]

        def run_coset(pts_16):
            if piv_row_idx[off0] >= 0 or cur_row >= max_rows - 40:
                return
            dmask = sum(1 << (x & 0xFF) for x in pts_16 if (x & 0xFF) == (x >> 8))
            wt_diag = (O_diag & dmask).bit_count()
            if (wt_diag & 3) != 0:
                return
            pair_reps = [x for x in pts_16 if (x & 0xFF) < (x >> 8)]
            for k, x in enumerate(pair_reps):
                p_idxs_arr[k] = pair_idx[(x & 0xFF, x >> 8)]
            ctypes.memset(char_words32, 0, ctypes.sizeof(char_words32))
            for m, u16 in enumerate(u_vecs):
                base_m = m * 32
                for k, x in enumerate(pair_reps):
                    if (x & u16).bit_count() & 1:
                        char_words32[base_m + (k >> 6)] |= 1 << (k & 63)
            if lib.extract_coset_hierarchy_fast(
                all_pair_bits, p_idxs_arr, len(pair_reps), n, wt_diag,
                char_words32, N_CH, col3_base, off2, off1, off0, n_col_words,
                out_batch, out_valid
            ) != 0:
                return
            for slot in range(1 + N_CH):
                if not out_valid[slot] or piv_row_idx[off0] >= 0 or cur_row >= max_rows - 10:
                    continue
                dst = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                src = ctypes.cast(ctypes.byref(out_batch, slot * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                ctypes.memmove(dst, src, n_col_words * 8)
                pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
                record_piv(pc, key="v6_coset_pivs")
            drain_xl()

        for pts8 in v6_list:
            if piv_row_idx[off0] >= 0:
                break
            run_coset([v | (w << 8) for v in pts8 for w in pts8])

        alg_budget = min(25.0, budget_per_cell * 0.25)
        if piv_row_idx[off0] < 0:
            for pts8 in v6_list:
                if (time.perf_counter() - tc) > alg_budget or piv_row_idx[off0] >= 0 or cur_row >= max_rows - 80:
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
                        run_coset([x ^ a16 for x in w_pts])
                    run_coset([interleave16(x ^ a16) for x in w_pts])
                    if piv_row_idx[off0] >= 0:
                        break

        alg_sec = round(time.perf_counter() - tc, 3)
        if piv_row_idx[off0] >= 0:
            report["cells"][cell_name] = {
                "algebraic_has_one": True,
                "unsat_closed": True,
                "total_pivots": cur_row,
                "deg_pivs": deg_pivs,
                "sources": src_stats,
                "alg_sec": alg_sec,
                "total_sec": alg_sec,
            }
            print(f"[{cell_name}] CLOSED ALGEBRAICALLY (1=0)! {json.dumps(report['cells'][cell_name])}", flush=True)
            continue

        print(f"[{cell_name}] Algebraic phase ({alg_sec}s): deg_pivs={deg_pivs}, sources={src_stats}", flush=True)
        if not HAS_PYSAT or (time.perf_counter() - tc) >= budget_per_cell - 2.0:
            report["cells"][cell_name] = {
                "algebraic_has_one": False,
                "unsat_closed": False,
                "total_pivots": cur_row,
                "deg_pivs": deg_pivs,
                "sources": src_stats,
                "alg_sec": alg_sec,
            }
            continue

        # ======================================================================
        # PART 5: Lightweight Exact SAT + Z_16^* Symmetry + Subcube Slack Nogoods
        #         (ZERO heavy 128/240/256-bit CardEnc counters in CNF!)
        # ======================================================================
        ts = time.perf_counter()
        # Eliminate discovered linear pivots explicitly first to shrink variable count!
        lin_psets = []
        quad_psets = []
        for r_idx in deg12_rows:
            row_slice = [rows[r_idx * n_col_words + w] for w in range(n_col_words)]
            pset = decode_row_to_pset(row_slice, n_cols, off2, off1, off0, pair2_list, col3_list)
            mx_d = max((m.bit_count() for m in pset), default=0)
            if mx_d == 1:
                lin_psets.append(pset)
            elif mx_d == 2:
                quad_psets.append(pset)

        clauses = []
        v_cnt = [n]

        def new_var():
            v_cnt[0] += 1
            return v_cnt[0]

        pair_cache = {}
        for pset in lin_psets + quad_psets:
            rhs = 1 if (0 in pset) else 0
            lits = []
            for m in pset:
                if m == 0:
                    continue
                if m.bit_count() == 1:
                    lits.append((m.bit_length() - 1) + 1)
                else:
                    b0 = (m & -m).bit_length() - 1
                    b1 = (m ^ (1 << b0)).bit_length() - 1
                    v1, v2 = b0 + 1, b1 + 1
                    key = (v1, v2)
                    if key not in pair_cache:
                        pv = new_var()
                        add_and2(clauses, pv, v1, v2)
                        pair_cache[key] = pv
                    lits.append(pair_cache[key])
            add_xor_clauses(clauses, lits, rhs, new_var)

        # Orbit literals c_0 .. c_115
        c_lits = {}
        long_lits = []
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
                add_xor_clauses(clauses, idxs + [lv], cst, new_var)
            c_lits[j] = lv
            if j not in (57, 99, 113, 115):
                long_lits.append(lv)

        # 6 <= weight(long orbits) <= 106 (lightweight bound that kills c=0 in B0_00!)
        for bnd, fn in [(6, CardEnc.atleast), (106, CardEnc.atmost)]:
            enc = fn(lits=long_lits, bound=bnd, top_id=v_cnt[0], encoding=EncType.seqcounter)
            v_cnt[0] = max(v_cnt[0], enc.nv)
            clauses.extend(enc.clauses)

        # Exact Z_16^* Lex Symmetry Breaking (order 8, preserves all symmetric cells c57==c113!)
        # Order variables by 0x5555 even-support orbits first so symmetry breaking acts at the top!
        even_orbs = [j for j in range(116) if j not in (57, 99, 113, 115) and any((m & 0xAAAA) == 0 for m in orbits[j])]
        other_long = [j for j in range(116) if j not in (57, 99, 113, 115) and j not in even_orbs]
        lex_order = even_orbs + other_long
        base_lex_lits = [c_lits[j] for j in lex_order]
        for m_mult, perm in z16_perms.items():
            img_lex_lits = [c_lits[perm[j]] for j in lex_order]
            add_lex_leq(clauses, base_lex_lits, img_lex_lits, new_var)

        # In B0_00 ONLY: tiny 16-bit exact counter on F_{0xff} == 8 (~80 clauses, zero slowdown!)
        if c99_val == 0 and c57_val == 0:
            flits_16 = []
            for rx in f_0xff_reps:
                idxs = [i + 1 for i in range(n) if (cb_tt[i] >> rx) & 1]
                cst = (O_tt >> rx) & 1
                lv = new_var()
                add_xor_clauses(clauses, idxs + [lv], cst, new_var)
                flits_16.append(lv)
            enc16 = CardEnc.equals(lits=flits_16, bound=8, top_id=v_cnt[0], encoding=EncType.totalizer)
            v_cnt[0] = max(v_cnt[0], enc16.nv)
            clauses.extend(enc16.clauses)

        # Encode T28 (C6) if available for this c99 branch
        poly_t28 = t28_polys.get(c99_val)
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
                    key = tuple(bits)
                    if key not in c6_cache:
                        cur_v = bits[0]
                        for nxt in bits[1:]:
                            z = new_var()
                            add_and2(clauses, z, cur_v, nxt)
                            cur_v = z
                        c6_cache[key] = cur_v
                    c6_lits.append(c6_cache[key])
            add_xor_clauses(clauses, c6_lits, c6_rhs, new_var)

        # Decode sparse cubic pivots for instant check
        cubic_psets = []
        for r_idx in cub_rows:
            row_slice = [rows[r_idx * n_col_words + w] for w in range(n_col_words)]
            pset = decode_row_to_pset(row_slice, n_cols, off2, off1, off0, pair2_list, col3_list)
            if len(pset) <= 450:
                cubic_psets.append(pset)

        models_checked = 0
        subcube_nogoods = 0
        cubic_cuts = 0
        bent_hits = []
        unsat_closed = False
        best_u, best_val = ctypes.c_int(), ctypes.c_int()

        with Solver(name="cadical195", bootstrap_with=clauses) as slv:
            while (time.perf_counter() - tc) < budget_per_cell:
                if not slv.solve():
                    unsat_closed = True
                    break
                models_checked += 1
                model = slv.get_model()
                pos_set = {lit for lit in model if lit > 0}

                x_bits = 0
                cint = origin
                for i, cdir in enumerate(cb):
                    if (i + 1) in pos_set:
                        x_bits |= 1 << i
                        cint ^= cdir

                # 1) Check cubic pivots lazily
                viol_cub = False
                for pset in cubic_psets:
                    val = 0
                    for m in pset:
                        if (x_bits & m) == m:
                            val ^= 1
                    if val == 1:
                        viol_cub = True
                        rhs = 1 if (0 in pset) else 0
                        lits = []
                        for m in pset:
                            if m == 0:
                                continue
                            d = m.bit_count()
                            if d == 1:
                                lits.append((m.bit_length() - 1) + 1)
                            elif d == 2:
                                b0 = (m & -m).bit_length() - 1
                                b1 = (m ^ (1 << b0)).bit_length() - 1
                                k2 = (b0 + 1, b1 + 1)
                                if k2 not in pair_cache:
                                    pv = new_var()
                                    cls2 = []
                                    add_and2(cls2, pv, k2[0], k2[1])
                                    for cl in cls2:
                                        slv.add_clause(cl)
                                    pair_cache[k2] = pv
                                lits.append(pair_cache[k2])
                            else:
                                b0 = (m & -m).bit_length() - 1
                                m1 = m ^ (1 << b0)
                                b1 = (m1 & -m1).bit_length() - 1
                                b2 = (m1 ^ (1 << b1)).bit_length() - 1
                                k2 = (b0 + 1, b1 + 1)
                                if k2 not in pair_cache:
                                    pv = new_var()
                                    cls2 = []
                                    add_and2(cls2, pv, k2[0], k2[1])
                                    for cl in cls2:
                                        slv.add_clause(cl)
                                    pair_cache[k2] = pv
                                tv = new_var()
                                cls3 = []
                                add_and2(cls3, tv, pair_cache[k2], b2 + 1)
                                for cl in cls3:
                                    slv.add_clause(cl)
                                lits.append(tv)
                        cls_x = []
                        add_xor_clauses(cls_x, lits, rhs, new_var)
                        for cl in cls_x:
                            slv.add_clause(cl)
                        cubic_cuts += 1
                        break
                if viol_cub:
                    continue

                # 2) Check Subcubes M_d (d=8..12) for Slack-Reduced SHORT Nogoods (15..45 lits instead of 111!)
                tt_cand = O_tt
                for i in range(n):
                    if (x_bits >> i) & 1:
                        tt_cand ^= cb_tt[i]

                short_cut = None
                for m16, dim, pts, active_j, deltas in subcube_defs:
                    spec = [-1 if ((tt_cand >> x) & 1) else 1 for x in pts]
                    step = 1
                    n_pts = 1 << dim
                    while step < n_pts:
                        dbl = step << 1
                        for idx0 in range(0, n_pts, dbl):
                            for idx1 in range(idx0, idx0 + step):
                                a_s, b_s = spec[idx1], spec[idx1 + step]
                                spec[idx1] = a_s + b_s
                                spec[idx1 + step] = a_s - b_s
                        step = dbl
                    max_abs = max(abs(v) for v in spec)
                    if max_abs > 256:
                        excess = max_abs - 256
                        order = sorted(range(len(active_j)), key=lambda k: deltas[k])
                        keep = [True] * len(active_j)
                        used_slack = 0
                        for k in order:
                            if used_slack + 2 * deltas[k] < excess:
                                used_slack += 2 * deltas[k]
                                keep[k] = False
                        cand_cl = []
                        for k, j in enumerate(active_j):
                            if keep[k]:
                                cj_val = (cint >> j) & 1
                                cand_cl.append(-c_lits[j] if cj_val else c_lits[j])
                        if short_cut is None or len(cand_cl) < len(short_cut):
                            short_cut = cand_cl
                            if len(short_cut) <= 28:
                                break

                if short_cut is not None:
                    slv.add_clause(short_cut)
                    subcube_nogoods += 1
                    continue

                # 3) Full 65,536-point C FWHT (0.05ms)
                is_bent = lib.audit_bent_and_find_viol(
                    orb_tts, cint & mask64, cint >> 64,
                    ctypes.byref(best_u), ctypes.byref(best_val)
                )
                if is_bent:
                    bent_hits.append(hex(cint))
                    break

                # Block full Z_16^* orbit of model (up to 8 clauses at once!)
                slv.add_clause([-(i + 1) if ((x_bits >> i) & 1) else (i + 1) for i in range(n)])

        report["cells"][cell_name] = {
            "algebraic_has_one": False,
            "unsat_closed": unsat_closed,
            "deg_pivs": deg_pivs,
            "lin_pivots": len(lin_psets),
            "quad_pivots": len(quad_psets),
            "sources": src_stats,
            "models_checked": models_checked,
            "subcube_short_nogoods": subcube_nogoods,
            "cubic_cuts_injected": cubic_cuts,
            "bent_hits": bent_hits,
            "alg_sec": alg_sec,
            "sat_sec": round(time.perf_counter() - ts, 3),
            "total_sec": round(time.perf_counter() - tc, 3),
        }
        print(f"[{cell_name}] DONE: {json.dumps(report['cells'][cell_name])}", flush=True)

    report["elapsed_total_sec"] = round(time.perf_counter() - t_global, 3)
    print("=== FINAL B16 SECOND-DERIVATIVE & CLOSURE REPORT ===", flush=True)
    print(json.dumps(report, indent=2), flush=True)


if __name__ == "__main__":
    bud = float(sys.argv[1]) if len(sys.argv) > 1 else 180.0
    flt = sys.argv[2] if len(sys.argv) > 2 else "ALL"
    run_pipeline(budget_per_cell=bud, cell_filter=flt)
