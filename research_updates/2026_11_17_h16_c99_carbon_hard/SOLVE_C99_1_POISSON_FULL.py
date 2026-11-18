#!/usr/bin/env python3
"""
Step 3H: Fast C/OpenMP Full Poisson-Lucas Extractor + Macaulay Degree-3 Closure.
1. Enumerates ALL C_8-orbits of 6-dim subspaces V_6 <= F_2^8 (all 2,667 -> ~340 orbits)
   plus C_8-orbits of 4-dim subspaces V_4 <= F_2^8 (W = {(x,y) : x^y in V_4}).
2. Uses a compiled C/OpenMP bitset kernel to extract exact degree <= 3 GF(2) polynomials
   in ~1 second total.
3. Combines all extracted polynomials with K=1, L_coset^1, x_i*(L_coset^1), and C6,
   and runs iterative GF(2) Macaulay degree-3 closure.
"""
import ctypes
import json
import random
import subprocess
import time
from itertools import combinations
from pathlib import Path

from SOLVE_C99_1_CSA_CEGAR import I2, I3, I4, J2, J3, J4
from SOLVE_C99_1_MACAULAY_AND_CMS import mul_polys, poly_from_lin_expr
from VERIFICAR_ALGEBRA_C99_1 import K_INDICES, R_INDICES, build_basis_111, setup_orbits
from VERIFICAR_ALGEBRA_C99_5_M3 import gf2_macaulay_reduce, substitute_linear_vars


C_SRC = r"""
#include <stdint.h>
#include <string.h>

// Extract degree <= 3 ANF over n=110 free vars into out_monomials (uint64_t[2] per monomial? No, indices i,j,k packed in uint32_t!)
// Actually, bitmask of 110 bits doesn't fit in uint64_t, so pack (i, j, k) as (deg << 24) | (i << 16) | (j << 8) | k with i<j<k<=110!
// For deg=0: 0; deg=1: (1<<24)|i; deg=2: (2<<24)|(i<<8)|j; deg=3: (3<<24)|(i<<16)|(j<<8)|k.
// Wait: we can return count and fill buf[max_out].
int extract_poly_c(
    const uint64_t *basis, // n * n_words
    const uint64_t *O_word, // n_words
    int n,
    int n_words,
    int const_shift,
    uint32_t *out_buf,
    int max_out
) {
    int cnt = 0;
    int o_pop = 0, o_chi_pop = 0;
    for (int w = 0; w < n_words; w++) o_pop += __builtin_popcountll(O_word[w]);
    if (o_pop % 2 != 0) return -1;
    if (((o_pop / 2) / 2 + const_shift) & 1) {
        if (cnt < max_out) out_buf[cnt] = 0;
        cnt++;
    }
    for (int i = 0; i < n; i++) {
        const uint64_t *bi = basis + i * n_words;
        int wi_pop = 0, wo_pop = 0;
        for (int w = 0; w < n_words; w++) {
            wi_pop += __builtin_popcountll(bi[w]);
            wo_pop += __builtin_popcountll(bi[w] & O_word[w]);
        }
        if (wi_pop % 2 != 0 || (wi_pop - 2 * wo_pop) % 4 != 0) return -2;
        if (((wi_pop - 2 * wo_pop) / 4) & 1) {
            if (cnt < max_out) out_buf[cnt] = (1U << 24) | (uint32_t)i;
            cnt++;
        }
    }
    for (int i = 0; i < n; i++) {
        const uint64_t *bi = basis + i * n_words;
        for (int j = i + 1; j < n; j++) {
            const uint64_t *bj = basis + j * n_words;
            int inter_pop = 0, io_pop = 0;
            for (int w = 0; w < n_words; w++) {
                uint64_t inter = bi[w] & bj[w];
                inter_pop += __builtin_popcountll(inter);
                io_pop += __builtin_popcountll(inter & O_word[w]);
            }
            if (inter_pop % 2 != 0) return -3;
            if ((inter_pop / 2 + io_pop) & 1) {
                if (cnt < max_out) out_buf[cnt] = (2U << 24) | ((uint32_t)i << 8) | (uint32_t)j;
                cnt++;
            }
        }
    }
    for (int i = 0; i < n; i++) {
        const uint64_t *bi = basis + i * n_words;
        for (int j = i + 1; j < n; j++) {
            const uint64_t *bj = basis + j * n_words;
            uint64_t inter[64];
            for (int w = 0; w < n_words; w++) inter[w] = bi[w] & bj[w];
            for (int k = j + 1; k < n; k++) {
                const uint64_t *bk = basis + k * n_words;
                int p = 0;
                for (int w = 0; w < n_words; w++) p += __builtin_popcountll(inter[w] & bk[w]);
                if (p & 1) {
                    if (cnt < max_out) out_buf[cnt] = (3U << 24) | ((uint32_t)i << 16) | ((uint32_t)j << 8) | (uint32_t)k;
                    cnt++;
                }
            }
        }
    }
    return cnt;
}
"""


