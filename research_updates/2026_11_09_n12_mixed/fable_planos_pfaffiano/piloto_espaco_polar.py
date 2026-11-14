"""Pilot on the WHOLE polar space of the 68-dim model (25 polar + 43 phase directions, all f quadratic in w):
for random polars B = sum c_j Bb_j and for the bent-witness polars, run the elementary filters
  (L5)+(L3) linear -> autocorrelation in (0,d): odd / mod-4 system / mod 2^k -> forced rows
and record where each polar dies, with its plane signature (a, b) = coordinates of the polar on V_a, V_b.
Usage: python piloto_espaco_polar.py <N random> <seed> <out.json> [--bent]"""
import os, sys, json, time
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from bitj import load_model, solve_affine, table_at
from parseval_dominio import affine_in_w
from cert_autocorr import analyse
from cert_forcado import forced
from lista_polares import hexB


def run_polar(B, Bb, Gb, Gk, piv, Vs, pack, Bv_table, equacoes, eq3, forma, coords, BA, BB):
    r = pack(B); comb = 0
    while r:
        c = r.bit_length() - 1; r ^= piv[c][0]; comb ^= piv[c][1]
    sel = [j for j in range(len(Bb)) if comb >> j & 1]
    G0 = np.bitwise_xor.reduce(Gb[sel], axis=0) if sel else np.zeros((64, 64), np.uint8)
    Bv = Bv_table(B)
    a_ = "".join(map(str, coords(forma(B, 27, 54), BA))); b_ = "".join(map(str, coords(forma(B, 21, 42), BB)))
    rec = {"polar": hexB(B), "a": a_, "b": b_}
    sol = solve_affine(equacoes(Bv, G0, Gk) + eq3(Bv, G0, Gk, Vs), Gk.shape[0])
    if sol is None:
        rec["level"] = "L5+L3"; return rec
    part, ker = sol
    T0 = table_at(G0, Gk, part); K = [table_at(np.zeros_like(G0), Gk, v) for v in ker]
    assert all(affine_in_w(Ki[z]) for Ki in K for z in range(64))
    rec["dim_U"] = len(ker)
    out = analyse(T0, K)
    if out["level"] == "open":
        f = forced(T0, K)
        rec.update(level=f["level"], mod4_solution_dim=f.get("mod4_solution_dim"), max_forced_sum=f.get("max_forced_sum"))
    else:
        rec.update(level=out["level"], mod4_solution_dim=out.get("mod4_solution_dim"))
    return rec


if __name__ == "__main__":
    from base12 import pack, forma
    from testemunhas12 import BA, BB, coords
    from poisson5 import Bv_table, equacoes
    from poisson3 import eq3
    from poisson3_lista import todos_subespacos3
    N, seed, out_path = int(sys.argv[1]), int(sys.argv[2]), sys.argv[3]
    Bb, Gb, Gk, piv = load_model(); Vs = todos_subespacos3()
    Bbl = [np.array(x, dtype=np.uint8) for x in Bb]
    rng = np.random.default_rng(seed)
    polars = []
    if "--bent" in sys.argv:
        for hx in open(os.path.join(os.path.dirname(os.path.abspath(__file__)), "polares_bent.txt")).read().split():
            v = int(hx, 16)
            polars.append(("bent", np.array([[(v >> (64 * k + z)) & 1 for z in range(64)] for k in range(15)], dtype=np.uint8)))
    for _ in range(N):
        c = rng.integers(0, 2, len(Bbl))
        B = np.bitwise_xor.reduce([Bbl[j] for j in range(len(Bbl)) if c[j]], axis=0) if c.any() else np.zeros((15, 64), np.uint8)
        polars.append(("random", B))
    res = []
    for kind, B in polars:
        t0 = time.time()
        rec = run_polar(B, Bb, Gb, Gk, piv, Vs, pack, Bv_table, equacoes, eq3, forma, coords, BA, BB)
        rec["kind"] = kind; rec["seconds"] = round(time.time() - t0, 1)
        res.append(rec)
        json.dump(res, open(out_path, "w"))
    print("done", len(res))
