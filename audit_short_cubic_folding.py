#!/usr/bin/env python3
"""Independent audit of short cubic orbit folding.

No project validator is imported.  For selected n=t*m (t a power of two,
m odd), enumerate all 3-subsets of Z/nZ, partition them into rotation
orbits, select the orbits with nontrivial stabilizer, and verify that each
restricts to the linear parity orbit L on t variables.

This is supplementary validation, not a premise of the proof.
"""
from itertools import combinations

def rot(S, k, n):
    return tuple(sorted((x + k) % n for x in S))

def orbit(S, n):
    return {rot(S, k, n) for k in range(n)}

def reduced_monomial(S, t):
    # ANF idempotence: repeated variables collapse.
    return tuple(sorted(set(x % t for x in S)))

def audit(n, t):
    assert n % t == 0
    m = n // t
    assert t & (t - 1) == 0 and m % 2 == 1
    seen = set()
    short = []
    for S in combinations(range(n), 3):
        if S in seen:
            continue
        O = orbit(S, n)
        seen.update(O)
        if len(O) < n:
            short.append((S, O))

    for S, O in short:
        assert len(O) == n // 3, (n, S, len(O))
        expected = tuple(sorted((S[0], (S[0]+n//3)%n, (S[0]+2*n//3)%n)))
        assert tuple(sorted(S)) == expected, (n, S, expected)
        parity = [0] * t
        for M in O:
            R = reduced_monomial(M, t)
            assert len(R) == 1, (n, t, S, M, R)
            parity[R[0]] ^= 1
        assert parity == [1] * t, (n, t, S, parity)
    return len(short)

def main():
    cases = [(12,4),(20,4),(24,8),(28,4),(36,4),(40,8),(48,16),(56,8),(60,4)]
    for n,t in cases:
        c = audit(n,t)
        print(f"n={n:2d}, t={t:2d}, m={n//t:2d}: short cubic orbits={c}, PASS")
    print("ALL SHORT-ORBIT FOLDING CHECKS PASS")

if __name__ == "__main__":
    main()
