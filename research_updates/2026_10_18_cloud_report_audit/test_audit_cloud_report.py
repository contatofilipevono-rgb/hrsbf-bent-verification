import copy
import hashlib
import unittest
import tempfile
from pathlib import Path
from audit_cloud_report import audit, COMPLETE

class ReportAuditTests(unittest.TestCase):
    def setUp(self):
        digest = hashlib.sha256(b'test fixture').hexdigest()
        self.report = {'status': COMPLETE, 'unconditional_global_theorem': False,
            'root_coverage': True, 'roots': ['Dependency', 'H12CloudChart2'],
            'sources': {'Dependency': digest, 'H12CloudChart2': digest},
            'modules_total': 2, 'modules_verified': 2, 'results': []}
        for name in self.report['roots']:
            self.report['results'].append({'module': name, 'source_sha256': digest,
                'olean_sha256': digest, 'build_exit_code': 0, 'kernel_exit_code': 0,
                'build_log_sha256': digest, 'kernel_log_sha256': digest})

    def test_complete_is_only_chart_report(self):
        self.assertEqual(audit(self.report, 2)['status'], 'CONSISTENT_COMPLETE_CHART_REPORT')

    def test_valid_partial_is_not_complete(self):
        self.report.update(status='PARTIAL_TIME_SLICE', root_coverage=False, modules_verified=1)
        self.report['results'].pop()
        self.assertEqual(audit(self.report, 2)['status'], 'CONSISTENT_PARTIAL_REPORT')

    def test_empty_success_rejected(self):
        self.report.update(roots=[], sources={}, results=[], modules_total=0, modules_verified=0)
        with self.assertRaises(ValueError): audit(self.report, 2)

    def test_missing_root_source_rejected(self):
        del self.report['sources']['H12CloudChart2']
        with self.assertRaises(ValueError): audit(self.report, 2)

    def test_wrong_chart_rejected(self):
        with self.assertRaises(ValueError): audit(self.report, 1)

    def test_missing_root_record_rejected(self):
        self.report['results'].pop()
        self.report['modules_verified'] = 1
        with self.assertRaises(ValueError): audit(self.report, 2)

    def test_partial_claiming_coverage_rejected(self):
        self.report['status'] = 'PARTIAL_MODULE_TIMEOUT'
        with self.assertRaises(ValueError): audit(self.report, 2)

    def test_global_claim_rejected(self):
        self.report['unconditional_global_theorem'] = True
        with self.assertRaises(ValueError): audit(self.report, 2)

    def test_failed_kernel_rejected(self):
        self.report['results'][0]['kernel_exit_code'] = 1
        with self.assertRaises(ValueError): audit(self.report, 2)

    def test_duplicate_record_rejected(self):
        self.report['results'][1] = copy.deepcopy(self.report['results'][0])
        with self.assertRaises(ValueError): audit(self.report, 2)

    def test_changed_source_rejected(self):
        self.report['results'][0]['source_sha256'] = '0'*64
        with self.assertRaises(ValueError): audit(self.report, 2)

    def test_logs_checked_and_tampering_rejected(self):
        with tempfile.TemporaryDirectory(prefix='.cloud-audit-test-', dir=Path.cwd()) as tmp:
            self.assertEqual(Path(tmp).resolve().parent, Path.cwd().resolve())
            for record in self.report['results']:
                for phase in ('build', 'kernel'):
                    (Path(tmp)/(record['module']+'_'+phase+'.log')).write_bytes(b'test fixture')
            self.assertTrue(audit(self.report, 2, Path(tmp))['logs_checked'])
            (Path(tmp)/'Dependency_kernel.log').write_bytes(b'changed')
            with self.assertRaises(ValueError): audit(self.report, 2, Path(tmp))

    def test_missing_logs_rejected(self):
        with tempfile.TemporaryDirectory(prefix='.cloud-audit-test-', dir=Path.cwd()) as tmp:
            self.assertEqual(Path(tmp).resolve().parent, Path.cwd().resolve())
            with self.assertRaises(ValueError): audit(self.report, 2, Path(tmp))

    def test_matching_hash_does_not_hide_rejected_axiom(self):
        with tempfile.TemporaryDirectory(prefix='.cloud-audit-test-', dir=Path.cwd()) as tmp:
            self.assertEqual(Path(tmp).resolve().parent, Path.cwd().resolve())
            for record in self.report['results']:
                for phase in ('build', 'kernel'):
                    raw = b'sorryAx'
                    record[phase+'_log_sha256'] = hashlib.sha256(raw).hexdigest()
                    (Path(tmp)/(record['module']+'_'+phase+'.log')).write_bytes(raw)
            with self.assertRaises(ValueError): audit(self.report, 2, Path(tmp))

if __name__ == '__main__': unittest.main()
