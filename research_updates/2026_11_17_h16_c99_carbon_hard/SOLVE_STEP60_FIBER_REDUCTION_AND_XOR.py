"""Replay the uniform pivot with its RHS and test full isotropic fibers."""
import itertools
import json
import os
from pathlib import Path
import subprocess
import sys
import time

import numpy as np

from H16_POLAR_FLAGS import null, rref, unpack
from H16_SPECIALIZED_KERNEL import mul, poly_product, specialize, transform
from SOLVE_STEP54_GLOBAL_SYZYGIES import residual
import SOLVE_STEP50_SPLIT_QUOTIENT as step50


def degree(poly):
    return max((p.bit_count() for p in poly), default=-1)


def bits(word):
    while word:
        bit = word & -word
        yield bit.bit_length() - 1
        word ^= bit


def polynomials(matrix, rhs, n):
    out = [set(p) for p in rhs]
    for term, coefficient in matrix.items():
        for row, col in zip(*np.nonzero(coefficient)):
            out[row].symmetric_difference_update({term | (1 << (n + int(col)))})
    return out


def eliminate(M, rhs, n, cert, offset):
    p = cert["rhs_source_row"]
    j = cert["pivot_R_index"]
    assert p == 36 and j == 0 and len(rhs) == 64
    witness = 0
    for m, v in cert["pivot_anf"].items():
        m = int(m)
        if m & offset == m:
            witness ^= v
    assert witness & 1
    assert all(not A[p].any() for m,A in M.items() if m)
    assert np.array_equal(M[0][p], unpack([witness],25)[0])
    M_out = {m: A[:,1:].copy() for m,A in M.items()}
    v = M[0][p,1:].copy()[None, :]
    for m, A in M.items():
        M_out[m] ^= mul(A[:,[0]], v)
    rhs_out = [b ^ poly_product({m for m,A in M.items() if A[i,0]}, rhs[p])
               for i,b in enumerate(rhs)]
    assert not rhs_out[p] and all(not A[p].any() for A in M_out.values())
    keep = [i for i in range(64) if i != p]
    reduced = polynomials({m:A[keep] for m,A in M_out.items()},
                         [rhs_out[i] for i in keep],n)
    return reduced, witness, rhs[p]


def cubic_radical(polys, n):
    pairs = list(itertools.combinations(range(n),2))
    pair_index = {p:i for i,p in enumerate(pairs)}
    contraction = np.zeros((len(polys) * len(pairs), n), dtype=np.uint8)
    for i, poly in enumerate(polys):
        for p in poly:
            if p.bit_count() == 3 and p.bit_length() <= n:
                a,b,c = tuple(bits(p))
                for x,y,z in ((a,b,c),(a,c,b),(b,c,a)):
                    contraction[i*len(pairs)+pair_index[x,y],z] ^= 1
    return null(contraction)


def monomials(n,d):
    return [sum(1 << i for i in subset) for k in range(d+1)
            for subset in itertools.combinations(range(n),k)]


def xl3(polys, n, budget=4):
    """Run Boolean XL only through degree three and replay each new low-degree row."""
    ms = monomials(n,3)
    index = {m:i for i,m in enumerate(ms)}
    low = 1 + n + n*(n-1)//2

    def pack(poly):
        return sum(1<<index[p] for p in poly)

    def unpack_row(word):
        return {ms[i] for i in bits(word)}

    def reduce(generators, trace=False):
        basis = {}
        for j, word in enumerate(generators):
            proof = (1 << j) if trace else 0
            while word:
                pivot = word.bit_length() - 1
                if pivot not in basis:
                    basis[pivot] = (word,proof)
                    break
                w,t = basis[pivot]
                word ^= w
                proof ^= t
        return basis

    source = [p for p in polys if degree(p)<=3]
    known = reduce([pack(p) for p in source])
    additions = []
    records = []
    for d in range(budget):
        quadratic = [unpack_row(w) for p,(w,_) in known.items() if p<low]
        base = [unpack_row(w) for w,_ in known.values()]
        generators = [pack(p) for p in base]
        for q in quadratic:
            for j in range(n):
                gens = poly_product(q,{1 << j})
                generators.append(pack(gens))
        enlarged = reduce(generators, trace=True)
        low_rows = [(p,w,t) for p,(w,t) in enlarged.items() if p<low]
        added = 0
        for p,w,trace in low_rows:
            # Reduce modulo previously known rows to count only new consequences.
            old = w
            while old and old.bit_length()-1 in known:
                old ^= known[old.bit_length()-1][0]
            if not old:
                continue
            check = 0
            for q in bits(trace):
                check ^= generators[q]
            assert check == w
            additions.append(unpack_row(w))
            added += 1
        keep = [pack(p) for p in source + additions]
        known = reduce(keep)
        result = {"round":d+1,"quadratic_input":len(quadratic),"generators":len(generators),
                  "new_low":added,"unit":0 in known}
        records.append(result)
        if not added or result["unit"] or len(additions)>=96:
            break
    return records, additions


