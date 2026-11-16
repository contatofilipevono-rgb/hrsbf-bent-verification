"""N_d mod 2 as a polynomial in the 21 polar coordinates, for d in representatives of the rotation orbits.
Evaluates over all 2^21 polars by doubling (one byte per (z, code)), then Moebius over 21 bits.
Memory: 64 rows x 2^21 bytes would be 128 MB; we do it row by row and keep only the parity accumulators.
Usage: python -I paridade_coords.py"""
import sys, os, json, itertools
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from bc_comum import *

here = os.path.dirname(os.path.abspath(__file__))
NB = 21
basisB = []
for k in range(NB):
    code = "".join("1" if i == k else "0" for i in range(NB))
    basisB.append(polar_of(t_from_coords(code)))
basisB = np.array(basisB)  # (21, 15, 64)


def rotm(d):
    return ((d << 1) | (d >> 5)) & 63


reps = []
seen = set()
for d in range(1, 64):
    if d in seen:
        continue
    o = {d}
    x = d
    for _ in range(6):
        x = rotm(x); o.add(x)
    seen |= o
    reps.append(min(o))
print("orbit reps of d:", reps)

# word_z(c)[d] : B_z d as 6-bit; we need, for each z, the 6-bit value B_z d for each rep d, as function of code c.
# B_z d (bit i) = sum_j B_ij(z) d_j ; linear in c.
par = {d: np.zeros(1 << NB, dtype=np.uint8) for d in reps}
for z in range(64):
    for d in reps:
        # vector of 6-bit values for each basis element
        vals = []
        for k in range(NB):
            v = 0
            for i in range(6):
                s = 0
                for kk, (a, b) in enumerate(PAIRS):
                    if basisB[k][kk][z]:
                        if a == i and d >> b & 1: s ^= 1
                        if b == i and d >> a & 1: s ^= 1
                if s: v |= 1 << i
            vals.append(v)
        arr = np.zeros(1, dtype=np.uint8)
        for k in range(NB):
            arr = np.concatenate([arr, arr ^ vals[k]])
        par[d] ^= (arr == 0).astype(np.uint8)
    if z % 16 == 15:
        print("z", z, flush=True)


def mob(a):
    a = a.copy()
    for j in range(NB):
        v = a.reshape(1 << (NB - 1 - j), 2, 1 << j)
        v[:, 1, :] ^= v[:, 0, :]
    return a


out = {}
for d in reps:
    A = mob(par[d])
    mons = np.nonzero(A)[0]
    degs = [bin(int(m)).count("1") for m in mons]
    out[d] = [int(m) for m in mons]
    print("d=%2d (%s): #monomials %d, max degree %d" % (d, format(d, "06b")[::-1], len(mons), max(degs) if degs else -1))
np.save(os.path.join(here, "paridade_tab.npy"), np.array([par[d] for d in reps]))
json.dump({"reps": reps, "anf": {str(d): out[d] for d in reps}}, open(os.path.join(here, "paridade_anf.json"), "w"))
