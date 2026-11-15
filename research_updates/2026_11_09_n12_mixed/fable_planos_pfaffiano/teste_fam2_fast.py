import os, sys, time
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from bitj import load_model
from poisson3_lista import todos_subespacos3
from cert_arvore import polar_data
from cert_fam2 import fam2_polys, fam2_polys_fast

hx = open(sys.argv[1]).read().split()[0]
D = int(sys.argv[2]) if len(sys.argv) > 2 else 12
model = load_model(); Vs = todos_subespacos3()
T0, K = polar_data(hx, model, Vs)
rng = np.random.default_rng(3)
Kp = []
for _ in range(D):                       # random directions inside U
    t = np.zeros_like(T0)
    for j in range(len(K)):
        if rng.random() < 0.5:
            t ^= K[j]
    Kp.append(t)
t = time.time(); _, a = fam2_polys(T0, Kp); ta = time.time() - t
t = time.time(); _, b = fam2_polys_fast(T0, Kp); tb = time.time() - t
key = lambda L: sorted((tuple(sorted(P)), k0) for _, k0, P in L)
print("D", D, "slow", len(a), round(ta, 1), "s | fast", len(b), round(tb, 1), "s | same polynomial sets:", key(a) == key(b))
