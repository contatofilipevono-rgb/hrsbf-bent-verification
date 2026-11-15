"""All 2^21 homogeneous polars: polar-only filters, without (Pf4).
  pass8  : the 8 phase-independent rows (z = 0, e_i, 63) do not exceed 4096 in any column;
  even   : N_d = #{z : B_z d = 0} is even for every d != 0 (parity);
  pf4    : the polar is one of the 18,816 (Pf4) polars.
Writes a uint8 flag array (bit0 pf4, bit1 pass8, bit2 even) to h12_flags.npy and a summary.
Usage: python h12_filtros_todos.py [processes]"""
import os, sys, json, itertools, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from multiprocessing import Pool

here = os.path.dirname(os.path.abspath(__file__))
PAIRS = list(itertools.combinations(range(6), 2))
ROWS = [0] + [1 << i for i in range(6)] + [63]


def setup():
    from base12 import orbitas, mobius, ZW, wtw, polar, pack, elim_comb, X
    from lista_polares import hexB
    from poisson5 import tabela
    ORB = [o for o in orbitas() if o[0] == 4]
    TT = []
    for o in ORB:
        t = np.zeros(4096, dtype=np.uint8)
        for m in o[2]:
            t ^= ((X & m) == m).astype(np.uint8)
        TT.append(t)
    AN = [mobius(t[ZW].copy(), 12) for t in TT]
    ind, ker = elim_comb([pack(a[wtw >= 3]) for a in AN])
    HV = [np.bitwise_xor.reduce([TT[i] for i in range(len(TT)) if k >> i & 1], axis=0) for k in ker]
    Bs = [polar(t)[0] for t in HV]
    pind, pker = elim_comb([pack(B) for B in Bs])
    PB = [Bs[i.bit_length() - 1] for i in pind]; PF = [HV[i.bit_length() - 1] for i in pind]
    rows = np.array([[int(sum(int(B[k][z]) << k for k in range(15))) for z in range(64)] for B in PB], dtype=np.int64)
    lam63 = []
    for f in PF:
        G = tabela(f)
        lam63.append(int(sum(int(G[63, 1 << i] ^ G[63, 0]) << i for i in range(6))))
    Pint = [int(hexB(B), 16) for B in PB]
    return rows, np.array(lam63, dtype=np.int64), Pint


def tables():
    W = np.arange(64)
    qtab = np.zeros((1 << 15, 64), dtype=np.int64)
    Bd = np.zeros((1 << 15, 64), dtype=np.int64)        # B d as 6-bit mask
    for bits in range(1 << 15):
        q = np.zeros(64, dtype=np.int64)
        for k, (i, j) in enumerate(PAIRS):
            if bits >> k & 1:
                q ^= ((W >> i) & 1) & ((W >> j) & 1)
                Bd[bits] ^= (((W >> j) & 1) << i) ^ (((W >> i) & 1) << j)
        qtab[bits] = q
    H = np.array([[1 - 2 * (bin(a & b).count("1") & 1) for b in range(64)] for a in range(64)])
    R = (1 - 2 * qtab) @ H
    act = (R != 0)
    wt = (R ** 2).max(axis=1)
    kerd = (Bd == 0)                                    # kerd[B, d]: d in rad B
    return act, wt, kerd


G = {}


def init():
    G["rows"], G["lam63"], _ = setup()
    G["act"], G["wt"], G["kerd"] = tables()


def work(args):
    s, e = args
    rows, lam63, act, wt, kerd = G["rows"], G["lam63"], G["act"], G["wt"], G["kerd"]
    n = rows.shape[0]
    codes = np.arange(s, e, dtype=np.int64)
    R = np.zeros((e - s, 64), dtype=np.int64); L = np.zeros(e - s, dtype=np.int64)
    for j in range(n):
        sel = ((codes >> j) & 1).astype(bool)
        R[sel] ^= rows[j]; L[sel] ^= lam63[j]
    bidx = np.arange(64)[None, :]
    col = np.zeros((e - s, 64), dtype=np.int64)
    for z in ROWS:
        q = R[:, z]
        lam = L if z == 63 else np.zeros_like(L)
        col += act[q[:, None], bidx ^ lam[:, None]] * wt[q][:, None]
    pass8 = (col <= 4096).all(axis=1)
    N = np.zeros((e - s, 64), dtype=np.int64)
    for z in range(64):
        N += kerd[R[:, z]]
    even = ((N[:, 1:] % 2) == 0).all(axis=1)
    return s, pass8, even


if __name__ == "__main__":
    procs = int(sys.argv[1]) if len(sys.argv) > 1 else 4
    rows, lam63, Pint = setup()
    n = rows.shape[0]
    listed = {int(h, 16) for h in open(os.path.join(here, "polares_18816.txt")).read().split()}
    cur = [0]
    for v in Pint:
        cur = cur + [x ^ v for x in cur]
    pf4 = np.array([x in listed for x in cur])
    del cur
    N = 1 << n; CH = 1 << 14
    flags = np.zeros(N, dtype=np.uint8); flags[pf4] |= 1
    with Pool(procs, initializer=init) as pool:
        for s, p8, ev in pool.imap_unordered(work, [(s, min(N, s + CH)) for s in range(0, N, CH)]):
            flags[s:s + len(p8)] |= (p8.astype(np.uint8) << 1) | (ev.astype(np.uint8) << 2)
    np.save(os.path.join(here, "h12_flags.npy"), flags)
    c = collections.Counter(flags.tolist())
    name = lambda f: "pf4=%d pass8=%d even=%d" % (f & 1, f >> 1 & 1, f >> 2 & 1)
    for f, v in sorted(c.items()):
        print(name(f), v)
    print("survive pass8 & even (no Pf4):", int(((flags & 6) == 6).sum()), "| and Pf4:", int((flags == 7).sum()))
