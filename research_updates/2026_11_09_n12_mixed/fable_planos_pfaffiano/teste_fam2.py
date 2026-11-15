import os, sys, time, random
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from bitj import load_model
from poisson3_lista import todos_subespacos3
from cert_arvore import polar_data, one_in_span
from cert_fam2 import fam2_polys, direct_poly

hx = open(sys.argv[1]).read().split()[0]
model = load_model(); Vs = todos_subespacos3()
T0, K = polar_data(hx, model, Vs)
print("D", len(K))
t = time.time()
mons, polys = fam2_polys(T0, K)
print("fam2: distinct constrained polynomials", len(polys), round(time.time() - t, 1), "s")
from collections import Counter
print("k0:", Counter(k for _, k, _ in polys), "max degree:", Counter(max((bin(J).count('1') for J in P), default=0) for _, _, P in polys))
rnd = random.Random(1)
for sid, k0, P in rnd.sample(polys, min(8, len(polys))):
    d = direct_poly(T0, K, sid)
    assert d == (k0, P), (sid, k0, d)
print("direct evaluation agrees on samples")
print("1 in span:", one_in_span([P for _, _, P in polys]))
