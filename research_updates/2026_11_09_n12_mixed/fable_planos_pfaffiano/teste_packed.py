"""Cross-check bent_test_packed against bent_test_vec: pack/unpack orientation, row sums,
and on real polars the number of tables passing the column-0 prefilter and the bent count
(with c=4 so that the Gray-code part is exercised)."""
import os, sys, time, functools
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
import bitj
from bitj import *

rng = np.random.default_rng(7)
Ts = rng.integers(0, 2, (20, 64, 64), dtype=np.uint8)
for G in Ts:
    P = pack_table(G)
    U = np.unpackbits(P.view(np.uint8).reshape(64, 8), axis=1, bitorder="little")
    assert (U == G).all()
    rs = 64 - 2 * POP8[P.view(np.uint8).reshape(64, 8)].sum(axis=1)
    assert (rs == (1 - 2 * G.astype(int)).sum(axis=1)).all()
print("pack/unpack and row sums ok")

from base12 import pack
from poisson5 import Bv_table, equacoes
from poisson3 import eq3
from poisson3_lista import todos_subespacos3
Bb, Gb, Gk, piv = load_model(); Vs = todos_subespacos3()
orig = bitj.bent_test_packed
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
    res = []
    for name, fn in (("packed c=4", functools.partial(orig, c=4)), ("vec", bitj.bent_test_vec)):
        bitj.bent_test_packed = fn; bitj.PASSED[0] = 0
        t = time.time(); out = exclude_vec(G0, Gk, p2, k2, polys, order)
        res.append((out, bitj.PASSED[0])); print(hx[:12], name, out, "passed", bitj.PASSED[0], round(time.time() - t, 2), "s")
    print("OK" if res[0] == res[1] else "MISMATCH")
bitj.bent_test_packed = orig
