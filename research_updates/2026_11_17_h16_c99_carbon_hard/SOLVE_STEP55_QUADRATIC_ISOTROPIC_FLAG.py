"""Determine how far the quadratic part can be linearized on affine flats."""
import json
from pathlib import Path

import numpy as np

from H16_POLAR_FLAGS import add, encode, null, radical_flag, rref, unpack
from H16_SPECIALIZED_KERNEL import mul, specialize
from SOLVE_STEP53_POLAR_GLOBAL_RESIDUAL import poly_mul


def bilinear_form(coeff, n):
    matrices = [A.ravel() for p,A in coeff.items() if p.bit_count() == 2 and A.any()]
    if not matrices:
        return np.zeros((n, 0, n), dtype=np.uint8)
    polar = np.zeros((n, matrices[0].size, n), dtype=np.uint8)
    for p, A in coeff.items():
        if p.bit_count() == 2:
            i, j = [k for k in range(n) if p >> k & 1]
            polar[i, :, j] = polar[j, :, i] = A.ravel()
    return polar


def isotropic_extension(polar):
    n = polar.shape[0]
    candidates = np.eye(n, dtype=np.uint8)
    flat = []
    basis = {}
    while len(basis) < len(candidates):
        encoded = encode(candidates)
        pool = sorted(set(encoded + [a ^ b for j, a in enumerate(encoded) for b in encoded[:j]]))
        trial = []
        for p in pool:
            change = basis.copy()
            if not add(change, p):
                continue
            rows = [polar[j] for j in range(n) if p >> j & 1]
            pairing = np.bitwise_xor.reduce(rows, axis=0)
            equations = mul(pairing, candidates.T)
            new = mul(null(equations), candidates)
            trial.append((len(new), p, new, change))
        _, p, candidates, basis = max(trial, key=lambda item: (item[0], -item[1]))
        flat.append(p)
    return unpack(flat, n)


def main():
    cert = json.loads(Path("residual/step53_global_residual.json").read_text())
    data = json.loads(Path("pencil/step41_B0_11.json").read_text())
    _, coeff, S = next(item for item in radical_flag(data) if item[0] == 30)
    n = S.shape[1]
    origin, _ = specialize(coeff, np.zeros(n, dtype=np.uint8), S)
    K = null(np.concatenate([A for p, A in origin.items() if p], axis=0)).T
    H = unpack(cert["adjusted_combinations"], 69)
    L = unpack(cert["constant_inverse"], 69)
    C = unpack(cert["r_complement"], 30).T
    hb = {p: mul(mul(H, A), K) for p, A in coeff.items()}
    D = {p: mul(A, C) for p, A in coeff.items()}
    adjusted = {p: mul(H, A) for p, A in D.items()}
    for p, A in poly_mul(hb, {p: mul(L, A) for p, A in D.items()}).items():
        adjusted.setdefault(p, np.zeros_like(adjusted[0]))
        adjusted[p] ^= A
    assert all(not A.any() for p,A in adjusted.items() if p.bit_count()>2)
    polar = bilinear_form(adjusted, n)
    radical = null(polar.reshape(-1, n))
    pivots = set(rref(radical)[1])
    J = np.eye(n, dtype=np.uint8)[[j for j in range(n) if j not in pivots]]
    reduced, _ = specialize(adjusted, np.zeros(n, dtype=np.uint8), J)
    q = len(J)
    quotient_polar = bilinear_form(reduced, q)
    wedge = np.array([quotient_polar[i, :, j] for i in range(q) for j in range(i+1,q)])
    wedge_rank = len(rref(wedge)[1])
    flat = isotropic_extension(quotient_polar)
    lifted = np.concatenate((radical, mul(flat, J)))
    verify, _ = specialize(adjusted, np.zeros(n, dtype=np.uint8), lifted)
    assert all(not A.any() for p,A in verify.items() if p.bit_count() > 1)
    complement = encode(null(lifted))
    result = {"radical_dim":len(radical),"quotient_dim":q,"wedge_rank":wedge_rank,
              "wedge_dim":q*(q-1)//2,"flat_dim":len(lifted),"fixed_forms":complement}
    Path("step55_isotropic_flag.json").write_text(json.dumps(result))
    print("STEP55_ISOTROPIC", json.dumps(result), flush=True)


if __name__ == "__main__":
    main()
