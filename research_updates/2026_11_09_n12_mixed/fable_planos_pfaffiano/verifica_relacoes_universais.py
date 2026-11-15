"""Independent check of the two universal quartic relations (EXTERIOR_QUARTICO_N12.md), from scratch.

1. t_j (j = 0..42): coefficients of the 43 rotation orbits of quartic monomials of x in F2^12, ordered by the
   smallest mask of each orbit.  With x = (a, b), a = z + w, b = w (a = bits 0-5, b = bits 6-11), every
   quartic monomial of (z, w) with at least three w-coordinates has a coefficient that is a linear form in t.
   Claim: each such form is 0, L456 or L464.
2. Divided-square filter (necessary for bentness, proof in the note): for every S of weight 8,
   Q_S = sum over unordered splits S = u + v (|u| = |v| = 4) of t_[u] t_[v]  = 0  (t^2 = t).
3. Claim: L456 and L464 lie in the F2-span of {Q_S} and {t_j Q_S}  (so every RS bent quartic part kills them).
Usage: python verifica_relacoes_universais.py"""
import itertools

N = 12
rot = lambda m: ((m << 1) | (m >> (N - 1))) & 4095

quart = [sum(1 << i for i in c) for c in itertools.combinations(range(N), 4)]
orb_of = {}
reps = []
for m in sorted(quart):
    if m in orb_of:
        continue
    o = set(); y = m
    for _ in range(N):
        o.add(y); y = rot(y)
    for y in o:
        orb_of[y] = len(reps)
    reps.append(min(o))
assert len(reps) == 43

# 1. change of coordinates: coefficient (linear form over t, as bitmask) of each (z,w) quartic monomial
coef = {}
for m, j in orb_of.items():
    a_idx = [i for i in range(6) if m >> i & 1]
    b_idx = [i - 6 for i in range(6, 12) if m >> i & 1]
    # expand prod_{i in a}(z_i + w_i) * prod_{i in b} w_i ; monomial in (z,w): z bits 0-5, w bits 6-11
    terms = {0: 1}
    for i in a_idx:
        new = {}
        for t_, c in terms.items():
            for choice in (1 << i, 1 << (i + 6)):
                k = t_ | choice
                new[k] = new.get(k, 0) ^ c
        terms = {k: c for k, c in new.items() if c}
    wpart = sum(1 << (i + 6) for i in b_idx)
    for t_ in terms:
        mono = t_ | wpart
        coef[mono] = coef.get(mono, 0) ^ (1 << j)
L456 = sum(1 << j for j in (0, 4, 7, 9, 22, 27, 29, 37))
L464 = sum(1 << j for j in (1, 3, 5, 8, 24, 28, 34, 36))
seen = {}
for mono in quart:                                   # quartic monomials of (z,w)
    if bin(mono >> 6).count("1") >= 3:
        f = coef.get(mono, 0)
        seen[f] = seen.get(f, 0) + 1
assert set(seen) <= {0, L456, L464}, "a coefficient is not 0 / L456 / L464"
print("quartic (z,w)-monomials with >= 3 w's:", {("0" if k == 0 else "L456" if k == L456 else "L464"): v for k, v in seen.items()})

# 2. divided-square quadrics
oct_masks = [sum(1 << i for i in c) for c in itertools.combinations(range(N), 8)]
Qs = set()
for S in oct_masks:
    bits = [i for i in range(N) if S >> i & 1]
    poly = set()
    for c in itertools.combinations(bits, 4):
        u = sum(1 << i for i in c); v = S ^ u
        if u < v:
            mono = (1 << orb_of[u]) | (1 << orb_of[v])
            poly ^= {mono}
    if poly:
        Qs.add(frozenset(poly))
print("distinct nonzero quadrics Q_S:", len(Qs))

# 3. span of {Q, t_j Q}: Gaussian elimination over monomials of degree <= 3
rows = []
for Q in Qs:
    rows.append(set(Q))
    for j in range(43):
        rows.append({mono | (1 << j) for mono in Q} if True else None)
def to_vec(poly):
    r = set()
    for mono in poly:
        r ^= {mono}
    return r
idx = {}
vecs = []
for p in rows:
    p = to_vec(p) if not isinstance(p, set) else p
    # symmetric reduction (t^2 = t already handled by OR); recompute XOR multiset
    acc = {}
    for mono in p:
        acc[mono] = acc.get(mono, 0) ^ 1
    v = 0
    for mono, c in acc.items():
        if c:
            if mono not in idx:
                idx[mono] = len(idx)
            v |= 1 << idx[mono]
    vecs.append(v)
# give linear monomials the lowest positions so that a linear form is a combination iff it reduces to 0
lin = [1 << j for j in range(43)]
order = sorted(idx, key=lambda mono: (bin(mono).count("1"), mono), reverse=True)
pos = {mono: k for k, mono in enumerate(order)}
def remap(v):
    out = 0
    for mono, k in idx.items():
        if v >> k & 1:
            out |= 1 << pos[mono]
    return out
piv = {}
for v in map(remap, vecs):
    while v and (v.bit_length() - 1) in piv:
        v ^= piv[v.bit_length() - 1]
    if v:
        piv[v.bit_length() - 1] = v
def in_span(linform):
    v = 0
    for j in range(43):
        if linform >> j & 1:
            mono = 1 << j
            if mono not in pos:
                return False
            v |= 1 << pos[mono]
    while v and (v.bit_length() - 1) in piv:
        v ^= piv[v.bit_length() - 1]
    return v == 0
print("L456 in span{Q, tQ}:", in_span(L456), "| L464 in span{Q, tQ}:", in_span(L464))
assert in_span(L456) and in_span(L464)
print("OK")
