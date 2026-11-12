# Controle de (Pf4) nas 18 testemunhas bent publicadas: os 15 menores Pfaffianos 4 x 4 de B_z
# tem grau <= 3 em z, e B_0 e singular.  Controle negativo: quantos elementos da base de B violam.
# Uso: python verifica_pf4.py <lower-dim-family-witnesses.json>
import json, sys, os, pickle, itertools
import numpy as np
from base12 import polar, mobius, PAIRS, X
from testemunhas12 import posto, matriz

pidx = {p: k for k, p in enumerate(PAIRS)}
wt = np.array([bin(m).count("1") for m in range(64)])


def grau_pf(B):
    g = 0
    for a, b, c, e in itertools.combinations(range(6), 4):
        pf = (B[pidx[(a, b)]] & B[pidx[(c, e)]]) ^ (B[pidx[(a, c)]] & B[pidx[(b, e)]]) ^ (B[pidx[(a, e)]] & B[pidx[(b, c)]])
        co = mobius(pf, 6)
        if co.any(): g = max(g, int(wt[np.flatnonzero(co)].max()))
    return g


W = json.load(open(sys.argv[1]))
for w in W:
    t = np.zeros(4096, dtype=np.uint8)
    for m in w["anf_supports"]: t ^= ((X & m) == m).astype(np.uint8)
    B, degw, _ = polar(t)
    assert degw <= 2 and grau_pf(B) <= 3 and posto(matriz(B, 0)) <= 4
print("ok: (Pf4) e Pf(B_0) = 0 valem nas", len(W), "testemunhas bent")
here = os.path.dirname(os.path.abspath(__file__))
Bs = pickle.load(open(os.path.join(here, "base12.pkl"), "rb"))["B"]
import random
random.seed(2)
viol = 0
for _ in range(2000):
    B = np.zeros((15, 64), np.uint8)
    for b in Bs:
        if random.random() < 0.5: B ^= b
    viol += grau_pf(B) == 4
print("controle negativo: de 2000 formas polares aleatorias do modelo,", viol, "violam (Pf4)")
