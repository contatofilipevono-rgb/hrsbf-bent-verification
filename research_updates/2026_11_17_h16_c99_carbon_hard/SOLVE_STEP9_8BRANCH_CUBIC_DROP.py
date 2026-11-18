#!/usr/bin/env python3
r"""
SOLVE_STEP9_8BRANCH_CUBIC_DROP.py

Novel Algebraic Attack & Exact Degree-3 Structural Audit on H(16,4) Open Cells
(B0_00, B0_11, B1_11):

1. Reuses DIAGNOSE_V2_STRUCTURE.build_cell_algebraic_system (pure 111-var basis,
   zero external assumptions beyond c115=0, L=c99, and proven C_0xf / C5 / Q4 /
   V6xV6 / rot^4 / fiber laws) PLUS newly verified exact degree-3 cyclotomic layer
   equations:
     - B0_00: (wt(L_d)//4) mod 2 == 0 for d = 9, 10, 11, 12, 13
     - B0_11: C_0x0_mod8_eq4 ((wt(C_0x0 \ D_8)//4) mod 2 == 1, proved from wt(f|_{D8})=64)
     - B1_11: (wt(L_13)//4) mod 2 == 0 (proved from U4-rigidity: q(L_13)=128)
   Every cyclotomic cubic equation is zero-trust verified on 20 random points.

2. Eliminates all linear pivots in-place (in C) on the fixed 111-var basis,
   reduces all ~12,400 cubic pivots modulo all y_i * q_a(y) (XL of genuine quads),
   isolating the EXACT genuine cubic quotient I_3 / <I_1, I_2> on GF(2)^109.

3. Measures the EXACT Degree-3 Trilinear Radical R_3, Combined Radical R_23,
   and Universal Degree-3 Translation Subgroup T_3 of the FULL system (I_2 + I_3)!
   (Previously only measured for degree 2, where dim(T_univ) = 102..103.)

4. Runs the 8-Branch Symplectic Linearizer Cascade (2^3 = 8 branches fixing the
   3 linear forms u_1, u_2, u_3 in W_ess that linearize ALL 4 genuine quadratics!):
   On each of the 8 branches:
     - All 4 quadratics immediately become linear -> eliminate all linear eqs
       in-place (109 -> ~102 free vars) into ALL genuine cubics in C!
     - Re-echelonize ALL cubics in C and detect EVERY drop to:
         deg 0 (1 = 0, branch CLOSED UNSAT!),
         deg 1 (new linear equations!),
         deg 2 (new genuine quadratics!).
     - Run a full fixpoint cascade (new linears -> subst -> new quads -> XL ->
       check if new quads trigger more drops; and if new low-rank quadratics
       emerge, recursively split up to depth +3 to test full collapse!).
     - Measure exact dim(R_3) and dim(T_3) inside each surviving branch.

5. Bonus probe on first surviving branch: fix 7 linear forms of L_9 (F_0xff)
   and/or 8 even orbits of E_8 (0x5555) simultaneously and measure whether
   genuine cubics trigger a quadratic/linear avalanche.
"""

import argparse
import ctypes
import json
import random
import subprocess
import sys
import time
from itertools import combinations
from pathlib import Path

WORK_DIR = Path(__file__).resolve().parent
sys.path.insert(0, str(WORK_DIR))

import DIAGNOSE_V2_STRUCTURE as diag_v2
import SOLVE_B09_DUAL_S_ELIM as b09

