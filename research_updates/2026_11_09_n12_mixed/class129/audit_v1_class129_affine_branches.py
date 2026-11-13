"""Check the affine branches of V1 class 129 against the support conditions."""
import argparse
from collections import Counter
from itertools import combinations, product
from pathlib import Path
import sys


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("model_dir", type=Path)
    parser.add_argument("catalog", type=Path)
    args = parser.parse_args()
    sys.path.insert(0, str(args.model_dir.resolve()))
    from count_near_antipodal import image_and_kernel
    from dim4_support_decode import decode
    from higher_filter import solve, xor_terms
    from line_phase_algebra import locate
    from lower_dim_moments import moment_masks
    from lower_dim_phase_prepare import fibre_masks

    model, basis, labels = decode(1)
    maps, lifts = map(list, zip(*model.maps))
    image = sorted(image_and_kernel(maps)[0], reverse=True)
    tail = 129 << 25
    base_mask = (1 << 64) - 1
    coords = [sum(1 << x for x in range(256) if x >> j & 1) for j in (6, 7)]
    tests = [mask for _, mask in moment_masks(8, 2)]
    d_of = [(z ^ (z >> 3)) & 7 for z in range(64)]
    rho = [tuple(x ^ (15 if x & 8 else 0) for x in labels(v)[:64]) for v in basis]

    def parity(x):
        return x.bit_count() & 1

    def lift(mapping):
        return xor_terms(lifts, locate(image, mapping))

    def chart(shifts):
        def derivative(values):
            return sum((values[z] ^ values[z ^ u]) << (3 * (64 * j + z))
                       for j, u in enumerate(shifts) for z in range(64))

        assert derivative(tuple(a ^ b for a, b in zip(rho[25], rho[32]))) == 0
        return image_and_kernel([derivative(r) for r in rho[:25]])[1]

    a2, arho = chart((27, 45)), chart((9, 18))
    assert (len(a2), len(arho)) == (14, 13)

    def z_index(y, d):
        return y | ((y ^ d) << 3)

    def h01(table, z):
        return ((table >> z) ^ (table >> (z + 128))) & 1

    def quadratic(y, d):
        missing = 7 ^ d
        return bool(y & missing) * parity(y & d)

    def affine(values):
        return all(value == (values[0] ^ xor_terms(
            [values[1 << i] ^ values[0] for i in range(3)], y))
                   for y, value in enumerate(values))

    # Subtract the fixed quadratic at the origin of the chart only.
    # The resulting conditions are linear in all the chart directions.
    for j, code in enumerate([tail, *arho]):
        mapping = xor_terms(basis, code)
        values = labels(mapping)[:64]
        h = lift(mapping)
        for d in (3, 5, 6):
            line = [z_index(y, d) for y in range(8)]
            assert affine([(values[z] & 1) ^ (quadratic(y, d) if j == 0 else 0)
                           for y, z in enumerate(line)])
            correction = [h01(h, z) ^ (values[z] & 1) for z in line]
            assert affine(correction)
            assert all(parity(values[z]) == correction[0] ^ correction[d] for z in line)
    for phase in model.phases:
        for d in (3, 5, 6):
            values = [h01(phase, z_index(y, d)) for y in range(8)]
            assert affine(values) and values[0] == values[d]
    print("A_rho affine identities verified on one origin and 13 directions")

    # Within each of the four choices of the two half-slices, prescribe the
    # nonzero linear part of the selector on each plane. Its constant is free.
    # This makes the branch an affine chart and the paired moment quadratic.
    codes = [tail, *a2]
    label_tables = [labels(xor_terms(basis, code))[:64] for code in codes]
    lift_tables = [lift(xor_terms(basis, code)) for code in codes]
    planes = {d: [[z_index(y, d) for y in range(8) if parity(y) == p]
                  for p in range(2)] for d in (3, 5)}
    dimensions = Counter()
    fixed_direction_cases = []

    def equation(values, target):
        return sum(v << i for i, v in enumerate(values[1:])), target ^ values[0]

    def h10(table, z):
        return ((table >> z) ^ (table >> (z + 64))) & 1

    def selector(table, plane):
        return [table[z] & 1 for z in plane]

    def quotient_label(value):
        return value ^ (15 if value & 8 else 0)

    def selector_differences(table, plane):
        values = selector(table, plane)
        return (values[0] ^ values[1]) | ((values[0] ^ values[2]) << 1)

    for pair in planes.values():
        for plane in pair:
            assert all(sum(selector(t, plane)) % 2 == 0 for t in label_tables)
    # On each plane the selector is affine, so a slice with exactly two
    # selected points has one plane contributing two and one contributing zero.

    for p3, p5, direction3, direction5 in product(range(2), range(2), range(1, 4), range(1, 4)):
        selected = [planes[3][p3], planes[5][p5]]
        equations = []
        for plane, direction in zip(selected, (direction3, direction5)):
            for bit in range(3):
                equations.append(equation([quotient_label(t[plane[0]]) >> bit & 1
                                           for t in label_tables], 1 >> bit & 1))
            equations.append(equation([parity(sum((t[z] & 1) << j
                                                   for j, z in enumerate(plane)))
                                       for t in label_tables], 0))
            for bit in range(2):
                equations.append(equation([selector_differences(t, plane) >> bit & 1
                                           for t in label_tables], direction >> bit & 1))
        origin, directions, _ = solve(equations, len(a2))
        if origin is None:
            continue
        dimensions[len(directions)] += 1
        points = [z for plane in selected for z in plane]
        edges = [plane[(0, 2, 1, 3)[direction]] ^ plane[0]
                 for plane, direction in zip(selected, (direction3, direction5))]
        for plane in selected:
            assert all(sum(h10(table, z) for z in plane) % 2 == 0
                       for table in [*lift_tables, *model.phases])
        fixed_direction_cases.append((p3, p5, *(edge & 7 for edge in edges)))

        def moment(parameter, table):
            return sum((xor_terms([v[z] & 1 for v in label_tables[1:]], parameter)
                        ^ (label_tables[0][z] & 1)) * h10(table, z) for z in points) & 1

        def derivative_sum(table):
            return sum(h10(table, plane[0]) ^ h10(table, plane[0] ^ edge)
                       for plane, edge in zip(selected, edges)) & 1

        # The selected pair has fixed direction. Its sum equals the derivative
        # at any point of the plane because H10 is affine there.
        h_origin = lift_tables[0] ^ xor_terms(lift_tables[1:], origin)
        assert derivative_sum(h_origin) == moment(origin, h_origin) == 1
        assert not any(derivative_sum(xor_terms(lift_tables[1:], v)) for v in directions)
        assert not any(map(derivative_sum, model.phases))
    print("Two-plane charts certified by coefficients:", dict(dimensions))
    print("Half-slice parities and selected directions:", fixed_direction_cases)

    def in_arho(mapping):
        values = [x ^ (15 if x & 8 else 0) for x in labels(mapping)[:64]]
        return all(values[z] == values[z ^ u] for z in range(64) for u in (9, 18))

    def early_residual(fibres, h):
        pair = fibres[2] | fibres[13]
        return not any(parity(h & mask) for mask in (fibres[5], pair & coords[0], pair & coords[1]))

    catalog_residuals = set()
    for code in map(int, args.catalog.read_bytes().splitlines()):
        if code >> 25 == 129:
            mapping = xor_terms(basis, code)
            fibres = fibre_masks(mapping, 256, 4)
            if early_residual(fibres, lift(mapping)):
                catalog_residuals.add(code)

    counts = Counter()
    chart_residuals = set()
    for parameter in range(1 << len(a2)):
        code = tail ^ xor_terms(a2, parameter)
        mapping = xor_terms(basis, code)
        fibres = fibre_masks(mapping, 256, 4)
        z1 = fibres[1] & base_mask
        profile = tuple(sorted(d_of[z] for z in range(64) if z1 >> z & 1))
        if profile == (3, 3, 5, 5):
            subset = fibres[1] & coords[1]
            assert subset.bit_count() == 8
            assert not any(parity(subset & phase) for phase in model.phases)
            assert parity(subset & lift(mapping))
            counts["profile_2_plus_2_in_A2"] += 1
        if not all(f.bit_count() == 16 and not any(parity(f & t) for t in tests) for f in fibres):
            continue
        chart_residuals.add(code)
        base_labels = labels(mapping)[:64]
        assert all(parity(v & 9) == (d_of[z].bit_count() >= 2)
                   for z, v in enumerate(base_labels))
        assert fibres[1] == sum(z1 << i for i in (0, 64, 128, 192))
        if in_arho(mapping):
            assert len(profile) == 4 and len(set(profile)) == 1 and profile[0] in (3, 5, 6)
            counts["admissible_Arho"] += 1
        else:
            assert profile == (3, 3, 5, 5)
            counts["admissible_A2_outside_Arho"] += 1
    assert chart_residuals == catalog_residuals
    assert counts == {"profile_2_plus_2_in_A2": 1280, "admissible_Arho": 288,
                      "admissible_A2_outside_Arho": 192}, counts
    print(dict(counts))
    print("catalog residuals and admissible A2 codes agree:", len(chart_residuals))


if __name__ == "__main__":
    main()
