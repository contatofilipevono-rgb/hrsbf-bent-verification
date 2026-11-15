"""Radical-parity lemma.  P_B(d) = sum_z 1_{rad B_z}(d) mod 2  (a Boolean function of d in F2^6).
Claims checked on the 18,816 polars:
  (1) deg P_B <= 4 (every B_z has rank <= 4, and 1_{rad B_z} = prod_i (1 + (B_z d)_i) has degree rank(B_z));
  (2) the degree-4 part of P_B is zero for every (Pf4) polar  (it is sum_z gamma_2(B_z), the I = {} Pfaffian sum);
  (3) 'N_d even for every d != 0'  <=>  P_B == 0  (a nonzero function vanishing off 0 has degree 6);
  (4) distribution of deg P_B among the polars with an odd N_d."""
import os, sys, json, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from base12 import mobius

here = os.path.dirname(os.path.abspath(__file__))
POP = np.array([bin(i).count("1") for i in range(64)])
rows = json.load(open(os.path.join(here, "paridade_radicais.json")))
ok1 = ok2 = ok3 = True
degs = collections.Counter()
for r in rows:
    P = (np.array(r["N"]) % 2).astype(np.uint8)
    an = mobius(P.copy(), 6)
    nz = np.nonzero(an)[0]
    deg = int(POP[nz].max()) if len(nz) else -1
    if deg > 4:
        ok1 = False
    if (an[POP == 4] != 0).any():
        ok2 = False
    allEven = not r["odd"]
    if allEven != (deg == -1):
        ok3 = False
    if r["odd"]:
        degs[deg] += 1
print("(1) deg P <= 4 for all:", ok1)
print("(2) degree-4 part of P vanishes for all (Pf4) polars:", ok2)
print("(3) all N_d even  <=>  P == 0:", ok3)
print("(4) degree of P among the polars with an odd N_d:", sorted(degs.items()))
