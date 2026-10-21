"""Real Lean smoke check of migration and image-independent continuation.

Only two trivial theorems are compiled, not the H(12,4) charts.
"""
from pathlib import Path
import hashlib
import json
import tempfile
from unittest.mock import patch

import verify_lean_cloud_slice as legacy
import verify_lean_cloud_resume as resume


def main():
    with tempfile.TemporaryDirectory(prefix='lean-resume-smoke-') as directory:
        root = Path(directory)
        project, evidence = root/'project',root/'evidence'
        project.mkdir()
        (project/'lakefile.toml').write_text('name = "resume_smoke"\nversion = "0.1.0"\n[[lean_lib]]\nname = "Resume"\nroots = ["ResumeA", "ResumeB"]\n')
        (project/'lean-toolchain').write_text('leanprover/lean4:v4.35.0\n')
        (project/'ResumeA.lean').write_text('theorem resume_a : True := True.intro\n')
        (project/'ResumeB.lean').write_text('import ResumeA\ntheorem resume_b : True := resume_a\n')
        first = legacy.verify(project,['ResumeB'],evidence,'lake',120,max_modules=1)
        assert first['modules_verified'] == 1 and not first['root_coverage']
        original = (evidence/'progress.json').read_bytes()
        checkpoint_sha = hashlib.sha256(original).hexdigest()
        migrated = resume.verify(project,['ResumeB'],evidence,'lake',120,
                                  legacy_report_sha256=checkpoint_sha)
        assert migrated['modules_reused'] == 1 and migrated['modules_verified_new'] == 1
        assert migrated['root_coverage'] and migrated['status'] == resume.COMPLETE
        # Only the host description changes; executable hashes remain real.
        with patch.object(resume.platform,'platform',return_value='different hosted Linux kernel'):
            continued = resume.verify(project,['ResumeB'],evidence,'lake',120)
        assert continued['fingerprint'] == migrated['fingerprint']
        assert continued['modules_reused'] == 2 and continued['modules_verified_new'] == 0
        assert continued['root_coverage'] and not continued['unconditional_global_theorem']
        assert (evidence/'history'/(checkpoint_sha+'.json')).read_bytes() == original
        output = {'status':'PASS_REAL_LEAN_RESUME_SMOKE','legacy_modules':1,
                  'migration_reused':1,'migration_new':1,'next_slice_reused':2,
                  'next_slice_new':0,'lean_version':continued['lean_version'],
                  'toolchain':continued['verification_identity']['toolchain'],
                  'scope':'Two trivial theorem modules; tests orchestration, not the H(12,4) result.'}
        destination = Path(__file__).resolve().parents[2]/'research_updates/2026_10_19_resume_fix'
        destination.mkdir(parents=True,exist_ok=True)
        (destination/'SMOKE_REAL_LEAN.json').write_text(json.dumps(output,indent=2)+'\n')
        print(json.dumps(output,indent=2))


if __name__ == '__main__':
    main()

