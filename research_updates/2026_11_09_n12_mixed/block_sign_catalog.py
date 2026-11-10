"""Count RS bent sign assignments on matched Walsh blocks of size one and four."""
import argparse
import json
from collections import Counter, defaultdict
from functools import lru_cache
from itertools import combinations
from pathlib import Path

import numpy as np

from higher_filter import evaluate_orbit, shift, solve, xor_terms
from higher_project import LOW, TOP, UPPER, signs_to_walsh
from mobius_rule import integer_anf
from quartic_catalog import linear_generators
from spectral_switching import LOWER_WIDTH, additivity_space, block_walsh


def shape(spectrum):
    return tuple(sum(1 << int(b) for b in np.flatnonzero(row)) for row in spectrum)


def sign_system(pattern):
    pairs = {(z, b): i for i, (z, b) in enumerate(
        (z, b) for z, row in enumerate(pattern) for b in range(64) if row >> b & 1)}
    equations = []
    for key in (0, 1):
        fibers = defaultdict(list)
        for z, b in pairs:
            fibers[(z, b)[key]].append((z, b))
        assert len(fibers) == 64
        for points in fibers.values():
            if len(points) == 4:
                assert xor_terms([p[1 - key] for p in points], 15) == 0
                equations.append((sum(1 << pairs[p] for p in points), 1))
            else:
                assert len(points) == 1
    for (z, b), i in pairs.items():
        j = pairs[shift(z, 1, 6), shift(b, 1, 6)]
        equations.append(((1 << i) ^ (1 << j), ((z & b) >> 5) & 1))
    root, basis, rank = solve(equations, len(pairs))
    assert root is not None
    return pairs, equations, root, basis, rank


def inverse_rows(pattern, pairs, signs):
    table = 0
    for z, row in enumerate(pattern):
        frequencies = [b for b in range(64) if row >> b & 1]
        scale = 64 if len(frequencies) == 1 else 32
        for w in range(64):
            total = 0
            for b in frequencies:
                bit = ((signs >> pairs[z, b]) ^ (b & w).bit_count()) & 1
                total += -scale if bit else scale
            assert total in (-64, 64)
            table |= (total < 0) << ((z ^ w) | (w << 6))
    return table


def w_quadratic_part(table):
    coefficients = [0] * 64
    degree = 0
    for column, (i, j) in enumerate(combinations(range(6), 2)):
        def bit(z, w):
            return (table >> ((z ^ w) | (w << 6))) & 1

        a, b = 1 << i, 1 << j
        c = [bit(z, 0) ^ bit(z, a) ^ bit(z, b) ^ bit(z, a ^ b) for z in range(64)]
        for z, v in enumerate(c):
            coefficients[z] |= v << column
        for k in range(6):
            for z in range(64):
                if z >> k & 1:
                    c[z] ^= c[z ^ (1 << k)]
        degree = max(degree, max((z.bit_count() for z, v in enumerate(c) if v), default=0))
    return tuple(coefficients), degree


@lru_cache(maxsize=1)
def subspaces():
    levels = [{1}]
    for _ in range(6):
        next_ = set()
        for space in levels[-1]:
            vectors = [i for i in range(64) if space >> i & 1]
            for a in range(1, 64):
                if not space >> a & 1:
                    next_.add(space | sum(1 << (a ^ v) for v in vectors))
        levels.append(next_)
    assert [len(level) for level in levels] == [1, 63, 651, 1395, 651, 63, 1]
    return levels


@lru_cache(maxsize=None)
def possible_m_intersections(quadratic):
    pairs = list(combinations(range(6), 2))

    @lru_cache(maxsize=None)
    def contract(form, a):
        result = 0
        for k, (i, j) in enumerate(pairs):
            if form >> k & 1:
                result ^= (((a >> i) & 1) << j) | (((a >> j) & 1) << i)
        return result

    period = []
    radical = []
    for a in range(64):
        delta = [quadratic[z] ^ quadratic[z ^ a] for z in range(64)]
        period.append(sum(1 << b for b in range(64) if all(delta[z] == delta[z ^ b] for z in range(64))))
        forms = set(delta)
        radical.append(sum(1 << b for b in range(64) if all(contract(f, b) == 0 for f in forms)))
    forms = set(quadratic)
    isotropic = [sum(1 << b for b in range(64)
                     if all((contract(f, a) & b).bit_count() % 2 == 0 for f in forms))
                 for a in range(64)]
    levels = subspaces()
    iso_spaces = [[space for space in level if all(not (space & ~isotropic[a])
                                                  for a in range(64) if space >> a & 1)]
                  for level in levels]
    counts = []
    for d, level in enumerate(levels):
        valid = 0
        for z_space in level:
            directions = [a for a in range(64) if z_space >> a & 1]
            if any(z_space & ~period[a] for a in directions):
                continue
            allowed = (1 << 64) - 1
            for a in directions:
                allowed &= radical[a]
            valid += sum(k_space & ~allowed == 0 for k_space in iso_spaces[6 - d])
        counts.append(valid)
    return counts


def shape_action(rows):
    def forward(x):
        return sum(((x & r).bit_count() % 2) << j for j, r in enumerate(rows))

    projections = [(forward(z) & 63) ^ (forward(z) >> 6) for z in range(64)]
    on_diagonal = [forward((1 << j) | (1 << (j + 6))) for j in range(6)]
    assert all((x & 63) == x >> 6 for x in on_diagonal)
    frequency = [1 << sum(((b & x).bit_count() % 2) << j for j, x in enumerate(on_diagonal))
                 for b in range(64)]
    assert len(set(projections)) == len(set(frequency)) == 64

    @lru_cache(maxsize=None)
    def transport_support(mask):
        return xor_terms(frequency, mask)

    return lambda pattern: tuple(transport_support(pattern[z]) for z in projections)


