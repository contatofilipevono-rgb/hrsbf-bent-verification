"""Exact filters and exhaustive shards for the quartic top of RS bent functions."""

import argparse
import json
from itertools import combinations
from pathlib import Path
from time import perf_counter

import numpy as np

N = 12
SIZE = 1 << N
FULL = SIZE - 1


def rot(mask, shift=1):
    return ((mask << shift) | (mask >> (N - shift))) & FULL


def masks_of_size(d):
    return (sum(1 << i for i in c) for c in combinations(range(N), d))


def orbits(masks):
    remaining = set(masks)
    while remaining:
        rep = min(remaining)
        orbit = tuple(sorted({rot(rep, j) for j in range(N)}))
        yield rep, orbit
        remaining.difference_update(orbit)


def active_bits(mask):
    while mask:
        bit = mask & -mask
        yield bit.bit_length() - 1
        mask ^= bit


TOP = tuple(orbits(masks_of_size(4)))
TOP_REPS = tuple(rep for rep, _ in TOP)
INDEX = {mask: i for i, (_, orbit) in enumerate(TOP) for mask in orbit}
DIM = len(TOP)
SLICES = tuple(FULL ^ m for m in TOP_REPS)


def filter_polys():
    """The divided square of the exterior quartic, in cyclic coordinates."""
    polys = []
    for t in SLICES:
        terms = set()
        for u in INDEX:
            v = t ^ u
            if u & t == u and u < v:
                term = (1 << INDEX[u]) | (1 << INDEX[v])
                terms.symmetric_difference_update((term,))
        polys.append(frozenset(terms))
    return polys


def product_linear_certificates(polys):
    """Find all linear rows in the span of Q_i and x_j Q_i."""
    monomials = [1 << i for i in range(DIM)]
    monomials += [sum(1 << i for i in c) for d in (2, 3)
                  for c in combinations(range(DIM), d)]
    indices = {m: i for i, m in enumerate(monomials)}
    rows = {}
    derived = {}
    for i, poly in enumerate(polys):
        for j in range(-1, DIM):
            x = 0 if j < 0 else 1 << j
            lifted = set()
            for m in poly:
                lifted.symmetric_difference_update((m | x,))
            row = sum(1 << indices[m] for m in lifted)
            certificate = 1 << (i * (DIM + 1) + j + 1)
            while row:
                pivot = row.bit_length() - 1
                if pivot not in rows:
                    rows[pivot] = row, certificate
                    if pivot < DIM:
                        derived[pivot] = row, certificate
                    break
                prior, reason = rows[pivot]
                row ^= prior
                certificate ^= reason
    for row, certificate in derived.values():
        reconstructed = set()
        for c in active_bits(certificate):
            i, j = divmod(c, DIM + 1)
            multiplier = 0 if j == 0 else 1 << (j - 1)
            for m in polys[i]:
                reconstructed.symmetric_difference_update((m | multiplier,))
        assert reconstructed == {1 << j for j in active_bits(row)}
    return derived


def nullspace(equations):
    free = [i for i in range(DIM) if i not in equations]
    basis = []
    for i in free:
        v = 1 << i
        for j, row in sorted(equations.items()):
            if (v & row).bit_count() & 1:
                v |= 1 << j
        assert all((v & row).bit_count() % 2 == 0 for row in equations.values())
        basis.append(v)
    return basis


def evaluate(polys, assignment):
    result = 0
    for i, poly in enumerate(polys):
        if sum(assignment & m == m for m in poly) & 1:
            result |= 1 << i
    return result


def xor_table(values):
    table = np.zeros(1, dtype=np.uint64)
    for v in values:
        table = np.concatenate((table, table ^ np.uint64(v)))
    return table


def quad_table(linear, cross):
    table = np.zeros(1, dtype=np.uint64)
    for i, a in enumerate(linear):
        extra = xor_table([cross[j][i] for j in range(i)])
        table = np.concatenate((table, table ^ np.uint64(a) ^ extra))
    return table


