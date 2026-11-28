#!/usr/bin/env python3
"""Replay the canonical K=0 root and split residuals by verified algebraic cascades."""
import argparse
import hashlib
import json
from pathlib import Path
import time

from SOLVE_B000_K0_RECERT_GAPS import build_k0_canonical_root, s9, s16, s45a
import SOLVE_STEP19_ZEROTRUST_AUDIT_AND_TRUE_WESS_CRUSH as s19
import SOLVE_STEP22A_B000_ENUM_CLOSE_ETA62_63_42_AND_ETA0 as s22a

ROOT_SHA = "71e50178f909fd6749333ca043eb96b4514a6d77d6dc0c6d0bcf2ea4b8e0c655"


def require(condition, message):
    if not condition:
        raise ValueError(message)


def digest(data):
    return hashlib.sha256(json.dumps(data, sort_keys=True).encode()).hexdigest()


def assignments(forms, value):
    return [(form, value >> i & 1) for i, form in enumerate(forms)]


def truth_table(n, rows):
    return [y for y in range(1 << n)
            if all(sum(y & m == m for m in row) % 2 == 0 for row in rows)]


def source_prefix(eta):
    source = Path(__file__).parent / "certs" / "k0_recert_source.json"
    shards = sorted((r for r in json.loads(source.read_text())["pending"]
                     if r["eta_rep"] == eta), key=lambda r: r["lo"])
    require(shards, "Missing first-level certificates")
    fix = [int(f, 16) for f in shards[0]["fix_forms_hex"]]
    fingerprint = hashlib.sha256(",".join(map(hex, fix)).encode()).hexdigest()[:16]
    opened, cursor = [], 0
    for row in shards:
        leaves = [leaf["rb"] for leaf in row["open_survivors"]]
        require(row["root_sha256"] == ROOT_SHA and row["fix_sha256"] == fingerprint
                and row["fix_forms_hex"] == shards[0]["fix_forms_hex"]
                and row["eta_free_hex"] == shards[0]["eta_free_hex"]
                and row["lo"] == cursor and cursor < row["hi"]
                and row["hi"] - cursor == row["covered_branches"] == row["verified_subst_branches"]
                == row["direct_closed"] + row["rescued_closed"] + len(leaves)
                and len(set(leaves)) == len(leaves)
                and all(cursor <= rb < row["hi"] for rb in leaves),
                "First-level partition failed verification")
        cursor = row["hi"]
        opened.extend(leaves)
    require(cursor == 1 << len(fix), "First-level coverage incomplete")
    return fix, fingerprint, shards[0]["eta_free_hex"], opened


