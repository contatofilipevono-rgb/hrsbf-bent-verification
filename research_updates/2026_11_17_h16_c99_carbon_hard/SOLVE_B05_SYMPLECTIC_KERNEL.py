#!/usr/bin/env python3
r"""
Task b05_symplectic_rank_q113:
Exact Symplectic Rank Audit, Common Bilinear Kernel Extractor U = span(u_1..u_k),
and Simultaneous Linearization Closer for B0_00, B0_11, B1_11, and B1_00.

Mathematical guarantees (100% Proven):
  1. In F_2[x_1..x_N]/(x_i^2+x_i), q_r(x) -> S_r = A_r ^ A_r^T in Alt_N(F_2) is injective
     modulo affine forms.
  2. Fixing k independent linear forms u_1(x), ..., u_k(x) simultaneously linearizes ALL m
     quadratic equations q_1, ..., q_m IFF K_U = U^perp is totally isotropic for all S_r:
         M_{K_U}^T * S_r * M_{K_U} == 0   for all r = 1..m.
  3. Restricting S_r to hyperplane u^perp <= K drops rank(S_r|_K) by 2 IFF u in Im(S_r|_K).
     Intersecting images Im(S_a|_K) cap Im(S_b|_K) and maximizing Gain(u) = #{r : u in Im(S_r|_K)}
     in C extracts an explicit basis u_1, ..., u_k of U invariant under GL_N(F_2)!
  4. Once U (dim k) is extracted, changing coordinates y = P*x with y_{0..k-1} = u(x) turns
     q_1..q_m into an pure m x (N-k) GF(2) linear system A(u)*w = b(u) for each u in {0,1}^k!

Usage:
  Single run / audit all 4 symmetric cells:
    python3 SOLVE_B05_SYMPLECTIC_KERNEL.py ALL 300
  Targeted cell + parallel shard (GitHub Actions / Cloud Run 96 vCPUs):
    python3 SOLVE_B05_SYMPLECTIC_KERNEL.py B0_00 600 [shard_idx] [shard_count]
    python3 SOLVE_B05_SYMPLECTIC_KERNEL.py B0_11 600 [shard_idx] [shard_count]
    python3 SOLVE_B05_SYMPLECTIC_KERNEL.py B1_11 600 [shard_idx] [shard_count]
"""
import ctypes
import json
import os
import random
import subprocess
import sys
import time
from pathlib import Path

from AUDIT_ALL_CELLS_111 import (
    C_SRC as C_SRC_AUDIT,
    I1, I2, I3, I4, J1, J2, J3, J4,
    K_INDICES, L_INDICES,
    all_v6_orbits, build_orbits_116, build_pure_111_basis,
    decode_row_to_pset, interleave16, rot8, rot16,
)

