"""Identity behind deg_3(P_B) = 0 on the pairs (z, B) with B alternating, B z = 0 (half-turn), rank B <= 4.

Find q_E(B) = [rad B n E = 0] (E = <e0,e1,e2>) as
    sum_k lambda_k(z,B) Pf_k(B) + R(z,B)
where every term has z-degree <= 5 when B = B_z has entries of degree <= 2 in z and Pf_k(B_z) has degree <= 3:
    lambda_k in {1, z_i, z_i z_j, b_m}            (z-degree <= 2)
    R monomials: z^a (|a| <= 5), z^a b_m (|a| <= 3), z^a b_m b_n (|a| <= 1).
Then sum_z q_E(B_z) = 0.  Linear algebra over F2 on the point set."""
import itertools
import numpy as np

PAIRS = list(itertools.combinations(range(6), 2))
pidx = {p: k for k, p in enumerate(PAIRS)}
QUADS = list(itertools.combinations(range(6), 4))


def apply(bits, v):
    out = 0
    for k, (i, j) in enumerate(PAIRS):
        if bits >> k & 1:
            out ^= ((v >> j & 1) << i) ^ ((v >> i & 1) << j)
    return out


def rank_le4_and_radE(bits):
    # rank of the alternating matrix and whether rad n E = 0 for E = <e0,e1,e2>
    rows = [apply(bits, 1 << c) for c in range(6)]
    def rk(vs):
        piv = {}; r = 0
        for x in vs:
            while x and (x.bit_length() - 1) in piv:
                x ^= piv[x.bit_length() - 1]
            if x:
                piv[x.bit_length() - 1] = x; r += 1
        return r
    return rk(rows), rk(rows[:3]) == 3


def pf4(bits, S):
    a, b, c, d = S
    e = lambda i, j: bits >> pidx[(min(i, j), max(i, j))] & 1
    return (e(a, b) & e(c, d)) ^ (e(a, c) & e(b, d)) ^ (e(a, d) & e(b, c))


pts = []; q = []
for bits in range(1 << 15):
    r, ok = rank_le4_and_radE(bits)
    if r > 4:
        continue
    for z in range(64):
        if apply(bits, z) == 0:
            pts.append((z, bits)); q.append(1 if ok else 0)
print("points (z, B):", len(pts))
n = len(pts)
Z = np.array([p[0] for p in pts]); Bb = np.array([p[1] for p in pts])
zbit = [((Z >> i) & 1).astype(bool) for i in range(6)]
bbit = [((Bb >> k) & 1).astype(bool) for k in range(15)]
pfv = [np.array([pf4(b, S) for b in Bb], dtype=bool) for S in QUADS]


def toint(arr):
    return int.from_bytes(np.packbits(arr.astype(np.uint8), bitorder="little").tobytes(), "little")


def zmon(a):
    v = np.ones(n, dtype=bool)
    for i in range(6):
        if a >> i & 1:
            v &= zbit[i]
    return v


cols = {}
lam = [("1", np.ones(n, dtype=bool))] + [("z%d" % i, zbit[i]) for i in range(6)] + \
      [("z%dz%d" % (i, j), zbit[i] & zbit[j]) for i, j in itertools.combinations(range(6), 2)] + \
      [("b%d" % m, bbit[m]) for m in range(15)]
for s, S in enumerate(QUADS):
    for nm, v in lam:
        cols["%s*Pf%s" % (nm, "".join(map(str, S)))] = toint(v & pfv[s])
for a in range(64):
    if bin(a).count("1") <= 5:
        cols["z^%d" % a] = toint(zmon(a))
    if bin(a).count("1") <= 3:
        for m in range(15):
            cols["z^%d*b%d" % (a, m)] = toint(zmon(a) & bbit[m])
    if bin(a).count("1") <= 1:
        for m, k in itertools.combinations(range(15), 2):
            cols["z^%d*b%d*b%d" % (a, m, k)] = toint(zmon(a) & bbit[m] & bbit[k])
names = list(cols)
print("columns:", len(names))
target = toint(np.array(q, dtype=bool))
piv = {}
for idx, nm in enumerate(names):
    v = cols[nm]; comb = 1 << idx
    while v:
        h = v.bit_length() - 1
        if h in piv:
            v ^= piv[h][0]; comb ^= piv[h][1]
        else:
            piv[h] = (v, comb); break
v = target; comb = 0
while v:
    h = v.bit_length() - 1
    if h not in piv:
        break
    v ^= piv[h][0]; comb ^= piv[h][1]
if v == 0:
    used = [names[i] for i in range(len(names)) if comb >> i & 1]
    chk = 0
    for nm in used:
        chk ^= cols[nm]
    print("IDENTITY FOUND,", len(used), "terms; re-check:", chk == target)
    print(" + ".join(used))
else:
    print("no identity in this family")
