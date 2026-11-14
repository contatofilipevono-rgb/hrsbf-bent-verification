"""Single-column residue certificates for the polars where 4096 is attainable in column 0.

Column b: E_b(theta) = 64 sum_{(z,d), d in rad B_z} (-1)^{f0(z,d)+f0(z,0)+b.d+L_zd(theta)},
so the weights are n^(b)_L = sum of signs (-1)^{f0(z,d)+f0(z,0)+b.d} over the pairs with form L.
If for some b the character certificate proves E_b constant mod 2048 with nonzero residue, no u in U is bent.
Usage: python cert_colunas.py <polars file> [--shard i/n] [--out file.json]"""
import os, sys, json, time
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from bitj import load_model, solve_affine, table_at
from parseval_dominio import rank_radical, affine_in_w
from cert_parseval import span, certificate


def pairs_of(T0, K):
    m = len(K); out = []
    for z in range(64):
        rk, rad = rank_radical(T0[z])
        for d in span(rad):
            form = 0
            for i in range(m):
                if K[i][z][d] ^ K[i][z][0]:
                    form |= 1 << i
            out.append((z, d, form, int(T0[z][d] ^ T0[z][0])))
    return out


def weights_col(pairs, b):
    n = {}
    for z, d, form, g in pairs:
        s = g ^ (bin(b & d).count("1") & 1)
        n[form] = n.get(form, 0) + (1 - 2 * s)
    return {L: v for L, v in n.items() if v}


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
        T0 = table_at(G0, Gk, part); K = [table_at(np.zeros_like(G0), Gk, v) for v in ker]
        assert all(affine_in_w(Ki[z]) for Ki in K for z in range(64))
        pairs = pairs_of(T0, K)
        cols = {}
        for b in range(64):
            c = certificate(weights_col(pairs, b))
            if c["ok"] and c["residue"] != 0:
                cols[b] = {"residue": c["residue"], "method": c["method"], "s": c["s"]}
        rec = {"polar": hx, "dim_U": len(ker), "part": hex(part), "ker": [hex(v) for v in ker],
               "certified_columns": cols, "seconds": round(time.time() - t0, 1)}
        res.append(rec)
        print(hx[:12], "columns with a residue certificate:", len(cols), sorted(cols)[:8], rec["seconds"], "s", flush=True)
        if out_path:
            json.dump(res, open(out_path, "w"))
