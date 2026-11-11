"""Check the complete V3 count and summarize its map orbits."""
import argparse
import json
import struct
from collections import Counter
from pathlib import Path

from lower_dim_orbits import apply, block_lookup, code_actions
from lower_dim_model import build
from lower_dim_plan import BASES
from lower_dim_phase_verify import records


def v3_summary(root):
    dirs = sorted(root.glob("lower-dim-phase-1-*"))
    assert len(dirs) == 8
    totals = Counter()
    maps = {}
    previous = 0
    for folder in dirs:
        support = json.loads((folder / "support.json").read_bytes())
        tasks = json.loads((folder / "tasks.json").read_bytes())
        count = json.loads((folder / "result.json").read_bytes())
        assert support["space"] == tasks["space"] == count["space"] == 1
        assert support["branch_start"] == previous
        previous = support["branch_stop"]
        assert tasks["support_start"] == 0
        assert tasks["support_stop"] == support["support_degree_at_most_five"]
        assert count["tasks"] == tasks["statistics"].get("tasks", 0)
        assert count["inconsistent"] + count["tested_maps"] == count["tasks"]
        assert count["deferred"] == 0
        found = records(folder / "result.witnesses.bin", 64)
        assert len(found) == count["maps"]
        assert sum(n for n, _ in found.values()) == count["functions"]
        assert not maps.keys() & found.keys()
        maps.update(found)
        totals.update({k: support[k] for k in ("tested", "balanced", "support_degree_at_most_five")})
        totals.update({k: count[k] for k in ("tasks", "maps", "functions", "phase_trials")})
        totals["quadratic_inconsistent"] += count["inconsistent"]
    assert previous == support["branches"]
    assert totals["functions"] == 4194304

    actions = [block_lookup(columns) for _, columns in code_actions(build(BASES[0]))]
    unseen = set(maps)
    orbit_types = Counter()
    orbit_rows = []
    while unseen:
        seed = min(unseen)
        seen = {seed}
        pending = [seed]
        count = maps[seed][0]
        while pending:
            code = pending.pop()
            for action in actions:
                moved = apply(action, code)
                if moved in seen:
                    continue
                assert moved in unseen and maps[moved][0] == count
                seen.add(moved)
                pending.append(moved)
        unseen.difference_update(seen)
        orbit_types[len(seen), count] += 1
        orbit_rows.append({"code": seed, "maps": len(seen), "phases_per_map": count})
    assert sum(n * size * count for (size, count), n in orbit_types.items()) == totals["functions"]
    return {"totals": dict(totals), "orbits": orbit_rows, "orbit_count": len(orbit_rows),
            "phase_count_distribution": [
                {"orbit_size": size, "phases_per_map": count, "orbits": n}
                for (size, count), n in sorted(orbit_types.items())]}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--artifacts", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    result = v3_summary(args.artifacts)
    args.output.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    print({k: v for k, v in result.items() if k != "orbits"})


if __name__ == "__main__":
    main()
