"""Is chi(z) an affine function of rho(z) at each point (identity on the whole A_k)?
chi(z) = [pi0(z) != pi0(swap z)], rho = pi0 mod 1111.  Both are affine in the code."""
import sys
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
pts = [base] + [base ^ d for d in dirs]
labs = [M.labels(mapping_of(c))[:64] for c in pts]
n = len(dirs)
def func(f):  # affine functional of a per-code bit: (vector over n dirs, constant)
    v0 = f(labs[0])
    return sum((f(labs[i + 1]) ^ v0) << i for i in range(n)), v0
res = Counter(); formula = {}
for z in range(64):
    if dd(z) == 0:
        continue
    chi = func(lambda L: ((L[z] ^ L[sw(z)]) >> 3) & 1)
    rb = [func(lambda L, b=b: (rep(L[z]) >> b) & 1) for b in range(3)]
    found = None
    for alpha in range(8):
        for c in (0, 1):
            v = 0; cc = c
            for b in range(3):
                if alpha >> b & 1:
                    v ^= rb[b][0]; cc ^= rb[b][1]
            if v == chi[0] and cc == chi[1]:
                found = (alpha, c)
    res[(dd(z), found is not None)] += 1
    if found:
        formula.setdefault(dd(z), Counter())[found] += 1
print("per row: chi affine in rho(z)?", dict(res))
print("formulas chi = alpha.rho + c per row:", {d: dict(c) for d, c in formula.items()})
