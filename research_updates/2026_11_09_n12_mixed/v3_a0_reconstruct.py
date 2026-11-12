"""Reconstruct the A0 map orbits and count their phases from the model bases."""
import argparse
from collections import Counter
import json
from pathlib import Path
import struct
from tempfile import TemporaryDirectory

from count_near_antipodal import all_points, image_and_kernel
from higher_filter import solve, xor_terms
from line_phase_algebra import reduce_phase
from lower_dim_model import active_indices, anf, build
from lower_dim_phase_prepare import prepare
from lower_dim_v3_q_classify import classify_case, decompose, prepare_space
from lower_dim_v3_symbolic import (
    affine_at, count, equations_for_task, orbit_partition, read_tasks, substitute,
)
from v3_a0_orbit_moments import consistency_equations
from v3_u_polar import fixed_slopes


def pack_slopes(phase):
    return sum(v << (3*x) for x, v in enumerate(fixed_slopes(phase)))


def balance_spectrum(base, directions, points, label):
    table = Counter()
    for z in points:
        column = sum(((g[z] & label).bit_count() & 1) << i for i, g in enumerate(directions))
        table[column] += 1 - 2 * ((base[z] & label).bit_count() & 1)
    return {frequency: value for frequency, value in table.items() if value}


def on_hyperplane(spectrum, mask, rhs):
    pivot = 1 << (mask.bit_length() - 1)
    restricted = Counter()
    for frequency, coefficient in spectrum.items():
        if frequency & pivot:
            frequency ^= mask
            coefficient *= (-1)**rhs
        restricted[frequency] += coefficient
    return {frequency: value for frequency, value in restricted.items() if value}


def balanced_flats(g0, gs, balance):
    spectra = {}
    for label, points, target in balance:
        assert len(points) - 2*target == -4
        spectra[label] = balance_spectrum(g0, gs, points, label)
    assert spectra[1] == spectra[2] == spectra[4]
    assert spectra[3] == spectra[5] == spectra[6]
    assert spectra[7] in ({0: -16, 122: 12}, {0: -16, 122: -12})
    rhs = int(spectra[7][122] < 0)
    hyperplane = (122, rhs)
    reduced = on_hyperplane(spectra[1], *hyperplane)
    assert reduced == on_hyperplane(spectra[3], *hyperplane)
    if len(gs) == 8:
        assert reduced == {7: -2, 10: -4, 13: 2, 181: 2, 191: -2}
        # With a=chi_7, b=chi_10, c=chi_181 the sum is
        # -2a-4b+2ab+2c-2bc. It is -4 iff b=1 or (b,a,c)=(-1,1,-1).
        return [(hyperplane, (10, 0)), (hyperplane, (10, 1), (7, 0), (181, 1))]
    assert len(gs) == 7 and reduced in ({7: -4}, {13: -4})
    return [(hyperplane, (next(iter(reduced)), 0))]


def chart_maps(map_root, map_directions, equations, balance, space):
    dimension = len(map_directions)
    g0 = decompose(xor_terms(space.tables, map_root))[2]
    gs = [decompose(xor_terms(space.tables, d))[2] for d in map_directions]
    maps = set()
    flat_dimensions = []
    for linear_system in balanced_flats(g0, gs, balance):
        root, directions, rank = solve(linear_system, dimension)
        assert root is not None and rank == len(linear_system)
        variables = [affine_at(i, root, directions) for i in range(dimension)]
        assert not substitute(equations, variables)
        words = all_points(directions)
        found = {map_root ^ xor_terms(map_directions, root ^ word) for word in words}
        assert len(found) == 1 << len(directions) and not maps.intersection(found)
        maps.update(found)
        flat_dimensions.append(len(directions))
    return maps, flat_dimensions


def reconstruct_maps(model, space):
    status, result = classify_case(space, 351)
    assert status == 'admitted_Q'
    (root, directions, equations), balance = result
    lifts = [h for _, h in model.maps]
    h0 = xor_terms(lifts, root)
    hs = [xor_terms(lifts, d) for d in directions]
    points = [9*x + 64*u for u in range(8) for x in range(8)]
    forbidden = sum(1 << i for i in range(64) if (i >> 3).bit_count() >= 2)
    for h in [h0] + hs + model.phases:
        assert not anf(sum(((h >> y) & 1) << i for i, y in enumerate(points)), 6) & forbidden
    g0 = decompose(xor_terms(space.tables, root))[2]
    gs = [decompose(xor_terms(space.tables, d))[2] for d in directions]
    local = consistency_equations(g0, gs)
    assert len(local) == 2 and all(m.bit_count() == 1 for q in local for m in q)
    fixed = pack_slopes(h0)
    shifts = list(map(pack_slopes, hs))
    phase_slopes = list(map(pack_slopes, model.phases))
    kernel, _ = image_and_kernel(phase_slopes)
    span, _ = image_and_kernel(shifts + phase_slopes)
    assert len(kernel) == 2 and len(span) == 4
    def quotient(value):
        for vector, _ in sorted(kernel, reverse=True):
            if (value >> (vector.bit_length()-1)) & 1:
                value ^= vector
        return value
    map_slopes = [quotient(v) for v in shifts]
    records = []
    maps = set()
    for variation in sorted(all_points([v for v, _ in span])):
        permutation = tuple(((fixed ^ variation) >> (3*x)) & 7 for x in range(8))
        if len(set(permutation)) != 8:
            continue
        slope = [affine_at(i, quotient(variation), map_slopes) for i in range(24)]
        dimension = len(directions)
        reduced = reduce_phase(0, [1 << i for i in range(dimension)], 0, [0]*dimension,
                               slope + local + equations, 4)
        assert reduced is not None
        origin, variations, _, _, residual = reduced
        chart_root = root ^ xor_terms(directions, origin)
        chart_directions = [xor_terms(directions, v) for v in variations]
        found, flat_dimensions = chart_maps(chart_root, chart_directions, residual, balance, space)
        assert not maps.intersection(found)
        maps.update(found)
        records.append({'permutation': permutation, 'dimension': len(variations),
                        'flat_dimensions': flat_dimensions, 'balanced': len(found)})
    assert len(records) == 3 and len(maps) == 144
    return maps, records, [sorted(q) for q in local]


def count_phases(maps):
    orbits, _ = orbit_partition(maps)
    assert len(orbits) == 5
    result = []
    with TemporaryDirectory() as temp:
        source = Path(temp) / 'maps.bin'
        source.write_bytes(b''.join(struct.pack('<Q', c) for c in orbits))
        tasks = Path(temp) / 'tasks.bin'
        prepare(1, source, tasks, 0, None)
        for code, factor, properties, root, signature, directions, moments in read_tasks(tasks):
            system = equations_for_task(properties, root, signature, directions, moments)
            n, dim, residual, _ = count(len(directions), system, Counter())
            assert n > 0
            result.append({'code': code, 'orbit_size': len(orbits[code]), 'phases_per_map': n << factor,
                           'dimension': dim, 'quadratics': len(residual)})
    assert len(result) == 5
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    maps, charts, equations = reconstruct_maps(build((9, 18, 36)), prepare_space())
    phases = count_phases(maps)
    total = sum(row['orbit_size'] * row['phases_per_map'] for row in phases)
    assert total == 2883584
    report = {'maps': len(maps), 'functions': total, 'local_equations': equations,
              'charts': charts, 'orbits': phases, 'map_codes': sorted(maps)}
    args.output.write_text(json.dumps(report, indent=2) + '\n', encoding='utf-8')
    print({k: v for k, v in report.items() if k != 'map_codes'})


if __name__ == '__main__':
    main()
