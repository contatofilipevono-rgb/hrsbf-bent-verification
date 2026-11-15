"""famW: (1) C(y) = W(u,b)(y) - 64 = 2^k0 P(y) mod 2^(k0+1) at random points; (2) agreement with the verifier."""
import os, sys, time
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from bitj import load_model, H64
from poisson3_lista import todos_subespacos3
from cert_arvore import polar_data
from cert_famW import famW_polys
from verifica_arvore import Polar

hx = open(sys.argv[1]).read().split()[int(sys.argv[3]) if len(sys.argv) > 3 else 0]
D = int(sys.argv[2])
model = load_model(); Vs = todos_subespacos3()
T0, K = polar_data(hx, model, Vs)
m = len(K)
rng = np.random.default_rng(5)
Bm = rng.integers(0, 2, size=(D, m))
x0 = rng.integers(0, 2, size=m)
def tab(vec):
    t = np.zeros_like(T0)
    for j in range(m):
        if vec[j] % 2:
            t ^= K[j]
    return t
T = T0 ^ tab(x0); Kp = [tab(Bm[i]) for i in range(D)]
t = time.time(); mons, polys = famW_polys(T, Kp); print("D", D, "W polys", len(polys), round(time.time() - t, 1), "s")
from collections import Counter
print("k0", Counter(k for _, k, _ in polys), "degree", Counter(max((bin(J).count("1") for J in P), default=0) for _, _, P in polys))
bad = 0
for trial in range(20):
    y = rng.integers(0, 2, size=D)
    f = T.copy()
    for i in range(D):
        if y[i]:
            f ^= Kp[i]
    Wf = H64 @ (1 - 2 * f.astype(np.int64)) @ H64
    ymask = sum(int(y[i]) << i for i in range(D))
    for (u, b), k0, P in polys:
        val = sum(1 for J in P if J & ymask == J) & 1
        if (int(Wf[u, b]) - 64) % (1 << (k0 + 1)) != (val << k0):
            bad += 1
print("random-point check failures:", bad)
Pv = Polar(T0, K)
for (u, b), k0, P in polys[:5]:
    pv = Pv.poly(["W", u, b], x0 % 2, Bm % 2)
    mine = frozenset(tuple(i for i in range(D) if J >> i & 1) for J in P)
    print("verifier agrees:", pv == mine)
