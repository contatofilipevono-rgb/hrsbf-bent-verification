"""Which (Pf4) quadrics kill the 3088 case-C polars left by the hand conditions?  Greedy cover, and the affine
structure of what each chosen quadric leaves."""
import sys, os, json, collections, io, contextlib
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
with contextlib.redirect_stdout(io.StringIO()):
    import pf4_quadricas as P
from bc_comum import NAMES

here = os.path.dirname(os.path.abspath(__file__))
pol = json.load(open(os.path.join(here, "caso_c_mao_sobrev.json")))["polars"]
quads = sorted(set(P.quads.values()) - {frozenset()}, key=lambda q: (len(q), P.show(q)))


def ev(q, code):
    s = 0
    for m in q:
        v = 1
        for c in m:
            v &= code >> c & 1
        s ^= v
    return s


kill = {i: {c for c in pol if ev(q, c)} for i, q in enumerate(quads)}
left = set(pol); chosen = []
while left:
    i = max(kill, key=lambda i: len(kill[i] & left))
    if not kill[i] & left:
        break
    chosen.append((i, len(kill[i] & left)))
    left -= kill[i]
print("polars:", len(pol), " killed by all of (Pf4):", len(set(pol) - left), " left:", len(left))
print("greedy cover size:", len(chosen))
for i, n in chosen:
    print("  kills %4d : %s = 0" % (n, P.show(quads[i])))
# how many quadrics are individually useless / single best
print("best single quadric kills", max(len(v) for v in kill.values()))
