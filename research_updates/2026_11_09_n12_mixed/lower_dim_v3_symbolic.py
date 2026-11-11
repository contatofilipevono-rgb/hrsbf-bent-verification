"""Count phase systems by Boolean polynomial elimination and quadratic Gauss sums."""
import argparse
import json
import struct
from collections import Counter
from pathlib import Path

from higher_filter import solve
from lower_dim_model import active_indices, build
from lower_dim_orbits import apply, block_lookup, code_actions
from lower_dim_phase_families import load_representatives
from lower_dim_phase_prepare import prepare
from lower_dim_phase_verify import records
from lower_dim_plan import BASES


def read_tasks(path):
    with path.open("rb") as f:
        assert f.read(8) == b"PHS3451\0"
        _, words, properties, _ = struct.unpack("<4I", f.read(16))
        width = 8 * words
        while header := f.read(20):
            code, dimension, multiplier, n = struct.unpack("<QIII", header)
            root = int.from_bytes(f.read(width), "little")
            signature = int.from_bytes(f.read(8 * properties), "little")
            directions = [(int.from_bytes(f.read(width), "little"),
                           int.from_bytes(f.read(8 * properties), "little"))
                          for _ in range(dimension)]
            moments = [(int.from_bytes(f.read(width), "little"), *f.read(2)) for _ in range(n)]
            yield code, multiplier, properties, root, signature, directions, moments


def product(left, right):
    result = set()
    for a in left:
        for b in right:
            result.symmetric_difference_update((a | b,))
    return result


def affine_at(point, base, directions):
    terms = {1 << i for i, value in enumerate(directions) if value >> point & 1}
    if base >> point & 1:
        terms.add(0)
    return terms


def equations_for_task(properties, root, signature, directions, moments):
    equations = []
    phase_dirs = [v for v, _ in directions]
    signature_dirs = [v for _, v in directions]
    phase_values = [affine_at(x, root, phase_dirs) for x in range(512)]

    for subset, modulus, target in moments:
        bits = [set() for _ in range(modulus.bit_length())]
        for point in active_indices(subset):
            carry = phase_values[point]
            for i in range(len(bits)):
                if not carry:
                    break
                next_carry = product(carry, bits[i]) if i + 1 < len(bits) else set()
                bits[i].symmetric_difference_update(carry)
                carry = next_carry
        for i, poly in enumerate(bits):
            if target >> i & 1:
                poly.symmetric_difference_update((0,))
            if poly:
                equations.append(poly)

    # A property must have a nonzero compressed signature.
    for j in range(properties):
        start = 64 * j
        rows = [affine_at(x, signature, signature_dirs) for x in range(start, start + 64)]
        linear = [(sum(m for m in row if m), int(0 in row)) for row in rows if row]
        origin, free, _ = solve(linear, len(directions))
        if origin is None:
            continue  # The signature can never be zero.
        # In the V3 tasks every signature that can vanish has rank one.
        assert len(free) == len(directions) - 1
        row = next(row for row in rows if any(row))
        equations.append(row ^ {0})
    return equations


def echelon(equations):
    basis = {}
    for poly in equations:
        row = set(poly)
        while row:
            leading = max(row, key=lambda m: (m.bit_count(), m))
            if leading not in basis:
                basis[leading] = row
                break
            row ^= basis[leading]
    return basis


def substitute(equations, variables):
    cache = {0: {0}}
    for i, poly in enumerate(variables):
        cache[1 << i] = poly

    def monomial(mask):
        if mask not in cache:
            bit = mask & -mask
            cache[mask] = product(cache[bit], monomial(mask ^ bit))
        return cache[mask]

    result = []
    for equation in equations:
        row = set()
        for term in equation:
            row ^= monomial(term)
        if row:
            result.append(row)
    return result


def eliminate(dimension, equations, statistics):
    while equations:
        rows = echelon(equations)
        if 0 in rows:
            return 0, [{-1}]
        affine = [poly for m, poly in rows.items() if m.bit_count() == 1]
        nonlinear = [poly for m, poly in rows.items() if m.bit_count() > 1]
        if not affine:
            return dimension, nonlinear
        constraints = [(sum(m for m in poly if m), int(0 in poly)) for poly in affine]
        origin, free, rank = solve(constraints, dimension)
        assert origin is not None
        statistics["linear_eliminations"] += rank
        coordinates = [affine_at(i, origin, free) for i in range(dimension)]
        equations = substitute(nonlinear, coordinates)
        dimension = len(free)
    return dimension, []


