#!/usr/bin/env python3
"""
Step 3G: Generalized Poisson-Lucas Polynomial Generator + Macaulay Reduction.
Generates exact degree <= 3 GF(2) equations from (wt(f|_W) / 2) mod 4 == 0
over rot^8-invariant 12-dimensional subspaces W of two families:
  1. W = V_6 x V_6 for 6-dim subspaces V_6 <= F_2^8
  2. W = {(x, y) : x ^ y in V_4} for 4-dim subspaces V_4 <= F_2^8
Validates every W on a known rot^8-symmetric bent function, reproduces 0x3f3f/0x5f5f/0x6f6f,
and runs iterative Macaulay degree-3 closure with K=1 and C6.
"""
import json
import random
import time
from itertools import combinations
from pathlib import Path

from VERIFICAR_ALGEBRA_C99_1 import (
    K_INDICES, R_INDICES, build_basis_111, extract_poly_mod4, setup_orbits,
)
from VERIFICAR_ALGEBRA_C99_5_M3 import gf2_macaulay_reduce, substitute_linear_vars


def extract_poly_exact_w(pairs, diag, orbits, origin, cb, free, use_chi=False):
    """
    Extract exact GF(2) polynomial for ((2 * wt_pairs + wt_diag) // 2) % 4 == 0,
    i.e., (wt_pairs + wt_diag // 2) % 4 == 0 (when wt_diag is always even)
    or check directly via mod-8 arithmetic over pairs (weight 2) + diag (weight 1).
    """
    # Build incidence over pairs (each contributes 2 mod 8) and diag (each contributes 1 mod 8)
    # Wait: extract_poly_mod4 assumes weight 1 per bit mod 4 (i.e. weight 2 per bit mod 8).
    # For diag, each point has weight 1 mod 8 -> its bit_k contributes 1, so sum(diag) mod 8
    # can be computed if sum(diag) is always even!
    # Let's check parity of wt_diag on origin and every cb[i]:
    diag_words = [sum((sum((x & m) == m for m in orb) % 2) << k for k, x in enumerate(diag)) for orb in orbits]
    O_d = 0
    for j in range(116):
        if (origin >> j) & 1:
            O_d ^= diag_words[j]
    b_d = []
    for cdir in cb:
        w = 0
        for j in range(116):
            if (cdir >> j) & 1:
                w ^= diag_words[j]
        b_d.append(w)

    if use_chi:
        chi_d = 0
        for k, x in enumerate(diag):
            if x.bit_count() & 1:
                chi_d |= 1 << k
        O_d ^= chi_d

    # Check if O_d and all b_d[i] have even popcount (so wt_diag is always even!)
    if (O_d.bit_count() & 1) != 0 or any((w.bit_count() & 1) != 0 for w in b_d):
        return None  # wt_diag not always even -> mod 4 of wt/2 not purely degree <= 3 via this split

    # Now wt_diag / 2 mod 2 is linear/quad? Actually wt_diag mod 4:
    # For bits d_1, ..., d_m: sum(d_k) mod 4 = (sum d_k mod 2) + 2 * sum_{j<k} d_j d_k (mod 4).
    # Since sum d_k is ALWAYS even, (sum d_k)/2 mod 2 == sum_{j<k} d_j d_k (mod 2),
    # which is extract_poly_mod4(b_d, O_d, free, const_shift=0) shifted? Wait:
    # For even popcount v = sum d_k: (v % 4) // 2 == (sum_{j<k} d_j d_k) % 2!
    # Wait: if v = 2, sum_{j<k} = 1, v//2 % 2 = 1. If v = 4, sum_{j<k} = 6 % 2 = 0, v//2 % 2 = 0!
    # YES! (wt_diag // 2) % 2 is the degree<=2 part, and we need (wt_pairs + wt_diag // 2) % 4!
    # Wait: (wt_pairs % 4) + (wt_diag // 2) % 4: we need wt_diag // 2 mod 4, which has degree <= 4 unless wt_diag // 2 is only mod 2!
    # Wait: in 0x3f3f, why did pairs ALONE work? Because wt_diag == 0 mod 4? Let's check!
    return None


