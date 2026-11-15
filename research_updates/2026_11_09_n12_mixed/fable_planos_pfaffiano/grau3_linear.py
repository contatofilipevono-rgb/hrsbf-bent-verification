"""Linear B(z) (entries of degree 1 in z) with B(z) z = 0: (Pf4) holds automatically (deg Pf <= 2).
Does deg_3(P_B) vanish?  If not, the degree-3 vanishing needs more than (Pf4) + half-turn (e.g. RS)."""
import os, sys, itertools, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from base12 import mobius
from poisson5 import Bv_table

POP = np.array([bin(i).count("1") for i in range(64)])
PAIRS = list(itertools.combinations(range(6), 2))
rng = np.random.default_rng(5)
X = np.arange(64)
zb = [((X >> i) & 1) for i in range(6)]
# unknowns: coefficient c[k][i] of z_i in entry k (pair (a,b)); constraint B(z) z = 0 for all z: for each output
# coordinate a and each monomial z_i z_b (i != b) ... solve by brute force on the linear constraint system.
nvar = 15 * 6
rows = []
for z in range(64):
    for a in range(6):
        # (B(z) z)_a = sum_b B_ab(z) z_b, B_ab(z) = sum_i c[(a,b)][i] z_i
        mask = 0
        for b in range(6):
            if a == b or not (z >> b & 1):
                continue
            k = PAIRS.index((min(a, b), max(a, b)))
            for i in range(6):
                if z >> i & 1:
                    mask ^= 1 << (6 * k + i)
        rows.append(mask)
# kernel of the constraint system
piv = {}
for r in rows:
    while r and (r.bit_length() - 1) in piv:
        r ^= piv[r.bit_length() - 1]
    if r:
        piv[r.bit_length() - 1] = r
for p in sorted(piv):
    for q in list(piv):
        if q != p and piv[q] >> p & 1:
            piv[q] ^= piv[p]
free = [i for i in range(nvar) if i not in piv]
kern = []
for f in free:
    v = 1 << f
    for p, r in piv.items():
        if r >> f & 1:
            v |= 1 << p
    kern.append(v)
print("dimension of linear B(z) with B(z)z = 0:", len(kern))
stats = collections.Counter()
for _ in range(300):
    c = 0
    for v in kern:
        if rng.random() < 0.5:
            c ^= v
    B = np.zeros((15, 64), dtype=np.uint8)
    for k in range(15):
        for i in range(6):
            if c >> (6 * k + i) & 1:
                B[k] ^= zb[i].astype(np.uint8)
    Bv = Bv_table(B)
    assert (Bv[np.arange(64), np.arange(64)] == 0).all()
    P = ((Bv == 0).sum(axis=0) % 2).astype(np.uint8)
    an = mobius(P.copy(), 6)
    stats[(int(an[POP == 4].any()), int(an[POP == 3].any()))] += 1
print("(deg4 part present, deg3 part present):", dict(stats))
