"""Prepare a branch plan after the cubic product obstruction."""
import argparse
import json
import struct
from pathlib import Path

from count_near_antipodal import image_and_kernel
from higher_filter import xor_terms
from lower_dim_cubic_filter import filter_cubic_basis, survivor_indices
from lower_dim_model import build, cubic


BASES = ((9, 18, 36), (27, 54), (21, 42), (63,))


def plan(basis):
    model = build(basis)
    cubics = [cubic(p, len(basis)) for p, _ in model.maps]
    image, null = image_and_kernel(cubics)
    linear, cross = filter_cubic_basis([p for p, _ in image], len(basis), model.nbase)
    directions = [code for _, code in image]
    survivors = [xor_terms(directions, i) for i in survivor_indices(linear, cross)]
    return model, null, survivors


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--space", type=int, choices=range(1, len(BASES) + 1), required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    model, null, survivors = plan(BASES[args.space - 1])
    r = len(model.basis)
    size = 1 << model.nbase
    with args.output.open("wb") as out:
        out.write(b"FIBR345\0")
        out.write(struct.pack("<7I", args.space, r, len(model.maps), len(model.phases),
                              len(null), len(survivors), size))
        for mapping, phase in model.maps:
            out.write(mapping.to_bytes(r * size // 8, "little"))
            out.write(phase.to_bytes(size // 8, "little"))
        for phase in model.phases:
            out.write(phase.to_bytes(size // 8, "little"))
        for code in null + survivors:
            out.write(struct.pack("<Q", code))
    report = {"space": args.space, "basis": model.basis, "map_dimension": len(model.maps),
              "phase_dimension": len(model.phases), "cubic_branches": len(survivors),
              "maps_per_branch": 1 << len(null)}
    args.output.with_suffix(".json").write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
    print(report)


if __name__ == "__main__":
    main()
