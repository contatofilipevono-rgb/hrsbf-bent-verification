"""Independent orbit-based mod-9 Walsh evaluator for H(16,4).

Input: selected 4-subset monomial rotation orbits (NOT Step-60 reduced variables).
This evaluator is a research filter, not an UNSAT certificate. A positive
outcome at a subset of frequencies does not establish bentness.
"""
from itertools import combinations
from math import comb
import random

N = 16
MASK = (1 << N) - 1
BENT_MAGNITUDE = 1 << (N // 2)
PERMITTED_MOD9 = {BENT_MAGNITUDE % 9, (-BENT_MAGNITUDE) % 9}  # {4,5}


def rotate(bits, shift):
    shift %= N
    return ((bits << shift) | (bits >> (N - shift))) & MASK if shift else bits


def orbit(bits):
    return tuple(sorted({rotate(bits, i) for i in range(N)}))


def orbit_partition():
    seen = set()
    result = []
    for bits in range(1 << N):
        if bits not in seen:
            part = orbit(bits)
            seen.update(part)
            result.append(part)
    assert sum(map(len, result)) == 1 << N
    assert len(result) == 4116
    return result


def quartic_orbits():
    seen = set()
    result = []
    for indices in combinations(range(N), 4):
        bits = sum(1 << i for i in indices)
        if bits not in seen:
            part = orbit(bits)
            seen.update(part)
            result.append(part)
    assert sum(map(len, result)) == comb(N, 4)
    assert len(result) == 116
    return result


def rotation_symmetric_truth(selected_orbits, q_orbits=None):
    q_orbits = q_orbits if q_orbits is not None else quartic_orbits()
    f = bytearray(1 << N)
    for i in selected_orbits:
        assert 0 <= i < len(q_orbits)
        for monomial in q_orbits[i]:
            for x in range(1 << N):
                if x & monomial == monomial:
                    f[x] ^= 1
    return f


def walsh_direct(f, u):
    return sum(1 if (f[x] ^ ((u & x).bit_count() & 1)) == 0 else -1
               for x in range(1 << N))


def walsh_orbits(f, frequencies, partition=None, modulus=9):
    partition = partition if partition is not None else orbit_partition()
    for part in partition:
        reference = f[part[0]]
        assert all(f[x] == reference for x in part), "Input not rotation invariant"
    vals = {}
    for u in frequencies:
        val = sum((1 - 2 * f[part[0]]) *
                  sum(1 - 2 * ((u & x).bit_count() & 1) for x in part)
                  for part in partition)
        vals[u] = val if modulus is None else val % modulus
    return vals


def passes_mod9(vals):
    return all(value % 9 in PERMITTED_MOD9 for value in vals.values())


def self_test():
    parts = orbit_partition()
    quartics = quartic_orbits()
    assert len(parts) == 4116 and len(quartics) == 116
    rng = random.Random(0x16509)
    probes = [0, 1, 3, 5, 7, 0x5555, 0x0101, 0xffff]
    for trial in range(4):
        choices = rng.sample(range(116), trial * 9)
        f = rotation_symmetric_truth(choices, quartics)
        orbit_vals = walsh_orbits(f, probes, parts, modulus=None)
        for u in probes:
            assert orbit_vals[u] == walsh_direct(f, u)
            assert orbit_vals[u] % 9 == walsh_direct(f, u) % 9
            assert (walsh_direct(f, u) in (-256, 256)) <= (orbit_vals[u] % 9 in PERMITTED_MOD9)
    # Independently constructed quadratic bent function:
    # f = x0*x8 + x1*x9 + ... + x7*x15, invariant under rotation.
    f = bytearray(1 << N)
    for x in range(1 << N):
        f[x] = sum(((x >> i) & 1) * ((x >> (i+8)) & 1) for i in range(8)) & 1
    vals = walsh_orbits(f, probes, parts, modulus=None)
    assert all(abs(z) == 256 for z in vals.values())
    assert passes_mod9(vals)
    print("PASS: 4116 spectral orbits, 116 quartic orbits, signed direct Walsh,")
    print("      mod-9 residue equivalence for bent controls (necessary per frequency)")
    print("WARNING: to use 9-modulus as sufficient for bentness requires a separate theorem proof.")
    print("WARNING: reduced Step-60 polynomial coordinates are not ANF coefficients.")


if __name__ == "__main__":
    self_test()
