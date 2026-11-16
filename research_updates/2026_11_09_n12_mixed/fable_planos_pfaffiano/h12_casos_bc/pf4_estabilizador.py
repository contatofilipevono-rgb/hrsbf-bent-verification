"""Pattern test: is a (Pf4) quadric 'simple' exactly when its index (V, J) is fixed by R^3 (i -> i+3 on both)?
Also: same test for the parity polynomials P(d) (stabilizer of d) - already known: d in {9, 27, 63} quadratic/zero."""
import sys, os, itertools, collections, io, contextlib
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
with contextlib.redirect_stdout(io.StringIO()):
    import pf4_quadricas as P

rot = lambda S, k: tuple(sorted((i + k) % 6 for i in S))
rows = collections.defaultdict(list)
for (V, J), q in P.quads.items():
    stab = [k for k in range(6) if rot(V, k) == tuple(V) and rot(J, k) == tuple(J)]
    order = len(stab)
    has3 = 3 in stab
    nm = len(q)
    deg = max((len(m) for m in q), default=-1)
    rows[(order, has3)].append((nm, deg, V, J))
for key in sorted(rows):
    L = rows[key]
    print("stabilizer order %d, contains R^3: %s -> %d pairs; #monomials %s; max degree %s" % (
        key[0], key[1], len(L), sorted(collections.Counter(x[0] for x in L).items()),
        sorted(collections.Counter(x[1] for x in L).items())))
# the simple ones that are NOT R^3-fixed
print("simple (<= 3 monomials) with stabilizer not containing R^3:")
for key in rows:
    if not key[1]:
        for nm, deg, V, J in rows[key]:
            if nm <= 3:
                print("   V", V, "J", J, "#mon", nm, P.show(P.quads[(V, J)]))
