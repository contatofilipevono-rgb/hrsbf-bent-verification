"""Mocked orchestration tests only: these do not establish any Lean theorem."""
from pathlib import Path
import ast,contextlib,hashlib,io,json,runpy,subprocess,tempfile,unittest,signal,os,re,textwrap
from unittest.mock import patch

SCRIPT=Path(__file__).with_name('verify_final_v2.py').read_text()
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
class GuardTests(unittest.TestCase):
 def case(self,mutation=None,wrong_rebuild=False,forbidden=False):
  with contextlib.nullcontext(tempfile.mkdtemp(prefix='guard-fixture-',dir=Path(__file__).parent)) as tmp:
   root=Path(tmp); (root/'tools').mkdir(); (root/'lean/.lake/build/lib/lean').mkdir(parents=True)
   script=root/'tools/verify_final.py'; script.write_text(SCRIPT); plan=dict(lean_version='test-version',charts=[])
   for c in range(3):
    n=f'H12CloudChart{c}'; src=root/f'lean/{n}.lean'; src.write_text('import Std\n')
    obj=root/f'lean/.lake/build/lib/lean/{n}.olean'; obj.write_bytes(n.encode())
    d=root/f'cloud_progress/chart{c}'; (d/'logs').mkdir(parents=True)
    rec=dict(module=n,source_sha256=sha(src),olean_sha256=sha(obj))
    for phase in ('build','kernel'):
     p=d/f'logs/{n}_{phase}.log';p.write_text('passed\n');rec[phase+'_exit_code']=0;rec[phase+'_log_sha256']=sha(p)
    q=dict(root_coverage=True,status='PASS_CHART_DEPENDENCIES_AND_ROOT_KERNEL_REPLAY',modules_verified=1,modules_total=1,results=[rec],sources={n:sha(src)})
    pf=d/'progress.json';pf.write_text(json.dumps(q));plan['charts'].append(dict(chart=c,modules=1,report_sha256=sha(pf)))
   (root/'tools/integration_plan.json').write_text(json.dumps(plan)); (root/'lean/H12Final.lean').write_text('import Std\n')
   if mutation:mutation(root)
   def run(cmd,cwd,stdout,**kw):
    if cmd[1]=='build':
     n=cmd[2]; (Path(cwd)/f'.lake/build/lib/lean/{n}.olean').write_bytes(b'bad' if wrong_rebuild else n.encode())
    else:
     if '-o' in cmd:Path(cmd[cmd.index('-o')+1]).write_bytes(b'final')
     if '-o' in cmd:
      for n in ('all_chart_refutations','no_bent_quartic','no_flat_quartic','walsh_witness'):stdout.write(f"'H12Final.{n}' depends on axioms: [propext, Classical.choice, Quot.sound]\n")
     if forbidden:stdout.write('sorryAx\n')
    return subprocess.CompletedProcess(cmd,0)
   failed=False
   class FakeProcess:
    pid=12345
    def __init__(self,cmd,cwd,stdout,**kw):
     assert kw['start_new_session'] is True
     self.result=run(cmd,cwd,stdout)
    def wait(self,timeout=None):return self.result.returncode
   with patch('sys.platform','linux'),patch('signal.SIGKILL',9,create=True),patch('os.killpg',create=True),patch('subprocess.check_output',return_value='test-version'),patch('subprocess.Popen',side_effect=FakeProcess),contextlib.redirect_stdout(io.StringIO()):
    try:runpy.run_path(str(script),run_name='__main__')
    except AssertionError:failed=True
   return failed,json.loads((root/'final_integration/integration_report.json').read_text())
 def test_valid_orchestration(self):self.assertFalse(self.case()[0])
 def test_source_tamper(self):self.assertTrue(self.case(lambda r:(r/'lean/H12CloudChart0.lean').write_text('changed'))[0])
 def test_object_tamper(self):self.assertTrue(self.case(lambda r:(r/'lean/.lake/build/lib/lean/H12CloudChart0.olean').write_bytes(b'changed'))[0])
 def test_log_tamper(self):self.assertTrue(self.case(lambda r:(r/'cloud_progress/chart0/logs/H12CloudChart0_kernel.log').write_text('changed'))[0])
 def test_report_tamper(self):self.assertTrue(self.case(lambda r:(r/'cloud_progress/chart0/progress.json').write_text('{}'))[0])
 def test_missing_chart0_refused(self):self.assertTrue(self.case(lambda r:(r/'lean/.lake/build/lib/lean/H12CloudChart0.olean').unlink())[0])
 def test_chart2_exact_reconstruction(self):
  failed,q=self.case(lambda r:(r/'lean/.lake/build/lib/lean/H12CloudChart2.olean').unlink());self.assertFalse(failed);self.assertEqual(q['reconstructed'],['H12CloudChart2'])
 def test_chart2_wrong_reconstruction_refused(self):self.assertTrue(self.case(lambda r:(r/'lean/.lake/build/lib/lean/H12CloudChart2.olean').unlink(),wrong_rebuild=True)[0])
 def test_forbidden_axiom_refused(self):self.assertTrue(self.case(forbidden=True)[0])
class ProcessAndSnapshotTests(unittest.TestCase):
 def test_timeout_reaps_parent_and_kills_group(self):
  ns={};exec(SCRIPT.split("if '--self-test-process-tree'")[0],ns)
  class Process:
   pid=71823
   def __init__(self):self.waits=0
   def wait(self,timeout=None):
    self.waits+=1
    if timeout is not None:raise subprocess.TimeoutExpired('fake',timeout)
    return -9
  p=Process()
  with patch('sys.platform','linux'),patch('subprocess.Popen',return_value=p) as start,patch('signal.SIGKILL',9,create=True),patch('os.killpg',create=True) as kill:
   with self.assertRaises(subprocess.TimeoutExpired):ns['isolated_command'](['fake'],'.',io.StringIO(),0.01)
   self.assertTrue(start.call_args.kwargs['start_new_session']);kill.assert_called_once_with(71823,9);self.assertEqual(p.waits,2)
 def test_workflow_embedded_python_and_snapshot(self):
  workflow=Path(__file__).with_name('lean-integration-v2.yml').read_text()
  blocks=[textwrap.dedent(s) for s in re.findall(r"          python - <<'PY'\n(.*?)          PY",workflow,re.S)]
  self.assertEqual(len(blocks),2)
  for block in blocks:ast.parse(block)
  with contextlib.nullcontext(tempfile.mkdtemp(prefix='snapshot-fixture-',dir=Path(__file__).parent)) as td:
   root=Path(td);lib=root/'lean/.lake/build/lib/lean';lib.mkdir(parents=True)
   (root/'cloud_progress/chart2').mkdir(parents=True);(root/'final_integration').mkdir()
   good=lib/'H12CloudChart2Data000.olean';good.write_bytes(b'good')
   bad=lib/'H12CloudChart2Data001.olean';bad.write_bytes(b'bad')
   records=[dict(module=p.stem,olean_sha256=hashlib.sha256(b'good').hexdigest()) for p in (good,bad)]
   (root/'cloud_progress/chart2/progress.json').write_text(json.dumps(dict(results=records)))
   with patch('pathlib.Path.cwd',return_value=root),contextlib.redirect_stdout(io.StringIO()):exec(blocks[0],{})
   m=json.loads((root/'final_integration/chart2_snapshot_manifest.json').read_bytes())
   self.assertEqual(m['modules'],['H12CloudChart2Data000']);self.assertEqual(len(m['files']),1)
if __name__=='__main__':unittest.main()
