"""How much of the homogeneous phase each row z sees: rank of phase -> lambda(z) in F2^6, per rotation orbit of z,
and joint ranks of unions of orbits."""
import sys, os, json, itertools
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from bc_comum import *

# phase basis: t in the model with all 21 coordinates zero
rows_eq = EQ  # 21 forms + 2 relations
# kernel of the 23 equations in F2^43
piv = {}
for r in rows_eq:
    while r:
        c = r.bit_length() - 1
        if c in piv:
            r ^= piv[c]
        else:
            piv[c] = r; break
# RREF
pr = {}
for c in sorted(piv):
    r = piv[c]
    for h in sorted(pr, reverse=True):
        if r >> h & 1:
            r ^= pr[h]
    for k in list(pr):
        if pr[k] >> c & 1:
            pr[k] ^= r
    pr[c] = r
free = [c for c in range(43) if c not in pr]
phase = []
for c in free:
    v = 1 << c
    for h, r in pr.items():
        if r >> c & 1:
            v |= 1 << h
    phase.append(v)
print("phase dim", len(phase))
# lambda(z) for each phase vector: lambda_k(z) = f(z, e_k) + f(z, 0) restricted... use ANF: coefficient of w_k with z-part
def lam_table(tm):
    t = [tm >> j & 1 for j in range(43)]
    F = ftab_zw(t)
    L = np.zeros(64, dtype=np.int64)
    for k in range(6):
        L |= ((F[:, 1 << k] ^ F[:, 0]).astype(np.int64) << k)
    # note: for a pure phase function the polar is zero, so f(z,w) = h(z) + lambda(z).w exactly
    return L, F[:, 0].astype(np.int64)
LT = [lam_table(v) for v in phase]
# check polar zero
for v in phase[:3]:
    assert hexint(polar_of([v >> j & 1 for j in range(43)])) == 0
def rotm(d):
    return ((d << 1) | (d >> 5)) & 63
orbs = []
seen = set()
for z in range(64):
    if z in seen: continue
    o = [z]; x = z
    for _ in range(5):
        x = rotm(x)
        if x not in o: o.append(x)
    seen |= set(o); orbs.append(o)
def rank(vecs):
    p = {}
    for r in vecs:
        while r:
            c = r.bit_length() - 1
            if c in p: r ^= p[c]
            else: p[c] = r; break
    return len(p)
print("orbit rep, size, rank of phase -> lambda(rep), rank -> (lambda(rep), h(rep))")
info = {}
for o in orbs:
    z = o[0]
    lam = [int(L[z]) for L, h in LT]
    lh = [int(L[z]) | (int(h[z]) << 6) for L, h in LT]
    info[z] = (len(o), rank(lam), rank(lh))
    print("  z=%2d %s size %d  rank_lambda %d  rank_(lambda,h) %d" % (z, format(z, "06b")[::-1], len(o), rank(lam), rank(lh)))
# joint ranks over the whole orbit (all rows in the orbit together)
print("joint rank over each full orbit (lambda only):")
for o in orbs:
    vecs = []
    for L, h in LT:
        v = 0
        for idx_, z in enumerate(o):
            v |= int(L[z]) << (6 * idx_)
        vecs.append(v)
    print("  orbit of", o[0], "joint rank", rank(vecs))
