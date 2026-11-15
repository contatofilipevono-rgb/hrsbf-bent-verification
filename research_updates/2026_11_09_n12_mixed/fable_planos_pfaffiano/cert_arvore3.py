"""Branching certificates with inherited constraints (families S, W, F; see cert_arvore2.py).

A polynomial constraint P = 0 valid on a subspace stays valid, as a function, on every smaller subspace.
So a node keeps the constraints computed at its ancestors, restricted by substitution, and recomputes the
families (S, then W, then F) only when the inherited ones give no progress.
Certificate node: {"actions": [...], then either "leaf"+"use" or "branch"+"kids"}.  Actions:
  {"id": e, "compute": [refs]}   evaluate these constraints on the current subspace (event e);
  {"restrict": [[e, ref], ...]}  restrict to the affine part of the span of those constraints (each taken
                                 from event e, restricted to the current subspace).
Leaves: 'const' (one constraint equal to 1), 'lin' (1 in the span of the listed constraints).
Usage: python cert_arvore3.py <polars file> [--shard i/n] [--out file.json] [--max-nodes N]"""
import os, sys, json, time
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from cert_arvore import restrict_terms, lowest_bit_poly, gf2_solve, to_U, dual_functional, polar_data, par
from cert_arvore2 import tables, ref_of, reduce_track


def mul(A, B):
    out = set()
    for a in A:
        for b in B:
            m = a | b
            if m in out:
                out.remove(m)
            else:
                out.add(m)
    return out


def subst(P, part, ker):
    """Old coordinates t_i = part_i + sum_j ker_j[i] t'_j.  Returns P in the new coordinates."""
    forms = {}
    out = set()
    for J in P:
        r = {0}
        x = J; i = 0
        while x:
            if x & 1:
                if i not in forms:
                    f = {1 << j for j, kv in enumerate(ker) if kv >> i & 1}
                    if part >> i & 1:
                        f.add(0)
                    forms[i] = f
                r = mul(r, forms[i])
                if not r:
                    break
            x >>= 1; i += 1
        for m in r:
            if m in out:
                out.remove(m)
            else:
                out.add(m)
    return out


