"""Check B0_00 sector accounting against CI artifacts, including eta coordinate alignment."""

import argparse
import json
from pathlib import Path


def read_records(root, pattern):
    return [json.loads(p.read_text(encoding="utf-8")) for p in sorted(root.rglob(pattern))]


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("root", type=Path)
    parser.add_argument("profile", type=Path)
    args = parser.parse_args()
    atlas, = read_records(args.root, "step34_b000_multipliers.json")
    profile = json.loads(args.profile.read_text(encoding="utf-8"))
    assert atlas["eta_forms"] == profile["eta_forms"]
    eta_forms = atlas["eta_forms"]

    root_scan = read_records(args.root, "step31_b000_scan_*.json")
    assert len(root_scan) == 16 and all(x["eta_forms"] == eta_forms for x in root_scan)
    root_data = [r for s in root_scan for r in s["summary"]]
    assert sorted(s["eta"] for s in root_data) == list(range(2, 64))
    direct = {s["eta"] for s in root_data if s["status"] == "root_unsat"}

    first = read_records(args.root, "step29_b000_eta1_*.json")
    assert sorted(x["shard"] for x in first) == list(range(8))
    assert all(x["anchor"] == profile["anchor"] and x["models"] == len(profile["models"])
               for x in first)
    first_vals = [y for x in first for y in x["assigned"]]
    assert sorted(first_vals) == profile["models"]
    assert all(not x["open"] and x["direct_closed"] + x["recursive_closed"] +
               len(x["balance_closed"]) == len(x["assigned"]) for x in first)

    focused = read_records(args.root, "step33_b000_eta*.json")
    assert len(focused) == 15 and all(x["eta_forms"] == eta_forms for x in focused)
    leaves = [c for data in focused for c in data["summary"]]
    extra = set()
    for eta in sorted({c["eta"] for c in leaves}):
        parts = [c for c in leaves if c["eta"] == eta]
        assert sorted(c["shard"] for c in parts) == [0, 1, 2]
        assert len({c["anchor"] for c in parts}) == 1
        assert {c["cases"] for c in parts} == {6}
        assert all(c["status"] == "shard_unsat" and c["tested"] == len(c["assigned"]) and
                   not c["remaining"] for c in parts)
        assert len({i for c in parts for i in c["assigned"]}) == 6
        assert sum(len(c["assigned"]) for c in parts) == 6
        extra.add(eta)

    by_k = {m["k"]: m["eta_images"] for m in atlas["maps"]}
    assert sorted(by_k) == list(range(1, 16, 2))
    for k in by_k:
        assert sorted(by_k[k]) == list(range(64))
        for j in by_k:
            assert by_k[k * j % 16] == [by_k[k][x] for x in by_k[j]]

    closed = direct | extra | {1}
    open_orbits = {}
    for eta in range(64):
        if eta not in closed:
            orbit = sorted({by_k[k][eta] for k in by_k})
            assert not (closed & set(orbit))
            open_orbits[orbit[0]] = orbit
    result = {"closed": sorted(closed), "root_closed": sorted(direct), "new_focused": sorted(extra),
              "open_sectors": 64 - len(closed), "open_orbits": list(open_orbits.values())}
    print("STEP35_VERIFIED " + json.dumps(result), flush=True)
    Path("step35_b000_ledger.json").write_text(json.dumps(result, indent=2), encoding="utf-8")


if __name__ == "__main__":
    main()
