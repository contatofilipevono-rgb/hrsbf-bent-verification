#!/usr/bin/env python3
"""Exact GF(2) ranks of diagonal derivative maps for quintic HRSBFs in n=16.

For p in F_2^8\{0}, set a=(p,p).  The script computes the rank of
    c in F_2^273 -> D_a f_c
in ANF coordinates, where f_c ranges over homogeneous degree-5
rotation-symmetric Boolean functions in 16 variables.

It also analyzes the special all-ones derivative and the ambient space of
rotation-symmetric degree <=4 functions invariant under x -> x+1.
Ranks are structural data only; balancedness is nonlinear.
"""
import collections
import itertools
import json
import sys
from pathlib import Path

N = 16
H = 8

def cyclic_orbits(n=N, degree=5):
    unseen = set(itertools.combinations(range(n), degree))
    out = []
    while unseen:
        rep = min(unseen)
        orbit = {
            tuple(sorted((i + shift) % n for i in rep))
            for shift in range(n)
        }
        unseen.difference_update(orbit)
        out.append((rep, sorted(orbit)))
    return out

def derivative_orbit_anf(orbit, a):
    out = 0
    for support in orbit:
        active = sum(1 << i for i in support if (a >> i) & 1)
        if not active:
            continue
        full = sum(1 << i for i in support)
        subset = active
        while subset:
            out ^= 1 << (full ^ subset)
            subset = (subset - 1) & active
    return out

def add_basis(basis, vector):
    x = vector
    while x:
        pivot = x.bit_length() - 1
        if pivot in basis:
            x ^= basis[pivot]
        else:
            basis[pivot] = x
            return True
    return False

def rank(vectors):
    basis = {}
    for vector in vectors:
        add_basis(basis, vector)
    return len(basis)

def rotation(v, shift, bits=H):
    if not shift:
        return v
    return ((v << shift) | (v >> (bits - shift))) & ((1 << bits) - 1)

def canonical_rotation(v):
    return min(rotation(v, shift) for shift in range(H))

def monomial_orbits(n, degree):
    if degree == 0:
        return [((), [()])]
    unseen = set(itertools.combinations(range(n), degree))
    out = []
    while unseen:
        rep = min(unseen)
        orbit = {
            tuple(sorted((i + shift) % n for i in rep))
            for shift in range(n)
        }
        unseen.difference_update(orbit)
        out.append((rep, sorted(orbit)))
    return out

def orbit_polynomial(orbit):
    poly = 0
    for support in orbit:
        poly ^= 1 << sum(1 << i for i in support)
    return poly

def derivative_all_ones_poly(poly):
    out = 0
    x = poly
    while x:
        low = x & -x
        mask = low.bit_length() - 1
        subset = mask
        while True:
            if subset != mask:
                out ^= 1 << subset
            if subset == 0:
                break
            subset = (subset - 1) & mask
        x ^= low
    return out

def generate():
    orbits = cyclic_orbits()
    assert len(orbits) == 273

    records = []
    histogram = collections.Counter()
    for p in range(1, 1 << H):
        direction = p | (p << H)
        r = rank(derivative_orbit_anf(orbit, direction) for _, orbit in orbits)
        records.append((p, r))
        histogram[r] += 1

    expected = collections.Counter({
        112: 1, 188: 2, 235: 4, 247: 8,
        263: 16, 265: 32, 266: 192,
    })
    assert histogram == expected
    assert dict(records)[0xFF] == 112

    classes = {}
    for p, r in records:
        classes.setdefault(canonical_rotation(p), set()).add(r)
    assert len(classes) == 35
    assert all(len(values) == 1 for values in classes.values())

    all_ones_images = [
        derivative_orbit_anf(orbit, 0xFFFF)
        for _, orbit in orbits
    ]
    degree_rows = {d: {} for d in range(5)}
    for coefficient, poly in enumerate(all_ones_images):
        x = poly
        while x:
            low = x & -x
            monomial = low.bit_length() - 1
            degree = monomial.bit_count()
            degree_rows[degree][monomial] = (
                degree_rows[degree].get(monomial, 0) | (1 << coefficient)
            )
            x ^= low

    block_ranks = {
        degree: rank(rows.values())
        for degree, rows in degree_rows.items()
    }
    assert block_ranks == {0: 0, 1: 1, 2: 6, 3: 34, 4: 84}

    basis = {}
    cumulative = []
    for degree in (4, 3, 2, 1, 0):
        before = len(basis)
        for row in degree_rows[degree].values():
            add_basis(basis, row)
        cumulative.append({
            "degree": degree,
            "gain": len(basis) - before,
            "total": len(basis),
        })
    assert cumulative == [
        {"degree": 4, "gain": 84, "total": 84},
        {"degree": 3, "gain": 27, "total": 111},
        {"degree": 2, "gain": 0, "total": 111},
        {"degree": 1, "gain": 1, "total": 112},
        {"degree": 0, "gain": 0, "total": 112},
    ]

    rs_basis = []
    for degree in range(5):
        for _, orbit in monomial_orbits(N, degree):
            rs_basis.append(orbit_polynomial(orbit))
    assert len(rs_basis) == 161

    derivative_map_rank = rank(
        derivative_all_ones_poly(poly) for poly in rs_basis
    )
    assert derivative_map_rank == 36

    # Kernel dimension 125 is the full complement-invariant RS space.
    # Constants give one kernel dimension; imposing q(0)=0 leaves 124.
    ambient_invariant_dimension = len(rs_basis) - derivative_map_rank
    zero_origin_dimension = ambient_invariant_dimension - 1
    assert ambient_invariant_dimension == 125
    assert zero_origin_dimension == 124

    return {
        "date_utc": "2026-10-06",
        "n": N,
        "degree": 5,
        "coefficient_dimension": len(orbits),
        "diagonal_direction_rank_histogram": {
            str(k): v for k, v in sorted(histogram.items())
        },
        "rotation_class_count": len(classes),
        "all_ones_rank": 112,
        "all_ones_is_unique_minimum": (
            sum(1 for _, r in records if r == 112) == 1
        ),
        "all_ones_degree_block_ranks": {
            str(k): v for k, v in block_ranks.items()
        },
        "all_ones_cumulative_gains_high_to_low": cumulative,
        "ambient_rotation_symmetric_degree_le_4_complement_invariant_dimension":
            ambient_invariant_dimension,
        "ambient_same_with_zero_origin_dimension": zero_origin_dimension,
        "all_ones_derivative_image_codimension_in_zero_origin_ambient":
            zero_origin_dimension - 112,
        "status": "PASS",
        "scope": (
            "Exact GF(2) ranks of linear derivative maps; balance is nonlinear "
            "and no quintic nonexistence is claimed."
        ),
    }

if __name__ == "__main__":
    if not __debug__:
        raise RuntimeError("Run without python -O; assertions are audit checks.")
    if len(sys.argv) != 2:
        raise SystemExit(
            "usage: python3 diagonal_derivative_rank_d5.py OUTPUT.json"
        )
    report = generate()
    Path(sys.argv[1]).write_text(json.dumps(report, indent=2) + "\n")
    print(json.dumps(report, indent=2))
