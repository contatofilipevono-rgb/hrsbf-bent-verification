#!/usr/bin/env python3
"""
Step 3C: Exact CSA (Carry-Save Adder) + Cube-and-Conquer + CEGAR Solver
for H(16, 4) branch c99=1 using CaDiCaL 1.9.5.

Encodes:
1. Basis C1-C5, C7 (R=0), T20 (c99=1), K=1 (c57=c113=1), L_coset=1.
2. All 4,080 size-16 rotation orbits + 36 diagonal rotation orbits (D8) once.
3. Exact 6 coset CSA trees:
   - wt(C_0xf) == 128, wt(C_0x5) == 256, wt(C_0x1) == wt(C_0x3) == wt(C_0x7) == 512
   - wt(C_0x0) in {110, 126} (exact for K=1, enforces W_f(u) = +-256 on all 16 of U_4)
4. Exact 9 weighted CSA trees:
   - W_f(e_0) = +-256
   - W_f(d_1..d_8) = +-256 (all 8 weight-2 distances, mask 0xff)
5. 32-cube Cube-and-Conquer over (u1, u2, v2, u3, v3) on 4 workers with CEGAR
   refinement for any SAT counterexample's first failing Walsh frequency.
"""
import json
import os
import time
from collections import defaultdict
from concurrent.futures import ProcessPoolExecutor
from pathlib import Path

from pysat.solvers import Solver

