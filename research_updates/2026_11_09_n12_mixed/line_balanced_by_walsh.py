"""Construct balanced antipodal-line maps by Walsh transforms in seven parameters."""
import argparse
import struct
from pathlib import Path

from count_near_antipodal import all_points, image_and_kernel
from higher_filter import xor_terms
from lower_dim_model import build
from lower_dim_orbits import apply, block_lookup, code_actions

Z_MASK = (1 << 64) - 1


def w_coefficients(mapping):
    return tuple(((mapping >> (64 << j)) ^ mapping) & Z_MASK for j in range(5))


def signature(mapping):
    return sum(table << (64 * j) for j, table in enumerate(w_coefficients(mapping)))


def coordinate_reducer(columns):
    image, kernel = image_and_kernel(columns)
    ordered = sorted(image, reverse=True)

    def encode(value):
        code = 0
        for pivot, witness in ordered:
            if value >> (pivot.bit_length() - 1) & 1:
                value ^= pivot
                code ^= witness
        assert not value
        return code

    return encode, kernel


def transforms(values):
    count = len(values)
    stride = 1
    while stride < count:
        for i in range(0, count, 2 * stride):
            for j in range(i, i + stride):
                a, b = values[j], values[j + stride]
                values[j], values[j + stride] = a + b, a - b
        stride *= 2
    return values


def balance(model):
    maps = [p for p, _ in model.maps]
    for p in maps:
        coeff = w_coefficients(p)
        assert all(((p >> (64*w)) & Z_MASK) == (p & Z_MASK) ^ xor_terms(coeff, w)
                   for w in range(32))
    q_columns = [signature(p) for p in maps]
    q_basis, g_basis = image_and_kernel(q_columns)
    q_values = [q for q, _ in q_basis]
    lifts = [v for _, v in q_basis]
    assert len(lifts) == 11 and len(g_basis) == 7
    coord, _ = coordinate_reducer(q_values)
    actions = [(name, block_lookup(cols)) for name, cols in code_actions(model)]
    q_actions = []
    for name, action in actions:
        assert all(not xor_terms(q_columns, apply(action, v)) for v in g_basis)
        induced = [coord(xor_terms(q_columns, apply(action, v))) for v in lifts]
        q_actions.append((name, block_lookup(induced)))
    kernels = [xor_terms(maps, v) & Z_MASK for v in g_basis]
    evaluations = [sum(((table >> z) & 1) << j for j, table in enumerate(kernels))
                   for z in range(64)]
    unseen = set(range(1 << len(lifts)))
    balanced = set()
    orbit_count = 0
    while unseen:
        q_root = min(unseen)
        root = xor_terms(lifts, q_root)
        mapping = xor_terms(maps, root)
        vanishing = Z_MASK
        for table in w_coefficients(mapping):
            vanishing &= Z_MASK ^ table
        values = [0] * (1 << len(g_basis))
        for z, index in enumerate(evaluations):
            if vanishing >> z & 1:
                values[index] += 1 - 2 * ((mapping >> z) & 1)
        roots = [root ^ xor_terms(g_basis, code) for code, value in enumerate(transforms(values)) if value == 0]
        # Transport the whole balanced fibre of one Q to the other Q in its orbit.
        queue = [(q_root, roots)]
        unseen.remove(q_root)
        while queue:
            q, members = queue.pop()
            assert not (balanced & set(members))
            balanced.update(members)
            for (_, action), (_, q_action) in zip(actions, q_actions):
                target = apply(q_action, q)
                if target in unseen:
                    unseen.remove(target)
                    queue.append((target, [apply(action, v) for v in members]))
        orbit_count += 1
    assert len(balanced) == 30781
    return sorted(balanced), orbit_count


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("output", type=Path)
    parser.add_argument("--compare", type=Path)
    args = parser.parse_args()
    codes, orbits = balance(build((63,)))
    if args.compare:
        previous = {v for (v,) in struct.iter_unpack("<Q", args.compare.read_bytes())}
        assert set(codes) == previous
    args.output.write_bytes(b"".join(struct.pack("<Q", code) for code in codes))
    print({"balanced_maps":len(codes), "q_orbits":orbits, "q_space_dimension":11, "g_space_dimension":7})


if __name__ == "__main__":
    main()