def rot8(v):
    return ((v << 1) & 0xFF) | (v >> 7)


def all_v6_orbits():
    """Enumerate all C_8-orbits of 6-dim subspaces of F_2^8 (all 2,667 -> ~340 orbits)."""
    # A 6-dim subspace is orthogonal to a 2-dim subspace <a, b> with 0 < a < b < 256, a^b > b?
    # Canonicalize 2-dim subspaces {0, a, b, a^b}: pick (x, y) in sorted(nonzero) -> tuple of 3 nonzero elts.
    dual2_seen = set()
    orbits_pts = []
    for a in range(1, 256):
        for b in range(a + 1, 256):
            c = a ^ b
            trip = tuple(sorted((a, b, c)))
            if trip in dual2_seen:
                continue
            # Add all 8 rotations of trip
            cur = trip
            for _ in range(8):
                dual2_seen.add(tuple(sorted(cur)))
                cur = tuple(rot8(x) for x in cur)
            pts = [v for v in range(256) if ((v & a).bit_count() & 1) == 0 and ((v & b).bit_count() & 1) == 0]
            orbits_pts.append((f"v6_{hex(a)}_{hex(b)}", pts))
    return orbits_pts


def main():
    t0 = time.perf_counter()
    repo = Path(__file__).resolve().parents[2]
    work_dir = Path(__file__).resolve().parent
    c_path = work_dir / "poisson_fast.c"
    so_path = work_dir / "libpoisson_fast.so"
    c_path.write_text(C_SRC, encoding="utf-8")
    subprocess.run(["gcc", "-O3", "-march=native", "-shared", "-fPIC", str(c_path), "-o", str(so_path)], check=True)
    lib = ctypes.CDLL(str(so_path))
    lib.extract_poly_c.argtypes = [
        ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64),
        ctypes.c_int, ctypes.c_int, ctypes.c_int,
        ctypes.POINTER(ctypes.c_uint32), ctypes.c_int,
    ]
    lib.extract_poly_c.restype = ctypes.c_int

    orbits = setup_orbits()
    free, origin, cb = build_basis_111()
    n = len(free)  # 110

    # Precompute incidence for ALL 256 diagonal points (v, v) and ALL 32640 pairs (v, w) with 0<=v<w<256
    # Map (v, w) -> idx in 0..32639
    pair_idx = {}
    all_pairs = []
    for v in range(256):
        for w in range(v + 1, 256):
            pair_idx[(v, w)] = len(all_pairs)
            all_pairs.append(v | (w << 8))

    # Evaluate origin and cb[0..109] on all 256 diag points and all 32640 pairs
    # First evaluate each of 116 orbits on all 256 diag and 32640 pairs
    orb_diag = [0] * 116
    for j, orb in enumerate(orbits):
        val = 0
        for v in range(256):
            x = v | (v << 8)
            if sum((x & m) == m for m in orb) & 1:
                val |= 1 << v
        orb_diag[j] = val

    # For pairs, evaluate 116 orbits on 32640 points -> bytearray(32640) per orbit? Or bit-packed!
    # Wait: 32640 * 116 in Python: let's do 64-bit ints or bitsets
    orb_pair = [0] * 116
    for j, orb in enumerate(orbits):
        val = 0
        for k, x in enumerate(all_pairs):
            if sum((x & m) == m for m in orb) & 1:
                val |= 1 << k
        orb_pair[j] = val

    O_diag = 0
    O_pair = 0
    for j in range(116):
        if (origin >> j) & 1:
            O_diag ^= orb_diag[j]
            O_pair ^= orb_pair[j]
    cb_diag = []
    cb_pair = []
    for cdir in cb:
        vd, vp = 0, 0
        for j in range(116):
            if (cdir >> j) & 1:
                vd ^= orb_diag[j]
                vp ^= orb_pair[j]
        cb_diag.append(vd)
        cb_pair.append(vp)

    chi_pair = 0
    for k, x in enumerate(all_pairs):
        if x.bit_count() & 1:
            chi_pair |= 1 << k

    print(f"Precomputed 32640 pairs in {time.perf_counter()-t0:.2f}s", flush=True)

    v6_list = all_v6_orbits()
    print(f"Total C_8-orbits of V_6 <= F_2^8: {len(v6_list)}", flush=True)

    # Extract all V_6 polynomials using C kernel
    n_words = (2016 + 63) // 64  # 32
    basis_arr = (ctypes.c_uint64 * (n * n_words))()
    o_arr = (ctypes.c_uint64 * n_words)()
    out_buf = (ctypes.c_uint32 * 250000)()

    extracted = []
    rng = random.Random(42)
    for name, pts in v6_list:
        # Build bitmask of pts for diag and pairs
        diag_mask = sum(1 << v for v in pts)
        # Check if diag wt % 8 is constant 0 across 32 random combos
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

        # Extract 2016-bit vectors for this V_6
        p_idxs = [pair_idx[(pts[i], pts[j])] for i in range(len(pts)) for j in range(i + 1, len(pts))]
        # Wait: extracting 2016 bits from 32640-bit int for 111 ints:
        # Fast in Python: iterate over k_new, or precompute? 340 * 111 * 2016 is 76M ops -> ~3s in Python?
        # Even faster: only pack if we use a small helper or numpy! Wait: 76M bit checks in Python is ~8s.
        # Let's pack into 32 uint64_t words directly:
        def pack2016(big_int):
            words = [0] * n_words
            for k_new, k_old in enumerate(p_idxs):
                if (big_int >> k_old) & 1:
                    words[k_new >> 6] |= 1 << (k_new & 63)
            return words

        o_words = pack2016(O_pair)
        chi_words = pack2016(chi_pair)
        for i in range(n):
            bw = pack2016(cb_pair[i])
            for w in range(n_words):
                basis_arr[i * n_words + w] = bw[w]

        for use_chi in (False, True):
            for w in range(n_words):
                o_arr[w] = o_words[w] ^ (chi_words[w] if use_chi else 0)
            # Check bit0 linear
            o_pop = sum(int(o_arr[w]).bit_count() for w in range(n_words))
            if o_pop & 1:
                continue
            if any(sum(int(basis_arr[i * n_words + w]).bit_count() for w in range(n_words)) & 1 for i in range(n)):
                continue
            cnt = lib.extract_poly_c(basis_arr, o_arr, n, n_words, 0, out_buf, 250000)
            if cnt >= 0:
                pset = set()
                for idx in range(cnt):
                    code = out_buf[idx]
                    deg = code >> 24
                    if deg == 0:
                        pset.add(0)
                    elif deg == 1:
                        pset.add(1 << free[code & 0xFF])
                    elif deg == 2:
                        pset.add((1 << free[(code >> 8) & 0xFF]) | (1 << free[code & 0xFF]))
                    else:
                        pset.add((1 << free[(code >> 16) & 0xFF]) | (1 << free[(code >> 8) & 0xFF]) | (1 << free[code & 0xFF]))
                extracted.append(pset)

    print(f"Extracted {len(extracted)} exact V_6 polynomials in {time.perf_counter()-t0:.2f}s", flush=True)

    # Add L_coset^1, x_i * (L_coset^1), and C6, substitute K=1, and run Macaulay closure
    def lin_expr(indices):
        mask = sum(1 << j for j in indices)
        idxs = [i for i, c in enumerate(cb) if (c & mask).bit_count() % 2]
        const = (origin & mask).bit_count() % 2
        return idxs, const

    slin_i, slin_c = lin_expr([23, 31, 39, 112])
    l_coset_zero = poly_from_lin_expr(slin_i, slin_c ^ 1)
    for Ir, Jr in [(I2, J2), (I3, J3), (I4, J4)]:
        ui, uc = lin_expr(Ir)
        vi, vc = lin_expr(Jr)
        l_coset_zero ^= mul_polys(poly_from_lin_expr(ui, uc), poly_from_lin_expr(vi, vc))

    cert_t28 = json.loads((repo / "quartic_audit_2026_10_17/archive/T28_SEXTA_CERTIFICADO.json").read_text(encoding="utf-8"))
    poly_t28 = [int(h, 16) for h in cert_t28["reduced_models"]["branches"][1]["polynomial_hex"]]
    R_no5_expr = {1 << j for j in R_INDICES if j != 5}
    c6_poly = set()
    def tog(s, m):
        if m in s: s.remove(m)
        else: s.add(m)
    for m in poly_t28:
        if (m >> 5) & 1:
            base = m ^ (1 << 5)
            for rbit in R_no5_expr:
                tog(c6_poly, base | rbit)
        else:
            tog(c6_poly, m)

    k_i, k_c = lin_expr(K_INDICES)
    piv_bit = k_i[0]
    piv_expr = {1 << i for i in k_i[1:]}
    if k_c ^ 1:
        piv_expr.add(0)
    piv_map = {piv_bit: piv_expr}
    rem_vars = [i for i in range(110) if i != piv_bit]

    lc_sub = substitute_linear_vars(l_coset_zero, piv_map)
    sys_polys = [lc_sub] + [mul_polys({1 << i}, lc_sub) for i in rem_vars]
    sys_polys.append(substitute_linear_vars(c6_poly, piv_map))
    for p in extracted:
        sys_polys.append(substitute_linear_vars(p, piv_map))

    tm = time.perf_counter()
    pivs = gf2_macaulay_reduce(sys_polys)
    deg2_done = set()
    for _ in range(3):
        new_gen = []
        for lead, pset in list(pivs.items()):
            if lead.bit_count() <= 2 and lead not in deg2_done:
                deg2_done.add(lead)
                for i in rem_vars:
                    prod = set()
                    bm = 1 << i
                    for m in pset:
                        nm = m | bm
                        if nm in prod: prod.remove(nm)
                        else: prod.add(nm)
                    new_gen.append(prod)
        if not new_gen:
            break
        pivs = gf2_macaulay_reduce(list(pivs.values()) + new_gen)

    deg_counts = {}
    for lead in pivs:
        d = lead.bit_count()
        deg_counts[d] = deg_counts.get(d, 0) + 1

    out = {
        "v6_orbits": len(v6_list),
        "extracted_polys": len(extracted),
        "has_one": (0 in pivs),
        "deg_counts": deg_counts,
        "total_pivots": len(pivs),
        "macaulay_sec": round(time.perf_counter() - tm, 3),
        "elapsed_sec": round(time.perf_counter() - t0, 3),
    }
    (work_dir / "poisson_full_report.json").write_text(json.dumps(out, indent=2), encoding="utf-8")
    print(json.dumps(out, indent=2), flush=True)


if __name__ == "__main__":
    main()
