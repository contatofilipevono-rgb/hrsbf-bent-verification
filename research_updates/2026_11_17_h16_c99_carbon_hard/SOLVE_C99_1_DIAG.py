#!/usr/bin/env python3
"""
Fast 2-minute diagnostic for c99=1 SAT encodings on Cube 0 (u1=u2=v2=u3=v3=0):
Tests build time, clause counts, and solve speed/conflicts under:
  - Config A: Algebraic (K=1, L=1, C6, 0x3f3f, 0x5f5f, 0x6f6f, P_7777) + 3 small coset CSA (0xf=128, 0x5=256, 0x0 in {110,126})
  - Config B: Config A + 2 Walsh CSA trees (e0, 0x0101)
  - Config C: Config A + 3 big coset CSA trees (0x1=512, 0x3=512, 0x7=512)
  - Config D: Full 15 CSA trees (from Step 3C) with 30s budget
"""
import json
import threading
import time
from pathlib import Path

from pysat.solvers import Solver

from SOLVE_C99_1_CSA_CEGAR import (
    I1, I2, I3, I4, J2, J3, J4, WEIGHT2_FREQS,
    add_and_gate, add_long_xor, add_weighted_sum_targets,
    audit_65536, build_all_rot_orbits, eval_rot_orbit_exprs, walsh_csa_params,
)
from SOLVE_C99_1_XORSAT_FULL import encode_poly_zero
from VERIFICAR_ALGEBRA_C99_1 import (
    K_INDICES, R_INDICES, build_basis_111, extract_poly_mod4, setup_orbits,
)


def solve_with_budget(clauses, assumptions, budget_sec=30.0):
    t0 = time.perf_counter()
    with Solver(name="cadical195", bootstrap_with=clauses) as slv:
        timer = threading.Timer(budget_sec, slv.interrupt)
        timer.start()
        try:
            res = slv.solve_limited(assumptions=assumptions, expect_interrupt=True)
        finally:
            timer.cancel()
        dt = round(time.perf_counter() - t0, 4)
        stats = slv.accum_stats()
        model = slv.get_model() if res is True else None
        return res, dt, stats, model


