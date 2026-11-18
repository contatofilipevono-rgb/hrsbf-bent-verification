#!/usr/bin/env python3
"""
Step 4C: B0_00 and B0_11 (c99=0) with:
  - C1-C5, C7, Q4 + x_i*Q4
  - All V_6 Poisson-Lucas equations
  - All V_4 (W = {(x,y) : x^y in V_4}) Poisson-Lucas equations (if wt(D_8) % 8 == 0)
  - Iterative Macaulay XL multiplication of all discovered degree <= 2 pivots by x_i!
"""
import ctypes
import json
import random
import subprocess
import time
from pathlib import Path

from SOLVE_C99_0_STEP4B import I1, J1, build_basis_c99_0_k
from SOLVE_C99_1_POISSON_C import I2, I3, I4, J2, J3, J4, all_v6_orbits
from VERIFICAR_ALGEBRA_C99_1 import setup_orbits

C_SRC_XL = r"""
#include <stdint.h>
#include <string.h>

int extract_and_fill_row_gen(
    const uint64_t *all_pair_bits, // (n+2) * pair_words
    int pair_words,
    const int *p_idxs,
    int n_pairs,
    int n,
    int use_chi,
    const int *col3_base,
    int off2,
    int off1,
    int off0,
    uint64_t *row_words
) {
    uint64_t basis[110][32];
    uint64_t O_word[32];
    int n_w = (n_pairs + 63) >> 6;
    memset(O_word, 0, sizeof(O_word));
    for (int k = 0; k < n_pairs; k++) {
        int idx = p_idxs[k];
        int w_old = idx >> 6;
        uint64_t m_old = 1ULL << (idx & 63);
        int w_new = k >> 6;
        uint64_t m_new = 1ULL << (k & 63);
        uint64_t ob = (all_pair_bits[n * pair_words + w_old] & m_old) ? 1ULL : 0ULL;
        if (use_chi && (all_pair_bits[(n + 1) * pair_words + w_old] & m_old)) ob ^= 1ULL;
        if (ob) O_word[w_new] |= m_new;
    }
    int o_pop = 0;
    for (int w = 0; w < n_w; w++) o_pop += __builtin_popcountll(O_word[w]);
    if (o_pop & 1) return -1;

    for (int i = 0; i < n; i++) {
        memset(basis[i], 0, 32 * sizeof(uint64_t));
        const uint64_t *src = all_pair_bits + (size_t)i * pair_words;
        for (int k = 0; k < n_pairs; k++) {
            int idx = p_idxs[k];
            if ((src[idx >> 6] >> (idx & 63)) & 1ULL) {
                basis[i][k >> 6] |= 1ULL << (k & 63);
            }
        }
        int wi_pop = 0, wo_pop = 0;
        for (int w = 0; w < n_w; w++) {
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
            for (int w = 0; w < n_w; w++) {
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
                for (int w = 0; w < n_w; w++) p += __builtin_popcountll(inter[w] & basis[k][w]);
                if (p & 1) {
                    int c = base3 + (k - j - 1);
                    row_words[c >> 6] ^= 1ULL << (c & 63);
                }
            }
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
"""


def decode_row_to_pset(row_ptr, n_cols, off2, off1, off0, pair2_list, col3_list):
    pset = set()
    # Read words
    n_words = (n_cols + 63) // 64
    for w in range(n_words):
        val = row_ptr[w]
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


