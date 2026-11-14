"""Per-polar certificates that sum_z r(z)^2 is constant and nonzero mod 2048 on the whole domain U of (L5)+(L3).

Identity (radical reformulation; certificate by characters after Codex, parseval-certificado/PROVA.md):
    E(theta) = 64 T(theta),  T(theta) = sum_L n_L (-1)^{L(theta)},
grouping the pairs (z, d), d in rad B_z, by the linear form L_zd(theta) = sum_i theta_i [K_i(z,d) + K_i(z,0)],
with n_L = sum of signs (-1)^{f_0(z,d) + f_0(z,0)} in the group.  T is constant mod 32 iff, in independent
character coordinates x, every coefficient (-2)^|J| sum_{l >= J} n_l with |J| >= 1 is 0 mod 32; degrees > 4 - s
are automatic when every nonconstant n_l is a multiple of 2^s.  If s >= 3 a single XOR relation suffices.
No enumeration of the parameters.
Usage: python cert_parseval.py <polars file> [--shard i/n] [--out file.json]"""
import os, sys, json, time, itertools
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from bitj import load_model, solve_affine, table_at
from parseval_dominio import rank_radical, affine_in_w


def span(vectors):
    pts = [0]
    for v in vectors:
        pts += [p ^ v for p in pts]
    return pts


def weights_of(T0, K):
    m = len(K)
    n = {}
    for z in range(64):
        rk, rad = rank_radical(T0[z])
        for d in span(rad):
            form = 0
            for i in range(m):
                if K[i][z][d] ^ K[i][z][0]:
                    form |= 1 << i
            n[form] = n.get(form, 0) + (1 - 2 * int(T0[z][d] ^ T0[z][0]))
    return {L: v for L, v in n.items() if v}


def v2(x):
    return (x & -x).bit_length() - 1


def certificate(n):
    nonconst = [v for L, v in n.items() if L]
    s = min((v2(abs(v)) for v in nonconst), default=5)
    E0 = 64 * sum(n.values())
    cert = {"E0": E0, "residue": E0 % 2048, "s": s, "n_weights": len(n)}
    if s >= 3:
        x = 0
        for L, v in n.items():
            if L and (v // 8) & 1:
                x ^= L
        if x == 0:
            cert.update(method="xor", ok=True)
            return cert
    # independent character coordinates
    basis = []                                   # (pivot, vector)
    for L in n:
        x = L
        for p, b in basis:
            if x >> p & 1:
                x ^= b
        if x:
            basis.append((x.bit_length() - 1, x))
    def coords(L):
        c = 0
        for t, (p, b) in enumerate(basis):
            if L >> p & 1:
                L ^= b; c |= 1 << t
        assert L == 0
        return c
    # (reduce in insertion order: each basis vector was reduced by the earlier ones, so pivots are distinct)
    C = {coords(L): v for L, v in n.items()}
    D = len(basis); maxdeg = min(D, max(0, 4 - s)); checks = 0; ok = True
    for deg in range(1, maxdeg + 1):
        for J in itertools.combinations(range(D), deg):
            mask = sum(1 << j for j in J)
            tot = sum(v for c, v in C.items() if c & mask == mask)
            checks += 1
            if (tot << deg) % 32:
                ok = False; cert["failed"] = hex(mask); break
        if not ok:
            break
    cert.update(method="coefficients", D=D, max_degree=maxdeg, checks=checks, ok=ok)
    return cert


if __name__ == "__main__":
    from base12 import pack
    from poisson5 import Bv_table, equacoes
    from poisson3 import eq3
    from poisson3_lista import todos_subespacos3
    out_path = sys.argv[sys.argv.index("--out") + 1] if "--out" in sys.argv else None
    si, sm = map(int, (sys.argv[sys.argv.index("--shard") + 1] if "--shard" in sys.argv else "0/1").split("/"))
    Bb, Gb, Gk, piv = load_model(); Vs = todos_subespacos3()
    res = []
    for k, hx in enumerate(open(sys.argv[1]).read().split()):
        if k % sm != si:
            continue
        t0 = time.time()
        val = int(hx, 16)
        B = np.array([[(val >> (64 * a + z)) & 1 for z in range(64)] for a in range(15)], dtype=np.uint8)
        r = pack(B); comb = 0
        while r:
            c = r.bit_length() - 1; r ^= piv[c][0]; comb ^= piv[c][1]
        sel = [j for j in range(len(Bb)) if comb >> j & 1]
        G0 = np.bitwise_xor.reduce(Gb[sel], axis=0) if sel else np.zeros((64, 64), np.uint8)
        Bv = Bv_table(B)
        part, ker = solve_affine(equacoes(Bv, G0, Gk) + eq3(Bv, G0, Gk, Vs), Gk.shape[0])
        T0 = table_at(G0, Gk, part)
        K = [table_at(np.zeros_like(G0), Gk, v) for v in ker]
        assert all(affine_in_w(Ki[z]) for Ki in K for z in range(64))
        n = weights_of(T0, K)
        cert = certificate(n)
        rec = {"polar": hx, "dim_U": len(ker), "part": hex(part), "ker": [hex(v) for v in ker],
               "weights": {hex(L): v for L, v in sorted(n.items())}, **cert, "seconds": round(time.time() - t0, 1)}
        res.append(rec)
        print(hx[:12], "residue", cert["residue"], cert["method"], "ok" if cert["ok"] else "FAIL", "s", cert["s"],
              "D", cert.get("D"), flush=True)
        if out_path:
            json.dump(res, open(out_path, "w"))
