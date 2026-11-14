"""(a) The 25 low directions do not change the derivative pair: labels over (z, s) differ by a constant in s.
(b) Over all 32 charts of CL3 and all z: the four labels over z never take 4 distinct values
    (so the multiplicities are 4 or 2+2 and |P_t| = 4B exactly) -- exhaustive, since (D1, D2) depend only on the chart.
(c) H4 = A_k implies u1 = 1, and H2 implies H(u) = c4, in the 14 catalog classes (own Gauss check)."""
import sys
REPO = sys.argv[1]
sys.path.insert(0, REPO); sys.path.insert(0, REPO + "/phase_plane")
from dim4_support_decode import decode
from higher_filter import xor_terms
import plane_cert as PC

model, basis, labels = decode(1)
for j in range(25):
    labs = labels(basis[j])
    assert all(labs[z] == labs[z + 64 * s] for z in range(64) for s in range(4)), j
print("(a) low directions: constant in s  OK")
cl3 = [c for c in range(256) if all(bin(c & p).count("1") % 2 == 0 for p in (26, 60, 64))]
worst = 0
for c in cl3:
    labs = labels(xor_terms(basis, c << 25))
    for z in range(64):
        vals = [labs[z + 64 * s] for s in range(4)]
        assert vals[0] ^ vals[1] ^ vals[2] ^ vals[3] == 0
        worst = max(worst, len(set(vals)))
print("(b) max number of distinct labels over a z in CL3:", worst)

M = PC.Model(REPO)
H = (11, 13, 16, 19, 22, 23, 24)
def affine_hull_satisfies(base, dirs, mask, rhs):
    lin = lambda v: bin(v & mask).count("1") & 1
    return lin(base) == rhs and all(lin(d) == 0 for d in dirs)
for k in (0, 1, 22, 23, 36, 37, 50, 51, 128, 129, 164, 165, 178, 179):
    c4 = (k >> 4) & 1
    b2, d2 = PC.space_for(M, k, "H2"); b4, d4 = PC.space_for(M, k, "H4")
    hm = sum(1 << v for v in H)
    r = (affine_hull_satisfies(b2, d2, hm, c4), affine_hull_satisfies(b4, d4, 1 << 1, 1),
         affine_hull_satisfies(b2, d2, 1 << 1, 1), len(d2), len(d4))
    print(f"class {k:3d}: H2 => H=c4 {r[0]},  H4 => u1=1 {r[1]},  (H2 => u1=1? {r[2]}),  dim H2 {r[3]}, dim H4 {r[4]}")
