"""The best (L3) rows on B(1,1): on which polars of the B(1,1) (Pf4) hull (4096 polars) is the row phase-free
with constant 1?  Is that set an affine family?  Also: describe V and w0.
Usage: python -I l3_uniforme.py REPO_DIR"""
import sys, os, json, collections, itertools
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
REPO = sys.argv[1]
sys.path.insert(1, REPO)
import numpy as np
from bc_comum import *
from verifica_L5L3 import HYP, D3, I2, MI2, MI1, H_idx, D_idx

here = os.path.dirname(os.path.abspath(__file__))
homog = json.load(open(os.path.join(here, "homog1176.json")))
M = json.load(open(os.path.join(here, "mapa_filtros.json")))
surv = set(M["surv98"])
from oito_parametros_lib import params
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

ROWS = [("L3", 1, 6160), ("L3", 1, 4576), ("L3", 1, 1560), ("L3", 1, 4352), ("L3", 1, 3608)]


def l3bit(F, Imask, vw):
    S = 1 - 2 * F.astype(np.int64)
    idxs = D_idx[vw]
    K = S[:, idxs].sum(axis=1)
    sel = (np.arange(64) & Imask) == Imask
    return int((K[sel].sum() >> 2) & 1), K


for fam, Im, vw in ROWS:
    V, reps = D3[vw // 8]
    print("row", fam, "I=", Im, "V=", [format(v, "06b")[::-1] for v in V if v], "w0=", format(reps[vw % 8], "06b")[::-1])

B11 = [c for c in homog if params(c)[:5] == (1, 1, 0, 1, 1)]
print("B(1,1) Pf4 polars:", len(B11))
# hull of B(1,1) Pf4 polars
def toint(c): return sum(int(c[i]) << i for i in range(21))
base = toint(B11[0])
pv = {}
for c in B11:
    x = toint(c) ^ base
    while x:
        h = x.bit_length() - 1
        if h in pv: x ^= pv[h]
        else: pv[h] = x; break
hull = [base]
for v in pv.values():
    hull = hull + [h ^ v for h in hull]
print("hull size", len(hull))
pf4set = set(toint(c) for c in B11)
survset = set(toint(c) for c in surv)
for fam, Im, vw in ROWS:
    kill = []
    for x in hull:
        code = "".join(str(x >> i & 1) for i in range(21))
        F0 = ftab_zw(t_from_coords(code))
        b0, _ = l3bit(F0, Im, vw)
        if b0 == 0:
            continue
        free = all(l3bit(F0 ^ P, Im, vw)[0] == b0 for P in PH)
        if free:
            kill.append(x)
    ks = set(kill)
    # affine hull dimension of kill set
    if kill:
        b = kill[0]; pk = {}
        for x in kill:
            y = x ^ b
            while y:
                h = y.bit_length() - 1
                if h in pk: y ^= pk[h]
                else: pk[h] = y; break
        d = len(pk)
    else:
        d = -1
    print("row", (fam, Im, vw), ": kills", len(kill), "of hull 4096; affine dim", d,
          "affine?", len(kill) == 2 ** d if kill else None,
          "| Pf4 killed", len(ks & pf4set), "| surv killed", len(ks & survset))
