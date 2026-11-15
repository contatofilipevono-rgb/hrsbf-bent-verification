"""Search for the identity behind deg_3(P_B) = 0.

On S4 = {alternating 6x6 matrices over F2 of rank <= 4} (12,608 matrices), write
    q_E(B) = [rad B n E = 0]          (E = <e0, e1, e2>)
as  sum_k lambda_k(B) Pf_k(B) + R(B)  with deg lambda_k <= 1, deg R <= 2 in the 15 entries of B,
where Pf_k are the 15 coordinate 4x4 Pfaffians.  If it exists then, for B = B_z with entries of degree <= 2 in z and
every z -> Pf_V(B_z) of degree <= 3 (this is (Pf4)), each term has degree <= 5 in z and sum_z q_E(B_z) = 0, i.e. the
degree-3 coefficient of P_B vanishes.  Prints the identity (which multipliers) if found."""
import itertools
import numpy as np

PAIRS = list(itertools.combinations(range(6), 2))
pidx = {p: k for k, p in enumerate(PAIRS)}
QUADS = list(itertools.combinations(range(6), 4))


def mat(bits):
    M = np.zeros((6, 6), dtype=np.int64)
    for k, (i, j) in enumerate(PAIRS):
        if bits >> k & 1:
            M[i, j] = M[j, i] = 1
    return M


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


def pf4(bits, S):
    a, b, c, d = S
    e = lambda i, j: bits >> pidx[(min(i, j), max(i, j))] & 1
    return (e(a, b) & e(c, d)) ^ (e(a, c) & e(b, d)) ^ (e(a, d) & e(b, c))


S4 = []; q = []
for bits in range(1 << 15):
    M = mat(bits)
    r = rank2(M)
    if r <= 4:
        S4.append(bits)
        # rad n E = 0  <=>  the columns M e0, M e1, M e2 are independent
        q.append(1 if rank2(M[:, :3]) == 3 else 0)
print("matrices of rank <= 4:", len(S4))
npts = len(S4)


def fvec(f):
    v = 0
    for i, b in enumerate(S4):
        if f(b):
            v |= 1 << i
    return v


target = fvec(lambda b: q[S4.index(b)] if False else None) if False else sum(1 << i for i in range(npts) if q[i])
cols = {}
ent = [lambda b, k=k: b >> k & 1 for k in range(15)]
cols["1"] = fvec(lambda b: 1)
for k in range(15):
    cols["b%d" % k] = fvec(ent[k])
for k, l in itertools.combinations(range(15), 2):
    cols["b%d*b%d" % (k, l)] = fvec(lambda b, k=k, l=l: (b >> k & 1) & (b >> l & 1))
for s, S in enumerate(QUADS):
    cols["Pf%s" % "".join(map(str, S))] = fvec(lambda b, S=S: pf4(b, S))
    for k in range(15):
        cols["b%d*Pf%s" % (k, "".join(map(str, S)))] = fvec(lambda b, S=S, k=k: (b >> k & 1) & pf4(b, S))
names = list(cols)
print("columns:", len(names))
# Gaussian elimination with tracking
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
    print("IDENTITY FOUND with", len(used), "terms:")
    print(" + ".join(used))
    # independent re-check
    chk = 0
    for nm in used:
        chk ^= cols[nm]
    print("re-check:", chk == target)
else:
    print("no identity with deg lambda <= 1, deg R <= 2")
