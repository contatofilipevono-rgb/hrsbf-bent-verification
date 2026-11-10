"""Count all RS bent functions with the antipodal diagonal as an M-subspace."""

import argparse
import csv
import json
import struct
import zlib
from collections import Counter
from itertools import permutations
from math import prod
from pathlib import Path
from random import Random

from higher_filter import N, SIZE, direct_walsh, evaluate_orbit, orbits, pack, shift, xor_terms


def eligible(origin, target, phase):
    pairs = [(z, target[(j + phase) % len(target)]) for j, z in enumerate(origin)]
    if sum((x >> 5) & (y >> 5) & 1 for x, y in pairs) % 2:
        return None
    # The six degree-five coefficients of the first coordinate of pi.
    return sum((sum((y & 1) for x, y in pairs if not x & (1 << j)) % 2) << j
               for j in range(6))


def assignment_dp(table):
    # Each entry is a list of XOR contributions, one per eligible phase.
    states = {0: {0: 1}}
    for row in table:
        nxt = {}
        for used, counts in states.items():
            for j, phases in enumerate(row):
                if used & (1 << j) or not phases:
                    continue
                merged = nxt.setdefault(used | (1 << j), Counter())
                for s, multiplicity in counts.items():
                    for phase in phases:
                        merged[s ^ phase] += multiplicity
        states = nxt
    return states[(1 << len(table)) - 1]


def xor_convolve(a, b):
    result = Counter()
    for u, n in a.items():
        for v, m in b.items():
            result[u ^ v] += n * m
    return result


def signed_permanent(matrix):
    # Ryser's inclusion-exclusion, independent of the assignment DP.
    n = len(matrix)
    sums = [0] * n
    old = 0
    total = 0
    for step in range(1, 1 << n):
        gray = step ^ (step >> 1)
        changed = old ^ gray
        j = changed.bit_length() - 1
        sign = 1 if gray & changed else -1
        for i in range(n):
            sums[i] += sign * matrix[i][j]
        total += (-1) ** (n - gray.bit_count()) * prod(sums)
        old = gray
    return total


def construct_sample(blocks, rng):
    pi = [-1] * 64
    h = [-1] * 64
    for block in blocks.values():
        while True:
            order = rng.sample(range(len(block)), len(block))
            allowed = [[r for r in range(len(a)) if eligible(a, block[j], r) is not None]
                       for a, j in zip(block, order)]
            if all(allowed):
                break
        for a, j, phases in zip(block, order, allowed):
            r = rng.choice(phases)
            b = block[j]
            next_h = rng.randrange(2)
            initial = next_h
            for k, z in enumerate(a):
                pi[z] = b[(k + r) % len(b)]
                h[z] = next_h
                next_h ^= (z >> 5) & (pi[z] >> 5) & 1
            assert next_h == initial
    assert sorted(pi) == list(range(64)) and all(a in (0, 1) for a in h)
    return pi, h


def count_all():
    blocks = {}
    for rep, orbit in orbits(6):
        ordered = tuple(shift(rep, j, 6) for j in range(len(orbit)))
        assert set(ordered) == orbit
        blocks.setdefault(len(orbit), []).append(ordered)
    assert {l: len(b) for l, b in blocks.items()} == {1: 2, 2: 1, 3: 2, 6: 9}
    spectra = []
    phase_tables = []
    block_totals = {}
    for length, block in sorted(blocks.items()):
        table = [[[s for r in range(length) if (s := eligible(a, b, r)) is not None]
                  for b in block] for a in block]
        dp = assignment_dp(table)
        phase_tables.append(table)
        block_totals[length] = sum(dp.values())
        # Independent permanent with multiplicities, ignoring the degree test.
        reference = sum(prod(len(table[i][j]) for i, j in enumerate(p))
                        for p in permutations(range(len(block))))
        assert reference == block_totals[length]
        spectra.append(dp)
    spectrum = Counter({0: 1})
    for s in spectra:
        spectrum = xor_convolve(spectrum, s)
    assert sum(spectrum.values()) == prod(block_totals.values())
    zero_replay = 0
    for character in range(64):
        product = 1
        for table in phase_tables:
            matrix = [[sum(1 - 2 * ((character & phase).bit_count() % 2)
                           for phase in phases) for phases in row] for row in table]
            product *= signed_permanent(matrix)
        zero_replay += product
    assert zero_replay == 64 * spectrum[0]

    rng = Random(126)
    for _ in range(12):
        pi, h = construct_sample(blocks, rng)
        def f(x):
            w = x >> 6
            z = (x & 63) ^ w
            return ((w & pi[z]).bit_count() % 2) ^ h[z]
        assert all(f(x) == f(shift(x, 1)) for x in range(SIZE))
        assert direct_walsh(pack(f))

    return {
        "orbit_lengths": {l: len(b) for l, b in blocks.items()},
        "eligible_permutations_by_block": block_totals,
        "eligible_permutations": sum(spectrum.values()),
        "eligible_permutations_degree_at_most_4": spectrum[0],
        "all_bent": sum(spectrum.values()) << 14,
        "bent_degree_at_most_5": spectrum[0] << 13,
    }


def affine_deviation(table):
    result = 0
    for z in range(64):
        base = (table >> z) & 1
        linear = sum((((table >> ((z ^ (1 << i)) | (1 << (i + 6)))) & 1) ^ base) << i
                     for i in range(6))
        for w in range(64):
            actual = (table >> ((z ^ w) | (w << 6))) & 1
            bit = actual ^ base ^ ((linear & w).bit_count() % 2)
            result |= bit << (64 * z + w)
    return result


def xor_table(columns):
    out = [0]
    for a in columns:
        out.extend([x ^ a for x in out])
    return out


def count_catalog(directory):
    lower = [affine_deviation(evaluate_orbit(o)) for d in (2, 3) for _, o in orbits(N, d)]
    high = [affine_deviation(evaluate_orbit(o)) for _, o in orbits(N, 4)]
    assert lower[5] == 0
    a, b = xor_table(lower[:12]), xor_table(lower[12:])
    all_counts = Counter()
    with (directory / "catalog-index.tsv").open(newline="") as index, (
            directory / "catalog.bin").open("rb") as data:
        for row in csv.DictReader(index, delimiter="\t"):
            top, size, count = [int(row[k]) for k in ("top", "orbit_size", "count")]
            if not count:
                continue
            data.seek(int(row["offset"]))
            raw = zlib.decompress(data.read(int(row["length"])))
            codes = struct.unpack(f"<{count}I", raw)
            fixed = xor_terms(high, top)
            for c in codes:
                if a[c & 4095] ^ b[c >> 12] == fixed:
                    degree = 4 if top else (3 if c >> 6 else 2)
                    all_counts[degree] += 4 * size
    assert all_counts[2] == 64
    return dict(sorted(all_counts.items()))


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("catalog", type=Path)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    result = count_all()
    counts = count_catalog(args.catalog)
    counts[5] = result["bent_degree_at_most_5"] - sum(counts.values())
    counts[6] = result["all_bent"] - result["bent_degree_at_most_5"]
    assert all(n > 0 for n in counts.values())
    result["by_exact_degree"] = counts
    args.output.write_text(json.dumps(result, indent=2) + "\n")
    print(json.dumps(result, indent=2))


if __name__ == "__main__":
    main()
