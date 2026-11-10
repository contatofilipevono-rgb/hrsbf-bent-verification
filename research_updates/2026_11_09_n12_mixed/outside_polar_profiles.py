"""Summarize the antipodal polar forms in the exterior quartic catalogue."""
import argparse
import json
from collections import Counter, defaultdict
from itertools import combinations
from pathlib import Path

from higher_filter import evaluate_orbit, shift, xor_terms
from higher_project import LOW, TOP
from mobius_rule import integer_anf


PAIRS = tuple(combinations(range(6), 2))
POINTS = tuple((z ^ w) | (w << 6) for w in range(64) for z in range(64))
Z_MONOMIALS = tuple(sum(1 << z for z in range(64) if z & mask == mask)
                    for mask in range(64))


def polar_column(orbit):
    table = evaluate_orbit(orbit)
    moved = sum(((table >> x) & 1) << i for i, x in enumerate(POINTS))
    coeff = integer_anf(moved)
    out = 0
    for k, (i, j) in enumerate(PAIRS):
        w_mask = (1 << (i + 6)) | (1 << (j + 6))
        column = 0
        for z_mask, monomial in enumerate(Z_MONOMIALS):
            if coeff[z_mask | w_mask] & 1:
                column ^= monomial
        out |= column << (64 * k)
    return out


def rank(vectors):
    rows = {}
    for x in vectors:
        while x and (i := x.bit_length()) in rows:
            x ^= rows[i]
        if x:
            rows[x.bit_length()] = x
    return len(rows)


def cyclic_subspaces():
    spaces = {}
    for v in range(64):
        space = {0}
        basis = []
        for j in range(6):
            a = shift(v, j, 6)
            if a not in space:
                basis.append(a)
                space.update({x ^ a for x in space})
        spaces.setdefault(tuple(sorted(space)), basis)
    assert len(spaces) == 9
    return sorted(spaces.values(), key=lambda b: (len(b), b), reverse=True)


def polar_profile(polar, spaces):
    functions = [(polar >> (64 * k)) & ((1 << 64) - 1) for k in range(15)]
    def pairing(u, v):
        out = 0
        for (i, j), f in zip(PAIRS, functions):
            if ((u >> i & v >> j) ^ (u >> j & v >> i)) & 1:
                out ^= f
        return out

    spectrum = Counter()
    for z in range(64):
        rows = [0] * 6
        for (i, j), f in zip(PAIRS, functions):
            if f >> z & 1:
                rows[i] |= 1 << j
                rows[j] |= 1 << i
        spectrum[rank(rows)] += 1
    largest = max(len(b) for b in spaces if all(pairing(u, v) == 0 for u, v in combinations(b, 2)))
    return tuple(spectrum[r] for r in range(0, 7, 2)), largest


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("exterior_catalogue", type=Path)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    cubic = [polar_column(orb) for _, orb in LOW]
    quartic = [polar_column(orb) for _, orb in TOP]
    grouped = defaultdict(Counter)
    with args.exterior_catalogue.open(encoding="utf-8") as source:
        for row in source:
            top, lower, multiplicity = map(int, row.split())
            grouped[top][xor_terms(cubic, lower)] += 4 * multiplicity
    spaces = cyclic_subspaces()
    profiles = Counter()
    dimensions = Counter()
    for top, lower_values in grouped.items():
        top_polar = xor_terms(quartic, top)
        for lower, count in lower_values.items():
            profile, dimension = polar_profile(top_polar ^ lower, spaces)
            profiles[(profile, dimension)] += count
            dimensions[dimension] += count
    output = {
        "top_representatives": len(grouped),
        "top_polar_pairs": sum(map(len, grouped.values())),
        "functions_by_maximum_rotation_invariant_isotropic_dimension": dict(sorted(dimensions.items())),
        "profiles": [
            {"rank_counts_0_2_4_6": ranks, "dimension": d, "functions": n}
            for (ranks, d), n in profiles.most_common()
        ],
    }
    args.output.write_text(json.dumps(output, indent=2) + "\n", encoding="utf-8")
    print(output)


if __name__ == "__main__":
    main()
