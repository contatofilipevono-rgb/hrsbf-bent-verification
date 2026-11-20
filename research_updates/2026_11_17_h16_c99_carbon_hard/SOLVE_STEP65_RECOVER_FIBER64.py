"""Step 65: resume only missing Step 64 prefixes and certify exact reduced-fiber coverage.

Consumes immutable artifacts from GitHub Actions run 44597394429; does not rerun
the 1,000 completed prefixes. The result is restricted to B0_11 fiber=64 only.
"""
from concurrent.futures import ThreadPoolExecutor
import hashlib
import json
import os
from pathlib import Path
import sys
import time

from SOLVE_STEP63_FIBER_CENSUS import gather
from SOLVE_STEP64_FULL_FIBER_CENSUS import scan

OLD_DIR = Path("old")
FIBER_PATH = Path("fiber/step60_fiber.json")
TOTAL_PREFIXES = 1024
VISITS_PER_PREFIX = 1 << 24
EXPECTED_MISSING = set(range(48, 64)) | set(range(568, 576))
RECOVERY_SHARDS = 4


def load_problem():
    raw = FIBER_PATH.read_bytes()
    data = json.loads(raw)
    assert data["variables"] == 59 and data["original_count"] == 63
    polys = data["polynomials"][:data["original_count"]]
    return raw, polys


def valid_row(row, polys, prefix):
    assert row["prefix"] == prefix
    assert row["visited"] == VISITS_PER_PREFIX
    assert row["survivors"] == len(row["models"])
    assert row["cross_checks"] >= 1024
    digest = hashlib.sha256(gather(polys, 24, prefix).encode("ascii")).hexdigest()
    assert row["slice_sha256"] == digest, ("slice hash mismatch", prefix)
    for model in row["models"]:
        assert isinstance(model, int) and 0 <= model < (1 << 59)
        assert all(sum((m & model) == m for m in f) % 2 == 0 for f in polys)
    return row


def read_old(polys, source_hash):
    files = sorted(OLD_DIR.glob("step64_shard_*.json"))
    assert len(files) == 16, ("old artifacts missing", [p.name for p in files])
    rows = {}
    source_hashes = set()
    for path in files:
        bundle = json.loads(path.read_text())
        shard = bundle["shard"]
        assert 0 <= shard < 16
        assert path.stem == f"step64_shard_{shard:02}"
        assert bundle["fiber"] == 64
        source_hashes.add(bundle["input_sha256"])
        for row in bundle["results"]:
            prefix = row["prefix"]
            assert 64 * shard <= prefix < 64 * (shard + 1)
            assert prefix not in rows
            rows[prefix] = valid_row(row, polys, prefix)
    assert source_hashes == {source_hash}
    missing = set(range(TOTAL_PREFIXES)) - set(rows)
    assert missing == EXPECTED_MISSING, ("unexpected missing set", sorted(missing))
    assert len(rows) == 1000
    return rows


def run_shard(shard):
    assert 0 <= shard < RECOVERY_SHARDS
    raw, polys = load_problem()
    source_hash = hashlib.sha256(raw).hexdigest()
    old = read_old(polys, source_hash)
    remaining = sorted(set(range(TOTAL_PREFIXES)) - set(old))
    targets = remaining[shard::RECOVERY_SHARDS]
    assert len(targets) == 6
    path = Path(f"step65_recovery_{shard:02}.json")
    result = {"shard": shard, "fiber": 64, "input_sha256": source_hash,
              "targets": targets, "results": []}
    start = time.monotonic()
    with ThreadPoolExecutor(max_workers=2) as pool:
        for row in pool.map(lambda p: scan(polys, p), targets):
            valid_row(row, polys, row["prefix"])
            result["results"].append(row)
            path.write_text(json.dumps(result))
            print("STEP65_PROGRESS", json.dumps({
                "shard": shard, "complete": len(result["results"]),
                "target": row["prefix"], "survivors": row["survivors"]}), flush=True)
    assert [r["prefix"] for r in result["results"]] == targets
    result["wall_seconds"] = round(time.monotonic()-start, 2)
    path.write_text(json.dumps(result))
    print("STEP65_SHARD_COMPLETE", json.dumps({
        "shard": shard, "prefixes": len(targets),
        "survivors": sum(r["survivors"] for r in result["results"])}), flush=True)


def collect():
    raw, polys = load_problem()
    source_hash = hashlib.sha256(raw).hexdigest()
    old = read_old(polys, source_hash)
    rows = dict(old)
    files = sorted(Path("recoveries").glob("step65_recovery_*.json"))
    assert len(files) == RECOVERY_SHARDS
    for idx, path in enumerate(files):
        assert path.stem == f"step65_recovery_{idx:02}"
        bundle = json.loads(path.read_text())
        assert bundle["fiber"] == 64 and bundle["shard"] == idx
        assert bundle["input_sha256"] == source_hash
        expected = sorted(EXPECTED_MISSING)[idx::RECOVERY_SHARDS]
        assert bundle["targets"] == expected
        assert [r["prefix"] for r in bundle["results"]] == expected
        for row in bundle["results"]:
            prefix = row["prefix"]
            assert prefix not in rows
            rows[prefix] = valid_row(row, polys, prefix)
    assert sorted(rows) == list(range(TOTAL_PREFIXES))
    assert sum(r["visited"] for r in rows.values()) == 1 << 34
    survivor_count = sum(r["survivors"] for r in rows.values())
    result = {
        "scope": "B0_11 reduced fiber 64 only; not global H(16,4)",
        "source_run": 44597394429, "source_input_sha256": source_hash,
        "old_verified_prefixes": len(old),
        "new_verified_prefixes": len(rows)-len(old),
        "total_prefixes": len(rows), "visited": 1 << 34,
        "survivor_count": survivor_count,
        "full_unsat_for_this_reduced_fiber": survivor_count == 0,
        "cross_checks": sum(r["cross_checks"] for r in rows.values()),
        "warning": "Requires separately audited equivalence of the reduced equations and the original cell."
    }
    Path("step65_fiber64_summary.json").write_text(json.dumps(result, indent=2) + "\n")
    print("STEP65_COVERAGE_CERT", json.dumps(result), flush=True)


if __name__ == "__main__":
    if len(sys.argv) == 2 and sys.argv[1] == "collect":
        collect()
    elif len(sys.argv) == 1:
        run_shard(int(os.environ["H16_RECOVERY_SHARD"]))
    else:
        raise SystemExit("usage: script.py [collect]")
