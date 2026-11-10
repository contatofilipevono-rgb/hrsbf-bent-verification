"""Exhaust all degree-2/3/4 completions of a specified higher part."""

import argparse
import json
from itertools import combinations
from pathlib import Path
from random import Random
from time import perf_counter

import numpy as np

from higher_filter import (allowed_period4, direct_walsh, evaluate_orbit, frequencies,
                           period4_charts, solve, xor_terms)
from higher_project import (EQ, LOW, TOP, UPPER, dual_quartic, eliminate_lower,
                            high_mask, polynomial_linear_relations, su_table,
                            union_system)
from mobius_rule import integer_anf
from top_filters import active_bits, quad_table, xor_table


def evaluate(terms, mask):
    return sum(mask & m == m for m in terms) % 2


def high_example(label):
    return dual_quartic(13896404, 1065441) if label == "dual5" else su_table()


def make_tables(family, fixed, basis, nw):
    width = len(basis)
    nu = width - nw

    def eqs(v):
        return sum(evaluate(p, v) << i for i, p in enumerate(family))

    q0 = eqs(fixed)
    linear = [eqs(fixed ^ v) ^ q0 for v in basis]
    cross = [[0] * width for _ in basis]
    for i, j in combinations(range(width), 2):
        q = eqs(fixed ^ basis[i] ^ basis[j]) ^ q0 ^ linear[i] ^ linear[j]
        cross[i][j] = cross[j][i] = q
    left = quad_table(linear[:nu], [row[:nu] for row in cross[:nu]])
    right = quad_table(linear[nu:], [row[nu:] for row in cross[nu:]])
    mixed = [xor_table(row[nu:]) for row in cross[:nu]]
    return q0, left, right, mixed, xor_table(basis[:nu]), xor_table(basis[nu:])


def validate_union_equations(rows, high, top_tables, low_tables):
    rng = Random(5412)
    for _ in range(20):
        t, low = rng.getrandbits(43), rng.getrandbits(25)
        f = high ^ xor_terms(top_tables, t) ^ xor_terms(low_tables, low)
        c = integer_anf(f)
        for s, (b, p) in zip(EQ, rows):
            assert c[s] % 2 == 0
            assert (c[s] // 2) % 2 == (b & low).bit_count() % 2 ^ evaluate(p, t)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("label", choices=("dual5", "su6"))
    parser.add_argument("shard", type=int)
    parser.add_argument("shard_bits", type=int)
    parser.add_argument("output", type=Path)
    parser.add_argument("--limit", type=int)
    args = parser.parse_args()
    assert 0 <= args.shard < 1 << args.shard_bits
    start = perf_counter()
    witness = high_example(args.label)
    high_code = high_mask(witness)
    hc = integer_anf(witness)
    reference_top = sum((hc[m] % 2) << i for i, (m, _) in enumerate(TOP))
    reference_low = sum((hc[m] % 2) << i for i, (m, _) in enumerate(LOW))
    assert direct_walsh(witness)
    high = xor_terms([evaluate_orbit(o) for _, o in UPPER], high_code)
    top_tables = [evaluate_orbit(o) for _, o in TOP]
    low_tables = [evaluate_orbit(o) for _, o in LOW]
    rows = union_system(high_code)
    assert len(rows) == 70
    validate_union_equations(rows, high, top_tables, low_tables)
    low_pivots, residual = eliminate_lower(rows)
    linear, contradiction = polynomial_linear_relations(residual)
    assert not contradiction
    quartic_root, quartic_basis, quartic_rank = solve(linear.values(), 43)
    assert quartic_root is not None
    assert all(evaluate(p, reference_top) == 0 for p in residual)
    free = len(quartic_basis)
    width = free - args.shard_bits
    assert width >= 0
    fixed = quartic_root ^ xor_terms(quartic_basis[width:], args.shard)
    basis = quartic_basis[:width]
    nw = min(19, width)
    q0, left, right, mixed, a_lut, b_lut = make_tables(residual, fixed, basis, nw)
    limit = len(left) if args.limit is None else min(args.limit, len(left))
    frequencies_to_test = frequencies()
    found_ref = False
    quartic_solutions = 0
    lower_trials = 0
    bent = 0
    args.output.mkdir(parents=True, exist_ok=True)
    print("rank lower", len(low_pivots), "rank quartic", quartic_rank,
          "free", free, "checked quartic", limit << nw, flush=True)
    with (args.output / "bent.tsv").open("w") as output:
        for i in range(limit):
            if i:
                bit = (i & -i).bit_length() - 1
                np.bitwise_xor(right, mixed[bit], out=right)
            gray = i ^ (i >> 1)
            hits = np.flatnonzero(right == (left[gray] ^ np.uint64(q0)))
            for value in b_lut[hits] ^ a_lut[gray] ^ np.uint64(fixed):
                top = int(value)
                quartic_solutions += 1
                root, low_basis, _ = solve(
                    [(mask, evaluate(p, top)) for mask, p in low_pivots.values()], 25)
                assert root is not None
                base = high ^ xor_terms(top_tables, top)
                roots, kernel = period4_charts(base, low_tables, root, low_basis)
                deltas = [xor_terms(low_tables, v) for v in kernel]
                lower_trials += len(roots) << len(kernel)
                for code in roots:
                    table = base ^ xor_terms(low_tables, code)
                    for j in range(1 << len(kernel)):
                        if j:
                            bit = (j & -j).bit_length() - 1
                            table ^= deltas[bit]
                            code ^= kernel[bit]
                        if all((table ^ chi).bit_count() in (2016, 2080)
                               for chi in frequencies_to_test):
                            assert direct_walsh(table)
                            output.write(f"{top}\t{code}\n")
                            bent += 1
                            found_ref |= top == reference_top and code == reference_low
            if i and i % 256 == 0:
                output.flush()
                if i % 2048 == 0:
                    print(i, "quartic survivors", quartic_solutions,
                          "bent", bent, flush=True)
    result = {
        "label": args.label, "shard": args.shard, "shard_bits": args.shard_bits,
        "complete": limit == len(left), "high_mask": hex(high_code),
        "quartic_linear_rank": quartic_rank, "lower_rank": len(low_pivots),
        "quartic_trials": limit << nw, "quartic_filter_survivors": quartic_solutions,
        "lower_trials_after_period4": lower_trials, "normalized_bent": bent,
        "reference_top": reference_top, "reference_lower": reference_low,
        "reference_found": found_ref, "seconds": round(perf_counter() - start, 3),
    }
    (args.output / "report.json").write_text(json.dumps(result, indent=2) + "\n")
    print(result, flush=True)


if __name__ == "__main__":
    main()
