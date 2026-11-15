"""Independent verifier of cert_arvore3.py certificates (inherited constraints).

Each event e records the subspace x0_e + rowspace(B_e) where it was evaluated; a constraint [e, ref] is
computed there exactly (verifica_arvore.Polar.poly) and transported to the current subspace by solving
x0 = x0_e + t0 B_e, B = M B_e (it fails if the current subspace is not inside the event's) and substituting
t_e = t0 + t M.  Steps restrict to the affine part of the span; leaves need 1 in the span.
Usage: python verifica_arvore3.py <certificates.json> [...]"""
import os, sys, json
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from verifica_arvore import Polar, span_info, restrict, solve


def express(x0, B, x0e, Be):
    """t0 (De), M (D x De) with x0 = x0e + t0 Be and B = M Be, or None."""
    De = Be.shape[0]
    sol = solve(Be.T.copy(), (x0 - x0e) % 2, De)
    if sol is None or len(sol[1]):
        return None
    t0 = sol[0]
    M = []
    for row in B:
        s = solve(Be.T.copy(), row % 2, De)
        if s is None:
            return None
        M.append(s[0])
    return t0, np.array(M, dtype=np.int64).reshape(B.shape[0], De)


def transport(P, t0, M):
    """P: frozenset of tuples over the event coordinates.  Returns it over the current coordinates."""
    D = M.shape[0]
    forms = {}
    acc = {}
    for J in P:
        poly = {(): 1}
        for i in J:
            if i not in forms:
                f = {(k,): 1 for k in range(D) if M[k, i]}
                if t0[i]:
                    f[()] = 1
                forms[i] = f
            new = {}
            for a in poly:
                for b in forms[i]:
                    m = tuple(sorted(set(a) | set(b)))
                    new[m] = new.get(m, 0) ^ 1
            poly = {m: 1 for m, v in new.items() if v}
            if not poly:
                break
        for m in poly:
            acc[m] = acc.get(m, 0) ^ 1
    return frozenset(m for m, v in acc.items() if v)


class Checker:
    def __init__(self, P):
        self.P = P; self.events = {}; self.cache = {}

    def get(self, use, x0, B):
        e, ref = use
        x0e, Be = self.events[e]
        key = (e, json.dumps(ref))
        if key not in self.cache:
            self.cache[key] = self.P.poly(ref, x0e, Be)
        Pe = self.cache[key]
        if Pe is None:
            return None
        ex = express(x0, B, x0e, Be)
        if ex is None:
            raise ValueError("current subspace not inside the event subspace")
        return transport(Pe, *ex)

    def node(self, n, x0, B, stats):
        stats["nodes"] = stats.get("nodes", 0) + 1
        for a in n["actions"]:
            if "compute" in a:
                self.events[a["id"]] = (x0.copy(), B.copy())
            else:
                polys = [self.get(u, x0, B) for u in a["restrict"]]
                one, aff = span_info([p for p in polys if p is not None], B.shape[0])
                if one:
                    return True
                new = restrict(x0, B, aff)
                if new is None:
                    return True
                x0, B = new
        if "kids" in n:
            phi = int(n["branch"], 16)
            pv = np.array([phi >> j & 1 for j in range(self.P.m)], dtype=np.int64)
            for c, kid in zip((0, 1), n["kids"]):
                new = restrict(x0, B, [((B @ pv) % 2, (c + int(pv @ x0)) % 2)])
                if new is not None and not self.node(kid, new[0], new[1], stats):
                    return False
            return True
        leaf = n["leaf"]; stats[leaf] = stats.get(leaf, 0) + 1
        polys = [self.get(u, x0, B) for u in n.get("use", [])]
        if leaf == "const":
            return polys[0] == frozenset({()})
        if leaf == "lin":
            return span_info([p for p in polys if p is not None], B.shape[0])[0]
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
        P = Polar(T0, K); stats = {}
        try:
            ok = Checker(P).node(r["cert"], np.zeros(P.m, np.int64), np.eye(P.m, dtype=np.int64), stats)
        except ValueError as e:
            ok = False; print("error:", e)
        for k, v in stats.items():
            tot[k] = tot.get(k, 0) + v
        print(r["polar"][:16], "OK" if ok else "FAIL", stats, flush=True)
        bad += not ok
    print("polars:", len(recs), "failures:", bad, "totals:", tot)
    sys.exit(1 if bad else 0)
