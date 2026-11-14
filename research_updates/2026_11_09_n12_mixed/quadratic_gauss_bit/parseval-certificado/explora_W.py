"""Identities from Pf4 and L5 in the fixed n=12 polar coordinates."""
import itertools
import json
import sys
from collections import Counter
from pathlib import Path

import numpy as np

ROOT = Path(__file__).resolve().parent
MODEL = ROOT.parent / "piloto-gauss-real" / "inputs_model"
if not MODEL.exists():
    MODEL = ROOT.parent.parent / "fable_planos_pfaffiano"
sys.path.insert(0, str(MODEL))
from base12 import PAIRS, mobius
from bitj import load_model, solve_affine, table_at
from base12 import forma
from poisson5 import Bv_table, equacoes
from testemunhas12 import BA, BB, coords


def matchings(vertices):
    if not vertices:
        yield ()
        return
    first, *tail = vertices
    for other in tail:
        for rest in matchings([v for v in tail if v != other]):
            yield ((first, other),) + rest


def pfaffian_rows(polar, indices):
    return np.bitwise_xor.reduce(
        [np.bitwise_and.reduce(polar[list(edges)], axis=0) for edges in indices], axis=0
    )


def monomials(dimension, degree):
    return [
        sum(1 << i for i in support)
        for weight in range(degree + 1)
        for support in itertools.combinations(range(dimension), weight)
    ]


def coefficients(values):
    result = {}
    for mask, value in values.items():
        coefficient = value.copy()
        remaining = mask
        while remaining:
            remaining = (remaining - 1) & mask
            coefficient ^= values[remaining]
        if coefficient.any():
            result[mask] = coefficient
    return result


def echelon(rows):
    pivots = {}
    for row in rows:
        while row:
            pivot = row.bit_length() - 1
            if pivot not in pivots:
                pivots[pivot] = row
                break
            row ^= pivots[pivot]
    return pivots


def compose(terms, affine_masks):
    output = 0
    for term in terms:
        if term == 0:
            output ^= 1
            continue
        factors = [affine_masks[j] for j in range(len(affine_masks)) if term >> j & 1]
        product = {0}
        for factor in factors:
            terms_f = [i for i in range(factor.bit_length()) if factor >> i & 1]
            next_terms = set()
            for a in product:
                for b in terms_f:
                    mask = a | (0 if b == 0 else 1 << (b - 1))
                    next_terms.symmetric_difference_update([mask])
            product = next_terms
        output ^= sum(1 << mask for mask in product)
    return output


def supports(row):
    while row:
        term = row & -row
        yield term.bit_length() - 1
        row ^= term


def mixed_pf4_classes(polars, generators):
    dimension = len(polars)
    beta = [tuple(coords(forma(B, 27, 54), BA)) + tuple(coords(forma(B, 21, 42), BB)) for B in polars]
    beta_rows = [sum(v[k] << i for i, v in enumerate(beta)) for k in range(6)]
    first = [1 << j for j in (4, 5, 6, 7, 8, 9, 22)]
    outcomes = {}
    for a, b in itertools.product(range(1, 8), repeat=2):
        target = a | (b << 3)
        part, kernel = solve_affine([(row, target >> k & 1) for k, row in enumerate(beta_rows)], dimension)
        affine_masks = [(part >> i & 1) | sum((v >> i & 1) << (j + 1) for j, v in enumerate(kernel)) for i in range(dimension)]
        rows = list(echelon(compose(terms, affine_masks) for terms in generators).values())
        first_class = compose(first, affine_masks)
        for step in range(20):
            linear = [row for row in rows if all(i.bit_count() <= 1 for i in supports(row))]
            affine_equations = [
                (sum(1 << i for i in range(len(kernel)) if row >> (1 << i) & 1), row & 1)
                for row in linear
            ]
            solution = solve_affine(affine_equations, len(kernel))
            if solution is None:
                outcome = "excluded_by_Pf4"
                break
            p, k = solution
            if len(k) == len(kernel):
                outcome = "first_equation_from_Pf4" if first_class == 0 else "open"
                break
            change = [(p >> i & 1) | sum((v >> i & 1) << (j + 1) for j, v in enumerate(k)) for i in range(len(kernel))]
            rows = [compose(supports(row), change) for row in rows]
            rows = list(echelon(rows).values())
            first_class = compose(supports(first_class), change)
            kernel = k
        outcomes[f"{a}/{b}"] = outcome
    return outcomes


