"""Does the V1 phenomenon hold in another block?  For decode(space):
  - per polar class (top 8 bits), the affine space A_k from the support hypotheses
    (linear consequences of the Boolean moments + balance character sums);
  - exact degree-4 ANF of the 48-moment phase columns on A_k;
  - the span, over all classes, of all ANF coefficient vectors (per phase) = the space that the
    columns can occupy; and the span of the constant terms (columns at the base points).
In V1: constants span L (dim 2) and all coefficients span L + <w> (dim 3, residue x24 * w)."""
import sys, json, time, argparse
from itertools import combinations
from pathlib import Path
from collections import Counter

MASK = (1 << 256) - 1


def lin_solve(rows, n):
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


def rank(vs):
    piv = {}
    for v in vs:
        while v and (v.bit_length() - 1) in piv:
            v ^= piv[v.bit_length() - 1]
        if v:
            piv[v.bit_length() - 1] = v
    return piv


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("repo"); ap.add_argument("--space", type=int, default=2)
    ap.add_argument("--out", required=True); ap.add_argument("--shard", default="0/1")
    a = ap.parse_args()
    si, sm = map(int, a.shard.split("/"))
    sys.path.insert(0, str(Path(a.repo).resolve()))
    from dim4_support_decode import decode
    from dim4_balance_charts import character_sums
    from line_column_autocorrelation import affine_consequences
    model, basis, labels = decode(a.space)
    nb = len(basis); nlow = nb - 8
    phases = model.phases
    xs = [sum(1 << x for x in range(256) if x >> i & 1) for i in range(8)]
    rm2 = [MASK] + xs + [xs[i] & xs[j] for i, j in combinations(range(8), 2)]
    s1, s2 = xs[6], xs[7]
    def mapping_of(code):
        m = 0
        for i in range(nb):
            if code >> i & 1:
                m ^= basis[i]
        return m
    def comps(mp): return [(mp >> (256 * i)) & MASK for i in range(4)]
    def columns(mp):
        c = comps(mp); nc = [MASK ^ w for w in c]; subs = []
        for t in range(16):
            f = MASK
            for i in range(4):
                f &= c[i] if t >> i & 1 else nc[i]
            subs += [f, f & s1, f & s2]
        out = 0
        for k, ph in enumerate(phases):
            col = 0
            for e, s in enumerate(subs):
                if (s & ph).bit_count() & 1:
                    col |= 1 << e
            out |= col << (48 * k)
        return out
    def anf(fun, base, dirs, deg):
        n = len(dirs); m0 = mapping_of(base); dm = [mapping_of(d) for d in dirs]
        vals = {}
        for k in range(deg + 1):
            for S in combinations(range(n), k):
                mp = m0
                for i in S:
                    mp ^= dm[i]
                vals[sum(1 << i for i in S)] = fun(mp)
        res = {}
        for key in vals:
            acc = 0; sub = key
            while True:
                acc ^= vals[sub]
                if sub == 0:
                    break
                sub = (sub - 1) & key
            if acc:
                res[key] = acc
        return res
    def reduce_space(base, dirs):
        # product moments (degree <= 4): affine consequences, iterated; then balance (character sums)
        prods = [S for k in range(1, 5) for S in combinations(range(4), k)]
        def mom(mp):
            c = comps(mp); bits = 0; e = 0
            for S in prods:
                w = MASK
                for i in S:
                    w &= c[i]
                for m in rm2:
                    if (w & m).bit_count() & 1:
                        bits |= 1 << e
                    e += 1
            return bits
        while True:
            n = len(dirs)
            if n == 0:
                return base, dirs
            A = anf(mom, base, dirs, 4)
            polys = {}
            for mono, vec in A.items():
                e = 0
                while vec:
                    if vec & 1:
                        polys.setdefault(e, set()).add(mono)
                    vec >>= 1; e += 1
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
                            mm = order[i]
                            if mm == 0:
                                c = 1
                            else:
                                v |= mm
                    rows.append((v, c))
            sol = lin_solve(rows, n)
            if sol is None:
                return None
            part, ker = sol
            nbse = base
            for j in range(n):
                if part >> j & 1:
                    nbse ^= dirs[j]
            nd = []
            for kk in ker:
                v = 0
                for j in range(n):
                    if kk >> j & 1:
                        v ^= dirs[j]
                nd.append(v)
            base, dirs = nbse, nd
            # balance
            shift, kernel, _ = affine_consequences(list(character_sums(mapping_of(base), [mapping_of(d) for d in dirs])), len(dirs))
            if shift is None:
                return None
            for j in range(len(dirs)):
                if shift >> j & 1:
                    base ^= dirs[j]
            nd = []
            for kk in kernel:
                v = 0
                for j in range(len(dirs)):
                    if kk >> j & 1:
                        v ^= dirs[j]
                nd.append(v)
            if len(nd) == n:
                return base, nd
            dirs = nd
    report = {"space": a.space, "basis": nb, "phases": len(phases), "classes": {}}
    consts = []; allc = []
    t0 = time.time()
    for k in range(256):
        if k % sm != si:
            continue
        sp = reduce_space(k << nlow, [1 << i for i in range(nlow)])
        if sp is None:
            continue
        base, dirs = sp
        A = anf(columns, base, dirs, 4)
        c0 = A.get(0, 0)
        per_phase_const = [(c0 >> (48 * j)) & ((1 << 48) - 1) for j in range(len(phases))]
        per_phase_all = [(v >> (48 * j)) & ((1 << 48) - 1) for v in A.values() for j in range(len(phases))]
        consts += per_phase_const; allc += per_phase_all
        degs = Counter(bin(m).count("1") for m in A)
        report["classes"][k] = {"dim": len(dirs), "anf_terms": len(A), "degrees": dict(degs),
                                "const_rank": len(rank(per_phase_const)), "all_rank": len(rank(per_phase_all))}
        print(k, report["classes"][k], round(time.time() - t0), flush=True)
    pc = rank(consts); pa = rank(allc)
    report["span_constants"] = [hex(v) for v in pc.values()]
    report["span_all"] = [hex(v) for v in pa.values()]
    report["constants"] = [hex(v) for v in set(consts) if v]
    report["all_coefficients"] = [hex(v) for v in set(allc) if v]
    print("nonempty classes:", len(report["classes"]), " span of constant columns:", len(pc),
          " span of all ANF coefficients:", len(pa))
    Path(a.out).write_text(json.dumps(report, indent=1))


if __name__ == "__main__":
    main()
