"""Attempt a *proof-checked* affine TRANSLATION between Step60 fibers 0 and 64.

These systems have 63 cubic equations in 59 Boolean coordinates. The change
x -> x + delta preserves cubic symbols, and its effect on quadratic
coefficients is linear in delta. Use this to solve exactly and then verify the
full translated polynomial identities, including linear/constant terms.

Passing certifies identical solution sets under translation. Failing does not
exclude other affine linear transformations or higher-degree ideal identities.
"""
from itertools import combinations
import json
from pathlib import Path

N=59
MASK=(1<<N)-1

def unpack_full(data):
    assert data["variables"]==N and data["original_count"]==63
    out=[]
    for poly in data["polynomials"][:63]:
        word=set(poly)
        assert len(word)==len(poly)
        assert all(0<=m<(1<<N) and m.bit_count()<=3 for m in word)
        out.append(word)
    return out

def canonical_cubic(polys, map_cubic):
    """RREF with leading degree-3 symbols; carry full polynomials."""
    pivots={}
    for poly in polys:
        sig=0
        for m in poly:
            if m.bit_count()==3:
                sig ^= 1<<map_cubic[m]
        out=set(poly)
        while sig:
            b=sig.bit_length()-1
            if b not in pivots:
                pivots[b]=(sig,out)
                break
            sig ^= pivots[b][0]
            out.symmetric_difference_update(pivots[b][1])
        assert sig != 0, "Cubic symbol rank is lower than 63"
    # RREF, preserving signatures and polynomial rows.
    for b in sorted(pivots):
        for c in sorted(pivots):
            if c != b and (pivots[c][0]>>b)&1:
                s,p=pivots[c]
                s ^= pivots[b][0]
                p=p.symmetric_difference(pivots[b][1])
                pivots[c]=(s,p)
    return [(pivots[b][0],pivots[b][1]) for b in sorted(pivots,reverse=True)]

def linear_solve(rows,n):
    basis={}
    for coeff,rhs in rows:
        v=coeff | (rhs<<n)
        while (v & ((1<<n)-1)):
            p=(v & ((1<<n)-1)).bit_length()-1
            if p in basis:
                v ^= basis[p]
            else:
                basis[p]=v
                break
        else:
            if (v>>n)&1:
                return None,len(basis),True
    delta=0
    for p in sorted(basis):
        rhs=(basis[p]>>n)&1
        rhs ^= (delta & (basis[p]&((1<<p)-1))).bit_count()&1
        if rhs:
            delta |= 1<<p
    assert all(((c&delta).bit_count()&1)==b for c,b in rows)
    return delta,len(basis),False

def shift_poly(poly, delta):
    out=set()
    for monomial in poly:
        excluded = monomial & delta
        sub=excluded
        while True:
            val=monomial^sub
            if val in out: out.remove(val)
            else: out.add(val)
            if sub==0:break
            sub=(sub-1)&excluded
    return out

def main():
    a=unpack_full(json.loads(Path("fiber0/step60_fiber.json").read_text()))
    b=unpack_full(json.loads(Path("fiber64/step60_fiber.json").read_text()))
    cubic=sorted({m for p in a+b for m in p if m.bit_count()==3})
    map_cubic={m:i for i,m in enumerate(cubic)}
    left=canonical_cubic(a,map_cubic)
    right=canonical_cubic(b,map_cubic)
    result={"scope":"B0_11 reduced fibers 0 and 64", "cubic_monomials":len(cubic),
            "rank_symbols_0":len(left),"rank_symbols_64":len(right),
            "common_cubic_span": [x[0] for x in left]==[x[0] for x in right]}
    if not result["common_cubic_span"]:
        result["outcome"]="NO_CUBIC_SPAN_EQUIVALENCE"
    else:
        eqs=[]
        for (_,src),(_,dst) in zip(left,right):
            all_quads={m for m in src|dst if m.bit_count()==2}
            for m in all_quads:
                # A translation of a cubic term with variables m + j contributes
                # delta_j to quadratic coefficient of m.
                coefficient=0
                for j in range(N):
                    if m>>j&1: continue
                    if m|(1<<j) in src:
                        coefficient ^= 1<<j
                rhs=(m in dst) ^ (m in src)
                if coefficient or rhs:
                    eqs.append((coefficient,int(rhs)))
        solution,rank,inconsistent=linear_solve(eqs,N)
        result.update({"quadratic_translation_equations":len(eqs),
            "linear_constraint_rank":rank, "linear_system_inconsistent":inconsistent,
            "sample_translation":solution})
        if inconsistent:
            result["outcome"]="NO_TRANSLATION_BY_QUADRATIC_INVARIANT"
        else:
            translated=[shift_poly(poly,solution) for _,poly in left]
            residual=[list(sorted(x.symmetric_difference(y[1]))) for x,y in zip(translated,right)]
            matching=all(not x for x in residual)
            result.update({"candidate_exact":matching,"mismatching_rows":sum(bool(x) for x in residual)})
            result["outcome"]="VERIFIED_TRANSLATION_EQUIVALENCE" if matching else "NO_EXACT_EQUIVALENCE_FOR_PARTICULAR_SOLUTION"
            if matching:
                assert [shift_poly(q,solution) for _,q in left]==[q for _,q in right]
                result["proof"]="Canonical cubic RREF rows match after the explicit invertible x -> x+delta translation."
    Path("step68_affine_translation.json").write_text(json.dumps(result,indent=2)+"\n")
    print("STEP68_TRANSLATION",json.dumps(result),flush=True)


if __name__=="__main__":
    main()
