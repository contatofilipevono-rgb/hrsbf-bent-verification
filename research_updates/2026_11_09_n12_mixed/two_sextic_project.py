"""Reduce every part with two upper orbits and at least one sextic orbit."""
import argparse
import json
from collections import Counter
from itertools import combinations
from pathlib import Path

from higher_orbits import high_actions, orbit
from higher_project import UPPER, eliminate_lower, union_system
from sparse_projection import reduce_iteratively


def plan():
    # Every union of size 11 or 12 uses two terms from the fixed high part.
    remaining = set()
    excluded = []
    for j in range(66, len(UPPER)):
        for i in range(j):
            high = (1 << i) | (1 << j)
            pairs = Counter(a | b for a, b in combinations(UPPER[i][1] | UPPER[j][1], 2)
                            if (a | b).bit_count() >= 11)
            witness = min((s for s, n in pairs.items() if n % 2), default=0)
            if witness:
                excluded.append([i, j, witness])
            else:
                remaining.add(high)
    assert len(remaining) + len(excluded) == 8440
    operators = high_actions()
    classes = []
    for mask in sorted(remaining):
        if mask not in remaining:
            continue
        group = orbit(mask, operators)
        members = group & remaining
        remaining -= members
        classes.append({'mask': mask, 'orbit_size': len(group), 'members': sorted(members)})
    assert not remaining
    return {'excluded_by_pair_union': excluded, 'classes': classes}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('plan', type=Path)
    parser.add_argument('--create', action='store_true')
    parser.add_argument('--shard', type=int, default=0)
    parser.add_argument('--shards', type=int, default=1)
    parser.add_argument('--output', type=Path)
    a = parser.parse_args()
    if a.create:
        result = plan()
        a.plan.write_text(json.dumps(result, separators=(',', ':')) + '\n')
        print('Excluded:', len(result['excluded_by_pair_union']), 'classes:', len(result['classes']))
        return
    classes = json.loads(a.plan.read_text())['classes']
    reports = []
    for row in classes[a.shard::a.shards]:
        low, residual = eliminate_lower(union_system(row['mask']))
        _, basis, poly, stages, certificate = reduce_iteratively(residual)
        reports.append({'mask': row['mask'], 'patterns': len(row['members']),
                        'lower_rank': len(low), 'quartic_free': len(basis),
                        'residual_equations': len(poly), 'stages': stages,
                        'contradiction': certificate is not None,
                        'certificate_of_final_contradiction': certificate})
    a.output.write_text(json.dumps(reports, indent=2) + '\n')
    print('shard', a.shard, 'tested', len(reports), 'contradictions',
          sum(r['contradiction'] for r in reports))


if __name__ == '__main__':
    main()
