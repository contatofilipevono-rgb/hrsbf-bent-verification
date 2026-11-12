"""Reduce all fixed restrictions in V3 to orbit pieces of the zero fibre."""
import argparse
import json
from collections import Counter, defaultdict
from itertools import combinations
from pathlib import Path

from count_near_antipodal import all_points, image_and_kernel
from higher_filter import solve, xor_terms
from lower_dim_model import active_indices, anf, build
from lower_dim_moments import conditions
from lower_dim_support import fibre_masks
from lower_dim_v3_q_classify import decompose
from lower_dim_v3_symbolic import affine_at, eliminate, equations_for_task, product
from v3_zero_fibre_geometry import piece, point_orbit, z_orbit


HIGH = sum(1 << m for m in range(512) if m.bit_count() >= 6)


def high_part(support):
    return anf(support, 9) & HIGH


def fixed_restrictions():
    model = build((9, 18, 36))
    image, _ = image_and_kernel([decompose(p)[1] for p, _ in model.maps])
    assert len(image) == 6
    for fixed in sorted(all_points([v for v, _ in image])):
        slices = [tuple((fixed >> (24*x + 3*u)) & 7 for u in range(8)) for x in range(8)]
        if any(len(set(s)) > 2 for s in slices):
            continue
        g = tuple(s[0] for s in slices)
        full = all(len(set(s)) == 1 for s in slices)
        support = sum(1 << (9*x + 64*u) for x, s in enumerate(slices) for u, value in enumerate(s)
                      if value == 0)
        yield g, full, support


def exterior_pieces():
    parts = []
    for z in range(64):
        cycle = z_orbit(z)
        if len(cycle) != 6 or z != min(cycle):
            continue
        r = (z >> 3) ^ (z & 7)
        for u in range(8):
            if u < (u ^ r):
                shape = piece(z, (u, u ^ r))
                parts.append((z, u, shape, high_part(shape)))
    short = {sum(1 << y for y in point_orbit(21 + 64*u)) for u in range(8)}
    assert sorted(s.bit_count() for s in short) == [4, 12]
    short_small, short_large = sorted(short, key=int.bit_count)
    return parts, (0, short_small, short_small | short_large)


