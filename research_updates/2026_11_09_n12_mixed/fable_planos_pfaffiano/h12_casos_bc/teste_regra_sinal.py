"""Finite checks for the sign rule theorem (rodar: python teste_regra_sinal.py; precisa de numpy).
Rule R(m): every RS bent h on F2^m has h(0) + h(1) = m/2 (mod 2), i.e. sign(W(0) W(1)) = (-1)^(m/2).
Theorem: R(m) and p an odd prime with p > 2^(m/2)  =>  R(m p^a).
 (a) base m = 4: RS bent on 4 variables satisfy R(4);  m = 6: R(6) exhaustively (also follows from m=2, p=3).
 (b) rigidity step at m = 4: for p = 5, 7, 11, 13, a Boolean g on F2^4 with every W_g(b) = +-2^(2p) (mod p) is bent.
     (exhaustive over the 2^16 functions; the theorem only needs the parity of W and Parseval)
 (c) the exceptional prime p = 3 at m = 4 (this is n = 12): every g with W_g(b) != 0 (mod 3) for all b is bent or of
     point type (|W| = 14 once and 2 fifteen times); RS point type has sign(W(0) W(1)) = -1, so R fails exactly there.
 (d) n = 12 homogeneous quartic: h(0) + h(1) = t42 (only odd-size quartic orbit is {0,3,6,9}), so R(12) <=> t42 = 0."""
import itertools
import numpy as np


def walsh_all(m):
    N = 1 << m
    H = np.array([[1 - 2 * (bin(a & b).count("1") & 1) for b in range(N)] for a in range(N)], dtype=np.int64)
    return H


def rs_orbits(m):
    rot = lambda x: ((x << 1) | (x >> (m - 1))) & ((1 << m) - 1)
    seen = set(); orbs = []
    for x in range(1 << m):
        if x in seen: continue
        o = set(); y = x
        for _ in range(m):
            o.add(y); y = rot(y)
        seen |= o; orbs.append(sorted(o))
    return orbs


def rs_bent(m):
    """all RS bent functions on m variables, as truth tables (enumerate RS truth tables: one bit per orbit of points)."""
    H = walsh_all(m); orbs = rs_orbits(m); out = []
    for bits in range(1 << len(orbs)):
        tt = np.zeros(1 << m, dtype=np.int64)
        for k, o in enumerate(orbs):
            if bits >> k & 1:
                tt[o] = 1
        W = (1 - 2 * tt) @ H
        if np.all(np.abs(W) == (1 << (m // 2))):
            out.append((tt, W))
    return out


for m in (4, 6):
    B = rs_bent(m)
    assert all((int(tt[0]) + int(tt[-1])) % 2 == (m // 2) % 2 for tt, W in B)
    assert all(np.sign(W[0] * W[-1]) == (-1) ** (m // 2) for tt, W in B)
    print("(a) R(%d): ok on all %d RS bent functions" % (m, len(B)))

H4 = walsh_all(4)
ALL = np.array([[(g >> y) & 1 for y in range(16)] for g in range(1 << 16)], dtype=np.int64)
W4 = (1 - 2 * ALL) @ H4                                           # (65536, 16)
for p in (5, 7, 11, 13):
    target = pow(2, 2 * p, p)
    ok = np.all((W4 % p == target % p) | (W4 % p == (-target) % p), axis=1)
    assert np.all(np.abs(W4[ok]) == 4), p
    print("(b) m=4, p=%d: %d functions satisfy the congruences, all bent" % (p, int(ok.sum())))
ok3 = np.all(W4 % 3 != 0, axis=1)
absW = np.sort(np.abs(W4), axis=1)
bent = np.all(absW == 4, axis=1)
point = np.all(absW == np.array([2] * 15 + [14]), axis=1)
assert np.all((bent | point)[ok3])
bent &= ok3; point &= ok3
print("(c) m=4, p=3: %d functions with W != 0 mod 3: %d bent, %d point type, nothing else" % (int(ok3.sum()), int(bent.sum()), int(point.sum())))
rot4 = lambda y: ((y << 1) | (y >> 3)) & 15
is_rs = np.all(ALL == ALL[:, [rot4(y) for y in range(16)]], axis=1)
sel = ok3 & point & is_rs
assert np.all(np.sign(W4[sel, 0] * W4[sel, 15]) == -1)
sel_b = ok3 & bent & is_rs
assert np.all(np.sign(W4[sel_b, 0] * W4[sel_b, 15]) == 1)
print("(c) RS point type (%d functions): sign(W(0)W(1)) = -1; RS bent (%d): +1" % (int(sel.sum()), int(sel_b.sum())))

# (d) odd-size orbits of quartic supports in Z12
n = 12
rot = lambda x: ((x << 1) | (x >> (n - 1))) & 4095
sizes = {}
for c in itertools.combinations(range(n), 4):
    m_ = sum(1 << i for i in c); o = set(); y = m_
    for _ in range(n):
        o.add(y); y = rot(y)
    sizes[min(o)] = len(o)
odd = [k for k, s in sizes.items() if s % 2]
assert odd == [sum(1 << i for i in (0, 3, 6, 9))]
print("(d) n=12: the only odd-size quartic orbit is {0,3,6,9} (size 3), so h(0)+h(1) = t42 for homogeneous quartics")
