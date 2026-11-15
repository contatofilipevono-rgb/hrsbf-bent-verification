"""Lemma Gamma: the RS-affine group preserves the model V and the zero-polar kernel K, hence acts linearly on the
polar space V/K, and f -> f o gamma is a bijection between the bent functions of P and of gamma(P).

Gamma = (units of F2[X]/(X^12 - 1), acting by circulant matrices) x (multipliers i -> k i, k in {1,5,7,11}).
Every element is linear, invertible and normalizes the rotation, so it maps RS functions of degree <= 4 to RS
functions of degree <= 4 and bent to bent.  Being linear maps of truth tables, the claims 'V -> V' and 'K -> K' only
need a basis of V, a basis of K and a generating set of Gamma: here everything is checked by F2 linear algebra.
Also prints the 25 x 25 matrices of the generators on the polar space and checks that they permute the 18,816
listed polars (the solutions of (Pf4)), and recounts the orbits from the matrices.
Usage: python lema_gamma.py"""
import os, sys, pickle, itertools, json
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from base12 import mobius, ZW, wtw, polar, pack, elim_comb

here = os.path.dirname(os.path.abspath(__file__))
XS = np.arange(4096)


def mul(a, b):
    r = 0
    for i in range(12):
        if b >> i & 1:
            r ^= ((a << i) | (a >> (12 - i))) & 4095
    return r


def circ_map(c):
    """x -> c * x (polynomial product mod X^12 - 1); returns y(x) for all x."""
    return np.array([mul(c, x) for x in range(4096)])


def mult_map(k):
    out = np.zeros(4096, dtype=np.int64)
    for i in range(12):
        out |= ((XS >> i) & 1) << ((k * i) % 12)
    return out


def unit_generators():
    units = [c for c in range(1, 4096) if any(mul(c, d) == 1 for d in range(1, 4096))]
    gens = []; H = {1}
    for c in units:                                      # greedy generating set of the abelian unit group
        if c in H:
            continue
        gens.append(c)
        frontier = list(H); H = set(H)
        while frontier:
            x = frontier.pop()
            for g in gens:
                y = mul(x, g)
                if y not in H:
                    H.add(y); frontier.append(y)
        if len(H) == len(units):
            break
    return units, gens


def deg_w(t):
    an = mobius(t[ZW].astype(np.uint8), 12)
    nz = np.flatnonzero(an)
    return int(wtw[nz].max()) if len(nz) else -1


if __name__ == "__main__":
    D = pickle.load(open(os.path.join(here, "base12.pkl"), "rb"))
    base = [np.asarray(t, dtype=np.uint8) for t in D["base"]]
    print("dim V =", len(base))
    units, ugens = unit_generators()
    print("units:", len(units), "| generating set of the unit group:", [hex(g) for g in ugens])
    maps = {"m5": mult_map(5), "m7": mult_map(7)}
    for g in ugens:
        maps["c%x" % g] = circ_map(g)
    # basis of K (zero polar) inside V
    Bs = [polar(t)[0] for t in base]
    ind, ker = elim_comb([pack(B) for B in Bs])
    Kb = [np.bitwise_xor.reduce([base[j] for j in range(len(base)) if k >> j & 1], axis=0) for k in ker]
    print("dim K =", len(Kb), "| dim V/K =", len(ind))
    ok_V = ok_K = True
    rot = np.array([((x << 1) | (x >> 11)) & 4095 for x in range(4096)])
    for name, ym in maps.items():
        for t in base:
            s = t[ym]                                    # (f o gamma)(x) = f(gamma x)
            if not (s[rot] == s).all() or deg_w(s) > 2:
                ok_V = False
        for t in Kb:
            s = t[ym]
            if deg_w(s) > 1:
                ok_K = False
    print("Gamma preserves V (RS, degree in w <= 2):", ok_V, "| Gamma preserves K (affine in w):", ok_K)
    # action on the polar space: coordinates of polar(f o gamma) for the basis polars
    piv = {}
    for i, B in enumerate([Bs[i.bit_length() - 1] for i in ind]):
        r = pack(B); comb = 1 << i
        while r:
            c = r.bit_length() - 1
            if c in piv:
                r ^= piv[c][0]; comb ^= piv[c][1]
            else:
                piv[c] = (r, comb); break
    pbasis = [base[i.bit_length() - 1] for i in ind]
    def coords(B):
        r = pack(B); comb = 0
        while r:
            c = r.bit_length() - 1
            assert c in piv, "polar outside the span"
            r ^= piv[c][0]; comb ^= piv[c][1]
        return comb
    mats = {}
    for name, ym in maps.items():
        mats[name] = [coords(polar(t[ym])[0]) for t in pbasis]   # column j = image of basis polar j
    # the 18,816 listed polars in these coordinates
    from lista_polares import hexB
    def hex_to_coords(hx):
        val = int(hx, 16)
        B = np.array([[(val >> (64 * a + z)) & 1 for z in range(64)] for a in range(15)], dtype=np.uint8)
        return coords(B)
    L = [hex_to_coords(h) for h in open(os.path.join(here, "polares_18816.txt")).read().split()]
    Ls = set(L)
    def apply(M, c):
        out = 0
        for j in range(len(M)):
            if c >> j & 1:
                out ^= M[j]
        return out
    perm_ok = all(apply(M, c) in Ls for M in mats.values() for c in L)
    print("generators permute the 18,816 (Pf4) polars:", perm_ok)
    seen = set(); orbits = []
    for c in L:
        if c in seen: continue
        st = [c]; o = set()
        while st:
            x = st.pop()
            if x in o: continue
            o.add(x); st += [apply(M, x) for M in mats.values()]
        seen |= o; orbits.append(len(o))
    from collections import Counter
    print("orbits from the linear action:", len(orbits), sorted(Counter(orbits).items()))
    json.dump({"unit_generators": ugens, "matrices": {k: v for k, v in mats.items()}, "orbits": len(orbits)},
              open(os.path.join(here, "lema_gamma.json"), "w"))
