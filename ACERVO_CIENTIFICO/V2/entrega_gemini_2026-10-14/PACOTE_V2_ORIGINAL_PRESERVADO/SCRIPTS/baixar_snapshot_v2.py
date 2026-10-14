#!/usr/bin/env python3
"""Baixa arquivos V2 de um ZIP GitHub pinado e valida os blobs Git.
Requer Internet; nao executado no ambiente offline atual.
"""
from pathlib import Path
from urllib.request import urlopen, Request
from zipfile import ZipFile
from io import BytesIO
import hashlib
import json

HERE = Path(__file__).resolve().parent.parent
manifest = json.loads((HERE / 'GITHUB_V2_MANIFEST.json').read_text(encoding='utf-8'))
url = manifest['source_archive_url']
print('Baixando:', url)
request = Request(url, headers={'User-Agent': 'V2-math-audit'})
with urlopen(request, timeout=90) as response:
    raw_zip = response.read()
target_dir = HERE / 'SNAPSHOT_GITHUB_ORIGINAL'
with ZipFile(BytesIO(raw_zip)) as zipped:
    for meta in manifest['files']:
        path = meta['path']
        candidates = [x for x in zipped.namelist() if x.endswith('/' + path) and not x.endswith('/')]
        if len(candidates) != 1:
            raise RuntimeError(f'Arquivo ausente ou ambiguo: {path}')
        data = zipped.read(candidates[0])
        git_sha = hashlib.sha1(b'blob ' + str(len(data)).encode() + b'\0' + data).hexdigest()
        assert len(data) == meta['bytes'], (path, len(data), meta['bytes'])
        assert git_sha == meta['blob_sha1'], (path, git_sha, meta['blob_sha1'])
        destination = target_dir / path
        destination.parent.mkdir(parents=True, exist_ok=True)
        destination.write_bytes(data)
print('SUCESSO:', len(manifest['files']), 'arquivos extraidos e validados em', target_dir)
