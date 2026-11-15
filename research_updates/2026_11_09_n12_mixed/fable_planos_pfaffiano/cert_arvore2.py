"""Branching certificates of non-bentness on a whole polar: two exact families of polynomial constraints.

  S-family : S_d(y) = 0 for d != 0 (autocorrelation in the w-directions = Parseval in all 64 columns);
  F-family : the Poisson sums on 4-flats C(y) = 0 mod 2^(5-|I|) (cert_fam2.py).
For each constraint the lowest nonzero bit is an exact F2 polynomial P (cert_arvore.lowest_bit_poly and
cert_fam2.fam2_polys), and bentness forces P = 0.  A node closes with
  'const' : some P == 1;
  'affine': the affine P's are inconsistent;
  'lin'   : 1 is an F2-combination of the listed P's (linearization);
otherwise affine P's restrict the subspace and the node branches on a linear functional of U.
Constraint references: ["S", d] or ["F", p, q, omega, w0, I] (V^perp = {0, p, q, p^q}, I = -1 for the empty set).
Usage: python cert_arvore2.py <polars file> [--shard i/n] [--out file.json] [--max-nodes N]"""
import os, sys, json, time
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from cert_arvore import (restrict_terms, lowest_bit_poly, gf2_solve, restrict_affine, split, dual_functional,
                         polar_data, size)
from bitj import ANN, OM, W0


def tables(T0, K, p, Q):
    T = T0.copy()
    for j in range(len(K)):
        if p >> j & 1:
            T ^= K[j]
    Kp = []
    for q in Q:
        t = np.zeros_like(T0)
        for j in range(len(K)):
            if q >> j & 1:
                t ^= K[j]
        Kp.append(t)
    return T, Kp


def ref_of(sid):
    v, o, w, i = sid
    P4 = ANN[v]
    return ["F", int(P4[1]), int(P4[2]), int(OM[v][o]), int(W0[v][w]), i - 1]


def is_affine(mon):
    return all(J & (J - 1) == 0 for J in mon)


def reduce_track(items):
    """items: list of (ref, poly).  Gaussian elimination over monomials, tracking combinations.
    Returns ('one', refs) if 1 is in the span, else ('ok', affine_basis) where affine_basis is a list of
    (refs, mask, rhs) for an independent set of affine consequences found among the pivot rows."""
    idx = {}
    rows = []
    for k, (ref, P) in enumerate(items):
        r = 0
        for J in P:
            if J == 0:
                r ^= 1
            else:
                if J not in idx:
                    idx[J] = len(idx) + 1
                r ^= 1 << idx[J]
        rows.append((r, 1 << k))
    # order monomials: put nonlinear ones on high bits so that pivots eliminate them first
    lin_ids = sorted(i for J, i in idx.items() if J & (J - 1) == 0)
    non_ids = sorted(i for J, i in idx.items() if J & (J - 1))
    perm = {}
    for new, old in enumerate(lin_ids + non_ids, start=1):
        perm[old] = new
    def remap(r):
        out = r & 1
        x = r >> 1; b = 1
        while x:
            if x & 1:
                out |= 1 << perm[b]
            x >>= 1; b += 1
        return out
    rows = [(remap(r), c) for r, c in rows]
    piv = {}
    for r, c in rows:
        while r > 1 and (r.bit_length() - 1) in piv:
            pr, pc = piv[r.bit_length() - 1]; r ^= pr; c ^= pc
        if r == 1:
            return "one", [items[k][0] for k in range(len(items)) if c >> k & 1]
        if r > 1:
            piv[r.bit_length() - 1] = (r, c)
    nlin = len(lin_ids)
    inv = {v: k for k, v in perm.items()}
    J_of = {i: J for J, i in idx.items()}
    aff = []
    for top, (r, c) in piv.items():
        if top <= nlin:                       # leading monomial linear: the row is affine
            mask = 0
            x = r >> 1; b = 1
            while x:
                if x & 1:
                    mask ^= J_of[inv[b]]
                x >>= 1; b += 1
            aff.append(([items[k][0] for k in range(len(items)) if c >> k & 1], mask, r & 1))
    return "ok", aff


