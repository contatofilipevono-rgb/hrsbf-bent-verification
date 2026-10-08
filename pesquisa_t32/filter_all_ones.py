"""Reproduce the global necessary linear filter; not a bentness test."""
import itertools
import json
from pathlib import Path
import sys
from audit_all_ones_obstruction import orbits, polar

def rank(rows):
    pivots={}
    for x in rows:
        while x:
            p=x.bit_length()-1
            if p in pivots: x^=pivots[p]
            else: pivots[p]=x;break
    return len(pivots)

def forms(n):
    oo=orbits(n,3); matrices=[polar(n,orb) for _,orb in oo]
    return [sum(1<<k for k,m in enumerate(matrices) if m[0]>>j&1)
            for j in range(1,n)]

if __name__=='__main__':
    r16=forms(16);r32=forms(32);passing=[]
    for c in itertools.combinations(range(35),3):
        h=sum(1<<k for k in c)
        if all((h&r).bit_count()%2==0 for r in r16): passing.append(hex(h))
    result={'necessary_all_ones_polar_zero':True,
            'original_coefficient_dimension':155,'original_constraint_rank':rank(r32),
            'original_necessary_subspace_dimension':155-rank(r32),
            'H_dimension':35,'H_constraint_rank':rank(r16),
            'H_necessary_subspace_dimension':35-rank(r16),
            'weight_three_H_total':6545,'weight_three_H_excluded_by_cross_polar':6545-len(passing),
            'weight_three_H_pass_this_test_only':len(passing),'passing_H':passing,
            'original_linear_forms':[hex(x) for x in r32],
            'H_linear_forms':[hex(x) for x in r16],
            'scope':'Passing is not evidence of bentness; other exclusion certificates must still be audited.'}
    Path(sys.argv[1]).write_text(json.dumps(result,indent=2)+'\n')
    print({k:v for k,v in result.items() if not isinstance(v,list)})
