"""Pack and query the complete degree-at-most-four RS bent catalog."""

import argparse
import csv
import heapq
import json
import struct
import zlib
from collections import Counter
from itertools import groupby
from pathlib import Path

from top_filters import (N, SIZE, TOP, active_bits, evaluate, filter_polys,
                         masks_of_size, orbits, rot)
from top_quotient import action, quartic_map, transform_tables, unit_generators

LOW = tuple(orbits(masks_of_size(2))) + tuple(orbits(masks_of_size(3)))


def ordered_hits(path):
    with path.open() as file:
        last = -1
        for line in file:
            top, low = map(int, line.split())
            assert top >= last and 0 <= low < 1 << 25
            last = top
            yield top, low


def pack(shards, representatives, output):
    reps = [tuple(map(int, line.split())) for line in representatives.read_text().splitlines()]
    data = sorted(shards.glob("**/bent.tsv"))
    assert len(data) == 64
    grouped = iter(groupby(heapq.merge(*(ordered_hits(p) for p in data), key=lambda a: a[0]),
                           key=lambda a: a[0]))
    item = next(grouped, None)
    output.mkdir(parents=True, exist_ok=True)
    hits = 0
    weighted = Counter()
    with (output / "catalog.bin").open("wb") as binary, (output / "catalog-index.tsv").open(
            "w", newline="") as index:
        out = csv.writer(index, delimiter="\t", lineterminator="\n")
        out.writerow(("top", "orbit_size", "count", "offset", "length"))
        for top, orbit_size in reps:
            assert item is None or item[0] >= top
            values = []
            if item is not None and item[0] == top:
                values = sorted(low for _, low in item[1])
                assert len(values) == len(set(values))
                item = next(grouped, None)
            encoded = zlib.compress(struct.pack(f"<{len(values)}I", *values)) if values else b""
            out.writerow((top, orbit_size, len(values), binary.tell(), len(encoded)))
            binary.write(encoded)
            hits += len(values)
            if top:
                weighted[4] += orbit_size * len(values)
            else:
                for c in values:
                    weighted[3 if c >> 6 else 2] += 1
    assert item is None
    print(json.dumps({"records": hits, "normalized_by_degree": weighted}, indent=2))


def linear_generators():
    rows = [[rot(g, i) for i in range(N)] for g in unit_generators()]
    return rows + [[1 << ((a * i) % N) for i in range(N)] for a in (5, 7)]


def orbit_tree(start, ops):
    todo = [start]
    parent = {start: None}
    for top in todo:
        for i, op in enumerate(ops):
            v = action(op, top)
            if v not in parent:
                parent[v] = (top, i)
                todo.append(v)
    return parent


def indices_after(path, rows):
    relabel = list(range(SIZE))
    for op in path:
        forward = [sum(((x & row).bit_count() % 2) << k for k, row in enumerate(rows[op]))
                   for x in range(SIZE)]
        relabel = [relabel[x] for x in forward]
    return relabel


def lower_columns(points):
    columns = []
    for _, supports in LOW + TOP:
        column = 0
        for i, (m, _) in enumerate(LOW):
            coefficient = 0
            x = m
            while True:
                a = points[x]
                coefficient ^= sum(a & u == u for u in supports) % 2
                if x == 0:
                    break
                x = (x - 1) & m
            column |= coefficient << i
        columns.append(column)
    return columns


def lookup(directory, top):
    assert 0 <= top < 1 << len(TOP)
    if evaluate(filter_polys(), top):
        return []
    rows = linear_generators()
    ops = [transform_tables(quartic_map(r)) for r in rows]
    rep = min(orbit_tree(top, ops))
    with (directory / "catalog-index.tsv").open(newline="") as f:
        index = csv.DictReader(f, delimiter="\t")
        row = next(r for r in index if int(r["top"]) == rep)
    count = int(row["count"])
    if not count:
        return []
    with (directory / "catalog.bin").open("rb") as f:
        f.seek(int(row["offset"]))
        data = zlib.decompress(f.read(int(row["length"])))
    codes = struct.unpack(f"<{count}I", data)
    assert len(codes) == count
    if rep == top:
        return list(codes)

    tree = orbit_tree(rep, ops)
    assert len(tree) == int(row["orbit_size"])
    path = []
    target = top
    while target != rep:
        target, op = tree[target]
        path.append(op)
    columns = lower_columns(indices_after(path[::-1], rows))

    def normalize(low):
        result = 0
        for i in active_bits((rep << len(LOW)) | low):
            result ^= columns[i]
        return result

    result = sorted(normalize(low) for low in codes)
    assert len(result) == len(set(result))
    return result


def main():
    parser = argparse.ArgumentParser()
    sub = parser.add_subparsers(dest="command", required=True)
    p = sub.add_parser("pack")
    p.add_argument("shards", type=Path)
    p.add_argument("representatives", type=Path)
    p.add_argument("output", type=Path)
    q = sub.add_parser("query")
    q.add_argument("directory", type=Path)
    q.add_argument("top", type=lambda s: int(s, 0))
    args = parser.parse_args()
    if args.command == "pack":
        pack(args.shards, args.representatives, args.output)
    else:
        for low in lookup(args.directory, args.top):
            print(low)


if __name__ == "__main__":
    main()