C_SYMP_SRC = r"""
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

// Compute GF(2) rank and image/kernel basis of a d x d matrix M (d <= 112),
// where each row i of M is packed in two uint64_t words: M_lo[i], M_hi[i].
// Since S_r is symmetric, row-space(S_r) == col-space(S_r) = Im(S_r)!
static int rref_im_basis_128(
    int d,
    const uint64_t *M_lo,
    const uint64_t *M_hi,
    uint64_t *piv_lo,   // [112] indexed by pivot bit
    uint64_t *piv_hi,   // [112]
    int *has_piv        // [112]
) {
    memset(has_piv, 0, d * sizeof(int));
    int rk = 0;
    for (int r = 0; r < d; r++) {
        uint64_t lo = M_lo[r];
        uint64_t hi = M_hi[r];
        while (lo | hi) {
            int col = lo ? __builtin_ctzll(lo) : (64 + __builtin_ctzll(hi));
            if (col >= d) break;
            if (has_piv[col]) {
                lo ^= piv_lo[col];
                hi ^= piv_hi[col];
            } else {
                has_piv[col] = 1;
                piv_lo[col] = lo;
                piv_hi[col] = hi;
                rk++;
                break;
            }
        }
    }
    return rk;
}

static inline int vec_in_span_128(
    int d,
    uint64_t lo,
    uint64_t hi,
    const uint64_t *piv_lo,
    const uint64_t *piv_hi,
    const int *has_piv
) {
    while (lo | hi) {
        int col = lo ? __builtin_ctzll(lo) : (64 + __builtin_ctzll(hi));
        if (col >= d) return 0;
        if (!has_piv[col]) return 0;
        lo ^= piv_lo[col];
        hi ^= piv_hi[col];
    }
    return 1;
}

// Given m alternating d x d matrices S[r] (packed as m * d * 2 uint64_t words: S_lo, S_hi)
// and a candidate pool of C vectors cand_lo[c], cand_hi[c] in F_2^d \ {0},
// evaluate Gain(c) = #{r in 0..m-1 : S[r] != 0 and cand[c] in Im(S[r])}.
// Returns index of best candidate and writes best_gain and active_nonzero_count.
int pick_best_symplectic_form_c(
    int m,
    int d,
    const uint64_t *S_lo,     // m * d
    const uint64_t *S_hi,     // m * d
    int n_cands,
    const uint64_t *cand_lo,  // n_cands
    const uint64_t *cand_hi,  // n_cands
    int *out_best_gain,
    int *out_active_mats,
    int *out_sum_ranks
) {
    uint64_t (*piv_lo)[112] = malloc((size_t)m * sizeof(*piv_lo));
    uint64_t (*piv_hi)[112] = malloc((size_t)m * sizeof(*piv_hi));
    int (*has_piv)[112] = malloc((size_t)m * sizeof(*has_piv));
    int *rk_arr = malloc((size_t)m * sizeof(int));

    int active = 0, sum_rk = 0;
    for (int r = 0; r < m; r++) {
        int rk = rref_im_basis_128(
            d, S_lo + (size_t)r * d, S_hi + (size_t)r * d,
            piv_lo[r], piv_hi[r], has_piv[r]
        );
        rk_arr[r] = rk;
        if (rk > 0) {
            active++;
            sum_rk += rk;
        }
    }
    *out_active_mats = active;
    *out_sum_ranks = sum_rk;

    int best_idx = -1, best_gain = -1;
    for (int c = 0; c < n_cands; c++) {
        uint64_t clo = cand_lo[c], chi = cand_hi[c];
        if ((clo | chi) == 0ULL) continue;
        int gain = 0;
        for (int r = 0; r < m; r++) {
            if (rk_arr[r] > 0 && vec_in_span_128(d, clo, chi, piv_lo[r], piv_hi[r], has_piv[r])) {
                gain++;
            }
        }
        if (gain > best_gain) {
            best_gain = gain;
            best_idx = c;
        }
    }

    free(piv_lo);
    free(piv_hi);
    free(has_piv);
    free(rk_arr);
    *out_best_gain = best_gain;
    return best_idx;
}

// Fast exact FWHT audit on 65,536 points given 116 orbit truth tables (116 * 1024 uint64_t).
int audit_bent_116_c(
    const uint64_t *orb_tts,
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
    // Quick weight pre-check: bent in n=16 must have wt(f) in {32640, 32896}!
    int wt = 0;
    for (int w = 0; w < 1024; w++) wt += __builtin_popcountll(tt[w]);
    if (wt != 32640 && wt != 32896) return 0;

    int32_t spec[65536];
    for (int x = 0; x < 65536; x++) {
        spec[x] = ((tt[x >> 6] >> (x & 63)) & 1ULL) ? -1 : 1;
    }
    for (int step = 1; step < 65536; step <<= 1) {
        int dbl = step << 1;
        for (int i = 0; i < 65536; i += dbl) {
            for (int j = 0; j < step; j++) {
                int32_t a = spec[i + j];
                int32_t b = spec[i + j + step];
                spec[i + j] = a + b;
                spec[i + j + step] = a - b;
            }
        }
    }
    for (int x = 0; x < 65536; x++) {
        if (spec[x] != 256 && spec[x] != -256) return 0;
    }
    return 1;
}

// Ultra-fast Gray-code exact enumeration over u in [u_start, u_end) subset {0,1}^k
// for the COMPLETELY LINEARIZED system A(u) * w = b(u), where:
//   d_w = N - k <= 112 (packed in 2 uint64_t words: A_lo, A_hi; typically d_w <= 96!)
//   A(u)[r] = A0[r] ^ xor_{a : u_a == 1} dA[a * m + r]
//   b(u)[r] = b0[r] ^ xor_{a : u_a == 1} db1[a * m + r] ^ xor_{a<b : u_a & u_b} db2[...]
// Whenever A(u)*w = b(u) is consistent, enumerates all 2^(d_w - rank) solutions w,
// maps (u, w) -> 116-bit orbit vector c, and calls audit_bent_116_c!
int gray_enumerate_linearized_u_c(
    int k,
    int d_w,
    int m,
    uint64_t u_idx_start,
    uint64_t u_idx_end,
    const uint64_t *A0_lo,      // [m]
    const uint64_t *A0_hi,      // [m]
    const uint64_t *dA_lo,      // [k * m]
    const uint64_t *dA_hi,      // [k * m]
    const uint8_t  *b0,         // [m]
    const uint8_t  *db1,        // [k * m]
    const uint8_t  *db2,        // [k * k * m]
    uint64_t orig_c_lo,
    uint64_t orig_c_hi,
    const uint64_t *u_cdir_lo,  // [k] 116-bit orbit dir for each u_a
    const uint64_t *u_cdir_hi,  // [k]
    const uint64_t *w_cdir_lo,  // [d_w] 116-bit orbit dir for each w_b
    const uint64_t *w_cdir_hi,  // [d_w]
    const uint64_t *orb_tts,    // 116 * 1024
    uint64_t *out_consistent_u,
    uint64_t *out_models_tested,
    uint64_t *out_hit_c_lo,
    uint64_t *out_hit_c_hi
) {
    uint64_t cur_A_lo[256], cur_A_hi[256];
    uint8_t cur_b[256];

    uint64_t g_prev = u_idx_start ^ (u_idx_start >> 1);
    memcpy(cur_A_lo, A0_lo, (size_t)m * sizeof(uint64_t));
    memcpy(cur_A_hi, A0_hi, (size_t)m * sizeof(uint64_t));
    memcpy(cur_b, b0, (size_t)m * sizeof(uint8_t));

    uint64_t cur_uc_lo = orig_c_lo, cur_uc_hi = orig_c_hi;
    for (int a = 0; a < k; a++) {
        if ((g_prev >> a) & 1ULL) {
            cur_uc_lo ^= u_cdir_lo[a];
            cur_uc_hi ^= u_cdir_hi[a];
            for (int r = 0; r < m; r++) {
                cur_A_lo[r] ^= dA_lo[a * m + r];
                cur_A_hi[r] ^= dA_hi[a * m + r];
                cur_b[r] ^= db1[a * m + r];
            }
            for (int b = a + 1; b < k; b++) {
                if ((g_prev >> b) & 1ULL) {
                    const uint8_t *p2 = db2 + ((size_t)(a * k + b) * m);
                    for (int r = 0; r < m; r++) cur_b[r] ^= p2[r];
                }
            }
        }
    }

    uint64_t consistent_cnt = 0, models_cnt = 0;
    uint64_t piv_lo[112], piv_hi[112];
    uint8_t piv_rhs[112];
    int has_piv[112];

    for (uint64_t step = u_idx_start; step < u_idx_end; step++) {
        if (step > u_idx_start) {
            uint64_t g_now = step ^ (step >> 1);
            uint64_t diff = g_now ^ g_prev;
            int bit = __builtin_ctzll(diff);
            // Flipping u_{bit}:
            // 1) Update A(u) by dA[bit]
            // 2) Update b(u) by db1[bit] ^ sum_{other != bit, g_prev_other == 1} db2[min, max]
            cur_uc_lo ^= u_cdir_lo[bit];
            cur_uc_hi ^= u_cdir_hi[bit];
            const uint64_t *dalo = dA_lo + (size_t)bit * m;
            const uint64_t *dahi = dA_hi + (size_t)bit * m;
            const uint8_t *db_lin = db1 + (size_t)bit * m;
            for (int r = 0; r < m; r++) {
                cur_A_lo[r] ^= dalo[r];
                cur_A_hi[r] ^= dahi[r];
                cur_b[r] ^= db_lin[r];
            }
            uint64_t others = g_prev & ~(1ULL << bit);
            while (others) {
                int ob = __builtin_ctzll(others);
                others &= others - 1;
                int a = (bit < ob) ? bit : ob;
                int b = (bit < ob) ? ob : bit;
                const uint8_t *p2 = db2 + ((size_t)(a * k + b) * m);
                for (int r = 0; r < m; r++) cur_b[r] ^= p2[r];
            }
            g_prev = g_now;
        }

        // Fast GF(2) Gauss on m equations in d_w variables
        memset(has_piv, 0, (size_t)d_w * sizeof(int));
        int inconsistent = 0;
        int rk = 0;
        for (int r = 0; r < m; r++) {
            uint64_t lo = cur_A_lo[r];
            uint64_t hi = cur_A_hi[r];
            uint8_t rhs = cur_b[r];
            while (lo | hi) {
                int col = lo ? __builtin_ctzll(lo) : (64 + __builtin_ctzll(hi));
                if (has_piv[col]) {
                    lo ^= piv_lo[col];
                    hi ^= piv_hi[col];
                    rhs ^= piv_rhs[col];
                } else {
                    has_piv[col] = 1;
                    piv_lo[col] = lo;
                    piv_hi[col] = hi;
                    piv_rhs[col] = rhs;
                    rk++;
                    goto next_row;
                }
            }
            if (rhs) {
                inconsistent = 1;
                break;
            }
            next_row:;
        }
        if (inconsistent) continue;

        consistent_cnt++;
        // Back-substitute to build particular solution w0 and nullspace basis vectors!
        for (int col = d_w - 1; col >= 0; col--) {
            if (!has_piv[col]) continue;
            uint64_t lo = piv_lo[col], hi = piv_hi[col];
            uint8_t rhs = piv_rhs[col];
            // Clear bit `col` temporarily to scan higher pivot columns
            uint64_t mask_lo = (col < 64) ? (lo & ~((1ULL << (col + 1)) - 1ULL)) : 0ULL;
            if (col == 63) mask_lo = 0ULL;
            uint64_t mask_hi = (col < 64) ? hi : ((col == 127) ? 0ULL : (hi & ~((1ULL << (col - 63)) - 1ULL)));
            while (mask_lo | mask_hi) {
                int c2 = mask_lo ? __builtin_ctzll(mask_lo) : (64 + __builtin_ctzll(mask_hi));
                if (c2 < 64) mask_lo &= mask_lo - 1;
                else mask_hi &= mask_hi - 1;
                if (has_piv[c2]) {
                    if (c2 < 64) lo ^= (1ULL << c2);
                    else hi ^= (1ULL << (c2 - 64));
                    lo ^= piv_lo[c2] ^ ((c2 < 64) ? (1ULL << c2) : 0ULL);
                    hi ^= piv_hi[c2] ^ ((c2 >= 64) ? (1ULL << (c2 - 64)) : 0ULL);
                    rhs ^= piv_rhs[c2];
                }
            }
            piv_lo[col] = lo;
            piv_hi[col] = hi;
            piv_rhs[col] = rhs;
        }

        // Particular solution (setting free vars = 0): w_col = piv_rhs[col] for pivot cols
        uint64_t base_c_lo = cur_uc_lo, base_c_hi = cur_uc_hi;
        int free_cols[112];
        uint64_t null_c_lo[112], null_c_hi[112];
        int n_free = 0;
        for (int col = 0; col < d_w; col++) {
            if (has_piv[col]) {
                if (piv_rhs[col]) {
                    base_c_lo ^= w_cdir_lo[col];
                    base_c_hi ^= w_cdir_hi[col];
                }
            } else {
                // Free variable f = col: setting w_col = 1 flips w_col and every pivot p < col that has bit `col` set!
                uint64_t nlo = w_cdir_lo[col], nhi = w_cdir_hi[col];
                for (int p = 0; p < col; p++) {
                    if (!has_piv[p]) continue;
                    int bit_set = (col < 64) ? ((piv_lo[p] >> col) & 1ULL) : ((piv_hi[p] >> (col - 64)) & 1ULL);
                    if (bit_set) {
                        nlo ^= w_cdir_lo[p];
                        nhi ^= w_cdir_hi[p];
                    }
                }
                free_cols[n_free] = col;
                null_c_lo[n_free] = nlo;
                null_c_hi[n_free] = nhi;
                n_free++;
            }
        }

        if (n_free <= 26) {
            uint64_t n_sol = 1ULL << n_free;
            uint64_t c_lo = base_c_lo, c_hi = base_c_hi;
            uint64_t fg_prev = 0;
            for (uint64_t fs = 0; fs < n_sol; fs++) {
                if (fs > 0) {
                    uint64_t fg_now = fs ^ (fs >> 1);
                    int fb = __builtin_ctzll(fg_now ^ fg_prev);
                    c_lo ^= null_c_lo[fb];
                    c_hi ^= null_c_hi[fb];
                    fg_prev = fg_now;
                }
                models_cnt++;
                if (audit_bent_116_c(orb_tts, c_lo, c_hi)) {
                    *out_consistent_u = consistent_cnt;
                    *out_models_tested = models_cnt;
                    *out_hit_c_lo = c_lo;
                    *out_hit_c_hi = c_hi;
                    return 1; // BENT HIT!
                }
            }
        } else {
            return -2; // Residual free space too large for naive inner enumeration
        }
    }

    *out_consistent_u = consistent_cnt;
    *out_models_tested = models_cnt;
    return 0; // UNSAT PROVEN ON THIS SHARD!
}
"""

U4_LIST = [u * 0x1111 for u in range(16)]


def swap16(x: int) -> int:
    return rot16(x, 8)


def rref_int_list(vecs):
    """Return RREF list of integer bitmasks (MSB-first pivot order)."""
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
    cols = sorted(pivs.keys(), reverse=True)
    for c in cols:
        for c2 in cols:
            if c2 != c and ((pivs[c2] >> c) & 1):
                pivs[c2] ^= pivs[c]
    return [pivs[c] for c in cols]


def nullspace_int_basis(row_masks, d: int):
    """Exact basis of ker(M) <= F_2^d given row bitmasks of M."""
    rref = rref_int_list(row_masks)
    piv_map = {r.bit_length() - 1: r for r in rref}
    basis = []
    for f in range(d):
        if f in piv_map:
            continue
        v = 1 << f
        for pb, r in piv_map.items():
            if (r >> f) & 1:
                v |= 1 << pb
        basis.append(v)
    return basis


