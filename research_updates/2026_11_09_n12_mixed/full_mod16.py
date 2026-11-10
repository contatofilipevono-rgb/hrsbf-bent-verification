"""An affine condition on the lower coefficients from full-support mod 16."""
from collections import Counter
from functools import lru_cache
from itertools import combinations
from random import Random

from higher_filter import evaluate_orbit, shift, xor_terms
from higher_project import LOW, TOP, UPPER
from mobius_rule import integer_anf


FULL = 4095
LOW_MASK = (1 << len(LOW)) - 1


@lru_cache(maxsize=1)
def covering_counts():
    columns = LOW + TOP + UPPER
    index = {m: 1 << i for i, (_, orbit) in enumerate(columns) for m in orbit}

    def counter(supports):
        result = Counter()
        for terms in supports:
            union = 0
            monomial = 0
            for term in terms:
                union |= term
                monomial |= index[term]
            if union == FULL:
                result[monomial] += 1
        return result

    pairs = counter((m, FULL ^ m) for m in index if m.bit_count() == 6 and m < FULL ^ m)
    fixed_half = [m for m in index if shift(m, 6) == m]
    half_pairs = [(m, shift(m, 6)) for m in index if m < shift(m, 6)]
    triples = list(combinations(fixed_half, 3))
    triples.extend((m, a, b) for m in fixed_half for a, b in half_pairs if m | a | b == FULL)
    odd_triples = []
    even_triples = []
    for terms in triples:
        rep = tuple(sorted(terms))
        shifted = tuple(sorted(shift(s, 3) for s in terms))
        if rep == shifted:
            odd_triples.append(rep)
        elif rep < shifted:
            even_triples.append(rep)
    fixed_quarter = [m for m in fixed_half if shift(m, 3) == m]
    quarter_pairs = [(m, shift(m, 3)) for m in fixed_half if m < shift(m, 3)]
    four_cycles = [tuple(shift(m, k) for k in (0, 3, 6, 9)) for m in index
                   if m < min(shift(m, k) for k in (3, 6, 9))]
    quads = four_cycles + [a + b for a, b in combinations(quarter_pairs, 2)]
    quads.extend(a + b for a in quarter_pairs for b in combinations(fixed_quarter, 2))
    even = counter(even_triples)
    even.update(counter(quads))
    linear_lower = {k for k, v in even.items() if v % 2}
    assert all((k & LOW_MASK).bit_count() <= 1 for k in linear_lower)
    assert all(k & LOW_MASK == 0 for k in counter(odd_triples))
    return pairs, counter(odd_triples), linear_lower


def equation(upper, quartic):
    """Return (lower_mask, parity) or None when mod 8 already fails."""
    pairs, odd, even = covering_counts()
    code = ((upper << len(TOP)) | quartic) << len(LOW)
    p = sum(v for m, v in pairs.items() if m & code == m)
    j = sum(v for m, v in odd.items() if m & code == m)
    difference = p - 2 * j
    if difference % 4:
        return None
    low = 0
    rhs = (difference // 4) & 1
    for monomial in even:
        high, lower = monomial & ~LOW_MASK, monomial & LOW_MASK
        if code & high == high:
            if lower:
                low ^= lower
            else:
                rhs ^= 1
    return low, rhs


def main():
    rng = Random(1612)
    upper_columns = [evaluate_orbit(o) for _, o in UPPER]
    quartic_columns = [evaluate_orbit(o) for _, o in TOP]
    lower_columns = [evaluate_orbit(o) for _, o in LOW]
    n = 0
    for i in range(768):
        upper = rng.getrandbits((0, 66, 146)[i % 3])
        quartic, lower = rng.getrandbits(len(TOP)), rng.getrandbits(len(LOW))
        f = xor_terms(upper_columns, upper) ^ xor_terms(quartic_columns, quartic)
        f ^= xor_terms(lower_columns, lower)
        c = integer_anf(f)[-1]
        result = equation(upper, quartic)
        assert (c % 8 == 0) == (result is not None)
        if result is not None:
            mask, rhs = result
            assert (c % 16 == 0) == ((mask & lower).bit_count() % 2 == rhs)
            n += 1
    print('Möbius transforms:', 768, 'including', n, 'cases admissible mod 8')
    print('Polynomial terms:', [len(v) for v in covering_counts()])


if __name__ == '__main__':
    main()
