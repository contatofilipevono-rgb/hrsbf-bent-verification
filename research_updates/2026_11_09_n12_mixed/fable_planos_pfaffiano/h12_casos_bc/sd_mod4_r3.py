"""The R^3 principle applied to column sums S_d (d fixed by R^3: 9, 27, 63).
Lemma (to test): for d with R^3 d = d,
    S_d = sum_{z : B_z d = 0} (-1)^{f(z,d)+f(z,0)}  satisfies  S_d == N_d - 2 E_F  (mod 4),
    E_F = #{z in Fix(R^3) : B_z d = 0, f(z,d)+f(z,0) = 1},  Fix(R^3) = {0,9,18,36,27,45,54,63}.
So 'S_d = 0 mod 4' only sees the 8 R^3-fixed rows (phase rank small).  Test its strength on the 98 survivors
and on all 1176 (Pf4) homogeneous polars.
Usage: python -I sd_mod4_r3.py"""
import sys, os, json, collections, random
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from bc_comum import *
from oito_parametros_lib import params

here = os.path.dirname(os.path.abspath(__file__))
homog = json.load(open(os.path.join(here, "homog1176.json")))
surv = set(json.load(open(os.path.join(here, "mapa_filtros.json")))["surv98"])
piv = {}
for r in EQ:
    while r:
        c = r.bit_length() - 1
        if c in piv: r ^= piv[c]
        else: piv[c] = r; break
pr = {}
for c in sorted(piv):
    r = piv[c]
    for h in sorted(pr, reverse=True):
        if r >> h & 1: r ^= pr[h]
    for k in list(pr):
        if pr[k] >> c & 1: pr[k] ^= r
    pr[c] = r
phase = []
for c in [c for c in range(43) if c not in pr]:
    v = 1 << c
    for h, r in pr.items():
        if r >> c & 1: v |= 1 << h
    phase.append(v)
PH = [ftab_zw([v >> j & 1 for j in range(43)]) for v in phase]
FIX = [0, 9, 18, 36, 27, 45, 54, 63]
DS = [9, 27, 63]


def Sd(F, K, d):
    sel = K[:, d]
    e = (F[:, d] ^ F[:, 0]).astype(np.int64)
    return int((1 - 2 * e[sel]).sum())


# 1. verify the lemma on random model functions
random.seed(2)
for _ in range(200):
    t = [random.getrandbits(1) for _ in range(43)]
    t[37] = sum(t[j] for j in L456 if j != 37) & 1
    t[36] = sum(t[j] for j in L464 if j != 36) & 1
    F = ftab_zw(t); K = Bd_zero(polar_of(t))
    for d in DS:
        N = int(K[:, d].sum())
        EF = sum(1 for z in FIX if K[z, d] and (F[z, d] ^ F[z, 0]))
        assert (Sd(F, K, d) - (N - 2 * EF)) % 4 == 0
print("lemma S_d = N_d - 2 E_F (mod 4) for d in {9,27,63}: ok on 200 random model functions")

# phase classes seen by the fixed rows
vecs = []
for P in PH:
    v = 0
    for k, z in enumerate(FIX):
        v |= int(sum(int(P[z, w]) << w for w in range(64))) << (64 * k)
    vecs.append(v)
pp = {}; chosen = []
for i, v in enumerate(vecs):
    x = v
    while x:
        c = x.bit_length() - 1
        if c in pp: x ^= pp[c]
        else: pp[c] = x; chosen.append(i); break
print("phase rank on the 8 R^3-fixed rows:", len(chosen))

CASE = {(0, 0, 0): "A", (1, 1, 0): "B", (1, 0, 1): "C"}
stat = collections.defaultdict(collections.Counter)
for c in homog:
    k = params(c)
    key = (CASE[k[:3]], k[3:5], c in surv)
    t = t_from_coords(c)
    F0 = ftab_zw(t); K = Bd_zero(polar_of(t))
    ok_any = False
    for bits_ in range(1 << len(chosen)):
        F = F0.copy()
        for q, i in enumerate(chosen):
            if bits_ >> q & 1: F ^= PH[i]
        if all(Sd(F, K, d) % 4 == 0 for d in DS):
            ok_any = True; break
    stat[key]["total"] += 1
    stat[key]["passes S_d mod 4 (d=9,27,63)"] += ok_any
for key in sorted(stat):
    print(key, dict(stat[key]))
