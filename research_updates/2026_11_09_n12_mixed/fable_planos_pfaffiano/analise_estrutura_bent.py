"""Structure of the bent set of each bent polar, rebuilt from its certificate.

Replays the certificate (verifica_arvore3.Checker, without the 'allbent' re-check: the certificates are already
verified) and collects the leaf subspaces.  For the bent set S (inside the phase space U, coordinates over the
basis of U): affine hull dimension a, stabilizer L = {v : S + v = S} (computed from the autocorrelation of 1_S
inside the affine hull by a Walsh transform), and the quotient S / L (number of cosets, and the quotient set).
Usage: python analise_estrutura_bent.py <bent certificates .json.gz> [--shard i/n] [--out file.json]"""
import os, sys, json, gzip
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
import verifica_arvore3 as V3


class Collect(V3.Checker):
    def __init__(self, P):
        super().__init__(P); self.leaves = []

    def node(self, n, x0, B, stats):
        if n.get("leaf") == "allbent":
            for a in n["actions"]:                      # same actions as the parent class, then record
                if "compute" in a:
                    self.events[a["id"]] = (x0.copy(), B.copy())
                else:
                    polys = [self.get(u, x0, B) for u in a["restrict"]]
                    one, aff = V3.span_info([p for p in polys if p is not None], B.shape[0])
                    assert not one
                    x0, B = V3.restrict(x0, B, aff)
            assert B.shape[0] == n["dim"]
            self.leaves.append((x0.copy(), B.copy()))
            return True
        return super().node(n, x0, B, stats)


def gf2_rank_rows(M):
    M = M.copy() % 2; r = 0; piv = []
    for c in range(M.shape[1]):
        p = np.nonzero(M[r:, c])[0]
        if len(p) == 0:
            continue
        p = p[0] + r; M[[r, p]] = M[[p, r]]
        for i in np.nonzero(M[:, c])[0]:
            if i != r:
                M[i] ^= M[r]
        piv.append(c); r += 1
        if r == M.shape[0]:
            break
    return M[:r], piv


def analyse(leaves, m):
    # points as int vectors over m bits
    W = 1 << np.arange(m, dtype=np.uint64)
    chunks = []
    for x0_, B in leaves:
        p = np.uint64(int((x0_.astype(np.uint64) * W).sum()))
        cur = np.array([p], dtype=np.uint64)
        for row in B:
            q = np.uint64(int((row.astype(np.uint64) * W).sum()))
            cur = np.concatenate([cur, cur ^ q])
        chunks.append(cur)
    pts = np.unique(np.concatenate(chunks))
    N = len(pts)
    x0 = pts[0]
    D = pts ^ x0
    sample = D[np.linspace(0, N - 1, min(N, 8192)).astype(np.int64)]
    diffs = ((sample[:, None] >> np.arange(m, dtype=np.uint64)) & np.uint64(1)).astype(np.int64)
    H, piv = gf2_rank_rows(diffs)
    a = len(H)
    if a > 26:
        return {"N": N, "hull_dim": a, "note": "hull too large for the transform"}
    idx = np.zeros(N, dtype=np.int64)
    for k, c in enumerate(piv):
        idx |= (((D >> np.uint64(c)) & np.uint64(1)).astype(np.int64)) << k
    # check: every point is in the affine hull (reconstruct from coordinates)
    Hint = [int(sum(int(b) << j for j, b in enumerate(row))) for row in H]
    for t in range(0, N, max(1, N // 500)):
        v = 0
        for k in range(a):
            if idx[t] >> k & 1:
                v ^= Hint[k]
        assert v == int(D[t]), "point outside the computed affine hull"
    f = np.zeros(1 << a, dtype=np.float64); f[idx] = 1
    # autocorrelation via Walsh: A = IWHT(WHT(f)^2)
    h = 1; F = f.copy()
    while h < len(F):
        F = F.reshape(-1, 2, h); x = F[:, 0, :].copy(); y = F[:, 1, :].copy()
        F[:, 0, :] = x + y; F[:, 1, :] = x - y; F = F.reshape(-1); h *= 2
    G = F * F
    h = 1
    while h < len(G):
        G = G.reshape(-1, 2, h); x = G[:, 0, :].copy(); y = G[:, 1, :].copy()
        G[:, 0, :] = x + y; G[:, 1, :] = x - y; G = G.reshape(-1); h *= 2
    G /= len(G)
    stab = np.nonzero(np.abs(G - N) < 0.5)[0]
    s = int(round(np.log2(len(stab))))
    # quotient: points modulo the stabilizer
    Sb = np.array([[v >> i & 1 for i in range(a)] for v in stab], dtype=np.int64)
    Sred, spiv = gf2_rank_rows(Sb) if len(stab) > 1 else (np.zeros((0, a), np.int64), [])
    def reduce(v):
        vec = np.array([v >> i & 1 for i in range(a)], dtype=np.int64)
        for row, c in zip(Sred, spiv):
            if vec[c]:
                vec ^= row
        return int(sum(int(b) << i for i, b in enumerate(vec)))
    cosets = sorted({reduce(int(v)) for v in idx})
    q = len(cosets)
    out = {"N": N, "hull_dim": a, "stab_dim": s, "cosets": q, "N_check": q << s == N}
    if q <= 64:
        # affine structure of the quotient set: dimension of its affine hull
        Cm = np.array([[(c ^ cosets[0]) >> i & 1 for i in range(a)] for c in cosets], dtype=np.int64)
        out["quotient_hull_dim"] = len(gf2_rank_rows(Cm)[0])
    return out


if __name__ == "__main__":
    from bitj import load_model
    from poisson3_lista import todos_subespacos3
    from cert_arvore import polar_data
    from verifica_arvore import Polar
    model = load_model(); Vs = todos_subespacos3()
    recs = json.load(gzip.open(sys.argv[1], "rt"))
    si, sm = map(int, (sys.argv[sys.argv.index("--shard") + 1] if "--shard" in sys.argv else "0/1").split("/"))
    out_path = sys.argv[sys.argv.index("--out") + 1] if "--out" in sys.argv else None
    res = []
    for k, r in enumerate(sorted(recs, key=lambda r: r["nodes"])):
        if k % sm != si:
            continue
        T0, K = polar_data(r["polar"], model, Vs)
        P = Polar(T0, K)
        C = Collect(P)
        C.node(r["cert"], np.zeros(P.m, np.int64), np.eye(P.m, dtype=np.int64), {})
        info = analyse(C.leaves, P.m)
        info.update(polar=r["polar"][:12], dim_U=P.m, count=r["bent_count"])
        res.append(info)
        print(json.dumps(info), flush=True)
        if out_path:
            json.dump(res, open(out_path, "w"))
