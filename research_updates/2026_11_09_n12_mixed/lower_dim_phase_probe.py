"""Measure phase consistency after the exact support sieve."""
import argparse
import json
import struct
from collections import Counter
from pathlib import Path
from time import perf_counter

from count_near_antipodal import all_points, rotation_orbits
from higher_filter import shift, xor_terms
from lower_dim_model import build
from lower_dim_moments import affine_phase_quotient, conditions, exact, phase_linear_system
from lower_dim_plan import BASES
from lower_dim_support import fibre_masks


def orbit_representatives(basis):
    span = all_points(basis)
    images = [span.index(shift(v, 1, 6)) for v in basis]
    # The transpose and its inverse have the same orbits.
    action = [sum(((image & label).bit_count() & 1) << i for i, image in enumerate(images))
              for label in range(1 << len(basis))]
    return [min(orbit) for orbit in rotation_orbits(action)]


def inspect(space, support_file, limit, output):
    start = perf_counter()
    model = build(BASES[space - 1])
    width = model.nbase
    size = 1 << width
    r = len(model.basis)
    t = 6 - r
    maps = [p for p, _ in model.maps]
    phases = [h for _, h in model.maps]
    labels = orbit_representatives(model.basis)
    stats = Counter()
    with support_file.open("rb") as source:
        while (block := source.read(8)) and (limit is None or stats["tested"] < limit):
            code, = struct.unpack("<Q", block)
            mapping = xor_terms(maps, code)
            phase = xor_terms(phases, code)
            fibres = fibre_masks(mapping, size, r)
            selected = [fibres[j] for j in labels]
            equations = conditions(selected, width, t)
            assert equations is not None
            stats["tested"] += 1
            root, free, rank = phase_linear_system(equations, phase, model.phases)
            if root is None:
                stats["linear_inconsistent"] += 1
                continue
            stats["linear_consistent"] += 1
            stats[f"free_{len(free)}"] += 1
            directions = [xor_terms(model.phases, f) for f in free]
            representatives, shifts = affine_phase_quotient(selected, width, directions)
            assert len(representatives) + shifts == len(free)
            stats[f"quotient_{len(representatives)}"] += 1
            witness = phase ^ xor_terms(model.phases, root)
            if exact(equations, witness):
                assert exact(conditions(fibres, width, t), witness)
                stats["base_phase_passes"] += 1
    report = {"space": space, "label_orbit_representatives": labels, "seconds": perf_counter() - start,
              "statistics": dict(stats)}
    output.write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
    print(report)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--space", type=int, choices=range(1, 4), required=True)
    parser.add_argument("--supports", type=Path, required=True)
    parser.add_argument("--limit", type=int)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    inspect(args.space, args.supports, args.limit, args.output)


if __name__ == "__main__":
    main()
