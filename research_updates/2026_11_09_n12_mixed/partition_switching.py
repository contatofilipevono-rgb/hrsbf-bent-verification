"""Count every admissible pairing of the two Walsh block partitions."""
import argparse
import json
from collections import Counter, defaultdict
from itertools import combinations, permutations
from math import prod
from pathlib import Path

from antipodal_mm import eligible, signed_permanent
from block_sign_catalog import inverse_rows, possible_m_intersections, shape_action, sign_system
from higher_filter import orbits, shift, xor_terms
from higher_project import signs_to_walsh
from quartic_catalog import linear_generators


def partitions(pattern):
    rows = defaultdict(int)
    for z, row in enumerate(pattern):
        rows[row] |= 1 << z
    assert len(rows) == 46
    assert all(a.bit_count() == b.bit_count() for a, b in rows.items())
    return tuple(sorted(rows.values())), tuple(sorted(rows))


def supported_partitions(patterns):
    actions = [shape_action(rows) for rows in linear_generators()]
    found = {}
    queue = []
    for pattern in patterns:
        key = partitions(pattern)
        if key not in found:
            found[key] = pattern
            queue.append(key)
    for key in queue:
        for op in actions:
            pattern = op(found[key])
            next_ = partitions(pattern)
            if next_ not in found:
                found[next_] = pattern
                queue.append(next_)
    return sorted(found)


def singleton_orbits(partition):
    singles = {mask.bit_length() - 1 for mask in partition if mask.bit_count() == 1}
    result = defaultdict(list)
    for rep, orbit in orbits(6):
        if rep in singles:
            assert orbit <= singles
            result[len(orbit)].append(tuple(shift(rep, j, 6) for j in range(len(orbit))))
    assert sum(length * len(block) for length, block in result.items()) == 40
    return result


def plane_orbit(partition):
    planes = [m for m in partition if m.bit_count() == 4]
    assert len(planes) == 6
    start = planes[0]
    rotated = [sum(1 << shift(z, j, 6) for z in range(64) if start >> z & 1) for j in range(6)]
    assert set(rotated) == set(planes)
    return rotated


def quadratic_part(pattern):
    polar = []
    for row in pattern:
        if not row:
            polar.append(0)
            continue
        a, b, c, d = [i for i in range(64) if row >> i & 1]
        assert a ^ b ^ c ^ d == 0
        u, v = a ^ b, a ^ c
        form = 0
        for k, (i, j) in enumerate(combinations(range(6), 2)):
            bit = ((u >> i) & (v >> j) ^ (u >> j) & (v >> i)) & 1
            form |= bit << k
        polar.append(form)
    coefficients = polar.copy()
    for i in range(6):
        for z in range(64):
            if z >> i & 1:
                coefficients[z] ^= coefficients[z ^ (1 << i)]
    return tuple(polar), max(z.bit_count() for z, c in enumerate(coefficients) if c)


def count_pair(left, right):
    a, b = singleton_orbits(left), singleton_orbits(right)
    assert {k: len(v) for k, v in a.items()} == {k: len(v) for k, v in b.items()}
    counts = {}
    sample_singletons = {}
    for length, group in sorted(a.items()):
        options = [[[p for p in range(length) if eligible(s, t, p) is not None]
                    for t in b[length]] for s in group]
        matrix = [[len(phases) for phases in row] for row in options]
        counts[length] = signed_permanent(matrix)
        brute = 0
        for order in permutations(range(len(group))):
            ways = prod(matrix[i][j] for i, j in enumerate(order))
            if ways and not brute:
                for i, j in enumerate(order):
                    phase = options[i][j][0]
                    for k, z in enumerate(group[i]):
                        sample_singletons[z] = 1 << b[length][j][(k + phase) % length]
            brute += ways
        assert counts[length] == brute
    matchings = 1
    for n in counts.values():
        matchings *= n
    free_singletons = sum(map(len, a.values()))
    z_planes, b_planes = plane_orbit(left), plane_orbit(right)
    phases = []
    total = 0
    for phase in range(6):
        pattern = [0] * 64
        for j, z_mask in enumerate(z_planes):
            for z in range(64):
                if z_mask >> z & 1:
                    pattern[z] = b_planes[(j + phase) % 6]
        _, _, origin, basis, _ = sign_system(pattern, expected_fibers=24)
        if origin is None:
            continue
        polar, degree = quadratic_part(pattern)
        possible = possible_m_intersections(polar)
        certified = degree == 4 and not any(possible)
        size = matchings << (free_singletons + len(basis))
        if certified:
            total += size
            sample = [sample_singletons.get(z, row) for z, row in enumerate(pattern)]
            pairs, _, root, sign_basis, _ = sign_system(sample)
            assert root is not None and len(sign_basis) == free_singletons + len(basis)
            f = inverse_rows(sample, pairs, root ^ xor_terms(sign_basis, 0x1AB))
            assert partitions(sample) == (left, right)
            assert all((f >> x ^ f >> shift(x, 1)) & 1 == 0 for x in range(4096))
            assert all(abs(w) == 64 for w in signs_to_walsh(f))
        phases.append({'phase': phase, 'free_plane_sign_bits': len(basis), 'size': size,
                       'quadratic_coefficient_degree': degree, 'possible_m_intersections': possible,
                       'certified_degree_six_outside_m_class': certified})
    return {'row_partition': left, 'frequency_partition': right, 'singleton_matchings': counts,
            'free_singleton_sign_bits': free_singletons, 'plane_phases': phases,
            'certified_degree_six_outside_m_class': total}


def main():
    p = argparse.ArgumentParser()
    p.add_argument('block_catalog', type=Path)
    p.add_argument('output', type=Path)
    a = p.parse_args()
    source = json.loads(a.block_catalog.read_text())
    patterns = [tuple(r['support_rows']) for r in source['patterns']]
    classes = supported_partitions(patterns)
    records = [count_pair(*key) for key in classes]
    total = sum(r['certified_degree_six_outside_m_class'] for r in records)
    result = {'partition_pairs': len(records), 'records': records,
              'degree_six_outside_m_class': total,
              'distinct_phase_totals': Counter(r['certified_degree_six_outside_m_class'] for r in records)}
    a.output.write_text(json.dumps(result, indent=2) + '\n')
    print({k: v for k, v in result.items() if k != 'records'})


if __name__ == '__main__':
    main()
