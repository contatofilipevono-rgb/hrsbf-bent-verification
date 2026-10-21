"""Audit archived integration evidence without executing Lean."""
from pathlib import Path,PurePosixPath
import argparse,hashlib,json,re,tarfile,shutil
p=argparse.ArgumentParser();p.add_argument('run',type=int);p.add_argument('attempt',type=int);args=p.parse_args()
repo=Path('C:/Users/Valer/Documents/Codex/2026-10-16/https-chatgpt-com-s-cx-6ad2e1da63888191af8d539bda9b3bed/outputs/hrsbf-bent-verification')
dest=repo/'research_updates/2026_10_20_final_integration';stem=f'run{args.run}_attempt{args.attempt}'
root=Path('outputs/final_integration')/stem;ev=root/'final_integration'
def sha(path):
 with path.open('rb') as f:return hashlib.file_digest(f,'sha256').hexdigest()
plan=json.loads((dest/'integration_plan.json').read_bytes())
q=json.loads((ev/'integration_report.json').read_bytes())
assert q['checked_inputs']==[dict(chart=c['chart'],modules=c['modules'],report_sha256=c['report_sha256']) for c in plan['charts']]
assert q['certified_modules_total']==2091 and q['lean_version']==plan['lean_version']
assert q['status'] in ('PARTIAL_OBJECT_TIMEOUT','PARTIAL_OBJECT_RECONSTRUCTION','PASS_FINAL_KERNEL_INTEGRATION')
assert q['global_proof_complete']==(q['status']=='PASS_FINAL_KERNEL_INTEGRATION')
old=Path('outputs/cloud_checkpoint4/cloud_progress/chart2/progress.json')
assert sha(old)==plan['charts'][2]['report_sha256']
cert={r['module']:r for r in json.loads(old.read_bytes())['results']}
m=json.loads((ev/'chart2_snapshot_manifest.json').read_bytes());archive=ev/'chart2_certified_objects.tar.gz'
assert sha(archive)==m['archive_sha256']
checked=set();objects={}
with tarfile.open(archive,'r:gz') as tar:
 for member in tar:
  name=member.name;path=PurePosixPath(name)
  assert member.isfile() and not path.is_absolute() and '..' not in path.parts and '\\' not in name and name.startswith('lean/.lake/')
  assert name not in checked and name in m['files'];checked.add(name)
  with tar.extractfile(member) as f:digest=hashlib.file_digest(f,'sha256').hexdigest()
  assert digest==m['files'][name],name
  if name.endswith('.olean'):
   n=path.name[:-6];assert n in cert and digest==cert[n]['olean_sha256'];objects[n]=digest
assert checked==set(m['files']) and set(objects)==set(m['modules'])
assert len(q['reconstructed'])==len(set(q['reconstructed'])) and set(q['reconstructed'])<=set(objects)
logs={}
for n in q['reconstructed']:
 f=ev/(n+'_reconstruct.log');text=f.read_text()
 assert 'Build completed successfully' in text and not any(t in text for t in ('sorryAx','ofReduceBool','error:'))
 logs[n]=sha(f)
