"""Audit the seven support orbits left by the paired quartic coefficients."""
import argparse
import json
from collections import Counter, deque
from functools import reduce
from itertools import combinations
from operator import xor
from pathlib import Path

from alternating_column_norms import (beta_columns, choices_for, column_test,
                                      direct_column_test, rank_two_joint_test, search,
                                      shift, solve, subsets, xor_terms)


TAU = {7, 14, 21, 28, 35, 42, 49, 56}
PAIRED = (27, 45, 54)
QUARTIC = tuple(s for s in range(64) if s.bit_count() == 4)
QUINTIC = (31, 47)


def sign_expressions(support):
    identifiers = {}
    expressions = {}
    for z, row in enumerate(support):
        for beta in row:
            cycle = {}
            a, b, phase = z, beta, 0
            while (a, b) not in cycle:
                cycle[a, b] = phase
                phase ^= ((a & b) >> 5) & 1
                a, b = shift(a, 1, 6), shift(b, 1, 6)
            assert (a, b, phase) == (z, beta, 0)
            rep = min(cycle)
            index = identifiers.setdefault(rep, len(identifiers))
            expressions[z, beta] = (1 << (index + 1)) | cycle[rep]
    return expressions, len(identifiers)


def audit_support(support):
    signs, width = sign_expressions(support)
    equations = {}
    linear = []
    for z, row in enumerate(support):
        if len(row) == 4:
            row_equation = reduce(xor, (signs[z, b] for b in row), 1)
            if row_equation:
                equations.setdefault(row_equation, ("row", z))
        b = row[0]
        moved = b ^ beta_columns(TAU, z)[0]
        linear.append(signs[z, b] ^ signs[z, moved] ^ (b & 1))
    for b in range(64):
        column = [z for z, row in enumerate(support) if b in row]
        assert len(column) in (1, 4)
        if len(column) == 4:
            column_equation = reduce(xor, (signs[z, b] for z in column), 1)
            if column_equation:
                equations.setdefault(column_equation, ("column", b))
    coefficients = {m: reduce(xor, (linear[z] for z in subsets(m)), 0)
                    for m in QUARTIC + QUINTIC}

    def solve_system(extra=()):
        rows = [(eq >> 1, eq & 1) for eq in equations]
        rows.extend((coefficients[m] >> 1, coefficients[m] & 1) for m in extra)
        return solve(rows, width)

    root, free, _ = solve_system()
    assert root is not None
    # Compare the paired coefficients with the half-turn identity on V_2.
    v2 = [z for z in range(64) if not z & 36]
    paired_values = 4
    for z in v2:
        if z == shift(z, 3, 6):
            paired_values ^= support[z][0] & 7
        elif z < shift(z, 3, 6):
            beta = support[z][0]
            paired_values ^= (beta & 7) ^ (beta >> 3)
    for i, m in enumerate(PAIRED):
        expr = coefficients[m]
        assert ((expr >> 1 & root).bit_count() ^ expr) & 1 == (paired_values >> i & 1)
        assert all(not ((expr >> 1 & x).bit_count() & 1) for x in free)
    paired_feasible = solve_system(PAIRED)[0] is not None
    quartic_feasible = solve_system(QUARTIC)[0] is not None
    return equations, coefficients, (root, free), paired_feasible, quartic_feasible


def shortest_identity(equations, coefficients, sign_space, quartic_feasible):
    root, free = sign_space
    goals = {}
    choices = [(s, i, j) for s in QUINTIC for i, j in combinations(QUARTIC, 2)] if quartic_feasible else [(23, 30)]
    for masks in choices:
        eq = reduce(xor, (coefficients[m] for m in masks), 1)
        if not (((eq >> 1 & root).bit_count() ^ eq) & 1) and all(
                not ((eq >> 1 & x).bit_count() & 1) for x in free):
            goals.setdefault(eq, masks)
    assert goals
    queue = deque([0])
    parent = {0: None}
    while queue:
        state = queue.popleft()
        if state in goals:
            used = []
            expression = state
            while parent[state] is not None:
                previous = parent[state]
                used.append(equations[state ^ previous])
                state = previous
            return goals[expression], sorted(used)
        for equation in equations:
            new = state ^ equation
            if new not in parent:
                parent[new] = state
                queue.append(new)
    raise AssertionError("No sign certificate found")


