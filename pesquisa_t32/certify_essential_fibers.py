"""Audit original ANF fibers, quotient exactly, solve XOR, and check XLRUP."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess
import time
from essential_fiber_quotient import export,need,build,lift,satisfies


def sha(path):
    h=hashlib.sha256()
    with path.open('rb') as f:
        for block in iter(lambda:f.read(1048576),b''):h.update(block)
    return h.hexdigest()


def certify(metadata,output,solver,checker,seconds):
    from modelo_radicais_t32 import CNF
    from audit_independent_cnf import audit_model
    output.mkdir(parents=True,exist_ok=True)
    info=json.loads(metadata.read_text());prefix=output/('essential_'+info['h'][2:])
    summary={'h':info['h'],'status':'AUDITING_MODEL','bentness_certified':False,
             'scope':'One fixed-H family under necessary fiber balance conditions.',
             'source_metadata_sha256':sha(metadata),'solver_sha256':sha(solver),
             'checker_sha256':sha(checker),'solver_cpu_seconds':seconds}
    def save():
        p=output/'summary.tmp';p.write_text(json.dumps(summary,indent=2)+'\n');p.replace(output/'summary.json')
    save()
    try:
        original=output/'original'
        formula=CNF(info['family_dimension'])
        for fiber in info['fibers']:
            formula.balance([(int(m,16),c) for m,c in fiber['affine_values']])
        with original.with_suffix('.cnf').open('w') as f:
            f.write(f'p cnf {formula.variables} {len(formula.clauses)}\n')
            for row in formula.clauses:f.write(' '.join(map(str,row))+' 0\n')
        audited=dict(info,variables=formula.variables,clauses=len(formula.clauses),cnf_sha256=sha(original.with_suffix('.cnf')))
        original.with_suffix('.json').write_text(json.dumps(audited)+'\n')
        del formula
        summary['original_audit']=audit_model(original.with_suffix('.json'),original.with_suffix('.cnf'))
        model_report=export(metadata,prefix)
        summary['quotient']={k:v for k,v in model_report.items() if k not in ('clauses','basis_rows')}
        # Native XOR/proof positive test before solving the research instance.
        control=output/'control.xcnf';control.write_text('p cnf 3 4\n1 2 0\n-1 -2 0\nx1 2 -3 0\n-3 0\n')
        with (output/'control.solver.log').open('w') as log:
            control_result=subprocess.run([str(solver),str(control),str(output/'control.xlrup')],stdout=log,stderr=subprocess.STDOUT,timeout=30)
        need(control_result.returncode==20,'Native UNSAT control failed')
        with (output/'control.checker.log').open('w') as log:
            control_checked=subprocess.run([str(checker),str(control),str(output/'control.xlrup')],stdout=log,stderr=subprocess.STDOUT,timeout=30)
        need(control_checked.returncode==0 and 's VERIFIED UNSAT' in (output/'control.checker.log').read_text().splitlines(),'Native proof control failed')
        summary['status']='SOLVING';save()
        command=[str(solver),'--maxtime',str(seconds),'--threads','1',str(prefix.with_suffix('.xcnf')),str(prefix.with_suffix('.xlrup'))]
        summary['solver_command']=command
        started=time.monotonic()
        with prefix.with_suffix('.solver.log').open('w') as log:
            result=subprocess.run(command,stdout=log,stderr=subprocess.STDOUT,timeout=seconds*2+60)
        summary['elapsed_solver_seconds']=time.monotonic()-started
        summary['solver_returncode']=result.returncode
        text=prefix.with_suffix('.solver.log').read_text()
        if result.returncode==20 and 's UNSATISFIABLE' in text.splitlines():
            summary['status']='UNSAT_UNCHECKED';save()
            with prefix.with_suffix('.checker.log').open('w') as log:
                checked=subprocess.run([str(checker),str(prefix.with_suffix('.xcnf')),str(prefix.with_suffix('.xlrup'))],stdout=log,stderr=subprocess.STDOUT,timeout=600)
            summary['checker_returncode']=checked.returncode
            if checked.returncode==0 and 's VERIFIED UNSAT' in prefix.with_suffix('.checker.log').read_text().splitlines():
                summary['status']='UNSAT_PROOF_VERIFIED_AND_MODEL_AUDITED'
            summary['proof_sha256']=sha(prefix.with_suffix('.xlrup'))
        elif result.returncode==10 and 's SATISFIABLE' in text.splitlines():
            original_clauses=[[(int(m,16),c) for m,c in f['affine_values']] for f in info['fibers']]
            model=build(original_clauses,info['family_dimension'])
            assignment={abs(v):v>0 for line in text.splitlines() if line.startswith('v ') for v in map(int,line.split()[1:]) if v}
            need(all(i+1 in assignment for i in range(model['dimension'])),'Incomplete SAT model')
            y=sum(assignment[i+1]<<i for i in range(model['dimension']));x=lift(model,y)
            need(satisfies(original_clauses,x),'Lifted assignment violates original fibers')
            summary.update(status='SAT_NECESSARY_CONDITIONS_ONLY',original_free_value=hex(x))
        else:summary['status']='UNKNOWN_OR_INTERRUPTED'
    except subprocess.TimeoutExpired as error:
        summary['interruption']=str(error)
        if summary['status']!='UNSAT_UNCHECKED':summary['status']='UNKNOWN_OR_INTERRUPTED'
    except Exception as error:
        summary.update(status='ERROR',error=repr(error))
    save()
    (output/'SHA256.json').write_text(json.dumps({p.name:sha(p) for p in output.iterdir() if p.is_file() and p.name!='SHA256.json'},indent=2)+'\n')
    print(json.dumps(summary,indent=2),flush=True)
    return summary


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('metadata',type=Path);p.add_argument('output',type=Path)
    p.add_argument('--solver',type=Path,required=True);p.add_argument('--checker',type=Path,required=True)
    p.add_argument('--seconds',type=int,default=300)
    a=p.parse_args();need(1<=a.seconds<=3600,'Use a solver budget from 1 to 3600 seconds')
    result=certify(a.metadata,a.output,a.solver.resolve(),a.checker.resolve(),a.seconds)
    if result['status']=='ERROR':raise SystemExit(1)
