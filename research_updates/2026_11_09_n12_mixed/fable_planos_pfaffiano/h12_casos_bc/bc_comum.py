"""Common helpers for the H12 cases B/C work (independent re-implementation of Fable's base/model).
Orbits of quartic monomials of F2^12 under rotation, ordered by smallest mask; t in F2^43.
(z,w) model: x = (a,b), a = bits 0..5, b = bits 6..11, z = a+b, w = b."""
import itertools
import numpy as np

n = 12
PAIRS = list(itertools.combinations(range(6), 2))


def rot(m, k=1):
    k %= n
    return ((m << k) | (m >> (n - k))) & ((1 << n) - 1)


quads = [m for m in range(1 << n) if bin(m).count("1") == 4]
orbs, idx = [], {}
for m in quads:
    if m in idx:
        continue
    o = sorted({rot(m, k) for k in range(n)})
    for x in o:
        idx[x] = len(orbs)
    orbs.append(o)
assert len(orbs) == 43

X = np.arange(4096)
TT = []
for o in orbs:
    t = np.zeros(4096, dtype=np.uint8)
    for m in o:
        t ^= ((X & m) == m).astype(np.uint8)
    TT.append(t)
TT = np.array(TT)
ZW = np.array([(z ^ w) | (w << 6) for w in range(64) for z in range(64)])  # index z + 64 w


def mobius(a, nb):
    a = a.copy()
    for j in range(nb):
        v = a.reshape(a.shape[:-1] + (1 << (nb - 1 - j), 2, 1 << j))
        v[..., 1, :] ^= v[..., 0, :]
    return a


AN = np.array([mobius(TT[j][ZW], 12) for j in range(43)])  # ANF in (z,w), index z + 64 w

L456 = [0, 4, 7, 9, 22, 27, 29, 37]
L464 = [1, 3, 5, 8, 24, 28, 34, 36]
NAMES = "u30 u40 u42 a b c d e g h k m n p r A1 A2 A3 B1 B2 B3".split()
FORMS = [[30], [40], [42], [10, 31], [11, 32], [13, 33], [16, 20], [17, 21], [18, 23], [19, 26], [12, 41],
         [14, 35], [15, 38], [6, 25], [2, 39], [0, 7, 9, 29], [0, 4, 9, 37], [0, 4, 7, 22], [1, 3, 8, 34],
         [1, 3, 5, 36], [3, 5, 8, 28]]


def tmask(t):
    return sum(1 << j for j in range(43) if t[j])


def gf2_solve(rows, rhs, nv):
    """rows: list of int masks over nv vars; returns one solution (free vars 0) or None."""
    piv = {}
    for r, b in zip(rows, rhs):
        while r:
            c = r.bit_length() - 1
            if c in piv:
                r ^= piv[c][0]
                b ^= piv[c][1]
            else:
                piv[c] = (r, b)
                break
        else:
            if b:
                return None
    sol = 0
    for c in sorted(piv):
        r, b = piv[c]
        if (bin(r & sol & ~(1 << c)).count("1") + b) & 1:
            sol |= 1 << c
    return sol


EQ = [sum(1 << j for j in F) for F in FORMS] + [sum(1 << j for j in L456), sum(1 << j for j in L464)]


def t_from_coords(code21):
    """code21: string of 21 bits in NAMES order -> t (list of 43 bits) with zero phase part."""
    rhs = [int(c) for c in code21] + [0, 0]
    s = gf2_solve(EQ, rhs, 43)
    assert s is not None
    return [s >> j & 1 for j in range(43)]


def coords_of_t(t):
    return "".join(str(sum(t[j] for j in F) & 1) for F in FORMS)


def anf_zw(t):
    a = np.zeros(4096, dtype=np.uint8)
    for j in range(43):
        if t[j]:
            a ^= AN[j]
    return a


def ftab_zw(t):
    """F[z, w] = f(x(z,w))."""
    f = np.zeros(4096, dtype=np.uint8)
    for j in range(43):
        if t[j]:
            f ^= TT[j]
    return f[ZW].reshape(64, 64).T.copy()


def polar_of(t):
    an = anf_zw(t)
    B = np.zeros((15, 64), np.uint8)
    for k, (i, j) in enumerate(PAIRS):
        wm = ((1 << i) | (1 << j)) << 6
        B[k] = mobius(an[wm:wm + 64], 6)
    return B


def hexint(B):
    v = 0
    for k in range(15):
        for z in range(64):
            if B[k][z]:
                v |= 1 << (64 * k + z)
    return v


H64 = np.array([[1 - 2 * (bin(a & b).count("1") & 1) for b in range(64)] for a in range(64)], dtype=np.int64)
ROWS8 = [0] + [1 << i for i in range(6)] + [63]


def spectrum_rows(F):
    """R[z, b] = sum_w (-1)^(F[z,w] + b.w)."""
    return (1 - 2 * F.astype(np.int64)) @ H64


def Bd_zero(B):
    """K[z, d] = 1 if B_z d = 0."""
    K = np.ones((64, 64), dtype=bool)
    D = np.arange(64)
    for i in range(6):
        row = np.zeros((64, 64), dtype=np.uint8)  # (z, d): sum_j B_ij(z) d_j
        for k, (a, b) in enumerate(PAIRS):
            if a == i:
                row ^= np.outer(B[k], (D >> b) & 1).astype(np.uint8)
            elif b == i:
                row ^= np.outer(B[k], (D >> a) & 1).astype(np.uint8)
        K &= (row == 0)
    return K


def even_ok(B):
    N = Bd_zero(B).sum(axis=0)
    return bool(np.all(N[1:] % 2 == 0)), N


def pass8(F):
    R = spectrum_rows(F)
    s = (R[ROWS8] ** 2).sum(axis=0)
    return bool(s.max() <= 4096), int(s.max())
