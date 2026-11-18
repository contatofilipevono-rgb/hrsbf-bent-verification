#!/usr/bin/env python3
"""
Emit Native-XOR DIMACS CNF for Mode C Cube 0 (K=1, L_coset=1, C6, 0x3f3f, 0x5f5f, 0x6f6f,
and all 6 coset CSA trees: 0xf=128, 0x5=256, 0x1=512, 0x3=512, 0x7=512, 0x0 in {110,126}).
"""
import json
import time
from pathlib import Path

from SOLVE_C99_1_CSA_CEGAR import (
    I1, I2, I3, I4, J2, J3, J4,
    add_and_gate, add_weighted_sum_targets,
    build_all_rot_orbits, eval_rot_orbit_exprs,
)
from SOLVE_C99_1_XORSAT_FULL import encode_poly_zero
from VERIFICAR_ALGEBRA_C99_1 import (
    K_INDICES, R_INDICES, build_basis_111, extract_poly_mod4, setup_orbits,
)


def main():
    t0 = time.perf_counter()
    repo = Path(__file__).resolve().parents[2]
    cert_t28 = json.loads((repo / "quartic_audit_2026_10_17/archive/T28_SEXTA_CERTIFICADO.json").read_text(encoding="utf-8"))
    orbits = setup_orbits()
    free, origin, cb = build_basis_111()
    free_pos = {j: i for i, j in enumerate(free)}
    rot_orbits, coset_groups = build_all_rot_orbits()
    exprs = eval_rot_orbit_exprs(rot_orbits, orbits, origin, cb)

    def lin_expr(indices):
        mask = sum(1 << j for j in indices)
        idxs = [i for i, c in enumerate(cb) if (c & mask).bit_count() % 2]
        const = (origin & mask).bit_count() % 2
        return idxs, const

    polys = {}
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
        polys[name] = extract_poly_mod4(b_w, O_w, free, const_shift=1)

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

    clauses = []
    xor_lines = []
    v_cnt = [110]
    def new_var():
        v_cnt[0] += 1
        return v_cnt[0]

    def add_native_xor(lits, rhs):
        if not lits:
            if rhs == 1:
                clauses.append([])
            return
        out = list(lits)
        if rhs == 0:
            out[0] = -out[0]
        xor_lines.append("x " + " ".join(map(str, out)) + " 0")

    k_i, k_c = lin_expr(K_INDICES)
    add_native_xor([i + 1 for i in k_i], 1 ^ k_c)

    cube_vars = []
    for indices in (I1, I2, J2, I3, J3):
        idxs, const = lin_expr(indices)
        cv = new_var()
        add_native_xor([i + 1 for i in idxs] + [cv], const)
        cube_vars.append(cv)

    slin_i, slin_c = lin_expr([23, 31, 39, 112])
    prod_vars = []
    for uv, vv in [(cube_vars[1], cube_vars[2]), (cube_vars[3], cube_vars[4])]:
        pv = new_var()
        add_and_gate(clauses, pv, [uv, vv])
        prod_vars.append(pv)
    u4i, u4c = lin_expr(I4)
    v4i, v4c = lin_expr(J4)
    u4v, v4v, p4v = new_var(), new_var(), new_var()
    add_native_xor([i + 1 for i in u4i] + [u4v], u4c)
    add_native_xor([i + 1 for i in v4i] + [v4v], v4c)
    add_and_gate(clauses, p4v, [u4v, v4v])
    prod_vars.append(p4v)
    add_native_xor([i + 1 for i in slin_i] + prod_vars, 1 ^ slin_c)

    for pname in ("0x3f3f", "0x5f5f", "0x6f6f", "C6"):
        encode_poly_zero(clauses, polys[pname], free_pos, new_var)

    y_vars = [None] * len(rot_orbits)
    for k in (coset_groups[0xF] + coset_groups[0x5] + coset_groups[0x0] + coset_groups[0x1] + coset_groups[0x3] + coset_groups[0x7]):
        o_bit, idxs = exprs[k]
        yv = new_var()
        add_native_xor([i + 1 for i in idxs] + [yv], o_bit)
        y_vars[k] = yv

    add_weighted_sum_targets(clauses, v_cnt, [(1, y_vars[k]) for k in coset_groups[0xF]], 128)
    add_weighted_sum_targets(clauses, v_cnt, [(1, y_vars[k]) for k in coset_groups[0x5]], 256)
    add_weighted_sum_targets(clauses, v_cnt, [(1, y_vars[k]) for k in coset_groups[0x1]], 512)
    add_weighted_sum_targets(clauses, v_cnt, [(1, y_vars[k]) for k in coset_groups[0x3]], 512)
    add_weighted_sum_targets(clauses, v_cnt, [(1, y_vars[k]) for k in coset_groups[0x7]], 512)
    add_weighted_sum_targets(clauses, v_cnt, [(1, y_vars[k]) for k in coset_groups[0x0]], 110, 126)

    for cv in cube_vars:
        clauses.append([-cv])

    cnf_path = repo / "research_updates/2026_11_17_h16_c99_carbon_hard/mode_c_cube0_native_xor.cnf"
    with cnf_path.open("w", encoding="utf-8") as f:
        f.write(f"p cnf {v_cnt[0]} {len(clauses) + len(xor_lines)}\n")
        for xline in xor_lines:
            f.write(xline + "\n")
        for cl in clauses:
            f.write(" ".join(map(str, cl)) + " 0\n")

    print(f"Wrote Mode C native-XOR CNF: vars={v_cnt[0]}, std_clauses={len(clauses)}, xor_clauses={len(xor_lines)} in {time.perf_counter()-t0:.2f}s", flush=True)


if __name__ == "__main__":
    main()
