"""Differential checks against direct truth-table derivatives, not symbolic ANF."""
import argparse
from itertools import combinations, product
import json
from pathlib import Path
import random
from derivative_balance_cnf import Circuit, add_balance, derivative_forms, fixed_family, default_directions


def need(condition, message):
    if not condition:
        raise AssertionError(message)


def value(literal, assignment):
    return literal if type(literal) is bool else bool(assignment[abs(literal)]) ^ (literal<0)


def satisfied(circuit, assignment):
    return all(any(value(l,assignment) for l in row) for row in circuit.clauses)


def evaluate(polynomial, coefficients, x):
    return sum((((row[0]&coefficients).bit_count()&1)^row[1])
               for term,row in polynomial.items() if term&x==term)&1


def direct_q(polynomial, c, a, x):
    return evaluate(polynomial,c,x)^evaluate(polynomial,c,x^a)


def witness_valid(polynomial,c,n,a,r):
    q=lambda x:direct_q(polynomial,c,a,x)
    q0=q(0)
    return q(r)^q0==1 and all(q(r)^q(1<<i)^q(r^(1<<i))^q0==0 for i in range(n))


def audit():
    rng=random.Random(20261005)
    report={'gate_truth_assignments':0,'witness_checks':0,'truth_table_balance_checks':0,
            'n32_derivative_point_checks':0,'positive_controls':[]}
    # Exhaustive auxiliary-output truth tables, including signed inputs.
    for kind in ('xor','and'):
        for sign_a,sign_b in product((-1,1),repeat=2):
            circuit=Circuit(2)
            out=circuit.xor([sign_a,2*sign_b]) if kind=='xor' else circuit.conjunction([sign_a,2*sign_b])
            for x,y,z in product((False,True),repeat=3):
                assignment={1:x,2:y,abs(out):z}
                expected=(value(sign_a,assignment)^value(2*sign_b,assignment)) if kind=='xor' else (value(sign_a,assignment)&value(2*sign_b,assignment))
                need(satisfied(circuit,assignment)==(value(out,assignment)==expected),'Gate truth table mismatch')
                report['gate_truth_assignments']+=1
    # All 16 homogeneous cubics in four variables; every direction and witness.
    terms=[sum(1<<i for i in s) for s in combinations(range(4),3)]
    poly={term:(1<<j,0) for j,term in enumerate(terms)}
    cases=[(4,poly,c) for c in range(16)]
    # Random degree <=3 polynomials in six variables include affine constants.
    for _ in range(12):
        terms=[0]+[sum(1<<i for i in s) for d in (1,2,3) for s in combinations(range(6),d)]
        cases.append((6,{t:(0,rng.randrange(2)) for t in terms},0))
    controls=[(4,{(1<<0)|(1<<2):(0,1),(1<<1)|(1<<3):(0,1)},0),
              (6,{(1<<0)|(1<<3):(0,1),(1<<1)|(1<<4):(0,1),
                  (1<<2)|(1<<5):(0,1),(1<<3)|(1<<4)|(1<<5):(0,1)},0)]
    cases+=controls
    for n,polynomial,c in cases:
        count=max((row[0].bit_length() for row in polynomial.values()),default=0)
        for a in range(1,1<<n):
            circuit=Circuit(count)
            witnesses=add_balance(circuit,n,polynomial,a)
            found=False
            for r in range(1<<n):
                assignment={i+1:bool(c>>i&1) for i in range(count)}
                assignment.update({v:bool(r>>i&1) for i,v in enumerate(witnesses)})
                actual=satisfied(circuit,circuit.extend(assignment))
                need(actual==witness_valid(polynomial,c,n,a,r),'CNF disagrees with direct radical test')
                found|=actual
                report['witness_checks']+=1
            total=sum(1 if direct_q(polynomial,c,a,x)==0 else -1 for x in range(1<<n))
            need(found==(total==0),'Existential CNF disagrees with direct balance')
            if (n,polynomial,c) in controls:
                need(found,'Known bent positive control was excluded')
            report['truth_table_balance_checks']+=1
    report['positive_controls']=['quadratic bent in n=4','Maiorana-McFarland cubic bent in n=6 (inhomogeneous)']
    for h in (0xa2000,0xa8000,0x20a000,0x228000,0x4000a000,0x40022000,0x40028000,0x10000a000,0x100022000):
        polynomial,free,lift=fixed_family(h)
        need(len(free)==120,'Wrong family dimension')
        for _ in range(2):
            c=rng.getrandbits(120)
            original=lift(c)
            from audit_independent_cnf import REPS32,HROWS
            need(all(((row&original).bit_count()&1)==(h>>i&1) for i,row in enumerate(HROWS)),'Lift changes H')
            for a in default_directions():
                q=derivative_forms(polynomial,a)
                for _ in range(3):
                    x=rng.getrandbits(32)
                    direct=sum((term&x)==term for j,(_,orb) in enumerate(REPS32) if original>>j&1 for term in orb)&1
                    shifted=sum((term&(x^a))==term for j,(_,orb) in enumerate(REPS32) if original>>j&1 for term in orb)&1
                    need(evaluate(q,c,x)==direct^shifted,'n=32 symbolic derivative differs from independent original ANF')
                    report['n32_derivative_point_checks']+=1
    report['status']='PASS'
    report['limitations']='Finite differential audit; not an UNSAT certificate or a bentness result in n=32.'
    return report


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('--output',type=Path)
    a=p.parse_args()
    result=audit()
    if a.output:
        a.output.write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps(result,indent=2))
