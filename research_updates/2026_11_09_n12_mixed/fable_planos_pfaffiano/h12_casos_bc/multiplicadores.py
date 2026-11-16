"""Orbits of the 98 survivors (and of the Pf4 subcases) under the multipliers i -> mu*i (mu = 5, 7, 11)."""
import sys, os, json, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from bc_comum import *
from oito_parametros_lib import params

here = os.path.dirname(os.path.abspath(__file__))
homog = json.load(open(os.path.join(here, "homog1176.json")))
M = json.load(open(os.path.join(here, "mapa_filtros.json")))


def perm_t(mu):
    p = []
    for o in orbs:
        m = o[0]
        mm = sum(1 << ((mu * i) % 12) for i in range(12) if m >> i & 1)
        p.append(idx[mm])
    return p


P = {mu: perm_t(mu) for mu in (5, 7, 11)}


def act(code, mu):
    t = t_from_coords(code)
    t2 = [0] * 43
    for j in range(43):
        if t[j]:
            t2[P[mu][j]] ^= 1
    # stays in the model?
    assert sum(t2[j] for j in L456) % 2 == 0 and sum(t2[j] for j in L464) % 2 == 0
    return coords_of_t(t2)


def orbits(codes):
    S = set(codes); seen = set(); out = []
    for c in sorted(S):
        if c in seen: continue
        o = {c} | {act(c, mu) for mu in (5, 7, 11)}
        assert o <= S, "set not invariant"
        seen |= o; out.append(sorted(o))
    return out


surv = M["surv98"]
for case in "BC":
    cs = [c for c in surv if (c[:3] == "110") == (case == "B")]
    ob = orbits(cs)
    print("survivors", case, len(cs), "-> orbits", len(ob), "sizes", collections.Counter(len(o) for o in ob))
for case, u in (("B", "110"), ("C", "101")):
    for ab in ("00", "11"):
        cs = [c for c in homog if c[:3] == u and "%d%d" % params(c)[3:5] == ab]
        ob = orbits(cs)
        print("Pf4", case, ab, len(cs), "-> orbits", len(ob))
