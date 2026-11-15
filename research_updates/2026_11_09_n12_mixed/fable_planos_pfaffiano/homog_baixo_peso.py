"""Homogeneous quartic RS f in the model (quadratic in w): what is f(z, w) for z of weight <= 1 and 2?
Also: is the polar of a homogeneous quartic pure top (low part zero)?  And r_0(z) = sum_w (-1)^f(z,w) there.
Light check."""
import os, sys, itertools, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from base12 import orbitas, mobius, ZW, wtw, polar, pack, elim_comb, X
from poisson5 import tabela

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
print("dim H_V:", len(HV))
POP = np.array([bin(z).count("1") for z in range(64)])
# (1) values on z of weight <= 1 and 2, over the whole H_V (linear: check basis)
for wt in (0, 1, 2):
    zs = [z for z in range(64) if POP[z] == wt]
    nonzero = sum(1 for f in HV if tabela(f)[zs].any())
    print("weight %d: basis functions not identically zero on these z: %d of %d" % (wt, nonzero, len(HV)))
# (2) is the polar pure top? low part = B(z) of degree <= 1 in z
low_nonzero = 0
for f in HV:
    B = polar(f)[0]
    for k in range(15):
        an = mobius(B[k].copy(), 6)
        if (an[POP <= 1] != 0).any():
            low_nonzero += 1; break
print("basis functions whose polar has a nonzero part of degree <= 1 in z:", low_nonzero)
# (3) the z-degree structure: in (z, w) coordinates, monomials of f
degs = collections.Counter()
for f in HV:
    an = mobius(tabela(f).T.reshape(-1).copy(), 12) if False else mobius(f[ZW].copy(), 12)
    for mono in np.flatnonzero(an):
        degs[(bin(mono & 63).count("1"), bin(mono >> 6).count("1"))] += 1
print("(z-degree, w-degree) of the monomials of the basis, in (z,w):", sorted(degs.items()))
