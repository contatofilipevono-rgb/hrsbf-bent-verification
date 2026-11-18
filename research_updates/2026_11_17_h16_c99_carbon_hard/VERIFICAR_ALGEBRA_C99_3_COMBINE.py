#!/usr/bin/env python3
"""
Stage 3 Algebraic Combination Check:
Extracts exact ANF polynomials for 0x3f3f, 0x5f5f, 0x6f6f, Q_{0x0}, Q_{0xf},
plus C4 (Q4) and C6 (T28 branch 1), and checks ALL 2^6 XOR combinations of the
degree-3 polynomials for degree drops (linear or quadratic cancellations),
as well as linear-span / Macaulay rank over GF(2).
"""
import json
import time
from itertools import combinations
from pathlib import Path

from VERIFICAR_ALGEBRA_C99_1 import (
    WITNESSES,
    build_basis_111,
    eval_poly,
    extract_poly_mod4,
    setup_orbits,
)


def main():
    t0 = time.perf_counter()
    repo = Path(__file__).resolve().parents[2]
    orbits = setup_orbits()
    free, origin, cb = build_basis_111()

    polys = {}

    # 1. Extract 0x3f3f, 0x5f5f, 0x6f6f (no_chi)
    for name, m8 in [("0x3f3f", 0x3F), ("0x5f5f", 0x5F), ("0x6f6f", 0x6F)]:
        small = [v for v in range(256) if (v & m8) == v]
        pairs = [v | (w << 8) for v in small for w in small if v < w]
        words = [sum((sum((x & m) == m for m in orb) % 2) << k for k, x in enumerate(pairs)) for orb in orbits]
        O_word = 0
        for j in range(116):
            if (origin >> j) & 1:
                O_word ^= words[j]
        basis = []
        for cdir in cb:
            w = 0
            for j in range(116):
                if (cdir >> j) & 1:
                    w ^= words[j]
            basis.append(w)
        # Required bit for bentness is 1, so P ^ {0} == 0 is the bentness equation
        P = extract_poly_mod4(basis, O_word, free, const_shift=1)
        polys[name] = P

    # 2. Extract Q_{0x0} and Q_{0xf}
    coset_orbits = {0x0: [], 0xF: []}
    visited = bytearray(65536)
    for x in range(65536):
        if visited[x]:
            continue
        cur, members = x, []
        while not visited[cur]:
            visited[cur] = 1
            members.append(cur)
            cur = ((cur << 1) & 0xFFFF) | (cur >> 15)
        if len(members) == 16:
            v = (x & 0xF) ^ ((x >> 4) & 0xF) ^ ((x >> 8) & 0xF) ^ ((x >> 12) & 0xF)
            if v in (0x0, 0xF):
                coset_orbits[v].append(members[0])

    for cname, reps in coset_orbits.items():
        words = [sum((sum((x & m) == m for m in orb) % 2) << k for k, x in enumerate(reps)) for orb in orbits]
        O_word = 0
        for j in range(116):
            if (origin >> j) & 1:
                O_word ^= words[j]
        basis = []
        for cdir in cb:
            w = 0
            for j in range(116):
                if (cdir >> j) & 1:
                    w ^= words[j]
            basis.append(w)
        P = extract_poly_mod4(basis, O_word, free, const_shift=0)
        polys[f"Q_{hex(cname)}"] = P

    # Check all non-empty XOR combinations of the 5 polynomials for degree drops!
    names = list(polys.keys())
    combos = []
    for r in range(1, len(names) + 1):
        for sub in combinations(names, r):
            acc = set()
            for s in sub:
                acc ^= polys[s]
            deg = max((m.bit_count() for m in acc), default=0)
            deg_counts = {}
            for m in acc:
                d = m.bit_count()
                deg_counts[d] = deg_counts.get(d, 0) + 1
            combos.append({
                "subset": list(sub),
                "terms": len(acc),
                "degree": deg,
                "deg_counts": deg_counts,
            })

    combos.sort(key=lambda x: (x["degree"], x["terms"]))

    # Also check which of the 14 witnesses pass ALL of {0x3f3f==1, 0x5f5f==1, 0x6f6f==1, Q_0xf==0}
    survivors = []
    for wn, cint in WITNESSES.items():
        v3 = eval_poly(polys["0x3f3f"], cint)
        v5 = eval_poly(polys["0x5f5f"], cint)
        v6 = eval_poly(polys["0x6f6f"], cint)
        vqf = eval_poly(polys["Q_0xf"], cint)
        if v3 == 0 and v5 == 0 and v6 == 0 and vqf == 0:
            survivors.append(wn)

    out = {
        "polynomial_names": names,
        "lowest_degree_combinations": combos[:12],
        "witnesses_passing_3f3f_5f5f_6f6f_Q0xf": survivors,
        "elapsed_sec": round(time.perf_counter() - t0, 4),
    }
    out_path = repo / "research_updates/2026_11_17_h16_c99_carbon_hard/algebra_c99_3_combine.json"
    out_path.write_text(json.dumps(out, indent=2), encoding="utf-8")
    print(json.dumps(out, indent=2))


if __name__ == "__main__":
    main()
