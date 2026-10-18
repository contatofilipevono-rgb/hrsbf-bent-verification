"""Build and kernel-replay a large generated Lean library in resumable module order.
A completed module is not a proof of global coverage; only the final root theorem
can supply that conclusion, and other root charts remain separate obligations.
"""
from pathlib import Path
import argparse,subprocess,json,time,hashlib,tomllib,re

def main():
 p=argparse.ArgumentParser(description=__doc__);p.add_argument('--lake',default='lake');p.add_argument('--library',required=True);p.add_argument('--resume',action='store_true');p.add_argument('--report',required=True);args=p.parse_args()
 root=Path(__file__).resolve().parent.parent;project=root/'lean';config=tomllib.loads((project/'lakefile.toml').read_text(encoding='utf-8'));libraries={x['name']:x['roots'] for x in config['lean_lib']}
 if args.library not in libraries:raise SystemExit('Unknown library: '+args.library)
 modules=libraries[args.library];dependencies={};stack=list(modules)
 while stack:
  name=stack.pop();file=project/(name+'.lean')
  if name in dependencies or not file.exists():continue
  dependencies[name]=hashlib.sha256(file.read_bytes()).hexdigest()
  stack.extend(re.findall(r'^import\s+(\w+)',file.read_text(encoding='utf-8'),re.M))
 digest=hashlib.sha256(json.dumps(dependencies,sort_keys=True).encode()).hexdigest();prior={};reportfile=root/'reports'/args.report
 if args.resume and reportfile.exists():
  old=json.loads(reportfile.read_text())
  if old.get('dependency_sha256')==digest:prior={r['module']:r for r in old.get('results',[])}
 logs=root/'reports'/('sequential_'+args.library);logs.mkdir(exist_ok=True)
 report={'status':'RUNNING','library':args.library,'dependency_sha256':digest,'dependencies':dependencies,'results':[],'modules_total':len(modules),'scope':'Module-by-module certificate replay. Partial progress does not establish coverage by a root theorem.'}
 def save():
  report['modules_verified']=sum(r.get('build_exit_code')==r.get('kernel_exit_code')==0 for r in report['results']);temp=reportfile.with_suffix('.tmp');temp.write_text(json.dumps(report,indent=2));temp.replace(reportfile)
 version=subprocess.check_output([args.lake,'env','lean','--version'],cwd=project,text=True,encoding='utf-8');assert '4.35.0' in version,version;report['lean_version']=version.strip()
 for index,module in enumerate(modules,1):
  sha=dependencies[module];old=prior.get(module)
  if old and old.get('source_sha256')==sha and old.get('build_exit_code')==old.get('kernel_exit_code')==0:
   # Successful records are reusable only with their preserved clean logs.
   good=True
   for phase in ['build','kernel']:
    file=logs/(module+'_'+phase+'.log')
    if not file.exists() or any(x in file.read_text(encoding='utf-8') for x in ['sorryAx','ofReduceBool','error:']):good=False
   if good:report['results'].append(old);print('RESUME_PASS',index,module,flush=True);continue
  record={'module':module,'source_sha256':sha};start=time.perf_counter()
  for phase,command in [('build',['build',module]),('kernel',['env','leanchecker','--verbose',module])]:
   print('START',index,'/',len(modules),module,phase,flush=True);file=logs/(module+'_'+phase+'.log')
   with file.open('w',encoding='utf-8') as out:r=subprocess.run([args.lake]+command,cwd=project,stdout=out,stderr=subprocess.STDOUT)
   text=file.read_text(encoding='utf-8');record[phase+'_exit_code']=r.returncode
   if r.returncode or any(x in text for x in ['sorryAx','ofReduceBool','error:']):
    record['seconds']=time.perf_counter()-start;report['results'].append(record);report['status']='FAILED';save();print(text[-4000:]);raise SystemExit(r.returncode or 1)
  record['seconds']=round(time.perf_counter()-start,3);report['results'].append(record);save();print('PASS',index,module,record['seconds'],flush=True)
 report['status']='PASS_ENTIRE_SELECTED_LIBRARY_KERNEL_REPLAY';report['final_module']=modules[-1];save();print(report['status'],len(modules),flush=True)

if __name__=='__main__':main()
