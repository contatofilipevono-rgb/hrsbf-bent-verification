"""Exact SAT model of n=12 RS bent functions in truth-orbit coordinates."""
import argparse
from collections import Counter
from pathlib import Path
from random import Random

from higher_filter import N, SIZE, evaluate_orbit, orbits, subsets
from higher_project import UPPER, signs_to_walsh, su_table


class Formula:
    def __init__(self, variables):
        self.variables = variables
        self.clauses = []
        self.parities = {}
        self.xors = []

    def fresh(self):
        self.variables += 1
        return self.variables

    def xor2(self, a, b):
        out = self.fresh()
        self.xors.append(((abs(a), abs(b), out), (a < 0) ^ (b < 0)))
        self.clauses.extend(((-a, -b, -out), (-a, b, out),
                             (a, -b, out), (a, b, -out)))
        return out

    def carry(self, a, b, c=None):
        out = self.fresh()
        if c is None:
            self.clauses.extend(((-a, -b, out), (a, -out), (b, -out)))
        else:
            for x, y in ((a, b), (a, c), (b, c)):
                self.clauses.extend(((-x, -y, out), (x, y, -out)))
        return out

    def parity(self, variables):
        key = tuple(sorted(variables))
        if not key:
            return None
        if key not in self.parities:
            out, *tail = key
            for var in tail:
                out = self.xor2(out, var)
            self.parities[key] = out
        return self.parities[key]

    def require(self, var, bit):
        if var is not None:
            self.clauses.append((var if bit else -var,))
        elif bit:
            self.clauses.append(())

    def congruence(self, coefficients, bits, rhs):
        columns = [[] for _ in range(bits)]
        modulus = 1 << bits
        for var, coefficient in coefficients.items():
            coefficient %= modulus
            if coefficient > modulus // 2:
                coefficient = modulus - coefficient
                var = -var
                rhs += coefficient
            for j, column in enumerate(columns):
                if coefficient >> j & 1:
                    column.append(var)
        for j, column in enumerate(columns):
            while len(column) > 1:
                a, b = column.pop(), column.pop()
                s = self.xor2(a, b)
                c = column.pop() if column else None
                if c is not None:
                    s = self.xor2(s, c)
                column.append(s)
                if j + 1 < bits:
                    columns[j + 1].append(self.carry(a, b, c))
            self.require(column[0] if column else None, rhs >> j & 1)

    def dimacs(self, path):
        with path.open('w') as file:
            file.write(f'p cnf {self.variables} {len(self.clauses)}\n')
            for clause in self.clauses:
                file.write(' '.join(map(str, clause)) + (' ' if clause else '') + '0\n')


class BentModel:
    def __init__(self):
        self.reps = []
        self.point = {}
        for i, (rep, cycle) in enumerate(orbits(N), 1):
            self.reps.append(rep)
            self.point.update({x: i for x in cycle})
        self.formula = Formula(len(self.reps))
        self.formula.require(self.point[0], 0)
        self.formula.require(self.point[1], 0)
        for support in self.reps:
            d = support.bit_count()
            if d >= 7:
                bits, rhs = (d - 6, 0) if d < N else (6, 32)
                self.formula.congruence(self.mobius_row(support), bits, rhs)

    def mobius_row(self, support):
        d = support.bit_count()
        result = Counter()
        for x in subsets(support):
            result[self.point[x]] += -1 if (d - x.bit_count()) % 2 else 1
        return result

    def anf_variable(self, support):
        return self.formula.parity(v for v, c in self.mobius_row(support).items() if c % 2)

    def fixed_upper(self, code):
        for i, (rep, _) in enumerate(UPPER):
            self.formula.require(self.anf_variable(rep), code >> i & 1)

    def outside_diagonal(self):
        conditions = set()
        for z in range(64):
            units = [self.point[(z ^ (1 << i)) | (1 << (i + 6))] for i in range(6)]
            for w in range(64):
                if w.bit_count() < 2:
                    continue
                v = {self.point[(z ^ w) | (w << 6)]}
                if w.bit_count() % 2 == 0:
                    v.symmetric_difference_update((self.point[z],))
                for i in range(6):
                    if w >> i & 1:
                        v.symmetric_difference_update((units[i],))
                if v:
                    conditions.add(tuple(sorted(v)))
        self.formula.clauses.append(tuple(self.formula.parity(v) for v in sorted(conditions)))

    def assignment(self, table):
        return [i if table >> rep & 1 else -i for i, rep in enumerate(self.reps, 1)]


def self_test(model):
    from pysat.solvers import Solver
    rng = Random(123)
    for bits in range(1, 7):
        for _ in range(8):
            weights = {j: rng.randrange(-32, 33) for j in range(1, 5)}
            rhs = rng.randrange(1 << bits)
            f = Formula(len(weights))
            f.congruence(weights, bits, rhs)
            with Solver(name='cadical195', bootstrap_with=f.clauses) as solver:
                for bits_in in range(16):
                    inputs = [j if bits_in >> (j - 1) & 1 else -j for j in weights]
                    s = sum(weights[j] for j in inputs if j > 0)
                    assert solver.solve(assumptions=inputs) == (s % (1 << bits) == rhs)
    quadratic = evaluate_orbit({(1 << i) | (1 << (i + 6)) for i in range(6)})
    controls = [quadratic, su_table(), quadratic ^ evaluate_orbit(UPPER[0][1]), 0]
    with Solver(name='cadical195', bootstrap_with=model.formula.clauses) as solver:
        for f in controls:
            result = solver.solve(assumptions=model.assignment(f))
            assert result == all(abs(w) == 64 for w in signs_to_walsh(f))
        assert [solver.solve(assumptions=model.assignment(f)) for f in controls] == [True, True, False, False]
    outside = BentModel()
    outside.outside_diagonal()
    with Solver(name='cadical195', bootstrap_with=outside.formula.clauses) as solver:
        assert not solver.solve(assumptions=outside.assignment(quadratic))
        assert solver.solve(assumptions=outside.assignment(su_table()))
    print('Positive and negative truth-table controls passed.')


def main():
    p = argparse.ArgumentParser()
    p.add_argument('--output', type=Path)
    p.add_argument('--high-mask', type=lambda x: int(x, 0))
    p.add_argument('--outside-diagonal', action='store_true')
    p.add_argument('--self-test', action='store_true')
    p.add_argument('--conflicts', type=int, help='Try a bounded search using CryptoMiniSat')
    a = p.parse_args()
    model = BentModel()
    if a.self_test:
        self_test(model)
    if a.high_mask is not None:
        assert 0 <= a.high_mask < 1 << len(UPPER)
        model.fixed_upper(a.high_mask)
    if a.outside_diagonal:
        model.outside_diagonal()
    if a.output:
        model.formula.dimacs(a.output)
    print('Truth orbits:', len(model.reps), 'CNF variables:', model.formula.variables,
          'clauses:', len(model.formula.clauses))
    if a.conflicts is not None:
        from pycryptosat import Solver
        solver = Solver(threads=1, confl_limit=a.conflicts)
        solver.add_clauses(model.formula.clauses)
        for row, parity in model.formula.xors:
            solver.add_xor_clause(list(row), parity)
        sat, values = solver.solve()
        if sat:
            table = sum(int(values[model.point[x]]) << x for x in range(SIZE))
            assert all(abs(w) == 64 for w in signs_to_walsh(table))
            print('SAT, normalized truth table:', hex(table))
        else:
            print('UNSAT' if sat is False else 'Conflict budget reached')


if __name__ == '__main__':
    main()
