"""Proof of x24 = 0 for class 129 of V1 (n=12, degree 4): verifier of every identity used.

Notation: z = (y, w), y = (z0,z1,z2), w = (z3,z4,z5), d = y + w, row R_d, swap(y,w) = (w,y)
(fixes R_0 pointwise and acts on R_d, d != 0, as y -> y + d without fixed points).
pi(z,s) = pi0(z) + (s1 a(d) + s2 b(d)) 1111 with a = [d in {2,4}], b = [d in {1,4}].
rho = pi0 mod <1111>; chi(z) = [pi0(swap z) != pi0(z)].  A = A_129 (support moments + balance,
affine consequences, dim 20).

Identities (affine in the code, checked at the base point and along all 20 directions):
  (I0) the class shape: s-derivatives as above, no s1 s2 term.
  (I1) diagonal: rho(y, 0) = x24 * Lam y with Lam e0 = 4, Lam e1 = 6, Lam e2 = 2 (kernel {0, 7}),
       pi0(0) = 15 and pi0(63) = 0.
  (I2) rows 3, 5, 6: chi(z) = bit 0 of rho(z).
  (I3) row 7: bit 0 of rho(z) = 1 (only odd pairs).
  (I4) rho o swap = rho.
Lemma (from I0-I4): if x24 = 1 and Z_[0] = rho^{-1}([0]) does not meet the rows 1, 2, 4, then
  sum_{P_0} s1 s2 = #{z : pi(z,1,1) = 0} = 1 (mod 2),
  contradicting the orthogonality of P_0 to s1 s2.  Proof: (a+b) is constant on rows; the swap orbits
  {z, swap z} in Z_[0] off the diagonal contribute chi(z); by (I3) Z_[0] misses R_7, by (I2) chi = 0
  on Z_[0] in rows 3, 5, 6; by (I1) Z_[0] ∩ R_0 = {0, 63} with labels 15, 0, contributing 1.
Remaining finite step (rho only, no map enumeration): on x24 = 1, every rho value with
  |Z_[t]| = 8 (size, summed over the pair) and a e_t, b e_t orthogonal to RM(1,6), |Z_[t] ∩ M| even,
  has Z_[0] ∩ M = ∅.  Checked over all 2^14 rho values.  Both filters are needed.
Controls: the lemma's conclusion (moment = 1) also holds for every rho with Z_[0] ∩ M = ∅ regardless
of the filters; witness 4358938703 (x24 = 1, all orthogonality moments, wrong fibre sizes) is kept;
positive control: catalog-type maps with x24 = 0 have the moment 0.
"""
import sys
from collections import Counter
from pathlib import Path
sys.path.insert(0, str(Path(__file__).parent))
import plane_cert as PC

K = 129


