#!/usr/bin/env python3
"""
Step 4E: Close B0_00 and B0_11 (c99=0) using the 1 linear + ~113-116 quadratic pivots
from Poisson-Lucas + Q4 + XL, combined with C6 (T28 branch 0) in CaDiCaL 1.9.5!
"""
import ctypes
import json
import random
import subprocess
import time
from pathlib import Path

from pysat.solvers import Solver

from SOLVE_C99_0_STEP4B import I1, J1, build_basis_c99_0_k
from SOLVE_C99_0_STEP4C import C_SRC_XL, decode_row_to_pset
from SOLVE_C99_0_STEP4D import gen_v4_list
from SOLVE_C99_1_POISSON_C import I2, I3, I4, J2, J3, J4, all_v6_orbits
from VERIFICAR_ALGEBRA_C99_1 import R_INDICES, setup_orbits


def add_xor_clause(clauses, lits, rhs):
    n = len(lits)
    if n == 0:
        if rhs == 1:
            clauses.append([])
        return
    if n == 1:
        clauses.append([lits[0] if rhs else -lits[0]])
        return
    for mask in range(1 << n):
        if mask.bit_count() % 2 != rhs:
            clauses.append([(-lits[i] if (mask >> i) & 1 else lits[i]) for i in range(n)])


def add_long_xor(clauses, lits, rhs, next_var_fn):
    cur = list(lits)
    while len(cur) > 4:
        chunk = cur[:3]
        aux = next_var_fn()
        add_xor_clause(clauses, chunk + [aux], 0)
        cur = [aux] + cur[3:]
    add_xor_clause(clauses, cur, rhs)


def add_and_gate(clauses, out_lit, in_lits):
    for x in in_lits:
        clauses.append([-out_lit, x])
    clauses.append([out_lit] + [-x for x in in_lits])


def encode_poly_zero_vars(clauses, poly_set, next_var_fn, pair_cache):
    rhs = 1 if (0 in poly_set) else 0
    lits = []
    for m in poly_set:
        if m == 0:
            continue
        bits = []
        tmp = m
        while tmp:
            b = tmp & -tmp
            bits.append(b.bit_length())  # 1-based SAT var
            tmp ^= b
        if len(bits) == 1:
            lits.append(bits[0])
        elif len(bits) == 2:
            key = (bits[0], bits[1])
            if key not in pair_cache:
                mv = next_var_fn()
                add_and_gate(clauses, mv, bits)
                pair_cache[key] = mv
            lits.append(pair_cache[key])
        else:
            mv = next_var_fn()
            add_and_gate(clauses, mv, bits)
            lits.append(mv)
    add_long_xor(clauses, lits, rhs, next_var_fn)


def audit_65536(c_int, orbits):
    tt = [0] * 65536
    for j in range(116):
        if (c_int >> j) & 1:
            for m in orbits[j]:
                for x in range(65536):
                    if (x & m) == m:
                        tt[x] ^= 1
    spec = [1 - 2 * v for v in tt]
    step = 1
    while step < 65536:
        for i in range(0, 65536, step << 1):
            for j in range(step):
                u, v = spec[i + j], spec[i + j + step]
                spec[i + j], spec[i + j + step] = u + v, u - v
        step <<= 1
    first_fail = next(({"mask_hex": hex(b), "weight": b.bit_count(), "val": spec[b]} for b in range(65536) if abs(spec[b]) != 256), None)
    return {"coefficients_hex": hex(c_int), "W_f_0": spec[0], "W_f_e0": spec[1], "is_bent": (first_fail is None), "first_fail": first_fail}


def main():
    t0 = time.perf_counter()
    repo = Path(__file__).resolve().parents[2]
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
    v4_list = gen_v4_list(500)

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

        max_rows = 12000
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
        xl_queue = []
        deg12_rows = []

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
                    deg12_rows.append(cur_row)
                cur_row += 1
            return pc

        insert_pset(q4)
        for i in range(n):
            insert_pset(mul_p({1 << i}, q4))

        rng = random.Random(42)
        def run_subspace_list(sub_iter, n_pairs):
            nonlocal cur_row
            for diag_mask, p_list in sub_iter:
                if piv_row_idx[off0] >= 0 or cur_row >= max_rows - 1:
                    break
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
                for k, v in enumerate(p_list):
                    p_idxs_arr[k] = v
                for use_chi in (0, 1):
                    if cur_row >= max_rows - 1:
                        break
                    base = cur_row * n_col_words
                    row_ptr = ctypes.cast(ctypes.byref(rows, base * 8), ctypes.POINTER(ctypes.c_uint64))
                    ctypes.memset(row_ptr, 0, n_col_words * 8)
                    rc = lib.extract_and_fill_row_gen(
                        all_pair_bits, 510, p_idxs_arr, n_pairs, n, use_chi,
                        col3_base, off2, off1, off0, row_ptr
                    )
                    if rc == 0:
                        pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
                        if pc >= 0:
                            if pc >= off2 and pc < off0:
                                xl_queue.append(cur_row)
                                deg12_rows.append(cur_row)
                            cur_row += 1

        run_subspace_list(
            ((sum(1 << v for v in pts), [pair_idx[(pts[i], pts[j])] for i in range(len(pts)) for j in range(i + 1, len(pts))]) for pts in v6_list),
            2016,
        )
        all_d8_mask = (1 << 256) - 1
        run_subspace_list(
            ((all_d8_mask, [pair_idx[(v, v ^ d)] for v in range(256) for d in v4 if d != 0 and v < (v ^ d)]) for v4 in v4_list),
            1920,
        )
        while xl_queue and piv_row_idx[off0] < 0 and cur_row < max_rows - n - 5:
            r_idx = xl_queue.pop(0)
            row_slice = [rows[r_idx * n_col_words + w] for w in range(n_col_words)]
            pset = decode_row_to_pset(row_slice, n_cols, off2, off1, off0, pair2_list, col3_list)
            for i in range(n):
                insert_pset(mul_p({1 << i}, pset))
                if piv_row_idx[off0] >= 0:
                    break

        # Feed all deg <= 2 pivots into CaDiCaL 1.9.5!
        clauses = []
        v_cnt = [n]
        def new_var():
            v_cnt[0] += 1
            return v_cnt[0]
        pair_cache = {}
        for r_idx in deg12_rows:
            row_slice = [rows[r_idx * n_col_words + w] for w in range(n_col_words)]
            pset = decode_row_to_pset(row_slice, n_cols, off2, off1, off0, pair2_list, col3_list)
            encode_poly_zero_vars(clauses, pset, new_var, pair_cache)

        ts = time.perf_counter()
        with Solver(name="cadical195", bootstrap_with=clauses) as slv:
            sat = slv.solve()
            sat_sec = round(time.perf_counter() - ts, 4)
            aud = None
            if sat:
                model = slv.get_model()
                cint = origin_k
                for i, cdir in enumerate(cb_k):
                    if model[i] > 0:
                        cint ^= cdir
                aud = audit_65536(cint, orbits)

        cell_name = f"B0_{c57_val}{c57_val}"
        results[cell_name] = {
            "deg12_count": len(deg12_rows),
            "sat_vars": v_cnt[0],
            "sat_clauses": len(clauses),
            "sat": bool(sat),
            "sat_sec": sat_sec,
            "audit": aud,
            "total_sec": round(time.perf_counter() - tc, 3),
        }
        print(f"{cell_name}: {results[cell_name]}", flush=True)

    print(json.dumps({"cells": results, "elapsed_sec": round(time.perf_counter() - t0, 3)}, indent=2), flush=True)


if __name__ == "__main__":
    main()
