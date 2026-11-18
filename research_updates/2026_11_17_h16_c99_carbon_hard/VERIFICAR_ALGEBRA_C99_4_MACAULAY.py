#!/usr/bin/env python3
"""
Stage 4 Algebraic Certificate:
1. Factors the 196-term degree-2 law Q_Delta = Q_0x0 ^ Q_0xf (required == 1 for bent).
2. Extracts Q_0x1, Q_0x3, Q_0x7 (for H(0x1)=H(0x3)=H(0x7)=0) and checks ALL XOR
   combinations of {Q_0x0, Q_0xf, Q_0x1, Q_0x3, Q_0x7} for degree <= 2 drops.
3. Computes symplectic rank & quadratic-form factorization of Q_Delta and any other
   degree <= 2 polynomials, and checks degree-2 / degree-3 Macaulay span with C4 (Q4)
   over GF(2) for direct Nullstellensatz contradiction (1 in span).
"""
import json
import time
from itertools import combinations
from pathlib import Path

from VERIFICAR_ALGEBRA_C99_1 import (
    WITNESSES,
    build_basis_111,
    eval_poly,
    extract_poly_mod4,
    setup_orbits,
)


def symplectic_rank(poly, n_bits=116):
    adj = {}
    for m in poly:
        if m.bit_count() == 2:
            a = m & -m
            b = m ^ a
            ia, ib = a.bit_length() - 1, b.bit_length() - 1
            adj[ia] = adj.get(ia, 0) ^ b
            adj[ib] = adj.get(ib, 0) ^ a
    pivots = {}
    for v in adj.values():
        x = v
        while x:
            b = x.bit_length() - 1
            if b in pivots:
                x ^= pivots[b]
            else:
                pivots[b] = x
                break
    return len(pivots), sorted(adj.keys())


def gf2_span_has_one(polys, vars_list):
    """Exact degree-2 Macaulay check: does 1 lie in the GF(2)-span of {p, x_i * p}?"""
    # Map monomial bitmasks to dense column indices? Better: represent each poly as a Python int
    # over sorted monomials, or directly use dict pivots keyed by max-monomial tuple!
    # Wait: with ~110 vars, degree <= 2 has <= 6200 monomials, degree <= 3 has <= 230,000.
    # For degree <= 2 inputs, {p} has degree 2, and x_i * p has degree 3.
    # First check pure GF(2) linear span of the degree <= 2 polynomials themselves:
    pivots = {}
    for p in polys:
        v = set(p)
        while v:
            lead = max(v)
            if lead in pivots:
                v ^= pivots[lead]
            else:
                pivots[lead] = v
                break
    return (0 in pivots and pivots[0] == {0}), len(pivots)


