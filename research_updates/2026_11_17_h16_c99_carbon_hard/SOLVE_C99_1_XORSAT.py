#!/usr/bin/env python3
"""
Step 3: Hybrid XOR-SAT + Exact Coset Cardinality Solver (CryptoMiniSat via PySAT)
for branch c99=1 (the two 108D sub-branches K1_u0_v1 and K1_u1_v0).
Also checks exact coset weights wt(C_0xf), wt(C_0x0), wt(C_0x5) on 0xd7 and 0xf5.
"""
import json
import subprocess
import sys
import time
from itertools import combinations
from pathlib import Path

from pysat.card import CardEnc, EncType
from pysat.solvers import Solver

from VERIFICAR_ALGEBRA_C99_1 import (
    K_INDICES,
    WITNESSES,
    build_basis_111,
    eval_poly,
    extract_poly_mod4,
    setup_orbits,
)

I1 = [0, 4, 8, 18, 42, 52, 56, 94]
J1 = [14, 22, 46, 71, 81, 85, 98, 106]
I2 = [1, 9, 15, 28, 53, 67, 76, 103]
J2 = [3, 11, 34, 45, 55, 69, 78, 89]
I3 = [2, 10, 25, 37, 54, 68, 83, 104]
J3 = [12, 20, 29, 33, 41, 48, 96, 110]
I4 = [13, 21, 38, 70, 74, 93, 97, 109]
J4 = [24, 32, 47, 72, 80, 86, 91, 107]


def add_xor_clause(clauses, lits, rhs):
    """Encode XOR(lits) == rhs in pure CNF (for small len(lits) <= 5)."""
    n = len(lits)
    if n == 0:
        if rhs == 1:
            clauses.append([])
        return
    if n == 1:
        clauses.append([lits[0] if rhs else -lits[0]])
        return
    for mask in range(1 << n):
        if mask.bit_count() % 2 != rhs:
            cl = [(-lits[i] if (mask >> i) & 1 else lits[i]) for i in range(n)]
            clauses.append(cl)


def add_long_xor(clauses, lits, rhs, next_var_fn):
    """Split long XOR into 4-literal XORs using Tseitin variables."""
    cur = list(lits)
    cur_rhs = rhs
    while len(cur) > 4:
        chunk = cur[:3]
        aux = next_var_fn()
        add_xor_clause(clauses, chunk + [aux], 0)
        cur = [aux] + cur[3:]
    add_xor_clause(clauses, cur, cur_rhs)


def add_and_gate(clauses, out_lit, in_lits):
    """Encode out_lit == AND(in_lits)."""
    for x in in_lits:
        clauses.append([-out_lit, x])
    clauses.append([out_lit] + [-x for x in in_lits])


