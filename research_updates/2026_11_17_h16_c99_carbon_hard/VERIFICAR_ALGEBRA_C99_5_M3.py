#!/usr/bin/env python3
"""
Step 1: Macaulay M_3 elimination on the 4 linearized affine sub-branches
of dimension 107 induced by Q4 ^ (Q_0x0 ^ Q_0xf) = 1  <=>  I_1 * J_1 = K ^ 1.
"""
import json
import time
from itertools import combinations
from pathlib import Path

from VERIFICAR_ALGEBRA_C99_1 import (
    K_INDICES,
    L_INDICES,
    R_INDICES,
    WITNESSES,
    build_basis_111,
    eval_poly,
    extract_poly_mod4,
    setup_orbits,
)

I1 = [0, 4, 8, 18, 42, 52, 56, 94]
J1 = [14, 22, 46, 71, 81, 85, 98, 106]


def substitute_linear_vars(poly, pivot_map):
    """
    Substitute each pivot variable p -> expr_set (a set of linear bitmasks / 0)
    into a degree <= 3 polynomial `poly` (set of bitmasks).
    """
    out = set()

    def toggle(s, m):
        if m in s:
            s.remove(m)
        else:
            s.add(m)

    piv_mask = 0
    for p in pivot_map:
        piv_mask |= 1 << p

    for m in poly:
        pm = m & piv_mask
        if pm == 0:
            toggle(out, m)
            continue
        base = m ^ pm
        # Collect pivot bits in m (at most 3!)
        pivs = []
        tmp = pm
        while tmp:
            b = tmp & -tmp
            pivs.append(b.bit_length() - 1)
            tmp ^= b
        # Multiply base by product of pivot_map[p]
        cur = {base}
        for p in pivs:
            nxt = set()
            for a in cur:
                for b in pivot_map[p]:
                    toggle(nxt, a | b)
            cur = nxt
        for a in cur:
            toggle(out, a)
    return out


def degrevlex_key(m: int):
    # Higher degree first, then higher bitmask
    return (m.bit_count(), m)


def gf2_macaulay_reduce(polys):
    """Sparse GF(2) Gaussian elimination ordered by (degree, bitmask)."""
    pivots = {}  # lead_monomial -> (lead_key, set_of_monomials)
    for p in polys:
        v = set(p)
        while v:
            lead = max(v, key=degrevlex_key)
            if lead in pivots:
                v ^= pivots[lead]
            else:
                pivots[lead] = v
                break
    return pivots


