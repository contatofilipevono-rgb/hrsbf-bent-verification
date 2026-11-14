"""Next level of the autocorrelation certificates: the second bit.

S_d = 0  <=>  sum_z l_z(theta) = N_d/2 exactly, with l_z = g(z,d) + L_zd(theta) in {0,1}.
Bit 0 gives the affine mod-4 system (cert_autocorr).  Bit 1 (Lucas): binom(s,2) = e_2(l) mod 2, so
    e_2(l)(theta) = sum_{z<z'} l_z l_z'  =  bit 1 of N_d/2      (a quadratic equation in theta).
On the solution space y of the mod-4 system, the 63 quadratics are linearized (monomials y_i y_j as new
unknowns); if that linear system is inconsistent, no theta has all S_d = 0.  Linear algebra only.
Usage: python cert_mod8.py <polars file> [--out file.json]"""
import os, sys, json, time
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from bitj import load_model, solve_affine, table_at
from parseval_dominio import affine_in_w
from cert_colunas import pairs_of


def par(x):
    return bin(x).count("1") & 1


def gf2_consistent(rows, nvar):
    """rows: list of (python int mask over nvar unknowns, rhs)."""
    piv = {}
    for r, b in rows:
        while r:
            c = r.bit_length() - 1
            if c in piv:
                r ^= piv[c][0]; b ^= piv[c][1]
            else:
                piv[c] = (r, b); break
        else:
            if b:
                return False
    return True


def mod8(T0, K):
    m = len(K)
    pairs = pairs_of(T0, K)
    by_d = {}
    for z, d, form, g in pairs:
        if d:
            by_d.setdefault(d, []).append((form, g))
    rows = []
    for d in range(1, 64):
        t = by_d.get(d, []); mask = 0; rhs = (len(t) // 2) & 1
        for form, g in t:
            mask ^= form; rhs ^= g
        rows.append((mask, rhs))
    sol = solve_affine(rows, m)
    if sol is None:
        return {"level": "mod4"}
    P, Q = sol
    n = len(Q)
    qidx = {}
    for i in range(n):
        for j in range(i + 1, n):
            qidx[(i, j)] = n + len(qidx)
    eqs = []
    for d in range(1, 64):
        t = by_d.get(d, [])
        if len(t) < 2:
            continue
        # restricted affine forms: l_z(y) = c + a.y
        A = np.array([[par(form & q) for q in Q] for form, g in t], dtype=np.uint8)      # N x n
        c = np.array([g ^ par(form & P) for form, g in t], dtype=np.uint8)
        # e2 = sum_{z<z'} (c_z + a_z.y)(c_z' + a_z'.y)
        # = sum_{z<z'} c_z c_z' + sum_{z<z'} (c_z a_z' + c_z' a_z).y + sum_{z<z'} (a_z.y)(a_z'.y)
        N = len(t); sc = int(c.sum())
        const = (sc * (sc - 1) // 2) & 1
        lin = ((sc - c.astype(np.int64))[:, None] * A).sum(axis=0) % 2                   # c_z' summed over z' != z
        # quadratic part: sum_{z<z'} a_z a_z'^T  = ((sum a)(sum a)^T - sum a a^T) / ... over F2 use pair sum:
        S = A.astype(np.int64).sum(axis=0)
        Mq = (np.outer(S, S) - A.T.astype(np.int64) @ A.astype(np.int64))                # = 2 * sum_{z<z'} sym part
        # coefficient of y_i y_j (i<j) in sum_{z<z'} (a_z.y)(a_z'.y) is  sum_{z<z'} (a_zi a_z'j + a_zj a_z'i) = Mq[i,j]
        # coefficient of y_i (from y_i^2 = y_i) is  sum_{z<z'} a_zi a_z'i = Mq[i,i] / 2
        lin = (lin + (np.diag(Mq) // 2)) % 2
        mask = 0
        for i in range(n):
            if lin[i]:
                mask |= 1 << i
            for j in range(i + 1, n):
                if Mq[i, j] % 2:
                    mask |= 1 << qidx[(i, j)]
        target = ((N // 2) >> 1) & 1
        eqs.append((mask, target ^ const))
    ok = gf2_consistent(eqs, n + len(qidx))
    return {"level": "open" if ok else "mod8quad", "mod4_solution_dim": n}


if __name__ == "__main__":
    from base12 import pack
    from poisson5 import Bv_table, equacoes
    from poisson3 import eq3
    from poisson3_lista import todos_subespacos3
    out_path = sys.argv[sys.argv.index("--out") + 1] if "--out" in sys.argv else None
    si, sm = map(int, (sys.argv[sys.argv.index("--shard") + 1] if "--shard" in sys.argv else "0/1").split("/"))
    Bb, Gb, Gk, piv = load_model(); Vs = todos_subespacos3()
    res = []
    for k, hx in enumerate(open(sys.argv[1]).read().split()):
        if k % sm != si:
            continue
        t0 = time.time(); val = int(hx, 16)
        B = np.array([[(val >> (64 * a + z)) & 1 for z in range(64)] for a in range(15)], dtype=np.uint8)
        r = pack(B); comb = 0
        while r:
            c = r.bit_length() - 1; r ^= piv[c][0]; comb ^= piv[c][1]
        sel = [j for j in range(len(Bb)) if comb >> j & 1]
        G0 = np.bitwise_xor.reduce(Gb[sel], axis=0) if sel else np.zeros((64, 64), np.uint8)
        Bv = Bv_table(B)
        part, ker = solve_affine(equacoes(Bv, G0, Gk) + eq3(Bv, G0, Gk, Vs), Gk.shape[0])
        T0 = table_at(G0, Gk, part); K = [table_at(np.zeros_like(G0), Gk, v) for v in ker]
        rec = {"polar": hx}
        rec.update(mod8(T0, K)); rec["seconds"] = round(time.time() - t0, 1)
        res.append(rec)
        if out_path:
            json.dump(res, open(out_path, "w"))
    print("done", len(res))
