"""Check the orbit reduction and the four-column obstruction for mask 6."""
from collections import Counter
from functools import reduce
from itertools import combinations, permutations
from operator import xor

from alternating_column_norms import beta_columns, choices_for, direct_column_test, orbits, shift


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
