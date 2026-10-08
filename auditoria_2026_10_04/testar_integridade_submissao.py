"""Check fail-closed behavior in an isolated temporary directory."""
import hashlib
import json
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile

def main():
    source = Path(__file__).resolve().parent.parent/'verify_submission.py'
    records = []
    with tempfile.TemporaryDirectory() as folder:
        root = Path(folder)
        shutil.copyfile(source,root/'verify_submission.py')
        expected = hashlib.sha256(b'expected bytes').hexdigest()
        (root/'submission_manifest.json').write_text(json.dumps({'files':{'required.txt':expected}}))
        for name, contents, expected_code in [('missing',None,1),('mismatched',b'wrong bytes',1),
                                              ('matching',b'expected bytes',0)]:
            if contents is not None:
                (root/'required.txt').write_bytes(contents)
            result = subprocess.run([sys.executable,str(root/'verify_submission.py'),'--integrity-only'],
                                    capture_output=True)
            if result.returncode != expected_code:
                raise RuntimeError('Integrity test failed: '+name)
            records.append({'case':name,'returncode':result.returncode,'expected_returncode':expected_code})
    output = {'status':'passed','cases':records,'scope':'Isolated negative integrity controls; no changes to repository artifacts.'}
    Path(__file__).with_suffix('.json').write_text(json.dumps(output,indent=2)+'\n')
    print(json.dumps(output,indent=2))

if __name__ == '__main__':
    main()
