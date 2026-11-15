"""Rewrite a special-polar certificate in the orbit coefficients t_j of f = sum_j t_j O_j (43 quartic orbits).

Prints (markdown) for a polar prefix:
  - the feasible set A (homogeneous, model, given polar, (L5)+(L3)) as: free coefficients and expressions of the others;
  - every node: branch equations and restriction equations, as linear equations in t (with the 2-adic level k0 of the
    S-polynomials they come from: k0 = 1 means a parity equation  sum_{z in Z_d} D_d f(z,0) = N_d/2 mod 2);
  - every leaf: for each S_d used, the multiset of the affine forms D_d f(z,0) (in the free t's of the node) with counts,
    and the value of S_d when it is constant.
Usage: python explica_t.py <prefix> > out.md"""
import os, sys, json, itertools, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np

pref = sys.argv[1]
here = os.path.dirname(os.path.abspath(__file__))
src = open(os.path.join(here, "homog_especiais.py")).read()
cut = src.index("from cert_colunas import pairs_of")
saved_argv = sys.argv
sys.argv = [sys.argv[0], pref, "--out", os.devnull]
import io, contextlib
with contextlib.redirect_stdout(io.StringIO()):
    exec(compile(src[:cut], "homog_especiais_setup", "exec"))
sys.argv = saved_argv
from verifica_arvore import Polar, lowest
import verifica_arvore3 as V3
sys.stdout.reconfigure(encoding="utf-8")

NT = len(TT)                                   # 43
# t-vectors: orbit j <-> bit j
tv_HV = [int(k) for k in ker]                  # HV[k] = sum of TT[i], i in k
def tv_comb(mask, vecs):
    out = 0
    for j in range(len(vecs)):
        if mask >> j & 1:
            out ^= vecs[j]
    return out
tv_PF = [tv_HV[i.bit_length() - 1] for i in pind]
tv_KH = [tv_comb(k, tv_HV) for k in pker]
code_sel = None
for code, x in enumerate(cur):
    if format(x, "x") == hx:
        code_sel = code; break
t_f0 = tv_comb(code_sel, tv_PF)
t_T0 = t_f0 ^ tv_comb(part, tv_KH)
tv_Kp = [tv_comb(v, tv_KH) for v in kerv]
cert = json.load(open(os.path.join(here, "homog_especiais_out", "homog_%s.json" % pref)))["cert"]
P = Polar(T0, Kp)
m = P.m

# orbit evaluation: c_j(z, d) = O_j(x(z,d)) + O_j(x(z,0)), x(z,w) = (z ^ w) | (w << 6)
def xof(z, w):
    return (z ^ w) | (w << 6)
OT = np.array(TT, dtype=np.uint8)              # 43 x 4096
def cvec(z, d):
    col = OT[:, xof(z, d)] ^ OT[:, xof(z, 0)]
    return int(sum(1 << j for j in np.flatnonzero(col)))
Zd = {}
for d in range(1, 64):
    Zd[d] = [z for z in range(64) if (T0[z, d] ^ T0[z, 0]) is not None and all(
        (P.Kt[:, z, d] == P.Kt[:, z, 0]).tolist() or True for _ in [0])]
# radical sets from the polar (independent of the phase): d in rad B_z  <=>  B_z d = 0
from poisson5 import Bv_table
val = int(hx, 16)
Bm = np.array([[(val >> (64 * a + z)) & 1 for z in range(64)] for a in range(15)], dtype=np.uint8)
Bv = Bv_table(Bm)
Zd = {d: [z for z in range(64) if Bv[z, d] == 0] for d in range(1, 64)}


def par(x):
    return bin(x).count("1") & 1


def tname(mask):
    return " + ".join("t%d" % j for j in range(NT) if mask >> j & 1) or "0"


