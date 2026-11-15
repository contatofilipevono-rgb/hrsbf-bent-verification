"""Independent verifier of the (Pf4) enumeration certificate (pf4_cert.py output).

Each condition [V, I] is evaluated directly: B = sum_j c_j Bb[j]; b_kl(z) = B_z(v_k, v_l) from the 15 pair
coefficients; Pf_V(B_z) = b01 b23 + b02 b13 + b03 b12; sum over z >= I mod 2.  Since b_kl is linear in c, every
condition is a quadratic form in c, so on a node subspace p + span(Q) it is interpolated exactly from its values
at p, p + Q_i and p + Q_i + Q_j.  Steps restrict to the affine part of the span of the referenced conditions;
'lin' leaves need 1 in that span; branches split on phi.c = rhs; the points of the 'pass' leaves must all be in
the enumeration list (so every solution of (Pf4) is a listed polar).
Usage: python verifica_pf4_arvore.py <pf4 certificate.json> <polars list>"""
import os, sys, json, itertools
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from verifica_arvore import span_info, restrict

PAIRS = list(itertools.combinations(range(6), 2))
Zs = np.arange(64)


def vec6(s):
    return np.array([s >> i & 1 for i in range(6)], dtype=np.int64)


class Pf4:
    def __init__(self, Bb):
        self.Bb = np.array(Bb, dtype=np.int64)                 # 25 x 15 x 64
        self.m = len(Bb)
        self.Vcache = {}

    def coeffs(self, key):
        """For V with annihilator key: basis and the 6 pair-coefficient vectors (6 x 15)."""
        if tuple(key) not in self.Vcache:
            p, q = key[0], key[1]
            V = [s for s in range(64) if bin(s & p).count("1") % 2 == 0 and bin(s & q).count("1") % 2 == 0]
            basis = []; span = {0}
            for s in V:
                if s not in span:
                    basis.append(s); span |= {x ^ s for x in span}
            vs = [vec6(b) for b in basis]
            W = np.zeros((6, 15), np.int64)
            for r, (k, l) in enumerate(itertools.combinations(range(4), 2)):
                u, v = vs[k], vs[l]
                for t, (a, b) in enumerate(PAIRS):
                    W[r, t] = (u[a] * v[b] + u[b] * v[a]) % 2
            self.Vcache[tuple(key)] = W
        return self.Vcache[tuple(key)]

    def b_of(self, x, key):
        """b_kl(z) for the polar with coordinates x (int over 25 bits): 6 x 64 (as integers, reduced later)."""
        B = np.zeros((15, 64), np.int64)
        for j in range(self.m):
            if x >> j & 1:
                B += self.Bb[j]
        return (self.coeffs(key) @ (B % 2)) % 2

    def cond_from_b(self, b, I):
        pf = (b[0] * b[5] + b[1] * b[4] + b[2] * b[3]) % 2   # pairs order (01,02,03,12,13,23)
        sel = (Zs & I) == I
        return int(pf[sel].sum() % 2)

    def poly(self, ref, p, Q):
        """Quadratic polynomial of condition ref on p + span(Q), as frozenset of index tuples."""
        key, I = ref
        D = len(Q)
        b0 = self.b_of(p, key)
        bq = [self.b_of(q, key) for q in Q]
        f0 = self.cond_from_b(b0, I)
        f1 = [self.cond_from_b((b0 + bq[i]) % 2, I) for i in range(D)]
        out = set()
        if f0:
            out.add(())
        for i in range(D):
            if f1[i] ^ f0:
                out.add((i,))
        for i in range(D):
            for j in range(i + 1, D):
                v = self.cond_from_b((b0 + bq[i] + bq[j]) % 2, I) ^ f1[i] ^ f1[j] ^ f0
                if v:
                    out.add((i, j))
        return frozenset(out)


def to_arrays(p, Q, m):
    x0 = np.array([p >> j & 1 for j in range(m)], dtype=np.int64)
    B = np.array([[q >> j & 1 for j in range(m)] for q in Q], dtype=np.int64).reshape(len(Q), m)
    return x0, B


def to_ints(x0, B):
    p = int(sum(int(v) << j for j, v in enumerate(x0)))
    Q = [int(sum(int(v) << j for j, v in enumerate(row))) for row in B]
    return p, Q


def check(P, node, x0, B, listed, stats):
    stats["nodes"] = stats.get("nodes", 0) + 1
    m = P.m
    for refs in node["steps"]:
        p, Q = to_ints(x0, B)
        polys = [P.poly(r, p, Q) for r in refs]
        one, aff = span_info(polys, B.shape[0])
        if one:
            return True
        new = restrict(x0, B, aff)
        if new is None:
            return True
        x0, B = new
    if "kids" in node:
        phi = node["branch"]
        pv = np.array([phi >> j & 1 for j in range(m)], dtype=np.int64)
        for rhs, kid in zip(node["rhs"], node["kids"]):
            new = restrict(x0, B, [((B @ pv) % 2, (rhs + int(pv @ x0)) % 2)])
            if new is not None and not check(P, kid, new[0], new[1], listed, stats):
                return False
        return True
    if node["leaf"] == "lin":
        p, Q = to_ints(x0, B)
        polys = [P.poly(r, p, Q) for r in node["use"]]
        stats["lin"] = stats.get("lin", 0) + 1
        return span_info(polys, B.shape[0])[0]
    if node["leaf"] == "pass":
        p, Q = to_ints(x0, B)
        pts = [p]
        for q in Q:
            pts += [x ^ q for x in pts]
        stats["pass_points"] = stats.get("pass_points", 0) + len(pts)
        stats.setdefault("points", set()).update(pts)
        return all(x in listed for x in pts)
    return False


if __name__ == "__main__":
    from bitj import load_model
    from base12 import pack
    Bb, Gb, Gk, piv = load_model()
    cert = json.load(open(sys.argv[1]))
    def coords_of(hx):
        val = int(hx, 16)
        Bm = np.array([[(val >> (64 * a + z)) & 1 for z in range(64)] for a in range(15)], dtype=np.uint8)
        r = pack(Bm); comb = 0
        while r:
            c = r.bit_length() - 1; r ^= piv[c][0]; comb ^= piv[c][1]
        return comb
    listed = {coords_of(h) for h in open(sys.argv[2]).read().split()}
    P = Pf4(Bb); stats = {}
    m = P.m
    ok = check(P, cert["tree"], np.zeros(m, np.int64), np.eye(m, dtype=np.int64), listed, stats)
    pts = stats.pop("points", set())
    print("verified:", ok, "| nodes", stats.get("nodes"), "| lin leaves", stats.get("lin"),
          "| solution points", len(pts), "| listed", len(listed), "| all solutions listed:", pts <= listed,
          "| equal:", pts == listed)
    sys.exit(0 if ok else 1)
