"""Readable data for the small certificates of the special homogeneous polars.

For a polar prefix: rebuild the homogeneous phase (as in homog_especiais.py), replay its certificate and print, at each
node, for every S-constraint used: d, N_d = #{z : d in rad B_z}, and the signs (-1)^{l_z(t)} as a multiset of affine
forms in the node coordinates t (constant part, linear part), plus the lowest-bit polynomial.
Usage: python explica_especiais.py <prefix>"""
import os, sys, json, itertools, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np

pref = sys.argv[1]
here = os.path.dirname(os.path.abspath(__file__))
# --- rebuild exactly as homog_especiais.py (selection of the exact special polar) ---
src = open(os.path.join(here, "homog_especiais.py")).read()
cut = src.index("from cert_colunas import pairs_of")
sys.argv = [sys.argv[0], pref, "--out", os.devnull]
exec(compile(src[:cut], "homog_especiais_setup", "exec"))
# now T0, Kp, hx are defined
from cert_colunas import pairs_of
from verifica_arvore import Polar
import verifica_arvore3 as V3

cert = json.load(open(os.path.join(here, "homog_especiais_out", "homog_%s.json" % pref)))["cert"]
P = Polar(T0, Kp)
m = P.m
print("polar", hx[:24], "... | homogeneous phase dim after (L5)+(L3):", m)
ranks = collections.Counter()
for z in range(64):
    from parseval_dominio import rank_radical
    ranks[rank_radical(T0[z])[0]] += 1
print("rank profile of B_z:", dict(sorted(ranks.items())))


def describe(ref, x0, B):
    d = ref[1]
    t = P.by_d.get(d, [])
    V = np.array([v for v, g in t]); g = np.array([g for v, g in t])
    c = (g + V @ x0) % 2
    coords = (V @ B.T) % 2 if B.shape[0] else np.zeros((len(t), 0), np.int64)
    forms = collections.Counter((int(ci), tuple(int(b) for b in row)) for ci, row in zip(c, coords))
    poly = P.poly(ref, x0, B)
    nconst = sum(v for (ci, row), v in forms.items() if not any(row))
    return {"d": d, "d_bits": format(d, "06b"), "N_d": len(t), "terms_without_phase": nconst,
            "distinct_forms": len(forms), "lowest_bit_poly": sorted(poly) if poly is not None else None,
            "forms": sorted(((ci, "".join(map(str, row))), v) for (ci, row), v in forms.items())}


class Explain(V3.Checker):
    def node(self, n, x0, B, stats, depth=0):
        ind = "  " * depth
        for a in n["actions"]:
            if "compute" in a:
                self.events[a["id"]] = (x0.copy(), B.copy())
            else:
                refs = [u[1] for u in a["restrict"]]
                print(ind + "restrict by the affine part of", [r[1] for r in refs], "| dim", B.shape[0], end=" -> ")
                polys = [self.get(u, x0, B) for u in a["restrict"]]
                one, aff = V3.span_info([p for p in polys if p is not None], B.shape[0])
                x0, B = V3.restrict(x0, B, aff)
                print(B.shape[0])
        if "kids" in n:
            print(ind + "branch on phi = %s (dim %d)" % (n["branch"], B.shape[0]))
            phi = int(n["branch"], 16)
            pv = np.array([phi >> j & 1 for j in range(self.P.m)], dtype=np.int64)
            for c, kid in zip((0, 1), n["kids"]):
                new = V3.restrict(x0, B, [((B @ pv) % 2, (c + int(pv @ x0)) % 2)])
                print(ind + " phi = %d:" % c)
                self.node(kid, new[0], new[1], stats, depth + 1)
            return True
        print(ind + "LEAF %s (dim %d) using:" % (n["leaf"], B.shape[0]))
        for u in n.get("use", []):
            info = describe(u[1], *self.events[u[0]]) if False else None
            # describe on the current subspace (transport is exact: same function)
            xe, Be = self.events[u[0]]
            info = describe(u[1], x0, B)
            print(ind + "   S_d with d=%s (%d): N_d=%d, terms without phase=%d, distinct forms=%d, lowest-bit poly=%s"
                  % (info["d_bits"], info["d"], info["N_d"], info["terms_without_phase"], info["distinct_forms"],
                     info["lowest_bit_poly"]))
            if info["distinct_forms"] <= 8:
                print(ind + "     forms (const, linear part) x count:", info["forms"])
        return True


Explain(P).node(cert, np.zeros(m, np.int64), np.eye(m, dtype=np.int64), {})
