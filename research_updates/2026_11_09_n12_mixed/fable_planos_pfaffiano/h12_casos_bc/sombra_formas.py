"""Express Lambda (shadow on weight-3 words) and M (shadow on row 63) via polar coordinates + phase."""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from bc_comum import *

LAM = [1, 2, 3, 4, 5, 8, 9, 10, 12, 13, 15, 16, 17, 19, 21, 22, 23, 24, 26, 28, 29, 31, 32, 33, 38, 39, 40, 41]
M = [7, 25, 34, 36, 37]
names = NAMES + ["L456", "L464"]
piv = {}
for i, g in enumerate(EQ):
    x = g; comb = 1 << i
    while x:
        c = x.bit_length() - 1
        if c in piv: x ^= piv[c][0]; comb ^= piv[c][1]
        else: piv[c] = (x, comb); break
for nm, R in (("Lambda", LAM), ("M", M)):
    x = sum(1 << j for j in R); comb = 0
    while x:
        c = x.bit_length() - 1
        if c in piv: x ^= piv[c][0]; comb ^= piv[c][1]
        else: break
    pol = " + ".join(names[i] for i in range(len(EQ)) if comb >> i & 1)
    res = [j for j in range(43) if x >> j & 1]
    print(nm, "= [polar part]", pol or "0", "+ [phase residual in t]", res)
