from bc_comum import NAMES

N = {s: i for i, s in enumerate(NAMES)}


def params(c):
    v = {s: int(c[N[s]]) for s in NAMES}
    al = (v["p"] + v["A2"] + v["B1"] + v["B2"]) & 1
    be = (v["r"] + v["A1"] + v["A3"] + v["B2"] + v["B3"]) & 1
    x1 = (v["a"] + v["d"]) & 1; x2 = (v["a"] + v["h"]) & 1
    y1 = (v["b"] + v["e"]) & 1; y2 = (v["b"] + v["n"]) & 1
    w1 = (v["c"] + v["g"]) & 1; w2 = (v["c"] + v["k"]) & 1
    return (v["u30"], v["u40"], v["u42"], al, be, x1, x2, y1, y2, w1, w2)
