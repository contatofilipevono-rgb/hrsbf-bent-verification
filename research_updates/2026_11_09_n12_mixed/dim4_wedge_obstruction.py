"""Certify that the fibre degree bound forces A=E in both dimension-four spaces."""
import argparse
import json
from collections import Counter
from itertools import combinations
from pathlib import Path

from count_near_antipodal import all_points, image_and_kernel
from lower_dim_model import active_indices, anf, build, derivative_quotient
from outside_polar_profiles import cyclic_subspaces


def affine_pairs(basis):
    model = build(basis)
    image, _ = image_and_kernel([derivative_quotient(p, 4) for p, _ in model.maps])
    assert len(image) == 8
    points = all_points(basis)
    pairs = Counter()
    for q in all_points([row for row, _ in image]):
        A = tuple(sum((q >> (64 * i + x) & 1) << i for i in range(4)) for x in points)
        E = tuple(sum((q >> (64 * (i + 4) + x) & 1) << i for i in range(4)) for x in points)
        # The model uses the complement e0,e1. V1 uses e0,e0+e1
        # in the dual coordinates of the two functionals 27 and 54.
        if basis[0] == 7:
            E = tuple(a ^ e for a, e in zip(A, E))
        pairs[A, E] += 1
    return pairs


def degree_of_wedge(A, E):
    degree = -1
    for i, j in combinations(range(4), 2):
        values = sum((((a >> i & e >> j) ^ (a >> j & e >> i)) & 1) << x
                     for x, (a, e) in enumerate(zip(A, E)))
        for support in active_indices(anf(values, 4)):
            degree = max(degree, support.bit_count())
    return degree


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    report = []
    for basis in cyclic_subspaces():
        if len(basis) != 4:
            continue
        pairs = affine_pairs(basis)
        classes = Counter()
        distinct = Counter()
        for (A, E), count in pairs.items():
            degree = degree_of_wedge(A, E)
            assert (degree == -1 if A == E else degree == 2)
            classes[A == E, degree] += count
            distinct[A == E, degree] += 1
        assert sum(classes.values()) == 256
        result = {"basis": basis, "distinct_pairs": len(pairs),
                  "groups": [{"equal": equal, "wedge_degree": degree,
                              "pairs": distinct[equal, degree], "mixed_polar_classes": count}
                             for (equal, degree), count in sorted(classes.items())]}
        report.append(result)
        print(result)
    args.output.write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")


if __name__ == "__main__":
    main()