def shape_orbits(patterns):
    actions = [shape_action(rows) for rows in linear_generators()]
    remaining = set(patterns)
    records = []
    while remaining:
        rep = min(remaining)
        orbit = {rep}
        queue = [rep]
        for pattern in queue:
            for action in actions:
                target = action(pattern)
                if target not in orbit:
                    orbit.add(target)
                    queue.append(target)
        assert 512 % len(orbit) == 0
        members = remaining & orbit
        remaining -= members
        dimensions = {patterns[p]['free_sign_bits'] for p in members}
        degrees = {patterns[p]['quadratic_in_w_coefficient_degree'] for p in members}
        assert len(dimensions) == len(degrees) == 1
        records.append({'seed': patterns[rep]['seed'], 'support_orbit_size': len(orbit),
                        'source_supports': len(members), 'free_sign_bits': dimensions.pop(),
                        'quadratic_in_w_coefficient_degree': degrees.pop()})
    return records


def main():
    p = argparse.ArgumentParser()
    p.add_argument('completions', type=Path)
    p.add_argument('output', type=Path)
    a = p.parse_args()
    groups = defaultdict(set)
    for line in a.completions.read_text().splitlines():
        high, t, l, _, _ = map(int, line.split())
        groups[high].add((t << len(LOW)) | l)
    columns = [evaluate_orbit(o) for _, o in LOW + TOP + UPPER]
    expected = [len(level) for level in subspaces()]
    assert possible_m_intersections((0,) * 64) == [expected[i] * expected[6 - i] for i in range(7)]
    patterns = {}
    disjoint_small = 0
    for high, values in sorted(groups.items()):
        if len(values) < 100:
            fixed = xor_terms(columns, high << LOWER_WIDTH)
            for low in values:
                f = fixed ^ xor_terms(columns, low)
                assert np.max(np.count_nonzero(block_walsh(f), axis=0)) > 4
                disjoint_small += 1
            continue
        _, subspace = additivity_space(values)
        remaining = set(values)
        while remaining:
            low = min(remaining)
            remaining -= {low ^ v for v in subspace}
            f = xor_terms(columns, (high << LOWER_WIDTH) | low)
            spectrum = block_walsh(f)
            pattern = shape(spectrum)
            if pattern in patterns:
                patterns[pattern]['seeds'] += 1
                continue
            assert Counter(np.count_nonzero(spectrum, axis=0)) == {1: 40, 4: 24}
            assert Counter(np.count_nonzero(spectrum, axis=1)) == {1: 40, 4: 24}
            pairs, rows, origin, basis, rank = sign_system(pattern)
            witness = sum(int(spectrum[z, b] < 0) << i for (z, b), i in pairs.items())
            assert all((mask & witness).bit_count() % 2 == rhs for mask, rhs in rows)
            quadratic, degree = w_quadratic_part(f)
            alternate = inverse_rows(pattern, pairs, origin ^ xor_terms(basis, 0x12345))
            assert shape(block_walsh(alternate)) == pattern
            assert all(abs(v) == 64 for v in signs_to_walsh(alternate))
            assert all((alternate >> x ^ alternate >> shift(x, 1)) & 1 == 0 for x in range(4096))
            assert max(i.bit_count() for i, v in enumerate(integer_anf(alternate)) if v & 1) == 6
            assert w_quadratic_part(alternate) == (quadratic, degree)
            patterns[pattern] = {'seed': [high, low], 'seeds': 1, 'sign_rank': rank,
                                 'free_sign_bits': len(basis), 'quadratic_in_w_coefficient_degree': degree,
                                 'possible_m_intersections': possible_m_intersections(quadratic)}
    transported = shape_orbits(patterns)
    assert all(not any(r['possible_m_intersections']) for r in patterns.values())
    first = next(iter(patterns))
    first_high, first_low = patterns[first]['seed']
    first_truth = xor_terms(columns, (first_high << LOWER_WIDTH) | first_low)
    for rows in linear_generators():
        moved = 0
        for x in range(4096):
            y = sum(((x & r).bit_count() % 2) << i for i, r in enumerate(rows))
            moved |= ((first_truth >> y) & 1) << x
        assert shape(block_walsh(moved)) == shape_action(rows)(first)
    result = {'patterns': [{**record, 'support_rows': pattern} for pattern, record in patterns.items()],
              'counts_by_free_sign_bits': Counter(r['free_sign_bits'] for r in patterns.values()),
              'functions_with_these_exact_supports': sum(1 << r['free_sign_bits'] for r in patterns.values()),
              'proven_degree_six': sum(1 << r['free_sign_bits'] for r in patterns.values()
                                       if r['quadratic_in_w_coefficient_degree'] == 4),
              'transported_support_orbits': transported,
              'small_sextic_source_completions_with_disjoint_support_types': disjoint_small,
              'proven_degree_six_with_transports': sum(r['support_orbit_size'] << r['free_sign_bits']
                                                       for r in transported
                                                       if r['quadratic_in_w_coefficient_degree'] == 4)}
    a.output.write_text(json.dumps(result, indent=2) + '\n')
    print({k: v for k, v in result.items() if k not in ('patterns', 'transported_support_orbits')})
    print('Support orbits:', len(transported), 'sizes:', Counter(r['support_orbit_size'] for r in transported))


if __name__ == '__main__':
    main()
