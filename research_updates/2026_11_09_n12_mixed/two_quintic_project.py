"""Plan the next quintic stratum and reduce each surviving representative."""
import argparse
import json
from collections import Counter
from itertools import combinations
from pathlib import Path

from higher_orbits import high_actions, orbit
from higher_project import UPPER, eliminate_lower, union_system
from sparse_projection import reduce_iteratively


def plan():
    ops = high_actions()
    remaining = {(1 << i) | (1 << j) for i, j in combinations(range(66), 2)}
    records = []
    for mask in sorted(remaining):
        if mask not in remaining:
            continue
        group = orbit(mask, ops)
        subset = group & remaining
        assert mask == min(subset)
        remaining -= subset
        supports = [t for i, (_, o) in enumerate(UPPER[:66]) if mask >> i & 1 for t in o]
        pairs = Counter(a | b for a, b in combinations(supports, 2)
                        if (a | b).bit_count() == 10)
        records.append({"mask": mask, "orbit_size": len(group),
                        "two_orbit_members": sorted(subset),
                        "passes_top_filter": all(v % 2 == 0 for v in pairs.values())})
    assert not remaining
    summary = {"classes": len(records),
               "passes": sum(r["passes_top_filter"] for r in records),
               "patterns": sum(len(r["two_orbit_members"]) for r in records),
               "patterns_passing": sum(len(r["two_orbit_members"]) for r in records
                                       if r["passes_top_filter"])}
    return {"summary": summary, "classes": records}


def main():
    p = argparse.ArgumentParser()
    p.add_argument("plan", type=Path)
    p.add_argument("--create", action="store_true")
    p.add_argument("--shard", type=int, default=0)
    p.add_argument("--shards", type=int, default=1)
    p.add_argument("--output", type=Path)
    a = p.parse_args()
    if a.create:
        result = plan()
        a.plan.write_text(json.dumps(result, indent=2) + "\n")
        print(result["summary"])
        return
    source = json.loads(a.plan.read_text())
    valid = [r for r in source["classes"] if r["passes_top_filter"]]
    reports = []
    for row in valid[a.shard::a.shards]:
        low, residual = eliminate_lower(union_system(row["mask"]))
        _, basis, poly, stages, certificate = reduce_iteratively(residual)
        reports.append({"mask": row["mask"], "patterns": len(row["two_orbit_members"]),
                        "lower_rank": len(low), "quartic_free": len(basis),
                        "residual_equations": len(poly), "stages": stages,
                        "contradiction": certificate is not None,
                        "certificate_of_final_contradiction": certificate})
    a.output.write_text(json.dumps(reports, indent=2) + "\n")
    print("shard",a.shard,"tested",len(reports),
          "contradictions",sum(r["contradiction"] for r in reports))


if __name__ == "__main__":
    main()
