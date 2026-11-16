"""Case C: the 4-periodic shadow g(y) = f(x(y)), x(y) = (y0..y3 repeated).  x(y) lies in row z = (s,r,s,r,s,r),
s = y0+y2, r = y1+y3, with w = (y2,y3,y0,y1,y2,y3).  Check by hand-derived claims:
  row 0 part of g = y0*y1 ; row 63 part = constant (c+1) when alpha = beta = 1 ;
and print, as linear forms in t, the values of g on the rows 21 and 42 and on row 63, to state the point-type
conditions g in {[y=1111], [y=1111] + sigma1}."""
import sys, os, random, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from bc_comum import *

def xof(y):
    return sum(((y >> (i % 4)) & 1) << i for i in range(12))

def zw_of(y):
    x = xof(y); a = x & 63; b = x >> 6
    return a ^ b, b

rows = collections.defaultdict(list)
for y in range(16):
    z, w = zw_of(y)
    rows[z].append((y, w))
print("rows of the 4-periodic words:", {z: [format(y, "04b")[::-1] for y, w in v] for z, v in rows.items()})
# value of each orbit sum O_j at x(y)
val = np.array([[int(TT[j][xof(y)]) for y in range(16)] for j in range(43)])
N = {s: i for i, s in enumerate(NAMES)}
random.seed(3)
for _ in range(2000):
    t = [random.getrandbits(1) for _ in range(43)]
    t[37] = sum(t[j] for j in L456 if j != 37) & 1
    t[36] = sum(t[j] for j in L464 if j != 36) & 1
    t[42], t[30], t[40] = 1, 1, 0
    c = coords_of_t(t); v = {s: int(c[N[s]]) for s in NAMES}
    al = (v["p"] + v["A2"] + v["B1"] + v["B2"]) & 1; be = (v["r"] + v["A1"] + v["A3"] + v["B2"] + v["B3"]) & 1
    g = (np.array(t) @ val) % 2
    for y, w in rows[0]:
        assert g[y] == ((y & 1) & (y >> 1 & 1))           # y0*y1
    if al == 1 and be == 1:
        assert len({int(g[y]) for y, w in rows[63]}) == 1
print("claims: row-0 part = y0*y1 and row-63 part constant (alpha = beta = 1): ok")
# linear forms: g(y) for y in rows 21, 42, 63 as sums of t_j
for z in (63, 21, 42):
    for y, w in rows[z]:
        print("z=%2d y=%s : g = %s" % (z, format(y, "04b")[::-1], " + ".join("t%d" % j for j in range(43) if val[j][y]) or "0"))
