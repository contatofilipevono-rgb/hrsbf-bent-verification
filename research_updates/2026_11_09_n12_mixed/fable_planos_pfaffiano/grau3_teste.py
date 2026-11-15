"""Where does deg_3(P_B) = 0 come from?  Test on random polars of the whole 25-dim polar space (no (Pf4)),
and on random alternating B(z) with entries of degree <= 2 in z (no RS, no model)."""
import os, sys, itertools, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from base12 import mobius
from bitj import load_model
from poisson5 import Bv_table

POP = np.array([bin(i).count("1") for i in range(64)])
PAIRS = list(itertools.combinations(range(6), 2))


def P_parts(B):
    Bv = Bv_table(B)
    N = (Bv == 0).sum(axis=0)
    P = (N % 2).astype(np.uint8)
    an = mobius(P.copy(), 6)
    return {k: int(an[POP == k].any()) for k in range(7)}, max((POP[i] for i in np.nonzero(an)[0]), default=-1)


rng = np.random.default_rng(1)
Bb, Gb, Gk, piv = load_model()
Bb = np.array(Bb, dtype=np.uint8)
stats = collections.Counter()
for _ in range(400):
    c = rng.integers(0, 2, len(Bb))
    B = (np.tensordot(c, Bb.astype(np.int64), axes=1) % 2).astype(np.uint8)
    parts, deg = P_parts(B)
    stats[("model polar", "deg4 part" if parts[4] else "-", "deg3 part" if parts[3] else "-")] += 1
# generic alternating B(z) with entries of degree <= 2 in z
X = np.arange(64)
mons = [0] + [1 << i for i in range(6)] + [(1 << i) | (1 << j) for i, j in itertools.combinations(range(6), 2)]
M = np.array([((X & m) == m).astype(np.uint8) for m in mons])            # 22 x 64
for _ in range(400):
    coef = rng.integers(0, 2, (15, len(mons)))
    B = (coef @ M % 2).astype(np.uint8)
    parts, deg = P_parts(B)
    stats[("generic deg<=2 entries", "deg4 part" if parts[4] else "-", "deg3 part" if parts[3] else "-")] += 1
for k, v in sorted(stats.items()):
    print(k, v)
