"""Low-weight column test for the homogeneous candidates (polar-only, no phase).

For z of weight <= 1, a homogeneous quartic in the model has f(z, .) = q_z, a pure quadratic form in w (monomials of
(z,w)-degree (0,2), (1,2) only), so r_b(z) = sum_w (-1)^{q_z(w) + b.w} depends on the polar only.
Parseval in column b: sum_z r_b(z)^2 = 4096.  Kill if for some b the 7 low points alone give more than 4096.
Also the weaker 'equality' info: if they give exactly 4096, every other z must be inactive in that column.
Counts over the 1,176 homogeneous (Pf4) polars (and their Gamma-orbits)."""
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
KH = [np.bitwise_xor.reduce([HV[j] for j in range(len(HV)) if k >> j & 1], axis=0) for k in pker]
listed = {int(h, 16) for h in open(os.path.join(here, "polares_18816.txt")).read().split()}
Pint = [int(hexB(B), 16) for B in PB]
cur = [0]
for v in Pint:
    cur = cur + [x ^ v for x in cur]
LOW = [0] + [1 << i for i in range(6)]
H64 = np.array([[1 - 2 * (bin(a & b).count("1") & 1) for b in range(64)] for a in range(64)])
# check: on low z, the phase (zero-polar homogeneous functions) vanishes
assert all(not tabela(k)[LOW].any() for k in KH), "phase does not vanish on low z"
res = collections.Counter(); killed = []
for code, x in enumerate(cur):
    if x not in listed:
        continue
    f = np.zeros(4096, dtype=np.uint8)
    for i in range(len(PB)):
        if code >> i & 1:
            f ^= PF[i]
    G = tabela(f)
    R = (1 - 2 * G[LOW].astype(np.int64)) @ H64            # 7 x 64 : r_b(z) for low z
    col = (R ** 2).sum(axis=0)                              # per column b
    if (col > 4096).any():
        res["killed: low points exceed 4096 in some column"] += 1; killed.append(format(x, "x"))
    elif (col == 4096).any():
        res["low points fill some column exactly (all other z inactive there)"] += 1
    else:
        res["no information"] += 1
print(dict(res))
orbs = json.load(open(os.path.join(here, "estr_out", "orbitas_18816.json")))
oid = {}
for k, o in enumerate(orbs):
    for h in o:
        oid[h] = k
print("Gamma-orbits of the killed:", len({oid[h] for h in killed}))
det = json.load(open(os.path.join(here, "mede_homogeneo.json")))["detail"]
op = {d[0] for d in det if d[1] == "open"}
print("special (open) polars killed by this test:", [h[:12] for h in killed if h[:12] in op])
json.dump(killed, open(os.path.join(here, "homog_coluna_baixa.json"), "w"))
