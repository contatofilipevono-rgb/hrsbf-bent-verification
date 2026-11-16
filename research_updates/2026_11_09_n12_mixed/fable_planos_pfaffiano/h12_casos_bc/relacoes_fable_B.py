"""Are Fable's case-B level-8 relations polar-only?  Express each as (combination of the 21 coordinate forms)
+ (combination of L456, L464) + (pure phase part).  Then test the polar-only part on the B (1,1) survivors."""
import sys, os, json, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from bc_comum import *
from oito_parametros_lib import params

here = os.path.dirname(os.path.abspath(__file__))
rels = {"R1": [0, 5, 7, 8, 10, 19, 26, 27, 31, 34, 36, 37],
        "R2": [4, 5, 8, 9, 10, 19, 22, 26, 29, 31, 34, 36],
        "Y": [10, 31, 16, 20, 19, 26, 14, 35],
        "Cshort": [4, 9, 11, 18, 22, 23, 29, 32]}
gens = EQ  # 21 forms then L456, L464
names = NAMES + ["L456", "L464"]
for nm, R in rels.items():
    v = sum(1 << j for j in R)
    # try to write v as combination of gens
    piv = {}
    for i, g in enumerate(gens):
        x = g; comb = 1 << i
        while x:
            c = x.bit_length() - 1
            if c in piv:
                x ^= piv[c][0]; comb ^= piv[c][1]
            else:
                piv[c] = (x, comb); break
    x = v; comb = 0
    while x:
        c = x.bit_length() - 1
        if c in piv:
            x ^= piv[c][0]; comb ^= piv[c][1]
        else:
            break
    if x == 0:
        print(nm, "polar-only:", " + ".join(names[i] for i in range(len(gens)) if comb >> i & 1))
    else:
        print(nm, "involves the phase (residual nonzero)")
