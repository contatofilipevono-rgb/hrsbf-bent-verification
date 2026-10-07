"""Independent scalar Walsh oracle and worker state regressions (no GPU needed)."""
import json
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch

import numpy as np
import colab_worker as worker

ROOT = Path(__file__).resolve().parent


class Controls(unittest.TestCase):
    def test_worker_rejects_v1_branch_before_git_mutation(self):
        with patch.object(worker, 'BRANCH', 'preprint-v1-final-2026-10-06'), \
                patch.object(worker, 'run_git') as git:
            with self.assertRaises(RuntimeError):
                worker.sync_repo()
            git.assert_not_called()

    def test_partial_run_resumes_without_skips_or_duplicates(self):
        with tempfile.TemporaryDirectory() as tmp:
            cmd = [sys.executable, str(ROOT/'rs_bent_exhaustive.py'), '8', '4',
                   '--backend', 'numpy', '--output-dir', tmp]
            first = subprocess.run(cmd+['--max-chunks', '3'], capture_output=True)
            self.assertEqual(first.returncode, 3)
            partial = json.loads((Path(tmp)/'result_n8.json').read_text())
            self.assertFalse(partial['complete'])
            self.assertEqual(partial['tested'], 48)
            subprocess.run(cmd+['--resume'], check=True, capture_output=True)
            final = json.loads((Path(tmp)/'result_n8.json').read_text())
            self.assertTrue(final['complete'])
            self.assertEqual(final['tested'], 2048)
            ids = np.load(Path(tmp)/'bent_ids_n8.npy').tolist()
            self.assertEqual(len(ids), 64)
            self.assertEqual(len(set(ids)), 64)
            with tempfile.TemporaryDirectory() as full:
                subprocess.run(cmd[:-1]+[full], check=True, capture_output=True)
                self.assertEqual(ids, np.load(Path(full)/'bent_ids_n8.npy').tolist())

    def test_scalar_walsh_oracle_without_derivative_filter(self):
        # Independently construct orbit truth tables from bit masks, then use
        # direct character sums instead of the production FWHT/filter.
        for n, chunk, expected in [(2, 0, 1), (4, 0, 2), (8, 6, 64)]:
            with tempfile.TemporaryDirectory() as tmp:
                subprocess.run([sys.executable, str(ROOT/'rs_bent_exhaustive.py'),
                                str(n), str(chunk), '--backend', 'numpy',
                                '--output-dir', tmp], check=True, capture_output=True)
                report = json.loads((Path(tmp)/f'result_n{n}.json').read_text())
                got = np.load(Path(tmp)/f'bent_ids_n{n}.npy').tolist()
                tables = []
                for orbit in report['generator_orbits']:
                    masks = [sum(1 << i for i in support) for support in orbit]
                    tables.append([sum((x & mask) == mask for mask in masks) % 2
                                   for x in range(1 << n)])
                chars = np.array([[1-2*((x & b).bit_count() % 2)
                                   for x in range(1 << n)]
                                  for b in range(1 << n)], dtype=np.int32)
                oracle = []
                for ident in range(1 << len(tables)):
                    values = [sum(tables[j][x] for j in range(len(tables))
                                  if (ident >> j) & 1) % 2 for x in range(1 << n)]
                    walsh = chars @ (1-2*np.array(values, dtype=np.int32))
                    if np.all(np.abs(walsh) == 1 << (n//2)):
                        oracle.append(ident)
                self.assertEqual(got, oracle)
                self.assertEqual(len(got), expected)
                self.assertTrue(report['complete'])

    def test_waiting_gpu_retries_but_running_and_done_do_not(self):
        job = {'id': 'test', 'revision': 2}
        for state, expected in [('waiting_gpu', True), ('running', False),
                                ('done', False), ('failed', False)]:
            with patch.object(worker, 'load_status', return_value={
                    'job_revision': 2, 'state': state}):
                self.assertEqual(worker.is_pending(job), expected)

    def test_missing_nvidia_smi(self):
        with patch.object(worker.subprocess, 'run', side_effect=FileNotFoundError):
            self.assertFalse(worker.gpu_info()['available'])

    def test_queue_accepts_list_or_object(self):
        with tempfile.TemporaryDirectory() as tmp:
            path = Path(tmp)/'queue.json'
            jobs = [{'id': 'test'}]
            for value in [jobs, {'jobs': jobs}]:
                path.write_text(json.dumps(value))
                with patch.object(worker, 'QUEUE', path):
                    self.assertEqual(worker.read_queue(), jobs)


if __name__ == '__main__':
    unittest.main()
