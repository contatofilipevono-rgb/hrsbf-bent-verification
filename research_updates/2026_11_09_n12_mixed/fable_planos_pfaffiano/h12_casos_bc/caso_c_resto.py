"""Structure of the 3088 case-C survivors of the hand conditions, and the 12 that pass all of (Pf4)."""
import sys, os, json, collections, io, contextlib
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
with contextlib.redirect_stdout(io.StringIO()):
    import pf4_quadricas as P
from bc_comum import *

here = os.path.dirname(os.path.abspath(__file__))
pol = json.load(open(os.path.join(here, "caso_c_mao_sobrev.json")))["polars"]
par = np.load(os.path.join(here, "paridade_tab.npy"))
reps = json.load(open(os.path.join(here, "paridade_anf.json")))["reps"]
quads = set(P.quads.values()) - {frozenset()}
ev = lambda q, c: sum(all(c >> x & 1 for x in m) for m in q) & 1
rest = [c for c in pol if not any(ev(q, c) for q in quads)]
print("survive all (Pf4):", len(rest))
for c in rest:
    odd = [d for i, d in enumerate(reps) if par[i][c]]
    print("  ", "".join(str(c >> i & 1) for i in range(21)), "odd N_d for d in", odd)


def hull(vs):
    b = vs[0]; pv = {}
    for v in vs:
        x = v ^ b
        while x:
            h = x.bit_length() - 1
            if h in pv: x ^= pv[h]
            else: pv[h] = x; break
    return len(pv)


print("affine hull dim of the 3088:", hull(pol), "(log2 3088 = %.2f)" % np.log2(len(pol)))
# split by row-e0 key and by Pf4-linear coordinates: are the fibres affine?
N = {s: i for i, s in enumerate(NAMES)}
def key(c):
    g = lambda s: c >> N[s] & 1
    return ((g("a") + g("d")) & 1, (g("a") + g("h")) & 1, (g("b") + g("e")) & 1, (g("b") + g("n")) & 1, (g("c") + g("g")) & 1, (g("c") + g("k")) & 1)
by = collections.defaultdict(list)
for c in pol: by[key(c)].append(c)
aff = sum(1 for v in by.values() if 2 ** hull(v) == len(v))
print("row-e0 keys:", len(by), " fibres that are affine subspaces:", aff, " sizes:", sorted(collections.Counter(len(v) for v in by.values()).items()))
