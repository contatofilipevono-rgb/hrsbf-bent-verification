"""Exact lowest-bit polynomials of the Poisson sums on 4-flats, on an affine subspace of the phase space.

For a 4-dim V < W = F2^6 (annihilator V^perp of dim j = 2), a coset w0 + V, a character omega and I with |I| <= 1:
    C(y) = sum_{z >= I} sum_{s in V} (-1)^{f_y(z, w0+s) + omega.s}.
If f_y is bent, Poisson in V^perp and the Moebius sum over z >= I give  C(y) = 0 mod 2^(5-|I|).
Write f_y = T + sum_i t_i K_i on the subspace.  Then C(t) = sum_J (-2)^|J| N_J t^J with
    N_J = sum_{z >= I, s in V} (-1)^{T(z,w0+s) + omega.s} prod_{i in J} K_i(z, w0+s),
and with k0 = min_J (|J| + v2 N_J):  C = 2^k0 P(t) mod 2^(k0+1),  P = sum_{|J| + v2 N_J = k0} t^J.
If k0 < 5 - |I|, bentness forces P(t) = 0.  We compute N_J for |J| <= 3, which is exact whenever k0 <= 3
(a monomial with |J| >= 4 contributes at bit >= 4); sums with k0 >= 4 are discarded (no information used).
Sum identifier: (v, o, w, i) = (index of V^perp in bitj.ANN, index of omega in bitj.OM[v], index of w0 in
bitj.W0[v], i in 0..6 with i = 0 for I = {} and i = 1 + bit for I = {bit})."""
import itertools
import numpy as np
from bitj import U, SG, IMASK, H64, ANN, OM, W0

NS = 7 * 651 * 16 * 4


def monomials(D, maxdeg=3):
    out = [0]
    for k in range(1, maxdeg + 1):
        for J in itertools.combinations(range(D), k):
            out.append(sum(1 << i for i in J))
    return out


def sum_tensor(S):
    """S: (B, 64, 64) integer functions s(z, w).  Returns (B, 7, 651, 16, 4) = sum_{z>=I, s in V} (-1)^{omega.s} S(z, w0+s)."""
    Sh = S @ H64                                                    # B x 64 x 64 : hat over w
    T = Sh[:, :, U]                                                  # B x 64 x 651 x 16 x 4p
    K = np.einsum("bzvop,vowp->bzvow", T, SG)                        # = 4 * sum
    assert (K % 4 == 0).all()
    K //= 4
    return np.einsum("iz,bzvow->bivow", IMASK, K)


SGf = SG.reshape(651 * 16, 4, 4).astype(np.float64)                 # (v o), w, p
IMf = IMASK.astype(np.float64)
H64f = H64.astype(np.float64)
Uflat = U.reshape(-1)


def sum_tensor_fast(S):
    """Same as sum_tensor with float64 BLAS products (exact: all values are integers < 2^20).  (B, NS)."""
    B = S.shape[0]
    Sh = S.astype(np.float64) @ H64f                                 # B x 64 x 64
    T = Sh[:, :, Uflat].reshape(B * 64, 651 * 16, 4)                 # (b z), (v o), p
    K = np.matmul(T.transpose(1, 0, 2), SGf.transpose(0, 2, 1))      # (v o), (b z), w
    K = K.reshape(651 * 16, B, 64, 4).transpose(1, 2, 0, 3).reshape(B, 64, 651 * 16 * 4)
    M = np.matmul(IMf, K) / 4.0                                      # B x 7 x (v o w)
    Mi = np.rint(M).astype(np.int64)
    assert np.abs(M - Mi).max() < 1e-6
    return Mi.reshape(B, NS)


def fam2_polys_fast(T, Kp, batch=16):
    """Same output as fam2_polys; stores v = |J| + v2(N_J) as uint8 for all (J, sum)."""
    D = len(Kp)
    mons = monomials(D)
    nJ = len(mons)
    sgn = (1 - 2 * T.astype(np.int64))
    Ks = [k.astype(np.int64) for k in Kp]
    deg = np.array([bin(J).count("1") for J in mons], dtype=np.int64)
    Vals = np.empty((nJ, NS), dtype=np.uint8)
    for start in range(0, nJ, batch):
        Js = mons[start:start + batch]
        S = np.empty((len(Js), 64, 64), dtype=np.int64)
        for b, J in enumerate(Js):
            X = np.ones((64, 64), dtype=np.int64)
            for i in range(D):
                if J >> i & 1:
                    X &= Ks[i]
            S[b] = sgn * X
        N = sum_tensor_fast(S)
        Vals[start:start + len(Js)] = np.minimum(v2arr(N) + deg[start:start + len(Js), None], 99)
    k0 = Vals.min(axis=0).astype(np.int64)
    Ivec = np.repeat(np.array([0] + [1] * 6), 651 * 16 * 4)
    lim = 5 - Ivec if D <= 3 else np.minimum(5 - Ivec, 4)          # D <= 3: the expansion is complete
    use = np.nonzero(k0 < lim)[0]
    if len(use) == 0:
        return mons, []
    sub = Vals[:, use] == k0[use][None, :]                          # nJ x nuse
    rows = np.packbits(sub, axis=0, bitorder="little").T.copy()     # nuse x nb
    uniq, first = np.unique(rows, axis=0, return_index=True)
    out = []
    for r, f in zip(uniq, first):
        s = int(use[f])
        bits = np.unpackbits(r, bitorder="little")[:nJ]
        P = {mons[j] for j in np.nonzero(bits)[0]}
        i, rem = divmod(s, 651 * 16 * 4); v, rem = divmod(rem, 16 * 4); o, w = divmod(rem, 4)
        out.append(((v, o, w, i), int(k0[s]), P))
    return mons, out


