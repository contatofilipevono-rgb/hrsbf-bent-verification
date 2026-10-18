"""Exercise cache integrity, bounded progress and failure handling without Lean."""
import importlib.util, json, subprocess, tempfile, unittest
from pathlib import Path
from unittest.mock import patch

spec = importlib.util.spec_from_file_location('cloud_slice', Path(__file__).with_name('verify_lean_cloud_slice.py'))
cloud = importlib.util.module_from_spec(spec)
spec.loader.exec_module(cloud)

class CloudSliceTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix='.lean-cloud-test-', dir=Path.cwd())
        assert Path(self.temp.name).resolve().parent == Path.cwd().resolve()
        self.project = Path(self.temp.name) / 'lean'
        self.project.mkdir()
        (self.project / 'B.lean').write_text('def b := 1\n')
        (self.project / 'A.lean').write_text('import B\ndef a := b\n')
        self.evidence = Path(self.temp.name) / 'records'
        self.calls = []
        self.reject = False
        self.timeout = False
        self.version = patch.object(cloud.subprocess, 'check_output', return_value='Lean (version 4.35.0, test)')
        self.runner = patch.object(cloud.subprocess, 'run', side_effect=self.run_fake)
        self.version.start()
        self.runner.start()
        self.addCleanup(self.version.stop)
        self.addCleanup(self.runner.stop)
        self.addCleanup(self.temp.cleanup)

    def run_fake(self, command, **kwargs):
        self.calls.append(command)
        if self.timeout:
            raise subprocess.TimeoutExpired(command, 1)
        if command[1] == 'build':
            file = self.project / '.lake/build/lib/lean' / (command[-1] + '.olean')
            file.parent.mkdir(parents=True, exist_ok=True)
            file.write_bytes(('verified object ' + command[-1]).encode())
        if self.reject and 'leanchecker' in command:
            kwargs['stdout'].write('error: deliberate rejection\n')
            return subprocess.CompletedProcess(command, 1)
        kwargs['stdout'].write('clean verification\n')
        return subprocess.CompletedProcess(command, 0)

    def check(self, **kwargs):
        return cloud.verify(self.project, ['A'], self.evidence, 'lake', 100, **kwargs)

    def test_bounded_then_resume_in_dependency_order(self):
        first = self.check(max_modules=1)
        self.assertEqual(first['status'], 'PARTIAL_TIME_SLICE')
        self.assertFalse(first['root_coverage'])
        self.assertEqual([r['module'] for r in first['results']], ['B'])
        self.calls.clear()
        final = self.check()
        self.assertTrue(final['root_coverage'])
        self.assertFalse(final['unconditional_global_theorem'])
        self.assertEqual(len(self.calls), 2)
        self.assertTrue(all(c[-1] == 'A' for c in self.calls))

    def test_changed_source_invalidates_prior_results(self):
        self.check()
        (self.project / 'B.lean').write_text('def b := 2\n')
        self.calls.clear()
        self.check()
        self.assertEqual(len(self.calls), 4)

    def test_tampered_artifact_forces_recheck(self):
        self.check()
        (self.project / '.lake/build/lib/lean/B.olean').write_bytes(b'changed')
        self.calls.clear()
        self.check()
        self.assertEqual(self.calls[0][-1], 'B')
        self.assertEqual(len(self.calls), 2)

    def test_missing_log_forces_recheck(self):
        self.check()
        (self.evidence / 'logs/B_kernel.log').unlink()
        self.calls.clear()
        self.check()
        self.assertEqual(self.calls[0][-1], 'B')

    def test_kernel_failure_cannot_become_pass(self):
        self.reject = True
        with self.assertRaises(RuntimeError):
            self.check()
        report = json.loads((self.evidence / 'progress.json').read_text())
        self.assertEqual(report['status'], 'FAILED')
        self.assertFalse(report['root_coverage'])
        self.assertEqual(report['modules_verified'], 0)

    def test_timeout_preserves_partial_without_proof_claim(self):
        self.timeout = True
        report = self.check()
        self.assertEqual(report['status'], 'PARTIAL_MODULE_TIMEOUT')
        self.assertFalse(report['root_coverage'])
        self.assertEqual(report['modules_verified'], 0)

if __name__ == '__main__':
    unittest.main()
