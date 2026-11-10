"""The exact period-four Walsh filter as two disjoint affine branches."""
from functools import lru_cache

from higher_filter import allowed_rs_period4, evaluate_orbit, orbits, projection, xor_terms
from higher_project import LOW, TOP, UPPER


@lru_cache(maxsize=1)
def projection_columns():
    return [[projection(evaluate_orbit(o)) for _, o in basis] for basis in (LOW, TOP, UPPER)]


def branch_equations(high, branch):
    assert branch in (0, 1)
    low, quartic, upper = projection_columns()
    fixed = xor_terms(upper, high)
    rows = []
    for support, rhs in (((1 << 1) | (1 << 7) | (1 << 15), 1),
                         ((1 << 1) | (1 << 7), branch),
                         ((1 << 5) | ((1 << 3) if branch == 0 else 0), branch)):
        def parity(v):
            return (v & support).bit_count() % 2

        mask = sum(parity(t) << j for j, t in enumerate(low))
        polynomial = {1 << j for j, t in enumerate(quartic) if parity(t)}
        if rhs ^ parity(fixed):
            polynomial.add(0)
        rows.append((mask, polynomial))
    return rows


def main():
    tables = [0]
    for _, o in orbits(4):
        mask = sum(1 << t for t in o)
        tables += [t ^ mask for t in tables]
    allowed = allowed_rs_period4()
    for t in tables:
        values = [(t >> s) & 1 for s in (0, 1, 3, 5, 7, 15)]
        t0, t1, t3, t5, t7, t15 = values
        a, b, c = t3 ^ t0, t5 ^ t0, t7 ^ t1
        accepted = t0 ^ t1 ^ t7 ^ t15 == 1 and b == a ^ c ^ (a & c)
        assert (t in allowed) == accepted
    print('The two branches exactly cover the 16 admissible invariant period-four tables.')


if __name__ == '__main__':
    main()