def main():
    t0 = time.perf_counter()
    repo = Path(__file__).resolve().parents[2]
    cert_t28 = json.loads((repo / "quartic_audit_2026_10_17/archive/T28_SEXTA_CERTIFICADO.json").read_text(encoding="utf-8"))
    orbits = setup_orbits()
    free, origin, cb = build_basis_111()
    free_pos = {j: i for i, j in enumerate(free)}
    rot_orbits, coset_groups = build_all_rot_orbits()

    # Extract algebraic polys: 0x3f3f, 0x5f5f, 0x6f6f (chi=1), P_7777 (chi=0), C6
    polys = {}
    for name, m8, shift in [("0x3f3f", 0x3F, 1), ("0x5f5f", 0x5F, 1), ("0x6f6f", 0x6F, 1), ("P_7777", 0x77, 0)]:
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
        polys[name] = extract_poly_mod4(b_w, O_w, free, const_shift=shift)

    poly_t28 = [int(h, 16) for h in cert_t28["reduced_models"]["branches"][1]["polynomial_hex"]]
    R_no5_expr = {1 << j for j in R_INDICES if j != 5}
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
    polys["C6"] = c6_poly
    print(f"Polys extracted in {time.perf_counter()-t0:.2f}s: " + ", ".join(f"{k}:{len(v)}" for k, v in polys.items()), flush=True)

    exprs = eval_rot_orbit_exprs(rot_orbits, orbits, origin, cb)

    def build_base(mode):
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

        k_idxs, k_const = lin_expr(K_INDICES)
        add_long_xor(clauses, [i + 1 for i in k_idxs], 1 ^ k_const, new_var)

        cube_vars = []
        for indices in (I1, I2, J2, I3, J3):
            idxs, const = lin_expr(indices)
            cv = new_var()
            add_long_xor(clauses, [i + 1 for i in idxs] + [cv], const, new_var)
            cube_vars.append(cv)

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

        if mode in ("A", "B", "C"):
            for pname in ("0x3f3f", "0x5f5f", "0x6f6f", "P_7777", "C6"):
                encode_poly_zero(clauses, polys[pname], free_pos, new_var)

        # Instantiate rot_orbits
        y_vars = [None] * len(rot_orbits)
        needed = set(coset_groups[0xF] + coset_groups[0x5] + coset_groups[0x0])
        if mode in ("B", "C", "D"):
            needed = set(range(len(rot_orbits)))
        for k in needed:
            o_bit, idxs = exprs[k]
            yv = new_var()
            add_long_xor(clauses, [i + 1 for i in idxs] + [yv], o_bit, new_var)
            y_vars[k] = yv

        add_weighted_sum_targets(clauses, v_cnt, [(1, y_vars[k]) for k in coset_groups[0xF]], 128)
        add_weighted_sum_targets(clauses, v_cnt, [(1, y_vars[k]) for k in coset_groups[0x5]], 256)
        add_weighted_sum_targets(clauses, v_cnt, [(1, y_vars[k]) for k in coset_groups[0x0]], 110, 126)

        if mode in ("C", "D"):
            add_weighted_sum_targets(clauses, v_cnt, [(1, y_vars[k]) for k in coset_groups[0x1]], 512)
            add_weighted_sum_targets(clauses, v_cnt, [(1, y_vars[k]) for k in coset_groups[0x3]], 512)
            add_weighted_sum_targets(clauses, v_cnt, [(1, y_vars[k]) for k in coset_groups[0x7]], 512)

        if mode == "B":
            for freq in (0x0001, 0x0101):
                wl, tp, tn = walsh_csa_params(freq, rot_orbits, y_vars)
                add_weighted_sum_targets(clauses, v_cnt, wl, tp, tn)
        elif mode == "D":
            for freq in [0x0001] + WEIGHT2_FREQS:
                wl, tp, tn = walsh_csa_params(freq, rot_orbits, y_vars)
                add_weighted_sum_targets(clauses, v_cnt, wl, tp, tn)

        assump = [-cv for cv in cube_vars]  # Cube 0
        return v_cnt[0], clauses, assump

    results = {}
    for mode in ("A",):
        tb = time.perf_counter()
        nvars, clauses, assump = build_base(mode)
        bsec = round(time.perf_counter() - tb, 3)
        ts = time.perf_counter()
        with Solver(name="cadical195", bootstrap_with=clauses) as slv:
            res = slv.solve(assumptions=assump)
            ssec = round(time.perf_counter() - ts, 4)
            stats = slv.accum_stats()
            model = slv.get_model() if res is True else None
        aud = None
        if res is True and model is not None:
            cint = origin
            for i, cdir in enumerate(cb):
                if model[i] > 0:
                    cint ^= cdir
            aud = audit_65536(cint, orbits)
        results[mode] = {
            "vars": nvars,
            "clauses": len(clauses),
            "build_sec": bsec,
            "res": "SAT" if res is True else "UNSAT",
            "solve_sec": ssec,
            "stats": stats,
            "audit": aud,
        }
        print(f"Mode {mode}: vars={nvars} clauses={len(clauses)} build={bsec}s res={results[mode]['res']} solve={ssec}s aud={aud}", flush=True)

    # Write Mode D DIMACS CNF for external solver benchmark (cryptominisat5 / kissat)
    nvars_d, clauses_d, assump_d = build_base("D")
    cnf_path = repo / "research_updates/2026_11_17_h16_c99_carbon_hard/mode_d_cube0.cnf"
    with cnf_path.open("w", encoding="utf-8") as f:
        f.write(f"p cnf {nvars_d} {len(clauses_d) + len(assump_d)}\n")
        for cl in clauses_d:
            f.write(" ".join(map(str, cl)) + " 0\n")
        for a in assump_d:
            f.write(f"{a} 0\n")
    print(f"Wrote Mode D CNF: vars={nvars_d} clauses={len(clauses_d) + len(assump_d)}", flush=True)

    out_path = repo / "research_updates/2026_11_17_h16_c99_carbon_hard/diag_c99_1_report.json"
    out_path.write_text(json.dumps(results, indent=2), encoding="utf-8")


if __name__ == "__main__":
    main()
