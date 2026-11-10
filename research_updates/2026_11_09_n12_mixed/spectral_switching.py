"""Extend the two large sextic charts by switching on antipodal pair sums."""
import argparse
import json
from collections import Counter, defaultdict
from pathlib import Path

import numpy as np

from higher_filter import evaluate_orbit, orbits, solve, xor_terms
from higher_orbits import high_actions, orbit
from higher_project import LOW, TOP, UPPER, signs_to_walsh
from m_subspaces import find_m_subspace
from mobius_rule import integer_anf
from quartic_m_catalog import leading_kernels, rotate_kernels


LOWER_WIDTH = len(LOW) + len(TOP)
LOWER_MASK = (1 << LOWER_WIDTH) - 1


def additivity_space(values):
    first = min(values)
    space = {0}
    rejected = set()
    basis = []
    for v in sorted(s ^ first for s in values):
        if v in space or v in rejected:
            continue
        translated = {s ^ v for s in space}
        if all(s ^ v in values for s in values):
            space.update(translated)
            basis.append(v)
        else:
            rejected.update(translated)
    return basis, space


def block_walsh(f):
    z = np.arange(64, dtype=np.uint16)[:, None]
    w = np.arange(64, dtype=np.uint16)
    truth = np.unpackbits(np.frombuffer(f.to_bytes(512, 'little'), dtype=np.uint8), bitorder='little')
    signs = 1 - 2 * truth[(z ^ w) | (w << 6)].astype(np.int16)
    for j in range(6):
        view = signs.reshape(64, -1, 2, 1 << j)
        left = view[:, :, 0, :].copy()
        right = view[:, :, 1, :]
        view[:, :, 0, :] = left + right
        view[:, :, 1, :] = left - right
    return signs


def affine_conditions(spectrum, evaluations):
    equations = set()
    for column in spectrum.T:
        support = list(map(int, np.flatnonzero(column)))
        if len(support) == 1:
            assert abs(column[support[0]]) == 64
            continue
        a, b, c, d = support
        assert a ^ b ^ c ^ d == 0 and all(abs(column[z]) == 32 for z in support)
        equations.add(xor_terms(evaluations, sum(1 << z for z in support)))
    return equations - {0}


def main():
    p = argparse.ArgumentParser()
    p.add_argument('results', type=Path)
    p.add_argument('output', type=Path)
    a = p.parse_args()
    groups = defaultdict(set)
    for line in a.results.read_text().splitlines():
        high, t, l, degree, outside = map(int, line.split())
        assert degree == 6 and outside == 1
        groups[high].add((t << len(LOW)) | l)
    known_high = set(groups)
    bases = LOW + TOP + UPPER
    columns = [evaluate_orbit(o) for _, o in bases]
    pairs = list(orbits(6, 2)) + list(orbits(6, 3)) + list(orbits(6, 4)) + list(orbits(6, 5)) + list(orbits(6, 6))
    lifted = []
    for _, orb in pairs:
        anf = integer_anf(evaluate_orbit(orb, on_pair_sums=True))
        code = sum((anf[m] % 2) << i for i, (m, _) in enumerate(bases))
        assert xor_terms(columns, code) == evaluate_orbit(orb, on_pair_sums=True)
        lifted.append(code)
    evaluations = [sum((sum(z & m == m for m in orb) % 2) << i
                       for i, (_, orb) in enumerate(pairs)) for z in range(64)]
    additions = defaultdict(set)
    source = []
    for high, values in sorted(groups.items()):
        if len(values) < 100:
            continue
        translation_basis, space = additivity_space(values)
        assert len(translation_basis) == 9
        remaining = set(values)
        conditions = Counter()
        while remaining:
            root = min(remaining)
            remaining -= {root ^ v for v in space}
            f = xor_terms(columns, (high << LOWER_WIDTH) | root)
            spectrum = block_walsh(f)
            assert Counter(np.count_nonzero(spectrum, axis=0)) == {1: 40, 4: 24}
            equations = affine_conditions(spectrum, evaluations)
            _, basis, rank = solve(((v, 0) for v in equations), len(pairs))
            assert rank == 1
            conditions[next(iter(equations))] += 1
            generated = [0]
            for v in basis:
                c = xor_terms(lifted, v)
                generated += [g ^ c for g in generated]
            assert {g for g in generated if not g >> LOWER_WIDTH} == space
            checked = set()
            for g in generated:
                new_high = high ^ (g >> LOWER_WIDTH)
                low = root ^ (g & LOWER_MASK)
                additions[new_high].add(low)
                if new_high not in checked:
                    assert all(abs(w) == 64 for w in signs_to_walsh(f ^ xor_terms(columns, g)))
                    checked.add(new_high)
            assert len(checked) == 4
        assert additions[high] >= values
        source.append({'high_mask': high, 'normalized_completions': len(values),
                       'translation_basis': translation_basis,
                       'conditions_by_translation_coset': dict(conditions)})
    operators = high_actions()
    total = 0
    new_orbits = []
    todo = set(additions)
    while todo:
        start = min(todo)
        group = orbit(start, operators)
        candidates = sorted(todo & group)
        todo -= group
        if group & known_high:
            continue
        best = max(candidates, key=lambda h: len(additions[h]))
        high_top = best >> 66
        assert high_top
        m_basis, _ = find_m_subspace(rotate_kernels(leading_kernels(high_top, UPPER[66:])))
        assert m_basis is None
        new_orbits.append({'high_mask': best, 'high_orbit_size': len(group),
                           'normalized_witnesses': len(additions[best]),
                           'all_generated_high_masks_in_orbit': candidates})
        total += 4 * len(group) * len(additions[best])
    result = {'sources': source, 'generated_high_masks': {h: len(rows) for h, rows in sorted(additions.items())},
              'new_orbits': new_orbits, 'new_sextics_outside_m_class_lower_bound': total}
    a.output.write_text(json.dumps(result, indent=2) + '\n')
    print(json.dumps(result, indent=2))


if __name__ == '__main__':
    main()
