"""Check the homogeneous quartic slice of the complete n=12 bent catalog."""
import argparse
import csv
import json
import struct
import zlib
from functools import lru_cache, reduce
from operator import xor
from pathlib import Path

from higher_filter import subsets, xor_terms
from quartic_catalog import LOW, linear_generators
from top_filters import N, SIZE, TOP
from top_quotient import action, quartic_map, transform_tables


def inverse_permutation(rows):
    inverse = [None] * SIZE
    for x in range(SIZE):
        y = sum(((x & row).bit_count() % 2) << i for i, row in enumerate(rows))
        assert inverse[y] is None
        inverse[y] = x
    return inverse


def verify(catalog):
    rows = linear_generators()
    generators = [transform_tables(quartic_map(r)) for r in rows]
    inverses = [inverse_permutation(r) for r in rows]
    identity = tuple(1 << i for i in range(N))
    value_rows = [
        sum((sum(x & m == m for m in orbit) % 2) << i
            for i, (_, orbit) in enumerate(TOP))
        for x in range(SIZE)
    ]
    evaluation_points = [tuple(subsets(s)) for s, _ in LOW + TOP]

    @lru_cache(maxsize=2048)
    def pullback_rows(columns):
        return tuple(
            reduce(xor, (value_rows[xor_terms(columns, x)] for x in points), 0)
            for points in evaluation_points
        )

    def pullback(top, columns):
        return sum(((row & top).bit_count() % 2) << i
                   for i, row in enumerate(pullback_rows(columns)))

    reps = normalized = 0
    seen = set()
    homogeneous = []
    with (
        (catalog / "catalog-index.tsv").open(newline="") as index,
        (catalog / "catalog.bin").open("rb") as binary,
    ):
        for entry in csv.DictReader(index, delimiter="\t"):
            rep, orbit_size, count, offset, length = (
                int(entry[k]) for k in ("top", "orbit_size", "count", "offset", "length"))
            if not rep or not count:
                continue
            reps += 1
            normalized += orbit_size * count
            binary.seek(offset)
            data = zlib.decompress(binary.read(length))
            codes = set(struct.unpack(f"<{count}I", data))
            assert len(codes) == count

            orbit = {rep: identity}
            queue = [rep]
            for top in queue:
                inverse = orbit[top]
                assert top not in seen
                seen.add(top)
                code = pullback(top, inverse)
                lower = code & ((1 << len(LOW)) - 1)
                assert code >> len(LOW) == rep
                if lower in codes:
                    homogeneous.append(top)
                for generator, inverse_table in zip(generators, inverses):
                    target = action(generator, top)
                    if target not in orbit:
                        orbit[target] = tuple(inverse_table[x] for x in inverse)
                        queue.append(target)
            assert len(orbit) == orbit_size
    assert (reps, len(seen), normalized) == (2564, 67647, 77305344)
    return {
        "nonempty_quartic_orbits": reps,
        "quartic_tops_with_bent_completions": len(seen),
        "normalized_bent_quartics": normalized,
        "homogeneous_quartic_bent_tops": homogeneous,
    }


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("catalog", type=Path)
    args = parser.parse_args()
    print(json.dumps(verify(args.catalog), indent=2))
