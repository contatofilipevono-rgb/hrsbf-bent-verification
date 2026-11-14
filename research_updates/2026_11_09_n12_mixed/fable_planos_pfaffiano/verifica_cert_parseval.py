"""Independent verifier of the Parseval residue certificates (cert_parseval.py output).

For each polar it recomputes, by a different route (numpy, full polar matrix):
  1. the domain U: (L5)+(L3) solved again; the certificate's affine space must coincide with it;
  2. every row of f_0 has degree <= 2 in w (bilinearity of the polar), every direction is affine in w;
  3. the weights n_L from all pairs (z, d), d in rad B_z, and compares them with the certificate;
  4. the claim T = E/64 constant mod 32 on F_2^D, by ALL integer coefficients of degree 1..4 in a basis of
     characters chosen differently (lowest-bit pivots), without the 2^s shortcut; for 'xor' certificates
     the XOR relation is checked too;
  5. residue = E(0) mod 2048 != 0, hence 4096 is never attained;
  6. consistency with the exhaustive enumeration in parseval_L5.json (values mod 2048 = {residue}).
No enumeration of the parameters is used in 1-5.
Usage: python verifica_cert_parseval.py <certificates.json> [...]"""
import os, sys, json, itertools
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from bitj import load_model, solve_affine, table_at

here = os.path.dirname(os.path.abspath(__file__))
X = np.arange(64)


def same_affine(p1, k1, p2, k2):
    def basis(vs):
        b = {}
        for v in vs:
            for p in sorted(b, reverse=True):
                if v >> p & 1:
                    v ^= b[p]
            if v:
                b[v.bit_length() - 1] = v
        return b
    def reduce(v, b):
        for p in sorted(b, reverse=True):
            if v >> p & 1:
                v ^= b[p]
        return v
    b1, b2 = basis(k1), basis(k2)
    return len(b1) == len(b2) and all(reduce(v, b1) == 0 for v in k2) and reduce(p1 ^ p2, b1) == 0


def weights_np(T0, K):
    m = len(K)
    Kt = np.array(K, dtype=np.uint8)                         # m x 64 x 64
    # directions affine in w: K(a^b) = K(a)+K(b)+K(0)
    for i in range(m):
        Ki = Kt[i]
        assert not (Ki[:, X[:, None] ^ X[None, :]] ^ Ki[:, X][:, :, None] ^ Ki[:, X][:, None, :] ^ Ki[:, :1, None]).any()
    w = {}
    for z in range(64):
        f = T0[z].astype(np.uint8)
        Bm = f[X[:, None] ^ X[None, :]] ^ f[:, None] ^ f[None, :] ^ f[0]
        # degree <= 2  <=>  Bm is bilinear (additive in the first argument)
        for a in range(6):
            assert (Bm[X ^ (1 << a)] ^ Bm[X] ^ Bm[1 << a][None, :] ^ Bm[0][None, :] == 0).all()
        rad = np.nonzero(~Bm.any(axis=1))[0]
        bits = (Kt[:, z, rad] ^ Kt[:, z, :1]).astype(np.uint64)    # m x |rad|
        forms = (bits << np.arange(m, dtype=np.uint64)[:, None]).sum(axis=0)
        signs = 1 - 2 * (f[rad] ^ f[0]).astype(np.int64)
        for L, s in zip(forms.tolist(), signs.tolist()):
            w[L] = w.get(L, 0) + s
    return {L: v for L, v in w.items() if v}


def const_mod32(n):
    """All integer coefficients of degree 1..4 of T in a lowest-pivot character basis are 0 mod 32."""
    piv = {}
    for L in n:
        x = L
        while x:
            p = (x & -x).bit_length() - 1
            if p in piv:
                x ^= piv[p][0]
            else:
                piv[p] = (x, len(piv)); break
    combos, vals = [], []
    for L, v in n.items():
        x, c = L, 0
        while x:
            p = (x & -x).bit_length() - 1
            x ^= piv[p][0]; c |= 1 << piv[p][1]
        combos.append(c); vals.append(v)
    combos = np.array(combos, dtype=np.int64); vals = np.array(vals, dtype=np.int64)
    D = len(piv)
    for deg in range(1, min(D, 4) + 1):
        for J in itertools.combinations(range(D), deg):
            mask = sum(1 << j for j in J)
            if (int(vals[(combos & mask) == mask].sum()) << deg) % 32:
                return False, D
    return True, D


if __name__ == "__main__":
    from base12 import pack
    from poisson5 import Bv_table, equacoes
    from poisson3 import eq3
    from poisson3_lista import todos_subespacos3
    # self-tests of the coefficient criterion (T on F_2^1, F_2^2)
    assert const_mod32({0: 5, 1: 1})[0] is False          # T = 6 or 4
    assert const_mod32({1: 8, 2: 8, 3: 8})[0] is True     # T in {24, -8, -8, -8}, all 24 mod 32
    assert const_mod32({1: 8, 2: 8})[0] is False          # T in {16, 0, 0, -16}
    assert const_mod32({1: 16, 2: 16})[0] is True         # T in {32, 0, 0, -32}
    enum = {r["polar"]: r for r in json.load(open(os.path.join(here, "parseval_L5.json"))) if "status" not in r}
    Bb, Gb, Gk, piv = load_model(); Vs = todos_subespacos3()
    certs = [c for p in sys.argv[1:] for c in json.load(open(p))]
    bad = 0
    from collections import Counter
    tally = Counter()
    for c in certs:
        hx = c["polar"]; val = int(hx, 16)
        B = np.array([[(val >> (64 * a + z)) & 1 for z in range(64)] for a in range(15)], dtype=np.uint8)
        r = pack(B); comb = 0
        while r:
            k = r.bit_length() - 1; r ^= piv[k][0]; comb ^= piv[k][1]
        sel = [j for j in range(len(Bb)) if comb >> j & 1]
        G0 = np.bitwise_xor.reduce(Gb[sel], axis=0) if sel else np.zeros((64, 64), np.uint8)
        Bv = Bv_table(B)
        part, ker = solve_affine(equacoes(Bv, G0, Gk) + eq3(Bv, G0, Gk, Vs), Gk.shape[0])
        cp, ck = int(c["part"], 16), [int(v, 16) for v in c["ker"]]
        ok = same_affine(part, ker, cp, ck)
        T0 = table_at(G0, Gk, cp); K = [table_at(np.zeros_like(G0), Gk, v) for v in ck]
        n = weights_np(T0, K)
        ok &= n == {int(L, 16): v for L, v in c["weights"].items()}
        E0 = 64 * sum(n.values()); res = E0 % 2048
        ok &= res == c["residue"] and res != 0
        cm, D = const_mod32(n)
        ok &= cm
        if c["method"] == "xor":
            x = 0
            for L, v in n.items():
                assert not L or v % 8 == 0
                if L and (v // 8) & 1:
                    x ^= L
            ok &= x == 0
        e = enum.get(hx)
        ok &= e is not None and {int(v) % 2048 for v in e["values"]} == {res}
        tally[(res, c["method"], ok)] += 1
        if not ok:
            bad += 1; print("FAIL", hx[:16])
    for k, v in sorted(tally.items()):
        print("residue %4d  %-12s  verified=%s : %d" % (k[0], k[1], k[2], v))
    print("certificates:", len(certs), "failures:", bad)
    sys.exit(1 if bad else 0)
