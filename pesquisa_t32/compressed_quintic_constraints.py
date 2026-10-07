#!/usr/bin/env python3
"""Exact compressed necessary-condition audit for homogeneous quintic RSBFs in n=16.

The 255 nonzero fibers F_z(u)=f(u,u+z) fall into 35 cyclic rotation
classes. This script evaluates one representative per class and reconstructs:
  * all fiber weights (with class multiplicities),
  * the total Hamming weight,
  * all 35 cyclic classes of diagonal derivative weights D_(p,p) f.

Everything uses exact Python integers and the standard library. Passing the
reported conditions is necessary, not sufficient, for bentness.
"""
import argparse
import itertools
import json
from functools import lru_cache
from pathlib import Path

N = 16
H = 8


def toggle(container, value):
    if value in container:
        container.remove(value)
    else:
        container.add(value)


def cyclic_orbits(n=N, degree=5):
    unseen = set(itertools.combinations(range(n), degree))
    result = []
    while unseen:
        rep = min(unseen)
        orbit = {
            tuple(sorted((i + shift) % n for i in rep))
            for shift in range(n)
        }
        unseen.difference_update(orbit)
        result.append((rep, sorted(orbit)))
    return result


def rotate8(value, shift):
    shift %= H
    if not shift:
        return value
    return ((value << shift) | (value >> (H - shift))) & 0xFF


def canonical_rotation(value):
    return min(rotate8(value, shift) for shift in range(H))


def period(value):
    for p in range(1, H + 1):
        if rotate8(value, p) == value:
            return p
    raise AssertionError


MONOMIAL_TRUTH = []
for mask in range(1 << H):
    truth = 0
    for u in range(1 << H):
        if (u & mask) == mask:
            truth |= 1 << u
    MONOMIAL_TRUTH.append(truth)


def fiber_profile(orbit, z):
    anf = set()
    for support in orbit:
        terms = {0}
        for variable in support:
            if variable < H:
                factors = (1 << variable,)
            else:
                j = variable - H
                factors = (1 << j, 0) if ((z >> j) & 1) else (1 << j,)
            nxt = set()
            for left in terms:
                for right in factors:
                    toggle(nxt, left | right)
            terms = nxt
        for monomial in terms:
            toggle(anf, monomial)
    truth = 0
    for monomial in anf:
        truth ^= MONOMIAL_TRUTH[monomial]
    return truth


def xor_shift_truth(truth, direction):
    shifted = 0
    for u in range(1 << H):
        if (truth >> (u ^ direction)) & 1:
            shifted |= 1 << u
    return shifted


def derivative_weight8(truth, direction):
    return (truth ^ xor_shift_truth(truth, direction)).bit_count()


@lru_cache(maxsize=1)
def build_basis():
    orbits = cyclic_orbits()
    assert len(orbits) == 273
    reps = sorted({canonical_rotation(z) for z in range(1, 1 << H)})
    assert len(reps) == 35
    periods = [period(z) for z in reps]
    profiles = [
        [fiber_profile(orbit, z) for z in reps]
        for _, orbit in orbits
    ]
    return orbits, reps, periods, profiles


def profiles_from_mask(mask, profiles):
    if not isinstance(mask, int) or not 0 <= mask < (1 << len(profiles)):
        raise ValueError('coefficient mask must be a nonnegative integer within the orbit basis')
    output = [0] * 35
    value = mask
    while value:
        low = value & -value
        coefficient = low.bit_length() - 1
        row = profiles[coefficient]
        for j in range(35):
            output[j] ^= row[j]
        value ^= low
    return output


def diagonal_derivative_weights(fiber_profiles, reps, periods):
    result = {}
    for p in reps:
        total = 0
        for z, orbit_size, truth in zip(reps, periods, fiber_profiles):
            for shift in range(orbit_size):
                direction = rotate8(p, -shift)
                total += derivative_weight8(truth, direction)
        result[p] = total
    return result


def audit(mask):
    if not isinstance(mask, int) or not 0 <= mask < (1 << 273):
        raise ValueError('coefficient mask must be a nonnegative 273-bit integer')
    _, reps, periods, basis = build_basis()
    fibers = profiles_from_mask(mask, basis)
    fiber_weights = [truth.bit_count() for truth in fibers]
    total_weight = sum(
        multiplicity * weight
        for multiplicity, weight in zip(periods, fiber_weights)
    )
    bad_fibers = sum(
        multiplicity
        for multiplicity, weight in zip(periods, fiber_weights)
        if weight != 128
    )
    diagonal = diagonal_derivative_weights(fibers, reps, periods)

    report = {
        "n": N,
        "degree": 5,
        "coefficient_mask": hex(mask),
        "active_orbits": mask.bit_count(),
        "rotation_class_count": len(reps),
        "total_weight": total_weight,
        "bent_weight_required_by_zero_diagonal": 32640,
        "fiber_class_weights": {
            hex(z): weight for z, weight in zip(reps, fiber_weights)
        },
        "bad_nonzero_fibers": bad_fibers,
        "balanced_fiber_classes": sum(weight == 128 for weight in fiber_weights),
        "complementary_fiber_weight": fiber_weights[reps.index(0xFF)],
        "diagonal_derivative_class_weights": {
            hex(p): diagonal[p] for p in reps
        },
        "balanced_diagonal_derivative_classes": sum(
            value == 32768 for value in diagonal.values()
        ),
        "passes_all_fiber_conditions": bad_fibers == 0,
        "passes_all_diagonal_derivative_conditions": all(
            value == 32768 for value in diagonal.values()
        ),
        "scope": (
            "Exact necessary conditions. Passing fibers and diagonal derivatives "
            "does not by itself prove bentness."
        ),
    }

    if report["passes_all_fiber_conditions"]:
        assert total_weight == 255 * 128 == 32640
        deviations = sum(
            periods[reps.index(p)] * (diagonal[p] - 32768)
            for p in reps
        )
        assert deviations == 0

    return report


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--mask", required=True)
    parser.add_argument("--output", default="compressed_quintic_audit.json")
    args = parser.parse_args()
    report = audit(int(args.mask, 0))
    Path(args.output).write_text(json.dumps(report, indent=2) + "\n")
    print(json.dumps({
        key: report[key]
        for key in (
            "total_weight",
            "bad_nonzero_fibers",
            "balanced_fiber_classes",
            "complementary_fiber_weight",
            "balanced_diagonal_derivative_classes",
        )
    }, indent=2))


if __name__ == "__main__":
    main()
