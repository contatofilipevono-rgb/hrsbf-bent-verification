"""Certificate for the polar enumeration: all solutions of (Pf4) in the 25 polar coordinates.

For a 4-dim V < W = F2^6 with basis v1..v4 and the alternating form B_z, Pf_V(B_z) = b12 b34 + b13 b24 + b14 b23
(b_ij = B_z(v_i, v_j)).  With K_z = sum_{s in V} (-1)^{f(z, w0+s)}, kappa_z = K_z / 4 is odd iff B_z|_V is
nondegenerate (|K_z| = 4; ranks 2 and 0 give |K_z| in {0, 8} and {0, 16}), so kappa_z = Pf_V(B_z) mod 2.
Poisson in V^perp and the Moebius sum over z >= I give, for bent f,  sum_{z >= I} kappa_z = 0 mod 2^(3-|I|), so
    (Pf4)   sum_{z >= I} Pf_V(B_z) = 0 (mod 2)   for all 651 V and |I| <= 2.
The polar is B = sum_j c_j Bb[j] (25 coordinates), so each condition is a homogeneous quadratic form in c.
The system is solved by a branching tree with linearization (same rules as the phase certificates):
leaves 'lin' (1 in the span) or 'pass' (every condition vanishes identically on the leaf subspace).
Usage: python pf4_cert.py <out.json>"""
import os, sys, json, itertools, time
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from base12 import forma

par6 = np.array([bin(i).count("1") & 1 for i in range(64)])
Zs = np.arange(64)
ISETS = [0] + [1 << i for i in range(6)] + [(1 << i) | (1 << j) for i, j in itertools.combinations(range(6), 2)]


def subspaces4():
    out = []
    seen = set()
    for p in range(1, 64):
        for q in range(p + 1, 64):
            key = tuple(sorted({p, q, p ^ q}))
            if key in seen:
                continue
            seen.add(key)
            V = [s for s in range(64) if par6[s & p] == 0 and par6[s & q] == 0]
            basis = []
            span = {0}
            for s in V:
                if s not in span:
                    basis.append(s); span |= {x ^ s for x in span}
            assert len(basis) == 4 and len(span) == 16
            out.append((key, basis))
    assert len(out) == 651
    return out


def build_system(Bb):
    """Returns list of (label, poly) with poly a set of monomial masks over the 25 coordinates."""
    m = len(Bb)
    polys = []
    pairs = [((0, 1), (2, 3)), ((0, 2), (1, 3)), ((0, 3), (1, 2))]
    for key, v in subspaces4():
        L = {}
        for i, j in itertools.combinations(range(4), 2):
            L[(i, j)] = np.array([forma(Bb[k], v[i], v[j]) for k in range(m)], dtype=np.int64).T   # 64 x m
        Mz = np.zeros((64, m, m), dtype=np.int64)
        for P, Pc in pairs:
            Mz += L[P][:, :, None] * L[Pc][:, None, :]
        for I in ISETS:
            sel = (Zs & I) == I
            M = Mz[sel].sum(axis=0) % 2
            poly = set()
            for i in range(m):
                if M[i, i]:
                    poly.add(1 << i)
                for j in range(i + 1, m):
                    if (M[i, j] + M[j, i]) % 2:
                        poly.add((1 << i) | (1 << j))
            if poly:
                polys.append(([list(key), I], frozenset(poly)))
    return polys


