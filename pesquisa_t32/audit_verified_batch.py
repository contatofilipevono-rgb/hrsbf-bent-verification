#!/usr/bin/env python3
"""Audit every completed UNSAT family from a checkpoint, then recheck DRAT."""
import argparse
import hashlib
import json
import subprocess
from pathlib import Path
from audit_independent_cnf import audit_model, need

def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--directory', type=Path, required=True)
    parser.add_argument('--checker', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    records = json.loads((args.directory/'resumo.json').read_text())['families']
    result = {'status': 'RUNNING', 'checker_sha256': digest(args.checker),
              'auditor_sha256': digest(Path(__file__).with_name('audit_independent_cnf.py')),
              'families': [], 'scope': 'completed UNSAT families only; no global bentness claim'}
    try:
        for record in records:
            if record['status'] != 'UNSAT_PROOF_VERIFIED':
                continue
            h = record['h']
            prefix = args.directory/('familia_'+h[2:])
            cnf, metadata, proof = [prefix.with_suffix(ext) for ext in ('.cnf','.json','.drat')]
            model = audit_model(metadata, cnf)
            need(model['cnf_sha256'] == record['cnf_sha256'], 'Checkpoint CNF hash differs.')
            need(digest(proof) == record['proof_sha256'], 'Checkpoint proof hash differs.')
            run = subprocess.run([str(args.checker),str(cnf),str(proof)], capture_output=True, text=True, timeout=300)
            log = args.directory/('independent_'+h[2:]+'.checker.log')
            log.write_text(run.stdout+run.stderr)
            need(run.returncode == 0 and any(line.strip() == 's VERIFIED' for line in run.stdout.splitlines()), 'Independent DRAT recheck failed.')
            model.update({'proof_checked_by_this_script': True, 'proof_sha256': digest(proof),
                          'metadata_sha256': digest(metadata), 'checker_log_sha256': digest(log)})
            result['families'].append(model)
            args.output.write_text(json.dumps(result,indent=2)+'\n')
            print('INDEPENDENT PASS',h,flush=True)
        result['status'] = 'PASS'
    except Exception as error:
        result.update({'status':'FAIL','error':repr(error)})
        raise
    finally:
        args.output.write_text(json.dumps(result,indent=2)+'\n')
        print('BATCH',result['status'],len(result['families']),flush=True)

if __name__ == '__main__':
    main()
