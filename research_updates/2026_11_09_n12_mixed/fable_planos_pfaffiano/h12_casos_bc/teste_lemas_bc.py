"""Testes numericos dos Lemas 5 a 8 da nota NOTA_H12_CASOS_BC.md (rodar: python teste_lemas_bc.py; precisa de numpy).
Usa so bc_comum.py (orbitas, modelo (z,w), polar, espectro das linhas)."""
import random, itertools
import numpy as np
from bc_comum import *

random.seed(11)
N = {s: i for i, s in enumerate(NAMES)}


def rand_model():
    t = [random.getrandbits(1) for _ in range(43)]
    t[37] = sum(t[j] for j in L456 if j != 37) & 1
    t[36] = sum(t[j] for j in L464 if j != 36) & 1
    return t


def coords(t):
    c = coords_of_t(t)
    return {s: int(c[N[s]]) for s in NAMES}


def ab(v):
    al = (v["p"] + v["A2"] + v["B1"] + v["B2"]) & 1
    be = (v["r"] + v["A1"] + v["A3"] + v["B2"] + v["B3"]) & 1
    return al, be


def pf4(an, V, J):
    """coeficiente de z^J em Pf_V(T_z): soma sobre os 3 emparelhamentos de V e as divisoes J = K u L."""
    i, j, k, l = V
    s = 0
    for (p, q) in (((i, j), (k, l)), ((i, k), (j, l)), ((i, l), (j, k))):
        for K in itertools.combinations(J, 2):
            L = tuple(x for x in J if x not in K)
            mK = sum(1 << x for x in K) | (((1 << p[0]) | (1 << p[1])) << 6)
            mL = sum(1 << x for x in L) | (((1 << q[0]) | (1 << q[1])) << 6)
            s ^= int(an[mK]) & int(an[mL])
    return s


# Lema 5: tres quadricas de (Pf4) com V = J sao as do Lema 1; uma com V != J da Y + alpha + beta + u42 (p + r)
for _ in range(200):
    t = rand_model(); an = anf_zw(t); v = coords(t); al, be = ab(v)
    Y = (v["a"] + v["d"] + v["h"] + v["m"]) & 1
    assert pf4(an, (0, 1, 3, 4), (0, 1, 3, 4)) == (v["u30"] + v["u40"] + v["u42"]) & 1
    assert pf4(an, (0, 1, 2, 3), (0, 1, 2, 3)) == (v["u30"] + v["u40"] + v["u30"] * v["u42"]) & 1
    assert pf4(an, (0, 1, 2, 4), (0, 1, 2, 4)) == v["u40"] * v["u42"]
    assert pf4(an, (0, 1, 3, 4), (0, 2, 3, 5)) == (Y + al + be + v["u42"] * (v["p"] + v["r"])) & 1
print("Lema 5 ((Pf4) contem o Lema 1; quadrica Y + alpha + beta + u42(p+r)): ok")

# Lema 6: N_63 = #{z : B_z 1 = 0} = (u30+u40+u42) + alpha + beta + (1+u42) Y  (mod 2)
# e as somas de linha de B_0, B_9, B_27, B_63 usadas na prova
def rowsums(B, z):
    d = [0] * 6
    for k, (i, j) in enumerate(PAIRS):
        if B[k][z]:
            d[i] ^= 1; d[j] ^= 1
    return d


for _ in range(300):
    t = rand_model(); B = polar_of(t); v = coords(t); al, be = ab(v)
    Y = (v["a"] + v["d"] + v["h"] + v["m"]) & 1
    s = (v["u30"] + v["u40"] + v["u42"] + al + be) & 1
    n63 = sum(1 for z in range(64) if rowsums(B, z) == [0] * 6)
    assert n63 % 2 == (v["u30"] + v["u40"] + v["u42"] + al + be + (1 + v["u42"]) * Y) % 2
    assert rowsums(B, 0) == [v["u42"]] * 6
    assert rowsums(B, 63) == [0] * 6
    assert rowsums(B, 9) == [0, s, s, 0, s, s]
    assert rowsums(B, 27) == [Y, Y, v["u42"], Y, Y, v["u42"]]
    # o conjunto {z : B_z 1 = 0} e invariante pela rotacao
    Zs = {z for z in range(64) if rowsums(B, z) == [0] * 6}
    assert {((z << 1) | (z >> 5)) & 63 for z in Zs} == Zs
print("Lema 6 (paridade em d = 63 pelos pontos fixos da rotacao): ok")

# Lema 7: caso C com alpha = beta = 0: r_0(0) = 32 e |r_0(63)| = 64
cnt = 0
while cnt < 40:
    t = rand_model(); t[30], t[40], t[42] = 1, 0, 1
    v = coords(t); al, be = ab(v)
    if (al, be) != (0, 0):
        continue
    cnt += 1
    R = spectrum_rows(ftab_zw(t))
    assert R[0, 0] == 32 and abs(R[63, 0]) == 64
print("Lema 7 (caso C com alpha = beta = 0 impossivel pela coluna 0): ok")

# Lema 8: o perfil |r_b(z)| nas 8 linhas so depende de (caso, alpha, beta, a+d, a+h, b+e, b+n, c+g, c+k)
prof = {}
for _ in range(1500):
    t = rand_model(); v = coords(t); al, be = ab(v)
    key = (v["u30"], v["u40"], v["u42"], al, be, (v["a"] + v["d"]) & 1, (v["a"] + v["h"]) & 1,
           (v["b"] + v["e"]) & 1, (v["b"] + v["n"]) & 1, (v["c"] + v["g"]) & 1, (v["c"] + v["k"]) & 1)
    R = np.abs(spectrum_rows(ftab_zw(t)))[ROWS8]
    p = R.tobytes()
    assert prof.setdefault(key, p) == p
print("Lema 8 (teste das 8 linhas depende de 8 parametros alem do caso): ok;", len(prof), "chaves vistas")
