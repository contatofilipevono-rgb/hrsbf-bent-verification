"""For the 98 polar-only survivors (94 in B(1,1), 4 in C(1,1)): how (L5)+(L3) kills them.
 - phase-free rows with constant 1 (polar-only certificates): which (family, I, eta/V, w0) ones;
 - is there a small set of such rows covering all polars?
Usage: python -I l5l3_sobreviventes.py REPO_DIR"""
import sys, os, json, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
REPO = sys.argv[1]
sys.path.insert(1, REPO)
import numpy as np
from bc_comum import *
from verifica_L5L3 import bits as l5bits, HYP, D3, I2

here = os.path.dirname(os.path.abspath(__file__))
M = json.load(open(os.path.join(here, "mapa_filtros.json")))
surv = M["surv98"]
# phase basis
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
nL5 = 22 * 126


def label(r):
    if r < nL5:
        i, vw = divmod(r, 126)
        eta = vw // 2 + 1
        return ("L5", I2[i], eta, vw % 2)
    r -= nL5
    i, vw = divmod(r, 11160)
    return ("L3", I2[i], vw)


rowkill = collections.defaultdict(set)
how = collections.Counter()
for c in surv:
    t = t_from_coords(c)
    F0 = ftab_zw(t)
    b0 = l5bits(F0)
    Mx = np.stack([l5bits(F0 ^ P) ^ b0 for P in PH], axis=1)
    masks = (Mx.astype(np.int64) << np.arange(Mx.shape[1])).sum(axis=1)
    bad = np.nonzero((masks == 0) & (b0 == 1))[0]
    case = "B" if c[:3] == "110" else "C"
    if len(bad):
        how[(case, "phase-free row")] += 1
        for r in bad:
            rowkill[label(int(r))].add(c)
    else:
        how[(case, "combination")] += 1
print(dict(how))
# greedy cover by phase-free rows
left = set(c for c in surv)
killed_any = set().union(*rowkill.values()) if rowkill else set()
print("polars with a phase-free row:", len(killed_any))
cover = []
rem = set(killed_any)
while rem:
    best = max(rowkill, key=lambda k: len(rowkill[k] & rem))
    cover.append((best, len(rowkill[best] & rem)))
    rem -= rowkill[best]
print("greedy cover size", len(cover))
for k, n in cover[:30]:
    print("  ", k, n)
fam = collections.Counter((k[0], bin(k[1]).count("1")) for k in rowkill)
print("row types available:", dict(fam))
