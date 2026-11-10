"""Degree-three linear consequences for sparse higher-part projection systems."""

import argparse
import json
from functools import lru_cache
from itertools import combinations
from pathlib import Path
from time import perf_counter

from higher_filter import solve, xor_terms
from higher_project import UPPER, TOP, eliminate_lower, polynomial_linear_relations, union_system

DIM = len(TOP)
@lru_cache(maxsize=None)
def monomial_space(width):
    monomials = [0] + [sum(1 << i for i in c) for d in (1, 2, 3)
                      for c in combinations(range(width), d)]
    return monomials, {m: i for i, m in enumerate(monomials)}


def bits(mask):
    while mask:
        bit = mask & -mask
        yield bit.bit_length() - 1
        mask ^= bit


def linear_closure(polynomials, width=DIM):
    """Return the affine part of the row space of P and x_i P."""
    monomials, index = monomial_space(width)
    rows = {}
    for i, polynomial in enumerate(polynomials):
        for j in range(-1, width):
            multiplier = 0 if j < 0 else 1 << j
            lifted = set()
            for m in polynomial:
                lifted.symmetric_difference_update((m | multiplier,))
            row = sum(1 << index[m] for m in lifted)
            certificate = 1 << (i * (width + 1) + j + 1)
            while row:
                pivot = row.bit_length() - 1
                if pivot in rows:
                    x, c = rows[pivot]
                    row ^= x
                    certificate ^= c
                else:
                    rows[pivot] = (row, certificate)
                    break
    result = {}
    for pivot, (row, reason) in rows.items():
        if pivot > width:
            continue
        reconstructed = set()
        for term in bits(reason):
            i, j = divmod(term, width + 1)
            multiplier = 0 if j == 0 else 1 << (j - 1)
            for m in polynomials[i]:
                reconstructed.symmetric_difference_update((m | multiplier,))
        assert reconstructed == {monomials[k] for k in bits(row)}
        result[pivot] = {"terms": [monomials[k] for k in bits(row)],
                         "certificate": list(bits(reason))}
    return result


def substitute(polynomials, root, basis, width):
    affine = [{1 << i for i, v in enumerate(basis) if v & (1 << j)}
              | ({0} if root & (1 << j) else set()) for j in range(width)]
    terms = {0: {0}}
    terms.update({1 << j: expr for j, expr in enumerate(affine)})
    for polynomial in polynomials:
        for term in polynomial:
            if term not in terms:
                i, j = bits(term)
                product = set()
                for a in affine[i]:
                    for b in affine[j]:
                        product.symmetric_difference_update((a | b,))
                terms[term] = product
    result = []
    for polynomial in polynomials:
        row = set()
        for term in polynomial:
            row.symmetric_difference_update(terms[term])
        if row:
            result.append(row)
    return result


def reduce_iteratively(polynomials):
    root = 0
    basis = [1 << j for j in range(DIM)]
    stages = []
    while True:
        width = len(basis)
        closed = linear_closure(polynomials, width)
        if 0 in closed:
            return None, [], [], stages, closed[0]
        if not closed:
            return root, basis, polynomials, stages, None
        equations = [(sum(m for m in e["terms"] if m), int(0 in e["terms"]))
                     for e in closed.values()]
        a, b, rank = solve(equations, width)
        assert a is not None and rank > 0
        stages.append(rank)
        polynomials = substitute(polynomials, a, b, width)
        root ^= xor_terms(basis, a)
        basis = [xor_terms(basis, v) for v in b]


def test_one(i):
    m, o = UPPER[i]
    low, residual = eliminate_lower(union_system(1 << i))
    affine, contradiction = polynomial_linear_relations(residual)
    _, basis, _, stages, certificate = reduce_iteratively(residual)
    assert not contradiction or certificate is not None
    return {"index": i, "degree": m.bit_count(), "orbit_rep": m, "orbit_size": len(o),
            "lower_rank": len(low), "quartic_linear_rank": len(affine),
            "quartic_free_after_iteration": len(basis), "linear_stages": stages,
            "contradiction": certificate is not None,
            "xl_contradiction_certificate": certificate}


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--shard", type=int, default=0)
    p.add_argument("--shards", type=int, default=1)
    p.add_argument("--limit", type=int)
    p.add_argument("--output", type=Path, required=True)
    a = p.parse_args()
    start = perf_counter()
    indices = list(range(a.shard, len(UPPER), a.shards))
    if a.limit is not None:
        indices = indices[:a.limit]
    results = []
    for i in indices:
        row = test_one(i)
        results.append(row)
        print({k:v for k,v in row.items() if k != "xl_contradiction_certificate"}, flush=True)
    a.output.write_text(json.dumps({"shard":a.shard,"shards":a.shards,
                                    "results":results,"seconds":perf_counter()-start},indent=2)+"\n")


if __name__ == "__main__":
    main()
