"""Enumerate balanced maps whose fibres have indicator degree at most five."""
import argparse
import json
import struct
from pathlib import Path
from time import perf_counter

from higher_filter import xor_terms
from lower_dim_model import anf
from lower_dim_plan import BASES, plan


def fibre_masks(packed, size, r):
    mask = (1 << size) - 1
    fibres = [mask]
    for i in range(r):
        coordinate = (packed >> (i * size)) & mask
        fibres = [fibre & (mask ^ coordinate) for fibre in fibres] + [
            fibre & coordinate for fibre in fibres]
    return fibres


def balanced(packed, size, r):
    mask = (1 << size) - 1
    target = size // 2
    parts = [(packed >> (i * size)) & mask for i in range(r)]
    if any(part.bit_count() != target for part in parts):
        return False, 0
    if r == 1:
        return True, 0
    target //= 2
    if (parts[0] & parts[1]).bit_count() != target:
        return False, 0
    if r == 2:
        return True, 0
    if any((parts[i] & parts[2]).bit_count() != target for i in range(2)):
        return False, 0
    product = parts[0] & parts[1] & parts[2]
    return product.bit_count() == target // 2, product


def coordinates_in_gray_order(directions):
    for ordinal in range(1, 1 << len(directions)):
        yield (ordinal & -ordinal).bit_length() - 1


def run(space, shard, shards, output):
    start = perf_counter()
    model, null, branches = plan(BASES[space - 1])
    width = model.nbase
    size = 1 << width
    r = len(model.basis)
    values = [p for p, _ in model.maps]
    low = [xor_terms(values, code) for code in null]
    toggles = [(null[i], low[i]) for i in coordinates_in_gray_order(null)]
    high_mask = sum(1 << m for m in range(size) if m.bit_count() >= 6)
    first = len(branches) * shard // shards
    last = len(branches) * (shard + 1) // shards
    tested = 0
    balanced_maps = 0
    supports = 0
    with output.with_suffix(".bin").open("wb") as target:
        for root in branches[first:last]:
            code = root
            packed = xor_terms(values, code)
            for ordinal in range(1 << len(null)):
                if ordinal:
                    direction, delta = toggles[ordinal - 1]
                    code ^= direction
                    packed ^= delta
                tested += 1
                ok, product = balanced(packed, size, r)
                if not ok:
                    continue
                balanced_maps += 1
                if product and anf(product, width) & high_mask:
                    continue
                supports += 1
                target.write(struct.pack("<Q", code))
    report = {"space": space, "basis": model.basis, "shard": shard, "shards": shards,
              "branch_start": first, "branch_stop": last, "branches": len(branches),
              "tested": tested, "balanced": balanced_maps, "support_degree_at_most_five": supports,
              "seconds": perf_counter() - start}
    output.write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
    print(report)
    return report


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--space", type=int, choices=range(1, len(BASES) + 1), required=True)
    parser.add_argument("--shard", type=int, default=0)
    parser.add_argument("--shards", type=int, default=1)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    if not 0 <= args.shard < args.shards:
        parser.error("invalid shard")
    run(args.space, args.shard, args.shards, args.output)


if __name__ == "__main__":
    main()
