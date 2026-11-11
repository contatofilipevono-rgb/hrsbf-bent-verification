"""Classify Q and construct balanced V3 supports with pi zero on z in V."""
import argparse
import json
import struct
from collections import Counter
from dataclasses import dataclass
from itertools import combinations
from pathlib import Path

from count_near_antipodal import image_and_kernel
from higher_filter import solve, xor_terms
from lower_dim_model import active_indices, anf, build
from lower_dim_support import balanced
from lower_dim_v3_symbolic import affine_at, echelon, product, substitute


SIZE = 512
MASK = (1 << SIZE) - 1
HIGH = sum(1 << i for i in range(SIZE) if i.bit_count() >= 6)
FIXED = frozenset(z for z in range(64) if (z & 7) == z >> 3)


def decompose(mapping):
    values = [sum(((mapping >> (SIZE * j + y)) & 1) << j for j in range(3))
              for y in range(SIZE)]
    q = sum((values[z + 64 * (1 << k)] ^ values[z]) << (3 * (64 * k + z))
            for k in range(3) for z in range(64))
    assert all(values[z + 64 * u] == values[z] ^ xor_terms(
        [(q >> (3 * (64 * k + z))) & 7 for k in range(3)], u)
        for z in range(64) for u in range(8))
    restriction = sum(values[z + 64 * u] << (3 * (8 * i + u))
                      for i, z in enumerate(sorted(FIXED)) for u in range(8))
    return q, restriction, values[:64]


@dataclass
class MapSpace:
    tables: list
    q_values: list
    q_lifts: list
    g_directions: list
    g_values: list


def prepare_space():
    model = build((9, 18, 36))
    tables = [mapping for mapping, _ in model.maps]
    data = [decompose(mapping) for mapping in tables]
    _, fixed_kernel = image_and_kernel([fixed for _, fixed, _ in data])
    q_columns = [xor_terms([q for q, _, _ in data], code) for code in fixed_kernel]
    q_image, q_kernel = image_and_kernel(q_columns)
    q_lifts = [xor_terms(fixed_kernel, code) for _, code in q_image]
    g_directions = [xor_terms(fixed_kernel, code) for code in q_kernel]
    g_values = [decompose(xor_terms(tables, code))[2] for code in g_directions]
    assert (len(tables), len(fixed_kernel), len(q_image), len(g_directions)) == (34, 28, 9, 19)
    return MapSpace(tables, [q for q, _ in q_image], q_lifts, g_directions, g_values)


def product_obstruction(space, code):
    mapping = xor_terms(space.tables, code)
    a, b, c = [(mapping >> (SIZE * j)) & MASK for j in range(3)]
    return ((anf(a & b & c, 9) & HIGH)
            | ((anf(a & b, 9) & HIGH) << SIZE)
            | ((anf(a & c, 9) & HIGH) << (2 * SIZE))
            | ((anf(b & c, 9) & HIGH) << (3 * SIZE)))


def product_equations(space, root, directions):
    """Recover the exact degree-at-most-three polynomial in map parameters."""
    coefficients = {0: product_obstruction(space, root)}
    for degree in range(1, 4):
        for indices in combinations(range(len(directions)), degree):
            term = sum(1 << i for i in indices)
            value = product_obstruction(space, root ^ xor_terms(directions, term))
            subset = term
            while True:
                subset = (subset - 1) & term
                value ^= coefficients.get(subset, 0)
                if not subset:
                    break
            if value:
                coefficients[term] = value
    union = 0
    for value in coefficients.values():
        union |= value
    return [{term for term, value in coefficients.items() if value >> bit & 1}
            for bit in active_indices(union)]


def output_bit(g_root, g_columns, point, label):
    terms = {1 << i for i, values in enumerate(g_columns)
             if (values[point] & label).bit_count() & 1}
    if (g_root[point] & label).bit_count() & 1:
        terms.add(0)
    return terms


def reduce_map_system(root, directions, equations):
    """Preserve the affine lift to the original 34 map coordinates."""
    while equations:
        rows = echelon(equations)
        if 0 in rows:
            return None
        linear = [row for term, row in rows.items() if term.bit_count() == 1]
        nonlinear = [row for term, row in rows.items() if term.bit_count() > 1]
        if not linear:
            return root, directions, nonlinear
        origin, free, _ = solve([(sum(term for term in row if term), int(0 in row))
                                 for row in linear], len(directions))
        assert origin is not None
        coordinates = [affine_at(i, origin, free) for i in range(len(directions))]
        root ^= xor_terms(directions, origin)
        directions = [xor_terms(directions, code) for code in free]
        equations = substitute(nonlinear, coordinates)
    return root, directions, []


