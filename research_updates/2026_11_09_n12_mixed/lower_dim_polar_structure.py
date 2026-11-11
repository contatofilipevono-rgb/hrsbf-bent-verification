"""Read exact phase-family data and compute polar and quartic profiles."""
import argparse
import json
from collections import Counter
from itertools import combinations
from pathlib import Path

from count_near_antipodal import all_points, image_and_kernel
from higher_filter import xor_terms
from lower_dim_model import active_indices, anf, build
from lower_dim_phase_prepare import truth_on_coordinates
from lower_dim_plan import BASES
from outside_polar_profiles import PAIRS, cyclic_subspaces, polar_profile


def accepted_codes(row):
    dimension = row["quotient_dimension"]
    if "acceptance_codes" in row:
        yield from row["acceptance_codes"]
        return
    coefficients = sum(1 << m for m in row["acceptance_anf_masks"])
    yield from active_indices(anf(coefficients, dimension))


def extract_polar(model, truth):
    index = {model.coordinates[i] >> 6: i for i in range(0, 4096, 64)}
    mask = (1 << 64) - 1
    result = 0
    for k, (i, j) in enumerate(PAIRS):
        a, b = 1 << i, 1 << j
        value = (truth ^ (truth >> index[a]) ^ (truth >> index[b]) ^ (truth >> index[a ^ b])) & mask
        result |= value << (64 * k)
    return result


def phase_features(row, model, maps):
    r = len(model.basis)
    top = sum(1 << m for m in range(4096) if m.bit_count() == 4)
    pi = xor_terms(maps, row["map_code"])
    root = int(row["phase_origin"], 16)
    shifts = [int(v, 16) for v in row["translation_basis"]]
    quotient = [int(v, 16) for v in row["quotient_hull_basis"]]

    def features(mapping, h):
        truth = truth_on_coordinates(mapping, h, r)
        polar = extract_polar(model, truth)
        return polar | ((anf(truth, 12) & top) << 960)

    base = features(pi, root)
    shift_features = [features(0, h) for h in shifts]
    quotient_features = [features(0, h) for h in quotient]
    projected, kernel = image_and_kernel(shift_features)
    projected = all_points([row for row, _ in projected])
    counts = Counter()
    for code in accepted_codes(row):
        value = base ^ xor_terms(quotient_features, code)
        for direction in projected:
            counts[value ^ direction] += 1 << len(kernel)
    assert sum(counts.values()) == row["phases_per_map"]
    return counts


def profile(path):
    data = json.loads(path.read_bytes())
    space = data["space"]
    model = build(BASES[space - 1])
    maps = [p for p, _ in model.maps]
    spaces = cyclic_subspaces()
    report = []
    for row in data["orbits"]:
        counts = phase_features(row, model, maps)
        by_polar = Counter()
        by_top = Counter()
        for value, count in counts.items():
            by_polar[value & ((1 << 960) - 1)] += count
            by_top[value >> 960] += count
        ranks = Counter()
        for polar, count in by_polar.items():
            pattern, dimension = polar_profile(polar, spaces)
            assert dimension == len(model.basis)
            ranks[pattern] += count
        item = {"map_code": row["map_code"], "orbit_size": row["orbit_size"],
                "polar_count": len(by_polar), "top_count": len(by_top),
                "counts_per_polar": sorted(Counter(by_polar.values()).items()),
                "counts_per_top": sorted(Counter(by_top.values()).items()),
                "rank_patterns": [{"ranks": p, "phases": n} for p, n in sorted(ranks.items())]}
        report.append(item)
        print(item, flush=True)
    return report


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("source", type=Path)
    p.add_argument("output", type=Path)
    args = p.parse_args()
    report = profile(args.source)
    args.output.write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")


if __name__ == "__main__":
    main()