assert q['last_validated_object'] in objects or not q['last_validated_object'].startswith('H12CloudChart2')
job=(dest/(stem+'_job.log')).read_text()
matches=re.findall(r'PASS_CACHE_PERSISTENCE\s+(lean-h12-integration-v3-\S+)\s+(\d+)',job)
assert len(matches)==1 and matches[0][0].endswith(f'-{args.run}-{args.attempt}') and int(matches[0][1])>0
assert 'PASS_PROCESS_TREE_TIMEOUT_TEST' in job and 'PASS_INDEPENDENT_BINARY_SNAPSHOT' in job
assert 'Cache save failed' not in job and 'file changed as we read it' not in job
if q['status']=='PASS_FINAL_KERNEL_INTEGRATION':
 assert 'CERTIFIED_OBJECT_UNION_READY 2091' in job
 assert [x['module'] for x in q['new_modules']]==['H12Fourier','H12Final']
 final_records={}
 for rec in q['new_modules']:
  n=rec['module'];source=dest/'certified_final_sources'/(n+'.lean')
  assert sha(source)==rec['source_sha256']
  text=source.read_text();assert not re.search(r'^\s*(axiom|opaque)\b|\bsorry\b|\bnative_decide\b|ofReduceBool',text,re.M)
  obj=root/'lean/.lake/build/lib/lean'/(n+'.olean');assert sha(obj)==rec['olean_sha256']
  for phase in ('build','kernel'):
   f=ev/(rec['module']+'_'+phase+'.log');assert rec[phase+'_exit_code']==0 and sha(f)==rec[phase+'_log_sha256']
   assert not any(t in f.read_text() for t in ('sorryAx','ofReduceBool','error:'))
  assert 'replaying '+n in (ev/(n+'_kernel.log')).read_text()
  final_records[n]=rec
 final=(dest/'certified_final_sources/H12Final.lean').read_text()
 assert re.findall(r'^import\s+(\w+)',final,re.M)==['H12CloudChart0','H12CloudChart1','H12CloudChart2','H12Fourier']
 assert all('exact H12CloudChart'+str(i)+'.refutation' in final for i in range(3))
 expected='theorem no_bent_quartic (c : BitVec 43) : ¬ H12Descent.BentAC (H12.quarticFunction c) :='
 assert expected in ' '.join(final.split())
 build=(ev/'H12Final_build.log').read_text()
 assert 'theorem H12Final.no_bent_quartic : ∀ (c : BitVec 43), ¬H12Descent.BentAC (H12.quarticFunction c) :=' in build
 assert 'theorem H12Final.no_flat_quartic : ∀ (c : BitVec 43), ¬H12Fourier.WalshFlat (H12.quarticFunction c) :=' in build
 axioms={}
 for declaration in ('all_chart_refutations','no_bent_quartic','no_flat_quartic','walsh_witness'):
  match=re.search(r"'H12Final\."+declaration+r"' depends on axioms: \[([^\]]*)\]",build);assert match
  actual=[x.strip() for x in match[1].split(',')];assert set(actual)=={'propext','Classical.choice','Quot.sound'};axioms[declaration]=actual
 # Independently recheck the concrete monomial basis against a certified source.
 paths=[repo/'research_updates/2026_10_20_stable_migration/checkpoints/chart0_stable_run39358421659_attempt3_progress.json',repo/'research_updates/2026_10_20_stable_migration/checkpoints/chart1_stable_run39358413248_attempt5_progress.json',old]
 union={}
 for entry,path in zip(plan['charts'],paths):
  assert sha(path)==entry['report_sha256']
  for rec in json.loads(path.read_bytes())['results']:
   if rec['module'] in union:assert all(rec[k]==union[rec['module']][k] for k in ('source_sha256','olean_sha256'))
   union[rec['module']]=rec
 assert len(union)==2091
 source=(repo/'quartic_audit_2026_10_17/lean/H12PeriodFour.lean').read_bytes()
 assert hashlib.sha256(source).hexdigest()==union['H12PeriodFour']['source_sha256']
 text=source.decode();orbits=json.loads(text.split('def quarticOrbits : List (List Nat) := ',1)[1].split('def periodicColumns',1)[0].strip())
 flat=[x for orbit in orbits for x in orbit];assert len(orbits)==43 and len(flat)==len(set(flat))==495
 assert set(flat)=={x for x in range(4096) if x.bit_count()==4}
 rot=lambda x:((x<<1)&4095)|(x>>11)
 assert all({rot(x) for x in orbit}==set(orbit) for orbit in orbits)
 assert set(objects)=={n for n in cert if n.startswith('H12CloudChart2')}
 assert set(json.loads((Path('outputs/final_integration')/f'run{args.run}_attempt1'/'final_integration/chart2_snapshot_manifest.json').read_bytes())['modules'])<=set(objects)
 for rec in q['new_modules']:
  n=rec['module'];od=dest/'certified_final_objects';od.mkdir(exist_ok=True)
  shutil.copyfile(root/'lean/.lake/build/lib/lean'/(n+'.olean'),od/(n+'.olean'))
  for phase in ('build','kernel'):shutil.copyfile(ev/(n+'_'+phase+'.log'),dest/(n+'_'+phase+'_FINAL.log'))
result=dict(run=args.run,attempt=args.attempt,status='PASS_FINAL_ENUNCIADO_SOURCE_OBJECT_AXIOM_AND_SNAPSHOT_AUDIT' if q['global_proof_complete'] else 'PASS_PARTIAL_EVIDENCE_AND_BINARY_SNAPSHOT_AUDIT',report_status=q['status'],global_proof_complete=q['global_proof_complete'],reconstructed_this_slice=len(q['reconstructed']),certified_binary_modules_preserved=len(objects),snapshot_files_verified=len(checked),snapshot_sha256=m['archive_sha256'],cache_key=matches[0][0],cache_bytes=int(matches[0][1]),last_validated_object=q['last_validated_object'],next_module=q.get('next_module'),reconstruction_logs_sha256=logs)
if q['global_proof_complete']:result.update(new_modules=final_records,axioms=axioms,orbit_basis=dict(orbits=43,disjoint_monomials=495,all_weight_four_masks=True,cyclic_closed=True),scope=q['scope'])
(dest/(stem+'_AUDIT.json')).write_text(json.dumps(result,indent=2)+'\n')
shutil.copyfile(ev/'chart2_snapshot_manifest.json',dest/(stem+'_snapshot_manifest.json'))
print(json.dumps({k:v for k,v in result.items() if k!='reconstruction_logs_sha256'}))
