"""Exact arithmetic checks for exclusion of the odd branch at rank >= 10."""
from fractions import Fraction


def lattice_checks():
    # e(X) is a convex quadratic. In each progression it suffices to check
    # the closest point(s) to the vertex or to each side of a split point.
    def error(value):
        return (value - 17) ** 2 - 1024

    def progressions(residue):
        return tuple(17 * residue + 32 * sign for sign in (-1, 1))

    def closest_on_each_side(base, origin):
        period = 272
        k = (origin - base) // period
        return base + period * k, base + period * (k + 1)

    minima = [
        min(error(x) for base in progressions(residue)
            for x in closest_on_each_side(base, 17))
        for residue in (1, 5, 9, 13)
    ]
    assert minima == [0, 272, 9792, 272]

    for base in progressions(1):
        largest_below = base + 272 * ((-16 - base) // 272)
        assert largest_below <= -223
    for residue, center in ((5, 53), (13, -19)):
        for base in progressions(residue):
            negative = base + 272 * ((center - 1 - base) // 272) - center
            positive = base + 272 * ((center - base) // 272 + 1) - center
            if center == 53:
                assert negative <= -208 and positive >= 64
            else:
                assert negative <= -64 and positive >= 208

    for q, residue, expected in ((0, 1, 56576), (1, 13, 28288)):
        bad = []
        for base in progressions(residue):
            wrong_base = base if (base - 17 + 4*q) % 32 else base + 272
            k = (17 - wrong_base) // 544
            bad.extend([wrong_base + 544*k, wrong_base + 544*(k+1)])
        assert min(error(x) - 272*q for x in bad) == expected


def arithmetic_checks():
    middle = Fraction(1, 32)
    for h in range(5, 11):
        beta = Fraction(1, 2**h)
        w_min = (1 - beta) / 2
        budget = Fraction(4641, 16) - 272 * w_min
        eta = budget / 136
        assert budget < Fraction(3, 128) * 9792
        assert budget < Fraction(1, 64) * 28288
        if h == 5:
            assert Fraction(4641, 16) - 272 * (1 + beta)/2 < Fraction(9792, 64)
            assert 17 * w_min - Fraction(36, 8) - eta > (middle + 1) / 2
        max_r = 2 if h == 5 else 9
        margins = []
        for r in range(max_r + 1):
            large_rank = max(r, h-r)
            smallest_bias_r = -Fraction(1, 2**r) if r else Fraction(0)
            bound_both_biases = beta + Fraction(1, 2**large_rank)
            lower = Fraction(19, 2) * (1 + smallest_bias_r) - 17 * bound_both_biases - eta
            upper = Fraction(1 + 2**r, 64)
            margins.append(lower - upper)
        assert min(margins) > 0
        full_rank_margin = 4 * w_min - Fraction(17, 1024) - eta
        assert full_rank_margin > 0
        print(f"polar rank {2*h:2d}, minimum lower-rank margin {min(margins)}, "
              f"full-rank margin {full_rank_margin}")
    assert 4 * 4 % 32 != 0
    print("All lattice and exact rational checks passed.")


if __name__ == "__main__":
    lattice_checks()
    arithmetic_checks()
