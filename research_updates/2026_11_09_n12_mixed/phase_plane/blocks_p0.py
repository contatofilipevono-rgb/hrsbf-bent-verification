"""Replace the point scan in the 364 'moment + size bit' certificates by a polynomial identity.

Block lemma.  Let pi(z,s) = pi0(z) + s1 D1(z) + s2 D2(z) (no s1 s2 term).  Suppose that for every z
  (T) the derivatives (D1(z), D2(z)) span a space of dimension 0 or 1, and in dimension 1 the
      swapped point sw(z) has the same derivatives,
  (C) if D(z) spans <v> != 0, then pi0(sw z) + pi0(z) is 0 or v   (swap compatibility; LINEAR in
      the code: its class modulo <v> vanishes),
and sw(z) != z whenever D(z) != 0.  Then P_0 is a disjoint union of blocks of exactly 4 points:
  all four points over z if D(z) = 0 and pi0(z) = 0; or the two points
  over each of z and sw(z) if D(z) = <v> and
  pi0(z) in {0, v}. The s-solutions can differ between z and sw(z).
Hence |P_0| = 4 B and bit2(|P_0|) = B mod 2, with
  B = sum_{z: D(z)=0} [pi0(z) = 0] + sum_{orbits {z, sw z}, D != 0} [pi0(z) in {0, v_z}],
a polynomial of degree <= dim(S) on each cell with fixed label modulo S.  The certificate M(0, z0 s1) + bit2(|P_0|) = 1 on a cell
becomes the polynomial identity M(0, z0 s1) + B = 1, checked by exact interpolation on the points of weight at most dim(S).

Checks: (T) on the class and (C) on each cell (base point and all
directions); for every size-bit certificate of short-certificates/short-k.json, the polynomial
identity on its cell; control: B = |P_0|/4 at sampled points.
"""
import sys, json, time, argparse
from collections import Counter
from itertools import combinations
from pathlib import Path
sys.path.insert(0, str(Path(__file__).parent))
import plane_cert as PC
import short_certs as SC


