"""Filter all three-orbit quintic parts and quotient by cyclic normalizers."""
import argparse
import json
from itertools import combinations
from math import comb
from pathlib import Path

from higher_filter import orbits
from higher_orbits import high_actions
from higher_project import UPPER
from top_quotient import transform_tables
from upper_union_counts import union_equation


def generator_group(width):
    ops = [transform_tables(op[:width]) for op in high_actions()]
    identity = tuple(1 << i for i in range(width))
    group = [identity]
    known = {identity}
    shifts = range(0, width, 8)

    def apply(op, v):
        result = 0
        for table, bit in zip(op, shifts):
            result ^= table[(v >> bit) & 255]
        return result

    for cols in group:
        for op in ops:
            candidate = tuple(apply(op, c) for c in cols)
            if candidate not in known:
                known.add(candidate)
                group.append(candidate)
    assert 512 % len(group) == 0
    return group


def plan(weight):
    quintic = UPPER[:66]
    equations = [union_equation(s, quintic) for s, _ in orbits(12, 10)]
    syndromes = {term: sum((term in p) << i for i, p in enumerate(equations))
                 for term in set.union(*equations)}
    options = [1 << i for i in range(66)]
    remaining = {}
    for chosen in combinations(options, weight):
        syndrome = 0
        for t in chosen:
            syndrome ^= syndromes.get(t, 0)
        for a, b in combinations(chosen, 2):
            syndrome ^= syndromes.get(a | b, 0)
        if not syndrome:
            remaining[sum(chosen)] = tuple(x.bit_length() - 1 for x in chosen)
    n = len(remaining)
    group = generator_group(66)
    rows = []
    for mask in sorted(remaining):
        if mask not in remaining:
            continue
        active = remaining[mask]
        full_orbit = set()
        for cols in group:
            v = 0
            for i in active:
                v ^= cols[i]
            full_orbit.add(v)
        members = sorted(full_orbit & remaining.keys())
        assert mask == members[0]
        for m in members:
            del remaining[m]
        rows.append({'mask': mask, 'orbit_size': len(full_orbit), 'members': members})
    assert not remaining and sum(len(r['members']) for r in rows) == n
    return {'summary': {'patterns': comb(66, weight), 'patterns_passing': n, 'classes_passing': len(rows),
                        'group_size': len(group)}, 'classes': rows}


def main():
    p = argparse.ArgumentParser()
    p.add_argument('output', type=Path)
    p.add_argument('--weight', type=int, choices=(3, 4), default=3)
    a = p.parse_args()
    result = plan(a.weight)
    a.output.write_text(json.dumps(result, separators=(',', ':')) + '\n')
    print(result['summary'])


if __name__ == '__main__':
    main()
