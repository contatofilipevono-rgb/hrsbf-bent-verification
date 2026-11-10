"""Check the two-orbit shards and verify every positive by full Walsh."""
import argparse
import json
from collections import Counter, defaultdict
from pathlib import Path

import numpy as np

from antipodal_mm import affine_deviation
from dual_catalog import degree_and_check
from higher_filter import SIZE, evaluate_orbit, xor_terms
from higher_orbits import high_actions, orbit
from higher_project import LOW, TOP, UPPER
from top_filters import masks_of_size


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('projection', type=Path)
    parser.add_argument('preflight', type=Path)
    parser.add_argument('shards', type=Path)
    parser.add_argument('output', type=Path)
    parser.add_argument('--with-sextic', action='store_true')
    a = parser.parse_args()
    projection = json.loads(a.projection.read_text())['classes']
    classes = {r['mask']: r for r in json.loads(a.preflight.read_text())['classes']}
    completions = defaultdict(set)
    totals = Counter()
    seen = set()
    for p in sorted(a.shards.glob('*/chart-*/report.json')):
        r = json.loads(p.read_text())
        i, part, bits = r['index'], r['shard'], r['shard_bits']
        chart = projection[i]
        expected_bits = max(0, min(4, chart['quartic_free'] - 24))
        assert not chart['contradiction'] and r['high_mask'] == chart['mask']
        assert bits == expected_bits and 0 <= part < 1 << bits and (i, part) not in seen
        assert r['quartic_trials'] == 1 << (chart['quartic_free'] - bits)
        seen.add((i, part))
        rows = [tuple(map(int, line.split())) for line in
                (p.parent / 'bent.tsv').read_text().splitlines()]
        assert all(j == i for j, _, _ in rows)
        vals = {(t, l) for _, t, l in rows}
        assert len(rows) == len(vals) == r['normalized_bent']
        assert not vals & completions[i]
        completions[i].update(vals)
        for k in ('quartic_trials', 'quartic_filter_survivors', 'lower_trials', 'normalized_bent'):
            totals[k] += r[k]
    assert seen == {(i, j) for i, r in enumerate(projection) if not r['contradiction']
                    for j in range(1 << max(0, min(4, r['quartic_free'] - 24)))}
    bases = [[evaluate_orbit(o) for _, o in basis] for basis in (UPPER, TOP, LOW)]
    deviations = [[affine_deviation(table) for table in basis] for basis in bases]
    positions = {d: list(masks_of_size(d)) for d in range(2, 7)}
    positions[7] = [m for d in range(7, 13) for m in masks_of_size(d)]
    operators = high_actions()
    known = ({'su': orbit((1 << 67) | 1, operators)} if a.with_sextic else
             {'single_orbit': orbit(1 << 61, operators),
              'fixed_quintic': orbit(int('40640b82416fcc8c', 16), operators)})
    by_dual, outside_by_dual, new = Counter(), Counter(), Counter()
    lines = []
    positives = []
    for i, vals in sorted(completions.items()):
        if not vals:
            continue
        high = projection[i]['mask']
        cls = classes[high]
        count = Counter()
        outside = Counter()
        high_truth = xor_terms(bases[0], high)
        high_deviation = xor_terms(deviations[0], high)
        ordered = sorted(vals)
        for start in range(0, len(ordered), 256):
            batch = ordered[start:start + 256]
            tables = b''.join((high_truth ^ xor_terms(bases[1], t) ^ xor_terms(bases[2], l))
                              .to_bytes(SIZE // 8, 'little') for t, l in batch)
            degrees = degree_and_check(np.frombuffer(tables, dtype=np.uint64).reshape(len(batch), -1),
                                       positions)
            for (t, l), degree in zip(batch, degrees, strict=True):
                d = int(degree)
                assert d == 6 if a.with_sextic else d in (4, 5)
                count[d] += 1
                outside_diagonal = int(bool(high_deviation ^ xor_terms(deviations[1], t) ^
                                            xor_terms(deviations[2], l)))
                outside[d] += outside_diagonal
                lines.append(f'{high}\t{t}\t{l}\t{d}\t{outside_diagonal}\n')
        members = len(cls['members' if a.with_sextic else 'two_orbit_members'])
        for d, n in count.items():
            by_dual[d] += 4 * members * n
            outside_by_dual[d] += 4 * members * outside[d]
        overlaps = [label for label, group in known.items() if high in group]
        if not overlaps:
            new.update({d: 4 * cls['orbit_size'] * n for d, n in outside.items()})
        positives.append({'mask': high, 'active_indices': [j for j in range(len(UPPER)) if high >> j & 1],
                          'two_orbit_members': members, 'full_orbit_size': cls['orbit_size'],
                          'normalized_by_dual_degree': count, 'outside_by_dual_degree': outside,
                          'previous_high_orbits': overlaps})
    scope = ('exactly two active orbits above degree four, at least one sextic' if a.with_sextic else
             'exactly two active quintic orbits, no sextic terms')
    result = {'scope': scope,
              'completed_shards': len(seen), 'trials': totals, 'positive_classes': positives,
              'counts_by_dual_degree_with_affine_terms': by_dual,
              'outside_diagonal_by_dual_degree_with_affine_terms': outside_by_dual,
              'new_outside_diagonal_in_full_high_orbits_by_dual_degree': new}
    a.output.mkdir(parents=True, exist_ok=True)
    label = 'two-sextic' if a.with_sextic else 'two-quintic'
    (a.output / f'{label}-counts.json').write_text(json.dumps(result, indent=2) + '\n')
    (a.output / f'{label}-bent.tsv').write_text(''.join(lines))
    print(json.dumps(result, indent=2))


if __name__ == '__main__':
    main()
