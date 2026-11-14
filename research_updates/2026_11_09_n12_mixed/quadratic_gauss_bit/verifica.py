"""Independent exact checks of the next bit of a quadratic Gauss sum.

No numerical interpolation or research-model imports are used to build the
predicted polynomials.  All arithmetic is integral or over F_2.
"""

import itertools
import json
from pathlib import Path


def parity(x):
    return x.bit_count() & 1


def qvalue(pairs, v):
    return sum(((v >> i) & (v >> j) & 1) for i, j in pairs) & 1


def rank_and_radical(n, pairs):
    rows = [0] * n
    for i, j in pairs:
        rows[i] ^= 1 << j
        rows[j] ^= 1 << i
    image = {sum(parity(row & x) << i for i, row in enumerate(rows))
             for x in range(1 << n)}
    radical = [x for x in range(1 << n) if not any(parity(row & x) for row in rows)]
    return len(image).bit_length() - 1, rows, radical


def radical_basis(radical):
    basis = []
    span = {0}
    for x in radical:
        if x not in span:
            basis.append(x)
            span |= {y ^ x for y in list(span)}
    return basis


def predicted_local(n, pairs):
    """Return p and all Q(lambda,h), using rank/radical formulae."""
    rank, rows, radical = rank_and_radical(n, pairs)
    k = n // 2
    p = int(rank == n)
    if rank == n:
        inverse = {sum(parity(row & x) << i for i, row in enumerate(rows)): x
                   for x in range(1 << n)}
        sign_sum = sum((-1) ** qvalue(pairs, x) for x in range(1 << n))
        assert abs(sign_sum) == 1 << k
        arf = int(sign_sum < 0)
        values = [arf ^ qvalue(pairs, inverse[lam]) ^ h
                  for h in range(2) for lam in range(1 << n)]
    elif rank == n - 2:
        r1, r2 = radical_basis(radical)
        values = [(1 ^ qvalue(pairs, r1) ^ parity(lam & r1)) &
                  (1 ^ qvalue(pairs, r2) ^ parity(lam & r2))
                  for h in range(2) for lam in range(1 << n)]
    else:
        values = [0] * (1 << (n + 1))
    return p, values, rank


def anf(values):
    coefficients = list(values)
    for i in range(len(values).bit_length() - 1):
        for mask in range(len(values)):
            if mask >> i & 1:
                coefficients[mask] ^= coefficients[mask ^ (1 << i)]
    return coefficients


