#!/usr/bin/env python3
"""Exact CPU controls for odd-group fixed-space transfer. No dependencies.

Examples only: a computational check is NOT a proof for arbitrary groups.
"""
from itertools import combinations


def parity(x):
    return x.bit_count() & 1


def perm3(x, offset=0):
    a, b, c = [(x >> (offset + i)) & 1 for i in range(3)]
    return (x & ~(7 << offset)) | ((c | (a << 1) | (b << 2)) << offset)


def monomial_orbits(n, actions, degree):
    monomials = [sum(1 << i for i in inds)
                 for d in range(1, degree + 1)
                 for inds in combinations(range(n), d)]
    seen, result = set(), []
    for mon in monomials:
        if mon in seen:
            continue
        orb, pending = {mon}, [mon]
        while pending:
            cur = pending.pop()
            for act in actions:
                nxt = act(cur)
                if nxt not in orb:
                    orb.add(nxt)
                    pending.append(nxt)
        seen.update(orb)
        result.append(tuple(sorted(orb)))
    return result


def evaluate_orbit(orb, x):
    return sum((x & mon) == mon for mon in orb) & 1


def fwht(signs):
    data = list(signs)
    n = len(data)
    assert n > 0 and (n & (n - 1)) == 0
    step = 1
    while step < n:
        for i in range(0, n, 2 * step):
            for j in range(i, i + step):
                u, v = data[j], data[j + step]
                data[j], data[j + step] = u + v, u - v
        step *= 2
    return data


def bent(signs):
    n = len(signs)
    return all(w * w == n for w in fwht(signs))


def test_fixed6(degree, expected_bent):
    actions = [lambda x: perm3(x, 0), lambda x: perm3(x, 3)]
    fixed = [0, 7, 56, 63]
    orbs = monomial_orbits(6, actions, degree)
    signatures = [sum(evaluate_orbit(orb, x) << j
                      for j, orb in enumerate(orbs)) for x in range(64)]
    count = 0
    balanced = 0
    for c in range(1 << len(orbs)):
        signs = [1 - 2 * parity(c & v) for v in signatures]
        restricted = [signs[x] for x in fixed]
        if degree == 2:
            full_balanced = (sum(signs) == 0)
            assert full_balanced == (sum(restricted) == 0), c
            balanced += full_balanced
        if bent(signs):
            count += 1
            assert bent(restricted), (degree, c, "bent restriction failure")
    assert count == expected_bent, (degree, count)
    if degree == 2:
        assert len(orbs) == 5 and balanced == 12
    print(f"degree <= {degree}: {len(orbs)} orbits, {1<<len(orbs)} functions, "
          f"{count} bent, zero transfer failures")
    return count


def test_cubic10():
    # A,B are disjoint triples; a,b,c,d are fixed coordinates.
    def f(x):
        wa = sum((x >> i) & 1 for i in range(3))
        wb = sum((x >> i) & 1 for i in range(3, 6))
        a, b, c, d = [(x >> i) & 1 for i in range(6, 10)]
        return ((wa * (wa - 1) // 2) + (wb * (wb - 1) // 2)
                + wa * wb + a * b + c * d + (wa & 1) * a * c) & 1

    assert all(f(perm3(x, 0)) == f(x)
               and f(perm3(x, 3)) == f(x) for x in range(1 << 10))
    signs = [1 - 2 * f(x) for x in range(1 << 10)]
    assert {abs(w) for w in fwht(signs)} == {32}
    fixed = [0, 7, 56, 63]
    restricted = [1 - 2 * f(base | (u << 6))
                  for u in range(16) for base in fixed]
    assert {abs(w) for w in fwht(restricted)} == {8}
    derivative3 = 0
    directions = [1 << 0, 1 << 6, 1 << 8]
    for bits in range(8):
        pos = 0
        for j in range(3):
            if (bits >> j) & 1:
                pos ^= directions[j]
        derivative3 ^= f(pos)
    assert derivative3 == 1
    print("n=10 cubic example: invariant and bent; fixed restriction bent")


def run():
    test_fixed6(2, 4)
    test_fixed6(3, 4)
    test_fixed6(4, 4)
    test_fixed6(5, 4)
    test_fixed6(6, 4)
    test_cubic10()
    print("PASS")


if __name__ == "__main__":
    run()
