"""Reduce exact support candidates by coordinate symmetries preserving rotation."""
import argparse
import json
import struct
from collections import Counter
from pathlib import Path
from time import perf_counter

from analyse_near_antipodal_phases import ambient_generators
from count_near_antipodal import all_points, image_and_kernel
from higher_filter import xor_terms
from lower_dim_model import build
from lower_dim_plan import BASES
from outside_polar_profiles import cyclic_subspaces


def code_actions(model):
    r = len(model.basis)
    size = 1 << model.nbase
    mask = size - 1
    inverse = {x: i for i, x in enumerate(model.coordinates)}
    image, null = image_and_kernel([p for p, _ in model.maps])
    assert not null
    echelon = sorted(image, reverse=True)
    generators = ambient_generators()
    generators.append(("multiplier_5", lambda x: sum((x >> i & 1) << ((5 * i) % 12)
                                                     for i in range(12))))
    spaces = cyclic_subspaces()
    for name, transform in generators:
        origin = transform(0)
        for basis in spaces:
            span = set(all_points(basis))
            for v in basis:
                w = transform(v | (v << 6)) ^ origin
                assert w >> 6 == (w & 63) and (w & 63) in span
        moved_base = [inverse[transform(x)] & mask for x in model.coordinates[:size]]
        moved_v = [inverse[transform(v | (v << 6)) ^ origin] >> model.nbase for v in model.basis]
        assert all(not (inverse[transform(v | (v << 6)) ^ origin] & mask) for v in model.basis)
        output = []
        for mapping, _ in model.maps:
            pieces = []
            for i in range(r):
                table = mapping >> (i * size)
                pieces.append(sum((table >> y & 1) << x for x, y in enumerate(moved_base)))
            value = sum(xor_terms(pieces, code) << (size * i) for i, code in enumerate(moved_v))
            code = 0
            for row, witness in echelon:
                if value >> (row.bit_length() - 1) & 1:
                    value ^= row
                    code ^= witness
            assert not value
            output.append(code)
        if any(code != 1 << i for i, code in enumerate(output)):
            yield name, output


def block_lookup(columns):
    tables = []
    for start in range(0, len(columns), 8):
        block = columns[start:start + 8]
        tables.append(all_points(block))
    return tables


def apply(tables, code):
    result = 0
    for block in tables:
        result ^= block[code & 255]
        code >>= 8
    return result


def classify(space, paths, output):
    start = perf_counter()
    model = build(BASES[space - 1])
    actions = [(name, block_lookup(columns)) for name, columns in code_actions(model)]
    unseen = set()
    for path in paths:
        raw = path.read_bytes()
        for code, in struct.iter_unpack("<Q", raw):
            assert code not in unseen
            unseen.add(code)
    all_maps = len(unseen)
    sizes = Counter()
    with output.with_suffix(".bin").open("wb") as support, output.with_suffix(".weights.bin").open("wb") as weights:
        # Sorted roots make the branch plan reproducible across processes.
        for root in sorted(unseen):
            if root not in unseen:
                continue
            seen = {root}
            pending = [root]
            while pending:
                code = pending.pop()
                for _, action in actions:
                    moved = apply(action, code)
                    if moved in seen:
                        continue
                    assert moved in unseen, (space, root, code, moved)
                    seen.add(moved)
                    pending.append(moved)
            unseen.difference_update(seen)
            size = len(seen)
            sizes[size] += 1
            support.write(struct.pack("<Q", root))
            weights.write(struct.pack("<QQ", root, size))
    assert not unseen and sum(size * n for size, n in sizes.items()) == all_maps
    result = {"space": space, "maps": all_maps, "orbits": sizes.total(),
              "orbit_sizes": dict(sorted(sizes.items())), "generators": [name for name, _ in actions],
              "seconds": perf_counter() - start}
    output.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    print(result)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--space", type=int, choices=range(1, len(BASES) + 1), required=True)
    parser.add_argument("--supports", type=Path, nargs="+", required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    classify(args.space, args.supports, args.output)


if __name__ == "__main__":
    main()
