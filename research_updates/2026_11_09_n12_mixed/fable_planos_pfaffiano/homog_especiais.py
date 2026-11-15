"""H12: the 5 special homogeneous polars.  For each: homogeneous phase space after (L5)+(L3), then the exact
branching certificate (families S, W, F; cert_arvore3.Prover3) on that space, verified by verifica_arvore3.
Usage: python homog_especiais.py <polar prefix> [--out file.json]"""
import os, sys, json, time
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from base12 import orbitas, mobius, ZW, wtw, polar, pack, elim_comb, X
from lista_polares import hexB
from poisson5 import tabela
from verifica_L5L3 import bits as l5bits, gf2_solve

pref = sys.argv[1]
out_path = sys.argv[sys.argv.index("--out") + 1] if "--out" in sys.argv else "homog_%s.json" % pref
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
Pint = [int(hexB(B), 16) for B in PB]
here = os.path.dirname(os.path.abspath(__file__))
listed = {int(h, 16) for h in open(os.path.join(here, "polares_18816.txt")).read().split()}
cur = [0]
for v in Pint:
    cur = cur + [x ^ v for x in cur]
from cert_autocorr import analyse as simple_levels
targets = []
for code, x in enumerate(cur):
    if x not in listed or not format(x, "x").startswith(pref):
        continue
    f = np.zeros(4096, dtype=np.uint8)
    for i in range(len(PB)):
        if code >> i & 1:
            f ^= PF[i]
    G0 = tabela(f)
    b0 = l5bits(G0)
    M = np.stack([l5bits(G0 ^ K) ^ b0 for K in Ktab], axis=1)
    rows = {}
    for r in range(M.shape[0]):
        rows[(int(sum(1 << k for k in np.flatnonzero(M[r]))), int(b0[r]))] = 1
    sol = gf2_solve(list(rows), len(Ktab))
    if sol is None:
        continue
    pt, kv = sol
    T0_ = G0.copy()
    for j in range(len(Ktab)):
        if pt >> j & 1:
            T0_ ^= Ktab[j]
    Kp_ = []
    for v in kv:
        t = np.zeros_like(G0)
        for j in range(len(Ktab)):
            if v >> j & 1:
                t ^= Ktab[j]
        Kp_.append(t)
    if simple_levels(T0_, Kp_)["level"] == "open":
        targets.append((format(x, "x"), G0, sol))
print(pref, "homogeneous (Pf4) polars with this prefix surviving the simple levels:", len(targets), flush=True)
assert len(targets) == 1, "expected exactly one special polar with this prefix"
hx, G0, (part, kerv) = targets[0]
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
print(pref, "homogeneous phase after (L5)+(L3): dim", len(Kp), flush=True)
from cert_colunas import pairs_of
from cert_arvore3 import Prover3, size, leaves
by_d = {}
for z, d, form, g in pairs_of(T0, Kp):
    if d:
        by_d.setdefault(d, []).append((form, g))
os.environ.setdefault("CERT_STRONG", "8"); os.environ.setdefault("CERT_RECOMPUTE", "1000")
pr = Prover3(T0, Kp, by_d)
t0 = time.time()
cert = pr.prove(0, [1 << i for i in range(len(Kp))], [], [10 ** 7])
lv = leaves(cert, {})
status = "certified" if not any(k in lv for k in ("point-open", "allbent")) else "OPEN"
print(pref, status, "nodes", size(cert), lv, pr.calls, round(time.time() - t0, 1), "s", flush=True)
# independent verification on the same (T0, Kp)
from verifica_arvore import Polar
from verifica_arvore3 import Checker
P = Polar(T0, Kp)
ok = Checker(P).node(cert, np.zeros(P.m, np.int64), np.eye(P.m, dtype=np.int64), {})
print(pref, "verified:", ok, flush=True)
json.dump({"polar": hx, "phase_dim": len(Kp), "status": status, "verified": bool(ok), "nodes": size(cert),
           "leaves": lv, "calls": pr.calls, "cert": cert}, open(out_path, "w"))
