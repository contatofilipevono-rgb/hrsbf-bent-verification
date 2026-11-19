"""Exact global translation symmetries of reduced coefficient matrices."""

import json
from pathlib import Path


def add(pivots, row):
    while row:
        lead = row.bit_length() - 1
        if lead not in pivots:
            pivots[lead] = row
            return
        row ^= pivots[lead]


def basis_kernel(rows, n):
    pivots = {}
    for row in rows:
        add(pivots, row)
    basis = []
    for j in range(n):
        if j in pivots:
            continue
        vector = 1 << j
        for p, row in sorted(pivots.items()):
            if (row & vector).bit_count() & 1:
                vector |= 1 << p
        basis.append(vector)
    return basis


def indices(mask):
    while mask:
        bit = mask & -mask
        mask ^= bit
        yield bit.bit_length() - 1


def xor_sum(values):
    result = 0
    for value in values:
        result ^= value
    return result


def evaluate_matrix(data, w):
    matrices = [data["reduced_constant"], *(data["reduced_slices"][i] for i in indices(w)),
                *(q for i, j, q in data["reduced_quadratic_slices"] if w >> i & w >> j & 1)]
    return [xor_sum(row) for row in zip(*matrices)]


def evaluate_rhs(data, w):
    terms = sum(1 << data["w_vars"][j] for j in indices(w))
    for key, ps in data["tails"].items():
        if sum(terms & m == m for m in ps) & 1:
            terms |= int(key)
    values = sum((sum(terms & m == m for m in row) & 1) << j
                 for j, row in enumerate(data["source_rhs_anf"]))
    return [(r & values).bit_count() & 1 for r in data["projector"]]


def matrix_kernel(data):
    linear = data["reduced_slices"]
    quad = data["reduced_quadratic_slices"]
    n = len(linear)
    width = len(data["complement"])
    rows = len(data["projector"])
    polar = [[0] * (width * rows) for _ in range(n)]
    for i, j, q in quad:
        for r, row in enumerate(q):
            for c in indices(row):
                position = r * width + c
                polar[i][position] ^= 1 << j
                polar[j][position] ^= 1 << i
    radical = basis_kernel((m for section in polar for m in section), n)
    base = data["reduced_constant"]
    restricted = [[a ^ b for a, b in zip(evaluate_matrix(data, direction), base)]
                  for direction in radical]
    equations = [sum(((m[r] >> c) & 1) << j for j, m in enumerate(restricted))
                 for r in range(rows) for c in range(width)]
    kernel = [xor_sum(radical[j] for j in indices(mask))
              for mask in basis_kernel(equations, len(radical))]
    return len(radical), kernel


def rank(rows):
    pivots = {}
    for row in rows:
        add(pivots, row)
    return len(pivots)


def audit(path):
    data = json.loads(path.read_text())
    polar_dim, kernel = matrix_kernel(data)
    samples = []
    width = len(data["complement"])
    for k in kernel:
        columns = evaluate_matrix(data, 0)
        assert columns == evaluate_matrix(data, k)
        a, b = evaluate_rhs(data, 0), evaluate_rhs(data, k)
        delta = [i ^ j for i, j in zip(a, b)]
        samples.append({"direction": list(indices(k)), "rhs_delta_weight_at_zero": sum(delta),
                        "rhs_delta_outside_image_at_zero":
                            rank([m | (v << width) for m, v in zip(columns, delta)]) > rank(columns)})
    print("STEP41_TRANSLATION", json.dumps({"matrix": path.stem,
        "polar_radical_dim": polar_dim, "matrix_translation_dim": len(kernel),
        "directions": samples}), flush=True)


if __name__ == "__main__":
    for file in sorted(Path("pencils").glob("step41_*.json")):
        audit(file)
