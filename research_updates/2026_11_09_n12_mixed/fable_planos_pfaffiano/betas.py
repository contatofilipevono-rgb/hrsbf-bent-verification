# Os espacos de beta_a = B_z(27,54) e beta_b = B_z(21,42): ANF nas funcoes RS de z, e perfis de posto de B_z.
import os, pickle
from collections import Counter
import numpy as np
from base12 import forma, mobius, elim_comb, pack, PAIRS

here = os.path.dirname(os.path.abspath(__file__))
D = pickle.load(open(os.path.join(here, "base12.pkl"), "rb"))
Bs = D["B"]


def anf_txt(v):
    c = mobius(v, 6)
    return " + ".join("".join("z%d" % t for t in range(6) if m >> t & 1) or "1" for m in np.flatnonzero(c)) or "0"


for nome, (u, v) in (("beta_a", (27, 54)), ("beta_b", (21, 42))):
    vs = [forma(B, u, v) for B in Bs]
    ind, _ = elim_comb([pack(x) for x in vs])
    print(nome, ": base")
    for i in ind:
        x = vs[i.bit_length() - 1]
        print("   peso", int(x.sum()), "|", anf_txt(x))
