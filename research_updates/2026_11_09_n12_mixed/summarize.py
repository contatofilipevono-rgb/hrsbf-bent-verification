"""Verify all completion artifacts and aggregate exact counts."""
import argparse
import csv
import json
from collections import Counter, defaultdict
from pathlib import Path


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("representatives", type=Path)
    parser.add_argument("shards", type=Path)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    expected = [tuple(map(int, line.split())) for line in
                args.representatives.read_text().splitlines()]
    rows = {}
    shard_reports = sorted(args.shards.glob("**/summary.tsv"))
    assert len(shard_reports) == 64
    for path in shard_reports:
        assert path.parent.name.startswith("worker-")
        worker = int(path.parent.name.split("-")[1])
        with path.open(newline="") as file:
            chart = list(csv.DictReader(file, delimiter="\t"))
        assert [(int(r["top"]), int(r["orbit_size"])) for r in chart] == expected[worker::64]
        hit_counts = Counter()
        hits = defaultdict(set)
        with (path.parent / "bent.tsv").open() as file:
            for line in file:
                top, low = map(int, line.split())
                assert 0 <= low < 1 << 25 and low not in hits[top]
                hits[top].add(low)
                hit_counts[top] += 1
        for row in chart:
            top, size = int(row["top"]), int(row["orbit_size"])
            assert top not in rows
            assert int(row["trials"]) == 1 << 23
            assert int(row["solutions"]) == hit_counts.pop(top, 0)
            rows[top] = size, int(row["solutions"])
        assert not hit_counts
    assert rows.keys() == dict(expected).keys()
    assert rows[0] == (1, 14336)
    normal_quartic = sum(size * c for top, (size, c) in rows.items() if top != 0)
    result = {
        "top_count_including_zero": sum(size for size, _ in rows.values()),
        "representative_count_including_zero": len(rows),
        "completed_lower_trials": len(rows) << 23,
        "representatives_with_quartic_bent": sum(bool(c) for top, (_, c) in rows.items() if top),
        "tops_with_quartic_bent": sum(size for top, (size, c) in rows.items() if top and c),
        "listed_normalized_quartics_on_representatives": sum(c for top, (_, c) in rows.items() if top),
        "normalized_counts_by_exact_degree": {2: 16, 3: 14320, 4: normal_quartic},
        "all_counts_with_invariant_affine_terms": {2: 64, 3: 57280, 4: 4 * normal_quartic},
    }
    args.output.write_text(json.dumps(result, indent=2) + "\n")
    print(json.dumps(result, indent=2))


if __name__ == "__main__":
    main()
