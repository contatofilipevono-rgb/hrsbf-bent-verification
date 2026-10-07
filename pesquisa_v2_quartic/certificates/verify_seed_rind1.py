#!/usr/bin/env python3
"""Independent certificate for the 8-variable quartic RS seed used in V2.

Pure Python, no third-party dependencies.

Seed SANF orbit representatives (0-based):
    (0,1), (0,1,2,3), (0,1,2,5), (0,1,3,5)

Checks:
1. rotation symmetry;
2. algebraic degree 4 from the generated ANF;
3. bentness by the full Walsh spectrum;
4. exhaustive relaxed-linearity certificate: every unordered independent
   nonzero direction pair {a,b} has nonconstant D_a D_b f.

Over F_2, two distinct nonzero vectors are automatically linearly independent.
Thus checking all C(255,2)=32385 pairs proves that no 2-dimensional relaxed
M-subspace exists. Every nonzero one-dimensional subspace is an M-subspace,
so r-ind(f)=ind(f)=1.
"""

from itertools import combinations

N = 8
MASK = (1 << N) - 1
REPS = ((0,1), (0,1,2,3), (0,1,2,5), (0,1,3,5))


def orbit(rep):
    return {tuple(sorted((i+s) % N for i in rep)) for s in range(N)}


MONOMIALS = set().union(*(orbit(rep) for rep in REPS))


def f(x):
    out = 0
    for mon in MONOMIALS:
        term = 1
        for i in mon:
            term &= (x >> i) & 1
        out ^= term
    return out


TT = tuple(f(x) for x in range(1 << N))


def rotate_one(x):
    # Coordinate convention is immaterial for invariance; this sends bit i to i-1 mod N.
    return ((x >> 1) | ((x & 1) << (N-1))) & MASK


def second_derivative(a, b, x):
    return TT[x] ^ TT[x ^ a] ^ TT[x ^ b] ^ TT[x ^ a ^ b]


def walsh(a):
    total = 0
    for x in range(1 << N):
        parity = (a & x).bit_count() & 1
        total += 1 if (TT[x] ^ parity) == 0 else -1
    return total


def main():
    assert len(MONOMIALS) == 32
    assert max(map(len, MONOMIALS)) == 4
    assert any(len(m) == 4 for m in MONOMIALS)

    assert all(TT[rotate_one(x)] == TT[x] for x in range(1 << N))

    spectrum = tuple(walsh(a) for a in range(1 << N))
    assert set(spectrum) == {-16, 16}
    assert spectrum.count(16) == 136
    assert spectrum.count(-16) == 120

    checked = 0
    constant_pairs = []
    for a, b in combinations(range(1, 1 << N), 2):
        checked += 1
        c0 = second_derivative(a, b, 0)
        if all(second_derivative(a, b, x) == c0 for x in range(1, 1 << N)):
            constant_pairs.append((a, b, c0))

    assert checked == 32385
    assert not constant_pairs

    print("V2 seed certificate: PASS")
    print(f"ANF monomials: {len(MONOMIALS)}")
    print("algebraic degree: 4")
    print("rotation symmetry: PASS (all 256 inputs)")
    print("Walsh spectrum: {-16: 120, +16: 136}; bentness PASS")
    print(f"independent direction pairs checked: {checked}")
    print("constant second-derivative pairs: 0")
    print("conclusion: r-ind(f)=ind(f)=1")


if __name__ == "__main__":
    main()
