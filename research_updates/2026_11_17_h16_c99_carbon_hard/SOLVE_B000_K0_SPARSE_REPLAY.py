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

from SOLVE_B000_K0_RECERT_GAPS import build_k0_canonical_root, s9, s16, s45a, b09, diag_v2
from k0_balance_fallback import make_fibers, balance_count, add_balance
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

def proof_attempt(polynomials, n, stem, max_conflicts, block=(), fibers=()):
    top, cnf = encode(polynomials, n)
    cnf.extend(block)
    for z in fibers:
        top = add_balance(CTX["balance"][z], cnf, top)
    with Solver(name="cadical195", bootstrap_with=cnf, with_proof=True) as solver:
        solver.conf_budget(max_conflicts)
        ret = solver.solve_limited()
        if ret is True:
            model = solver.get_model()
            x = sum(1 << (v-1) for v in model if 0 < v <= n)
            require(all(sum(x & m == m for m in eq) % 2 == 0 for eq in polynomials),
                    "SAT model fails source polynomials")
            require(all(balance_count(CTX["balance"][z], x) == 128 for z in fibers),
                    "SAT model fails exact fiber equations")
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
    polys = residual(state)
    fibers = [255,85,51]
    quadratic = [row for row in polys if all(m.bit_count() <= 2 for m in row)]
    cubics = sorted((row for row in polys if any(m.bit_count() == 3 for m in row)),
                    key=lambda row: (len(row), tuple(sorted(row))))
    selected = quadratic + cubics[:12]
    for iteration in range(24):
        result = proof_attempt(selected, CTX["tbl"]["n"], stem, CTX["conflicts"], fibers=fibers)
        if result["status"] != "SAT":
            return {**result, "exact_balance_fibers": fibers, "polynomial_count": len(selected),
                    "cegar_iterations": iteration + 1}
        candidate = int(result["model"],16)
        violated = [row for row in cubics if sum(candidate & m == m for m in row)%2]
        if violated:
            selected += violated[:4]
        else:
            other = [z for z, eq in CTX["balance"].items()
                     if z not in fibers and balance_count(eq,candidate) != 128]
            if not other:
                return {**result, "exact_balance_fibers": fibers, "full_residual_model": True}
            fibers.append(min(other,key=lambda z:len(CTX["balance"][z])))
    return {"status": "UNKNOWN_CEGAR", "polynomial_count": len(selected),
            "exact_balance_fibers": fibers}

CLOSED = {"CASCADE_CONTRADICTION", "DRAT_VERIFIED", "W_EXHAUSTED", "W_TRUTH_TABLE_EXHAUSTED"}

def replay(rb):
    state = cascade(CTX["eta_state"], [(f,rb>>j&1) for j,f in enumerate(CTX["fix"])])
    if not state["closed_unsat"] and "_quad_ids" not in state:
        state = cascade(CTX["eta_state"], [(f,rb>>j&1) for j,f in enumerate(CTX["fix"])], 80)
    if not state["closed_unsat"] and CTX.get("complete_w"):
        forms, y_models, prefix_masks = CTX["complete_w"]
        children = []
        for y in y_models:
            if any(((y & mask).bit_count() % 2) != (rb>>j&1)
                   for j,mask in enumerate(prefix_masks)):
                continue
            sub = cascade(state, [(form,y>>i&1) for i,form in enumerate(forms)])
            result = solve_leaf(sub, "eta{}-rb{}-w{}".format(CTX["eta"],rb,y), 0)
            children.append({"w": y, **result})
        if all(c["status"] in CLOSED for c in children):
            return {"rb": rb, "status": "W_TRUTH_TABLE_EXHAUSTED",
                    "forms": list(map(hex, forms)), "children": children}
        return {"rb": rb, "status": "OPEN_W_CHILDREN", "children": children}
    result = solve_leaf(state, "eta{}-rb{}".format(CTX["eta"], rb), 2)
    return {"rb": rb, **result}

def sum_masks(mask, masks):
    out=0
    for j in terms(mask):
        out ^= masks[j-1]
    return out

