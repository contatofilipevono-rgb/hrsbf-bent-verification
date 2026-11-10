"""Quotient the exact quartic-top pool by rotation-preserving linear changes."""

import argparse
import json
from collections import Counter
from pathlib import Path
from time import perf_counter

import numpy as np

from top_filters import (N, FULL, TOP, TOP_REPS, INDEX, active_bits, rot,
                         filter_polys, evaluate)


def compose(a, b):
    result = 0
    for j in active_bits(b):
        result ^= rot(a, j)
    return result


def poly_remainder(a, divisor):
    while a.bit_length() >= divisor.bit_length():
        a ^= divisor << (a.bit_length() - divisor.bit_length())
    return a


def unit_generators():
    # z^12+1=(z+1)^4(z^2+z+1)^4 over F_2.
    units = {a for a in range(1, 1 << N)
             if a.bit_count() % 2 and poly_remainder(a, 7)}
    assert len(units) == 1536
    seen = {1}
    generators = [2]  # the rotation acts trivially on invariant quartics
    for a in [2] + sorted(units, key=lambda x: (x.bit_count(), x)):
        if a in seen:
            continue
        if a != 2:
            generators.append(a)
        original = seen
        seen = set(original)
        power = a
        while power not in original:
            seen.update(compose(b, power) for b in original)
            power = compose(power, a)
    assert seen == units
    return generators[1:]


def quartic_map(rows):
    cache = {0: {0}}

    def expand(m):
        if m in cache:
            return cache[m]
        i = (m & -m).bit_length() - 1
        rest = expand(m ^ (1 << i))
        out = set()
        for v in rest:
            for j in active_bits(rows[i] & ~v):
                out.symmetric_difference_update((v | (1 << j),))
        cache[m] = out
        return out

    columns = []
    for _, orbit in TOP:
        out = set()
        for m in orbit:
            out.symmetric_difference_update(expand(m))
        active = {INDEX[m] for m in out}
        assert len(out) == sum(len(TOP[j][1]) for j in active)
        columns.append(sum(1 << j for j in active))
    return columns


def transform_tables(columns):
    tables = []
    for i in range(0, len(columns), 8):
        t = [0]
        for col in columns[i:i + 8]:
            t.extend([col ^ v for v in t])
        if len(t) < 256:
            t.extend([0] * (256 - len(t)))
        tables.append(t)
    return tables


def action(tables, v):
    return (tables[0][v & 255] ^ tables[1][(v >> 8) & 255]
            ^ tables[2][(v >> 16) & 255] ^ tables[3][(v >> 24) & 255]
            ^ tables[4][(v >> 32) & 255] ^ tables[5][v >> 40])


def gather(directory):
    results = sorted(directory.glob("*/top-report.json"))
    arrays = []
    seen = set()
    for file in results:
        report = json.loads(file.read_text())
        assert report["complete"]
        assert tuple(report["quartic_orbit_masks"]) == TOP_REPS
        assert report["shard_bits"] == 4 and report["linear_rank"] == 3
        assert report["candidates_checked"] == 1 << 36
        assert report["shard"] not in seen
        seen.add(report["shard"])
        values = np.load(file.parent / "tops.npy", allow_pickle=False)
        assert report["solution_count"] == len(values)
        arrays.append(values)
    assert seen == set(range(16))
    top = sorted(int(a) for a in np.concatenate(arrays))
    assert len(top) == len(set(top)) and top[0] == 0
    return top


def independent_coordinate_check(columns, rows, polys):
    # Check the highest degree after evaluating the complete transformed function.
    for i in (0, 1, 8, 21, 42):
        orbit = TOP[i][1]
        actual = 0
        for j, support in enumerate(TOP_REPS):
            v = support
            coefficient = 0
            while True:
                x = sum(((v & row).bit_count() % 2) << k
                        for k, row in enumerate(rows))
                coefficient ^= sum(x & m == m for m in orbit) % 2
                if v == 0:
                    break
                v = (v - 1) & support
            actual |= coefficient << j
        assert actual == columns[i]
    sample = [0, 1, 57, 10003, (1 << 43) - 1]
    for v in sample:
        image = action(transform_tables(columns), v)
        assert bool(evaluate(polys, v)) == bool(evaluate(polys, image))


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--shards", type=Path)
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    started = perf_counter()
    generators = unit_generators()
    rows_list = [[rot(g, i) for i in range(N)] for g in generators]
    # Multiplication of indices by units normalizes the rotation group.
    rows_list += [[1 << ((a * i) % N) for i in range(N)] for a in (5, 7)]
    polys = filter_polys()
    operators = []
    for rows in rows_list:
        columns = quartic_map(rows)
        independent_coordinate_check(columns, rows, polys)
        operators.append(transform_tables(columns))
    print("circulant generators", generators, "plus index multipliers 5 and 7")
    if args.shards is None:
        return
    top = gather(args.shards)
    uncovered = set(top)
    representative = []
    for root in top:
        if root not in uncovered:
            continue
        queue = [root]
        orbit = {root}
        for v in queue:
            for op in operators:
                w = action(op, v)
                if w in orbit:
                    continue
                assert w in uncovered, (root, v, w)
                orbit.add(w)
                queue.append(w)
        assert 512 % len(orbit) == 0
        uncovered.difference_update(orbit)
        representative.append((root, len(orbit)))
    assert not uncovered and sum(s for _, s in representative) == len(top)
    args.output.mkdir(parents=True, exist_ok=True)
    (args.output / "representatives.tsv").write_text(
        "".join(f"{v}\t{s}\n" for v, s in representative))
    report = {
        "top_count_including_zero": len(top),
        "representative_count_including_zero": len(representative),
        "orbit_size_distribution": dict(sorted(Counter(
            s for _, s in representative).items())),
        "circulant_generators": generators, "index_multipliers": [5, 7],
        "seconds": round(perf_counter() - started, 3),
    }
    (args.output / "quotient-report.json").write_text(json.dumps(report, indent=2) + "\n")
    print(report)


if __name__ == "__main__":
    main()
