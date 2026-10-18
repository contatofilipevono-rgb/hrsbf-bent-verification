"""Build selected optional Lean libraries and independently replay their roots."""
from pathlib import Path
import argparse,subprocess,json,time,hashlib,tomllib,re

def main():
 p=argparse.ArgumentParser(description=__doc__);p.add_argument('--lake',default='lake');p.add_argument('--library',action='append',required=True);p.add_argument('--report',default='LEAN_EXTENSION_AUDIT.json');args=p.parse_args()
 root=Path(__file__).resolve().parent.parent;project=root/'lean';config=tomllib.loads((project/'lakefile.toml').read_text(encoding='utf-8'));libraries={x['name']:x['roots'] for x in config['lean_lib']}
 for name in args.library:
  if name not in libraries:raise SystemExit('Unknown library: '+name)
 logs=root/'reports/extensions';logs.mkdir(exist_ok=True);report={'status':'RUNNING','libraries':args.library,'scope':'Selected extension modules only. This is not an unconditional global nonexistence theorem.','results':[],'dependencies':{}}
 modules=list(dict.fromkeys(m for lib in args.library for m in libraries[lib]))
 def dep(name):
  file=project/(name+'.lean')
  if name in report['dependencies'] or not file.exists():return
  report['dependencies'][name]=hashlib.sha256(file.read_bytes()).hexdigest()
  for child in re.findall(r'^import\s+(\w+)',file.read_text(encoding='utf-8'),re.M):dep(child)
 for module in modules:dep(module)
 def save():
  (root/'reports'/args.report).write_text(json.dumps(report,indent=2))
 commands=[('build_'+lib,['build',lib]) for lib in args.library]+[('kernel_'+m,['env','leanchecker','--verbose',m]) for m in modules]
 for name,command in commands:
  print('START',name,flush=True);start=time.perf_counter();file=logs/(name+'.log')
  with file.open('w',encoding='utf-8') as out:r=subprocess.run([args.lake]+command,cwd=project,stdout=out,stderr=subprocess.STDOUT)
  text=file.read_text(encoding='utf-8');report['results'].append({'step':name,'exit_code':r.returncode,'seconds':time.perf_counter()-start})
  if r.returncode or any(x in text for x in ['sorryAx','ofReduceBool','error:']):
   report['status']='FAILED';save();print(text[-4000:]);raise SystemExit(r.returncode or 1)
  save();print('PASS',name,flush=True)
 report['status']='PASS_SELECTED_LIBRARIES_KERNEL_REPLAY';report['modules']=modules;save();print(report['status'],len(modules),flush=True)

if __name__=='__main__':main()
