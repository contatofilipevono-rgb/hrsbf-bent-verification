#!/usr/bin/env python3
"""Consolidate replayed K=0 branch certificates against the Step 45A source coverage."""
import argparse
import hashlib
import json
from pathlib import Path


ROOT = "71e50178f909fd6749333ca043eb96b4514a6d77d6dc0c6d0bcf2ea4b8e0c655"


def require(ok, message):
    if not ok:
        raise ValueError(message)


def digest(value):
    return hashlib.sha256(json.dumps(value, sort_keys=True).encode()).hexdigest()


def points(forms, quads=()):
    return [x for x in range(1 << len(forms))
            if all(sum((x & monomial) == monomial for monomial in row) % 2 == 0 for row in quads)]


def check_tree(proof):
    method = proof["method"]
    require(proof["closed"] is True, "Open child in claimed closed tree")
    if method == "cascade_contradiction":
        require(bool(proof.get("reason")) and proof["rounds"] >= 0, "Invalid contradiction record")
        return
    require(method in {"pure_w_exhaustion", "minrank_partition", "cubic_partition"},
            "Unrecognized branch rule")
    domain = proof["domain"]
    forms = [int(f, 16) for f in domain["forms_hex"]]
    require(0 < len(forms) <= 16, "Unexpected branch width")
    span = {0}
    for form in forms:
        require(form not in span, "Dependent branch forms")
        span |= {x ^ form for x in span}
    expected = points(forms, domain["quadratics"] if method == "pure_w_exhaustion" else ())
    require(domain["points"] == expected and not proof["open_values"]
            and [child["value"] for child in proof["children"]] == expected,
            "Incomplete proof tree")
    for child in proof["children"]:
        check_tree(child["proof"])


def check_leaf(cert, shards):
    require(cert["root_sha256"] == ROOT and cert["fix_sha256"] == shards[0]["fix_sha256"]
            and cert["verify_subst"] is True and cert["conditional_on"] == "C5"
            and cert["target_w"] is None and cert["open_survivors"] == []
            and cert["verified_cascade_calls_after_root"] >= 2, "Invalid root or incomplete leaf")
    sha = cert["sha256"]
    require(digest({k: v for k, v in cert.items() if k != "sha256"}) == sha, "Leaf hash mismatch")
    if "first_w_domain" not in cert:
        check_tree(cert["proof"])
        return
    domain = cert["first_w_domain"]
    forms = [int(f, 16) for f in domain["forms_hex"]]
    raw = points(forms, domain["quadratics"])
    require(len(forms) == 12 and len(raw) == domain["full_model_count"] == 288
            and digest(raw) == domain["full_model_sha256"], "Invalid eta=1 W truth table")
    require(len(domain["prefix_masks"]) == len(shards[0]["fix_forms_hex"]),
            "Missing prefix directions")
    for wm, fx in zip(domain["prefix_masks"], shards[0]["fix_forms_hex"]):
        value = 0
        for j, f in enumerate(forms):
            if wm >> j & 1:
                value ^= f
        require(value == int(fx, 16), "W prefix map mismatch")
    expected = [w for w in raw if sum(((w & m).bit_count() % 2) << j
                for j, m in enumerate(domain["prefix_masks"])) == cert["rb"]]
    require(expected == domain["models"] == [c["w"] for c in cert["children"]],
            "Incomplete first W domain")
    for child in cert["children"]:
        check_tree(child["proof"])


def candidates(download):
    for path in sorted(download.glob("*/cert.json")):
        yield path, path.with_name("replayed.json")
    for path in sorted(download.glob("*/cert/rb*.json")):
        yield path, path.parents[1] / "replayed" / path.name


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--certs", type=Path, required=True)
    parser.add_argument("downloads", type=Path, nargs="+")
    args = parser.parse_args()
    target = args.certs
    raw = json.loads((target / "k0_recert_source.json").read_text())
    by_eta = {eta: sorted((s for s in raw["pending"] if s["eta_rep"] == eta), key=lambda s: s["lo"])
              for eta in (1, 22, 23, 43)}
    pending = {}
    for eta, shards in by_eta.items():
        cursor, pending[eta] = 0, set()
        for s in shards:
            leaves = {l["rb"] for l in s["open_survivors"]}
            require(s["root_sha256"] == ROOT and s["fix_sha256"] == shards[0]["fix_sha256"]
                    and s["fix_forms_hex"] == shards[0]["fix_forms_hex"] and s["lo"] == cursor
                    and s["hi"] - cursor == s["covered_branches"] == s["verified_subst_branches"]
                    == s["direct_closed"] + s["rescued_closed"] + len(leaves)
                    and len(leaves) == len(s["open_survivors"])
                    and all(cursor <= rb < s["hi"] for rb in leaves), "Source coverage mismatch")
            cursor = s["hi"]
            pending[eta].update(leaves)
        require(cursor == 1 << len(shards[0]["fix_forms_hex"]), "Incomplete source partition")
    accepted = {eta: {} for eta in by_eta}
    pairs = [(p, p) for p in sorted(target.glob("cert_k0_eta*_rb*.json")) if "_w" not in p.stem]
    for directory in args.downloads:
        pairs.extend(candidates(directory))
    for path, repeated in pairs:
        if not repeated.is_file():
            continue
        content = path.read_bytes()
        require(content == repeated.read_bytes(), "Certificate changed on replay")
        cert = json.loads(content)
        eta, rb = cert["eta_rep"], cert["rb"]
        require(eta in pending and rb in pending[eta], "Leaf outside source partition")
        check_leaf(cert, by_eta[eta])
        if rb in accepted[eta]:
            continue
        name = f"cert_k0_eta{eta:02d}_rb{rb}.json"
        (target / name).write_bytes(content)
        accepted[eta][rb] = name
    result = {}
    for eta, leaves in pending.items():
        remaining = sorted(leaves - set(accepted[eta]))
        report = {"eta_rep": eta, "root_sha256": ROOT,
                  "fix_sha256": by_eta[eta][0]["fix_sha256"], "verify_subst": True,
                  "conditional_on": "C5", "first_level_source": "k0_recert_source.json",
                  "second_level_certificates": accepted[eta], "open_survivors": remaining}
        stem = "cert" if not remaining else "progress"
        path = target / f"{stem}_k0_eta{eta:02d}.json"
        path.write_text(json.dumps(report, indent=2, sort_keys=True) + "\n", encoding="utf-8")
        result[eta] = {"verified": len(accepted[eta]), "open": len(remaining), "summary": path.name}
    path = target / "k0_algebraic_rollup.json"
    path.write_text(json.dumps(result, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    print(json.dumps(result, sort_keys=True))


if __name__ == "__main__":
    main()