def coordinate_maps():
    result = []
    for g in range(1, 64):
        columns = [shift(g, j, 6) for j in range(6)]
        if len({xor_terms(columns, z) for z in range(64)}) != 64:
            continue
        for oriented in (columns, [columns[-j % 6] for j in range(6)]):
            a = [xor_terms(oriented, z) for z in range(64)]
            at = [sum(((col & b).bit_count() & 1) << j for j, col in enumerate(oriented))
                  for b in range(64)]
            result.append((a, at))
    assert len(result) == 48
    return result


def transport(support, a, at):
    return tuple(tuple(sorted(at[b] for b in support[z])) for z in a)


def compressed_support(support):
    psi = []
    for v in range(8):
        digits = ""
        for a in range(8):
            z = a | ((a ^ v) << 3)
            row = support[z]
            b = row[0]
            value = (b & 7) ^ (b >> 3)
            digits += str(value)
            if v:
                assert value
                assert row == tuple(beta for beta in range(64)
                                    if ((beta & 7) ^ (beta >> 3)) == value
                                    and not ((beta & z).bit_count() & 1))
            else:
                assert len(row) == 1 and value == 0
        psi.append(digits)
    p_d = "".join(str(support[a | (a << 3)][0] & 7) for a in range(8))
    assert p_d in ("76543210", "72431560", "74132560")
    return p_d, psi


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("output", type=Path)
    parser.add_argument("--direct", action="store_true")
    args = parser.parse_args()
    supports = []
    joint, counts, _ = rank_two_joint_test(TAU, on_joint_support=supports.append)
    check = direct_column_test if args.direct else column_test
    witness, _ = search(choices_for(TAU, keep_columns=True), True, check(TAU), joint)
    assert witness is None and len(set(supports)) == len(supports) == 288
    audited = {s: audit_support(s) for s in supports}
    group = coordinate_maps()
    visited = set()
    distribution = Counter()
    residual = []
    for support in sorted(supports):
        if support in visited:
            continue
        orbit = {transport(support, *g) for g in group}
        assert orbit <= audited.keys()
        visited |= orbit
        paired = [s for s in orbit if audited[s][3]]
        quartic = [s for s in orbit if audited[s][4]]
        distribution[len(orbit), len(paired), len(quartic)] += 1
        if not paired:
            continue
        assert len(paired) == len(orbit) and len(quartic) in (0, len(orbit))
        options = []
        for s in sorted(paired):
            identity, equations = shortest_identity(*audited[s][:3], bool(quartic))
            options.append((len(equations), s, identity, equations))
        _, representative, identity, equations = min(options)
        p_d, psi = compressed_support(representative)
        residual.append({"orbit_size": len(orbit), "survives_quartic": bool(quartic),
                         "p_on_D": p_d, "psi_by_v": psi,
                         "coefficients_whose_xor_is_one": identity,
                         "sign_equations_to_xor": equations})
    assert sum(k[1] * v for k, v in distribution.items()) == 20
    assert sum(k[2] * v for k, v in distribution.items()) == 16
    assert len(residual) == 7
    report = {
        "joint_supports": counts["joint_signs_feasible"],
        "orbit_histogram": [{"size": a, "paired_survivors": b, "quartic_survivors": c, "orbits": n}
                            for (a, b, c), n in sorted(distribution.items())],
        "residual_orbits": sorted(residual, key=lambda r: (r["survives_quartic"], r["orbit_size"],
                                                         r["p_on_D"], r["psi_by_v"])),
    }
    args.output.write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
    for record in report["residual_orbits"]:
        print(record)


if __name__ == "__main__":
    main()
