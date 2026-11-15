"""Independent verifier of the branching certificates (cert_arvore2.py output).

Different implementation from the prover (numpy matrices, own elimination, own polynomial evaluation):
  - U from (L5)+(L3); pairs (z, d), d in rad B_z, by the full polar matrix (verifica_autocorr.pairs_np);
  - a node is an affine subspace x0 + rowspace(B) of U, kept as numpy arrays;
  - ["S", d]: S_d(y) = sum over the pairs of (-1)^{g + L(y)}; exact lowest-bit polynomial (all J needed);
  - ["F", p, q, om, w0, I]: C(y) = sum_{z >= I, s in V} (-1)^{f_y(z, w0+s) + om.s}, V = {s : s.p = s.q = 0};
    exact lowest-bit polynomial from N_J, |J| <= 3, accepted only if k0 <= 3 and k0 < 5 - |I|;
  - a step restricts to the affine part of the F2-span of its polynomials (basis independent);
  - leaves: 'const' (P == 1), 'affine'/'lin' (1 in the span); branches split on phi.y = 0 / 1.
Usage: python verifica_arvore.py <certificates.json> [...]"""
import os, sys, json, itertools
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from verifica_autocorr import pairs_np

par = lambda x: bin(x).count("1") & 1


def v2(n):
    n = abs(n)
    return (n & -n).bit_length() - 1


def lowest(coords, sg, kmax, const=0):
    """coords: (N x D) 0/1, sg: integer weights (plus an integer constant).  Returns (k0, frozenset of J tuples)."""
    N_, D = coords.shape
    supp = {(): const} if const else {}
    for row, w in zip(coords, sg):                    # merge equal rows first: weight of each character
        key = tuple(np.nonzero(row)[0])
        supp[key] = supp.get(key, 0) + int(w)
    supp = {k_: w for k_, w in supp.items() if w}
    best = None; vals = {}
    k = 0
    kmax = min(kmax, D)                               # no monomial has degree > D
    while (best is None or k <= best) and k <= kmax:
        acc = {}
        for s_, w in supp.items():
            if len(s_) >= k:
                for J in itertools.combinations(s_, k):
                    acc[J] = acc.get(J, 0) + w
        for J, s in acc.items():
            if s:
                val = k + v2(s); vals[J] = val
                if best is None or val < best:
                    best = val
        k += 1
    if best is None or (k <= best and k <= D):       # stopped by the cap before degree best: not exact
        return None
    return best, frozenset(J for J, v in vals.items() if v == best)


class Polar:
    def __init__(self, T0, K):
        self.T0 = T0.astype(np.uint8); self.Kt = np.array(K, dtype=np.uint8); self.m = len(K)
        pairs, _ = pairs_np(T0, K)
        self.by_d = {}
        for z, d, vec, g in pairs:
            if d:
                self.by_d.setdefault(d, []).append((vec.astype(np.int64), g))

    def poly(self, ref, x0, B):
        D = B.shape[0]
        if ref[0] == "S":
            t = self.by_d.get(ref[1], [])
            if not t:
                return None
            V = np.array([v for v, g in t]); g = np.array([g for v, g in t])
            c = (g + V @ x0) % 2
            coords = (V @ B.T) % 2 if D else np.zeros((len(t), 0), np.int64)
            r = lowest(coords.astype(bool), 1 - 2 * c, 6)
            return None if r is None else r[1]
        if ref[0] == "W":
            _, u, b = ref
            Z = np.repeat(np.arange(64), 64); Wv = np.tile(np.arange(64), 64)
            ch = np.array([par(u & z) ^ par(b & w) for z, w in zip(Z, Wv)])
            Kx = self.Kt[:, Z, Wv].astype(np.int64).T                      # 4096 x m
            base = (self.T0[Z, Wv].astype(np.int64) + Kx @ x0 + ch) % 2
            coords = (Kx @ B.T) % 2 if D else np.zeros((4096, 0), np.int64)
            r = lowest(coords.astype(bool), 1 - 2 * base, 6, const=-64)
            if r is None or r[0] >= 7:
                raise ValueError("W constraint without information: %s" % (ref,))
            return r[1]
        _, p, q, om, w0, I = ref
        Vs = [s for s in range(64) if par(s & p) == 0 and par(s & q) == 0]
        assert len(Vs) == 16 and p and q and p != q
        zs = [z for z in range(64) if I < 0 or z >> I & 1]
        Z = np.repeat(zs, 16); Wv = np.array([w0 ^ s for s in Vs] * len(zs)); ch = np.array([par(om & s) for s in Vs] * len(zs))
        base = (self.T0[Z, Wv].astype(np.int64) + (self.Kt[:, Z, Wv].astype(np.int64).T @ x0)) % 2
        coords = (self.Kt[:, Z, Wv].astype(np.int64).T @ B.T) % 2 if D else np.zeros((len(Z), 0), np.int64)
        r = lowest(coords.astype(bool), 1 - 2 * ((base + ch) % 2), 3)
        if r is None or r[0] >= 5 - (0 if I < 0 else 1):
            raise ValueError("F constraint without information: %s" % (ref,))
        return r[1]