class Replay:
    def __init__(self, eta, *, deadline, max_depth):
        self.eta = eta
        self.deadline = deadline
        self.max_depth = max_depth
        self.cascade_calls = 0
        self.fix, self.fix_sha, eta_hex, self.opened = source_prefix(eta)
        root, eta_forms, sha, self.lib9, self.lib_sh, _, self.tbl = build_k0_canonical_root(
            "k0_wess_eta" + str(eta))
        require(sha == ROOT_SHA and list(map(hex, eta_forms)) == eta_hex,
                "Canonical root or eta forms differ")
        self.eta_state = self.cascade(root, assignments(eta_forms, eta))
        require("_quad_ids" in self.eta_state and not self.eta_state["closed_unsat"],
                "Expected eta residual")
        info = self.minrank(self.eta_state)
        fix, _, sha = s45a.build_fix_and_rescue_forms(info, len(self.fix))
        require(list(fix) == self.fix and sha == self.fix_sha, "Step 45A prefix differs")

    def cascade(self, state, extra):
        self.cascade_calls += 1
        return s9.run_branch_cascade(
            self.lib9, state["_buf"], state["_quad_ids"], state["_cub_ids"],
            state["_lin_pivs"], extra, self.tbl, max_xl_rounds=25, verify_subst=True)

    def minrank(self, state):
        return s45a.extract_minrank_basis_for_state(
            "k0_wess", state, self.lib9, self.lib_sh, self.tbl, rng_seed=4300 + self.eta)

    def pure_w(self, state):
        quads = [s9.row_to_pset(state["_buf"], row, self.tbl) for row in state["_quad_ids"]]
        if not quads:
            return [], [], []
        rref = s19.strict_rref_masks(list(s16.analyze_quad_system(quads)["W_piv"].values()))
        pivots, rows = s22a.extract_pure_w_quads(self.lib_sh, state, rref, self.tbl)
        return pivots, [rref[i] for i in pivots], rows

    def eta_one_domain(self, rb):
        pivots, forms, rows = self.pure_w(self.eta_state)
        require(len(forms) == 12, "Expected 12 W coordinates")
        all_models = truth_table(len(forms), rows)
        require(len(all_models) == 288, "Expected 288 pure W models")
        masks = []
        for fix in self.fix:
            selected = [j for j, p in enumerate(pivots) if fix >> p & 1]
            recovered = 0
            for j in selected:
                recovered ^= forms[j]
            require(recovered == fix, "Step 45A form lies outside W")
            masks.append(sum(1 << j for j in selected))
        models = [w for w in all_models if all((w & m).bit_count() % 2 == bit
                  for m, bit in assignments(masks, rb))]
        return forms, {"forms_hex": list(map(hex, forms)), "quadratics": rows,
                       "full_model_count": len(all_models), "full_model_sha256": digest(all_models),
                       "prefix_masks": masks, "models": models}

    def resolve(self, state, depth=0):
        if state["closed_unsat"]:
            return {"method": "cascade_contradiction", "closed": True,
                    "reason": state["closed_by"], "rounds": state["rounds"]}
        if "_quad_ids" not in state:
            return {"method": "cascade_round_limit", "closed": False}
        profile = {"active": self.tbl["n"] - len(state["_lin_pivs"]),
                   "quadratics": len(state["_quad_ids"]), "cubics": len(state["_cub_ids"])}
        if time.monotonic() >= self.deadline or depth >= self.max_depth:
            return {"method": "budget", "closed": False, "state": profile}

        _, forms, rows = self.pure_w(state)
        profile["dim_w"] = len(forms)
        if not forms:
            return {"method": "no_w", "closed": False, "state": profile}
        # Step 22A/27A/28A: exhaust the exact pure W domain when small.
        models = truth_table(len(forms), rows) if len(forms) <= 16 else None
        if models is not None and len(models) <= 64:
            method = "pure_w_exhaustion"
            domain = {"forms_hex": list(map(hex, forms)), "quadratics": rows, "points": models}
        else:
            # Step 45A MinRank: keep the low-rank directions free, split on
            # independent forms in their annihilator and visit every assignment.
            info = self.minrank(state)
            require(info["nW"] == len(forms), "Inconsistent W dimension")
            nfix = min(3, len(forms))
            forms, _, _ = s45a.build_fix_and_rescue_forms(info, nfix)
            require(len(s19.strict_rref_masks(forms)) == nfix, "Dependent MinRank split")
            models = list(range(1 << nfix))
            method = "minrank_partition"
            domain = {"forms_hex": list(map(hex, forms)), "points": models,
                      "low_rank_basis_dim": info["low_bas_dim"]}
        print("BRANCH", depth, method, profile, len(models), flush=True)
        children = []
        for value in models:
            if time.monotonic() >= self.deadline:
                break
            result = self.resolve(self.cascade(state, assignments(forms, value)), depth + 1)
            children.append({"value": value, "proof": result})
        open_values = sorted(set(models) - {c["value"] for c in children if c["proof"]["closed"]})
        return {"method": method, "closed": not open_values, "state": profile,
                "domain": domain, "children": children, "open_values": open_values}


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--eta", type=int, default=1)
    p.add_argument("--rb", type=int, required=True)
    p.add_argument("--w", type=int)
    p.add_argument("--depth", type=int, default=3)
    p.add_argument("--seconds", type=int, default=1200)
    p.add_argument("--out", type=Path, required=True)
    p.add_argument("--verify", type=Path, help="Rebuild and compare a completed certificate")
    args = p.parse_args()
    require(args.depth >= 1 and args.seconds > 0, "Invalid bounds")
    started = time.monotonic()
    replay = Replay(args.eta, deadline=started + args.seconds, max_depth=args.depth)
    require(args.rb in replay.opened, "Prefix is not open in the source partition")
    prefix = replay.cascade(replay.eta_state, assignments(replay.fix, args.rb))
    report = {"schema": 1, "eta_rep": args.eta, "rb": args.rb, "target_w": args.w,
              "root_sha256": ROOT_SHA, "fix_sha256": replay.fix_sha,
              "conditional_on": "C5", "verify_subst": True, "max_depth": args.depth}
    if args.eta == 1 and not prefix["closed_unsat"]:
        require("_quad_ids" in prefix, "Prefix cascade did not reach a reusable state")
        forms, domain = replay.eta_one_domain(args.rb)
        report["first_w_domain"] = domain
        models = domain["models"]
        if args.rb == 199:
            require(models == [271, 775, 2495], "Unexpected leaf 199 domain")
        if args.w is not None:
            require(args.w in models, "Target W outside the exact domain")
        targets = [args.w] if args.w is not None else models
        children = []
        for w in targets:
            print("TARGET", args.eta, args.rb, w, flush=True)
            proof = replay.resolve(replay.cascade(prefix, assignments(forms, w)))
            children.append({"w": w, "proof": proof})
        report["children"] = children
        report["open_survivors"] = [c["w"] for c in children if not c["proof"]["closed"]]
        if args.w is not None:
            report["other_w_models"] = [w for w in models if w != args.w]
    else:
        require(args.w is None, "Unexpected W argument for this prefix")
        report["proof"] = replay.resolve(prefix)
        report["open_survivors"] = [] if report["proof"]["closed"] else [args.rb]
    report["verified_cascade_calls_after_root"] = replay.cascade_calls
    report["sha256"] = digest(report)
    args.out.parent.mkdir(parents=True, exist_ok=True)
    pending = args.out.with_suffix(".tmp")
    pending.write_text(json.dumps(report, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    pending.replace(args.out)
    if args.verify:
        require(not report["open_survivors"], "Cannot verify an open certificate as closed")
        require(report == json.loads(args.verify.read_text()), "Certificate does not replay exactly")
    print("SUMMARY", json.dumps({k: report[k] for k in (
        "eta_rep", "rb", "target_w", "open_survivors", "verified_cascade_calls_after_root", "sha256"
    )}), flush=True)


if __name__ == "__main__":
    main()
