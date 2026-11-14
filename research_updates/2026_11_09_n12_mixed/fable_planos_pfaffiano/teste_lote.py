"""Positive-control check of bent_batch_x and bent_test_packed against brute force.
G0 = z.w (bent); directions: affine tables (bent + affine is bent) mixed with random tables,
so a known, nonzero number of combinations are bent.  Then real polars: timing + survivor count."""
import os, sys, time
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
import bitj
from bitj import *

Z = np.arange(64)
par = lambda v: np.array([bin(int(x)).count("1") & 1 for x in v.ravel()], np.uint8).reshape(v.shape)
ip = par(Z[:, None] & Z[None, :])
rng = np.random.default_rng(11)
for trial in range(4):
    dirs = []
    for i in range(10):
        if rng.random() < 0.6:
            a, b = rng.integers(0, 64, 2)
            dirs.append(par(Z[:, None] & a) ^ par(Z[None, :] & b))
        else:
            dirs.append(rng.integers(0, 2, (64, 64), dtype=np.uint8))
    Gk = np.array(dirs); m = len(dirs)
    allX = ((np.arange(1 << m)[:, None] >> np.arange(m)[None, :]) & 1).astype(np.uint8)
    tabs = np.array([table_at(ip, Gk, int(sum(int(b) << i for i, b in enumerate(x)))) for x in allX])
    brute = int(is_bent_batch(tabs).sum())
    Dp = np.array([pack_table(d) for d in dirs]); Gp = pack_table(ip)
    b1 = bent_batch_x(Gp, Dp, allX, chunk=100)
    # kernel path: x0 = 0, kernel = 10 unit vectors -> whole space; c=3 exercises the Gray part
    b2 = bent_test_packed(ip, Gk, 0, [1 << i for i in range(m)], [(0, [1 << i for i in range(m)])], [], [], c=3)
    b3 = bent_test_packed(ip, Gk, 0, [1 << i for i in range(m)], [(0, [1 << i for i in range(m)])], [], [], c=3, skip_zero=True)
    print("trial", trial, "brute", brute, "batch", b1, "kernel", b2, "kernel skip0", b3, "(+1)",
          "OK" if brute == b1 == b2 == b3 + 1 and brute > 1 else "MISMATCH")

if len(sys.argv) > 1:
    from base12 import pack
    from poisson5 import Bv_table, equacoes
    from poisson3 import eq3
    from poisson3_lista import todos_subespacos3
    Bb, Gb, Gk, piv = load_model(); Vs = todos_subespacos3()
    for hx in open(sys.argv[1]).read().split():
        val = int(hx, 16)
        B = np.array([[(val >> (64 * k + z)) & 1 for z in range(64)] for k in range(15)], dtype=np.uint8)
        r = pack(B); comb = 0
        while r:
            c = r.bit_length() - 1; r ^= piv[c][0]; comb ^= piv[c][1]
        sel = [j for j in range(len(Bb)) if comb >> j & 1]
        G0 = np.bitwise_xor.reduce(Gb[sel], axis=0) if sel else np.zeros((64, 64), np.uint8)
        Bv = Bv_table(B)
        part, ker = solve_affine(equacoes(Bv, G0, Gk) + eq3(Bv, G0, Gk, Vs), Gk.shape[0])
        analyse(G0, Gk, part, ker, np.random.default_rng(1))
        p2, k2, polys, order = analyse.final
        bitj.PASSED[0] = 0
        t = time.time(); out = exclude_vec(G0, Gk, p2, k2, polys, order)
        print(hx[:12], out, "passed prefilter", bitj.PASSED[0], round(time.time() - t, 1), "s", flush=True)
