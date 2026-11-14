"""Class 164, cell 0: Z_[0] = pi0^{-1}(S) by rows; e(z) = psi^{-1}(pi0(z)) on Z_[0] as affine
function of the cell parameters (psi: d -> derivative value on row d)."""
import sys, json
from pathlib import Path
from collections import Counter
sys.path.insert(0, str(Path(__file__).parent))
import plane_cert as PC
import short_certs as SC
M = PC.Model(sys.argv[1]); K = int(sys.argv[2]) if len(sys.argv) > 2 else 164
want = int(sys.argv[3]) if len(sys.argv) > 3 else 0
def mapping_of(c):
    m = 0
    for i in range(33):
        if c >> i & 1:
            m ^= M.basis[i]
    return m
def dd(z): return (z & 7) ^ (z >> 3)
def sw(z): return (z >> 3) | ((z & 7) << 3)
cells = list(SC.cells_of(M, K))
code, rker, info = cells[want]
lab = M.labels(mapping_of(code))
D1 = [lab[z + 64] ^ lab[z] for z in range(64)]; D2 = [lab[z + 128] ^ lab[z] for z in range(64)]
psi = {}
for z in range(64):
    d = dd(z); v = D1[z] or D2[z]
    if v: psi[d] = v
psi[0] = 0
psi[7] = psi[1] ^ psi[2] ^ psi[4]
assert all(psi[a ^ b] == psi[a] ^ psi[b] for a in range(8) for b in range(8)), "psi linear"
inv = {v: d for d, v in psi.items()}
print("psi:", psi)
S = set(psi.values())
Z0 = [z for z in range(64) if lab[z] in S]
print("Z_[0] rows:", dict(Counter(dd(z) for z in Z0)), "size", len(Z0))
e0 = {z: inv[lab[z]] for z in Z0}
E = []
for v in rker:
    L2 = M.labels(mapping_of(code ^ v))
    assert all(L2[z] in S for z in Z0)
    E.append({z: inv[L2[z] ^ lab[z]] for z in Z0})
for d in range(8):
    zs = [z for z in Z0 if dd(z) == d]
    if not zs: continue
    print(f" row {d}: points y={[z & 7 for z in zs]}")
    print(f"   e at base: {[e0[z] for z in zs]}")
    for i, ed in enumerate(E):
        if any(ed[z] for z in zs):
            print(f"   dir {i}: {[ed[z] for z in zs]}")