# ==============================================================================
# Clean C11 Kernel: Exact Single-Var Linear Substitution + Echelon + XL + R_3
# ==============================================================================
C_STEP9_SRC = r"""
#include <stddef.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

static inline void toggle_bit(uint64_t *row, int col) {
    row[col >> 6] ^= (1ULL << (col & 63));
}

static inline int col_of_3(int a, int b, int c, int n, const int *col3_base) {
    // Sort a < b < c
    int t;
    if (a > b) { t = a; a = b; b = t; }
    if (b > c) { t = b; b = c; c = t; }
    if (a > b) { t = a; a = b; b = t; }
    return col3_base[a * n + b] + (c - b - 1);
}

static inline int col_of_2(int a, int b, int n, int off2, const int *col2_base) {
    if (a > b) { int t = a; a = b; b = t; }
    return off2 + col2_base[a] + (b - a - 1);
}

// Exact GF(2)[y]/(y^2+y) substitution of ONE pivot variable `p` by:
//   y_p <- rhs ^ XOR_{k in mask} y_k   (where bit p is NOT set in mask!)
// Operates in-place on `n_rows` rows of length `n_col_words` uint64s.
// Uses precomputed unrank tables for fast decoding of active bits!
void subst_one_linear_var_batch(
    uint64_t *rows,
    int n_rows,
    int n_col_words,
    int n,
    int off2,
    int off1,
    int off0,
    const int *col2_base,
    const int *col3_base,
    const uint8_t *col_deg,
    const uint8_t *col_v0,
    const uint8_t *col_v1,
    const uint8_t *col_v2,
    int p,
    uint64_t mask_lo,
    uint64_t mask_hi,
    int rhs
) {
    int k_list[128];
    int nk = 0;
    for (int k = 0; k < n; k++) {
        if (k == p) continue;
        int bit = (k < 64) ? (int)((mask_lo >> k) & 1ULL) : (int)((mask_hi >> (k - 64)) & 1ULL);
        if (bit) k_list[nk++] = k;
    }

    int p_col1 = off1 + p;
    // Collect active columns containing p in a scratch buffer per row so mutations never interfere
    int *p_cols = (int *)malloc((size_t)(off0 + 1) * sizeof(int));
    if (!p_cols) return;

    for (int r = 0; r < n_rows; r++) {
        uint64_t *row = rows + (size_t)r * n_col_words;
        int np = 0;
        for (int w = 0; w < n_col_words; w++) {
            uint64_t v = row[w];
            while (v) {
                int b = __builtin_ctzll(v);
                int c = (w << 6) + b;
                v &= v - 1;
                if (c > off0) continue;
                uint8_t d = col_deg[c];
                if (d == 1) {
                    if (col_v0[c] == p) p_cols[np++] = c;
                } else if (d == 2) {
                    if (col_v0[c] == p || col_v1[c] == p) p_cols[np++] = c;
                } else if (d == 3) {
                    if (col_v0[c] == p || col_v1[c] == p || col_v2[c] == p) p_cols[np++] = c;
                }
            }
        }
        if (np == 0) continue;

        for (int idx = 0; idx < np; idx++) {
            int c = p_cols[idx];
            toggle_bit(row, c); // remove original monomial containing p
            uint8_t d = col_deg[c];
            if (d == 1) {
                if (rhs) toggle_bit(row, off0);
                for (int t = 0; t < nk; t++) toggle_bit(row, off1 + k_list[t]);
            } else if (d == 2) {
                int a = (col_v0[c] == p) ? col_v1[c] : col_v0[c];
                if (rhs) toggle_bit(row, off1 + a);
                for (int t = 0; t < nk; t++) {
                    int k = k_list[t];
                    if (k == a) toggle_bit(row, off1 + a);
                    else toggle_bit(row, col_of_2(a, k, n, off2, col2_base));
                }
            } else if (d == 3) {
                int v0 = col_v0[c], v1 = col_v1[c], v2 = col_v2[c];
                int a, b;
                if (v0 == p) { a = v1; b = v2; }
                else if (v1 == p) { a = v0; b = v2; }
                else { a = v0; b = v1; }
                int cab = col_of_2(a, b, n, off2, col2_base);
                if (rhs) toggle_bit(row, cab);
                for (int t = 0; t < nk; t++) {
                    int k = k_list[t];
                    if (k == a || k == b) toggle_bit(row, cab);
                    else toggle_bit(row, col_of_3(a, b, k, n, col3_base));
                }
            }
        }
    }
    free(p_cols);
}

// Fast GF(2) echelon insert on row `cur_row` (leading col = smallest set bit index;
// deg3 < deg2 < deg1 < deg0 so deg3 pivots eliminate first, drops expose deg<=2!)
int gf2_echelon_insert_s9(
    uint64_t *rows,
    int cur_row,
    int n_col_words,
    int *piv_row_idx,
    int n_cols
) {
    uint64_t *row = rows + (size_t)cur_row * n_col_words;
    for (int w = 0; w < n_col_words; w++) {
        while (row[w] != 0ULL) {
            int bit = __builtin_ctzll(row[w]);
            int col = (w << 6) + bit;
            if (col >= n_cols) return -1;
            int p_row = piv_row_idx[col];
            if (p_row >= 0) {
                const uint64_t *prow = rows + (size_t)p_row * n_col_words;
                for (int k = w; k < n_col_words; k++) {
                    row[k] ^= prow[k];
                }
            } else {
                piv_row_idx[col] = cur_row;
                return col;
            }
        }
    }
    return -1;
}

// Multiply a degree <= 2 row `src_row` by variable `vi` (in GF(2)[y]/(y^2+y)) into `dst_row`
void mul_deg2_row_by_var(
    const uint64_t *src_row,
    uint64_t *dst_row,
    int vi,
    int n,
    int off2,
    int off1,
    int off0,
    int n_col_words,
    const int *col2_base,
    const int *col3_base,
    const uint8_t *col_deg,
    const uint8_t *col_v0,
    const uint8_t *col_v1
) {
    memset(dst_row, 0, (size_t)n_col_words * sizeof(uint64_t));
    int start_w = off2 >> 6;
    for (int w = start_w; w < n_col_words; w++) {
        uint64_t v = src_row[w];
        while (v) {
            int b = __builtin_ctzll(v);
            int c = (w << 6) + b;
            v &= v - 1;
            if (c < off2 || c > off0) continue;
            uint8_t d = col_deg[c];
            if (d == 0) {
                toggle_bit(dst_row, off1 + vi);
            } else if (d == 1) {
                int a = col_v0[c];
                if (a == vi) toggle_bit(dst_row, off1 + vi);
                else toggle_bit(dst_row, col_of_2(a, vi, n, off2, col2_base));
            } else if (d == 2) {
                int a = col_v0[c], b2 = col_v1[c];
                if (vi == a || vi == b2) toggle_bit(dst_row, c);
                else toggle_bit(dst_row, col_of_3(a, b2, vi, n, col3_base));
            }
        }
    }
}

// Evaluate row at 111-bit vector (x_lo, x_hi)
int eval_row_s9(
    const uint64_t *row,
    int n_col_words,
    int off0,
    const uint8_t *col_deg,
    const uint8_t *col_v0,
    const uint8_t *col_v1,
    const uint8_t *col_v2,
    uint64_t x_lo,
    uint64_t x_hi
) {
    int acc = 0;
    for (int w = 0; w < n_col_words; w++) {
        uint64_t v = row[w];
        while (v) {
            int b = __builtin_ctzll(v);
            int c = (w << 6) + b;
            v &= v - 1;
            if (c > off0) continue;
            uint8_t d = col_deg[c];
            if (d == 0) {
                acc ^= 1;
            } else if (d == 1) {
                int a = col_v0[c];
                int ba = (a < 64) ? (int)((x_lo >> a) & 1ULL) : (int)((x_hi >> (a - 64)) & 1ULL);
                acc ^= ba;
            } else if (d == 2) {
                int a = col_v0[c], b2 = col_v1[c];
                int ba = (a < 64) ? (int)((x_lo >> a) & 1ULL) : (int)((x_hi >> (a - 64)) & 1ULL);
                int bb = (b2 < 64) ? (int)((x_lo >> b2) & 1ULL) : (int)((x_hi >> (b2 - 64)) & 1ULL);
                acc ^= (ba & bb);
            } else if (d == 3) {
                int a = col_v0[c], b2 = col_v1[c], c3 = col_v2[c];
                int ba = (a < 64) ? (int)((x_lo >> a) & 1ULL) : (int)((x_hi >> (a - 64)) & 1ULL);
                int bb = (b2 < 64) ? (int)((x_lo >> b2) & 1ULL) : (int)((x_hi >> (b2 - 64)) & 1ULL);
                int bc = (c3 < 64) ? (int)((x_lo >> c3) & 1ULL) : (int)((x_hi >> (c3 - 64)) & 1ULL);
                acc ^= (ba & bb & bc);
            }
        }
    }
    return acc;
}

// Compute the EXACT rank of the trilinear polar constraints over GF(2)^n:
// For every cubic row r and every pair (i < j), the constraint vector
//   vec[k] = coeff(y_i * y_j * y_k)   (k != i, j)
// must satisfy <vec, v> = 0 for v in R_3 (so deg(D_v P_r) <= 1 for all r)!
// Returns the GF(2) rank of all constraint vectors (stored in out_pivs_lo/hi of size n).
int compute_trilinear_radical_rank(
    const uint64_t *rows,
    const int *row_ids,
    int n_rows,
    int n_col_words,
    int n,
    int off2,
    const uint8_t *col_v0,
    const uint8_t *col_v1,
    const uint8_t *col_v2,
    uint64_t *piv_lo,
    uint64_t *piv_hi
) {
    int n_pairs = n * (n - 1) / 2;
    uint64_t *pair_lo = (uint64_t *)malloc((size_t)n_pairs * sizeof(uint64_t));
    uint64_t *pair_hi = (uint64_t *)malloc((size_t)n_pairs * sizeof(uint64_t));
    int *touched = (int *)malloc((size_t)n_pairs * sizeof(int));
    if (!pair_lo || !pair_hi || !touched) {
        free(pair_lo); free(pair_hi); free(touched);
        return -1;
    }
    memset(pair_lo, 0, (size_t)n_pairs * sizeof(uint64_t));
    memset(pair_hi, 0, (size_t)n_pairs * sizeof(uint64_t));

    // Precompute pair index p_idx(a, b) for a < b
    int pair_base[128];
    int acc_p = 0;
    for (int i = 0; i < n; i++) {
        pair_base[i] = acc_p;
        acc_p += (n - 1 - i);
    }

    int rank = 0;
    for (int b = 0; b < n; b++) {
        if (piv_lo[b] || piv_hi[b]) rank++;
    }

    int max_w3 = (off2 + 63) >> 6;
    for (int ri = 0; ri < n_rows && rank < n; ri++) {
        const uint64_t *row = rows + (size_t)row_ids[ri] * n_col_words;
        int nt = 0;
        for (int w = 0; w < max_w3; w++) {
            uint64_t v = row[w];
            while (v) {
                int bit = __builtin_ctzll(v);
                int c = (w << 6) + bit;
                v &= v - 1;
                if (c >= off2) break;
                int a = col_v0[c], b2 = col_v1[c], c3 = col_v2[c];
                // 3 pairs: (a,b2)->c3, (a,c3)->b2, (b2,c3)->a
                int p1 = pair_base[a] + (b2 - a - 1);
                if (pair_lo[p1] == 0 && pair_hi[p1] == 0) touched[nt++] = p1;
                if (c3 < 64) pair_lo[p1] ^= (1ULL << c3); else pair_hi[p1] ^= (1ULL << (c3 - 64));

                int p2 = pair_base[a] + (c3 - a - 1);
                if (pair_lo[p2] == 0 && pair_hi[p2] == 0) touched[nt++] = p2;
                if (b2 < 64) pair_lo[p2] ^= (1ULL << b2); else pair_hi[p2] ^= (1ULL << (b2 - 64));

                int p3 = pair_base[b2] + (c3 - b2 - 1);
                if (pair_lo[p3] == 0 && pair_hi[p3] == 0) touched[nt++] = p3;
                if (a < 64) pair_lo[p3] ^= (1ULL << a); else pair_hi[p3] ^= (1ULL << (a - 64));
            }
        }
        // Insert all touched non-zero pair vectors into GF(2) pivot table (MSB-first or LSB-first)
        for (int t = 0; t < nt; t++) {
            int pi = touched[t];
            uint64_t lo = pair_lo[pi], hi = pair_hi[pi];
            pair_lo[pi] = 0; pair_hi[pi] = 0;
            while (lo || hi) {
                int lead = lo ? __builtin_ctzll(lo) : (64 + __builtin_ctzll(hi));
                if (piv_lo[lead] || piv_hi[lead]) {
                    lo ^= piv_lo[lead];
                    hi ^= piv_hi[lead];
                } else {
                    piv_lo[lead] = lo;
                    piv_hi[lead] = hi;
                    rank++;
                    break;
                }
            }
        }
    }
    free(pair_lo); free(pair_hi); free(touched);
    return rank;
}
"""