def v2arr(N):
    a = np.abs(N)
    out = np.full(N.shape, 99, dtype=np.int64)
    nz = a != 0
    x = a[nz]
    out[nz] = np.log2(x & -x).round().astype(np.int64)
    return out


def fam2_polys(T, Kp, batch=24):
    """T: 64x64 table at the base point; Kp: list of D tables (directions).  Returns
    (mons, list of (sumid, k0, set of J)) for the sums with k0 < 5 - |I| and k0 <= 3."""
    D = len(Kp)
    mons = monomials(D)
    nJ = len(mons)
    nb = (nJ + 7) // 8
    lev = {l: np.zeros((NS, nb), dtype=np.uint8) for l in range(4)}
    sgn = (1 - 2 * T.astype(np.int64))
    Ks = [k.astype(np.int64) for k in Kp]
    for start in range(0, nJ, batch):
        Js = mons[start:start + batch]
        S = np.empty((len(Js), 64, 64), dtype=np.int64)
        for b, J in enumerate(Js):
            X = np.ones((64, 64), dtype=np.int64)
            for i in range(D):
                if J >> i & 1:
                    X &= Ks[i]
            S[b] = sgn * X
        N = sum_tensor(S).reshape(len(Js), NS)
        V = v2arr(N)
        for b, J in enumerate(Js):
            val = bin(J).count("1") + V[b]
            idx = start + b
            for l in range(4):
                hit = val == l
                if hit.any():
                    lev[l][hit, idx >> 3] |= np.uint8(1 << (idx & 7))
    Ivec = np.repeat(np.array([0] + [1] * 6), 651 * 16 * 4)
    k0 = np.full(NS, 99, dtype=np.int64)
    for l in (3, 2, 1, 0):
        k0[lev[l].any(axis=1)] = l
    use = k0 < np.minimum(5 - Ivec, 4)
    out = []
    rows = np.zeros((NS, nb), dtype=np.uint8)
    for l in range(4):
        sel = use & (k0 == l)
        rows[sel] = lev[l][sel]
    idx_use = np.nonzero(use)[0]
    if len(idx_use) == 0:
        return mons, []
    uniq, first = np.unique(rows[idx_use], axis=0, return_index=True)
    for r, f in zip(uniq, first):
        s = int(idx_use[f])
        bits = np.unpackbits(r, bitorder="little")[:nJ]
        P = {mons[j] for j in np.nonzero(bits)[0]}
        i, rem = divmod(s, 651 * 16 * 4); v, rem = divmod(rem, 16 * 4); o, w = divmod(rem, 4)
        out.append(((v, o, w, i), int(k0[s]), P))
    return mons, out


def direct_poly(T, Kp, sumid):
    """Independent evaluation of one sum: (k0, P) by direct summation over its points (no transforms)."""
    v, o, w, i = sumid
    P4 = ANN[v]
    Vsub = [s for s in range(64) if all(bin(s & q).count("1") % 2 == 0 for q in P4)]
    assert len(Vsub) == 16
    om = int(OM[v][o]); w0 = int(W0[v][w])
    pts = [(z, w0 ^ s, bin(om & s).count("1") & 1) for z in range(64) if (i == 0 or z >> (i - 1) & 1) for s in Vsub]
    D = len(Kp)
    sg = np.array([1 - 2 * (int(T[z, ww]) ^ c) for z, ww, c in pts], dtype=np.int64)
    X = np.array([[int(Kp[t][z, ww]) for t in range(D)] for z, ww, c in pts], dtype=np.int64).reshape(len(pts), D)
    best = 99; vals = {}
    for k in range(0, 4):
        for J in itertools.combinations(range(D), k):
            col = sg.copy()
            for t in J:
                col = col * X[:, t]
            N = int(col.sum())
            if N:
                val = k + ((abs(N) & -abs(N)).bit_length() - 1)
                vals[sum(1 << t for t in J)] = val
                best = min(best, val)
    tgt = 5 - (0 if i == 0 else 1)
    if best > 3 or best >= tgt:
        return None
    return best, {J for J, val in vals.items() if val == best}
