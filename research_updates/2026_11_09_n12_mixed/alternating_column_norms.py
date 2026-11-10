"""Exact column-norm test for quartics with an antipodal-linear leading part."""
import argparse
import json
from collections import Counter
from functools import lru_cache
from itertools import combinations
from pathlib import Path

from higher_filter import orbits, shift, solve, subsets, xor_terms
from higher_project import signs_to_walsh
from mobius_rule import integer_anf


def beta_columns(tau, z):
    """Return the columns of the polar matrix of the contraction at z."""
    columns = [0] * 6
    for support in tau:
        for i, j in combinations((k for k in range(6) if support >> k & 1), 2):
            if z & (support ^ (1 << i) ^ (1 << j)):
                columns[i] ^= 1 << j
                columns[j] ^= 1 << i
    assert xor_terms(columns, z) == 0
    return columns


def cosets(tau, z, length):
    image = {0}
    for a in beta_columns(tau, z):
        image |= {x ^ a for x in image}
    assert len(image) in (1, 4, 16)
    return sorted({tuple(sorted(x ^ a for x in image)) for a in range(64)
                   if (a & z).bit_count() % 2 == 0 and (a ^ shift(a, length, 6)) in image})


def compatible_sign_cycle(z, b):
    u, v = z, b
    phase = 0
    while True:
        phase ^= ((u & v) >> 5) & 1
        u, v = shift(u, 1, 6), shift(v, 1, 6)
        if (u, v) == (z, b):
            return phase == 0


def choices_for(tau, keep_columns=False):
    """Record each row-orbit choice by its norm, moments, and column supports."""
    reps = [(r, len(c)) for r, c in orbits(6)]
    monomials = [m for m in range(64) if m.bit_count() <= 2]
    moments = [sum(1 << i for i, m in enumerate(monomials) if z & m == m) for z in range(64)]
    out = []
    for z, length in reps:
        options = {}
        for support in cosets(tau, z, length):
            if keep_columns and any(not compatible_sign_cycle(z, b) for b in support):
                continue
            column_hits = Counter(shift(b, k, 6) for k in range(length) for b in support)
            scale = 16 // len(support)
            contribution = tuple(scale * column_hits[b] for b, _ in reps)
            parity = 0
            profile = [0] * len(reps)
            if scale == 1 or keep_columns:
                for k in range(length):
                    moved = {shift(b, k, 6) for b in support}
                    point = shift(z, k, 6)
                    for j, (b, _) in enumerate(reps):
                        if b in moved:
                            if scale == 1:
                                parity ^= moments[point] << (j * len(monomials))
                            profile[j] |= 1 << point
            options.setdefault((contribution, parity, tuple(profile) if keep_columns else ()), support)
        out.append((z, options))
    return out


def reduce_bits(v, pivots):
    while v and (k := v.bit_length() - 1) in pivots:
        v ^= pivots[k]
    return v