def classify_case(space, q_code):
    q = xor_terms(space.q_values, q_code)
    root = xor_terms(space.q_lifts, q_code)
    g_root = decompose(xor_terms(space.tables, root))[2]
    annihilators = []
    linear = []
    for z in range(64):
        if z in FIXED:
            continue
        columns = [(q >> (3 * (64 * k + z))) & 7 for k in range(3)]
        _, normals, _ = solve([(column, 0) for column in columns], 3)
        assert normals
        annihilators.append((z, normals))
        if len(normals) == 1:
            bit = output_bit(g_root, space.g_values, z, normals[0])
            linear.append((sum(term for term in bit if term), 1 ^ int(0 in bit)))

    balance = []
    for label in range(1, 8):
        zero = [z for z in range(64) if all(
            (((q >> (3 * (64 * k + z))) & 7) & label).bit_count() % 2 == 0
            for k in range(3))]
        if len(zero) < 16 or len(zero) % 4:
            return "balance_size", None
        representatives = [z for z in zero if z < ((z & 7) << 3 | z >> 3)]
        target = len(zero) // 4
        parity = set()
        for z in representatives:
            parity ^= output_bit(g_root, space.g_values, z, label)
        linear.append((sum(term for term in parity if term), (target & 1) ^ int(0 in parity)))
        balance.append((label, representatives, target))

    origin, free, _ = solve(linear, len(space.g_directions))
    if origin is None:
        return "linear_balance", None
    map_root = root ^ xor_terms(space.g_directions, origin)
    map_directions = [xor_terms(space.g_directions, code) for code in free]
    g_root = decompose(xor_terms(space.tables, map_root))[2]
    g_columns = [decompose(xor_terms(space.tables, code))[2] for code in map_directions]
    equations = []
    for z, normals in annihilators:
        if len(normals) == 1:
            continue
        equation = {0}
        for label in normals:
            equation = product(equation, output_bit(g_root, g_columns, z, label) ^ {0})
        if equation:
            equations.append(equation)
    for label, representatives, target in balance:
        values = [output_bit(g_root, g_columns, z, label) for z in representatives]
        equation = set()
        for a, b in combinations(values, 2):
            equation ^= product(a, b)
        if target & 2:
            equation ^= {0}
        if equation:
            equations.append(equation)
    equations += product_equations(space, map_root, map_directions)
    reduced = reduce_map_system(map_root, map_directions, equations)
    if reduced is None:
        return "polynomial_contradiction", None
    return "admitted_Q", (reduced, balance)


class BooleanCircuit:
    def __init__(self, dimension):
        from pysat.formula import IDPool
        self.pool = IDPool(start_from=dimension + 1)
        self.one = self.pool.id()
        self.clauses = [[self.one]]
        self.monomials = {0: self.one, **{1 << i: i + 1 for i in range(dimension)}}
        self.parities = {}

    def parity(self, left, right):
        if left == right:
            return -self.one
        if left == -right:
            return self.one
        if abs(left) == self.one:
            return -right if left > 0 else right
        if abs(right) == self.one:
            return -left if right > 0 else left
        key = tuple(sorted((left, right)))
        if key not in self.parities:
            out = self.pool.id()
            self.clauses += [[left, right, -out], [-left, -right, -out],
                             [left, -right, out], [-left, right, out]]
            self.parities[key] = out
        return self.parities[key]

    def literal(self, polynomial):
        out = -self.one
        for term in sorted(polynomial):
            if term not in self.monomials:
                variable = self.pool.id()
                factors = [i + 1 for i in active_indices(term)]
                self.clauses += [[-variable, factor] for factor in factors]
                self.clauses.append([variable] + [-factor for factor in factors])
                self.monomials[term] = variable
            out = self.parity(out, self.monomials[term])
        return out

    def cardinality(self, literals, target):
        from pysat.card import CardEnc, EncType
        target -= literals.count(self.one)
        literals = [lit for lit in literals if abs(lit) != self.one]
        if target < 0 or target > len(literals):
            self.clauses.append([])
        elif target == 0:
            self.clauses += [[-lit] for lit in literals]
        elif target == len(literals):
            self.clauses += [[lit] for lit in literals]
        else:
            self.clauses += CardEnc.equals(literals, target, vpool=self.pool,
                                           encoding=EncType.seqcounter).clauses


def construct_supports(space, reduced, balance):
    from pysat.solvers import Solver
    root, directions, equations = reduced
    dimension = len(directions)
    circuit = BooleanCircuit(dimension)
    for equation in equations:
        circuit.clauses.append([-circuit.literal(equation)])
    g_root = decompose(xor_terms(space.tables, root))[2]
    g_columns = [decompose(xor_terms(space.tables, code))[2] for code in directions]
    for label, representatives, target in balance:
        circuit.cardinality([circuit.literal(output_bit(g_root, g_columns, z, label))
                             for z in representatives], target)
    codes = []
    with Solver(name="cadical195", bootstrap_with=circuit.clauses) as solver:
        while solver.solve():
            model = set(solver.get_model())
            word = sum(1 << i for i in range(dimension) if i + 1 in model)
            code = root ^ xor_terms(directions, word)
            assert balanced(xor_terms(space.tables, code), SIZE, 3)[0]
            assert not product_obstruction(space, code)
            codes.append(code)
            solver.add_clause([-(i + 1) if word >> i & 1 else i + 1 for i in range(dimension)])
    assert len(codes) == len(set(codes))
    return sorted(codes)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--q-code", type=int)
    parser.add_argument("--construct", action="store_true")
    args = parser.parse_args()
    space = prepare_space()
    cases = range(512) if args.q_code is None else [args.q_code]
    stages = Counter()
    rows = []
    supports = []
    for code in cases:
        stage, result = classify_case(space, code)
        stages[stage] += 1
        if result is None:
            continue
        reduced, balance = result
        root, directions, equations = reduced
        row = {"q_code": code, "map_root": root, "map_directions": directions,
               "equations": [sorted(eq) for eq in equations],
               "balance": balance, "dimension": len(directions)}
        if args.construct:
            values = construct_supports(space, reduced, balance)
            row["support_maps"] = len(values)
            supports += values
        rows.append(row)
        print({k: v for k, v in row.items() if k in ("q_code", "dimension", "support_maps")}, flush=True)
    args.output.parent.mkdir(exist_ok=True, parents=True)
    report = {"hypothesis": "pi is zero on z in V", "tested_Q": len(cases),
              "stages": dict(stages), "cases": rows}
    if args.construct:
        assert len(supports) == len(set(supports))
        args.output.with_suffix(".bin").write_bytes(b"".join(struct.pack("<Q", c) for c in sorted(supports)))
        report["support_maps"] = len(supports)
    args.output.write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
    print({k: v for k, v in report.items() if k != "cases"})


if __name__ == "__main__":
    main()
