from pathlib import Path
import argparse,hashlib,json,shutil,urllib.request,urllib.error,zipfile
from check_integration_remote import get,h,base,R
p=argparse.ArgumentParser();p.add_argument('run',type=int);a=p.parse_args()
state=get(f'/actions/runs/{a.run}');assert state['status']=='completed','Never preserve an unfinished run as final'
attempt=state['run_attempt'];name=f'lean-final-integration-{a.run}-{attempt}'
artifact=next(x for x in get(f'/actions/runs/{a.run}/artifacts')['artifacts'] if x['name']==name)
d=R/'research_updates/2026_10_20_final_integration';stem=f'run{a.run}_attempt{attempt}'
local=Path('outputs/final_integration')/stem;local.mkdir(parents=True,exist_ok=True)
# Large binary snapshots stay in the conversation and GitHub artifact storage;
# publish their digests and audit records rather than exceeding Git's file limit.
zpath=(d if artifact['size_in_bytes']<=50_000_000 else local)/(stem+'_artifact.zip')
def digest(path):
 with path.open('rb') as f:return hashlib.file_digest(f,'sha256').hexdigest()
class NoRedirect(urllib.request.HTTPRedirectHandler):
 def redirect_request(self,*args,**kwargs):return None
if not zpath.exists():
 try:urllib.request.build_opener(NoRedirect()).open(urllib.request.Request(artifact['archive_download_url'],headers=h),timeout=60)
 except urllib.error.HTTPError as ex:
  assert ex.code==302;url=ex.headers['Location']
 temp=zpath.with_suffix('.download')
 with urllib.request.urlopen(url,timeout=120) as response,temp.open('wb') as out:shutil.copyfileobj(response,out,length=8*1024*1024)
 assert digest(temp)==artifact['digest'].split(':')[1]
 temp.replace(zpath)
assert digest(zpath)==artifact['digest'].split(':')[1]
with zipfile.ZipFile(zpath) as z:
 assert z.testzip() is None
 assert all((local/n).resolve().is_relative_to(local.resolve()) for n in z.namelist())
 z.extractall(local)
reports=list(local.rglob('integration_report.json'));assert len(reports)==1
q=json.loads(reports[0].read_bytes());shutil.copyfile(reports[0],d/(stem+'_integration_report.json'))
if zpath.resolve()!=(local/zpath.name).resolve():shutil.copyfile(zpath,local/zpath.name)
meta=dict(run=a.run,attempt=attempt,conclusion=state['conclusion'],artifact_sha256=digest(zpath),artifact_id=artifact['id'],artifact_bytes=artifact['size_in_bytes'],local_zip=str(zpath.resolve()),report_status=q['status'],global_proof_complete=q['global_proof_complete'])
(d/(stem+'_preservation.json')).write_text(json.dumps(meta,indent=2)+'\n');print(json.dumps(meta))