def main():
    polars, function_tables, phase_tables, _ = load_model()
    dimension = len(polars)
    pf6 = [[PAIRS.index(edge) for edge in pairs] for pairs in matchings(range(6))]
    pf4 = [
        [[PAIRS.index(edge) for edge in pairs] for pairs in matchings(vertices)]
        for vertices in itertools.combinations(range(6), 4)
    ]
    top4 = [mask for mask in range(64) if mask.bit_count() == 4]
    samples6, samples4 = {}, {}
    for mask in monomials(dimension, 3):
        selected = [j for j in range(dimension) if mask >> j & 1]
        polar = np.bitwise_xor.reduce([polars[j] for j in selected], axis=0) if selected else np.zeros((15, 64), np.uint8)
        samples6[mask] = pfaffian_rows(polar, pf6)
        if mask.bit_count() <= 2:
            samples4[mask] = np.stack([mobius(pfaffian_rows(polar, terms), 6)[top4] for terms in pf4])
    formula = coefficients(samples6)
    assert set(formula) == {1 << 24, (1 << 24) | (1 << 21), (1 << 24) | (1 << 23)}
    assert all(np.flatnonzero(value).tolist() == [0] for value in formula.values())
    pf4_coefs = coefficients(samples4)
    labels = list(samples4)
    equations = [
        sum(1 << i for i, mask in enumerate(labels) if mask in pf4_coefs and pf4_coefs[mask][a, b])
        for a, b in itertools.product(range(15), repeat=2)
    ]
    rowspace = echelon(equations)
    linear = [[j for j, mask in enumerate(labels) if row >> j & 1] for pivot, row in rowspace.items() if pivot <= dimension]
    target_second = sum(1 << labels.index(1 << j) for j in (21, 23, 24))
    tracked = {}
    for i, equation in enumerate(equations):
        row, combination = equation, 1 << i
        while row:
            pivot = row.bit_length() - 1
            if pivot not in tracked:
                tracked[pivot] = (row, combination)
                break
            reduced, selected = tracked[pivot]
            row ^= reduced
            combination ^= selected
    remaining, support = target_second, 0
    while remaining:
        row, selected = tracked[remaining.bit_length() - 1]
        remaining ^= row
        support ^= selected
    quads = list(itertools.combinations(range(6), 4))
    pairs_for_second = [
        {"minor": quads[i // 15], "z_monomial": hex(top4[i % 15])}
        for i in range(225) if support >> i & 1
    ]
    assert np.bitwise_xor.reduce([np.array([equations[i] >> j & 1 for j in range(len(labels))], np.uint8)
                                  for i in range(225) if support >> i & 1], axis=0).tolist() == [
        target_second >> j & 1 for j in range(len(labels))]
    upper = monomials(dimension, 4)
    index = {mask: i for i, mask in enumerate(upper)}
    generators = [[mask for i, mask in enumerate(labels) if row >> i & 1] for row in rowspace.values()]
    assert all(term & 15 == 0 for equation in generators for term in equation)
    # Pack the truth table of each top coordinate into an integer. The four
    # coordinates with zero quadratic top do not occur in these equations.
    count = 1 << 21
    variables = [int.from_bytes(bytes([0xAA, 0xCC, 0xF0][i]) * (count // 8), "little") if i < 3
                 else int.from_bytes((bytes(1 << (i - 3)) + b"\xff" * (1 << (i - 3))) * (count >> (i + 1)), "little")
                 for i in range(21)]
    all_points = (1 << count) - 1
    valid_top = all_points
    term_values = {0: all_points}
    for equation in generators:
        truth = 0
        for term in equation:
            if term not in term_values:
                value = all_points
                for i in supports(term >> 4):
                    value &= variables[i]
                term_values[term] = value
            truth ^= term_values[term]
        valid_top &= all_points ^ truth
    first_truth = 0
    for i in (4, 5, 6, 7, 8, 9, 22):
        first_truth ^= variables[i - 4]
    failing_top = valid_top & first_truth
    beta = [tuple(coords(forma(B, 27, 54), BA)) + tuple(coords(forma(B, 21, 42), BB)) for B in polars]
    beta_masks = [sum(bit << i for i, bit in enumerate(v)) for v in beta]
    mixed_outside = []
    for top in supports(failing_top):
        fingerprint = 0
        for i in supports(top):
            fingerprint ^= beta_masks[i + 4]
        for low in range(16):
            signature = fingerprint
            for i in supports(low):
                signature ^= beta_masks[i]
            if signature & 7 and signature >> 3:
                mixed_outside.append((top << 4) | low)
    l5_failures = []
    common_single_rows = None
    for mask in mixed_outside:
        polar = np.bitwise_xor.reduce([polars[i] for i in supports(mask)], axis=0)
        table = table_at(np.zeros((64, 64), np.uint8), function_tables, mask)
        rows = equacoes(Bv_table(polar), table, phase_tables)
        if solve_affine(rows, len(phase_tables)) is not None:
            l5_failures.append(hex(mask))
        indices = {i for i, row in enumerate(rows) if row == (0, 1)}
        common_single_rows = indices if common_single_rows is None else common_single_rows & indices
    target = sum(1 << index[1 << j] for j in (4, 5, 6, 7, 8, 9, 22))
    implications = {}
    for multiplier_degree in (1, 2):
        def products():
            for multiplier in monomials(dimension, multiplier_degree):
                for generator in generators:
                    product = 0
                    for term in generator:
                        product ^= 1 << index[term | multiplier]
                    yield product
        lifted = echelon(products())
        residual = target
        while residual and residual.bit_length() - 1 in lifted:
            residual ^= lifted[residual.bit_length() - 1]
        implications[multiplier_degree] = {"rank": len(lifted), "first_equation_from_pf4": residual == 0}
        if not residual:
            break
    result = {
        "polar_dimension": dimension,
        "pf6_nonzero_coefficients": {hex(mask): np.flatnonzero(value).tolist() for mask, value in formula.items()},
        "pf4_independent_equations": len(rowspace),
        "pf4_linear_consequences": [[hex(labels[i]) for i in row] for row in linear],
        "pf4_explicit_second_equation": pairs_for_second,
        "pf4_equation_sizes": dict(Counter(row.bit_count() for row in rowspace.values())),
        "pf4_multiplication": implications,
        "mixed_Pf4_classes": mixed_pf4_classes(polars, generators),
        "top_pf4_scan": {"accepted_top": valid_top.bit_count(), "accepted_outside_first": failing_top.bit_count(),
                         "mixed_outside_first": len(mixed_outside), "examples": [hex(c) for c in mixed_outside[:8]],
                         "l5_survivors_outside_first": l5_failures,
                         "common_raw_L5_contradiction_indices": sorted(common_single_rows or [])},
    }
    (ROOT / "explora_W.json").write_text(json.dumps(result, indent=2) + "\n")
    print(json.dumps(result, indent=2))


if __name__ == "__main__":
    main()
