#!/usr/bin/env python3
"""Audit necessary bent conditions for a quintic HRSBF candidate in n=16.

The candidate is tested against:
  * the two allowed zero-frequency weights for a bent function;
  * one representative from each of the 35 rotation classes of nonzero fibers;
  * one representative from each of the 35 rotation classes of diagonal
    derivatives D_(p,p) f.

Because the candidate is rotation symmetric, weights are constant inside
each corresponding rotation class. Passing every test is necessary, not
sufficient, for bentness.
"""
import argparse
import itertools
import json

N = 16
H = 8
SIZE = 1 << N

def cyclic_orbits(n=N, degree=5):
    unseen = set(itertools.combinations(range(n), degree))
    out = []
    while unseen:
        rep = min(unseen)
        orbit = sorted({
            tuple(sorted((i + shift) % n for i in rep))
            for shift in range(n)
        })
        unseen.difference_update(orbit)
        out.append((rep, orbit))
    return out

def rotation(v, shift, bits=H):
    if not shift:
        return v
    return ((v << shift) | (v >> (bits - shift))) & ((1 << bits) - 1)

def class_representatives():
    return sorted({
        min(rotation(v, shift) for shift in range(H))
        for v in range(1, 1 << H)
    })

def variable_tables():
    full = (1 << SIZE) - 1
    tables = []
    for i in range(N):
        block = (1 << (1 << i)) - 1
        value = 0
        for start in range(1 << i, SIZE, 2 << i):
            value |= block << start
        tables.append(value)
    return full, tables

def orbit_truth_tables(orbits):
    full, variables = variable_tables()
    result = []
    for _, orbit in orbits:
        truth = 0
        for support in orbit:
            monomial = full
            for i in support:
                monomial &= variables[i]
            truth ^= monomial
        result.append(truth)
    return result

def bit_at(raw, x):
    return (raw[x >> 3] >> (x & 7)) & 1

def fiber_weight(raw, z):
    return sum(
        bit_at(raw, u | ((u ^ z) << H))
        for u in range(1 << H)
    )

PERMUTE_BYTE = [[0] * 256 for _ in range(8)]
for low in range(8):
    for byte in range(256):
        permuted = 0
        for bit in range(8):
            if (byte >> (bit ^ low)) & 1:
                permuted |= 1 << bit
        PERMUTE_BYTE[low][byte] = permuted

POPCOUNT = [value.bit_count() for value in range(256)]

def derivative_weight(raw, direction):
    high = direction >> 3
    low = direction & 7
    permutation = PERMUTE_BYTE[low]
    return sum(
        POPCOUNT[byte ^ permutation[raw[index ^ high]]]
        for index, byte in enumerate(raw)
    )

def parse_candidate(args, orbits):
    if args.mask is not None:
        return int(args.mask, 0)

    with open(args.json) as handle:
        data = json.load(handle)

    if "coefficient_mask" in data:
        return int(data["coefficient_mask"], 0)

    if "coefficients" in data:
        return sum(
            (int(value) & 1) << i
            for i, value in enumerate(data["coefficients"])
        )

    index = {tuple(rep): i for i, (rep, _) in enumerate(orbits)}
    for key in (
        "active_orbit_representatives",
        "homogeneous_quintic_RS_orbit_representatives",
    ):
        if key in data:
            mask = 0
            for representative in data[key]:
                mask |= 1 << index[tuple(representative)]
            return mask

    raise SystemExit("JSON does not contain a supported coefficient encoding")

def audit(mask):
    if not isinstance(mask, int) or not 0 <= mask < (1 << 273):
        raise ValueError('coefficient mask must be a nonnegative 273-bit integer')
    orbits = cyclic_orbits()
    assert len(orbits) == 273
    truth_tables = orbit_truth_tables(orbits)

    truth = 0
    for i, table in enumerate(truth_tables):
        if (mask >> i) & 1:
            truth ^= table

    raw = truth.to_bytes(SIZE // 8, "little")
    representatives = class_representatives()
    assert len(representatives) == 35

    fibers = []
    derivatives = []
    for p in representatives:
        weight = fiber_weight(raw, p)
        fibers.append({
            "z": hex(p),
            "weight": weight,
            "balanced": weight == 128,
        })

        direction = p | (p << H)
        dweight = derivative_weight(raw, direction)
        derivatives.append({
            "p": hex(p),
            "direction": hex(direction),
            "weight": dweight,
            "balanced": dweight == 32768,
        })

    weight = truth.bit_count()
    zero_frequency_ok = weight in (32640, 32896)

    return {
        "n": N,
        "degree": 5,
        "coefficient_mask": hex(mask),
        "active_orbits": mask.bit_count(),
        "weight": weight,
        "bent_zero_frequency_weight": zero_frequency_ok,
        "fiber_rotation_classes_tested": len(fibers),
        "balanced_fiber_classes": sum(row["balanced"] for row in fibers),
        "diagonal_derivative_rotation_classes_tested": len(derivatives),
        "balanced_diagonal_derivative_classes":
            sum(row["balanced"] for row in derivatives),
        "fiber_results": fibers,
        "diagonal_derivative_results": derivatives,
        "passes_all_recorded_necessary_conditions": (
            zero_frequency_ok
            and all(row["balanced"] for row in fibers)
            and all(row["balanced"] for row in derivatives)
        ),
        "status_note": (
            "Necessary conditions only; passing does not prove bentness."
        ),
    }

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--mask")
    parser.add_argument("--json")
    parser.add_argument("--output", default="candidate_audit.json")
    args = parser.parse_args()

    if bool(args.mask) == bool(args.json):
        raise SystemExit("provide exactly one of --mask or --json")

    orbits = cyclic_orbits()
    mask = parse_candidate(args, orbits)
    report = audit(mask)

    with open(args.output, "w") as handle:
        json.dump(report, handle, indent=2)
        handle.write("\n")

    print(json.dumps({
        key: report[key]
        for key in (
            "weight",
            "bent_zero_frequency_weight",
            "balanced_fiber_classes",
            "balanced_diagonal_derivative_classes",
            "passes_all_recorded_necessary_conditions",
        )
    }, indent=2))

if __name__ == "__main__":
    main()
