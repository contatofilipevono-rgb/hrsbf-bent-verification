"""Is the 6x6 Pfaffian of the w-polar B_z identically zero?
Over F_2, Pf(B) = sum over the 15 perfect matchings of {0..5} of the product of the three entries b_ij.
B_z is linear in the polar coordinates c (B = sum_j c_j Bb_j), so Pf(B_z) is a cubic in c for each z.
We test (1) the 3,984 (L5) polars, (2) the whole polar space: Pf is identically 0 there iff all
coefficients of the cubic vanish, i.e. iff the trilinear symmetric form
   P(j1,j2,j3)(z) = sum_M sum_{bijections e->(j1,j2,j3)} prod b_e(Bb_j)  (monomials c_j1 c_j2 c_j3, with c^2=c)
vanishes; we check it by evaluating Pf on all c of weight <= 3 (Moebius in c up to degree 3)."""
import os, sys, itertools, pickle
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from base12 import elim_comb, pack

here = os.path.dirname(os.path.abspath(__file__))
PAIRS = list(itertools.combinations(range(6), 2))          # index k of B[k][z] (assumed order)
MATCH = []
for p in itertools.permutations(range(6)):
    m = tuple(sorted(tuple(sorted(p[2 * i:2 * i + 2])) for i in range(3)))
    if m not in MATCH:
        MATCH.append(m)
assert len(MATCH) == 15
MIDX = [[PAIRS.index(e) for e in m] for m in MATCH]


def pf(Bk):
    """Bk: 15 x 64 array of entries; returns the 64 values of Pf over F_2."""
    out = np.zeros(64, dtype=np.uint8)
    for a, b, c in MIDX:
        out ^= Bk[a] & Bk[b] & Bk[c]
    return out


def rank_profile(Bk):
    out = []
    for z in range(64):
        M = np.zeros((6, 6), np.uint8)
        for k, (i, j) in enumerate(PAIRS):
            M[i, j] = M[j, i] = Bk[k, z]
        # GF2 rank
        R = M.copy(); r = 0
        for c in range(6):
            p = np.nonzero(R[r:, c])[0]
            if len(p) == 0:
                continue
            p = p[0] + r; R[[r, p]] = R[[p, r]]
            for i in np.nonzero(R[:, c])[0]:
                if i != r:
                    R[i] ^= R[r]
            r += 1
            if r == 6:
                break
        out.append(r)
    return out


if __name__ == "__main__":
    D = pickle.load(open(os.path.join(here, "base12.pkl"), "rb"))
    Bs = D["B"]
    ind, ker = elim_comb([pack(B) for B in Bs])
    Bb = [np.array(Bs[i.bit_length() - 1], dtype=np.uint8) for i in ind]
    print("polar space dimension:", len(Bb))
    # sanity: rank 6 <=> Pf = 1 on random combinations
    rng = np.random.default_rng(0)
    agree = 0
    for _ in range(200):
        c = rng.integers(0, 2, len(Bb))
        Bk = np.bitwise_xor.reduce([Bb[j] for j in range(len(Bb)) if c[j]], axis=0) if c.any() else np.zeros((15, 64), np.uint8)
        P = pf(Bk); rk = rank_profile(Bk)
        agree += all((rk[z] == 6) == bool(P[z]) for z in range(64))
    print("Pf = 1 <=> rank 6 on 200 random polars:", agree == 200)
    # 1. the (L5) polars
    nz = 0; ranks = set()
    for hx in open(os.path.join(here, "polares_L5.txt")).read().split():
        val = int(hx, 16)
        Bk = np.array([[(val >> (64 * k + z)) & 1 for z in range(64)] for k in range(15)], dtype=np.uint8)
        nz += int(pf(Bk).any()); ranks |= set(rank_profile(Bk))
    print("(L5) polars with some Pf != 0:", nz, " ranks seen:", sorted(ranks))
    # 2. the whole polar space: Pf(sum c_j Bb_j) is a cubic in c; it vanishes identically iff it vanishes on all c of weight <= 3
    n = len(Bb); bad = 0; tested = 0
    for w in range(1, 4):
        for S in itertools.combinations(range(n), w):
            Bk = np.bitwise_xor.reduce([Bb[j] for j in S], axis=0)
            tested += 1
            if pf(Bk).any():
                bad += 1
                if bad <= 3:
                    print("  Pf != 0 at c =", S, "rank profile", sorted(set(rank_profile(Bk))))
    print("whole polar space: combinations of weight <= 3 tested:", tested, " with Pf != 0:", bad)
