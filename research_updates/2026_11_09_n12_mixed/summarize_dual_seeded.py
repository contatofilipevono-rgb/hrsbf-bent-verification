"""Audit completions of selected high orbits located through quartic duality."""
import argparse
import json
from collections import Counter, defaultdict
from pathlib import Path

from higher_project import UPPER
from m_subspaces import find_m_subspace
from quartic_m_catalog import leading_kernels, rotate_kernels
from summarize_two import audit, collect


def main():
    p = argparse.ArgumentParser()
    p.add_argument('projection', type=Path)
    p.add_argument('top_orbits', type=Path)
    p.add_argument('shards', type=Path)
    p.add_argument('output', type=Path)
    a = p.parse_args()
    projection = json.loads(a.projection.read_text())['classes']
    metadata = {r['mask']: r for r in json.loads(a.top_orbits.read_text())['classes']}
    completions, totals, shards = collect(projection, a.shards)
    assert set(completions) == {r['mask'] for r in projection}
    counts = defaultdict(Counter)
    outside = defaultdict(Counter)
    a.output.mkdir(parents=True, exist_ok=True)
    with (a.output / 'dual-seeded-bent.tsv').open('w') as file:
        for h, t, l, d, e in audit(completions):
            assert d in (4, 5)
            counts[h][d] += 1
            outside[h][d] += e
            file.write(f'{h}\t{t}\t{l}\t{d}\t{int(e)}\n')
    rows = []
    total_new = 0
    certified_outside_m = 0
    for high in sorted(completions):
        info = metadata[high]
        assert outside[high][4] == info['normalized_quartic_duals']
        bound, _ = find_m_subspace(rotate_kernels(leading_kernels(high, UPPER[:66])))
        new = outside[high][5] * 4 * info['orbit_size']
        total_new += new
        if bound is None:
            certified_outside_m += new
        rows.append({**info, 'normalized_by_dual_degree': counts[high],
                     'outside_diagonal_by_dual_degree': outside[high],
                     'leading_part_rules_out_m_subspace': bound is None})
    result = {'completed_shards': shards, 'trials': totals, 'classes': rows,
              'quintics_with_quintic_dual_outside_diagonal': total_new,
              'certified_outside_m_by_leading_part': certified_outside_m}
    (a.output / 'dual-seeded-counts.json').write_text(json.dumps(result, indent=2) + '\n')
    print({k: v for k, v in result.items() if k != 'classes'})


if __name__ == '__main__':
    main()