from VERIFICAR_ALGEBRA_C99_1 import (
    K_INDICES,
    WITNESSES,
    build_basis_111,
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

WEIGHT2_FREQS = [0x0003, 0x0005, 0x0009, 0x0011, 0x0021, 0x0041, 0x0081, 0x0101]


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


def add_full_adder(cnf, top_var_ref, a, b, cin):
    s = top_var_ref[0] + 1
    cout = top_var_ref[0] + 2
    top_var_ref[0] += 2
    cnf.extend([
        [-a, -b, -cin, s], [-a, b, cin, s], [a, -b, cin, s], [a, b, -cin, s],
        [a, b, cin, -s], [a, -b, -cin, -s], [-a, b, -cin, -s], [-a, -b, cin, -s],
    ])
    cnf.extend([
        [-a, -b, cout], [-a, -cin, cout], [-b, -cin, cout],
        [a, b, -cout], [a, cin, -cout], [b, cin, -cout],
    ])
    return s, cout


def add_half_adder(cnf, top_var_ref, a, b):
    s = top_var_ref[0] + 1
    cout = top_var_ref[0] + 2
    top_var_ref[0] += 2
    cnf.extend([[-a, -b, -s], [a, b, -s], [-a, b, s], [a, -b, s]])
    cnf.extend([[-a, -b, cout], [a, -cout], [b, -cout]])
    return s, cout


def add_weighted_sum_targets(cnf, top_var_ref, weighted_lits, t_pos, t_neg=None):
    """Imposes sum(w_i * lit_i) in {t_pos, t_neg} (or == t_pos if t_neg is None)."""
    buckets = defaultdict(list)
    max_sum = 0
    for w, lit in weighted_lits:
        assert w > 0
        max_sum += w
        bit = 0
        while (1 << bit) <= w:
            if (w >> bit) & 1:
                buckets[bit].append(lit)
            bit += 1

    t_max = max(max_sum, t_pos, t_pos if t_neg is None else t_neg)
    num_bits = t_max.bit_length() + 1
    out_bits = []
    for col in range(num_bits):
        b = buckets[col]
        while len(b) >= 3:
            x, y, z = b.pop(), b.pop(), b.pop()
            s, c = add_full_adder(cnf, top_var_ref, x, y, z)
            b.append(s)
            buckets[col + 1].append(c)
        if len(b) == 2:
            x, y = b.pop(), b.pop()
            s, c = add_half_adder(cnf, top_var_ref, x, y)
            b.append(s)
            buckets[col + 1].append(c)
        out_bits.append(b[0] if len(b) == 1 else None)

    if t_neg is None or t_pos == t_neg:
        for col, bit_lit in enumerate(out_bits):
            b_val = (t_pos >> col) & 1
            if bit_lit is None:
                assert b_val == 0
                continue
            cnf.append([bit_lit if b_val == 1 else -bit_lit])
        return None

    sel = top_var_ref[0] + 1
    top_var_ref[0] += 1
    for col, bit_lit in enumerate(out_bits):
        b_pos = (t_pos >> col) & 1
        b_neg = (t_neg >> col) & 1
        if bit_lit is None:
            assert b_pos == 0 and b_neg == 0
            continue
        if b_pos == b_neg:
            cnf.append([bit_lit if b_pos == 1 else -bit_lit])
        elif b_pos == 1 and b_neg == 0:
            cnf.extend([[-bit_lit, sel], [bit_lit, -sel]])
        else:
            cnf.extend([[-bit_lit, -sel], [bit_lit, sel]])
    return sel


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
    first_fail = next(
        ({"mask_hex": hex(b), "weight": b.bit_count(), "val": spec[b]} for b in range(65536) if abs(spec[b]) != 256),
        None,
    )
    return {
        "coefficients_hex": hex(c_int),
        "W_f_0": spec[0],
        "W_f_e0": spec[1],
        "w2_8_signed": [spec[b] for b in WEIGHT2_FREQS],
        "is_bent": (first_fail is None),
        "first_fail": first_fail,
    }


def build_all_rot_orbits():
    """Partition all 65,536 points into 4,080 size-16 orbits and 36 short (diagonal) orbits."""
    visited = bytearray(65536)
    canon_map = {}
    for v in range(16):
        canon_map[v] = min(((v << r) & 0xF) | (v >> (4 - r)) if r else v for r in range(4))

    rot_orbits = []
    coset_groups = defaultdict(list)
    for x in range(65536):
        if visited[x]:
            continue
        cur, members = x, []
        while not visited[cur]:
            visited[cur] = 1
            members.append(cur)
            cur = ((cur << 1) & 0xFFFF) | (cur >> 15)
        idx = len(rot_orbits)
        rot_orbits.append(members)
        if len(members) == 16:
            v = (x & 0xF) ^ ((x >> 4) & 0xF) ^ ((x >> 8) & 0xF) ^ ((x >> 12) & 0xF)
            coset_groups[canon_map[v]].append(idx)
        else:
            coset_groups["diag"].append(idx)
    return rot_orbits, coset_groups


def eval_rot_orbit_exprs(rot_orbits, orbits, origin, cb):
    """For each of the 4,116 rotation orbits, compute (O_bit, basis_var_indices)."""
    # Precompute for each of 116 quartic orbits its value on each rot_orbit rep
    reps = [m[0] for m in rot_orbits]
    n_rot = len(reps)
    orb_vals = [[sum((x & m) == m for m in orb) & 1 for x in reps] for orb in orbits]

    exprs = []
    for k in range(n_rot):
        o_bit = 0
        for j in range(116):
            if ((origin >> j) & 1) and orb_vals[j][k]:
                o_bit ^= 1
        idxs = []
        for i, cdir in enumerate(cb):
            v = 0
            for j in range(116):
                if ((cdir >> j) & 1) and orb_vals[j][k]:
                    v ^= 1
            if v:
                idxs.append(i)
        exprs.append((o_bit, idxs))
    return exprs


def walsh_csa_params(freq_a, rot_orbits, y_vars):
    """
    Build weighted_lits, t_pos, t_neg for W_f(freq_a) = +-256 using rotation orbits.
    W_f(a) = sum_k omega_a(O_k) - 2 * sum_k omega_a(O_k) * y_k.
    """
    from math import gcd

    weights_raw = []
    c_const = 0
    for k, members in enumerate(rot_orbits):
        om = sum(1 if ((freq_a & x).bit_count() & 1) == 0 else -1 for x in members)
        c_const += om
        if om != 0:
            weights_raw.append((k, om))

    # Positivize: -2 * om * y_k
    # If om > 0: coeff of y_k is -2*om -> use (-y_k) = 1 - y_k => -2*om + 2*om*(~y_k)
    # If om < 0: coeff of y_k is +2*|om| -> use (+y_k)
    const_after = c_const
    pos_terms = []
    g = 0
    for k, om in weights_raw:
        w2 = 2 * abs(om)
        g = gcd(g, w2)
        if om > 0:
            const_after -= w2
            pos_terms.append((w2, -y_vars[k]))
        else:
            pos_terms.append((w2, y_vars[k]))

    # const_after + sum(w2 * lit) = +-256  =>  sum((w2/g)*lit) = (+-256 - const_after)/g
    rhs_pos = (256 - const_after) // g
    rhs_neg = (-256 - const_after) // g
    assert (256 - const_after) % g == 0 and (-256 - const_after) % g == 0
    weighted_lits = [(w2 // g, lit) for w2, lit in pos_terms]
    return weighted_lits, rhs_pos, rhs_neg


def _solve_cube(task):
    cube_id, assumptions, base_clauses, top_var_init, cube_vars_info, rot_orbits, y_vars, origin, cb, orbits = task
    t0 = time.perf_counter()
    clauses = list(base_clauses)
    v_cnt = [top_var_init]
    cegar_rounds = 0
    cegar_freqs = []

    with Solver(name="cadical195", bootstrap_with=clauses) as slv:
        while True:
            sat = slv.solve(assumptions=assumptions)
            if not sat:
                return {
                    "cube_id": cube_id,
                    "bits": cube_vars_info,
                    "sat": False,
                    "cegar_rounds": cegar_rounds,
                    "cegar_freqs": cegar_freqs,
                    "elapsed_sec": round(time.perf_counter() - t0, 4),
                }
            model = slv.get_model()
            cint = origin
            for i, cdir in enumerate(cb):
                if model[i] > 0:
                    cint ^= cdir
            audit = audit_65536(cint, orbits)
            if audit["is_bent"]:
                return {
                    "cube_id": cube_id,
                    "bits": cube_vars_info,
                    "sat": True,
                    "bent_found": True,
                    "audit": audit,
                    "cegar_rounds": cegar_rounds,
                    "cegar_freqs": cegar_freqs,
                    "elapsed_sec": round(time.perf_counter() - t0, 4),
                }
            # CEGAR refinement on first_fail frequency
            ff_hex = audit["first_fail"]["mask_hex"]
            ff_mask = int(ff_hex, 16)
            cegar_rounds += 1
            cegar_freqs.append({"mask_hex": ff_hex, "weight": audit["first_fail"]["weight"], "val": audit["first_fail"]["val"]})
            new_cnf = []
            wl, tp, tn = walsh_csa_params(ff_mask, rot_orbits, y_vars)
            add_weighted_sum_targets(new_cnf, v_cnt, wl, tp, tn)
            for cl in new_cnf:
                slv.add_clause(cl)
            if cegar_rounds >= 25:
                return {
                    "cube_id": cube_id,
                    "bits": cube_vars_info,
                    "sat": True,
                    "bent_found": False,
                    "audit": audit,
                    "cegar_rounds": cegar_rounds,
                    "cegar_freqs": cegar_freqs,
                    "stopped_reason": "max_cegar_rounds_25",
                    "elapsed_sec": round(time.perf_counter() - t0, 4),
                }


def main():
    t0 = time.perf_counter()
    repo = Path(__file__).resolve().parents[2]
    orbits = setup_orbits()
    free, origin, cb = build_basis_111()
    rot_orbits, coset_groups = build_all_rot_orbits()
    assert len(rot_orbits) == 4116
    assert len(coset_groups[0x0]) == 240
    assert len(coset_groups[0xF]) == 256
    assert len(coset_groups[0x5]) == 512
    assert len(coset_groups[0x1]) == 1024
    assert len(coset_groups[0x3]) == 1024
    assert len(coset_groups[0x7]) == 1024
    assert len(coset_groups["diag"]) == 36

    # Step 0A: Exhaustive 64-vector verification of s in {+-1}^6 congruences
    valid_s = []
    for mask in range(64):
        s0 = 1 if (mask & 1) else -1
        s1 = 1 if (mask & 2) else -1
        s3 = 1 if (mask & 4) else -1
        s5 = 1 if (mask & 8) else -1
        s7 = 1 if (mask & 16) else -1
        sf = 1 if (mask & 32) else -1
        if (s0 + sf + 2 * s5 + 4 * (s1 + s3 + s7)) % 16 != 0:
            continue
        if (s0 + s5 + 2 * s1 + 4) % 8 != 0:
            continue
        if (sf + s5 + 2 * s7 + 4) % 8 != 0:
            continue
        valid_s.append((s0, s1, s3, s5, s7, sf))
    assert valid_s == [(-1, -1, -1, -1, -1, -1), (1, 1, 1, 1, 1, 1)], f"Unexpected valid_s: {valid_s}"

    # Step 0B: Sanity check rotation-orbit Walsh formula on archived witnesses
    sanity = {}
    for wname in ("0xd7", "0xf5", "0xbf"):
        cint = int(WITNESSES[wname], 16)
        aud = audit_65536(cint, orbits)
        y_vals = []
        for members in rot_orbits:
            x = members[0]
            v = 0
            for j in range(116):
                if (cint >> j) & 1:
                    for m in orbits[j]:
                        if (x & m) == m:
                            v ^= 1
            y_vals.append(v)
        for idx_f, freq in enumerate([0x0000, 0x0001] + WEIGHT2_FREQS):
            w_val = sum((1 - 2 * y_vals[k]) * sum(1 if ((freq & x).bit_count() & 1) == 0 else -1 for x in rot_orbits[k]) for k in range(4116))
            if freq == 0x0000:
                assert w_val == aud["W_f_0"]
            elif freq == 0x0001:
                assert w_val == aud["W_f_e0"]
            else:
                assert w_val == aud["w2_8_signed"][idx_f - 2]
        sanity[wname] = {"W_f_0": aud["W_f_0"], "W_f_e0": aud["W_f_e0"], "ok": True}

    # Step 1: Build compact CSA CNF
    clauses = []
    v_cnt = [110]

    def new_var():
        v_cnt[0] += 1
        return v_cnt[0]

    def lin_expr(indices):
        mask = sum(1 << j for j in indices)
        idxs = [i for i, c in enumerate(cb) if (c & mask).bit_count() % 2]
        const = (origin & mask).bit_count() % 2
        return idxs, const

    # K = 1
    k_idxs, k_const = lin_expr(K_INDICES)
    add_long_xor(clauses, [i + 1 for i in k_idxs], 1 ^ k_const, new_var)

    # Cube vars: u1, u2, v2, u3, v3
    cube_vars = []
    for indices in (I1, I2, J2, I3, J3):
        idxs, const = lin_expr(indices)
        cv = new_var()
        add_long_xor(clauses, [i + 1 for i in idxs] + [cv], const, new_var)
        cube_vars.append(cv)

    # L_coset = 1: slin ^ (u2*v2) ^ (u3*v3) ^ (u4*v4) == 1
    slin_idxs, slin_const = lin_expr([23, 31, 39, 112])
    prod_vars = []
    for uv, vv in [(cube_vars[1], cube_vars[2]), (cube_vars[3], cube_vars[4])]:
        pv = new_var()
        add_and_gate(clauses, pv, [uv, vv])
        prod_vars.append(pv)
    u4i, u4c = lin_expr(I4)
    v4i, v4c = lin_expr(J4)
    u4v, v4v, p4v = new_var(), new_var(), new_var()
    add_long_xor(clauses, [i + 1 for i in u4i] + [u4v], u4c, new_var)
    add_long_xor(clauses, [i + 1 for i in v4i] + [v4v], v4c, new_var)
    add_and_gate(clauses, p4v, [u4v, v4v])
    prod_vars.append(p4v)
    add_long_xor(clauses, [i + 1 for i in slin_idxs] + prod_vars, 1 ^ slin_const, new_var)

    # Instantiate all 4,116 rotation orbit bits ONCE
    exprs = eval_rot_orbit_exprs(rot_orbits, orbits, origin, cb)
    y_vars = []
    for o_bit, idxs in exprs:
        yv = new_var()
        add_long_xor(clauses, [i + 1 for i in idxs] + [yv], o_bit, new_var)
        y_vars.append(yv)

    # 6 Coset CSA trees
    add_weighted_sum_targets(clauses, v_cnt, [(1, y_vars[k]) for k in coset_groups[0xF]], 128)
    add_weighted_sum_targets(clauses, v_cnt, [(1, y_vars[k]) for k in coset_groups[0x5]], 256)
    add_weighted_sum_targets(clauses, v_cnt, [(1, y_vars[k]) for k in coset_groups[0x1]], 512)
    add_weighted_sum_targets(clauses, v_cnt, [(1, y_vars[k]) for k in coset_groups[0x3]], 512)
    add_weighted_sum_targets(clauses, v_cnt, [(1, y_vars[k]) for k in coset_groups[0x7]], 512)
    add_weighted_sum_targets(clauses, v_cnt, [(1, y_vars[k]) for k in coset_groups[0x0]], 110, 126)

    # 9 Walsh CSA trees: e_0 + 8 weight-2 frequencies (0xff)
    for freq in [0x0001] + WEIGHT2_FREQS:
        wl, tp, tn = walsh_csa_params(freq, rot_orbits, y_vars)
        add_weighted_sum_targets(clauses, v_cnt, wl, tp, tn)

    build_sec = round(time.perf_counter() - t0, 4)
    base_stats = {"vars": v_cnt[0], "clauses": len(clauses), "build_sec": build_sec}

    # Step 2: 32-cube parallel Cube-and-Conquer + CEGAR
    tasks = []
    for cid in range(32):
        bits = [(cid >> b) & 1 for b in range(5)]
        assump = [cube_vars[b] if bits[b] else -cube_vars[b] for b in range(5)]
        tasks.append((cid, assump, clauses, v_cnt[0], bits, rot_orbits, y_vars, origin, cb, orbits))

    workers = min(4, os.cpu_count() or 4)
    with ProcessPoolExecutor(max_workers=workers) as ex:
        cube_results = list(ex.map(_solve_cube, tasks))

    unsat_count = sum(1 for r in cube_results if not r["sat"])
    bent_hits = [r for r in cube_results if r.get("bent_found")]
    unresolved = [r for r in cube_results if r["sat"] and not r.get("bent_found")]

    out = {
        "valid_s": valid_s,
        "sanity": sanity,
        "base_stats": base_stats,
        "workers": workers,
        "total_cubes": 32,
        "unsat_cubes": unsat_count,
        "bent_hits": bent_hits,
        "unresolved_cubes": unresolved,
        "cube_timings": [{"cube_id": r["cube_id"], "sat": r["sat"], "cegar_rounds": r["cegar_rounds"], "elapsed_sec": r["elapsed_sec"]} for r in cube_results],
        "total_elapsed_sec": round(time.perf_counter() - t0, 4),
    }
    out_path = repo / "research_updates/2026_11_17_h16_c99_carbon_hard/csa_cegar_c99_1_report.json"
    out_path.write_text(json.dumps(out, indent=2), encoding="utf-8")
    print(json.dumps({k: v for k, v in out.items() if k != "cube_timings"}, indent=2))


if __name__ == "__main__":
    main()
