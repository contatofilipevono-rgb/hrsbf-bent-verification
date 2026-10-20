"""Bounded integration with exact reuse of certified chart objects."""
from pathlib import Path
import hashlib,json,os,re,subprocess,time

R=Path(__file__).resolve().parent.parent; P=R/'lean'; E=R/'final_integration'; E.mkdir(exist_ok=True)
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
plan=json.loads(Path(__file__).with_name('integration_plan.json').read_bytes())
report=dict(status='PREFLIGHT',global_proof_complete=False,checked_inputs=[],reconstructed=[],new_modules=[])
def save():
 p=E/'integration_report.json'; t=p.with_suffix('.tmp'); t.write_text(json.dumps(report,indent=2)+'\n'); t.replace(p)
def run_logged(cmd,log,timeout):
 with log.open('w') as out:r=subprocess.run(cmd,cwd=P,stdout=out,stderr=subprocess.STDOUT,timeout=timeout)
 text=log.read_text(); assert r.returncode==0 and not any(t in text for t in ('sorryAx','ofReduceBool','error:')),str(log)
 return r
save(); start=time.monotonic(); budget=165*60
try:
 version=subprocess.check_output(['lake','env','lean','--version'],cwd=P,text=True).strip()
 assert version==plan['lean_version']; report['lean_version']=version
 expected={}; origins={}; order=[]
 for entry in plan['charts']:
  c=entry['chart']; pf=R/f'cloud_progress/chart{c}/progress.json'
  assert sha(pf)==entry['report_sha256'],f'Chart {c} report digest'
  q=json.loads(pf.read_bytes()); assert q['root_coverage'] and q['status']=='PASS_CHART_DEPENDENCIES_AND_ROOT_KERNEL_REPLAY'
  assert q['modules_verified']==q['modules_total']==entry['modules'] and q['results'][-1]['module']==f'H12CloudChart{c}'
  for rec in q['results']:
   n=rec['module']; assert sha(P/(n+'.lean'))==q['sources'][n]==rec['source_sha256'],n+' source'
   for phase in ('build','kernel'):
    log=pf.parent/'logs'/(n+'_'+phase+'.log')
    assert rec[phase+'_exit_code']==0 and sha(log)==rec[phase+'_log_sha256'],n+' log digest'
    assert not any(t in log.read_text() for t in ('sorryAx','ofReduceBool','error:')),n+' log content'
   if n in expected:assert all(rec[k]==expected[n][k] for k in ('source_sha256','olean_sha256')),n+' shared mismatch'
   else: order.append(n); origins[n]=c
   expected[n]=rec
  report['checked_inputs'].append(dict(chart=c,modules=q['modules_verified'],report_sha256=sha(pf)))
 report['certified_modules_total']=len(expected); save()
 for n in order:
  obj=P/'.lake/build/lib/lean'/(n+'.olean')
  if not obj.exists():
   assert origins[n]==2,n+' unexpected missing object from charts 0/1'
   if time.monotonic()-start>=budget:
    report.update(status='PARTIAL_OBJECT_RECONSTRUCTION',next_module=n); save(); print(report['status'],n,flush=True); raise SystemExit(0)
   print('RECONSTRUCT_CERTIFIED_OBJECT',n,flush=True); obj.parent.mkdir(parents=True,exist_ok=True)
   try:run_logged(['lake','build',n],E/(n+'_reconstruct.log'),min(1800,budget-(time.monotonic()-start)))
   except subprocess.TimeoutExpired:
    if obj.exists():obj.unlink()
    report.update(status='PARTIAL_OBJECT_TIMEOUT',next_module=n); save(); print(report['status'],n,flush=True); raise SystemExit(0)
   report['reconstructed'].append(n)
  assert sha(obj)==expected[n]['olean_sha256'],n+' object differs from certified record'
  report['last_validated_object']=n; save()
 print('CERTIFIED_OBJECT_UNION_READY',len(expected),flush=True)
 new=[]; seen=set()
 def visit(n):
  if n in seen or n in expected:return
  seen.add(n); p=P/(n+'.lean'); assert p.exists(),n
  for dep in re.findall(r'^import\s+(\w+)',p.read_text(),re.M):
   if dep!='Std':visit(dep)
  new.append(n)
 visit('H12Final')
 for n in new:
  src=P/(n+'.lean'); assert not re.search(r'^\s*(axiom|opaque)\b|\bsorry\b|\bnative_decide\b|ofReduceBool',src.read_text(),re.M)
  rec=dict(module=n,source_sha256=sha(src)); obj=P/'.lake/build/lib/lean'/(n+'.olean')
  for phase,cmd in [('build',['lake','env','lean','-o',str(obj),n+'.lean']),('kernel',['lake','env','leanchecker','--verbose',n])]:
   print('START_FINAL',n,phase,flush=True); log=E/(n+'_'+phase+'.log'); run_logged(cmd,log,1800)
   rec[phase+'_exit_code']=0; rec[phase+'_log_sha256']=sha(log)
  rec['olean_sha256']=sha(obj); report['new_modules'].append(rec); save()
 text=(E/'H12Final_build.log').read_text()
 for theorem in ('all_chart_refutations','no_bent_quartic','no_flat_quartic','walsh_witness'):
  match=re.search(r"'H12Final\."+theorem+r"' depends on axioms: \[([^\]]*)\]",text)
  assert match,'Missing axiom report '+theorem
  assert set(x.strip() for x in match[1].split(',')) <= {'propext','Classical.choice','Quot.sound'},match[0]
 report.update(status='PASS_FINAL_KERNEL_INTEGRATION',global_proof_complete=True,scope='All c : BitVec 43 in the explicit quartic cyclic basis on 12 variables; no BentAC and no WalshFlat.')
 save(); print(report['status'],flush=True)
except SystemExit:raise
except BaseException as ex:
 report.update(status='FAILED',error=str(ex)); save(); raise
