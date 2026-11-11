"""Certify the V3 cubic product obstruction by a union of affine spaces."""
import argparse
import json
from collections import Counter
from functools import reduce
from itertools import combinations
from operator import or_, xor
from pathlib import Path

from count_near_antipodal import all_points, image_and_kernel
from higher_filter import solve, xor_terms
from lower_dim_cubic_filter import filter_cubic_basis, survivor_indices
from lower_dim_model import active_indices, build, cubic
from lower_dim_plan import BASES


# Coordinates in the cubic basis obtained from the ordered map basis.
# The first three vectors span the common radical after the linear constraints.
ISOTROPIC = (
    1115136, 657408, 57344, 3028983, 747847,
    2370631, 233207, 3986096, 2452144, 582391,
)


def polynomial_value(diagonal, cross, x):
    bits = list(active_indices(x))
    return reduce(xor, (cross[i][j] for i, j in combinations(bits, 2)), xor_terms(diagonal, x))


def row_mask(columns, bit):
    return sum(((column >> bit) & 1) << i for i, column in enumerate(columns))


def linear_constraints(diagonal, cross, bits):
    pairs = tuple(combinations(range(len(diagonal)), 2))
    columns = [cross[i][j] for i, j in pairs]
    _, relations = image_and_kernel([row_mask(columns, bit) for bit in bits])
    coefficients = [row_mask(diagonal, bit) for bit in bits]
    return [xor_terms(coefficients, relation) for relation in relations]


def certificate(check):
    model = build(BASES[0])
    image, _ = image_and_kernel([cubic(p, 3) for p, _ in model.maps])
    diagonal, cross = filter_cubic_basis([column for column, _ in image], 3, model.nbase)
    dimension = len(diagonal)
    bits = list(active_indices(reduce(or_, diagonal + [c for row in cross for c in row], 0)))

    def value(x):
        return polynomial_value(diagonal, cross, x)

    def polar(x, y):
        return value(x) ^ value(y) ^ value(x ^ y)

    linear = sorted(set(linear_constraints(diagonal, cross, bits)) - {0})
    _, allowed, linear_rank = solve([(row, 0) for row in linear], dimension)
    radical = ISOTROPIC[:3]
    assert len(image_and_kernel(ISOTROPIC)[0]) == len(ISOTROPIC)
    assert all((u & row).bit_count() % 2 == 0 for u in ISOTROPIC for row in linear)
    assert all(not polar(u, v) for u, v in combinations(ISOTROPIC, 2))
    assert all(not value(u) and all(not polar(u, v) for v in allowed) for u in radical)
    radical_rows = [row_mask([polar(u, v) for v in allowed], bit) for u in allowed for bit in bits]
    assert len(solve([(row, 0) for row in radical_rows], len(allowed))[1]) == len(radical)

    # Extend the verified isotropic space to a direct-sum decomposition.
    _, complement_indices = image_and_kernel(list(ISOTROPIC) + allowed)
    dependent = {relation.bit_length() - 1 for relation in complement_indices}
    complement = [v for i, v in enumerate(allowed, len(ISOTROPIC)) if i not in dependent]
    assert len(complement) + len(ISOTROPIC) == len(allowed)

    isotropic_quotient = ISOTROPIC[3:]
    diagonal_on_quotient = [value(u) for u in isotropic_quotient]
    offsets = []
    dimensions = Counter()
    for x in all_points(complement):
        target = value(x)
        columns = [v ^ polar(x, u) for u, v in zip(isotropic_quotient, diagonal_on_quotient)]
        root, free, _ = solve([(row_mask(columns, bit), (target >> bit) & 1) for bit in bits],
                              len(isotropic_quotient))
        if root is None:
            continue
        offset = x ^ xor_terms(isotropic_quotient, root)
        directions = [xor_terms(isotropic_quotient, u) for u in free] + list(radical)
        dimensions[len(directions)] += 1
        offsets.append({"offset": offset, "directions": directions})

    total = sum(1 << len(row["directions"]) for row in offsets)
    assert total == 12160
    if check:
        symbolic = {p ^ row["offset"] for row in offsets for p in all_points(row["directions"])}
        assert len(symbolic) == total
        assert symbolic == set(survivor_indices(diagonal, cross))
    return {"cubic_dimension": dimension, "linear_rank": linear_rank, "linear_masks": linear,
            "common_radical": radical, "isotropic_basis": ISOTROPIC, "complement_basis": complement,
            "affine_systems": 1 << len(complement), "consistent_systems": len(offsets),
            "dimensions": dict(sorted(dimensions.items())), "cubic_parts": total, "spaces": offsets}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("output", type=Path)
    parser.add_argument("--check", action="store_true", help="Compare with the previous exhaustive scan.")
    args = parser.parse_args()
    report = certificate(args.check)
    args.output.write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
    print({key: value for key, value in report.items() if key != "spaces"})


if __name__ == "__main__":
    main()
