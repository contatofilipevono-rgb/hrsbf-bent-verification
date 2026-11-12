"""Measure which signed-fibre moments suffice for the final cubic exclusions."""
import argparse
import json
import random
from collections import Counter
from pathlib import Path

from count_near_antipodal import image_and_kernel
from higher_filter import xor_terms
from line_phase_algebra import locate, mod8_bit, quadratic_moments, reduce_phase
from lower_dim_model import build
from lower_dim_moments import moment_masks
from lower_dim_phase_prepare import fibre_masks, truth_on_coordinates
from lower_dim_polar_structure import extract_polar
from lower_dim_v3_symbolic import read_tasks


def residual_systems(tasks, reference, shard, shards):
    model = build((63,))
    maps = [mapping for mapping, _ in model.maps]
    by_map = {}
    hard = [record for record in reference["details"] if record["exclusion"] == "mod8"]
    assert len(hard) == 55
    for index, record in enumerate(hard):
        if index % shards == shard:
            by_map.setdefault(record["map_code"], []).append(int(record["polar"], 16))
    for code, _, _, root, signature, directions, moments in read_tasks(tasks):
        if code not in by_map:
            continue
        mapping = xor_terms(maps, code)
        base = extract_polar(model, truth_on_coordinates(mapping, root, 1))
        image, kernel = image_and_kernel([
            extract_polar(model, truth_on_coordinates(0, phase, 1))
            for phase, _ in directions
        ])
        phases, sigs = map(list, zip(*directions))
        ds = [xor_terms(phases, v) for v in kernel]
        ss = [xor_terms(sigs, v) for v in kernel]
        fibres = fibre_masks(mapping, 1 << model.nbase, 1)
        descriptions = {}
        for label, fibre in enumerate(fibres):
            for index, (order, coord) in enumerate(moment_masks(model.nbase, 2)):
                descriptions.setdefault(fibre & coord, []).append((label, order, index))
        for polar in by_map[code]:
            rep = locate(sorted(image, reverse=True), polar ^ base)
            phase = root ^ xor_terms(phases, rep)
            sig = signature ^ xor_terms(sigs, rep)
            result = reduce_phase(phase, ds, sig, ss, quadratic_moments(phase, ds, moments), 3)
            assert result is not None
            phase, free, _, _, quadratics = result
            cubics = {}
            for subset, mask, target in moments:
                if mask < 7:
                    continue
                equation = frozenset(mod8_bit(phase, free, subset, target))
                if equation:
                    cubics.setdefault(equation, set()).update(descriptions[subset])
            yield code, polar, len(free), quadratics, cubics


def ablate(dimension, quadratics, cubics, trials, seed):
    cache = {}

    def fails(indices):
        key = tuple(sorted(indices))
        if key not in cache:
            equations = quadratics + [cubics[i] for i in key]
            cache[key] = reduce_phase(
                0, [1 << j for j in range(dimension)], 0, [0] * dimension, equations, 4
            ) is None
        return cache[key]

    all_indices = tuple(range(len(cubics)))
    assert fails(all_indices) and not fails(())
    best = all_indices
    rng = random.Random(seed)
    for _ in range(trials):
        active = set(all_indices)
        order = list(all_indices)
        rng.shuffle(order)
        for i in order:
            if fails(active - {i}):
                active.remove(i)
        candidate = tuple(sorted(active))
        best = min(best, candidate, key=lambda ids: (len(ids), ids))
    assert fails(best) and all(not fails(set(best) - {i}) for i in best)
    return best, len(cache), fails


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--tasks", type=Path, required=True)
    parser.add_argument("--reference", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--shard", type=int, default=0)
    parser.add_argument("--shards", type=int, default=1)
    parser.add_argument("--trials", type=int, default=12)
    args = parser.parse_args()
    reference = json.loads(args.reference.read_text())
    records = []
    for code, polar, dimension, quadratics, tagged in residual_systems(
        args.tasks, reference, args.shard, args.shards
    ):
        cubics = list(tagged)
        tags = [sorted(tagged[q]) for q in cubics]
        best, calls, fails = ablate(dimension, quadratics, cubics, args.trials, code ^ polar)
        families = {
            "fibre_0": lambda label, order: label == 0,
            "fibre_1": lambda label, order: label == 1,
            "order_0": lambda label, order: order == 0,
            "orders_0_1": lambda label, order: order <= 1,
        }
        sufficient = [name for name, predicate in families.items()
                      if fails([i for i, items in enumerate(tags)
                                if any(predicate(label, order) for label, order, _ in items)])]
        record = {
            "map_code": code, "polar": f"{polar:0240x}", "dimension_mod4": dimension,
            "quadratic_rows": len(quadratics), "mod8_rows": len(cubics),
            "solver_calls": calls, "sufficient_mod8_families": sufficient,
            "core": [{"moments": tags[i], "polynomial": sorted(cubics[i])} for i in best],
        }
        records.append(record)
        print(code, dimension, len(cubics), len(best), sufficient, flush=True)
    print(dict(Counter(len(r["core"]) for r in records)), flush=True)
    args.output.write_text(json.dumps(records, indent=2) + "\n", encoding="utf-8")


if __name__ == "__main__":
    main()
