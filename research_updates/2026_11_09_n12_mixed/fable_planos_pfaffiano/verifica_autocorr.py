"""Independent verifier of the autocorrelation certificates (cert_autocorr.py output).

Recomputes, by a different implementation (full polar matrix with numpy; GF(2) ranks with numpy):
  - U from (L5)+(L3) and the radicals, the pairs (z, d), N_d and the forms L_zd, g(z,d);
  - level 'odd'  : N_d odd at the witness direction;
  - level 'mod4' : rank [A | b] > rank A for the 63 affine equations  XOR_z [g + L_zd(theta)] = N_d/2;
  - level 'modK' : on the solution space of that system (recomputed), S_d is constant mod K with nonzero
                   residue: all integer coefficients (-2)^|J| sum_{l>=J} n_l, 1 <= |J| < log2 K, vanish mod K.
Usage: python verifica_autocorr.py <certificates.json> [...]"""
import os, sys, json, itertools
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from bitj import load_model, solve_affine, table_at

X = np.arange(64)


def gf2_rank(M):
    M = M.copy() % 2; r = 0
    rows, cols = M.shape
    for c in range(cols):
        p = np.nonzero(M[r:, c])[0]
        if len(p) == 0:
            continue
        p = p[0] + r
        M[[r, p]] = M[[p, r]]
        nz = np.nonzero(M[:, c])[0]
        for i in nz:
            if i != r:
                M[i] ^= M[r]
        r += 1
        if r == rows:
            break
    return r


def gf2_solve(A, b):
    """Solution space of A x = b over GF(2): (particular, kernel basis as arrays) or None."""
    rows, m = A.shape
    M = np.concatenate([A % 2, (b % 2)[:, None]], axis=1).astype(np.uint8)
    piv = []; r = 0
    for c in range(m):
        p = np.nonzero(M[r:, c])[0]
        if len(p) == 0:
            continue
        p = p[0] + r
        M[[r, p]] = M[[p, r]]
        for i in np.nonzero(M[:, c])[0]:
            if i != r:
                M[i] ^= M[r]
        piv.append(c); r += 1
        if r == rows:
            break
    if M[r:, m].any():
        return None
    x0 = np.zeros(m, np.uint8)
    for i, c in enumerate(piv):
        x0[c] = M[i, m]
    free = [c for c in range(m) if c not in piv]
    ker = []
    for f in free:
        v = np.zeros(m, np.uint8); v[f] = 1
        for i, c in enumerate(piv):
            v[c] = M[i, f]
        ker.append(v)
    return x0, ker


def pairs_np(T0, K):
    Kt = np.array(K, dtype=np.uint8); m = len(K)
    out = []
    for z in range(64):
        f = T0[z].astype(np.uint8)
        Bm = f[X[:, None] ^ X[None, :]] ^ f[:, None] ^ f[None, :] ^ f[0]
        for a in range(6):
            assert (Bm[X ^ (1 << a)] ^ Bm[X] ^ Bm[1 << a][None, :] ^ Bm[0][None, :] == 0).all()
        rad = np.nonzero(~Bm.any(axis=1))[0]
        for d in rad:
            out.append((z, int(d), (Kt[:, z, d] ^ Kt[:, z, 0]).copy(), int(f[d] ^ f[0])))
    return out, m


def check(c, T0, K):
    pairs, m = pairs_np(T0, K)
    by_d = {}
    for z, d, vec, g in pairs:
        if d:
            by_d.setdefault(d, []).append((vec, g))
    if c["level"] == "odd":
        return len(by_d.get(c["witness_d"], [])) % 2 == 1
    A = np.zeros((63, m), np.uint8); b = np.zeros(63, np.uint8)
    for d in range(1, 64):
        t = by_d.get(d, [])
        b[d - 1] = (len(t) // 2) & 1
        for vec, g in t:
            A[d - 1] ^= vec; b[d - 1] ^= g
    if c["level"] == "mod4":
        return gf2_rank(np.concatenate([A, b[:, None]], axis=1)) > gf2_rank(A)
    K_ = int(c["level"][3:]); k = K_.bit_length() - 1
    sol = gf2_solve(A, b)
    if sol is None:
        return False
    x0, ker = sol
    n = {}
    for vec, g in by_d[c["witness_d"]]:
        cst = int(vec @ x0) & 1
        lf = tuple(int(vec @ kv) & 1 for kv in ker)
        n[lf] = n.get(lf, 0) + (1 - 2 * (g ^ cst))
    keys = [kk for kk, v in n.items() if v]
    vals = np.array([n[kk] for kk in keys], dtype=np.int64)
    L = np.array(keys, dtype=np.uint8).reshape(len(keys), len(ker))
    # character basis: row-reduce the distinct forms (lowest index pivots), express every form in it
    Bm = L.copy(); piv = []; r = 0
    for col in range(L.shape[1]):
        p = np.nonzero(Bm[r:, col])[0]
        if len(p) == 0:
            continue
        p = p[0] + r; Bm[[r, p]] = Bm[[p, r]]
        for i in np.nonzero(Bm[:, col])[0]:
            if i != r:
                Bm[i] ^= Bm[r]
        piv.append(col); r += 1
        if r == len(Bm):
            break
    D = len(piv)
    coords = L[:, piv]                      # since Bm is reduced, a form's coordinates are its values at the pivot columns
    # check: forms reconstructed from coordinates
    assert ((coords.astype(np.int64) @ Bm[:D].astype(np.int64)) % 2 == L).all()
    S0 = int(vals.sum())
    for deg in range(1, min(D, k - 1) + 1):
        for J in itertools.combinations(range(D), deg):
            sel = coords[:, list(J)].all(axis=1)
            if (int(vals[sel].sum()) << deg) % K_:
                return False
    return S0 % K_ != 0


if __name__ == "__main__":
    from base12 import pack
    from collections import Counter
    from poisson5 import Bv_table, equacoes
    from poisson3 import eq3
    from poisson3_lista import todos_subespacos3
    Bb, Gb, Gk, piv = load_model(); Vs = todos_subespacos3()
    certs = [c for p in sys.argv[1:] for c in json.load(open(p))]
    tally = Counter(); bad = 0
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
        assert hex(part) == c["part"] and [hex(v) for v in ker] == c["ker"]
        T0 = table_at(G0, Gk, part); K = [table_at(np.zeros_like(G0), Gk, v) for v in ker]
        ok = c["level"] != "open" and check(c, T0, K)
        tally[(c["level"], ok)] += 1
        if not ok:
            bad += 1; print("FAIL", hx[:16], c["level"])
    for (lv, ok), n in sorted(tally.items()):
        print("%-6s verified=%s : %d" % (lv, ok, n))
    print("certificates:", len(certs), "failures:", bad)
    sys.exit(1 if bad else 0)
