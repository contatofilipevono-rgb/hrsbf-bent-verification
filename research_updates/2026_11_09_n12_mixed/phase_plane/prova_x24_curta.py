"""Short proof of x24 = 0 in the 14 nonempty V1 classes (fibre 0; fibre 15 as a check).

Notation: code = (k << 25) | u, u in F_2^25 (u_24 = x24), x = z + 64 s (z in F_2^6, s in F_2^2).
The label of x is Lu(z) + C_k(z, s): the 25 low directions do not depend on s (checked), so
Lu is linear in u and constant in s, and C_k depends only on the class k.

E_t := <1_{P_t}, x0 x6> + bit2(|P_t|).  A bent function needs |P_t| = 16 and 1_{P_t} orthogonal to RM(2,8),
so E_t = 0.  We prove, as identities in F_2[u_0..u_24] (all 2^25 values of u at once):

  (1) for every z the four labels over z take 1 or 2 values; if 2, then sw(z) != z, sw(z) also takes
      2 values, and the pair indicators J_z, J_sw(z) coincide (t = 0, 15).  Hence |P_t| = 4B with
      B = sum_{D(z)=0} I_z + sum_{orbits} J_z, and bit2(|P_t|) = B mod 2;
  (2) E_0 = E_15 = (1 + u24)(S(u) + c4) + u1 u24,  S = u11+u13+u16+u19+u22+u23,  c4 = bit 4 of k;
  (3) the affine consequences H4 = A_k (plane_cert.space_for) force u1 = 1.
On A_k with u24 = 1, (2) gives E_0 = u1 = 1: fibre 0 fails its size or its z0 s1 moment.  So x24 = 0 on A_k.
Usage: python prova_x24_curta.py <research_updates/2026_11_09_n12_mixed>"""
import os, sys
from itertools import combinations

REPO = sys.argv[1] if len(sys.argv) > 1 else os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, REPO); sys.path.insert(0, os.path.join(REPO, "phase_plane"))
from dim4_support_decode import decode
from higher_filter import xor_terms
import plane_cert as PC

CLASSES = (0, 1, 22, 23, 36, 37, 50, 51, 128, 129, 164, 165, 178, 179)
S_BITS = (11, 13, 16, 19, 22, 23)
sw = lambda z: (z >> 3) | ((z & 7) << 3)

model, basis, labels = decode(1)
low = [labels(basis[j]) for j in range(25)]
for j in range(25):
    assert all(low[j][z] == low[j][z + 64 * s] for z in range(64) for s in range(4)), j
print("low directions constant in s: OK")

# polynomials in u_0..u_24 of degree <= 4, as Python ints over a monomial index
mons = [()] + [m for d in range(1, 5) for m in combinations(range(25), d)]
idx = {m: i for i, m in enumerate(mons)}
ONE = 1 << idx[()]
var = lambda *v: 1 << idx[tuple(sorted(v))]

def mul_affine(p, lin, const):
    """p * (sum_{v in lin} u_v + const)."""
    out = p if const else 0
    x = p
    while x:
        b = x & -x; m = mons[b.bit_length() - 1]; x ^= b
        for v in lin:
            out ^= 1 << idx[m if v in m else tuple(sorted(m + (v,)))]
    return out

# I[z][a] = [Lu(z) = a]
lin = [[[j for j in range(25) if (low[j][z] >> b) & 1] for b in range(4)] for z in range(64)]
I = [[None] * 16 for _ in range(64)]
for z in range(64):
    for a in range(16):
        p = ONE
        for b in range(4):
            p = mul_affine(p, lin[z][b], 1 ^ ((a >> b) & 1))
        I[z][a] = p

S = 0
for v in S_BITS:
    S ^= var(v)
for k in CLASSES:
    c4 = (k >> 4) & 1
    expected = S ^ (ONE if c4 else 0) ^ mul_affine(S, [24], 0) ^ (var(24) if c4 else 0) ^ var(1, 24)
    C = labels(xor_terms(basis, k << 25))
    vals = [sorted({C[z + 64 * s] for s in range(4)}) for z in range(64)]
    for t in (0, 15):
        B = 0; mom = 0
        for z in range(64):
            assert len(vals[z]) in (1, 2), (k, z)
            if z & 1:
                for s in (1, 3):
                    mom ^= I[z][t ^ C[z + 64 * s]]
            if len(vals[z]) == 1:
                B ^= I[z][t ^ vals[z][0]]
            else:
                y = sw(z)
                assert y != z and len(vals[y]) == 2, (k, z)
                assert sorted(C[z + 64 * s] for s in range(4)).count(vals[z][0]) == 2      # 2 + 2
                Jz = I[z][t ^ vals[z][0]] ^ I[z][t ^ vals[z][1]]
                Jy = I[y][t ^ vals[y][0]] ^ I[y][t ^ vals[y][1]]
                assert Jz == Jy, (k, z, t)
                if z < y:
                    B ^= Jz
        assert mom ^ B == expected, (k, t)
    b4, d4 = PC.space_for(PC.Model(REPO), k, "H4")
    assert (b4 >> 1) & 1 == 1 and all((d >> 1) & 1 == 0 for d in d4), k
    print(f"class {k:3d}: |P_t| = 4B, E_0 = E_15 = (1+u24)(S+c4) + u1 u24 (c4 = {c4}), H4 => u1 = 1  OK")
print("x24 = 0 on A_k in all 14 classes: on u24 = 1 the identity gives E_0 = u1 = 1.")
