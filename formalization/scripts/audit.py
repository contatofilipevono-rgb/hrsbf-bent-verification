#!/usr/bin/env python3
"""Rebuild the project and audit every public lemma/theorem with #print axioms."""
import hashlib
import json
import pathlib
import re
import subprocess
import time

ROOT = pathlib.Path(__file__).resolve().parents[1]
LOGS = ROOT / 'logs'
LOGS.mkdir(exist_ok=True)
ALLOWED = {'propext', 'Classical.choice', 'Quot.sound'}

def run(args, log):
    start = time.monotonic()
    result = subprocess.run(args, cwd=ROOT, text=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    (LOGS / log).write_text(result.stdout, encoding='utf-8')
    if result.returncode:
        print(result.stdout)
        raise SystemExit(result.returncode)
    return result.stdout, round(time.monotonic() - start, 3)

version, _ = run(['lean', '--version'], 'lean_version.log')
assert 'version 4.15.0,' in version, version
names = []
source_hashes = {}
for source in sorted((ROOT / 'Antipodal').glob('*.lean')):
    text = source.read_text(encoding='utf-8')
    assert not re.search(r'\b(sorry|admit|axiom|native_decide)\b', text), source
    source_hashes[str(source.relative_to(ROOT))] = hashlib.sha256(source.read_bytes()).hexdigest()
    names.extend(re.findall(r'^(?:@\[simp\]\s+)?(?:lemma|theorem)\s+(\w+)', text, re.M))
assert len(names) == len(set(names))
audit = 'import Antipodal.Main\n\n' + ''.join(f'#print axioms HRSBF.Antipodal.{name}\n' for name in names)
(ROOT / 'AxiomAudit.lean').write_text(audit, encoding='utf-8')
_, build_seconds = run(['lake', 'build'], 'build.log')
output, audit_seconds = run(['lake', 'env', 'lean', 'AxiomAudit.lean'], 'axioms.log')
reports = re.findall(r"'([^']+)' (?:depends on axioms:\s*\[([^\]]*)\]|does not depend on any axioms)", output)
assert len(reports) == len(names), (len(reports), len(names))
used = set()
for name, deps in reports:
    axioms = {dep.strip() for dep in deps.split(',') if dep.strip()}
    assert axioms <= ALLOWED, (name, axioms - ALLOWED)
    used |= axioms
assert 'sorryAx' not in output and 'Lean.ofReduceBool' not in output
order = ['LocalRigidity', 'Polynomial', 'Cyclic', 'Fourier', 'Main']
parts = []
for module in order:
    source = (ROOT / 'Antipodal' / (module + '.lean')).read_text(encoding='utf-8')
    parts.append(re.sub(r'^import Antipodal\.[^\n]+\n', '', source, flags=re.M))
standalone = '\n'.join(parts) + '\n' + audit.removeprefix('import Antipodal.Main\n')
unit = ROOT / 'Nucleo_Fibras.lean'
unit.write_text(standalone, encoding='utf-8')
unit_output, standalone_seconds = run(['lake', 'env', 'lean', unit.name], 'standalone.log')
unit_reports = re.findall(r"'([^']+)' (?:depends on axioms:\s*\[([^\]]*)\]|does not depend on any axioms)", unit_output)
assert unit_reports == reports
assert 'sorryAx' not in unit_output and 'Lean.ofReduceBool' not in unit_output
source_hashes[unit.name] = hashlib.sha256(unit.read_bytes()).hexdigest()
result = {
    'lean_version': version.strip(),
    'mathlib_commit': '9837ca9d65d9de6fad1ef4381750ca688774e608',
    'build_exit_code': 0,
    'audit_exit_code': 0,
    'public_theorems_audited': len(names),
    'axioms': sorted(used),
    'build_seconds': build_seconds,
    'audit_seconds': audit_seconds,
    'standalone_exit_code': 0,
    'standalone_seconds': standalone_seconds,
    'scope': 'Local fiber rigidity, Parseval, fiber balance, and conditional fiber contradiction. The universal antipodal theorem remains unformalized.',
    'source_sha256': source_hashes,
}
(LOGS / 'result.json').write_text(json.dumps(result, indent=2, ensure_ascii=False) + '\n', encoding='utf-8')
print(json.dumps(result, indent=2, ensure_ascii=False))