def parity(poly, point):
    return sum((p & point) == p for p in poly) & 1


def xor_worker(json_path):
    from pycryptosat import Solver

    data = json.loads(Path(json_path).read_text())
    n = data["variables"]
    solver = Solver(threads=1)
    gates = {}
    next_var = n + 1

    def gate(m):
        nonlocal next_var
        if m.bit_count() == 1:
            return m.bit_length()
        if m not in gates:
            bit = m & -m
            a, b = gate(m ^ bit), bit.bit_length()
            c = next_var
            next_var += 1
            gates[m] = c
            solver.add_clause([-c,a])
            solver.add_clause([-c,b])
            solver.add_clause([c,-a,-b])
        return gates[m]

    for poly in data["polynomials"]:
        xs = [gate(p) for p in poly if p]
        rhs = 0 in poly
        if xs:
            solver.add_xor_clause(xs,rhs)
        elif rhs:
            print(json.dumps({"status":"UNSAT","gates":len(gates)}),flush=True)
            return
    print(json.dumps({"status":"READY","gates":len(gates)}),flush=True)
    sat, values = solver.solve()
    result = {"status":{True:"SAT",False:"UNSAT",None:"UNKNOWN"}[sat],"gates":len(gates)}
    if sat:
        point = sum(1<<j for j in range(n) if values[j+1])
        assert not any(parity(p,point) for p in data["polynomials"])
        result["point"] = point
    print(json.dumps(result),flush=True)


def try_xor(path, seconds):
    start = time.monotonic()
    try:
        process = subprocess.run([sys.executable,__file__,"--xor-worker",str(path)],
                                 timeout=seconds,capture_output=True,text=True)
        if process.returncode:
            return {"status":"ERROR","stderr":process.stderr[-1200:]}
        return json.loads(process.stdout.splitlines()[-1])
    except subprocess.TimeoutExpired as exc:
        seen = exc.stdout.decode().splitlines() if exc.stdout else []
        ready = json.loads(seen[-1]) if seen else {}
        return {**ready,"status":"TIMEOUT","seconds":round(time.monotonic()-start,2)}


def probe(coeff, S, rhs, pure, bits_fixed, trial):
    left, right = residual(coeff, S, rhs)
    n = S.shape[1]
    flag = json.loads(Path("flag/step55_isotropic_flag.json").read_text())
    cert = json.loads(Path("pivot/step59_branch_free_pivot.json").read_text())
    U = null(unpack(flag["fixed_forms"],n))
    pv = set(rref(U)[1])
    J = np.eye(n,dtype=np.uint8)[[j for j in range(n) if j not in pv]]
    offset = int(os.environ["H16_FIBER"])
    origin = np.zeros(n,dtype=np.uint8)
    for j in bits(offset):
        origin ^= J[j]
    M, forms = specialize(left,origin,U)
    assert all(p.bit_count() <= 1 or not A.any() for p,A in M.items())
    cache = {0:{0}}
    c = [transform(poly,forms,cache) for poly in right]
    pure_u = [transform(poly,forms,cache) for poly in pure]
    reduced,witness,pivot = eliminate(M,c,len(U),cert,offset)
    equations = reduced + pure_u
    assert len(U) + 24 == 59
    counts = {d:sum(degree(p)==d for p in equations) for d in range(-1,5)}
    cubic = cubic_radical(equations,len(U))
    print("STEP60_MATRIX",json.dumps({"fiber":offset,"equations":len(equations),
          "degrees":counts,"cubic_radical":len(cubic),"cubic_support":len(U)-len(cubic),
          "pivot_rhs_degree":degree(pivot),"max_degree":max(map(degree,equations))}),flush=True)
    records,extra = xl3(equations,59)
    print("STEP60_XL",json.dumps({"fiber":offset,"rounds":records}),flush=True)
    path = Path("step60_fiber.json")
    path.write_text(json.dumps({"variables":59,"polynomials":[sorted(p) for p in equations+extra],
                               "original_count":len(equations),"cubic_radical":cubic.tolist()}))
    result = try_xor(path,60)
    if result["status"]=="SAT":
        point = result["point"]
        u = point & ((1 << len(U))-1)
        rr = (point >> len(U)) << 1
        r0 = parity(pivot,u) ^ ((rr & witness).bit_count() & 1)
        lifted = u | ((rr | r0) << len(U))
        assert not any(parity(p,lifted) for p in polynomials(M,c,len(U)) + pure_u)
        result["verified_against_64"] = True
    print("STEP60_SOLVER",json.dumps({"fiber":offset,**result}),flush=True)
    Path("step60_result.json").write_text(json.dumps({"fiber":offset,"rounds":records,"solver":result}))


if __name__ == "__main__":
    if len(sys.argv)>1 and sys.argv[1]=="--xor-worker":
        xor_worker(sys.argv[2])
    else:
        step50.split_probe = probe
        step50.main()
