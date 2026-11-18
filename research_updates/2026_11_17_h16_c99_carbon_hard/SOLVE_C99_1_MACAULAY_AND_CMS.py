#!/usr/bin/env python3
"""
Step 3D:
1. Exact GF(2) Macaulay degree-3 reduction on {L_coset^1, 0x3f3f, 0x5f5f, 0x6f6f, C6}
   + x_i * (L_coset^1) for K=1 (u1=0 and u1=1), checking for new degree <= 2 / linear laws
   or direct Nullstellensatz contradiction (1 in span).
2. Native-XOR DIMACS generator (`x ... 0` lines for CryptoMiniSat5) for Mode D Cube 0.
"""
import json
import time
from pathlib import Path

from SOLVE_C99_1_CSA_CEGAR import (
    I1, I2, I3, I4, J2, J3, J4, WEIGHT2_FREQS,
    add_and_gate, add_weighted_sum_targets,
    build_all_rot_orbits, eval_rot_orbit_exprs, walsh_csa_params,
)
from VERIFICAR_ALGEBRA_C99_1 import (
    K_INDICES, R_INDICES, build_basis_111, extract_poly_mod4, setup_orbits,
)
from VERIFICAR_ALGEBRA_C99_5_M3 import gf2_macaulay_reduce, substitute_linear_vars


def poly_from_lin_expr(idxs, const):
    p = {1 << i for i in idxs}
    if const:
        p.add(0)
    return p


def mul_polys(p1, p2):
    out = set()
    for a in p1:
        for b in p2:
            m = a | b
            if m in out:
                out.remove(m)
            else:
                out.add(m)
    return out


