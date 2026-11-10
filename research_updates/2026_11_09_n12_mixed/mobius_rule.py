"""Verify the exact integer-ANF characterization of bentness in dimension 12."""

from collections import Counter
from random import Random

from higher_filter import (N, SIZE, FULL, direct_walsh, evaluate_orbit, flats,
                           linear_system, orbits, xor_terms, solve)


def integer_anf(table):
    coeffs = [(table >> x) & 1 for x in range(SIZE)]
    for i in range(N):
        b = 1 << i
        for x in range(SIZE):
            if x & b:
                coeffs[x] -= coeffs[x ^ b]
    return coeffs


def bent_by_mobius(table, degree_representatives):
    coeffs = integer_anf(table)
    return all(coeffs[m] % (1 << (m.bit_count() - 6)) == (32 if m == FULL else 0)
               for m in degree_representatives)


def main():
    rng = Random(120912)
    representatives = [m for d in range(7, 13) for m, _ in orbits(N, d)]
    assert Counter(m.bit_count() for m in representatives) == {
        7: 66, 8: 43, 9: 19, 10: 6, 11: 1, 12: 1}
    lower = [evaluate_orbit(o) for d in (2, 3) for _, o in orbits(N, d)]
    upper = [evaluate_orbit(o) for d in (4, 5, 6) for _, o in orbits(N, d)]
    anti = [evaluate_orbit(o, True) for d in (4, 5, 6) for _, o in orbits(6, d)]
    coordinate, extra = flats()
    exact_controls = [xor_terms(anti, c) ^ lower[5] for c in range(32)]
    exact_controls += [xor_terms(upper, rng.getrandbits(len(upper))) ^
                       xor_terms(lower, rng.getrandbits(len(lower))) for _ in range(128)]
    for table in exact_controls:
        assert bent_by_mobius(table, representatives) == direct_walsh(table)
    for width in (43, 109, 189):
        for _ in range(16):
            high = xor_terms(upper, rng.getrandbits(width))
            L = rng.getrandbits(25)
            combined = high ^ xor_terms(lower, L)
            shifted_filter = all(
                (row & L).bit_count() % 2 == rhs
                for row, rhs in linear_system(high, lower, coordinate))
            union_filter = all(c % 4 == 0 for m, c in enumerate(integer_anf(combined))
                               if m.bit_count() >= 8)
            assert shifted_filter == union_filter
            direct_filter = all((combined & f).bit_count() % 4 == 0 for f in coordinate)
            assert direct_filter == shifted_filter
    for high in [xor_terms(anti, c) for c in range(32)]:
        row, _, _ = solve(linear_system(high, lower, coordinate + extra), 25)
        assert row is not None
    print("PASS: 160 Walsh/Mobius comparisons, 48 coordinate-affine/union comparisons, "
          "and 32 positive high-part controls.")


if __name__ == "__main__":
    main()
