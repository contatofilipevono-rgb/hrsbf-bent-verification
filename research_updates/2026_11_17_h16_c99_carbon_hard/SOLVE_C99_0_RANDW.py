#!/usr/bin/env python3
"""
Step 5A: B0_00 / B0_11 (c99=0). Poisson-Lucas degree<=3 equations from MANY random
rot^8-invariant 12-dim subspaces W (W^perp = 4-dim, closed under half-swap), not only V6xV6.
Valid necessary condition for bent f in n=16:  wt(f|_W) = 0 mod 16, with W rot^8-invariant,
wt = 2*#pairs + #diag.  Reduced mod 4 on pairs when wt_diag = 0 mod 8 identically.
Usage: python3 SOLVE_C99_0_RANDW.py <c57_val 0|1> [time_budget_sec]
"""
import ctypes
import json
import random
import subprocess
import sys
import time
from pathlib import Path

from SOLVE_C99_0_STEP4B import I1, J1, build_basis_c99_0_k
from SOLVE_C99_0_STEP4C import C_SRC_XL
from SOLVE_C99_1_POISSON_C import I2, I3, I4, J2, J3, J4
from VERIFICAR_ALGEBRA_C99_1 import setup_orbits


def swap16(h):
    return ((h & 0xFF) << 8) | (h >> 8)


def rank_basis(vs):
    piv = {}
    out = []
    for v in vs:
        x = v
        while x:
            b = x.bit_length() - 1
            if b in piv:
                x ^= piv[b]
            else:
                piv[b] = x
                out.append(v)
                break
    return out


def nullspace_points(hs):
    """All x in F_2^16 with <h,x>=0 for h in hs (rank r) -> list of 2^(16-r) points."""
    # Gaussian elimination on rows hs to RREF, then free-variable basis.
    rows = []
    for h in hs:
        x = h
        for r in rows:
            if x & (1 << (r.bit_length() - 1)):
                x ^= r
        if x:
            rows.append(x)
    # reduce
    rows.sort(reverse=True)
    for i in range(len(rows)):
        pb = rows[i].bit_length() - 1
        for j in range(len(rows)):
            if j != i and (rows[j] >> pb) & 1:
                rows[j] ^= rows[i]
    pivs = {r.bit_length() - 1: r for r in rows}
    basis = []
    for f in range(16):
        if f in pivs:
            continue
        v = 1 << f
        for pb, r in pivs.items():
            if (r >> f) & 1:
                v |= 1 << pb
        basis.append(v)
    pts = [0]
    for b in basis:
        pts += [p ^ b for p in pts]
    return pts


