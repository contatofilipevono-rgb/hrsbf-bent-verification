"""Exact lowest-bit polynomials of the Walsh coefficients on an affine subspace of the phase space.

Bent  <=>  W(u,b) = +-64 for all (u,b)  =>  C(y) = W_{f_y}(u,b) - 64 = 0 mod 128.
With f_y = T + sum_i t_i K_i:  C(t) = sum_J (-2)^|J| N_J t^J - 64,
    N_J = sum_{z,w} (-1)^{T(z,w) + u.z + b.w} prod_{i in J} K_i(z,w)    (the Walsh transform of s_J),
k0 = min_J (|J| + v2 N'_J) with N'_0 = N_0 - 64.  Monomials up to degree c are computed; P is exact when
k0 <= c, and only sums with k0 <= c and k0 < 7 are returned.  Sum identifier: (u, b)."""
import itertools
import numpy as np
from math import comb
from bitj import H64

H = H64.astype(np.float64)


def choose_degree(D, budget=1200000):
    c = 0; tot = 1
    while c < 6 and tot + comb(D, c + 1) <= budget:
        c += 1; tot += comb(D, c)
    return max(c, min(4, D))


def monomials(D, c):
    out = [0]
    for k in range(1, c + 1):
        for J in itertools.combinations(range(D), k):
            out.append(sum(1 << i for i in J))
    return out


def famW_polys(T, Kp, c=None, batch=256):
    D = len(Kp)
    if c is None:
        c = choose_degree(D)
    c = min(c, D) if D else 0
    famW_polys.last_c = c
    mons = monomials(D, c)
    nJ = len(mons)
    sgn = (1 - 2 * T.astype(np.int64))
    Ks = [k.astype(np.int64) for k in Kp]
    deg = np.array([bin(J).count("1") for J in mons], dtype=np.int64)
    Vals = np.empty((nJ, 4096), dtype=np.uint8)
    for start in range(0, nJ, batch):
        Js = mons[start:start + batch]
        S = np.empty((len(Js), 64, 64), dtype=np.float64)
        for b, J in enumerate(Js):
            X = np.ones((64, 64), dtype=np.int64)
            for i in range(D):
                if J >> i & 1:
                    X &= Ks[i]
            S[b] = sgn * X
        Wv = np.rint(H @ S @ H).astype(np.int64).reshape(len(Js), 4096)       # [u, b] flattened u*64 + b
        if start == 0:
            Wv[0] -= 64
        a = np.abs(Wv)
        v = np.full(a.shape, 99, dtype=np.int64)
        nz = a != 0
        x = a[nz]
        v[nz] = np.log2(x & -x).round().astype(np.int64)
        Vals[start:start + len(Js)] = np.minimum(v + deg[start:start + len(Js), None], 99)
    k0 = Vals.min(axis=0).astype(np.int64)
    use = np.nonzero(((k0 <= c) | (c >= D)) & (k0 < 7))[0]        # c >= D: the expansion is complete
    if len(use) == 0:
        return mons, []
    sub = Vals[:, use] == k0[use][None, :]
    rows = np.packbits(sub, axis=0, bitorder="little").T.copy()
    uniq, first = np.unique(rows, axis=0, return_index=True)
    out = []
    for r, f in zip(uniq, first):
        s = int(use[f])
        bits = np.unpackbits(r, bitorder="little")[:nJ]
        P = {mons[j] for j in np.nonzero(bits)[0]}
        out.append(((s >> 6, s & 63), int(k0[s]), P))
    return mons, out
