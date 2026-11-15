"""Independent re-derivation of (L5)+(L3) for every polar, straight from the Poisson sums.

For a subspace V of W = F2^6 with dim V^perp = j, a coset w0 + V and I with |I| small, put
    C(theta) = sum_{z >= I} K_z,   K_z = sum_{s in V} (-1)^{f_theta(z, w0 + s)}.
Bentness gives C = 0 mod 2^(7 - j - |I|) (Poisson in V^perp and the Moebius sum over z >= I).
  (L5): j = 1 (hyperplanes eta^perp), |I| <= 2, target mod 16.  Every K_z = 0 mod 8 (rank of B_z|_V <= 4),
        so the condition is: bit 3 of C vanishes.
  (L3): j = 3 (all 1395 subspaces of dimension 3), |I| <= 1, target mod 8.  Every K_z = 0 mod 4,
        so the condition is: bit 2 of C vanishes.
With the polar fixed, these bits are affine in the phase theta (Gauss sums: the magnitude of K_z depends on the
polar only, and K_z / 8 resp. K_z / 4 is odd iff z is active, an affine condition; see poisson5.py, poisson3.py).
So each bit is interpolated from theta = 0 and the 43 unit vectors (and checked at random points).
This code does not use poisson5.py / poisson3.py: K_z is summed directly over the points of V.
For each polar it reports whether the independent system is inconsistent (the polar dies by (L5)+(L3)), and
otherwise checks that its solution space U_ind is contained in the U used by the certificates.
Usage: python verifica_L5L3.py lista <out.txt>
       python verifica_L5L3.py <polars file> [--shard i/n] [--out file.json]"""
import os, sys, json, time, itertools
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np

par6 = np.array([bin(i).count("1") & 1 for i in range(64)])
Zs = np.arange(64)


def all_hyperplanes():
    out = []
    for eta in range(1, 64):
        V = [s for s in range(64) if par6[s & eta] == 0]
        w1 = next(w for w in range(64) if par6[w & eta])
        out.append((V, [0, w1]))
    return out


def all_dim3():
    seen = set(); out = []
    for a in range(1, 64):
        for b in range(a + 1, 64):
            for c in range(b + 1, 64):
                span = {0}
                for v in (a, b, c):
                    span |= {s ^ v for s in span}
                if len(span) == 8:
                    key = tuple(sorted(span))
                    if key not in seen:
                        seen.add(key)
                        reps = []; vis = set()
                        for w in range(64):
                            if w not in vis:
                                reps.append(w); vis |= {w ^ s for s in key}
                        out.append((list(key), reps))
    assert len(out) == 1395
    return out


HYP = all_hyperplanes(); D3 = all_dim3()
I2 = [0] + [1 << i for i in range(6)] + [(1 << i) | (1 << j) for i, j in itertools.combinations(range(6), 2)]
I1 = I2[:7]
MI2 = np.array([(Zs & m) == m for m in I2], dtype=np.int64)
MI1 = MI2[:7]
# index arrays: for each (V, w0) the 64 x |V| matrix of columns w0 ^ s
H_idx = np.array([[w0 ^ s for s in V] for V, reps in HYP for w0 in reps])          # 126 x 32
D_idx = np.array([[w0 ^ s for s in V] for V, reps in D3 for w0 in reps])           # 11160 x 8


def bits(f):
    """f: 64 x 64 table.  Returns the concatenated condition bits (L5 then L3)."""
    S = 1 - 2 * f.astype(np.int64)
    K5 = S[:, H_idx].sum(axis=2)                       # 64 x 126
    assert (K5 % 8 == 0).all()
    C5 = MI2 @ K5                                      # 22 x 126
    b5 = (C5 >> 3) & 1
    K3 = S[:, D_idx].sum(axis=2)                       # 64 x 11160
    assert (K3 % 4 == 0).all()
    C3 = MI1 @ K3                                      # 7 x 11160
    b3 = (C3 >> 2) & 1
    return np.concatenate([b5.reshape(-1), b3.reshape(-1)]).astype(np.uint8)


def gf2_solve(rows, n):
    piv = {}
    for r, b in rows:
        x = (r << 1) | b
        while x > 1 and (x.bit_length() - 1) in piv:
            x ^= piv[x.bit_length() - 1]
        if x == 1:
            return None
        if x > 1:
            piv[x.bit_length() - 1] = x
    for p in sorted(piv):
        for q in piv:
            if q != p and piv[q] >> p & 1:
                piv[q] ^= piv[p]
    pivs = {p - 1 for p in piv}
    part = sum(1 << (p - 1) for p, x in piv.items() if x & 1)
    ker = []
    for f_ in range(n):
        if f_ not in pivs:
            v = 1 << f_
            for p, x in piv.items():
                if x >> (f_ + 1) & 1:
                    v |= 1 << (p - 1)
            ker.append(v)
    return part, ker


