"""Prepare the exact degree-four RS model affine along a fixed V."""
import argparse
import json
import struct
from pathlib import Path

from count_near_antipodal import all_points, image_and_kernel
from higher_filter import evaluate_orbit, orbits, xor_terms
from higher_project import LOW, TOP
from mobius_rule import integer_anf
from probe_dim4 import complementary, spaces


def model(space):
    basis = spaces[space - 1]
    w_points = all_points(complementary(basis) + basis)
    coordinates = [(z ^ w) | (w << 6) for w in w_points for z in range(64)]
    forbidden_mask = sum(1 << m for m in range(4096) if (m >> 8).bit_count() >= 2)
    truth = []
    forbidden = []
    original_orbits = (*orbits(12, 0), *orbits(12, 1), *LOW, *TOP)
    top_offset = len(original_orbits) - len(TOP)
    for i, (_, orbit) in enumerate(original_orbits):
        original = evaluate_orbit(orbit)
        moved = sum(((original >> x) & 1) << j for j, x in enumerate(coordinates))
        truth.append(moved)
        anf = integer_anf(moved)
        row = sum((c & 1) << m for m, c in enumerate(anf)) & forbidden_mask
        # The two universal quartic relations are necessary for bentness.
        top_index = i - top_offset
        if top_index >= 0:
            row |= int(top_index in (0, 4, 7, 9, 22, 27, 29, 37)) << 4096
            row |= int(top_index in (1, 3, 5, 8, 24, 28, 34, 36)) << 4097
        forbidden.append(row)
    _, affine = image_and_kernel(forbidden)
    assert len(affine) == 52
    moved = [xor_terms(truth, code) for code in affine]
    mask = (1 << 256) - 1
    phase = [f & mask for f in moved]
    maps = []
    for f in moved:
        differences = [((f >> (256 << i)) & mask) ^ (f & mask) for i in range(4)]
        maps.append(sum(sum((d >> x & 1) << j for j, d in enumerate(differences)) << (4 * x)
                        for x in range(256)))
    image, kernel = image_and_kernel(maps)
    assert (len(image), len(kernel)) == ((33, 19) if space == 1 else (31, 21))
    return (basis, coordinates,
            [(p, xor_terms(phase, code)) for p, code in image],
            [xor_terms(phase, code) for code in kernel])


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--space", type=int, choices=(1, 2), required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    basis, _, maps, phases = model(args.space)
    with args.output.open("wb") as target:
        target.write(b"DIM4V01\0")
        target.write(struct.pack("<III", args.space, len(maps), len(phases)))
        for phase in phases:
            target.write(phase.to_bytes(32, "little"))
        for mapping, phase in maps:
            target.write(mapping.to_bytes(128, "little"))
            target.write(phase.to_bytes(32, "little"))
    report = {"space": args.space, "basis": basis, "RS_dimension": len(maps) + len(phases),
              "map_dimension": len(maps), "phase_dimension": len(phases)}
    args.output.with_suffix(".json").write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
    print(report)


if __name__ == "__main__":
    main()
