"""Write polar lists (hex, 15 blocks of 64 bits) for the broad test of the degree-2 Poisson filter:
  polares_L5.txt      : the 3,984 polars compatible with (L5) (from vivos_L5.pkl / poisson5.py)
  polares_bent.txt    : the polars of the 18 bent witnesses (positive control)
Usage: python lista_polares.py <vivos_L5.pkl> <witnesses.json>"""
import os, sys, pickle, json
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from base12 import mobius, elim_comb, pack, forma, polar, X

here = os.path.dirname(os.path.abspath(__file__))


def hexB(B):
    v = 0
    for k in range(15):
        for z in range(64):
            if B[k][z]:
                v |= 1 << (64 * k + z)
    return format(v, "x")


if __name__ == "__main__":
    D = pickle.load(open(os.path.join(here, "base12.pkl"), "rb"))
    base, Bs = D["base"], D["B"]
    ind, ker = elim_comb([pack(B) for B in Bs])
    Bb = [Bs[i.bit_length() - 1] for i in ind]
    ZP = [(1 << i) | (1 << j) for i, j in __import__("itertools").combinations(range(6), 2)]
    tops = np.array([[mobius(B[k], 6)[ZP] for k in range(15)] for B in Bb], dtype=np.uint8)
    ti, tk = elim_comb([pack(t) for t in tops])
    topi = [i.bit_length() - 1 for i in ti]
    lows = [[j for j in range(len(Bb)) if k >> j & 1] for k in tk]
    vivos = pickle.load(open(sys.argv[1], "rb"))
    out = []
    for code, low in vivos:
        sel = set(topi[i] for i in range(len(topi)) if code >> i & 1)
        for i in range(len(lows)):
            if low >> i & 1:
                sel ^= set(lows[i])
        sel = sorted(sel)
        B = np.bitwise_xor.reduce([Bb[j] for j in sel], axis=0) if sel else np.zeros((15, 64), np.uint8)
        out.append(hexB(B))
    open(os.path.join(here, "polares_L5.txt"), "w").write("\n".join(out) + "\n")
    W = json.load(open(sys.argv[2]))
    bent = []
    for w in W:
        t = np.zeros(4096, dtype=np.uint8)
        for m in w["anf_supports"]:
            t ^= ((X & m) == m).astype(np.uint8)
        bent.append(hexB(polar(t)[0]))
    open(os.path.join(here, "polares_bent.txt"), "w").write("\n".join(bent) + "\n")
    print(len(out), "L5 polars;", len(bent), "witness polars (", len(set(bent)), "distinct )")
