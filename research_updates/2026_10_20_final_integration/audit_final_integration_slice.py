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
 for rec in q['new_modules']:
  for phase in ('build','kernel'):
   f=ev/(rec['module']+'_'+phase+'.log');assert rec[phase+'_exit_code']==0 and sha(f)==rec[phase+'_log_sha256']
   assert not any(t in f.read_text() for t in ('sorryAx','ofReduceBool','error:'))
 # Final theorem acceptance needs the explicit source/object/axiom audit too.
 raise RuntimeError('Final status: perform final declaration audit before publication as a proof')
result=dict(run=args.run,attempt=args.attempt,status='PASS_PARTIAL_EVIDENCE_AND_BINARY_SNAPSHOT_AUDIT',report_status=q['status'],global_proof_complete=False,reconstructed_this_slice=len(q['reconstructed']),certified_binary_modules_preserved=len(objects),snapshot_files_verified=len(checked),snapshot_sha256=m['archive_sha256'],cache_key=matches[0][0],cache_bytes=int(matches[0][1]),last_validated_object=q['last_validated_object'],next_module=q['next_module'],reconstruction_logs_sha256=logs)
(dest/(stem+'_AUDIT.json')).write_text(json.dumps(result,indent=2)+'\n')
shutil.copyfile(ev/'chart2_snapshot_manifest.json',dest/(stem+'_snapshot_manifest.json'))
print(json.dumps({k:v for k,v in result.items() if k!='reconstruction_logs_sha256'}))
