"""Structure of the 8-row test on ALL 2^21 homogeneous polars (not only the (Pf4) ones).

Row z in {0, e_0..e_5, 63}: B_z is an alternating 6x6 form (15 bits), linear in the homogeneous polar; f(z, .) = q_z
(pure quadratic form, pairs only), so r_b(z) != 0 iff b is in the active set A(B_z) and then r_b(z)^2 = 2^(12-rank).
Test: some column b with sum over rows of 2^(12-rank) [b in A(B_z)] > 4096.
Reports: how many pass among all 2^21 and among the (Pf4) ones; rank profiles (B_0, B_e*, B_63) of the passing ones;
whether B_0 = 0 is forced, etc.  Chunked, one process, small memory."""
import os, sys, json, itertools, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from base12 import orbitas, mobius, ZW, wtw, polar, pack, elim_comb, X
from lista_polares import hexB

here = os.path.dirname(os.path.abspath(__file__))
PAIRS = list(itertools.combinations(range(6), 2))
ROWS = [0] + [1 << i for i in range(6)] + [63]
# per alternating form (15 bits): rank, active-column mask (64 bits), weight
rankt = np.zeros(1 << 15, dtype=np.int64); act = np.zeros((1 << 15, 64), dtype=bool)
W = np.arange(64)
par = lambda v: bin(v).count("1") & 1
qtab = np.zeros((1 << 15, 64), dtype=np.int64)
for bits in range(1 << 15):
    q = np.zeros(64, dtype=np.int64)
    for k, (i, j) in enumerate(PAIRS):
        if bits >> k & 1:
            q ^= ((W >> i) & 1) & ((W >> j) & 1)
    qtab[bits] = q
H = np.array([[1 - 2 * (bin(a & b).count("1") & 1) for b in range(64)] for a in range(64)])
R = (1 - 2 * qtab) @ H                                         # r_b for each form: (32768 x 64)
act = R != 0
rankt = 12 - np.round(np.log2(np.maximum((R ** 2).max(axis=1), 1))).astype(np.int64)   # 2^(12-rank) = max r^2
wt = (R ** 2).max(axis=1)                                      # 2^(12 - rank)
# homogeneous polar basis and their 8 rows
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
PB = [Bs[i.bit_length() - 1] for i in pind]
def rowcode(B, z):
    return int(sum(int(B[k][z]) << k for k in range(15)))
from poisson5 import tabela
PF = [HV[i.bit_length() - 1] for i in pind]
def lamcode(f, z):
    G = tabela(f)
    return int(sum(int(G[z, 1 << i] ^ G[z, 0]) << i for i in range(6)))
# a row is (q: 15 bits, lambda: 6 bits) -> code q | lambda << 15
basis_rows = np.array([[rowcode(B, z) | (lamcode(f, z) << 15) for z in ROWS] for B, f in zip(PB, PF)], dtype=np.int64)
print("rows with a nonzero linear part in the basis:", {ROWS[k]: int(((basis_rows[:, k] >> 15) != 0).sum()) for k in range(8)})
listed = {int(h, 16) for h in open(os.path.join(here, "polares_18816.txt")).read().split()}
Pint = [int(hexB(B), 16) for B in PB]
n = len(PB)
# all combinations of the 21 basis polars, by doubling
rows_all = np.zeros((1 << n, 8), dtype=np.int64)
for j in range(n):
    rows_all[1 << j:2 << j] = rows_all[:1 << j] ^ basis_rows[j]
pass_mask = np.zeros(1 << n, dtype=bool)
CH = 1 << 16
for s in range(0, 1 << n, CH):
    r = rows_all[s:s + CH]                                     # CH x 8
    col = np.zeros((len(r), 64), dtype=np.int64)
    bidx = np.arange(64)[None, :]
    for k in range(8):
        q = r[:, k] & 0x7FFF; lam = (r[:, k] >> 15) & 63
        col += act[q[:, None], bidx ^ lam[:, None]] * wt[q][:, None]
    pass_mask[s:s + CH] = (col <= 4096).all(axis=1)
print("homogeneous polars: %d; passing the 8-row test: %d" % (1 << n, int(pass_mask.sum())))
# which are (Pf4)?
cur = [0]
for v in Pint:
    cur = cur + [x ^ v for x in cur]
pf4 = np.array([x in listed for x in cur])
print("(Pf4) polars: %d; (Pf4) and passing: %d" % (int(pf4.sum()), int((pf4 & pass_mask).sum())))
prof = collections.Counter()
for idx in np.flatnonzero(pass_mask):
    r = rows_all[idx]
    prof[(int(rankt[r[0] & 0x7FFF]), tuple(sorted(int(rankt[x & 0x7FFF]) for x in r[1:7])), int(rankt[r[7] & 0x7FFF]))] += 1
print("rank profiles (B_0, sorted B_e*, B_63) of all passing polars:")
for k, v in prof.most_common(15):
    print("  ", k, v)
prof2 = collections.Counter()
for idx in np.flatnonzero(pass_mask & pf4):
    r = rows_all[idx]
    prof2[(int(rankt[r[0] & 0x7FFF]), tuple(sorted(int(rankt[x & 0x7FFF]) for x in r[1:7])), int(rankt[r[7] & 0x7FFF]))] += 1
print("rank profiles among the (Pf4) passing polars:")
for k, v in prof2.most_common(15):
    print("  ", k, v)
# linear structure: is the passing set closed under addition / a union of few subspaces?
P = np.flatnonzero(pass_mask)
Ps = set(P.tolist())
samp = P[:400]
closed = sum(1 for a, b in itertools.combinations(samp.tolist(), 2) if (a ^ b) in Ps)
print("sample: pairs of passing polars whose sum passes:", closed, "of", len(samp) * (len(samp) - 1) // 2)
# B_0 = 0 forced?
print("passing with B_0 = 0:", int(sum(1 for i in P if (rows_all[i][0] & 0x7FFF) == 0)), "of", len(P))
json.dump({"passing_all": int(pass_mask.sum()), "passing_pf4": int((pf4 & pass_mask).sum())},
          open(os.path.join(here, "oito_linhas_estrutura.json"), "w"))
