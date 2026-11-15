"""Zero polar: f(z,w) = lambda(z).w + h(z).  Dimensions of the lambda-space and of the h-only kernel."""
import os, sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from bitj import load_model
from cert_arvore import polar_data
from poisson3_lista import todos_subespacos3

model = load_model(); Vs = todos_subespacos3()
T0, K = polar_data("0", model, Vs)
m = len(K)
def lam(t):
    return np.concatenate([(t[:, 1 << i] ^ t[:, 0]) for i in range(6)]).astype(np.uint8)   # 384 bits
def aff_check(t):
    for z in range(64):
        row = t[z]
        for w in range(64):
            pred = row[0]
            for i in range(6):
                if w >> i & 1:
                    pred ^= row[1 << i] ^ row[0]
            if pred != row[w]:
                return False
    return True
assert aff_check(T0) and all(aff_check(k) for k in K[:5])
L = np.array([lam(k) for k in K])
# rank over F2
M = L.copy() % 2; r = 0
rows, cols = M.shape
piv_rows = []
for c in range(cols):
    p = np.nonzero(M[r:, c])[0]
    if len(p) == 0:
        continue
    p = p[0] + r; M[[r, p]] = M[[p, r]]
    for i in np.nonzero(M[:, c])[0]:
        if i != r:
            M[i] ^= M[r]
    r += 1
    if r == rows:
        break
print("phase dim", m, "| dim Lambda", r, "| h-only kernel", m - r, "| base point lambda zero:", not lam(T0).any())
