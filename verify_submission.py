#!/usr/bin/env python3
"""Verify required file hashes and run exact submission checks, failing closed.

The manifest records byte integrity, not a signature or proof of mathematical truth.
Python 3.10+, standard library only. Run from any directory.
"""
import argparse
import hashlib
import json
from pathlib import Path, PurePosixPath
import subprocess
import sys

BASE = Path(__file__).resolve().parent

def verify_integrity():
    manifest = json.loads((BASE/'submission_manifest.json').read_text())
    files = manifest.get('files')
    if not isinstance(files, dict) or not files:
        raise ValueError('Manifest has no required files.')
    results = {}
    for name, expected in files.items():
        path = PurePosixPath(name)
        if path.is_absolute() or '..' in path.parts:
            raise ValueError('Unsafe manifest path.')
        if not isinstance(expected, str) or len(expected) != 64 or any(c not in '0123456789abcdef' for c in expected):
            raise ValueError('Invalid SHA-256 value for '+name)
        local = BASE/name
        if not local.is_file():
            raise FileNotFoundError('Required file is missing: '+name)
        obtained = hashlib.sha256(local.read_bytes()).hexdigest()
        if obtained != expected:
            raise ValueError('SHA-256 mismatch: '+name)
        results[name] = obtained
    return results

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--integrity-only', action='store_true')
    args = parser.parse_args()
    try:
        hashes = verify_integrity()
    except (OSError, ValueError) as error:
        print('FAIL: '+str(error), file=sys.stderr)
        return 1
    print('Required SHA-256 checks passed:',len(hashes), flush=True)
    if args.integrity_only:
        print('Integrity only; no mathematical checks executed.')
        return 0
    output = BASE/'auditoria_2026_10_04'
    output.mkdir(exist_ok=True)
    checks = [
        ('integrated', ['avanco_t32/verificador_integrado.py']),
        ('seven_fibers', ['avanco_t32/verificar_7_fibras.py']),
        ('exact_fiber_differential', ['avanco_t32/validar_fibras_exato.py']),
        ('fiber_example', ['avanco_t32/verificar_fibras_exato.py',
                           'avanco_t32/exemplo_fibras32.json', '--z','2261','--enumerate-sum',
                           '--output','auditoria_2026_10_04/exemplo_fibras32_resultado.json']),
    ]
    records = []
    for name, command in checks:
        completed = subprocess.run([sys.executable]+command, cwd=BASE,
                                   stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        log = output/('submissao_'+name+'.log')
        log.write_bytes(completed.stdout)
        records.append({'check':name,'returncode':completed.returncode,
                        'log':str(log.relative_to(BASE)),
                        'log_sha256':hashlib.sha256(completed.stdout).hexdigest()})
        print(name+(': PASS' if completed.returncode == 0 else ': FAIL'),flush=True)
        if completed.returncode != 0:
            break
    passed = len(records) == len(checks) and all(r['returncode'] == 0 for r in records)
    report = {'status':'passed' if passed else 'failed','required_hashes':hashes,
              'checks':records,'formal_proof_assistant_certification':False,
              'all_n32_cubics_excluded':False,
              'scope':'Finite checks supporting the manuscript proofs; no global n=32 exclusion or automated novelty certification.'}
    (output/'resultado_submissao.json').write_text(json.dumps(report,indent=2)+'\n')
    return 0 if passed else 1

if __name__ == '__main__':
    sys.exit(main())
