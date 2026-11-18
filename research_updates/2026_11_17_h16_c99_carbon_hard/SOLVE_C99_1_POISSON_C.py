#!/usr/bin/env python3
"""
Step 3I: Pure-C Bitset Poisson-Lucas Extractor + Pure-C GF(2) Macaulay Reduction.
1. Enumerates ALL C_8-orbits of 6-dim subspaces V_6 <= F_2^8 (canonicalized properly).
2. Packs 2,016-bit vectors and extracts degree <= 3 polynomials in C (OpenMP).
3. Performs dense uint64_t bitset GF(2) Gaussian elimination in C over all
   215,934 monomials of degree <= 3 (in 109 vars after K=1), including L_coset^1
   and x_i*(L_coset^1), exposing any degree <= 2 / linear / constant drops!
"""
import ctypes
import json
import random
import subprocess
import time
from itertools import combinations
from pathlib import Path

from VERIFICAR_ALGEBRA_C99_1 import K_INDICES, build_basis_111, setup_orbits

I2 = [1, 9, 15, 28, 53, 67, 76, 103]
J2 = [3, 11, 34, 45, 55, 69, 78, 89]
I3 = [2, 10, 25, 37, 54, 68, 83, 104]
J3 = [12, 20, 29, 33, 41, 48, 96, 110]
I4 = [13, 21, 38, 70, 74, 93, 97, 109]
J4 = [24, 32, 47, 72, 80, 86, 91, 107]


C_SRC = r"""
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

// Pack p_idxs[0..2015] from big_bits (n_vars * 510 uint64_t words, since 32640 = 510 * 64)
// into out_words (32 uint64_t words per var) and extract degree <= 3 monomials.
// Column mapping:
//   deg 3: col = idx3(i,j,k) in [0 .. C(n,3)-1]
//   deg 2: col = C(n,3) + idx2(i,j)
//   deg 1: col = C(n,3) + C(n,2) + i
//   deg 0: col = C(n,3) + C(n,2) + n  (last column!)
int extract_and_fill_row(
    const uint64_t *all_pair_bits, // (n+2) * 510 words: [0..n-1]=cb, [n]=O, [n+1]=chi
    const int *p_idxs,             // 2016 indices in 0..32639
    int n,
    int use_chi,
    const int *col3_base,          // precomputed offset for (i, j) -> col3_base[i*n+j] + k
    int off2,
    int off1,
    int off0,
    uint64_t *row_words,           // zeroed buffer of n_col_words
    int *out_deg_counts            // optional [4]
) {
    uint64_t basis[110][32];
    uint64_t O_word[32];
    memset(O_word, 0, sizeof(O_word));
    for (int k = 0; k < 2016; k++) {
        int idx = p_idxs[k];
        int w_old = idx >> 6;
        uint64_t m_old = 1ULL << (idx & 63);
        int w_new = k >> 6;
        uint64_t m_new = 1ULL << (k & 63);
        uint64_t ob = (all_pair_bits[n * 510 + w_old] & m_old) ? 1ULL : 0ULL;
        if (use_chi && (all_pair_bits[(n + 1) * 510 + w_old] & m_old)) ob ^= 1ULL;
        if (ob) O_word[w_new] |= m_new;
    }
    int o_pop = 0;
    for (int w = 0; w < 32; w++) o_pop += __builtin_popcountll(O_word[w]);
    if (o_pop & 1) return -1;

    for (int i = 0; i < n; i++) {
        memset(basis[i], 0, 32 * sizeof(uint64_t));
        const uint64_t *src = all_pair_bits + i * 510;
        for (int k = 0; k < 2016; k++) {
            int idx = p_idxs[k];
            if ((src[idx >> 6] >> (idx & 63)) & 1ULL) {
                basis[i][k >> 6] |= 1ULL << (k & 63);
            }
        }
        int wi_pop = 0, wo_pop = 0;
        for (int w = 0; w < 32; w++) {
            wi_pop += __builtin_popcountll(basis[i][w]);
            wo_pop += __builtin_popcountll(basis[i][w] & O_word[w]);
        }
        if ((wi_pop & 1) || ((wi_pop - 2 * wo_pop) & 3)) return -2;
        if (((wi_pop - 2 * wo_pop) / 4) & 1) {
            int c = off1 + i;
            row_words[c >> 6] ^= 1ULL << (c & 63);
        }
    }
    if ((o_pop / 4) & 1) {
        row_words[off0 >> 6] ^= 1ULL << (off0 & 63);
    }
    int c2_idx = 0;
    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            int inter_pop = 0, io_pop = 0;
            uint64_t inter[32];
            for (int w = 0; w < 32; w++) {
                uint64_t iv = basis[i][w] & basis[j][w];
                inter[w] = iv;
                inter_pop += __builtin_popcountll(iv);
                io_pop += __builtin_popcountll(iv & O_word[w]);
            }
            if (inter_pop & 1) return -3;
            if ((inter_pop / 2 + io_pop) & 1) {
                int c = off2 + c2_idx;
                row_words[c >> 6] ^= 1ULL << (c & 63);
            }
            c2_idx++;
            int base3 = col3_base[i * n + j];
            for (int k = j + 1; k < n; k++) {
                int p = 0;
                for (int w = 0; w < 32; w++) p += __builtin_popcountll(inter[w] & basis[k][w]);
                if (p & 1) {
                    int c = base3 + (k - j - 1);
                    row_words[c >> 6] ^= 1ULL << (c & 63);
                }
            }
        }
    }
    return 0;
}

// Sparse-pivot dense-row GF(2) echelonization:
// piv_row_idx[col] = index of pivot row in `rows` (or -1)
int gf2_echelon_insert(
    uint64_t *rows,      // max_rows * n_words
    int row_idx,
    int n_words,
    int *piv_row_idx,    // n_cols, initialized to -1
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
    return -1; // reduced to 0
}
"""


