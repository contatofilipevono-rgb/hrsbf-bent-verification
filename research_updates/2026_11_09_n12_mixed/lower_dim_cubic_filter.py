"""Count cubic map parts passing the degree-six product obstruction."""
import argparse
import json
from itertools import combinations
from pathlib import Path
from time import perf_counter

from count_near_antipodal import image_and_kernel
from lower_dim_model import build, cubic, cubic_wedge
from outside_polar_profiles import cyclic_subspaces


def filter_cubic_basis(cubic_columns, r, width):
    size = 1 << width
    mask = (1 << size) - 1
    columns = [tuple(p >> (size * j) & mask for j in range(r)) for p in cubic_columns]
    pairs = tuple(combinations(range(r), 2))

    def obstruction(a, b=None):
        if b is None:
            return sum(cubic_wedge(a[i], a[j], width) << (k * size)
                       for k, (i, j) in enumerate(pairs))
        return sum((cubic_wedge(a[i], b[j], width) ^ cubic_wedge(b[i], a[j], width)) << (k * size)
                   for k, (i, j) in enumerate(pairs))

    linear = [obstruction(a) for a in columns]
    d = len(columns)
    cross = [[0] * d for _ in range(d)]
    for i, j in combinations(range(d), 2):
        cross[i][j] = cross[j][i] = obstruction(columns[i], columns[j])
    return linear, cross


def survivor_indices(linear, cross):
    # Store each first difference of the quadratic. A Gray step updates only
    # the coordinates coupled to the bit that changed.
    d = len(linear)
    differences = linear.copy()
    neighbours = [[(j, row) for j, row in enumerate(rows) if row] for rows in cross]
    value = 0
    yield 0
    for ordinal in range(1, 1 << d):
        i = (ordinal & -ordinal).bit_length() - 1
        value ^= differences[i]
        for j, row in neighbours[i]:
            differences[j] ^= row
        if value == 0:
            yield ordinal ^ (ordinal >> 1)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    results = []
    for basis in cyclic_subspaces():
        r = len(basis)
        if r not in (2, 3):
            continue
        start = perf_counter()
        model = build(basis)
        columns = [p for p, _ in image_and_kernel([cubic(p, r) for p, _ in model.maps])[0]]
        linear, cross = filter_cubic_basis(columns, r, model.nbase)
        survivors = sum(1 for _ in survivor_indices(linear, cross))
        d = len(columns)
        report = {"basis": basis, "map_dimension": len(model.maps), "phase_dimension": len(model.phases),
                  "cubic_dimension": d, "tested_cubic_parts": 1 << d, "surviving_cubic_parts": survivors,
                  "maps_after_filter": survivors << (len(model.maps) - d),
                  "seconds": perf_counter() - start}
        results.append(report)
        print(report, flush=True)
    args.output.write_text(json.dumps(results, indent=2) + "\n", encoding="utf-8")


if __name__ == "__main__":
    main()
