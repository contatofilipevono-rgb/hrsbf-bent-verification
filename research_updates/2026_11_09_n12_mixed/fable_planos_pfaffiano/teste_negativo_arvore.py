"""Negative tests of verifica_arvore: tampered certificates must be rejected."""
import os, sys, json, copy, random
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from bitj import load_model
from poisson3_lista import todos_subespacos3
from cert_arvore import polar_data
from verifica_arvore import Polar, check_node

recs = json.load(open(sys.argv[1]))
model = load_model(); Vs = todos_subespacos3()
rng = random.Random(7)


def all_nodes(n, acc):
    acc.append(n)
    for k in n.get("kids", []):
        all_nodes(k, acc)
    return acc


def run(r, cert):
    T0, K = polar_data(r["polar"], model, Vs)
    P = Polar(T0, K)
    return check_node(P, cert, np.zeros(P.m, np.int64), np.eye(P.m, dtype=np.int64), {})


rejected = 0; trials = 0
for r in recs:
    for t in range(4):
        c = copy.deepcopy(r["cert"])
        nodes = all_nodes(c, [])
        lv = [n for n in nodes if "leaf" in n]
        n = rng.choice(lv)
        kind = t % 4
        if kind == 0 and n["refs"]:              # leaf: replace one direction by another
            i = rng.randrange(len(n["refs"]))
            n["refs"][i] = ["S", (n["refs"][i][1] % 63) + 1]
        elif kind == 1 and len(n["refs"]) > 1:   # leaf: drop one reference
            n["refs"].pop(rng.randrange(len(n["refs"])))
        elif kind == 2:                           # leaf: drop all steps leading to it and its refs but one
            n["refs"] = n["refs"][:1]; n["leaf"] = "const"
        else:                                     # claim the whole space dies at the root with the first leaf's refs
            c = {"steps": [], "leaf": lv[0]["leaf"], "refs": lv[0]["refs"]}
            if c == r["cert"]:
                continue
        if c == r["cert"]:
            continue                              # the tampering changed nothing
        trials += 1
        ok = run(r, c)
        rejected += not ok
        print(r["polar"][:12], "tamper", kind, "->", "accepted" if ok else "rejected", flush=True)
print("tampered:", trials, "rejected:", rejected)