def main():
    t0 = time.perf_counter()
    repo = Path(__file__).resolve().parents[2]
    orbits = setup_orbits()
    free, origin, cb = build_basis_111()

    # 1. Extract the 5 polynomials over the 110 free vars
    base_polys = {}
    for name, m8 in [("0x3f3f", 0x3F), ("0x5f5f", 0x5F), ("0x6f6f", 0x6F)]:
        small = [v for v in range(256) if (v & m8) == v]
        pairs = [v | (w << 8) for v in small for w in small if v < w]
        words = [sum((sum((x & m) == m for m in orb) % 2) << k for k, x in enumerate(pairs)) for orb in orbits]
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
        base_polys[name] = extract_poly_mod4(basis, O_word, free, const_shift=1)

    coset_orbits = {0x0: [], 0xF: []}
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
            if v in (0x0, 0xF):
                coset_orbits[v].append(members[0])

    for cname, reps in coset_orbits.items():
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
        base_polys[f"Q_{hex(cname)}"] = extract_poly_mod4(basis, O_word, free, const_shift=0)

    # L_coset == 0 equation: Q_0x0 ^ Q_0xf ^ 1 == 0
    L_coset = base_polys["Q_0x0"] ^ base_polys["Q_0xf"] ^ {0}
    cubics = [base_polys["0x3f3f"], base_polys["0x5f5f"], base_polys["0x6f6f"], base_polys["Q_0xf"]]

    # Linear forms for K, u1, v1 in the 110 free variables
    def lin_form(indices):
        mask = sum(1 << j for j in indices)
        s = {1 << j for j, c in zip(free, cb) if (c & mask).bit_count() % 2}
        if (origin & mask).bit_count() % 2:
            s.add(0)
        return s

    f_K = lin_form(K_INDICES)
    f_u1 = lin_form(I1)
    f_v1 = lin_form(J1)

    # Since L = I1 U J1 = 1, u1 ^ v1 = 1 => I1 * J1 = 0 => K = 1 (c57 = c113 = 1) ALWAYS!
    branches = [(1, 0, 1), (1, 1, 0)]
    results = {"linear_law_discovered": "K = 1 (c57 = c113 = 1) forced by L = I1 U J1 = 1 and I1*J1 = K ^ 1", "sub_branches": {}, "witness_branches": {}}

    for wn in ("0xd7", "0xf5"):
        cint = WITNESSES[wn]
        results["witness_branches"][wn] = {
            "K": eval_poly(f_K, cint),
            "u1": eval_poly(f_u1, cint),
            "v1": eval_poly(f_v1, cint),
        }

    for k_val, u1_val, v1_val in branches:
        # Only 2 independent linear equations: K == 1 and u1 == u1_val (v1 == 1 ^ u1 is automatic)
        eqs = [
            f_K ^ ({0} if k_val else set()),
            f_u1 ^ ({0} if u1_val else set()),
        ]
        # Simple RREF over 2 equations
        pivs = {}
        for eq in eqs:
            cur = set(eq)
            for p, pexpr in pivs.items():
                if (1 << p) in cur:
                    cur ^= pexpr
            vars_in = sorted(m.bit_length() - 1 for m in cur if m > 0)
            assert vars_in, "Linear dependency in (K, u1)!"
            p = vars_in[-1]
            pivs[p] = cur ^ {1 << p}
        # Back-substitute so pivot_map RHS has no pivot variables
        changed = True
        while changed:
            changed = False
            for p in list(pivs.keys()):
                for q in list(pivs.keys()):
                    if p != q and (1 << q) in pivs[p]:
                        pivs[p] ^= (pivs[q] ^ {1 << q})
                        changed = True

        rem_vars = [v for v in free if v not in pivs]
        assert len(rem_vars) == 108

        # Restrict L_coset and the 4 cubics to the 107 variables
        L_sub = substitute_linear_vars(L_coset, pivs)
        m3_rows = [L_sub]
        for x in rem_vars:
            bit = 1 << x
            m3_rows.append({m | bit for m in L_sub})
        for cp in cubics:
            m3_rows.append(substitute_linear_vars(cp, pivs))

        pivots = gf2_macaulay_reduce(m3_rows)
        has_one = (0 in pivots and pivots[0] == {0})
        deg1_new = sum(1 for lead in pivots if lead.bit_count() == 1)
        deg2_new = sum(1 for lead in pivots if lead.bit_count() == 2)
        deg3_pivs = sum(1 for lead in pivots if lead.bit_count() == 3)

        results["sub_branches"][f"K{k_val}_u{u1_val}_v{v1_val}"] = {
            "remaining_dim": len(rem_vars),
            "m3_input_rows": len(m3_rows),
            "m3_rank": len(pivots),
            "one_in_m3_span": has_one,
            "deg1_pivots": deg1_new,
            "deg2_pivots": deg2_new,
            "deg3_pivots": deg3_pivs,
        }

    results["elapsed_sec"] = round(time.perf_counter() - t0, 4)
    out_path = repo / "research_updates/2026_11_17_h16_c99_carbon_hard/algebra_c99_5_m3.json"
    out_path.write_text(json.dumps(results, indent=2), encoding="utf-8")
    print(json.dumps(results, indent=2))


if __name__ == "__main__":
    main()
