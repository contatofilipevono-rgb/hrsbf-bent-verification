"""Export deterministic discovery and blind holdout samples for V1."""
import argparse
import json
import random
from collections import defaultdict
from pathlib import Path
import sys


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("model_dir", type=Path)
    parser.add_argument("catalog", type=Path)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    sys.path.insert(0, str(args.model_dir.resolve()))
    from count_near_antipodal import image_and_kernel
    from dim4_support_decode import decode
    from higher_filter import xor_terms
    from line_phase_algebra import locate, quadratic_moments, reduce_phase
    from lower_dim_moments import conditions, phase_linear_system
    from lower_dim_phase_prepare import fibre_masks

    model, basis, labels = decode(1)
    maps, lifts = map(list, zip(*model.maps))
    image = sorted(image_and_kernel(maps)[0], reverse=True)
    s = [sum(1 << x for x in range(256) if x >> i & 1) for i in (6, 7)]
    report = json.loads((args.model_dir / "dim4-v1-full-charts.json").read_bytes())
    positive = {int(code): count for code, count in report["positive"].items()}
    discovery = {1, 23, 37, 129, 165}
    holdout = {0, 22, 36, 128, 164}
    groups = defaultdict(list)
    for code in map(int, args.catalog.read_bytes().splitlines()):
        chart = code >> 25
        if chart in discovery | holdout:
            groups[chart, code in positive].append(code)

    rng = random.Random(129)
    output = defaultdict(list)
    for (chart, known_positive), codes in sorted(groups.items()):
        assert len(codes) == len(set(codes))
        for code in sorted(rng.sample(sorted(codes), min(24, len(codes)))):
            mapping = xor_terms(basis, code)
            reference = xor_terms(lifts, locate(image, mapping))
            fibres = fibre_masks(mapping, 256, 4)
            subsets = [mask for fibre in fibres for mask in (fibre, fibre & s[0], fibre & s[1])]
            short = [(mask, 1, mask.bit_count() // 2 & 1) for mask in subsets]
            linear = [[sum(((mask & phase).bit_count() & 1) << i
                           for i, phase in enumerate(model.phases)),
                       ((mask & reference).bit_count() & 1) ^ residue]
                      for mask, _, residue in short]
            root, kernel, _ = phase_linear_system(short, reference, model.phases)
            if root is None:
                outcome = "inconsistent_mod2"
            else:
                phase = reference ^ xor_terms(model.phases, root)
                directions = [xor_terms(model.phases, v) for v in kernel]
                mod4 = quadratic_moments(phase, directions, conditions(fibres, 8, 2))
                result = reduce_phase(phase, directions, 0, [0] * len(directions), mod4, 3)
                outcome = ("inconsistent_mod4" if result is None else
                           "verified_positive" if known_positive else "passes_mod4_elimination")
            if known_positive:
                assert outcome == "verified_positive"
            row = {
                "code": code,
                "chart": chart,
                "g": "".join(format(label, "x") for label in labels(mapping)[:64]),
                "moments": [[hex(coefficients), residue] for coefficients, residue in linear],
                "phase_ref": format(reference, "064x"),
            }
            if chart in discovery:
                output["discovery"].append(dict(row, outcome=outcome))
            else:
                output["holdout_blind"].append(row)
                output["holdout_key"].append({"code": code, "outcome": outcome})
    args.output.mkdir(parents=True, exist_ok=True)
    for name, records in output.items():
        target = args.output / f"{name}.jsonl"
        target.write_text("".join(json.dumps(row, separators=(",", ":")) + "\n"
                                  for row in records), encoding="utf-8")
        print(name, len(records), target)
    (args.output / "phase_basis.json").write_text(json.dumps({
        "basis": [format(phase, "064x") for phase in model.phases],
        "coordinates": "index = z + 64*s1 + 128*s2, least significant bit is index zero",
        "labels": "row 3*t+i for label t and multiplier 1,s1,s2 respectively",
        "model": "V1, decode(1), code >> 25 identifies the mixed class",
    }, indent=2) + "\n", encoding="utf-8")


if __name__ == "__main__":
    main()
