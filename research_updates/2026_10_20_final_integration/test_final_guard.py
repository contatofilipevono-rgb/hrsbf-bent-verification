"""Mocked orchestration tests only: these do not establish any Lean theorem."""
from pathlib import Path
import contextlib,hashlib,io,json,runpy,subprocess,tempfile,unittest
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
   with patch('subprocess.check_output',return_value='test-version'),patch('subprocess.run',side_effect=run),contextlib.redirect_stdout(io.StringIO()):
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
if __name__=='__main__':unittest.main()
