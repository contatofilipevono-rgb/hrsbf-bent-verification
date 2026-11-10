"""Count confirmed quintics and track exact coverage across resumed runs."""
import argparse
import json
from collections import Counter, defaultdict
from pathlib import Path


def main():
    p = argparse.ArgumentParser()
    p.add_argument('projection', type=Path)
    p.add_argument('catalog', type=Path)
    p.add_argument('reports', type=Path)
    p.add_argument('output', type=Path)
    a = p.parse_args()
    projection = json.loads(a.projection.read_text())['classes']
    catalog = {r['mask']: r for r in json.loads(a.catalog.read_text())['classes']}
    expected = defaultdict(set)
    for i, row in enumerate(projection):
        if not row['contradiction']:
            expected[row['mask']].update((i, j) for j in range(1 << max(0, min(4, row['quartic_free'] - 24))))
    counts = defaultdict(Counter)
    completed = defaultdict(set)
    samples = 0
    for file in sorted(a.reports.glob('*.json')):
        report = json.loads(file.read_text())
        samples += report['independently_checked_samples']
        for i, j, bits, quartic, lower, n, off in report['records']:
            high = projection[i]['mask']
            assert (i, j) in expected[high] and (i, j) not in completed[high]
            assert quartic == 1 << (projection[i]['quartic_free'] - bits)
            completed[high].add((i, j))
            counts[high].update({'quartic_trials': quartic, 'lower_trials': lower,
                                 'normalized': n, 'outside_diagonal': off})
    data = []
    total = Counter()
    for high, tasks in sorted(expected.items()):
        cls = catalog[high]
        c = counts[high]
        complete = completed[high] == tasks
        dual4 = cls['normalized_quartic_duals']
        if complete:
            assert c['outside_diagonal'] >= dual4
        lower = max(0, c['outside_diagonal'] - dual4) * 4 * cls['orbit_size']
        total['complete_high_orbits'] += complete
        total['completed_blocks'] += len(completed[high])
        total['planned_blocks'] += len(tasks)
        total['normalized_hits'] += c['normalized']
        total['outside_diagonal_dual5_lower_bound'] += lower
        if cls['leading_part_rules_out_m_subspace']:
            total['outside_m_class_dual5_lower_bound'] += lower
        data.append({'high_mask': high, 'blocks_completed': len(completed[high]), 'blocks_expected': len(tasks),
                     'complete': complete, 'orbit_size': cls['orbit_size'], **c,
                     'all_outside_diagonal_quartic_duals_normalized': dual4,
                     'outside_diagonal_dual5_lower_bound': lower,
                     'leading_part_rules_out_m_subspace': cls['leading_part_rules_out_m_subspace']})
    result = {'summary': total, 'independently_checked_samples': samples, 'classes': data}
    a.output.write_text(json.dumps(result, indent=2) + '\n')
    print(dict(total), 'samples:', samples, flush=True)


if __name__ == '__main__':
    main()
