#!/usr/bin/env python3
"""Check editorial release integrity and that certified Lean bytes are unchanged."""
import hashlib
import io
import json
from pathlib import Path
import re
import subprocess
import zipfile

BASE = Path(__file__).resolve().parents[1]
REPO = BASE.parents[1]
SOURCE = '6dd183685ef8a5b033c1bcf8733496d57b853cc7'

def require(ok, message):
    if not ok:
        raise RuntimeError(message)

def check_manifest(root, manifest):
    count = 0
    for line in manifest.splitlines():
        digest, name = line.split(maxsplit=1)
        name = name.lstrip('*')
        path = (root / name).resolve()
        require(path.is_relative_to(root.resolve()), 'Path escapes manifest root')
        require(path.is_file(), f'Missing file: {name}')
        require(hashlib.sha256(path.read_bytes()).hexdigest() == digest, f'Hash mismatch: {name}')
        count += 1
    return count

count = check_manifest(BASE, (BASE / 'SHA256SUMS.txt').read_text())
archive = BASE / 'audit/EVIDENCIAS_REVISAO_RECEBIDA.zip'
with zipfile.ZipFile(archive) as z:
    manifest = z.read('SHA256SUMS.txt').decode()
    incoming = 0
    for line in manifest.splitlines():
        digest, name = line.split(maxsplit=1)
        name = name.lstrip('*')
        require(hashlib.sha256(z.read(name)).hexdigest() == digest, f'Incoming hash mismatch: {name}')
        incoming += 1
    require(z.read('REVISAO_ADVERSARIA_ANTIPODAL_2026-10-15.md') ==
            (BASE / 'audit/REVISAO_ADVERSARIA_RECEBIDA.md').read_bytes(), 'Received report changed')
    log = z.read('evidence/AuditSignatures.log').decode()
reports = dict(re.findall(r"'([^']+)' depends on axioms:\s*\[([^\]]*)\]", log))
recorded = json.loads((BASE / 'audit/final_axioms_received.json').read_text())
require(len(recorded) == 6, 'Expected six final interfaces')
for name, axioms in recorded.items():
    require(name in reports, f'Missing kernel report: {name}')
    got = {x.strip() for x in reports[name].split(',') if x.strip()}
    require(got == set(axioms) == {'propext', 'Classical.choice', 'Quot.sound'}, f'Unexpected axioms: {name}')
require('sorryAx' not in log and 'Lean.ofReduceBool' not in log, 'Forbidden dependency')
subprocess.run(['git', 'diff', '--exit-code', SOURCE, '--', 'formalization',
                '.github/workflows/astra-global-progress.yml'], cwd=REPO, check=True)
# Check paper metadata and the PDF header; do not mistake this for a mathematical proof.
pdf = (BASE / 'paper/antipodal_necessity_v1_3.pdf').read_bytes()
require(pdf.startswith(b'%PDF-'), 'Invalid PDF header')
tex = (BASE / 'paper/antipodal_necessity_v1_3.tex').read_text()
require(SOURCE in tex and '\\bibitem{tang2026}' in tex, 'Missing source provenance or Tang reference')
require('\\label{lem:antipodal-transport}' not in tex, 'Old folding dependency retained')
print(json.dumps({'release_manifest_files': count, 'received_manifest_files': incoming,
                  'six_axiom_reports_verified': True, 'certified_lean_unchanged': True,
                  'source_sha': SOURCE}, indent=2))
