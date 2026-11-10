"""Check the two-orbit quintic shards and verify every positive by full Walsh."""
import argparse
import json
from collections import Counter, defaultdict
from pathlib import Path

from antipodal_mm import affine_deviation
from higher_filter import evaluate_orbit, xor_terms
from higher_orbits import high_actions, orbit
from higher_project import LOW, TOP, UPPER, signs_to_walsh
from mobius_rule import integer_anf


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('projection', type=Path)
    parser.add_argument('preflight', type=Path)
    parser.add_argument('shards', type=Path)
    parser.add_argument('output', type=Path)
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
    operators = high_actions()
    known = {'single_orbit': orbit(1 << 61, operators),
             'fixed_quintic': orbit(int('40640b82416fcc8c', 16), operators)}
    by_dual, new = Counter(), Counter()
    lines = []
    positives = []
    for i, vals in sorted(completions.items()):
        if not vals:
            continue
        high = projection[i]['mask']
        cls = classes[high]
        count = Counter()
        outside = Counter()
        for t, l in sorted(vals):
            table = xor_terms(bases[0], high) ^ xor_terms(bases[1], t) ^ xor_terms(bases[2], l)
            spectrum = signs_to_walsh(table)
            assert all(abs(w) == 64 for w in spectrum)
            dual = sum((w < 0) << j for j, w in enumerate(spectrum))
            d = max(j.bit_count() for j, c in enumerate(integer_anf(dual)) if c & 1)
            assert d in (4, 5)
            count[d] += 1
            outside[d] += bool(affine_deviation(table))
            lines.append(f'{high}\t{t}\t{l}\t{d}\t{int(bool(affine_deviation(table)))}\n')
        members = len(cls['two_orbit_members'])
        for d, n in count.items():
            by_dual[d] += 4 * members * n
        overlaps = [label for label, group in known.items() if high in group]
        if not overlaps:
            new.update({d: 4 * cls['orbit_size'] * n for d, n in outside.items()})
        positives.append({'mask': high, 'active_indices': [j for j in range(66) if high >> j & 1],
                          'two_orbit_members': members, 'full_orbit_size': cls['orbit_size'],
                          'normalized_by_dual_degree': count, 'outside_by_dual_degree': outside,
                          'previous_high_orbits': overlaps})
    result = {'scope': 'exactly two active quintic orbits, no sextic terms',
              'completed_shards': len(seen), 'trials': totals, 'positive_classes': positives,
              'counts_by_dual_degree_with_affine_terms': by_dual,
              'new_outside_diagonal_in_full_high_orbits_by_dual_degree': new}
    a.output.mkdir(parents=True, exist_ok=True)
    (a.output / 'two-quintic-counts.json').write_text(json.dumps(result, indent=2) + '\n')
    (a.output / 'two-quintic-bent.tsv').write_text(''.join(lines))
    print(json.dumps(result, indent=2))


if __name__ == '__main__':
    main()
