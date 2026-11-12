# Levantamento linear em subespacos V de dimensao 3 de W, somado ao dos hiperplanos (poisson5.py).
#   K_z = soma de (-1)^{f(z, w0+s)} em s em V:  0 ou +-4 se B_z|_V tem posto 2 (ativo sse D_r f(z, w0) = 0,
#   r = b23 v1 + b13 v2 + b12 v3), e 0 mod 8 caso contrario;  a transformada em z esta em 16 Z;  logo
#   (L3)   sum_{z contem I, posto(B_z|_V) = 2} (1 + D_{r_z} f(z, w0)) = 0 (mod 2),   |I| <= 1.
# Sonda: amostra de subespacos V, numa classe (a, b) dada, sobre as polares que passam em (L5).
# Uso: python poisson3.py <a> <b> <numero de subespacos>      ex.: python poisson3.py 100 001 150
import os, sys, pickle, random, itertools
import numpy as np
from base12 import mobius, elim_comb, pack, PAIRS, forma
from testemunhas12 import BA, BB, coords
from poisson5 import tabela, Bv_table, equacoes, viavel, par6, Zs, MI

here = os.path.dirname(os.path.abspath(__file__))
M7 = MI[:7]


def subespacos3(n, rng):
    out = set()
    while len(out) < n:
        vs = rng.sample(range(1, 64), 3)
        if vs[0] ^ vs[1] == vs[2]: continue
        span = {0}
        for v in vs: span |= {s ^ v for s in span}
        if len(span) == 8: out.add(tuple(sorted(span)))
    return [sorted(s) for s in out]


def eq3(Bv, G0, Gk, Vs):
    rows = []
    for span in Vs:
        v1 = span[1]; v2 = next(v for v in span if v not in (0, v1)); v3 = next(v for v in span if v not in (0, v1, v2, v1 ^ v2))
        b12 = par6[Bv[:, v1] & v2]; b13 = par6[Bv[:, v1] & v3]; b23 = par6[Bv[:, v2] & v3]
        m2 = (b12 | b13 | b23).astype(bool)
        if not m2.any(): continue
        r = (b23 * v1) ^ (b13 * v2) ^ (b12 * v3)
        reps = []; visto = set()
        for w in range(64):
            if w not in visto: reps.append(w); visto |= {w ^ s for s in span}
        Mm = M7 * m2.astype(np.int64)
        for w0 in reps:
            d0 = (G0[Zs, w0 ^ r] ^ G0[Zs, w0]).astype(np.int64)
            dk = (Gk[:, Zs, w0 ^ r] ^ Gk[:, Zs, w0]).astype(np.int64)
            rhs = (Mm @ (1 ^ d0)) & 1
            co = (Mm @ dk.T) & 1
            for i in range(7):
                rows.append((sum(1 << int(k) for k in np.flatnonzero(co[i])), int(rhs[i])))
    return rows


if __name__ == "__main__":
    alvo_a = tuple(int(c) for c in sys.argv[1]); alvo_b = tuple(int(c) for c in sys.argv[2]); nV = int(sys.argv[3])
    D = pickle.load(open(os.path.join(here, "base12.pkl"), "rb"))
    base, Bs = D["base"], D["B"]
    ind, ker = elim_comb([pack(B) for B in Bs])
    fb = [base[i.bit_length() - 1] for i in ind]; Bb = [Bs[i.bit_length() - 1] for i in ind]
    Hk = [np.bitwise_xor.reduce([base[j] for j in range(len(base)) if k >> j & 1], axis=0) for k in ker]
    Gk = np.array([tabela(h) for h in Hk]); Gb = np.array([tabela(f) for f in fb])
    ZP = [(1 << i) | (1 << j) for i, j in PAIRS]
    tops = np.array([[mobius(B[k], 6)[ZP] for k in range(15)] for B in Bb], dtype=np.uint8)
    ti, tk = elim_comb([pack(t) for t in tops])
    topi = [i.bit_length() - 1 for i in ti]
    lows = [[j for j in range(len(Bb)) if k >> j & 1] for k in tk]
    vivos = pickle.load(open(os.path.join(here, "vivos_L5.pkl"), "rb"))
    Vs = subespacos3(nV, random.Random(11))
    tot = ok = 0
    for code, low in vivos:
        sel = set(topi[i] for i in range(len(ti)) if code >> i & 1)
        for i in range(len(lows)):
            if low >> i & 1: sel ^= set(lows[i])
        sel = sorted(sel)
        B = np.bitwise_xor.reduce([Bb[j] for j in sel], axis=0)
        if coords(forma(B, 27, 54), BA) != alvo_a or coords(forma(B, 21, 42), BB) != alvo_b: continue
        G0 = np.bitwise_xor.reduce(Gb[sel], axis=0); Bv = Bv_table(B)
        v, _ = viavel(equacoes(Bv, G0, Gk) + eq3(Bv, G0, Gk, Vs))
        tot += 1; ok += v
        if tot % 50 == 0: print(tot, ok, flush=True)
    print("classe a =", alvo_a, "b =", alvo_b, ": passam em (L5) + (L3 amostrado,", nV, "subespacos):", ok, "de", tot)