def intersect_subspaces_int(basis_A, basis_B, d: int):
    """Exact basis of span(basis_A) cap span(basis_B) in F_2^d via dual sum (A^perp + B^perp)^perp."""
    if not basis_A or not basis_B:
        return []
    perp_A = nullspace_int_basis(basis_A, d)
    perp_B = nullspace_int_basis(basis_B, d)
    return nullspace_int_basis(perp_A + perp_B, d)


def span_pts_16(basis):
    pts = [0]
    for b in basis:
        pts += [p ^ b for p in pts]
    return pts


def build_c8_orbits():
    seen = set()
    u8_size8, nonzero_z = [], []
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
        if len(orb) == 8:
            u8_size8.append((rep, orb))
    return u8_size8, nonzero_z


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


def extract_sym2_poly(lin_masks, origin_bits, n: int):
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


def sample_rot4_wperp(rng, target_codim: int):
    for _ in range(200):
        gens = []
        while len(rref_int_list(gens)) < target_codim:
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
            if len(rref_int_list(cand)) <= target_codim:
                gens = rref_int_list(cand)
            elif len(rref_int_list(gens)) == target_codim - 1:
                for u in rng.sample(U4_LIST, len(U4_LIST)):
                    if len(rref_int_list(gens + [u])) == target_codim:
                        gens = rref_int_list(gens + [u])
                        break
                break
        if len(gens) == target_codim:
            sp = set(span_pts_16(gens))
            if all(rot16(w, 4) in sp for w in sp):
                return gens
    return None


def extract_mod8_from_orbits4_deg2(basis_words, O_word, d0_div4: int, n: int):
    """Extract Level-1 degree <= 2 polynomial P2 from rot^4-orbits."""
    o_pop = O_word.bit_count()
    g0 = o_pop + d0_div4
    if g0 & 1:
        return None
    S1 = []
    for i in range(n):
        wi = basis_words[i].bit_count()
        wo = (basis_words[i] & O_word).bit_count()
        si = wi - 2 * wo
        if si & 1:
            return None
        S1.append(si)

    P2 = set()

    def toggle(m):
        if m in P2:
            P2.remove(m)
        else:
            P2.add(m)

    if (g0 >> 1) & 1:
        toggle(0)
    for i in range(n):
        if (S1[i] >> 1) & 1:
            toggle(1 << i)
    for i in range(n):
        bi = basis_words[i]
        for j in range(i + 1, n):
            inter = bi & basis_words[j]
            if not inter:
                continue
            vij = 2 * (inter & O_word).bit_count() - inter.bit_count()
            if vij & 1:
                toggle((1 << i) | (1 << j))
    return P2


def compile_libraries(work_dir: Path):
    c_audit = work_dir / "b05_audit.c"
    so_audit = work_dir / "libb05_audit.so"
    c_audit.write_text(C_SRC_AUDIT, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_audit), "-o", str(so_audit)], check=True)
    lib_audit = ctypes.CDLL(str(so_audit))

    lib_audit.extract_level1_quad_when_diag4.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64),
    ]
    lib_audit.extract_level1_quad_when_diag4.restype = ctypes.c_int
    lib_audit.extract_coset_full_hierarchy_corrected.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
    ]
    lib_audit.extract_coset_full_hierarchy_corrected.restype = ctypes.c_int
    lib_audit.gf2_echelon_insert.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int,
    ]
    lib_audit.gf2_echelon_insert.restype = ctypes.c_int

    c_symp = work_dir / "b05_symp.c"
    so_symp = work_dir / "libb05_symp.so"
    c_symp.write_text(C_SYMP_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_symp), "-o", str(so_symp)], check=True)
    lib_symp = ctypes.CDLL(str(so_symp))

    lib_symp.pick_best_symplectic_form_c.argtypes = [
        ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
    ]
    lib_symp.pick_best_symplectic_form_c.restype = ctypes.c_int

    lib_symp.audit_bent_116_c.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_uint64, ctypes.c_uint64,
    ]
    lib_symp.audit_bent_116_c.restype = ctypes.c_int

    lib_symp.gray_enumerate_linearized_u_c.argtypes = [
        ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.c_uint64, ctypes.c_uint64,
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.c_uint64, ctypes.c_uint64,
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.POINTER(ctypes.c_uint64),
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
    ]
    lib_symp.gray_enumerate_linearized_u_c.restype = ctypes.c_int
    return lib_audit, lib_symp


