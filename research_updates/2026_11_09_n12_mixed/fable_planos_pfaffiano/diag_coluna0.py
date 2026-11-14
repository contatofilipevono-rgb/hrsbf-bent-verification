"""Why do the Poisson survivors fail?  For every survivor table f(z, w) record the row sums r(z) = sum_w (-1)^f,
the Parseval sum sum_z r(z)^2 (a bent f needs 4096 = 64^2 for the column b = 0 to be flat),
the profile of |r(z)| values, and whether the column b = 0 is flat.
Usage: python diag_coluna0.py <polars file>"""
import os, sys
from collections import Counter
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
import bitj
from bitj import *

stats = {"n": 0, "parseval": Counter(), "flat": 0, "absr": Counter(), "zeros": Counter()}
orig = bitj.walsh_filter

def spy(T, Hf):
    rs = 64 - 2 * POP8[T.view(np.uint8).reshape(-1, 64, 8)].sum(axis=2)
    stats["n"] += len(rs)
    for row in rs[:4000]:
        stats["parseval"][int((row.astype(np.int64) ** 2).sum())] += 1
        stats["absr"][tuple(sorted(Counter(np.abs(row).tolist()).items()))] += 1
    stats["flat"] += int((np.abs(rs.astype(np.float32) @ Hf) == 64).all(axis=1).sum())
    return orig(T, Hf)

bitj.walsh_filter = spy
from base12 import pack
from poisson5 import Bv_table, equacoes
from poisson3 import eq3
from poisson3_lista import todos_subespacos3
Bb, Gb, Gk, piv = load_model(); Vs = todos_subespacos3()
for hx in open(sys.argv[1]).read().split():
    for k in stats:
        stats[k] = Counter() if isinstance(stats[k], Counter) else 0
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
    out = exclude_vec(G0, Gk, p2, k2, polys, order)
    print(hx[:12], "survivors", out[0], "tables seen", stats["n"], "flat column 0:", stats["flat"])
    print("   sum_z r(z)^2 (need 4096):", dict(stats["parseval"].most_common(6)))
    print("   |r(z)| profiles:", [dict(p) for p, _ in stats["absr"].most_common(3)])
