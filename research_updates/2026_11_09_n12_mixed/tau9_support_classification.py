"""Cross-check the three-bit support classification for the decomposable form."""
import argparse
import json
from collections import Counter
from itertools import product
from pathlib import Path

from alternating_column_norms import (choices_for, column_test, rank_two_joint_test,
                                      search, shift, xor_terms)
from antipodal_residual_certificates import TAU, audit_support, compressed_support, transport


P_ON_D = ("76543210", "72431560", "74132560")
WEIGHT_ONE = (1, 2, 4)
WEIGHT_TWO = (3, 5, 6)


def dot(a, b):
    return (a & b).bit_count() & 1


def cross(a, b):
    x, y, z = ((a >> i) & 1 for i in range(3))
    u, v, w = ((b >> i) & 1 for i in range(3))
    return (y * w ^ z * v) | ((z * u ^ x * w) << 1) | ((x * v ^ y * u) << 2)


def class_values(v, a_labels):
    start_v, start_labels = v, a_labels
    for _ in range(3):
        yield v, "".join(map(str, a_labels))
        moved = [0] * 8
        for a, value in enumerate(a_labels):
            moved[shift(a, 1, 3) ^ (v >> 2)] = shift(value, 1, 3)
        v, a_labels = shift(v, 1, 3), tuple(moved)
    assert (v, a_labels) == (start_v, start_labels)


def split(first, second, normal, flip):
    return tuple(second if dot(a, normal) ^ flip else first for a in range(8))


def psi_table(a, b):
    rows = {0: "00000000", 7: "77777777"}
    rows.update(class_values(*a))
    rows.update(class_values(*b))
    assert len(rows) == 8
    return tuple(rows[v] for v in range(8))


def generate():
    by_type = {0: set(), 3: set(), 6: set()}
    labels = WEIGHT_ONE + WEIGHT_TWO
    for f in labels:
        if not dot(1, f):
            continue
        other = WEIGHT_TWO if f in WEIGHT_ONE else WEIGHT_ONE
        full = (1, (f,) * 8)
        for g in other:
            if dot(3, g):
                by_type[0].add(psi_table(full, (3, (g,) * 8)))
            first, second = (x for x in other if x != g)
            for flip in (0, 1):
                by_type[3].add(psi_table(full, (3, split(first, second, 7, flip))))
    for v, f, g, flip, other_flip in product(WEIGHT_TWO, WEIGHT_ONE, WEIGHT_TWO, (0, 1), (0, 1)):
        normal = cross(1, v)
        if normal not in (f, g):
            by_type[6].add(psi_table((1, split(f, g, normal, flip)),
                                     (v, split(f, g, normal, other_flip))))
    assert {k: len(v) for k, v in by_type.items()} == {0: 6, 3: 18, 6: 72}
    return by_type


def paired_sum(p_d, psi):
    value = 4
    for a in range(4):
        value ^= int(p_d[a])
    for v in (1, 2, 3):
        for a in range(4):
            if a < a ^ v:
                value ^= int(psi[v][a])
    return value


def support_table(p_d, psi):
    supports = []
    for z in range(64):
        a = z & 7
        v = a ^ (z >> 3)
        if v == 0:
            p = int(p_d[a])
            supports.append((p | p << 3,))
        else:
            f = int(psi[v][a])
            supports.append(tuple(b for b in range(64)
                                  if ((b & 7) ^ (b >> 3)) == f and not dot(b, z)))
    return tuple(supports)


def lifted_action(g, reflected):
    columns = [shift(g, -j % 6 if reflected else j, 6) for j in range(6)]
    a = [xor_terms(columns, z) for z in range(64)]
    at = [sum(dot(b, col) << j for j, col in enumerate(columns)) for b in range(64)]
    assert len(set(a)) == 64
    return a, at


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("certificates", type=Path)
    parser.add_argument("--check-enumeration", action="store_true")
    args = parser.parse_args()
    by_type = generate()
    allowed = {(p, psi) for p in P_ON_D for group in by_type.values() for psi in group}
    assert len(allowed) == 288
    survivors = {(p, psi) for p, psi in allowed if not paired_sum(p, psi)}
    counts = Counter(k for _, psi in survivors for k, group in by_type.items() if psi in group)
    assert counts == {3: 12, 6: 8}
    print("Three-bit classification", {k: len(v) for k, v in by_type.items()}, dict(counts))

    covered = set()
    reps = json.loads(args.certificates.read_text())["residual_orbits"]
    for row in reps:
        p, psi = row["p_on_D"], tuple(row["psi_by_v"])
        base = support_table(p, psi)
        equations, coefficients, *_ = audit_support(base)
        by_label = {label: equation for equation, label in equations.items()}
        target = 1
        for mask in row["coefficients_whose_xor_is_one"]:
            target ^= coefficients[mask]
        for label in row["sign_equations_to_xor"]:
            target ^= by_label[tuple(label)]
        assert target == 0
        generators = (1, 19, 37, 55) if p == P_ON_D[0] else (1,)
        images = {(q, tuple(psi)) for g, reflect in product(generators, (False, True))
                  for q, psi in [compressed_support(transport(base, *lifted_action(g, reflect)))]}
        assert len(images) == row["orbit_size"] and not covered & images
        covered |= images
    assert covered == survivors
    print("Seven explicit families cover all 20 survivors and their sign certificates verify")
    if args.check_enumeration:
        found = set()

        def collect(support):
            p, psi = compressed_support(support)
            found.add((p, tuple(psi)))

        joint, _, _ = rank_two_joint_test(TAU, on_joint_support=collect)
        assert search(choices_for(TAU, keep_columns=True), True, column_test(TAU), joint)[0] is None
        assert found == allowed
        print("The classification and independent support enumeration agree on all 288 supports")


if __name__ == "__main__":
    main()
