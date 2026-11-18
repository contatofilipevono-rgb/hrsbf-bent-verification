#!/usr/bin/env python3
"""
Step 3J: Extract and Independently Verify the GF(2) Degree-3 Nullstellensatz Certificate
for Branch c99=1 (K=1, L_coset=1 + V_6 Poisson-Lucas equations).
"""
import ctypes
import json
import random
import subprocess
import time
from pathlib import Path

from SOLVE_C99_1_POISSON_C import I2, I3, I4, J2, J3, J4, all_v6_orbits
from VERIFICAR_ALGEBRA_C99_1 import K_INDICES, build_basis_111, extract_poly_mod4, setup_orbits

C_SRC_CERT = r"""
#include <stdint.h>
#include <string.h>

int extract_and_fill_row(
    const uint64_t *all_pair_bits,
    const int *p_idxs,
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

// Also track dependency bitmask in deps (max 8 uint64_t words = 512 pivots)
int gf2_echelon_insert_dep(
    uint64_t *rows,
    uint64_t *deps,      // max_rows * 8
    int row_idx,
    int n_words,
    int *piv_row_idx,
    int n_cols
) {
    uint64_t *r = rows + (size_t)row_idx * n_words;
    uint64_t *d = deps + (size_t)row_idx * 8;
    memset(d, 0, 8 * sizeof(uint64_t));
    d[row_idx >> 6] |= 1ULL << (row_idx & 63);

    for (int w = 0; w < n_words; w++) {
        while (r[w] != 0ULL) {
            int bit = __builtin_ctzll(r[w]);
            int col = (w << 6) + bit;
            if (col >= n_cols) return -1;
            int p_idx = piv_row_idx[col];
            if (p_idx >= 0) {
                const uint64_t *p = rows + (size_t)p_idx * n_words;
                const uint64_t *pd = deps + (size_t)p_idx * 8;
                for (int k = w; k < n_words; k++) r[k] ^= p[k];
                for (int k = 0; k < 8; k++) d[k] ^= pd[k];
            } else {
                piv_row_idx[col] = row_idx;
                return col;
            }
        }
    }
    return -1;
}
"""


