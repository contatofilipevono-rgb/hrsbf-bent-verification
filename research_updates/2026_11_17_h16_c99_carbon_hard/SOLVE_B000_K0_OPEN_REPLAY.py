#!/usr/bin/env python3
"""Targeted K=0 replay of the open prefix assignments from run 46077594419."""
import argparse
import hashlib
from itertools import combinations, product
import json
import multiprocessing
from pathlib import Path
import subprocess

from pysat.solvers import Solver

from SOLVE_B000_K0_RECERT_GAPS import build_k0_canonical_root, s9, s16, s45a
import SOLVE_STEP19_ZEROTRUST_AUDIT_AND_TRUE_WESS_CRUSH as s19
import SOLVE_STEP22A_B000_ENUM_CLOSE_ETA62_63_42_AND_ETA0 as s22a

ROOT_SHA = "71e50178f909fd6749333ca043eb96b4514a6d77d6dc0c6d0bcf2ea4b8e0c655"
CTX = {}

def require(test, message):
    if not test:
        raise ValueError(message)

def terms(mask):
    while mask:
        bit = mask & -mask
        yield bit.bit_length()
        mask ^= bit

def encode(polynomials, primaries):
    """CNF defining each AND monomial, followed by exact XOR-to-CNF chains."""
    clauses, monomials = [], {}
    top = primaries

    def new_var():
        nonlocal top
        top += 1
        return top

    def short_xor(lits, rhs):
        for values in product((0, 1), repeat=len(lits)):
            if sum(values) % 2 != rhs:
                clauses.append([-lit if value else lit for lit, value in zip(lits, values)])

    for equation in polynomials:
        lits = []
        for monomial in sorted(equation - {0}):
            factors = list(terms(monomial))
            if len(factors) == 1:
                lits.append(factors[0])
            else:
                if monomial not in monomials:
                    v = new_var()
                    monomials[monomial] = v
                    clauses.extend([-v, f] for f in factors)
                    clauses.append([v, *(-f for f in factors)])
                lits.append(monomials[monomial])
        while len(lits) > 4:
            v = new_var()
            short_xor(lits[:3] + [v], 0)
            lits = [v] + lits[3:]
        short_xor(lits, int(0 in equation))
    return top, clauses

def proof_attempt(polynomials, n, stem, max_conflicts, block=()):
    top, cnf = encode(polynomials, n)
    cnf.extend(block)
    with Solver(name="cadical195", bootstrap_with=cnf, with_proof=True) as solver:
        solver.conf_budget(max_conflicts)
        ret = solver.solve_limited()
        if ret is True:
            model = solver.get_model()
            x = sum(1 << (v-1) for v in model if 0 < v <= n)
            require(all(sum(x & m == m for m in eq) % 2 == 0 for eq in polynomials),
                    "SAT model fails source polynomials")
            return {"status": "SAT", "model": hex(x)}
        if ret is None:
            return {"status": "UNKNOWN"}
        proof = solver.get_proof()
    out = CTX["out"]
    formula = out / (stem + ".cnf")
    drat = out / (stem + ".drat")
    formula.write_text("p cnf {} {}\n".format(top, len(cnf)) +
                       "".join(" ".join(map(str, clause)) + " 0\n" for clause in cnf),
                       encoding="ascii")
    drat.write_text("\n".join(proof) + "\n", encoding="ascii")
    check = subprocess.run([CTX["drat_trim"], str(formula), str(drat), "-q"],
                           text=True, capture_output=True, timeout=120)
    require(check.returncode == 0 and "s VERIFIED" in check.stdout,
            "DRAT verifier rejected proof: " + check.stdout[-1000:] + check.stderr[-1000:])
    return {"status": "DRAT_VERIFIED", "cnf_sha256": hashlib.sha256(formula.read_bytes()).hexdigest(),
            "drat_sha256": hashlib.sha256(drat.read_bytes()).hexdigest(), "proof": stem}

def cascade(state, extra, rounds=25):
    return s9.run_branch_cascade(CTX["lib9"], state["_buf"], state["_quad_ids"], state["_cub_ids"],
                                 state["_lin_pivs"], extra, CTX["tbl"], max_xl_rounds=rounds,
                                 verify_subst=True)

def residual(state):
    rows = [set(s9.row_to_pset(state["_buf"], r, CTX["tbl"]))
            for r in state["_quad_ids"] + state["_cub_ids"]]
    for mask, value in state["_lin_pivs"].values():
        row = {1 << (i-1) for i in terms(mask)}
        if value:
            row.add(0)
        rows.append(row)
    return rows

def solve_leaf(state, stem, depth):
    if state["closed_unsat"]:
        return {"status": "CASCADE_CONTRADICTION", "closed_by": state.get("closed_by")}
    if "_quad_ids" not in state:
        return {"status": "UNKNOWN_CASCADE"}
    if depth and state["_quad_ids"]:
        tbl = CTX["tbl"]
        quads = [s9.row_to_pset(state["_buf"], r, tbl) for r in state["_quad_ids"]]
        w_basis = s19.strict_rref_masks(list(s16.analyze_quad_system(quads)["W_piv"].values()))
        if 0 < len(w_basis) <= 24:
            indexes, pure = s22a.extract_pure_w_quads(CTX["lib_sh"], state, w_basis, tbl)
            forms = [w_basis[i] for i in indexes]
            require(all(m.bit_count() <= 2 for q in pure for m in q), "Non-quadratic W projection")
            exhaust, models, _ = s22a.enumerate_pure_w_models(pure, len(forms), max_models=65, time_budget=2)
            if exhaust and len(models) <= 64:
                # Reprove exhaustive coverage of the proposed W models with independently encoded CNF.
                block = [[-i if y >> (i-1) & 1 else i for i in range(1, len(forms)+1)] for y in models]
                check = proof_attempt([set(q) for q in pure], len(forms), stem + "-coverage",
                                      CTX["conflicts"], block)
                if check["status"] == "DRAT_VERIFIED":
                    children = []
                    for y in models:
                        sub = cascade(state, [(m, y >> i & 1) for i,m in enumerate(forms)])
                        result = solve_leaf(sub, stem + "-w" + str(y), depth-1)
                        children.append({"w": y, **result})
                        if result["status"] not in CLOSED:
                            break
                    if len(children) == len(models) and all(x["status"] in CLOSED for x in children):
                        return {"status": "W_EXHAUSTED", "forms": list(map(hex, forms)),
                                "coverage": check, "children": children}
    return proof_attempt(residual(state), CTX["tbl"]["n"], stem, CTX["conflicts"])

