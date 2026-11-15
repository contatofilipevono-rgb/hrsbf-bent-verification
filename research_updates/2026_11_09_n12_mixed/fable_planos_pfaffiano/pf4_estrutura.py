"""Structure of the (Pf4) solutions: tops T in Lambda^2 W x Lambda^2 Z.

For a polar B (15 functions of z, one per pair of w-coordinates), the top T[k][l] is the coefficient of the
monomial z_l1 z_l2 (l-th pair of z-coordinates) in B[k].  Facts checked here:
  (a) the 18,816 polars = (distinct tops) x (the 16 polars with zero top), i.e. the low parts are free;
  (b) rank distribution of T as a 15 x 15 matrix, and the dimension of the space of tops;
  (c) orbits of the tops under Gamma (via the matrices of lema_gamma.json, acting modulo the zero-top polars);
  (d) whether the solution set is a union of linear subspaces, and which.
Usage: python pf4_estrutura.py"""
import os, sys, json, itertools, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from base12 import mobius, pack

here = os.path.dirname(os.path.abspath(__file__))
PAIRS = list(itertools.combinations(range(6), 2))
ZP = [(1 << i) | (1 << j) for i, j in PAIRS]


def top_of(B):
    return np.array([mobius(B[k].astype(np.uint8).copy(), 6)[ZP] for k in range(15)], dtype=np.uint8)


def rank2(M):
    M = M.copy() % 2; r = 0
    for c in range(M.shape[1]):
        p = np.nonzero(M[r:, c])[0]
        if len(p) == 0: continue
        p = p[0] + r; M[[r, p]] = M[[p, r]]
        for i in np.nonzero(M[:, c])[0]:
            if i != r: M[i] ^= M[r]
        r += 1
        if r == M.shape[0]: break
    return r


if __name__ == "__main__":
    hexes = open(os.path.join(here, "polares_18816.txt")).read().split()
    tops = {}; lows = collections.defaultdict(set)
    for hx in hexes:
        val = int(hx, 16)
        B = np.array([[(val >> (64 * a + z)) & 1 for z in range(64)] for a in range(15)], dtype=np.uint8)
        T = top_of(B)
        key = pack(T)
        tops[key] = T
        lows[key].add(hx)
    print("distinct tops:", len(tops), "| polars per top:", collections.Counter(len(v) for v in lows.values()))
    Ts = list(tops.values())
    span_rank = rank2(np.array([T.reshape(-1) for T in Ts]))
    print("dimension of the span of the solution tops:", span_rank)
    ranks = collections.Counter(rank2(T) for T in Ts)
    print("rank of T (15 x 15) among the solutions:", sorted(ranks.items()))
    # is the solution set closed under addition (a subspace)? union of subspaces?
    keys = set(tops)
    closed = sum(1 for a, b in itertools.combinations(list(keys)[:300], 2) if (a ^ b) in keys)
    print("sample: sums of two solutions that are solutions:", closed, "of", 300 * 299 // 2)
    # maximal linear subspaces through 0 inside the solution set, greedy
    sols = [k for k in keys if k]
    subspaces = []
    remaining = set(sols)
    while remaining:
        v = max(remaining, key=lambda k: bin(k).count("1"))
        S = {0, v}
        for w in sorted(keys, key=lambda k: -bin(k).count("1")):
            if w in S: continue
            if all((w ^ s) in keys for s in S):
                S |= {w ^ s for s in S}
        subspaces.append(S)
        remaining -= S
    dims = collections.Counter(int(np.log2(len(S))) for S in subspaces)
    print("greedy cover of the nonzero solutions by linear subspaces inside the set:", len(subspaces),
          "subspaces, dimensions", sorted(dims.items()))
    json.dump({"tops": len(tops), "span_dim": span_rank, "rank_distribution": sorted(ranks.items()),
               "cover_dims": sorted(dims.items())}, open(os.path.join(here, "pf4_estrutura.json"), "w"))
