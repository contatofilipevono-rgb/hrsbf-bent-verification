"""Branching certificates for the joint Parseval condition S_d = 0 (all d != 0), without enumerating theta.

S_d(y) = sum_z (-1)^{g + L(y)} over the pairs (z, d), d in rad B_z, on an affine subspace y = p + span(Q) of U.
Integer expansion on {0,1}^D:  S(y) = sum_J (-2)^{|J|} N_J y^J,  N_J = sum_{L >= J} n_L.
Let k0 = min_J (|J| + v2(N_J)).  Then S = 2^k0 * P(y) mod 2^(k0+1) with the F2 polynomial
    P(y) = sum_{J : |J| + v2(N_J) = k0} y^J,
so S_d = 0 forces P_d(y) = 0.  At a node:
  P_d == 1 for some d                    -> leaf 'const'
  affine P_d: solve them together        -> inconsistent: leaf 'affine'; else restrict and repeat
  remaining P_d of higher degree         -> 1 in their F2-span (linearization): leaf 'lin'
  otherwise branch on a linear functional of U (both halves are children).
Every check is invariant under affine change of coordinates, so the certificate records only directions d,
the branching functionals (masks over the coordinates of U) and the leaf type.
Usage: python cert_arvore.py <polars file> [--shard i/n] [--out file.json] [--max-nodes N]"""
import os, sys, json, time, itertools
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

MAXK = 6


def par(x):
    return bin(x).count("1") & 1


def restrict_terms(terms, p, Q):
    """terms: list of (form over U, g).  Returns dict L (over the D coordinates of Q) -> integer weight."""
    n = {}
    for form, g in terms:
        c = g ^ par(form & p)
        L = 0
        for i, q in enumerate(Q):
            if form & q and par(form & q):
                L |= 1 << i
        n[L] = n.get(L, 0) + (1 - 2 * c)
    return {L: v for L, v in n.items() if v}


def v2(x):
    return (x & -x).bit_length() - 1


def lowest_bit_poly(n, maxk=MAXK):
    """Returns (k0, set of monomials J as bitmasks) or None if S == 0 identically or k0 > maxk."""
    if not n:
        return None
    best = None; N = {}
    k = 0
    while True:
        if best is not None and k > best:
            break
        if k > maxk:
            return None
        NJ = {}
        for L, v in n.items():
            bits = [i for i in range(L.bit_length()) if L >> i & 1]
            if len(bits) < k:
                continue
            for J in itertools.combinations(bits, k):
                m = 0
                for i in J:
                    m |= 1 << i
                NJ[m] = NJ.get(m, 0) + v
        for J, s in NJ.items():
            if s:
                val = k + v2(abs(s))
                N[J] = val
                if best is None or val < best:
                    best = val
        k += 1
    if best is None or best > maxk:
        return None
    return best, {J for J, val in N.items() if val == best}


def gf2_solve(rows, n):
    """rows: (mask over n, rhs). Returns (part, kernel list) or None."""
    piv = {}
    for r, b in rows:
        x = (r << 1) | b
        while x > 1 and (x.bit_length() - 1) in piv:
            x ^= piv[x.bit_length() - 1]
        if x == 1:
            return None
        if x > 1:
            piv[x.bit_length() - 1] = x
    for p in sorted(piv):
        for q in piv:
            if q != p and piv[q] >> p & 1:
                piv[q] ^= piv[p]
    pivs = {p - 1 for p in piv}
    part = sum(1 << (p - 1) for p, x in piv.items() if x & 1)
    ker = []
    for f in range(n):
        if f not in pivs:
            v = 1 << f
            for p, x in piv.items():
                if x >> (f + 1) & 1:
                    v |= 1 << (p - 1)
            ker.append(v)
    return part, ker


def one_in_span(polys):
    """polys: list of sets of monomials (bitmask J; J = 0 is the constant).  True if 1 is an F2-combination."""
    idx = {}
    rows = []
    for P in polys:
        r = 0; b = 0
        for J in P:
            if J == 0:
                b ^= 1
            else:
                if J not in idx:
                    idx[J] = len(idx)
                r ^= 1 << idx[J]
        rows.append((r, b))
    return gf2_solve(rows, len(idx)) is None


def to_U(part, ker, p, Q):
    """Compose: new subspace coordinates (part, ker over D) -> U."""
    p2 = p
    for i, q in enumerate(Q):
        if part >> i & 1:
            p2 ^= q
    Q2 = []
    for v in ker:
        w = 0
        for i, q in enumerate(Q):
            if v >> i & 1:
                w ^= q
        Q2.append(w)
    return p2, Q2


def restrict_affine(p, Q, rows):
    sol = gf2_solve(rows, len(Q))
    if sol is None:
        return None
    return to_U(sol[0], sol[1], p, Q)


def split(p, Q, phi, c):
    """Intersect p + span(Q) with {y : phi.y = c} (phi a mask over U)."""
    a = 0
    for i, q in enumerate(Q):
        if par(phi & q):
            a |= 1 << i
    return restrict_affine(p, Q, [(a, c ^ par(phi & p))])


def dual_functional(Q, j):
    """A mask phi over U with phi.Q_i = delta_ij."""
    width = max(q.bit_length() for q in Q)
    rows = []
    for i, q in enumerate(Q):
        rows.append((q, 1 if i == j else 0))
    sol = gf2_solve(rows, width)
    return sol[0]