def dd(z): return (z & 7) ^ (z >> 3)
def sw(z): return (z >> 3) | ((z & 7) << 3)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("repo"); ap.add_argument("--classes", default="22,23,36,37,50,51,164,165,178,179")
    ap.add_argument("--out", default="blocks_p0.json")
    a = ap.parse_args()
    M = PC.Model(a.repo)
    def mapping_of(c):
        m = 0
        for i in range(33):
            if c >> i & 1:
                m ^= M.basis[i]
        return m
    report = {}
    for k in [int(x) for x in a.classes.split(",")]:
        t0 = time.time()
        base, dirs = PC.space_for(M, k, "H4")
        labs = [M.labels(mapping_of(c)) for c in [base] + [base ^ d for d in dirs]]
        L0 = labs[0]
        D1 = [L0[z + 64] ^ L0[z] for z in range(64)]; D2 = [L0[z + 128] ^ L0[z] for z in range(64)]
        # (T): derivative types (fixed by the class: the low directions do not depend on s)
        for L in labs:
            assert all(L[z + 64] ^ L[z] == D1[z] and L[z + 128] ^ L[z] == D2[z]
                       and L[z] ^ L[z + 64] ^ L[z + 128] ^ L[z + 192] == 0 for z in range(64))
        vz = {}
        for z in range(64):
            span = {0, D1[z], D2[z], D1[z] ^ D2[z]} - {0}
            assert len(span) <= 1, (k, z, "derivatives of rank 2")
            vz[z] = span.pop() if span else 0
        for z in range(64):
            if vz[z]:
                assert sw(z) != z and vz[sw(z)] == vz[z], (k, z, "(T) swap")
        # (C): pi0(sw z) + pi0(z) in {0, v_z}, an affine condition: check on the affine basis
        def mod_v(x, v):
            return min(x, x ^ v) if v else x
        # S = span of all derivative values; inside a cell rho = pi0 mod S is fixed, so the set
        # Z = {z : pi0(z) in t + S} is fixed and (C) restricted to Z is affine in the code: it is
        # checked below on the affine basis of each cell.
        Sp = {}
        for v in D1 + D2:
            while v and (v.bit_length() - 1) in Sp:
                v ^= Sp[v.bit_length() - 1]
            if v:
                Sp[v.bit_length() - 1] = v
        def projS(x):
            for p in sorted(Sp, reverse=True):
                if x >> p & 1:
                    x ^= Sp[p]
            return x
        # On a rho-cell each label varies within a fixed coset of S. A label
        # equality is therefore the product of at most dim(S) affine equations.
        degree = len(Sp)
        # cells with a size-bit certificate
        certs = json.loads((Path(__file__).parent / "short-certificates" / f"short-{k}.json").read_text())
        sizecells = {r["cell_index"]: r for r in certs if r["kind"] == "moments+size"}
        forms = Counter(tuple(map(tuple, r["certificate"])) for r in sizecells.values())
        xs = [sum(1 << x for x in range(256) if x >> i & 1) for i in range(8)]
        mon = {"x0x6": xs[0] & xs[6]}
        checked = 0; ctrl = 0
        orbit_reps = [z for z in range(64) if vz[z] and z < sw(z)]
        zero_d = [z for z in range(64) if not vz[z]]
        for idx, (code, rker, info) in enumerate(SC.cells_of(M, k)):
            if idx not in sizecells:
                continue
            cert = sizecells[idx]["certificate"]
            assert len(cert) == 2 and cert[1][0] == "B" and cert[1][2] == "2" and cert[0][0] == "M"
            t = int(cert[0][1]); assert int(cert[1][1]) == t
            mm = xs[int(cert[0][2][1])] & xs[int(cert[0][2][3])]
            n = len(rker)
            # (C) on Z = {z : pi0(z) = t mod S} (fixed in the cell), on the cell's affine basis
            Lb = M.labels(mapping_of(code))
            Zc = [z for z in range(64) if projS(Lb[z]) == projS(t)]
            for cc in [code] + [code ^ v for v in rker]:
                Lc = M.labels(mapping_of(cc))
                assert [z for z in range(64) if projS(Lc[z]) == projS(t)] == Zc
                for z in Zc:
                    if vz[z]:
                        assert sw(z) in Zc and mod_v(Lc[z] ^ Lc[sw(z)], vz[z]) == 0, (k, idx, z, "(C)")
            def value(cc):
                L = M.labels(mapping_of(cc))
                fib = sum(1 << x for x in range(256) if L[x] == t)
                mom = (fib & mm).bit_count() & 1
                B = sum(1 for z in zero_d if L[z] == t) + \
                    sum(1 for z in orbit_reps if L[z] in (t, t ^ vz[z]))
                return mom ^ (B & 1), B, fib.bit_count()
            # Exact interpolation up to dim(S) tests mom + B == 1 on the cell.
            vals = {}
            for deg in range(min(degree, n) + 1):
                for S in combinations(range(n), deg):
                    cc = code
                    for i in S:
                        cc ^= rker[i]
                    f, B, size = value(cc)
                    vals[sum(1 << i for i in S)] = f
                    assert size == 4 * B, (k, idx, "block decomposition")   # control
                    ctrl += 1
            for key in vals:
                acc = 0; sub = key
                while True:
                    acc ^= vals[sub]
                    if sub == 0:
                        break
                    sub = (sub - 1) & key
                assert acc == (1 if key == 0 else 0), (k, idx, "identity fails", key)
            checked += 1
        report[k] = {"size_bit_cells": len(sizecells), "checked_by_polynomial_identity": checked,
                     "degree_bound": degree,
                     "forms": {" + ".join("".join(c) for c in f): v for f, v in forms.items()},
                     "points_evaluated": ctrl, "seconds": round(time.time() - t0, 1)}
        assert checked == len(sizecells)
        print(k, report[k], flush=True)
    Path(a.out).write_text(json.dumps(report, indent=1))
    print("total size-bit cells closed by the block lemma:", sum(r["checked_by_polynomial_identity"] for r in report.values()))


if __name__ == "__main__":
    main()
