"""Sylow localization for n = 12 (rotation group acting on rows z through Z6 = Z2 x Z3).
 2-part <R^3>: for d in Fix(R^3) = {9,18,36,27,45,54,63}:
     S_d == N_d - 2 E_F (mod 4), E_F over the rows Fix(R^3) = {0,9,18,36,27,45,54,63}.        [cond 2a]
 3-part <R^2>: for d in Fix(R^2) = {21,42,63}:
     S_d == sum_{z in {0,21,42,63}, B_z d = 0} (-1)^{f(z,d)+f(z,0)} (mod 3), and S_d = 0.       [cond 3a]
   column 0, u in Fix(R^2) = {0,21,42,63}:
     W(u,0) = sum_z (-1)^{u.z} r_0(z) == sum_{z in {0,21,42,63}} (-1)^{u.z} r_0(z) (mod 3), and W = +-64 = +-1 mod 3. [cond 3b]
Identities are checked on random model functions; then the strength of 2a + 3a + 3b (with the phase on the
localized rows enumerated) is measured on the (Pf4) polars.
Usage: python -I sylow_localizacao.py"""
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
FIX2 = [0, 9, 18, 36, 27, 45, 54, 63]
FIX3 = [0, 21, 42, 63]
D2 = [9, 27, 63]
D3 = [21, 42, 63]
par6 = np.array([bin(i).count("1") & 1 for i in range(64)])


def Sd(F, K, d, rows=None):
    sel = K[:, d].copy()
    if rows is not None:
        m = np.zeros(64, bool); m[rows] = True; sel &= m
    e = (F[:, d] ^ F[:, 0]).astype(np.int64)
    return int((1 - 2 * e[sel]).sum())


def W_u0(F, rows=None):
    R0 = (1 - 2 * F.astype(np.int64)).sum(axis=1)          # r_0(z)
    out = {}
    for u in FIX3:
        sg = 1 - 2 * par6[np.arange(64) & u]
        if rows is None:
            out[u] = int((sg * R0).sum())
        else:
            out[u] = int((sg * R0)[rows].sum())
    return out


random.seed(4)
for _ in range(200):
    t = [random.getrandbits(1) for _ in range(43)]
    t[37] = sum(t[j] for j in L456 if j != 37) & 1
    t[36] = sum(t[j] for j in L464 if j != 36) & 1
    F = ftab_zw(t); K = Bd_zero(polar_of(t))
    for d in D2:
        N = int(K[:, d].sum()); EF = sum(1 for z in FIX2 if K[z, d] and (F[z, d] ^ F[z, 0]))
        assert (Sd(F, K, d) - (N - 2 * EF)) % 4 == 0
    for d in D3:
        assert (Sd(F, K, d) - Sd(F, K, d, FIX3)) % 3 == 0
    a, b = W_u0(F), W_u0(F, FIX3)
    for u in FIX3:
        assert (a[u] - b[u]) % 3 == 0
print("localization identities (mod 4 on Fix(R^3), mod 3 on Fix(R^2)): ok on 200 random model functions")


def classes(rows):
    vecs = []
    for P in PH:
        v = 0
        for k, z in enumerate(rows):
            v |= int(sum(int(P[z, w]) << w for w in range(64))) << (64 * k)
        vecs.append(v)
    pp = {}; ch = []
    for i, v in enumerate(vecs):
        x = v
        while x:
            c = x.bit_length() - 1
            if c in pp: x ^= pp[c]
            else: pp[c] = x; ch.append(i); break
    return ch


ROWS = sorted(set(FIX2) | set(FIX3))
CH = classes(ROWS)
print("phase rank on the 10 localized rows", ROWS, ":", len(CH))
CASE = {(0, 0, 0): "A", (1, 1, 0): "B", (1, 0, 1): "C"}
stat = collections.defaultdict(collections.Counter)
left = []
for c in homog:
    k = params(c)
    key = (CASE[k[:3]], k[3:5], c in surv)
    t = t_from_coords(c)
    F0 = ftab_zw(t); K = Bd_zero(polar_of(t))
    Nd = {d: int(K[:, d].sum()) for d in D2}
    got = collections.Counter()
    for bits_ in range(1 << len(CH)):
        F = F0.copy()
        for q, i in enumerate(CH):
            if bits_ >> q & 1: F ^= PH[i]
        c2 = all((Nd[d] - 2 * sum(1 for z in FIX2 if K[z, d] and (F[z, d] ^ F[z, 0]))) % 4 == 0 for d in D2)
        c3a = all(Sd(F, K, d, FIX3) % 3 == 0 for d in D3)
        w = W_u0(F, FIX3)
        c3b = all(w[u] % 3 != 0 for u in FIX3)
        got["2a"] |= c2; got["3a"] |= c3a; got["3b"] |= c3b
        got["3a&3b"] |= c3a and c3b
        got["all"] |= c2 and c3a and c3b
    stat[key]["total"] += 1
    for kk, v in got.items():
        stat[key][kk] += v
    if key[2] and got["all"]:
        left.append(c)
for key in sorted(stat):
    print(key, dict(stat[key]))
json.dump(left, open(os.path.join(here, "sylow_sobrev.json"), "w"))
print("survivors (among the 98) of 2a+3a+3b:", len(left))
