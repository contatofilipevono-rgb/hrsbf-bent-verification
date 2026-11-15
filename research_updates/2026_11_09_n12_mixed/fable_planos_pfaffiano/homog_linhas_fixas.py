"""Rows z where |r_b(z)| does not depend on the homogeneous phase (the phase only adds a constant in w there).
Polar-only Parseval bound: sum over those rows of r_b(z)^2 <= 4096 for every column b.  How many of the 1,176
homogeneous candidates does it kill, compared with the 7 low-weight rows?"""
import os, sys, json, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from base12 import orbitas, mobius, ZW, wtw, polar, pack, elim_comb, X
from lista_polares import hexB
from poisson5 import tabela

here = os.path.dirname(os.path.abspath(__file__))
ORB = [o for o in orbitas() if o[0] == 4]
TT = []
for o in ORB:
    t = np.zeros(4096, dtype=np.uint8)
    for m in o[2]:
        t ^= ((X & m) == m).astype(np.uint8)
    TT.append(t)
AN = [mobius(t[ZW].copy(), 12) for t in TT]
ind, ker = elim_comb([pack(a[wtw >= 3]) for a in AN])
HV = [np.bitwise_xor.reduce([TT[i] for i in range(len(TT)) if k >> i & 1], axis=0) for k in ker]
Bs = [polar(t)[0] for t in HV]
pind, pker = elim_comb([pack(B) for B in Bs])
PB = [Bs[i.bit_length() - 1] for i in pind]; PF = [HV[i.bit_length() - 1] for i in pind]
KH = [tabela(np.bitwise_xor.reduce([HV[j] for j in range(len(HV)) if k >> j & 1], axis=0)) for k in pker]
# rows where every phase function is constant in w
fixed = [z for z in range(64) if all((K[z] == K[z][0]).all() for K in KH)]
POP = [bin(z).count("1") for z in range(64)]
print("rows z with phase-independent |r_b(z)|:", len(fixed), "| by weight:", dict(collections.Counter(POP[z] for z in fixed)))
listed = {int(h, 16) for h in open(os.path.join(here, "polares_18816.txt")).read().split()}
Pint = [int(hexB(B), 16) for B in PB]
cur = [0]
for v in Pint:
    cur = cur + [x ^ v for x in cur]
H64 = np.array([[1 - 2 * (bin(a & b).count("1") & 1) for b in range(64)] for a in range(64)])
LOW = [0] + [1 << i for i in range(6)]
res = collections.Counter(); killed = []
for code, x in enumerate(cur):
    if x not in listed:
        continue
    f = np.zeros(4096, dtype=np.uint8)
    for i in range(len(PB)):
        if code >> i & 1:
            f ^= PF[i]
    G = tabela(f)
    R = (1 - 2 * G[fixed].astype(np.int64)) @ H64
    col = (R ** 2).sum(axis=0)
    Rl = (1 - 2 * G[LOW].astype(np.int64)) @ H64
    low = (Rl ** 2).sum(axis=0)
    k_fixed = bool((col > 4096).any()); k_low = bool((low > 4096).any())
    res[("fixed rows kill", k_fixed, "low rows kill", k_low)] += 1
    if k_fixed:
        killed.append(format(x, "x"))
for k, v in sorted(res.items()):
    print(k, v)
json.dump({"fixed_rows": fixed, "killed": killed}, open(os.path.join(here, "homog_linhas_fixas.json"), "w"))
