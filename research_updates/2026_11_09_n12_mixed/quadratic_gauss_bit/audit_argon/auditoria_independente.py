"""Exact independent audit of the joint-degree and Poisson claims.

Uses direct character sums as ground truth, not degree-two interpolation.
The imported Argon module is compared only after that ground truth is built.
No network calls or research-model imports.
"""
import itertools
import json
from pathlib import Path

import numpy as np

import argon_prova_poisson_bitj as argon


def mobius(values, xor=True):
    out = list(map(int, values))
    for i in range(len(out).bit_length() - 1):
        for m in range(len(out)):
            if m >> i & 1:
                if xor:
                    out[m] ^= out[m ^ (1 << i)]
                else:
                    out[m] -= out[m ^ (1 << i)]
    return out


def fwht(values):
    values = np.array(values, dtype=np.int64).reshape(-1).copy()
    for i in range(values.size.bit_length() - 1):
        blocks = values.reshape(-1, 2, 1 << i)
        a, b = blocks[:, 0].copy(), blocks[:, 1].copy()
        blocks[:, 0], blocks[:, 1] = a + b, a - b
    return values


def eval_anf(anf, point):
    return sum(bit for mask, bit in enumerate(anf) if (point & mask) == mask) & 1


def joint_audit():
    rng = np.random.default_rng(221114)
    W, V = np.arange(64), np.arange(16)
    par = np.array([i.bit_count() & 1 for i in range(64)], dtype=np.int64)
    H16 = 1 - 2 * par[V[:, None] & V[None, :]]
    pairs = list(itertools.combinations(range(4), 2))
    report = {"families": 64, "parameter_dimension": 3, "auxiliary_dimension": 6,
              "all_parameter_auxiliary_points": 64 * 512,
              "compressed_equivalence_checks": 64 * 8,
              "coefficient_checks": 0, "shuffled_basis_checks": 0}
    for case in range(64):
        base = np.zeros(64, dtype=np.int64)
        for i, (a, b) in enumerate(pairs):
            if case >> i & 1:
                base ^= (W >> a) & (W >> b) & 1
        # Fixed cross terms involving the complementary coordinates.
        for a in range(4):
            if (case >> a) & 1:
                base ^= (W >> a) & (W >> (4 + (a & 1))) & 1
        q = np.stack([base ^ par[W & int(rng.integers(0, 64))] ^ int(rng.integers(0, 2))
                      for _ in range(2)])
        B = np.stack([argon.eval_q_and_polar(row)[1] for row in q])
        lam0 = rng.integers(0, 64, 2)
        lam_dirs = rng.integers(0, 64, (3, 2))
        h0 = rng.integers(0, 2, 2)
        h_dirs = rng.integers(0, 2, (3, 2))
        truth = np.zeros(512, dtype=np.int64)
        for theta in range(8):
            lam, h = lam0.copy(), h0.copy()
            for i in range(3):
                if theta >> i & 1:
                    lam ^= lam_dirs[i]
                    h ^= h_dirs[i]
            signs = 1 - 2 * (q ^ par[lam[:, None] & W[None, :]] ^ h[:, None])
            for coset in range(4):
                K = signs[:, (coset << 4) ^ V] @ H16.T
                assert (K % 4 == 0).all()
                moments = (K // 4).sum(axis=0)
                assert (moments % 2 == 0).all()  # Two rows have the same polar.
                for omega in range(16):
                    y = omega | (coset << 4)
                    truth[theta | (y << 3)] = (moments[omega] % 4) // 2
        coefficients = mobius(truth)
        assert all(not bit or mask.bit_count() <= 2
                   for mask, bit in enumerate(coefficients))
        for y in [x for x in range(64) if x.bit_count() <= 2]:
            _, c0, c1, c2 = argon.direct_bI_coefficients(
                q, B, lam0, lam_dirs, h0, h_dirs, [0, 1], list(range(16)),
                (y >> 4) << 4, y & 15)
            row = mobius([truth[theta | (y << 3)] for theta in range(8)])
            assert c0 == row[0]
            assert all(c1[i] == row[1 << i] for i in range(3))
            assert all(c2[i, j] == row[(1 << i) | (1 << j)]
                       for i, j in itertools.combinations(range(3), 2))
            report["coefficient_checks"] += 1

        # Equivalence of all 64 equations with one quadratic, six affine
        # differences, and the fifteen constant second differences.
        for theta in range(8):
            row = [int(truth[theta | (y << 3)]) for y in range(64)]
            c0 = row[0]
            first = [row[1 << j] ^ c0 for j in range(6)]
            second = [row[(1 << i) | (1 << j)] ^ row[1 << i] ^ row[1 << j] ^ c0
                      for i, j in itertools.combinations(range(6), 2)]
            assert (not any(row)) == (not c0 and not any(first) and not any(second))
        # Verify the claimed basis-order bug does not occur on valid inputs.
        reference = argon.direct_Qz_coefficients(q[0], B[0], int(lam0[0]),
            list(map(int, lam_dirs[:, 0])), int(h0[0]), list(map(int, h_dirs[:, 0])),
            list(range(16)), 32, 9)
        for _ in range(3):
            permuted = list(map(int, rng.permutation(16)))
            value = argon.direct_Qz_coefficients(q[0], B[0], int(lam0[0]),
                list(map(int, lam_dirs[:, 0])), int(h0[0]), list(map(int, h_dirs[:, 0])),
                permuted, 32, 9)
            assert all(np.array_equal(a, b) for a, b in zip(reference, value))
            report["shuffled_basis_checks"] += 1
        damaged = list(truth)
        damaged[-1] ^= 1
        assert any(bit and m.bit_count() > 2 for m, bit in enumerate(mobius(damaged)))
    return report


def false_mod8_examples():
    Z, W = np.arange(64), np.arange(64)
    par = np.array([i.bit_count() & 1 for i in range(64)], dtype=np.int64)
    shift = (((Z >> 3) & 1) << 4) ^ (((Z >> 4) & 1) << 5)
    y = W[None, :] ^ shift[:, None]
    pi = y ^ (((y >> 1) & 1) * ((y >> 2) & 1)) ^ \
        (((((y >> 3) & 1) * ((y >> 4) & 1))) << 1)
    first = par[Z[:, None] & pi]
    V = np.arange(16)
    K = (1 - 2 * first[:, V]) @ (1 - 2 * par[V & 1])  # omega=e0, w0=0.
    M = int((K // 4)[((Z >> 2) & 1) == 1].sum())
    assert M == -4
    spectrum = fwht(1 - 2 * first)
    assert (np.abs(spectrum) == 64).all()
    second = par[Z[:, None] & W[None, :]] ^ (((W >> 0) & (W >> 1) & 1)[None, :])
    M2 = int((((1 - 2 * second).sum(axis=1)) // 8)[(Z & 3) == 3].sum())
    assert M2 == -4 and (np.abs(fwht(1 - 2 * second)) == 64).all()
    return {"F4": {"I": [2], "V": [1, 2, 4, 8], "w0": 0, "omega": 1,
                   "M": M, "Walsh_abs": 64},
            "F6": {"I": [0, 1], "omega": 0, "M": M2, "Walsh_abs": 64}}


def main():
    report = {"joint": joint_audit(), "false_mod8_counterexamples": false_mod8_examples()}
    # Boolean degree is not the degree of the ordinary integer multilinear lift.
    integer_kappa = [2 * (-1) ** (mask.bit_count() & 1) for mask in range(64)]
    integer_coefficients = mobius(integer_kappa, xor=False)
    assert integer_coefficients[63] == 128
    report["integer_degree_counterexample"] = {"boolean_phase_degree": 1,
        "integer_kappa_degree": 6, "top_coefficient": 128,
        "kappa_mod4": 2}
    report["result"] = "main lemma and compression pass; stronger mod8 claims refuted"
    path = Path(__file__).with_name("auditoria_resultado.json")
    path.write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
    print(json.dumps(report, indent=2))


if __name__ == "__main__":
    main()