def main():
    c57_val = int(sys.argv[1])
    budget = float(sys.argv[2]) if len(sys.argv) > 2 else 200.0
    t0 = time.perf_counter()
    work_dir = Path(__file__).resolve().parent
    c_path = work_dir / f"poisson_c_xl_{c57_val}.c"
    so_path = work_dir / f"libpoisson_c_xl_{c57_val}.so"
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
    orb_diag, orb_pair = [0] * 116, [0] * 116
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
        for w in range(510):
            all_pair_bits[i * 510 + w] = (cb_pair[i] >> (64 * w)) & mask64
    for w in range(510):
        all_pair_bits[n * 510 + w] = (O_pair >> (64 * w)) & mask64
        all_pair_bits[(n + 1) * 510 + w] = (chi_pair >> (64 * w)) & mask64

    max_rows = 4000
    rows = (ctypes.c_uint64 * (max_rows * n_col_words))()
    piv_row_idx = (ctypes.c_int * n_cols)(*([-1] * n_cols))
    cur_row = 0
    deg_pivs = {0: 0, 1: 0, 2: 0, 3: 0}

    def lin_expr(indices):
        mask = sum(1 << j for j in indices)
        idxs = [i for i, c in enumerate(cb_k) if (c & mask).bit_count() & 1]
        return idxs, (origin_k & mask).bit_count() & 1

    def poly_from_lin(idxs, const):
        p = {1 << i for i in idxs}
        if const:
            p.add(0)
        return p

    def mul_p(p1, p2):
        out = set()
        for a in p1:
            for b in p2:
                m = a | b
                out.symmetric_difference_update({m})
        return out

    def insert_pset(pset):
        nonlocal cur_row
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
        if pc >= 0:
            cur_row += 1
            d = 0 if pc == off0 else (1 if pc >= off1 else (2 if pc >= off2 else 3))
            deg_pivs[d] += 1
        return pc

    slin_i, slin_c = lin_expr([23, 31, 39, 112])
    q4 = poly_from_lin(slin_i, slin_c ^ c57_val)
    for Ir, Jr in [(I1, J1), (I2, J2), (I3, J3), (I4, J4)]:
        ui, uc = lin_expr(Ir)
        vi, vc = lin_expr(Jr)
        q4 ^= mul_p(poly_from_lin(ui, uc), poly_from_lin(vi, vc))
    insert_pset(q4)
    for i in range(n):
        insert_pset(mul_p({1 << i}, q4))

    rng = random.Random(1000 + c57_val)
    p_idxs_arr = (ctypes.c_int * 2048)()
    seen = set()
    tried = diag_ok = extracted = 0
    kinds = {"free2": 0, "free1sym2": 0}
    while time.perf_counter() - t0 < budget and piv_row_idx[off0] < 0 and cur_row < max_rows - 4:
        kind = "free2" if rng.random() < 0.7 else "free1sym2"
        if kind == "free2":
            h1, h2 = rng.randint(1, 65535), rng.randint(1, 65535)
            hs = [h1, h2, swap16(h1), swap16(h2)]
        else:
            h1 = rng.randint(1, 65535)
            a1, a2 = rng.randint(1, 255), rng.randint(1, 255)
            hs = [h1, swap16(h1), a1 | (a1 << 8), a2 | (a2 << 8)]
        rb = rank_basis(hs)
        if len(rb) != 4:
            continue
        key = tuple(sorted(rank_basis(sorted(hs))))
        # canonical: RREF of span
        span = {0}
        for b in rb:
            span |= {s ^ b for s in span}
        key = frozenset(span)
        if key in seen:
            continue
        seen.add(key)
        tried += 1
        pts = nullspace_points(rb)
        if len(pts) != 4096:
            continue
        diag = [x & 0xFF for x in pts if (x & 0xFF) == (x >> 8)]
        plist = [pair_idx[(x & 0xFF, x >> 8)] for x in pts if (x & 0xFF) < (x >> 8)]
        if len(plist) + len(diag) * 0 > 2048:
            continue
        # diag_pop % 8 == 0 identically? probabilistic filter (random 24 combos + origin)
        dmask = 0
        for v in diag:
            dmask |= 1 << v
        ok = True
        for _ in range(24):
            w = O_diag
            for bi in cb_diag:
                if rng.getrandbits(1):
                    w ^= bi
            if (w & dmask).bit_count() % 8 != 0:
                ok = False
                break
        if not ok:
            continue
        diag_ok += 1
        for k, v in enumerate(plist):
            p_idxs_arr[k] = v
        for use_chi in (0, 1):
            base = cur_row * n_col_words
            row_ptr = ctypes.cast(ctypes.byref(rows, base * 8), ctypes.POINTER(ctypes.c_uint64))
            ctypes.memset(row_ptr, 0, n_col_words * 8)
            rc = lib.extract_and_fill_row_gen(all_pair_bits, 510, p_idxs_arr, len(plist), n, use_chi,
                                              col3_base, off2, off1, off0, row_ptr)
            if rc == 0:
                extracted += 1
                kinds[kind] += 1
                pc = lib.gf2_echelon_insert(rows, cur_row, n_col_words, piv_row_idx, n_cols)
                if pc >= 0:
                    cur_row += 1
                    d = 0 if pc == off0 else (1 if pc >= off1 else (2 if pc >= off2 else 3))
                    deg_pivs[d] += 1

    out = {
        "cell": f"B0_{c57_val}{c57_val}",
        "has_one": piv_row_idx[off0] >= 0,
        "subspaces_tried": tried,
        "diag_filter_ok": diag_ok,
        "polys_extracted": extracted,
        "kinds": kinds,
        "total_pivots": cur_row,
        "deg_pivs": deg_pivs,
        "elapsed_sec": round(time.perf_counter() - t0, 2),
    }
    print(json.dumps(out, indent=2), flush=True)


if __name__ == "__main__":
    main()
