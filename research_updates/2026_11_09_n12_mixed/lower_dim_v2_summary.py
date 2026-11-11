"""Verify complete orbit coverage and aggregate the dimension-two phase counts."""
import argparse
import json
import struct
from pathlib import Path

from lower_dim_phase_verify import records


def summarize(root):
    result = []
    seen = set()
    for path in sorted(root.glob("lower-dim-phase-orbits-*")):
        counts = json.loads((path / "result.json").read_bytes())
        space = counts["space"]
        assert space in (2, 3) and space not in seen
        seen.add(space)
        support = json.loads((path / "support.json").read_bytes())
        orbits = json.loads((path / "orbits.json").read_bytes())
        tasks = json.loads((path / "tasks.json").read_bytes())
        assert space == support["space"] == orbits["space"] == tasks["space"]
        assert support["branch_start"] == support["shard"] == 0 and support["shards"] == 1
        assert support["branch_stop"] == support["branches"]
        weights = dict(struct.iter_unpack("<QQ", (path / "orbits.weights.bin").read_bytes()))
        assert len(weights) == orbits["orbits"] == tasks["support_stop"]
        assert sum(weights.values()) == support["support_degree_at_most_five"] == orbits["maps"]
        assert tasks["support_start"] == 0
        assert counts["tasks"] == tasks["statistics"]["tasks"]
        assert counts["deferred"] == 0 and counts["inconsistent"] + counts["tested_maps"] == counts["tasks"]
        assert not (path / "result.deferred.bin").read_bytes()
        witnesses = records(path / "result.witnesses.bin", 128)
        assert len(witnesses) == counts["maps"]
        assert sum(v for v, _ in witnesses.values()) == counts["functions"]
        admitted = []
        for code, (number, _) in sorted(witnesses.items()):
            admitted.append({"map_code": code, "orbit_size": weights[code], "phases_per_map": number,
                             "functions": weights[code] * number})
        result.append({"space": space, "basis": support["basis"], "maps_after_cubic_filter": support["tested"],
                       "support_maps": orbits["maps"], "support_orbits": orbits["orbits"],
                       "phase_tasks": counts["tasks"], "quadratic_inconsistent": counts["inconsistent"],
                       "tested_phase_orbits": counts["tested_maps"], "admitted_orbits": admitted,
                       "functions": sum(row["functions"] for row in admitted)})
    assert seen == {2, 3}
    assert [row["functions"] for row in result] == [0, 309248]
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--artifacts", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    results = summarize(args.artifacts)
    args.output.write_text(json.dumps(results, indent=2) + "\n", encoding="utf-8")
    for row in results:
        print(row)


if __name__ == "__main__":
    main()
