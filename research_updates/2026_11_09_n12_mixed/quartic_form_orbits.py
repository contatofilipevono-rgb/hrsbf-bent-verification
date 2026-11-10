"""Check the orbit reduction and the four-column obstruction for mask 6."""
from collections import Counter
from functools import reduce
from itertools import combinations, permutations
from operator import xor

from alternating_column_norms import (beta_columns, choices_for, compatible_sign_cycle,
                                      direct_column_test, orbits, shift)


def forms():
    basis = [o for _, o in orbits(6, 3)]
    return [frozenset().union(*(o for j, o in enumerate(basis) if k >> j & 1))
            for k in range(16)]


def pullback_table(alternating_forms):
    triples = tuple(combinations(range(6), 3))
    columns = [shift(11, -i % 6, 6) for i in range(6)]
    all_permutations = tuple(permutations(range(3)))
    result = []
    for tau in alternating_forms:
        output = set()
        inputs = [J for J in triples if sum(1 << j for j in J) in tau]
        for I in triples:
            coefficient = sum(
                all(columns[I[j]] >> J[p[j]] & 1 for j in range(3))
                for J in inputs for p in all_permutations
            ) % 2
            if coefficient:
                output.add(sum(1 << i for i in I))
        result.append(alternating_forms.index(output))
    return result


def four_column_profiles(tau, chosen):
    freq = [(b, len(o)) for b, o in orbits(6)]
    indices = [i for i, (b, _) in enumerate(freq) if b in chosen]
    assert [freq[i][0] for i in indices] == list(chosen)
    rows = [sorted({(tuple(v[j] for j in indices), tuple(p[j] for j in indices))
                    for v, _, p in options}) for _, options in choices_for(tau, True)]
    rows.sort(key=lambda opts: (len(opts), -max(sum(v) for v, _ in opts)))
    upper = [(0,) * len(indices)]
    lower = upper.copy()
    for options in reversed(rows):
        energies = tuple(zip(*(v for v, _ in options)))
        upper.append(tuple(x + max(e) for x, e in zip(upper[-1], energies)))
        lower.append(tuple(x + min(e) for x, e in zip(lower[-1], energies)))
    upper.reverse()
    lower.reverse()

    profiles = set()

    def visit(i, budget, support):
        if any(x < lo or x > hi for x, lo, hi in zip(budget, lower[i], upper[i])):
            return
        if i == len(rows):
            assert not any(budget)
            profiles.add(support)
            return
        for energies, points in rows[i]:
            visit(i + 1, tuple(x - y for x, y in zip(budget, energies)),
                  tuple(x | y for x, y in zip(support, points)))

    visit(0, (16,) * len(indices), (0,) * len(indices))
    return [freq[i] for i in indices], profiles


def check_form_six_line(tau):
    assert tau == {((1 << i) | (1 << (i + 3)) | (1 << k))
                   for i in range(3) for k in range(6) if k not in (i, i + 3)}
    for z in range(64):
        moved = shift(z, 3, 6)
        columns = [
            moved ^ (63 if moved >> j & 1 else 0)
            ^ (shift(1 << j, 3, 6) if z.bit_count() & 1 else 0)
            for j in range(6)
        ]
        assert beta_columns(tau, z) == columns
    z = 27
    polar = beta_columns(tau, z)
    terms = [((1 << i) | (1 << j)) for i, j in combinations(range(6), 2) if polar[i] >> j & 1]
    quadratic = [sum(w & m == m for m in terms) & 1 for w in range(64)]
    good = []
    for p in range(64):
        row = [q ^ ((p & w).bit_count() & 1) for w, q in enumerate(quadratic)]
        if any(row[w] != row[shift(w, 3, 6) ^ (z >> 3)] for w in range(64)):
            continue
        support = tuple(b for b in range(64) if sum(
            1 - 2 * (v ^ ((w & b).bit_count() & 1)) for w, v in enumerate(row)))
        assert support == (0, 27, 36, 63)
        good.append(p)
    assert good == [0, 27, 36, 63]
    relaxed = (3, 24, 39, 60)
    assert all(compatible_sign_cycle(z, b) for b in relaxed)
    assert all(not ((z >> 3 & b >> 3).bit_count() & 1) for b in relaxed)
    print("Mask 6: all four invariant linear masks give support (0, 27, 36, 63)")


def main():
    all_forms = forms()
    action = pullback_table(all_forms)
    assert action == [0, 5, 4, 1, 11, 14, 15, 10, 12, 9, 8, 13, 7, 2, 3, 6]
    print("Pullback on the 15 masks:", action[1:])

    tau = all_forms[2]
    rank_two = []
    for z, _ in orbits(6):
        im = {0}
        for c in beta_columns(tau, z):
            im |= {a ^ c for a in im}
        assert len(im) in (1, 4, 16)
        if len(im) == 4:
            rank_two.append(z)
        if len(im) == 1:
            assert z == 0
    assert rank_two == [9, 27, 63]

    tau = all_forms[6]
    check_form_six_line(tau)
    wanted = [b for b, _ in orbits(6)]
    i0, i3, i27, i63 = [wanted.index(b) for b in (0, 3, 27, 63)]
    empty = ()
    expected = {
        3: {((3,), (3, 24)), ((12,), empty), ((48,), empty)},
        5: {(empty, (10, 17)), ((20, 40), empty)},
        9: {((36,), empty)},
        15: {((60,), (39, 60)), ((15,), empty), ((51,), empty)},
        23: {(empty, (46, 53)), ((23, 43), empty)},
        27: {((27,), empty)},
    }
    for z, options in choices_for(tau, True):
        if z in (0, 63):
            continue
        pairs = {tuple(tuple(v for v in range(64) if p[j] >> v & 1) for j in (i3, i27))
                 for energy, _, p in options if not (energy[i0] or energy[i63])}
        assert pairs - {(empty, empty)} == expected.get(z, set())
    print("Mask 6: the relaxed two-column contribution table agrees")

    freqs, profiles = four_column_profiles(tau, (0, 3, 27, 63))
    assert len(profiles) == 31
    check = direct_column_test(tau)
    feasible_geometry = []
    bad_columns = Counter()
    for support in profiles:
        z = [tuple(i for i in range(64) if m >> i & 1) for m in support]
        assert z[0] == (63,) and z[3] == (0,)
        assert len(z[1]) == len(z[2]) == 4
        if not reduce(xor, z[1], 0) and not reduce(xor, z[2], 0):
            feasible_geometry.append((z[1], z[2]))
        bad = tuple(b for (b, length), p in zip(freqs, support) if not check(b, length, p))
        bad_columns[bad] += 1
    assert bad_columns == {(3,): 24, (27,): 3, (3, 27): 4}
    print("Mask 6: 31 norm profiles. Direct Walsh failures:", dict(bad_columns))
    print("The three pairs of affine planes:", sorted(feasible_geometry))


if __name__ == "__main__":
    main()