class Prover3:
    def __init__(self, T0, K, by_d):
        self.T0, self.K, self.by_d = T0, K, by_d
        self.nev = 0; self.calls = {"S": 0, "W": 0, "F": 0}
        self.verbose = bool(os.environ.get("CERT_VERBOSE"))
        self.maxlevel = int(os.environ.get("CERT_MAXLEVEL", "2"))
        self.R = int(os.environ.get("CERT_RECOMPUTE", "6"))
        self.strong = int(os.environ.get("CERT_STRONG", "1"))

    def family(self, level, p, Q):
        out = []
        if level == 0:
            self.calls["S"] += 1
            for d, terms in sorted(self.by_d.items()):
                r = lowest_bit_poly(restrict_terms(terms, p, Q))
                if r is not None:
                    out.append((["S", d], r[1]))
        else:
            T, Kp = tables(self.T0, self.K, p, Q)
            if level == 1:
                from cert_famW import famW_polys
                self.calls["W"] += 1
                out = [(["W", u, b], P) for (u, b), k0, P in famW_polys(T, Kp)[1]]
            else:
                from cert_fam2 import fam2_polys_fast
                self.calls["F"] += 1
                out = [(ref_of(sid), P) for sid, k0, P in fam2_polys_fast(T, Kp)[1]]
        return out

    def lookahead(self, p, Q, phi, c, rounds=4):
        """Dimension removed by fixing phi.y = c and propagating the S-family only (1000 if it closes)."""
        a = 0
        for i, q in enumerate(Q):
            if par(phi & q):
                a |= 1 << i
        part, ker = gf2_solve([(a, c ^ par(phi & p))], len(Q))
        p2, Q2 = to_U(part, ker, p, Q)
        d0 = len(Q)
        for _ in range(rounds):
            items = []
            for d, terms in self.by_d.items():
                r = lowest_bit_poly(restrict_terms(terms, p2, Q2))
                if r is not None:
                    if r[1] == {0}:
                        return 1000
                    items.append((d, r[1]))
            st, res = reduce_track(items)
            if st == "one":
                return 1000
            if not res:
                break
            sol = gf2_solve([(m, r) for _, m, r in res], len(Q2))
            if sol is None:
                return 1000
            if len(sol[1]) == len(Q2):
                break
            p2, Q2 = to_U(sol[0], sol[1], p2, Q2)
        return d0 - len(Q2)

    def use(self, keys):
        out = []
        for ev, ref in keys:
            if ref not in ev["compute"]:
                ev["compute"].append(ref)
            out.append([ev["id"], ref])
        return out

    def prove(self, p, Q, pool, budget, depth=0, computed=-1, since=0):
        """pool: list of (event, ref, P) valid on the current subspace, in its coordinates.
        computed: highest family level already evaluated on exactly this subspace."""
        node = {"actions": []}
        level = computed + 1 if computed >= 0 else 0
        fresh_needed = False
        while True:
            budget[0] -= 1
            if budget[0] < 0:
                return None
            if fresh_needed:
                if level > self.maxlevel:
                    break
                t_ = time.time()
                fam = self.family(level, p, Q)
                ev = {"id": self.nev, "compute": []}; self.nev += 1
                node["actions"].append(ev)
                newrefs = {tuple(map(str, r)) for r, P in fam}
                pool = [e for e in pool if tuple(map(str, e[1])) not in newrefs] + [(ev, r, P) for r, P in fam]
                if self.verbose:
                    print("  depth", depth, "dim", len(Q), "family", "SWF"[level], len(fam), "polys",
                          round(time.time() - t_), "s", file=sys.stderr, flush=True)
                level += 1
            fresh_needed = True
            for ev, ref, P in pool:
                if P == {0}:
                    node.update(leaf="const", use=self.use([(ev, ref)]))
                    return node
            items = [((id(ev), tuple(map(str, ref))), P) for ev, ref, P in pool]
            keymap = {k: (ev, ref) for (k, P), (ev, ref, _) in zip(items, pool)}
            status, res = reduce_track([(k, P) for k, P in items])
            if status == "one":
                node.update(leaf="lin", use=self.use([keymap[k] for k in res]))
                return node
            if res:
                sol = gf2_solve([(mask, rhs) for _, mask, rhs in res], len(Q))
                assert sol is not None
                if len(sol[1]) < len(Q):
                    keys = []
                    for rr, _, _ in res:
                        for k in rr:
                            if k not in keys:
                                keys.append(k)
                    node["actions"].append({"restrict": self.use([keymap[k] for k in keys])})
                    part, ker = sol
                    p, Q = to_U(part, ker, p, Q)
                    pool = [(ev, ref, subst(P, part, ker)) for ev, ref, P in pool]
                    pool = [e for e in pool if e[2]]
                    level = 0; fresh_needed = False      # first retry with the inherited constraints only
                    continue
            if (level == 1 and Q and since < self.R and
                    any(J & (J - 1) for _, _, P in pool for J in P)):
                break                       # nonlinear constraints remain: branch before the costly families
            if level <= self.maxlevel:
                if level >= 1:
                    since = 0
                continue
            break
        if not Q:
            node.update(leaf="point-open"); return node
        cnt = [0] * len(Q)
        for ev, ref, P in pool:
            for J in P:
                if J & (J - 1):
                    for i in range(len(Q)):
                        if J >> i & 1:
                            cnt[i] += 1
        phi = None
        if os.environ.get("CERT_FORMBRANCH", "1") == "1":
            # branch on the most frequent activation form among the S-sums whose polynomial is nonlinear
            nonlin_d = {ref[1] for ev, ref, P in pool if ref[0] == "S" and any(J & (J - 1) for J in P)}
            fc = {}
            for d in nonlin_d:
                for L in restrict_terms(self.by_d[d], p, Q):
                    if L:
                        fc[L] = fc.get(L, 0) + 1
            if fc:
                cands = sorted(fc, key=lambda x: (-fc[x], bin(x).count("1")))[:max(1, self.strong)]
                def to_phi(L):
                    ph = 0
                    for i in range(len(Q)):
                        if L >> i & 1:
                            ph ^= dual_functional(Q, i)
                    return ph
                if len(cands) == 1:
                    phi = to_phi(cands[0])
                else:
                    best = None
                    for L in cands:
                        ph = to_phi(L); score = []
                        for c in (0, 1):
                            score.append(self.lookahead(p, Q, ph, c))
                        sc = (min(score), max(score))
                        if best is None or sc > best[0]:
                            best = (sc, ph)
                    phi = best[1]
        if phi is None:
            j = max(range(len(Q)), key=lambda i: cnt[i])
            phi = dual_functional(Q, j)
        node["branch"] = hex(phi); node["kids"] = []
        for c in (0, 1):
            a = 0
            for i, q in enumerate(Q):
                if par(phi & q):
                    a |= 1 << i
            part, ker = gf2_solve([(a, c ^ par(phi & p))], len(Q))
            p2, Q2 = to_U(part, ker, p, Q)
            pool2 = [(ev, ref, subst(P, part, ker)) for ev, ref, P in pool]
            pool2 = [e for e in pool2 if e[2]]
            k = self.prove(p2, Q2, pool2, budget, depth + 1, computed=-1, since=since + 1)
            if k is None:
                return None
            node["kids"].append(k)
        return node


def size(n):
    return 1 + sum(size(k) for k in n.get("kids", []))


def leaves(n, acc):
    if "kids" in n:
        for k in n["kids"]:
            leaves(k, acc)
    else:
        acc[n["leaf"]] = acc.get(n["leaf"], 0) + 1
    return acc


if __name__ == "__main__":
    from bitj import load_model
    from poisson3_lista import todos_subespacos3
    from cert_colunas import pairs_of
    out_path = sys.argv[sys.argv.index("--out") + 1] if "--out" in sys.argv else None
    si, sm = map(int, (sys.argv[sys.argv.index("--shard") + 1] if "--shard" in sys.argv else "0/1").split("/"))
    maxn = int(sys.argv[sys.argv.index("--max-nodes") + 1]) if "--max-nodes" in sys.argv else 10 ** 7
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
        pr = Prover3(T0, K, by_d)
        cert = pr.prove(0, [1 << i for i in range(m)], [], [maxn])
        rec = {"polar": hx, "dim_U": m, "format": "arvore3"}
        if cert is None:
            rec["status"] = "budget"
        else:
            lv = leaves(cert, {})
            rec["status"] = "open" if "point-open" in lv else "certified"
            rec["nodes"] = size(cert); rec["leaves"] = lv; rec["cert"] = cert
        rec["calls"] = pr.calls; rec["seconds"] = round(time.time() - t0, 1)
        res.append(rec)
        print(hx[:12], "dimU", m, rec["status"], rec.get("nodes"), rec.get("leaves"), pr.calls, rec["seconds"], "s", flush=True)
        if out_path:
            json.dump(res, open(out_path, "w"))
