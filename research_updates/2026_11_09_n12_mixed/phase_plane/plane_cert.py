"""Certify that the 19 phase columns (48 moments) lie in the plane L on an affine space of maps,
by exact degree-4 interpolation (every entry is a polynomial of degree <= 4 in the map parameters).

Hypothesis levels for a polar class kappa (code >> 25 == kappa), 25 free low bits:
  H0  no condition (whole class space)
  H1  linear support moments: each label coordinate pi_i is orthogonal to RM(2,8)
      (37 affine equations per coordinate)
  H2  H1 + linear consequences of the product moments (pi_i pi_j, ... orthogonal to RM(2,8)),
      iterated (echelon of the Boolean support moments of degree <= 4)
"""
import sys, json, time, argparse
from itertools import combinations
from pathlib import Path

L1, L2 = 0x084006C00810, 0x106002400C20
MASK = (1 << 256) - 1


def lin_solve(rows, n):
    """rows: (vector over n bits, rhs). Returns (particular, kernel basis) or None."""
    piv = {}
    for v, b in rows:
        x = (v << 1) | b
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


class Model:
    def __init__(self, repo):
        sys.path.insert(0, str(Path(repo).resolve()))
        from dim4_support_decode import decode
        self.model, self.basis, self.labels = decode(1)
        assert len(self.basis) == 33 and len(self.model.phases) == 19
        self.phases = self.model.phases
        xs = [sum(1 << x for x in range(256) if x >> i & 1) for i in range(8)]
        self.s1, self.s2 = xs[6], xs[7]
        self.rm2 = [MASK] + xs + [xs[i] & xs[j] for i, j in combinations(range(8), 2)]
        lp = {}
        for v in (L1, L2):
            while v and (v.bit_length() - 1) in lp:
                v ^= lp[v.bit_length() - 1]
            lp[v.bit_length() - 1] = v
        self.lpiv = lp

    def comps(self, mapping):
        return [(mapping >> (256 * i)) & MASK for i in range(4)]

    def columns_mod_L(self, mapping):
        c = self.comps(mapping)
        nc = [MASK ^ w for w in c]
        out = []
        subs = []
        for t in range(16):
            f = MASK
            for i in range(4):
                f &= c[i] if t >> i & 1 else nc[i]
            subs += [f, f & self.s1, f & self.s2]
        for ph in self.phases:
            col = 0
            for e, s in enumerate(subs):
                if (s & ph).bit_count() & 1:
                    col |= 1 << e
            for p in sorted(self.lpiv, reverse=True):
                if col >> p & 1:
                    col ^= self.lpiv[p]
            out.append(col)
        return tuple(out)


def space_for(M, kappa, level):
    """Affine space of codes: (base code, list of direction codes)."""
    base = kappa << 25
    dirs = [1 << i for i in range(25)]
    if level == "H0":
        return base, dirs
    xor = lambda cs: 0
    def mapping_of(code):
        m = 0
        for i in range(33):
            if code >> i & 1:
                m ^= M.basis[i]
        return m
    # H1: pi_i orthogonal to RM(2,8): affine equations in the code
    while True:
        bm = mapping_of(base); dm = [mapping_of(d) for d in dirs]
        rows = []
        for i in range(4):
            bi = (bm >> (256 * i)) & MASK
            di = [(d >> (256 * i)) & MASK for d in dm]
            for m in M.rm2:
                v = sum((((di[j] & m).bit_count() & 1) << j) for j in range(len(dirs)))
                rows.append((v, (bi & m).bit_count() & 1))
        sol = lin_solve(rows, len(dirs))
        if sol is None:
            return None
        part, ker = sol
        nb = base
        for j in range(len(dirs)):
            if part >> j & 1:
                nb ^= dirs[j]
        nd = []
        for k in ker:
            v = 0
            for j in range(len(dirs)):
                if k >> j & 1:
                    v ^= dirs[j]
            nd.append(v)
        changed = len(nd) != len(dirs)
        base, dirs = nb, nd
        if level == "H1" or not changed:
            break
    if level in ("H3", "H4"):
        r = space_for(M, kappa, "H2")
        if r is None:
            return None
        base, dirs = r
        while True:
            n = len(dirs)
            if level == "H4":
                # balance (all fibres of size 16) through the repository's character-sum
                # consequences: sum_x (-1)^{v.pi(x)} = 0, restricted to points where the
                # character does not depend on s (affine consequences of the spectra)
                from dim4_balance_charts import character_sums
                from line_column_autocorrelation import affine_consequences
                shift, kernel, _ = affine_consequences(
                    list(character_sums(mapping_of(base), [mapping_of(d) for d in dirs])), n)
                if shift is None:
                    return None
                for j in range(n):
                    if shift >> j & 1:
                        base ^= dirs[j]
                nd = []
                for k in kernel:
                    v = 0
                    for j in range(n):
                        if k >> j & 1:
                            v ^= dirs[j]
                    nd.append(v)
                dirs = nd
            rows = full_product_consequences(M, base, dirs, mapping_of)
            sol = lin_solve(rows, len(dirs))
            n = len(dirs) if level == "H3" else n
            if sol is None:
                return None
            part, ker = sol
            if len(ker) == n:
                break
            nb = base
            for j in range(n):
                if part >> j & 1:
                    nb ^= dirs[j]
            nd = []
            for k in ker:
                v = 0
                for j in range(n):
                    if k >> j & 1:
                        v ^= dirs[j]
                nd.append(v)
            base, dirs = nb, nd
        return base, dirs
    if level == "H2":
        # linear consequences of product moments: evaluate polynomial equations by interpolation
        # (degree <= 4) and keep the affine ones; iterate.
        while True:
            n = len(dirs)
            rows = linear_product_consequences(M, base, dirs, mapping_of)
            sol = lin_solve(rows, n)
            if sol is None:
                return None
            part, ker = sol
            if len(ker) == n:
                break
            nb = base
            for j in range(n):
                if part >> j & 1:
                    nb ^= dirs[j]
            nd = []
            for k in ker:
                v = 0
                for j in range(n):
                    if k >> j & 1:
                        v ^= dirs[j]
                nd.append(v)
            base, dirs = nb, nd
    return base, dirs


