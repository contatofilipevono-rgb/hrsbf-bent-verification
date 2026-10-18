"""Sequentially build and replay all concrete Lean Walsh witnesses.
Resume is allowed only for matching source/dependency digests and successful
previous build+kernel records. It does not certify coverage by the global tree.
"""
from pathlib import Path
import argparse,hashlib,json,re,subprocess,time,sys

def main():
 p=argparse.ArgumentParser(description=__doc__)
 p.add_argument('--lake',default='lake')
 p.add_argument('--resume',action='store_true')
 args=p.parse_args();root=Path(__file__).resolve().parent.parent;project=root/'lean'
 logs=root/'reports/witness_kernel';logs.mkdir(parents=True,exist_ok=True)
 def sha(path):return hashlib.sha256(path.read_bytes()).hexdigest()
 seen={}
 def dependency(name):
  path=project/(name+'.lean')
  if name in seen or not path.exists():return
  seen[name]=sha(path)
  for name in re.findall(r'^import\s+(\w+)',path.read_text(encoding='utf-8-sig'),re.M):dependency(name)
 dependency('H12WitnessTheory')
 digest=hashlib.sha256(json.dumps(seen,sort_keys=True).encode()).hexdigest()
 data=json.loads((root/'reports/LEAN_WITNESS_DATA.json').read_text())
 reportfile=root/'reports/LEAN_WITNESS_KERNEL_AUDIT.json'
 prior={}
 resumefile=reportfile if reportfile.exists() else root/'reports/LEAN_WITNESS_KERNEL_PROGRESS.json'
 if args.resume and resumefile.exists():
  old=json.loads(resumefile.read_text())
  if old.get('dependency_sha256')==digest:prior={r['module']:r for r in old.get('results',[])}
 results=[]
 def save(status):
  report={'status':status,'witnesses':data['witnesses'],'dependency_sha256':digest,
   'dependencies':seen,'results':results,
   'scope':'Concrete Walsh rejections only. Global algebraic tree coverage is a separate obligation.'}
  reportfile.write_text(json.dumps(report,indent=2))
 for module in data['data_modules']+['H12Witnesses']:
  source=sha(project/(module+'.lean'));old=prior.get(module)
  if old and old.get('source_sha256')==source and old.get('build_exit_code')==old.get('kernel_exit_code')==0:
   results.append(old);print('RESUME_PASS',module,flush=True);continue
  record={'module':module,'source_sha256':source};start=time.perf_counter()
  for kind,command in [('build',['build',module]),('kernel',['env','leanchecker','--verbose',module])]:
   print('START',module,kind,flush=True)
   logfile=logs/(module+'_'+kind+'.log')
   with logfile.open('w',encoding='utf-8') as output:
    result=subprocess.run([args.lake]+command,cwd=project,stdout=output,stderr=subprocess.STDOUT)
   text=logfile.read_text(encoding='utf-8')
   record[kind+'_exit_code']=result.returncode
   if result.returncode or any(s in text for s in ['sorryAx','ofReduceBool','error:']):
    record['seconds']=time.perf_counter()-start;results.append(record);save('FAILED')
    print(text[-4000:]);raise SystemExit(result.returncode or 1)
  record['seconds']=round(time.perf_counter()-start,3);results.append(record);save('RUNNING')
  print('PASS',module,record['seconds'],flush=True)
 save('PASS_ALL_WALSH_REJECTIONS_KERNEL_CHECKED')
 print('PASS_ALL_WALSH_REJECTIONS_KERNEL_CHECKED',flush=True)

if __name__=='__main__':main()
