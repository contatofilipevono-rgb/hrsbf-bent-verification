"""Bounded, certified CaDiCaL pilot: original fibers AND selected derivatives."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess
import sys
import time
import zipfile
from derivative_balance_cnf import generate, read_dimacs, fixed_family
from audit_derivative_balance import audit, witness_valid
from audit_derivative_native import run_native


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def run(args):
    from audit_independent_cnf import audit_model, REPS32
    from modelo_radicais_t32 import CNF, directions, free_coordinates
    from triagem_familias_t32 import model, coefficient_forms, family_fiber, linear_row
    output=args.base/'resultados_derivadas_piloto'
    output.mkdir(parents=True,exist_ok=True)
    source=args.base/'resultados'/('familia_'+format(args.h,'x'))
    prefix=output/('familia_'+format(args.h,'x'))
    summary={'h':hex(args.h),'status':'PREPARING','bentness_certified':False,
             'solver_seconds':args.seconds,'scope':'One fixed-H family; selected derivative and fiber necessary conditions.'}
    checkpoint=output/'summary.json'
    def save():
        temporary=checkpoint.with_suffix('.tmp')
        temporary.write_text(json.dumps(summary,indent=2)+'\n')
        temporary.replace(checkpoint)
    save()
    try:
        summary['derivative_model_audit']=audit()
        solver=args.base/'cadical/build/cadical'
        checker=args.base/'drat-trim/drat-trim'
        if not solver.is_file() or not checker.is_file():
            raise ValueError('Prepare CaDiCaL and drat-trim before the pilot.')
        summary['native_controls']=run_native(output,solver,checker)
        save()
        if not source.with_suffix('.cnf').exists() or not source.with_suffix('.json').exists():
            print('Construindo fibras originais para o representante',hex(args.h),flush=True)
            reps,_,hrows,_=model()
            free,sub,_=free_coordinates(args.h,hrows)
            formula=CNF(120)
            fibers=[]
            for index,z in enumerate(directions(),1):
                forms=coefficient_forms(reps,z,hrows)
                _,rank,basis=family_fiber(args.h,hrows,forms)
                values=[sub(linear_row(forms,r)) for r in basis]
                formula.balance(values)
                fibers.append({'z':z,'rank':rank,'radical_basis':basis,
                               'affine_values':[[hex(m),c] for m,c in values]})
                if index%512==0:
                    print('Fibras construídas:',index,flush=True)
            source.parent.mkdir(parents=True,exist_ok=True)
            with source.with_suffix('.cnf').open('w') as f:
                f.write(f'p cnf {formula.variables} {len(formula.clauses)}\n')
                for row in formula.clauses:
                    f.write(' '.join(map(str,row))+' 0\n')
            source.with_suffix('.json').write_text(json.dumps({
                'h':hex(args.h),'family_dimension':120,'free_original_orbit_indices':free,
                'fibers':fibers,'variables':formula.variables,'clauses':len(formula.clauses),
                'cnf_sha256':sha(source.with_suffix('.cnf'))})+'\n')
            del formula
        summary['original_fiber_audit']=audit_model(source.with_suffix('.json'),source.with_suffix('.cnf'))
        summary['derivative_model']=generate(args.h,prefix,source=source.with_suffix('.cnf'),metadata=source.with_suffix('.json'))
        solver=args.base/'cadical/build/cadical'
        checker=args.base/'drat-trim/drat-trim'
        if not solver.is_file() or not checker.is_file():
            raise ValueError('Prepare CaDiCaL and drat-trim before the pilot.')
        summary.update(status='SOLVING',solver_sha256=sha(solver),checker_sha256=sha(checker))
        save()
        print('Modelo reforçado:',summary['derivative_model']['variables'],'variáveis;',summary['derivative_model']['clauses'],'cláusulas',flush=True)
        started=time.monotonic()
        with prefix.with_suffix('.solver.log').open('w') as log:
            result=subprocess.run([str(solver),'--no-binary','-t',str(args.seconds),str(prefix.with_suffix('.cnf')),str(prefix.with_suffix('.drat'))],
                                  stdout=log,stderr=subprocess.STDOUT,timeout=args.seconds+30)
        summary['solver_elapsed_seconds']=time.monotonic()-started
        summary['solver_returncode']=result.returncode
        text=prefix.with_suffix('.solver.log').read_text(errors='replace')
        if result.returncode==20 and 's UNSATISFIABLE' in text.splitlines():
            summary['status']='VERIFYING_PROOF'
            save()
            with prefix.with_suffix('.checker.log').open('w') as log:
                checked=subprocess.run([str(checker),str(prefix.with_suffix('.cnf')),str(prefix.with_suffix('.drat'))],
                                       stdout=log,stderr=subprocess.STDOUT,timeout=300)
            verified=checked.returncode==0 and 's VERIFIED' in prefix.with_suffix('.checker.log').read_text().splitlines()
            summary['status']='UNSAT_PROOF_VERIFIED' if verified else 'UNSAT_UNCHECKED'
            summary['proof_sha256']=sha(prefix.with_suffix('.drat'))
        elif result.returncode==10 and 's SATISFIABLE' in text.splitlines():
            assignment={abs(v):v>0 for line in text.splitlines() if line.startswith('v ') for v in map(int,line.split()[1:]) if v}
            variables,rows=read_dimacs(prefix.with_suffix('.cnf'))
            if not all(i in assignment for i in range(1,variables+1)):
                raise ValueError('Incomplete SAT assignment')
            if not all(any(assignment[abs(v)]==(v>0) for v in row) for row in rows):
                raise ValueError('SAT assignment violates serialized clauses')
            c=sum(assignment[i+1]<<i for i in range(120))
            polynomial,_,lift=fixed_family(args.h)
            for direction,witness in summary['derivative_model']['witness_variables'].items():
                r=sum(assignment[v]<<i for i,v in enumerate(witness))
                if not witness_valid(polynomial,c,32,int(direction,16),r):
                    raise ValueError('SAT witness violates independently evaluated derivative condition')
            original=lift(c)
            candidate={'n':32,'coordinate_base':0,'h':hex(args.h),
                       'sanf':[list(s) for j,(s,_) in enumerate(REPS32) if original>>j&1],
                       'bentness_certified':False}
            prefix.with_suffix('.candidate.json').write_text(json.dumps(candidate,indent=2)+'\n')
            summary['status']='SAT_NECESSARY_CONDITIONS_ONLY'
        else:
            summary['status']='UNKNOWN_OR_INTERRUPTED'
    except subprocess.TimeoutExpired as error:
        # A subprocess wall-time limit is not a mathematical conclusion.
        summary.update(status='UNKNOWN_OR_INTERRUPTED',interruption=repr(error))
    except Exception as error:
        summary.update(status='ERROR',error=repr(error))
    finally:
        save()
        files=[f for f in sorted(output.iterdir()) if f.is_file() and f.name not in ('SHA256.json','resultado_derivadas_piloto.zip')]
        (output/'SHA256.json').write_text(json.dumps({f.name:sha(f) for f in files},indent=2)+'\n')
        with zipfile.ZipFile(output/'resultado_derivadas_piloto.zip','w',zipfile.ZIP_DEFLATED) as z:
            for f in files+[output/'SHA256.json']:
                z.write(f,f.name)
            for suffix in ('.cnf','.json'):
                f=source.with_suffix(suffix)
                if f.exists():
                    z.write(f,'original/'+f.name)
        print(json.dumps(summary,indent=2),flush=True)
    return summary


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('--base',type=Path,default=Path('/content/hrsbf_derivative_pilot'))
    p.add_argument('--h',type=lambda s:int(s,0),default=0xa2000)
    p.add_argument('--seconds',type=int,default=300)
    a=p.parse_args()
    if not 0<a.seconds<=1200 or not 0<=a.h<1<<35:
        p.error('Invalid bounds')
    result=run(a)
    if result['status']=='ERROR':
        sys.exit(1)
