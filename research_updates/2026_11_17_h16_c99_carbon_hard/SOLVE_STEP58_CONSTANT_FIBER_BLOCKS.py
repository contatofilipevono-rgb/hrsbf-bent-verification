"""Audit constant row and column blocks on all 512 isotropic fibers."""
from collections import Counter
import json
from pathlib import Path

import numpy as np

from H16_POLAR_FLAGS import encode, null, radical_flag, rref, unpack
from H16_SPECIALIZED_KERNEL import mul, rank, specialize
from SOLVE_STEP54_GLOBAL_SYZYGIES import residual


def blocks(matrix, U, J):
    n = U.shape[1]
    w = len(U)
    values, _ = specialize(matrix, np.zeros(n, dtype=np.uint8), np.concatenate((U,J)))
    zero = np.zeros_like(values[0])
    def at(p):
        return values.get(p, zero)

    assert not any(A.any() for p,A in values.items() if p.bit_count() > 2 or
                   (p.bit_count() == 2 and p < (1 << w)))
    slope = np.array([at(1 << j) for j in range(w)])
    updates = [np.array([at((1 << j) | (1 << (w+k))) for j in range(w)]) for k in range(len(J))]
    base = values[0].copy()
    linear = [at(1 << (w+j)).copy() for j in range(len(J))]
    changes = [[at((1 << (w+j)) | (1 << (w+k))) if j != k else zero
                for k in range(len(J))] for j in range(len(J))]
    for i in range(1 << len(J)):
        if i:
            j = (i & -i).bit_length()-1
            base ^= linear[j]
            for k in range(len(J)):
                linear[k] ^= changes[j][k]
            slope ^= updates[j]
        yield i ^ (i >> 1), base, slope


def main():
    data = json.loads(Path("pencil/step41_B0_11.json").read_text())
    _, coeff, S = next(item for item in radical_flag(data) if item[0] == 30)
    matrix, _ = residual(coeff, S, [set() for _ in range(69)])
    n = S.shape[1]
    cert = json.loads(Path("flag/step55_isotropic_flag.json").read_text())
    U = null(unpack(cert["fixed_forms"], n))
    pivots = set(rref(U)[1])
    J = np.eye(n, dtype=np.uint8)[[j for j in range(n) if j not in pivots]]
    result = []
    hist = Counter()
    coefficients = Counter()
    for offset, M, A in blocks(matrix, U, J):
        left = null(A.transpose(1,0,2).reshape(64,-1).T)
        right = null(A.reshape(-1,25))
        constant = mul(left, M)
        constant_B = mul(M, right.T)
        left_rank = rank(constant, rref)
        right_rank = rank(constant_B, rref)
        assert left_rank <= len(left) and right_rank <= len(right)
        hist[str((len(left),left_rank,len(right),right_rank))] += 1
        basis = tuple(encode(rref(constant)[0][:left_rank]))
        coefficients[basis] += 1
        result.append({"offset":offset,"constant_rows":encode(left),"constant_R":basis,
                       "right_kernel":encode(right),"eliminable_right":right_rank})
    profile = {"histogram":hist, "different_constant_R_spaces":len(coefficients),
               "most_common":coefficients.most_common(6)}
    Path("step58_constant_fiber_blocks.json").write_text(json.dumps({"profile":profile,"fibers":result}))
    print("STEP58_BLOCKS",json.dumps(profile),flush=True)


if __name__ == "__main__":
    main()
