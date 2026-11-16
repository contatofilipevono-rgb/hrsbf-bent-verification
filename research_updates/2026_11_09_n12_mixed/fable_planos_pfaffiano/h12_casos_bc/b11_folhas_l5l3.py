"""B(1,1): per affine leaf of the (Pf4) tree, the polars passing 8 rows + parity, and a greedy cover by phase-free
(L5)/(L3) rows (or 'combination').  Is each leaf killed by 1-2 uniform rows?
Usage: python -I b11_folhas_l5l3.py REPO_DIR"""
import sys, os, json, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
REPO = sys.argv[1]; sys.path.insert(1, REPO)
import numpy as np
from bc_comum import *
from verifica_L5L3 import bits as l5bits, I2

here = os.path.dirname(os.path.abspath(__file__))
leaves = json.load(open(os.path.join(here, "pf4_b11_folhas.json")))
sols = json.load(open(os.path.join(here, "pf4_b11_solucoes.json")))
surv = set(int("".join(reversed(c)), 2) for c in json.load(open(os.path.join(here, "mapa_filtros.json")))["surv98"])
def member(c, path):
    for v, o, val in path:
        x = (c >> v & 1) ^ val
        if o is not None:
            x ^= c >> o & 1
        if x: return False
    return True
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
def killers(code):
    cs = "".join(str(code >> i & 1) for i in range(21))
    F0 = ftab_zw(t_from_coords(cs)); b0 = l5bits(F0)
    Mx = np.stack([l5bits(F0 ^ P) ^ b0 for P in PH], axis=1)
    masks = (Mx.astype(np.int64) << np.arange(Mx.shape[1])).sum(axis=1)
    return set(int(r) for r in np.nonzero((masks == 0) & (b0 == 1))[0])
tot = 0
for li, path in enumerate(leaves):
    mem = [c for c in sols if member(c, path)]
    ss = [c for c in mem if c in surv]
    kd = {c: killers(c) for c in ss}
    left = set(ss); cover = []
    while left:
        cand = collections.Counter(r for c in left for r in kd[c])
        if not cand: break
        r, n = cand.most_common(1)[0]
        cover.append(n); left -= {c for c in left if r in kd[c]}
    tot += len(cover) + len(left)
    print("leaf %2d: polars %3d, pass 8 rows+parity %3d, rows needed %d %s, combination-only %d" % (li, len(mem), len(ss), len(cover), cover, len(left)))
print("total checks (rows + combination polars):", tot)
