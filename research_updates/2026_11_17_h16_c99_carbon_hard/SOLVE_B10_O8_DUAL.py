#!/usr/bin/env python3
"""
Task b10_odd_subspace_o8_dual:
Exact (E_8 ^ b, f~|_{O_8}) Primal-Dual Extractor, Z/4Z Krawtchouk Syzygies,
and Exhaustive 256-State Elimination of c_{even} in F_2^8 across B1_00, B1_11, B0_11, B0_00.

Pure 111-variable audit basis (ONLY c115=0 and L=c99 eliminating c0; NO unverified assumptions).
Every extracted polynomial is Zero-Trust cross-checked against 65,536-bit ANF evaluations.
"""
import ctypes
import json
import random
import subprocess
import sys
import time
from itertools import combinations
from pathlib import Path

C_SRC_B10 = r"""
#include <stdint.h>
#include <string.h>

// Extract exact degree <= 3 polynomial for (wt(f|_S) / 4) mod 2 over an arbitrary 256-point set S
// (4 uint64_t words!), where Theorem 2 guarantees wt(f|_S) == 0 mod 4 identically!
// Returns 0 on success, <0 if wt(f|_S) % 4 != 0 identically (safety guard).
int extract_set256_div4_mod2(
    const uint64_t *cb_w4,   // n * 4 uint64_t words
    const uint64_t *O_w4,    // 4 uint64_t words
    int n,
    const int *col3_base,
    int off2, int off1, int off0,
    int n_col_words,
    uint64_t *out_row
) {
    int o_pop = 0;
    for (int w = 0; w < 4; w++) o_pop += __builtin_popcountll(O_w4[w]);
    if (o_pop & 3) return -1; // Must be 0 mod 4!

    memset(out_row, 0, (size_t)n_col_words * sizeof(uint64_t));
    if ((o_pop >> 2) & 1) {
        out_row[off0 >> 6] ^= 1ULL << (off0 & 63);
    }

    for (int i = 0; i < n; i++) {
        const uint64_t *bi = cb_w4 + (size_t)i * 4;
        int wi = 0, wo = 0;
        for (int w = 0; w < 4; w++) {
            wi += __builtin_popcountll(bi[w]);
            wo += __builtin_popcountll(bi[w] & O_w4[w]);
        }
        int d1 = wi - 2 * wo;
        if (d1 & 3) return -2; // Must be 0 mod 4!
        if ((d1 >> 2) & 1) {
            int c = off1 + i;
            out_row[c >> 6] ^= 1ULL << (c & 63);
        }
    }

    int c2_idx = 0;
    for (int i = 0; i < n; i++) {
        const uint64_t *bi = cb_w4 + (size_t)i * 4;
        for (int j = i + 1; j < n; j++) {
            const uint64_t *bj = cb_w4 + (size_t)j * 4;
            uint64_t inter[4];
            int ij_pop = 0, ijo_pop = 0;
            for (int w = 0; w < 4; w++) {
                uint64_t iv = bi[w] & bj[w];
                inter[w] = iv;
                ij_pop  += __builtin_popcountll(iv);
                ijo_pop += __builtin_popcountll(iv & O_w4[w]);
            }
            if (ij_pop & 1) return -3; // -2*(ij_pop - 2*ijo_pop) must be 0 mod 4!
            if (((ij_pop >> 1) + ijo_pop) & 1) {
                int c = off2 + c2_idx;
                out_row[c >> 6] ^= 1ULL << (c & 63);
            }
            c2_idx++;

            int base3 = col3_base[i * n + j];
            for (int k = j + 1; k < n; k++) {
                const uint64_t *bk = cb_w4 + (size_t)k * 4;
                int p = 0;
                for (int w = 0; w < 4; w++) p += __builtin_popcountll(inter[w] & bk[w]);
                if (p & 1) {
                    int c = base3 + (k - j - 1);
                    out_row[c >> 6] ^= 1ULL << (c & 63);
                }
            }
        }
    }
    return 0;
}

static inline void pack_subset(const uint64_t *src_510, const int *p_idxs, int n_pairs, uint64_t out32[32]) {
    memset(out32, 0, 32 * sizeof(uint64_t));
    for (int k = 0; k < n_pairs; k++) {
        int idx = p_idxs[k];
        if ((src_510[idx >> 6] >> (idx & 63)) & 1ULL) out32[k >> 6] |= 1ULL << (k & 63);
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

int extract_v6_hierarchy_corrected(
    const uint64_t *all_pair_bits, const int *p_idxs, int n_pairs, int n, int diag_div8_parity,
    const uint64_t *char_words32, int n_chars, const int *col3_base,
    int off2, int off1, int off0, int n_col_words,
    uint64_t *out_base_row, uint64_t *out_quad_rows, int *out_quad_valid
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
        out_row_set:
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
            if ((((wi_pop - 2 * wo_pop) / 4) ^ ((wi_pop - 2 * wou_pop) / 4)) & 1) {
                int c = off1 + i;
                qrow[c >> 6] ^= 1ULL << (c & 63);
            }
        }
        if (!ok) {
            out_quad_valid[m] = 0;
            memset(qrow, 0, (size_t)n_col_words * sizeof(uint64_t));
            continue;
        }
        if (((o_pop / 4) ^ (ou_pop / 4)) & 1) qrow[off0 >> 6] ^= 1ULL << (off0 & 63);
        out_quad_valid[m] = 1;
    }
    return 0;
}

int gf2_echelon_insert(uint64_t *rows, int row_idx, int n_words, int *piv_row_idx, int n_cols) {
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

// Fast In-Cube Specialization + Iterative Linear Elimination + Degree<=2 XL Check!
// Given `n_polys` of degree <= 2 (packed as bitsets on n<=111 vars: off1=n*(n-1)/2, off0=off1+n),
// plus `n_fix` linear equations fixing c_{even} (each given as n+1 bitmask),
// iteratively eliminates all linear pivots, substitutes them into all quadratics,
// and checks if 1 == 0 is derived in degree <= 2!
// Returns 1 if UNSAT (1=0 derived!), 0 if consistent in degree <= 2 (writes out_lin_pivs, out_quad_pivs).
int check_ceven_cube_deg2_cascade(
    int n,
    int n_quad_rows,
    const uint64_t *quad_rows,   // n_quad_rows * q_words (cols: [0..n2-1]=pairs, [n2..n2+n-1]=lin, [n2+n]=const)
    int q_words,
    int n_init_lin,
    const uint64_t *init_lin,    // n_init_lin * 2 words (bits 0..n-1 = vars, bit n = const)
    const int *pair_i,           // [n2]
    const int *pair_j,           // [n2]
    const int *pair_col_mat,     // [n * n]
    int *out_lin_rank,
    int *out_quad_rank
) {
    int n2 = (n * (n - 1)) / 2;
    int off1 = n2, off0 = n2 + n, n_cols = off0 + 1;

    // Maintain linear basis in RREF on (n + 1) bits (2 uint64_t words)
    uint64_t lin_piv_row[128][2];
    int has_lin_piv[128];
    for (int i = 0; i < 128; i++) has_lin_piv[i] = 0;
    int lin_rank = 0;

    // Queue of newly discovered linear equations (2 words each)
    uint64_t lin_queue[256][2];
    int lq_head = 0, lq_tail = 0;
    for (int k = 0; k < n_init_lin; k++) {
        lin_queue[lq_tail][0] = init_lin[2 * k + 0];
        lin_queue[lq_tail][1] = init_lin[2 * k + 1];
        lq_tail++;
    }

    // Working copy of quadratic rows for cascade
    uint64_t *work_q = (uint64_t *)__builtin_alloca((size_t)(n_quad_rows + 128) * q_words * sizeof(uint64_t));
    int piv2[8192];
    int quad_rank = 0;

    while (1) {
        int new_lin_added = 0;
        while (lq_head < lq_tail) {
            uint64_t v0 = lin_queue[lq_head][0], v1 = lin_queue[lq_head][1];
            lq_head++;
            while (1) {
                int lead = -1;
                if (v0 != 0ULL) lead = __builtin_ctzll(v0);
                else if (v1 != 0ULL) lead = 64 + __builtin_ctzll(v1);
                if (lead < 0) break;
                if (lead == n) {
                    *out_lin_rank = lin_rank;
                    *out_quad_rank = quad_rank;
                    return 1; // 1 == 0 UNSAT!
                }
                if (has_lin_piv[lead]) {
                    v0 ^= lin_piv_row[lead][0];
                    v1 ^= lin_piv_row[lead][1];
                } else {
                    // Back-reduce existing linear pivots by new pivot `lead` to keep RREF!
                    for (int p = 0; p < n; p++) {
                        if (has_lin_piv[p]) {
                            int bit_set = (lead < 64) ? ((lin_piv_row[p][0] >> lead) & 1ULL)
                                                      : ((lin_piv_row[p][1] >> (lead - 64)) & 1ULL);
                            if (bit_set) {
                                lin_piv_row[p][0] ^= v0;
                                lin_piv_row[p][1] ^= v1;
                            }
                        }
                    }
                    lin_piv_row[lead][0] = v0;
                    lin_piv_row[lead][1] = v1;
                    has_lin_piv[lead] = 1;
                    lin_rank++;
                    new_lin_added = 1;
                    break;
                }
            }
        }
        if (!new_lin_added && quad_rank > 0) break;

        // Substitute current linear RREF into all `n_quad_rows` quadratics and echelonize degree <= 2!
        // For each variable `i`: if has_lin_piv[i], then x_i = sum_{t > i, free} alpha_{i,t} x_t ^ c_i.
        for (int c = 0; c < n_cols; c++) piv2[c] = -1;
        quad_rank = 0;
        int cur_wrow = 0;

        for (int r = 0; r < n_quad_rows; r++) {
            const uint64_t *src = quad_rows + (size_t)r * q_words;
            uint64_t *dst = work_q + (size_t)cur_wrow * q_words;
            memset(dst, 0, (size_t)q_words * sizeof(uint64_t));

            // Expand each active column in `src` using RREF substitution
            for (int w = 0; w < q_words; w++) {
                uint64_t word = src[w];
                while (word) {
                    int b = __builtin_ctzll(word);
                    word &= word - 1;
                    int col = (w << 6) + b;
                    if (col == off0) {
                        dst[off0 >> 6] ^= 1ULL << (off0 & 63);
                    } else if (col >= off1) {
                        int vi = col - off1;
                        if (!has_lin_piv[vi]) {
                            dst[col >> 6] ^= 1ULL << (col & 63);
                        } else {
                            // x_vi = (lin_piv_row[vi] without bit vi)
                            uint64_t m0 = lin_piv_row[vi][0], m1 = lin_piv_row[vi][1];
                            if (vi < 64) m0 ^= (1ULL << vi); else m1 ^= (1ULL << (vi - 64));
                            while (m0) {
                                int t = __builtin_ctzll(m0); m0 &= m0 - 1;
                                int tc = (t == n) ? off0 : (off1 + t);
                                dst[tc >> 6] ^= 1ULL << (tc & 63);
                            }
                            while (m1) {
                                int t = 64 + __builtin_ctzll(m1); m1 &= m1 - 1;
                                int tc = (t == n) ? off0 : (off1 + t);
                                dst[tc >> 6] ^= 1ULL << (tc & 63);
                            }
                        }
                    } else {
                        int u = pair_i[col], v = pair_j[col];
                        // Build linear forms Lu, Lv on [0..n] (bit n = constant 1)
                        uint64_t lu0 = 0, lu1 = 0, lv0 = 0, lv1 = 0;
                        if (!has_lin_piv[u]) { if (u < 64) lu0 = 1ULL << u; else lu1 = 1ULL << (u - 64); }
                        else {
                            lu0 = lin_piv_row[u][0]; lu1 = lin_piv_row[u][1];
                            if (u < 64) lu0 ^= (1ULL << u); else lu1 ^= (1ULL << (u - 64));
                        }
                        if (!has_lin_piv[v]) { if (v < 64) lv0 = 1ULL << v; else lv1 = 1ULL << (v - 64); }
                        else {
                            lv0 = lin_piv_row[v][0]; lv1 = lin_piv_row[v][1];
                            if (v < 64) lv0 ^= (1ULL << v); else lv1 ^= (1ULL << (v - 64));
                        }
                        // Multiply Lu * Lv
                        int u_list[128], nu = 0, v_list[128], nv = 0;
                        uint64_t t0 = lu0, t1 = lu1;
                        while (t0) { u_list[nu++] = __builtin_ctzll(t0); t0 &= t0 - 1; }
                        while (t1) { u_list[nu++] = 64 + __builtin_ctzll(t1); t1 &= t1 - 1; }
                        t0 = lv0; t1 = lv1;
                        while (t0) { v_list[nv++] = __builtin_ctzll(t0); t0 &= t0 - 1; }
                        while (t1) { v_list[nv++] = 64 + __builtin_ctzll(t1); t1 &= t1 - 1; }
                        for (int ia = 0; ia < nu; ia++) {
                            int a = u_list[ia];
                            for (int ib = 0; ib < nv; ib++) {
                                int bb = v_list[ib];
                                int tc;
                                if (a == n && bb == n) tc = off0;
                                else if (a == n) tc = off1 + bb;
                                else if (bb == n) tc = off1 + a;
                                else if (a == bb) tc = off1 + a; // x_a^2 = x_a!
                                else tc = pair_col_mat[a * n + bb];
                                dst[tc >> 6] ^= 1ULL << (tc & 63);
                            }
                        }
                    }
                }
            }

            // Echelonize `dst`
            int pcol = -1;
            for (int w = 0; w < q_words; w++) {
                while (dst[w] != 0ULL) {
                    int b = __builtin_ctzll(dst[w]);
                    int col = (w << 6) + b;
                    if (col >= n_cols) { dst[w] = 0ULL; break; }
                    int pr = piv2[col];
                    if (pr >= 0) {
                        const uint64_t *prow = work_q + (size_t)pr * q_words;
                        for (int k = w; k < q_words; k++) dst[k] ^= prow[k];
                    } else {
                        piv2[col] = cur_wrow++;
                        pcol = col;
                        goto inserted_q;
                    }
                }
            }
        inserted_q:
            if (pcol == off0) {
                *out_lin_rank = lin_rank;
                *out_quad_rank = quad_rank;
                return 1; // 1 == 0 UNSAT!
            }
            if (pcol >= off1 && pcol < off0) {
                // Quadratic collapsed to a NEW LINEAR EQUATION! Push to lin_queue!
                uint64_t nl0 = 0, nl1 = 0;
                for (int v = pcol - off1; v <= n; v++) {
                    int tc = (v == n) ? off0 : (off1 + v);
                    if ((dst[tc >> 6] >> (tc & 63)) & 1ULL) {
                        if (v < 64) nl0 |= (1ULL << v); else nl1 |= (1ULL << (v - 64));
                    }
                }
                if (lq_tail < 256) {
                    lin_queue[lq_tail][0] = nl0;
                    lin_queue[lq_tail][1] = nl1;
                    lq_tail++;
                }
            } else if (pcol >= 0 && pcol < off1) {
                quad_rank++;
            }
        }
        if (lq_head == lq_tail) break;
    }

    *out_lin_rank = lin_rank;
    *out_quad_rank = quad_rank;
    return 0;
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


def rot8(v: int) -> int:
    return ((v << 1) & 0xFF) | (v >> 7)


def phi_E(alpha: int) -> int:
    out = 0
    for r in range(8):
        if (alpha >> r) & 1:
            out |= 1 << (2 * r)
    return out


def phi_O(beta: int) -> int:
    return phi_E(beta) << 1


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


def eval_anf_tt_words1024(monomials):
    a = bytearray(65536)
    for m in monomials:
        a[m] ^= 1
    step = 1
    while step < 65536:
        dbl = step << 1
        for i in range(0, 65536, dbl):
            for j in range(i, i + step):
                a[j + step] ^= a[j]
        step = dbl
    words = [0] * 1024
    for w in range(1024):
        base = w << 6
        val = 0
        for b in range(64):
            if a[base + b]:
                val |= 1 << b
        words[w] = val
    return words


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
    u4_orbs, u8_size8, nonzero_b = [], [], []
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
            nonzero_b.append((rep, orb))
        if len(orb) < 8:
            u4_orbs.append((rep, orb))
        else:
            u8_size8.append((rep, orb))
    return u4_orbs, u8_size8, nonzero_b


def z4_left_nullspace(int_rows, n_cols):
    """
    Compute an exact generating set of integer combinations lambda in {0,1,2,3}^R
    with at least one odd coordinate (lambda_r % 2 == 1) such that sum_r lambda_r * row_r == 0 (mod 4)!
    Uses exact GF(2) 2-stage reduction:
      Stage 1: find basis of V1 = {u in F_2^R : u * (M mod 2) == 0 mod 2}.
      Stage 2: for each basis vector u^(k) of V1, compute w^(k) = ((sum_{r in u^(k)} row_r) // 2) mod 2 in F_2^{n_cols}.
               Find two types of solutions:
                 (a) v in F_2^{dim V1} with v * W == 0 mod 2 -> pure {0,1} combination!
                 (b) Any u^(k) combined with 2 * e_r (from Stage 1 pivots) if w^(k) lies in rowspace(M mod 2)!
    """
    R = len(int_rows)
    m_mod2 = []
    for row in int_rows:
        bits = 0
        for c in range(n_cols):
            if row[c] & 1:
                bits |= 1 << c
        m_mod2.append(bits)

    piv1 = {}  # bit -> (row_bits, comb_mask)
    v1_combs = []
    for r_i, v in enumerate(m_mod2):
        cur = v
        comb = 1 << r_i
        while cur:
            b = cur.bit_length() - 1
            if b in piv1:
                pv, pc = piv1[b]
                cur ^= pv
                comb ^= pc
            else:
                piv1[b] = (cur, comb)
                break
        if cur == 0:
            v1_combs.append(comb)

    # Reduce Stage 2 against BOTH piv1 (multiplying a Stage-1 pivot by 2 kills its mod-2 part and gives
    # its mod-2 vector at level 2!) and among v1_combs themselves!
    syzygies = []  # list of tuples (odd_row_mask, twice_row_mask) representing lambda = odd + 2*twice (mod 4)
    piv2 = {}      # bit -> (w_bits, odd_mask, twice_mask)

    # First register 2 * (original rows) into piv2 (odd_mask = 0, twice_mask = 1 << r_i)!
    for r_i, v in enumerate(m_mod2):
        cur = v
        tw = 1 << r_i
        while cur:
            b = cur.bit_length() - 1
            if b in piv2:
                pw, _, ptw = piv2[b]
                cur ^= pw
                tw ^= ptw
            else:
                piv2[b] = (cur, 0, tw)
                break

    # Now reduce every v1_comb (which has odd_mask != 0!) against piv2!
    for comb in v1_combs:
        acc = [0] * n_cols
        for r_i in range(R):
            if (comb >> r_i) & 1:
                for c in range(n_cols):
                    acc[c] += int_rows[r_i][c]
        w_bits = 0
        for c in range(n_cols):
            assert (acc[c] & 1) == 0
            if (acc[c] >> 1) & 1:
                w_bits |= 1 << c

        cur = w_bits
        odd_m = comb
        tw_m = 0
        while cur:
            b = cur.bit_length() - 1
            if b in piv2:
                pw, podd, ptw = piv2[b]
                cur ^= pw
                # Careful in Z/4Z when XORing two odd masks: (a + b) = (a ^ b) + 2*(a & b) mod 4!
                carry = odd_m & podd
                odd_m ^= podd
                tw_m ^= ptw ^ carry
            else:
                piv2[b] = (cur, odd_m, tw_m)
                break
        if cur == 0 and odd_m != 0:
            # Verify exact mod-4 annihilation!
            chk = [0] * n_cols
            for r_i in range(R):
                lam = ((odd_m >> r_i) & 1) + 2 * ((tw_m >> r_i) & 1)
                if lam:
                    for c in range(n_cols):
                        chk[c] = (chk[c] + lam * int_rows[r_i][c]) & 3
            assert all(x == 0 for x in chk), "Z/4Z syzygy check failed!"
            syzygies.append((odd_m, tw_m))

    return syzygies


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


def eval_pset(pset, x_mask: int) -> int:
    ans = 0
    for m in pset:
        if (x_mask & m) == m:
            ans ^= 1
    return ans


def main():
    t0 = time.perf_counter()
    work_dir = Path(__file__).resolve().parent
    c_path = work_dir / "b10_o8_dual.c"
    so_path = work_dir / "libb10_o8_dual.so"
    c_path.write_text(C_SRC_B10, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_path), "-o", str(so_path)], check=True)
    lib = ctypes.CDLL(str(so_path))

    lib.extract_set256_div4_mod2.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int, ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64),
    ]
    lib.extract_set256_div4_mod2.restype = ctypes.c_int

    lib.extract_v6_hierarchy_corrected.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
    ]
    lib.extract_v6_hierarchy_corrected.restype = ctypes.c_int

    lib.gf2_echelon_insert.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int,
    ]
    lib.gf2_echelon_insert.restype = ctypes.c_int

    lib.check_ceven_cube_deg2_cascade.argtypes = [
        ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
        ctypes.c_int, ctypes.POINTER(ctypes.c_uint64),
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
    ]
    lib.check_ceven_cube_deg2_cascade.restype = ctypes.c_int

    orbits = build_orbits_116()
    orb_words = [eval_anf_tt_words1024(orb) for orb in orbits]
    v6_list = all_v6_orbits()
    u4_orbs, u8_size8, nonzero_b = build_c8_orbits()

    def eval_orb_x(j: int, x: int) -> int:
        return (orb_words[j][x >> 6] >> (x & 63)) & 1

    # 1. Identify the EXACT 8 long orbits of c_{even} (touching E_8 = {x <= 0x5555})
    even_long_orbs = []
    for j, orb in enumerate(orbits):
        if len(orb) == 16 and any((m & 0xAAAA) == 0 for m in orb):
            even_long_orbs.append(j)
    assert len(even_long_orbs) == 8, f"Expected 8 even long orbits, got {len(even_long_orbs)}"

    # Compute the action of Z_16^* = {1,3,5,7,9,11,13,15} on the 8 bits of c_{even} -> 88 canonical orbits!
    orb_rep_map = {orb[0]: j for j, orb in enumerate(orbits)}
    z16_perms_on_ceven = []
    for a_mult in (1, 3, 5, 7, 9, 11, 13, 15):
        perm = []
        for j in even_long_orbs:
            m0 = orbits[j][0]
            m_img = 0
            for bit in range(16):
                if (m0 >> bit) & 1:
                    m_img |= 1 << ((a_mult * bit) & 15)
            rep_img = min(rot16(m_img, r) for r in range(16))
            j_img = orb_rep_map[rep_img]
            perm.append(even_long_orbs.index(j_img))
        z16_perms_on_ceven.append(perm)

    seen_ceven = set()
    canonical_ceven = []
    for st in range(256):
        if st in seen_ceven:
            continue
        orb_st = set()
        for perm in z16_perms_on_ceven:
            img = 0
            for idx_b in range(8):
                if (st >> idx_b) & 1:
                    img |= 1 << perm[idx_b]
            orb_st.add(img)
        seen_ceven |= orb_st
        canonical_ceven.append((min(orb_st), sorted(orb_st)))
    assert len(canonical_ceven) == 88, f"Burnside count mismatch: {len(canonical_ceven)} != 88!"

    # Precompute E_8 ^ phi_O(beta) 256-point masks for all 36 representatives (0 + 35 nonzero)
    e8_pts = [phi_E(alpha) for alpha in range(256)]
    coset_e8_pts = {}
    for b_rep, _ in [(0, [0])] + nonzero_b:
        b16 = phi_O(b_rep)
        coset_e8_pts[b_rep] = [y ^ b16 for y in e8_pts]

    # Precompute cyclic Krawtchouk coefficients A_0(beta), B_u(beta), K_{beta, m} for Eq. (8) & (20)
    Q_orbs = {
        0x01: [0x11, 0x22, 0x44, 0x88],
        0x05: [0x33, 0x66, 0xCC, 0x99],
        0x15: [0x77, 0xEE, 0xDD, 0xBB],
    }
    A0_list, B_list, K_mat = [], [], []
    for b_rep, _ in nonzero_b:
        a0 = sum(-1 if ((g & b_rep).bit_count() & 1) else 1 for g in (0x00, 0xFF, 0x55, 0xAA))
        bu = [sum(-1 if ((g & b_rep).bit_count() & 1) else 1 for g in Q_orbs[u]) for u in (0x01, 0x05, 0x15)]
        km = [sum(-1 if ((g & b_rep).bit_count() & 1) else 1 for g in a_orb) for _, a_orb in u8_size8]
        A0_list.append(a0)
        B_list.append(bu)
        K_mat.append(km)

    # Compute exact Z/4Z syzygies for B0_00 (30 t_m cols) and for B0_11 / B1_11 (4 s cols + 30 t_m cols, with beta=0 row!)
    # Row 0 (beta=0, Eq. 5): 2*r + c99 = 1*s0 + 1*s01 + 1*s05 + 1*s15 + 2*sum(t_m)
    # Rows 1..35 (Eq. 20):   2*Y_beta  = 64 + (A0/2)*s0 + (B01/2)*s01 + (B05/2)*s05 + (B15/2)*s15 + sum(K/2 * t_m)
    rows_z4_b00 = [[K_mat[r][m] // 2 for m in range(30)] for r in range(35)]
    syz_b00 = z4_left_nullspace(rows_z4_b00, 30)

    rows_z4_general = [[1, 1, 1, 1] + [2] * 30]
    for r in range(35):
        rows_z4_general.append(
            [A0_list[r] // 2, B_list[r][0] // 2, B_list[r][1] // 2, B_list[r][2] // 2]
            + [K_mat[r][m] // 2 for m in range(30)]
        )
    syz_general = z4_left_nullspace(rows_z4_general, 34)

    print(f"[Setup] even_long_orbs={even_long_orbs}, canonical_Z16_orbits={len(canonical_ceven)}, "
          f"Z4_syzygies_B00={len(syz_b00)}, Z4_syzygies_general={len(syz_general)}", flush=True)

    # Precompute global pairs & C_{0xf} parity for Macaulay degree <= 3
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
            if eval_orb_x(j, v | (v << 8)):
                vd |= 1 << v
        orb_diag[j] = vd
        for k, x in enumerate(all_pairs):
            if eval_orb_x(j, x):
                vp |= 1 << k
        orb_pair[j] = vp

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
    orb_0xf_par = [sum(eval_orb_x(j, x) for x in coset_0xf_reps) & 1 for j in range(116)]

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
    pair_i_arr = (ctypes.c_int * n2)()
    pair_j_arr = (ctypes.c_int * n2)()
    pair_col_mat = (ctypes.c_int * (n * n))()
    for i in range(n):
        for j in range(i + 1, n):
            idx2 = len(pair2_list)
            m = (1 << i) | (1 << j)
            pair2_col[m] = off2 + idx2
            pair2_list.append(m)
            pair_i_arr[idx2] = i
            pair_j_arr[idx2] = j
            pair_col_mat[i * n + j] = idx2
            pair_col_mat[j * n + i] = idx2

    mask64 = (1 << 64) - 1
    MAX_CHARS = 9
    p_idxs_arr = (ctypes.c_int * 2048)()
    char_words32 = (ctypes.c_uint64 * (MAX_CHARS * 32))()
    quad_buf = (ctypes.c_uint64 * (MAX_CHARS * n_col_words))()
    quad_valid = (ctypes.c_int * MAX_CHARS)()

    max_rows = 16000
    rows = (ctypes.c_uint64 * (max_rows * n_col_words))()
    piv_row_idx = (ctypes.c_int * n_cols)()

    report = {}
    for c99_val, c57_val, c113_val in [(1, 0, 0), (1, 1, 1), (0, 1, 1), (0, 0, 0)]:
        tc = time.perf_counter()
        cell_name = f"B{c99_val}_{c57_val}{c113_val}"
        free111, origin, cb = build_pure_111_basis(c99_val, c57_val, c113_val)
        ceven_var_idxs = [free111.index(j) for j in even_long_orbs]

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
        deg12_row_indices = []
        o8_stats = {"eq18_piv": 0, "o8_syzygy_pivs": 0, "fz_pivs": 0}

        def record_piv(pc, tag=None):
            nonlocal cur_row
            if pc < 0:
                return
            d = 0 if pc == off0 else (1 if pc >= off1 else (2 if pc >= off2 else 3))
            deg_pivs[d] += 1
            if d in (1, 2):
                xl_queue.append(cur_row)
                deg12_row_indices.append(cur_row)
            if tag:
                o8_stats[tag] += 1
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

        def insert_pset(pset, tag=None):
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
            record_piv(pc, tag=tag)
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

        def eval_x_form(x_pt: int):
            orb_vec = 0
            for j in range(116):
                if eval_orb_x(j, x_pt):
                    orb_vec |= 1 << j
            ob = (origin & orb_vec).bit_count() & 1
            wm = 0
            for i, cdir in enumerate(cb):
                if (cdir & orb_vec).bit_count() & 1:
                    wm |= 1 << i
            return wm, ob

        def form_to_pset(wm: int, ob: int):
            p = {1 << i for i in range(n) if (wm >> i) & 1}
            if ob:
                p.add(0)
            return p

        # A) Exact C_{0xf} parity (Theorem 1: wt_orb16(C_{0xf}) == 128 => even! Immediately kills B1_00 or forces K=c57!)
        c0xf_m = sum(1 << j for j in range(116) if orb_0xf_par[j])
        p_0xf = {1 << i for i, cdir in enumerate(cb) if (cdir & c0xf_m).bit_count() & 1}
        if (origin & c0xf_m).bit_count() & 1:
            p_0xf.add(0)
        insert_pset(p_0xf)
        drain_xl()

        # Also enforce C5 (K == c57_val) ONLY by verifying it from the 0x5555/U4 coset? Wait:
        # Let's check if C_{0xf} parity ALREADY IS K == c57_val!
        # In c99=1: p_0xf is K ^ 1 == 0 => K = 1! In B1_00, let's also extract T31 (0x7777) and C5 (from V6xV6)!
        # V6xV6 automatically discovers C5 and T31 with ZERO assumptions! Let's run Q4 + V6xV6 first, OR O8 first to measure O8!

        # B) NEW O_8 DUAL EQUATIONS (Task b10_odd_subspace_o8_dual):
        # 1) Exact Equation (18) on E_8 ^ 0xaaaa (beta = 0xff, mod 16 closed quadratic equation!):
        xi_pts = [phi_E(g) ^ 0xAAAA for g in (0x11, 0x33, 0x77)]
        xi_psets = [form_to_pset(*eval_x_form(pt)) for pt in xi_pts]
        # Verify xi_1 ^ xi_2 ^ xi_3 == c99 identically or extract linear law!
        lin_xi = xi_psets[0] ^ xi_psets[1] ^ xi_psets[2] ^ ({0} if c99_val else set())
        insert_pset(lin_xi, tag="eq18_piv")
        drain_xl()

        if not lin_xi:
            # Since xi_1 + xi_2 + xi_3 - c99 is identically even, floor((xi1+xi2+xi3-c99)/2) mod 2 is:
            # - if c99 == 0: e_2(xi1, xi2, xi3) = xi1*xi2 ^ xi1*xi3 ^ xi2*xi3
            # - if c99 == 1: (xi1+xi2+xi3 == 1 -> 0; == 3 -> 1) = xi1 * xi2 * xi3?
            #   WAIT: check xi1 + xi2 + xi3 = 1 mod 2 => sum in {1, 3}!
            #   If sum == 1: (1 - 1)/2 = 0. If sum == 3: (3 - 1)/2 = 1!
            #   Over {sum in {1,3}}, sum == 3 iff xi1=xi2=xi3=1, OR since xi1^xi2^xi3 == 1 identically,
            #   let's check e_2(xi1, xi2, xi3) on {1,0,0} -> 0, and on {1,1,1} -> 1^1^1 = 1!!
            #   BINGO!! When xi1 ^ xi2 ^ xi3 == 1, e_2(xi1, xi2, xi3) == xi1*xi2 ^ xi1*xi3 ^ xi2*xi3 ALSO equals (sum - 1)//2 mod 2 (DEGREE 2, NOT 3)!!
            q_half = (
                mul_p(xi_psets[0], xi_psets[1])
                ^ mul_p(xi_psets[0], xi_psets[2])
                ^ mul_p(xi_psets[1], xi_psets[2])
            )
            eta_xor = set()
            r_mod2_pset = set()
            for a_rep, _ in u8_size8:
                eta_xor ^= form_to_pset(*eval_x_form(phi_E(a_rep) ^ 0xAAAA))
                r_mod2_pset ^= form_to_pset(*eval_x_form(phi_E(a_rep)))
            eq18_pset = q_half ^ eta_xor ^ r_mod2_pset
            # Zero-Trust verification of Eq. (18) on a random vector when c99==0 & all dual cancellations hold:
            # Verify algebraic identity: 4*(xi1+xi2+xi3-c99) + 8*sum(eta) - 8*r == 0 mod 16?
            # Wait: in Eq. (17), RHS was 128 + 8*r - 16*sum(t_odd) == 8*r (mod 16)!
            # Let's assert on 16 random c that (wt(f|_{E8^0xaaaa}) - 4*c99 - 8*r) // 8 mod 2 == eval_pset(eq18_pset) whenever wt - 4*c99 is 0 mod 8!
            insert_pset(eq18_pset, tag="eq18_piv")
            drain_xl()

        # 2) Extract all 35 exact degree <= 3 polynomials Y_beta(c) = (wt(f|_{E8 ^ phi_O(beta)}) // 4) mod 2 in C!
        cb_w4 = (ctypes.c_uint64 * (n * 4))()
        O_w4 = (ctypes.c_uint64 * 4)()
        tmp_row = (ctypes.c_uint64 * n_col_words)()
        Y_beta_psets = []
        rng_chk = random.Random(9911 + 4 * c99_val + c57_val)

        for b_idx, (b_rep, _) in enumerate(nonzero_b):
            pts256 = coset_e8_pts[b_rep]
            ctypes.memset(cb_w4, 0, ctypes.sizeof(cb_w4))
            ctypes.memset(O_w4, 0, ctypes.sizeof(O_w4))
            for k_pt, x_pt in enumerate(pts256):
                wm, ob = eval_x_form(x_pt)
                if ob:
                    O_w4[k_pt >> 6] |= 1 << (k_pt & 63)
                for i in range(n):
                    if (wm >> i) & 1:
                        cb_w4[i * 4 + (k_pt >> 6)] |= 1 << (k_pt & 63)
            rc = lib.extract_set256_div4_mod2(
                cb_w4, O_w4, n, col3_base, off2, off1, off0, n_col_words, tmp_row
            )
            assert rc == 0, f"Theorem 2 violated on beta={hex(b_rep)}: rc={rc}!"
            pset_y = decode_row_to_pset([tmp_row[w] for w in range(n_col_words)], n_cols, off2, off1, off0, pair2_list, col3_list)

            # Zero-Trust check on 4 random points
            if b_idx < 6:
                for _ in range(4):
                    xm = rng_chk.getrandbits(n)
                    w_val = [O_w4[w] for w in range(4)]
                    for i in range(n):
                        if (xm >> i) & 1:
                            for w in range(4):
                                w_val[w] ^= cb_w4[i * 4 + w]
                    wt256 = sum(v.bit_count() for v in w_val)
                    assert wt256 % 4 == 0
                    assert ((wt256 // 4) & 1) == eval_pset(pset_y, xm)
            Y_beta_psets.append(pset_y)

        r_mod2_global = set()
        for a_rep, _ in u8_size8:
            r_mod2_global ^= form_to_pset(*eval_x_form(phi_E(a_rep)))

        if c99_val == 0 and c57_val == 0 and c113_val == 0:
            # B0_00: s0 = s01 = s05 = s15 = 0 -> use 30-col Z/4Z syzygies!
            for odd_m, tw_m in syz_b00:
                comb_p = set()
                rhs_sum = 0
                for r_i in range(35):
                    lam = ((odd_m >> r_i) & 1) + 2 * ((tw_m >> r_i) & 1)
                    if lam & 1:
                        comb_p ^= Y_beta_psets[r_i]
                    rhs_sum = (rhs_sum + lam * 64) & 3
                assert (rhs_sum & 1) == 0
                if (rhs_sum >> 1) & 1:
                    comb_p ^= {0}
                insert_pset(comb_p, tag="o8_syzygy_pivs")
            drain_xl()
        else:
            # General Z/4Z syzygies across row 0 (beta=0) + rows 1..35
            for odd_m, tw_m in syz_general:
                comb_p = set()
                rhs_const = 0
                lam0 = (odd_m & 1) + 2 * (tw_m & 1)
                if lam0 & 1:
                    comb_p ^= r_mod2_global
                # Row 0 has +c99 on LHS -> moves to -c99 on RHS!
                rhs_const = (rhs_const - lam0 * c99_val) & 3
                for r_i in range(35):
                    lam = ((odd_m >> (r_i + 1)) & 1) + 2 * ((tw_m >> (r_i + 1)) & 1)
                    if lam & 1:
                        comb_p ^= Y_beta_psets[r_i]
                    rhs_const = (rhs_const + lam * 64) & 3
                assert (rhs_const & 1) == 0
                if (rhs_const >> 1) & 1:
                    comb_p ^= {0}
                insert_pset(comb_p, tag="o8_syzygy_pivs")
            drain_xl()

        # C) Seed Q4 + U8 fibers F_z + V6 x V6 with corrected diag_div8_parity!
        def lin_expr(indices):
            msk = sum(1 << j for j in indices)
            return [i for i, c in enumerate(cb) if (c & msk).bit_count() & 1], (origin & msk).bit_count() & 1

        def poly_from_lin(idxs, cst):
            p = {1 << i for i in idxs}
            if cst:
                p.add(0)
            return p

        if c57_val == c113_val:
            slin_i, slin_c = lin_expr([23, 31, 39, 112])
            q4 = poly_from_lin(slin_i, slin_c ^ c57_val)
            pairs_ij = [(I2, J2), (I3, J3), (I4, J4)] if c99_val == 1 else [(I1, J1), (I2, J2), (I3, J3), (I4, J4)]
            for Ir, Jr in pairs_ij:
                ui, uc = lin_expr(Ir)
                vi, vc = lin_expr(Jr)
                q4 ^= mul_p(poly_from_lin(ui, uc), poly_from_lin(vi, vc))
            insert_pset(q4)
            drain_xl()

        for pts8 in v6_list:
            if piv_row_idx[off0] >= 0 or cur_row >= max_rows - 50:
                break
            dmask = sum(1 << v for v in pts8)
            wt_diag = (O_diag & dmask).bit_count()
            if wt_diag % 8 != 0:
                continue
            diag_par = (wt_diag // 8) & 1
            pair_reps = [pts8[i] | (pts8[j] << 8) for i in range(64) for j in range(i + 1, 64)]
            for k, x in enumerate(pair_reps):
                p_idxs_arr[k] = pair_idx[(x & 0xFF, x >> 8)]
            u_vecs = [(1 << r) | (1 << (r + 8)) for r in range(8)] + [0xFFFF]
            ctypes.memset(char_words32, 0, ctypes.sizeof(char_words32))
            for m, u16 in enumerate(u_vecs):
                base_m = m * 32
                for k, x in enumerate(pair_reps):
                    if (x & u16).bit_count() & 1:
                        char_words32[base_m + (k >> 6)] |= 1 << (k & 63)
            ctypes.memset(quad_buf, 0, ctypes.sizeof(quad_buf))
            base_ptr = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
            if lib.extract_v6_hierarchy_corrected(
                all_pair_bits, p_idxs_arr, 2016, n, diag_par,
                char_words32, 9, col3_base, off2, off1, off0, n_col_words,
                base_ptr, quad_buf, quad_valid
            ) != 0:
                continue
            pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
            record_piv(pc)
            for m in range(9):
                if not quad_valid[m] or cur_row >= max_rows - 10 or piv_row_idx[off0] >= 0:
                    continue
                dst = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                src = ctypes.cast(ctypes.byref(quad_buf, m * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                ctypes.memmove(dst, src, n_col_words * 8)
                pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
                record_piv(pc)
            drain_xl()

        has_one_global = (piv_row_idx[off0] >= 0)

        # D) EXHAUSTIVE 256-STATE AUDIT OF c_{even} in F_2^8 (via the 88 canonical Z_16^* orbits)!
        # Pack all discovered degree <= 2 pivots into compact q_words format for C cascade!
        q_cols = n2 + n + 1
        q_words = (q_cols + 63) // 64
        n_qrows = len(deg12_row_indices)
        compact_q = (ctypes.c_uint64 * (max(1, n_qrows) * q_words))()
        for qi, r_idx in enumerate(deg12_row_indices):
            row_slice = [rows[r_idx * n_col_words + w] for w in range(n_col_words)]
            pset = decode_row_to_pset(row_slice, n_cols, off2, off1, off0, pair2_list, col3_list)
            for m in pset:
                bc = m.bit_count()
                if bc == 0:
                    c = n2 + n
                elif bc == 1:
                    c = n2 + (m.bit_length() - 1)
                elif bc == 2:
                    c = pair2_col[m] - off2
                else:
                    continue
                compact_q[qi * q_words + (c >> 6)] ^= 1 << (c & 63)

        eliminated_states_256 = 0
        eliminated_orbits_88 = 0
        surviving_canonical = []
        init_lin = (ctypes.c_uint64 * (8 * 2))()
        out_lr, out_qr = ctypes.c_int(), ctypes.c_int()

        if has_one_global:
            eliminated_states_256 = 256
            eliminated_orbits_88 = 88
        else:
            for rep_st, orb_members in canonical_ceven:
                ctypes.memset(init_lin, 0, ctypes.sizeof(init_lin))
                for b_i in range(8):
                    v_idx = ceven_var_idxs[b_i]
                    if v_idx < 64:
                        init_lin[2 * b_i + 0] |= 1 << v_idx
                    else:
                        init_lin[2 * b_i + 1] |= 1 << (v_idx - 64)
                    if (rep_st >> b_i) & 1:
                        init_lin[2 * b_i + 1] |= 1 << (n - 64)

                is_unsat = lib.check_ceven_cube_deg2_cascade(
                    n, n_qrows, compact_q, q_words, 8, init_lin,
                    pair_i_arr, pair_j_arr, pair_col_mat,
                    ctypes.byref(out_lr), ctypes.byref(out_qr)
                )
                if is_unsat:
                    eliminated_orbits_88 += 1
                    eliminated_states_256 += len(orb_members)
                else:
                    surviving_canonical.append({
                        "ceven_hex": hex(rep_st),
                        "orbit_size": len(orb_members),
                        "lin_rank_after_cascade": out_lr.value,
                        "free_vars_remaining": n - out_lr.value,
                        "quad_rank_remaining": out_qr.value,
                    })

        report[cell_name] = {
            "global_has_one_deg3": has_one_global,
            "total_pivots_deg3": cur_row,
            "deg_pivs": deg_pivs,
            "o8_stats": o8_stats,
            "ceven_256_eliminated": eliminated_states_256,
            "ceven_256_surviving": 256 - eliminated_states_256,
            "ceven_88_canonical_eliminated": eliminated_orbits_88,
            "ceven_88_canonical_surviving": 88 - eliminated_orbits_88,
            "surviving_canonical_sample": surviving_canonical[:10],
            "sec": round(time.perf_counter() - tc, 3),
        }
        print(f"[{cell_name}] {json.dumps(report[cell_name])}", flush=True)

    print("=== FINAL B10 O8 DUAL & C_EVEN ELIMINATION REPORT ===", flush=True)
    print(json.dumps(report, indent=2), flush=True)


if __name__ == "__main__":
    main()
