"""Turn the exact phases of each map orbit into affine cosets."""
import argparse
import json
import struct
from collections import defaultdict
from pathlib import Path

from count_near_antipodal import image_and_kernel
from lower_dim_model import active_indices, anf


def load_representatives(space, source):
    data = json.loads(source.read_bytes())
    if space == 1:
        return {v["code"]: (v["maps"], v["phases_per_map"]) for v in data["orbits"]}
    rows = next(d["admitted_orbits"] for d in data if d["space"] == space)
    return {v["map_code"]: (v["orbit_size"], v["phases_per_map"]) for v in rows}


def reduce(value, basis):
    for row in basis:
        if (value >> (row.bit_length() - 1)) & 1:
            value ^= row
    return value


def affine_description(phases, shifts):
    """Return the full translation space and a predicate on the remaining span."""
    first = min(phases)
    candidates = {v ^ first for v in phases}
    for phase in sorted(phases):
        if not all((d ^ phase) in phases for d in candidates):
            candidates = {d for d in candidates if (d ^ phase) in phases}
        if len(candidates) == 1:
            break
    period, _ = image_and_kernel(sorted(candidates))
    assert len(candidates) == 1 << len(period)
    group, _ = image_and_kernel(shifts + [row for row, _ in period])
    assert len(group) == len(shifts) + len(period)
    group = sorted((row for row, _ in group), reverse=True)
    cosets = sorted({reduce(h, group) for h in phases})
    assert len(cosets) * len(candidates) == len(phases)
    origin = cosets[0]
    hull, _ = image_and_kernel([p ^ origin for p in cosets])
    basis = sorted((row for row, _ in hull), reverse=True)
    codes = []
    for value in cosets:
        value ^= origin
        code = 0
        for i, row in enumerate(basis):
            if value >> (row.bit_length() - 1) & 1:
                value ^= row
                code |= 1 << i
        assert not value
        codes.append(code)
    result = {"phase_origin": hex(origin), "translation_basis": [hex(v) for v in group],
              "quotient_hull_basis": [hex(v) for v in basis], "quotient_dimension": len(basis),
              "quotient_size": len(codes)}
    if len(basis) <= 20:
        coefficients = anf(sum(1 << v for v in codes), len(basis))
        result["acceptance_anf_masks"] = list(active_indices(coefficients))
        result["acceptance_degree"] = max(m.bit_count() for m in result["acceptance_anf_masks"])
    else:
        result["acceptance_codes"] = sorted(codes)
    return result


def summarize(space, summary, phase_dump, shift_basis, output):
    expected = load_representatives(space, summary)
    shifts = json.loads(shift_basis.read_bytes())
    byte_count = 64 if space == 1 else 128
    raw = phase_dump.read_bytes()
    assert len(raw) % (byte_count + 8) == 0
    phases = defaultdict(set)
    for i in range(0, len(raw), byte_count + 8):
        code, = struct.unpack_from("<Q", raw, i)
        phase = int.from_bytes(raw[i + 8:i + 8 + byte_count], "little")
        assert phase not in phases[code]
        phases[code].add(phase)
    assert phases.keys() == expected.keys()
    rows = []
    for code, h in sorted(phases.items()):
        orbit_size, count = expected[code]
        shift_space = [int(v, 16) for v in shifts[str(code)]]
        assert len(h) << len(shift_space) == count
        description = affine_description(h, shift_space)
        assert description["quotient_size"] << len(description["translation_basis"]) == count
        rows.append({"map_code": code, "orbit_size": orbit_size, "phases_per_map": count,
                     "functions": count * orbit_size, **description})
        print(code, len(description["translation_basis"]), description["quotient_size"],
              description["quotient_dimension"], description.get("acceptance_degree"), flush=True)
    output.write_text(json.dumps({"space": space, "functions": sum(row["functions"] for row in rows),
                                  "orbits": rows}, indent=2) + "\n", encoding="utf-8")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--space", type=int, choices=(1, 3), required=True)
    parser.add_argument("--summary", type=Path, required=True)
    parser.add_argument("--representatives", type=Path)
    parser.add_argument("--phases", type=Path)
    parser.add_argument("--shift-basis", type=Path)
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    if args.representatives:
        codes = load_representatives(args.space, args.summary)
        args.representatives.write_bytes(b"".join(struct.pack("<Q", code) for code in sorted(codes)))
    if args.phases:
        summarize(args.space, args.summary, args.phases, args.shift_basis, args.output)


if __name__ == "__main__":
    main()
