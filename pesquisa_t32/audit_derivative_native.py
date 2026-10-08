"""Native SAT/UNSAT controls, including an independently checked DRAT proof."""
import argparse
from itertools import combinations
import json
from pathlib import Path
import subprocess
from derivative_balance_cnf import Circuit,add_balance
from audit_derivative_balance import witness_valid,need


def run_native(output,solver,checker):
    output.mkdir(parents=True,exist_ok=True)
    reports=[]
    controls=[('control_n4_homogeneous',4,
               {sum(1<<i for i in s):(1<<j,0) for j,s in enumerate(combinations(range(4),3))},4),
              ('control_n6_bent',6,{9:(0,1),18:(0,1),36:(0,1),56:(0,1)},0)]
    for name,n,polynomial,base in controls:
        circuit=Circuit(base)
        witnesses={a:add_balance(circuit,n,polynomial,a) for a in range(1,1<<n)}
        cnf=output/(name+'.cnf')
        proof=output/(name+'.drat')
        solver_log=output/(name+'.solver.log')
        with cnf.open('w') as f:
            f.write(f'p cnf {circuit.variables} {len(circuit.clauses)}\n')
            for row in circuit.clauses:
                f.write(' '.join(map(str,row))+' 0\n')
        with solver_log.open('w') as log:
            result=subprocess.run([str(solver),'--no-binary',str(cnf),str(proof)],
                                  stdout=log,stderr=subprocess.STDOUT,timeout=30)
        text=solver_log.read_text()
        report={'control':name,'solver_returncode':result.returncode}
        if n==4:
            need(result.returncode==20 and 's UNSATISFIABLE' in text.splitlines(),'Expected UNSAT control')
            checker_log=output/(name+'.checker.log')
            with checker_log.open('w') as log:
                checked=subprocess.run([str(checker),str(cnf),str(proof)],
                                       stdout=log,stderr=subprocess.STDOUT,timeout=30)
            report['proof_verified']=checked.returncode==0 and 's VERIFIED' in checker_log.read_text().splitlines()
            need(report['proof_verified'],'Control DRAT proof rejected')
        else:
            need(result.returncode==10 and 's SATISFIABLE' in text.splitlines(),'Known bent control excluded')
            assignment={abs(v):v>0 for line in text.splitlines() if line.startswith('v ') for v in map(int,line.split()[1:]) if v}
            need(all(i in assignment for i in range(1,circuit.variables+1)),'Incomplete control model')
            need(all(any(assignment[abs(v)]==(v>0) for v in row) for row in circuit.clauses),'Control SAT assignment violates clauses')
            need(all(witness_valid(polynomial,0,n,a,sum(assignment[v]<<i for i,v in enumerate(w)))
                     for a,w in witnesses.items()),'Control derivative witness invalid')
            report['sat_assignment_and_all_derivative_witnesses_verified']=True
        reports.append(report)
    (output/'native_controls.json').write_text(json.dumps(reports,indent=2)+'\n')
    return reports


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('--output',type=Path,required=True)
    p.add_argument('--solver',type=Path,required=True)
    p.add_argument('--checker',type=Path,required=True)
    a=p.parse_args()
    print(json.dumps(run_native(a.output,a.solver.resolve(),a.checker.resolve()),indent=2))
