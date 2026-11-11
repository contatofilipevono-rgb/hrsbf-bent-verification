"""Audit universal coverage and the finite-difference signatures used for exclusion."""
import argparse
import hashlib
import json
from pathlib import Path

from count_near_antipodal import image_and_kernel
from lower_dim_model import active_indices, anf, build
from lower_dim_phase_prepare import preceding_spaces, properties, truth_on_coordinates
from lower_dim_plan import BASES


def xor_translate(table, displacement):
    mask = (1 << 4096) - 1
    for i in active_indices(displacement):
        step = 1 << i
        low = mask // ((1 << step) + 1)
        table = ((table & low) << step) | ((table >> step) & low)
    return table


def validate_line_model():
    model = build(BASES[3])
    signatures, phase_signatures, n = properties(model, 4)
    assert n == 3
    columns = model.maps + [(0, h) for h in model.phases]
    assert len(columns) == 68
    assert len(model.maps) == 18 and len(model.phases) == 50
    pairs = [(27, 54), (21, 42)]
    checked = 0
    direct_columns = [[], [], []]
    compressed_columns = [[], [], []]
    for (p, h), signature in zip(columns, signatures + phase_signatures):
        moved = truth_on_coordinates(p, h, 1)
        original = sum(1 << model.coordinates[x] for x in active_indices(moved))
        zw = sum((original >> ((z ^ w) | (w << 6)) & 1) << (z | (w << 6))
                 for w in range(64) for z in range(64))
        coefficients = anf(zw, 12)
        assert all((support >> 6).bit_count() <= 2 for support in active_indices(coefficients))
        assert bool(signature & ((1 << 64) - 1)) == any(m.bit_count() == 4 for m in active_indices(anf(original, 12)))
        direct_columns[0].append(anf(original, 12) & sum(1 << m for m in range(4096) if m.bit_count() == 4))
        compressed_columns[0].append(signature & ((1 << 64) - 1))
        for j, (u, v) in enumerate(pairs, 1):
            a, b = u | (u << 6), v | (v << 6)
            derivative = (original ^ xor_translate(original, a) ^ xor_translate(original, b)
                          ^ xor_translate(original, a ^ b))
            assert bool(derivative) == bool(signature >> (64 * j) & ((1 << 64) - 1))
            direct_columns[j].append(derivative)
            compressed_columns[j].append(signature >> (64 * j) & ((1 << 64) - 1))
            assert all(((derivative >> x) ^ (derivative >> ((x & 63) ^ (x >> 6)))) & 1 == 0
                       for x in range(4096))
            checked += 1
    ranks = []
    for direct, compressed in zip(direct_columns, compressed_columns):
        a = len(image_and_kernel(direct)[0])
        b = len(image_and_kernel(compressed)[0])
        c = len(image_and_kernel([x | (y << 4096) for x, y in zip(direct, compressed)])[0])
        assert a == b == c
        ranks.append(a)
    return {"model_dimension": 68, "map_dimension": 18, "phase_dimension": 50,
            "direct_signature_comparisons": checked, "signature_kernel_ranks": ranks,
            "all_functions_quadratic_in_w": True}


def aggregate(root):
    folders = sorted(root.glob("n12-invariant-plane-coverage-*"))
    assert len(folders) == 16
    counts = [json.loads((p / "result.json").read_bytes()) for p in folders]
    assert {d["phase_shard"] for d in counts} == set(range(16))
    prototype = counts[0]
    hashes = {}
    for name in ("support.bin", "orbits.bin", "orbits.weights.bin"):
        digests = {hashlib.sha256((p / name).read_bytes()).hexdigest() for p in folders}
        assert len(digests) == 1
        hashes[name] = digests.pop()
    if all((p / "tasks.bin").exists() for p in folders):
        digests = {hashlib.sha256((p / "tasks.bin").read_bytes()).hexdigest() for p in folders}
        assert len(digests) == 1
        hashes["tasks.bin"] = digests.pop()
    assert all(d["space"] == 4 and d["phase_shards"] == 16 and not d["deferred"] for d in counts)
    for p, result in zip(folders, counts):
        support = json.loads((p / "support.json").read_bytes())
        orbit = json.loads((p / "orbits.json").read_bytes())
        tasks = json.loads((p / "tasks.json").read_bytes())
        assert support["tested"] == 262144 and support["balanced"] == 30781
        assert support["branch_start"] == 0 and support["branch_stop"] == support["branches"]
        assert orbit["maps"] == 30781 and orbit["orbits"] == 452
        assert sum(int(k) * v for k, v in orbit["orbit_sizes"].items()) == 30781
        assert tasks["support_start"] == 0 and tasks["support_stop"] == 452
        assert tasks["statistics"]["tested"] == 452 and tasks["statistics"]["tasks"] == 49
        assert result["tasks"] == 49 and result["inconsistent"] == 8 and result["tested_maps"] == 41
        assert result["residual_dimensions"] == prototype["residual_dimensions"]
        assert not (p / "result.deferred.bin").read_bytes()
        assert not (p / "result.witnesses.bin").read_bytes()
    expected = sum(number << int(d) for d, number in prototype["residual_dimensions"].items())
    tested = sum(d["phase_trials"] for d in counts)
    assert expected == tested
    assert sum(d["functions"] for d in counts) == 0
    return {"all_map_codes": 262144, "balanced_maps": 30781, "map_orbits": 452,
            "phase_tasks": 49, "quadratic_inconsistent": 8, "phase_tasks_completed": 41,
            "phase_intervals": 16, "phase_combinations_tested": tested,
            "functions_outside_both_planes": 0, "deferred": 0,
            "residual_dimensions": prototype["residual_dimensions"], "input_hashes": hashes}


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--artifacts", type=Path, required=True)
    p.add_argument("--output", type=Path, required=True)
    args = p.parse_args()
    report = {"model_controls": validate_line_model(), "coverage": aggregate(args.artifacts)}
    args.output.write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
    print(report)


if __name__ == "__main__":
    main()
