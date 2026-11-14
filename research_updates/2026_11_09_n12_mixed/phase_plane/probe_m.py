"""Class k, hyperplane x24 = 1: over all rho values, how do the filters control Z_[0] ∩ M,
and what is the s1s2 moment of fibre 0 (formula: diagonal + sum of chi over swap orbits)?"""
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
lin = [(d >> 24) & 1 for d in dirs]; p = lin.index(1)
b1 = base if (base >> 24) & 1 else base ^ dirs[p]
d1 = [d ^ dirs[p] if lin[i] else d for i, d in enumerate(dirs) if i != p]
lab0 = M.labels(mapping_of(b1))[:64]
DL = [[a ^ b for a, b in zip(M.labels(mapping_of(b1 ^ d))[:64], lab0)] for d in d1]
piv = {}; rch = []
for dl in DL:
    x = sum(rep(v) << (3 * z) for z, v in enumerate(dl)); vv = dl
    while x and (x.bit_length() - 1) in piv:
        px, pv = piv[x.bit_length() - 1]; x ^= px; vv = [a ^ b for a, b in zip(vv, pv)]
    if x:
        piv[x.bit_length() - 1] = (x, vv); rch.append((x, vv))
A = {2, 4}; B = {1, 4}; Ms = {1, 2, 4}
ab = {0: 0, 1: 1, 2: 1, 4: 0, 3: 0, 5: 0, 6: 0, 7: 0}  # a+b per row (a on 2,4; b on 1,4)
st = Counter()
for sel in range(1 << len(rch)):
    lab = list(lab0)
    for i, (_, v) in enumerate(rch):
        if sel >> i & 1:
            lab = [a ^ b for a, b in zip(lab, v)]
    rho = [rep(x) for x in lab]
    Z = [[z for z in range(64) if rho[z] == t] for t in range(8)]
    bal = all(len(s) == 8 for s in Z)
    f2 = True
    for s in Z:
        for S in (A, B):
            pts = [z for z in s if dd(z) in S]; acc = 0
            for z in pts: acc ^= z
            if len(pts) % 2 or acc: f2 = False
        if sum(dd(z) in Ms for z in s) % 2: f2 = False
    Z0 = Z[0]
    meetM = any(dd(z) in Ms for z in Z0)
    # s1s2 moment of P_0 = #{z : pi(z,1,1) = 0} mod 2, pi(z,1,1) = pi0(z) + (a+b)(z)*1111
    mom = sum(1 for z in range(64) if (lab[z] ^ (15 if ab[dd(z)] else 0)) == 0) & 1
    st[(bal, f2, meetM, mom)] += 1
print("(balance |Z_t|=8, F2+M-parity, Z_[0] meets M, s1s2 moment of fibre 0): count of rho values")
for key, v in sorted(st.items()): print(key, v)
