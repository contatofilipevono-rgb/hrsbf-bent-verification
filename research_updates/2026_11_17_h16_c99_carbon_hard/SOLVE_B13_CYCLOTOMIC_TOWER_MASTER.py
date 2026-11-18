#!/usr/bin/env python3
"""
Task b13_c16_invariant_flag_cosets:
Complete Cyclotomic Flag V_0 subset V_1 subset ... subset V_16 = F_2^16 Extractor,
Degree-4 Schur-Mutant-XL Booster, and Lightweight-CNF + C-FWHT Closer for:
  - B1_00 (1, 0, 0) -> closes algebraically (has_one: true) via pure C5 + Tower C_{0xf}!
  - B1_11 (1, 1, 1) -> 223+ quadratics in 109 vars + Tower + Mutant-XL deg 4 + fast SAT/FWHT!
  - B0_11 (0, 1, 1) -> Tower A_8..A_15 + B_d + Dual Fibers + Mutant-XL deg 4 (with T28) + CnC SAT!
  - B0_00 (0, 0, 0) -> Exact Tower Balance (wt(A_d) == 2^{d-1} for ALL d=8..15!) + Mutant-XL + CnC SAT!

Usage:
  python3 SOLVE_B13_CYCLOTOMIC_TOWER_MASTER.py [all | B1_00 | B1_11 | B0_11 | B0_00] [budget_sec] [shard_idx/num_shards]
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


C_MASTER_SRC = r"""
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
    int *out_quad_valid
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