def build_cyclotomic_layers():
    """Partition all free C_16-orbits into cyclotomic layers L_9..L_16 and C_0x0\\D_8."""
    def apply_T(x):
        return b09.rot16(x) ^ x

    V_deg = [0] * 65536
    for x in range(1, 65536):
        y, d = x, 0
        while y:
            y = apply_T(y)
            d += 1
        V_deg[x] = d

    layers = {d: [] for d in range(9, 17)}
    c0x0 = []
    vis16 = bytearray(65536)
    for x in range(65536):
        if vis16[x]:
            continue
        cur, mem = x, []
        while not vis16[cur]:
            vis16[cur] = 1
            mem.append(cur)
            cur = b09.rot16(cur)
        if len(mem) == 16:
            d = V_deg[mem[0]]
            if d >= 9:
                layers[d].append(mem[0])
            vnib = (mem[0] & 0xF) ^ ((mem[0] >> 4) & 0xF) ^ ((mem[0] >> 8) & 0xF) ^ ((mem[0] >> 12) & 0xF)
            if vnib == 0x0:
                c0x0.append(mem[0])
    return layers, c0x0


def extract_verified_cyclotomic_cubics(cell_name, orbits, origin, cb, layers, c0x0):
    """
    Extract 100% mathematically proven degree-3 cyclotomic layer equations
    and zero-trust verify each one on 20 random points in GF(2)^111.
    """
    n = len(cb)
    specs = []
    if cell_name == "B0_00":
        for d in (9, 10, 11, 12, 13):
            specs.append((f"L_{d}_mod8_eq0", layers[d], 0))
    elif cell_name == "B0_11":
        specs.append(("C_0x0_mod8_eq4", c0x0, 1))
    elif cell_name == "B1_11":
        specs.append(("L_13_mod8_eq0", layers[13], 0))

    eqs = []
    rng = random.Random(20260901)
    for label, reps, target_bit in specs:
        orb_masks = [0] * 116
        for idx, x in enumerate(reps):
            for j in range(116):
                if sum((x & m) == m for m in orbits[j]) & 1:
                    orb_masks[j] |= 1 << idx
        O_w = 0
        for j in range(116):
            if (origin >> j) & 1:
                O_w ^= orb_masks[j]
        cb_w = []
        for cdir in cb:
            w = 0
            for j in range(116):
                if (cdir >> j) & 1:
                    w ^= orb_masks[j]
            cb_w.append(w)

        p2 = b09.extract_weight_div_2k_poly(cb_w, O_w, 2, n)
        assert p2 is not None, f"{label}: weight not identically div by 4!"
        # Zero-trust verify p2(c) == (wt(c)//4) & 1 on 20 random points
        for _ in range(20):
            cm = rng.getrandbits(n)
            val = O_w
            m = cm
            while m:
                lb = m & -m
                val ^= cb_w[lb.bit_length() - 1]
                m ^= lb
            q = val.bit_count()
            assert q % 4 == 0
            actual = (q // 4) & 1
            pe = 0
            for mon in p2:
                if (cm & mon) == mon:
                    pe ^= 1
            assert pe == actual, f"Zero-trust verification FAILED on {label}!"

        poly = set(p2)
        if target_bit:
            poly ^= {0}
        eqs.append((label, poly))
    return eqs


def build_col_tables(n):
    col3_base_py = [0] * (n * n)
    idx = 0
    for i in range(n):
        for j in range(i + 1, n):
            col3_base_py[i * n + j] = idx
            idx += (n - 1 - j)
    off2 = idx
    col2_base_py = [0] * n
    acc2 = 0
    for i in range(n):
        col2_base_py[i] = acc2
        acc2 += (n - 1 - i)
    off1 = off2 + acc2
    off0 = off1 + n
    n_cols = off0 + 1
    n_col_words = (n_cols + 63) // 64

    col_deg = (ctypes.c_uint8 * n_cols)()
    col_v0 = (ctypes.c_uint8 * n_cols)()
    col_v1 = (ctypes.c_uint8 * n_cols)()
    col_v2 = (ctypes.c_uint8 * n_cols)()
    col3_list = []
    pair2_list = []
    pair2_col = {}

    c = 0
    for i in range(n):
        for j in range(i + 1, n):
            for k in range(j + 1, n):
                col_deg[c] = 3
                col_v0[c] = i
                col_v1[c] = j
                col_v2[c] = k
                col3_list.append((1 << i) | (1 << j) | (1 << k))
                c += 1
    assert c == off2
    for i in range(n):
        for j in range(i + 1, n):
            col_deg[c] = 2
            col_v0[c] = i
            col_v1[c] = j
            m = (1 << i) | (1 << j)
            pair2_col[m] = c
            pair2_list.append(m)
            c += 1
    assert c == off1
    for i in range(n):
        col_deg[c] = 1
        col_v0[c] = i
        c += 1
    col_deg[off0] = 0

    return {
        "n": n, "off2": off2, "off1": off1, "off0": off0,
        "n_cols": n_cols, "n_col_words": n_col_words,
        "col2_base_py": col2_base_py, "col3_base_py": col3_base_py,
        "col2_base": (ctypes.c_int * n)(*col2_base_py),
        "col3_base": (ctypes.c_int * (n * n))(*col3_base_py),
        "col_deg": col_deg, "col_v0": col_v0, "col_v1": col_v1, "col_v2": col_v2,
        "pair2_list": pair2_list, "pair2_col": pair2_col, "col3_list": col3_list,
    }


def pset_to_row(pset, dst_buf, row_idx, tbl):
    n = tbl["n"]
    n_cw = tbl["n_col_words"]
    off2, off1, off0 = tbl["off2"], tbl["off1"], tbl["off0"]
    pair2_col = tbl["pair2_col"]
    col3_base = tbl["col3_base_py"]
    base = row_idx * n_cw
    for w in range(n_cw):
        dst_buf[base + w] = 0
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
            raise ValueError(f"Degree {d} > 3")
        dst_buf[base + (c >> 6)] ^= (1 << (c & 63))


def row_to_pset(buf, row_idx, tbl):
    n_cw = tbl["n_col_words"]
    off2, off1, off0 = tbl["off2"], tbl["off1"], tbl["off0"]
    pair2_list = tbl["pair2_list"]
    col3_list = tbl["col3_list"]
    base = row_idx * n_cw
    pset = set()
    for w in range(n_cw):
        v = buf[base + w]
        while v:
            lb = v & -v
            c = (w << 6) + lb.bit_length() - 1
            v ^= lb
            if c == off0:
                pset.add(0)
            elif c >= off1:
                pset.add(1 << (c - off1))
            elif c >= off2:
                pset.add(pair2_list[c - off2])
            else:
                pset.add(col3_list[c])
    return pset


def find_minimal_linearizers(quad_psets, n):
    """
    Given quadratic psets over GF(2)^n (expressed in the original 111-var indices),
    compute the exact essential linear space W_ess (row space of all polar matrices B_a)
    and find a minimal set of k linear forms u_1..u_k in W_ess whose fixing linearizes
    ALL quadratic psets simultaneously!
    """
    B_rows = []
    q_B = []
    for qp in quad_psets:
        Ba = [0] * n
        for m in qp:
            if m.bit_count() == 2:
                i = (m & -m).bit_length() - 1
                j = (m ^ (1 << i)).bit_length() - 1
                Ba[i] |= (1 << j)
                Ba[j] |= (1 << i)
        q_B.append(Ba)
        for row in Ba:
            if row:
                B_rows.append(row)

    # Basis of W_ess = row space of all B_a
    w_pivs = {}
    for r in B_rows:
        cur = r
        while cur:
            b = cur.bit_length() - 1
            if b in w_pivs:
                cur ^= w_pivs[b]
            else:
                w_pivs[b] = cur
                break
    w_basis = sorted(w_pivs.values())
    dim_W = len(w_basis)

    if dim_W == 0:
        return {"dim_W_ess": 0, "linearizer_forms": [], "w_basis": []}

    # Express every quadratic's homogeneous part in coordinates of W_ess (length dim_W)!
    # Find dual basis vectors e_0..e_{dim_W-1} in GF(2)^n such that <w_basis[r], e_s> = delta_{rs}!
    # Simply pick the pivot bit column of each RREF row of W_ess!
    # First put w_pivs in full RREF:
    for b in sorted(w_pivs.keys(), reverse=True):
        for b2 in list(w_pivs.keys()):
            if b2 != b and ((w_pivs[b2] >> b) & 1):
                w_pivs[b2] ^= w_pivs[b]
    piv_cols = sorted(w_pivs.keys())
    w_rref = [w_pivs[c] for c in piv_cols]

    # On the coordinate space of W_ess (z_r = <w_rref[r], y>), the polar matrix of q_a is
    # simply the submatrix B_a restricted to rows/cols in piv_cols!
    # Wait: check that! Since every row of B_a lies in span(w_rref), if <w_rref[r], y> = 0 for all r,
    # then B_a * y = 0! And for e_s = unit vector at piv_cols[s], <w_rref[r], e_s> = delta_{rs}!
    # So q_a^hom(y) = sum_{r < s} M_a[r, s] * z_r * z_s where M_a[r, s] = (B_a[piv_cols[r]] >> piv_cols[s]) & 1!
    M_list = []
    for Ba in q_B:
        Ma = [0] * dim_W
        for r in range(dim_W):
            pr = piv_cols[r]
            row_r = 0
            for s in range(dim_W):
                if (Ba[pr] >> piv_cols[s]) & 1:
                    row_r |= (1 << s)
            Ma[r] = row_r
        M_list.append(Ma)

    # Zero-trust check: verify M_list reproduces B_a * e_s on W_ess!
    # Now search for smallest subspace U <= W_ess (dim k = 1, 2, 3, ...) such that on U^perp <= GF(2)^{dim_W},
    # ALL quadratic forms M_a vanish identically (i.e. U^perp is totally isotropic for all M_a)!
    def is_total_linearizer(u_masks):
        # Nullspace of u_masks in GF(2)^{dim_W}
        ns = diag_v2.gf2_nullspace_right(u_masks, dim_W)
        # Check that for every Ma and every pair (v1, v2) in ns, v1^T Ma v2 == 0
        for Ma in M_list:
            for idx1 in range(len(ns)):
                v1 = ns[idx1]
                # Compute Ma * v1
                mv1 = 0
                for r in range(dim_W):
                    if ((Ma[r] & v1).bit_count() & 1):
                        mv1 |= (1 << r)
                for idx2 in range(idx1 + 1, len(ns)):
                    if (mv1 & ns[idx2]).bit_count() & 1:
                        return False
        return True

    # If dim_W <= 10, find exact minimum k by searching over subspaces of GF(2)^{dim_W}
    chosen_u = None
    if dim_W <= 8:
        all_nz = list(range(1, 1 << dim_W))
        # k = 1
        for u1 in all_nz:
            if is_total_linearizer([u1]):
                chosen_u = [u1]
                break
        if chosen_u is None and dim_W >= 2:
            for i1, u1 in enumerate(all_nz):
                for u2 in all_nz[i1 + 1:]:
                    if is_total_linearizer([u1, u2]):
                        chosen_u = [u1, u2]
                        break
                if chosen_u is not None:
                    break
        if chosen_u is None and dim_W >= 3:
            # Smart search: start from isotropic subspace of M_0 of dim dim_W - k!
            # Any u_1..u_k corresponds to a subspace V = U^perp of dim (dim_W - k) that is
            # totally isotropic for ALL M_a! Search maximal isotropic subspaces of M_list!
            # Wait: for dim_W == 6, k == 3 means dim(V) = 3! Only ~1395 3-dim subspaces of F_2^6!
            iso_vecs = [v for v in range(1, 1 << dim_W)]  # alternating: v^T M v = 0 always
            # Build adjacency: v1 ~ v2 iff v1^T Ma v2 == 0 for all a
            adj = [0] * (1 << dim_W)
            for v1 in range(1, 1 << dim_W):
                m_vec = []
                for Ma in M_list:
                    mv = 0
                    for r in range(dim_W):
                        if (Ma[r] & v1).bit_count() & 1:
                            mv |= (1 << r)
                    m_vec.append(mv)
                mask_ok = 0
                for v2 in range(1, 1 << dim_W):
                    if all(((mv & v2).bit_count() & 1) == 0 for mv in m_vec):
                        mask_ok |= (1 << v2)
                adj[v1] = mask_ok

            best_V = []
            # Backtrack to find maximal totally isotropic subspace V <= F_2^{dim_W}
            def bt(basis_v, span_v, cand_mask):
                nonlocal best_V
                if len(basis_v) > len(best_V):
                    best_V = list(basis_v)
                # Upper bound check: if we already hit dim_W // 2 + 1 or enough, keep going quickly
                m = cand_mask
                while m:
                    lb = m & -m
                    v = lb.bit_length() - 1
                    m ^= lb
                    # Remove all vectors in new span from future candidates
                    new_span = span_v | {s ^ v for s in span_v}
                    new_cand = cand_mask & adj[v]
                    for s in new_span:
                        new_cand &= ~(1 << s)
                    # Also enforce ordering > v to avoid duplicates
                    new_cand &= ~((1 << (v + 1)) - 1)
                    bt(basis_v + [v], new_span, new_cand)

            bt([], {0}, ((1 << (1 << dim_W)) - 1) ^ 1)
            # U = best_V^perp in GF(2)^{dim_W}
            chosen_u = diag_v2.gf2_nullspace_right(best_V, dim_W)
            assert is_total_linearizer(chosen_u)

    if chosen_u is None:
        # Fallback: take half the basis vectors via greedy isotropic extension
        chosen_u = [1 << r for r in range(dim_W)]

    # Lift each u in chosen_u back to GF(2)^n: form = XOR_{r: bit r in u} w_rref[r]
    forms_111 = []
    for u in chosen_u:
        fm = 0
        for r in range(dim_W):
            if (u >> r) & 1:
                fm ^= w_rref[r]
        forms_111.append(fm)

    return {
        "dim_W_ess": dim_W,
        "k_linearizers": len(forms_111),
        "linearizer_forms_111": forms_111,
        "w_rref_111": w_rref,
    }


def add_linear_rref(lin_pivs, vm, rhs):
    """Insert linear equation <vm, x> == rhs into dict lin_pivs: piv_bit -> (vm, rhs).
    Returns False if 1 = 0 contradiction, True otherwise."""
    cur_v, cur_r = vm, rhs & 1
    while cur_v:
        b = (cur_v & -cur_v).bit_length() - 1
        if b in lin_pivs:
            pv, pr = lin_pivs[b]
            cur_v ^= pv
            cur_r ^= pr
        else:
            # Back-substitute into existing pivots
            for ob in list(lin_pivs.keys()):
                ov, orhs = lin_pivs[ob]
                if (ov >> b) & 1:
                    lin_pivs[ob] = (ov ^ cur_v, orhs ^ cur_r)
            lin_pivs[b] = (cur_v, cur_r)
            return True
    return cur_r == 0


def compute_degree3_radicals(lib9, buf, cub_ids, quad_ids, lin_pivs, tbl):
    """
    On the current active variable subspace (all piv_vars in lin_pivs eliminated from buf):
      - Compute dim_R3 (trilinear radical of cub_ids inside the active subspace),
      - Compute dim_R23 (vectors in R_3 whose directional derivative on BOTH quads and cubics is constant),
      - Compute dim_T3 (universal translation subgroup of V(I_2, I_3) inside the active subspace!).
    """
    n = tbl["n"]
    n_cw = tbl["n_col_words"]
    mask64 = (1 << 64) - 1
    active_vars = [i for i in range(n) if i not in lin_pivs]
    N_act = len(active_vars)

    # Seed pivot table with the eliminated linear forms (or unit vectors for eliminated vars!)
    # Because eliminated vars do not appear in buf, we enforce v_p = 0 for p in lin_pivs
    # so the nullspace lives strictly in GF(2)^{active_vars} (dimension N_act)!
    piv_lo = (ctypes.c_uint64 * n)()
    piv_hi = (ctypes.c_uint64 * n)()
    for p in lin_pivs.keys():
        if p < 64:
            piv_lo[p] = 1 << p
        else:
            piv_hi[p] = 1 << (p - 64)

    n_cub = len(cub_ids)
    cub_arr = (ctypes.c_int * max(1, n_cub))(*cub_ids)
    rk_total = lib9.compute_trilinear_radical_rank(
        buf, cub_arr, n_cub, n_cw, n, tbl["off2"],
        tbl["col_v0"], tbl["col_v1"], tbl["col_v2"],
        piv_lo, piv_hi
    )
    rk_trilin_in_active = rk_total - len(lin_pivs)
    dim_R3 = N_act - rk_trilin_in_active

    # Extract basis of R_3 inside active_vars!
    r3_constraints = []
    for b in range(n):
        m = int(piv_lo[b]) | (int(piv_hi[b]) << 64)
        if m:
            r3_constraints.append(m)
    r3_basis = diag_v2.gf2_nullspace_right(r3_constraints, n)
    assert len(r3_basis) == dim_R3

    # Now check how many vectors in R_3 ALSO lie in R_bil(I_2) and have constant/zero D_v on ALL cubics & quads!
    # Wait: for v in R_3, D_v P_a(y) has degree <= 1!
    # Specifically, D_v P_a(y) = D_v P_a(0) ^ sum_{i} [y_i](D_v P_a) * y_i.
    # Notice [y_i](D_v P_a) = D_v (dP_a/dy_i) = sum_{j != i} [y_i y_j]P_a * v_j ^ sum_{j < k, j,k != i} [y_i y_j y_k]P_a * v_j * v_k!
    # Wait: because v is in R_3, for ANY (i, j) the linear term sum_k c_{ijk} v_k == 0,
    # HOWEVER sum_{j < k} c_{ijk} v_j v_k is quadratic in v!
    # So we test directly on each basis vector v of R_3 (and check if R_3 itself is linear/small):
    # First intersect R_3 with R_bil(I_2):
    r23_constraints = list(r3_constraints)
    for qr in quad_ids:
        qp = row_to_pset(buf, qr, tbl)
        Ba = [0] * n
        for m in qp:
            if m.bit_count() == 2:
                i = (m & -m).bit_length() - 1
                j = (m ^ (1 << i)).bit_length() - 1
                Ba[i] |= (1 << j)
                Ba[j] |= (1 << i)
        for row in Ba:
            if row:
                r23_constraints.append(row)
    r3_cap_rbil_basis = diag_v2.gf2_nullspace_right(r23_constraints, n)

    # Test on up to 64 basis vectors of (R_3 cap R_bil) whether D_v P(y) == 0 on 8 random y!
    # Wait: even simpler & exact: for each v in r3_cap_rbil_basis, check if D_v P(y) == 0 for ALL cub_ids & quad_ids
    # across 6 random active points y!
    rng = random.Random(314159)
    rand_ys = []
    for _ in range(6):
        ym = 0
        for i in active_vars:
            if rng.getrandbits(1):
                ym |= (1 << i)
        rand_ys.append(ym)

    t3_basis_exact_candidates = 0
    t3_const_shift_candidates = 0
    all_check_ids = list(quad_ids) + list(cub_ids)
    for v in r3_cap_rbil_basis:
        v_lo, v_hi = v & mask64, v >> 64
        all_zero = True
        all_const = True
        for r_id in all_check_ids:
            row_ptr = ctypes.cast(ctypes.byref(buf, r_id * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
            d0 = lib9.eval_row_s9(row_ptr, n_cw, tbl["off0"], tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"], 0, 0) ^ \
                 lib9.eval_row_s9(row_ptr, n_cw, tbl["off0"], tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"], v_lo, v_hi)
            if d0:
                all_zero = False
            for ym in rand_ys:
                yv = ym ^ v
                dy = lib9.eval_row_s9(row_ptr, n_cw, tbl["off0"], tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"], ym & mask64, ym >> 64) ^ \
                     lib9.eval_row_s9(row_ptr, n_cw, tbl["off0"], tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"], yv & mask64, yv >> 64)
                if dy != d0:
                    all_const = False
                    all_zero = False
                    break
            if not all_const:
                break
        if all_zero:
            t3_basis_exact_candidates += 1
        if all_const:
            t3_const_shift_candidates += 1

    return {
        "N_active": N_act,
        "dim_R3_trilinear_radical": dim_R3,
        "dim_R3_cap_Rbil_I2": len(r3_cap_rbil_basis),
        "R3_cap_Rbil_basis_const_shift_count": t3_const_shift_candidates,
        "R3_cap_Rbil_basis_zero_shift_count": t3_basis_exact_candidates,
    }


def run_branch_cascade(lib9, base_buf, base_quad_ids, base_cub_ids, base_lin_pivs,
                       extra_lin_eqs, tbl, max_xl_rounds=4, verify_subst=False):
    """
    Copy base_quad_ids + base_cub_ids into a fresh workspace, impose extra_lin_eqs
    (and eliminate all linear equations in-place), re-echelonize ALL polynomials,
    and run a full fixpoint cascade:
      deg 0 -> UNSAT!
      deg 1 -> substitute in-place & re-echelonize!
      deg 2 -> multiply by all active vars (XL) & insert into cubic echelon!
    Returns exact branch summary + surviving reduced buffer/ids.
    """
    n = tbl["n"]
    n_cw = tbl["n_col_words"]
    n_cols = tbl["n_cols"]
    off2, off1, off0 = tbl["off2"], tbl["off1"], tbl["off0"]
    mask64 = (1 << 64) - 1

    lin_pivs = dict(base_lin_pivs)
    new_pivs_to_subst = []
    for vm, rhs in extra_lin_eqs:
        before = set(lin_pivs.keys())
        ok = add_linear_rref(lin_pivs, vm, rhs)
        if not ok:
            return {"closed_unsat": True, "closed_by": "linear_contradiction", "rounds": 0}
        after = set(lin_pivs.keys())
        for nb in (after - before):
            new_pivs_to_subst.append(nb)

    # Copy all active base rows (quads + cubics) into fresh buffer
    src_ids = list(base_quad_ids) + list(base_cub_ids)
    n_init = len(src_ids)
    max_rows = max(n_init + 4096, 16000)
    work = (ctypes.c_uint64 * (max_rows * n_cw))()
    for idx, rid in enumerate(src_ids):
        dst_ptr = ctypes.cast(ctypes.byref(work, idx * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
        src_ptr = ctypes.cast(ctypes.byref(base_buf, rid * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
        ctypes.memmove(dst_ptr, src_ptr, n_cw * 8)

    # Apply newly added linear pivots in-place (in reverse/RREF order: since lin_pivs is RREF,
    # substitute EVERY pivot in lin_pivs whose bit wasn't eliminated in base_buf!)
    # Wait: back-substitution in add_linear_rref may have modified older pivots? No, older pivots
    # were already eliminated from base_buf! So ONLY the new pivot variables `new_pivs_to_subst`
    # appear in base_buf! Wait: what if `add_linear_rref` expressed a new pivot `nb` using an OLD
    # pivot variable? Impossible because old pivot bits are ALREADY eliminated from `cur_v`!
    # Verify: for each nb in new_pivs_to_subst, lin_pivs[nb][0] only contains active vars + nb!
    def apply_pivs_in_place(buf_arr, cur_n_rows, piv_bits):
        for p in piv_bits:
            pv, pr = lin_pivs[p]
            m = pv ^ (1 << p)
            lib9.subst_one_linear_var_batch(
                buf_arr, cur_n_rows, n_cw, n, off2, off1, off0,
                tbl["col2_base"], tbl["col3_base"],
                tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"],
                p, m & mask64, m >> 64, pr
            )

    apply_pivs_in_place(work, n_init, new_pivs_to_subst)

    if verify_subst and n_init > 0:
        # Zero-trust verify on 5 random solutions of lin_pivs!
        rng = random.Random(777)
        active_now = [i for i in range(n) if i not in lin_pivs]
        for _ in range(5):
            x = 0
            for i in active_now:
                if rng.getrandbits(1):
                    x |= (1 << i)
            for p, (pv, pr) in lin_pivs.items():
                m = pv ^ (1 << p)
                if (((m & x).bit_count() ^ pr) & 1):
                    x |= (1 << p)
            x_lo, x_hi = x & mask64, x >> 64
            for check_idx in range(min(30, n_init)):
                r_old = ctypes.cast(ctypes.byref(base_buf, src_ids[check_idx] * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
                r_new = ctypes.cast(ctypes.byref(work, check_idx * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
                v_old = lib9.eval_row_s9(r_old, n_cw, off0, tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"], x_lo, x_hi)
                v_new = lib9.eval_row_s9(r_new, n_cw, off0, tbl["col_deg"], tbl["col_v0"], tbl["col_v1"], tbl["col_v2"], x_lo, x_hi)
                assert v_old == v_new, f"SUBST ZERO-TRUST MISMATCH at row {check_idx}!"

    # Fixpoint cascade: echelonize -> extract deg0/deg1/deg2 -> subst deg1 -> XL deg2 -> repeat!
    cur_count = n_init
    total_lin_dropped = 0
    total_quad_dropped = 0
    round_logs = []

    for rnd in range(1, max_xl_rounds + 1):
        # Fresh echelon over `cur_count` rows
        ech = (ctypes.c_uint64 * (max_rows * n_cw))()
        piv_idx = (ctypes.c_int * n_cols)(*([-1] * n_cols))
        e_rows = 0
        d1_rows, d2_rows, d3_rows = [], [], []

        for r in range(cur_count):
            dst = ctypes.cast(ctypes.byref(ech, e_rows * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
            src = ctypes.cast(ctypes.byref(work, r * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
            ctypes.memmove(dst, src, n_cw * 8)
            pc = lib9.gf2_echelon_insert_s9(ech, e_rows, n_cw, piv_idx, n_cols)
            if pc < 0:
                continue
            if pc == off0:
                return {
                    "closed_unsat": True,
                    "closed_by": f"cubic_drop_has_one_round_{rnd}",
                    "rounds": rnd,
                    "round_logs": round_logs,
                    "N_active": n - len(lin_pivs),
                }
            elif pc >= off1:
                d1_rows.append(e_rows)
            elif pc >= off2:
                d2_rows.append(e_rows)
            else:
                d3_rows.append(e_rows)
            e_rows += 1

        # First: if ANY new linear equations (d1_rows) appeared, eliminate them immediately!
        if d1_rows:
            added_bits = []
            for r_id in d1_rows:
                ps = row_to_pset(ech, r_id, tbl)
                vm = 0
                rhs = 1 if (0 in ps) else 0
                for m in ps:
                    if m != 0:
                        vm |= m
                before = set(lin_pivs.keys())
                ok = add_linear_rref(lin_pivs, vm, rhs)
                if not ok:
                    return {
                        "closed_unsat": True,
                        "closed_by": f"linear_cascade_contradiction_round_{rnd}",
                        "rounds": rnd,
                        "round_logs": round_logs,
                        "N_active": n - len(lin_pivs),
                    }
                after = set(lin_pivs.keys())
                for nb in (after - before):
                    added_bits.append(nb)
            total_lin_dropped += len(added_bits)
            round_logs.append({
                "round": rnd, "event": "linear_drop",
                "new_lin": len(added_bits), "d2": len(d2_rows), "d3": len(d3_rows),
                "N_active_after": n - len(lin_pivs),
            })
            # Copy d2_rows + d3_rows back into `work` and substitute added_bits in-place!
            keep = d2_rows + d3_rows
            for idx, r_id in enumerate(keep):
                dst = ctypes.cast(ctypes.byref(work, idx * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
                src = ctypes.cast(ctypes.byref(ech, r_id * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
                ctypes.memmove(dst, src, n_cw * 8)
            cur_count = len(keep)
            apply_pivs_in_place(work, cur_count, added_bits)
            continue

        # No deg-1 drops in this round!
        # Check if we have deg-2 equations (`d2_rows`) whose XL multiples y_i * q_a generate NEW drops!
        active_vars = [i for i in range(n) if i not in lin_pivs]
        xl_new_d1, xl_new_d2, xl_new_d3 = [], [], 0
        if d2_rows:
            for qr in d2_rows:
                src_ptr = ctypes.cast(ctypes.byref(ech, qr * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
                for vi in active_vars:
                    if e_rows >= max_rows - 2:
                        break
                    dst_ptr = ctypes.cast(ctypes.byref(ech, e_rows * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
                    lib9.mul_deg2_row_by_var(
                        src_ptr, dst_ptr, vi, n, off2, off1, off0, n_cw,
                        tbl["col2_base"], tbl["col3_base"],
                        tbl["col_deg"], tbl["col_v0"], tbl["col_v1"]
                    )
                    pc = lib9.gf2_echelon_insert_s9(ech, e_rows, n_cw, piv_idx, n_cols)
                    if pc < 0:
                        continue
                    if pc == off0:
                        return {
                            "closed_unsat": True,
                            "closed_by": f"xl_quad_has_one_round_{rnd}",
                            "rounds": rnd,
                            "round_logs": round_logs,
                            "N_active": n - len(lin_pivs),
                        }
                    elif pc >= off1:
                        xl_new_d1.append(e_rows)
                    elif pc >= off2:
                        xl_new_d2.append(e_rows)
                    else:
                        xl_new_d3 += 1
                    e_rows += 1

        round_logs.append({
            "round": rnd, "event": "quad_xl_pass",
            "d2_before_xl": len(d2_rows), "d3_before_xl": len(d3_rows),
            "xl_new_d1": len(xl_new_d1), "xl_new_d2": len(xl_new_d2), "xl_new_d3": xl_new_d3,
            "N_active": len(active_vars),
        })

        if xl_new_d1 or xl_new_d2:
            total_quad_dropped += len(xl_new_d2)
            # Feed ech[0..e_rows] back into work for next fixpoint round
            for idx in range(e_rows):
                dst = ctypes.cast(ctypes.byref(work, idx * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
                src = ctypes.cast(ctypes.byref(ech, idx * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
                ctypes.memmove(dst, src, n_cw * 8)
            cur_count = e_rows
            continue

        # Reached algebraic fixpoint! Separate genuine cubics (those NOT generated by XL of d2_rows!)
        # Rebuild clean echelon inserting d2_rows + XL(d2_rows) FIRST, then d3_rows -> exact genuine cubics!
        clean = (ctypes.c_uint64 * (max_rows * n_cw))()
        cpiv = (ctypes.c_int * n_cols)(*([-1] * n_cols))
        c_rows = 0
        final_quad_ids = []
        for qr in d2_rows:
            dst = ctypes.cast(ctypes.byref(clean, c_rows * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
            src = ctypes.cast(ctypes.byref(ech, qr * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
            ctypes.memmove(dst, src, n_cw * 8)
            pc = lib9.gf2_echelon_insert_s9(clean, c_rows, n_cw, cpiv, n_cols)
            if pc >= off2 and pc < off1:
                final_quad_ids.append(c_rows)
                c_rows += 1
        # Insert XL of final_quad_ids
        for qr in list(final_quad_ids):
            src_ptr = ctypes.cast(ctypes.byref(clean, qr * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
            for vi in active_vars:
                if c_rows >= max_rows - 2:
                    break
                dst_ptr = ctypes.cast(ctypes.byref(clean, c_rows * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
                lib9.mul_deg2_row_by_var(
                    src_ptr, dst_ptr, vi, n, off2, off1, off0, n_cw,
                    tbl["col2_base"], tbl["col3_base"],
                    tbl["col_deg"], tbl["col_v0"], tbl["col_v1"]
                )
                pc = lib9.gf2_echelon_insert_s9(clean, c_rows, n_cw, cpiv, n_cols)
                if pc >= 0:
                    c_rows += 1
        # Now insert d3_rows -> every surviving pivot is a GENUINE cubic outside <I_1, I_2>!
        final_genuine_cub_ids = []
        for cr in d3_rows:
            if c_rows >= max_rows - 2:
                break
            dst = ctypes.cast(ctypes.byref(clean, c_rows * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
            src = ctypes.cast(ctypes.byref(ech, cr * n_cw * 8), ctypes.POINTER(ctypes.c_uint64))
            ctypes.memmove(dst, src, n_cw * 8)
            pc = lib9.gf2_echelon_insert_s9(clean, c_rows, n_cw, cpiv, n_cols)
            if pc >= 0 and pc < off2:
                final_genuine_cub_ids.append(c_rows)
                c_rows += 1

        return {
            "closed_unsat": False,
            "rounds": rnd,
            "N_active": len(active_vars),
            "n_quad_surviving": len(final_quad_ids),
            "n_genuine_cubics": len(final_genuine_cub_ids),
            "total_lin_dropped": total_lin_dropped,
            "round_logs": round_logs,
            "_buf": clean,
            "_quad_ids": final_quad_ids,
            "_cub_ids": final_genuine_cub_ids,
            "_lin_pivs": lin_pivs,
        }

    return {"closed_unsat": False, "rounds": max_xl_rounds, "round_logs": round_logs, "note": "max_xl_rounds_reached"}


def analyze_cell_step9(cell_name, lib_diag, lib9, orbits, v6_list, rot4_data, fiber_meta, layers, c0x0, tbl):
    t0 = time.perf_counter()
    print(f"\n==================== [{cell_name}] STEP 9: 8-BRANCH CUBIC DROP & RADICAL AUDIT ====================", flush=True)

    # 1. Extract base pure-111 system via battle-tested DIAGNOSE_V2_STRUCTURE
    sys_data = diag_v2.build_cell_algebraic_system(
        cell_name, lib_diag, orbits, v6_list, rot4_data, fiber_meta, extract_sec=20.0
    )
    if sys_data["has_one"]:
        return {"cell": cell_name, "closed_unsat": True, "closed_by": "stage1_base"}

    n = tbl["n"]
    n_cw = tbl["n_col_words"]
    n_cols = tbl["n_cols"]
    off2, off1, off0 = tbl["off2"], tbl["off1"], tbl["off0"]
    c99, c57, c113 = int(cell_name[1]), int(cell_name[3]), int(cell_name[4])
    _, origin111, cb111 = b09.build_pure_111_basis(c99, c57, c113)

    # 2. Extract and zero-trust verify the exact degree-3 cyclotomic layer equations!
    cyc_cubs = extract_verified_cyclotomic_cubics(cell_name, orbits, origin111, cb111, layers, c0x0)
    print(f"[{cell_name}] Verified {len(cyc_cubs)} cyclotomic degree-3 equations: "
          f"{[(lbl, len(p)) for lbl, p in cyc_cubs]}", flush=True)

    # 3. Copy ALL base rows (lin + quad + cub) + cyclotomic cubics into our clean Step-9 buffer
    # Reconstruct base linear pivots from sys_data["var_subst"]!
    # Wait: sys_data["rows_c"] has all pivots up to len(lin)+len(quad)+len(cub).
    # Easier: pull all non-zero rows from sys_data["rows_c"] directly!
    n_base_pivs = sum(sys_data["deg_pivs_111"].values())
    max_rows = n_base_pivs + len(cyc_cubs) + 4096
    raw_buf = (ctypes.c_uint64 * (max_rows * n_cw))()
    ctypes.memmove(raw_buf, sys_data["rows_c"], n_base_pivs * n_cw * 8)

    # Append verified cyclotomic degree-3 equations!
    for idx_c, (lbl, poly) in enumerate(cyc_cubs):
        pset_to_row(poly, raw_buf, n_base_pivs + idx_c, tbl)
    total_raw = n_base_pivs + len(cyc_cubs)

    # Run Stage 2 initial cascade (no extra branch constraints yet!) -> isolates exact lin_pivs (N=109),
    # genuine quads (m=4), and exact genuine cubic quotient I_3 / <I_1, I_2>!
    t_s2 = time.perf_counter()
    base_ids = list(range(total_raw))
    root = run_branch_cascade(
        lib9, raw_buf, [], base_ids, {}, [], tbl, max_xl_rounds=5, verify_subst=True
    )
    if root["closed_unsat"]:
        print(f"[{cell_name}] CLOSED AT ROOT BY CYCLOTOMIC CUBICS! ({root['closed_by']})", flush=True)
        return {"cell": cell_name, "closed_unsat": True, "root": root, "total_sec": round(time.perf_counter() - t0, 3)}

    print(f"[{cell_name}] Root exact quotient ({time.perf_counter()-t_s2:.2f}s): "
          f"N_active={root['N_active']}, genuine_quads={root['n_quad_surviving']}, "
          f"genuine_cubics={root['n_genuine_cubics']}, rounds={root['rounds']}", flush=True)

    # Measure EXACT Degree-3 Trilinear Radical R_3 and Translation Subgroup T_3 at Root (N=109)!
    t_rad = time.perf_counter()
    root_rad = compute_degree3_radicals(
        lib9, root["_buf"], root["_cub_ids"], root["_quad_ids"], root["_lin_pivs"], tbl
    )
    print(f"[{cell_name}] Root Degree-3 Radicals ({time.perf_counter()-t_rad:.2f}s): {json.dumps(root_rad)}", flush=True)

    # 4. Find the exact minimal symplectic linearizers (u_1..u_k in W_ess) of the surviving quadratics!
    root_quad_psets = [row_to_pset(root["_buf"], qr, tbl) for qr in root["_quad_ids"]]
    lin_info = find_minimal_linearizers(root_quad_psets, n)
    forms = lin_info["linearizer_forms_111"]
    k_lin = len(forms)
    print(f"[{cell_name}] Symplectic linearizers: dim_W_ess={lin_info['dim_W_ess']}, k={k_lin} -> {1<<k_lin} branches!", flush=True)

    # 5. Execute the 2^k Symplectic Linearizer Branch Cascade!
    branches_summary = []
    closed_count = 0
    first_surviving = None

    for bmask in range(1 << k_lin):
        tb = time.perf_counter()
        extra_eqs = [(forms[i], (bmask >> i) & 1) for i in range(k_lin)]
        bres = run_branch_cascade(
            lib9, root["_buf"], root["_quad_ids"], root["_cub_ids"], root["_lin_pivs"],
            extra_eqs, tbl, max_xl_rounds=5, verify_subst=(bmask == 0)
        )
        b_sec = round(time.perf_counter() - tb, 3)
        if bres["closed_unsat"]:
            closed_count += 1
            b_digest = {
                "branch": bmask,
                "bits": [(bmask >> i) & 1 for i in range(k_lin)],
                "closed_unsat": True,
                "closed_by": bres["closed_by"],
                "rounds": bres["rounds"],
                "sec": b_sec,
            }
        else:
            b_rad = compute_degree3_radicals(
                lib9, bres["_buf"], bres["_cub_ids"], bres["_quad_ids"], bres["_lin_pivs"], tbl
            )
            # Check if ANY new quadratics dropped from the cubics on this branch!
            new_q_symp = None
            sub_split_closed = None
            if bres["n_quad_surviving"] > 0:
                bq_psets = [row_to_pset(bres["_buf"], qr, tbl) for qr in bres["_quad_ids"]]
                nq_info = find_minimal_linearizers(bq_psets, n)
                new_q_symp = {"dim_W_ess_new": nq_info["dim_W_ess"], "k_lin_new": nq_info["k_linearizers"]}
                # If k_lin_new <= 4, recursively test splitting them to see if ALL sub-branches close!
                if 1 <= nq_info["k_linearizers"] <= 4:
                    sub_closed = 0
                    sub_forms = nq_info["linearizer_forms_111"]
                    for sm in range(1 << len(sub_forms)):
                        seq = [(sub_forms[i], (sm >> i) & 1) for i in range(len(sub_forms))]
                        sres = run_branch_cascade(
                            lib9, bres["_buf"], bres["_quad_ids"], bres["_cub_ids"], bres["_lin_pivs"],
                            seq, tbl, max_xl_rounds=4, verify_subst=False
                        )
                        if sres["closed_unsat"]:
                            sub_closed += 1
                    sub_split_closed = f"{sub_closed}/{1 << len(sub_forms)}"
                    if sub_closed == (1 << len(sub_forms)):
                        closed_count += 1

            b_digest = {
                "branch": bmask,
                "bits": [(bmask >> i) & 1 for i in range(k_lin)],
                "closed_unsat": (sub_split_closed is not None and sub_split_closed.split("/")[0] == sub_split_closed.split("/")[1]),
                "N_active": bres["N_active"],
                "n_quad_dropped_from_cubics": bres["n_quad_surviving"],
                "n_genuine_cubics": bres["n_genuine_cubics"],
                "total_lin_dropped": bres["total_lin_dropped"],
                "new_q_symp": new_q_symp,
                "sub_split_closed": sub_split_closed,
                "deg3_radicals": b_rad,
                "round_logs": bres["round_logs"],
                "sec": b_sec,
            }
            if first_surviving is None and not b_digest["closed_unsat"]:
                first_surviving = bres

        branches_summary.append(b_digest)
        print(f"[{cell_name} | branch {bmask:0{k_lin}b}] closed={b_digest['closed_unsat']}, "
              f"N_act={b_digest.get('N_active')}, new_quads={b_digest.get('n_quad_dropped_from_cubics')}, "
              f"gen_cubs={b_digest.get('n_genuine_cubics')}, "
              f"dim_R3={b_digest.get('deg3_radicals', {}).get('dim_R3_trilinear_radical')}, "
              f"sec={b_sec}", flush=True)

    # 6. Bonus Probe on first surviving branch: fix L_9 (F_0xff, 7 forms) + E_8 (8 even orbits)
    #    simultaneously to measure whether fixing 15 linear forms causes a cubic -> quad avalanche!
    avalanche_probe = None
    if first_surviving is not None:
        # Build the 7 independent linear forms of F_0xff and 8 even orbits of E_8 in 111-var coords!
        reps_ff = b09.fiber_orbit_reps(0xFF, 1)
        ff_forms = []
        for x in reps_ff:
            ov = 0
            for j in range(116):
                if sum((x & m) == m for m in orbits[j]) & 1:
                    ov |= (1 << j)
            vm = sum((1 << i) for i, cdir in enumerate(cb111) if (cdir & ov).bit_count() & 1)
            ob = (origin111 & ov).bit_count() & 1
            ff_forms.append((vm, ob))
        # Pick 7 independent forms of F_0xff (valid zero/weight-8 pattern: pick a valid codeword of weight 8 in B0_00/B0_11 or 6 in B1_11)
        # Simply test fixing 7 independent forms of F_0xff to a valid pattern (matching a random point on the branch!)
        piv_ff = {}
        ff_indep = []
        for vm, ob in ff_forms:
            cur = vm
            while cur:
                b = cur.bit_length() - 1
                if b in piv_ff:
                    cur ^= piv_ff[b]
                else:
                    piv_ff[b] = cur
                    ff_indep.append((vm, ob))
                    break
        # Find E_8 even orbits (8 long orbits supported on even indices {0,2,4,6,8,10,12,14})
        e8_forms = []
        for j, orb in enumerate(orbits):
            if len(orb) == 16 and any((m & 0xAAAA) == 0 for m in orb):
                vm = sum((1 << i) for i, cdir in enumerate(cb111) if (cdir >> j) & 1)
                ob = (origin111 >> j) & 1
                e8_forms.append((vm, ob))

        # Sample a consistent assignment on first_surviving for those linear forms so we don't accidentally hit trivial linear unsat
        act_v = [i for i in range(n) if i not in first_surviving["_lin_pivs"]]
        rng = random.Random(999)
        x_sample = 0
        for i in act_v:
            if rng.getrandbits(1):
                x_sample |= (1 << i)
        for p, (pv, pr) in first_surviving["_lin_pivs"].items():
            if (((pv ^ (1 << p)) & x_sample).bit_count() ^ pr) & 1:
                x_sample |= (1 << p)

        def probe_forms(tag, flist):
            eqs = [(vm, ((vm & x_sample).bit_count() & 1)) for vm, _ in flist]
            pr = run_branch_cascade(
                lib9, first_surviving["_buf"], first_surviving["_quad_ids"],
                first_surviving["_cub_ids"], first_surviving["_lin_pivs"],
                eqs, tbl, max_xl_rounds=4, verify_subst=False
            )
            return {
                "tag": tag,
                "n_forms_added": len(flist),
                "closed_unsat": pr["closed_unsat"],
                "N_active": pr.get("N_active"),
                "n_quad_dropped": pr.get("n_quad_surviving"),
                "n_genuine_cubics": pr.get("n_genuine_cubics"),
                "total_lin_dropped": pr.get("total_lin_dropped"),
            }

        avalanche_probe = [
            probe_forms("branch0 + L9(7 forms)", ff_indep),
            probe_forms("branch0 + E8(8 forms)", e8_forms),
            probe_forms("branch0 + L9 + E8(15 forms)", ff_indep + e8_forms),
        ]
        print(f"[{cell_name}] Avalanche probe on Branch 0: {json.dumps(avalanche_probe)}", flush=True)

    return {
        "cell": cell_name,
        "closed_unsat": (closed_count == (1 << k_lin)),
        "branches_closed": f"{closed_count}/{1 << k_lin}",
        "cyclotomic_cubics_added": [lbl for lbl, _ in cyc_cubs],
        "root_N_active": root["N_active"],
        "root_genuine_quads": root["n_quad_surviving"],
        "root_genuine_cubics": root["n_genuine_cubics"],
        "root_deg3_radicals": root_rad,
        "symplectic_linearizers": {"dim_W_ess": lin_info["dim_W_ess"], "k": k_lin},
        "branches": branches_summary,
        "avalanche_probe": avalanche_probe,
        "total_sec": round(time.perf_counter() - t0, 3),
    }


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--cells", type=str, default="B0_00,B0_11,B1_11")
    args = parser.parse_args()
    t_all = time.perf_counter()

    # Compile DIAGNOSE_V2_STRUCTURE C kernel
    c_diag = WORK_DIR / "step9_diag_v2.c"
    so_diag = WORK_DIR / "libstep9_diag_v2.so"
    c_diag.write_text(diag_v2.C_DIAG_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_diag), "-o", str(so_diag)], check=True)
    lib_diag = ctypes.CDLL(str(so_diag))
    lib_diag.extract_level1_quad_when_diag4.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_uint64),
    ]
    lib_diag.extract_level1_quad_when_diag4.restype = ctypes.c_int
    lib_diag.extract_coset_full_hierarchy_corrected.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int, ctypes.POINTER(ctypes.c_int), ctypes.c_int, ctypes.c_int,
        ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_uint64),
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
    ]
    lib_diag.extract_coset_full_hierarchy_corrected.restype = ctypes.c_int
    lib_diag.gf2_echelon_insert.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int,
    ]
    lib_diag.gf2_echelon_insert.restype = ctypes.c_int

    # Compile Step 9 C kernel
    c_s9 = WORK_DIR / "step9_cubic_drop.c"
    so_s9 = WORK_DIR / "libstep9_cubic_drop.so"
    c_s9.write_text(C_STEP9_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_s9), "-o", str(so_s9)], check=True)
    lib9 = ctypes.CDLL(str(so_s9))
    lib9.subst_one_linear_var_batch.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.c_int, ctypes.c_uint64, ctypes.c_uint64, ctypes.c_int,
    ]
    lib9.gf2_echelon_insert_s9.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int,
    ]
    lib9.gf2_echelon_insert_s9.restype = ctypes.c_int
    lib9.mul_deg2_row_by_var.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
    ]
    lib9.eval_row_s9.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.c_uint64, ctypes.c_uint64,
    ]
    lib9.eval_row_s9.restype = ctypes.c_int
    lib9.compute_trilinear_radical_rank.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8), ctypes.POINTER(ctypes.c_uint8),
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
    ]
    lib9.compute_trilinear_radical_rank.restype = ctypes.c_int

    print("[Init] Precomputing orbits, V6, rot^4, fibers, cyclotomic layers, and col tables...", flush=True)
    orbits = diag_v2.build_orbits_116()
    v6_list = diag_v2.all_v6_orbits()
    _, u8_size8, nonzero_z = diag_v2.build_c8_orbits()
    M_rows = []
    for rep_z, _ in nonzero_z:
        row_mask = 0
        for m_idx, (_, u_orb) in enumerate(u8_size8):
            s = sum(1 if ((u & rep_z).bit_count() & 1) == 0 else -1 for u in u_orb)
            if (s // 2) & 1:
                row_mask |= (1 << m_idx)
        M_rows.append(row_mask)
    null_z_vecs = diag_v2.gf2_nullspace_left(M_rows)
    fiber_meta = (nonzero_z, null_z_vecs)

    # Precompute rot^4 and pair tables exactly as DIAGNOSE_V2_STRUCTURE.main() does
    pair_idx, all_pairs = {}, []
    for v in range(256):
        for w in range(v + 1, 256):
            pair_idx[(v, w)] = len(all_pairs)
            all_pairs.append(v | (w << 8))
    seen_x = bytearray(65536)
    rot4_reps, rep_of_x = [], [-1] * 65536
    for x in range(65536):
        if (x & 0xFF) == (x >> 8) or seen_x[x]:
            continue
        r_idx = len(rot4_reps)
        rot4_reps.append(x)
        for y in (x, diag_v2.rot16(x, 4), diag_v2.rot16(x, 8), diag_v2.rot16(x, 12)):
            seen_x[y] = 1
            rep_of_x[y] = r_idx

    coset_0xf_reps = []
    vis16 = bytearray(65536)
    for x in range(65536):
        if vis16[x]:
            continue
        cur, mem = x, []
        while not vis16[cur]:
            vis16[cur] = 1
            mem.append(cur)
            cur = diag_v2.rot16(cur)
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
    layers, c0x0 = build_cyclotomic_layers()
    tbl = build_col_tables(111)

    report = {"cells": {}}
    for cname in [c.strip() for c in args.cells.split(",") if c.strip()]:
        res = analyze_cell_step9(cname, lib_diag, lib9, orbits, v6_list, rot4_data, fiber_meta, layers, c0x0, tbl)
        report["cells"][cname] = res
    report["total_sec"] = round(time.perf_counter() - t_all, 3)

    print("\n=== STEP 9 FINAL SUMMARY ===", flush=True)
    print(json.dumps(report, indent=2), flush=True)


if __name__ == "__main__":
    main()