def rot8(v):
    return ((v << 1) & 0xFF) | (v >> 7)


def all_v6_orbits():
    """Enumerate all C_8-orbits of 6-dim subspaces of F_2^8."""
    dual2_seen = set()
    orbits_pts = []
    for a in range(1, 256):
        for b in range(a + 1, 256):
            c = a ^ b
            trip = tuple(sorted((a, b, c)))
            if trip in dual2_seen:
                continue
            cur = trip
            for _ in range(8):
                dual2_seen.add(tuple(sorted(cur)))
                cur = tuple(rot8(x) for x in cur)
            pts = [v for v in range(256) if ((v & a).bit_count() & 1) == 0 and ((v & b).bit_count() & 1) == 0]
            orbits_pts.append(pts)
    return orbits_pts


def main():
    t0 = time.perf_counter()
    work_dir = Path(__file__).resolve().parent
    c_path = work_dir / "poisson_c_echelon.c"
    so_path = work_dir / "libpoisson_c_echelon.so"
    c_path.write_text(C_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_path), "-o", str(so_path)], check=True)
    lib = ctypes.CDLL(str(so_path))
    lib.extract_and_fill_row.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
    ]
    lib.extract_and_fill_row.restype = ctypes.c_int
    lib.gf2_echelon_insert.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int,
    ]
    lib.gf2_echelon_insert.restype = ctypes.c_int

    orbits = setup_orbits()
    free, origin, cb = build_basis_111()

    # Eliminate K = 1 directly from (origin, cb) -> 109 free vars!
    k_mask = sum(1 << j for j in K_INDICES)
    k_const = (origin & k_mask).bit_count() & 1
    piv_i = next(i for i, c in enumerate(cb) if (c & k_mask).bit_count() & 1)
    c_piv = cb[piv_i]
    origin_k1 = origin ^ (c_piv if (k_const ^ 1) else 0)
    cb_k1 = [c ^ (c_piv if ((c & k_mask).bit_count() & 1) else 0) for i, c in enumerate(cb) if i != piv_i]
    n = len(cb_k1)  # 109
    assert n == 109

    # Column layout for n=109
    n3 = n * (n - 1) * (n - 2) // 6
    n2 = n * (n - 1) // 2
    off2 = n3
    off1 = n3 + n2
    off0 = n3 + n2 + n
    n_cols = off0 + 1
    n_col_words = (n_cols + 63) // 64
    col3_base = (ctypes.c_int * (n * n))()
    cur3 = 0
    for i in range(n):
        for j in range(i + 1, n):
            col3_base[i * n + j] = cur3
            cur3 += (n - 1 - j)
    assert cur3 == n3

    # Precompute 32640 pairs
    pair_idx = {}
    all_pairs = []
    for v in range(256):
        for w in range(v + 1, 256):
            pair_idx[(v, w)] = len(all_pairs)
            all_pairs.append(v | (w << 8))

    orb_diag = [0] * 116
    orb_pair = [0] * 116
    for j, orb in enumerate(orbits):
        vd = 0
        for v in range(256):
            x = v | (v << 8)
            if sum((x & m) == m for m in orb) & 1:
                vd |= 1 << v
        orb_diag[j] = vd
        vp = 0
        for k, x in enumerate(all_pairs):
            if sum((x & m) == m for m in orb) & 1:
                vp |= 1 << k
        orb_pair[j] = vp

    O_diag, O_pair = 0, 0
    for j in range(116):
        if (origin_k1 >> j) & 1:
            O_diag ^= orb_diag[j]
            O_pair ^= orb_pair[j]
    cb_diag, cb_pair = [], []
    for cdir in cb_k1:
        vd, vp = 0, 0
        for j in range(116):
            if (cdir >> j) & 1:
                vd ^= orb_diag[j]
                vp ^= orb_pair[j]
        cb_diag.append(vd)
        cb_pair.append(vp)
    chi_pair = sum((1 << k) for k, x in enumerate(all_pairs) if x.bit_count() & 1)

    # Pack all_pair_bits into C array (111 * 510 uint64_t)
    all_pair_bits = (ctypes.c_uint64 * ((n + 2) * 510))()
    mask64 = (1 << 64) - 1
    for i in range(n):
        v = cb_pair[i]
        for w in range(510):
            all_pair_bits[i * 510 + w] = (v >> (64 * w)) & mask64
    for w in range(510):
        all_pair_bits[n * 510 + w] = (O_pair >> (64 * w)) & mask64
        all_pair_bits[(n + 1) * 510 + w] = (chi_pair >> (64 * w)) & mask64

    v6_list = all_v6_orbits()
    max_rows = 2 * len(v6_list) + 200
    rows = (ctypes.c_uint64 * (max_rows * n_col_words))()
    piv_row_idx = (ctypes.c_int * n_cols)(*([-1] * n_cols))
    print(f"Setup done in {time.perf_counter()-t0:.2f}s; v6_orbits={len(v6_list)}, n_cols={n_cols}", flush=True)

    # First insert L_coset^1 and x_i * (L_coset^1)
    def lin_expr_k1(indices):
        mask = sum(1 << j for j in indices)
        idxs = [i for i, c in enumerate(cb_k1) if (c & mask).bit_count() & 1]
        const = (origin_k1 & mask).bit_count() & 1
        return idxs, const

    def poly_from_lin(idxs, const):
        p = {1 << i for i in idxs}
        if const: p.add(0)
        return p

    def mul_p(p1, p2):
        out = set()
        for a in p1:
            for b in p2:
                m = a | b
                if m in out: out.remove(m)
                else: out.add(m)
        return out

    slin_i, slin_c = lin_expr_k1([23, 31, 39, 112])
    lc = poly_from_lin(slin_i, slin_c ^ 1)
    for Ir, Jr in [(I2, J2), (I3, J3), (I4, J4)]:
        ui, uc = lin_expr_k1(Ir)
        vi, vc = lin_expr_k1(Jr)
        lc ^= mul_p(poly_from_lin(ui, uc), poly_from_lin(vi, vc))

    # Map pair (i, j) to off2 + idx
    pair2_col = {}
    idx2 = 0
    for i in range(n):
        for j in range(i + 1, n):
            pair2_col[(1 << i) | (1 << j)] = off2 + idx2
            idx2 += 1

    def insert_pset(pset, cur_row):
        base = cur_row * n_col_words
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
                raise ValueError(f"deg {d}")
            rows[base + (c >> 6)] ^= 1 << (c & 63)
        piv_c = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
        return piv_c

    cur_row = 0
    deg_pivs = {0: 0, 1: 0, 2: 0, 3: 0}
    for p in [lc] + [mul_p({1 << i}, lc) for i in range(n)]:
        pc = insert_pset(p, cur_row)
        if pc >= 0:
            cur_row += 1
            d = 0 if pc == off0 else (1 if pc >= off1 else (2 if pc >= off2 else 3))
            deg_pivs[d] += 1

    # Now extract and insert all V_6 polynomials in C!
    rng = random.Random(42)
    p_idxs_arr = (ctypes.c_int * 2016)()
    n_extracted = 0
    for pts in v6_list:
        diag_mask = sum(1 << v for v in pts)
        d_ok = True
        for _ in range(32):
            w = O_diag
            for bi in cb_diag:
                if rng.randint(0, 1):
                    w ^= bi
            if (w & diag_mask).bit_count() % 8 != 0:
                d_ok = False
                break
        if not d_ok:
            continue
        p_list = [pair_idx[(pts[i], pts[j])] for i in range(len(pts)) for j in range(i + 1, len(pts))]
        for k, v in enumerate(p_list):
            p_idxs_arr[k] = v
        for use_chi in (0, 1):
            base = cur_row * n_col_words
            row_ptr = ctypes.cast(ctypes.byref(rows, base * 8), ctypes.POINTER(ctypes.c_uint64))
            ctypes.memset(row_ptr, 0, n_col_words * 8)
            rc = lib.extract_and_fill_row(
                all_pair_bits, p_idxs_arr, n, use_chi,
                col3_base, off2, off1, off0,
                row_ptr, None
            )
            if rc == 0:
                n_extracted += 1
                pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
                if pc >= 0:
                    cur_row += 1
                    d = 0 if pc == off0 else (1 if pc >= off1 else (2 if pc >= off2 else 3))
                    deg_pivs[d] += 1

    out = {
        "v6_orbits": len(v6_list),
        "n_extracted": n_extracted,
        "total_pivots": cur_row,
        "deg_pivs": deg_pivs,
        "has_one": (piv_row_idx[off0] >= 0),
        "elapsed_sec": round(time.perf_counter() - t0, 3),
    }
    (work_dir / "poisson_c_report.json").write_text(json.dumps(out, indent=2), encoding="utf-8")
    print(json.dumps(out, indent=2), flush=True)


if __name__ == "__main__":
    main()