def span_info(polys, D):
    """Returns (one_in_span, affine rows as (a over D, rhs))."""
    mons = sorted({J for P in polys for J in P if len(J) >= 2})
    cols = mons + [(i,) for i in range(D)] + [()]
    ci = {J: k for k, J in enumerate(cols)}
    M = np.zeros((len(polys), len(cols)), np.uint8)
    for r, P in enumerate(polys):
        for J in P:
            M[r, ci[J]] ^= 1
    piv = []; r = 0
    for c in range(len(cols)):
        nz = np.nonzero(M[r:, c])[0]
        if len(nz) == 0:
            continue
        p = nz[0] + r; M[[r, p]] = M[[p, r]]
        for i in np.nonzero(M[:, c])[0]:
            if i != r:
                M[i] ^= M[r]
        piv.append(c); r += 1
        if r == len(M):
            break
    one = any(cols[c] == () for c in piv)
    aff = []
    for i, c in enumerate(piv):
        if c >= len(mons) and cols[c] != ():
            aff.append((M[i, len(mons):len(mons) + D].astype(np.int64), int(M[i, -1])))
    return one, aff


def solve(A, b, D):
    """t with A t = b over F2: (t0, kernel matrix) or None."""
    M = np.concatenate([A % 2, b[:, None] % 2], axis=1).astype(np.uint8) if len(A) else np.zeros((0, D + 1), np.uint8)
    piv = []; r = 0
    for c in range(D):
        nz = np.nonzero(M[r:, c])[0]
        if len(nz) == 0:
            continue
        p = nz[0] + r; M[[r, p]] = M[[p, r]]
        for i in np.nonzero(M[:, c])[0]:
            if i != r:
                M[i] ^= M[r]
        piv.append(c); r += 1
        if r == len(M):
            break
    if M[r:, D].any():
        return None
    t0 = np.zeros(D, np.int64)
    for i, c in enumerate(piv):
        t0[c] = M[i, D]
    ker = []
    for f in range(D):
        if f in piv:
            continue
        v = np.zeros(D, np.int64); v[f] = 1
        for i, c in enumerate(piv):
            v[c] = M[i, f]
        ker.append(v)
    return t0, np.array(ker, dtype=np.int64).reshape(len(ker), D)


def restrict(x0, B, rows):
    D = B.shape[0]
    A = np.array([a for a, _ in rows], dtype=np.int64).reshape(len(rows), D); b = np.array([r for _, r in rows], dtype=np.int64)
    s = solve(A, b, D)
    if s is None:
        return None
    t0, Kr = s
    return (x0 + t0 @ B) % 2, (Kr @ B) % 2


def check_node(P, node, x0, B, stats):
    stats["nodes"] = stats.get("nodes", 0) + 1
    for refs in node["steps"]:
        polys = [P.poly(r, x0, B) for r in refs]
        polys = [p for p in polys if p is not None]
        one, aff = span_info(polys, B.shape[0])
        if one:
            return True                              # already dead here (stronger than claimed)
        new = restrict(x0, B, aff)
        if new is None:
            return True
        x0, B = new
    if "kids" in node:
        phi = int(node["branch"], 16)
        pv = np.array([phi >> j & 1 for j in range(P.m)], dtype=np.int64)
        for c, kid in zip((0, 1), node["kids"]):
            new = restrict(x0, B, [((B @ pv) % 2, (c + int(pv @ x0)) % 2)])
            if new is not None and not check_node(P, kid, new[0], new[1], stats):
                return False
        return True
    leaf = node["leaf"]
    stats[leaf] = stats.get(leaf, 0) + 1
    polys = [P.poly(r, x0, B) for r in node.get("refs", [])]
    if leaf == "const":
        return polys[0] == frozenset({()})
    if leaf in ("affine", "lin"):
        polys = [p for p in polys if p is not None]
        return span_info(polys, B.shape[0])[0]
    return False


if __name__ == "__main__":
    from bitj import load_model
    from poisson3_lista import todos_subespacos3
    from cert_arvore import polar_data
    model = load_model(); Vs = todos_subespacos3()
    recs = [r for f in sys.argv[1:] for r in json.load(open(f))]
    bad = 0; tot = {}
    for r in recs:
        if r.get("status") != "certified":
            print("NOT CERTIFIED", r["polar"][:16], r.get("status")); bad += 1; continue
        T0, K = polar_data(r["polar"], model, Vs)
        assert len(K) == r["dim_U"]
        P = Polar(T0, K); stats = {}
        ok = check_node(P, r["cert"], np.zeros(P.m, np.int64), np.eye(P.m, dtype=np.int64), stats)
        for k, v in stats.items():
            tot[k] = tot.get(k, 0) + v
        print(r["polar"][:16], "OK" if ok else "FAIL", stats, flush=True)
        bad += not ok
    print("polars:", len(recs), "failures:", bad, "totals:", tot)
    sys.exit(1 if bad else 0)
