"""Is the 8-row test a function of (case, alpha, beta, x1=a+d, x2=a+h, y1=b+e, y2=b+n, v1=c+g, v2=c+k)?
alpha = p + A2 + B1 + B2 ; beta = r + A1 + A3 + B2 + B3.  Runs over all 2^21 homogeneous polars (cheap: one
representative per 8-row key) and over the 1176 (Pf4) polars.
Usage: python -I oito_parametros.py REPO_DIR"""
import sys, os, json, collections, itertools
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from bc_comum import *

REPO = sys.argv[1]
N = {s: i for i, s in enumerate(NAMES)}


def params(c):
    v = {s: int(c[N[s]]) for s in NAMES}
    al = (v["p"] + v["A2"] + v["B1"] + v["B2"]) & 1
    be = (v["r"] + v["A1"] + v["A3"] + v["B2"] + v["B3"]) & 1
    x1 = (v["a"] + v["d"]) & 1; x2 = (v["a"] + v["h"]) & 1
    y1 = (v["b"] + v["e"]) & 1; y2 = (v["b"] + v["n"]) & 1
    w1 = (v["c"] + v["g"]) & 1; w2 = (v["c"] + v["k"]) & 1
    return (v["u30"], v["u40"], v["u42"], al, be, x1, x2, y1, y2, w1, w2)


# check on random codes that pass8 / max8 depend only on params
import random
random.seed(3)
table = {}
bad = 0
for it in range(6000):
    c = "".join(random.choice("01") for _ in range(21))
    k = params(c)
    t = t_from_coords(c)
    ok, m = pass8(ftab_zw(t))
    R = spectrum_rows(ftab_zw(t))
    prof = tuple(sorted(tuple(int(abs(R[z, b])) for z in ROWS8) for b in range(64)))
    if k in table and table[k] != (ok, m, prof):
        bad += 1
    table.setdefault(k, (ok, m, prof))
print("random codes:", 6000, "distinct keys:", len(table), "inconsistent:", bad)
# full table over all 2^11 keys: build a code for each key
full = {}
for k in itertools.product((0, 1), repeat=11):
    u30, u40, u42, al, be, x1, x2, y1, y2, w1, w2 = k
    v = dict.fromkeys(NAMES, 0)
    v["u30"], v["u40"], v["u42"] = u30, u40, u42
    v["d"], v["h"] = x1, x2          # a = 0
    v["e"], v["n"] = y1, y2          # b = 0
    v["g"], v["k"] = w1, w2          # c = 0
    v["p"] = al; v["r"] = be
    c = "".join(str(v[s]) for s in NAMES)
    assert params(c) == k
    ok, m = pass8(ftab_zw(t_from_coords(c)))
    full[k] = (ok, m)
for case, key in (("A", (0, 0, 0)), ("B", (1, 1, 0)), ("C", (1, 0, 1))):
    ks = [k for k in full if k[:3] == key]
    print("case", case, ": keys passing 8 rows", sum(full[k][0] for k in ks), "of", len(ks))
    for ab in itertools.product((0, 1), repeat=2):
        kk = [k for k in ks if k[3:5] == ab]
        print("   (alpha,beta)=", ab, " pass:", sum(full[k][0] for k in kk), "of", len(kk))
json.dump({"".join(map(str, k)): v for k, v in full.items()}, open(os.path.join(os.path.dirname(os.path.abspath(__file__)), "oito_tabela.json"), "w"))
