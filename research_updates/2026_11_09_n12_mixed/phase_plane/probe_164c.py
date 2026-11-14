"""Class 164: is there a per-code symmetry z -> zeta(z) (cyclic shift of the 3 bits of y and of w,
rows 1->2->4, 3->6->5) with pi0(zeta z) = A pi0(z) for a fixed linear A on labels?"""
import sys, json
from pathlib import Path
from collections import Counter
from itertools import product
sys.path.insert(0, str(Path(__file__).parent))
import plane_cert as PC
import short_certs as SC
M = PC.Model(sys.argv[1]); K = int(sys.argv[2]) if len(sys.argv) > 2 else 164
def mapping_of(c):
    m = 0
    for i in range(33):
        if c >> i & 1:
            m ^= M.basis[i]
    return m
def dd(z): return (z & 7) ^ (z >> 3)
def rot3(v): return ((v << 1) | (v >> 2)) & 7
def zeta(z, k=1):
    y, w = z & 7, z >> 3
    for _ in range(k):
        y, w = rot3(y), rot3(w)
    return y | (w << 3)
base, dirs = PC.space_for(M, K, "H4")
pts = [base] + [base ^ d for d in dirs]
for kz in (1, 2):
    found = Counter()
    for c in pts:
        L = M.labels(mapping_of(c))
        pairs = {}
        ok = True
        for x in range(256):
            z, s = x & 63, x >> 6
            xx = zeta(z, kz) | (s << 6)
            pairs.setdefault(L[x], set()).add(L[xx])
        functional = all(len(v) == 1 for v in pairs.values())
        lin = None
        if functional:
            f = {a: next(iter(b)) for a, b in pairs.items()}
            # affine on labels?
            c0 = f.get(0)
            lin = all(f[a] ^ f[b] ^ f[a ^ b] ^ c0 == 0 for a in f for b in f if a ^ b in f) if c0 is not None else None
        found[(functional, lin)] += 1
    print("zeta^%d: (pi0(zeta x) a function of pi0(x), affine) over the affine basis of A_164:" % kz, dict(found))
# with s also rotated? try (z,s) -> (zeta z, s permuted)
for kz, sperm in product((1,), ((0, 1), (1, 0))):
    found = Counter()
    for c in pts:
        L = M.labels(mapping_of(c))
        pairs = {}
        for x in range(256):
            z, s1, s2 = x & 63, x >> 6 & 1, x >> 7 & 1
            s = (s1, s2)
            xx = zeta(z, kz) | (s[sperm[0]] << 6) | (s[sperm[1]] << 7)
            pairs.setdefault(L[x], set()).add(L[xx])
        found[all(len(v) == 1 for v in pairs.values())] += 1
    print("zeta with s-permutation", sperm, ": functional on all basis points:", dict(found))
