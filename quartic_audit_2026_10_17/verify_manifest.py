"""Verify preserved-file hashes; does not certify mathematical claims."""
from pathlib import Path
import hashlib,json

root=Path(__file__).resolve().parent
manifest=json.loads((root/'MANIFEST.json').read_text())
for entry in manifest['files']:
    path=(root/entry['path']).resolve()
    assert path.is_relative_to(root), entry['path']
    assert path.is_file(), entry['path']
    assert path.stat().st_size==entry['bytes'], entry['path']
    with path.open('rb') as stream:
        digest=hashlib.file_digest(stream,'sha256').hexdigest() if hasattr(hashlib,'file_digest') else hashlib.sha256(stream.read()).hexdigest()
    assert digest==entry['sha256'], entry['path']
print(f"PASS: {len(manifest['files'])} preserved files; hashes verify integrity only.")
