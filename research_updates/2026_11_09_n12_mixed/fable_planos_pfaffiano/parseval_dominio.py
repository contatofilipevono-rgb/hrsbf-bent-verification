"""Parseval on the column b = 0, decided on the whole affine space U = part + span(ker) left by (L5)+(L3).

For u in U the table is f_u = T0 + sum u_i K_i.  Row z: f_u(z, .) is quadratic in w with polar B_z that does not
depend on u (asserted: every K_i is affine in w on every row).  Then
    r_u(z)^2 = 2^(12 - rank B_z)  if f_u(z, .) is constant on rad(B_z)  ("row z active"),  0 otherwise,
and activation is a system of dim rad(B_z) affine equations in u.  A bent f needs sum_z r(z)^2 = 4096.
Let D be the dimension of the span of all activation forms; all 2^D value patterns occur on U, so the set of
attainable values of sum_z r_u(z)^2 is computed exactly by enumerating F_2^D.
Usage: python parseval_dominio.py <polars file> [--out file.json]"""
import os, sys, json, time
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from bitj import load_model, solve_affine, table_at

E = [1 << j for j in range(6)]


def rank_radical(row):
    """row: 64 bits f(w) of degree <= 2. Returns (rank of polar, radical basis)."""
    f = [int(x) for x in row]
    for w in range(64):                         # degree <= 2 check
        acc = f[0]
        for j in range(6):
            if w >> j & 1:
                acc ^= f[E[j]] ^ f[0]
        for i in range(6):
            for j in range(i + 1, 6):
                if (w >> i & 1) and (w >> j & 1):
                    acc ^= f[E[i] | E[j]] ^ f[E[i]] ^ f[E[j]] ^ f[0]
        assert acc == f[w], "row of degree > 2"
    Bm = [0] * 6
    for i in range(6):
        for j in range(6):
            if i != j and f[E[i] | E[j]] ^ f[E[i]] ^ f[E[j]] ^ f[0]:
                Bm[i] |= 1 << j
    # kernel of the symmetric matrix Bm over F2
    rows = Bm[:]; piv = []; r = 0
    M = [rows[i] for i in range(6)]
    pivcols = []
    for c in range(6):
        p = next((i for i in range(r, 6) if M[i] >> c & 1), None)
        if p is None:
            continue
        M[r], M[p] = M[p], M[r]
        for i in range(6):
            if i != r and M[i] >> c & 1:
                M[i] ^= M[r]
        pivcols.append(c); r += 1
    free = [c for c in range(6) if c not in pivcols]
    rad = []
    for fc in free:
        v = 1 << fc
        for i, pc in enumerate(pivcols):
            if M[i] >> fc & 1:
                v |= 1 << pc
        rad.append(v)
    return r, rad


def affine_in_w(row):
    f = [int(x) for x in row]
    for w in range(64):
        acc = f[0]
        for j in range(6):
            if w >> j & 1:
                acc ^= f[E[j]] ^ f[0]
        if acc != f[w]:
            return False
    return True


def analyse_polar(G0, Gk, part, ker, max_D=22):
    m = len(ker)
    T0 = table_at(G0, Gk, part)
    K = [table_at(np.zeros_like(G0), Gk, ker[i]) for i in range(m)]
    for Ki in K:
        assert all(affine_in_w(Ki[z]) for z in range(64)), "direction changes the polar"
    forms = []; cz = []
    for z in range(64):
        rk, rad = rank_radical(T0[z])
        cz.append(1 << (12 - rk))
        for rho in rad:
            coef = 0
            for i in range(m):
                if K[i][z][rho] ^ K[i][z][0]:
                    coef |= 1 << i
            forms.append((z, coef, int(T0[z][rho] ^ T0[z][0])))
    # basis of the span of the coefficient vectors; express each form in it
    basis = {}; comb_of = []
    for z, coef, c in forms:
        x = coef; comb = 0
        while x:
            h = x.bit_length() - 1
            if h in basis:
                x ^= basis[h][0]; comb ^= basis[h][1]
            else:
                bi = len(basis); basis[h] = (x, comb ^ (1 << bi)); comb ^= 0
                x = 0; comb = None
        comb_of.append(comb)
    # second pass: now every coefficient vector reduces to 0; record the combination of basis elements
    combs = []
    for z, coef, c in forms:
        x = coef; comb = 0
        while x:
            h = x.bit_length() - 1
            x ^= basis[h][0]; comb ^= basis[h][1]
        combs.append(comb)
    D = len(basis)
    ranks = sorted(12 - (c.bit_length() - 1) for c in cz)
    if D > max_D:
        return {"D": D, "ranks": ranks, "skipped": True}
    V = np.arange(1 << D, dtype=np.int64)
    active = np.ones((64, 1 << D), dtype=bool)
    for (z, coef, c), comb in zip(forms, combs):
        par = np.zeros(1 << D, dtype=np.int64)
        x = comb; b = 0
        while x:
            if x & 1:
                par ^= (V >> b) & 1
            x >>= 1; b += 1
        active[z] &= (par == c)
    S = (active * np.array(cz, dtype=np.int64)[:, None]).sum(axis=0)
    vals, cnts = np.unique(S, return_counts=True)
    return {"D": D, "ranks": ranks, "values": {int(v): int(n) for v, n in zip(vals, cnts)},
            "hits4096": int(cnts[vals == 4096].sum()) if (vals == 4096).any() else 0}


if __name__ == "__main__":
    from base12 import pack
    from poisson5 import Bv_table, equacoes
    from poisson3 import eq3
    from poisson3_lista import todos_subespacos3
    from collections import Counter
    out_path = sys.argv[sys.argv.index("--out") + 1] if "--out" in sys.argv else None
    shard = sys.argv[sys.argv.index("--shard") + 1] if "--shard" in sys.argv else "0/1"
    si, sm = map(int, shard.split("/"))
    Bb, Gb, Gk, piv = load_model(); Vs = todos_subespacos3()
    res = []
    for n, hx in enumerate(open(sys.argv[1]).read().split()):
        if n % sm != si:
            continue
        t0 = time.time()
        val = int(hx, 16)
        B = np.array([[(val >> (64 * k + z)) & 1 for z in range(64)] for k in range(15)], dtype=np.uint8)
        r = pack(B); comb = 0
        while r:
            c = r.bit_length() - 1; r ^= piv[c][0]; comb ^= piv[c][1]
        sel = [j for j in range(len(Bb)) if comb >> j & 1]
        G0 = np.bitwise_xor.reduce(Gb[sel], axis=0) if sel else np.zeros((64, 64), np.uint8)
        Bv = Bv_table(B)
        sol = solve_affine(equacoes(Bv, G0, Gk) + eq3(Bv, G0, Gk, Vs), Gk.shape[0])
        if sol is None:
            rec = {"polar": hx, "status": "L5+L3 empty"}
        else:
            rec = {"polar": hx, "dim_U": len(sol[1])}
            rec.update(analyse_polar(G0, Gk, sol[0], sol[1]))
        rec["seconds"] = round(time.time() - t0, 1)
        res.append(rec)
        rk = Counter(rec.get("ranks", []))
        print(hx[:12], "dim U", rec.get("dim_U"), "D", rec.get("D"), "ranks", dict(sorted(rk.items())),
              "values", rec.get("values"), "hits4096", rec.get("hits4096"), rec["seconds"], "s", flush=True)
        if out_path:
            json.dump(res, open(out_path, "w"), indent=1)
