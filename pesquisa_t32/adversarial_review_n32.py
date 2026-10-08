"""Fail-closed certificate mutation tests and controls for proof hypotheses."""
import copy
import itertools
import json
from pathlib import Path
import tempfile
import sys
from verify_universal_n32 import verify, walsh

def run(certificate):
    original=json.loads(certificate.read_text());tests=[]
    with tempfile.TemporaryDirectory() as folder:
        for case in ('alter_fiber_coefficient','alter_derivative_equation','remove_identity','swap_generator_order'):
            d=copy.deepcopy(original)
            if case=='alter_fiber_coefficient':
                r=d['complementary_fiber_nonconstant_coefficient_identities'][0]
                r['coefficient_row_155']=hex(int(r['coefficient_row_155'],16)^1)
            elif case=='alter_derivative_equation':d['derivative_polar_equations'][0]['row_155']='0x0'
            elif case=='remove_identity':d['complementary_fiber_nonconstant_coefficient_identities'].pop()
            else:d['basis_155'][0],d['basis_155'][1]=d['basis_155'][1],d['basis_155'][0]
            p=Path(folder)/'invalid.json';p.write_text(json.dumps(d))
            try:verify(p)
            except AssertionError:tests.append({'case':case,'status':'REJECTED_AS_REQUIRED'})
            else:raise RuntimeError('Invalid certificate accepted: '+case)
    terms=[(0,1,2),(0,1,3),(0,1,5),(0,2,3),(0,2,4),(0,3,4),(0,3,5),(0,4,5),
           (1,2,3),(1,2,4),(1,2,5),(1,3,4),(1,4,5),(2,3,5),(2,4,5),(3,4,5)]
    table=[sum(all(x>>i&1 for i in s) for s in terms)%2 for x in range(64)]
    assert all(abs(w)==8 for w in walsh(table))
    assert any(table[x]!=table[((x<<1)&63)|(x>>5)] for x in range(64))
    literature=[]
    # Full cyclic-sum convention, including cancellation and x_i^2=x_i.
    for n in (2,4,6,8):
        poly=set()
        for d in (1,2):
            for i in range(n):
                term=(1<<i)|(1<<((i+d)%n))
                if term in poly:poly.remove(term)
                else:poly.add(term)
        table=[sum((x&m)==m for m in poly)%2 for x in range(1<<n)]
        value=walsh(table)[0];degree=max((m.bit_count() for m in poly),default=0)
        literature.append({'n':n,'actual_degree':degree,'Walsh_at_zero':value,'balanced':value==0})
        if n in (2,6):assert value==0
        if n in (4,8):assert value!=0
    return {'status':'PASS','mutation_tests':tests,
            'homogeneous_cubic_nonRS_bent_control':{'n':6,'ANF_terms':[list(s) for s in terms],'Walsh_magnitude':8,'rotation_invariant':False},
            'literature_convention_controls':literature,
            'review_type':'Self-audit with independent computational evaluators, not an external referee report',
            'originality_established':False}

if __name__=='__main__':
    if not __debug__:raise RuntimeError('Run without -O.')
    result=run(Path(sys.argv[1]));Path(sys.argv[2]).write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result,indent=2))
