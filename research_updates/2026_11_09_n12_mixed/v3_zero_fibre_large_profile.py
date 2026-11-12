"""Exclude the fixed profile with zero rows x=0 and x=111 using one fibre."""
from collections import Counter, defaultdict
from itertools import combinations

from higher_filter import solve, xor_terms
from line_phase_algebra import quadratic_moments
from lower_dim_model import active_indices, anf
from lower_dim_moments import conditions
from lower_dim_v3_symbolic import eliminate, equations_for_task
from v3_zero_fibre_geometry import piece, point_orbit, z_orbit


def allowed_phases(support, orbit):
    masks = {}
    origin = 0
    for point in active_indices(support):
        label = orbit[point]
        bit = 1 << point
        if label & 63:
            masks[label] = masks.get(label, 0) | bit
        else:
            weight = (point >> 6).bit_count()
            masks[-1] = masks.get(-1, 0) | bit
            if weight & 1:
                masks[-2] = masks.get(-2, 0) | bit
            if weight & 2:
                origin |= bit
    return origin, list(masks.values())


def candidates():
    high = sum(1 << m for m in range(512) if m.bit_count() >= 6)
    parts = []
    for z in range(64):
        o = z_orbit(z)
        if len(o) != 6 or z != min(o):
            continue
        r = (z >> 3) ^ (z & 7)
        for u in range(8):
            if u < (u ^ r):
                support = piece(z, (u, u ^ r))
                parts.append((z, u, support, anf(support, 9) & high))
    fixed = sum(1 << (9*x + 64*u) for x in (0, 7) for u in range(8))
    signature = anf(fixed, 9) & high
    pair_indices = defaultdict(list)
    for i, j in combinations(range(len(parts)), 2):
        pair_indices[parts[i][3] ^ parts[j][3]].append((i, j))
    for value, pairs in pair_indices.items():
        for i, j in pairs:
            for k, l in pair_indices.get(value ^ signature, ()):
                if j >= k:
                    continue
                items = [parts[index] for index in (i, j, k, l)]
                if 3 in Counter(item[0] for item in items).values():
                    continue
                support = fixed
                for _, _, points, _ in items:
                    support |= points
                yield [(z, u) for z, u, _, _ in items], support


def main():
    orbit = [min(point_orbit(y)) for y in range(512)]
    counts = Counter()
    for pieces, support in candidates():
        counts['geometries'] += 1
        origin, directions = allowed_phases(support, orbit)
        moments = conditions([support], 9, 3)
        assert moments is not None
        checks = [(s, b) for s, _, b in moments]
        points_in_fibre = list(active_indices(support))
        for d in range(1, 512):
            points = sum(1 << y for y in points_in_fibre if (support >> (y ^ d)) & 1)
            assert points.bit_count() % 4 == 0
            if points:
                checks.append((points, points.bit_count() // 4))
        for z in range(64):
            row = sum(1 << (z + 64*u) for u in range(8))
            if (row & support) == row:
                checks.append((row, 0))
        linear = [(sum(((s & v).bit_count() & 1) << i for i, v in enumerate(directions)),
                   (b ^ (s & origin).bit_count()) & 1) for s, b in checks]
        shift, free, _ = solve(linear, len(directions))
        if shift is None:
            continue
        counts['linear'] += 1
        origin ^= xor_terms(directions, shift)
        directions = [xor_terms(directions, d) for d in free]
        eq4 = quadratic_moments(origin, directions, moments)
        if eliminate(len(directions), eq4, Counter())[1] == [{-1}]:
            counts['mod4'] += 1
            continue
        eq8 = equations_for_task(0, origin, 0, [(d, 0) for d in directions], moments)
        assert eliminate(len(directions), eq8, Counter())[1] == [{-1}], pieces
        counts['mod8'] += 1
        counts['constant_mod8'] += {0} in eq8
        print(pieces, 'phase directions after parity', len(directions),
              'weight mod8', (support & origin).bit_count() % 8)
    assert counts['geometries'] == 329 and counts['linear'] == 17
    assert counts['mod4'] + counts['mod8'] == counts['linear']
    print(dict(counts))


if __name__ == '__main__':
    main()
