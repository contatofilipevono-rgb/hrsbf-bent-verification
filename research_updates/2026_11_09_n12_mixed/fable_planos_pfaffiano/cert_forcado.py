"""Lower-bound certificates: rows forced active on a whole affine space.

In column b, row z contributes 2^(12 - rank B_z) to E_b iff  g(z,rho) + b.rho + L_zrho(theta) = 0  for rho in a basis
of rad B_z.  On an affine space theta in P + span(Q) (here: the solution space of the mod-4 autocorrelation system,
which every bent theta must satisfy), the row is FORCED active when every such form vanishes identically there and
every constant is 0.  If the forced rows alone give more than 4096 in some column b, then E_b > 4096 on the whole
space: no bent function.  Linear algebra only.
Usage: python cert_forcado.py <polars file> [--out file.json]"""
import os, sys, json, time
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from bitj import load_model, solve_affine, table_at
from parseval_dominio import rank_radical, affine_in_w
from cert_colunas import pairs_of


def par(x):
    return bin(x).count("1") & 1


def forced(T0, K):
    m = len(K)
    pairs = pairs_of(T0, K)
    by_d = {}
    for z, d, form, g in pairs:
        if d:
            by_d.setdefault(d, []).append((form, g))
    rows = []
    for d in range(1, 64):
        t = by_d.get(d, []); mask = 0; rhs = (len(t) // 2) & 1
        for form, g in t:
            mask ^= form; rhs ^= g
        rows.append((mask, rhs))
    sol = solve_affine(rows, m)
    if sol is None:
        return {"level": "mod4"}
    P, Q = sol
    rad_info = []
    for z in range(64):
        rk, rad = rank_radical(T0[z])
        ent = []
        for rho in rad:
            form = 0
            for i in range(m):
                if K[i][z][rho] ^ K[i][z][0]:
                    form |= 1 << i
            ent.append((rho, form, int(T0[z][rho] ^ T0[z][0])))
        rad_info.append((1 << (12 - rk), ent))
    best = (0, None, None)
    for b in range(64):
        tot = 0; frows = []
        for z, (cz, ent) in enumerate(rad_info):
            if all(all(par(form & q) == 0 for q in Q) and (g ^ par(b & rho) ^ par(form & P)) == 0 for rho, form, g in ent):
                tot += cz; frows.append(z)
        if tot > best[0]:
            best = (tot, b, frows)
    out = {"mod4_solution_dim": len(Q), "max_forced_sum": best[0], "column": best[1], "forced_rows": best[2]}
    out["level"] = "forced" if best[0] > 4096 else "open"
    return out


if __name__ == "__main__":
    from base12 import pack
    from poisson5 import Bv_table, equacoes
    from poisson3 import eq3
    from poisson3_lista import todos_subespacos3
    out_path = sys.argv[sys.argv.index("--out") + 1] if "--out" in sys.argv else None
    Bb, Gb, Gk, piv = load_model(); Vs = todos_subespacos3()
    res = []
    for hx in open(sys.argv[1]).read().split():
        t0 = time.time(); val = int(hx, 16)
        B = np.array([[(val >> (64 * a + z)) & 1 for z in range(64)] for a in range(15)], dtype=np.uint8)
        r = pack(B); comb = 0
        while r:
            c = r.bit_length() - 1; r ^= piv[c][0]; comb ^= piv[c][1]
        sel = [j for j in range(len(Bb)) if comb >> j & 1]
        G0 = np.bitwise_xor.reduce(Gb[sel], axis=0) if sel else np.zeros((64, 64), np.uint8)
        Bv = Bv_table(B)
        part, ker = solve_affine(equacoes(Bv, G0, Gk) + eq3(Bv, G0, Gk, Vs), Gk.shape[0])
        T0 = table_at(G0, Gk, part); K = [table_at(np.zeros_like(G0), Gk, v) for v in ker]
        assert all(affine_in_w(Ki[z]) for Ki in K for z in range(64))
        rec = {"polar": hx, "dim_U": len(ker), "part": hex(part), "ker": [hex(v) for v in ker]}
        rec.update(forced(T0, K)); rec["seconds"] = round(time.time() - t0, 1)
        res.append(rec)
        print(hx[:12], rec["level"], "forced sum", rec.get("max_forced_sum"), "column", rec.get("column"),
              "rows", len(rec.get("forced_rows") or []), flush=True)
        if out_path:
            json.dump(res, open(out_path, "w"))
