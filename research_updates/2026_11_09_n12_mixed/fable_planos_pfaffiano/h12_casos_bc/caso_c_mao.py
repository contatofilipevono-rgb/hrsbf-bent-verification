"""Case C (t42 = 1, t30 = 1, t40 = 0), alpha = beta = 1 (Lemmas 6, 7): sweep of all 2^16 polars x 128 phase classes
on the localized rows {0,9,18,36,27,45,54,63,21,42}, with hand-checkable conditions only:
  T8    8-row table (Lemma 8)
  PL    the (Pf4) quadric that is linear in case C: a+d+h+m+A1+A2+A3+B1+B3 = 0 (Lemma 5)
  L2    S_d mod 4 on Fix(R^3) rows, d in {9,27,63} (Lemma 9)
  L3    S_d mod 3 on rows {0,21,42,63}, d in {21,42,63} (Lemma 9)
  SH    4-periodic shadow must be [y=1111]: g = 0 on the weight-3 words (rows 21, 42) and on row 63 (Lambda = M = 0)
  S3    column 0, signs mod 3:  sum_{z in {0,21,42,63}} (-1)^{u.z} r_0(z) = W_f(u,0) mod 3, with
        W_f = -64, +64, +64, +64 for u = 0, 21, 42, 63 (forced by the point-type shadow, Technique 2)
  C32   column 0 mod 32 on Fix(R^3): sum_{z in Fix(R^3)} (-1)^{u.z} r_0(z) = 0 mod 32 for u in Fix(R^3)
Writes the surviving (polar, class) pairs for the next step.  Usage: python -I caso_c_mao.py"""
import sys, os, json, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from bc_comum import *

here = os.path.dirname(os.path.abspath(__file__))
tab8 = json.load(open(os.path.join(here, "oito_tabela.json")))
T8 = np.zeros(1 << 11, dtype=bool)
for k, v in tab8.items():
    T8[int(k[::-1], 2)] = v[0]
FIX2 = [0, 9, 18, 36, 27, 45, 54, 63]
FIX3 = [0, 21, 42, 63]
ROWS = sorted(set(FIX2) | set(FIX3))
RI = {z: i for i, z in enumerate(ROWS)}
D2 = [9, 27, 63]; D3 = [21, 42, 63]
DALL = sorted(set(D2 + D3))
NB = 21
N = {s: i for i, s in enumerate(NAMES)}
# shadow points (row, w) that must be 0
def xof(y): return sum(((y >> (i % 4)) & 1) << i for i in range(12))
SHP = []
for y in range(16):
    x = xof(y); z = (x & 63) ^ (x >> 6); w = x >> 6
    if z in (21, 42) and bin(y).count("1") == 3: SHP.append((z, w))
    if z == 63: SHP.append((z, w))
# linear data
Bw = np.zeros((NB, 64, len(DALL)), dtype=np.uint8)
Fr = np.zeros((NB, len(ROWS), 64), dtype=np.uint8)
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
    Fr[k] = F[ROWS]
# fixed part from t42 (case C sets u42 = 1 via coordinates: u42 is coordinate 2, included in code)
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
PR = np.zeros((ncl, len(ROWS), 64), dtype=np.uint8)
for cl in range(ncl):
    F = np.zeros((64, 64), dtype=np.uint8)
    for q, i in enumerate(CH):
        if cl >> q & 1: F ^= PH[i]
    PR[cl] = F[ROWS]
