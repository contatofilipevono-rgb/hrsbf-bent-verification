"""Probe: on A_k (H4) of a class, which rho/label data depend on x24 as affine functions?"""
import sys, json
from pathlib import Path
from collections import Counter
sys.path.insert(0, str(Path(__file__).parent))
import plane_cert as PC
M = PC.Model(sys.argv[1]); k = int(sys.argv[2])
base, dirs = PC.space_for(M, k, "H4")
def mapping_of(code):
    m = 0
    for i in range(33):
        if code >> i & 1:
            m ^= M.basis[i]
    return m
def rep(t): return t ^ (15 if t & 8 else 0)
def dd(z): return (z & 7) ^ (z >> 3)
def sw(z): return (z >> 3) | ((z & 7) << 3)
def zof(y, d): return y | ((y ^ d) << 3)
L0 = M.labels(mapping_of(base))[:64]
D = [[a ^ b for a, b in zip(M.labels(mapping_of(base ^ d))[:64], L0)] for d in dirs]
x24 = [(d >> 24) & 1 for d in dirs]
print("dim", len(dirs), "x24 at base", (base >> 24) & 1, "directions with x24=1:", sum(x24))
# change basis: one direction p with x24=1, others made x24-free
p = x24.index(1)
Dp = D[p]
others = [[a ^ b for a, b in zip(D[i], Dp)] if x24[i] else D[i] for i in range(len(dirs)) if i != p]
base_lab = L0 if not (base >> 24) & 1 else [a ^ b for a, b in zip(L0, Dp)]   # labels at a point with x24=0
print("effect of x24 (labels toggled by the x24 direction, modulo x24-free directions):")
# which points z does x24 change, and is it determined modulo others? report Dp restricted
print(" Dp nonzero points:", Counter(dd(z) for z in range(64) if Dp[z]), "values", Counter(Dp[z] for z in range(64) if Dp[z]))
# diagonal row d=0: rho, label as affine in code
diag = [zof(y, 0) for y in range(8)]
print(" diagonal points:", diag)
print(" base labels on diagonal (x24=0):", [base_lab[z] for z in diag])
print(" x24 toggles on diagonal:", [Dp[z] for z in diag])
print(" x24-free directions toggling the diagonal:", sum(1 for o in others if any(o[z] for z in diag)))
for o in others:
    if any(o[z] for z in diag): print("   ", [o[z] for z in diag])
# chi = label(z) ^ label(swap z) (in units of 1111) as affine function
def chi(lab): return [lab[z] ^ lab[sw(z)] for z in range(64)]
print(" chi at x24=0 base by row:", {d: Counter(chi(base_lab)[z] for z in range(64) if dd(z) == d) for d in range(8)})
print(" chi change by x24:", {d: Counter(chi(Dp)[z] for z in range(64) if dd(z) == d) for d in range(8)})
print(" chi change by x24-free directions (rows touched):", Counter(tuple(sorted({dd(z) for z in range(64) if chi(o)[z]})) for o in others))
