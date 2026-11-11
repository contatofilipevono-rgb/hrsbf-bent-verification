"""Independently check the hypotheses in Fable's fixed-slice V3 argument."""
import argparse
import json
from itertools import product
from pathlib import Path

from higher_filter import xor_terms
from lower_dim_model import build
from lower_dim_v3_q_classify import decompose
from lower_dim_v3_symbolic import read_tasks


def rotate(z):
    return ((z << 1) | (z >> 5)) & 63


def audit(artifacts):
    model = build((9, 18, 36))
    tables = [p for p, _ in model.maps]
    base_functions = model.maps + [(0, h) for h in model.phases]
    for p, h in base_functions:
        for y in range(512):
            z, u = y & 63, y >> 6
            x = z >> 3
            moved_z = ((z & 7) << 3) | x
            moved = moved_z | ((u ^ x) << 6)
            label = sum(((p >> (512 * j + y)) & 1) << j for j in range(3))
            other = sum(((p >> (512 * j + moved)) & 1) << j for j in range(3))
            assert label == other
            assert ((h >> y) ^ (h >> moved)) & 1 == (label & u).bit_count() & 1

    fixed_columns = [decompose(p)[1] for p in tables]
    even_plane = sum(1 << u for u in (0, 3, 5, 6))
    codes = []
    for task_path in sorted(artifacts.glob("tasks-*.bin")):
        for code, *_ in read_tasks(task_path):
            if not xor_terms(fixed_columns, code):
                continue
            p = xor_terms(tables, code)
            slices = []
            for z in range(64):
                slices.append(sum(1 << u for u in range(8) if all(
                    not (p >> (512 * j + z + 64 * u)) & 1 for j in range(3))))
            for x in range(8):
                assert slices[9 * x] == (255 if x in (0, 3, 5, 6, 7) else 0)
            outside = {z for z in range(64) if (z & 7) != z >> 3 and slices[z]}
            assert len(outside) == 6
            seed = min(outside)
            orbit = {seed}
            for _ in range(5):
                seed = rotate(seed)
                orbit.add(seed)
            assert orbit == outside
            for z in outside:
                assert ((z & 7) ^ (z >> 3)).bit_count() == 2
                assert slices[z] in (even_plane, even_plane ^ 255)
            codes.append(code)
    assert len(codes) == len(set(codes)) == 384

    squares = (0, 4, 16, 36, 64)
    paired_squares = (0, 16, 64)
    solutions = []
    for c0, c1, c2, c7, b0, b2 in product(paired_squares, repeat=6):
        a0, a1, a2, a7 = 64 - 3 * c0 - b0, 32 - c1, 32 - c2 - b2, 64 - 3 * c7
        if not all(a in squares for a in (a0, a1, a2, a7)):
            continue
        if a0 + 3 * a1 + 3 * a2 + a7 != 64:
            continue
        if c0 + c1 + c2 + c7 != 64 or b0 + 3 * b2 != 64:
            continue
        solutions.append([a0, a1, a2, a7, c0, c1, c2, c7, b0, b2])
    assert solutions == [[0, 16, 0, 16, 16, 16, 16, 16, 16, 16]]
    assert 27 ^ 45 ^ 54 ^ 63 == 63
    return {"basis_functions": len(base_functions), "kappa_point_checks": 512 * len(base_functions),
            "candidate_maps_checked": len(codes), "geometry_G1_G2": True,
            "square_system_solutions": solutions, "character_support_xor": 63,
            "scope": "The other 14 nonzero fixed-slice classes still use the support enumeration."}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--tasks", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    report = audit(args.tasks)
    args.output.write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
    print(report)


if __name__ == "__main__":
    main()