def node_t(x0, B):
    """Node affine subspace in t-coordinates, in reduced echelon form: (base t, rows R, pivots)."""
    base = t_T0 ^ tv_comb(int(sum(int(v) << j for j, v in enumerate(x0))), tv_Kp)
    rows = [tv_comb(int(sum(int(v) << j for j, v in enumerate(r))), tv_Kp) for r in B]
    # reduced echelon on t-bits, pivot = lowest set bit
    R = []
    for r in rows:
        for q in R:
            if r >> (q & -q).bit_length() - 1 & 1:
                r ^= q
        if r:
            p = (r & -r).bit_length() - 1
            R = [q ^ r if q >> p & 1 else q for q in R]
            R.append(r)
    piv = [(q & -q).bit_length() - 1 for q in R]
    for q, p in zip(R, piv):
        if base >> p & 1:
            base ^= q
    return base, R, piv


def restrict_form(c, base, R, piv):
    """The affine function t -> c.t on the node, in its free coefficients t_p (p in piv): (const, mask over t)."""
    const = par(c & base)
    lin = 0
    for q, p in zip(R, piv):
        if par(c & q):
            lin |= 1 << p
    return const, lin


def describe_leaf(d, base, R, piv):
    forms = collections.Counter()
    for z in Zd[d]:
        forms[restrict_form(cvec(z, d), base, R, piv)] += 1
    # S_d as a function: constant iff the phase-dependent forms cancel in pairs (n(c,L) = n(c+1,L))
    nonconst = collections.Counter()
    S0 = 0
    for (c, L), v in forms.items():
        if L == 0:
            S0 += v * (1 - 2 * c)
        else:
            nonconst[L] += v * (1 - 2 * c)
    cancels = all(v == 0 for v in nonconst.values())
    return forms, S0, cancels


class T(V3.Checker):
    def node(self, n, x0, B, stats, depth=0, path="r"):
        ind = "  " * depth
        for a in n["actions"]:
            if "compute" in a:
                self.events[a["id"]] = (x0.copy(), B.copy())
            else:
                refs = [u[1] for u in a["restrict"]]
                polys = [self.get(u, x0, B) for u in a["restrict"]]
                ks = []
                for u in a["restrict"]:
                    d_ = u[1][1]
                    tt = self.P.by_d.get(d_, [])
                    Vv = np.array([v for v, g in tt]); gg = np.array([g for v, g in tt])
                    cc = (gg + Vv @ x0) % 2
                    co = (Vv @ B.T) % 2 if B.shape[0] else np.zeros((len(tt), 0), np.int64)
                    rr = lowest(co.astype(bool), 1 - 2 * cc, 6)
                    ks.append((d_, rr[0] if rr else None))
                one, aff = V3.span_info([p for p in polys if p is not None], B.shape[0])
                new = V3.restrict(x0, B, aff)
                b0, R0, p0 = node_t(x0, B)
                b1, R1, p1 = node_t(*new)
                # equations cut out: express the new subspace by linear equations on the old free coefficients
                eqs = affine_equations(b0, R0, p0, b1, R1)
                print(ind + "- **Restrição** por S_d = 0, d ∈ %s (nível k0 de cada: %s) (dim %d → %d):" % (
                    [r[1] for r in refs], ", ".join("d=%d:k0=%s" % kv for kv in ks), B.shape[0], new[1].shape[0]))
                for e in eqs:
                    print(ind + "  - %s" % e)
                x0, B = new
        if "kids" in n:
            phi = int(n["branch"], 16)
            pv = np.array([phi >> j & 1 for j in range(self.P.m)], dtype=np.int64)
            b0, R0, p0 = node_t(x0, B)
            for c, kid in zip((0, 1), n["kids"]):
                new = V3.restrict(x0, B, [((B @ pv) % 2, (c + int(pv @ x0)) % 2)])
                b1, R1, p1 = node_t(*new)
                eqs = affine_equations(b0, R0, p0, b1, R1)
                print(ind + "- **Caso** %s:" % ("; ".join(eqs)))
                self.node(kid, new[0], new[1], stats, depth + 1, path + str(c))
            return True
        b, R, pv_ = node_t(x0, B)
        print(ind + "- **Folha `%s`** (coeficientes livres: %s)" % (n["leaf"], ", ".join("t%d" % p for p in sorted(pv_))))
        for u in n.get("use", []):
            d = u[1][1]
            forms, S0, cancels = describe_leaf(d, b, R, pv_)
            items = ", ".join("%s%s ×%d" % ("1+" if c else "", tname(L) if L else ("1" if c else "0"), v)
                              if L else "%d ×%d" % (c, v) for (c, L), v in sorted(forms.items(), key=lambda kv: (kv[0][1], kv[0][0])))
            print(ind + "  - d = %d = %s, N_d = %d; D_d f(z,0) por z ∈ Z_d: %s" % (d, format(d, "06b"), len(Zd[d]), items))
            if n["leaf"] == "const":
                if cancels:
                    print(ind + "    ⇒ os termos com fase cancelam aos pares; **S_%d = %d ≠ 0**" % (d, S0))
                else:
                    tt = self.P.by_d.get(d, [])
                    Vv = np.array([v for v, g in tt]); gg = np.array([g for v, g in tt])
                    cc = (gg + Vv @ x0) % 2
                    co = (Vv @ B.T) % 2 if B.shape[0] else np.zeros((len(tt), 0), np.int64)
                    k0 = lowest(co.astype(bool), 1 - 2 * cc, 6)[0]
                    print(ind + "    ⇒ não é cancelamento exato: **S_%d ≡ %d (mod %d) em todo ponto**, logo S_%d ≠ 0"
                          % (d, 1 << k0, 1 << (k0 + 1), d))
        return True


