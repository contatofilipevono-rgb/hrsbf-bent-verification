"""The homogeneous candidates not killed by the 8 fixed rows: which polar-only criteria kill them?
  parity: some N_d odd (P_B != 0);
  L5 pair sums: sum_{z >= I, z in Z_V} B_z(w1, r_z) = 1 for some hyperplane V and |I| <= 2 (phase-free combination of
                the two (L5) equations w0 = 0 and w0 = w1);
and what is left after them (with the (L5)+(L3) linear system on the homogeneous phase)."""
import os, sys, json, collections, itertools
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from base12 import orbitas, mobius, ZW, wtw, polar, pack, elim_comb, X
from lista_polares import hexB
from poisson5 import tabela, Bv_table, radicais
from verifica_L5L3 import bits as l5bits, gf2_solve

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
killed8 = set(json.load(open(os.path.join(here, "homog_linhas_fixas.json")))["killed"])
listed = {int(h, 16) for h in open(os.path.join(here, "polares_18816.txt")).read().split()}
Pint = [int(hexB(B), 16) for B in PB]
cur = [0]
for v in Pint:
    cur = cur + [x ^ v for x in cur]
Zs = np.arange(64)
par6 = np.array([bin(i).count("1") & 1 for i in range(64)])
MI = np.array([(Zs & m) == m for m in [0] + [1 << i for i in range(6)] + [(1 << i) | (1 << j) for i, j in itertools.combinations(range(6), 2)]], dtype=np.int64)
res = collections.Counter(); left = []
for code, x in enumerate(cur):
    if x not in listed or format(x, "x") in killed8:
        continue
    f = np.zeros(4096, dtype=np.uint8)
    for i in range(len(PB)):
        if code >> i & 1:
            f ^= PF[i]
    G = tabela(f)
    B = polar(f)[0]
    Bv = Bv_table(B)
    N = (Bv == 0).sum(axis=0)
    if any(N[d] % 2 for d in range(1, 64)):
        res["parity (some N_d odd)"] += 1; continue
    # L5 pair sums: for each eta, rank-4 rows, r_z; B_z(w1, r_z) = parity(Bv[z, w1] & r_z)
    bad = False
    for eta in range(1, 64):
        m4, r = radicais(Bv, eta)
        if not m4.any():
            continue
        w1 = next(w for w in range(64) if par6[w & eta])
        vals = par6[Bv[Zs, w1] & r] * m4
        sums = (MI @ vals) & 1
        if sums.any():
            bad = True; break
    if bad:
        res["L5 pair sum = 1"] += 1; continue
    # (L5)+(L3) on the homogeneous phase
    b0 = l5bits(G)
    M = np.stack([l5bits(G ^ K) ^ b0 for K in KH], axis=1)
    rows = {}
    for r_ in range(M.shape[0]):
        rows[(int(sum(1 << k for k in np.flatnonzero(M[r_]))), int(b0[r_]))] = 1
    if gf2_solve(list(rows), len(KH)) is None:
        res["(L5)+(L3) linear system"] += 1; continue
    res["left"] += 1; left.append(format(x, "x"))
print(dict(res))
json.dump(left, open(os.path.join(here, "homog_resto.json"), "w"))
