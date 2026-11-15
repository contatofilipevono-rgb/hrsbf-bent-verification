"""Eigen-decomposition over F4 of the top space under R^2 (order 3) acting on W and Z.

F4 = {0, 1, w, w^2} encoded 0,1,2,3 (addition = XOR).  W x F4 = E_1 + E_w + E_w2 (each dim 2) for R^2.
A top T in Alt(W) x Alt(Z) is written in eigen-bases; each coordinate (pair of w-basis vectors, pair of z-basis
vectors) carries a character (product of the four eigenvalues).  R-invariant tops can only live on character 1.
Reports the dimension (over F4) of the top space projected on each (w-character-pair, z-character-pair) block."""
import os, sys, itertools, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from pf4_estrutura import top_of

MUL = np.array([[0, 0, 0, 0], [0, 1, 2, 3], [0, 2, 3, 1], [0, 3, 1, 2]], dtype=np.int64)
INV = {1: 1, 2: 3, 3: 2}
PAIRS = list(itertools.combinations(range(6), 2))


def mat_mul(A, B):
    n, m = A.shape; p = B.shape[1]
    C = np.zeros((n, p), dtype=np.int64)
    for i in range(n):
        for j in range(p):
            acc = 0
            for k in range(m):
                acc ^= MUL[A[i, k], B[k, j]]
            C[i, j] = acc
    return C


def kernel(M):
    A = M.copy(); n = A.shape[1]; piv = []; r = 0
    for c in range(n):
        rows = [i for i in range(r, A.shape[0]) if A[i, c]]
        if not rows: continue
        p = rows[0]; A[[r, p]] = A[[p, r]]
        inv = INV[A[r, c]]
        A[r] = MUL[inv][A[r]]
        for i in range(A.shape[0]):
            if i != r and A[i, c]:
                A[i] ^= MUL[A[i, c]][A[r]]
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


def rank(rows):
    if not rows:
        return 0
    A = np.array(rows, dtype=np.int64); r = 0
    for c in range(A.shape[1]):
        cand = [i for i in range(r, A.shape[0]) if A[i, c]]
        if not cand: continue
        p = cand[0]; A[[r, p]] = A[[p, r]]
        A[r] = MUL[INV[A[r, c]]][A[r]]
        for i in range(A.shape[0]):
            if i != r and A[i, c]:
                A[i] ^= MUL[A[i, c]][A[r]]
        r += 1
        if r == A.shape[0]: break
    return r


R = np.zeros((6, 6), dtype=np.int64)
for i in range(6):
    R[(i + 1) % 6, i] = 1
R2 = mat_mul(R, R)
I = np.eye(6, dtype=np.int64)
eig = {}
for lam in (1, 2, 3):
    eig[lam] = kernel(R2 ^ MUL[lam][I])
print("eigenspace dims of R^2 over F4:", {l: len(v) for l, v in eig.items()})
basis = []; chars = []
for lam in (1, 2, 3):
    for v in eig[lam]:
        basis.append(v); chars.append(lam)
P = np.array(basis, dtype=np.int64).T            # columns = eigenvectors


def alt_from_bits(vals):
    """alternating matrix with entries in F4 (values kept, not reduced to bits)."""
    M = np.zeros((6, 6), dtype=np.int64)
    for k, (i, j) in enumerate(PAIRS):
        if vals[k]:
            M[i, j] = M[j, i] = int(vals[k])
    return M


def to_eigen(T):
    """T (15 x 15 over F2) -> T' (15 x 15 over F4) in the eigenbasis: coordinates of P^T T(.,.) P on both sides."""
    PT = P.T
    T1 = np.zeros((15, 15), dtype=np.int64)
    for l in range(15):
        M = mat_mul(mat_mul(PT, alt_from_bits(T[:, l])), P)
        T1[:, l] = [M[i, j] for i, j in PAIRS]
    T2 = np.zeros((15, 15), dtype=np.int64)
    for k in range(15):
        M = mat_mul(mat_mul(PT, alt_from_bits(T1[k, :])), P)
        T2[k, :] = [M[i, j] for i, j in PAIRS]
    return T2


def pchar(i, j):
    return MUL[chars[i], chars[j]]


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
    Tp = [to_eigen(T) for T in tops]
    # characters of coordinates
    nonzero_char = collections.Counter()
    for T in Tp:
        for k, (a, b) in enumerate(PAIRS):
            for l, (c, d) in enumerate(PAIRS):
                if T[k, l]:
                    nonzero_char[MUL[pchar(a, b), pchar(c, d)]] += 1
    print("characters of the nonzero coordinates (should be only 1 for R^2-invariant tops):", dict(nonzero_char))
    # blocks by (w eigen-pair type, z eigen-pair type)
    def ptype(i, j):
        return "".join(sorted({1: "1", 2: "w", 3: "v"}[chars[i]] + {1: "1", 2: "w", 3: "v"}[chars[j]]))
    groups = collections.defaultdict(list)
    for k, (a, b) in enumerate(PAIRS):
        for l, (c, d) in enumerate(PAIRS):
            groups[(ptype(a, b), ptype(c, d))].append((k, l))
    print("rank over F4 of the projection of the 21-dim top space on each block (w-type, z-type):")
    tot = 0
    for key in sorted(groups):
        coords = groups[key]
        rows = [[int(T[k, l]) for k, l in coords] for T in Tp]
        r = rank(rows)
        if r:
            tot += r
            print("   ", key, "size", len(coords), "rank", r)
    print("sum of block ranks:", tot, "(21 means the top space is the direct sum of its block projections)")