CLOSED = {"CASCADE_CONTRADICTION", "DRAT_VERIFIED", "W_EXHAUSTED"}

def replay(rb):
    state = cascade(CTX["eta_state"], [(f,rb>>j&1) for j,f in enumerate(CTX["fix"])])
    if not state["closed_unsat"] and "_quad_ids" not in state:
        state = cascade(CTX["eta_state"], [(f,rb>>j&1) for j,f in enumerate(CTX["fix"])], 80)
    result = solve_leaf(state, "eta{}-rb{}".format(CTX["eta"], rb), 2)
    return {"rb": rb, **result}

def main():
    p = argparse.ArgumentParser()
    p.add_argument("--eta", type=int, required=True)
    p.add_argument("--shard", type=int, default=0)
    p.add_argument("--shards", type=int, default=1)
    p.add_argument("--workers", type=int, default=4)
    p.add_argument("--conflicts", type=int, default=50000)
    p.add_argument("--drat-trim", required=True)
    p.add_argument("--out", type=Path, required=True)
    args = p.parse_args()
    sources = json.loads((Path(__file__).parent / "certs" / "k0_recert_source.json").read_text())
    sources = sorted((x for x in sources["pending"] if x["eta_rep"] == args.eta), key=lambda x:x["lo"])
    require(bool(sources) and 0 <= args.shard < args.shards, "Invalid eta or shard")
    fix = [int(f,16) for f in sources[0]["fix_forms_hex"]]
    fix_sha = hashlib.sha256(",".join(map(hex,fix)).encode()).hexdigest()[:16]
    n = 1 << len(fix)
    cursor, opened = 0, []
    for cert in sources:
        require(cert["root_sha256"] == ROOT_SHA and cert["fix_sha256"] == fix_sha
                and cert["fix_forms_hex"] == sources[0]["fix_forms_hex"]
                and cert["lo"] == cursor and cert["hi"] - cursor == cert["covered_branches"]
                == cert["verified_subst_branches"]
                == cert["direct_closed"] + cert["rescued_closed"] + len(cert["open_survivors"]),
                "Source certificate coverage or fingerprint mismatch")
        items = [leaf["rb"] for leaf in cert["open_survivors"]]
        require(len(set(items)) == len(items) and all(cursor <= rb < cert["hi"] for rb in items),
                "Duplicate or out-of-range open leaf")
        opened.extend(items)
        cursor = cert["hi"]
    require(cursor == n, "Source coverage incomplete")
    opened.sort()
    selection = opened[args.shard::args.shards]
    root, forms, sha, lib9, lib_sh, _, tbl = build_k0_canonical_root("k0_replay_" + str(args.eta))
    require(sha == ROOT_SHA and all(list(map(hex, forms)) == x["eta_free_hex"] for x in sources),
            "Recomputed root or eta forms differ")
    args.out.mkdir(parents=True, exist_ok=True)
    CTX.update(out=args.out, lib9=lib9, lib_sh=lib_sh, tbl=tbl, eta=args.eta, fix=fix,
               conflicts=args.conflicts, drat_trim=str(Path(args.drat_trim).resolve()))
    state = cascade(root, [(form,args.eta>>i&1) for i,form in enumerate(forms)])
    require(not state["closed_unsat"] and "_quad_ids" in state, "Unexpected eta root")
    info = s45a.extract_minrank_basis_for_state("k0_replay", state, lib9, lib_sh, tbl,
                                               rng_seed=4300+args.eta)
    recomputed, _, fingerprint = s45a.build_fix_and_rescue_forms(info, len(fix))
    require(list(recomputed) == fix and fingerprint == fix_sha, "Prefix forms differ")
    CTX["eta_state"] = state
    results = []
    with multiprocessing.get_context("fork").Pool(args.workers) as pool:
        for result in pool.imap_unordered(replay, selection, chunksize=1):
            results.append(result)
            print(args.eta, result["rb"], result["status"], flush=True)
    unresolved = sorted(r["rb"] for r in results if r["status"] not in CLOSED)
    report = dict(eta_rep=args.eta, root_sha256=sha, fix_sha256=fix_sha, shard=args.shard,
                  shards=args.shards, selected=selection, verify_subst=True,
                  results=sorted(results,key=lambda r:r["rb"]), open_survivors=unresolved)
    (args.out / ("replay_eta{}_s{}.json".format(args.eta,args.shard))).write_text(
        json.dumps(report, indent=2) + "\n", encoding="utf-8")
    print("REPLAY_JSON", json.dumps(report, separators=(",", ":")), flush=True)

if __name__ == "__main__":
    main()