def node_polys(by_d, p, Q):
    out = {}
    for d, terms in by_d.items():
        r = lowest_bit_poly(restrict_terms(terms, p, Q))
        if r is not None:
            out[d] = r[1]
    return out


def prove(by_d, p, Q, budget):
    """Returns a certificate node or None (budget exhausted)."""
    steps = []
    while True:
        budget[0] -= 1
        if budget[0] < 0:
            return None
        P = node_polys(by_d, p, Q)
        if not P:                       # every S_d vanishes identically here: Parseval holds in all columns
            return {"steps": steps, "leaf": "parseval-zero", "dim": len(Q), "p": hex(p), "Q": [hex(q) for q in Q]}
        for d, mon in P.items():
            if mon == {0}:
                return {"steps": steps, "leaf": "const", "d": [d]}
        aff = {d: mon for d, mon in P.items() if all(J & (J - 1) == 0 for J in mon) and any(J for J in mon)}
        if aff:
            rows = []
            for d, mon in aff.items():
                r = 0; b = 0
                for J in mon:
                    if J == 0:
                        b ^= 1
                    else:
                        r ^= J
                rows.append((r, b))
            new = restrict_affine(p, Q, rows)
            if new is None:
                return {"steps": steps, "leaf": "affine", "d": sorted(aff)}
            if len(new[1]) < len(Q):
                steps.append(sorted(aff)); p, Q = new
                continue
        nonlin = {d: mon for d, mon in P.items() if d not in aff}
        if nonlin and one_in_span(list(nonlin.values())):
            return {"steps": steps, "leaf": "lin", "d": sorted(nonlin)}
        if not Q:
            return {"steps": steps, "leaf": "point-open"}      # a surviving point: not a certificate
        cnt = [0] * len(Q)
        for mon in nonlin.values():
            for J in mon:
                if J & (J - 1):
                    for i in range(len(Q)):
                        if J >> i & 1:
                            cnt[i] += 1
        j = max(range(len(Q)), key=lambda i: cnt[i])
        phi = dual_functional(Q, j)
        kids = []
        for c in (0, 1):
            sub = split(p, Q, phi, c)
            k = prove(by_d, sub[0], sub[1], budget)
            if k is None:
                return None
            kids.append(k)
        return {"steps": steps, "branch": hex(phi), "kids": kids}


def size(node):
    if "kids" in node:
        return 1 + sum(size(k) for k in node["kids"])
    return 1


def leaves(node, acc):
    if "kids" in node:
        for k in node["kids"]:
            leaves(k, acc)
    else:
        acc[node["leaf"]] = acc.get(node["leaf"], 0) + 1
    return acc


def polar_data(hx, model, Vs):
    import numpy as np
    from base12 import pack
    from bitj import solve_affine, table_at
    from poisson5 import Bv_table, equacoes
    from poisson3 import eq3
    Bb, Gb, Gk, piv = model
    val = int(hx, 16)
    B = np.array([[(val >> (64 * a + z)) & 1 for z in range(64)] for a in range(15)], dtype=np.uint8)
    r = pack(B); comb = 0
    while r:
        c = r.bit_length() - 1; r ^= piv[c][0]; comb ^= piv[c][1]
    sel = [j for j in range(len(Bb)) if comb >> j & 1]
    G0 = np.bitwise_xor.reduce(Gb[sel], axis=0) if sel else np.zeros((64, 64), np.uint8)
    Bv = Bv_table(B)
    part, ker = solve_affine(equacoes(Bv, G0, Gk) + eq3(Bv, G0, Gk, Vs), Gk.shape[0])
    T0 = table_at(G0, Gk, part); K = [table_at(np.zeros_like(G0), Gk, v) for v in ker]
    return T0, K


if __name__ == "__main__":
    from bitj import load_model
    from poisson3_lista import todos_subespacos3
    from cert_colunas import pairs_of
    out_path = sys.argv[sys.argv.index("--out") + 1] if "--out" in sys.argv else None
    si, sm = map(int, (sys.argv[sys.argv.index("--shard") + 1] if "--shard" in sys.argv else "0/1").split("/"))
    maxn = int(sys.argv[sys.argv.index("--max-nodes") + 1]) if "--max-nodes" in sys.argv else 20000
    model = load_model(); Vs = todos_subespacos3()
    res = []
    for k, hx in enumerate(open(sys.argv[1]).read().split()):
        if k % sm != si:
            continue
        t0 = time.time()
        T0, K = polar_data(hx, model, Vs)
        m = len(K)
        by_d = {}
        for z, d, form, g in pairs_of(T0, K):
            if d:
                by_d.setdefault(d, []).append((form, g))
        budget = [maxn]
        cert = prove(by_d, 0, [1 << i for i in range(m)], budget)
        rec = {"polar": hx, "dim_U": m, "seconds": None}
        if cert is None:
            rec["status"] = "budget"
        else:
            lv = leaves(cert, {})
            rec["status"] = "open" if "point-open" in lv else "certified"
            rec["nodes"] = size(cert); rec["leaves"] = lv; rec["cert"] = cert
        rec["seconds"] = round(time.time() - t0, 1)
        res.append(rec)
        print(hx[:12], "dimU", m, rec["status"], rec.get("nodes"), rec.get("leaves"), rec["seconds"], "s", flush=True)
        if out_path:
            json.dump(res, open(out_path, "w"))