print("phase classes:", ncl, " shadow points:", len(SHP), flush=True)
par6 = np.array([bin(i).count("1") & 1 for i in range(64)])
U3 = [0, 21, 42, 63]; S3T = {0: -1, 21: 1, 42: 1, 63: 1}
U2 = FIX2
jD2 = [DALL.index(d) for d in D2]; jD3 = [DALL.index(d) for d in D3]
iF2 = [RI[z] for z in FIX2]; iF3 = [RI[z] for z in FIX3]
names = ["T8", "PL", "L2", "L3", "SH", "S3", "C32"]
cnt = collections.Counter()
surv = []
base_u = {N["u30"]: 1, N["u40"]: 0, N["u42"]: 1}
free = [i for i in range(NB) if i not in base_u]
CHS = 2048
for start in range(0, 1 << 18, CHS):
    idxs = np.arange(start, start + CHS, dtype=np.int64)
    bits = np.zeros((CHS, NB), dtype=np.uint8)
    for q, i in enumerate(free):
        bits[:, i] = (idxs >> q) & 1
    for i, v in base_u.items():
        bits[:, i] = v
    g = lambda s: bits[:, N[s]].astype(np.int64)
    al = (g("p") + g("A2") + g("B1") + g("B2")) & 1
    be = (g("r") + g("A1") + g("A3") + g("B2") + g("B3")) & 1
    keep = (al == 1) & (be == 1)
    if not keep.any(): continue
    bits = bits[keep]; C = bits.shape[0]
    g = lambda s: bits[:, N[s]].astype(np.int64)
    key = np.stack([g("u30"), g("u40"), g("u42"), np.ones(C, np.int64), np.ones(C, np.int64),
                    (g("a") + g("d")) & 1, (g("a") + g("h")) & 1, (g("b") + g("e")) & 1, (g("b") + g("n")) & 1,
                    (g("c") + g("g")) & 1, (g("c") + g("k")) & 1], axis=1)
    t8 = T8[(key << np.arange(11)).sum(axis=1)]
    pl = ((g("a") + g("d") + g("h") + g("m") + g("A1") + g("A2") + g("A3") + g("B1") + g("B3")) & 1) == 0
    W = np.zeros((C, 64, len(DALL)), dtype=np.uint8)
    Fp = np.zeros((C, len(ROWS), 64), dtype=np.uint8)
    for k in range(NB):
        m = bits[:, k].astype(bool)
        W[m] ^= Bw[k]; Fp[m] ^= Fr[k]
    K = (W == 0); Nd = K.sum(axis=1)
    codes = (bits.astype(np.int64) << np.arange(NB)).sum(axis=1)
    for cl in range(ncl):
        F = Fp ^ PR[cl][None]                                          # (C, 10, 64)
        # e(z,d) on localized rows
        E = np.stack([F[:, :, d] ^ F[:, :, 0] for d in DALL], axis=2)  # (C, 10, D)
        Kl = K[:, ROWS, :]
        EF = (Kl[:, iF2, :] & (E[:, iF2, :] == 1)).sum(axis=1)
        l2 = (((Nd - 2 * EF)[:, jD2]) % 4 == 0).all(axis=1)
        s3 = (Kl[:, iF3, :] * (1 - 2 * E[:, iF3, :].astype(np.int64))).sum(axis=1)
        l3 = ((s3[:, jD3] % 3) == 0).all(axis=1)
        sh = np.ones(C, bool)
        for (z, w) in SHP:
            sh &= F[:, RI[z], w] == 0
        r0 = (1 - 2 * F.astype(np.int64)).sum(axis=2)                  # (C, 10) row sums r_0(z)
        s3s = np.ones(C, bool)
        for u in U3:
            sg = np.array([1 - 2 * par6[u & z] for z in FIX3])
            val = (r0[:, iF3] * sg).sum(axis=1)
            s3s &= (val - S3T[u]) % 3 == 0
        c32 = np.ones(C, bool)
        for u in U2:
            sg = np.array([1 - 2 * par6[u & z] for z in FIX2])
            c32 &= ((r0[:, iF2] * sg).sum(axis=1) % 32) == 0
        flags = np.stack([t8, pl, l2, l3, sh, s3s, c32], axis=1)
        for mask in range(1 << len(names)):
            sel = np.ones(C, bool)
            for q in range(len(names)):
                if mask >> q & 1: sel &= flags[:, q]
            # count polars with some class: accumulate later; here count (polar, class) pairs
            cnt[mask] += int(sel.sum())
        allok = flags.all(axis=1)
        for i in np.nonzero(allok)[0]:
            surv.append((int(codes[i]), cl))
print("(polar, class) pairs, alpha = beta = 1:")
for combo in [[], ["T8"], ["T8", "PL"], ["SH"], ["SH", "S3"], ["T8", "SH", "S3"], ["T8", "PL", "L2", "L3"],
              ["T8", "PL", "L2", "L3", "SH"], ["T8", "PL", "L2", "L3", "SH", "S3"], names]:
    mask = sum(1 << names.index(x) for x in combo)
    print("  ", "+".join(combo) or "(none)", cnt[mask])
pol = sorted({c for c, cl in surv})
print("polars surviving all:", len(pol))
json.dump({"surv": surv, "polars": pol}, open(os.path.join(here, "caso_c_mao_sobrev.json"), "w"))
