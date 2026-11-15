"""Parity of N_d = #{z : d in rad B_z} over the 18,816 polars, against structural invariants of the polar.

Fourier view: 1_{rad B_z}(d) has Walsh transform |rad| * 1_{rad^perp}; and rad B_z^perp = image of B_z.
So N(d) mod 2 = sum_z 1_{rad B_z}(d) mod 2.  We record, per polar: the set of d != 0 with N_d odd, the rank profile,
the set Z0 of z with rank 0, Z2 with rank 2, and test candidate rules.
Light computation (one process)."""
import os, sys, json, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from base12 import pack
from bitj import load_model
from poisson5 import Bv_table

here = os.path.dirname(os.path.abspath(__file__))
par6 = np.array([bin(i).count("1") & 1 for i in range(64)])

Bb, Gb, Gk, piv = load_model()
hexes = open(os.path.join(here, "polares_18816.txt")).read().split()
rows = []
for hx in hexes:
    val = int(hx, 16)
    B = np.array([[(val >> (64 * a + z)) & 1 for z in range(64)] for a in range(15)], dtype=np.uint8)
    Bv = Bv_table(B)                                   # Bv[z, v] = B_z v as a 6-bit mask
    rad = (Bv == 0)                                    # rad[z, d] : d in rad B_z
    N = rad.sum(axis=0)                                # N[d]
    rk = 6 - np.log2(rad.sum(axis=1)).round().astype(int)
    odd = [int(d) for d in range(1, 64) if N[d] % 2]
    Z0 = [int(z) for z in range(64) if rk[z] == 0]
    Z2 = [int(z) for z in range(64) if rk[z] == 2]
    rows.append({"polar": hx, "odd": odd, "rank_counts": [int((rk == r).sum()) for r in (0, 2, 4)], "Z0": Z0, "Z2": Z2,
                 "N": [int(x) for x in N]})
json.dump(rows, open(os.path.join(here, "paridade_radicais.json"), "w"))
c_odd = sum(1 for r in rows if r["odd"])
print("polars with some N_d odd:", c_odd, "of", len(rows))
prof = collections.Counter((tuple(r["rank_counts"]), bool(r["odd"])) for r in rows)
print("(rank counts 0/2/4, some odd) :")
for k, v in sorted(prof.items()):
    print("  ", k, v)
# candidate: N_d mod 2 equals (number of rank-0 z) + (number of rank-2 z with d in rad) ... test: the rank-4 z
# contribute 1_{rad}(d) with |rad| = 4; rank-2: |rad| = 16; rank-0: everything.
def rule(r):
    return None
