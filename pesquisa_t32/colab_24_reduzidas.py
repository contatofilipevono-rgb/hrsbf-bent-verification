"""Bounded CPU run: nine verified representatives cover 24 fixed-H families."""
import argparse
from concurrent.futures import ThreadPoolExecutor, as_completed
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import time

def sha(path):return hashlib.sha256(path.read_bytes()).hexdigest()
def require(ok,msg):
    if not ok:raise ValueError(msg)

def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('--project',type=Path,required=True);p.add_argument('--base',type=Path,default=Path('/content/hrsbf_colab'))
    p.add_argument('--seconds',type=int,default=1200);p.add_argument('--wall-seconds',type=int,default=7200);p.add_argument('--workers',type=int,default=2)
    a=p.parse_args();sys.path.insert(0,str(a.project/'pesquisa_t32'));sys.path.insert(0,str(a.project/'avanco_t32'))
    from symmetry_remaining import classes
    from audit_independent_cnf import audit_model, REPS32
    from reduce_fiber_cnf import run as reduce_model
    from modelo_radicais_t32 import CNF, directions, free_coordinates
    from triagem_familias_t32 import model, coefficient_forms, family_fiber, linear_row
    out=a.base/'resultados_24_reduzidos';out.mkdir(parents=True,exist_ok=True)
    original=a.base/'resultados';original.mkdir(parents=True,exist_ok=True)
    solver=a.base/'cadical/build/cadical';checker=a.base/'drat-trim/drat-trim'
    require(solver.is_file() and checker.is_file(),'Execute notebook preparation first.')
    orbits=classes(a.project/'pesquisa_t32/familias_30_remanescentes.json')
    (out/'symmetry_certificate.json').write_text(json.dumps(orbits,indent=2)+'\n')
    summary={'scope':'24 weight-three families, via verified index permutations; SAT is not bentness',
             'project_commit':subprocess.check_output(['git','rev-parse','HEAD'],cwd=a.project,text=True).strip(),
             'solver_sha256':sha(solver),'checker_sha256':sha(checker),'solver_seconds':a.seconds,
             'wall_seconds':a.wall_seconds,'workers':min(a.workers,os.cpu_count() or 1,2),
             'families':{},'completed':False}
    checkpoint=out/'summary.json'
    if checkpoint.exists():
        previous=json.loads(checkpoint.read_text())
        for h,record in previous.get('families',{}).items():
            # Certified previous results are rechecked below before reuse.
            summary['families'][h]=record
    def save():
        temporary=out/'summary.tmp';temporary.write_text(json.dumps(summary,indent=2)+'\n');temporary.replace(checkpoint)
    save();deadline=time.monotonic()+a.wall_seconds
    reps,_,hrows,_=model();forms=None;dirs=directions()
    print('24 famílias ->',len(orbits),'representantes; CPU workers:',summary['workers'],flush=True)
    for orbit in orbits:
        if time.monotonic()>=deadline:break
        h=orbit['representative'];prefix=original/('familia_'+h[2:])
        if not prefix.with_suffix('.json').exists() or not prefix.with_suffix('.cnf').exists():
            if forms is None:
                print('Reconstruindo formas compartilhadas...',flush=True)
                forms={z:coefficient_forms(reps,z,hrows) for z in dirs}
            free,sub,_=free_coordinates(int(h,16),hrows);formula=CNF(120);fibers=[]
            for z in dirs:
                B,rank,basis=family_fiber(int(h,16),hrows,forms[z]);values=[sub(linear_row(forms[z],r)) for r in basis]
                formula.balance(values);fibers.append({'z':z,'rank':rank,'radical_basis':basis,'affine_values':[[hex(m),c] for m,c in values]})
            cnf=prefix.with_suffix('.cnf')
            with cnf.open('w') as s:
                s.write(f'p cnf {formula.variables} {len(formula.clauses)}\n')
                for row in formula.clauses:s.write(' '.join(map(str,row))+' 0\n')
            info={'h':h,'family_dimension':120,'free_original_orbit_indices':free,'fibers':fibers,
                  'variables':formula.variables,'clauses':len(formula.clauses),'cnf_sha256':sha(cnf)}
            prefix.with_suffix('.json').write_text(json.dumps(info)+'\n')
            del formula
    del forms
    def work(orbit):
        h=orbit['representative'];prefix=out/('familia_'+h[2:]);source=original/prefix.name
        record={'h':h,'members':list(orbit['members']),'status':'PREPARING','bentness_certified':False}
        if time.monotonic()>=deadline:return dict(record,status='NOT_STARTED_BUDGET')
        try:
            record['original_model_audit']=audit_model(source.with_suffix('.json'),source.with_suffix('.cnf'))
            reduced=reduce_model(source.with_suffix('.json'),prefix)
            record.update({k:reduced[k] for k in ['linear_rank','remaining_dimension','variables','clauses','cnf_sha256']})
            cnf=prefix.with_suffix('.cnf');proof=prefix.with_suffix('.drat')
            seconds=min(a.seconds,int(deadline-time.monotonic()))
            if seconds<1:return dict(record,status='NOT_STARTED_BUDGET')
            with prefix.with_suffix('.solver.log').open('w') as log:
                result=subprocess.run([str(solver),'--no-binary','-t',str(seconds),str(cnf),str(proof)],stdout=log,stderr=subprocess.STDOUT,timeout=seconds+30)
            text=prefix.with_suffix('.solver.log').read_text(errors='replace');record['solver_returncode']=result.returncode
            if result.returncode==20 and any(l.strip()=='s UNSATISFIABLE' for l in text.splitlines()):
                with prefix.with_suffix('.checker.log').open('w') as log:
                    checked=subprocess.run([str(checker),str(cnf),str(proof)],stdout=log,stderr=subprocess.STDOUT,timeout=300)
                accepted=any(l.strip()=='s VERIFIED' for l in prefix.with_suffix('.checker.log').read_text().splitlines())
                record['status']='UNSAT_PROOF_VERIFIED' if checked.returncode==0 and accepted else 'UNSAT_UNCHECKED'
                record['proof_sha256']=sha(proof)
            elif result.returncode==10 and any(l.strip()=='s SATISFIABLE' for l in text.splitlines()):
                assignment={abs(v):int(v>0) for l in text.splitlines() if l.startswith('v ') for v in map(int,l.split()[1:]) if v}
                for l in cnf.read_text().splitlines():
                    if not l.strip() or l.startswith(('p','c')):continue
                    literals=list(map(int,l.split()))[:-1]
                    require(any(assignment.get(abs(v))==int(v>0) for v in literals),'SAT model violates serialized CNF.')
                k=reduced['remaining_dimension'];require(all(i in assignment for i in range(1,k+1)),'Incomplete SAT model.')
                y=sum(assignment[i]<<(i-1) for i in range(1,k+1));x=sum((((int(m,16)&y).bit_count()&1)^c)<<i for i,(m,c) in enumerate(reduced['lift_expressions']))
                info=json.loads(source.with_suffix('.json').read_text())
                require(all(any(((int(m,16)&x).bit_count()&1)^c for m,c in f['affine_values']) for f in info['fibers']),'Lift violates original fiber conditions.')
                _,_,lift=free_coordinates(int(h,16),hrows);c=lift(x)
                candidate={'n':32,'coordinate_base':0,'h':h,'sanf':[list(s) for j,(s,_) in enumerate(REPS32) if c>>j&1],'bentness_certified':False}
                prefix.with_suffix('.candidate.json').write_text(json.dumps(candidate,indent=2)+'\n');record['status']='SAT_NECESSARY_CONDITIONS_ONLY'
            else:record['status']='UNKNOWN_OR_INTERRUPTED'
        except Exception as error:record.update({'status':'ERROR','error':repr(error)})
        print(h,record['status'],'dimension',record.get('remaining_dimension'),flush=True)
        return record
    with ThreadPoolExecutor(max_workers=summary['workers']) as pool:
        futures=[pool.submit(work,orbit) for orbit in orbits]
        for future in as_completed(futures):
            record=future.result();summary['families'][record['h']]=record
            summary['excluded_of_24']=sum(len(r['members']) for r in summary['families'].values() if r['status']=='UNSAT_PROOF_VERIFIED');save()
    summary['completed']=True;save()
    (out/'SHA256.json').write_text(json.dumps({p.name:sha(p) for p in out.iterdir() if p.is_file() and p.name!='SHA256.json'},indent=2)+'\n')
    import zipfile
    with zipfile.ZipFile(a.base/'resultado_24_reduzidas.zip','w',zipfile.ZIP_DEFLATED) as z:
        for f in sorted(out.iterdir()):
            if f.is_file():z.write(f,f.name)
        for orbit in orbits:
            prefix=original/('familia_'+orbit['representative'][2:])
            for extension in ('.cnf','.json'):
                source=prefix.with_suffix(extension)
                if source.exists():z.write(source,'original/'+source.name)
    print('FINAL:',summary.get('excluded_of_24',0),'excluídas; ZIP:',a.base/'resultado_24_reduzidas.zip',flush=True)

if __name__=='__main__':main()
