"""Check a degree-three identity excluding a whole derivative class."""
from itertools import combinations

from higher_filter import solve, xor_terms
from line_pfaffian_parity_scan import orbit_form, pairings, polar_value, top_coordinates
from line_radical_parity import Z_MASK, parity_polynomial, polar_basis
from lower_dim_v3_symbolic import affine_at, product, substitute


def compile_class():
    basis = polar_basis()
    e1 = sum((z.bit_count() & 1) << z for z in range(64))
    targets = [e1, Z_MASK ^ orbit_form(2) ^ orbit_form(3)]
    equations = []
    for (a, b), target in zip(((27, 54), (21, 42)), targets):
        evaluations = [polar_value(p, a, b) for p in basis]
        equations.extend(
            (sum(((p >> z) & 1) << i for i, p in enumerate(evaluations)), (target >> z) & 1)
            for z in range(64)
        )
    word, params, rank = solve(equations, len(basis))
    assert word is not None and rank == 6 and len(params) == 19
    variables = [affine_at(i, word, params) for i in range(len(basis))]
    base = top_coordinates(xor_terms(basis, word))
    directions = [top_coordinates(xor_terms(basis, p)) for p in params]
    groups = pairings()

    def pfaffians(top):
        return sum((sum(
            ((top >> (15*i+a) & 1) & (top >> (15*j+c) & 1))
            ^ ((top >> (15*i+c) & 1) & (top >> (15*j+a) & 1))
            for i, j in wp for a, c in zp
        ) & 1) << (15*m+n) for m, wp in enumerate(groups) for n, zp in enumerate(groups))

    # The Pfaffian equations are quadratic in the parameters.
    # Values at zero, the unit vectors and their pairwise sums determine all coefficients.
    origin = pfaffians(base)
    samples = [pfaffians(base ^ direction) for direction in directions]
    monomials = [(0, origin)] + [(1 << i, value ^ origin) for i, value in enumerate(samples)]
    monomials.extend(
        ((1 << i) | (1 << j), pfaffians(base ^ directions[i] ^ directions[j])
         ^ samples[i] ^ samples[j] ^ origin)
        for i, j in combinations(range(len(params)), 2)
    )
    rows = [{m for m, value in monomials if value >> k & 1} for k in range(225)]
    parity, = substitute([parity_polynomial(basis, 63)], variables)
    return rows, parity


def verify():
    rows, parity = compile_class()
    assert parity == {0, 8, 16, 32, 64, 128, 65536}
    terms = [
        ([0, 1, 2, 4, 5, 6, 8, 9, 11, 12, 13, 14, 21], {0}),
        ([0, 9], {128, 512, 1024, 4096, 16384, 262144}),
        ([1, 8, 11, 13], {32, 128, 256, 65536}),
        ([2, 12, 21], {8, 16, 64, 256}),
    ]
    total = set()
    for indices, multiplier in terms:
        row = set()
        for i in indices:
            row ^= rows[i]
        total ^= product(row, multiplier)
    assert total == parity ^ {0}
    print("The Pfaffian equations force odd radical support in direction 63 for the entire class.")


if __name__ == "__main__":
    verify()
