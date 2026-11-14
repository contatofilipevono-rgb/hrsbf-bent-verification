"""Certificates for the joint Parseval condition (all 64 columns), via autocorrelation in the w-directions.

E_b(theta) = 64 sum_d S_d(theta) (-1)^{b.d}, with
    S_d(theta) = sum_{z : d in rad B_z} (-1)^{g(z,d) + L_zd(theta)},  g(z,d) = f0(z,d) + f0(z,0),
so  E_b = 4096 for all b  <=>  S_d = 0 for every d != 0   (64 S_d is the autocorrelation of f at (0, d)).
Levels, none of which enumerates theta:
  odd   : N_d = #{z : d in rad B_z} odd for some d != 0  ->  S_d != 0 always (depends on the polar only);
  mod4  : S_d = 0 forces  XOR_z [g(z,d) + L_zd(theta)] = N_d/2 mod 2, an affine equation in theta;
          if the system over all d is inconsistent, no theta works;
  mod8+ : on the solution space of the mod-4 system, S_d is checked for a constant nonzero residue
          mod 8 / mod 16 / ... by the integer coefficients of its character expansion.
Usage: python cert_autocorr.py <polars file> [--shard i/n] [--out file.json]"""
import os, sys, json, time, itertools
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from bitj import load_model, solve_affine, table_at
from parseval_dominio import affine_in_w
from cert_colunas import pairs_of


def solve(rows, m):
    """rows: list of (mask, rhs) over m unknowns.  Returns (particular, kernel basis) or None."""
    return solve_affine(rows, m)


def residue_certificate(terms, m, part, ker, maxk=6):
    """terms: list of (form over m, g).  S(theta) = sum (-1)^{g + form(theta)} on theta = part + span(ker).
    Find the largest k such that S is constant mod 2^k on that space and report the residue.
    Uses character coordinates of the restricted forms; integer coefficients (-2)^|J| sum_{l>=J} n_l."""
    n = {}
    for form, g in terms:
        # restrict the form to the affine space: value = form(part) + sum_j y_j form(ker_j)
        c = bin(form & part).count("1") & 1
        lf = 0
        for j, kv in enumerate(ker):
            if bin(form & kv).count("1") & 1:
                lf |= 1 << j
        n[lf] = n.get(lf, 0) + (1 - 2 * (g ^ c))
    n = {L: v for L, v in n.items() if v}
    basis = []
    for L in n:
        x = L
        for p, b in basis:
            if x >> p & 1:
                x ^= b
        if x:
            basis.append((x.bit_length() - 1, x))
    C = {}
    for L, v in n.items():
        x, c = L, 0
        for t, (p, b) in enumerate(basis):
            if x >> p & 1:
                x ^= b; c |= 1 << t
        C[c] = v
    D = len(basis); const = C.get(0, 0) + 0
    # S(0) in these coordinates = sum of all n
    S0 = sum(C.values())
    best = 0
    for k in range(1, maxk + 1):
        mod = 1 << k; ok = True
        for deg in range(1, min(D, k) + 1):        # (-2)^deg factor: degrees >= k vanish mod 2^k
            for J in itertools.combinations(range(D), deg):
                mask = sum(1 << j for j in J)
                if ((sum(v for c, v in C.items() if c & mask == mask)) << deg) % mod:
                    ok = False; break
            if not ok:
                break
        if not ok:
            break
        best = k
    return {"D": D, "S0": S0, "constant_mod": 1 << best, "residue": S0 % (1 << best) if best else None}


def analyse(T0, K):
    m = len(K)
    pairs = pairs_of(T0, K)
    by_d = {}
    for z, d, form, g in pairs:
        if d:
            by_d.setdefault(d, []).append((form, g))
    out = {"N_d": {d: len(v) for d, v in by_d.items()}}
    odd = sorted(d for d in range(1, 64) if len(by_d.get(d, [])) % 2)
    if odd:
        out.update(level="odd", witness_d=odd[0], odd_directions=odd)
        return out
    rows = []
    for d in range(1, 64):
        terms = by_d.get(d, [])
        mask = 0; rhs = (len(terms) // 2) & 1
        for form, g in terms:
            mask ^= form; rhs ^= g
        rows.append((mask, rhs))
    sol = solve(rows, m)
    if sol is None:
        out.update(level="mod4", rank=None)
        return out
    part, ker = sol
    out["mod4_solution_dim"] = len(ker)
    for d in range(1, 64):
        terms = by_d.get(d, [])
        if not terms:
            continue
        rc = residue_certificate(terms, m, part, ker)
        if rc["residue"] is not None and rc["residue"] != 0:
            out.update(level="mod%d" % rc["constant_mod"], witness_d=d, cert=rc)
            return out
    out.update(level="open")
    return out


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
        t0 = time.time()
        val = int(hx, 16)
        B = np.array([[(val >> (64 * a + z)) & 1 for z in range(64)] for a in range(15)], dtype=np.uint8)
        r = pack(B); comb = 0
        while r:
            c = r.bit_length() - 1; r ^= piv[c][0]; comb ^= piv[c][1]
        sel = [j for j in range(len(Bb)) if comb >> j & 1]
        G0 = np.bitwise_xor.reduce(Gb[sel], axis=0) if sel else np.zeros((64, 64), np.uint8)
        Bv = Bv_table(B)
        part, ker = solve_affine(equacoes(Bv, G0, Gk) + eq3(Bv, G0, Gk, Vs), Gk.shape[0])
        T0 = table_at(G0, Gk, part); K = [table_at(np.zeros_like(G0), Gk, v) for v in ker]
        assert all(affine_in_w(Ki[z]) for Ki in K for z in range(64))
        rec = {"polar": hx, "dim_U": len(ker), "part": hex(part), "ker": [hex(v) for v in ker]}
        rec.update(analyse(T0, K))
        rec["seconds"] = round(time.time() - t0, 1)
        res.append(rec)
        print(hx[:12], "level", rec["level"], "witness d", rec.get("witness_d"), "mod4 dim", rec.get("mod4_solution_dim"),
              rec["seconds"], "s", flush=True)
        if out_path:
            json.dump(res, open(out_path, "w"))