if __name__ == "__main__":
    from bitj import load_model
    from cert_arvore2 import reduce_track
    from cert_arvore3 import subst
    from cert_arvore import gf2_solve
    Bb, Gb, Gk, piv = load_model()
    m = len(Bb)
    t0 = time.time()
    polys = build_system(Bb)
    uniq = {}
    for lab, P in polys:
        uniq.setdefault(P, lab)
    print("conditions", len(polys), "distinct nonzero polynomials", len(uniq), round(time.time() - t0, 1), "s", flush=True)
    items = [(lab, set(P)) for P, lab in uniq.items()]

    leaves = []                                    # (part, ker) over the 25 coordinates for 'pass' leaves
    stats = {"lin": 0, "pass": 0, "nodes": 0}

    def to_global(part, ker, p, Q):
        p2 = p
        for i, q in enumerate(Q):
            if part >> i & 1:
                p2 ^= q
        Q2 = []
        for kv in ker:
            w = 0
            for i, q in enumerate(Q):
                if kv >> i & 1:
                    w ^= q
            Q2.append(w)
        return p2, Q2

    def prove(p, Q, pool):
        stats["nodes"] += 1
        node = {"steps": []}
        while True:
            pool = [(lab, P) for lab, P in pool if P]
            if not pool:
                node["leaf"] = "pass"; node["dim"] = len(Q); node["p"] = p; node["Q"] = list(Q)
                leaves.append((p, Q)); stats["pass"] += 1
                return node
            st, res = reduce_track(pool)
            if st == "one":
                node["leaf"] = "lin"; node["use"] = res; stats["lin"] += 1
                return node
            if res:
                sol = gf2_solve([(mask, rhs) for _, mask, rhs in res], len(Q))
                if len(sol[1]) < len(Q):
                    part, ker = sol
                    p, Q = to_global(part, ker, p, Q)
                    pool = [(lab, subst(P, part, ker)) for lab, P in pool]
                    refs = []
                    for rr, _, _ in res:
                        for r in rr:
                            if r not in refs:
                                refs.append(r)
                    node["steps"].append(refs)
                    continue
            break
        cnt = [0] * len(Q)
        for lab, P in pool:
            for J in P:
                if J & (J - 1):
                    for i in range(len(Q)):
                        if J >> i & 1:
                            cnt[i] += 1
        j = max(range(len(Q)), key=lambda i: cnt[i])
        from cert_arvore import dual_functional, par
        phi = dual_functional(Q, j)                    # phi.(p + sum t_i Q_i) = phi.p + t_j
        node["branch"] = phi; node["rhs"] = [par(phi & p), par(phi & p) ^ 1]; node["kids"] = []
        for c in (0, 1):
            part = c << j
            ker = [1 << i for i in range(len(Q)) if i != j]
            # new coordinates: all old except j; old t_j = c
            p2, Q2 = to_global(part, ker, p, Q)
            pool2 = [(lab, subst(P, part, ker)) for lab, P in pool]
            node["kids"].append(prove(p2, Q2, pool2))
        return node

    t1 = time.time()
    tree = prove(0, [1 << i for i in range(m)], items)
    total = sum(1 << len(Q) for p, Q in leaves)
    print("tree nodes", stats["nodes"], "leaves lin", stats["lin"], "pass", stats["pass"], "| solutions", total,
          round(time.time() - t1, 1), "s", flush=True)
    # compare with the enumeration list
    from base12 import pack
    def coords_of(hx):
        val = int(hx, 16)
        B = np.array([[(val >> (64 * a + z)) & 1 for z in range(64)] for a in range(15)], dtype=np.uint8)
        r = pack(B); comb = 0
        while r:
            c = r.bit_length() - 1; r ^= piv[c][0]; comb ^= piv[c][1]
        return comb
    listed = {coords_of(h) for h in open(os.path.join(os.path.dirname(os.path.abspath(__file__)), "polares_18816.txt")).read().split()}
    sols = set()
    for p, Q in leaves:
        pts = [p]
        for q in Q:
            pts += [x ^ q for x in pts]
        sols |= set(pts)
    print("solutions", len(sols), "| listed", len(listed), "| solutions inside the list:", sols <= listed,
          "| list inside solutions:", listed <= sols, flush=True)
    json.dump({"tree": tree, "solutions": len(sols), "listed": len(listed), "subset": sols <= listed,
               "equal": sols == listed}, open(sys.argv[1], "w"))
