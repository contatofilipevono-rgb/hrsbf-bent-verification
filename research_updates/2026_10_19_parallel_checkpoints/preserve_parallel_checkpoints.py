from pathlib import Path
import base64, hashlib, importlib.util, json, subprocess, urllib.request, urllib.error, zipfile

HERE=Path(__file__).resolve().parent
REPO=Path('C:/Users/Valer/Documents/Codex/2026-10-16/https-chatgpt-com-s-cx-6ad2e1da63888191af8d539bda9b3bed/outputs/hrsbf-bent-verification')
cred=subprocess.run(['git','-c','safe.directory='+str(REPO),'-C',str(REPO),'credential','fill'],input='protocol=https\nhost=github.com\n\n',text=True,capture_output=True,check=True)
credentials=dict(s.split('=',1) for s in cred.stdout.splitlines() if '=' in s)
auth=base64.b64encode((credentials['username']+':'+credentials['password']).encode()).decode()
BASE='https://api.github.com/repos/contatofilipevono-rgb/hrsbf-bent-verification'
headers={'Authorization':'Basic '+auth,'User-Agent':'Lean-checkpoint-audit','Accept':'application/vnd.github+json'}
def get(path):
    with urllib.request.urlopen(urllib.request.Request(BASE+path,headers=headers),timeout=60) as response:
        return response.read()
class NoRedirect(urllib.request.HTTPRedirectHandler):
    def redirect_request(self,*args,**kwargs):
        return None
spec=importlib.util.spec_from_file_location('audit',REPO/'research_updates/2026_10_18_cloud_report_audit/audit_cloud_report.py')
audit=importlib.util.module_from_spec(spec);spec.loader.exec_module(audit)
dest=REPO/'research_updates/2026_10_19_parallel_checkpoints'
dest.mkdir(parents=True,exist_ok=True)
for chart,run in [(1,39258813467),(0,39258818208)]:
    state=json.loads(get(f'/actions/runs/{run}'))
    attempt=state['run_attempt']
    artifacts=json.loads(get(f'/actions/runs/{run}/artifacts'))['artifacts']
    artifact=next(a for a in artifacts if a['name']==f'lean-chart-{chart}-{run}-{attempt}')
    stem=f'chart{chart}_attempt{attempt}'
    archive=dest/(stem+'_artifact.zip')
    if not archive.exists():
        try:
            urllib.request.build_opener(NoRedirect()).open(urllib.request.Request(artifact['archive_download_url'],headers=headers),timeout=60)
        except urllib.error.HTTPError as e:
            if e.code!=302: raise
            url=e.headers['Location']
        with urllib.request.urlopen(url,timeout=120) as response:
            raw=response.read()
        assert hashlib.sha256(raw).hexdigest()==artifact['digest'].split(':')[1]
        archive.write_bytes(raw)
    raw=archive.read_bytes()
    assert hashlib.sha256(raw).hexdigest()==artifact['digest'].split(':')[1]
    local=HERE/'outputs'/f'parallel_chart{chart}_attempt{attempt}'
    local.mkdir(parents=True,exist_ok=True)
    with zipfile.ZipFile(archive) as z:
        assert z.testzip() is None
        for name in z.namelist():
            target=(local/name).resolve()
            assert target.is_relative_to(local.resolve())
        z.extractall(local)
    reports=list(local.rglob('progress.json'))
    assert len(reports)==1
    report=json.loads(reports[0].read_text())
    validation=audit.audit(report,chart,reports[0].parent/'logs')
    (dest/(stem+'_progress.json')).write_bytes(reports[0].read_bytes())
    jobs=json.loads(get(f'/actions/runs/{run}/jobs'))
    (dest/(stem+'_jobs.json')).write_bytes((json.dumps(jobs,indent=2)+'\n').encode())
    summary=dict(chart=chart,run=run,attempt=attempt,run_status=state['status'],run_conclusion=state['conclusion'],report_status=report['status'],modules_verified=report['modules_verified'],modules_total=report['modules_total'],root_coverage=report['root_coverage'],fingerprint=report.get('fingerprint'),audit=validation,artifact_sha256=hashlib.sha256(raw).hexdigest(),global_proof_complete=False)
    (dest/(stem+'_audit.json')).write_bytes((json.dumps(summary,indent=2)+'\n').encode())
    print(json.dumps(summary),flush=True)