def main():
    t0 = time.perf_counter()
    work_dir = Path(__file__).resolve().parent
    c_path = work_dir / "poisson_c_xl.c"
    so_path = work_dir / "libpoisson_c_xl.so"
    c_path.write_text(C_SRC_XL, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_path), "-o", str(so_path)], check=True)
    lib = ctypes.CDLL(str(so_path))
    lib.extract_and_fill_row_gen.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_uint64),
    ]
    lib.extract_and_fill_row_gen.restype = ctypes.c_int
    lib.gf2_echelon_insert.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_int), ctypes.c_int,
    ]
    lib.gf2_echelon_insert.restype = ctypes.c_int

    orbits = setup_orbits()
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
    chi_pair = sum((1 << k) for k, x in enumerate(all_pairs) if x.bit_count() & 1)
    v6_list = all_v6_orbits()

    n = 109
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

    pair2_col = {}
    pair2_list = []
    for i in range(n):
        for j in range(i + 1, n):
            m = (1 << i) | (1 << j)
            pair2_col[m] = off2 + len(pair2_list)
            pair2_list.append(m)

    mask64 = (1 << 64) - 1
    p_idxs_arr = (ctypes.c_int * 2016)()
    results = {}

    for c57_val in (0, 1):
        tc = time.perf_counter()
        origin_k, cb_k = build_basis_c99_0_k(c57_val)
        O_diag, O_pair = 0, 0
        for j in range(116):
            if (origin_k >> j) & 1:
                O_diag ^= orb_diag[j]
                O_pair ^= orb_pair[j]
        cb_diag, cb_pair = [], []
        for cdir in cb_k:
            vd, vp = 0, 0
            for j in range(116):
                if (cdir >> j) & 1:
                    vd ^= orb_diag[j]
                    vp ^= orb_pair[j]
            cb_diag.append(vd)
            cb_pair.append(vp)

        all_pair_bits = (ctypes.c_uint64 * ((n + 2) * 510))()
        for i in range(n):
            v = cb_pair[i]
            for w in range(510):
                all_pair_bits[i * 510 + w] = (v >> (64 * w)) & mask64
        for w in range(510):
            all_pair_bits[n * 510 + w] = (O_pair >> (64 * w)) & mask64
            all_pair_bits[(n + 1) * 510 + w] = (chi_pair >> (64 * w)) & mask64

        max_rows = 4096
        rows = (ctypes.c_uint64 * (max_rows * n_col_words))()
        piv_row_idx = (ctypes.c_int * n_cols)(*([-1] * n_cols))

        def lin_expr(indices):
            mask = sum(1 << j for j in indices)
            idxs = [i for i, c in enumerate(cb_k) if (c & mask).bit_count() & 1]
            const = (origin_k & mask).bit_count() & 1
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

        slin_i, slin_c = lin_expr([23, 31, 39, 112])
        q4 = poly_from_lin(slin_i, slin_c ^ c57_val)
        for Ir, Jr in [(I1, J1), (I2, J2), (I3, J3), (I4, J4)]:
            ui, uc = lin_expr(Ir)
            vi, vc = lin_expr(Jr)
            q4 ^= mul_p(poly_from_lin(ui, uc), poly_from_lin(vi, vc))

        cur_row = 0
        deg_pivs = {0: 0, 1: 0, 2: 0, 3: 0}
        xl_queue = []

        def insert_pset(pset):
            nonlocal cur_row
            if cur_row >= max_rows - 1:
                return -1
            base = cur_row * n_col_words
            row_ptr = ctypes.cast(ctypes.byref(rows, base * 8), ctypes.POINTER(ctypes.c_uint64))
            ctypes.memset(row_ptr, 0, n_col_words * 8)
            for m in pset:
                d = m.bit_count()
                if d == 0: c = off0
                elif d == 1: c = off1 + (m.bit_length() - 1)
                elif d == 2: c = pair2_col[m]
                else:
                    b0 = (m & -m).bit_length() - 1
                    m1 = m ^ (1 << b0)
                    b1 = (m1 & -m1).bit_length() - 1
                    b2 = (m1 ^ (1 << b1)).bit_length() - 1
                    c = col3_base[b0 * n + b1] + (b2 - b1 - 1)
                rows[base + (c >> 6)] ^= 1 << (c & 63)
            pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
            if pc >= 0:
                if pc >= off2 and pc < off0:
                    xl_queue.append(cur_row)
                cur_row += 1
                d = 0 if pc == off0 else (1 if pc >= off1 else (2 if pc >= off2 else 3))
                deg_pivs[d] += 1
            return pc

        insert_pset(q4)
        for i in range(n):
            insert_pset(mul_p({1 << i}, q4))

        rng = random.Random(42)
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
                if cur_row >= max_rows - 1:
                    break
                base = cur_row * n_col_words
                row_ptr = ctypes.cast(ctypes.byref(rows, base * 8), ctypes.POINTER(ctypes.c_uint64))
                ctypes.memset(row_ptr, 0, n_col_words * 8)
                rc = lib.extract_and_fill_row_gen(
                    all_pair_bits, 510, p_idxs_arr, 2016, n, use_chi,
                    col3_base, off2, off1, off0, row_ptr
                )
                if rc == 0:
                    pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
                    if pc >= 0:
                        if pc >= off2 and pc < off0:
                            xl_queue.append(cur_row)
                        cur_row += 1
                        d = 0 if pc == off0 else (1 if pc >= off1 else (2 if pc >= off2 else 3))
                        deg_pivs[d] += 1

        # Iterative XL closure on any degree <= 2 pivots!
        while xl_queue and piv_row_idx[off0] < 0 and cur_row < max_rows - n - 5:
            r_idx = xl_queue.pop(0)
            row_slice = [rows[r_idx * n_col_words + w] for w in range(n_col_words)]
            pset = decode_row_to_pset(row_slice, n_cols, off2, off1, off0, pair2_list, col3_list)
            for i in range(n):
                insert_pset(mul_p({1 << i}, pset))
                if piv_row_idx[off0] >= 0:
                    break

        cell_name = f"B0_{c57_val}{c57_val}"
        results[cell_name] = {
            "total_pivots": cur_row,
            "deg_pivs": deg_pivs,
            "has_one": (piv_row_idx[off0] >= 0),
            "sec": round(time.perf_counter() - tc, 3),
        }
        print(f"{cell_name}: {results[cell_name]}", flush=True)

    print(json.dumps({"cells": results, "elapsed_sec": round(time.perf_counter() - t0, 3)}, indent=2), flush=True)


if __name__ == "__main__":
    main()
