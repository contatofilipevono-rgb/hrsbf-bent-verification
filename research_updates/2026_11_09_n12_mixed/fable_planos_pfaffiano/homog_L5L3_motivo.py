"""Why do (L5)+(L3) kill the homogeneous case?  For each homogeneous (Pf4) polar:
  - rows of (L5)+(L3) on the homogeneous phase space (20 dims): (phase mask, constant);
  - phase-free rows with constant 1 (an obstruction depending on the polar only), by family / |I| / w0;
  - otherwise the size of a minimal contradictory combination.
Measurement only."""
import os, sys, json, itertools, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from base12 import orbitas, mobius, ZW, wtw, polar, pack, elim_comb, X
from lista_polares import hexB
from poisson5 import tabela
from verifica_L5L3 import bits as l5bits, HYP, D3, I2

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
KH = [np.bitwise_xor.reduce([HV[j] for j in range(len(HV)) if k >> j & 1], axis=0) for k in pker]
Ktab = [tabela(k) for k in KH]
listed = {int(h, 16) for h in open(os.path.join(here, "polares_18816.txt")).read().split()}
Pint = [int(hexB(B), 16) for B in PB]
cur = [0]
for v in Pint:
    cur = cur + [x ^ v for x in cur]
nL5 = 22 * 126


def label(r):
    if r < nL5:
        i, vw = divmod(r, 126)
        return ("L5", "|I|=%d" % bin(I2[i]).count("1"), "w0=%d" % (vw % 2))
    r -= nL5
    i, vw = divmod(r, 11160)
    return ("L3", "|I|=%d" % bin(I2[i]).count("1"), "")


stats = collections.Counter(); free_labels = collections.Counter(); minsize = collections.Counter()
for code, x in enumerate(cur):
    if x not in listed:
        continue
    f = np.zeros(4096, dtype=np.uint8)
    for i in range(len(PB)):
        if code >> i & 1:
            f ^= PF[i]
    G0 = tabela(f)
    b0 = l5bits(G0)
    M = np.stack([l5bits(G0 ^ K) ^ b0 for K in Ktab], axis=1)
    masks = (M.astype(np.int64) << np.arange(M.shape[1])).sum(axis=1)
    free_bad = np.nonzero((masks == 0) & (b0 == 1))[0]
    if len(free_bad):
        stats["dies by a phase-free row"] += 1
        for r in set(label(int(r)) for r in free_bad):
            free_labels[r] += 1
        continue
    # linear inconsistency needing several rows: size of the combination (greedy elimination with tracking)
    piv = {}; found = None
    for r in range(M.shape[0]):
        v = (int(masks[r]) << 1) | int(b0[r]); comb = {r}
        while v > 1 and (v.bit_length() - 1) in piv:
            pv, pc = piv[v.bit_length() - 1]; v ^= pv; comb = comb ^ pc
        if v == 1:
            found = comb; break
        if v > 1:
            piv[v.bit_length() - 1] = (v, comb)
    if found is None:
        stats["survives (L5)+(L3)"] += 1
    else:
        stats["needs a combination"] += 1
        minsize[min(len(found), 20)] += 1
print(dict(stats))
print("labels of the phase-free contradictory rows (polars having one):")
for k, v in free_labels.most_common(12):
    print("  ", k, v)
print("combination sizes (when needed):", sorted(minsize.items()))