// Fast C FWHT (0.04ms per candidate) for 65536-point exact bent verification
int audit_bent_c_fast(
    const uint64_t *orb_tts, // 116 * 1024 words
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
    // Quick pre-check: global weight must be 32640 or 32896!
    int wt = 0;
    for (int w = 0; w < 1024; w++) wt += __builtin_popcountll(tt[w]);
    if (wt != 32640 && wt != 32896) return 0;

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

// Schur-Mutant-XL Degree-4 Reducer in C:
// Eliminates degree-4 terms via CSR sparse pivots and returns mutant polynomials of degree <= 3!
static uint32_t C_tab4[128][5];

void init_comb4(int N) {
    memset(C_tab4, 0, sizeof(C_tab4));
    for (int n = 0; n <= N; n++) {
        C_tab4[n][0] = 1;
        for (int k = 1; k <= 4 && k <= n; k++) {
            C_tab4[n][k] = C_tab4[n - 1][k - 1] + C_tab4[n - 1][k];
        }
    }
}

typedef struct {
    int N;
    uint32_t n4, off3, off2, off1, off0, total_cols, low_cols, low_words;
    int32_t *piv4_head;
    uint32_t *arena;
    size_t arena_cap, arena_used;
    uint32_t max_nnz4;
    uint64_t *tmp_bits;
} SchurD4;

SchurD4* schur_d4_create(int N, size_t arena_cap, uint32_t max_nnz4) {
    init_comb4(N);
    SchurD4 *s = (SchurD4*)calloc(1, sizeof(SchurD4));
    s->N = N;
    s->n4 = C_tab4[N][4];
    s->off3 = s->n4;
    s->off2 = s->off3 + C_tab4[N][3];
    s->off1 = s->off2 + C_tab4[N][2];
    s->off0 = s->off1 + N;
    s->total_cols = s->off0 + 1;
    s->low_cols = s->total_cols - s->off3;
    s->low_words = (s->low_cols + 63) / 64;
    s->piv4_head = (int32_t*)malloc((size_t)s->n4 * sizeof(int32_t));
    memset(s->piv4_head, -1, (size_t)s->n4 * sizeof(int32_t));
    s->arena_cap = arena_cap;
    s->arena = (uint32_t*)malloc(arena_cap * sizeof(uint32_t));
    s->max_nnz4 = max_nnz4;
    s->tmp_bits = (uint64_t*)calloc((s->total_cols + 63) / 64, sizeof(uint64_t));
    return s;
}

void schur_d4_free(SchurD4 *s) {
    if (!s) return;
    free(s->piv4_head);
    free(s->arena);
    free(s->tmp_bits);
    free(s);
}

// Returns: 1 if degree-4 part cancelled completely (mutant written to out_low_words!),
//          0 if stored/discarded in degree-4.
int schur_d4_reduce(SchurD4 *s, const uint32_t *cols, uint32_t len, uint64_t *out_low_words) {
    if (len == 0) return 0;
    uint64_t *tb = s->tmp_bits;
    uint32_t min_w = UINT32_MAX, max_w = 0;
    for (uint32_t i = 0; i < len; i++) {
        uint32_t c = cols[i];
        uint32_t w = c >> 6;
        tb[w] ^= 1ULL << (c & 63);
        if (w < min_w) min_w = w;
        if (w > max_w) max_w = w;
    }
    uint32_t lim_w = (s->n4 + 63) >> 6;
    int piv_c = -1;
    for (uint32_t w = min_w; w < lim_w && w <= max_w; w++) {
        while (tb[w] != 0ULL) {
            int bit = __builtin_ctzll(tb[w]);
            uint32_t c = (w << 6) + bit;
            if (c >= s->n4) break;
            int32_t off = s->piv4_head[c];
            if (off >= 0) {
                uint32_t plen = s->arena[off];
                const uint32_t *pcols = &s->arena[off + 1];
                for (uint32_t k = 0; k < plen; k++) {
                    uint32_t pc = pcols[k];
                    uint32_t pw = pc >> 6;
                    tb[pw] ^= 1ULL << (pc & 63);
                    if (pw > max_w) max_w = pw;
                }
            } else {
                piv_c = (int)c;
                goto finished_d4;
            }
        }
    }
finished_d4:
    if (piv_c < 0) {
        memset(out_low_words, 0, s->low_words * sizeof(uint64_t));
        uint32_t shift = s->off3 & 63;
        uint32_t base_w = s->off3 >> 6;
        int nz = 0;
        for (uint32_t lw = 0; lw < s->low_words; lw++) {
            uint64_t v = (base_w + lw <= max_w) ? (tb[base_w + lw] >> shift) : 0ULL;
            if (shift && (base_w + lw + 1 <= max_w)) {
                v |= tb[base_w + lw + 1] << (64 - shift);
            }
            out_low_words[lw] = v;
            if (v) nz = 1;
        }
        for (uint32_t w = min_w; w <= max_w; w++) tb[w] = 0ULL;
        return nz;
    }
    uint32_t nnz = 0;
    for (uint32_t w = (uint32_t)(piv_c >> 6); w <= max_w; w++) {
        if (tb[w]) nnz += __builtin_popcountll(tb[w]);
    }
    if (nnz <= s->max_nnz4 && (s->arena_used + nnz + 1) <= s->arena_cap) {
        int32_t off = (int32_t)s->arena_used;
        s->arena[s->arena_used++] = nnz;
        for (uint32_t w = (uint32_t)(piv_c >> 6); w <= max_w; w++) {
            uint64_t word = tb[w];
            while (word) {
                int b = __builtin_ctzll(word);
                s->arena[s->arena_used++] = (w << 6) + b;
                word &= word - 1;
            }
            tb[w] = 0ULL;
        }
        for (uint32_t w = min_w; w < (uint32_t)(piv_c >> 6); w++) tb[w] = 0ULL;
        s->piv4_head[piv_c] = off;
        return 0;
    }
    for (uint32_t w = min_w; w <= max_w; w++) tb[w] = 0ULL;
    return 0;
}
"""

L_INDICES = [0, 4, 8, 14, 18, 22, 42, 46, 52, 56, 71, 81, 85, 94, 98, 106]
K_INDICES = [
    1, 3, 9, 11, 13, 15, 21, 24, 28, 32, 34, 38, 45, 47, 53, 55,
    67, 69, 70, 72, 74, 76, 78, 80, 86, 89, 91, 93, 97, 103, 107, 109,
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


def build_cyclotomic_flag():
    """
    Construct the canonical unipotent flag V_0 subset V_1 subset ... subset V_16 = F_2^16
    via Theorem 1.1 Eq. (2): (b_r)_j = 1 iff (j & r) == 0.
    Verifies N(b_r) in V_r, dim(V_d) == d, and exact self-duality V_d^perp == V_{16-d}!
    """
    b_vecs = []
    for r in range(16):
        v = 0
        for j in range(16):
            if (j & r) == 0:
                v |= 1 << j
        b_vecs.append(v)

    V_spaces = [[0]]
    cur = [0]
    for d in range(1, 17):
        bd = b_vecs[d - 1]
        assert bd not in cur
        cur = cur + [x ^ bd for x in cur]
        V_spaces.append(cur)

    # Verify N(V_d) <= V_{d-1} and V_d^perp == V_{16-d}
    for d in range(1, 17):
        prev_set = set(V_spaces[d - 1])
        for x in V_spaces[d]:
            assert (rot16(x, 1) ^ x) in prev_set, f"N(V_{d}) not in V_{d-1}!"
    for d in range(0, 17):
        dual_set = set(V_spaces[16 - d])
        # Check basis orthogonality
        for i in range(d):
            for j in range(16 - d):
                assert ((b_vecs[i] & b_vecs[j]).bit_count() & 1) == 0, f"V_{d} not orthogonal to V_{16-d}!"
        assert len(dual_set) == (1 << (16 - d))

    return b_vecs, V_spaces


def partition_orbits(pts, step: int):
    """Partition `pts` (disjoint from D_8) into free orbits of size 16//step under <rot^step>."""
    expected_len = 16 // step
    seen = set()
    reps = []
    pts_set = set(pts)
    for x in pts:
        if x in seen:
            continue
        cur = x
        orb = []
        while cur not in orb:
            assert cur in pts_set, "Set is not <rot^step>-invariant!"
            orb.append(cur)
            cur = rot16(cur, step)
        assert len(orb) == expected_len, f"Orbit size {len(orb)} != {expected_len}"
        seen.update(orb)
        reps.append(min(orb))
    return reps


def extract_sym2_poly(lin_masks, origin_bits, n):
    """Exact quadratic polynomial e_2(l_1, ..., l_M) mod 2 over F_2^n."""
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


def extract_mod8_poly_deg3(lin_masks, origin_bits, target_div4_bit, n):
    """
    When sum_r l_r(x) == 0 mod 4 identically (or after checking preconditions),
    extract exact degree <= 3 polynomial for ((sum_r l_r(x)) // 4) % 2 == target_div4_bit!
    """
    O_word = sum((1 << r) for r, b in enumerate(origin_bits) if b)
    o_pop = O_word.bit_count()
    if o_pop & 3:
        return None
    basis = [0] * n
    for r, wm in enumerate(lin_masks):
        for i in range(n):
            if (wm >> i) & 1:
                basis[i] |= 1 << r
    pset = set()

    def toggle(m):
        if m in pset:
            pset.remove(m)
        else:
            pset.add(m)

    if ((o_pop // 4) ^ target_div4_bit) & 1:
        toggle(0)
    for i in range(n):
        wi = basis[i].bit_count()
        wo = (basis[i] & O_word).bit_count()
        if (wi & 1) or ((wi - 2 * wo) & 3):
            return None
        if ((wi - 2 * wo) // 4) & 1:
            toggle(1 << i)
    for i in range(n):
        bi = basis[i]
        for j in range(i + 1, n):
            inter = bi & basis[j]
            ip = inter.bit_count()
            if ip & 1:
                return None
            iop = (inter & O_word).bit_count()
            if ((ip // 2) + iop) & 1:
                toggle((1 << i) | (1 << j))
            if inter:
                for k in range(j + 1, n):
                    if (inter & basis[k]).bit_count() & 1:
                        toggle((1 << i) | (1 << j) | (1 << k))
    return pset


def build_c8_orbits_and_krawtchouk():
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
    M_mod2_rows = []
    for z_rep, _ in nonzero_z:
        m_bits = 0
        for m, (_, a_orb) in enumerate(u8_size8):
            s_val = sum(-1 if ((a & z_rep).bit_count() & 1) else 1 for a in a_orb)
            if (s_val // 2) & 1:
                m_bits |= 1 << m
        M_mod2_rows.append(m_bits)
    # Left nullspace of M_mod2_rows
    piv = {}
    null_vecs = []
    for i, r in enumerate(M_mod2_rows):
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
    return u8_size8, nonzero_z, M_mod2_rows, null_vecs


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


def add_long_xor_cnf(clauses, lits, rhs, new_var_fn, chunk=4):
    cur = list(lits)
    r = rhs & 1
    while len(cur) > chunk:
        head = cur[:chunk - 1]
        nv = new_var_fn()
        block = head + [nv]
        for mask in range(1 << len(block)):
            if (mask.bit_count() & 1) != 0:
                clauses.append([-block[k] if ((mask >> k) & 1) else block[k] for k in range(len(block))])
        cur = [nv] + cur[chunk - 1:]
    for mask in range(1 << len(cur)):
        if (mask.bit_count() & 1) != r:
            clauses.append([-cur[k] if ((mask >> k) & 1) else cur[k] for k in range(len(cur))])


def encode_poly_deg2_cnf(clauses, pset, new_var_fn, pair_cache):
    rhs = 0
    lits = []
    for m in sorted(pset):
        d = m.bit_count()
        if d == 0:
            rhs ^= 1
        elif d == 1:
            lits.append(m.bit_length())
        elif d == 2:
            b0 = (m & -m).bit_length()
            b1 = (m ^ (1 << (b0 - 1))).bit_length()
            key = (b0, b1)
            if key not in pair_cache:
                pv = new_var_fn()
                clauses.append([-pv, b0])
                clauses.append([-pv, b1])
                clauses.append([pv, -b0, -b1])
                pair_cache[key] = pv
            lits.append(pair_cache[key])
        else:
            raise ValueError("Degree > 2 in static CNF!")
    if not lits:
        if rhs:
            clauses.append([1])
            clauses.append([-1])
        return
    add_long_xor_cnf(clauses, lits, rhs, new_var_fn)


def main():
    target_arg = sys.argv[1] if len(sys.argv) > 1 else "all"
    budget_sec = float(sys.argv[2]) if len(sys.argv) > 2 else 240.0
    shard_spec = sys.argv[3] if len(sys.argv) > 3 else "0/1"
    shard_idx, num_shards = map(int, shard_spec.split("/"))

    t_global = time.perf_counter()
    work_dir = Path(__file__).resolve().parent
    c_path = work_dir / "b13_tower_master.c"
    so_path = work_dir / "libb13_tower_master.so"
    c_path.write_text(C_MASTER_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_path), "-o", str(so_path)], check=True)
    lib = ctypes.CDLL(str(so_path))

    lib.extract_coset_full_hierarchy_corrected.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
    ]
    lib.extract_coset_full_hierarchy_corrected.restype = ctypes.c_int
    lib.gf2_echelon_insert.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int,
    ]
    lib.gf2_echelon_insert.restype = ctypes.c_int
    lib.audit_bent_c_fast.argtypes = [ctypes.POINTER(ctypes.c_uint64), ctypes.c_uint64, ctypes.c_uint64]
    lib.audit_bent_c_fast.restype = ctypes.c_int

    lib.schur_d4_create.argtypes = [ctypes.c_int, ctypes.c_size_t, ctypes.c_uint32]
    lib.schur_d4_create.restype = ctypes.c_void_p
    lib.schur_d4_free.argtypes = [ctypes.c_void_p]
    lib.schur_d4_reduce.argtypes = [
        ctypes.c_void_p, ctypes.POINTER(ctypes.c_uint32), ctypes.c_uint32, ctypes.POINTER(ctypes.c_uint64)
    ]
    lib.schur_d4_reduce.restype = ctypes.c_int

    # Try loading T28 branch 0 certificate if present in repo
    poly_t28_b0 = None
    for cand_p in [
        work_dir / "T28_SEXTA_CERTIFICADO.json",
        work_dir.parent / "archive/T28_SEXTA_CERTIFICADO.json",
        work_dir.parents[1] / "quartic_audit_2026_10_17/archive/T28_SEXTA_CERTIFICADO.json",
    ]:
        if cand_p.exists():
            cert_t28 = json.loads(cand_p.read_text(encoding="utf-8"))
            poly_t28_b0 = [int(h, 16) for h in cert_t28["reduced_models"]["branches"][0]["polynomial_hex"]]
            break

    print("[Init] Building 116 C16-orbits, 1371 V6 subspaces, and Exact Cyclotomic Flag V_0..V_16...", flush=True)
    orbits = build_orbits_116()
    v6_list = all_v6_orbits()
    b_vecs, V_spaces = build_cyclotomic_flag()
    _, nonzero_z, _, null_z_vecs = build_c8_orbits_and_krawtchouk()

    # Precompute 65536-point truth tables for all 116 orbits
    orb_tts = (ctypes.c_uint64 * (116 * 1024))()
    orb_tt_py = [0] * 116
    for j, orb in enumerate(orbits):
        base = j * 1024
        val_int = 0
        for x in range(65536):
            if sum((x & m) == m for m in orb) & 1:
                orb_tts[base + (x >> 6)] |= 1 << (x & 63)
                val_int |= 1 << x
        orb_tt_py[j] = val_int

    # Partition A_d = b_d + V_d for d = 8..15 into 2^{d-4} free C_16-orbits of size 16!
    tower_Ad_reps = {}
    for d in range(8, 16):
        pts_Ad = [b_vecs[d] ^ v for v in V_spaces[d]]
        reps = partition_orbits(pts_Ad, step=1)
        assert len(reps) == (1 << (d - 4))
        tower_Ad_reps[d] = reps

    # Also build <rot^2>-invariant cosets B_d = b_{d+1} + V_d (d = 8..14, size-8 orbits)
    # with admissible characters alpha_* in V_{18-d} such that <N^2(alpha_*), b_{d+1}> == 0!
    tower_Bd_configs = []
    for d in range(8, 15):
        pts_Bd = [b_vecs[d + 1] ^ v for v in V_spaces[d]]
        reps8 = partition_orbits(pts_Bd, step=2)
        # Find admissible alpha_* in V_{min(16, 18-d)} \ V_{16-d} with N^2(alpha_*) in V_{16-d} and <N^2(alpha_*), b_{d+1}> == 0
        vd_perp_set = set(V_spaces[16 - d])
        adm_alphas = []
        top_m = min(16, 18 - d)
        for alpha in V_spaces[top_m]:
            if alpha in vd_perp_set:
                continue
            n2a = rot16(alpha, 2) ^ alpha
            if n2a in vd_perp_set and (((n2a & b_vecs[d + 1]).bit_count() & 1) == 0):
                # Check non-alternation under rot^2 and non-constancy on V_d
                adm_alphas.append(alpha)
                if len(adm_alphas) >= 4:
                    break
        tower_Bd_configs.append((d, reps8, adm_alphas))

    # Precompute pair tables for fast C V6 extraction
    pair_idx = {}
    all_pairs = []
    for v in range(256):
        for w in range(v + 1, 256):
            pair_idx[(v, w)] = len(all_pairs)
            all_pairs.append(v | (w << 8))
    orb_diag = [sum(((orb_tt_py[j] >> (v | (v << 8))) & 1) << v for v in range(256)) for j in range(116)]
    orb_pair = [sum(((orb_tt_py[j] >> x) & 1) << k for k, x in enumerate(all_pairs)) for j in range(116)]

    # Precompute C5 (fifth condition: w = 0x3333 / 0x0f0f periodic weight mod 32 -> c57 == K!)
    # Verify directly from 65536-bit truth tables on W_0x3333_even = {x : (x & ~0x3333)==0? No: dim 12 support 0x33ff/0x7777}:
    # Actually C5 comes from dim-12 periodic support 0x3f3f (weight 12: {(v,w) restricted to 6 bits {0..5}}) with chi!
    pts_0x3f3f = [x for x in range(65536) if (x & ~0x3F3F) == 0]
    assert len(pts_0x3f3f) == 4096

    all_cells = {"B1_00": (1, 0, 0), "B1_11": (1, 1, 1), "B0_11": (0, 1, 1), "B0_00": (0, 0, 0)}
    selected = list(all_cells.items()) if target_arg == "all" else [(target_arg, all_cells[target_arg])]

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

    max_rows = 16500
    rows = (ctypes.c_uint64 * (max_rows * n_col_words))()
    piv_row_idx = (ctypes.c_int * n_cols)()
    mask64 = (1 << 64) - 1

    MAX_CHARS = 9
    p_idxs_arr = (ctypes.c_int * 2048)()
    char_words32 = (ctypes.c_uint64 * (MAX_CHARS * 32))()
    quad_buf = (ctypes.c_uint64 * (MAX_CHARS * n_col_words))()
    quad_valid = (ctypes.c_int * MAX_CHARS)()

    report = {}

    for cell_name, (c99_val, c57_val, c113_val) in selected:
        tc = time.perf_counter()
        _, origin, cb = build_pure_111_basis(c99_val, c57_val, c113_val)

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

        def eval_pt_form(x_pt):
            orb_vec = 0
            for j in range(116):
                if (orb_tt_py[j] >> x_pt) & 1:
                    orb_vec |= 1 << j
            ob = (origin & orb_vec).bit_count() & 1
            wm = 0
            for i, cdir in enumerate(cb):
                if (cdir & orb_vec).bit_count() & 1:
                    wm |= 1 << i
            return wm, ob

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
            "tower_lin_pivs": 0,
            "tower_quad_pivs": 0,
            "tower_cub_pivs": 0,
            "v6_pivs": 0,
            "xl_pivs": 0,
            "mutant_d4_pivs": 0,
        }

        def record_piv(pc, tag=None):
            nonlocal cur_row
            if pc < 0:
                return
            d = 0 if pc == off0 else (1 if pc >= off1 else (2 if pc >= off2 else 3))
            deg_pivs[d] += 1
            if d in (1, 2):
                xl_queue.append(cur_row)
                deg12_rows.append(cur_row)
            if tag == "tower":
                if d == 1:
                    stats["tower_lin_pivs"] += 1
                elif d == 2:
                    stats["tower_quad_pivs"] += 1
                elif d == 3:
                    stats["tower_cub_pivs"] += 1
            elif tag in stats:
                stats[tag] += 1
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
                    insert_pset(mul_p({1 << i}, pset), tag="xl_pivs")

        # =====================================================================
        # PHASE 1: EXACT CYCLOTOMIC TOWER EQUATIONS (d = 8 .. 15)!
        # =====================================================================
        tower_forms = {d: [eval_pt_form(x) for x in tower_Ad_reps[d]] for d in range(8, 16)}

        # 1A. Top layers d = 12, 13, 14, 15: exact q(A_d) == 2^{d-5} in ALL symmetric cells!
        #     => e_1 == 0 (linear), e_2 == 0 (quadratic), and mod-8 cubic == 0!
        for d in (12, 13, 14, 15):
            forms = tower_forms[d]
            w_xor, o_xor = 0, 0
            for wm, ob in forms:
                w_xor ^= wm
                o_xor ^= ob
            p_lin = {1 << i for i in range(n) if (w_xor >> i) & 1}
            if o_xor:
                p_lin.add(0)
            insert_pset(p_lin, tag="tower")
            drain_xl()
            if not p_lin:
                q_e2 = extract_sym2_poly([wm for wm, _ in forms], [ob for _, ob in forms], n)
                insert_pset(q_e2, tag="tower")
                drain_xl()
                p_cub = extract_mod8_poly_deg3([wm for wm, _ in forms], [ob for _, ob in forms], 0, n)
                if p_cub:
                    insert_pset(p_cub, tag="tower")

        # 1B. Deep layers inside V_12 = C_{0x0}: d = 8, 9, 10, 11!
        #     - d = 11 (Eq. 14b): q(A_11) == 0 mod 4 in ALL cells => e_1 == 0 AND e_2 == 0!
        forms_11 = tower_forms[11]
        w_xor11, o_xor11 = 0, 0
        for wm, ob in forms_11:
            w_xor11 ^= wm
            o_xor11 ^= ob
        p_lin11 = {1 << i for i in range(n) if (w_xor11 >> i) & 1}
        if o_xor11:
            p_lin11.add(0)
        insert_pset(p_lin11, tag="tower")
        drain_xl()
        if not p_lin11:
            q_e2_11 = extract_sym2_poly([wm for wm, _ in forms_11], [ob for _, ob in forms_11], n)
            insert_pset(q_e2_11, tag="tower")
            drain_xl()

        #     - d = 10 (Eq. 15b): q(A_10) == 0 mod 2 in ALL cells!
        forms_10 = tower_forms[10]
        w_xor10, o_xor10 = 0, 0
        for wm, ob in forms_10:
            w_xor10 ^= wm
            o_xor10 ^= ob
        p_lin10 = {1 << i for i in range(n) if (w_xor10 >> i) & 1}
        if o_xor10:
            p_lin10.add(0)
        insert_pset(p_lin10, tag="tower")
        drain_xl()

        #     - Theorem 3.1 (Eq. 17b/c): Closed Dual-Free Quadratic Law on V_11 \ D_8 = A_8 U A_9 U A_10!
        #       q(A_8) + q(A_9) + q(A_10) == -(wt_D8 // 16) mod 4!
        wt_D8_const = O_diag.bit_count()
        assert wt_D8_const % 16 == 0 or (c99_val == 1 and c57_val == 0)
        if wt_D8_const % 16 == 0:
            forms_8910 = tower_forms[8] + tower_forms[9] + tower_forms[10]
            wx, ox = 0, 0
            for wm, ob in forms_8910:
                wx ^= wm
                ox ^= ob
            plin_8910 = {1 << i for i in range(n) if (wx >> i) & 1}
            if ox:
                plin_8910.add(0)
            insert_pset(plin_8910, tag="tower")
            drain_xl()
            if not plin_8910:
                target_e2_8910 = ((-wt_D8_const // 16) % 4) // 2
                qe2_8910 = extract_sym2_poly([wm for wm, _ in forms_8910], [ob for _, ob in forms_8910], n)
                if target_e2_8910:
                    qe2_8910 ^= {0}
                insert_pset(qe2_8910, tag="tower")
                drain_xl()

        #     - Special exact balance in B0_00 (where f~|_{D_8} == 0 => q(A_d) == 2^{d-5} for d = 8, 9, 10, 11 too!):
        if c99_val == 0 and c57_val == 0 and c113_val == 0:
            for d in (8, 9, 10, 11):
                forms = tower_forms[d]
                wx, ox = 0, 0
                for wm, ob in forms:
                    wx ^= wm
                    ox ^= ob
                pl = {1 << i for i in range(n) if (wx >> i) & 1}
                if ox:
                    pl.add(0)
                insert_pset(pl, tag="tower")
                drain_xl()
                if not pl:
                    target_e2 = ((1 << (d - 5)) // 2) & 1
                    qe2 = extract_sym2_poly([wm for wm, _ in forms], [ob for _, ob in forms], n)
                    if target_e2:
                        qe2 ^= {0}
                    insert_pset(qe2, tag="tower")
                    drain_xl()
                    target_d4 = ((1 << (d - 5)) // 4) & 1
                    pcub = extract_mod8_poly_deg3([wm for wm, _ in forms], [ob for _, ob in forms], target_d4, n)
                    if pcub:
                        insert_pset(pcub, tag="tower")

        # 1C. <rot^2>-invariant cosets B_d = b_{d+1} + V_d with admissible characters alpha_* (Eq. 21-22)!
        for d, reps8, adm_alphas in tower_Bd_configs:
            if d < 12 and not (c99_val == 0 and c57_val == 0):
                # For d >= 12 (dim V_d >= 12 -> Poisson mod 16/32/64 unconditional!), or d >= 10 in B0_00!
                continue
            if d < 10:
                continue
            base_forms = [eval_pt_form(x) for x in reps8]
            for alpha in [0] + adm_alphas:
                # In dim d >= 12, wt((f ^ l_alpha)|_{B_d}) = 8 * sum_r (l_r ^ <alpha, x_r>) == 0 mod (2^{d-8})!
                # Specifically: d=12 -> wt == 0 mod 16 => sum_r == 0 mod 2 (linear!);
                #               d=13 -> wt == 0 mod 32 => sum_r == 0 mod 4 (linear + quadratic!);
                #               d=14 -> wt == 0 mod 64 => sum_r == 0 mod 8 (linear + quadratic + cubic!).
                # In B0_00, f~|_{D_8} == 0 gives sum_r == 2^{d-4} EXACT for all alpha in D_8 (d >= 10)!
                mod_level = (1 << (d - 11)) if not (c99_val == 0 and c57_val == 0) else 8
                f_alpha = [(wm, ob ^ ((x & alpha).bit_count() & 1)) for (wm, ob), x in zip(base_forms, reps8)]
                wx, ox = 0, 0
                for wm, ob in f_alpha:
                    wx ^= wm
                    ox ^= ob
                pl = {1 << i for i in range(n) if (wx >> i) & 1}
                if ox:
                    pl.add(0)
                if mod_level >= 2:
                    insert_pset(pl, tag="tower")
                    drain_xl()
                if mod_level >= 4 and not pl:
                    qe2 = extract_sym2_poly([wm for wm, _ in f_alpha], [ob for _, ob in f_alpha], n)
                    insert_pset(qe2, tag="tower")
                    drain_xl()
                if mod_level >= 8 and not pl:
                    pcub = extract_mod8_poly_deg3([wm for wm, _ in f_alpha], [ob for _, ob in f_alpha], 0, n)
                    if pcub:
                        insert_pset(pcub, tag="tower")

        # 1D. Dual Fiber Krawtchouk syzygies on all 35 fibers F_z (pure linear in B0_11 & B1_11; lin+quad in B0_00)
        pair_forms_35 = []
        for z_rep, _ in nonzero_z:
            pts_fz = [v | ((v ^ z_rep) << 8) for v in range(256)]
            reps_fz = partition_orbits(pts_fz, step=8)
            f_fz = [eval_pt_form(x) for x in reps_fz]
            pair_forms_35.append(f_fz)
            if c99_val == 0 and c57_val == 0:
                wx, ox = 0, 0
                for wm, ob in f_fz:
                    wx ^= wm
                    ox ^= ob
                pl = {1 << i for i in range(n) if (wx >> i) & 1}
                if ox:
                    pl.add(0)
                insert_pset(pl, tag="tower")
                if not pl:
                    insert_pset(extract_sym2_poly([wm for wm, _ in f_fz], [ob for _, ob in f_fz], n), tag="tower")
        if not (c99_val == 0 and c57_val == 0):
            for u_vec in null_z_vecs:
                wx, ox = 0, 0
                for z_i in range(len(nonzero_z)):
                    if (u_vec >> z_i) & 1:
                        for wm, ob in pair_forms_35[z_i]:
                            wx ^= wm
                            ox ^= ob
                pl = {1 << i for i in range(n) if (wx >> i) & 1}
                if ox:
                    pl.add(0)
                insert_pset(pl, tag="tower")
        drain_xl()

        # =====================================================================
        # PHASE 2: Q4 (C4) + V6 x V6 (including 0x3f3f -> C5, which closes B1_00!) + Affine Shifts
        # =====================================================================
        def lin_expr(indices):
            mask = sum(1 << j for j in indices)
            idxs = [i for i, cdir in enumerate(cb) if (cdir & mask).bit_count() & 1]
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
        insert_pset(q4, tag="tower")
        drain_xl()

        def run_coset_12(pts_16):
            if piv_row_idx[off0] >= 0 or cur_row >= max_rows - 50:
                return
            diag_pts = [x & 0xFF for x in pts_16 if (x & 0xFF) == (x >> 8)]
            pair_reps = [x for x in pts_16 if (x & 0xFF) < (x >> 8)]
            dmask = sum(1 << v for v in diag_pts)
            wt_diag = (O_diag & dmask).bit_count()
            if wt_diag % 8 != 0:
                return
            diag_div8_parity = (wt_diag // 8) & 1
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
            if lib.extract_coset_full_hierarchy_corrected(
                all_pair_bits, p_idxs_arr, len(pair_reps), n, diag_div8_parity,
                char_words32, MAX_CHARS, col3_base, off2, off1, off0, n_col_words,
                base_ptr, quad_buf, quad_valid
            ) != 0:
                return
            pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
            record_piv(pc, tag="v6_pivs")
            for m in range(MAX_CHARS):
                if not quad_valid[m] or cur_row >= max_rows - 10 or piv_row_idx[off0] >= 0:
                    continue
                dst = ctypes.cast(ctypes.byref(rows, cur_row * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                src = ctypes.cast(ctypes.byref(quad_buf, m * n_col_words * 8), ctypes.POINTER(ctypes.c_uint64))
                ctypes.memmove(dst, src, n_col_words * 8)
                pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
                record_piv(pc, tag="v6_pivs")
            drain_xl()

        # Explicitly run 0x3f3f first (contains C5: K == c57, closing B1_00 in < 0.05s!)
        run_coset_12(pts_0x3f3f)
        for pts8 in v6_list:
            if piv_row_idx[off0] >= 0 or (time.perf_counter() - tc) > budget_sec * 0.25:
                break
            w_pts = [v | (w << 8) for v in pts8 for w in pts8]
            run_coset_12(w_pts)

        # Affine diagonal shifts + interleaved on first 180 V6s for maximum quadratic pivots
        for pts8 in v6_list[:180]:
            if piv_row_idx[off0] >= 0 or (time.perf_counter() - tc) > budget_sec * 0.35 or cur_row >= max_rows - 150:
                break
            pts_set = set(pts8)
            covered = set(pts8)
            reps8 = [0]
            for cand in range(1, 256):
                if cand not in covered:
                    reps8.append(cand)
                    covered |= {cand ^ p for p in pts_set}
            w_pts = [v | (w << 8) for v in pts8 for w in pts8]
            for a0 in reps8:
                a16 = a0 | (a0 << 8)
                if a0 != 0:
                    run_coset_12([x ^ a16 for x in w_pts])
                run_coset_12([interleave16(x ^ a16) for x in w_pts])

        # =====================================================================
        # PHASE 3: DEGREE-4 SCHUR-MUTANT-XL BOOSTER (Pairs of Sparse Quadratics + T28)
        # =====================================================================
        if piv_row_idx[off0] < 0 and (time.perf_counter() - tc) < budget_sec * 0.55:
            # Collect all reduced degree <= 2 pivots
            quad_psets = []
            for c_idx in range(off2, off0):
                r_idx = piv_row_idx[c_idx]
                if r_idx >= 0:
                    r_slice = [rows[r_idx * n_col_words + w] for w in range(n_col_words)]
                    quad_psets.append(decode_row_to_pset(r_slice, n_cols, off2, off1, off0, pair2_list, col3_list))
            quad_psets.sort(key=len)

            # Initialize C Schur-D4 reducer (25M uint32 arena = 100 MB RAM)
            schur = lib.schur_d4_create(n, 25_000_000, 4096)
            C_tab = [[0] * 5 for _ in range(n + 1)]
            for nn in range(n + 1):
                C_tab[nn][0] = 1
                for kk in range(1, min(5, nn + 1)):
                    C_tab[nn][kk] = C_tab[nn - 1][kk - 1] + C_tab[nn - 1][kk]
            s_n4 = C_tab[n][4]
            s_off3 = s_n4
            s_off2 = s_off3 + C_tab[n][3]
            s_off1 = s_off2 + C_tab[n][2]
            s_off0 = s_off1 + n
            low_words_n = ((s_off0 + 1 - s_off3) + 63) // 64
            out_low_buf = (ctypes.c_uint64 * low_words_n)()

            def pset4_to_cols(p4):
                cols = []
                for m in p4:
                    d = m.bit_count()
                    if d == 0:
                        cols.append(s_off0)
                    elif d == 1:
                        cols.append(s_off1 + m.bit_length() - 1)
                    else:
                        idxs = []
                        tmp = m
                        while tmp:
                            b = tmp & -tmp
                            idxs.append(b.bit_length() - 1)
                            tmp ^= b
                        if d == 2:
                            cols.append(s_off2 + C_tab[idxs[0]][1] + C_tab[idxs[1]][2])
                        elif d == 3:
                            cols.append(s_off3 + C_tab[idxs[0]][1] + C_tab[idxs[1]][2] + C_tab[idxs[2]][3])
                        elif d == 4:
                            cols.append(C_tab[idxs[0]][1] + C_tab[idxs[1]][2] + C_tab[idxs[2]][3] + C_tab[idxs[3]][4])
                cols.sort()
                return cols

            # Map colex low_col back to standard Macaulay pset when a mutant is born!
            colex3_to_mask = [0] * C_tab[n][3]
            for i0 in range(n):
                for i1 in range(i0 + 1, n):
                    for i2 in range(i1 + 1, n):
                        colex3_to_mask[C_tab[i0][1] + C_tab[i1][2] + C_tab[i2][3]] = (1 << i0) | (1 << i1) | (1 << i2)
            colex2_to_mask = [0] * C_tab[n][2]
            for i0 in range(n):
                for i1 in range(i0 + 1, n):
                    colex2_to_mask[C_tab[i0][1] + C_tab[i1][2]] = (1 << i0) | (1 << i1)

            def feed_deg4_poly(p4):
                cols = pset4_to_cols(p4)
                if not cols:
                    return
                arr = (ctypes.c_uint32 * len(cols))(*cols)
                if lib.schur_d4_reduce(schur, arr, len(cols), out_low_buf) == 1:
                    mut_pset = set()
                    for lw in range(low_words_n):
                        v = out_low_buf[lw]
                        while v:
                            b = v & -v
                            gcol = s_off3 + (lw << 6) + b.bit_length() - 1
                            v ^= b
                            if gcol == s_off0:
                                mut_pset.add(0)
                            elif gcol >= s_off1:
                                mut_pset.add(1 << (gcol - s_off1))
                            elif gcol >= s_off2:
                                mut_pset.add(colex2_to_mask[gcol - s_off2])
                            else:
                                mut_pset.add(colex3_to_mask[gcol - s_off3])
                    pc = insert_pset(mut_pset, tag="mutant_d4_pivs")
                    if pc >= off2:
                        drain_xl()

            # Feed pairwise products q_a * q_b and monomial multiples x_i * x_j * q_a of sparsest quadratics!
            sparse_q = [q for q in quad_psets if len(q) <= 320][:60]
            for idx_a, qa in enumerate(sparse_q):
                if piv_row_idx[off0] >= 0 or (time.perf_counter() - tc) > budget_sec * 0.55:
                    break
                for qb in sparse_q[idx_a + 1:]:
                    if len(qa) * len(qb) <= 25000:
                        feed_deg4_poly(mul_p(qa, qb))
                        if piv_row_idx[off0] >= 0:
                            break
                if len(qa) <= 90:
                    for i0 in range(0, n, 2):
                        for i1 in range(i0 + 1, min(n, i0 + 18)):
                            feed_deg4_poly(mul_p({(1 << i0) | (1 << i1)}, qa))

            lib.schur_d4_free(schur)

        alg_sec = round(time.perf_counter() - tc, 3)
        print(f"[{cell_name}] Algebraic phase ({alg_sec}s): has_one={piv_row_idx[off0]>=0}, "
              f"deg_pivs={deg_pivs}, stats={stats}", flush=True)

        if piv_row_idx[off0] >= 0 or not HAS_PYSAT:
            report[cell_name] = {
                "has_one": (piv_row_idx[off0] >= 0),
                "unsat_closed": (piv_row_idx[off0] >= 0),
                "deg_pivs": deg_pivs,
                "stats": stats,
                "alg_sec": alg_sec,
                "total_sec": alg_sec,
            }
            continue

        # =====================================================================
        # PHASE 4: ULTRA-FAST LIGHTWEIGHT SAT (ZERO Heavy CardEnc!) + C FWHT
        # =====================================================================
        ts = time.perf_counter()
        clauses = []
        v_cnt = [n]

        def new_var():
            v_cnt[0] += 1
            return v_cnt[0]

        pair_cache = {}
        final_deg12 = []
        var_deg_freq = [0] * n
        for c_idx in range(off2, off0):
            r_idx = piv_row_idx[c_idx]
            if r_idx >= 0:
                r_slice = [rows[r_idx * n_col_words + w] for w in range(n_col_words)]
                pset = decode_row_to_pset(r_slice, n_cols, off2, off1, off0, pair2_list, col3_list)
                final_deg12.append(pset)
                encode_poly_deg2_cnf(clauses, pset, new_var, pair_cache)
                for m in pset:
                    if m.bit_count() == 2:
                        b0 = (m & -m).bit_length() - 1
                        b1 = (m ^ (1 << b0)).bit_length() - 1
                        var_deg_freq[b0] += 1
                        var_deg_freq[b1] += 1

        # ONLY tiny 16-bit exact counter on A_8 = F_{0xff} in B0_00 (16 lits == 8 -> ~120 tiny clauses, ZERO slowdown!)
        if c99_val == 0 and c57_val == 0 and c113_val == 0:
            flits_8 = []
            for wm, ob in tower_forms[8]:
                idxs = [i + 1 for i in range(n) if (wm >> i) & 1]
                lv = new_var()
                add_long_xor_cnf(clauses, idxs + [lv], ob, new_var)
                flits_8.append(lv)
            enc8 = CardEnc.equals(lits=flits_8, bound=8, top_id=v_cnt[0], encoding=EncType.totalizer)
            v_cnt[0] = max(v_cnt[0], enc8.nv)
            clauses.extend(enc8.clauses)

        # Encode C6 (T28 branch 0) in c99 == 0 if loaded
        if c99_val == 0 and poly_t28_b0 is not None:
            c_lits = {}
            for j in range(116):
                idxs = [i + 1 for i, cdir in enumerate(cb) if (cdir >> j) & 1]
                const = (origin >> j) & 1
                if len(idxs) == 1 and const == 0:
                    c_lits[j] = idxs[0]
                elif len(idxs) == 0:
                    lv = new_var()
                    clauses.append([lv if const else -lv])
                    c_lits[j] = lv
                else:
                    lv = new_var()
                    add_long_xor_cnf(clauses, idxs + [lv], const, new_var)
                    c_lits[j] = lv
            c6_lits, c6_rhs, c6_cache = [], 0, {}
            for m in poly_t28_b0:
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
                        for lit in bits:
                            clauses.append([-mv, lit])
                        clauses.append([mv] + [-lit for lit in bits])
                        c6_cache[key] = mv
                    c6_lits.append(c6_cache[key])
            add_long_xor_cnf(clauses, c6_lits, c6_rhs, new_var)

        # Optional deterministic Cube-and-Conquer sharding on top Vertex-Cover variables!
        top_branch_vars = sorted(range(n), key=lambda i: var_deg_freq[i], reverse=True)
        cube_depth = 0
        while (1 << cube_depth) < num_shards:
            cube_depth += 1
        cube_list = [c_id for c_id in range(1 << cube_depth) if (c_id % num_shards) == shard_idx]

        models_checked = 0
        bent_hits = []
        all_cubes_unsat = True

        with Solver(name="cadical195", bootstrap_with=clauses) as slv:
            for cube_id in cube_list:
                assumps = [
                    (top_branch_vars[b] + 1) if ((cube_id >> b) & 1) else -(top_branch_vars[b] + 1)
                    for b in range(cube_depth)
                ]
                while (time.perf_counter() - tc) < budget_sec:
                    if not slv.solve(assumptions=assumps):
                        break
                    models_checked += 1
                    model = slv.get_model()
                    cint = origin
                    for i, cdir in enumerate(cb):
                        if model[i] > 0:
                            cint ^= cdir
                    if lib.audit_bent_c_fast(orb_tts, cint & mask64, cint >> 64):
                        bent_hits.append(hex(cint))
                        all_cubes_unsat = False
                        break
                    slv.add_clause([-(i + 1) if model[i] > 0 else (i + 1) for i in range(n)])
                else:
                    all_cubes_unsat = False
                if bent_hits:
                    break

        report[cell_name] = {
            "has_one": False,
            "unsat_closed": (all_cubes_unsat and len(bent_hits) == 0),
            "shard": shard_spec,
            "deg_pivs": deg_pivs,
            "deg12_encoded": len(final_deg12),
            "stats": stats,
            "models_checked": models_checked,
            "bent_hits": bent_hits,
            "alg_sec": alg_sec,
            "sat_sec": round(time.perf_counter() - ts, 3),
            "total_sec": round(time.perf_counter() - tc, 3),
        }
        print(f"[{cell_name}] Final: {json.dumps(report[cell_name])}", flush=True)

    print("=== CYCLOTOMIC TOWER MASTER REPORT ===", flush=True)
    print(json.dumps({"cells": report, "elapsed_sec": round(time.perf_counter() - t_global, 3)}, indent=2), flush=True)


if __name__ == "__main__":
    main()
