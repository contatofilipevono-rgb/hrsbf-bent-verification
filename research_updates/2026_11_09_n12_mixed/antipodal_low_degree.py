"""Count low-degree antipodal Maiorana–McFarland functions independently."""
import argparse
import json
from collections import Counter, defaultdict
from itertools import combinations, permutations, product
from pathlib import Path

from antipodal_mm import eligible
from higher_filter import orbits, shift


def phase_tables():
    groups = defaultdict(list)
    for rep, cycle in orbits(6):
        groups[len(cycle)].append(tuple(shift(rep, j, 6) for j in range(len(cycle))))
    supports = [s for d in (5, 4, 3) for s in range(64) if s.bit_count() == d]
    point_signatures = [sum(1 << i for i, s in enumerate(supports) if z & s == z) for z in range(64)]
    tables = {}
    for length, group in groups.items():
        rows = []
        for source in group:
            row = []
            for target in group:
                options = []
                for phase in range(length):
                    if eligible(source, target, phase) is None:
                        continue
                    signature = 0
                    for j, z in enumerate(source):
                        if target[(j + phase) % length] & 1:
                            signature ^= point_signatures[z]
                    options.append(signature)
                row.append(options)
            rows.append(row)
        tables[length] = rows
    return tables


def assignments(table, start, destinations):
    for order in permutations(destinations):
        for selection in product(*(table[i][j] for i, j in enumerate(order, start))):
            syndrome = 0
            for mask in selection:
                syndrome ^= mask
            yield syndrome


def count_permutations(tables):
    small = Counter({0: 1})
    for length in (1, 2, 3):
        group = list(assignments(tables[length], 0, range(len(tables[length]))))
        next_ = Counter()
        for a, n in small.items():
            for b in group:
                next_[a ^ b] += n
        small = next_
    table = tables[6]
    destinations = set(range(len(table)))
    masks = {2: (1 << 41) - 1, 3: (1 << 21) - 1, 4: (1 << 6) - 1}
    counts = Counter()
    for selected in combinations(sorted(destinations), 4):
        left = {d: Counter() for d in masks}
        for signature in assignments(table, 0, selected):
            for offset, n in small.items():
                for degree, mask in masks.items():
                    left[degree][(signature ^ offset) & mask] += n
        for signature in assignments(table, 4, sorted(destinations - set(selected))):
            for degree, mask in masks.items():
                counts[degree] += left[degree][signature & mask]
    return counts


def main():
    p = argparse.ArgumentParser()
    p.add_argument('output', type=Path)
    a = p.parse_args()
    counts = count_permutations(phase_tables())
    by_degree = {}
    for d in (3, 4, 5):
        phase_bits = sum(1 for m, _ in orbits(6) if m.bit_count() <= d)
        by_degree[d] = {'eligible_permutations': counts[d - 1], 'phase_bits': phase_bits,
                        'functions_of_degree_at_most_d': counts[d - 1] << phase_bits}
    result = {'degree_cutoffs': by_degree,
              'exact_degree_four': by_degree[4]['functions_of_degree_at_most_d'] -
              by_degree[3]['functions_of_degree_at_most_d']}
    a.output.write_text(json.dumps(result, indent=2) + '\n')
    print(result)


if __name__ == '__main__':
    main()
