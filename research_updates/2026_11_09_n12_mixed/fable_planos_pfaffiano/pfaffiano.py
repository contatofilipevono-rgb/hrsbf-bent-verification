# Condicao (Pf4), sem fase: para f bent com grau <= 2 em w, cada menor Pfaffiano 4 x 4 de B_z
#   gamma_2(B_z)_{ijkl} = B_ij B_kl + B_ik B_jl + B_il B_jk
# tem grau <= 3 em z.  So as partes quadraticas (topo) das entradas de B entram no termo de grau 4.
# Enumera o espaco dos topos de B e lista os pares (topo de beta_a, topo de beta_b) que sobrevivem.
#   topo de beta_a em <p1, p2> = (a1, a2);  topo de beta_b em <p1, p2, p3> = (b1, b2, b3)
import os, pickle, itertools
from collections import Counter
import numpy as np
from base12 import mobius, elim_comb, pack, PAIRS, forma

here = os.path.dirname(os.path.abspath(__file__))
Bs = pickle.load(open(os.path.join(here, "base12.pkl"), "rb"))["B"]
ZP = [(1 << i) | (1 << j) for i, j in PAIRS]                       # 15 monomios quadraticos em z
tops = np.array([[mobius(B[k], 6)[ZP] for k in range(15)] for B in Bs], dtype=np.uint8)     # 68 x 15 x 15
ind, _ = elim_comb([pack(t) for t in tops])
T = np.array([tops[i.bit_length() - 1] for i in ind])               # base dos topos
d = len(T)
print("dimensao do espaco dos topos quadraticos de B:", d)
# todas as combinacoes
N = 1 << d
allT = np.zeros((N, 15, 15), np.uint8)
for i in range(d):
    allT[1 << i:2 << i] = allT[:1 << i] ^ T[i]
pidx = {p: k for k, p in enumerate(PAIRS)}
quads = list(itertools.combinations(range(6), 4))


def splits(S):
    a, b, c, e = S
    return [((a, b), (c, e)), ((a, c), (b, e)), ((a, e), (b, c))]


def prod4(q, r):
    """parte multilinear de grau 4 do produto de duas quadraticas (N x 15 cada) -> N x 15 (por 4-conjunto de z)."""
    out = np.zeros((q.shape[0], 15), np.uint8)
    for s, S in enumerate(quads):
        for P, Pc in splits(S):
            out[:, s] ^= (q[:, pidx[P]] & r[:, pidx[Pc]]) ^ (q[:, pidx[Pc]] & r[:, pidx[P]])
    return out


ok = np.ones(N, bool)
for S in quads:                                                     # indices i<j<k<l das coordenadas de w
    acc = np.zeros((N, 15), np.uint8)
    for P, Pc in splits(S):
        acc ^= prod4(allT[:, pidx[P]], allT[:, pidx[Pc]])
    ok &= ~acc.any(axis=1)
print("topos que passam em (Pf4):", int(ok.sum()), "de", N)


def forma_top(u, v):
    out = np.zeros((N, 15), np.uint8)
    for k, (i, j) in enumerate(PAIRS):
        if ((u >> i & v >> j) ^ (u >> j & v >> i)) & 1: out ^= allT[:, k]
    return out


ta = forma_top(27, 54); tb = forma_top(21, 42)
# coordenadas: p1 = z_i z_{i+1}, p2 = z_i z_{i+2}, p3 = z_i z_{i+3}
c1, c2, c3 = pidx[(0, 1)], pidx[(0, 2)], pidx[(0, 3)]
tab = Counter()
for n in np.flatnonzero(ok):
    tab[((int(ta[n, c1]), int(ta[n, c2])), (int(tb[n, c1]), int(tb[n, c2]), int(tb[n, c3])))] += 1
print("((a1, a2), (b1, b2, b3)) dos topos que passam -> contagem")
for k, v in sorted(tab.items()): print(" ", k, v, "" if (k[0] == (0, 0) or k[1] == (0, 0, 0)) else "<- ambos nao nulos")
todos = Counter()
for n in range(N):
    todos[((int(ta[n, c1]), int(ta[n, c2])), (int(tb[n, c1]), int(tb[n, c2]), int(tb[n, c3])))] += 1
print("classes de topo antes do filtro:", len(todos), "| depois:", len(tab))