def geometry(fixed, full, parts, lookup, shorts):
    for short in shorts:
        outside = 64 - fixed.bit_count() - short.bit_count()
        if outside < 0 or outside % 12:
            continue
        n = outside // 12
        target = high_part(fixed | short)
        for value, head in lookup[n // 2].items():
            for left in head:
                for right in lookup[(n+1) // 2].get(value ^ target, ()):
                    if left and right and left[-1] >= right[0]:
                        continue
                    items = [parts[i] for i in left + right]
                    multiplicity = Counter(z for z, _, _, _ in items)
                    if 3 in multiplicity.values():
                        continue
                    support = fixed | short
                    for _, _, s, _ in items:
                        support |= s
                    assert support.bit_count() == 64
                    if full and multiplicity[7] == 2:
                        u_mask = sum(((support >> (7 + 64*u)) & 1) << u for u in range(8))
                        if u_mask not in (90, 165):
                            continue
                    yield support


def test_phase(support, orbit, polar, label7=False):
    origin = 0
    masks = defaultdict(int)
    points = list(active_indices(support))
    if label7:
        for representative in {orbit[y] for y in points}:
            phase = 0
            for y in point_orbit(representative):
                origin |= phase << y
                phase ^= (y >> 8) & 1
            if phase:
                return 'rotation_phase'
    for y in points:
        label = orbit[y]
        if polar is None or label & 63:
            masks[label] |= 1 << y
        else:
            w = (y >> 6).bit_count()
            masks[-1] |= 1 << y
            if w & 1:
                masks[-2] |= 1 << y
            if polar and w & 2:
                origin |= 1 << y
    directions = list(masks.values())
    moments = conditions([support], 9, 3)
    assert moments is not None
    checks = [(s, b) for s, _, b in moments]
    for d in range(1, 512):
        intersection = sum(1 << y for y in points if (support >> (y ^ d)) & 1)
        if intersection.bit_count() % 4:
            return 'support_parity'
        if intersection:
            checks.append((intersection, intersection.bit_count() // 4))
    for z in range(64):
        row = sum(1 << (z + 64*u) for u in range(8))
        if (row & support) == row:
            checks.append((row, 0))
    linear = [(sum(((s & v).bit_count() & 1) << i for i, v in enumerate(directions)),
               (b ^ (s & origin).bit_count()) & 1) for s, b in checks]
    shift, free, _ = solve(linear, len(directions))
    if shift is None:
        return 'linear'
    origin ^= xor_terms(directions, shift)
    directions = [xor_terms(directions, d) for d in free]
    system = equations_for_task(0, origin, 0, [(v, 0) for v in directions], moments)
    _, reduced = eliminate(len(directions), system, Counter())
    return 'moments' if reduced == [{-1}] else 'residual'


def test_mapping(support, g, columns, masks, support7=0):
    rows = []
    for x in range(8):
        for u in range(8):
            y = 9*x + 64*u
            rows.extend((columns[512*j + y], (g[x] >> j) & 1) for j in range(3))
    for y in active_indices(support):
        rows.extend((columns[512*j + y], 0) for j in range(3))
    for y in active_indices(support7):
        rows.extend((columns[512*j + y], 1) for j in range(3))
    origin, directions, _ = solve(rows, len(masks))
    if origin is None:
        return 'map_linear'
    fixed = xor_terms(masks, origin)
    variation = 0
    for v in directions:
        variation |= xor_terms(masks, v)
    forced_zero = fibre_masks(fixed | variation, 512, 3)[0]
    if forced_zero & ~support:
        return 'map_extra_zeros'
    if support7:
        forced_seven = fibre_masks(fixed & ~variation, 512, 3)[7]
        if forced_seven & ~support7:
            return 'map_extra_sevens'
        return finish_mapping(support | support7, fixed, [xor_terms(masks, v) for v in directions])
    return f'map_dimension_{len(directions)}'


def finish_mapping(assigned, origin, directions):
    mask = (1 << 512) - 1
    one = [((p ^ (p >> 1024)) & mask) for p in [origin] + directions]
    two = [(((p >> 512) ^ (p >> 1024)) & mask) for p in [origin] + directions]
    equations = [product(affine_at(y, one[0], one[1:]) ^ {0}, affine_at(y, two[0], two[1:]) ^ {0})
                 for y in active_indices(mask ^ assigned)]
    assert eliminate(len(directions), equations, Counter())[1] == [{-1}], 'compatible pair of fibres'
    return 'map_nonzero_quotient_mod2'


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path)
    args = parser.parse_args()
    parts, shorts = exterior_pieces()
    lookup = []
    for n in range(4):
        values = defaultdict(list)
        for indices in combinations(range(len(parts)), n):
            values[xor_terms([part[3] for part in parts], sum(1 << i for i in indices))].append(indices)
        lookup.append(values)
    orbit = [min(point_orbit(y)) for y in range(512)]
    restrictions = list(fixed_restrictions())
    assert len(restrictions) == 16
    masks = [p for p, _ in build((9, 18, 36)).maps]
    columns = [sum(((p >> y) & 1) << i for i, p in enumerate(masks)) for y in range(1536)]
    report = []
    for g, full, fixed in restrictions:
        if fixed.bit_count() == 64:
            continue
        status = Counter()
        partners = Counter()
        label7 = None
        for support in geometry(fixed, full, parts, lookup, shorts):
            polar = (g[3] & 5).bit_count() & 1 if full else None
            result = test_phase(support, orbit, polar)
            if result == 'residual' and full:
                result = test_mapping(support, g, columns, masks)
                if result.startswith('map_dimension'):
                    if label7 is None:
                        fixed7 = sum(1 << (9*x + 64*u) for x in range(8) for u in range(8) if g[x] == 7)
                        candidates7 = list(geometry(fixed7, full, parts, lookup, shorts))
                        label7 = [s7 for s7 in candidates7 if test_phase(s7, orbit, None, label7=True) == 'residual']
                    partners.update(test_mapping(support, g, columns, masks, s7)
                                    for s7 in label7 if not (s7 & support))
            status[result] += 1
        assert not status['residual']
        item = {'profile': ''.join(map(str, g)), 'constant_on_fixed_rows': full,
                'fixed_size': fixed.bit_count(), 'zero_fibre': dict(status)}
        if label7 is not None:
            item['label7_geometries'] = len(candidates7)
            item['label7_compatible'] = len(label7)
            item['two_fibre_tests'] = dict(partners)
        report.append(item)
        print(item, flush=True)
    assert len(report) == 15
    if args.output:
        args.output.write_text(json.dumps(report, indent=2) + '\n', encoding='utf-8')


if __name__ == '__main__':
    main()
