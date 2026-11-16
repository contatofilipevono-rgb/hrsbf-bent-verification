"""Which (V, J) of (Pf4) give the quadrics u40*u42, u30+u40+u30*u42, u30+u40+u42 and Y+alpha+beta+u42*(p+r)."""
import sys, os, itertools, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import pf4_quadricas as P   # recomputes (prints its summary)

targets = {"u40*u42", "u30 + u40 + u30*u42", "u30 + u40 + u42",
           "a + d + h + m + p + r + A1 + A2 + A3 + B1 + B3 + u42*p + u42*r"}
seen = collections.defaultdict(list)
for (V, J), q in P.quads.items():
    s = P.show(q)
    if s in targets:
        seen[s].append((V, J))
for s in targets:
    print(s, "<-", seen[s][:8], "... total", len(seen[s]))