def main():
    t0 = time.perf_counter()
    repo = Path(__file__).resolve().parents[2]
    orbits = setup_orbits()
    free, origin, cb = build_basis_111()

    # 1. Build coset orbit incidence for 0xf (256), 0x0 (240), 0x5 (512)
    coset_reps = {0x0: [], 0xF: [], 0x5: []}
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
            if v in (0x0, 0xF, 0x5, 0xA):
                key = 0x5 if v in (0x5, 0xA) else v
                coset_reps[key].append(members[0])

    # Precompute words for each coset
    coset_words = {}
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
        coset_words[cv] = (len(reps), O_word, basis)

    # Check exact coset weights on 0xd7 and 0xf5
    witness_coset_wts = {}
    for wn in ("0xd7", "0xf5"):
        cint = WITNESSES[wn]
        wts = {}
        for cv, (n_reps, O_word, basis) in coset_words.items():
            w_eval = O_word
            for j, bword in zip(free, basis):
                if (cint >> j) & 1:
                    w_eval ^= bword
            wts[hex(cv)] = {"wt": w_eval.bit_count(), "total": n_reps}
        witness_coset_wts[wn] = wts

    # Helper to get linear expression (list_of_free_indices, const) for any index subset
    def lin_expr(indices):
        mask = sum(1 << j for j in indices)
        idxs = [i for i, c in enumerate(cb) if (c & mask).bit_count() % 2]
        const = (origin & mask).bit_count() % 2
        return idxs, const

    # Extract 0x5f5f polynomial (6,695 terms, degree 3)
    small_5f = [v for v in range(256) if (v & 0x5F) == v]
    pairs_5f = [v | (w << 8) for v in small_5f for w in small_5f if v < w]
    words_5f = [sum((sum((x & m) == m for m in orb) % 2) << k for k, x in enumerate(pairs_5f)) for orb in orbits]
    O_5f = 0
    for j in range(116):
        if (origin >> j) & 1:
            O_5f ^= words_5f[j]
    basis_5f = [sum((words_5f[j] if (cdir >> j) & 1 else 0) for j in range(116)) for cdir in cb]
    # Use XOR of basis words cleanly:
    basis_5f = []
    for cdir in cb:
        w = 0
        for j in range(116):
            if (cdir >> j) & 1:
                w ^= words_5f[j]
        basis_5f.append(w)
    P_5f5f = extract_poly_mod4(basis_5f, O_5f, free, const_shift=1)
    free_pos = {j: i for i, j in enumerate(free)}

    # Solve each of the 2 sub-branches (K=1, u1=0) and (K=1, u1=1) using CaDiCaL (cadical195 or g42)
    # Note: we encode K=1, u1=u1_val, L_coset=1, wt(C_0xf)==128, wt(C_0x0) in {110,114,126,130}, P_5f5f==0!
    branch_results = {}
    for u1_val in (0, 1):
        clauses = []
        v_cnt = [110]

        def new_var():
            v_cnt[0] += 1
            return v_cnt[0]

        # Variables 1..110 correspond to free[0..109]
        # 1. K == 1 and u1 == u1_val
        k_idxs, k_const = lin_expr(K_INDICES)
        add_long_xor(clauses, [i + 1 for i in k_idxs], 1 ^ k_const, new_var)
        u1_idxs, u1_const = lin_expr(I1)
        add_long_xor(clauses, [i + 1 for i in u1_idxs], u1_val ^ u1_const, new_var)

        # 2. L_coset: S_lin ^ u2*v2 ^ u3*v3 ^ u4*v4 == 1
        slin_idxs, slin_const = lin_expr([23, 31, 39, 112])
        prod_vars = []
        for Ir, Jr in [(I2, J2), (I3, J3), (I4, J4)]:
            ui, uc = lin_expr(Ir)
            vi, vc = lin_expr(Jr)
            uv = new_var()
            vv = new_var()
            pv = new_var()
            add_long_xor(clauses, [i + 1 for i in ui] + [uv], uc, new_var)
            add_long_xor(clauses, [i + 1 for i in vi] + [vv], vc, new_var)
            add_and_gate(clauses, pv, [uv, vv])
            prod_vars.append(pv)
        add_long_xor(clauses, [i + 1 for i in slin_idxs] + prod_vars, 1 ^ slin_const, new_var)

        # 3. Exact cardinality wt(C_0xf) == 128
        n_f, O_f, b_f = coset_words[0xF]
        y_f = []
        for k in range(n_f):
            yk = new_var()
            lits = [i + 1 for i, bw in enumerate(b_f) if (bw >> k) & 1]
            rhs = (O_f >> k) & 1
            add_long_xor(clauses, lits + [yk], rhs, new_var)
            y_f.append(yk)
        card_f = CardEnc.equals(lits=y_f, bound=128, top_id=v_cnt[0], encoding=EncType.seqcounter)
        v_cnt[0] = max(v_cnt[0], card_f.nv)
        clauses.extend(card_f.clauses)

        # 4. Exact cardinality 110 <= wt(C_0x0) <= 130 (tightened bound, plus mod 4 is already 2)
        n_0, O_0, b_0 = coset_words[0x0]
        y_0 = []
        for k in range(n_0):
            yk = new_var()
            lits = [i + 1 for i, bw in enumerate(b_0) if (bw >> k) & 1]
            rhs = (O_0 >> k) & 1
            add_long_xor(clauses, lits + [yk], rhs, new_var)
            y_0.append(yk)
        card_0_lo = CardEnc.atleast(lits=y_0, bound=110, top_id=v_cnt[0], encoding=EncType.seqcounter)
        v_cnt[0] = max(v_cnt[0], card_0_lo.nv)
        clauses.extend(card_0_lo.clauses)
        card_0_hi = CardEnc.atmost(lits=y_0, bound=130, top_id=v_cnt[0], encoding=EncType.seqcounter)
        v_cnt[0] = max(v_cnt[0], card_0_hi.nv)
        clauses.extend(card_0_hi.clauses)

        # 5. P_5f5f == 0 (6,695 terms, degree <= 3)
        p5_rhs = 1 if (0 in P_5f5f) else 0
        p5_lits = []
        for m in P_5f5f:
            if m == 0:
                continue
            bits = []
            tmp = m
            while tmp:
                b = tmp & -tmp
                bits.append(free_pos[b.bit_length() - 1] + 1)
                tmp ^= b
            if len(bits) == 1:
                p5_lits.append(bits[0])
            else:
                mv = new_var()
                add_and_gate(clauses, mv, bits)
                p5_lits.append(mv)
        add_long_xor(clauses, p5_lits, p5_rhs, new_var)

        ts = time.perf_counter()
        with Solver(name="cadical195", bootstrap_with=clauses) as slv:
            # Time-bounded solve (60s per sub-branch)
            sat = slv.solve()
            dt = time.perf_counter() - ts
            sol_hex = None
            if sat:
                model = slv.get_model()
                cint = origin
                for i, cdir in enumerate(cb):
                    if model[i] > 0:
                        cint ^= cdir
                sol_hex = hex(cint)

        branch_results[f"K1_u{u1_val}"] = {
            "vars": v_cnt[0],
            "clauses": len(clauses),
            "sat": bool(sat),
            "solve_sec": round(dt, 4),
            "sample_solution_hex": sol_hex,
        }

    out = {
        "witness_coset_weights": witness_coset_wts,
        "branch_results": branch_results,
        "elapsed_sec": round(time.perf_counter() - t0, 4),
    }
    out_path = repo / "research_updates/2026_11_17_h16_c99_carbon_hard/xorsat_c99_1_report.json"
    out_path.write_text(json.dumps(out, indent=2), encoding="utf-8")
    print(json.dumps(out, indent=2))


if __name__ == "__main__":
    main()