def independent_filter_controls(polys):
    points = np.arange(SIZE, dtype=np.uint16)
    evaluation = np.zeros((DIM + 3, SIZE), dtype=np.uint8)
    for i, (_, orbit) in enumerate(TOP):
        for m in orbit:
            evaluation[i] ^= (points & m) == m
    for i, mask in enumerate((3, 11, 21), DIM):
        for m in {rot(mask, j) for j in range(N)}:
            evaluation[i] ^= (points & m) == m
    rng = np.random.default_rng(12)
    sample = rng.integers(0, 2, (96, DIM + 3), dtype=np.uint8)
    with_lower = (sample @ evaluation) & 1
    sample[:, DIM:] = 0
    top_only = (sample @ evaluation) & 1
    values = [sum(int(c) << i for i, c in enumerate(row[:DIM])) for row in sample]
    direct = np.zeros(96, dtype=np.uint64)
    for j, t in enumerate(SLICES):
        fixed = FULL ^ t
        for translate in (0, fixed & -fixed, fixed):
            selector = (points & fixed) == translate
            w_top = top_only[:, selector].sum(axis=1) % 4
            w_mix = with_lower[:, selector].sum(axis=1) % 4
            assert np.array_equal(w_top, w_mix)
            assert np.all(w_top % 2 == 0)
            direct |= (w_top // 2) << np.uint64(j)
    assert direct.tolist() == [evaluate(polys, v) for v in values]


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--shard", type=int, default=0)
    parser.add_argument("--shard-bits", type=int, default=4)
    parser.add_argument("--limit", type=int)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    started = perf_counter()
    assert 0 <= args.shard < 1 << args.shard_bits
    polys = filter_polys()
    independent_filter_controls(polys)
    certs = product_linear_certificates(polys)
    equations = {p: row for p, (row, _) in certs.items()}
    basis = nullspace(equations)
    free = len(basis)
    width = free - args.shard_bits
    fixed = 0
    for i in active_bits(args.shard):
        fixed ^= basis[width + i]
    branch = basis[:width]
    nw = min(20, width)
    nu = width - nw
    q0 = evaluate(polys, fixed)
    linear = [evaluate(polys, fixed ^ v) ^ q0 for v in branch]
    cross = [[0] * width for _ in branch]
    for i, j in combinations(range(width), 2):
        entry = evaluate(polys, fixed ^ branch[i] ^ branch[j])
        cross[i][j] = cross[j][i] = entry ^ q0 ^ linear[i] ^ linear[j]
    left = quad_table(linear[:nu], [row[:nu] for row in cross[:nu]])
    right = quad_table(linear[nu:], [row[nu:] for row in cross[nu:]])
    mixed = [xor_table(row[nu:]) for row in cross[:nu]]
    lookup = xor_table(branch[nu:])
    left_lookup = xor_table(branch[:nu])
    limit = (1 << nu) if args.limit is None else min(args.limit, 1 << nu)
    solutions = []
    print(f"rank={len(equations)} free={free} shard={args.shard} "
          f"block=2^{nw} iterations={limit}", flush=True)
    for step in range(limit):
        if step:
            bit = (step & -step).bit_length() - 1
            np.bitwise_xor(right, mixed[bit], out=right)
        gray = step ^ (step >> 1)
        hits = np.flatnonzero(right == (left[gray] ^ np.uint64(q0)))
        if hits.size:
            solutions.append(lookup[hits] ^ left_lookup[gray] ^ np.uint64(fixed))
    top = np.sort(np.concatenate(solutions)) if solutions else np.empty(0, dtype=np.uint64)
    assert len(top) == len(np.unique(top))
    for value in top[::max(1, len(top) // 128)]:
        assert evaluate(polys, int(value)) == 0
    args.output.mkdir(parents=True, exist_ok=True)
    np.save(args.output / "tops.npy", top, allow_pickle=False)
    report = {
        "shard": args.shard, "shard_bits": args.shard_bits,
        "complete": limit == 1 << nu,
        "candidates_checked": limit << nw, "solution_count": len(top),
        "quartic_orbit_masks": TOP_REPS, "linear_rank": len(equations),
        "linear_certificates": [
            {"row_mask": row, "multipliers": list(active_bits(reason))}
            for row, reason in certs.values()
        ],
        "seconds": round(perf_counter() - started, 3),
    }
    (args.output / "top-report.json").write_text(json.dumps(report, indent=2) + "\n")
    print({k: report[k] for k in ("complete", "candidates_checked",
                                  "solution_count", "seconds")}, flush=True)


if __name__ == "__main__":
    main()
