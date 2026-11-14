"""Parseval in ALL 64 Walsh columns at once, on the whole (L5)+(L3) domain U.

Column b:  r_b(z) = sum_w (-1)^{f(z,w) + b.w},  sum_z r_b(z)^2 = 4096 for every b if f is bent.
b.w is linear in w, so the polar B_z is unchanged and row z is active in column b iff
   L_{z,rho}(u) = c_{z,rho} + b.rho   for every rho in a basis of rad B_z
(the same linear forms as for b = 0, only the constants move).  So one enumeration of F_2^D decides the
joint condition "all 64 columns equal 4096 at the same u".
Usage: python parseval_colunas.py <polars file> [--shard i/n] [--out file.json]"""
import os, sys, json, time
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from bitj import load_model, solve_affine, table_at
from parseval_dominio import rank_radical, affine_in_w

par6 = np.array([bin(x).count("1") & 1 for x in range(64)], dtype=np.int64)


def analyse_all_columns(G0, Gk, part, ker, max_D=22):
    m = len(ker)
    T0 = table_at(G0, Gk, part)
    K = [table_at(np.zeros_like(G0), Gk, ker[i]) for i in range(m)]
    assert all(affine_in_w(Ki[z]) for Ki in K for z in range(64))
    forms = []; cz = []
    for z in range(64):
        rk, rad = rank_radical(T0[z])
        cz.append(1 << (12 - rk))
        for rho in rad:
            coef = 0
            for i in range(m):
                if K[i][z][rho] ^ K[i][z][0]:
                    coef |= 1 << i
            forms.append((z, rho, coef, int(T0[z][rho] ^ T0[z][0])))
    basis = {}
    for _, _, coef, _ in forms:
        x = coef
        while x:
            h = x.bit_length() - 1
            if h in basis:
                x ^= basis[h][0]
            else:
                basis[h] = (x, 1 << len(basis)); break
    combs = []
    for _, _, coef, _ in forms:
        x = coef; comb = 0
        while x:
            h = x.bit_length() - 1
            x ^= basis[h][0]; comb ^= basis[h][1]
        combs.append(comb)
    D = len(basis)
    if D > max_D:
        return {"D": D, "skipped": True}
    V = np.arange(1 << D, dtype=np.int64)
    pars = []
    for comb in combs:
        p = np.zeros(1 << D, dtype=np.int8); b = 0; x = comb
        while x:
            if x & 1:
                p ^= ((V >> b) & 1).astype(np.int8)
            x >>= 1; b += 1
        pars.append(p)
    cz = np.array(cz, dtype=np.int64)
    ok = np.ones(1 << D, dtype=bool)
    per_col = []
    for bcol in range(64):
        active = np.ones((64, 1 << D), dtype=bool)
        for (z, rho, coef, c), p in zip(forms, pars):
            active[z] &= (p == (c ^ int(par6[bcol & rho])))
        S = (active * cz[:, None]).sum(axis=0)
        hit = S == 4096
        per_col.append(int(hit.sum()))
        ok &= hit
        if not ok.any():
            return {"D": D, "joint_hits": 0, "dies_at_column": bcol, "hits_per_column_so_far": per_col}
    return {"D": D, "joint_hits": int(ok.sum()), "dies_at_column": None, "hits_per_column": per_col}


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
        sol = solve_affine(equacoes(Bv, G0, Gk) + eq3(Bv, G0, Gk, Vs), Gk.shape[0])
        rec = {"polar": hx, "dim_U": len(sol[1])}
        rec.update(analyse_all_columns(G0, Gk, sol[0], sol[1]))
        rec["seconds"] = round(time.time() - t0, 1)
        res.append(rec)
        print(hx[:12], "D", rec["D"], "joint hits", rec.get("joint_hits"), "dies at column", rec.get("dies_at_column"),
              rec["seconds"], "s", flush=True)
        if out_path:
            json.dump(res, open(out_path, "w"))
