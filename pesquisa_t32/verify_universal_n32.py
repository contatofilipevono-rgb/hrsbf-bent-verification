"""Verify the universal n32 certificate by independent direct ANF evaluations."""
import itertools
import json
from pathlib import Path
import sys
from audit_independent_cnf import REPS32, evaluate_generators
from audit_all_ones_obstruction import orbits

if not __debug__:raise RuntimeError('Run without -O.')

def coeff(values,support):
    row=0
    for n in range(len(support)+1):
        for sub in itertools.combinations(support,n):row^=values(sum(1<<i for i in sub))
    return row

def walsh(values):
    a=[1-2*v for v in values];step=1
    while step<len(a):
        for start in range(0,len(a),step*2):
            for i in range(start,start+step):
                x,y=a[i],a[i+step];a[i]=x+y;a[i+step]=x-y
        step*=2
    return a

def controls():
    oo=orbits(8,3);assert len(oo)==7
    tables=[[sum(all(x>>i&1 for i in s) for s in orb)%2 for x in range(256)] for _,orb in oo]
    for c in range(128):
        table=[sum(tables[j][x] for j in range(7) if c>>j&1)%2 for x in range(256)]
        assert not all(abs(w)==16 for w in walsh(table))
    table=[]
    for x in range(256):
        u=x&15;v=x>>4;z=u^v
        g=sum(all(z>>i&1 for i in s) for s in itertools.combinations(range(4),3))%2
        table.append(((u&v).bit_count()%2)^g)
    assert all(abs(w)==16 for w in walsh(table))
    # The positive control is RS and genuinely nonhomogeneous of degree three.
    assert all(table[x]==table[((x<<1)&255)|(x>>7)] for x in range(256))
    anf=list(table)
    for i in range(8):
        for x in range(256):
            if x>>i&1:anf[x]^=anf[x^(1<<i)]
    assert {x.bit_count() for x,v in enumerate(anf) if v}=={2,3}
    return {'homogeneous_cubic_RS_n8_exhaustive_cases':128,
            'nonhomogeneous_cubic_RS_bent_n8_positive_control':'PASS',
            'positive_control_Walsh_magnitude':16}

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
            'controls':controls(),
            'scope':'Universal homogeneous cubic RS n=32 finite certificate; mathematical necessity is proved in the accompanying text.'}

if __name__=='__main__':
    result=verify(Path(sys.argv[1]));print(json.dumps(result,indent=2))
    if len(sys.argv)>2:Path(sys.argv[2]).write_text(json.dumps(result,indent=2)+'\n')
