"""Verify the two quartic relations that force quadratic antipodal fibres."""
from collections import Counter

from higher_filter import evaluate_orbit
from mobius_rule import integer_anf
from top_filters import TOP, active_bits, filter_polys, product_linear_certificates


def main():
    coordinates = [(z ^ w) | (w << 6) for w in range(64) for z in range(64)]
    masks = [m for m in range(4096) if m.bit_count() == 4 and (m >> 6).bit_count() >= 3]
    rows = dict.fromkeys(masks, 0)
    for i, (_, orbit) in enumerate(TOP):
        truth = evaluate_orbit(orbit)
        moved = sum(((truth >> x) & 1) << k for k, x in enumerate(coordinates))
        coefficients = integer_anf(moved)
        for m in masks:
            rows[m] |= (coefficients[m] & 1) << i

    certified = [row for row, _ in product_linear_certificates(filter_polys()).values()]
    span = {0}
    for row in certified:
        span.update({x ^ row for x in span})
    assert set(rows.values()) <= span
    expected = {
        464: [1, 3, 5, 8, 24, 28, 34, 36],
        456: [0, 4, 7, 9, 22, 27, 29, 37],
    }
    for m, indices in expected.items():
        assert list(active_bits(rows[m])) == indices
    assert {row for row in rows.values() if row} == {rows[m] for m in expected}
    counts = Counter(rows.values())
    for m in sorted(expected):
        print(m, counts[rows[m]], expected[m])
    print("Zero rows:", counts[0])


if __name__ == "__main__":
    main()
