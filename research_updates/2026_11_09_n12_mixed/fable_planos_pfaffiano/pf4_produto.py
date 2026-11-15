"""Does gamma_2 split?  The cross term beta(T, T') = T ^ T' (the polarization of gamma_2) on the top space.
If the top space is A + B with beta(A, B) = 0, the (Pf4) solutions are sol(A) x sol(B).
We compute beta on a basis, the radical of beta, and look for a splitting by the connected components of the
'beta != 0' graph after reducing the basis (radical first)."""
import os, sys, itertools, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from base12 import pack
from bitj import load_model
from pf4_estrutura import top_of

PAIRS = list(itertools.combinations(range(6), 2))
QUADS = list(itertools.combinations(range(6), 4))
pidx = {p: k for k, p in enumerate(PAIRS)}


def splits(S):
    a, b, c, d = S
    return [((a, b), (c, d)), ((a, c), (b, d)), ((a, d), (b, c))]


def beta(T, U):
    """T ^ U in Lambda^4 W x Lambda^4 Z: for w-quad S and z-quad R, sum over pairings."""
    out = np.zeros((15, 15), dtype=np.int64)
    for s, S in enumerate(QUADS):
        for r, R in enumerate(QUADS):
            v = 0
            for P, Pc in splits(S):
                for A, Ac in splits(R):
                    v += T[pidx[P], pidx[A]] * U[pidx[Pc], pidx[Ac]] + T[pidx[P], pidx[Ac]] * U[pidx[Pc], pidx[A]]
                    v += U[pidx[P], pidx[A]] * T[pidx[Pc], pidx[Ac]] + U[pidx[P], pidx[Ac]] * T[pidx[Pc], pidx[A]]
            out[s, r] = v % 2
    return out


def gamma2(T):
    out = np.zeros((15, 15), dtype=np.int64)
    for s, S in enumerate(QUADS):
        for r, R in enumerate(QUADS):
            v = 0
            for P, Pc in splits(S):
                for A, Ac in splits(R):
                    v += T[pidx[P], pidx[A]] * T[pidx[Pc], pidx[Ac]] + T[pidx[P], pidx[Ac]] * T[pidx[Pc], pidx[A]]
            out[s, r] = v % 2
    return out


if __name__ == "__main__":
    Bb, Gb, Gk, piv = load_model()
    tops = [top_of(B).astype(np.int64) for B in Bb]
    # basis of the top space
    basis = []; keys = []
    M = []
    for T in tops:
        v = T.reshape(-1) % 2
        M.append(v)
    M = np.array(M); r = 0; rows = []
    A = M.copy()
    piv_cols = []
    used = []
    for i in range(len(A)):
        pass
    # simple independent subset
    def rank(vs):
        X = np.array(vs) % 2; rr = 0
        for c in range(X.shape[1]):
            p = np.nonzero(X[rr:, c])[0]
            if len(p) == 0: continue
            p = p[0] + rr; X[[rr, p]] = X[[p, rr]]
            for i in np.nonzero(X[:, c])[0]:
                if i != rr: X[i] ^= X[rr]
            rr += 1
            if rr == X.shape[0]: break
        return rr
    for T in tops:
        if rank([b.reshape(-1) for b in basis] + [T.reshape(-1)]) > len(basis):
            basis.append(T)
    n = len(basis)
    print("dimension of the top space:", n)
    # check: gamma2 is quadratic with polarization beta
    rng = np.random.default_rng(0)
    for _ in range(5):
        c1 = rng.integers(0, 2, n); c2 = rng.integers(0, 2, n)
        T1 = sum(c * b for c, b in zip(c1, basis)) % 2; T2 = sum(c * b for c, b in zip(c2, basis)) % 2
        assert ((gamma2((T1 + T2) % 2) - gamma2(T1) - gamma2(T2) - beta(T1, T2)) % 2 == 0).all()
    Bm = [[beta(basis[i], basis[j]).reshape(-1) for j in range(n)] for i in range(n)]
    nz = np.array([[int(Bm[i][j].any()) for j in range(n)] for i in range(n)])
    print("pairs of basis tops with nonzero cross term:", int(nz.sum()) // 2, "of", n * (n - 1) // 2)
    # radical of beta: vectors v with beta(v, e_j) = 0 for all j  (beta is bilinear: stack 225-vectors)
    rows = []
    for j in range(n):
        rows.append(np.array([Bm[i][j] for i in range(n)]).T)        # 225 x n : coefficient of c_i
    Big = np.concatenate(rows, axis=0) % 2                            # (225 n) x n
    rk = rank(list(Big.T))   # rank of the map c -> beta(c, .)
    print("rank of beta as a map from the top space:", rk, "| radical dimension:", n - rk)
    # graph components in this basis (crude splitting test)
    comp = list(range(n))
    def f(x):
        while comp[x] != x: x = comp[x]
        return x
    for i in range(n):
        for j in range(i + 1, n):
            if nz[i, j]:
                comp[f(j)] = f(i)
    print("components of the cross-term graph in this basis:", collections.Counter(f(i) for i in range(n)).most_common())
