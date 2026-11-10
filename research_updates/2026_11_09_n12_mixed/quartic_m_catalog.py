"""Use second derivatives to partition quartics outside the antipodal family."""
import argparse
import json
from collections import Counter, defaultdict
from itertools import combinations
from pathlib import Path

from higher_filter import N, SIZE, evaluate_orbit, orbits, shift, xor_terms
from higher_project import LOW, TOP
from m_subspaces import find_m_subspace, translations


CYCLES = tuple((a, len(o)) for a, o in orbits(N) if a)
PAIRS = {s: i for i, s in enumerate(sorted(s for _, o in orbits(N, 2) for s in o))}


def kernel_basis(columns):
    pivots = {}
    basis = []
    for i, col in enumerate(columns):
        vector = 1 << i
        while col:
            j = col.bit_length() - 1
            if j not in pivots:
                pivots[j] = col, vector
                break
            c, v = pivots[j]
            col ^= c
            vector ^= v
        else:
            basis.append(vector)
    return basis


def leading_kernels(top):
    columns = [[0] * N for _ in range(N)]
    for i, (_, supports) in enumerate(TOP):
        if not top >> i & 1:
            continue
        for s in supports:
            for j, k in combinations((j for j in range(N) if s >> j & 1), 2):
                coefficient = 1 << PAIRS[s ^ (1 << j) ^ (1 << k)]
                columns[j][k] ^= coefficient
                columns[k][j] ^= coefficient
    result = {}
    for a, _ in CYCLES:
        basis = kernel_basis(xor_terms(c, a) for c in columns)
        if len(basis) < 6:
            continue
        space = [0]
        for b in basis:
            space += [v ^ b for v in space]
        assert a in space
        result[a] = space
    return result


def rotate_kernels(spaces):
    result = dict.fromkeys(range(1, SIZE), 0)
    for a, length in CYCLES:
        if a in spaces and len(spaces[a]) >= 64:
            for k in range(length):
                result[shift(a, k)] = sum(1 << shift(b, k) for b in spaces[a])
    return result


def full_kernels(table, leading):
    translates = translations(table)
    exact = {}
    for a, space in leading.items():
        derivative = table ^ translates[a]
        exact[a] = [b for b in space if translates[b] ^ translates[a ^ b] == derivative]
        assert a in exact[a] and len(exact[a]).bit_count() == 1
    return rotate_kernels(exact)


def main():
    p = argparse.ArgumentParser()
    p.add_argument('outside_list', type=Path)
    p.add_argument('output', type=Path)
    p.add_argument('--plan-only', action='store_true')
    p.add_argument('--shard', type=int, default=0)
    p.add_argument('--shards', type=int, default=1)
    a = p.parse_args()
    groups = defaultdict(list)
    for line in a.outside_list.read_text().splitlines():
        top, lower, orbit_size = map(int, line.split())
        groups[top].append((lower, orbit_size))
    tops = [evaluate_orbit(o) for _, o in TOP]
    lows = [evaluate_orbit(o) for _, o in LOW]
    totals = Counter()
    records = []
    for top, completions in sorted(groups.items())[a.shard::a.shards]:
        leading = leading_kernels(top)
        potential, visited = find_m_subspace(rotate_kernels(leading))
        report = {'top': top, 'representative_records': len(completions),
                  'weighted_count': sum(4 * size for _, size in completions),
                  'potential_m_basis': potential, 'visited_by_dimension': visited}
        if potential is None:
            totals['excluded_by_top'] += report['weighted_count']
        elif not a.plan_only:
            h = xor_terms(tops, top)
            inside = []
            for lower, size in completions:
                f = h ^ xor_terms(lows, lower)
                m, _ = find_m_subspace(full_kernels(f, leading))
                if m is not None:
                    inside.append([lower, size, m])
            report['exact_m_members'] = inside
            totals['inside_m_class'] += sum(4 * size for _, size, _ in inside)
            totals['excluded_by_full_derivatives'] += (report['weighted_count'] -
                                                       sum(4 * size for _, size, _ in inside))
        else:
            totals['pending_exact'] += report['weighted_count']
        records.append(report)
    a.output.write_text(json.dumps({'totals': totals, 'records': records}, indent=2) + '\n')
    print(totals)


if __name__ == '__main__':
    main()
