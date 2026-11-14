"""Exact bent search through the joint Parseval patterns.

Every bent point theta satisfies
  (i)  the linearized degree-2 Poisson system (bitj.analyse) -> theta in p2 + span(k2);
  (ii) all 64 Parseval columns -> its activation pattern x (values of the activation forms restricted to that
       space) is one of the joint hits.
For each hit x the constraints 'basis forms = x' cut an affine subspace of p2 + span(k2); every point of it is
tested by the full Walsh spectrum (bent_batch_x).  No bent in any subspace  =>  the polar has no bent function.
Usage: python busca_padroes.py <polar hex> <out.json> [--maxD 26]"""
import os, sys, json, time
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
import bitj
from bitj import load_model, solve_affine, table_at, analyse, pack_table, bent_batch_x
from parseval_dominio import rank_radical, affine_in_w

par6 = np.array([bin(x).count("1") & 1 for x in range(64)], dtype=np.int64)


def joint_hits(T0, K, maxD):
    m = len(K)
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
    basis = {}; order_b = []
    for _, _, coef, _ in forms:
        x = coef
        while x:
            h = x.bit_length() - 1
            if h in basis:
                x ^= basis[h][0]
            else:
                basis[h] = (x, 1 << len(basis)); order_b.append(h); break
    combs = []
    for _, _, coef, _ in forms:
        x = coef; comb = 0
        while x:
            h = x.bit_length() - 1
            x ^= basis[h][0]; comb ^= basis[h][1]
        combs.append(comb)
    D = len(basis)
    if D > maxD:
        return None, D
    V = np.arange(1 << D, dtype=np.int64)
    pars = []
    for comb in combs:
        p = np.zeros(1 << D, dtype=np.int8); b = 0; x = comb
        while x:
            if x & 1:
                p ^= ((V >> b) & 1).astype(np.int8)
            x >>= 1; b += 1
        pars.append(p)
    czv = np.array(cz, dtype=np.int64)
    ok = np.ones(1 << D, dtype=bool)
    for bcol in range(64):
        active = np.ones((64, 1 << D), dtype=bool)
        for (z, rho, coef, c), p in zip(forms, pars):
            active[z] &= (p == (c ^ int(par6[bcol & rho])))
        ok &= ((active * czv[:, None]).sum(axis=0) == 4096)
        if not ok.any():
            break
    hits = np.nonzero(ok)[0].tolist()
    bvecs = [basis[h][0] for h in sorted(basis, key=lambda h: basis[h][1])]   # basis vector t has bit 1<<t
    return (hits, bvecs), D


if __name__ == "__main__":
    from base12 import pack
    from poisson5 import Bv_table, equacoes
    from poisson3 import eq3
    from poisson3_lista import todos_subespacos3
    hx, out_path = sys.argv[1], sys.argv[2]
    maxD = int(sys.argv[sys.argv.index("--maxD") + 1]) if "--maxD" in sys.argv else 26
    t0 = time.time()
    Bb, Gb, Gk, piv = load_model(); Vs = todos_subespacos3()
    val = int(hx, 16)
    B = np.array([[(val >> (64 * a + z)) & 1 for z in range(64)] for a in range(15)], dtype=np.uint8)
    r = pack(B); comb = 0
    while r:
        c = r.bit_length() - 1; r ^= piv[c][0]; comb ^= piv[c][1]
    sel = [j for j in range(len(Bb)) if comb >> j & 1]
    G0 = np.bitwise_xor.reduce(Gb[sel], axis=0) if sel else np.zeros((64, 64), np.uint8)
    Bv = Bv_table(B)
    part, ker = solve_affine(equacoes(Bv, G0, Gk) + eq3(Bv, G0, Gk, Vs), Gk.shape[0])
    status, hist = analyse(G0, Gk, part, ker, np.random.default_rng(1))
    rec = {"polar": hx, "analyse": status}
    if status == "alive":
        p2, k2, polys, order = analyse.final
        T0 = table_at(G0, Gk, p2); K = [table_at(np.zeros_like(G0), Gk, v) for v in k2]
        res, D = joint_hits(T0, K, maxD)
        rec.update(dim_after_analyse=len(k2), D=D)
        if res is None:
            rec["status"] = "D too large"
        else:
            hits, bvecs = res
            rec["hits"] = len(hits)
            Gp = pack_table(T0); Dp = np.array([pack_table(Ki) for Ki in K])
            m = len(k2); bent = 0; pts = 0
            sh = np.arange(m, dtype=np.int64)
            for x in hits:
                rows = [(bvecs[t], (x >> t) & 1) for t in range(len(bvecs))]
                sol = solve_affine(rows, m)
                if sol is None:
                    continue
                y0, Y = sol
                k = len(Y)
                Yb = ((np.array(Y, dtype=np.int64)[:, None] >> sh[None, :]) & 1).astype(np.int64) if k else np.zeros((0, m), np.int64)
                y0b = ((y0 >> sh) & 1).astype(np.uint8)
                for s in range(0, 1 << k, 1 << 16):
                    Tm = ((np.arange(s, min(s + (1 << 16), 1 << k))[:, None] >> np.arange(k)[None, :]) & 1).astype(np.int64)
                    X = ((Tm @ Yb) & 1).astype(np.uint8) ^ y0b
                    pts += len(X)
                    bent += bent_batch_x(Gp, Dp, X)
                    if bent:
                        break
                if bent:
                    break
            rec.update(points_tested=pts, bent=bent, status="BENT FOUND" if bent else "dead (no bent in any pattern subspace)")
    else:
        rec["status"] = "dead by analyse"
    rec["seconds"] = round(time.time() - t0, 1)
    json.dump(rec, open(out_path, "w"))
    print(json.dumps(rec))
