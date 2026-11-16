"""Degree-3 XL on the (Pf4) quadrics restricted to a subcase: which linear forms lie in span{q_i, x_j q_i}?
Prints a certificate (which q_i and x_j q_i) for each hull relation found.
Subcases: C (u30,u40,u42) = (1,0,1); C(1,1); B(1,1) with Y = 0; B(0,0)."""
import sys, os, json, itertools, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import io, contextlib
with contextlib.redirect_stdout(io.StringIO()):
    import pf4_quadricas as P
from bc_comum import NAMES

N = {s: i for i, s in enumerate(NAMES)}


def subst_lin(q, sub):
    """sub: dict var -> (set of vars, const) affine substitution. q: frozenset of monomials (frozensets)."""
    out = collections.Counter()
    for m in q:
        terms = [(frozenset(), 1)]
        for v in m:
            if v in sub:
                vs, c = sub[v]
                opts = [frozenset([u]) for u in vs] + ([frozenset()] if c else [])
            else:
                opts = [frozenset([v])]
            terms = [(a | o, 1) for a, _ in terms for o in opts]
        for a, _ in terms:
            out[a] ^= 1
    return frozenset(m for m, x in out.items() if x)


def run(name, sub, extra_lin):
    quads = {subst_lin(q, sub) for q in set(P.quads.values())} - {frozenset()}
    quads = list(quads) + [frozenset(l) for l in extra_lin]
    vars_ = sorted({v for q in quads for m in q for v in m})
    polys = []; labels = []
    for i, q in enumerate(quads):
        polys.append(q); labels.append(("q", i, None))
        for x in vars_:
            pr = collections.Counter()
            for m in q:
                pr[m | {x}] ^= 1
            pq = frozenset(m for m, c in pr.items() if c)
            if pq:
                polys.append(pq); labels.append(("xq", i, x))
    mons = sorted({m for p in polys for m in p}, key=lambda m: (-len(m), sorted(m)))
    col = {m: k for k, m in enumerate(mons)}
    nonlin = sum(1 for m in mons if len(m) >= 2)
    rows = []
    for p in polys:
        v = 0
        for m in p:
            v |= 1 << (len(mons) - 1 - col[m])
        rows.append(v)
    # eliminate the nonlinear monomials first (they are the high bits)
    piv = {}
    for idx_, r in enumerate(rows):
        comb = 1 << idx_
        while r:
            h = r.bit_length() - 1
            if h in piv:
                r ^= piv[h][0]; comb ^= piv[h][1]
            else:
                piv[h] = (r, comb); break
    lin_bits = len(mons) - nonlin
    found = []
    for h, (r, comb) in piv.items():
        if r.bit_length() <= lin_bits:
            found.append((r, comb))
    def show(r):
        ms = [mons[len(mons) - 1 - b] for b in range(len(mons)) if r >> b & 1]
        return " + ".join("*".join(NAMES[c] for c in sorted(m)) if m else "1" for m in ms)
    print("==", name, ": quadrics", len(quads), "vars", len(vars_), "linear consequences (degree-3 XL):", len(found))
    for r, comb in found:
        used = [labels[k] for k in range(len(polys)) if comb >> k & 1]
        print("   ", show(r), "= 0   [", len(used), "polynomials ]")
    return found


C = {N["u30"]: (set(), 1), N["u40"]: (set(), 0), N["u42"]: (set(), 1)}
run("C", C, [])
Bsub = {N["u30"]: (set(), 1), N["u40"]: (set(), 1), N["u42"]: (set(), 0)}
run("B", Bsub, [])
# B with alpha = beta = 1 imposed as linear equations (p = 1 + A2 + B1 + B2, r = 1 + A1 + A3 + B2 + B3)
B11 = dict(Bsub)
B11[N["p"]] = ({N["A2"], N["B1"], N["B2"]}, 1)
B11[N["r"]] = ({N["A1"], N["A3"], N["B2"], N["B3"]}, 1)
run("B(1,1)", B11, [])
B00 = dict(Bsub)
B00[N["p"]] = ({N["A2"], N["B1"], N["B2"]}, 0)
B00[N["r"]] = ({N["A1"], N["A3"], N["B2"], N["B3"]}, 0)
run("B(0,0)", B00, [])
C11 = dict(C)
C11[N["p"]] = ({N["A2"], N["B1"], N["B2"]}, 1)
C11[N["r"]] = ({N["A1"], N["A3"], N["B2"], N["B3"]}, 1)
run("C(1,1)", C11, [])