def main():
    p = argparse.ArgumentParser()
    p.add_argument("--eta", type=int, required=True)
    p.add_argument("--only-open", type=Path, required=True)
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
    remaining = json.loads(args.only_open.read_text())[str(args.eta)]
    require(len(set(remaining)) == len(remaining) and set(remaining)<=set(opened), "Invalid residual leaf set")
    selection = sorted(remaining)[args.shard::args.shards]
    root, forms, sha, lib9, lib_sh, _, tbl = build_k0_canonical_root("k0_replay_" + str(args.eta))
    require(sha == ROOT_SHA and all(list(map(hex, forms)) == x["eta_free_hex"] for x in sources),
            "Recomputed root or eta forms differ")
    args.out.mkdir(parents=True, exist_ok=True)
    print("CHECKED ROOT", sha, "eta",args.eta, "leaves", selection, flush=True)
    CTX.update(out=args.out, lib9=lib9, lib_sh=lib_sh, tbl=tbl, eta=args.eta, fix=fix,
               conflicts=args.conflicts, drat_trim=str(Path(args.drat_trim).resolve()))
    state = cascade(root, [(form,args.eta>>i&1) for i,form in enumerate(forms)])
    require(not state["closed_unsat"] and "_quad_ids" in state, "Unexpected eta root")
    info = s45a.extract_minrank_basis_for_state("k0_replay", state, lib9, lib_sh, tbl,
                                               rng_seed=4300+args.eta)
    recomputed, _, fingerprint = s45a.build_fix_and_rescue_forms(info, len(fix))
    require(list(recomputed) == fix and fingerprint == fix_sha, "Prefix forms differ")
    _, origin, basis = b09.build_pure_111_basis(0,0,0)
    require(origin==0, "Expected linear physical chart")
    CTX["balance"] = make_fibers(diag_v2.build_orbits_116(), basis,
                                   lambda c: sum(((v & c).bit_count()%2)<<j for j,v in enumerate(basis)))
    if args.eta == 1:
        quads = [s9.row_to_pset(state["_buf"],r,tbl) for r in state["_quad_ids"]]
        basis_w = s19.strict_rref_masks(list(s16.analyze_quad_system(quads)["W_piv"].values()))
        indexes,pure = s22a.extract_pure_w_quads(lib_sh,state,basis_w,tbl)
        w = [basis_w[i] for i in indexes]
        if 0 < len(w) <= 16:
            how = [sum((form>>pivot&1)<<j for j,pivot in enumerate(indexes)) for form in fix]
            if all(sum_masks(mask,w)==form for mask,form in zip(how,fix)):
                y = [y for y in range(1<<len(w))
                     if all(sum(y & m == m for m in row)%2==0 for row in pure)]
                require(len(w)==12 and len(y)==288,"Unexpected eta=1 W profile")
                CTX["complete_w"] = (w,y,how)
                print("EXACT W TRUTH TABLE",len(w),len(y),flush=True)
    CTX["eta_state"] = state
    results = []
    def checkpoint():
        unresolved = sorted(set(selection) - {r["rb"] for r in results if r["status"] in CLOSED})
        report = dict(eta_rep=args.eta, root_sha256=sha, fix_sha256=fix_sha, shard=args.shard,
                      shards=args.shards, selected=selection, verify_subst=True,
                      results=sorted(results,key=lambda r:r["rb"]), open_survivors=unresolved)
        path=args.out / ("replay_eta{}_s{}.json".format(args.eta,args.shard))
        temporary=path.with_suffix(".tmp")
        temporary.write_text(json.dumps(report,indent=2)+"\n",encoding="utf-8")
        temporary.replace(path)
        return report

    checkpoint()
    for rb in selection:
        print("START LEAF", rb, flush=True)
        result = replay(rb)
        results.append(result)
        checkpoint()
        print("LEAF_JSON",json.dumps(result,separators=(",",":")),flush=True)
    report=checkpoint()
    print("REPLAY_JSON", json.dumps(report, separators=(",", ":")), flush=True)

if __name__ == "__main__":
    main()
