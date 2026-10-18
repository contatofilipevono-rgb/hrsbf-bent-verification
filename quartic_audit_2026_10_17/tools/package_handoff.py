"""Build a small, self-contained continuation snapshot without historical bulk."""
from pathlib import Path
import hashlib,json,zipfile

root=Path(__file__).resolve().parent.parent
names=['README.md','CLAIMS.md','CONTINUAR_COLABORADOR.md','FORMALIZATION_STATUS.md',
       'MATHEMATICAL_EXPLANATION.md','ADVERSARIAL_AUDIT.md','PROVENANCE.json','SOURCE_ARTICLE.json',
       'verify_manifest.py','verify_linear_laws.py','verify_periodic_reduction.py',
       'linear_law_certificates.json']
paths=[root/n for n in names]
for folder in ['lean','cpu_replay','reports','tools','ci']:
    paths.extend(p for p in (root/folder).rglob('*') if p.is_file()
                 and '.lake' not in p.parts and '__pycache__' not in p.parts)
payload={p.relative_to(root).as_posix():p.read_bytes() for p in sorted(set(paths))}
payload['LEIA_PACOTE_RETOMADA.txt']=(
    'Snapshot reduzido para retomar H(12,4). Leia CONTINUAR_COLABORADOR.md.\n'
    'O acervo histórico archive/ e a GPU original estão no repositório completo.\n'
    'Este manifesto cobre apenas os arquivos deste ZIP.\n'
    'Python padrão: python verify_manifest.py; python cpu_replay/verify_certificate.py\n'
    'Lean 4.35.0: cd lean; lake build\n'
    'A prova Lean global permanece incompleta; veja FORMALIZATION_STATUS.md.\n'
).encode('utf-8')
manifest={'algorithm':'SHA-256','scope':'Reduced handoff snapshot; full historical archive remains in Git.',
          'files':[{'path':n,'bytes':len(b),'sha256':hashlib.sha256(b).hexdigest()}
                   for n,b in sorted(payload.items())]}
payload['MANIFEST.json']=json.dumps(manifest,indent=2).encode('utf-8')
archive=root/'PACOTE_RETOMADA_H12.zip'
with zipfile.ZipFile(archive,'w',zipfile.ZIP_DEFLATED,compresslevel=9) as z:
    for name,data in sorted(payload.items()):
        info=zipfile.ZipInfo(name,date_time=(2026,10,18,0,0,0))
        info.compress_type=zipfile.ZIP_DEFLATED
        z.writestr(info,data,compresslevel=9)
print(json.dumps({'file':str(archive),'files':len(payload),'bytes':archive.stat().st_size,
                  'sha256':hashlib.sha256(archive.read_bytes()).hexdigest()}))