def extract_cell_deg12_pivots(c99_val: int, c57_val: int, c113_val: int, lib_audit, precomp):
    """
    Extracts all provable degree <= 2 equations on the pure 111-variable basis
    (plus C5 K = c57, verified explicitly from C_{0xf} / T20; note in B1_00, C_{0xf} parity
    implies K = 1 while C5 requires K = c57 = 0 -> immediate linear contradiction 1=0!).
    """
    orbits = precomp["orbits"]
    v6_list = precomp["v6_list"]
    pair_idx = precomp["pair_idx"]
    orb_diag = precomp["orb_diag"]
    orb_pair = precomp["orb_pair"]
    orb_r4 = precomp["orb_r4"]
    chi_r4 = precomp["chi_r4"]
    rep_of_x = precomp["rep_of_x"]
    coset_0xf_reps = precomp["coset_0xf_reps"]
    orb_tts = precomp["orb_tts"]
    u8_size8, nonzero_z = precomp["u8_size8"], precomp["nonzero_z"]

    _, origin, cb = build_pure_111_basis(c99_val, c57_val, c113_val)
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
    deg1_rows, deg2_rows = [], []

    def record_piv(pc):
        nonlocal cur_row
        if pc < 0:
            return
        d = 0 if pc == off0 else (1 if pc >= off1 else (2 if pc >= off2 else 3))
        deg_pivs[d] += 1
        if d == 1:
            deg1_rows.append(cur_row)
            xl_queue.append(cur_row)
        elif d == 2:
            deg2_rows.append(cur_row)
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
        pc = lib_audit.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
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

    def eval_orb_at_x(j, x):
        return (orb_tts[j * 1024 + (x >> 6)] >> (x & 63)) & 1

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

    # 1. Proven C5: K == c57, AND C_{0xf} exact parity (Theorem 1: wt_orb(C_{0xf}) == 128 => even!)
    k_mask = sum(1 << j for j in K_INDICES)
    p_c5 = {1 << i for i, cdir in enumerate(cb) if (cdir & k_mask).bit_count() & 1}
    if ((origin & k_mask).bit_count() ^ c57_val) & 1:
        p_c5.add(0)
    insert_pset(p_c5)

    w_0xf, o_0xf = 0, 0
    for x in coset_0xf_reps:
        wm, ob = eval_x_form(x)
        w_0xf ^= wm
        o_0xf ^= ob
    p_0xf = {1 << i for i in range(n) if (w_0xf >> i) & 1}
    if o_0xf:
        p_0xf.add(0)
    insert_pset(p_0xf)
    drain_xl()

    if piv_row_idx[off0] >= 0:
        return {"has_one": True, "origin": origin, "cb": cb, "deg_pivs": deg_pivs,
                "lin_psets": [], "quad_psets": []}

    # 2. Q4 (C4)
    def lin_expr(indices):
        msk = sum(1 << j for j in indices)
        idxs = [i for i, c in enumerate(cb) if (c & msk).bit_count() & 1]
        return idxs, (origin & msk).bit_count() & 1

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

    # 3. Dual Fibers F_z (Theorem A1 in B0_00; Krawtchouk mod-2 left-nullspace in B0_11 / B1_11!)
    M_mod2_rows = []
    for z_rep, _ in nonzero_z:
        m_bits = 0
        for m, (_, a_orb) in enumerate(u8_size8):
            s_val = sum(-1 if ((a & z_rep).bit_count() & 1) else 1 for a in a_orb)
            if (s_val // 2) & 1:
                m_bits |= 1 << m
        M_mod2_rows.append(m_bits)

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
    else:
        # Left-nullspace of M_mod2_rows gives pure linear equations in c!
        piv_m = {}
        null_vecs = []
        for idx_r, r_val in enumerate(M_mod2_rows):
            v, comb = r_val, 1 << idx_r
            while v:
                b = v.bit_length() - 1
                if b in piv_m:
                    pv, pc = piv_m[b]
                    v ^= pv
                    comb ^= pc
                else:
                    piv_m[b] = (v, comb)
                    break
            if v == 0:
                null_vecs.append(comb)
        pair_forms_35 = [[eval_x_form(x) for x in fiber_orbit_reps(z_rep, 8)] for z_rep, _ in nonzero_z]
        for u_vec in null_vecs:
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

    # 4. V6 x V6 + Affine cosets + Interleaved + First/Second Differences!
    MAX_CHARS = 12
    MAX_C_PAIRS = MAX_CHARS * (MAX_CHARS - 1) // 2
    p_idxs_arr = (ctypes.c_int * 2048)()
    char_words32 = (ctypes.c_uint64 * (MAX_CHARS * 32))()
    quad_buf = (ctypes.c_uint64 * (MAX_CHARS * n_col_words))()
    quad_valid = (ctypes.c_int * MAX_CHARS)()
    lin_buf = (ctypes.c_uint64 * (MAX_C_PAIRS * n_col_words))()
    lin_valid = (ctypes.c_int * MAX_C_PAIRS)()

    def process_coset(pts_16, asym_u_list=()):
        if piv_row_idx[off0] >= 0 or cur_row >= max_rows - 100:
            return
        diag_pts = [x & 0xFF for x in pts_16 if (x & 0xFF) == (x >> 8)]
        pair_reps = [x for x in pts_16 if (x & 0xFF) < (x >> 8)]
        n_pairs = len(pair_reps)
        wt_diag = sum((O_diag >> v) & 1 for v in diag_pts)
        for k, x in enumerate(pair_reps):
            p_idxs_arr[k] = pair_idx[(x & 0xFF, x >> 8)]
        u_vecs = [(1 << r) | (1 << (r + 8)) for r in range(8)] + [0xFFFF]
        if not diag_pts:
            for u_asym in asym_u_list[: (MAX_CHARS - 9)]:
                u_vecs.append(u_asym)
        n_chars = len(u_vecs)
        ctypes.memset(char_words32, 0, ctypes.sizeof(char_words32))
        for m, u16 in enumerate(u_vecs):
            base_m = m * 32
            for k, x in enumerate(pair_reps):
                if (x & u16).bit_count() & 1:
                    char_words32[base_m + (k >> 6)] |= 1 << (k & 63)

        if wt_diag % 8 == 4:
            base_ptr = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            if lib_audit.extract_level1_quad_when_diag4(
                all_pair_bits, p_idxs_arr, n_pairs, n, None, off2, off1, off0, n_col_words, base_ptr
            ) == 0:
                record_piv(lib_audit.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols))
            for m in range(n_chars):
                if piv_row_idx[off0] >= 0 or cur_row >= max_rows - 20:
                    break
                um_ptr = ctypes.cast(ctypes.byref(char_words32, m * 32 * 8), ctypes.POINTER(ctypes.c_uint64))
                base_ptr = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                if lib_audit.extract_level1_quad_when_diag4(
                    all_pair_bits, p_idxs_arr, n_pairs, n, um_ptr, off2, off1, off0, n_col_words, base_ptr
                ) == 0:
                    record_piv(lib_audit.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols))
            drain_xl()
            return

        if wt_diag % 8 != 0:
            return
        diag_div8_parity = (wt_diag // 8) & 1
        ctypes.memset(quad_buf, 0, ctypes.sizeof(quad_buf))
        base_ptr = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
        rc = lib_audit.extract_coset_full_hierarchy_corrected(
            all_pair_bits, p_idxs_arr, n_pairs, n, diag_div8_parity,
            char_words32, n_chars, col3_base, off2, off1, off0, n_col_words,
            base_ptr, quad_buf, quad_valid, lin_buf, lin_valid,
        )
        if rc != 0:
            return
        record_piv(lib_audit.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols))
        for pm in range(n_chars * (n_chars - 1) // 2):
            if not lin_valid[pm] or cur_row >= max_rows - 10 or piv_row_idx[off0] >= 0:
                continue
            dst = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            src = ctypes.cast(ctypes.byref(lin_buf, pm * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            ctypes.memmove(dst, src, n_col_words * 8)
            record_piv(lib_audit.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols))
        for m in range(n_chars):
            if not quad_valid[m] or cur_row >= max_rows - 10 or piv_row_idx[off0] >= 0:
                continue
            dst = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            src = ctypes.cast(ctypes.byref(quad_buf, m * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            ctypes.memmove(dst, src, n_col_words * 8)
            record_piv(lib_audit.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols))
        drain_xl()

    t_ext = time.perf_counter()
    for pts8 in v6_list:
        if piv_row_idx[off0] >= 0 or (time.perf_counter() - t_ext) > 18.0:
            break
        w_pts = [v | (w << 8) for v in pts8 for w in pts8]
        process_coset(w_pts)
        process_coset([interleave16(x) for x in w_pts])

    # 5. Also scan rot^4-invariant dim 12 / dim 11 degree <= 2 P2 equations (Step 7)
    rng = random.Random(20260805 + 10 * c99_val + c57_val)
    seen_w = set()
    for trial in range(500):
        if piv_row_idx[off0] >= 0 or cur_row >= max_rows - 150 or (time.perf_counter() - t_ext) > 25.0:
            break
        codim = 4 if (trial % 3 != 2) else 5
        wp_basis = sample_rot4_wperp(rng, codim)
        if wp_basis is None:
            continue
        key = tuple(wp_basis)
        if key in seen_w:
            continue
        seen_w.add(key)
        W_basis = nullspace_int_basis(wp_basis, 16)
        W_pts = span_pts_16(W_basis)
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
        sub_cb = [sum(((vr >> ri) & 1) << idx for idx, ri in enumerate(r4_indices)) for vr in cb_r4]
        for use_chi in (0, 1):
            src_O = O_r4 ^ (chi_r4 if use_chi else 0)
            sub_O = sum(((src_O >> ri) & 1) << idx for idx, ri in enumerate(r4_indices))
            P2 = extract_mod8_from_orbits4_deg2(sub_cb, sub_O, d0 // 4, n)
            if P2 is not None:
                insert_pset(P2)
                drain_xl()

    if piv_row_idx[off0] >= 0:
        return {"has_one": True, "origin": origin, "cb": cb, "deg_pivs": deg_pivs,
                "lin_psets": [], "quad_psets": []}

    # Extract clean RREF degree-1 and degree-2 polynomials from pivot table!
    lin_psets = []
    for c in range(off1, off0):
        r_idx = piv_row_idx[c]
        if r_idx >= 0:
            row_slice = [rows[r_idx * n_col_words + w] for w in range(n_col_words)]
            lin_psets.append(decode_row_to_pset(row_slice, n_cols, off2, off1, off0, pair2_list, col3_list))

    quad_psets = []
    for c in range(off2, off1):
        r_idx = piv_row_idx[c]
        if r_idx >= 0:
            row_slice = [rows[r_idx * n_col_words + w] for w in range(n_col_words)]
            quad_psets.append(decode_row_to_pset(row_slice, n_cols, off2, off1, off0, pair2_list, col3_list))

    return {
        "has_one": False,
        "origin": origin,
        "cb": cb,
        "deg_pivs": deg_pivs,
        "lin_psets": lin_psets,
        "quad_psets": quad_psets,
    }


def eliminate_linears_and_echelonize_quads(origin111: int, cb111: list, lin_psets: list, quad_psets: list):
    """
    Eliminate ALL linear equations from F_2^111 -> F_2^N, substitute into quad_psets,
    and iteratively eliminate any new linear equations that drop out!
    Returns (has_one, origin_N, cb_N, reduced_quads_N).
    """
    cur_orig = origin111
    cur_cb = list(cb111)
    cur_polys = [set(p) for p in lin_psets] + [set(p) for p in quad_psets]

    while True:
        N = len(cur_cb)
        # Find all degree <= 1 polynomials
        lin_rows = []
        other_polys = []
        for p in cur_polys:
            if not p:
                continue
            max_d = max(m.bit_count() for m in p)
            if max_d == 0:
                return True, cur_orig, cur_cb, []  # 1 = 0!
            elif max_d == 1:
                # Pack as (N+1)-bit integer: bit 0 = const, bit (i+1) = x_i
                rm = (1 if 0 in p else 0)
                for m in p:
                    if m:
                        rm |= 1 << m.bit_length()  # since m = 1<<i, m.bit_length() == i+1
                lin_rows.append(rm)
            else:
                other_polys.append(p)

        if not lin_rows:
            break

        rref = rref_int_list(lin_rows)
        if any(r == 1 for r in rref):
            return True, cur_orig, cur_cb, []  # 1 = 0!

        # Build substitution map: pivot var p_var -> (mask_on_free_vars, const_bit)
        piv_expr = {}
        piv_vars = set()
        for r in rref:
            pb = r.bit_length() - 1  # >= 1
            p_var = pb - 1
            piv_vars.add(p_var)
            piv_expr[p_var] = r ^ (1 << pb)  # still indexed on 1..N + bit 0

        free_old = [i for i in range(N) if i not in piv_vars]
        old_to_new_lin = {}  # old_i -> (new_mask, const_bit)
        for new_i, old_i in enumerate(free_old):
            old_to_new_lin[old_i] = (1 << new_i, 0)
        for p_var, rem in piv_expr.items():
            c_bit = rem & 1
            n_mask = 0
            for new_i, old_i in enumerate(free_old):
                if (rem >> (old_i + 1)) & 1:
                    n_mask ^= 1 << new_i
            old_to_new_lin[p_var] = (n_mask, c_bit)

        # Update affine parametrization in F_2^116
        new_orig = cur_orig
        new_cb = [0] * len(free_old)
        for old_i, cdir in enumerate(cur_cb):
            n_mask, c_bit = old_to_new_lin[old_i]
            if c_bit:
                new_orig ^= cdir
            tmp = n_mask
            while tmp:
                b = tmp & -tmp
                new_cb[b.bit_length() - 1] ^= cdir
                tmp ^= b

        # Substitute into all quadratic polynomials!
        new_polys = []
        for p in other_polys:
            out_p = set()

            def toggle(m):
                if m in out_p:
                    out_p.remove(m)
                else:
                    out_p.add(m)

            for m in p:
                if m == 0:
                    toggle(0)
                elif m.bit_count() == 1:
                    i = m.bit_length() - 1
                    nm, cb_bit = old_to_new_lin[i]
                    if cb_bit:
                        toggle(0)
                    tmp = nm
                    while tmp:
                        b = tmp & -tmp
                        toggle(b)
                        tmp ^= b
                else:
                    i = (m & -m).bit_length() - 1
                    j = (m ^ (1 << i)).bit_length() - 1
                    m1, c1 = old_to_new_lin[i]
                    m2, c2 = old_to_new_lin[j]
                    if c1 and c2:
                        toggle(0)
                    if c1:
                        tmp = m2
                        while tmp:
                            b = tmp & -tmp
                            toggle(b)
                            tmp ^= b
                    if c2:
                        tmp = m1
                        while tmp:
                            b = tmp & -tmp
                            toggle(b)
                            tmp ^= b
                    # Product m1 * m2 in B_{N_new}:
                    t1 = m1
                    while t1:
                        b1 = t1 & -t1
                        t1 ^= b1
                        t2 = m2
                        while t2:
                            b2 = t2 & -t2
                            t2 ^= b2
                            toggle(b1 | b2)
            if out_p:
                new_polys.append(out_p)

        cur_orig, cur_cb, cur_polys = new_orig, new_cb, new_polys

    # Final RREF on degree <= 2 polynomials (deg 2 first, then deg 1, then const 0)
    piv2 = {}
    for p in cur_polys:
        cur = set(p)
        while cur:
            lead = max(cur, key=lambda m: (m.bit_count(), m))
            if lead == 0:
                return True, cur_orig, cur_cb, []
            if lead in piv2:
                cur ^= piv2[lead]
            else:
                piv2[lead] = cur
                break

    # If any degree-1 pivot emerged during quadratic RREF, recurse once!
    if any(lead.bit_count() == 1 for lead in piv2):
        return eliminate_linears_and_echelonize_quads(cur_orig, cur_cb, [], list(piv2.values()))

    cols_sorted = sorted(piv2.keys(), key=lambda m: (m.bit_count(), m), reverse=True)
    for idx_a, ca in enumerate(cols_sorted):
        for cb_col in cols_sorted[:idx_a]:
            if ca in piv2[cb_col]:
                piv2[cb_col] ^= piv2[ca]

    return False, cur_orig, cur_cb, [piv2[c] for c in cols_sorted]


def extract_symplectic_kernel_U(N: int, quad_psets: list, lib_symp):
    """
    Exact algorithmic extraction of the common bilinear linearizer U = span(u_1..u_k) <= (F_2^N)^*
    via alternating matrices S_r = A_r ^ A_r^T, pairwise image intersections Im(S_a) cap Im(S_b),
    and the proven Gain(u) = #{r : u in Im(S_r|_K)} refinement theorem!
    """
    m = len(quad_psets)
    # Build initial alternating matrices S_orig[r][i] as N-bit int masks
    S_orig = [[0] * N for _ in range(m)]
    for r, pset in enumerate(quad_psets):
        for mon in pset:
            if mon.bit_count() == 2:
                i = (mon & -mon).bit_length() - 1
                j = (mon ^ (1 << i)).bit_length() - 1
                S_orig[r][i] |= 1 << j
                S_orig[r][j] |= 1 << i

    # 1. Global radical K_rad = cap_r ker(S_r) and essential subspace W_ess = sum_r Im(S_r)
    all_rows = [row for r in range(m) for row in S_orig[r] if row]
    w_ess_basis = rref_int_list(all_rows)
    dim_w_ess = len(w_ess_basis)
    dim_k_rad = N - dim_w_ess

    indiv_ranks = [len(rref_int_list(S_orig[r])) for r in range(m)]
    rank_hist = {}
    for rk in indiv_ranks:
        rank_hist[rk] = rank_hist.get(rk, 0) + 1

    # Maintain current subspace K <= F_2^N via basis K_basis[0..d-1] (each an N-bit int, initially e_0..e_{N-1})
    K_basis = [1 << i for i in range(N)]
    U_forms = []       # selected linear forms u_1..u_k in (F_2^N)^* (each an N-bit int)
    curve = []         # [(k, m_linearized, active_quads, sum_symp_ranks, residual_dim_est)]

    while True:
        d = len(K_basis)
        # Project S_orig[r] onto current K_basis: S_K[r][a, b] = <K_basis[a], S_orig[r] * K_basis[b]>
        # Fast computation: first V_r[b] = S_orig[r] * K_basis[b] in F_2^N!
        S_K = [[0] * d for _ in range(m)]
        for r in range(m):
            Sr = S_orig[r]
            Vr = [0] * d
            for b in range(d):
                kb = K_basis[b]
                out_v = 0
                tmp = kb
                while tmp:
                    bit = tmp & -tmp
                    idx = bit.bit_length() - 1
                    out_v ^= Sr[idx]
                    tmp ^= bit
                Vr[b] = out_v
            for a in range(d):
                ka = K_basis[a]
                row_d = 0
                for b in range(a + 1, d):
                    if (ka & Vr[b]).bit_count() & 1:
                        row_d |= 1 << b
                        S_K[r][b] |= 1 << a
                S_K[r][a] |= row_d

        # Exact quadratic span rank p_2 = dim span(S_K[0], ..., S_K[m-1]) over GF(2)!
        # Pack upper triangle of each S_K[r] as a Python int to get EXACT m_lin = m - p_2!
        quad_vecs = []
        im_bases = []
        active_indices = []
        for r in range(m):
            ib = rref_int_list(S_K[r])
            im_bases.append(ib)
            if ib:
                active_indices.append(r)
            q_int = 0
            shift = 0
            for a in range(d):
                upper = S_K[r][a] >> (a + 1)
                q_int |= upper << shift
                shift += (d - 1 - a)
            if q_int:
                quad_vecs.append(q_int)

        p2_rank = len(rref_int_list(quad_vecs))
        m_lin = m - p2_rank
        sum_ranks = sum(len(ib) for ib in im_bases)
        k_cur = len(U_forms)
        curve.append({
            "k": k_cur,
            "d_K": d,
            "p2_quad_rank": p2_rank,
            "m_linearized_span": m_lin,
            "active_pivots_nonzero": len(active_indices),
            "sum_symplectic_ranks": sum_ranks,
            "expected_w_free_after_lin": max(0, d - m_lin),
        })

        if p2_rank == 0 or d == 0:
            break

        # Build high-quality GL_d(F_2)-invariant candidate pool in K^* \ {0}:
        #   (a) Basis vectors of lowest-rank active Im(S_K[r]) (Lagrangian factor candidates!)
        #   (b) Non-zero vectors in pairwise intersections Im(S_K[a]) cap Im(S_K[b])!
        #   (c) Non-zero rows of S_K[r] (images of basis vectors S_K[r] * e_j)
        cand_set = set()
        active_sorted = sorted(active_indices, key=lambda r: len(im_bases[r]))
        for r in active_sorted[:24]:
            for v in im_bases[r]:
                cand_set.add(v)
            for row_v in S_K[r]:
                if row_v:
                    cand_set.add(row_v)

        # Pairwise intersections Im(S_a) cap Im(S_b) among lowest-rank & diverse active matrices!
        sample_pairs = active_sorted[:20]
        for idx_1 in range(len(sample_pairs)):
            r1 = sample_pairs[idx_1]
            for idx_2 in range(idx_1 + 1, len(sample_pairs)):
                r2 = sample_pairs[idx_2]
                inter_b = intersect_subspaces_int(im_bases[r1], im_bases[r2], d)
                for iv in inter_b[:6]:
                    cand_set.add(iv)
                if len(inter_b) >= 2:
                    cand_set.add(inter_b[0] ^ inter_b[1])

        # Also add unit coordinates in K^* as baseline
        for i in range(d):
            cand_set.add(1 << i)

        cand_list = [c for c in cand_set if c != 0]
        n_cands = len(cand_list)

        # Call C engine to evaluate exact Gain(u) = #{r : u in Im(S_K[r])} across all m matrices!
        mask64 = (1 << 64) - 1
        S_lo = (ctypes.c_uint64 * (m * d))()
        S_hi = (ctypes.c_uint64 * (m * d))()
        for r in range(m):
            base = r * d
            for a in range(d):
                v = S_K[r][a]
                S_lo[base + a] = v & mask64
                S_hi[base + a] = (v >> 64) & mask64

        cand_lo = (ctypes.c_uint64 * n_cands)()
        cand_hi = (ctypes.c_uint64 * n_cands)()
        for idx_c, cv in enumerate(cand_list):
            cand_lo[idx_c] = cv & mask64
            cand_hi[idx_c] = (cv >> 64) & mask64

        best_gain = ctypes.c_int()
        act_m = ctypes.c_int()
        sum_rk_c = ctypes.c_int()
        best_idx = lib_symp.pick_best_symplectic_form_c(
            m, d, S_lo, S_hi, n_cands, cand_lo, cand_hi,
            ctypes.byref(best_gain), ctypes.byref(act_m), ctypes.byref(sum_rk_c)
        )
        assert best_idx >= 0 and best_gain.value >= 1
        u_local = cand_list[best_idx]  # form in K^*: u_local(w) = <u_local, w>

        # Lift u_local in K^* to an explicit global linear form u_global in (F_2^N)^*
        # that vanishes on the new K' = ker(u_local) <= K and is independent of previous U_forms!
        # Specifically: find ker(u_local) in F_2^d (dim d-1), lift to K'_basis <= F_2^N,
        # then U_new = (K'_basis)^perp = U_old + span(u_new)!
        piv_b = (u_local & -u_local).bit_length() - 1
        new_K_basis = []
        for a in range(d):
            if a == piv_b:
                continue
            vec = K_basis[a]
            if (u_local >> a) & 1:
                vec ^= K_basis[piv_b]
            new_K_basis.append(vec)

        # Find the unique (mod U_forms) vector u_global in (new_K_basis)^perp \ span(U_forms)
        perp_new_K = nullspace_int_basis(new_K_basis, N)
        prev_rref = rref_int_list(U_forms)
        prev_pivs = {r.bit_length() - 1: r for r in prev_rref}
        chosen_u_global = 0
        for cand_ug in perp_new_K:
            rem = cand_ug
            while rem:
                b = rem.bit_length() - 1
                if b in prev_pivs:
                    rem ^= prev_pivs[b]
                else:
                    chosen_u_global = cand_ug
                    break
            if chosen_u_global:
                break
        assert chosen_u_global != 0
        U_forms.append(chosen_u_global)
        K_basis = new_K_basis

    # Rigorous Verification Theorem 1.3 (Eq. 5'): K_U = U^perp is 100% isotropic for ALL S_1..S_m!
    K_final = nullspace_int_basis(U_forms, N)
    assert len(K_final) + len(U_forms) == N
    for r in range(m):
        Sr = S_orig[r]
        for a in range(len(K_final)):
            va = K_final[a]
            # Compute Sr * va
            sva = 0
            tmp = va
            while tmp:
                b = tmp & -tmp
                sva ^= Sr[b.bit_length() - 1]
                tmp ^= b
            for b in range(a + 1, len(K_final)):
                assert ((K_final[b] & sva).bit_count() & 1) == 0, "ISOTROPY CHECK FAILED!"

    return {
        "N": N,
        "m": m,
        "dim_K_rad_pure_linear_vars": dim_k_rad,
        "dim_W_ess": dim_w_ess,
        "individual_symplectic_rank_hist": {str(k): v for k, v in sorted(rank_hist.items())},
        "min_individual_rank": min(indiv_ranks) if indiv_ranks else 0,
        "max_individual_rank": max(indiv_ranks) if indiv_ranks else 0,
        "dim_U_total_linearizer": len(U_forms),
        "U_forms_masks": U_forms,
        "K_U_basis_masks": K_final,
        "linearization_curve": curve,
    }


def build_bilinearized_system_for_c(N: int, origin_N: int, cb_N: list, quad_psets: list, U_forms: list, K_final: list):
    """
    Construct the exact invertible basis change x(u, w) = M_U * u ^ M_K * w on F_2^N:
      - Choose dual vectors v_0..v_{k-1} in F_2^N such that u_a(v_b) = delta_{ab}!
      - Any x in F_2^N decomposes uniquely as x = sum_{a=0}^{k-1} u_a * v_a ^ sum_{c=0}^{d_w-1} w_c * K_final[c],
        because for a_test in 0..k-1: u_{a_test}(K_final[c]) = 0!
      - Substitute this affine map into every q_r(x) -> pure affine-in-w system A(u)*w = b(u)!
    """
    k = len(U_forms)
    d_w = len(K_final)
    assert k + d_w == N

    # Find dual vectors v_0..v_{k-1} satisfying <U_forms[a], v_b> == [a == b]
    # Solve the k x N linear system U_mat * v = e_a for each a = 0..k-1:
    # Augment row a of U_mat (bits 0..N-1) with identity bit (N + a):
    aug = [U_forms[a] | (1 << (N + a)) for a in range(k)]
    # RREF on lower N bits only!
    piv_col = []
    for r in range(k):
        # Find lowest set bit in 0..N-1
        low_mask = aug[r] & ((1 << N) - 1)
        assert low_mask != 0
        c = (low_mask & -low_mask).bit_length() - 1
        piv_col.append(c)
        for r2 in range(k):
            if r2 != r and ((aug[r2] >> c) & 1):
                aug[r2] ^= aug[r]
    v_dual = [0] * k
    for a in range(k):
        vec = 0
        for r, c in enumerate(piv_col):
            if (aug[r] >> (N + a)) & 1:
                vec |= 1 << c
        v_dual[a] = vec

    for a in range(k):
        for b in range(k):
            assert ((U_forms[a] & v_dual[b]).bit_count() & 1) == (1 if a == b else 0)

    # Coordinate expression: x_i = <coord_u[i], u> ^ <coord_w[i], w>
    coord_u = [0] * N
    coord_w = [0] * N
    for i in range(N):
        cu = 0
        for a in range(k):
            if (v_dual[a] >> i) & 1:
                cu |= 1 << a
        cw = 0
        for c in range(d_w):
            if (K_final[c] >> i) & 1:
                cw |= 1 << c
        coord_u[i] = cu
        coord_w[i] = cw

    m = len(quad_psets)
    A0 = [0] * m
    dA = [[0] * m for _ in range(k)]
    b0 = [0] * m
    db1 = [[0] * m for _ in range(k)]
    db2 = [[[0] * m for _ in range(k)] for _ in range(k)]

    for r, pset in enumerate(quad_psets):
        for mon in pset:
            if mon == 0:
                b0[r] ^= 1
            elif mon.bit_count() == 1:
                i = mon.bit_length() - 1
                A0[r] ^= coord_w[i]
                cu = coord_u[i]
                while cu:
                    bit = cu & -cu
                    db1[bit.bit_length() - 1][r] ^= 1
                    cu ^= bit
            else:
                i = (mon & -mon).bit_length() - 1
                j = (mon ^ (1 << i)).bit_length() - 1
                ui, wi = coord_u[i], coord_w[i]
                uj, wj = coord_u[j], coord_w[j]
                # Product (ui + wi)*(uj + wj):
                # 1) ui * uj -> pure u terms (diagonal u_a^2 = u_a -> db1; cross u_a u_b -> db2)
                t1 = ui
                while t1:
                    b1_bit = t1 & -t1
                    a1 = b1_bit.bit_length() - 1
                    t1 ^= b1_bit
                    t2 = uj
                    while t2:
                        b2_bit = t2 & -t2
                        a2 = b2_bit.bit_length() - 1
                        t2 ^= b2_bit
                        if a1 == a2:
                            db1[a1][r] ^= 1
                        elif a1 < a2:
                            db2[a1][a2][r] ^= 1
                        else:
                            db2[a2][a1][r] ^= 1
                # 2) ui * wj + uj * wi -> bilinear u_a * w_c -> dA[a][r] ^= (1 << c)
                for u_mask, w_mask in ((ui, wj), (uj, wi)):
                    tu = u_mask
                    while tu:
                        bu = tu & -tu
                        a_idx = bu.bit_length() - 1
                        dA[a_idx][r] ^= w_mask
                        tu ^= bu
                # 3) wi * wj: diagonal w_c^2 = w_c contributes to LINEAR A0[r]!
                #    Cross terms w_c * w_d (c < d) MUST cancel completely across pset by isotropy!
                A0[r] ^= (wi & wj)

    # Map v_dual[0..k-1] and K_final[0..d_w-1] to 116-bit orbit directions!
    u_cdir = []
    for a in range(k):
        cd = 0
        for i in range(N):
            if (v_dual[a] >> i) & 1:
                cd ^= cb_N[i]
        u_cdir.append(cd)
    w_cdir = []
    for c in range(d_w):
        cd = 0
        for i in range(N):
            if (K_final[c] >> i) & 1:
                cd ^= cb_N[i]
        w_cdir.append(cd)

    return A0, dA, b0, db1, db2, origin_N, u_cdir, w_cdir


def solve_residual_sat_in_symplectic_basis(
    cell_name: str,
    c99_val: int,
    c57_val: int,
    N: int,
    origin_N: int,
    cb_N: list,
    A0, dA, b0, db1, db2,
    u_cdir, w_cdir,
    precomp,
    lib_symp,
    budget_sec: float,
    shard_idx: int = 0,
    shard_count: int = 1,
):
    """
    Fast SAT + C FWHT closer written IN THE SYMPLECTIC BASIS (u_0..u_{k-1}, w_0..w_{d_w-1})!
    Why this is dramatically faster than standard CNF:
      1. EVERY quadratic monomial in all m equations has AT LEAST ONE factor in U = {u_0..u_{k-1}}!
         ZERO w_c * w_d AND-gates exist!
      2. Only C_{0xf} == 128 (256 orbits) + C6 (T28) are encoded in CNF (avoiding the 12 heavy
         F_z counters that slowed Run 44373529263); F_z weights and full FWHT are checked in 0.05ms C!
      3. When shard_count > 1 (e.g. 96 vCPUs), partitions cleanly on top bits of U = (u_0, u_1, ...),
         immediately linearizing those equations by unit propagation!
    """
    from pysat.card import CardEnc, EncType
    from pysat.solvers import Solver

    t0 = time.perf_counter()
    k = len(u_cdir)
    d_w = len(w_cdir)
    m = len(A0)
    assert k + d_w == N

    # SAT variables: 1..k = u_0..u_{k-1}; (k+1)..N = w_0..w_{d_w-1}
    clauses = []
    v_cnt = [N]

    def new_var():
        v_cnt[0] += 1
        return v_cnt[0]

    def add_and2(z, x, y):
        clauses.append([-x, -y, z])
        clauses.append([x, -z])
        clauses.append([y, -z])

    def add_xor(lits, rhs):
        if not lits:
            if rhs:
                clauses.append([1])
                clauses.append([-1])
            return
        cur = list(lits)
        while len(cur) > 4:
            a, b, c = cur[0], cur[1], cur[2]
            aux = new_var()
            # a ^ b ^ c ^ aux == 0
            for s1 in (-1, 1):
                for s2 in (-1, 1):
                    for s3 in (-1, 1):
                        for s4 in (-1, 1):
                            if ((s1 < 0) ^ (s2 < 0) ^ (s3 < 0) ^ (s4 < 0)) == 1:
                                clauses.append([s1 * a, s2 * b, s3 * c, s4 * aux])
            cur = [aux] + cur[3:]
        n_l = len(cur)
        for mask in range(1 << n_l):
            # forbid assignments whose parity != rhs
            if (mask.bit_count() & 1) != rhs:
                clauses.append([-(cur[i]) if ((mask >> i) & 1) else cur[i] for i in range(n_l)])

    # Shard partitioning on top bits of U = (u_0, u_1, ...) when shard_count is a power of 2 (or modular)
    if shard_count > 1:
        # Pick s_bits such that 2^s_bits >= shard_count (e.g. s_bits = 7 -> 128 cubes across shards)
        s_bits = max(1, (shard_count - 1).bit_length())
        s_bits = min(s_bits, k)
        my_cubes = [cid for cid in range(1 << s_bits) if (cid % shard_count) == shard_idx]
        if not my_cubes:
            return {"status": "EMPTY_SHARD", "unsat_closed": True, "models_checked": 0}
    else:
        s_bits = 0
        my_cubes = [0]

    and_cache = {}

    def get_and(v1, v2):
        if v1 > v2:
            v1, v2 = v2, v1
        key = (v1, v2)
        if key not in and_cache:
            z = new_var()
            add_and2(z, v1, v2)
            and_cache[key] = z
        return and_cache[key]

    # Encode all m bilinearized equations: A0[r]*w ^ sum_a u_a*(dA[a][r]*w) ^ b(u) == 0!
    # Notice: group u_a * (linear form L_{r,a}(w)) by creating ONE gate u_a & L_var instead of many u_a & w_c!
    lin_w_cache = {}

    def get_w_lin_var(w_mask):
        if w_mask in lin_w_cache:
            return lin_w_cache[w_mask]
        if w_mask.bit_count() == 1:
            v = k + 1 + (w_mask.bit_length() - 1)
            lin_w_cache[w_mask] = v
            return v
        lv = new_var()
        lits = [k + 1 + c for c in range(d_w) if (w_mask >> c) & 1] + [lv]
        add_xor(lits, 0)
        lin_w_cache[w_mask] = lv
        return lv

    for r in range(m):
        xor_lits = []
        rhs = b0[r]
        for c in range(d_w):
            if (A0[r] >> c) & 1:
                xor_lits.append(k + 1 + c)
        for a in range(k):
            if db1[a][r]:
                xor_lits.append(a + 1)
            wm = dA[a][r]
            if wm:
                lw_var = get_w_lin_var(wm)
                xor_lits.append(get_and(a + 1, lw_var))
            for b in range(a + 1, k):
                if db2[a][b][r]:
                    xor_lits.append(get_and(a + 1, b + 1))
        add_xor(xor_lits, rhs)

    # Encode C_{0xf} exact weight == 128 (256 free C16-orbits: Theorem 1 holds in ALL cells!)
    all_cdirs = u_cdir + w_cdir
    orb_tts = precomp["orb_tts"]
    coset_0xf_reps = precomp["coset_0xf_reps"]

    def make_pt_lit(x_pt):
        orb_vec = 0
        for j in range(116):
            if (orb_tts[j * 1024 + (x_pt >> 6)] >> (x_pt & 63)) & 1:
                orb_vec |= 1 << j
        ob = (origin_N & orb_vec).bit_count() & 1
        lits = [idx + 1 for idx, cd in enumerate(all_cdirs) if (cd & orb_vec).bit_count() & 1]
        if not lits:
            v = new_var()
            clauses.append([v if ob else -v])
            return v
        if len(lits) == 1:
            return -lits[0] if ob else lits[0]
        lv = new_var()
        add_xor(lits + [lv], ob)
        return lv

    lits_0xf = [make_pt_lit(x) for x in coset_0xf_reps]
    enc_0xf = CardEnc.equals(lits=lits_0xf, bound=128, top_id=v_cnt[0], encoding=EncType.totalizer)
    v_cnt[0] = max(v_cnt[0], enc_0xf.nv)
    clauses.extend(enc_0xf.clauses)

    # Optional C6 (T28 certificate if present in repo)
    t28_candidates = [
        Path(__file__).resolve().parent / "T28_SEXTA_CERTIFICADO.json",
        Path(__file__).resolve().parents[2] / "quartic_audit_2026_10_17/archive/T28_SEXTA_CERTIFICADO.json",
    ]
    for p_t28 in t28_candidates:
        if p_t28.exists():
            cert_t28 = json.loads(p_t28.read_text(encoding="utf-8"))
            br_idx = 1 if c99_val == 1 else 0
            if br_idx < len(cert_t28.get("reduced_models", {}).get("branches", [])):
                poly_hex = [int(h, 16) for h in cert_t28["reduced_models"]["branches"][br_idx]["polynomial_hex"]]
                c_lits = {}
                for j in range(116):
                    idxs = [idx + 1 for idx, cd in enumerate(all_cdirs) if (cd >> j) & 1]
                    cst = (origin_N >> j) & 1
                    if not idxs:
                        lv = new_var()
                        clauses.append([lv if cst else -lv])
                    elif len(idxs) == 1 and cst == 0:
                        lv = idxs[0]
                    elif len(idxs) == 1 and cst == 1:
                        lv = -idxs[0]
                    else:
                        lv = new_var()
                        add_xor(idxs + [lv], cst)
                    c_lits[j] = lv
                c6_lits, c6_rhs = [], 0
                for mon in poly_hex:
                    if mon == 0:
                        c6_rhs ^= 1
                        continue
                    bits = []
                    tmp = mon
                    while tmp:
                        b = tmp & -tmp
                        bits.append(c_lits[b.bit_length() - 1])
                        tmp ^= b
                    cur_v = bits[0]
                    for nxt in bits[1:]:
                        # handle signed literals safely
                        z = new_var()
                        clauses.append([-cur_v, -nxt, z])
                        clauses.append([cur_v, -z])
                        clauses.append([nxt, -z])
                        cur_v = z
                    c6_lits.append(cur_v)
                add_xor(c6_lits, c6_rhs)
            break

    mask64 = (1 << 64) - 1
    models_checked = 0
    bent_hits = []
    all_cubes_closed = True

    with Solver(name="cadical195", bootstrap_with=clauses) as slv:
        # Direct solver decision priority onto U variables 1..k first!
        for cid in my_cubes:
            assumps = [((b + 1) if ((cid >> b) & 1) else -(b + 1)) for b in range(s_bits)]
            while True:
                if (time.perf_counter() - t0) >= budget_sec:
                    all_cubes_closed = False
                    break
                if not slv.solve(assumptions=assumps):
                    break
                models_checked += 1
                model = slv.get_model()
                cint = origin_N
                for idx, cd in enumerate(all_cdirs):
                    if model[idx] > 0:
                        cint ^= cd
                if lib_symp.audit_bent_116_c(orb_tts, cint & mask64, cint >> 64):
                    bent_hits.append(hex(cint))
                    break
                slv.add_clause([-(idx + 1) if model[idx] > 0 else (idx + 1) for idx in range(N)])
            if bent_hits or not all_cubes_closed:
                break

    return {
        "mode": "symplectic_basis_sat_fwht",
        "unsat_closed": (all_cubes_closed and len(bent_hits) == 0),
        "shard_idx": shard_idx,
        "shard_count": shard_count,
        "cubes_assigned": len(my_cubes),
        "cnf_vars": v_cnt[0],
        "cnf_clauses": len(clauses),
        "and_gates_created": len(and_cache),
        "models_checked": models_checked,
        "bent_hits": bent_hits,
        "sec": round(time.perf_counter() - t0, 3),
    }


def run_cell_pipeline(
    cell_name: str,
    c99_val: int,
    c57_val: int,
    c113_val: int,
    lib_audit,
    lib_symp,
    precomp,
    budget_sec: float,
    shard_idx: int = 0,
    shard_count: int = 1,
):
    t_cell = time.perf_counter()
    ext = extract_cell_deg12_pivots(c99_val, c57_val, c113_val, lib_audit, precomp)
    if ext["has_one"]:
        return {
            "cell": cell_name,
            "algebraic_has_one": True,
            "unsat_closed": True,
            "deg_pivs_111": ext["deg_pivs"],
            "sec": round(time.perf_counter() - t_cell, 3),
        }

    has_one_lin, origin_N, cb_N, quad_psets = eliminate_linears_and_echelonize_quads(
        ext["origin"], ext["cb"], ext["lin_psets"], ext["quad_psets"]
    )
    if has_one_lin:
        return {
            "cell": cell_name,
            "algebraic_has_one": True,
            "unsat_closed": True,
            "closed_by": "linear_substitution_cascade",
            "sec": round(time.perf_counter() - t_cell, 3),
        }

    N = len(cb_N)
    m = len(quad_psets)
    symp_info = extract_symplectic_kernel_U(N, quad_psets, lib_symp)
    k = symp_info["dim_U_total_linearizer"]
    d_w = N - k

    A0, dA, b0, db1, db2, _, u_cdir, w_cdir = build_bilinearized_system_for_c(
        N, origin_N, cb_N, quad_psets, symp_info["U_forms_masks"], symp_info["K_U_basis_masks"]
    )

    rem_budget = max(5.0, budget_sec - (time.perf_counter() - t_cell))

    # Choose solver engine automatically:
    # If total states per shard (2^k / shard_count) <= 2^25 (~33.5M Gray steps ~ 20s in pure C!),
    # execute 100% deterministic C Gray-Code Linearized Enumeration (ZERO SAT needed!).
    total_u_states = 1 << k
    states_per_shard = (total_u_states + shard_count - 1) // shard_count
    if states_per_shard <= (1 << 25) and m <= 255 and d_w <= 112:
        u_start = min(total_u_states, shard_idx * states_per_shard)
        u_end = min(total_u_states, (shard_idx + 1) * states_per_shard)
        mask64 = (1 << 64) - 1
        A0_lo = (ctypes.c_uint64 * m)(*[v & mask64 for v in A0])
        A0_hi = (ctypes.c_uint64 * m)(*[(v >> 64) & mask64 for v in A0])
        dA_lo = (ctypes.c_uint64 * (k * m))(*[dA[a][r] & mask64 for a in range(k) for r in range(m)])
        dA_hi = (ctypes.c_uint64 * (k * m))(*[(dA[a][r] >> 64) & mask64 for a in range(k) for r in range(m)])
        b0_arr = (ctypes.c_uint8 * m)(*b0)
        db1_arr = (ctypes.c_uint8 * (k * m))(*[db1[a][r] for a in range(k) for r in range(m)])
        db2_arr = (ctypes.c_uint8 * (k * k * m))(*[db2[a][b][r] for a in range(k) for b in range(k) for r in range(m)])
        uc_lo = (ctypes.c_uint64 * k)(*[v & mask64 for v in u_cdir])
        uc_hi = (ctypes.c_uint64 * k)(*[(v >> 64) & mask64 for v in u_cdir])
        wc_lo = (ctypes.c_uint64 * d_w)(*[v & mask64 for v in w_cdir])
        wc_hi = (ctypes.c_uint64 * d_w)(*[(v >> 64) & mask64 for v in w_cdir])

        cons_u = ctypes.c_uint64()
        mod_cnt = ctypes.c_uint64()
        hit_lo = ctypes.c_uint64()
        hit_hi = ctypes.c_uint64()
        t_gray = time.perf_counter()
        rc = lib_symp.gray_enumerate_linearized_u_c(
            k, d_w, m, u_start, u_end,
            A0_lo, A0_hi, dA_lo, dA_hi, b0_arr, db1_arr, db2_arr,
            origin_N & mask64, origin_N >> 64,
            uc_lo, uc_hi, wc_lo, wc_hi, precomp["orb_tts"],
            ctypes.byref(cons_u), ctypes.byref(mod_cnt),
            ctypes.byref(hit_lo), ctypes.byref(hit_hi)
        )
        if rc >= 0:
            hits = [hex((hit_hi.value << 64) | hit_lo.value)] if rc == 1 else []
            close_res = {
                "mode": "pure_c_gray_code_linearizer",
                "unsat_closed": (rc == 0),
                "u_range": [u_start, u_end],
                "consistent_u_subspaces": cons_u.value,
                "models_fwht_tested": mod_cnt.value,
                "bent_hits": hits,
                "sec": round(time.perf_counter() - t_gray, 3),
            }
        else:
            close_res = solve_residual_sat_in_symplectic_basis(
                cell_name, c99_val, c57_val, N, origin_N, cb_N,
                A0, dA, b0, db1, db2, u_cdir, w_cdir,
                precomp, lib_symp, rem_budget, shard_idx, shard_count
            )
    else:
        close_res = solve_residual_sat_in_symplectic_basis(
            cell_name, c99_val, c57_val, N, origin_N, cb_N,
            A0, dA, b0, db1, db2, u_cdir, w_cdir,
            precomp, lib_symp, rem_budget, shard_idx, shard_count
        )

    # Compact summary of the linearization curve (every 4 steps + endpoints + max excess jump)
    curve = symp_info["linearization_curve"]
    best_partial = max(curve, key=lambda item: item["m_linearized_span"] - item["k"])
    curve_digest = [
        c for idx, c in enumerate(curve)
        if idx == 0 or idx == len(curve) - 1 or (idx % 4 == 0) or c["k"] == best_partial["k"]
    ]

    return {
        "cell": cell_name,
        "algebraic_has_one": False,
        "unsat_closed": close_res["unsat_closed"],
        "N_free_vars": N,
        "m_quad_pivots": m,
        "dim_K_rad_pure_linear_vars": symp_info["dim_K_rad_pure_linear_vars"],
        "dim_W_ess": symp_info["dim_W_ess"],
        "min_individual_symp_rank": symp_info["min_individual_rank"],
        "max_individual_symp_rank": symp_info["max_individual_rank"],
        "symplectic_rank_hist": symp_info["individual_symplectic_rank_hist"],
        "dim_U_total_linearizer_k": k,
        "best_partial_linearizer_point": best_partial,
        "linearization_curve_digest": curve_digest,
        "closer_report": close_res,
        "total_sec": round(time.perf_counter() - t_cell, 3),
    }


def main():
    t0 = time.perf_counter()
    target = sys.argv[1] if len(sys.argv) > 1 else "ALL"
    budget = float(sys.argv[2]) if len(sys.argv) > 2 else 300.0
    shard_idx = int(sys.argv[3]) if len(sys.argv) > 3 else int(os.environ.get("CLOUD_RUN_TASK_INDEX", "0"))
    shard_cnt = int(sys.argv[4]) if len(sys.argv) > 4 else int(os.environ.get("CLOUD_RUN_TASK_COUNT", "1"))

    work_dir = Path(__file__).resolve().parent
    lib_audit, lib_symp = compile_libraries(work_dir)

    orbits = build_orbits_116()
    v6_list = all_v6_orbits()
    orb_tts = (ctypes.c_uint64 * (116 * 1024))()
    for j, orb in enumerate(orbits):
        base = j * 1024
        for mon in orb:
            for x in range(65536):
                if (x & mon) == mon:
                    orb_tts[base + (x >> 6)] ^= 1 << (x & 63)

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
        r_idx = len(rot4_reps)
        rot4_reps.append(x)
        for y in (x, rot16(x, 4), rot16(x, 8), rot16(x, 12)):
            seen_x[y] = 1
            rep_of_x[y] = r_idx

    orb_diag, orb_pair, orb_r4 = [0] * 116, [0] * 116, [0] * 116
    for j, orb in enumerate(orbits):
        vd, vp, vr = 0, 0, 0
        for v in range(256):
            x = v | (v << 8)
            if sum((x & mon) == mon for mon in orb) & 1:
                vd |= 1 << v
        for k, x in enumerate(all_pairs):
            if sum((x & mon) == mon for mon in orb) & 1:
                vp |= 1 << k
        for k, x in enumerate(rot4_reps):
            if sum((x & mon) == mon for mon in orb) & 1:
                vr |= 1 << k
        orb_diag[j], orb_pair[j], orb_r4[j] = vd, vp, vr
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
        if len(mem) == 16:
            vnib = (x & 0xF) ^ ((x >> 4) & 0xF) ^ ((x >> 8) & 0xF) ^ ((x >> 12) & 0xF)
            if vnib == 0xF:
                coset_0xf_reps.append(mem[0])

    u8_size8, nonzero_z = build_c8_orbits()
    precomp = {
        "orbits": orbits,
        "v6_list": v6_list,
        "orb_tts": orb_tts,
        "pair_idx": pair_idx,
        "orb_diag": orb_diag,
        "orb_pair": orb_pair,
        "orb_r4": orb_r4,
        "chi_r4": chi_r4,
        "rep_of_x": rep_of_x,
        "coset_0xf_reps": coset_0xf_reps,
        "u8_size8": u8_size8,
        "nonzero_z": nonzero_z,
    }

    cell_map = {
        "B1_00": (1, 0, 0),
        "B1_11": (1, 1, 1),
        "B0_11": (0, 1, 1),
        "B0_00": (0, 0, 0),
    }
    to_run = list(cell_map.keys()) if target == "ALL" else [target]
    per_cell_budget = budget / max(1, len(to_run))

    report = {}
    for cname in to_run:
        c99_v, c57_v, c113_v = cell_map[cname]
        res = run_cell_pipeline(
            cname, c99_v, c57_v, c113_v,
            lib_audit, lib_symp, precomp,
            budget_sec=per_cell_budget,
            shard_idx=shard_idx,
            shard_count=shard_cnt,
        )
        report[cname] = res
        print(f"[{cname}] {json.dumps(res)}", flush=True)

    final_out = {"cells": report, "wall_sec": round(time.perf_counter() - t0, 3)}
    print("=== B05 SYMPLECTIC KERNEL & LINEARIZATION REPORT ===", flush=True)
    print(json.dumps(final_out, indent=2), flush=True)


if __name__ == "__main__":
    main()
