"""Look for new quintic parts by additions on antipodal pair sums."""
import argparse
import json
from collections import Counter, defaultdict
from pathlib import Path

import numpy as np

from higher_filter import evaluate_orbit, orbits, solve, xor_terms
from higher_orbits import high_actions, orbit
from higher_project import LOW, TOP, UPPER
from m_subspaces import find_m_subspace
from mobius_rule import integer_anf
from quartic_m_catalog import leading_kernels, rotate_kernels
from spectral_switching import LOWER_MASK, LOWER_WIDTH, block_walsh
from summarize_two import audit


def affine_equations(spectrum, evaluations):
    equations = set()
    for column in spectrum.T:
        pivots = {}
        for z in map(int, np.flatnonzero(column)):
            code, v = z | 64, evaluations[z]
            while code:
                pivot = code.bit_length() - 1
                if pivot not in pivots:
                    pivots[pivot] = code, v
                    break
                a, b = pivots[pivot]
                code ^= a
                v ^= b
            else:
                if v:
                    equations.add(v)
    return equations


def main():
    p = argparse.ArgumentParser()
    p.add_argument('output', type=Path)
    p.add_argument('sources', type=Path, nargs='+')
    a = p.parse_args()
    values = defaultdict(set)
    for source in a.sources:
        for line in source.read_text().splitlines():
            h, top, low, degree, outside = map(int, line.split())
            if degree == 5 and outside:
                values[h].add((top << len(LOW)) | low)
    bases = LOW + TOP + UPPER[:66]
    columns = [evaluate_orbit(o) for _, o in bases]
    pair_basis = [o for d in range(2, 6) for _, o in orbits(6, d)]
    evaluations = [sum((sum(z & m == m for m in o) % 2) << i
                       for i, o in enumerate(pair_basis)) for z in range(64)]
    lifted = []
    for o in pair_basis:
        truth = evaluate_orbit(o, on_pair_sums=True)
        anf = integer_anf(truth)
        code = sum((anf[m] % 2) << i for i, (m, _) in enumerate(bases))
        assert xor_terms(columns, code) == truth
        lifted.append(code)
    ops = high_actions()
    prior = set().union(*(orbit(h, ops) for h in (*values, 1 << 61, int('40640b82416fcc8c', 16))))
    additions = defaultdict(set)
    dimensions = Counter()
    for high, rows in sorted(values.items()):
        fixed = xor_terms(columns, high << LOWER_WIDTH)
        for lower in rows:
            f = fixed ^ xor_terms(columns, lower)
            eq = affine_equations(block_walsh(f), evaluations)
            _, basis, _ = solve(((v, 0) for v in eq), len(pair_basis))
            dimensions[len(basis)] += 1
            if all(v < 1 << (len(pair_basis) - 1) for v in basis):
                continue
            codes = [0]
            for v in basis:
                code = xor_terms(lifted, v)
                codes += [old ^ code for old in codes]
            for code in codes:
                new_high = high ^ (code >> LOWER_WIDTH)
                if new_high and new_high not in prior:
                    new_low = lower ^ (code & LOWER_MASK)
                    additions[new_high].add((new_low >> len(LOW), new_low & ((1 << len(LOW)) - 1)))
    by_dual = defaultdict(Counter)
    for h, _, _, d, outside in audit(additions):
        assert outside and d in (4, 5)
        by_dual[h][d] += 1
    todo = set(additions)
    new = []
    while todo:
        group = orbit(min(todo), ops)
        representatives = sorted(todo & group)
        todo -= group
        h = max(representatives, key=lambda v: by_dual[v][5])
        basis, _ = find_m_subspace(rotate_kernels(leading_kernels(h, UPPER[:66])))
        new.append({'high_mask': h, 'high_orbit_size': len(group), 'normalized_by_dual': by_dual[h],
                    'min_quintic_orbits': min(v.bit_count() for v in group),
                    'leading_part_rules_out_m_subspace': basis is None})
    result = {'source_functions': sum(map(len, values.values())), 'switching_dimensions': dimensions,
              'new_high_orbits': new,
              'additional_quintics_outside_diagonal': sum(4 * r['high_orbit_size'] * r['normalized_by_dual'][5]
                                                          for r in new)}
    a.output.write_text(json.dumps(result, indent=2) + '\n')
    print(json.dumps(result, indent=2))


if __name__ == '__main__':
    main()
