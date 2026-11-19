"""Find W directions that can be moved to the linear unknown block."""
from collections import Counter
import json
from pathlib import Path

import numpy as np

from H16_POLAR_FLAGS import encode, null, radical_flag, rref, unpack
from H16_SPECIALIZED_KERNEL import specialize
from SOLVE_STEP53_POLAR_GLOBAL_RESIDUAL import poly_mul
from SOLVE_STEP54_GLOBAL_SYZYGIES import residual


def main():
    data = json.loads(Path("pencil/step41_B0_11.json").read_text())
    _, coeff, S = next(item for item in radical_flag(data) if item[0]==30)
    core, _ = residual(coeff,S,[set() for _ in range(69)])
    n = S.shape[1]
    flag = json.loads(Path("flag/step55_isotropic_flag.json").read_text())
    pivot = json.loads(Path("pivot/step59_branch_free_pivot.json").read_text())
    U = null(unpack(flag["fixed_forms"],n))
    pivs = set(rref(U)[1])
    T = np.eye(n,dtype=np.uint8)[[j for j in range(n) if j not in pivs]]
    u_dim = len(U)
    assert (u_dim,len(T))==(35,9)
    matrix, _ = specialize(core,np.zeros(n,dtype=np.uint8),np.concatenate((U,T)))
    assert pivot["pivot_R_index"]==0
    drop = pivot["rhs_source_row"]
    keep = [i for i in range(64) if i!=drop]
    A = {p: B[keep,1:].copy() for p,B in matrix.items() if B[keep,1:].any()}
    B = {p: C[keep,0].copy()[:,None] for p,C in matrix.items() if C[keep,0].any()}
    v = {int(p)<<u_dim:unpack([row],25)[:,1:] for p,row in pivot["pivot_anf"].items()}
    for p,C in poly_mul(B,v).items():
        A.setdefault(p,np.zeros((63,24),dtype=np.uint8))
        A[p] ^= C
    blocks = {}
    mask = (1<<u_dim)-1
    for p,C in A.items():
        if not C.any():
            continue
        m = p&mask
        assert m.bit_count() <= 1
        if m:
            D = blocks.setdefault(p>>u_dim,np.zeros((63*24,u_dim),dtype=np.uint8))
            D[:,m.bit_length()-1] ^= C.flatten()

    global_kernel = null(np.concatenate(list(blocks.values()),axis=0))
    ranks = Counter()
    spaces = Counter()
    for t in range(512):
        evaluation = np.zeros_like(blocks[0])
        for p,D in blocks.items():
            if p&t==p:
                evaluation ^= D
        K = null(evaluation)
        ranks[len(K)] += 1
        spaces[tuple(encode(K))] += 1
    result = {"matrix_kernel_dim_hist":ranks,"distinct_kernels":len(spaces),
              "most_common":spaces.most_common(8),"global_kernel":encode(global_kernel),
              "global_kernel_dim":len(global_kernel)}
    checks = []
    global_support = set(encode(global_kernel))
    for t in (0,64):
        polys = json.loads(Path(f"fiber{t}/step60_fiber.json").read_text())["polynomials"]
        all_terms = set().union(*map(set,polys))
        for j in range(u_dim):
            if 1<<j not in global_support:
                continue
            support=1<<j
            assert all(not (p&support and p>>u_dim) for p in all_terms)
            moved = [{p^support for p in q if p&support} for q in polys]
            degree = max((p.bit_count() for poly in moved for p in poly),default=0)
            checks.append({"fiber":t,"coordinate":j,"column_degree":degree,
                           "nonzero_rows":sum(bool(q) for q in moved)})
    result["rhs_columns"] = checks
    print("STEP62_TRANSFER",json.dumps(result),flush=True)
    Path("step62_transfer.json").write_text(json.dumps(result))


if __name__=="__main__":
    main()
