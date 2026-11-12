# Nas 18 testemunhas publicadas (12 do bloco de dimensao 3, 6 do plano <21,42>): classe (a, b) de
# beta_a = a0 e1 + a1 p1 + a2 p2,  beta_b = b1 p1 + b2 (e1 + p2) + b3 (1 + e1 + p3),
# perfil de postos de B_z e dimensoes d_a(z) = dim B_z V_a, d_b(z) = dim B_z V_b.
# Uso: python testemunhas12.py <lower-dim-family-witnesses.json>
import json, sys
from collections import Counter
import numpy as np
from base12 import polar, forma, PAIRS, X

Z = np.arange(64)
bit = lambda t: (Z >> t) & 1
e1 = sum(bit(t) for t in range(6)) & 1
p1 = sum(bit(t) & bit((t + 1) % 6) for t in range(6)) & 1
p2 = sum(bit(t) & bit((t + 2) % 6) for t in range(6)) & 1
p3 = sum(bit(t) & bit(t + 3) for t in range(3)) & 1
BA = [e1, p1, p2]; BB = [p1, e1 ^ p2, 1 ^ e1 ^ p3]


def coords(v, basis):
    for c in range(8):
        w = np.zeros(64, int)
        for t in range(3):
            if c >> t & 1: w ^= basis[t]
        if (w == v).all(): return tuple((c >> t) & 1 for t in range(3))
    return None


def posto(rows):
    piv = []
    for r in rows:
        for p in piv: r = min(r, r ^ p)
        if r: piv.append(r)
    return len(piv)


def matriz(B, z):
    rows = [0] * 6
    for k, (i, j) in enumerate(PAIRS):
        if B[k][z]: rows[i] |= 1 << j; rows[j] |= 1 << i
    return rows


def aplica(rows, v):
    return sum((bin(rows[i] & v).count("1") & 1) << i for i in range(6))


if __name__ == "__main__":
    W = json.load(open(sys.argv[1]))
    for w in W:
        t = np.zeros(4096, dtype=np.uint8)
        for m in w["anf_supports"]: t ^= ((X & m) == m).astype(np.uint8)
        B, degw, _ = polar(t)
        assert degw <= 2
        ba = forma(B, 27, 54); bb = forma(B, 21, 42)
        rk = Counter(posto(matriz(B, z)) for z in range(64))
        da = Counter(posto([aplica(matriz(B, z), 27), aplica(matriz(B, z), 54)]) for z in range(64))
        db = Counter(posto([aplica(matriz(B, z), 21), aplica(matriz(B, z), 42)]) for z in range(64))
        print("espaco", w["space"], "orbita", w["map_orbit"], "| a =", coords(ba, BA), "b =", coords(bb, BB),
              "| postos de B_z:", dict(sorted(rk.items())), "| posto B_0:", posto(matriz(B, 0)),
              "| d_a:", dict(sorted(da.items())), "| d_b:", dict(sorted(db.items())))
