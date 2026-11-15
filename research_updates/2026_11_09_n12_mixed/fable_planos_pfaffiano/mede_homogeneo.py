"""Size of the homogeneous quartic case (H12) inside the polar framework.  Measurement only (not part of a proof).

H = homogeneous quartic RS functions (43 orbit sums); H_V = those quadratic in w (model).  For f in H_V the polar is
pure top.  Candidates = polars of H_V that are among the 18,816 (Pf4) polars; their Gamma-orbits; for each candidate,
the homogeneous phase space and which simple level kills it: (L5)+(L3) (independent bits), autocorrelation odd/mod4."""
import os, sys, json, itertools, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from base12 import orbitas, mobius, ZW, wtw, polar, pack, elim_comb, X
from lista_polares import hexB

here = os.path.dirname(os.path.abspath(__file__))
ORB = [o for o in orbitas() if o[0] == 4]
print("quartic orbits:", len(ORB))
TT = []
for o in ORB:
    t = np.zeros(4096, dtype=np.uint8)
    for m in o[2]:
        t ^= ((X & m) == m).astype(np.uint8)
    TT.append(t)
AN = [mobius(t[ZW].copy(), 12) for t in TT]
alto = wtw >= 3
ind, ker = elim_comb([pack(a[alto]) for a in AN])
HV = [np.bitwise_xor.reduce([TT[i] for i in range(len(TT)) if k >> i & 1], axis=0) for k in ker]
print("dim H_V (homogeneous quartic RS, quadratic in w):", len(HV))
Bs = [polar(t)[0] for t in HV]
pind, pker = elim_comb([pack(B) for B in Bs])
print("dim of the homogeneous polar image:", len(pind), "| homogeneous zero-polar (phase) dim:", len(pker))
PB = [Bs[i.bit_length() - 1] for i in pind]; PF = [HV[i.bit_length() - 1] for i in pind]
KH = [np.bitwise_xor.reduce([HV[j] for j in range(len(HV)) if k >> j & 1], axis=0) for k in pker]
listed = set(open(os.path.join(here, "polares_18816.txt")).read().split())
listed_int = {int(h, 16) for h in listed}
Pint = [int(hexB(B), 16) for B in PB]
print("enumerating", 1 << len(PB), "homogeneous polars", flush=True)
cands = []
cur = [0]
for v in Pint:                                   # all XOR combinations, as integers (Gray-free doubling)
    cur = cur + [x ^ v for x in cur]
codes = {}
for code, x in enumerate(cur):
    if x in listed_int:
        f = np.zeros(4096, dtype=np.uint8)
        for i in range(len(PB)):
            if code >> i & 1:
                f ^= PF[i]
        cands.append((format(x, "x"), f))
print("homogeneous polars in the (Pf4) list:", len(cands), "of", 1 << len(PB), flush=True)
# Gamma-orbits among the candidates (from the orbit file)
orbs = json.load(open(os.path.join(here, "estr_out", "orbitas_18816.json")))
oid = {}
for k, o in enumerate(orbs):
    for h in o:
        oid[h] = k
print("their Gamma-orbits:", len({oid[h] for h, _ in cands}))
# phase: homogeneous zero-polar functions; tables in (z, w)
from poisson5 import tabela
from verifica_L5L3 import bits as l5bits, gf2_solve
from cert_autocorr import analyse
Ktab = [tabela(k) for k in KH]
levels = collections.Counter(); detail = []
for hx, f in cands:
    G0 = tabela(f)
    b0 = l5bits(G0)
    cols = [l5bits(G0 ^ K) ^ b0 for K in Ktab]
    M = np.stack(cols, axis=1) if cols else np.zeros((len(b0), 0), np.uint8)
    rows = {}
    for r in range(M.shape[0]):
        rows[(int(sum(1 << k for k in np.flatnonzero(M[r]))), int(b0[r]))] = 1
    sol = gf2_solve(list(rows), len(Ktab))
    if sol is None:
        levels["dead by (L5)+(L3)"] += 1; detail.append((hx[:12], "L5L3", None)); continue
    part, kerv = sol
    T0 = G0.copy()
    for j in range(len(Ktab)):
        if part >> j & 1:
            T0 ^= Ktab[j]
    Kp = []
    for v in kerv:
        t = np.zeros_like(G0)
        for j in range(len(Ktab)):
            if v >> j & 1:
                t ^= Ktab[j]
        Kp.append(t)
    a = analyse(T0, Kp)
    levels[a["level"]] += 1
    detail.append((hx[:12], a["level"], len(kerv)))
print("how the homogeneous candidates die:", dict(levels))
print("open (not killed by these simple levels):", [d for d in detail if d[1] == "open"])
json.dump({"dim_HV": len(HV), "polar_dim": len(pind), "phase_dim": len(pker), "candidates": len(cands),
           "levels": dict(levels), "detail": detail}, open(os.path.join(here, "mede_homogeneo.json"), "w"))
