"""Verify the exclusion of V1 class 129 without a support catalog."""
from collections import Counter
from pathlib import Path
import argparse
import sys


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("model_dir", type=Path)
    parser.add_argument("--hull-only", action="store_true",
                        help="Certify the dimension-19 envelope by linear support tests on quotient cells.")
    args = parser.parse_args()
    sys.path.insert(0, str(args.model_dir.resolve()))
    from count_near_antipodal import image_and_kernel
    from dim4_balance_charts import character_sums
    from dim4_support_decode import decode
    from dim4_support_moments import moment_equations
    from higher_filter import xor_terms
    from line_column_autocorrelation import affine_consequences
    from line_phase_algebra import locate, reduce_phase
    from lower_dim_phase_prepare import fibre_masks
    from lower_dim_moments import moment_masks

    model, basis, labels = decode(1)
    maps, lifts = map(list, zip(*model.maps))
    image = sorted(image_and_kernel(maps)[0], reverse=True)
    base = xor_terms(basis, 129 << 25)
    directions = basis[:25]
    code_base = 129 << 25
    code_directions = [1 << i for i in range(25)]
    s = [sum(1 << x for x in range(256) if x >> j & 1) for j in (6, 7)]

    def phase_subsets(fibres):
        pair = fibres[2] | fibres[13]
        return fibres[5], pair & s[0], pair & s[1]

    def defect(mapping):
        quotient = [x ^ (15 if x & 8 else 0) for x in labels(mapping)[:64]]
        return sum((quotient[z] ^ quotient[z ^ u]) << (3 * (64 * j + z))
                   for j, u in enumerate((27, 45)) for z in range(64))

    def quotient_word(mapping):
        return sum((value ^ (15 if value & 8 else 0)) << (3 * z)
                   for z, value in enumerate(labels(mapping)[:64]))

    while True:
        n = len(directions)
        shift, kernel, _ = affine_consequences(list(character_sums(base, directions)), n)
        assert shift is not None
        base ^= xor_terms(directions, shift)
        code_base ^= xor_terms(code_directions, shift)
        directions = [xor_terms(directions, v) for v in kernel]
        code_directions = [xor_terms(code_directions, v) for v in kernel]
        equations = moment_equations(base, directions, 1, 4)
        result = reduce_phase(base, directions, code_base, code_directions, equations, 5)
        assert result is not None
        base, directions, code_base, code_directions, _ = result
        rank = len(image_and_kernel([defect(v) for v in directions])[0])
        print("support reduction: dimension", len(directions), "defect rank", rank, flush=True)
        if n == len(directions):
            break
    support_monomials = [mask for _, mask in moment_masks(8, 2)]
    hull = [(2, 1), *((mask, 0) for mask in
                     (0x05504EC, 0x0D50800, 0x0379000, 0x01C2000, 0x1000000))]
    if args.hull_only:
        quotient_image, quotient_kernel = image_and_kernel([quotient_word(v) for v in directions])
        chart_directions = [v for _, v in quotient_image]
        assert (len(chart_directions), len(quotient_kernel)) == (15, 5)
        selector_codes = [xor_terms(code_directions, v) for v in quotient_kernel]
        assert all(not ((code & mask).bit_count() & 1)
                   for mask, _ in hull for code in selector_codes)
        a = [sum(1 << z for z in range(64) if ((z ^ (z >> 3)) & 7) in slices)
             for slices in ({2, 4}, {1, 4})]
        z_coordinates = [sum(1 << z for z in range(64) if z >> i & 1) for i in range(6)]
        chart_maps = [xor_terms(directions, v) for v in chart_directions]
        chart_codes = [xor_terms(code_directions, v) for v in chart_directions]
        counts = Counter()
        selector_maps = [xor_terms(directions, v) for v in quotient_kernel]
        diagonal = sum(1 << (9 * y) for y in range(8))
        passive_slices = sum(1 << z for z in range(64) if ((z ^ (z >> 3)) & 7) in (0, 3, 5, 6))
        swap = [(z >> 3) | ((z & 7) << 3) for z in range(64)]
        for parameter in range(1 << len(chart_directions)):
            code = code_base ^ xor_terms(chart_codes, parameter)
            if all((code & mask).bit_count() & 1 == value for mask, value in hull):
                continue
            mapping = base ^ xor_terms(chart_maps, parameter)
            fibres = fibre_masks(mapping, 256, 4)
            projected = [(fibres[t] | fibres[t ^ 15]) & ((1 << 64) - 1) for t in range(8)]
            if any(f.bit_count() != 8 for f in projected):
                continue
            if any((f & selector & coord).bit_count() & 1
                   for f in projected for selector in a
                   for coord in [(1 << 64) - 1, *z_coordinates]):
                continue
            counts["outside_hull_with_preliminary_support"] += 1
            z0 = projected[0]
            assert z0 & passive_slices == z0 and (z0 & diagonal).bit_count() == 2
            assert fibres[0] == sum((fibres[0] & ((1 << 64) - 1)) << (64 * i)
                                    for i in range(4))
            g = labels(mapping)[:64]
            other_points = [z for z in range(64) if (z0 & ~diagonal) >> z & 1]
            assert all(z0 >> swap[z] & 1 and g[z] == g[swap[z]] for z in other_points)
            assert sum(g[z] == 0 for z in range(64) if (z0 & diagonal) >> z & 1) == 1
            for delta in selector_maps:
                displacement = labels(delta)[:64]
                assert all(displacement[z] == displacement[swap[z]] for z in other_points)
                values = {displacement[z] for z in range(64) if (z0 & diagonal) >> z & 1}
                assert values in ({0}, {15})
        assert counts["outside_hull_with_preliminary_support"] == 272
        print("Envelope follows from the support equations:", dict(counts))
        print("All 272 cells fail the s1*s2 support moment on label zero.")
        return
    # Evaluate the remaining Boolean identities in parallel, with one bit
    # per assignment. No support list is used.
    width = 1 << len(directions)
    full = (1 << width) - 1
    monomials = {0: full}
    for i in range(len(directions)):
        half_period = 1 << i
        monomials[1 << i] = full ^ (full // ((1 << half_period) + 1))

    def truth(mask):
        if mask not in monomials:
            low = mask & -mask
            monomials[mask] = monomials[low] & truth(mask ^ low)
        return monomials[mask]

    def polynomial_truth(eq):
        value = 0
        for mask in eq:
            value ^= truth(mask)
        return value

    equations = moment_equations(base, directions, 1, 4)
    remaining = full
    for eq in sorted(equations, key=len):
        remaining &= full ^ polynomial_truth(eq)
    print("after Boolean support moments:", remaining.bit_count(), flush=True)

    # Count occurrences of each label with bit-sliced binary addition. Every
    # integer bit is an independent parameter assignment. Equalities with 16
    # can therefore be checked before reconstructing any individual map.
    coordinates = [[polynomial_truth({
        *(1 << i for i, direction in enumerate(directions) if direction >> (256 * k + x) & 1),
        *([0] if base >> (256 * k + x) & 1 else []),
    }) for k in range(4)] for x in range(256)]
    for label in range(16):
        counter = [0] * 9
        for point in coordinates:
            carry = remaining
            for k, values in enumerate(point):
                carry &= values if label >> k & 1 else full ^ values
            for k, digit in enumerate(counter):
                counter[k] = digit ^ carry
                carry &= digit
                if not carry:
                    break
        for k, digit in enumerate(counter):
            remaining &= digit if k == 4 else full ^ digit
    assert remaining.bit_count() == 11232
    data = remaining.to_bytes(width // 8, "little")
    compatible = 0
    outside = 0
    admissible = 0
    profiles = Counter()
    active_ranks = Counter()
    active = sum(1 << z for z in range(64) if ((z ^ (z >> 3)) & 7) in (1, 2, 4))
    for j, byte in enumerate(data):
        while byte:
            bit = byte & -byte
            byte ^= bit
            parameter = 8 * j + bit.bit_length() - 1
            mapping = base ^ xor_terms(directions, parameter)
            code = code_base ^ xor_terms(code_directions, parameter)
            fibres = fibre_masks(mapping, 256, 4)
            if all(f.bit_count() == 16 for f in fibres):
                assert not any((f & test).bit_count() & 1
                               for f in fibres for test in support_monomials)
                admissible += 1
                assert all((code & mask).bit_count() & 1 == value for mask, value in hull)
                assert not ((fibres[5] | fibres[10]) & active)
                # Check phase blindness before discarding any admissible map.
                # The three right-hand sides are zero for balanced fibres.
                subsets = phase_subsets(fibres)
                assert all(not ((mask & phase).bit_count() & 1)
                           for mask in subsets for phase in model.phases)
                lift = xor_terms(lifts, locate(image, mapping))
                moment = tuple((mask & lift).bit_count() & 1 for mask in subsets)
                quotient = [v ^ (15 if v & 8 else 0) for v in labels(mapping)[:64]]
                assert moment[0] == (len({quotient[y | ((y ^ 7) << 3)] for y in range(8)}) > 1)
                if not moment[0]:
                    ranks = tuple(len({quotient[y | ((y ^ d) << 3)] for y in range(8)}) - 1
                                  for d in (1, 2, 4))
                    active_ranks[ranks, moment[1:]] += 1
                if any(moment):
                    continue
                compatible += 1
                outside += bool(defect(mapping))
                z1 = fibres[1] & ((1 << 64) - 1)
                assert fibres[1] == sum(z1 << (64 * i) for i in range(4))
                profile = sorted((z ^ (z >> 3)) & 7 for z in range(64) if z1 >> z & 1)
                if profile == [3, 3, 5, 5]:
                    phase_subset = fibres[1] & s[1]
                    profiles["2+2"] += 1
                else:
                    assert len(profile) == 4 and len(set(profile)) == 1 and profile[0] in (3, 5, 6)
                    assert all(quotient[z] == quotient[z ^ u] for z in range(64) for u in (9, 18))
                    phase_subset = fibres[1] & s[0]
                    profiles["4"] += 1
                assert phase_subset.bit_count() == 8
                assert (phase_subset & lift).bit_count() & 1
                assert not any((phase_subset & h).bit_count() & 1 for h in model.phases)
    assert admissible == 11232, admissible
    assert compatible == 480 and outside == 0, (compatible, outside)
    print("admissible:", admissible, "all three moments zero:", compatible, "outside A2:", outside)
    assert profiles == {"4": 288, "2+2": 192}
    print("remaining maps excluded by the passive fibre:", dict(profiles))
    assert active_ranks == {((0, 0, 0), (0, 0)): 480,
                            **{((1, 1, 1), pair): 768 for pair in ((0, 1), (1, 0), (1, 1))}}
    print("active rank patterns after the fibre-5 test:", dict(active_ranks))


if __name__ == "__main__":
    main()
