"""Rotation decomposition of the top space.

W = F2^6 (w) and Z = F2^6 (z) with the 6-cycle R.  X^6 - 1 = (X+1)^2 (X^2+X+1)^2, so W = W_A + W_B with
W_A = ker (R+1)^2 (dim 2) and W_B = ker (R^2+R+1)^2 (dim 4); same for Z.  A top T (alternating in w, quadratic in z,
i.e. an element of Alt(W) x Alt(Z)) is written in the adapted bases; Alt(W) = Alt(W_A) + (W_A x W_B) + Alt(W_B) has
dims 1 + 8 + 6.  Reports where the 21-dim homogeneous top space lives (which of the 9 blocks), and gamma_2 by blocks."""
import os, sys, itertools, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from pf4_estrutura import top_of

PAIRS = list(itertools.combinations(range(6), 2))


def rank_basis_kernel(M):
    """kernel basis of M (n x n over F2) as list of vectors."""
    n = M.shape[1]
    A = M.copy() % 2; piv = []; r = 0
    for c in range(n):
        p = np.nonzero(A[r:, c])[0]
        if len(p) == 0: continue
        p = p[0] + r; A[[r, p]] = A[[p, r]]
        for i in np.nonzero(A[:, c])[0]:
            if i != r: A[i] ^= A[r]
        piv.append(c); r += 1
        if r == A.shape[0]: break
    free = [c for c in range(n) if c not in piv]
    ker = []
    for f in free:
        v = np.zeros(n, dtype=np.int64); v[f] = 1
        for i, c in enumerate(piv):
            v[c] = A[i, f]
        ker.append(v)
    return ker


R = np.zeros((6, 6), dtype=np.int64)
for i in range(6):
    R[(i + 1) % 6, i] = 1
I = np.eye(6, dtype=np.int64)
KA = rank_basis_kernel(((R + I) @ (R + I)) % 2)
RR = (R @ R + R + I) % 2
KB = rank_basis_kernel((RR @ RR) % 2)
print("dim W_A =", len(KA), "| dim W_B =", len(KB))
P = np.array(KA + KB, dtype=np.int64).T            # columns: new basis vectors (A first)
labels = ["A"] * len(KA) + ["B"] * len(KB)


def alt_from_bits(bits):
    M = np.zeros((6, 6), dtype=np.int64)
    for k, (i, j) in enumerate(PAIRS):
        if bits[k]:
            M[i, j] = M[j, i] = 1
    return M


def bits_from_alt(M):
    return np.array([M[i, j] % 2 for i, j in PAIRS], dtype=np.int64)


def block(i, j):
    return "".join(sorted(labels[i] + labels[j]))     # AA, AB, BB


def transform(T):
    """T: 15 (w-pairs) x 15 (z-pairs).  Returns T' in adapted bases (same shape)."""
    # apply congruence on the w side for each z-pair column, then on the z side for each w-pair row
    T1 = np.zeros_like(T)
    for l in range(15):
        T1[:, l] = bits_from_alt(P.T @ alt_from_bits(T[:, l]) @ P)
    T2 = np.zeros_like(T)
    for k in range(15):
        T2[k, :] = bits_from_alt(P.T @ alt_from_bits(T1[k, :]) @ P)
    return T2 % 2


if __name__ == "__main__":
    from base12 import orbitas, mobius, ZW, wtw, polar, pack, elim_comb, X
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
    tops = [top_of(Bs[i.bit_length() - 1]).astype(np.int64) for i in pind]
    support = collections.Counter()
    blocks = collections.Counter()
    Tp = [transform(T) for T in tops]
    for T in Tp:
        for k, (a, b) in enumerate(PAIRS):
            for l, (c, d) in enumerate(PAIRS):
                if T[k, l]:
                    blocks[(block(a, b), block(c, d))] += 1
    print("block support (w-block, z-block) over the 21 basis tops:", dict(blocks))
    # dimension of the top space projected on each block
    for bw in ("AA", "AB", "BB"):
        for bz in ("AA", "AB", "BB"):
            vecs = []
            for T in Tp:
                v = [int(T[k, l]) for k, (a, b) in enumerate(PAIRS) for l, (c, d) in enumerate(PAIRS)
                     if block(a, b) == bw and block(c, d) == bz]
                vecs.append(v)
            M = np.array(vecs, dtype=np.int64) % 2
            r = len(M) - len(rank_basis_kernel(M.T)) if M.size else 0
            # rank via kernel of transpose: rank = cols - dim ker(M) ... compute directly
            A = M.copy(); rr = 0
            for c in range(A.shape[1] if A.ndim == 2 else 0):
                p = np.nonzero(A[rr:, c])[0]
                if len(p) == 0: continue
                p = p[0] + rr; A[[rr, p]] = A[[p, rr]]
                for i in np.nonzero(A[:, c])[0]:
                    if i != rr: A[i] ^= A[rr]
                rr += 1
                if rr == A.shape[0]: break
            print("  block w:%s x z:%s  size %d  rank of the projection %d" % (bw, bz, M.shape[1] if M.ndim == 2 else 0, rr))
