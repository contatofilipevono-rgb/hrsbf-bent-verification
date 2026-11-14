"""For the surviving rho-cells (x24 = 1) of a class: where is Z_[0] and what is chi on it?"""
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
rw = lambda lab: tuple(rep(x) for x in lab)
piv = {}; rch = []; rker = []
for d, dl in zip(d1, DL):
    x = sum(rep(v) << (3 * z) for z, v in enumerate(dl)); vv = dl
    while x and (x.bit_length() - 1) in piv:
        px, pv = piv[x.bit_length() - 1]; x ^= px; vv = [a ^ b for a, b in zip(vv, pv)]
    if x:
        piv[x.bit_length() - 1] = (x, vv); rch.append((x, vv))
    else:
        rker.append(vv)
print("rho dim", len(rch), "cell dim", len(rker))
print("cell directions change chi?", [any((v[z] ^ v[sw(z)]) for z in range(64)) for v in rker])
A = {2, 4}; B = {1, 4}; Ms = {1, 2, 4}
stat = Counter(); rowsZ0 = Counter(); chiZ0 = Counter()
for sel in range(1 << len(rch)):
    lab = list(lab0)
    for i, (_, v) in enumerate(rch):
        if sel >> i & 1:
            lab = [a ^ b for a, b in zip(lab, v)]
    rho = [rep(x) for x in lab]
    Z = [[z for z in range(64) if rho[z] == t] for t in range(8)]
    if any(len(s) != 8 for s in Z):
        continue
    ok = True
    for s in Z:
        for S in (A, B):
            pts = [z for z in s if dd(z) in S]; acc = 0
            for z in pts: acc ^= z
            if len(pts) % 2 or acc: ok = False
        if sum(dd(z) in Ms for z in s) % 2: ok = False
    if not ok:
        continue
    Z0 = Z[0]
    rowsZ0[tuple(sorted(Counter(dd(z) for z in Z0).items()))] += 1
    chiZ0[tuple(sorted(Counter((dd(z), (lab[z] ^ lab[sw(z)]) >> 3) for z in Z0 if dd(z)).items()))] += 1
    stat["cells"] += 1
    stat[("diag", tuple(sorted(z for z in Z0 if dd(z) == 0)), tuple(lab[z] for z in sorted(Z0) if dd(z) == 0))] += 1
print(dict(stat))
print("rows of Z_[0]:", dict(rowsZ0))
print("(row, chi) on Z_[0] off-diagonal:", dict(chiZ0))
