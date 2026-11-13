"""Aggregate the phase-plane certificate for V1 (n=12, degree 4).

Inputs: spaces.json (plane_cert.py, levels H0 and H4 for all 256 polar classes) and the slice
reports of enum_slice.py.  Checks coverage: every class is empty, closed by identity, or fully
enumerated (all slices of its affine space present, no violation).  Optional control: compare
admissible counts per class with the catalog (used only after the certificate is complete).
"""
import json, argparse, hashlib
from collections import Counter, defaultdict
from pathlib import Path


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("spaces"); ap.add_argument("slices", nargs="+")
    ap.add_argument("--catalog"); ap.add_argument("--out")
    a = ap.parse_args()
    S = json.loads(Path(a.spaces).read_text())
    assert sorted(map(int, S)) == list(range(256)), "classes missing in spaces.json"
    rep = defaultdict(list)
    for f in a.slices:
        for r in json.loads(Path(f).read_text()):
            rep[r["class"]].append(r)
    status = {}; adm = Counter(); problems = []
    for k in range(256):
        h4 = S[str(k)]["H4"]
        if h4.get("empty"):
            status[k] = "empty"
            continue
        if h4["nonzero_coefficients"] == 0:
            status[k] = "identity"
        rs = rep.get(k, [])
        if status.get(k) != "identity":
            if not rs:
                problems.append(f"class {k}: residue but no enumeration"); continue
            fix = {r["fix"] for r in rs}
            assert len(fix) == 1, k
            f = fix.pop()
            got = sorted(r["slice"] for r in rs)
            if got != list(range(1 << f)):
                problems.append(f"class {k}: slices {len(got)} of {1 << f}"); continue
            assert all(r["dim"] + r["fix"] == h4["dim"] for r in rs)
            v = sum(r["violations"] for r in rs)
            if v:
                problems.append(f"class {k}: {v} violations, witness {[r['witness'] for r in rs if r['witness']]}")
            status[k] = "enumerated" if not v else "VIOLATION"
        adm[k] = sum(r["admissible"] for r in rs)
    out = {"status_counts": Counter(status.values()), "problems": problems,
           "admissible_by_class": {k: v for k, v in adm.items() if v},
           "total_admissible": sum(adm.values()),
           "identity_classes": [k for k, s in status.items() if s == "identity"],
           "enumerated_classes": [k for k, s in status.items() if s == "enumerated"]}
    if a.catalog:
        cat = Counter(int(l) >> 25 for l in Path(a.catalog).read_text().split())
        out["catalog_control"] = {
            "catalog_total": sum(cat.values()),
            "mismatch": {k: [adm.get(k, 0), cat.get(k, 0)] for k in range(256)
                         if adm.get(k, 0) != cat.get(k, 0) and status.get(k) == "enumerated"},
            "catalog_classes_not_enumerated": {k: [status.get(k), cat[k]] for k in cat
                                               if status.get(k) != "enumerated"}}
    print(json.dumps(out, indent=1, default=int))
    if a.out:
        Path(a.out).write_text(json.dumps(out, indent=1, default=int))
    assert not problems, problems


if __name__ == "__main__":
    main()
