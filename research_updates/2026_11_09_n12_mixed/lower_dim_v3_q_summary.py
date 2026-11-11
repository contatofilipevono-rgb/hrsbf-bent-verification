"""Compare the reconstructed V3 supports and their exact quadratic phase counts."""
import argparse
import json
import struct
from collections import Counter
from pathlib import Path

from lower_dim_phase_verify import records
from lower_dim_v3_symbolic import count, equations_for_task, orbit_partition, read_tasks


SUPPORT_COUNTS = {0: 9966, 56: 3168, 157: 928, 179: 832, 315: 3168,
                  325: 928, 351: 832, 472: 928, 492: 832}
PHASE_COUNTS = {56: 655360, 315: 655360, 351: 2883584}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--artifacts", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    native, tasks, supports = {}, {}, set()
    cases = []
    for q_code, expected in SUPPORT_COUNTS.items():
        folder = args.artifacts / f"v3-q-{q_code}"
        report = json.loads((folder / "support.json").read_bytes())
        result = json.loads((folder / "result.json").read_bytes())
        codes = {code for code, in struct.iter_unpack("<Q", (folder / "support.bin").read_bytes())}
        assert report["support_maps"] == len(codes) == expected, (q_code, len(codes), expected)
        assert not (codes & supports)
        supports.update(codes)
        output = records(folder / "result.witnesses.bin", 64)
        assert not (folder / "result.deferred.bin").stat().st_size
        assert sum(n for n, _ in output.values()) == result["functions"] == PHASE_COUNTS.get(q_code, 0)
        assert not (output.keys() & native.keys())
        native.update(output)
        for task in read_tasks(folder / "tasks.bin"):
            assert task[0] not in tasks
            tasks[task[0]] = task
        cases.append({"q_code": q_code, "supports": expected,
                      "maps_with_phase": len(output), "functions": result["functions"]})
    orbits, generators = orbit_partition(tasks)
    descriptions = []
    for code, members in orbits.items():
        _, factor, properties, root, signature, directions, moments = tasks[code]
        equations = equations_for_task(properties, root, signature, directions, moments)
        number, dimension, quadratic, sums = count(len(directions), equations, Counter())
        phases = number << factor
        assert all(native.get(member, (0, 0))[0] == phases for member in members)
        descriptions.append({"map_code": code, "orbit_size": len(members),
                             "phases_per_map": phases, "dimension": dimension,
                             "quadratics": quadratic, "gauss_sums": sums})
    assert len(supports) == 21582
    assert len(native) == 256 and sum(n for n, _ in native.values()) == 4194304
    report = {"supports": len(supports), "phase_tasks": len(tasks), "phase_orbits": len(orbits),
              "maps_with_phase": len(native), "functions": sum(n for n, _ in native.values()),
              "generators": generators, "cases": cases, "phase_details": descriptions}
    args.output.write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
    print({key: value for key, value in report.items() if key != "phase_details"})


if __name__ == "__main__":
    main()
