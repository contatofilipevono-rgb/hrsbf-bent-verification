"""Audit the exact branch-free 64-by-25 residual matrix."""
import json
from pathlib import Path

import numpy as np

from H16_POLAR_FLAGS import add, encode, null, radical_flag, rref, unpack
from H16_SPECIALIZED_KERNEL import mul, rank, specialize, strip


def poly_mul(left, right):
    out = {}
    for p, A in left.items():
        for q, B in right.items():
            value = mul(A, B)
            if value.any():
                out.setdefault(p | q, np.zeros_like(value))
                out[p | q] ^= value
    return {p: A for p, A in out.items() if A.any()}


def degree_profile(coeff):
    profile = {}
    for p, A in coeff.items():
        profile[p.bit_count()] = profile.get(p.bit_count(), 0) + int(A.sum())
    return profile


def main():
    data = json.loads(Path("pencil/step41_B0_11.json").read_text())
    certificate = json.loads(Path("inverse/step52_left_inverse.json").read_text())
    assert certificate["left_inverse_degree"] == 0
    _, coeff, S = next(item for item in radical_flag(data) if item[0] == 30)
    origin, _ = specialize(coeff, np.zeros(S.shape[1], dtype=np.uint8), S)
    K = null(np.concatenate([A for p, A in origin.items() if p], axis=0))
    B = {p: mul(A, K.T) for p, A in coeff.items()}
    L = np.zeros((5, 69), dtype=np.uint8)
    L[:, certificate["rows"]] = unpack(certificate["left_inverse"]["0"], 19)
    for p, A in B.items():
        expected = np.eye(5, dtype=np.uint8) if p == 0 else np.zeros((5, 5), dtype=np.uint8)
        assert np.array_equal(mul(L, A), expected)

    N = null(np.concatenate(list(B.values()), axis=1).T)
    pivots = {}
    for row in encode(np.concatenate((N, L))):
        assert add(pivots, row)
    H = unpack([1 << j for j in range(69) if add(pivots, 1 << j)], 69)
    assert N.shape == (50, 69) and H.shape == (14, 69)
    C = np.eye(30, dtype=np.uint8)[:, [j for j in range(30) if j not in rref(K)[1]]]
    assert rank(np.concatenate((C, K.T), axis=1), rref) == 30
    D = {p: mul(A, C) for p, A in coeff.items()}
    J = {p: mul(H, A) for p, A in B.items() if A.any()}
    LD = {p: mul(L, A) for p, A in D.items()}
    fixed = {p: mul(N, A) for p, A in D.items()}
    corrected = {p: mul(H, A) for p, A in D.items()}
    for p, correction in poly_mul(J, LD).items():
        corrected.setdefault(p, np.zeros_like(corrected[0]))
        corrected[p] ^= correction

    zero_n, zero_h = np.zeros_like(fixed[0]), np.zeros_like(corrected[0])
    residual = {p: np.concatenate((fixed.get(p, zero_n), corrected.get(p, zero_h)))
                for p in fixed.keys() | corrected.keys()}
    high_rank = {}
    for degree in (2, 3, 4):
        mats = [A for p, A in residual.items() if p.bit_count() >= degree]
        high_rank[degree] = rank(np.concatenate(mats, axis=1), rref) if mats else 0
    more, _, steps = strip(residual, rref, null)
    report = {"fixed_degree_profile": degree_profile(fixed),
              "corrected_degree_profile": degree_profile(corrected),
              "high_degree_row_rank": high_rank,
              "residual_shape": list(residual[0].shape), "global_further_strip": steps,
              "further_shape": list(more[0].shape)}
    result = {**report, "fixed_combinations": encode(N), "adjusted_combinations": encode(H),
              "constant_inverse": encode(L), "r_complement": encode(C.T)}
    Path("step53_global_residual.json").write_text(json.dumps(result))
    print("STEP53_RESIDUAL", json.dumps(report), flush=True)


if __name__ == "__main__":
    main()
