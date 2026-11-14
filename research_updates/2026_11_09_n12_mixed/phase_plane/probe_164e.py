"""Class 164: on the hyperplane x24 = 1 of A_164, test the rotation identity
   e(zeta z) == rot(e(z)) (exactly, or modulo <rot d>) for z in Z_[0] off the diagonal,
where e(z) = psi^{-1}(pi0(z) mod the rho-part) is only defined inside a cell.  Instead test the
label-level identity on S-components: pi0(zeta z) + A pi0(z) in a fixed set, per code."""
import sys
from pathlib import Path
from collections import Counter
sys.path.insert(0, str(Path(__file__).parent))
import plane_cert as PC
import short_certs as SC
M = PC.Model(sys.argv[1]); K = int(sys.argv[2]) if len(sys.argv) > 2 else 164
def mapping_of(c):
    m = 0
    for i in range(33):
        if c >> i & 1:
            m ^= M.basis[i]
    return m
def dd(z): return (z & 7) ^ (z >> 3)
def rot3(v): return ((v << 1) | (v >> 2)) & 7
def zeta(z): return rot3(z & 7) | (rot3(z >> 3) << 3)
psi = {0: 0, 1: 2, 2: 4, 4: 9}
for a in range(8):
    psi[a] = (psi[1] if a & 1 else 0) ^ (psi[2] if a & 2 else 0) ^ (psi[4] if a & 4 else 0)
inv = {v: d for d, v in psi.items()}
S = set(psi.values())
# candidate label map A: the linear map on F2^4 with A psi(d) = psi(rot d) on S, and A on a complement?
stat = Counter()
for idx, (code, rker, info) in enumerate(SC.cells_of(M, K)):
    for kk in range(0, 1 << len(rker), 97):          # sample of points of the cell
        cc = code
        for i, v in enumerate(rker):
            if kk >> i & 1:
                cc ^= v
        lab = M.labels(mapping_of(cc))
        Z0 = [z for z in range(64) if lab[z] in S]
        ok_exact = ok_mod = True
        for z in Z0:
            d = dd(z)
            if d in (0, 7):
                continue
            z2 = zeta(z)
            if lab[z2] not in S:
                ok_exact = ok_mod = False; break
            e1, e2 = inv[lab[z]], inv[lab[z2]]
            if e2 != rot3(e1):
                ok_exact = False
            if e2 not in (rot3(e1), rot3(e1) ^ rot3(d)):
                ok_mod = False
        stat[(idx, ok_exact, ok_mod)] += 1
for k_, v in sorted(stat.items()): print("(cell, e(zeta z)=rot e(z), same mod <rot d>):", k_, v)
