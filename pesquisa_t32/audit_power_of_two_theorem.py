#!/usr/bin/env python3
"""Independent finite controls for the power-of-two cubic RS theorem.

The proof is algebraic.  This script checks its generator-level identities in
dimensions 4, 8, 16, 32 and 64 and exhausts the full RS cubic spaces for 4 and
8 variables.  It uses only Python's standard library.
"""

import itertools
import json
import random
import sys
from pathlib import Path


def toggle(poly, monomial):
    if monomial in poly:
        poly.remove(monomial)
    else:
        poly.add(monomial)


def mul(left, right):
    result = set()
    for a in left:
        for b in right:
            toggle(result, a | b)  # Boolean reduction x_i^2=x_i
    return result


def substitute(terms, images):
    result = set()
    for term in terms:
        image = {0}
        for i in range(len(images)):
            if term >> i & 1:
                image = mul(image, images[i])
        for monomial in image:
            toggle(result, monomial)
    return result


def cubic_orbits(n):
    unseen = set(itertools.combinations(range(n), 3))
    result = []
    while unseen:
        representative = min(unseen)
        orbit = {
            tuple(sorted((i + shift) % n for i in representative))
            for shift in range(n)
        }
        unseen.difference_update(orbit)
        result.append((representative, sorted(orbit)))
    return sorted(result)


def orbit_polynomial(orbit):
    return {sum(1 << i for i in support) for support in orbit}


def derivative_all_ones(poly, n):
    images = [{0, 1 << i} for i in range(n)]
    shifted = substitute(poly, images)
    result = set(poly)
    for term in shifted:
        toggle(result, term)
    return result


def quadratic_matrix(poly, n):
    rows = [0] * n
    for term in poly:
        if term.bit_count() == 2:
            i, j = [k for k in range(n) if term >> k & 1]
            rows[i] ^= 1 << j
            rows[j] ^= 1 << i
    return rows


def rank_and_radical(rows):
    n = len(rows)
    matrix = list(rows)
    pivots = []
    for column in range(n):
        pivot = next(
            (r for r in range(len(pivots), n) if matrix[r] >> column & 1),
            None,
        )
        if pivot is None:
            continue
        row = len(pivots)
        matrix[row], matrix[pivot] = matrix[pivot], matrix[row]
        for r in range(n):
            if r != row and matrix[r] >> column & 1:
                matrix[r] ^= matrix[row]
        pivots.append(column)
    radical = []
    for free in range(n):
        if free in pivots:
            continue
        vector = 1 << free
        for row, pivot in zip(matrix, pivots):
            if row >> free & 1:
                vector |= 1 << pivot
        radical.append(vector)
    return len(pivots), radical


def evaluate(poly, x):
    return sum((x & term) == term for term in poly) & 1


def walsh(poly, n, frequency=0):
    return sum(
        -1 if evaluate(poly, x) ^ ((x & frequency).bit_count() & 1) else 1
        for x in range(1 << n)
    )


def check_generator_identities(n):
    h = n // 2
    generators = cubic_orbits(n)
    diagonal_images = [{1 << (i % h)} for i in range(n)]
    fiber_images = []
    for i in range(n):
        if i < h:
            fiber_images.append({1 << i})
        else:
            fiber_images.append({0, 1 << (i - h)})
    twist_images = [{0, 1 << (h - 1)}] + [{1 << (i - 1)} for i in range(1, h)]

    for index, (_, orbit) in enumerate(generators):
        poly = orbit_polynomial(orbit)
        assert substitute(poly, diagonal_images) == set(), (n, index, "diagonal")
        fiber = substitute(poly, fiber_images)
        assert max((term.bit_count() for term in fiber), default=0) <= 2, (
            n,
            index,
            "fiber degree",
        )
        assert substitute(fiber, twist_images) == fiber, (n, index, "twist")

        derivative_matrix = quadratic_matrix(derivative_all_ones(poly, n), n)
        fiber_matrix = quadratic_matrix(fiber, h)
        for i in range(h):
            predicted = 0
            for j in range(h):
                bit = ((derivative_matrix[i] ^ derivative_matrix[i + h]) >> (j + h)) & 1
                predicted |= bit << j
            assert predicted == fiber_matrix[i], (n, index, i, "polar transfer")
    return {"n": n, "cubic_orbits": len(generators), "identities": "PASS"}


