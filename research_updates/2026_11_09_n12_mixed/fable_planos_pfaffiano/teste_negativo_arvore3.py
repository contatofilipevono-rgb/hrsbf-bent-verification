"""Negative tests of verifica_arvore3: tampered certificates (inheritance format) must be rejected."""
import os, sys, json, copy, random
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from bitj import load_model
from poisson3_lista import todos_subespacos3
from cert_arvore import polar_data
from verifica_arvore import Polar
from verifica_arvore3 import Checker

recs = [r for r in json.load(open(sys.argv[1])) if r["status"] == "certified"]
model = load_model(); Vs = todos_subespacos3()
rng = random.Random(11)


def nodes(n, acc):
    acc.append(n)
    for k in n.get("kids", []):
        nodes(k, acc)
    return acc


def run(r, cert):
    T0, K = polar_data(r["polar"], model, Vs)
    P = Polar(T0, K)
    try:
        return Checker(P).node(cert, np.zeros(P.m, np.int64), np.eye(P.m, dtype=np.int64), {})
    except Exception:
        return False


trials = rejected = 0
for r in recs:
    for kind in range(4):
        c = copy.deepcopy(r["cert"])
        lv = [n for n in nodes(c, []) if "leaf" in n and n.get("use")]
        if not lv:
            continue
        n = rng.choice(lv)
        if kind == 0:                                     # another direction / sum in one reference
            u = n["use"][rng.randrange(len(n["use"]))]
            if u[1][0] == "S":
                u[1] = ["S", u[1][1] % 63 + 1]
            elif u[1][0] == "W":
                u[1] = ["W", u[1][1], (u[1][2] + 1) % 64]
            else:
                u[1] = u[1][:3] + [(u[1][3] + 1) % 64] + u[1][4:]
        elif kind == 1 and len(n["use"]) > 1:            # drop one reference of a leaf
            n["use"].pop(rng.randrange(len(n["use"])))
        elif kind == 2:                                   # claim 'const' with the first reference
            n["leaf"] = "const"; n["use"] = n["use"][-1:]
        else:                                             # point a reference to an event of another branch
            evs = [a["id"] for m in nodes(c, []) for a in m["actions"] if "compute" in a]
            u = n["use"][0]
            others = [e for e in evs if e != u[0]]
            if not others:
                continue
            u[0] = rng.choice(others)
        if c == r["cert"]:
            continue
        trials += 1
        ok = run(r, c)
        rejected += not ok
        print(r["polar"][:12], "tamper", kind, "->", "accepted" if ok else "rejected", flush=True)
print("tampered:", trials, "rejected:", rejected)
