#!/usr/bin/env python3
"""
Step 3B: Full Hybrid XOR-SAT + Exact Coset Cardinality Solver (CaDiCaL 1.9.5)
for branch c99=1 (K1_u0 and K1_u1), including:
- K = 1, u1 in {0,1}, L_coset = 1
- C6 (T28 branch 1)
- P_3f3f == 0, P_5f5f == 0, P_6f6f == 0
- wt(C_0xf) == 128, wt(C_0x5) == 256, wt(C_0x0) in {110, 114, 126, 130}
Also audits any SAT model over all 65,536 entries via FWHT.
"""
import json
import time
from pathlib import Path

from pysat.card import CardEnc, EncType
from pysat.solvers import Solver

from VERIFICAR_ALGEBRA_C99_1 import (
    K_INDICES,
    L_INDICES,
    R_INDICES,
    build_basis_111,
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
            clauses.append([(-lits[i] if (mask >> i) & 1 else lits[i]) for i in range(n)])


def add_long_xor(clauses, lits, rhs, next_var_fn):
    cur = list(lits)
    while len(cur) > 4:
        chunk = cur[:3]
        aux = next_var_fn()
        add_xor_clause(clauses, chunk + [aux], 0)
        cur = [aux] + cur[3:]
    add_xor_clause(clauses, cur, rhs)


def add_and_gate(clauses, out_lit, in_lits):
    for x in in_lits:
        clauses.append([-out_lit, x])
    clauses.append([out_lit] + [-x for x in in_lits])


def encode_poly_zero(clauses, poly_set, free_pos, next_var_fn):
    rhs = 1 if (0 in poly_set) else 0
    lits = []
    for m in poly_set:
        if m == 0:
            continue
        bits = []
        tmp = m
        while tmp:
            b = tmp & -tmp
            bits.append(free_pos[b.bit_length() - 1] + 1)
            tmp ^= b
        if len(bits) == 1:
            lits.append(bits[0])
        else:
            mv = next_var_fn()
            add_and_gate(clauses, mv, bits)
            lits.append(mv)
    add_long_xor(clauses, lits, rhs, next_var_fn)


def audit_65536(c_int, orbits):
    tt = [0] * 65536
    for j in range(116):
        if (c_int >> j) & 1:
            for m in orbits[j]:
                for x in range(65536):
                    if (x & m) == m:
                        tt[x] ^= 1
    spec = [1 - 2 * v for v in tt]
    step = 1
    while step < 65536:
        for i in range(0, 65536, step << 1):
            for j in range(step):
                u, v = spec[i + j], spec[i + j + step]
                spec[i + j], spec[i + j + step] = u + v, u - v
        step <<= 1
    first_fail = next(({"mask_hex": hex(b), "weight": b.bit_count(), "val": spec[b]} for b in range(65536) if abs(spec[b]) != 256), None)
    return {
        "coefficients_hex": hex(c_int),
        "W_f_0": spec[0],
        "W_f_e0": spec[1],
        "is_bent": (first_fail is None),
        "first_fail": first_fail,
    }


def main():
    t0 = time.perf_counter()
    repo = Path(__file__).resolve().parents[2]
    cert_t28 = json.loads((repo / "quartic_audit_2026_10_17/archive/T28_SEXTA_CERTIFICADO.json").read_text(encoding="utf-8"))
    orbits = setup_orbits()
    free, origin, cb = build_basis_111()
    free_pos = {j: i for i, j in enumerate(free)}

    # Build coset orbit incidence for 0xf (256), 0x0 (240), 0x5 (512)
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

    # Extract 0x3f3f, 0x5f5f, 0x6f6f
    support_polys = {}
    for name, m8 in [("0x3f3f", 0x3F), ("0x5f5f", 0x5F), ("0x6f6f", 0x6F)]:
        small = [v for v in range(256) if (v & m8) == v]
        pairs = [v | (w << 8) for v in small for w in small if v < w]
        words = [sum((sum((x & m) == m for m in orb) % 2) << k for k, x in enumerate(pairs)) for orb in orbits]
        O_w = 0
        for j in range(116):
            if (origin >> j) & 1:
                O_w ^= words[j]
        b_w = []
        for cdir in cb:
            w = 0
            for j in range(116):
                if (cdir >> j) & 1:
                    w ^= words[j]
            b_w.append(w)
        support_polys[name] = extract_poly_mod4(b_w, O_w, free, const_shift=1)

    # Extract C6 (T28 branch 1) restricted to the 110 free vars
    # Note: in T28 branch 1, excluded = {0, 23, 57, 99, 113, 115}, whereas here excluded = {0, 5, 57, 99, 113, 115}.
    # Wait: c23 is a free var in our 110 vars, while c5 was eliminated by R=0!
    # So we simply substitute c_5 = parity(R\{5}) into T28 branch 1's polynomial!
    # Even simpler: T28 branch 1 polynomial only uses {free_T28}; any monomial with bit 5 gets multiplied by R\{5}!
    poly_t28 = [int(h, 16) for h in cert_t28["reduced_models"]["branches"][1]["polynomial_hex"]]
    R_no5_expr = {1 << j for j in R_INDICES if j != 5} | ({0} if False else set())
    # Substitute bit 5 -> R\{5}:
    c6_poly = set()
    def tog(s, m):
        if m in s: s.remove(m)
        else: s.add(m)
    for m in poly_t28:
        if (m >> 5) & 1:
            base = m ^ (1 << 5)
            for rbit in R_no5_expr:
                tog(c6_poly, base | rbit)
        else:
            tog(c6_poly, m)

    def lin_expr(indices):
        mask = sum(1 << j for j in indices)
        idxs = [i for i, c in enumerate(cb) if (c & mask).bit_count() % 2]
        const = (origin & mask).bit_count() % 2
        return idxs, const

    branch_results = {}
    for u1_val in (0, 1):
        clauses = []
        v_cnt = [110]

        def new_var():
            v_cnt[0] += 1
            return v_cnt[0]

        k_idxs, k_const = lin_expr(K_INDICES)
        add_long_xor(clauses, [i + 1 for i in k_idxs], 1 ^ k_const, new_var)
        u1_idxs, u1_const = lin_expr(I1)
        add_long_xor(clauses, [i + 1 for i in u1_idxs], u1_val ^ u1_const, new_var)

        slin_idxs, slin_const = lin_expr([23, 31, 39, 112])
        prod_vars = []
        for Ir, Jr in [(I2, J2), (I3, J3), (I4, J4)]:
            ui, uc = lin_expr(Ir)
            vi, vc = lin_expr(Jr)
            uv, vv, pv = new_var(), new_var(), new_var()
            add_long_xor(clauses, [i + 1 for i in ui] + [uv], uc, new_var)
            add_long_xor(clauses, [i + 1 for i in vi] + [vv], vc, new_var)
            add_and_gate(clauses, pv, [uv, vv])
            prod_vars.append(pv)
        add_long_xor(clauses, [i + 1 for i in slin_idxs] + prod_vars, 1 ^ slin_const, new_var)

        # Coset 0xf: wt == 128
        n_f, O_f, b_f = coset_words[0xF]
        y_f = []
        for k in range(n_f):
            yk = new_var()
            add_long_xor(clauses, [i + 1 for i, bw in enumerate(b_f) if (bw >> k) & 1] + [yk], (O_f >> k) & 1, new_var)
            y_f.append(yk)
        cf = CardEnc.equals(lits=y_f, bound=128, top_id=v_cnt[0], encoding=EncType.seqcounter)
        v_cnt[0] = max(v_cnt[0], cf.nv)
        clauses.extend(cf.clauses)

        # Coset 0x5: wt == 256
        n_5, O_5, b_5 = coset_words[0x5]
        y_5 = []
        for k in range(n_5):
            yk = new_var()
            add_long_xor(clauses, [i + 1 for i, bw in enumerate(b_5) if (bw >> k) & 1] + [yk], (O_5 >> k) & 1, new_var)
            y_5.append(yk)
        c5 = CardEnc.equals(lits=y_5, bound=256, top_id=v_cnt[0], encoding=EncType.seqcounter)
        v_cnt[0] = max(v_cnt[0], c5.nv)
        clauses.extend(c5.clauses)

        # Coset 0x0: 110 <= wt <= 130
        n_0, O_0, b_0 = coset_words[0x0]
        y_0 = []
        for k in range(n_0):
            yk = new_var()
            add_long_xor(clauses, [i + 1 for i, bw in enumerate(b_0) if (bw >> k) & 1] + [yk], (O_0 >> k) & 1, new_var)
            y_0.append(yk)
        c0_lo = CardEnc.atleast(lits=y_0, bound=110, top_id=v_cnt[0], encoding=EncType.seqcounter)
        v_cnt[0] = max(v_cnt[0], c0_lo.nv)
        clauses.extend(c0_lo.clauses)
        c0_hi = CardEnc.atmost(lits=y_0, bound=130, top_id=v_cnt[0], encoding=EncType.seqcounter)
        v_cnt[0] = max(v_cnt[0], c0_hi.nv)
        clauses.extend(c0_hi.clauses)

        # Support polynomials + C6
        for pname in ("0x3f3f", "0x5f5f", "0x6f6f"):
            encode_poly_zero(clauses, support_polys[pname], free_pos, new_var)
        encode_poly_zero(clauses, c6_poly, free_pos, new_var)

        ts = time.perf_counter()
        with Solver(name="cadical195", bootstrap_with=clauses) as slv:
            sat = slv.solve()
            dt = time.perf_counter() - ts
            audit = None
            if sat:
                model = slv.get_model()
                cint = origin
                for i, cdir in enumerate(cb):
                    if model[i] > 0:
                        cint ^= cdir
                audit = audit_65536(cint, orbits)

        branch_results[f"K1_u{u1_val}"] = {
            "vars": v_cnt[0],
            "clauses": len(clauses),
            "sat": bool(sat),
            "solve_sec": round(dt, 4),
            "audit": audit,
        }

    out = {"branch_results": branch_results, "elapsed_sec": round(time.perf_counter() - t0, 4)}
    out_path = repo / "research_updates/2026_11_17_h16_c99_carbon_hard/xorsat_c99_1_full_report.json"
    out_path.write_text(json.dumps(out, indent=2), encoding="utf-8")
    print(json.dumps(out, indent=2))


if __name__ == "__main__":
    main()