def invariant_quadratic_basis(n):
    basis = []
    for distance in range(1, n // 2):
        basis.append(
            {
                (1 << i) | (1 << ((i + distance) % n))
                for i in range(n)
            }
        )
    basis.append({(1 << i) | (1 << (i + n // 2)) for i in range(n // 2)})
    return basis


def check_quadratic(poly, n):
    rows = quadratic_matrix(poly, n)
    rank, radical = rank_and_radical(rows)
    if rank:
        # On the radical, the normalized quadratic is linear.  Vanishing on a
        # basis therefore proves that its character sum is nonzero.
        assert all(evaluate(poly, vector) == 0 for vector in radical)
    return rank


def quadratic_controls(n, exhaustive, samples=4096):
    basis = invariant_quadratic_basis(n)
    choices = range(1 << len(basis)) if exhaustive else (
        random.Random(0xC0FFEE + n).getrandbits(len(basis)) for _ in range(samples)
    )
    checked = 0
    nonzero_polar = 0
    for choice in choices:
        quadratic = set()
        for i, generator in enumerate(basis):
            if choice >> i & 1:
                quadratic.symmetric_difference_update(generator)
        for linear in (0, 1):
            poly = set(quadratic)
            if linear:
                poly.symmetric_difference_update({1 << i for i in range(n)})
            rank = check_quadratic(poly, n)
            nonzero_polar += bool(rank)
            checked += 1
            if n <= 8:
                assert not (rank and walsh(poly, n) == 0)
    return {
        "n": n,
        "mode": "exhaustive" if exhaustive else "deterministic sample",
        "quadratics_checked": checked,
        "nonzero_polar_cases": nonzero_polar,
        "status": "PASS",
    }


def exhaustive_cubic_controls(n):
    basis = [orbit_polynomial(orbit) for _, orbit in cubic_orbits(n)]
    bent = 0
    for choice in range(1 << len(basis)):
        poly = set()
        for i, generator in enumerate(basis):
            if choice >> i & 1:
                poly.symmetric_difference_update(generator)
        spectrum = [1 if evaluate(poly, x) == 0 else -1 for x in range(1 << n)]
        step = 1
        while step < len(spectrum):
            for start in range(0, len(spectrum), 2 * step):
                for offset in range(step):
                    a = spectrum[start + offset]
                    b = spectrum[start + offset + step]
                    spectrum[start + offset] = a + b
                    spectrum[start + offset + step] = a - b
            step *= 2
        magnitude = 1 << (n // 2)
        if all(abs(value) == magnitude for value in spectrum):
            bent += 1
    assert bent == 0
    return {"n": n, "functions": 1 << len(basis), "bent": bent, "status": "PASS"}


def main(output):
    dimensions = (4, 8, 16, 32, 64)
    result = {
        "claim": "No homogeneous cubic rotation-symmetric bent Boolean function exists in n=2^k variables (k>=2).",
        "proof_status": "algebraic; these are finite controls, not a formal proof",
        "generator_identities": [check_generator_identities(n) for n in dimensions],
        "quadratic_lemma_controls": [
            quadratic_controls(n, exhaustive=n <= 16,
                               samples=2048 if n == 32 else 512)
            for n in dimensions
        ],
        "complete_small_dimension_controls": [
            exhaustive_cubic_controls(n) for n in (4, 8)
        ],
    }
    output.write_text(json.dumps(result, indent=2) + "\n")
    print(json.dumps(result, indent=2))


if __name__ == "__main__":
    if not __debug__:
        raise RuntimeError("Run without python -O; assertions are the audit checks.")
    if len(sys.argv) != 2:
        raise SystemExit("usage: python3 audit_power_of_two_theorem.py OUTPUT.json")
    main(Path(sys.argv[1]))
