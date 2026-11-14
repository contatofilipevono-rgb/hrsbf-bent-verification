"""Cell certificate for x24 = 0 (hence the common phase plane) in every polar class of V1.

On the affine space A_k (support moments + balance, see plane_cert.py), take the hyperplane
x24 = 1.  The quotient map rho = pi0 mod <1111> on 64 points is affine in the code; its fibres
are affine cells.  For each value of rho:
  * preliminary support conditions that depend only on rho (size hypothesis on pairs and
    orthogonality on the active slices):  |Z_[t]| = 8,  a e_t and b e_t orthogonal to RM(1,6),
    |Z_[t] ∩ M| even;
  * for every surviving cell, a single support equation that is constant 1 on the whole cell:
    a Boolean moment  sum_{x in P_t} m(x)  (m in RM(2,8), orthogonality), or the parity |P_t|.
    If none exists, fall back to "every point of the cell has some fibre of size != 16".
Prints, per class, the number of rho values, of surviving cells and the certificate used.
"""
import sys, json, time, argparse
from collections import Counter
from itertools import combinations
from pathlib import Path
sys.path.insert(0, str(Path(__file__).parent))
import plane_cert as PC

MASK = (1 << 256) - 1


def dd(z): return (z & 7) ^ (z >> 3)
def rep(t): return t ^ (15 if t & 8 else 0)


def run_class(M, k):
    sp = PC.space_for(M, k, "H4")
    if sp is None:
        return {"status": "empty"}
    base, dirs = sp
    n = len(dirs)
    # x24 as a functional on the H4 coordinates
    lin = [(d >> 24) & 1 for d in dirs]
    c0 = (base >> 24) & 1
    if not any(lin):
        return {"status": "x24 constant", "value": c0}
    # hyperplane x24 = 1: pick pivot direction p with lin=1
    p = lin.index(1)
    b1 = base if c0 == 1 else base ^ dirs[p]
    d1 = [d ^ dirs[p] if lin[i] else d for i, d in enumerate(dirs) if i != p]
    def mapping_of(code):
        m = 0
        for i in range(33):
            if code >> i & 1:
                m ^= M.basis[i]
        return m
    # derivatives of the map in s (fixed by the class: the 25 low directions do not depend on s)
    lab_b = M.labels(mapping_of(b1))
    D1 = [lab_b[z + 64] ^ lab_b[z] for z in range(64)]
    D2 = [lab_b[z + 128] ^ lab_b[z] for z in range(64)]
    assert all(lab_b[z] ^ lab_b[z + 64] ^ lab_b[z + 128] ^ lab_b[z + 192] == 0 for z in range(64))
    # S = span of all derivative values; quotient labels by S
    Sp = {}
    for v in D1 + D2:
        while v and (v.bit_length() - 1) in Sp:
            v ^= Sp[v.bit_length() - 1]
        if v:
            Sp[v.bit_length() - 1] = v
    S_size = 1 << len(Sp)
    def proj(t):
        for pv in sorted(Sp, reverse=True):
            if t >> pv & 1:
                t ^= Sp[pv]
        return t
    def rho_word(code):
        lab = M.labels(mapping_of(code))
        return sum(proj(lab[z]) << (4 * z) for z in range(64))
    r0 = rho_word(b1)
    piv = {}; rch = []; rker = []
    for d in d1:
        x = rho_word(b1 ^ d) ^ r0; v = d
        while x and (x.bit_length() - 1) in piv:
            px, pv = piv[x.bit_length() - 1]; x ^= px; v ^= pv
        if x:
            piv[x.bit_length() - 1] = (x, v); rch.append((x, v))
        else:
            rker.append(v)
    # extra rho-only filters (F2) only when the derivatives are multiples of 1111 depending on the row:
    # pi(z,s) = pi0(z) + (s1 a(d) + s2 b(d)) 1111
    pair_case = set(D1 + D2) <= {0, 15} and S_size == 2
    if pair_case:
        A = {dd(z) for z in range(64) if D1[z]}; B = {dd(z) for z in range(64) if D2[z]}
        assert all((D1[z] != 0) == (dd(z) in A) and (D2[z] != 0) == (dd(z) in B) for z in range(64))
        Mset = A | B
    xs = [sum(1 << x for x in range(256) if x >> i & 1) for i in range(8)]
    tests = [("1", MASK)] + [(f"x{i}", xs[i]) for i in range(8)] + \
            [(f"x{i}x{j}", xs[i] & xs[j]) for i, j in combinations(range(8), 2)]
    surv = 0; certs = Counter(); fallback = 0
    for sel in range(1 << len(rch)):
        r = r0; code = b1
        for i, (x, v) in enumerate(rch):
            if sel >> i & 1:
                r ^= x; code ^= v
        rho = [(r >> (4 * z)) & 15 for z in range(64)]
        Z = [[z for z in range(64) if rho[z] == t] for t in sorted({proj(t) for t in range(16)})]
        if any(len(s) != 4 * S_size for s in Z):     # sum of |P_t| over a coset of S = 16 |S|
            continue
        ok = True
        for s in (Z if pair_case else []):
            for S in (A, B):
                pts = [z for z in s if dd(z) in S]; acc = 0
                for z in pts:
                    acc ^= z
                if len(pts) % 2 or acc:
                    ok = False
            if sum(dd(z) in Mset for z in s) % 2:
                ok = False
        if not ok:
            continue
        surv += 1
        # evaluate all support moments on every point of the cell
        constant1 = None
        pts = []
        for kk in range(1 << len(rker)):
            cc = code
            for i, v in enumerate(rker):
                if kk >> i & 1:
                    cc ^= v
            pts.append(cc)
        vals = []
        sizes_bad = True
        for cc in pts:
            lab = M.labels(mapping_of(cc))
            fib = [0] * 16
            for x, t in enumerate(lab):
                fib[t] |= 1 << x
            v = {}
            for t in range(16):
                for nm, m in tests:
                    v[(t, nm)] = (fib[t] & m).bit_count() & 1
            vals.append(v)
            if all(f.bit_count() == 16 for f in fib) and not any(v.values()):
                sizes_bad = False       # an admissible point: must never happen
        keys = [key for key in vals[0] if all(v[key] == 1 for v in vals)]
        if keys:
            # prefer a moment of degree 2, then 1, then the size parity
            keys.sort(key=lambda kk: (-len(kk[1]), kk))
            certs[keys[0]] += 1
        else:
            assert sizes_bad, (k, "cell with an admissible point outside x24 = 0")
            fallback += 1
    return {"status": "cells", "dim_A": n, "derivative_span_size": S_size, "pair_case": pair_case,
            "active_rows_a": sorted(A) if pair_case else None, "active_rows_b": sorted(B) if pair_case else None,
            "rho_dim": len(rch), "cell_dim": len(rker),
            "rho_values": 1 << len(rch), "surviving_cells": surv,
            "certificates": {f"P{t}.{nm}": c for (t, nm), c in certs.items()},
            "cells_without_single_moment": fallback}


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("repo"); ap.add_argument("--classes", default="1,22,23,36,37,50,51,128,129,164,165,178,179")
    ap.add_argument("--out", default="cells_x24.json")
    a = ap.parse_args()
    M = PC.Model(a.repo)
    rep_ = {}
    for k in [int(x) for x in a.classes.split(",")]:
        t0 = time.time()
        r = run_class(M, k)
        r["seconds"] = round(time.time() - t0, 1)
        rep_[k] = r
        print(k, json.dumps(r), flush=True)
    Path(a.out).write_text(json.dumps(rep_, indent=1))


if __name__ == "__main__":
    main()
