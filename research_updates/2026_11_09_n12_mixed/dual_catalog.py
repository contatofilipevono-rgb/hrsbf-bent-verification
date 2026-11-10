"""Recheck the catalog by batched FWHT and count dual degrees."""

import argparse
import csv
import json
import struct
import zlib
from collections import Counter
from pathlib import Path
from time import perf_counter

import numpy as np

from antipodal_mm import affine_deviation, xor_table
from higher_filter import evaluate_orbit, xor_terms
from top_filters import N, SIZE, TOP, active_bits, masks_of_size, orbits

LOW = tuple(orbits(masks_of_size(2))) + tuple(orbits(masks_of_size(3)))


def pack_basis(orbits_, points):
    rows = []
    for _, orbit in orbits_:
        truth = np.zeros(SIZE, dtype=bool)
        for m in orbit:
            truth ^= (points & m) == m
        rows.append(np.packbits(truth, bitorder="little").view(np.uint64))
    return rows


def packed_subsets(columns):
    table = np.zeros((1, SIZE // 64), dtype=np.uint64)
    for row in columns:
        table = np.concatenate((table, table ^ row), axis=0)
    return table


def degree_and_check(batch, degree_positions):
    signs = 1 - 2 * np.unpackbits(batch.view(np.uint8), axis=1,
                                  bitorder="little").astype(np.int16)
    for j in range(N):
        view = signs.reshape(len(signs), -1, 2, 1 << j)
        a = view[:, :, 0, :].copy()
        b = view[:, :, 1, :]
        view[:, :, 0, :] = a + b
        view[:, :, 1, :] = a - b
    assert np.all((signs == 64) | (signs == -64))
    dual = signs < 0
    for j in range(N):
        view = dual.reshape(len(dual), -1, 2, 1 << j)
        view[:, :, 1, :] ^= view[:, :, 0, :]
    assert not np.any(dual[:, degree_positions[7]])
    degree = np.zeros(len(dual), dtype=np.uint8)
    for d in range(2, 7):
        degree[np.any(dual[:, degree_positions[d]], axis=1)] = d
    assert np.all(degree >= 2)
    return degree


def main():
    p = argparse.ArgumentParser()
    p.add_argument("catalog", type=Path)
    p.add_argument("shard", type=int)
    p.add_argument("shards", type=int)
    p.add_argument("output", type=Path)
    p.add_argument("--limit", type=int)
    a = p.parse_args()
    assert 0 <= a.shard < a.shards
    t0 = perf_counter()
    points = np.arange(SIZE)
    low = pack_basis(LOW, points)
    upper = pack_basis(TOP, points)
    left, right = packed_subsets(low[:12]), packed_subsets(low[12:])
    s_low = [affine_deviation(evaluate_orbit(o)) for _, o in LOW]
    s_high = [affine_deviation(evaluate_orbit(o)) for _, o in TOP]
    ls, rs = xor_table(s_low[:12]), xor_table(s_low[12:])
    degree_positions = {d: list(masks_of_size(d)) for d in range(2, 7)}
    degree_positions[7] = [m for d in range(7, 13) for m in masks_of_size(d)]
    totals = Counter()
    outside = Counter()
    witnesses = {}
    weighted_counts = Counter()
    read = 0
    seen = 0
    with (a.catalog / "catalog-index.tsv").open(newline="") as idx, (
            a.catalog / "catalog.bin").open("rb") as data:
        for line, row in enumerate(csv.DictReader(idx, delimiter="\t")):
            if line % a.shards != a.shard:
                continue
            top, size, count = [int(row[k]) for k in ("top", "orbit_size", "count")]
            if a.limit is not None and seen >= a.limit:
                break
            seen += 1
            if not count:
                continue
            data.seek(int(row["offset"]))
            raw = zlib.decompress(data.read(int(row["length"])))
            codes = np.frombuffer(raw, dtype="<u4")
            assert len(codes) == count and np.all(codes < 1 << 25)
            tp = np.zeros(SIZE // 64, dtype=np.uint64)
            for i in active_bits(top):
                tp ^= upper[i]
            sigma = xor_terms(s_high, top)
            for start in range(0, count, 512):
                c = codes[start:start + 512]
                block = left[c & 4095] ^ right[c >> 12] ^ tp
                dual_degree = degree_and_check(block, degree_positions)
                source_degree = np.full(len(c), 4, dtype=np.uint8) if top else np.where(c >> 6, 3, 2)
                inside = np.array([ls[int(v) & 4095] ^ rs[int(v) >> 12] == sigma for v in c])
                for i in range(len(c)):
                    d, e = int(source_degree[i]), int(dual_degree[i])
                    totals[d, e] += 4 * size
                    if not inside[i]:
                        outside[d, e] += 4 * size
                        if e >= 5 and e not in witnesses:
                            witnesses[e] = [top, int(c[i])]
                    weighted_counts[d] += 4 * size
                read += len(c)
    result = {
        "shard": a.shard, "shards": a.shards, "complete": a.limit is None,
        "index_rows": seen, "normalized_records_verified": read,
        "weighted_total_by_source_degree": dict(weighted_counts),
        "dual_degree_counts": {f"{d},{e}": v for (d, e), v in sorted(totals.items())},
        "outside_diagonal_counts": {f"{d},{e}": v for (d, e), v in sorted(outside.items())},
        "outside_diagonal_witnesses_by_dual_degree": witnesses,
        "seconds": round(perf_counter() - t0, 3),
    }
    a.output.write_text(json.dumps(result, indent=2) + "\n")
    print(json.dumps(result, indent=2))


if __name__ == "__main__":
    main()
