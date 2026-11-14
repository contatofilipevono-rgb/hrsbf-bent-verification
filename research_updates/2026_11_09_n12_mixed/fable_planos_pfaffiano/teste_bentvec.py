"""Check bent_test_vec / new exclude_vec against exclude_cover on real polars, and the float32 Walsh test
on a known bent function (inner product z.w) and on random tables."""
import os, sys, time
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
import bitj
from bitj import *

H = bitj.H64.astype(np.float32)
rng = np.random.default_rng(5)
Z = np.arange(64)
ip = np.array([[bin(z & w).count("1") & 1 for w in Z] for z in Z], np.uint8)
Ts = np.concatenate([ip[None], rng.integers(0, 2, (5, 64, 64), dtype=np.uint8)])
S = 1 - 2 * Ts.astype(np.float32)
fl = (np.abs(H @ S @ H) == 64).all(axis=(1, 2))
assert list(fl) == list(is_bent_batch(Ts)) and fl[0] and not fl[1:].any()
print("Walsh float32 ok")

from base12 import pack, forma
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
    st, _ = analyse(G0, Gk, part, ker, np.random.default_rng(1))
    p2, k2, polys, order = analyse.final
    t = time.time(); a = exclude_vec(G0, Gk, p2, k2, polys, order); t1 = time.time() - t
    t = time.time(); b = exclude_cover(G0, Gk, p2, k2, polys, order); t2 = time.time() - t
    print(hx[:12], "vec", a, round(t1, 1), "s  cover", b, round(t2, 1), "s", "OK" if a == b else "MISMATCH")
