"""Global B0_11 SAT with FACTORIZED 64 equations (degrees 3/4) in 69 variables.

Unlike Step70, retain the universal pivot R0 as a variable: the 63 resultant
degree-4/5 equations expand to 2M monomials, whereas 64 parent equations remain
degree <=4. EXACTLY verify symbolic R0 elimination reproduces archived Step70
all-512 quotient-bit ideal, then run the same XOR-aware SAT solver.

UNSAT would eliminate only the parent algebraic B0_11 case whose hypotheses
were used to build the Step41 data. SAT/TIMEOUT cannot establish bentness.
"""
from collections import Counter
import json
import os
from pathlib import Path
import time

import numpy as np
from H16_POLAR_FLAGS import null,rref,unpack
from H16_SPECIALIZED_KERNEL import specialize,transform,poly_product
from SOLVE_STEP54_GLOBAL_SYZYGIES import residual
import SOLVE_STEP50_SPLIT_QUOTIENT as step50
import SOLVE_STEP60_FIBER_REDUCTION_AND_XOR as step60

NU=35
NT=9
BASE=NU+NT
PIVOT=36
TOTAL_VARIABLES=69


def main_probe(coeff,S,rhs,pure,_fixed_bits,_trial):
    started=time.monotonic()
    matrix,redrhs=residual(coeff,S,rhs)
    flag=json.loads(Path("flag/step55_isotropic_flag.json").read_text())
    n=S.shape[1]
    U=null(unpack(flag["fixed_forms"],n))
    piv=set(rref(U)[1])
    J=np.eye(n,dtype=np.uint8)[[j for j in range(n) if j not in piv]]
    assert len(U)==NU and len(J)==NT
    M,forms=specialize(matrix,np.zeros(n,dtype=np.uint8),np.concatenate((U,J)))
    cache={0:{0}}
    c=[transform(poly,forms,cache) for poly in redrhs]
    extra=[transform(poly,forms,cache) for poly in pure]
    assert M[0].shape==(64,25)
    assert len(c)==64 and not extra
    equations=[set(p) for p in c]
    for m,A in M.items():
        for i,j in zip(*np.nonzero(A)):
            equations[int(i)].symmetric_difference_update({m|(1<<(BASE+int(j)))})
    assert all(all(term.bit_length()<=TOTAL_VARIABLES for term in p) for p in equations)
    degree=Counter(max((m.bit_count() for m in p),default=-1) for p in equations)
    assert max(degree)<=4,degree
    assert degree[3]==50 and degree[4]==14,degree
    # Explicit exact algebraic equivalence with Step70 global 63 equations.
    pivot=json.loads(Path("pivot/step59_branch_free_pivot.json").read_text())
    assert pivot["rhs_source_row"]==PIVOT and pivot["pivot_R_index"]==0
    for m,A in M.items():
        assert int(A[PIVOT,0])==int(m==0)
    rhs_pivot=c[PIVOT]
    v={j:{m for m,A in M.items() if A[PIVOT,j]} for j in range(1,25)}
    reduced=[]
    for i in range(64):
        f={m for m,A in M.items() if A[i,0]}
        eq=c[i]^poly_product(f,rhs_pivot)
        for j in range(1,25):
            old={m for m,A in M.items() if A[i,j]}
            a=old^poly_product(f,v[j])
            for p in a:
                eq.symmetric_difference_update({p|(1<<(BASE+j-1))})
        if i==PIVOT:
            assert not eq
        else:
            reduced.append(sorted(eq))
    assert len(reduced)==63
    old=json.loads(Path("global/step70_global_fiber_ideal.json").read_text())
    assert old["variables"]==68 and old["original_count"]==63
    assert reduced==old["polynomials"],"Lossless exact symbolic crosscheck against Step70 failed"
    result={
        "parent_variables":TOTAL_VARIABLES,
        "parent_equations":len(equations),
        "parent_degree_profile":degree,
        "parent_monomial_occurrences":sum(map(len,equations)),
        "parent_unique_monomials":len(set().union(*equations)),
        "parent_max_equation":max(map(len,equations)),
        "step70_68var_exact_replay":True,
        "step70_quotient_offsets":512,
        "construction_seconds":round(time.monotonic()-started,2),
    }
    dest=Path("step72_factorized_global_ideal.json")
    dest.write_text(json.dumps({"variables":TOTAL_VARIABLES,
             "polynomials":[sorted(p) for p in equations],
             "original_count":len(equations),
             "source":"B0_11 Step54/59 before branch-free pivot elimination",
             "exact_step70_replay":True}))
    print("STEP72_FACTORIZED_SYSTEM",json.dumps(result,default=int),flush=True)
    probe=step60.try_xor(dest,int(os.environ.get("H16_GLOBAL_SOLVER_SEC","300")))
    if probe["status"]=="SAT":
        point=probe["point"]
        assert all(sum((m&point)==m for m in poly)%2==0 for poly in equations)
        result["verified_parent_system_model"]=True
    result["solver"]=probe
    Path("step72_factorized_global_result.json").write_text(json.dumps(result,indent=2,default=int)+"\n")
    print("STEP72_FACTORIZED_SOLVER",json.dumps(result,default=int),flush=True)


if __name__=="__main__":
    step50.split_probe=main_probe
    step50.main()