def gauss_sum(dimension, quadratic):
    """Sum the signs of a quadratic by eliminating nonsingular pairs."""
    poly = set(quadratic)
    pairs = 0
    while cross := next((m for m in poly if m.bit_count() == 2), 0):
        left = cross & -cross
        right = cross ^ left
        # For Q = xy + xA + yB + C, summing x,y gives 2*(-1)^(C+AB).
        a = {m ^ left for m in poly if m & left and not m & right}
        b = {m ^ right for m in poly if m & right and not m & left}
        poly = {m for m in poly if not m & cross} ^ product(a, b)
        pairs += 1
    if any(m for m in poly):
        return 0, 2 * pairs
    return (-1 if 0 in poly else 1) * (1 << (dimension - pairs)), 2 * pairs


def count(dimension, equations, statistics):
    dimension, equations = eliminate(dimension, equations, statistics)
    if equations == [{-1}]:
        statistics["contradictions"] += 1
        return 0, dimension, [], []
    assert all(m.bit_count() <= 2 for equation in equations for m in equation)
    sums = []
    ranks = []
    polynomial = set()
    for ordinal in range(1 << len(equations)):
        if ordinal:
            polynomial ^= equations[(ordinal & -ordinal).bit_length() - 1]
        value, rank = gauss_sum(dimension, polynomial)
        sums.append(value)
        ranks.append(rank)
    total = sum(sums)
    assert total >= 0 and total % len(sums) == 0
    return total // len(sums), dimension, [sorted(row) for row in equations], [
        {"sum": value, "rank": rank} for value, rank in zip(sums, ranks)]


def orbit_partition(codes):
    actions = [(name, block_lookup(columns)) for name, columns in code_actions(build(BASES[0]))]
    unseen = set(codes)
    orbits = {}
    while unseen:
        root = min(unseen)
        seen = {root}
        pending = [root]
        while pending:
            code = pending.pop()
            for _, action in actions:
                moved = apply(action, code)
                if moved not in seen:
                    assert moved in unseen, (root, code, moved)
                    seen.add(moved)
                    pending.append(moved)
        unseen.difference_update(seen)
        orbits[root] = sorted(seen)
    return orbits, [name for name, _ in actions]


def read_artifacts(directory, work):
    tasks, native = {}, {}
    support_maps = 0
    for shard in range(8):
        artifact = directory / f"lower-dim-phase-1-{shard}"
        path = work / f"tasks-{shard}.bin"
        support = artifact / "support.bin"
        support_maps += support.stat().st_size // 8
        prepare(1, support, path, 0, None)
        for task in read_tasks(path):
            assert task[0] not in tasks
            tasks[task[0]] = task
        output = records(artifact / "result.witnesses.bin", 64)
        assert not (output.keys() & native.keys())
        assert not (artifact / "result.deferred.bin").stat().st_size
        native.update(output)
    assert native.keys() <= tasks.keys()
    return tasks, native, support_maps


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--summary", type=Path, required=True)
    p.add_argument("--artifacts", type=Path, required=True)
    p.add_argument("--output", type=Path, required=True)
    p.add_argument("--work", type=Path, required=True)
    args = p.parse_args()
    args.work.mkdir(exist_ok=True, parents=True)
    expected = load_representatives(1, args.summary)
    tasks, native, support_maps = read_artifacts(args.artifacts, args.work)
    orbits, generators = orbit_partition(tasks)
    result, admitted = [], {}
    for code, members in orbits.items():
        _, factor, properties, root, signature, directions, moments = tasks[code]
        equations = equations_for_task(properties, root, signature, directions, moments)
        statistics = Counter()
        n, dimension, reduced, sums = count(len(directions), equations, statistics)
        phase_count = n << factor
        for member in members:
            assert phase_count == native.get(member, (0, 0))[0], (code, member, phase_count)
        if phase_count:
            admitted[code] = len(members), phase_count
        result.append({"map_code": code, "orbit_size": len(members), "members": members,
                       "initial_dimension": len(directions), "initial_equations": len(equations),
                       "phase_multiplier": 1 << factor, "phases_per_map": phase_count,
                       "functions": len(members) * phase_count, "residual_dimension": dimension,
                       "residual_quadratics": reduced, "gauss_sums": sums,
                       "statistics": dict(statistics)})
    assert admitted == expected
    report = {"support_maps": support_maps, "phase_candidates": len(tasks),
              "generators": generators, "orbit_sizes": dict(Counter(map(len, orbits.values()))),
              "orbits": len(orbits), "admitted_orbits": len(admitted), "admitted_maps": len(native),
              "functions": sum(row["functions"] for row in result), "details": result}
    args.output.write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
    print({key: value for key, value in report.items() if key != "details"})


if __name__ == "__main__":
    main()
