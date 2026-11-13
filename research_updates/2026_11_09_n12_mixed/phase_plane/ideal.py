"""Truncated ideal membership: is each residue component (column mod L) a combination
sum m_i * g_i of support-moment polynomials g_i (products of label coordinates against RM(2,8)),
with multilinear multipliers m_i and total degree <= 4?  Works on a given affine space."""
import sys, json, time, argparse
from itertools import combinations
from pathlib import Path
sys.path.insert(0, str(Path(__file__).parent))
from plane_cert import Model, anf_of, MASK


def polys_of(M, base, dirs):
    def mapping_of(code):
        m = 0
        for i in range(33):
            if code >> i & 1:
                m ^= M.basis[i]
        return m
    n = len(dirs)
    m0 = mapping_of(base); dm = [mapping_of(d) for d in dirs]
    prods = [S for k in range(1, 5) for S in combinations(range(4), k)]
    labels = []
    def moments(mp):
        c = M.comps(mp); bits = 0; e = 0
        for S in prods:
            w = MASK
            for i in S:
                w &= c[i]
            for m in M.rm2:
                if (w & m).bit_count() & 1:
                    bits |= 1 << e
                e += 1
        return bits
    for S in prods:
        for j in range(len(M.rm2)):
            labels.append((S, j))
    anf = anf_of(moments, n, 4, m0, dm)
    gens = {}
    for mono, vec in anf.items():
        e = 0
        while vec:
            if vec & 1:
                gens.setdefault(e, set()).add(mono)
            vec >>= 1; e += 1
    def colfun(mp):
        cols = M.columns_mod_L(mp)
        v = 0
        for a, c in enumerate(cols):
            v |= c << (48 * a)
        return v
    ranf = anf_of(colfun, n, 4, m0, dm)
    targets = {}
    for mono, vec in ranf.items():
        e = 0
        while vec:
            if vec & 1:
                targets.setdefault(e, set()).add(mono)
            vec >>= 1; e += 1
    return n, gens, labels, targets


def member(n, gens, targets, maxdeg=4):
    monos = [sum(1 << i for i in S) for k in range(maxdeg + 1) for S in combinations(range(n), k)]
    idx = {m: i for i, m in enumerate(monos)}
    deg = lambda m: bin(m).count("1")
    piv = {}
    rows = 0
    def insert(x):
        while x:
            t = x.bit_length() - 1
            if t in piv:
                x ^= piv[t]
            else:
                piv[t] = x; return True
        return False
    for e, g in gens.items():
        dg = max(deg(m) for m in g)
        for k in range(maxdeg - dg + 1):
            for S in combinations(range(n), k):
                mul = sum(1 << i for i in S)
                prod = {}
                for m in g:
                    mm = m | mul
                    prod[mm] = prod.get(mm, 0) ^ 1
                x = 0
                for mm, c in prod.items():
                    if c:
                        x ^= 1 << idx[mm]
                insert(x); rows += 1
    out = {}
    for e, t in targets.items():
        x = sum(1 << idx[m] for m in t)
        while x:
            tp = x.bit_length() - 1
            if tp in piv:
                x ^= piv[tp]
            else:
                break
        out[e] = (x == 0)
    return out, len(piv), rows


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("repo"); ap.add_argument("spaces"); ap.add_argument("--classes", required=True)
    ap.add_argument("--level", default="H4")
    a = ap.parse_args()
    M = Model(a.repo)
    S = json.loads(Path(a.spaces).read_text())
    for k in [int(x) for x in a.classes.split(",")]:
        sp = S[str(k)][a.level]
        if sp.get("empty"):
            continue
        t0 = time.time()
        n, gens, labels, targets = polys_of(M, sp["base"], sp["dirs"])
        res, rank, rows = member(n, gens, targets)
        print(k, a.level, "dim", n, "generators", len(gens), "ideal rank", rank, "rows", rows,
              "residue components", len(targets), "in ideal:", sum(res.values()),
              "time", round(time.time() - t0, 1), flush=True)


if __name__ == "__main__":
    main()
