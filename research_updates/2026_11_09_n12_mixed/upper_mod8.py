"""The full-support integer Möbius congruence mod 8 in 12 variables."""
from collections import Counter
from itertools import combinations
from random import Random

from higher_filter import evaluate_orbit, shift, xor_terms
from higher_project import LOW, TOP, UPPER
from mobius_rule import integer_anf


def terms_for_fixed_upper(upper):
    """Return the polynomial in the 43 quartic bits, as monomial masks."""
    sextic = upper >> 66
    s = lambda i: (sextic >> i) & 1
    if s(46) != s(79):
        return {0}
    terms = {(1 << 42) | (1 << 30), (1 << 42) | (1 << 40)}
    if 1 ^ s(71) ^ s(77):
        terms.add(1 << 42)
    if (sum(s(i) for i in (0, 10, 24, 45, 70, 75)) + s(71) * s(77)) % 2:
        terms.add(0)
    return terms


def derive_pair_and_triple_formulas():
    index = {m: (degree, i) for degree, basis in
             ((2, LOW[:6]), (3, LOW[6:]), (4, TOP), (5, UPPER[:66]), (6, UPPER[66:]))
             for i, (_, orbit) in enumerate(basis) for m in orbit}
    full = 4095
    pairs = Counter(tuple(sorted({index[a], index[full ^ a]}))
                    for a in index if a.bit_count() == 6 and a < full ^ a)
    fixed = [a for a in index if shift(a, 3) == a]
    swapped = [(a, shift(a, 3)) for a in index if shift(a, 6) == a < shift(a, 3)]
    triples = Counter(tuple(sorted({index[a], index[b], index[c]}))
                      for a, b, c in combinations(fixed, 3) if a | b | c == full)
    triples.update(tuple(sorted({index[a], index[b], index[c]}))
                   for a in fixed for b, c in swapped if a | b | c == full)
    return ({k: v % 4 for k, v in pairs.items() if v % 4},
            {k for k, v in triples.items() if v % 2})


def main():
    pairs, triples = derive_pair_and_triple_formulas()
    assert pairs == {((6, i),): 2 for i in (0, 10, 24, 45, 70, 75)} | {
        ((6, 46),): 3, ((6, 79),): 1, ((6, 71), (6, 77)): 2}
    assert triples == {((4, 42),), ((4, 30), (4, 42)), ((4, 40), (4, 42))} | {
        ((4, 42), (6, i)) for i in (46, 71, 77, 79)}
    rng = Random(128)
    bases = [[evaluate_orbit(o) for _, o in basis] for basis in (UPPER, TOP, LOW)]
    for i in range(256):
        upper = rng.getrandbits((0, 66, 146, 146)[i % 4])
        top, low = rng.getrandbits(43), rng.getrandbits(25)
        table = xor_terms(bases[0], upper) ^ xor_terms(bases[1], top) ^ xor_terms(bases[2], low)
        # Affine terms cannot appear in an odd orbit of covering triples.
        if i & 16:
            table ^= sum(1 << x for x in range(4096) if x.bit_count() % 2)
        if i & 32:
            table ^= (1 << 4096) - 1
        coeff = integer_anf(table)[-1]
        result = sum(t & top == t for t in terms_for_fixed_upper(upper)) % 2
        assert (coeff % 8 == 0) == (result == 0)
    print('Verified the pair/triple formulas and 256 full integer Möbius transforms.')


if __name__ == '__main__':
    main()
