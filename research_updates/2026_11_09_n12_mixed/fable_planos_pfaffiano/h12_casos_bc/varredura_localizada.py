"""Sweep of all 2^18 polars of cases B and C WITHOUT (Pf4): how far do the hand-tractable conditions go?
  T8  : 8-row test (table, Lemma 8);
  Ploc: parity at the R^3-fixed directions d in {9, 27, 63} (quadratic polynomials, Lemma 6);
  Pall: parity at every d (degree-4 polynomials; not hand-friendly);
  L2  : S_d = N_d - 2E_F = 0 mod 4 for d in {9,27,63}, phase on the 8 R^3-fixed rows (exists a phase);
  L3  : S_d = 0 mod 3 on rows {0,21,42,63} for d in {21,42,63} (exists a phase, jointly with L2).
Vectorized in chunks (memory ~100 MB).  Usage: python -I varredura_localizada.py"""
import sys, os, json, collections, itertools
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from bc_comum import *

here = os.path.dirname(os.path.abspath(__file__))
tab8 = json.load(open(os.path.join(here, "oito_tabela.json")))
T8 = np.zeros(1 << 11, dtype=bool)
for k, v in tab8.items():
    T8[int(k[::-1], 2)] = v[0]          # key bits (u30,u40,u42,al,be,x1,x2,y1,y2,w1,w2) -> index with u30 as bit 0
par = np.load(os.path.join(here, "paridade_tab.npy"))   # [13 reps, 2^21]
reps = json.load(open(os.path.join(here, "paridade_anf.json")))["reps"]
iloc = [reps.index(d) for d in (9, 27, 63)]
homog = set(int(c[::-1], 2) for c in json.load(open(os.path.join(here, "homog1176.json"))))

FIX2 = [0, 9, 18, 36, 27, 45, 54, 63]
FIX3 = [0, 21, 42, 63]
D2 = [9, 27, 63]; D3 = [21, 42, 63]
DALL = sorted(set(D2 + D3))
NB = 21
# linear data per coordinate basis vector k
Bw = np.zeros((NB, 64, len(DALL)), dtype=np.uint8)     # B_z d as 6-bit word
Eb = np.zeros((NB, 64, len(DALL)), dtype=np.uint8)     # e(z,d) = f(z,d) + f(z,0)
for k in range(NB):
    code = "".join("1" if i == k else "0" for i in range(NB))
    t = t_from_coords(code)
    B = polar_of(t); F = ftab_zw(t)
    for j, d in enumerate(DALL):
        for z in range(64):
            v = 0
            for i in range(6):
                s = 0
                for kk, (a, b) in enumerate(PAIRS):
                    if B[kk][z]:
                        if a == i and d >> b & 1: s ^= 1
                        if b == i and d >> a & 1: s ^= 1
                v |= s << i
            Bw[k, z, j] = v
            Eb[k, z, j] = F[z, d] ^ F[z, 0]
# phase classes on the 10 localized rows
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
ROWS = sorted(set(FIX2) | set(FIX3))
vecs = []
for P in PH:
    v = 0
    for kk, z in enumerate(ROWS):
        v |= int(sum(int(P[z, w]) << w for w in range(64))) << (64 * kk)
    vecs.append(v)
pp = {}; CH = []
for i, v in enumerate(vecs):
    x = v
    while x:
        c = x.bit_length() - 1
        if c in pp: x ^= pp[c]
        else: pp[c] = x; CH.append(i); break
ncl = 1 << len(CH)
PE = np.zeros((ncl, 64, len(DALL)), dtype=np.uint8)
for cl in range(ncl):
    F = np.zeros((64, 64), dtype=np.uint8)
    for q, i in enumerate(CH):
        if cl >> q & 1: F ^= PH[i]
    for j, d in enumerate(DALL):
        PE[cl, :, j] = F[:, d] ^ F[:, 0]
