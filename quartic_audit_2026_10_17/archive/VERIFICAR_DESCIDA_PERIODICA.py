"""Checks finite instances of the periodic autocorrelation descent theorem.
Python standard library only. These checks supplement, not replace, the proof.
"""
import itertools
import json
import random
from pathlib import Path


def rotate(x, n):
    return ((x << 1) & ((1 << n) - 1)) | (x >> (n - 1))


def orbits(n, degree):
    seen = set()
    result = []
    for inds in itertools.combinations(range(n), degree):
        s = sum(1 << i for i in inds)
        if s in seen:
            continue
        orbit = []
        t = s
        while t not in seen:
            seen.add(t)
            orbit.append(t)
            t = rotate(t, n)
        result.append(orbit)
    return result


def truth(n, monomials):
    a = [0] * (1 << n)
    for s in monomials:
        a[s] ^= 1
    for i in range(n):
        b = 1 << i
        for start in range(0, 1 << n, b << 1):
            for j in range(start, start + b):
                a[j + b] ^= a[j]
    return a


def walsh(a):
    v = [1 - 2 * x for x in a]
    b = 1
    while b < len(v):
        for start in range(0, len(v), b << 1):
            for j in range(start, start + b):
                x, y = v[j], v[j + b]
                v[j], v[j + b] = x + y, x - y
        b <<= 1
    return v


def repeat(x, d, q):
    return sum(x << (d * j) for j in range(q))


def corr(a, u):
    return sum(1 if x == a[i ^ u] else -1 for i, x in enumerate(a))


def main():
    rng = random.Random(112)
    tests = []
    # Includes a prime-square action, nonhomogeneous functions, and bent controls.
    for d, p, k in [(2, 3, 1), (4, 3, 1), (2, 3, 2), (2, 5, 1), (4, 5, 1)]:
        q, n = p ** k, d * p ** k
        oo = orbits(n, 4)
        cases = [[], [sum((1 << i, 1 << (i + n // 2)))
                      for i in range(n // 2)]]
        for _ in range(3):
            cases.append([s for orbit in oo if rng.randrange(2) for s in orbit])
        cases.append(cases[1] + cases[2])
        for ci, mons in enumerate(cases):
            a = truth(n, mons)
            g = [a[repeat(y, d, q)] for y in range(1 << d)]
            for u in range(1, 1 << d):
                cn, cd = corr(a, repeat(u, d, q)), corr(g, u)
                assert (cn - cd) % p == 0
                assert cd % 4 == 0
            if ci == 1:
                assert all(abs(w) == 1 << (n // 2) for w in walsh(a))
                assert all(abs(w) == 1 << (d // 2) for w in walsh(g))
        tests.append({'d': d, 'p': p, 'k': k, 'n': n, 'cases': len(cases),
                      'nonzero_periodic_shifts_per_case': (1 << d) - 1})

    # Exhaustively verify the small-dimensional premise used in the corollary.
    oo = orbits(8, 4)
    columns = [truth(8, o) for o in oo]
    assert len(columns) == 10
    bent = 0
    for coeff in range(1 << len(columns)):
        a = [0] * 256
        for j, column in enumerate(columns):
            if (coeff >> j) & 1:
                a = [x ^ y for x, y in zip(a, column)]
        bent += all(abs(w) == 16 for w in walsh(a))
    assert bent == 0

    # Symbolic support checks: short quartic orbits consist of two antipodal pairs.
    short_tests = []
    for n in range(8, 33, 2):
        m = n // 2
        short = [o for o in orbits(n, 4) if len(o) < n]
        assert len(short) == m // 2
        for orbit in short:
            for s in orbit:
                lo, hi = s & ((1 << m) - 1), s >> m
                assert lo == hi and lo.bit_count() == 2
        short_tests.append({'n': n, 'short_orbits': len(short)})
    result = {'status': 'PASS', 'periodic_descent_tests': tests,
              'H8_exhaustive': {'dimension': 10, 'tested': 1024, 'bent': bent},
              'short_orbit_support_checks': short_tests,
              'scope': 'Finite checks; infinite statements have separate written proofs.'}
    path = Path(__file__).with_name('T112_DESCIDA_PERIODICA_VERIFICACAO.json')
    path.write_text(json.dumps(result, indent=2), encoding='utf-8')
    print(json.dumps(result, indent=2))


if __name__ == '__main__':
    main()
