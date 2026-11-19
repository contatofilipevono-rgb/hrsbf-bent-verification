"""Search bounded-degree certificates on two complete reduced fibers."""
import json
from pathlib import Path

import numpy as np

from H16_POLAR_FLAGS import add, rref
from H16_SPECIALIZED_KERNEL import poly_product, rank
from SOLVE_STEP60_FIBER_REDUCTION_AND_XOR import bits


def split_polynomial(poly, n, r):
    u = (1 << n)-1
    terms = {}
    rhs = set()
    for m in poly:
        monomial = m & u
        coeff = m >> n
        if coeff:
            assert coeff.bit_count() == 1 and coeff.bit_length() <= r and monomial.bit_count() <= 1
            terms[monomial] = terms.get(monomial,0) ^ coeff
        else:
            rhs.add(monomial)
    return terms, rhs


def build_certificate(rows, n, r, anchors):
    directions = [1<<j for j in range(n)]
    quadratic = sorted({(1<<a) | v for a in anchors for v in directions if v != 1<<a})
    multipliers = [0] + directions + quadratic
    monomials = sorted({p | m for p in [0]+directions for m in multipliers},
                       key=lambda p:(p.bit_count(),p))
    location = {p:r*i for i,p in enumerate(monomials)}
    basis = {}
    lhs_rows = []
    dependent = []
    for k,m in enumerate(multipliers):
        for i,(terms,_) in enumerate(rows):
            row = 0
            for p,coeff in terms.items():
                row ^= coeff << location[m|p]
            lhs_rows.append(row)
            proof = 1 << (k*len(rows)+i)
            while row:
                j = row.bit_length()-1
                if j not in basis:
                    basis[j] = (row,proof)
                    break
                pivot, witness = basis[j]
                row ^= pivot
                proof ^= witness
            else:
                dependent.append(proof)

    polys = []
    witnesses = []
    for v in dependent:
        pure = set()
        check = 0
        trace = []
        for j in bits(v):
            k,i = divmod(j,len(rows))
            check ^= lhs_rows[j]
            pure ^= poly_product(rows[i][1],{multipliers[k]})
            trace.append((i,multipliers[k]))
        assert check==0
        if pure:
            polys.append(pure)
            witnesses.append(trace)
    pure_terms = sorted(set().union(*polys),key=lambda p:(p.bit_count(),p))
    pure_index = {p:i for i,p in enumerate(pure_terms)}
    pure_basis = {}
    for poly in polys:
        add(pure_basis,sum(1<<pure_index[p] for p in poly))
    result = {"anchors":anchors,"multipliers":len(multipliers),"expanded_rows":len(lhs_rows),
              "coefficient_columns":r*len(monomials),"coefficient_rank":len(basis),
              "dependencies":len(dependent),"pure_rank":len(pure_basis),
              "unit":pure_index.get(0) in pure_basis}
    return result,[(sorted(p),w) for p,w in zip(polys,witnesses)]


def main():
    data = json.loads(Path("fiber/step60_fiber.json").read_text())
    n,r = 35,24
    rows = [split_polynomial(poly,n,r) for poly in data["polynomials"][:data["original_count"]]]
    assert len(rows) == 63
    slopes = []
    for a in range(n):
        matrix = np.array([[(terms.get(1<<a,0)>>j)&1 for j in range(r)] for terms,_ in rows],dtype=np.uint8)
        slopes.append((rank(matrix,rref),a))
    slopes.sort()
    report,trace = build_certificate(rows,n,r,[a for _,a in slopes[:2]])
    print("STEP61_CERTIFICATE",json.dumps({"lowest_slopes":slopes[:5],**report}),flush=True)
    Path("step61_certificate.json").write_text(json.dumps({"report":report,"trace":trace}))


if __name__ == "__main__":
    main()
