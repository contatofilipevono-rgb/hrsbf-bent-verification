"""(1) Rule g(0)+g(1) = n/2 at n = 12 on the degree-<=4 classification: does any bent polar have the C3 matching in B_0
    (= coefficient of the orbit {0,3,6,9}, which is the only odd-size quartic orbit)?
(2) 4-periodic shadow at n = 12 (p = 3): g(y) = f(y,y,y) on F2^4. Technique 2: W_g(b) = W_f(rep b) = +-64 = +-1 mod 3,
    so W_g(b) must avoid {0, +-6, +-12}.  Which t pass, per case A/B/C (homogeneous model)?
    Also: Parseval classification at p = 3: g bent, or spectrum {+-14 once, +-2 fifteen times} (point type).
Usage: python -I regra_sombra.py REPO_DIR"""
import sys, os, json, itertools, collections, random
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from bc_comum import *

REPO = sys.argv[1]
bent = [l.strip() for l in open(os.path.join(REPO, "polares_bent72.txt")) if l.strip()]
k03, k14, k25 = PAIRS.index((0, 3)), PAIRS.index((1, 4)), PAIRS.index((2, 5))
c3 = collections.Counter()
for h in bent:
    v = int(h, 16)
    c3[tuple(v >> (64 * k) & 1 for k in (k03, k14, k25))] += 1
print("(1) C3 part of B_0 over the 72 bent polars (pairs 03,14,25 at z=0):", dict(c3))

# (2) shadow: x 4-periodic, x_i = y_{i mod 4}
idx4 = [sum(((y >> (i % 4)) & 1) << i for i in range(12)) for y in range(16)]
H16 = np.array([[1 - 2 * (bin(a & b).count("1") & 1) for b in range(16)] for a in range(16)])
SH = TT[:, idx4]                       # (43, 16): orbit sums restricted to 4-periodic words
# which t combinations matter: rank of SH
rows = [int("".join(str(int(b)) for b in SH[j][::-1]), 2) for j in range(43)]
print("rank of t -> shadow map:", len({0}) and None)
piv = {}
for j, r in enumerate(rows):
    x = r
    while x:
        c = x.bit_length() - 1
        if c in piv: x ^= piv[c]
        else: piv[c] = x; break
print("shadow space dimension:", len(piv), " orbits with nonzero shadow:", [j for j in range(43) if rows[j]])
random.seed(9)
stat = collections.defaultdict(collections.Counter)
for case, (t42, t30, t40) in (("A", (0, 0, 0)), ("B", (0, 1, 1)), ("C", (1, 1, 0))):
    for _ in range(20000):
        t = [random.getrandbits(1) for _ in range(43)]
        t[37] = sum(t[j] for j in L456 if j != 37) & 1
        t[36] = sum(t[j] for j in L464 if j != 36) & 1
        t[42], t[30], t[40] = t42, t30, t40
        g = np.zeros(16, dtype=np.int64)
        for j in range(43):
            if t[j]: g ^= SH[j]
        W = (1 - 2 * g) @ H16
        ok3 = bool(np.all(W % 3 != 0))
        kind = "bent" if np.all(np.abs(W) == 4) else ("ponto" if sorted(np.abs(W)) == [2] * 15 + [14] else "outro")
        stat[case]["total"] += 1
        stat[case]["W != 0 mod 3"] += ok3
        stat[case]["tipo " + kind] += 1
        stat[case]["tipo %s & mod3" % kind] += ok3
for case in stat:
    print("(2) case", case, dict(stat[case]))