def in_span(v, basis):
    piv = {}
    for b in basis:
        x = b
        while x and (x.bit_length() - 1) in piv:
            x ^= piv[x.bit_length() - 1]
        if x:
            piv[x.bit_length() - 1] = x
    x = v
    while x and (x.bit_length() - 1) in piv:
        x ^= piv[x.bit_length() - 1]
    return x == 0


def independent_U(G0, Gk, rng):
    n = Gk.shape[0]
    b0 = bits(G0)
    cols = [bits(G0 ^ Gk[k]) ^ b0 for k in range(n)]
    # affinity sanity checks at random points
    for _ in range(3):
        th = [k for k in range(n) if rng.random() < 0.5]
        f = G0.copy()
        pred = b0.copy()
        for k in th:
            f ^= Gk[k]; pred ^= cols[k]
        assert (bits(f) == pred).all(), "bits not affine in the phase"
    M = np.stack(cols, axis=1)                         # conditions x n
    rows = {}
    for r in range(M.shape[0]):
        mask = int(sum(1 << k for k in np.flatnonzero(M[r])))
        rows[(mask, int(b0[r]))] = 1
    return gf2_solve(list(rows), n)


if __name__ == "__main__":
    if sys.argv[1] == "lista":
        from enum_polares_todos import setup
        from lista_polares import hexB
        Bb, Gb, Gk, topi, lows, codes = setup()
        out = []
        for code in codes:
            sel0 = [topi[i] for i in range(len(topi)) if code >> i & 1]
            for low in range(1 << len(lows)):
                sel = set(sel0)
                for i in range(len(lows)):
                    if low >> i & 1:
                        sel ^= set(lows[i])
                sel = sorted(sel)
                B = np.bitwise_xor.reduce([Bb[j] for j in sel], axis=0) if sel else np.zeros((15, 64), np.uint8)
                out.append(hexB(B))
        open(sys.argv[2], "w").write("\n".join(out) + "\n")
        print(len(out), "polars", len(set(out)), "distinct"); sys.exit(0)
    from bitj import load_model, solve_affine
    from base12 import pack
    from poisson5 import Bv_table, equacoes          # only to rebuild the U used by the certificates
    from poisson3 import eq3
    from poisson3_lista import todos_subespacos3
    out_path = sys.argv[sys.argv.index("--out") + 1] if "--out" in sys.argv else None
    si, sm = map(int, (sys.argv[sys.argv.index("--shard") + 1] if "--shard" in sys.argv else "0/1").split("/"))
    Bb, Gb, Gk, piv = load_model(); Vs = todos_subespacos3()
    rng = np.random.default_rng(1)
    res = []
    for k, hx in enumerate(open(sys.argv[1]).read().split()):
        if k % sm != si:
            continue
        t0 = time.time(); val = int(hx, 16)
        B = np.array([[(val >> (64 * a + z)) & 1 for z in range(64)] for a in range(15)], dtype=np.uint8)
        r = pack(B); comb = 0
        while r:
            c = r.bit_length() - 1; r ^= piv[c][0]; comb ^= piv[c][1]
        sel = [j for j in range(len(Bb)) if comb >> j & 1]
        G0 = np.bitwise_xor.reduce(Gb[sel], axis=0) if sel else np.zeros((64, 64), np.uint8)
        ind = independent_U(G0, Gk, rng)
        rec = {"polar": hx}
        if ind is None:
            rec["independent"] = "dead"
        else:
            rec["independent"] = "alive"; rec["dim_ind"] = len(ind[1])
            Bv = Bv_table(B)
            cert = solve_affine(equacoes(Bv, G0, Gk) + eq3(Bv, G0, Gk, Vs), Gk.shape[0])
            if cert is None:
                rec["contained"] = False; rec["note"] = "certificates call it dead by (L5)+(L3), independent check does not"
            else:
                part, ker = cert
                rec["dim_cert"] = len(ker)
                rec["contained"] = in_span(ind[0] ^ part, ker) and all(in_span(v, ker) for v in ind[1])
        rec["seconds"] = round(time.time() - t0, 1)
        res.append(rec)
        if out_path and len(res) % 50 == 0:
            json.dump(res, open(out_path, "w"))
    if out_path:
        json.dump(res, open(out_path, "w"))
    from collections import Counter
    print("done", len(res), Counter((r["independent"], r.get("contained")) for r in res))
