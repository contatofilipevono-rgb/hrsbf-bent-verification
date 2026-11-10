"""Check completed sparse shards and transport the missing charts exactly."""
import json
from collections import Counter
from pathlib import Path

from higher_orbits import high_actions
from higher_filter import xor_terms
from higher_project import UPPER
from sparse_projection import test_one


def path_between(start, targets, operators):
    queue = [start]
    parent = {start: None}
    for v in queue:
        if v in targets:
            path = []
            current = v
            while parent[current] is not None:
                current, op = parent[current]
                path.append(op)
            return targets[v], path[::-1]
        for i, op in enumerate(operators):
            w = xor_terms(op, v)
            if w not in parent:
                parent[w] = (v, i)
                queue.append(w)
    return None, []


def main():
    d = Path(__file__).parent
    old = d / "sparse-shards"
    resumed = d / "sparse-resume-shards"
    cases = {}
    listed = {}
    for p in sorted(old.glob("*/reports.json")):
        rows = json.loads(p.read_text())
        done = {r["index"]: r for r in rows}
        collected = {i: [] for i in done}
        for line in (p.parent / "bent.tsv").read_text().splitlines():
            i, top, low = map(int, line.split())
            if i in done:
                collected[i].append((top, low))
        for i, report in done.items():
            vals = collected[i]
            assert i not in cases and len(vals) == len(set(vals)) == report["normalized_bent"]
            cases[i] = {"normalized_bent": len(vals), "method": "complete-first-run"}
            if vals:
                listed[i] = sorted(vals)
    complete_count = len(cases)
    phases = []
    result = set()
    for p in sorted(resumed.glob("*/report.json")):
        r = json.loads(p.read_text())
        assert r["index"] == 122 and r["shard_bits"] == 4 and r["quartic_trials"] == 1 << 29
        phases.append(r)
        rows = {tuple(map(int, line.split())) for line in
                (p.parent / "bent.tsv").read_text().splitlines()}
        assert len(rows) == r["normalized_bent"] and not rows & result
        result |= rows
    assert {r["shard"] for r in phases} == set(range(16)) and len(phases) == 16
    cases[122] = {"normalized_bent": len(result), "method": "complete-resumed-run"}
    if result:
        listed[122] = sorted((top, low) for i, top, low in result if i == 122)

    d76 = test_one(76)
    assert d76["contradiction"] and d76["xl_contradiction_certificate"]
    cases[76] = {"normalized_bent": 0, "method": "polynomial-identity",
                 "certificate": d76["xl_contradiction_certificate"]}

    operators = high_actions()
    targets = {1 << i: i for i in cases}
    for i in range(len(UPPER)):
        if i in cases:
            continue
        rep, path = path_between(1 << i, targets, operators)
        assert rep is not None
        cases[i] = {"normalized_bent": cases[rep]["normalized_bent"],
                    "method": "affine-normalizer", "equivalent_index": rep,
                    "generator_path_to_equivalent": path}
    assert set(cases) == set(range(146))
    count = Counter()
    for i, result in cases.items():
        result["higher_orbit_representative"] = UPPER[i][0]
        result["degree"] = UPPER[i][0].bit_count()
        count[result["degree"]] += result["normalized_bent"]
    report = {
        "scope": "exactly one active orbit of degree 5 or 6; arbitrary RS degree-2/3/4 terms",
        "first_run_completed_charts": complete_count,
        "resumed_quartic_trials_chart_122": sum(r["quartic_trials"] for r in phases),
        "resumed_lower_trials_chart_122": sum(r["lower_trials"] for r in phases),
        "normalized_by_degree": count,
        "counts_with_affine_terms": {d: 4 * n for d, n in count.items()},
        "cases": dict(sorted(cases.items())),
    }
    (d / "sparse-counts.json").write_text(json.dumps(report, indent=2) + "\n")
    (d / "sparse-bent-representatives.tsv").write_text(
        "".join(f"{i}\t{t}\t{l}\n" for i in sorted(listed) for t, l in listed[i]))
    print({k: v for k, v in report.items() if k != "cases"})
    print("nonzero charts", [(i, r["normalized_bent"]) for i, r in sorted(cases.items())
                            if r["normalized_bent"]])


if __name__ == "__main__":
    main()
