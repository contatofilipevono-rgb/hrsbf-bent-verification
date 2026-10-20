"""Link three completed chart roots without replaying their large prefixes."""
from pathlib import Path
import hashlib, json, re, subprocess, sys

R=Path(__file__).resolve().parent.parent
P=R/'lean'; E=R/'final_integration'; E.mkdir(exist_ok=True)
def sha(p): return hashlib.sha256(p.read_bytes()).hexdigest()
plan=json.loads((Path(__file__).with_name('integration_plan.json')).read_bytes())
report=dict(status='PREFLIGHT',global_proof_complete=False,checked_inputs=[],new_modules=[])
def save(): (E/'integration_report.json').write_text(json.dumps(report,indent=2)+'\n')
save()
try:
 expected={}
 for entry in plan['charts']:
  c=entry['chart']; pf=R/f'cloud_progress/chart{c}/progress.json'
  assert sha(pf)==entry['report_sha256'],f'Chart {c}: report digest mismatch'
  q=json.loads(pf.read_bytes())
  assert q['root_coverage'] and q['status']=='PASS_CHART_DEPENDENCIES_AND_ROOT_KERNEL_REPLAY'
  assert q['modules_verified']==q['modules_total']==entry['modules']
  assert q['results'][-1]['module']==f'H12CloudChart{c}'
  for rec in q['results']:
   n=rec['module']
   assert sha(P/(n+'.lean'))==q['sources'][n]==rec['source_sha256'],n+' source'
   obj=P/'.lake/build/lib/lean'/(n+'.olean')
   if not obj.exists():
    assert c==2, n+' unexpected missing cached object'
    print('RECONSTRUCT_CERTIFIED_OBJECT',n,flush=True)
    log=E/(n+'_reconstruct.log')
    with log.open('w') as out:
     rebuilt=subprocess.run(['lake','build',n],cwd=P,stdout=out,stderr=subprocess.STDOUT,timeout=1800)
    assert rebuilt.returncode==0,n+' reconstruction failed'
    assert not any(t in log.read_text() for t in ('sorryAx','ofReduceBool','error:'))
   assert sha(obj)==rec['olean_sha256'],n+' object differs from already-certified artifact'
   for phase in ('build','kernel'):
    log=pf.parent/'logs'/(n+'_'+phase+'.log')
    assert rec[phase+'_exit_code']==0 and sha(log)==rec[phase+'_log_sha256'],n+' '+phase
    assert not any(t in log.read_text() for t in ('sorryAx','ofReduceBool','error:')),n+' rejected log'
   if n in expected:
    assert all(rec[k]==expected[n][k] for k in ('source_sha256','olean_sha256')),n+' shared mismatch'
   expected[n]=rec
  report['checked_inputs'].append(dict(chart=c,modules=q['modules_verified'],report_sha256=sha(pf)))
 print('PREFLIGHT_CERTIFIED_UNION',len(expected),flush=True)
 version=subprocess.check_output(['lake','env','lean','--version'],cwd=P,text=True).strip()
 assert version==plan['lean_version'],version
 report['lean_version']=version; report['certified_modules_reused']=len(expected); save()
 order=[]; seen=set()
 def visit(n):
  if n in seen or n in expected:return
  seen.add(n); p=P/(n+'.lean')
  assert p.exists(),n
  for dep in re.findall(r'^import\s+(\w+)',p.read_text(),re.M):
   if dep!='Std':visit(dep)
  order.append(n)
 visit('H12Final')
 for n in order:
  source=P/(n+'.lean')
  assert not re.search(r'^\s*(axiom|opaque)\b|\bsorry\b|\bnative_decide\b|ofReduceBool',source.read_text(),re.M)
  obj=P/'.lake/build/lib/lean'/(n+'.olean'); obj.parent.mkdir(parents=True,exist_ok=True)
  rec=dict(module=n,source_sha256=sha(source))
  for phase,cmd in [('build',['lake','env','lean','-o',str(obj),n+'.lean']),('kernel',['lake','env','leanchecker','--verbose',n])]:
   print('START_FINAL',n,phase,flush=True); log=E/(n+'_'+phase+'.log')
   with log.open('w') as out: result=subprocess.run(cmd,cwd=P,stdout=out,stderr=subprocess.STDOUT,timeout=1800)
   text=log.read_text(); assert result.returncode==0 and not any(t in text for t in ('sorryAx','ofReduceBool','error:')),n+' '+phase+' failed'
   rec[phase+'_exit_code']=result.returncode; rec[phase+'_log_sha256']=sha(log)
  rec['olean_sha256']=sha(obj); report['new_modules'].append(rec); save()
 final=(E/'H12Final_build.log').read_text()
 for theorem in ('all_chart_refutations','no_bent_quartic','no_flat_quartic','walsh_witness'):
  match=re.search(r"'H12Final\."+theorem+r"' depends on axioms: \[([^\]]*)\]",final)
  assert match, 'Missing axiom report '+theorem
  assert set(x.strip() for x in match[1].split(',')) <= {'propext','Classical.choice','Quot.sound'},match[0]
 report.update(status='PASS_FINAL_KERNEL_INTEGRATION',global_proof_complete=True,scope='All coefficient vectors c : BitVec 43 in the explicit quartic cyclic basis on 12 variables; no BentAC and no WalshFlat function.')
 save(); print(report['status'],flush=True)
except BaseException as ex:
 report.update(status='FAILED',error=str(ex)); save(); raise
