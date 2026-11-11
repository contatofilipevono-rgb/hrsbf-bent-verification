"""Prepare exact phase tasks for the exterior blocks of invariant dimensions three and two."""
import argparse
import json
import struct
from collections import Counter
from itertools import combinations
from pathlib import Path
from time import perf_counter

from count_near_antipodal import image_and_kernel
from higher_filter import xor_terms
from lower_dim_model import anf, build
from lower_dim_moments import affine_phase_quotient, conditions, exact, phase_linear_system
from lower_dim_phase_probe import orbit_representatives
from lower_dim_plan import BASES
from lower_dim_support import fibre_masks


def truth_on_coordinates(mapping, phase, r):
    size = 1 << (12 - r)
    base_mask = (1 << size) - 1
    parts = [(mapping >> (i * size)) & base_mask for i in range(r)]
    return sum((phase ^ xor_terms(parts, u)) << (u * size) for u in range(1 << r))


def preceding_spaces(space):
    if space == 4:
        return list(BASES[1:3])
    return [(7, 14, 28, 56), (5, 10, 20, 40)] + list(BASES[:space - 1])


def properties(model, space):
    """Linear signatures for degree four and exclusion of preceding spaces."""
    preceding = preceding_spaces(space)
    degree_four = sum(1 << m for m in range(4096) if m.bit_count() == 4)
    w_index = {model.coordinates[i] >> 6: i for i in range(0, 4096, 64)}
    z_mask = (1 << 64) - 1
    data = []
    for pi, h in model.maps + [(0, h) for h in model.phases]:
        truth = truth_on_coordinates(pi, h, len(model.basis))
        values = [anf(truth, 12) & degree_four]
        for basis in preceding:
            polar = 0
            for k, (u, v) in enumerate(combinations(basis, 2)):
                f = (truth ^ (truth >> w_index[u]) ^ (truth >> w_index[v])
                     ^ (truth >> w_index[u ^ v])) & z_mask
                polar |= f << (k * 64)
            values.append(polar)
        data.append(values)

    signatures = [0] * len(data)
    for j, values in enumerate(zip(*data)):
        basis, _ = image_and_kernel(values)
        rows = sorted((row for row, _ in basis), reverse=True)
        assert len(rows) <= 64
        for i, v in enumerate(values):
            code = 0
            for k, row in enumerate(rows):
                if v >> (row.bit_length() - 1) & 1:
                    v ^= row
                    code |= 1 << k
            assert v == 0
            signatures[i] |= code << (64 * j)
    return signatures[:len(model.maps)], signatures[len(model.maps):], len(preceding) + 1


def words(value, width):
    return value.to_bytes(width, "little")


def prepare(space, support_file, output, start, stop, shift_basis_output=None):
    elapsed = perf_counter()
    model = build(BASES[space - 1])
    r = len(model.basis)
    t = 6 - r
    size = 1 << model.nbase
    maps = [p for p, _ in model.maps]
    phases = [h for _, h in model.maps]
    labels = orbit_representatives(model.basis)
    map_signatures, phase_signatures, nprop = properties(model, space)
    stats = Counter()
    shift_bases = {}
    with support_file.open("rb") as source, output.open("wb") as target:
        target.write(b"PHS3451\0")
        target.write(struct.pack("<4I", space, size // 64, nprop, 0))
        source.seek(start * 8)
        while (stop is None or start + stats["tested"] < stop) and (block := source.read(8)):
            code, = struct.unpack("<Q", block)
            stats["tested"] += 1
            mapping = xor_terms(maps, code)
            reference = xor_terms(phases, code)
            signature = xor_terms(map_signatures, code)
            # Reject maps that stay in an already covered family under every
            # phase, even before imposing the linear phase equations.
            support_signature = signature
            for item in phase_signatures:
                support_signature |= item
            if any(not (support_signature >> (64 * i) & ((1 << 64) - 1)) for i in range(nprop)):
                stats["excluded_by_class"] += 1
                continue
            fibres = fibre_masks(mapping, size, r)
            selected = [fibres[i] for i in labels]
            equations = conditions(selected, model.nbase, t)
            assert equations is not None
            root, free, _ = phase_linear_system(equations, reference, model.phases)
            if root is None:
                stats["linear_inconsistent"] += 1
                continue
            base = reference ^ xor_terms(model.phases, root)
            signature ^= xor_terms(phase_signatures, root)
            directions = [xor_terms(model.phases, v) for v in free]
            signatures = [xor_terms(phase_signatures, v) for v in free]
            union = signature
            for value in signatures:
                union |= value
            if any(not (union >> (64 * i) & ((1 << 64) - 1)) for i in range(nprop)):
                stats["excluded_after_linear"] += 1
                continue
            reps, symmetry = affine_phase_quotient(selected, model.nbase, directions, signatures)
            if shift_basis_output is not None:
                shift_bases[str(code)] = [hex(xor_terms(directions, v)) for v in symmetry]
            directions = [xor_terms(directions, v) for v in reps]
            signatures = [xor_terms(signatures, v) for v in reps]
            residual = set()
            impossible = False
            variation = 0
            for direction in directions:
                variation |= direction
            for subset, modulus_mask, residue in equations:
                if modulus_mask == 1:
                    continue
                if subset & variation:
                    residual.add((subset, modulus_mask, residue))
                elif ((subset & base).bit_count() & modulus_mask) != residue:
                    impossible = True
                    break
            if impossible:
                stats["excluded_constant_phase"] += 1
                continue

            ordered = sorted(residual, key=lambda item: (-item[1], item[0].bit_count(), item[0]))
            stats["tasks"] += 1
            stats[f"phase_dimension_{len(directions)}"] += 1
            stats["phase_evaluations"] += 1 << len(directions)
            target.write(struct.pack("<QIII", code, len(directions), len(symmetry), len(ordered)))
            target.write(words(base, size // 8))
            target.write(words(signature, nprop * 8))
            for h, value in zip(directions, signatures):
                target.write(words(h, size // 8))
                target.write(words(value, nprop * 8))
            for subset, modulus_mask, residue in ordered:
                target.write(words(subset, size // 8))
                target.write(struct.pack("<BB", modulus_mask, residue))
    result = {"space": space, "support_start": start, "support_stop": start + stats["tested"],
              "labels": labels, "properties": nprop, "statistics": dict(stats),
              "seconds": perf_counter() - elapsed}
    output.with_suffix(".json").write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    if shift_basis_output is not None:
        shift_basis_output.write_text(json.dumps(shift_bases, indent=2) + "\n", encoding="utf-8")
    print(result)
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--space", type=int, choices=range(1, len(BASES) + 1), required=True)
    parser.add_argument("--supports", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--start", type=int, default=0)
    parser.add_argument("--stop", type=int)
    parser.add_argument("--shift-basis-output", type=Path)
    args = parser.parse_args()
    prepare(args.space, args.supports, args.output, args.start, args.stop, args.shift_basis_output)


if __name__ == "__main__":
    main()