def main():
    t0 = time.perf_counter()
    repo = Path(__file__).resolve().parents[2]
    cert_t28 = json.loads((repo / "quartic_audit_2026_10_17/archive/T28_SEXTA_CERTIFICADO.json").read_text(encoding="utf-8"))
    orbits = setup_orbits()
    free, origin, cb = build_basis_111()

    def lin_expr(indices):
        mask = sum(1 << j for j in indices)
        idxs = [i for i, c in enumerate(cb) if (c & mask).bit_count() % 2]
        const = (origin & mask).bit_count() % 2
        return idxs, const

    # Extract 0x3f3f, 0x5f5f, 0x6f6f, C6
    polys = {}
    for name, m8, shift in [("0x3f3f", 0x3F, 1), ("0x5f5f", 0x5F, 1), ("0x6f6f", 0x6F, 1)]:
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

    # L_coset ^ 1 = slin ^ u2*v2 ^ u3*v3 ^ u4*v4 ^ 1
    slin_i, slin_c = lin_expr([23, 31, 39, 112])
    l_coset_zero = poly_from_lin_expr(slin_i, slin_c ^ 1)
    for Ir, Jr in [(I2, J2), (I3, J3), (I4, J4)]:
        ui, uc = lin_expr(Ir)
        vi, vc = lin_expr(Jr)
        l_coset_zero ^= mul_polys(poly_from_lin_expr(ui, uc), poly_from_lin_expr(vi, vc))

    # Part 1: Degree-3 Macaulay reduction for u1=0 and u1=1
    macaulay_report = {}
    k_i, k_c = lin_expr(K_INDICES)
    u1_i, u1_c = lin_expr(I1)
    k_poly = poly_from_lin_expr(k_i, k_c ^ 1)  # K = 1 -> k_poly = 0

    for u1_val in (0, 1):
        u1_poly = poly_from_lin_expr(u1_i, u1_c ^ u1_val)
        lin_pivots = gf2_macaulay_reduce([k_poly, u1_poly])
        # Build pivot_map: lead_bit -> expr without lead_bit
        piv_map = {}
        for lead, pset in lin_pivots.items():
            assert lead.bit_count() == 1
            bit = lead.bit_length() - 1
            piv_map[bit] = pset ^ {lead}
        rem_vars = [i for i in range(110) if i not in piv_map]

        lc_sub = substitute_linear_vars(l_coset_zero, piv_map)
        sys_polys = [lc_sub]
        for i in rem_vars:
            sys_polys.append(mul_polys({1 << i}, lc_sub))
        for pname in ("0x3f3f", "0x5f5f", "0x6f6f", "C6"):
            sys_polys.append(substitute_linear_vars(polys[pname], piv_map))

        tm = time.perf_counter()
        pivs = gf2_macaulay_reduce(sys_polys)
        deg_counts = {0: 0, 1: 0, 2: 0, 3: 0}
        for lead in pivs:
            d = lead.bit_count()
            deg_counts[d] = deg_counts.get(d, 0) + 1
        macaulay_report[f"K1_u{u1_val}"] = {
            "has_one": (0 in pivs),
            "deg_counts": deg_counts,
            "total_pivots": len(pivs),
            "sec": round(time.perf_counter() - tm, 3),
        }
        print(f"Macaulay K1_u{u1_val}: {macaulay_report[f'K1_u{u1_val}']}", flush=True)

    # Part 2: Build Native-XOR DIMACS for Mode D Cube 0
    rot_orbits, coset_groups = build_all_rot_orbits()
    exprs = eval_rot_orbit_exprs(rot_orbits, orbits, origin, cb)

    clauses = []
    xor_lines = []
    v_cnt = [110]
    def new_var():
        v_cnt[0] += 1
        return v_cnt[0]

    def add_native_xor(lits, rhs):
        # CryptoMiniSat format: x a b c 0 means a^b^c = 1; to set rhs=0, negate first lit
        if not lits:
            if rhs == 1:
                clauses.append([])
            return
        out = list(lits)
        if rhs == 0:
            out[0] = -out[0]
        xor_lines.append("x " + " ".join(map(str, out)) + " 0")

    add_native_xor([i + 1 for i in k_i], 1 ^ k_c)
    cube_vars = []
    for indices in (I1, I2, J2, I3, J3):
        idxs, const = lin_expr(indices)
        cv = new_var()
        add_native_xor([i + 1 for i in idxs] + [cv], const)
        cube_vars.append(cv)

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

    y_vars = []
    for o_bit, idxs in exprs:
        yv = new_var()
        add_native_xor([i + 1 for i in idxs] + [yv], o_bit)
        y_vars.append(yv)

    add_weighted_sum_targets(clauses, v_cnt, [(1, y_vars[k]) for k in coset_groups[0xF]], 128)
    add_weighted_sum_targets(clauses, v_cnt, [(1, y_vars[k]) for k in coset_groups[0x5]], 256)
    add_weighted_sum_targets(clauses, v_cnt, [(1, y_vars[k]) for k in coset_groups[0x1]], 512)
    add_weighted_sum_targets(clauses, v_cnt, [(1, y_vars[k]) for k in coset_groups[0x3]], 512)
    add_weighted_sum_targets(clauses, v_cnt, [(1, y_vars[k]) for k in coset_groups[0x7]], 512)
    add_weighted_sum_targets(clauses, v_cnt, [(1, y_vars[k]) for k in coset_groups[0x0]], 110, 126)

    for freq in [0x0001] + WEIGHT2_FREQS:
        wl, tp, tn = walsh_csa_params(freq, rot_orbits, y_vars)
        add_weighted_sum_targets(clauses, v_cnt, wl, tp, tn)

    for cv in cube_vars:
        clauses.append([-cv])  # Cube 0

    cnf_path = repo / "research_updates/2026_11_17_h16_c99_carbon_hard/mode_d_cube0_native_xor.cnf"
    with cnf_path.open("w", encoding="utf-8") as f:
        f.write(f"p cnf {v_cnt[0]} {len(clauses) + len(xor_lines)}\n")
        for xline in xor_lines:
            f.write(xline + "\n")
        for cl in clauses:
            f.write(" ".join(map(str, cl)) + " 0\n")

    rep = {
        "macaulay": macaulay_report,
        "native_xor_cnf": {"vars": v_cnt[0], "std_clauses": len(clauses), "xor_clauses": len(xor_lines)},
        "elapsed_sec": round(time.perf_counter() - t0, 3),
    }
    (repo / "research_updates/2026_11_17_h16_c99_carbon_hard/macaulay_cms_report.json").write_text(json.dumps(rep, indent=2), encoding="utf-8")
    print(json.dumps(rep, indent=2), flush=True)


if __name__ == "__main__":
    main()
