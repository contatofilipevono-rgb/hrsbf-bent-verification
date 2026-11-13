"""Build and verify the phase exclusions in the first invariant plane."""
import argparse
import json
from pathlib import Path

from higher_filter import solve, xor_terms
from lower_dim_v2_residual_certificates import (
    build_all_equations,
    echelon_dag_step,
    pack_witness_terms,
    run_initial_quadratic_elimination,
    verify_witness_equation_combination,
)
from lower_dim_v3_symbolic import read_tasks


def certify(tasks, manifest=None):
    given = {} if manifest is None else {row["map_code"]: row for row in manifest["residual"]}
    residual = []
    excluded = []
    for code, _, properties, root, signature, directions, moments in read_tasks(tasks):
        reduced = run_initial_quadratic_elimination(root, signature, directions, moments)
        if reduced is None:
            excluded.append(code)
            continue
        root, signature, directions = reduced
        phases, sigs = map(list, zip(*directions))
        record = {"map_code": code, "residual_dimension": len(phases), "rounds": []}
        if manifest is None:
            labeled = build_all_equations(root, signature, phases, sigs, moments, properties)
            low = [(tag, q) for tag, q in labeled if tag["type"] != "mod16"]
            for equations in (low, labeled):
                status, witness = echelon_dag_step(equations, len(phases), True)
                if status == "contradiction":
                    record["contradiction"] = pack_witness_terms(equations, witness)
                    break
            else:
                status, relations = echelon_dag_step(labeled, len(phases))
                assert status == "linear"
                record["rounds"].append([
                    pack_witness_terms(labeled, terms) for _, terms in relations
                ])
        else:
            record = given[code]
            assert record["residual_dimension"] == len(phases)

        for step in record["rounds"]:
            equations = []
            for terms in step:
                row = verify_witness_equation_combination(
                    terms, root, signature, phases, sigs, moments, properties
                )
                assert row and all(m.bit_count() <= 1 for m in row)
                equations.append((sum(row - {0}), int(0 in row)))
            origin, basis, rank = solve(equations, len(phases))
            assert origin is not None and rank
            root ^= xor_terms(phases, origin)
            signature ^= xor_terms(sigs, origin)
            phases = [xor_terms(phases, word) for word in basis]
            sigs = [xor_terms(sigs, word) for word in basis]
        if "contradiction" not in record:
            assert manifest is None
            equations = build_all_equations(root, signature, phases, sigs, moments, properties)
            status, witness = echelon_dag_step(equations, len(phases), True)
            assert status == "contradiction"
            record["contradiction"] = pack_witness_terms(equations, witness)
        assert verify_witness_equation_combination(
            record["contradiction"], root, signature, phases, sigs, moments, properties
        ) == {0}
        residual.append(record)
    assert len(excluded) == 85 and len(residual) == 13
    report = {"quadratic_exclusions": excluded, "residual": residual}
    if manifest is not None:
        assert report == manifest
    return report


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--tasks", type=Path, required=True)
    parser.add_argument("--manifest", type=Path, required=True)
    parser.add_argument("--build", action="store_true")
    args = parser.parse_args()
    given = None if args.build else json.loads(args.manifest.read_text(encoding="utf-8"))
    report = certify(args.tasks, given)
    if args.build:
        args.manifest.write_text(json.dumps(report, separators=(",", ":")) + "\n", encoding="utf-8")
    print("Verified 85 quadratic and 13 residual exclusions in the plane <27,54>.")


if __name__ == "__main__":
    main()
