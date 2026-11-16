"""The (Pf4) quadrics gamma_2(T)=0 as explicit polynomials in the 21 polar coordinates.
T_{ij,K} = coefficient of z^K w_i w_j (|K| = 2) in f (z,w)-ANF: linear in the coordinates.
Pf4(V, J) = sum over the 3 pairings {ij|kl} of V and over splits J = K u L (|K|=|L|=2) of T_{ij,K} T_{kl,L}.
Then substitute each case and list the equations that become linear (or constant)."""
import sys, os, json, itertools, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from bc_comum import *

here = os.path.dirname(os.path.abspath(__file__))
# T as linear forms: T[(i,j)][K] = 21-bit mask of coordinates
anb = []
for k in range(21):
    code = "".join("1" if i == k else "0" for i in range(21))
    anb.append(anf_zw(t_from_coords(code)))
K2 = [frozenset(K) for K in itertools.combinations(range(6), 2)]
T = {}
for (i, j) in PAIRS:
    for K in K2:
        m = sum(1 << q for q in K) | (((1 << i) | (1 << j)) << 6)
        T[(i, j, K)] = sum(1 << c for c in range(21) if anb[c][m])
# also check: low parts (z-degree 0,1) of the polar
low = collections.Counter()
for (i, j) in PAIRS:
    for K in [frozenset()] + [frozenset([q]) for q in range(6)]:
        m = sum(1 << q for q in K) | (((1 << i) | (1 << j)) << 6)
        if any(anb[c][m] for c in range(21)):
            low[len(K)] += 1
print("low-part monomials present (by z-degree):", dict(low))


def mul(a, b):
    """product of two linear forms (masks) -> set of monomials (frozensets of coord indices); x^2 = x."""
    out = collections.Counter()
    for p in range(21):
        if not a >> p & 1:
            continue
        for q in range(21):
            if b >> q & 1:
                out[frozenset([p, q])] ^= 1
    return {m for m, v in out.items() if v}


def addto(acc, mons):
    for m in mons:
        acc[m] ^= 1


quads = {}
for V in itertools.combinations(range(6), 4):
    i, j, k, l = V
    pairings = [((i, j), (k, l)), ((i, k), (j, l)), ((i, l), (j, k))]
    for J in itertools.combinations(range(6), 4):
        acc = collections.Counter()
        for (p1, p2) in pairings:
            for K in itertools.combinations(J, 2):
                K = frozenset(K); L = frozenset(J) - K
                addto(acc, mul(T[(p1[0], p1[1], K)], T[(p2[0], p2[1], L)]))
        q = frozenset(m for m, v in acc.items() if v)
        quads[(V, J)] = q
distinct = set(quads.values()) - {frozenset()}
print("Pf4: 225 (V,J); distinct nonzero quadrics:", len(distinct))


def show(q):
    def mn(m):
        return "*".join(NAMES[c] for c in sorted(m)) if m else "1"
    return " + ".join(mn(m) for m in sorted(q, key=lambda m: (len(m), sorted(m)))) or "0"


def subst(q, fix):
    out = collections.Counter()
    for m in q:
        val = 1; rest = []
        for c in m:
            if c in fix:
                val &= fix[c]
            else:
                rest.append(c)
        if val:
            out[frozenset(rest)] ^= 1
    return frozenset(m for m, v in out.items() if v)


res = {"quadricas": [show(q) for q in sorted(distinct, key=lambda q: (len(q), show(q)))]}
for case, fix in (("A", {0: 0, 1: 0, 2: 0}), ("B", {0: 1, 1: 1, 2: 0}), ("C", {0: 1, 1: 0, 2: 1})):
    sub = {subst(q, fix) for q in distinct} - {frozenset()}
    lin = [q for q in sub if all(len(m) <= 1 for m in q)]
    print("case", case, ": distinct after substitution", len(sub), " linear ones", len(lin))
    for q in sorted(lin, key=lambda q: (len(q), show(q))):
        print("    ", show(q), "= 0")
    res[case] = {"lineares": [show(q) for q in lin], "todas": [show(q) for q in sorted(sub, key=lambda q: (len(q), show(q)))]}
json.dump(res, open(os.path.join(here, "pf4_quadricas.json"), "w"), indent=1)
for q in sorted(distinct, key=lambda q: (len(q), show(q)))[:12]:
    print("Q:", show(q))
