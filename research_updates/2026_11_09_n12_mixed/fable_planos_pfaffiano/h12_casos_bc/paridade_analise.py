"""Show the quadratic parity polynomials (d = 9, 63) and which d is odd on the Pf4 polars of each case/(alpha,beta)."""
import sys, os, json, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from bc_comum import NAMES
from oito_parametros_lib import params

here = os.path.dirname(os.path.abspath(__file__))
J = json.load(open(os.path.join(here, "paridade_anf.json")))
reps = J["reps"]
tab = np.load(os.path.join(here, "paridade_tab.npy"))


def show(mons):
    terms = []
    for m in sorted(mons, key=lambda m: (bin(m).count("1"), m)):
        if m == 0:
            terms.append("1")
        else:
            terms.append("*".join(NAMES[k] for k in range(21) if m >> k & 1))
    return " + ".join(terms)


for d in (9, 63):
    print("P(d=%d) =" % d, show(J["anf"][str(d)]))
homog = json.load(open(os.path.join(here, "homog1176.json")))
CASE = {(0, 0, 0): "A", (1, 1, 0): "B", (1, 0, 1): "C"}
stat = collections.defaultdict(collections.Counter)
for c in homog:
    k = params(c)
    case = CASE[k[:3]]
    code = sum(int(c[i]) << i for i in range(21))
    odd = tuple(d for i, d in enumerate(reps) if tab[i][code])
    stat[(case, k[3:5])][odd] += 1
for key in sorted(stat):
    print(key, dict(stat[key]))
