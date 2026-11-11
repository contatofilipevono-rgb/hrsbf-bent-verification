"""Construct the 4,503,552 functions in the last two exterior blocks."""
import argparse
import json
from pathlib import Path
from random import Random

from count_near_antipodal import image_and_kernel
from higher_filter import shift, xor_terms
from higher_project import signs_to_walsh
from lower_dim_model import active_indices, anf, build
from lower_dim_orbits import apply, block_lookup, code_actions
from lower_dim_phase_prepare import truth_on_coordinates
from lower_dim_plan import BASES


def family_path(space):
    return Path(__file__).with_name(f"phase-families-dimension-{3 if space == 1 else 2}.json")


def accepts(row, code):
    dimension = row["quotient_dimension"]
    if not 0 <= code < 1 << dimension:
        return False
    if "acceptance_codes" in row:
        return code in row["acceptance_codes"]
    return sum(1 for mask in row["acceptance_anf_masks"] if code & mask == mask) & 1


def phase(row, parameter, free):
    if not accepts(row, parameter):
        raise ValueError("The quotient parameters do not satisfy the phase condition")
    translations = [int(v, 16) for v in row["translation_basis"]]
    if not 0 <= free < 1 << len(translations):
        raise ValueError("Translation parameter outside range")
    assert len(image_and_kernel(translations)[0]) == len(translations)
    hull = [int(v, 16) for v in row["quotient_hull_basis"]]
    return int(row["phase_origin"], 16) ^ xor_terms(hull, parameter) ^ xor_terms(translations, free)


def construct(space, row, parameter, free):
    model = build(BASES[space - 1])
    mapping = xor_terms([p for p, _ in model.maps], row["map_code"])
    moved = truth_on_coordinates(mapping, phase(row, parameter, free), len(model.basis))
    truth = sum(1 << model.coordinates[x] for x in active_indices(moved))
    return model, truth


def map_orbit(model, code):
    matrices = [(name, block_lookup(columns)) for name, columns in code_actions(model)]
    found = {code: ()}
    pending = [code]
    while pending:
        value = pending.pop()
        for name, matrix in matrices:
            result = apply(matrix, value)
            if result in found:
                continue
            found[result] = found[value] + (name,)
            pending.append(result)
    return found


def coordinate_generators():
    from analyse_near_antipodal_phases import ambient_generators
    result = dict(ambient_generators())
    result["multiplier_5"] = lambda x: sum((x >> i & 1) << ((5 * i) % 12) for i in range(12))
    return result


def transformed(truth, path, generators):
    out = 0
    for x in range(4096):
        y = x
        for name in reversed(path):
            y = generators[name](y)
        out |= (truth >> y & 1) << x
    return out


def sample(output):
    rng = Random(12112026)
    generators = coordinate_generators()
    records = []
    for space in (1, 3):
        data = json.loads(family_path(space).read_bytes())
        total = 0
        for row in data["orbits"]:
            dimension = row["quotient_dimension"]
            if "acceptance_codes" in row:
                parameter = rng.choice(row["acceptance_codes"])
            else:
                while not accepts(row, parameter := rng.randrange(1 << dimension)):
                    pass
            free = rng.randrange(1 << len(row["translation_basis"]))
            model, truth = construct(space, row, parameter, free)
            orbit = map_orbit(model, row["map_code"])
            assert len(orbit) == row["orbit_size"]
            target = rng.choice(sorted(orbit))
            truth = transformed(truth, orbit[target], generators)
            assert set(map(abs, signs_to_walsh(truth))) == {64}
            assert all((truth >> x & 1) == (truth >> shift(x, 1) & 1) for x in range(4096))
            coefficients = anf(truth, 12)
            assert max(m.bit_count() for m in active_indices(coefficients)) == 4
            records.append({"space": space, "map_orbit": row["map_code"], "target_map": target,
                            "phase_parameter": parameter, "free_parameter": free,
                            "anf_supports": list(active_indices(coefficients))})
            total += row["orbit_size"] * row["quotient_size"] * (1 << len(row["translation_basis"]))
        assert total == data["functions"]
    output.write_text(json.dumps(records, indent=2) + "\n", encoding="utf-8")
    print({"verified_orbit_representatives": len(records), "functions_represented": 4194304 + 309248})


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--sample", type=Path)
    args = parser.parse_args()
    if args.sample:
        sample(args.sample)


if __name__ == "__main__":
    main()
