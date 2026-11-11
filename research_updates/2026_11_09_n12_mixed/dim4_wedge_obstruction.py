"""Certify that the fibre degree bound forces A=E in both dimension-four spaces."""
import argparse
import json
from collections import Counter
from itertools import combinations
from pathlib import Path

from count_near_antipodal import all_points, image_and_kernel
from higher_filter import shift, xor_terms
from lower_dim_model import active_indices, anf, build, derivative_quotient
from lower_dim_phase_prepare import truth_on_coordinates
from lower_dim_polar_structure import extract_polar
from outside_polar_profiles import PAIRS, cyclic_subspaces


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


def bilinear(polar, u, v):
    return xor_terms([(polar >> (64 * i)) & ((1 << 64) - 1) for i in range(len(PAIRS))],
                     sum(1 << i for i, (a, b) in enumerate(PAIRS)
                         if ((u >> a & v >> b) ^ (u >> b & v >> a)) & 1))


def restriction(polar, basis):
    return sum(bilinear(polar, u, v) << (64 * i)
               for i, (u, v) in enumerate(combinations(basis, 2)))


def intersection_report():
    v1, v2 = [b for b in cyclic_subspaces() if len(b) == 4]
    model = build(v2)
    polar_columns = [extract_polar(model, truth_on_coordinates(p, h, 4))
                     for p, h in model.maps + [(0, h) for h in model.phases]]
    _, simultaneous = image_and_kernel([restriction(p, v1) for p in polar_columns])
    image, _ = image_and_kernel([xor_terms(polar_columns, code) for code in simultaneous])
    polars = all_points([v for v, _ in image])
    classes = []
    for polar in polars:
        actual = [bilinear(polar, e, v) for e in (1, 2) for v in v2]
        for m, kappa in ((0, 0), (0, 1), (9, 0), (9, 1)):
            expected = [0] * 8
            for z in range(64):
                even, odd = (z & 21).bit_count() & 1, (z & 42).bit_count() & 1
                nz = z ^ shift(z, 3, 6)
                u = nz * (kappa and even == odd)
                q = ((nz * odd * (m == 9)) ^ u, (nz * even * (m == 9)) ^ u)
                for i, word in enumerate(q):
                    for j, v in enumerate(v2):
                        expected[4 * i + j] |= ((word & v).bit_count() & 1) << z
            if actual == expected:
                classes.append({"M_mask": m, "kappa": kappa,
                                "affine_in_U": not restriction(polar, [3, 6, 12, 24, 48])})
                break
        else:
            raise AssertionError("Unclassified simultaneous polar")
    assert len(simultaneous) == 45 and len(image) == 2
    assert {(x["M_mask"], x["kappa"], x["affine_in_U"]) for x in classes} == {
        (0, 0, True), (0, 1, True), (9, 0, False), (9, 1, False)}
    return {"dimension_affine_in_both": len(simultaneous), "polar_dimension": len(image),
            "classes": sorted(classes, key=lambda x: (x["M_mask"], x["kappa"]))}


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
    intersection = intersection_report()
    print(intersection)
    args.output.write_text(json.dumps({"wedge_obstruction": report, "intersection": intersection},
                                      indent=2) + "\n", encoding="utf-8")


if __name__ == "__main__":
    main()
