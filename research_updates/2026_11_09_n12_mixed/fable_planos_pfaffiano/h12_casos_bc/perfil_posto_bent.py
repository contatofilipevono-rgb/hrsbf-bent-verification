"""Rank profile of B_z over z for: the 72 bent polars, all 18816 (Pf4) polars (sample), the 1176 homogeneous (Pf4)
polars.  Question: do bent polars only have rows of rank <= 2?  Do homogeneous (Pf4) polars always have a rank-4 row?
Usage: python -I perfil_posto_bent.py REPO_DIR"""
import sys, os, json, collections, random
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from bc_comum import PAIRS

REPO = sys.argv[1]
here = os.path.dirname(os.path.abspath(__file__))


def B_of_hex(h):
    v = int(h, 16)
    B = np.zeros((15, 64), dtype=np.uint8)
    for k in range(15):
        for z in range(64):
            B[k][z] = v >> (64 * k + z) & 1
    return B


def rank_alt(entries):
    # entries: dict (i,j)->bit ; rank of 6x6 alternating matrix over F2
    M = [0] * 6
    for (i, j), b in entries.items():
        if b:
            M[i] |= 1 << j; M[j] |= 1 << i
    r = 0
    rows = M[:]
    for c in range(6):
        p = next((k for k in range(r, 6) if rows[k] >> c & 1), None)
        if p is None: continue
        rows[r], rows[p] = rows[p], rows[r]
        for k in range(6):
            if k != r and rows[k] >> c & 1: rows[k] ^= rows[r]
        r += 1
    return r


def profile(B):
    c = collections.Counter()
    for z in range(64):
        c[rank_alt({PAIRS[k]: int(B[k][z]) for k in range(15)})] += 1
    return tuple(sorted(c.items()))


bent = [l.strip() for l in open(os.path.join(REPO, "polares_bent72.txt")) if l.strip()]
pb = collections.Counter(profile(B_of_hex(h)) for h in bent)
print("72 bent polars, rank profiles:", dict(pb))
allp = open(os.path.join(REPO, "polares_18816.txt")).read().split()
random.seed(5)
samp = random.sample(allp, 3000)
pa = collections.Counter(max(r for r, _ in profile(B_of_hex(h))) for h in samp)
print("3000 random (Pf4) polars, max rank:", dict(pa))
low = [h for h in allp if max(r for r, _ in profile(B_of_hex(h))) <= 2]
print("(Pf4) polars with all ranks <= 2:", len(low), " bent among them:", len(set(low) & set(bent)))
json.dump(low, open(os.path.join(here, "polares_posto_le2.json"), "w"))
