"""Find certified pure-W consequences of the global 50+14 residual."""
import json
from pathlib import Path

import numpy as np

from H16_POLAR_FLAGS import add, null, rref, unpack
from H16_SPECIALIZED_KERNEL import mul, rank, specialize
from SOLVE_STEP53_POLAR_GLOBAL_RESIDUAL import poly_mul
import SOLVE_STEP50_SPLIT_QUOTIENT as step50


def combine(polys, matrix):
    result = []
    for row in matrix:
        value = set()
        for i in np.flatnonzero(row):
            value ^= polys[i]
        result.append(value)
    return result


def multiply(poly, monomial):
    out = set()
    for p in poly:
        out.symmetric_difference_update({p | monomial})
    return out


def residual(coeff, S, rhs):
    cert = json.loads(Path("residual/step53_global_residual.json").read_text())
    N = unpack(cert["fixed_combinations"], 69)
    H = unpack(cert["adjusted_combinations"], 69)
    L = unpack(cert["constant_inverse"], 69)
    C = unpack(cert["r_complement"], 30).T
    assert rank(np.concatenate((N, H, L)), rref) == 69
    origin, _ = specialize(coeff, np.zeros(S.shape[1], dtype=np.uint8), S)
    K = null(np.concatenate([A for p, A in origin.items() if p], axis=0)).T
    assert rank(np.column_stack((C, K)), rref) == 30
    B = {p: mul(A, K) for p, A in coeff.items()}
    for p, A in B.items():
        assert np.array_equal(mul(L, A), np.eye(5, dtype=np.uint8) * (p == 0))
        assert not mul(N, A).any()
    D = {p: mul(A, C) for p, A in coeff.items()}
    fixed = {p: mul(N, A) for p, A in D.items()}
    adjusted = {p: mul(H, A) for p, A in D.items()}
    hb = {p: mul(H, A) for p, A in B.items() if A.any()}
    for p, A in poly_mul(hb, {p: mul(L, A) for p, A in D.items()}).items():
        adjusted.setdefault(p, np.zeros_like(adjusted[0]))
        adjusted[p] ^= A
    assert all(not A.any() for p, A in fixed.items() if p.bit_count() > 1)
    assert all(not A.any() for p, A in adjusted.items() if p.bit_count() > 2)
    left = {p: np.concatenate((fixed.get(p, np.zeros_like(fixed[0])),
                               adjusted.get(p, np.zeros_like(adjusted[0]))))
            for p in fixed.keys() | adjusted.keys()}
    low = combine(rhs, L)
    high = combine(rhs, H)
    for p, A in hb.items():
        for row, col in zip(*np.nonzero(A)):
            high[row] ^= multiply(low[col], p)
    return left, combine(rhs, N) + high


def encoding(terms):
    loc = {p: j for j, p in enumerate(terms)}
    return lambda p: 1 << loc[p]


def dependencies(matrix, rhs, n, include_adjusted, pure, affine_rows=50):
    base = [[] for _ in rhs]
    for monomial, A in matrix.items():
        for row, col in zip(*np.nonzero(A)):
            base[row].append((int(col), monomial))
    multipliers = [0] + [1 << j for j in range(n)]
    generators = [(i, m) for i in range(affine_rows) for m in multipliers]
    if include_adjusted:
        generators.extend((i, 0) for i in range(affine_rows, 64))
    left_terms = sorted({(c, p | m) for i, m in generators for c, p in base[i]},
                        key=lambda cp: (cp[1].bit_count(), cp))
    code = encoding(left_terms)
    low_width = sum(p.bit_count() <= 1 for _, p in left_terms)
    basis = {}
    vectors = []
    relations = []
    for j, (i, multiplier) in enumerate(generators):
        v = 0
        for col, p in base[i]:
            v ^= code((col, p | multiplier))
        vectors.append(v)
        proof = 1 << j
        while v:
            pivot = v.bit_length() - 1
            if pivot not in basis:
                basis[pivot] = (v, proof)
                break
            other, relation = basis[pivot]
            v ^= other
            proof ^= relation
        else:
            relations.append(proof)

    consequences = []
    projected = {}
    for proof in relations:
        add(projected, proof >> (affine_rows * (n + 1)))
        combination = []
        lhs = 0
        poly = set()
        while proof:
            bit = proof & -proof
            j = bit.bit_length() - 1
            proof ^= bit
            i, m = generators[j]
            combination.append((i, m))
            lhs ^= vectors[j]
            poly ^= multiply(rhs[i], m)
        assert lhs == 0
        if poly:
            consequences.append((poly, combination))

    all_polys = pure + [p for p, _ in consequences]
    terms = sorted(set().union(*all_polys), key=lambda p: (p.bit_count(), p))
    positions = {p: i for i, p in enumerate(terms)}
    echelon = {}
    for poly in all_polys:
        add(echelon, sum(1 << positions[p] for p in poly))
    degree = {}
    for pivot in echelon:
        d = terms[pivot].bit_count()
        degree[d] = degree.get(d, 0) + 1
    high = sum(j >= low_width for j in basis)
    report = {"include_adjusted": include_adjusted, "generators": len(generators),
              "quadratic_rank": high, "affine_survivor_rank": len(basis) - high,
              "pure_dependencies": len(relations), "adjusted_dependency_rank": len(projected),
              "nonzero_rhs": len(consequences), "pure_basis_degrees": degree,
              "unit": positions.get(0) in echelon}
    return report, consequences


def probe(coeff, S, rhs, pure, fixed_bits, trial):
    left, result_rhs = residual(coeff, S, rhs)
    print("STEP54_RHS", json.dumps({"fixed_max": max(p.bit_count() for q in result_rhs[:50] for p in q),
                                   "adjusted_max": max(p.bit_count() for q in result_rhs[50:] for p in q),
                                   "initial_pure_count": len(pure)}), flush=True)
    c52 = json.loads(Path("inverse/step52_left_inverse.json").read_text())
    Z = null(unpack(c52["forms"], S.shape[1]))
    restricted, _ = specialize(left, np.zeros(S.shape[1], dtype=np.uint8), Z)
    high = [A for p, A in restricted.items() if p.bit_count() > 1 and A.any()]
    print("STEP54_CHART", json.dumps({"free": len(Z), "quadratic_terms": len(high),
          "quadratic_rank": rank(np.concatenate(high, axis=1), rref) if high else 0}), flush=True)
    results = []
    for adjusted in (False, True):
        report, witnesses = dependencies(left, result_rhs, S.shape[1], adjusted, pure)
        results.append({"report": report, "witnesses": [[sorted(poly), c] for poly, c in witnesses]})
        print("STEP54_SYZ", json.dumps(report), flush=True)
    Path("step54_syzygies.json").write_text(json.dumps(results))


if __name__ == "__main__":
    step50.split_probe = probe
    step50.main()