def exact_local(n, pairs):
    result = []
    for h in range(2):
        for lam in range(1 << n):
            total = sum((-1) ** (qvalue(pairs, w) ^ parity(lam & w) ^ h)
                        for w in range(1 << n))
            assert total % (1 << (n // 2)) == 0
            result.append(total // (1 << (n // 2)))
    return result


def coefficient_formula(n, pairs, offset, columns):
    """Build Q after an affine substitution, without point interpolation."""
    rank, rows, radical = rank_and_radical(n, pairs)
    dimension = len(columns)
    out = [0] * (1 << dimension)
    lambda_mask = (1 << n) - 1
    if rank == n:
        inverse = {sum(parity(row & x) << i for i, row in enumerate(rows)): x
                   for x in range(1 << n)}
        t0 = inverse[offset & lambda_mask]
        directions = [inverse[column & lambda_mask] for column in columns]
        def polar(a, b):
            return parity(a & sum(parity(row & b) << i for i, row in enumerate(rows)))
        arf = int(sum((-1) ** qvalue(pairs, x) for x in range(1 << n)) < 0)
        out[0] = arf ^ (offset >> n) ^ qvalue(pairs, t0)
        for i, direction in enumerate(directions):
            out[1 << i] = (columns[i] >> n) ^ qvalue(pairs, direction) ^ polar(t0, direction)
        for i, j in itertools.combinations(range(dimension), 2):
            out[(1 << i) | (1 << j)] = polar(directions[i], directions[j])
    elif rank == n - 2:
        r1, r2 = radical_basis(radical)
        a1 = 1 ^ qvalue(pairs, r1) ^ parity(offset & r1)
        a2 = 1 ^ qvalue(pairs, r2) ^ parity(offset & r2)
        b1 = [parity(column & r1) for column in columns]
        b2 = [parity(column & r2) for column in columns]
        out[0] = a1 & a2
        for i in range(dimension):
            out[1 << i] = (a1 & b2[i]) ^ (a2 & b1[i]) ^ (b1[i] & b2[i])
        for i, j in itertools.combinations(range(dimension), 2):
            out[(1 << i) | (1 << j)] = (b1[i] & b2[j]) ^ (b1[j] & b2[i])
    return out


def main():
    report = {"four_dimensional": {}, "other_dimensions": [], "sum_checks": 0}
    all_pairs = list(itertools.combinations(range(4), 2))
    local = []
    for mask in range(1 << len(all_pairs)):
        pairs = [pair for i, pair in enumerate(all_pairs) if mask >> i & 1]
        p, predicted, rank = predicted_local(4, pairs)
        exact = exact_local(4, pairs)
        assert all((x - p - 2 * y) % 4 == 0 for x, y in zip(exact, predicted))
        coefficients = anf(predicted)
        degree = max((i.bit_count() for i, v in enumerate(coefficients) if v), default=-1)
        assert degree <= 2
        key = str(rank)
        report["four_dimensional"][key] = report["four_dimensional"].get(key, 0) + 1
        local.append((p, predicted, exact))
    assert report["four_dimensional"] == {"0": 1, "2": 35, "4": 28}

    # Check even and odd constant sums, negative Gauss sums, and every pair
    # of four-variable polars with common affine parameters (lambda,h).
    for i, (p1, q1, k1) in enumerate(local):
        for j, (p2, q2, k2) in enumerate(local):
            constant = p1 + p2
            expected = [((constant // 2) & 1) ^ a ^ b for a, b in zip(q1, q2)]
            actual = [((a + b) % 4) // 2 for a, b in zip(k1, k2)]
            assert expected == actual
            assert max((m.bit_count() for m, bit in enumerate(anf(actual)) if bit), default=-1) <= 2
            report["sum_checks"] += 1

    # Affine substitutions, including noninjective ones, in six parameters.
    for trial, (p, predicted, exact) in enumerate(local):
        offsets = (trial * 7) % 32
        columns = [((trial + 3) * (i + 5) ^ (i << 2)) & 31 for i in range(6)]
        values = []
        for theta in range(64):
            point = offsets
            for i, column in enumerate(columns):
                if theta >> i & 1:
                    point ^= column
            values.append(((exact[point] % 4) // 2))
            assert (exact[point] - p - 2 * predicted[point]) % 4 == 0
        assert max((m.bit_count() for m, bit in enumerate(anf(values)) if bit), default=-1) <= 2
        pairs = [pair for i, pair in enumerate(all_pairs) if trial >> i & 1]
        assert coefficient_formula(4, pairs, offsets, columns) == anf(values)

    for n in (2, 6, 8):
        for rank in range(0, n + 1, 2):
            pairs = [(i, i + 1) for i in range(0, rank, 2)]
            p, predicted, actual_rank = predicted_local(n, pairs)
            assert actual_rank == rank
            exact = exact_local(n, pairs)
            assert all((x - p - 2 * y) % 4 == 0 for x, y in zip(exact, predicted))
            degree = max((m.bit_count() for m, bit in enumerate(anf(predicted)) if bit), default=-1)
            assert degree <= 2
            report["other_dimensions"].append({"dimension": n, "rank": rank, "degree": degree})
    report["local_assignments_4d"] = 64 * 32
    report["affine_substitutions"] = 64
    report["direct_coefficient_constructions"] = 64
    report["result"] = "all exact checks passed"
    output = Path(__file__).with_name("resultado.json")
    output.write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
    print(json.dumps(report, indent=2))


if __name__ == "__main__":
    main()
