"""Combine all four-orbit shards, keeping the small outside-diagonal catalog."""
import argparse
import json
from collections import Counter, defaultdict
from pathlib import Path

from higher_filter import evaluate_orbit, xor_terms
from higher_orbits import high_actions, orbit
from higher_project import LOW, TOP, UPPER
from m_subspaces import find_m_subspace
from quartic_m_catalog import full_kernels, leading_kernels, rotate_kernels
from summarize_two import audit


def main():
    p = argparse.ArgumentParser()
    p.add_argument('projection', type=Path)
    p.add_argument('preflight', type=Path)
    p.add_argument('reports', type=Path)
    p.add_argument('output', type=Path)
    a = p.parse_args()
    projection = json.loads(a.projection.read_text())['classes']
    groups = {r['mask']: r for r in json.loads(a.preflight.read_text())['classes']}
    expected = {(i, j) for i, r in enumerate(projection) if not r['contradiction']
                for j in range(1 << max(0, min(4, r['quartic_free'] - 24)))}
    seen = set()
    quartic = lower = sample = 0
    counts = defaultdict(Counter)
    outside = defaultdict(set)
    for file in sorted(a.reports.glob('*.json')):
        data = json.loads(file.read_text())
        sample += data['independently_checked_samples']
        for i, j, bits, q, l, n, e in data['records']:
            assert (i, j) not in seen and (i, j) in expected
            assert q == 1 << (projection[i]['quartic_free'] - bits)
            seen.add((i, j))
            counts[projection[i]['mask']].update({'normalized': n, 'outside_diagonal': e})
            quartic += q
            lower += l
        for line in file.with_suffix('.tsv').read_text().splitlines():
            high, t, l = map(int, line.split())
            assert (t, l) not in outside[high]
            outside[high].add((t, l))
    assert seen == expected
    assert all(c['outside_diagonal'] == len(outside[h]) for h, c in counts.items())
    ops = high_actions()
    known = {1 << 61, int('40640b82416fcc8c', 16)}
    for name in ('two', 'three'):
        known.update(r['mask'] for r in json.loads((a.output / f'{name}-quintic-counts.json').read_text())['positive_classes'])
    known = set().union(*(orbit(h, ops) for h in known))
    switching = json.loads((a.output / 'quintic-switching-counts.json').read_text())
    assert all(r['min_quintic_orbits'] > 4 for r in switching['new_high_orbits'])
    dual_seeded = json.loads((a.output / 'dual-quintic-top-orbits.json').read_text())
    assert all(r['min_quintic_orbits'] > 4 for r in dual_seeded['classes'])
    for _, _, _, degree, off in audit(outside):
        assert degree == 5 and off
    outside_m = Counter()
    columns = [[evaluate_orbit(o) for _, o in basis] for basis in (UPPER[:66], TOP, LOW)]
    for high, values in outside.items():
        if not values:
            continue
        leading = leading_kernels(high, UPPER[:66])
        potential, _ = find_m_subspace(rotate_kernels(leading))
        if potential is None:
            outside_m[high] = len(values)
        else:
            h = xor_terms(columns[0], high)
            for t, l in values:
                table = h ^ xor_terms(columns[1], t) ^ xor_terms(columns[2], l)
                basis, _ = find_m_subspace(full_kernels(table, leading))
                outside_m[high] += basis is None
    records = []
    full = Counter()
    new = Counter()
    for high, row in sorted(counts.items()):
        if not row['normalized']:
            continue
        cls = groups[high]
        row['outside_m_class'] = outside_m[high]
        multiplicity = 4 * len(cls['members'])
        full.update({k: multiplicity * v for k, v in row.items()})
        if high not in known:
            for k in ('outside_diagonal', 'outside_m_class'):
                new[k] += 4 * cls['orbit_size'] * row[k]
        records.append({'high_mask': high, 'full_orbit_size': cls['orbit_size'],
                        'patterns_in_scope': len(cls['members']), **row,
                        'previously_counted_high_orbit': high in known})
    result = {'completed_shards': len(seen), 'quartic_trials': quartic, 'lower_trials': lower,
              'independently_checked_samples': sample, 'positive_classes': records,
              'four_orbit_counts_with_affine_terms': full,
              'new_quintics_in_full_high_orbits': new}
    (a.output / 'four-quintic-counts.json').write_text(json.dumps(result, indent=2) + '\n')
    with (a.output / 'four-quintic-outside-bent.tsv').open('w') as file:
        for h, values in sorted(outside.items()):
            for t, l in sorted(values):
                file.write(f'{h}\t{t}\t{l}\n')
    print({k: v for k, v in result.items() if k != 'positive_classes'})


if __name__ == '__main__':
    main()
