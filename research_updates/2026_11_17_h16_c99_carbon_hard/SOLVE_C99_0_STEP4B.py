#!/usr/bin/env python3
"""
Step 4B: Test B0_00 and B0_11 (c99=0) with:
  - C1-C5 (K = c57), C7 (R=0), L=0 (c99=0)
  - C4 (Q4 = 0) and x_i * Q4
  - All V_6 Poisson-Lucas equations
  - Iterative Macaulay XL on any deg <= 2 pivots
"""
import ctypes
import json
import random
import subprocess
import time
from pathlib import Path

from SOLVE_C99_1_POISSON_C import C_SRC, I2, I3, I4, J2, J3, J4, all_v6_orbits
from VERIFICAR_ALGEBRA_C99_1 import K_INDICES, L_INDICES, R_INDICES, setup_orbits

I1 = [0, 4, 8, 18, 42, 52, 56, 94]
J1 = [14, 22, 46, 71, 81, 85, 98, 106]


def build_basis_c99_0_k(c57_val):
    excluded = {0, 5, 57, 99, 113, 115}
    free = sorted(set(range(116)) - excluded)
    L_set = set(L_INDICES)
    R_set = set(R_INDICES)
    origin = (c57_val << 57) | (c57_val << 113)
    cb = []
    for j in free:
        c = 1 << j
        if j in L_set:
            c ^= 1 << 0
        if j in R_set:
            c ^= 1 << 5
        cb.append(c)

    # Eliminate K == c57_val
    k_mask = sum(1 << j for j in K_INDICES)
    k_const = (origin & k_mask).bit_count() & 1
    piv_i = next(i for i, c in enumerate(cb) if (c & k_mask).bit_count() & 1)
    c_piv = cb[piv_i]
    origin_k = origin ^ (c_piv if (k_const ^ c57_val) else 0)
    cb_k = [c ^ (c_piv if ((c & k_mask).bit_count() & 1) else 0) for i, c in enumerate(cb) if i != piv_i]
    return origin_k, cb_k


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
    cur3 = 0
    for i in range(n):
        for j in range(i + 1, n):
            col3_base[i * n + j] = cur3
            cur3 += (n - 1 - j)

    pair2_col = {}
    idx2 = 0
    for i in range(n):
        for j in range(i + 1, n):
            pair2_col[(1 << i) | (1 << j)] = off2 + idx2
            idx2 += 1

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

        max_rows = 2 * len(v6_list) + 500
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

        # Q4 = S_lin ^ K ^ I1*J1 ^ I2*J2 ^ I3*J3 ^ I4*J4 == 0
        # Wait: let's include Q4 and x_i * Q4!
        # Note: in c99=0, verify constant shift of Q4? Actually in T28/C4, Q4 = S_lin ^ c57 ^ sum(I_r*J_r) == 0.
        slin_i, slin_c = lin_expr([23, 31, 39, 112])
        q4 = poly_from_lin(slin_i, slin_c ^ c57_val)
        for Ir, Jr in [(I1, J1), (I2, J2), (I3, J3), (I4, J4)]:
            ui, uc = lin_expr(Ir)
            vi, vc = lin_expr(Jr)
            q4 ^= mul_p(poly_from_lin(ui, uc), poly_from_lin(vi, vc))

        cur_row = 0
        deg_pivs = {0: 0, 1: 0, 2: 0, 3: 0}

        def insert_pset(pset):
            nonlocal cur_row
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
                cur_row += 1
                d = 0 if pc == off0 else (1 if pc >= off1 else (2 if pc >= off2 else 3))
                deg_pivs[d] += 1
            return pc

        for p in [q4] + [mul_p({1 << i}, q4) for i in range(n)]:
            insert_pset(p)

        rng = random.Random(42)
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
                    col3_base, off2, off1, off0, row_ptr, None
                )
                if rc == 0:
                    n_extracted += 1
                    pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
                    if pc >= 0:
                        cur_row += 1
                        d = 0 if pc == off0 else (1 if pc >= off1 else (2 if pc >= off2 else 3))
                        deg_pivs[d] += 1

        cell_name = f"B0_{c57_val}{c57_val}"
        results[cell_name] = {
            "n_extracted": n_extracted,
            "total_pivots": cur_row,
            "deg_pivs": deg_pivs,
            "has_one": (piv_row_idx[off0] >= 0),
            "sec": round(time.perf_counter() - tc, 3),
        }
        print(f"{cell_name}: {results[cell_name]}", flush=True)

    out = {"cells": results, "elapsed_sec": round(time.perf_counter() - t0, 3)}
    print(json.dumps(out, indent=2), flush=True)


if __name__ == "__main__":
    main()
