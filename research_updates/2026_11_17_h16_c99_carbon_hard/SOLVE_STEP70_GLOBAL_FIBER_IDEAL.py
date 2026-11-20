"""Build the global 68-variable necessary polynomial system for B0_11.

Retains all 9 quotient bits (512 fibers) instead of fixing one fiber. Eliminates
the branch-free pivot from Step59 SYMBOLICALLY for all quotient assignments,
and cross-checks exact specialization against archived Step60 fibers 0 and 64.

If this complete necessary system is UNSAT, then B0_11 is impossible.
SAT/UNKNOWN/TIMEOUT do not close the cell. No claim about other H16 cells.
"""
from collections import Counter
import hashlib
import json
import os
from pathlib import Path
import random
import time

import numpy as np
from H16_POLAR_FLAGS import null, rref, unpack
from H16_SPECIALIZED_KERNEL import specialize, transform, poly_product
from SOLVE_STEP54_GLOBAL_SYZYGIES import residual
import SOLVE_STEP50_SPLIT_QUOTIENT as step50
import SOLVE_STEP60_FIBER_REDUCTION_AND_XOR as step60

PIVOT_ROW=36
N_U=35
N_T=9
N_BASE=N_U+N_T
N_R=24


def eqval(poly,point):
    return sum((monom & point)==monom for monom in poly)&1


def quotient_specialization(poly,offset):
    """Substitute t=offset, compact original 24 right bits from 44..67 to 35..58."""
    out=set()
    for m in poly:
        t=(m>>N_U)&((1<<N_T)-1)
        if (t&offset)!=t:
            continue
        compact=(m&((1<<N_U)-1)) | ((m>>N_BASE)<<N_U)
        if compact in out:out.remove(compact)
        else:out.add(compact)
    return out


def crosscheck(polys,offset,path):
    data=json.loads(Path(path).read_text())
    assert data["variables"]==59 and data["original_count"]==63
    ref=[set(poly) for poly in data["polynomials"][:63]]
    comp=[quotient_specialization(poly,offset) for poly in polys]
    assert len(ref)==len(comp)==63
    # Same ordered original 63 rows, not just a shared row span.
    exact=comp==ref
    if not exact:
        differences=[i for i,(a,b) in enumerate(zip(comp,ref)) if a!=b]
        print("STEP70_CROSSCHECK_DIFFERENCES",offset,len(differences),differences[:12],flush=True)
    return exact


def main_probe(coeff,S,rhs,pure,_fixed_bits,_trial):
    started=time.monotonic()
    matrix,redrhs=residual(coeff,S,rhs)
    flag=json.loads(Path("flag/step55_isotropic_flag.json").read_text())
    pivot=json.loads(Path("pivot/step59_branch_free_pivot.json").read_text())
    n=S.shape[1]
    U=null(unpack(flag["fixed_forms"],n))
    piv=set(rref(U)[1])
    J=np.eye(n,dtype=np.uint8)[[j for j in range(n) if j not in piv]]
    assert len(U)==N_U and len(J)==N_T and pivot["rhs_source_row"]==PIVOT_ROW
    assert pivot["pivot_R_index"]==0
    M,forms=specialize(matrix,np.zeros(n,dtype=np.uint8),np.concatenate((U,J)))
    cache={0:{0}}
    c=[transform(poly,forms,cache) for poly in redrhs]
    pure_c=[transform(poly,forms,cache) for poly in pure]
    assert M[0].shape==(64,25)
    v={j:set() for j in range(1,25)}
    for k,word in pivot["pivot_anf"].items():
        k=int(k)
        for j in range(1,25):
            if (word>>j)&1:
                v[j].add(k<<N_U)
    # Verify the pivot identity as an exact polynomial over all 44 coordinates.
    for monomial,A in M.items():
        assert A[PIVOT_ROW,0]==(monomial==0), ("pivot col0",monomial)
        for j in range(1,25):
            assert A[PIVOT_ROW,j]==(monomial in v[j]), ("pivot col",j,monomial)
    rhs_pivot=c[PIVOT_ROW]
    # Symbolic substitution R0=rhs_pivot + sum_j v_j(t)*R_j.
    equations=[]
    for i in range(64):
        first={p for p,A in M.items() if A[i,0]}
        eq=c[i] ^ poly_product(first,rhs_pivot)
        for j in range(1,25):
            old={p for p,A in M.items() if A[i,j]}
            new=old ^ poly_product(first,v[j])
            shift=1<<(N_BASE+j-1)
            for p in new:
                eq.symmetric_difference_update({p|shift})
        if i==PIVOT_ROW:
            assert not eq
        else:
            equations.append(eq)
    assert len(equations)==63
    assert not pure_c, ("unexpected extra pure conditions",len(pure_c))
    assert all(m.bit_length()<=N_BASE+N_R for p in equations for m in p)
    degree=Counter(max((m.bit_count() for m in p),default=-1) for p in equations)
    # Random exact equivalence: old 64 equations vs new 63 after lifted R0.
    randomizer=random.Random(700165)
    for _ in range(96):
        u_t=randomizer.getrandbits(N_BASE)
        tail=randomizer.getrandbits(N_R)
        r0=eqval(rhs_pivot,u_t)
        for j in range(1,25):
            if (tail>>(j-1))&1:
                r0 ^= eqval(v[j],u_t)
        original_r=r0 | (tail<<1)
        oldval=[]
        for i in range(64):
            bit=eqval(c[i],u_t)
            for p,A in M.items():
                if (p&u_t)!=p:continue
                bit ^= int((original_r & sum((int(A[i,j])<<j) for j in range(25))).bit_count()&1)
            oldval.append(bit)
        newpoint=u_t | (tail<<N_BASE)
        assert oldval[PIVOT_ROW]==0
        assert [x for j,x in enumerate(oldval) if j!=PIVOT_ROW]==[eqval(poly,newpoint) for poly in equations]
    matches={str(t):crosscheck(equations,t,f"fiber{t}/step60_fiber.json") for t in (0,64)}
    assert all(matches.values()), "global specialization does not reconstruct Step60: UNSAFE TO PROCEED"
    polys=[sorted(p) for p in equations]
    source={"variables":68,"polynomials":polys,"original_count":63,
            "source":"B0_11 Step54/59 global symbolic elimination",
            "crosschecks":matches,"degree_profile":degree}
    dest=Path("step70_global_fiber_ideal.json")
    dest.write_text(json.dumps(source))
    report={"variables":68,"equations":63,"quotient_bits":9,"fibers":512,
            "crosschecks":matches,"degree_profile":degree,
            "monomials_total":sum(len(p) for p in equations),
            "largest_equation":max(map(len,equations)),
            "construction_seconds":round(time.monotonic()-started,2)}
    print("STEP70_GLOBAL_SYSTEM",json.dumps(report),flush=True)
    probe=step60.try_xor(dest,int(os.environ.get("H16_GLOBAL_SOLVER_SEC","180")))
    if probe["status"]=="SAT":
        point=probe["point"]
        assert all(eqval(p,point)==0 for p in equations)
        report["quotient_offset"]=(point>>N_U)&((1<<N_T)-1)
        report["verified_reduced_solution"]=True
    report["solver"]=probe
    Path("step70_global_fiber_result.json").write_text(json.dumps(report,indent=2,default=int)+"\n")
    print("STEP70_GLOBAL_SOLVER",json.dumps(report,default=int),flush=True)


if __name__=="__main__":
    step50.split_probe=main_probe
    step50.main()