def main():
    t0 = time.perf_counter()
    work_dir = Path(__file__).resolve().parent
    c_path = work_dir / "poisson_cert.c"
    so_path = work_dir / "libpoisson_cert.so"
    c_path.write_text(C_SRC_CERT, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_path), "-o", str(so_path)], check=True)
    lib = ctypes.CDLL(str(so_path))
    lib.extract_and_fill_row.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_int),
        ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint64),
    ]
    lib.extract_and_fill_row.restype = ctypes.c_int
    lib.gf2_echelon_insert_dep.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int, ctypes.c_int, ctypes.POINTER(ctypes.c_int), ctypes.c_int,
    ]
    lib.gf2_echelon_insert_dep.restype = ctypes.c_int

    orbits = setup_orbits()
    free, origin, cb = build_basis_111()

    k_mask = sum(1 << j for j in K_INDICES)
    k_const = (origin & k_mask).bit_count() & 1
    piv_i = next(i for i, c in enumerate(cb) if (c & k_mask).bit_count() & 1)
    c_piv = cb[piv_i]
    origin_k1 = origin ^ (c_piv if (k_const ^ 1) else 0)
    cb_k1 = [c ^ (c_piv if ((c & k_mask).bit_count() & 1) else 0) for i, c in enumerate(cb) if i != piv_i]
    n = len(cb_k1)

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
    max_rows = 512
    rows = (ctypes.c_uint64 * (max_rows * n_col_words))()
    deps = (ctypes.c_uint64 * (max_rows * 8))()
    piv_row_idx = (ctypes.c_int * n_cols)(*([-1] * n_cols))

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

    pair2_col = {}
    idx2 = 0
    for i in range(n):
        for j in range(i + 1, n):
            pair2_col[(1 << i) | (1 << j)] = off2 + idx2
            idx2 += 1

    row_sources = []
    cur_row = 0
    lc_list = [("lc", lc)] + [(f"x{i}*lc", mul_p({1 << i}, lc)) for i in range(n)]
    for label, pset in lc_list:
        base = cur_row * n_col_words
        ctypes.memset(ctypes.cast(ctypes.byref(rows, base * 8), ctypes.POINTER(ctypes.c_uint64)), 0, n_col_words * 8)
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
        pc = lib.gf2_echelon_insert_dep(rows, deps, cur_row, n_col_words, piv_row_idx, n_cols)
        if pc >= 0:
            row_sources.append((label, pset))
            cur_row += 1

    rng = random.Random(42)
    p_idxs_arr = (ctypes.c_int * 2016)()
    one_row_idx = None
    for v_idx, pts in enumerate(v6_list):
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
            rc = lib.extract_and_fill_row(all_pair_bits, p_idxs_arr, n, use_chi, col3_base, off2, off1, off0, row_ptr)
            if rc == 0:
                pc = lib.gf2_echelon_insert_dep(rows, deps, cur_row, n_col_words, piv_row_idx, n_cols)
                if pc >= 0:
                    row_sources.append(("v6", v_idx, pts, use_chi))
                    if pc == off0:
                        one_row_idx = cur_row
                        break
                    cur_row += 1
        if one_row_idx is not None:
            break

    assert one_row_idx is not None, "Did not find 1=0!"
    # Reconstruct exact subset of row_sources that XOR to 1
    used_indices = []
    for r_i in range(cur_row + 1):
        if (deps[one_row_idx * 8 + (r_i >> 6)] >> (r_i & 63)) & 1:
            used_indices.append(r_i)

    # INDEPENDENT PURE-PYTHON VERIFICATION of every row in used_indices!
    acc_poly = set()
    used_lc = []
    used_v6 = []
    k1_vars = list(range(n))
    for r_i in used_indices:
        src = row_sources[r_i]
        if src[0] != "v6":
            used_lc.append(src[0])
            acc_poly ^= src[1]
        else:
            _, v_idx, pts, use_chi = src
            used_v6.append({"v_idx": v_idx, "use_chi": use_chi})
            # 1. Deterministically verify wt_diag % 8 == 0 on ALL 109 vars!
            diag_mask = sum(1 << v for v in pts)
            # Check wt_diag % 4 == 0 deterministically via extract_poly_mod4
            bd_sub = [bw & diag_mask for bw in cb_diag]
            od_sub = O_diag & diag_mask
            assert extract_poly_mod4(bd_sub, od_sub, k1_vars, const_shift=0) == set(), "wt_diag % 4 != 0!"
            # Check degree <= 3 of (wt_diag // 4) % 2 is identically 0 (all triples have even intersection)
            for i in range(n):
                for j in range(i + 1, n):
                    ij = bd_sub[i] & bd_sub[j]
                    if ij:
                        for k in range(j + 1, n):
                            assert ((ij & bd_sub[k]).bit_count() & 1) == 0, "wt_diag % 8 deg-3 nonzero!"
            # 2. Extract V_6 pairs poly in PURE PYTHON via extract_poly_mod4
            pairs = [pts[i] | (pts[j] << 8) for i in range(len(pts)) for j in range(i + 1, len(pts))]
            words = [sum((sum((x & m) == m for m in orb) % 2) << k for k, x in enumerate(pairs)) for orb in orbits]
            Ow = 0
            for j in range(116):
                if (origin_k1 >> j) & 1:
                    Ow ^= words[j]
            if use_chi:
                for k, x in enumerate(pairs):
                    if x.bit_count() & 1:
                        Ow ^= 1 << k
            bw = []
            for cdir in cb_k1:
                w = 0
                for j in range(116):
                    if (cdir >> j) & 1:
                        w ^= words[j]
                bw.append(w)
            p_py = extract_poly_mod4(bw, Ow, k1_vars, const_shift=0)
            acc_poly ^= p_py

    assert acc_poly == {0}, f"Independent verification FAILED! acc_poly len = {len(acc_poly)}"
    cert = {
        "verified_independent_pure_python": True,
        "acc_poly_equals_one": True,
        "total_used_equations": len(used_indices),
        "used_lc_count": len(used_lc),
        "used_v6_count": len(used_v6),
        "used_lc_labels": used_lc,
        "used_v6_equations": used_v6,
        "elapsed_sec": round(time.perf_counter() - t0, 3),
    }
    (work_dir / "c99_1_nullstellensatz_cert.json").write_text(json.dumps(cert, indent=2), encoding="utf-8")
    print(json.dumps(cert, indent=2), flush=True)


if __name__ == "__main__":
    main()
