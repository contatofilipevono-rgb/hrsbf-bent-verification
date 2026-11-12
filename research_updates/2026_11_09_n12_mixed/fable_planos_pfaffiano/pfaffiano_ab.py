# Depois de (Pf4): percorre os B completos (25 dimensoes) cujo topo passa, impõe tambem Pf(B_0) = 0
# (posto de B_0 <= 4) e lista os pares (a, b) com a != 0 e b != 0 que sobram, com perfis de posto.
import os, pickle, itertools
from collections import Counter
import numpy as np
from base12 import mobius, elim_comb, pack, PAIRS, forma
from testemunhas12 import BA, BB, coords, posto, matriz

here = os.path.dirname(os.path.abspath(__file__))
Bs = pickle.load(open(os.path.join(here, "base12.pkl"), "rb"))["B"]
ZP = [(1 << i) | (1 << j) for i, j in PAIRS]
pidx = {p: k for k, p in enumerate(PAIRS)}
quads = list(itertools.combinations(range(6), 4))
ind, _ = elim_comb([pack(B) for B in Bs])
base = np.array([Bs[i.bit_length() - 1] for i in ind])               # 25 x 15 x 64
tops = np.array([[mobius(B[k], 6)[ZP] for k in range(15)] for B in base], dtype=np.uint8)
ti, tk = elim_comb([pack(t) for t in tops])
print("dim B:", len(base), "| dim topo:", len(ti), "| direcoes sem topo:", len(tk))


def splits(S):
    a, b, c, e = S
    return [((a, b), (c, e)), ((a, c), (b, e)), ((a, e), (b, c))]


def pf4_top(t):                                                     # t: 15 x 15 (entrada, monomio)
    for S in quads:
        acc = np.zeros(15, np.uint8)
        for P, Pc in splits(S):
            q, r = t[pidx[P]], t[pidx[Pc]]
            for s, Sz in enumerate(quads):
                for A, Ac in splits(Sz):
                    acc[s] ^= (q[pidx[A]] & r[pidx[Ac]]) ^ (q[pidx[Ac]] & r[pidx[A]])
        if acc.any(): return False
    return True


# enumera combinacoes das direcoes com topo (21) por Gray, testando (Pf4) vetorizado como em pfaffiano.py
T = np.array([tops[i.bit_length() - 1] for i in ti]); d = len(T)
N = 1 << d
allT = np.zeros((N, 15, 15), np.uint8)
for i in range(d): allT[1 << i:2 << i] = allT[:1 << i] ^ T[i]
ok = np.ones(N, bool)
for S in quads:
    acc = np.zeros((N, 15), np.uint8)
    for P, Pc in splits(S):
        q, r = allT[:, pidx[P]], allT[:, pidx[Pc]]
        for s, Sz in enumerate(quads):
            for A, Ac in splits(Sz):
                acc[:, s] ^= (q[:, pidx[A]] & r[:, pidx[Ac]]) ^ (q[:, pidx[Ac]] & r[:, pidx[A]])
    ok &= ~acc.any(axis=1)
del allT
passam = np.flatnonzero(ok)
print("topos que passam:", len(passam))
Btop = [base[i.bit_length() - 1] for i in ti]
Blow = [np.bitwise_xor.reduce(base[[j for j in range(len(base)) if k >> j & 1]], axis=0) for k in tk]
tab = Counter(); perfis = {}
for code in passam:
    B0 = np.zeros((15, 64), np.uint8)
    for i in range(d):
        if code >> i & 1: B0 ^= Btop[i]
    for low in range(1 << len(Blow)):
        B = B0.copy()
        for i in range(len(Blow)):
            if low >> i & 1: B ^= Blow[i]
        a = coords(forma(B, 27, 54), BA); b = coords(forma(B, 21, 42), BB)
        r0 = posto(matriz(B, 0))
        tab[(a, b, r0 <= 4)] += 1
print("pares (a, b) com a != 0 e b != 0 que passam em (Pf4) e Pf(B_0) = 0:")
vivos = sorted({(a, b) for (a, b, s), v in tab.items() if s and any(a) and any(b)})
for a, b in vivos: print("   a =", a, "b =", b, "| B's:", tab[(a, b, True)])
print("total de pares vivos:", len(vivos), "de 49")
mortos_B0 = sorted({(a, b) for (a, b, s) in tab if any(a) and any(b)} - set(vivos))
print("pares que so tinham B com B_0 de posto 6:", mortos_B0)
print("B's que passam em (Pf4):", sum(tab.values()), "| com B_0 singular:", sum(v for (a, b, s), v in tab.items() if s))
