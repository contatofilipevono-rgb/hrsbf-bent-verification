"""Affine hull of the (Pf4) homogeneous polars in each case, in the 21 coordinates; complement structure."""
import sys, os, json, itertools, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from bc_comum import NAMES
from oito_parametros_lib import params

here = os.path.dirname(os.path.abspath(__file__))
homog = json.load(open(os.path.join(here, "homog1176.json")))
CASE = {(0, 0, 0): "A", (1, 1, 0): "B", (1, 0, 1): "C"}


def toint(c):
    return sum(int(c[i]) << i for i in range(21))


def span_basis(vecs):
    piv = {}
    for r in vecs:
        while r:
            h = r.bit_length() - 1
            if h in piv:
                r ^= piv[h]
            else:
                piv[h] = r
                break
    return piv


def reduce(piv, r):
    while r:
        h = r.bit_length() - 1
        if h in piv:
            r ^= piv[h]
        else:
            return r
    return 0


def nullforms(vecs, n=21):
    """linear forms L (n bits) + constant (bit n) vanishing on all vecs (affine relations)."""
    piv = span_basis([v | (1 << n) for v in vecs])
    rows = list(piv.values())
    # complement: solve L . r = 0 for all r, L over n+1 bits
    pr = {}
    for r in rows:
        for h in sorted(pr, reverse=True):
            if r >> h & 1:
                r ^= pr[h]
        if r:
            h = r.bit_length() - 1
            for k in list(pr):
                if pr[k] >> h & 1:
                    pr[k] ^= r
            pr[h] = r
    free = [c for c in range(n + 1) if c not in pr]
    out = []
    for c in free:
        L = 1 << c
        for h, r in pr.items():
            if r >> c & 1:
                L |= 1 << h
        out.append(L)
    return out


def fmt(L, n=21):
    s = [NAMES[j] for j in range(n) if L >> j & 1]
    return " + ".join(s) + (" = 1" if L >> n & 1 else " = 0")


import numpy as np
par = np.load(os.path.join(here, "paridade_tab.npy"))
tab8 = json.load(open(os.path.join(here, "oito_tabela.json")))
GROUPS = []
for case in "BC":
    for ab in ((0, 0), (1, 1)):
        for extra in ("pf4", "pf4&8&par"):
            GROUPS.append((case, ab, extra))
for case, ab, extra in GROUPS:
    P = [toint(c) for c in homog if CASE[params(c)[:3]] == case and params(c)[3:5] == ab
         and (extra == "pf4" or (tab8["".join(map(str, params(c)))][0] and not par[:, toint(c)].any()))]
    if not P:
        print(case, ab, extra, "empty"); continue
    print("==", case, ab, extra)
    print("case", case, "Pf4 points", len(P))
    base = P[0]
    piv = span_basis([p ^ base for p in P])
    dim = len(piv)
    print("  affine hull dim", dim)
    for L in nullforms(P):
        print("   ", fmt(L))
    # complement inside hull
    hull = [base]
    for v in piv.values():
        hull = hull + [h ^ v for h in hull]
    Pset = set(P)
    comp = [h for h in hull if h not in Pset]
    print("  hull size", len(hull), "complement size", len(comp))
    if comp:
        cb = comp[0]
        cpiv = span_basis([c ^ cb for c in comp])
        print("  complement affine hull dim", len(cpiv), "(affine subspace?)", 2 ** len(cpiv) == len(comp))
        for L in nullforms(comp):
            print("     comp:", fmt(L))
