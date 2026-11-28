"""Check structural coverage of K=0 recertification reports without running SAT."""
import argparse
import hashlib
import json
from pathlib import Path
import re

ROOT = "71e50178f909fd6749333ca043eb96b4514a6d77d6dc0c6d0bcf2ea4b8e0c655"
CLOSED = {1, 3, 21, 22, 23, 27, 43, 62, 63}

def require(ok, message):
    if not ok:
        raise ValueError(message)

def proof_record(r):
    return r.get("status") == "DRAT_VERIFIED" and all(
        re.fullmatch(r"[0-9a-f]{64}", r.get(key, "")) for key in ("cnf_sha256", "drat_sha256")
    ) and isinstance(r.get("proof"), str)

def closed_leaf(r):
    if r.get("status") == "CASCADE_CONTRADICTION":
        return isinstance(r.get("closed_by"), str)
    if proof_record(r):
        return True
    if r.get("status") == "W_EXHAUSTED":
        return proof_record(r["coverage"]) and all(closed_leaf(c) for c in r["children"])
    if r.get("status") == "W_TRUTH_TABLE_EXHAUSTED":
        return len(r.get("forms", [])) == 12 and all(closed_leaf(c) for c in r["children"])
    return False

def check_coverage(source, cert, eta):
    roots = {row["root_sha256"] for row in source}
    require(roots == {ROOT} and cert["root_sha256"] == ROOT, "Root mismatch")
    forms = source[0]["fix_forms_hex"]
    fix = hashlib.sha256(",".join(forms).encode()).hexdigest()[:16]
    total = 1 << len(forms)
    cursor = 0
    pending = set()
    for row in sorted(source,key=lambda x:x.get("lo",0)):
        hi = row.get("hi", total)
        require(row["fix_forms_hex"] == forms and row["fix_sha256"] == fix
                and row.get("lo",0)==cursor and row["covered_branches"] == hi-cursor
                == row["verified_subst_branches"] == row["direct_closed"] + row["rescued_closed"]
                + len(row["open_survivors"]), "Source prefix mismatch")
        opened = [y["rb"] for y in row["open_survivors"]]
        require(len(set(opened))==len(opened) and all(cursor<=v<hi for v in opened),
                "Invalid open leaf in source")
        pending.update(opened)
        cursor=hi
    require(cursor==total, "Incomplete initial domain")
    accepted=set()
    for r in cert.get("replays",[]):
        require(r["root_sha256"]==ROOT and r["fix_sha256"]==fix
                and r["eta_rep"]==eta and r["verify_subst"] is True,"Replay mismatch")
        checked={v["rb"]:v for v in r["results"]}
        require(len(checked)==len(r["results"]) and set(checked)==set(r["selected"])
                and set(checked)<=pending, "Unexpected replay domain")
        require(set(r["open_survivors"])=={i for i,v in checked.items() if not closed_leaf(v)},
                "Replay verdict mismatch")
        accepted.update(i for i,v in checked.items() if closed_leaf(v))
    remaining = sorted(pending-accepted)
    require(remaining==cert["open_survivors"], "Combined open survivor set differs")
    return remaining

def main():
    p=argparse.ArgumentParser()
    p.add_argument("directory",type=Path)
    args=p.parse_args()
    d=args.directory
    raw=json.loads((d/"k0_recert_source.json").read_text())
    sources=raw["completed"]+raw["pending"]
    failed={}
    for eta in sorted(CLOSED):
        p=d/f"cert_k0_eta{eta:02d}.json"
        if not p.exists():
            failed[eta]="certificate absent"
            continue
        cert=json.loads(p.read_text())
        pending=check_coverage([r for r in sources if r["eta_rep"]==eta], cert, eta)
        if pending:
            failed[eta]=pending
    print(json.dumps({"covered_orbits": 9-len(failed), "outstanding": failed}))
    require(not failed, "Coverage remains incomplete")

if __name__ == "__main__":
    main()
