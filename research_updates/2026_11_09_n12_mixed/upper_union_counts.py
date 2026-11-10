"""Count upper parts surviving the union equations independent of lower terms."""
from collections import Counter
from itertools import combinations

from higher_project import UPPER
from higher_filter import orbits


def union_equation(support, basis):
    candidates = [(i, m) for i, (_, orbit) in enumerate(basis)
                  for m in orbit if m & support == m]
    counts = Counter((1 << i) | (1 << j) for (i, a), (j, b) in combinations(candidates, 2)
                     if a | b == support)
    return {term for term, count in counts.items() if count % 2}


def evaluate(poly, v):
    return sum(term & v == term for term in poly) % 2


def quadratic_sum(poly, n):
    """Sum (-1)^q by eliminating one nonsingular pair at a time."""
    exponent = n
    while True:
        pair = next((term for term in poly if term.bit_count() == 2), 0)
        if not pair:
            return 0 if poly - {0} else (-1 if 0 in poly else 1) * (1 << exponent)
        x = pair & -pair
        y = pair ^ x
        left, right, rest = set(), set(), set()
        for term in poly - {pair}:
            if term & x:
                left.add(term ^ x)
            elif term & y:
                right.add(term ^ y)
            else:
                rest.add(term)
        for u in left:
            for v in right:
                rest.symmetric_difference_update((u | v,))
        poly = rest
        exponent -= 1


def intersection_count(equations, n):
    combinations_ = [set()]
    for equation in equations:
        combinations_ += [p ^ equation for p in combinations_]
    numerator = sum(quadratic_sum(p, n) for p in combinations_)
    assert numerator % len(combinations_) == 0
    return numerator // len(combinations_)


def main():
    # Compare the quadratic elimination with explicit small Boolean tables.
    from random import Random
    rng = Random(12)
    for n in range(2, 9):
        allowed = [v for v in range(1 << n) if v.bit_count() <= 2]
        for _ in range(30):
            poly = {v for v in allowed if rng.getrandbits(1)}
            assert quadratic_sum(poly, n) == sum(1 - 2 * evaluate(poly, v) for v in range(1 << n))
    quintic = [union_equation(s, UPPER[:66]) for s, _ in orbits(12, 10)]
    general = [union_equation(s, UPPER) for s in (2047, 4095)]
    assert len(quintic) == 6 and general[1] == {1 << 112, 1 << 145}
    passing_quintic = intersection_count(quintic, 66)
    passing_general = intersection_count(general, 146)
    print('Quintic nonzero:', passing_quintic - 1, 'out of', (1 << 66) - 1)
    print('With nonzero sextic:', passing_general - (1 << 66),
          'out of', (1 << 146) - (1 << 66))


if __name__ == '__main__':
    main()