def linear_product_consequences(M, base, dirs, mapping_of):
    """Support moments for products of 2 label coordinates (degree 2 polynomials in the code):
    take the linear span of their ANF and keep combinations that are affine (degree <= 1)."""
    n = len(dirs)
    pts = {0: mapping_of(base)}
    for i in range(n):
        pts[1 << i] = pts[0] ^ mapping_of(dirs[i]) ^ mapping_of(0)
    for i, j in combinations(range(n), 2):
        pts[(1 << i) | (1 << j)] = pts[1 << i] ^ pts[1 << j] ^ pts[0]  # mapping is affine
    def moments(mp):
        c = M.comps(mp)
        vals = []
        for i, j in combinations(range(4), 2):
            w = c[i] & c[j]
            for m in M.rm2:
                vals.append((w & m).bit_count() & 1)
        return vals
    V = {k: moments(v) for k, v in pts.items()}
    neq = len(V[0])
    # ANF coefficients
    quad = [(i, j) for i, j in combinations(range(n), 2)]
    polys = []
    for e in range(neq):
        c0 = V[0][e]
        lin = sum((V[1 << i][e] ^ c0) << i for i in range(n))
        q = 0
        for k, (i, j) in enumerate(quad):
            if V[(1 << i) | (1 << j)][e] ^ V[1 << i][e] ^ V[1 << j][e] ^ c0:
                q |= 1 << k
        polys.append((q, lin, c0))
    # combinations that kill all quadratic parts
    rows = []
    piv = {}
    for q, lin, c0 in polys:
        x = (q << (n + 1)) | (lin << 1) | c0
        while x and (x.bit_length() - 1) in piv and (x >> (n + 1)):
            x ^= piv[x.bit_length() - 1]
        if x >> (n + 1):
            piv[x.bit_length() - 1] = x
        else:
            rows.append(((x >> 1) & ((1 << n) - 1), x & 1))
    return rows


def anf_of(valfun, n, degree, mapping0, dmaps):
    """Evaluate a vector-valued polynomial (list of bits) at points of weight <= degree and
    return the ANF as {monomial_mask: bitvector over equations}."""
    vals = {}
    for k in range(degree + 1):
        for S in combinations(range(n), k):
            mp = mapping0
            for i in S:
                mp ^= dmaps[i]
            vals[sum(1 << i for i in S)] = valfun(mp)
    anf = {}
    for key in vals:
        acc = 0; sub = key
        while True:
            acc ^= vals[sub]
            if sub == 0:
                break
            sub = (sub - 1) & key
        if acc:
            anf[key] = acc
    return anf