print("phase classes on localized rows:", ncl, flush=True)
jD2 = [DALL.index(d) for d in D2]; jD3 = [DALL.index(d) for d in D3]
CASES = {"B": (1, 1, 0), "C": (1, 0, 1)}
N = {s: i for i, s in enumerate(NAMES)}
stat = collections.defaultdict(collections.Counter)
surv_loc = collections.defaultdict(list)
CH_SZ = 2048
for case, u in CASES.items():
    free = list(range(3, NB))
    base = u[0] | (u[1] << 1) | (u[2] << 2)
    for start in range(0, 1 << 18, CH_SZ):
        idxs = np.arange(start, start + CH_SZ, dtype=np.int64)
        codes = base | (idxs << 3)
        bits = ((codes[:, None] >> np.arange(NB)) & 1).astype(np.uint8)       # (C, 21)
        # 8-row key
        g = lambda s: bits[:, N[s]].astype(np.int64)
        al = (g("p") + g("A2") + g("B1") + g("B2")) & 1
        be = (g("r") + g("A1") + g("A3") + g("B2") + g("B3")) & 1
        key = np.stack([g("u30"), g("u40"), g("u42"), al, be, (g("a") + g("d")) & 1, (g("a") + g("h")) & 1,
                        (g("b") + g("e")) & 1, (g("b") + g("n")) & 1, (g("c") + g("g")) & 1, (g("c") + g("k")) & 1], axis=1)
        kidx = (key << np.arange(11)).sum(axis=1)
        t8 = T8[kidx]
        ploc = ~par[iloc][:, codes].any(axis=0)
        pall = ~par[:, codes].any(axis=0)
        # B_z d words and e(z,d) for the polar part
        W = np.zeros((CH_SZ, 64, len(DALL)), dtype=np.uint8)
        E = np.zeros((CH_SZ, 64, len(DALL)), dtype=np.uint8)
        for k in range(NB):
            m = bits[:, k].astype(bool)
            W[m] ^= Bw[k]; E[m] ^= Eb[k]
        K = (W == 0)                                                          # (C, 64, D)
        Nd = K.sum(axis=1)                                                    # (C, D)
        K2 = K[:, FIX2, :]; K3 = K[:, FIX3, :]
        E2 = E[:, FIX2, :]; E3 = E[:, FIX3, :]
        ok2 = np.zeros(CH_SZ, bool); ok3 = np.zeros(CH_SZ, bool); ok23 = np.zeros(CH_SZ, bool)
        for cl in range(ncl):
            e2 = E2 ^ PE[cl][FIX2][None]; e3 = E3 ^ PE[cl][FIX3][None]
            EF = (K2 & (e2 == 1)).sum(axis=1)                                 # (C, D)
            c2 = (((Nd - 2 * EF)[:, jD2]) % 4 == 0).all(axis=1)
            s3 = (K3 * (1 - 2 * e3.astype(np.int64))).sum(axis=1)
            c3 = ((s3[:, jD3] % 3) == 0).all(axis=1)
            ok2 |= c2; ok3 |= c3; ok23 |= c2 & c3
        inpf4 = np.array([int(c) in homog for c in codes])
        for i in range(CH_SZ):
            sk = (case, int(al[i]), int(be[i]))
            S = stat[sk]
            S["total"] += 1
            S["T8"] += t8[i]
            S["T8&Ploc"] += t8[i] and ploc[i]
            S["T8&Ploc&L2&L3"] += t8[i] and ploc[i] and ok23[i]
            S["T8&Pall&L2&L3"] += t8[i] and pall[i] and ok23[i]
            S["pf4"] += inpf4[i]
            S["pf4&T8&Pall&L2&L3"] += inpf4[i] and t8[i] and pall[i] and ok23[i]
            if t8[i] and ploc[i] and ok23[i]:
                surv_loc[case].append(int(codes[i]))
    print("case", case, "done", flush=True)
for k in sorted(stat):
    print(k, dict(stat[k]))
json.dump({k: v for k, v in surv_loc.items()}, open(os.path.join(here, "varredura_localizada_sobrev.json"), "w"))
