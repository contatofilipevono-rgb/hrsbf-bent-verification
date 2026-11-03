"""Adversarial orchestration tests. Fake objects here are not Lean evidence."""
from pathlib import Path
import contextlib
import copy
import hashlib
import io
import json
import tempfile
import unittest
from unittest.mock import patch

import verify_lean_cloud_resume as resume


class ResumeTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.project = Path(self.temp.name)/'project'
        self.evidence = Path(self.temp.name)/'evidence'
        self.logs = self.evidence/'logs'
        self.objects = self.project/'.lake/build/lib/lean'
        self.logs.mkdir(parents=True)
        self.objects.mkdir(parents=True)
        (self.project/'ResumeA.lean').write_text('theorem fixture_a : True := True.intro\n')
        (self.project/'ResumeB.lean').write_text('import ResumeA\ntheorem fixture_b : True := fixture_a\n')
        self.roots = ['ResumeB']
        self.order = ['ResumeA','ResumeB']
        self.toolchain = {'version':'Lean (version 4.35.0, fixture)', 'target':'linux-x86_64',
                          'release_archive_sha256':resume.RELEASE_SHA256,
                          'binaries':{'lean':'1'*64,'leanchecker':'2'*64,'lake':'3'*64}}
        self.sources = {n:resume.sha(self.project/(n+'.lean')) for n in self.order}
        self.identity = resume.verification_identity(self.sources,self.roots,self.toolchain)
        (self.objects/'ResumeA.olean').write_bytes(b'orchestration fixture, not a real Lean object')
        record = {'module':'ResumeA','source_sha256':self.sources['ResumeA'],
                  'olean_sha256':resume.sha(self.objects/'ResumeA.olean')}
        for phase in ('build','kernel'):
            path = self.logs/('ResumeA_'+phase+'.log')
            path.write_text('successful fixture phase\n')
            record[phase+'_exit_code'] = 0
            record[phase+'_log_sha256'] = resume.sha(path)
        self.old = {'status':'PARTIAL_TIME_SLICE','root_coverage':False,
                    'unconditional_global_theorem':False,'roots':self.roots,'sources':self.sources,
                    'fingerprint':'f'*64,'lean_version':self.toolchain['version'],
                    'modules_total':2,'modules_verified':1,'results':[record]}

    def save_old(self, old=None):
        raw = (json.dumps(old or self.old,indent=2)+'\n').encode()
        (self.evidence/'progress.json').write_bytes(raw)
        return raw,hashlib.sha256(raw).hexdigest()

    def check(self,old=None,expected=None):
        raw,sha = self.save_old(old)
        return resume.checked_prior(json.loads(raw),sha,self.identity,self.order,
                                    self.project,self.logs,expected if expected is not None else sha)

    def run_verify(self,**kw):
        with patch.object(resume,'toolchain_identity',return_value=self.toolchain), contextlib.redirect_stdout(io.StringIO()):
            return resume.verify(self.project,self.roots,self.evidence,'lake',**kw)

    def test_audited_legacy_import(self):
        records,mode = self.check()
        self.assertEqual(mode,'audited_legacy_digest')
        self.assertEqual(len(records),1)

    def test_legacy_digest_required(self):
        with self.assertRaisesRegex(ValueError,'requires the audited'):
            self.check(expected='')

    def test_wrong_legacy_digest(self):
        with self.assertRaisesRegex(ValueError,'differs from the audited'):
            self.check(expected='0'*64)

    def test_log_corruption(self):
        (self.logs/'ResumeA_kernel.log').write_text('changed\n')
        with self.assertRaisesRegex(ValueError,'changed checked log'):
            self.check()

    def test_object_corruption(self):
        (self.objects/'ResumeA.olean').write_bytes(b'changed')
        with self.assertRaisesRegex(ValueError,'changed checked object'):
            self.check()

    def test_rejected_kernel_marker_even_with_matching_hash(self):
        for marker in resume.FORBIDDEN:
            with self.subTest(marker=marker):
                path = self.logs/'ResumeA_kernel.log'
                path.write_text(marker+'\n')
                old = copy.deepcopy(self.old)
                old['results'][0]['kernel_log_sha256'] = resume.sha(path)
                with self.assertRaisesRegex(ValueError,'Rejected evidence'):
                    self.check(old)

    def test_changed_source_manifest(self):
        old = copy.deepcopy(self.old)
        old['sources']['ResumeA'] = '0'*64
        with self.assertRaisesRegex(ValueError,'source manifest differs'):
            self.check(old)

    def test_changed_version(self):
        old = copy.deepcopy(self.old)
        old['lean_version'] += ' changed'
        with self.assertRaisesRegex(ValueError,'Lean version differs'):
            self.check(old)

    def test_duplicate_record_rejected(self):
        old = copy.deepcopy(self.old)
        old['results'] *= 2
        old['modules_verified'] = 2
        with self.assertRaisesRegex(ValueError,'exact dependency prefix'):
            self.check(old)

    def test_failed_phase_rejected(self):
        old = copy.deepcopy(self.old)
        old['results'][0]['kernel_exit_code'] = 1
        with self.assertRaisesRegex(ValueError,'Unsuccessful saved phase'):
            self.check(old)

    def test_false_complete_rejected(self):
        old = copy.deepcopy(self.old)
        old['status'] = resume.COMPLETE
        old['root_coverage'] = True
        with self.assertRaisesRegex(ValueError,'Inconsistent complete'):
            self.check(old)

    def test_unknown_schema_rejected(self):
        old = copy.deepcopy(self.old)
        old['schema_version'] = 99
        with self.assertRaisesRegex(ValueError,'Unknown saved report schema'):
            self.check(old)

    def test_rejection_does_not_overwrite_progress(self):
        raw,_ = self.save_old()
        with self.assertRaises(ValueError):
            self.run_verify(seconds=0,legacy_report_sha256='0'*64)
        self.assertEqual((self.evidence/'progress.json').read_bytes(),raw)
        self.assertFalse((self.evidence/'history').exists())

    def test_native_resume_survives_kernel_description_change(self):
        raw,sha = self.save_old()
        with patch.object(resume.platform,'platform',return_value='Linux old host'):
            first = self.run_verify(seconds=0,legacy_report_sha256=sha)
        with patch.object(resume.platform,'platform',return_value='Linux new host'), patch.object(resume.subprocess,'run',side_effect=AssertionError('must not rebuild prior modules')):
            second = self.run_verify(seconds=0)
        self.assertEqual(first['fingerprint'],second['fingerprint'])
        self.assertNotEqual(first['execution_environment'],second['execution_environment'])
        self.assertEqual(second['modules_reused'],1)
        self.assertEqual(second['modules_verified_new'],0)
        self.assertEqual(second['resume']['mode'],'stable_identity')
        self.assertEqual((self.evidence/'history'/(sha+'.json')).read_bytes(),raw)

    def test_actual_toolchain_identity_change_rejected(self):
        _,sha = self.save_old()
        self.run_verify(seconds=0,legacy_report_sha256=sha)
        self.toolchain = copy.deepcopy(self.toolchain)
        self.toolchain['binaries']['leanchecker'] = '4'*64
        with self.assertRaisesRegex(ValueError,'verification identity differs'):
            self.run_verify(seconds=0)

    def test_only_remaining_module_is_executed(self):
        _,sha = self.save_old()
        calls = []
        def fake_run(command,**kw):
            calls.append(command)
            self.assertEqual(command[-1],'ResumeB')
            kw['stdout'].write('fixture success\n')
            (self.objects/'ResumeB.olean').write_bytes(b'new orchestration fixture')
            return type('Result',(),{'returncode':0})()
        with patch.object(resume.subprocess,'run',side_effect=fake_run):
            result = self.run_verify(seconds=60,legacy_report_sha256=sha)
        self.assertEqual(len(calls),2)
        self.assertEqual(result['modules_reused'],1)
        self.assertEqual(result['modules_verified_new'],1)
        self.assertTrue(result['root_coverage'])
        self.assertFalse(result['unconditional_global_theorem'])


if __name__ == '__main__':
    unittest.main(verbosity=2)

