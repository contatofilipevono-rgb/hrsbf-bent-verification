"""Verify a branch-free pivot from the constant equations on 512 fibers."""
from collections import Counter
import json
from functools import reduce
from operator import and_
from pathlib import Path

import numpy as np

from H16_POLAR_FLAGS import encode, null, radical_flag, rref, unpack
from H16_SPECIALIZED_KERNEL import mul, specialize
from SOLVE_STEP53_POLAR_GLOBAL_RESIDUAL import poly_mul
from SOLVE_STEP54_GLOBAL_SYZYGIES import residual


def anf(table, bits=9):
    coeff = list(table)
    for j in range(bits):
        for point in range(1 << bits):
            if point >> j & 1:
                coeff[point] ^= coeff[point ^ (1 << j)]
    return {p:v for p,v in enumerate(coeff) if v}


def forms_for_vector(anf_vector):
    active = np.zeros(9,dtype=np.uint8)
    for p in anf_vector:
        for j in range(9):
            active[j] |= (p>>j)&1
    return int(active.sum())


def main():
    cert = json.loads(Path("blocks/step58_constant_fiber_blocks.json").read_text())["fibers"]
    rows, right = [0]*512, [0]*512
    assert {r["offset"] for r in cert} == set(range(512))
    for row in cert:
        (rows[row["offset"]],) = row["constant_rows"]
        (right[row["offset"]],) = row["constant_R"]
    left_polys, right_polys = anf(rows), anf(right)
    fixed_row_mask = reduce(and_,rows)
    fixed_col_mask = reduce(and_,right)
    assert fixed_col_mask
    pivot = (fixed_col_mask&-fixed_col_mask).bit_length()-1

    data = json.loads(Path("pencil/step41_B0_11.json").read_text())
    _, coeff, S = next(item for item in radical_flag(data) if item[0] == 30)
    M, _ = residual(coeff, S, [set() for _ in range(69)])
    flag = json.loads(Path("flag/step55_isotropic_flag.json").read_text())
    n = S.shape[1]
    U = null(unpack(flag["fixed_forms"],n))
    pv = set(rref(U)[1])
    J = np.eye(n,dtype=np.uint8)[[j for j in range(n) if j not in pv]]
    lift = len(U)
    assert lift == 35 and len(J) == 9
    adjusted, _ = specialize(M,np.zeros(n,dtype=np.uint8),np.concatenate((U,J)))
    left = {p<<lift:unpack([row],64) for p,row in left_polys.items()}
    target = {p<<lift:unpack([v],25) for p,v in right_polys.items()}
    contraction = poly_mul(left,adjusted)
    assert contraction.keys() == target.keys()
    assert all(np.array_equal(contraction[p],A) for p,A in target.items())

    keep = [j for j in range(25) if j != pivot]
    quotient = {p:A[:,keep].copy() for p,A in adjusted.items() if A.any()}
    column = {p:A[:,[pivot]] for p,A in adjusted.items() if A[:,pivot].any()}
    correction = poly_mul(column, {p:A[:,keep] for p,A in target.items()})
    for p,A in correction.items():
        quotient.setdefault(p,np.zeros_like(quotient[0]))
        quotient[p] ^= A
    assert all((p & ((1<<lift)-1)).bit_count() <= 1 for p,A in quotient.items() if A.any())
    drop = None
    if fixed_row_mask:
        drop = (fixed_row_mask&-fixed_row_mask).bit_length()-1
        survivors = [i for i in range(64) if i != drop]
        quotient = {p:A[survivors] for p,A in quotient.items()}
    degrees = Counter()
    for p,A in quotient.items():
        if A.any():
            degrees[p.bit_count()] += int(A.sum())
    report = {"left_degree":max(p.bit_count() for p in left_polys),
              "left_monomials":len(left_polys), "left_variables":forms_for_vector(left_polys),
              "pivot_degree":max(p.bit_count() for p in right_polys),
              "pivot_anf":right_polys, "rhs_source_row":drop, "pivot_R_index":pivot,
              "fixed_row_mask":fixed_row_mask, "fixed_col_mask":fixed_col_mask,
              "matrix_shape":list(quotient[0].shape),"matrix_degrees_U_T":degrees}
    Path("step59_branch_free_pivot.json").write_text(json.dumps({**report,"left_anf":left_polys}))
    print("STEP59_PIVOT",json.dumps(report),flush=True)


if __name__ == "__main__":
    main()
