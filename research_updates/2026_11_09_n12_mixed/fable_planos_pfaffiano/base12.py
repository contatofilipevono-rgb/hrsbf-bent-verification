# Cobertura pelos dois planos (n = 12, grau <= 4): base independente do modelo da reta 63.
# f(z, w) nas coordenadas z = a + b, w = b.  Espaco RS de grau <= 4 (dim 70) e o subespaco de grau <= 2 em w.
#   f = alpha(z) + lambda(z).w + sum_{i<j} B_ij(z) w_i w_j
# beta_a(z) = B_z(27, 54) = D_27 D_54 f,   beta_b(z) = B_z(21, 42) = D_21 D_42 f.
# Uso: python base12.py   (grava base12.pkl)
import itertools, os, pickle
import numpy as np

rot12 = lambda x: ((x << 1) | (x >> 11)) & 4095
X = np.arange(4096)
PAIRS = list(itertools.combinations(range(6), 2))


def orbitas(maxdeg=4):
    seen = set(); out = []
    for d in range(maxdeg + 1):
        for c in itertools.combinations(range(12), d):
            m = sum(1 << i for i in c)
            if m in seen: continue
            o = set(); y = m
            for _ in range(12): o.add(y); y = rot12(y)
            seen |= o; out.append((d, min(o), sorted(o)))
    return out


def mobius(a, nb):
    a = a.copy()
    for j in range(nb):
        v = a.reshape(a.shape[:-1] + (1 << (nb - 1 - j), 2, 1 << j))
        v[..., 1, :] ^= v[..., 0, :]
    return a


def elim_comb(vecs):
    piv = {}; ind = []; ker = []
    for i, r in enumerate(vecs):
        comb = 1 << i
        while r:
            c = r.bit_length() - 1
            if c in piv: r ^= piv[c][0]; comb ^= piv[c][1]
            else: piv[c] = (r, comb); ind.append(1 << i); break
        else: ker.append(comb)
    return ind, ker


pack = lambda a: int.from_bytes(np.packbits(np.asarray(a, dtype=np.uint8).reshape(-1)).tobytes(), "big")
ZW = np.array([(z ^ w) | (w << 6) for w in range(64) for z in range(64)])        # indice z + 64 w -> ponto (a, b)
wtw = np.array([bin(m >> 6).count("1") for m in range(4096)])


def polar(t):
    """t: tabela em x = (a,b). Devolve B[15, 64] (funcoes de z, valores), lam[6, 64], alpha[64], e o grau em w."""
    F = t[ZW]                                  # indice z + 64 w
    an = mobius(F, 12)
    degw = int(wtw[np.flatnonzero(an)].max()) if an.any() else 0
    B = np.zeros((15, 64), np.uint8)
    for k, (i, j) in enumerate(PAIRS):
        wm = ((1 << i) | (1 << j)) << 6
        coef = an[wm:wm + 64]                  # coeficientes em z do termo w_i w_j
        B[k] = mobius(coef, 6)                 # Mobius e involucao: coeficientes -> valores
    return B, degw, an


def forma(B, u, v):
    out = np.zeros(64, np.uint8)
    for k, (i, j) in enumerate(PAIRS):
        if ((u >> i & v >> j) ^ (u >> j & v >> i)) & 1: out ^= B[k]
    return out


if __name__ == "__main__":
    ORB = orbitas()
    TT = []
    for o in ORB:
        t = np.zeros(4096, dtype=np.uint8)
        for m in o[2]: t ^= ((X & m) == m).astype(np.uint8)
        TT.append(t)
    print("dim RS grau <= 4:", len(TT))
    AN = [mobius(t[ZW], 12) for t in TT]
    alto = wtw >= 3
    _, ker = elim_comb([pack(a[alto]) for a in AN])
    base = []
    for k in ker:
        t = np.zeros(4096, dtype=np.uint8)
        for i in range(len(TT)):
            if k >> i & 1: t ^= TT[i]
        base.append(t)
    print("dim do subespaco de grau <= 2 em w:", len(base))
    Bs = [polar(t)[0] for t in base]
    rk = lambda vs: len(elim_comb([pack(v) for v in vs])[0])
    ba = [forma(B, 27, 54) for B in Bs]; bb = [forma(B, 21, 42) for B in Bs]
    print("dim de B:", rk(Bs), "| dim beta_a:", rk(ba), "| dim beta_b:", rk(bb), "| dim (beta_a, beta_b):",
          rk([np.concatenate([x, y]) for x, y in zip(ba, bb)]))
    pickle.dump({"base": base, "B": Bs}, open(os.path.join(os.path.dirname(os.path.abspath(__file__)), "base12.pkl"), "wb"))
