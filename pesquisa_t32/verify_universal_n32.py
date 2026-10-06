"""Verify the universal n32 certificate by independent direct ANF evaluations."""
import itertools
import json
from pathlib import Path
import sys
from audit_independent_cnf import REPS32, evaluate_generators

if not __debug__:raise RuntimeError('Run without -O.')

def coeff(values,support):
    row=0
    for n in range(len(support)+1):
        for sub in itertools.combinations(support,n):row^=values(sum(1<<i for i in sub))
    return row

def verify(path):
    cert=json.loads(path.read_text())
    assert cert['basis_155']==[list(s) for s,_ in REPS32]
    allones=(1<<32)-1;rows={}
    for j in range(1,32):
        row=0
        for a,b,c in itertools.product((0,1),repeat=3):
            row^=evaluate_generators((allones if a else 0)^(1 if b else 0)^((1<<j) if c else 0))
        rows[j]=row
    assert cert['derivative_polar_equations']==[{'column':j,'row_155':hex(rows[j]),'rhs':0} for j in range(1,32)]
    # Direct Möbius coefficients on each basis generator, via bit-packed ANF.
    # Both restrictions have degree <=3; these are all possible coefficients.
    diag=lambda u:evaluate_generators(u|(u<<16))
    complementary=lambda u:evaluate_generators(u|((u^65535)<<16))
    assert diag(0)==0
    cube_checks=0
    for size in (1,2,3):
        for support in itertools.combinations(range(16),size):
            assert coeff(diag,support)==0;cube_checks+=1
            if size==3:assert coeff(complementary,support)==0;cube_checks+=1
    expected_terms={1<<i for i in range(16)}|{(1<<i)|(1<<j) for i,j in itertools.combinations(range(16),2)}
    identities=cert['complementary_fiber_nonconstant_coefficient_identities']
    assert len(identities)==136
    assert {int(r['fiber_term_mask'],16) for r in identities}==expected_terms
    for rec in identities:
        term=int(rec['fiber_term_mask'],16)
        support=[i for i in range(16) if term>>i&1]
        actual=coeff(complementary,support)
        assert actual==int(rec['coefficient_row_155'],16)
        combined=0
        for j in rec['derivative_polar_columns']:combined^=rows[j]
        assert combined==actual
    return {'status':'PASS','all_155_basis_generators_verified':True,
            'zero_diagonal_and_cubic_fiber_coefficients_checked':cube_checks,
            'nonconstant_fiber_coefficients_in_derivative_equation_span':136,
            'scope':'Universal homogeneous cubic RS n=32 finite certificate; mathematical necessity is proved in the accompanying text.'}

if __name__=='__main__':
    result=verify(Path(sys.argv[1]));print(json.dumps(result,indent=2))
    if len(sys.argv)>2:Path(sys.argv[2]).write_text(json.dumps(result,indent=2)+'\n')
