"""Check the phase-kernel polar and the permutation criterion on the fixed fibre."""
import json
from collections import Counter
from pathlib import Path

from count_near_antipodal import image_and_kernel
from higher_filter import xor_terms
from lower_dim_model import anf, build
from lower_dim_phase_prepare import truth_on_coordinates
from lower_dim_v3_q_classify import decompose, normal_form_q, prepare_space


def fixed_slopes(phase):
    return tuple(sum((((phase >> (9*x + 64*(1 << j))) ^ (phase >> (9*x))) & 1) << j
                     for j in range(3)) for x in range(8))


def verify_c_families(model, maps, lifts):
    space = prepare_space()
    w_index = {model.coordinates[i] >> 6: i for i in range(0, 4096, 64)}
    parity = sum((z.bit_count() & 1) << z for z in range(64))
    width = (1 << 64) - 1

    def derivative(truth, a, b):
        return (truth ^ (truth >> w_index[a]) ^ (truth >> w_index[b])
                ^ (truth >> w_index[a ^ b])) & width

    for q_code in (56, 315):
        particular = xor_terms(space.q_lifts, q_code)
        functions = [(xor_terms(maps, c), xor_terms(lifts, c))
                     for c in [particular] + space.g_directions]
        functions.extend((0, phase) for phase in model.phases)
        assert len(functions) == 46
        for mapping, phase in functions:
            truth = truth_on_coordinates(mapping, phase, 3)
            polar_bit = (derivative(truth, 1, 2) >> 7) & 1
            assert derivative(truth, 10, 5) == polar_bit * parity


def verify_constant_fixed_maps(maps, lifts):
    values = [decompose(mapping)[1] for mapping in maps]
    vertical = [fixed ^ sum(((fixed >> (24*x)) & 7) << (24*x + 3*u)
                            for x in range(8) for u in range(8)) for fixed in values]
    _, kernel = image_and_kernel(vertical)
    assert len(kernel) == 31
    for code in kernel:
        q, fixed, _ = decompose(xor_terms(maps, code))
        first = (q >> 21) & 7
        second = (q >> (3 * (64 + 7))) & 7
        assert second == first ^ (first >> 1) ^ ((first & 1) << 2)
        phase = xor_terms(lifts, code)
        polar_bit = (phase ^ (phase >> 64) ^ (phase >> 128) ^ (phase >> 192)) & 1
        g3 = (fixed >> 72) & 7
        assert polar_bit == ((g3 & 5).bit_count() & 1)


def main():
    model = build((9, 18, 36))
    maps, lifts = map(list, zip(*model.maps))
    width = (1 << 64) - 1
    slopes = {(0,) * 8}
    expected = tuple(sum((((r.bit_count() & 1) * ((r >> (2 - j)) & 1))) << z
                         for z in range(64) for r in [(z >> 3) ^ (z & 7)])
                     for j in range(3))
    polars = set()
    for phase in model.phases:
        terms = anf(phase, 9)
        assert not terms >> (64 * 7)
        polar = tuple(anf((terms >> (64 * mask)) & width, 6) for mask in (3, 5, 6))
        polars.add(polar)
        a = int(polar == expected)
        for r in range(8):
            for i in range(3):
                slope = sum((((phase >> ((9*x ^ r) + 64*(1 << i)))
                              ^ (phase >> (9*x ^ r))) & 1) << x for x in range(8))
                coefficients = anf(slope, 3)
                c = sum(((coefficients >> (7 ^ (1 << j))) & 1) << j for j in range(3))
                assert not coefficients >> 7
                assert c == a * (r ^ ((r.bit_count() & 1) << i))
        slopes |= {tuple(a ^ b for a, b in zip(s, fixed_slopes(phase))) for s in slopes}
    assert polars == {(0, 0, 0), expected}
    expected_slopes = {tuple((a * (x ^ 7)) ^ (b * (x ^ (7 * (x.bit_count() & 1))))
                             for x in range(8)) for a in (0, 1) for b in (0, 1)}
    assert slopes == expected_slopes
    verify_c_families(model, maps, lifts)
    verify_constant_fixed_maps(maps, lifts)

    forms = {normal_form_q('A', 0): 'A0', normal_form_q('C', 2): 'C2'}
    fixed_points = [9*x + 64*u for u in range(8) for x in range(8)]
    nonlinear_u = sum(1 << i for i in range(64) if (i >> 3).bit_count() >= 2)
    counts = Counter()
    for record in json.loads(Path('lower-dim-v3-symbolic.json').read_text())['details']:
        code = record['map_code']
        q, fixed, _ = decompose(xor_terms(maps, code))
        if fixed:
            continue
        lift = xor_terms(lifts, code)
        table = sum((lift >> y & 1) << i for i, y in enumerate(fixed_points))
        assert not (anf(table, 6) & nonlinear_u)
        origin = fixed_slopes(lift)
        permutations = sum(len({a ^ b for a, b in zip(origin, s)}) == 8 for s in slopes)
        bent = bool(record['phases_per_map'])
        assert not bent or permutations == 1
        counts[forms[q], bent, permutations] += record['orbit_size']
    assert counts == {('A0', True, 1): 144, ('A0', False, 0): 64,
                      ('C2', True, 1): 112, ('C2', False, 1): 272}
    print(dict(counts))


if __name__ == '__main__':
    main()
