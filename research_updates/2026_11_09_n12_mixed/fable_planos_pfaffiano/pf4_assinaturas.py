"""(Pf4) tops by plane signature (a, b) and Gamma-orbits of tops; check gamma_2(T) = 0 <=> the 15 coordinate quads."""
import os, sys, json, itertools, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from base12 import forma, pack, mobius
from testemunhas12 import BA, BB, coords
from pf4_estrutura import top_of

here = os.path.dirname(os.path.abspath(__file__))
hexes = open(os.path.join(here, "polares_18816.txt")).read().split()
sig_tops = collections.defaultdict(set); top_sig = {}
for hx in hexes:
    val = int(hx, 16)
    B = np.array([[(val >> (64 * a + z)) & 1 for z in range(64)] for a in range(15)], dtype=np.uint8)
    a = "".join(map(str, coords(forma(B, 27, 54), BA))); b = "".join(map(str, coords(forma(B, 21, 42), BB)))
    t = pack(top_of(B))
    sig_tops[(a, b)].add(t)
    top_sig.setdefault(t, set()).add((a, b))
print("signatures (a, b) present:", len(sig_tops))
print("tops per signature:", sorted(collections.Counter(len(v) for v in sig_tops.values()).items()))
print("does a top determine the signature?", all(len(s) == 1 for s in top_sig.values()))
za = collections.Counter();
for (a, b), v in sig_tops.items():
    za[("a=0" if a == "000" else "a!=0", "b=0" if b == "000" else "b!=0")] += len(v)
print("tops by (a zero?, b zero?):", dict(za))
for (a, b), v in sorted(sig_tops.items()):
    print("  a", a, "b", b, "tops", len(v))
# Gamma orbits of tops (from the polar orbits)
orbs = json.load(open(os.path.join(here, "estr_out", "orbitas_18816.json")))
parent = {}
def find(x):
    while parent.get(x, x) != x:
        x = parent[x]
    return x
tp = {}
for hx in hexes:
    val = int(hx, 16)
    B = np.array([[(val >> (64 * a + z)) & 1 for z in range(64)] for a in range(15)], dtype=np.uint8)
    tp[hx] = pack(top_of(B))
for o in orbs:
    ts = [tp[h] for h in o]
    for t in ts[1:]:
        ra, rb = find(ts[0]), find(t)
        if ra != rb:
            parent[rb] = ra
for hx in hexes:                      # polars with the same top are the same top
    pass
roots = collections.Counter(find(t) for t in set(tp.values()))
print("Gamma-orbits of tops:", len(roots), "| sizes:", sorted(collections.Counter(roots.values()).items()))