def main():
    M = PC.Model(sys.argv[1])
    base, dirs = PC.space_for(M, K, "H4")
    assert len(dirs) == 20
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
    pts = [base] + [base ^ d for d in dirs]
    L = [M.labels(mapping_of(c)) for c in pts]
    x24 = [(c >> 24) & 1 for c in pts]
    a_rows, b_rows = {2, 4}, {1, 4}
    for lab in L:                                   # (I0)
        for z in range(64):
            d = dd(z)
            assert lab[z + 64] ^ lab[z] == (15 if d in a_rows else 0)
            assert lab[z + 128] ^ lab[z] == (15 if d in b_rows else 0)
            assert lab[z] ^ lab[z + 64] ^ lab[z + 128] ^ lab[z + 192] == 0
    Lam = [4, 6, 2]
    for lab, x in zip(L, x24):                      # (I1)-(I4) at every point of an affine basis:
        for y in range(8):                          # all are affine in the code, hence hold on A
            v = 0
            for i in range(3):
                if y >> i & 1:
                    v ^= Lam[i]
            assert rep(lab[zof(y, 0)]) == (v if x else 0), "(I1)"
        assert lab[0] == 15 and lab[63] == 0, "(I1) labels"
        for z in range(64):
            if dd(z) in (3, 5, 6):
                assert ((lab[z] ^ lab[sw(z)]) >> 3) == (rep(lab[z]) & 1), "(I2)"
            if dd(z) == 7:
                assert rep(lab[z]) & 1 == 1, "(I3)"
            assert rep(lab[z]) == rep(lab[sw(z)]), "(I4)"
    print("identities I0-I4: OK on the affine basis of A_129 (21 points)")
    # remaining finite step over rho values on x24 = 1
    lin = [(d >> 24) & 1 for d in dirs]; p = lin.index(1)
    b1 = base if (base >> 24) & 1 else base ^ dirs[p]
    d1 = [d ^ dirs[p] if lin[i] else d for i, d in enumerate(dirs) if i != p]
    lab0 = M.labels(mapping_of(b1))[:64]
    DL = [[u ^ v for u, v in zip(M.labels(mapping_of(b1 ^ d))[:64], lab0)] for d in d1]
    piv = {}; rch = []
    for dl in DL:
        xw = sum(rep(v) << (3 * z) for z, v in enumerate(dl)); vv = dl
        while xw and (xw.bit_length() - 1) in piv:
            px, pv = piv[xw.bit_length() - 1]; xw ^= px; vv = [u ^ v for u, v in zip(vv, pv)]
        if xw:
            piv[xw.bit_length() - 1] = (xw, vv); rch.append(vv)
    assert len(rch) == 14
    Ms = {1, 2, 4}
    stat = Counter()
    for sel in range(1 << 14):
        lab = list(lab0)
        for i, v in enumerate(rch):
            if sel >> i & 1:
                lab = [u ^ w for u, w in zip(lab, v)]
        rho = [rep(v) for v in lab]
        Z = [[z for z in range(64) if rho[z] == t] for t in range(8)]
        bal = all(len(s) == 8 for s in Z)
        f2 = True
        for s in Z:
            for S in (a_rows, b_rows):
                q = [z for z in s if dd(z) in S]; acc = 0
                for z in q:
                    acc ^= z
                if len(q) % 2 or acc:
                    f2 = False
            if sum(dd(z) in Ms for z in s) % 2:
                f2 = False
        meet = any(dd(z) in Ms for z in Z[0])
        mom = sum(1 for z in range(64)
                  if (lab[z] ^ (15 if (dd(z) in a_rows) ^ (dd(z) in b_rows) else 0)) == 0) & 1
        if not meet:
            assert mom == 1, "lemma"
        if bal and f2:
            assert not meet, "remaining step"
        stat[(bal, f2, meet)] += 1
    print("rho values on x24=1 (balance, F2, Z_[0] meets M):", dict(sorted(stat.items())))
    assert stat[(True, True, True)] == 0 and stat[(True, False, True)] > 0 and stat[(False, True, True)] > 0
    print("remaining step OK; both filters are needed")
    # negative witness: survives without the size hypothesis
    w = 4358938703
    lab = M.labels(mapping_of(w))
    assert (w >> 24) & 1 == 1 and w >> 25 == K
    fib = [sum(1 << x for x in range(256) if lab[x] == t) for t in range(16)]
    xs = [sum(1 << x for x in range(256) if x >> i & 1) for i in range(8)]
    tests = xs + [xs[i] & xs[j] for i in range(8) for j in range(i + 1, 8)]
    assert all(not ((f & m).bit_count() & 1) for f in fib for m in tests), "witness orthogonality"
    sizes = [f.bit_count() for f in fib]
    assert any(s != 16 for s in sizes)
    Z0 = [z for z in range(64) if rep(lab[z]) == 0]
    print("witness 4358938703: x24=1, all orthogonality moments 0, fibre sizes", sizes,
          "; Z_[0] rows", dict(Counter(dd(z) for z in Z0)))
    print("OK")


if __name__ == "__main__":
    main()
