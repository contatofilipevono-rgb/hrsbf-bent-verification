"""Universal finite linear certificate for homogeneous cubic RS in n=32.

All 155 basis generators are regenerated. The accompanying mathematical
proof supplies the necessity of the all-ones derivative polar equations.
No SAT result, sampled H restriction, or truth-table enumeration is assumed.
"""
import itertools
import json
from pathlib import Path
import random
import sys
from audit_all_ones_obstruction import orbits, polar

def fiber_anf(orbit,z):
    result=set()
    for support in orbit:
        terms={0}
        for v in support:
            i=v%16;factor=[1<<i]
            if v>=16 and z>>i&1:factor.append(0)
            product=set()
            for a in terms:
                for b in factor:
                    c=a|b
                    if c in product:product.remove(c)
                    else:product.add(c)
            terms=product
        result.symmetric_difference_update(terms)
    return result

def evaluation(orbit,x):
    return sum(all(x>>i&1 for i in s) for s in orbit)%2

def generate():
    oo=orbits(32,3);assert len(oo)==155
    global_rows=[0]*31;fiber_rows={};rng=random.Random(20261006);checks=0
    for k,(_,orb) in enumerate(oo):
        B=polar(32,orb)
        for i in range(32):
            expected=((B[0]<<i)|(B[0]>>(32-i)))&((1<<32)-1) if i else B[0]
            assert B[i]==expected
        for j in range(1,32):
            if B[0]>>j&1:global_rows[j-1]|=1<<k
            # Independently evaluate the third difference on eight vertices.
            value=0
            for a,b,c in itertools.product((0,1),repeat=3):
                x=(((1<<32)-1) if a else 0)^(1 if b else 0)^((1<<j) if c else 0)
                value^=evaluation(orb,x)
            assert value==(B[0]>>j&1);checks+=1
        zero=fiber_anf(orb,0);assert not zero
        q=fiber_anf(orb,65535);assert all(m.bit_count()<=2 for m in q)
        for m in q:
            if m:fiber_rows[m]=fiber_rows.get(m,0)^(1<<k)
        for u in [0]+[1<<i for i in range(16)]+[rng.randrange(65536) for _ in range(32)]:
            value=sum((u&m)==m for m in q)%2
            assert value==evaluation(orb,u|((u^65535)<<16));checks+=1
            rotated=((u<<1)&65535)|(u>>15)
            assert value==sum(((rotated^1)&m)==m for m in q)%2;checks+=1
    piv={}
    for j,row in enumerate(global_rows,1):
        origin=1<<j
        while row:
            p=row.bit_length()-1
            if p not in piv:piv[p]=(row,origin);break
            a,b=piv[p];row^=a;origin^=b
    identities=[]
    for term in [1<<i for i in range(16)]+[(1<<i)|(1<<j) for i,j in itertools.combinations(range(16),2)]:
        original=fiber_rows.get(term,0);row=original;origin=0
        for p in sorted(piv,reverse=True):
            if row>>p&1:a,b=piv[p];row^=a;origin^=b
        assert row==0,('unproved fiber coefficient',hex(term))
        combination=[j for j in range(1,32) if origin>>j&1]
        reconstructed=0
        for j in combination:reconstructed^=global_rows[j-1]
        assert reconstructed==original
        identities.append({'fiber_term_mask':hex(term),'coefficient_row_155':hex(original),'derivative_polar_columns':combination})
    return {'scope':'All homogeneous cubic rotation-symmetric Boolean functions in 32 variables, not all dimensions or degrees',
            'basis_155':[list(s) for s,_ in oo],
            'derivative_polar_equations':[{'column':j,'row_155':hex(r),'rhs':0} for j,r in enumerate(global_rows,1)],
            'derivative_polar_constraint_rank':len(piv),
            'complementary_fiber_nonconstant_coefficient_identities':identities,
            'identities_verified':len(identities),'direct_anf_and_invariance_checks':checks,
            'status':'PASS','conclusion':'Every solution of the necessary derivative-polar equations has a constant complementary-diagonal fiber; with the zero diagonal fiber this contradicts bentness.'}

if __name__=='__main__':
    if not __debug__:raise RuntimeError('Run without -O.')
    report=generate();Path(sys.argv[1]).write_text(json.dumps(report,indent=2)+'\n')
    print({k:report[k] for k in ('status','derivative_polar_constraint_rank','identities_verified','direct_anf_and_invariance_checks','scope')})