def column_test(tau):
    amplitudes = [4 // {1: 1, 4: 2, 16: 4}[len(cosets(tau, z, 6)[0])] for z in range(64)]

    @lru_cache(maxsize=30000)
    def check(b, length, support):
        unused = {z for z in range(64) if support >> z & 1}
        orbits_ = []
        while unused:
            start = min(unused)
            z = start
            phase = 0
            values = []
            while True:
                assert z in unused
                unused.remove(z)
                values.append((z, (-1 if phase else 1) * amplitudes[z]))
                for j in range(length):
                    phase ^= ((z & shift(b, j, 6)) >> 5) & 1
                    z = shift(z, 1, 6)
                if z == start:
                    if phase:
                        return False
                    break
            orbits_.append(values)
        weights = [sum(v for _, v in o) for o in orbits_]
        baseline = sum(weights)
        if (baseline - 4) % 2:
            return False
        rhs = ((baseline - 4) // 2) % 4
        equations = [(sum((v % 2) << i for i, v in enumerate(weights)), rhs & 1)]
        for j in range(6):
            w = [sum(v for z, v in o if z >> j & 1) for o in orbits_]
            s = sum(w)
            if s % 2:
                return False
            equations.append((sum((v % 2) << i for i, v in enumerate(w)), (s // 2) & 1))
        root, basis, _ = solve(equations, len(weights))
        if root is None:
            return False
        values = [root]
        for v in basis:
            values += [x ^ v for x in values]
        return any(sum(v for i, v in enumerate(weights) if x >> i & 1) % 4 == rhs for x in values)

    return check


def direct_column_test(tau):
    import numpy as np

    amplitudes = [4 // {1: 1, 4: 2, 16: 4}[len(cosets(tau, z, 6)[0])] for z in range(64)]
    characters = np.array([[1 - 2 * ((a & z).bit_count() % 2) for a in range(64)]
                           for z in range(64)], dtype=np.int16)

    @lru_cache(maxsize=30000)
    def check(b, length, support):
        points = {z for z in range(64) if support >> z & 1}
        contributions = []
        while points:
            start = min(points)
            z = start
            sign = 1
            total = np.zeros(64, dtype=np.int16)
            while True:
                points.remove(z)
                total += sign * amplitudes[z] * characters[z]
                for j in range(length):
                    if ((z & shift(b, j, 6)) >> 5) & 1:
                        sign = -sign
                    z = shift(z, 1, 6)
                if z == start:
                    if sign < 0:
                        return False
                    break
            contributions.append(total)
        matrix = np.array(contributions, dtype=np.int16)
        indices = np.arange(len(contributions), dtype=np.uint32)
        limit = 1 << max(0, len(contributions) - 1)
        for start in range(0, limit, 1024):
            codes = np.arange(start, min(start + 1024, limit), dtype=np.uint32)
            signs = (1 - 2 * ((codes[:, None] >> indices) & 1).astype(np.int16))
            if np.any(np.all(np.abs(signs @ matrix) == 4, axis=1)):
                return True
        return False

    return check


def search(rows, require_moments, check_column=None, check_joint=None):
    """Choose row supports with exact column norms and the requested filters."""
    if any(not choices for _, choices in rows):
        return None, 0
    rows = sorted(rows, key=lambda row: (len(row[1]), -max(sum(v) for v, _, _ in row[1])))
    n = len(next(iter(rows[0][1]))[0])
    frequencies = [(z, len(o)) for z, o in orbits(6)]
    upper = [(0,) * n]
    lower = [(0,) * n]
    offsets = [0]
    spaces = [{}]
    for _, options in reversed(rows):
        values = list(zip(*(v for v, _, _ in options)))
        upper.append(tuple(v + max(w) for v, w in zip(upper[-1], values)))
        lower.append(tuple(v + min(w) for v, w in zip(lower[-1], values)))
        base = next(iter(options))[1]
        offsets.append(base ^ offsets[-1])
        pivots = spaces[-1].copy()
        for _, parity, _ in options:
            v = reduce_bits(parity ^ base, pivots)
            if v:
                pivots[v.bit_length() - 1] = v
        spaces.append(pivots)
    upper.reverse()
    lower.reverse()
    offsets.reverse()
    spaces.reverse()

    @lru_cache(maxsize=100000)
    def visit(i, target, moments, profile):
        if any(x < lo or x > hi for x, lo, hi in zip(target, lower[i], upper[i])):
            return None
        if require_moments and reduce_bits(moments ^ offsets[i], spaces[i]):
            return None
        if i == len(rows):
            return () if check_joint is None or check_joint(profile) else None
        z, options = rows[i]
        for (contribution, parity, masks), support in options.items():
            residue = tuple(x - y for x, y in zip(target, contribution))
            new_profile = ()
            if check_column is not None:
                new_profile = tuple(x | y for x, y in zip(profile, masks))
                if any(old > 0 and new == 0 and not check_column(*frequencies[j], new_profile[j])
                       for j, (old, new) in enumerate(zip(target, residue))):
                    continue
            value = visit(i + 1, residue, moments ^ parity if require_moments else 0, new_profile)
            if value is not None:
                return ((z, support), *value)
        return None

    result = visit(0, (16,) * n, 0, (0,) * n if check_column else ())
    return result, visit.cache_info().misses


def quadratic_walsh(tau, z):
    terms = []
    for support in tau:
        for k in range(6):
            if support & z & (1 << k):
                terms.append(support ^ (1 << k))
    return [sum((-1) ** ((sum(t & w == t for t in terms) + (b & w).bit_count()) % 2)
                for w in range(64)) for b in range(64)]


def rank_two_joint_test(tau, enforce_degree=True, verify_witness=False):
    """Solve the shared sign equations and the degree bounds on the linear part."""
    base = [quadratic_walsh(tau, z) for z in range(64)]
    polar = [beta_columns(tau, z) for z in range(64)]
    beta_reps = [(b, len(o)) for b, o in orbits(6)]
    calls = Counter()
    forced_higher = Counter()

    def check(profile):
        calls['support_patterns'] += 1
        columns = [set() for _ in range(64)]
        rows = [set() for _ in range(64)]
        for (b, length), support in zip(beta_reps, profile):
            for k in range(length):
                moved_b = shift(b, k, 6)
                for z in range(64):
                    if support >> z & 1:
                        moved_z = shift(z, k, 6)
                        columns[moved_b].add(moved_z)
                        rows[moved_z].add(moved_b)
        signs = {}
        width = 0
        for z, row in enumerate(rows):
            for b in sorted(row):
                if (z, b) in signs:
                    continue
                u, v, phase = z, b, 0
                while True:
                    assert v in rows[u]
                    signs[u, v] = (1 << width, phase)
                    phase ^= ((u & v) >> 5) & 1
                    u, v = shift(u, 1, 6), shift(v, 1, 6)
                    if (u, v) == (z, b):
                        assert phase == 0
                        break
                width += 1

        def combine(values):
            m = v = 0
            for a, b in values:
                m ^= a
                v ^= b
            return m, v

        equations = []
        coefficient = []
        for z, row in enumerate(rows):
            s = sorted(row)
            q = base[z]
            offset = s[0] ^ next(i for i, v in enumerate(q) if v)
            assert {b ^ offset for b, v in enumerate(q) if v} == row
            coeffs = [(0, (offset >> j) & 1) for j in range(6)]
            if len(s) == 4:
                b, c, d, e = s
                u, v = b ^ c, b ^ d
                assert b ^ e == u ^ v
                relative = {a: (signs[z, a][0], signs[z, a][1] ^ int(q[a ^ offset] < 0)) for a in s}
                equations.append(combine(relative.values()))
                first = combine((relative[b], relative[c]))
                second = combine((relative[b], relative[d]))
                directions = {0: (0, 0), u: first, v: second, u ^ v: combine((first, second))}
                coeffs = [combine((coef, directions[p])) for coef, p in zip(coeffs, polar[z])]
            else:
                assert len(s) == 1
            coefficient.append(coeffs)
        for b, column in enumerate(columns):
            if len(column) == 4:
                m, v = combine(signs[z, b] for z in column)
                equations.append((m, v ^ 1))
            else:
                assert len(column) == 1
        root, free, _ = solve(equations, width)
        if root is None:
            return False
        calls['joint_signs_feasible'] += 1
        if enforce_degree:
            first = []
            quartic = []
            selected = []
            forced_here = set()
            paired = []
            for s in range(64):
                if s.bit_count() >= 4:
                    row = combine(coefficient[z][0] for z in subsets(s))
                    first.append(row)
                    if s.bit_count() == 4:
                        quartic.append(row)
                    if s in (23, 27, 30, 31, 45, 47, 54):
                        selected.append(row)
                    if s in (27, 45, 54):
                        paired.append(row)
                    mask, value = row
                    if (mask & root).bit_count() % 2 != value and all(
                            (mask & v).bit_count() % 2 == 0 for v in free):
                        forced_higher[s] += 1
                        forced_here.add(s)
            calls['has_individually_forced_high_coefficient'] += bool(forced_here)
            calls['has_forced_union_of_two_antipodal_pairs'] += bool(forced_here & {27, 45, 54})
            first_root, _, _ = solve(equations + first, width)
            quartic_root, _, _ = solve(equations + quartic, width)
            selected_root, _, _ = solve(equations + selected, width)
            paired_root, _, _ = solve(equations + paired, width)
            calls['excluded_by_first_coordinate_degree'] += first_root is None
            calls['excluded_by_three_paired_coefficients'] += paired_root is None
            calls['excluded_by_all_quartic_coefficients'] += quartic_root is None
            calls['excluded_by_seven_coefficients'] += selected_root is None
            for s in range(64):
                if s.bit_count() >= 4:
                    for j in range(6):
                        equations.append(combine(coefficient[z][j] for z in subsets(s)))
        root, _, _ = solve(equations, width)
        if root is None:
            return False
        calls['joint_signs_and_degree_feasible'] += 1
        if verify_witness:
            table = 0
            for z, row in enumerate(rows):
                amplitude = 64 if len(row) == 1 else 32
                for w in range(64):
                    total = 0
                    for b in row:
                        mask, phase = signs[z, b]
                        exponent = (mask & root).bit_count() + phase + (w & b).bit_count()
                        total += amplitude * (1 - 2 * (exponent % 2))
                    assert total in (-64, 64)
                    x = (z ^ w) | (w << 6)
                    table |= (total < 0) << x
            assert all(abs(v) == 64 for v in signs_to_walsh(table))
            assert all((table >> x ^ table >> shift(x, 1, 12)) & 1 == 0 for x in range(4096))
            calls['verified_boolean_witness_degree'] = max(s.bit_count() for s, c in
                                                            enumerate(integer_anf(table)) if c % 2)
        return True

    return check, calls, forced_higher


def main():
    p = argparse.ArgumentParser()
    p.add_argument('output', type=Path)
    p.add_argument('--full', action='store_true')
    p.add_argument('--direct', action='store_true', help='Check columns by direct Walsh rather than congruences')
    a = p.parse_args()
    cycles = [o for _, o in orbits(6, 3)]
    reports = []
    column = direct_column_test if a.direct else column_test
    if a.full:
        control = tuple(1 << (b ^ 63) for b, _ in orbits(6))
        positive, control_counts, _ = rank_two_joint_test(set(), verify_witness=True)
        assert positive(control) and control_counts['verified_boolean_witness_degree'] == 2
    for mask in range(1, 1 << len(cycles)):
        tau = set().union(*(v for i, v in enumerate(cycles) if mask >> i & 1))
        choices = choices_for(tau)
        norm, norm_states = search(choices, False)
        result, states = search(choices, True)
        report = {'mask': mask, 'tau_supports': sorted(tau), 'states': states,
                  'distinct_choices_by_z_orbit': {z: len(c) for z, c in choices},
                  'norm_only_states': norm_states, 'norm_witness': norm,
                  'norm_and_moments_witness': result}
        if a.full:
            supported, full_states = search(choices_for(tau, keep_columns=True), True, column(tau))
            report.update({'all_column_signs_feasible_witness': supported, 'all_column_states': full_states})
            print(mask, 'full column witness' if supported is not None else 'excluded by columns', full_states, flush=True)
            if supported is not None and all(len(cosets(tau, z, 6)[0]) <= 4 for z in range(64)):
                joint_test, calls, forced = rank_two_joint_test(tau)
                joint, joint_states = search(choices_for(tau, keep_columns=True), True, column(tau), joint_test)
                report.update({'joint_witness': joint, 'joint_states': joint_states, 'joint_test_counts': calls})
                report['individually_forced_high_coefficients_of_pi0'] = dict(forced)
                print(mask, 'joint witness' if joint is not None else 'excluded by joint signs and degree',
                      joint_states, dict(calls), flush=True)
                relaxed, relaxed_counts, _ = rank_two_joint_test(tau, enforce_degree=False, verify_witness=True)
                relaxed_support, _ = search(choices_for(tau, keep_columns=True), True, column(tau), relaxed)
                assert relaxed_support is not None and relaxed_counts['verified_boolean_witness_degree'] > 4
                report['relaxed_degree_witness'] = dict(relaxed_counts)
                print('relaxed control', dict(relaxed_counts), flush=True)
            assert supported is None or ('joint_witness' in report and report['joint_witness'] is None), (
                f'Nonzero form {mask} survived the filters'
            )
        reports.append(report)
        if not a.full:
            print(mask, 'norm witness' if result is not None else 'impossible', states, flush=True)
    a.output.write_text(json.dumps(reports, indent=2) + '\n')


if __name__ == '__main__':
    main()