class Prover:
    def __init__(self, T0, K, by_d, use_f=True, use_w=True):
        self.T0, self.K, self.by_d, self.use_f, self.use_w = T0, K, by_d, use_f, use_w
        self.fcalls = 0; self.wcalls = 0
        self.maxlevel = 2 if use_f else (1 if use_w else 0)

    def polys(self, p, Q, level):
        items = []
        for d, terms in sorted(self.by_d.items()):
            r = lowest_bit_poly(restrict_terms(terms, p, Q))
            if r is not None:
                items.append((["S", d], r[1]))
        if level >= 1 and self.use_w:
            from cert_famW import famW_polys
            T, Kp = tables(self.T0, self.K, p, Q)
            self.wcalls += 1
            _, wp = famW_polys(T, Kp)
            items += [(["W", u, b], P) for (u, b), k0, P in wp]
        if level >= 2 and self.use_f:
            from cert_fam2 import fam2_polys_fast
            T, Kp = tables(self.T0, self.K, p, Q)
            self.fcalls += 1
            _, fp = fam2_polys_fast(T, Kp)
            items += [(ref_of(sid), P) for sid, k0, P in fp]
        return items

    def prove(self, p, Q, budget, depth=0):
        steps = []
        level = 0
        while True:
            budget[0] -= 1
            if budget[0] < 0:
                return None
            t_ = time.time()
            items = self.polys(p, Q, level)
            if os.environ.get("CERT_VERBOSE"):
                degs = {}
                for ref, P in items:
                    key = (ref[0], max((bin(J).count("1") for J in P), default=0))
                    degs[key] = degs.get(key, 0) + 1
                print("  depth", depth, "dim", len(Q), "level", level, "polys", sorted(degs.items()),
                      round(time.time() - t_), "s", file=sys.stderr, flush=True)
            for ref, P in items:
                if P == {0}:
                    return {"steps": steps, "leaf": "const", "refs": [ref]}
            status, res = reduce_track(items)
            if status == "one":
                kind = "affine" if all(is_affine(P) for ref, P in items if ref in res) else "lin"
                return {"steps": steps, "leaf": kind, "refs": res}
            if res:
                rows = [(mask, rhs) for refs, mask, rhs in res]
                new = restrict_affine(p, Q, rows)
                assert new is not None
                if len(new[1]) < len(Q):
                    refs = []
                    for rr, _, _ in res:
                        for r in rr:
                            if r not in refs:
                                refs.append(r)
                    steps.append(refs); p, Q = new
                    level = 0
                    continue
            if level < self.maxlevel:
                level += 1
                continue
            if not Q:
                return {"steps": steps, "leaf": "point-open"}
            cnt = [0] * len(Q)
            for ref, P in items:
                for J in P:
                    if J & (J - 1):
                        for i in range(len(Q)):
                            if J >> i & 1:
                                cnt[i] += 1
            j = max(range(len(Q)), key=lambda i: cnt[i])
            phi = dual_functional(Q, j)
            kids = []
            for c in (0, 1):
                sub = split(p, Q, phi, c)
                k = self.prove(sub[0], sub[1], budget, depth + 1)
                if k is None:
                    return None
                kids.append(k)
            return {"steps": steps, "branch": hex(phi), "kids": kids}


def leaves(node, acc):
    if "kids" in node:
        for k in node["kids"]:
            leaves(k, acc)
    else:
        acc[node["leaf"]] = acc.get(node["leaf"], 0) + 1
    return acc


if __name__ == "__main__":
    from bitj import load_model
    from poisson3_lista import todos_subespacos3
    from cert_colunas import pairs_of
    out_path = sys.argv[sys.argv.index("--out") + 1] if "--out" in sys.argv else None
    si, sm = map(int, (sys.argv[sys.argv.index("--shard") + 1] if "--shard" in sys.argv else "0/1").split("/"))
    maxn = int(sys.argv[sys.argv.index("--max-nodes") + 1]) if "--max-nodes" in sys.argv else 200000
    use_f = "--no-f" not in sys.argv
    use_w = "--no-w" not in sys.argv
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
        pr = Prover(T0, K, by_d, use_f, use_w)
        budget = [maxn]
        cert = pr.prove(0, [1 << i for i in range(m)], budget)
        rec = {"polar": hx, "dim_U": m}
        if cert is None:
            rec["status"] = "budget"
        else:
            lv = leaves(cert, {})
            rec["status"] = "open" if "point-open" in lv else "certified"
            rec["nodes"] = size(cert); rec["leaves"] = lv; rec["cert"] = cert
        rec["fam2_calls"] = pr.fcalls; rec["walsh_calls"] = pr.wcalls
        rec["seconds"] = round(time.time() - t0, 1)
        res.append(rec)
        print(hx[:12], "dimU", m, rec["status"], rec.get("nodes"), rec.get("leaves"), "F-calls", pr.fcalls,
              rec["seconds"], "s", flush=True)
        if out_path:
            json.dump(res, open(out_path, "w"))
