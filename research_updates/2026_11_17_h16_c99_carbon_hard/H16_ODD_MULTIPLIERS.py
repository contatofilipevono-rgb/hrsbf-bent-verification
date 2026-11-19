"""Exact induced action of odd coordinate multipliers on B0_00 eta labels."""

import json


def _indices(mask):
    while mask:
        bit = mask & -mask
        mask ^= bit
        yield bit.bit_length() - 1


def _xor_pullback(mask, forms):
    result = 0
    for i in _indices(mask):
        result ^= forms[i]
    return result


def odd_multiplier_maps(orbits, free, origin, basis, eta_forms, root_pivots, insert):
    assert origin == 0
    orbit_index = {monomial: j for j, orbit in enumerate(orbits) for monomial in orbit}
    coefficient_forms = [
        sum(1 << j for j, direction in enumerate(basis) if direction >> i & 1)
        for i in range(len(orbits))
    ]
    states = []
    for eta in range(1 << len(eta_forms)):
        state = root_pivots.copy()
        assert all(insert(state, form, eta >> i & 1) for i, form in enumerate(eta_forms))
        states.append(state)

    maps = []
    for k in range(1, 16, 2):
        target_orbits = []
        for orbit in orbits:
            image_indices = {
                orbit_index[sum(1 << ((k * i) % 16) for i in _indices(m))]
                for m in orbit
            }
            assert len(image_indices) == 1
            target_orbits.append(image_indices.pop())
        assert sorted(target_orbits) == list(range(len(orbits)))
        inverse = [target_orbits.index(j) for j in range(len(orbits))]
        mapped_free = [coefficient_forms[inverse[i]] for i in free]
        # Test the full affine chart, including the eliminated c0 relation.
        for target, form in enumerate(coefficient_forms):
            assert _xor_pullback(form, mapped_free) == coefficient_forms[inverse[target]]

        mapped_eta = [_xor_pullback(m, mapped_free) for m in eta_forms]
        outcomes = []
        for state in states:
            code = 0
            for i, pullback in enumerate(mapped_eta):
                reduced, phase = pullback, 0
                for pivot, (row, rhs) in state.items():
                    if reduced >> pivot & 1:
                        reduced ^= row
                        phase ^= rhs
                if reduced:
                    break
                code |= phase << i
            else:
                outcomes.append(code)
                continue
            outcomes.append(None)
        maps.append({"k": k, "orbit_permutation": target_orbits,
                     "pullbacks": mapped_eta, "eta_images": outcomes})
        print("STEP34_MULTIPLIER " + json.dumps({"k": k, "eta_images": outcomes}), flush=True)
    return maps
