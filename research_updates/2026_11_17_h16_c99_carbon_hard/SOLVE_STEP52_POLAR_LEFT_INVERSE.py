"""Construct a minimal-degree Boolean left inverse of the five-column block."""
import json
from pathlib import Path

import numpy as np

from H16_POLAR_FLAGS import encode, null, radical_flag, rref
from H16_SPECIALIZED_KERNEL import mul, specialize
from SOLVE_STEP51_POLAR_PIVOT_CHARTS import translation_radical


def left_inverse(matrices, degree, dim):
    monomials = [m for m in range(1 << dim) if m.bit_count() <= degree]
    width = matrices.shape[1]
    pivots = {}
    for point, matrix in enumerate(matrices):
        active = sum(1 << (width * j) for j, m in enumerate(monomials) if point & m == m)
        for j, column in enumerate(encode(matrix.T)):
            row = ((active * column) << 5) | (1 << j)
            while row >= 32:
                pivot = row.bit_length() - 1
                if pivot not in pivots:
                    pivots[pivot] = row
                    break
                row ^= pivots[pivot]
            else:
                if row:
                    return None
    solutions = [0] * 5
    for pivot in sorted(pivots):
        row = pivots[pivot]
        for j in range(5):
            if ((solutions[j] & row).bit_count() ^ (row >> j)) & 1:
                solutions[j] |= 1 << pivot

    inverse = np.zeros((len(monomials), 5, width), dtype=np.uint8)
    for j, solution in enumerate(solutions):
        for k in range(len(monomials) * width):
            order, row = divmod(k, width)
            inverse[order, j, row] = (solution >> (k + 5)) & 1
    identity = np.eye(5, dtype=np.uint8)
    for point, matrix in enumerate(matrices):
        active = [i for i, m in enumerate(monomials) if point & m == m]
        value = np.bitwise_xor.reduce(inverse[active], axis=0)
        assert np.array_equal(mul(value, matrix), identity)
    return {m: A for m, A in zip(monomials, inverse) if A.any()}


def main():
    data = json.loads(Path("pencil/step41_B0_11.json").read_text())
    _, coeff, S = next(item for item in radical_flag(data) if item[0] == 30)
    n = S.shape[1]
    origin, _ = specialize(coeff, np.zeros(n, dtype=np.uint8), S)
    K = null(np.concatenate([A for p, A in origin.items() if p], axis=0))
    assert len(K) == 5
    block = {p: mul(A, K.T) for p, A in coeff.items()}
    _, rows = rref(np.concatenate(list(block.values()), axis=1).T)
    assert len(rows) == 19
    small = {p: A[rows] for p, A in block.items()}
    stabilizer = translation_radical(small, n)
    pivots = set(rref(stabilizer)[1])
    J = np.eye(n, dtype=np.uint8)[[j for j in range(n) if j not in pivots]]
    assert len(J) == 9
    F = null(stabilizer)
    aug, pivots = rref(np.concatenate((mul(F, J.T), F), axis=1))
    assert pivots == list(range(9))
    forms = aug[:, 9:]
    assert np.array_equal(mul(forms, J.T), np.eye(9, dtype=np.uint8))
    assert not mul(forms, stabilizer.T).any()

    reduced, _ = specialize(small, np.zeros(n, dtype=np.uint8), J)
    # Certify coefficient by coefficient that the nine forms reconstruct the block on all W.
    pulled, _ = specialize(reduced, np.zeros(9, dtype=np.uint8), forms.T)
    zero = np.zeros_like(small[0])
    assert all(np.array_equal(pulled.get(p, zero), small.get(p, zero)) for p in pulled.keys() | small.keys())
    terms = list(reduced)
    points = np.arange(512, dtype=np.uint32)
    matrices = mul((points[:, None] & terms == terms).astype(np.uint8),
                   np.array([reduced[p].ravel() for p in terms], dtype=np.uint8)).reshape((-1, 19, 5))
    for degree in range(10):
        inverse = left_inverse(matrices, degree, 9)
        print("STEP52_DEGREE", degree, inverse is not None, flush=True)
        if inverse is not None:
            break
    assert inverse is not None
    result = {"left_inverse_degree": degree, "nonzero_coefficients": len(inverse),
              "scalar_terms": int(sum(A.sum() for A in inverse.values())),
              "forms": encode(forms), "rows": rows,
              "left_inverse": {p: encode(A) for p, A in inverse.items()}}
    Path("step52_left_inverse.json").write_text(json.dumps(result))
    print("STEP52_INVERSE", json.dumps({k:v for k,v in result.items() if k!="left_inverse"}), flush=True)


if __name__ == "__main__":
    main()
