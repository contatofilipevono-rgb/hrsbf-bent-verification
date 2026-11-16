"""Hand-checkable classification of (Pf4) in C(1,1) (u30=1,u40=0,u42=1, alpha=beta=1).
Search a branching tree on single variables: at each node substitute, Gaussian-eliminate the linear equations
(substituting pivots back into the quadrics), and branch on the variable that appears in most quadratic monomials,
until every equation is linear.  Leaves = linear systems.  Reports tree size and solution count (must be 40)."""
import sys, os, io, contextlib, collections, itertools
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
with contextlib.redirect_stdout(io.StringIO()):
    import pf4_quadricas as P
from bc_comum import NAMES

N = {s: i for i, s in enumerate(NAMES)}
# polynomial: frozenset of monomials (frozenset of var idx); constant = frozenset()
def add(p, q): return p ^ q
def subst(p, v, expr):
    """replace variable v by affine polynomial expr (frozenset of monomials of degree <=1)"""
    out = collections.Counter()
    for m in p:
        if v in m:
            rest = m - {v}
            for e in expr:
                out[rest | e] ^= 1
        else:
            out[m] ^= 1
    return frozenset(m for m, c in out.items() if c)

C1 = frozenset([frozenset()])
start = {N["u30"]: C1, N["u40"]: frozenset(), N["u42"]: C1,
         N["p"]: frozenset([frozenset(), frozenset([N["A2"]]), frozenset([N["B1"]]), frozenset([N["B2"]])]),
         N["r"]: frozenset([frozenset(), frozenset([N["A1"]]), frozenset([N["A3"]]), frozenset([N["B2"]]), frozenset([N["B3"]])])}
system = []
for q in set(P.quads.values()) - {frozenset()}:
    for v, e in start.items():
        q = subst(q, v, e)
    if q: system.append(q)
system = list(set(system))
freevars = sorted(set(range(21)) - set(start))
print("C(1,1): equations", len(system), "variables", len(freevars))

stats = collections.Counter()
def span_linear(eqs):
    """F2-span of the equations: return (contradiction?, list of linear consequences)."""
    mons = sorted({m for e in eqs for m in e}, key=lambda m: (-len(m), sorted(m)))
    col = {m: i for i, m in enumerate(mons)}; L = len(mons)
    piv = {}
    for e in eqs:
        r = 0
        for m in e: r |= 1 << (L - 1 - col[m])
        while r:
            h = r.bit_length() - 1
            if h in piv: r ^= piv[h]
            else: piv[h] = r; break
    nlin = sum(1 for m in mons if len(m) <= 1)
    out = []
    for h, r in piv.items():
        if r.bit_length() <= nlin:
            out.append(frozenset(mons[L - 1 - b] for b in range(L) if r >> b & 1))
    return any(o == C1 for o in out), out


def solve(eqs, assigned, depth, path):
    """returns number of solutions in remaining free vars; eqs: list of polys"""
    eqs = [e for e in eqs if e]
    for _ in range(6):
        contra, lins = span_linear(eqs)
        if contra:
            stats["leaf_contra_span"] += 1
            return 0
        new = [l for l in lins if l not in eqs]
        if not new: break
        eqs = eqs + new
    # linear elimination
    changed = True
    while changed:
        changed = False
        for e in eqs:
            if e == C1:
                stats["leaf_contra"] += 1
                return 0
            if all(len(m) <= 1 for m in e):
                vs = [next(iter(m)) for m in e if m]
                v = max(vs)
                expr = frozenset(m for m in e if m != frozenset([v]))
                eqs = [subst(x, v, expr) for x in eqs if x is not e]
                eqs = [x for x in eqs if x]
                assigned = assigned | {v}
                changed = True
                break
    quad = [e for e in eqs if any(len(m) >= 2 for m in e)]
    remaining = [v for v in freevars if v not in assigned]
    if not quad:
        if any(e == C1 for e in eqs):
            stats["leaf_contra"] += 1; return 0
        stats["leaf_lin"] += 1
        stats["maxdepth"] = max(stats["maxdepth"], depth)
        return 2 ** len([v for v in remaining])
    qvars = sorted({v for e in quad for m in e if len(m) >= 2 for v in m})
    # candidate branchings: v = c, or v = u + c (u another variable); score = quadratic monomials left after both
    def reduce_lin(es):
        es = [e for e in es if e]
        for _ in range(40):
            lin = next((e for e in es if e != C1 and all(len(m) <= 1 for m in e)), None)
            if lin is None or any(e == C1 for e in es): break
            vv = max(next(iter(m)) for m in lin if m)
            ex = frozenset(m for m in lin if m != frozenset([vv]))
            es = [x for x in (subst(x, vv, ex) for x in es if x is not lin) if x]
        return es
    def mk(other, val):
        base = frozenset() if other is None else (frozenset([frozenset([other])]) if isinstance(other, int) else frozenset(frozenset([o]) for o in other))
        return base ^ (C1 if val else frozenset())
    def score(v, other):
        s = 0
        for val in (0, 1):
            ex = mk(other, val)
            es = reduce_lin([subst(e, v, ex) for e in eqs])
            if any(e == C1 for e in es): continue
            contra, lins = span_linear(es)
            if contra: continue
            es = reduce_lin(es + lins)
            if any(e == C1 for e in es): continue
            s += 1 + sum(1 for e in es for m in e if len(m) >= 2)
        return s
    cands = [(v, None) for v in qvars] + [(v, u) for v in qvars for u in qvars if u < v]
    v, other = min(cands, key=lambda c: score(*c))
    tot = 0
    print("  " * depth + "ramo em", fmt_branch(v, other, 0).split(" = ")[0], "=", fmt_branch(v, other, 0).split(" = ")[1], "(+0/+1)")
    for val in (0, 1):
        ex = mk(other, val)
        tot += solve([subst(e, v, ex) for e in eqs], assigned | {v}, depth + 1, path + [(NAMES[v], other, val)])
    stats["nodes"] += 1
    return tot

LOG = []
def fmt_branch(v, other, val):
    rhs = []
    if other is not None:
        rhs = [NAMES[other]] if isinstance(other, int) else [NAMES[o] for o in other]
    return "%s = %s" % (NAMES[v], " + ".join(rhs + (["1"] if val else [])) or "0")
_orig = solve
def solve_logged(eqs, assigned, depth, path):
    before = dict(stats)
    r = _orig(eqs, assigned, depth, path)
    return r
n = solve(system, set(), 0, [])
print("solutions:", n, dict(stats))
# independent check: brute force over the 16 free variables
import itertools
cnt = 0; sols = []
for bits_ in range(1 << len(freevars)):
    a = {v: (bits_ >> i) & 1 for i, v in enumerate(freevars)}
    a[N["u30"]], a[N["u40"]], a[N["u42"]] = 1, 0, 1
    a[N["p"]] = 1 ^ a[N["A2"]] ^ a[N["B1"]] ^ a[N["B2"]]
    a[N["r"]] = 1 ^ a[N["A1"]] ^ a[N["A3"]] ^ a[N["B2"]] ^ a[N["B3"]]
    if all(sum(all(a[x] for x in m) for m in q) % 2 == 0 for q in set(P.quads.values())):
        cnt += 1; sols.append(sum(a[i] << i for i in range(21)))
print("brute force solutions:", cnt)
import json
json.dump(sols, open(os.path.join(os.path.dirname(os.path.abspath(__file__)), "pf4_c11_solucoes.json"), "w"))
