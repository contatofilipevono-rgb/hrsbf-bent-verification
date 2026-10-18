"""Build and independently kernel-replay the limited packed subtree pilot."""
from pathlib import Path
import argparse,subprocess,time,json,hashlib
p=argparse.ArgumentParser(description=__doc__);p.add_argument('--lake',default='lake');args=p.parse_args()
root=Path(__file__).resolve().parent.parent;project=root/'lean';logs=root/'reports/packed_pilot';logs.mkdir(exist_ok=True)
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
report={'status':'RUNNING','scope':'Subtree 18 only: 11 nodes, 48 transitions; no global nonexistence theorem.','sources':{n:sha(project/(n+'.lean')) for n in ['H12PackedPolynomial']+[p.stem for p in sorted(project.glob('H12PackedPilotData*.lean'))]+['H12PackedPilot']}}
start=time.perf_counter()
commands=[('build',['build','H12PackedPilotCertificate'])]+[('kernel_'+p.stem,['env','leanchecker','--verbose',p.stem]) for p in sorted(project.glob('H12PackedPilotData*.lean'))]+[('kernel_H12PackedPilot',['env','leanchecker','--verbose','H12PackedPilot'])]
for phase,command in commands:
 print('START',phase,flush=True)
 logfile=logs/(phase+'.log')
 with logfile.open('w',encoding='utf-8') as out:r=subprocess.run([args.lake]+command,cwd=project,stdout=out,stderr=subprocess.STDOUT)
 text=logfile.read_text(encoding='utf-8');report[phase+'_exit_code']=r.returncode
 if r.returncode or any(x in text for x in ['sorryAx','ofReduceBool','error:']):
  report['status']='FAILED';report['seconds']=time.perf_counter()-start;(root/'reports/LEAN_PACKED_PILOT_AUDIT.json').write_text(json.dumps(report,indent=2));print(text[-4000:]);raise SystemExit(r.returncode or 1)
 print('PASS',phase,flush=True)
report['status']='PASS_SUBTREE_18_KERNEL_REPLAY';report['seconds']=time.perf_counter()-start
(root/'reports/LEAN_PACKED_PILOT_AUDIT.json').write_text(json.dumps(report,indent=2));print(report['status'],report['seconds'],flush=True)
