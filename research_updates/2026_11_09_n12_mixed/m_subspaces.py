"""Decide six-dimensional M-subspace existence for explicit RS bent witnesses."""
import argparse
import json
from collections import Counter
from pathlib import Path

from higher_filter import N, SIZE, evaluate_orbit, orbits, shift, xor_terms
from higher_project import LOW, TOP, UPPER, signs_to_walsh


def translations(table):
    values = [table]
    for j in range(N):
        step = 1 << j
        low = ((1 << SIZE) - 1) // ((1 << step) + 1)
        values += [((v & low) << step) | ((v >> step) & low) for v in values]
    return values


def second_derivative_kernels(table):
    translates = translations(table)
    rows = {}
    for a, orbit in orbits(N):
        if not a:
            continue
        derivative = table ^ translates[a]
        space = [b for b, v in enumerate(translates) if v ^ translates[a ^ b] == derivative]
        assert a in space and len(space).bit_count() == 1
        for k in range(len(orbit)):
            rows[shift(a, k)] = sum(1 << shift(b, k) for b in space)
    assert len(rows) == SIZE - 1
    return rows


def find_m_subspace(kernels):
    eligible = 1 | sum(1 << a for a, kernel in kernels.items() if kernel.bit_count() >= 64)
    visited = [0] * 7

    def search(span, choices, basis):
        d = len(basis)
        visited[d] += 1
        if d == 6:
            return basis
        while choices.bit_count() >= 6 - d:
            bit = choices & -choices
            choices ^= bit
            a = bit.bit_length() - 1
            coset = [a ^ b for b in span]
            if min(coset) != a or any(not eligible >> v & 1 for v in coset):
                continue
            result = search(span + coset, choices & kernels[a], basis + [a])
            if result is not None:
                return result
        return None

    return search([0], eligible ^ 1, []), visited


def inspect(table):
    spectrum = signs_to_walsh(table)
    assert all(abs(v) == 64 for v in spectrum)
    assert all((table >> x ^ table >> shift(x, 1)) & 1 == 0 for x in range(SIZE))
    kernels = second_derivative_kernels(table)
    basis, visited = find_m_subspace(kernels)
    if basis is not None:
        for a in basis:
            for b in basis:
                assert all((table >> x ^ table >> (x ^ a) ^ table >> (x ^ b) ^
                            table >> (x ^ a ^ b)) & 1 == 0 for x in range(SIZE))
    return {'kernel_dimensions': dict(sorted(Counter(k.bit_count().bit_length() - 1
                                                     for k in kernels.values()).items())),
            'm_basis': basis, 'visited_by_dimension': visited}


def main():
    p = argparse.ArgumentParser()
    p.add_argument('input', type=Path, help='TSV of name, high mask, quartic mask, lower mask')
    p.add_argument('output', type=Path)
    a = p.parse_args()
    columns = [[evaluate_orbit(o) for _, o in basis] for basis in (UPPER, TOP, LOW)]
    reports = {}
    for line in a.input.read_text().splitlines():
        name, *fields = line.split()
        codes = [int(v, 0) for v in fields]
        high, top, low = (xor_terms(b, c) for b, c in zip(columns, codes, strict=True))
        reports[name] = {'masks': codes, **inspect(high ^ top ^ low)}
        print(name, reports[name], flush=True)
    a.output.write_text(json.dumps(reports, indent=2) + '\n')


if __name__ == '__main__':
    main()