def full_product_consequences(M, base, dirs, mapping_of, balance=False):
    """All Boolean support moments: products of 1..4 label coordinates against RM(2,8)
    (degree <= 4 polynomials in the code).  Optionally the fibre-size parity bits
    |P_t| = 16 => |P_t| even and |P_t|/2, |P_t|/4, |P_t|/8 even (bits of weights of products,
    via the identity wt(prod_S pi) = 256/2^|S|, i.e. balance) -- encoded as the mod-2 values of
    the binomial-coefficient polynomials of degree <= 4.  Return the affine combinations."""
    n = len(dirs)
    m0 = mapping_of(base); dm = [mapping_of(d) for d in dirs]
    prods = [S for k in range(1, 5) for S in combinations(range(4), k)]
    def moments(mp):
        c = M.comps(mp)
        bits = 0; e = 0
        for S in prods:
            w = MASK
            for i in S:
                w &= c[i]
            for m in M.rm2:
                if (w & m).bit_count() & 1:
                    bits |= 1 << e
                e += 1
            if balance:
                # binomial(wt, 2^j) mod 2 = bit j of wt; target weight 256 / 2^|S|
                wt = w.bit_count(); target = 256 >> len(S)
                for j in range(1, 4):
                    if ((wt >> j) ^ (target >> j)) & 1:
                        bits |= 1 << e
                    e += 1
        return bits
    anf = anf_of(moments, n, 4, m0, dm)
    # polys: for each equation index, its ANF as a set of monomials
    neq = max((v.bit_length() for v in anf.values()), default=0)
    polys = {}
    for mono, vec in anf.items():
        for e in range(neq):
            if vec >> e & 1:
                polys.setdefault(e, set()).add(mono)
    # gaussian elimination: monomial order by degree (high first); keep affine results
    order = sorted({m for p in polys.values() for m in p}, key=lambda m: (bin(m).count("1"), m))
    idx = {m: i for i, m in enumerate(order)}
    piv = {}; rows = []
    for p in polys.values():
        x = sum(1 << idx[m] for m in p)
        while x:
            top = x.bit_length() - 1
            if bin(order[top]).count("1") <= 1:
                break
            if top in piv:
                x ^= piv[top]
            else:
                piv[top] = x; x = 0
        if x:
            v = 0; c = 0
            for i in range(x.bit_length()):
                if x >> i & 1:
                    m = order[i]
                    if m == 0:
                        c = 1
                    else:
                        v |= m
            rows.append((v, c))
    return rows


def certify(M, base, dirs, degree=4):
    def mapping_of(code):
        m = 0
        for i in range(33):
            if code >> i & 1:
                m ^= M.basis[i]
        return m
    n = len(dirs)
    m0 = mapping_of(base); dm = [mapping_of(d) for d in dirs]
    vals = {}
    resid = []
    for k in range(degree + 1):
        for S in combinations(range(n), k):
            mp = m0
            for i in S:
                mp ^= dm[i]
            key = sum(1 << i for i in S)
            vals[key] = M.columns_mod_L(mp)
    nz = 0
    for key in vals:
        acc = [0] * 19
        sub = key
        while True:
            v = vals[sub]
            acc = [a ^ b for a, b in zip(acc, v)]
            if sub == 0:
                break
            sub = (sub - 1) & key
        if any(acc):
            nz += 1
            if len(resid) < 5:
                resid.append((key, [hex(a) for a in acc]))
    return nz, resid, len(vals)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("repo"); ap.add_argument("--classes", default="129")
    ap.add_argument("--levels", default="H0,H1,H2"); ap.add_argument("--out")
    a = ap.parse_args()
    M = Model(a.repo)
    if a.classes == "all":
        classes = list(range(256))
    elif "/" in a.classes:                      # shard i/m: classes k with k % m == i
        i, m = map(int, a.classes.split("/"))
        classes = [k for k in range(256) if k % m == i]
    else:
        classes = [int(x) for x in a.classes.split(",")]
    report = {}
    for kappa in classes:
        report[kappa] = {}
        for level in a.levels.split(","):
            t0 = time.time()
            sp = space_for(M, kappa, level)
            if sp is None:
                report[kappa][level] = {"empty": True}
                print(kappa, level, "empty", flush=True)
                continue
            base, dirs = sp
            nz, resid, npts = certify(M, base, dirs)
            report[kappa][level] = {"dim": len(dirs), "points": npts, "nonzero_coefficients": nz,
                                    "residues": resid, "base": base, "dirs": dirs,
                                    "seconds": round(time.time() - t0, 1)}
            print(kappa, level, "dim", len(dirs), "nonzero ANF coefficients mod L:", nz,
                  "time", round(time.time() - t0, 1), flush=True)
    if a.out:
        Path(a.out).write_text(json.dumps(report, indent=1))


if __name__ == "__main__":
    main()
