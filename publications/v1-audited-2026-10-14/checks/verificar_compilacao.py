#!/usr/bin/env python3
"""Compile the self-contained source and reject failed or native-admitted proofs."""
from pathlib import Path
import argparse, hashlib, json, os, re, shutil, subprocess, time

root = Path(__file__).resolve().parents[1]
parser = argparse.ArgumentParser()
parser.add_argument('--lean', default=shutil.which('lean') or str(Path.home()/'.elan/bin/lean'))
parser.add_argument('--memory-mb', default=6500, type=int)
args = parser.parse_args()
version = subprocess.run([args.lean, '--version'], check=True, text=True, capture_output=True).stdout.strip()
if 'version 4.15.0,' not in version:
    raise SystemExit('Este pacote foi validado com Lean 4.15.0. Instale leanprover/lean4:v4.15.0.')
source = root/'formal/Matematica_Formalizacao_Real.lean'
log_dir = root/'logs'
log_dir.mkdir(exist_ok=True)
t0 = time.monotonic()
result = subprocess.run([args.lean, '-M', str(args.memory_mb), '-o', str(source.with_suffix('.olean')), str(source)],
                        text=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
output = result.stdout
(log_dir/'recompilacao.log').write_text(output, encoding='utf-8')
expected = len(re.findall(r'^theorem\s+\w+', source.read_text(encoding='utf-8'), flags=re.M))
observed = len(re.findall(r"^'HRSBF_Formalizacao_Real\.", output, flags=re.M))
axioms = sorted({a.strip() for group in re.findall(r'depends on axioms: \[([^]]*)\]', output)
                 for a in group.split(',') if a.strip()})
allowed = {'propext', 'Quot.sound', 'Classical.choice'}
report = {'version': version, 'exit_code': result.returncode, 'elapsed_seconds': round(time.monotonic()-t0,3),
          'source_sha256': hashlib.sha256(source.read_bytes()).hexdigest(),
          'expected_axiom_reports': expected, 'observed_axiom_reports': observed,
          'axioms': axioms, 'unexpected_axioms': sorted(set(axioms)-allowed)}
report['passed'] = result.returncode == 0 and observed == expected and not report['unexpected_axioms']
(log_dir/'recompilacao_resultado.json').write_text(json.dumps(report,indent=2,ensure_ascii=False)+'\n',encoding='utf-8')
print(json.dumps(report,indent=2,ensure_ascii=False))
if not report['passed']:
    print(output)
    raise SystemExit(1)