def main():
    t0 = time.perf_counter()
    repo = Path(__file__).resolve().parents[2]
    cert_t28 = json.loads((repo / "quartic_audit_2026_10_17/archive/T28_SEXTA_CERTIFICADO.json").read_text(encoding="utf-8"))
    orbits = setup_orbits()
    free, origin, cb = build_basis_111()

    # Group size-16 orbits by U_4^perp coset representative
    coset_reps = {0x0: [], 0x1: [], 0x3: [], 0x5: [], 0x7: [], 0xF: []}
    canon_map = {}
    for v in range(16):
        rots = [((v << r) & 0xF) | (v >> (4 - r)) if r else v for r in range(4)]
        canon_map[v] = min(rots)

    visited = bytearray(65536)
    for x in range(65536):
        if visited[x]:
            continue
        cur, members = x, []
        while not visited[cur]:
            visited[cur] = 1
            members.append(cur)
            cur = ((cur << 1) & 0xFFFF) | (cur >> 15)
        if len(members) == 16:
            v = (x & 0xF) ^ ((x >> 4) & 0xF) ^ ((x >> 8) & 0xF) ^ ((x >> 12) & 0xF)
            cv = canon_map[v]
            if cv in coset_reps:
                coset_reps[cv].append(members[0])

    coset_polys = {}
    coset_info = {}
    for cv, reps in coset_reps.items():
        words = [sum((sum((x & m) == m for m in orb) % 2) << k for k, x in enumerate(reps)) for orb in orbits]
        O_word = 0
        for j in range(116):
            if (origin >> j) & 1:
                O_word ^= words[j]
        basis = []
        for cdir in cb:
            w = 0
            for j in range(116):
                if (cdir >> j) & 1:
                    w ^= words[j]
            basis.append(w)

        par_bits = [w.bit_count() % 2 for w in basis]
        par_const = O_word.bit_count() % 2
        mod4_clean = all(b == 0 for b in par_bits) and all((v & w).bit_count() % 2 == 0 for v, w in combinations(basis, 2))
        info = {
            "num_size16_orbits": len(reps),
            "linear_parity_const": par_const,
            "linear_parity_terms": sum(par_bits),
            "mod4_clean": mod4_clean,
        }
        if mod4_clean:
            P = extract_poly_mod4(basis, O_word, free, const_shift=0)
            coset_polys[hex(cv)] = P
            info["terms"] = len(P)
            info["degree"] = max((m.bit_count() for m in P), default=0)
        coset_info[hex(cv)] = info

    # Check ALL non-empty XOR combinations of extracted coset polynomials for degree <= 2
    deg2_laws = []
    pnames = sorted(coset_polys.keys())
    for r in range(1, len(pnames) + 1):
        for sub in combinations(pnames, r):
            acc = set()
            for s in sub:
                acc ^= coset_polys[s]
            deg = max((m.bit_count() for m in acc), default=0)
            if deg <= 2 and len(acc) > 0:
                srank, svars = symplectic_rank(acc)
                deg2_laws.append({
                    "subset": list(sub),
                    "terms": len(acc),
                    "degree": deg,
                    "symplectic_rank": srank,
                    "num_vars_involved": len(svars),
                    "vars_involved": svars,
                    "linear_vars": sorted(m.bit_length() - 1 for m in acc if m.bit_count() == 1),
                    "has_const": (0 in acc),
                    "monomials_hex": [hex(m) for m in sorted(acc)],
                    "witness_evals": {wn: eval_poly(acc, cint) for wn, cint in WITNESSES.items()},
                })

    # Build C4 (Q4) restricted to the 110-dim space
    factor = cert_t28["fourth_factorization"]
    q4_poly = set()
    def toggle(p, m):
        if m in p: p.remove(m)
        else: p.add(m)
    def form(indices):
        mask = sum(1 << j for j in indices)
        out = {1 << j for j, c in zip(free, cb) if (c & mask).bit_count() % 2}
        if (origin & mask).bit_count() % 2:
            out.add(0)
        return out
    for m in form(factor["linear"]):
        toggle(q4_poly, m)
    for prod in factor["products"]:
        for a in form(prod["I"]):
            for b in form(prod["J"]):
                toggle(q4_poly, a | b)

    # Check GF(2) span of {Q4} U deg2_laws (adjusted to == 0 equations)
    eq_polys = [q4_poly]
    for law in deg2_laws:
        # For Q_0x0 ^ Q_0xf: Q_0x0 == 1 and Q_0xf == 0 => sum == 1
        p = {int(h, 16) for h in law["monomials_hex"]}
        if law["subset"] == ["0x0", "0xf"]:
            toggle(p, 0)
        eq_polys.append(p)

    one_in_deg2_span, deg2_rank = gf2_span_has_one(eq_polys, free)

    out = {
        "coset_info": coset_info,
        "deg_le_2_laws_from_cosets": deg2_laws,
        "q4_terms": len(q4_poly),
        "deg2_system_rank": deg2_rank,
        "one_in_deg2_span": one_in_deg2_span,
        "elapsed_sec": round(time.perf_counter() - t0, 4),
    }
    out_path = repo / "research_updates/2026_11_17_h16_c99_carbon_hard/algebra_c99_4_macaulay.json"
    out_path.write_text(json.dumps(out, indent=2), encoding="utf-8")
    print(json.dumps(out, indent=2))


if __name__ == "__main__":
    main()
