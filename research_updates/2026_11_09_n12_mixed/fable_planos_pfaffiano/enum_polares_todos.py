"""All polars of the 68-dim model that pass the (Pf4) top filter and (L5), WITHOUT skipping the plane-covered
signatures (poisson5.py skips a = 0 or b = 0).  Same enumeration otherwise: top codes passing the 4x4-Pfaffian
quadric test, times all low parts.
Usage: python enum_polares_todos.py count
       python enum_polares_todos.py run <shard i/n> <out.json>"""
import os, sys, json, itertools, time
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
import pickle
from base12 import mobius, elim_comb, pack, PAIRS, forma
from testemunhas12 import BA, BB, coords
from poisson5 import Bv_table, equacoes, viavel, tabela
from lista_polares import hexB

here = os.path.dirname(os.path.abspath(__file__))


def setup():
    D = pickle.load(open(os.path.join(here, "base12.pkl"), "rb"))
    base, Bs = D["base"], D["B"]
    ind, ker = elim_comb([pack(B) for B in Bs])
    fb = [base[i.bit_length() - 1] for i in ind]; Bb = [Bs[i.bit_length() - 1] for i in ind]
    Hk = [np.bitwise_xor.reduce([base[j] for j in range(len(base)) if k >> j & 1], axis=0) for k in ker]
    Gk = np.array([tabela(h) for h in Hk]); Gb = np.array([tabela(f) for f in fb])
    ZP = [(1 << i) | (1 << j) for i, j in PAIRS]
    pidx = {p: k for k, p in enumerate(PAIRS)}
    quads = list(itertools.combinations(range(6), 4))
    tops = np.array([[mobius(B[k], 6)[ZP] for k in range(15)] for B in Bb], dtype=np.uint8)
    ti, tk = elim_comb([pack(t) for t in tops])
    d = len(ti); N = 1 << d
    T = np.array([tops[i.bit_length() - 1] for i in ti])
    allT = np.zeros((N, 15, 15), np.uint8)
    for i in range(d):
        allT[1 << i:2 << i] = allT[:1 << i] ^ T[i]
    ok = np.ones(N, bool)
    def sp(S):
        a, b, c, e = S
        return [((a, b), (c, e)), ((a, c), (b, e)), ((a, e), (b, c))]
    for S in quads:
        acc = np.zeros((N, 15), np.uint8)
        for P, Pc in sp(S):
            q, r = allT[:, pidx[P]], allT[:, pidx[Pc]]
            for s, Sz in enumerate(quads):
                for A, Ac in sp(Sz):
                    acc[:, s] ^= (q[:, pidx[A]] & r[:, pidx[Ac]]) ^ (q[:, pidx[Ac]] & r[:, pidx[A]])
        ok &= ~acc.any(axis=1)
    topi = [i.bit_length() - 1 for i in ti]
    lows = [[j for j in range(len(Bb)) if k >> j & 1] for k in tk]
    codes = [int(c) for c in np.flatnonzero(ok)]
    return Bb, Gb, Gk, topi, lows, codes


if __name__ == "__main__":
    Bb, Gb, Gk, topi, lows, codes = setup()
    total = len(codes) << len(lows)
    if sys.argv[1] == "count":
        print("top codes passing (Pf4):", len(codes), " low parts:", 1 << len(lows), " polars:", total)
        sys.exit(0)
    si, sm = map(int, sys.argv[2].split("/")); out_path = sys.argv[3]
    res = []; k = -1
    for code in codes:
        sel0 = [topi[i] for i in range(len(topi)) if code >> i & 1]
        for low in range(1 << len(lows)):
            k += 1
            if k % sm != si:
                continue
            sel = set(sel0)
            for i in range(len(lows)):
                if low >> i & 1:
                    sel ^= set(lows[i])
            sel = sorted(sel)
            B = np.bitwise_xor.reduce([Bb[j] for j in sel], axis=0) if sel else np.zeros((15, 64), np.uint8)
            a = "".join(map(str, coords(forma(B, 27, 54), BA))); b = "".join(map(str, coords(forma(B, 21, 42), BB)))
            G0 = np.bitwise_xor.reduce(Gb[sel], axis=0) if sel else np.zeros((64, 64), np.uint8)
            v, rk = viavel(equacoes(Bv_table(B), G0, Gk))
            if v:
                res.append({"polar": hexB(B), "a": a, "b": b})
    json.dump(res, open(out_path, "w"))
    print("shard", si, "viable", len(res))