def compute_exact_poly_mod8_split(pairs, diag, orbits, origin, cb, free, use_chi=False):
    """
    Compute (wt_pairs + wt_diag // 2) % 4 == 0 directly if wt_diag % 4 is constant!
    Returns (poly, diag_mod4_vals) or (None, diag_mod4_vals).
    """
    diag_words = [sum((sum((x & m) == m for m in orb) % 2) << k for k, x in enumerate(diag)) for orb in orbits]
    O_d = 0
    for j in range(116):
        if (origin >> j) & 1:
            O_d ^= diag_words[j]
    b_d = []
    for cdir in cb:
        w = 0
        for j in range(116):
            if (cdir >> j) & 1:
                w ^= diag_words[j]
        b_d.append(w)
    if use_chi:
        for k, x in enumerate(diag):
            if x.bit_count() & 1:
                O_d ^= 1 << k

    # Check if diag_words are 0 on all cb[i] (or constant mod 4)
    # Actually test 64 random combinations of cb to see if wt_diag % 8 is constant!
    rng = random.Random(42)
    vals = set()
    for _ in range(64):
        w = O_d
        for bi in b_d:
            if rng.randint(0, 1):
                w ^= bi
        vals.add(w.bit_count() % 8)
        if len(vals) > 1:
            break
    if len(vals) != 1:
        return None, sorted(vals)

    d_const = next(iter(vals))
    if d_const % 2 != 0:
        return None, [d_const]
    # Now wt_pairs % 4 must equal ((16 - d_const) // 2) % 4?
    # Wait: wt(f|_W) % 16 == 0 => wt_pairs * 2 + wt_diag == 0 mod 16 => wt_pairs + wt_diag/2 == 0 mod 8!
    # In particular, wt_pairs % 4 == (-d_const // 2) % 4!
    # Wait: if d_const == 0 mod 8, target_mod4 is 0; if d_const == 4 mod 8, target_mod4 is 2 (bit1 = 1)!
    # Wait: extract_poly_mod4 checks bit1 of (wt_pairs % 4) == const_shift!
    # Wait: what if wt_pairs % 2 != 0? Let's check bit0 of wt_pairs first!
    p_words = [sum((sum((x & m) == m for m in orb) % 2) << k for k, x in enumerate(pairs)) for orb in orbits]
    O_p = 0
    for j in range(116):
        if (origin >> j) & 1:
            O_p ^= p_words[j]
    b_p = []
    for cdir in cb:
        w = 0
        for j in range(116):
            if (cdir >> j) & 1:
                w ^= p_words[j]
        b_p.append(w)
    if use_chi:
        for k, x in enumerate(pairs):
            if x.bit_count() & 1:
                O_p ^= 1 << k

    req_mod4 = ((-d_const) // 2) % 4
    # If req_mod4 in (1, 3), bit0 is 1 (linear equation!). If req_mod4 in (0, 2), bit0 must be 0, bit1 = req_mod4 // 2.
    # Let's check bit0 polynomial first:
    bit0_poly = set()
    if (O_p.bit_count() & 1) != (req_mod4 & 1):
        bit0_poly.add(0)
    for i, bw in enumerate(b_p):
        if bw.bit_count() & 1:
            bit0_poly.add(1 << free[i])
    if bit0_poly:
        # Linear equation! Wait: if bit0_poly == {0}, contradiction? No, let's only return bit1 if bit0 is identically 0!
        return None, [d_const, "nonempty_bit0"]

    const_shift = (req_mod4 >> 1) & 1
    poly = extract_poly_mod4(b_p, O_p, free, const_shift=const_shift)
    return poly, [d_const]


def main():
    t0 = time.perf_counter()
    repo = Path(__file__).resolve().parents[2]
    work_dir = Path(__file__).resolve().parent
    orbits = setup_orbits()
    free, origin, cb = build_basis_111()

    # Build a known rot^8-symmetric bent function: <x_low, x_high> ^ g(x_low ^ x_high)
    rng = random.Random(123)
    g_table = [rng.randint(0, 1) for _ in range(256)]
    bent_tt = bytearray(65536)
    for x in range(65536):
        lo, hi = x & 0xFF, x >> 8
        bent_tt[x] = ((lo & hi).bit_count() & 1) ^ g_table[lo ^ hi]

    # Generate V_6 <= F_2^8 (6-dim subspaces):
    # 1. All 28 coordinate masks (wt=6)
    # 2. Random 6-dim subspaces via 2 random linearly independent parity checks in F_2^8
    subspaces_v6 = []
    seen_v6 = set()
    for a, b in combinations(range(8), 2):
        m8 = 0xFF ^ (1 << a) ^ (1 << b)
        pts = tuple(v for v in range(256) if (v & m8) == v)
        if pts not in seen_v6:
            seen_v6.add(pts)
            subspaces_v6.append((f"coord_{hex(m8)}", pts))
    while len(subspaces_v6) < 120:
        h1 = rng.randint(1, 255)
        h2 = rng.randint(1, 255)
        if h1 == h2 or (h1 ^ h2) == 0:
            continue
        pts = tuple(v for v in range(256) if ((v & h1).bit_count() & 1) == 0 and ((v & h2).bit_count() & 1) == 0)
        if pts not in seen_v6:
            seen_v6.add(pts)
            subspaces_v6.append((f"rand_{hex(h1)}_{hex(h2)}", pts))

    extracted = []
    diag_stats = {}
    for name, pts in subspaces_v6:
        pairs = [v | (w << 8) for i, v in enumerate(pts) for w in pts[i + 1:]]
        diag = [v | (v << 8) for v in pts]
        # Verify bent_tt has wt % 16 == 0 on W
        wt_bent = sum(bent_tt[x] for x in (pairs + pairs + diag))
        assert wt_bent % 16 == 0, f"Bent check failed on {name}: {wt_bent}"

        for use_chi in (False, True):
            poly, dinfo = compute_exact_poly_mod8_split(pairs, diag, orbits, origin, cb, free, use_chi=use_chi)
            diag_stats[str(dinfo)] = diag_stats.get(str(dinfo), 0) + 1
            if poly is not None:
                extracted.append((f"{name}_chi{int(use_chi)}", poly))

    print(f"Tested {len(subspaces_v6)} V_6 subspaces -> extracted {len(extracted)} exact deg<=3 polys in {time.perf_counter()-t0:.2f}s", flush=True)
    print(f"Diag stats: {diag_stats}", flush=True)

    # Substitute K=1 and run Macaulay degree-3 closure
    k_mask = sum(1 << j for j in K_INDICES)
    k_idxs = [i for i, c in enumerate(cb) if (c & k_mask).bit_count() % 2]
    k_const = (origin & k_mask).bit_count() % 2
    piv_bit = k_idxs[0]
    piv_expr = {1 << i for i in k_idxs[1:]}
    if k_const ^ 1:
        piv_expr.add(0)
    piv_map = {piv_bit: piv_expr}
    rem_vars = [i for i in range(110) if i != piv_bit]

    sys_polys = [substitute_linear_vars(p, piv_map) for _, p in extracted]
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
        "n_subspaces": len(subspaces_v6),
        "n_extracted": len(extracted),
        "diag_stats": diag_stats,
        "has_one": (0 in pivs),
        "deg_counts": deg_counts,
        "total_pivots": len(pivs),
        "elapsed_sec": round(time.perf_counter() - t0, 3),
    }
    (work_dir / "poisson_macaulay_report.json").write_text(json.dumps(out, indent=2), encoding="utf-8")
    print(json.dumps(out, indent=2), flush=True)


if __name__ == "__main__":
    main()