def affine_equations(b0, R0, p0, b1, R1):
    """Linear equations (in the free t's of the old node) that cut the new node out of the old one."""
    # parametrize old node by its free coefficients y_p (p in p0); new node points are t = b1 + sum s_i R1_i.
    # find equations a.y = c satisfied on the new node: the new node in old coordinates is an affine subspace.
    def ycoords(t):
        return tuple((t >> p) & 1 for p in p0)
    pts = [ycoords(b1)] + [tuple(a ^ b for a, b in zip(ycoords(b1 ^ r), ycoords(b1))) for r in R1]
    y0 = np.array(pts[0], dtype=np.int64); D = np.array(pts[1:], dtype=np.int64).reshape(len(R1), len(p0))
    # orthogonal complement of the direction space
    M = D.copy() % 2
    # solve M a = 0
    k = len(p0)
    piv = []; r = 0
    M2 = M.copy()
    for c in range(k):
        nz = np.nonzero(M2[r:, c])[0] if r < len(M2) else []
        if len(nz) == 0:
            continue
        pr = nz[0] + r; M2[[r, pr]] = M2[[pr, r]]
        for i in np.nonzero(M2[:, c])[0]:
            if i != r:
                M2[i] ^= M2[r]
        piv.append(c); r += 1
        if r == len(M2):
            break
    free = [c for c in range(k) if c not in piv]
    eqs = []
    for fcol in free:
        a = np.zeros(k, dtype=np.int64); a[fcol] = 1
        for i, c in enumerate(piv):
            a[c] = M2[i, fcol]
        rhs = int(a @ y0) % 2
        eqs.append("%s = %d" % (" + ".join("t%d" % p0[i] for i in range(k) if a[i]) or "0", rhs))
    return eqs


print("## Polar %s…" % hx[:12])
print()
print("Fase homogênea depois de (L5)+(L3): dimensão %d. Raios Z_d = {z : B_z d = 0} fixados pela polar." % m)
b, R, pv_ = node_t(np.zeros(m, np.int64), np.eye(m, dtype=np.int64))
print("Coeficientes livres no início: %s." % ", ".join("t%d" % p for p in sorted(pv_)))
print("Os demais t_j são determinados (afins) por estes; o ponto-base tem t = %s." % tname(b))
print()
T(P).node(cert, np.zeros(m, np.int64), np.eye(m, dtype=np.int64), {})
