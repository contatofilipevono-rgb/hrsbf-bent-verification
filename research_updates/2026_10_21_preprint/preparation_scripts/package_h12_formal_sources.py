from pathlib import Path
import json,zipfile,hashlib,re

ROOT=Path(__file__).resolve().parents[1]
R=Path(r'C:/Users/Valer/Documents/Codex/2026-10-16/https-chatgpt-com-s-cx-6ad2e1da63888191af8d539bda9b3bed/outputs/hrsbf-bent-verification')
D=R/'research_updates/2026_10_20_final_integration'
OUT=ROOT/'outputs/H12_preprint'
pairs=[
 ('research_updates/2026_10_20_stable_migration/checkpoints/chart0_stable_run39358421659_attempt3_progress.json','research_updates/2026_10_20_stable_migration/checkpoints/chart0_stable_run39358421659_attempt3_artifact.zip'),
 ('research_updates/2026_10_20_stable_migration/checkpoints/chart1_stable_run39358413248_attempt5_progress.json','research_updates/2026_10_20_stable_migration/checkpoints/chart1_stable_run39358413248_attempt5_artifact.zip'),
 ('research_updates/2026_10_19_overnight/chart2_attempt4_progress.json','research_updates/2026_10_19_overnight/chart2_complete_artifact.zip')]
sha=lambda b:hashlib.sha256(b).hexdigest()
expected={};archives=[];report_pins=[]
plan=json.loads((D/'integration_plan.json').read_text())
for i,(report,archive) in enumerate(pairs):
 raw=(R/report).read_bytes();assert sha(raw)==plan['charts'][i]['report_sha256']
 d=json.loads(raw);assert d['root_coverage'] and d['modules_verified']==d['modules_total']
 for item in d['results']:
  n=item['module'];h=item['source_sha256']
  if n in expected:assert expected[n]==h
  expected[n]=h
 archives.append(zipfile.ZipFile(R/archive))
 report_pins.append({'chart':i,'report_sha256':sha(raw),'archive_sha256':sha((R/archive).read_bytes())})
assert len(expected)==2091
final=json.loads((D/'run39520500414_attempt2_integration_report.json').read_text())
assert final['global_proof_complete'] and final['status']=='PASS_FINAL_KERNEL_INTEGRATION'
for item in final['new_modules']:expected[item['module']]=item['source_sha256']
assert len(expected)==2093
manifest={};origins={};imports={};missing=[]
target=OUT/'H12_formal_sources.zip'
with zipfile.ZipFile(target,'w',zipfile.ZIP_DEFLATED,compresslevel=5) as z:
 for n,h in sorted(expected.items()):
  data=None;origin=None
  candidates=[(D/'certified_final_sources'/(n+'.lean'),'certified_final_sources'),(R/'quartic_audit_2026_10_17/lean'/(n+'.lean'),'local_hash_matched')]
  for p,label in candidates:
   if p.exists():
    raw=p.read_bytes()
    if sha(raw)==h:data=raw;origin=label;break
  if data is None:
   for i,archive in enumerate(archives):
    member='lean/'+n+'.lean'
    if member in archive.namelist():
     raw=archive.read(member)
     if sha(raw)==h:data=raw;origin='certified_chart_'+str(i);break
  if data is None:missing.append(n);continue
  assert sha(data)==h
  for line in data.decode('utf-8').splitlines():
   if line.startswith('import '):imports.setdefault(n,[]).extend(line.split()[1:])
  z.writestr(n+'.lean',data);manifest[n+'.lean']=h;origins[n]=origin
 assert not missing,missing
 for n,deps in imports.items():
  for dep in deps:
   assert dep in expected or dep.startswith(('Std','Init','Lean','Lake')), (n,dep)
 config='name = "H12CertificateArchive"\nversion = "1.0.0"\ndefaultTargets = ["H12Final"]\n\n[[lean_lib]]\nname = "H12CertificateArchive"\nroots = '+json.dumps(sorted(expected))+'\n'
 z.writestr('lakefile.toml',config)
 z.writestr('lean-toolchain','leanprover/lean4:v4.35.0\n')
 readme='''# Exact H(12,4) Lean proof sources

2091 previously certified modules plus H12Fourier and H12Final are included. Every source file is byte-identical to its recorded certified source hash. This archive contains source, not compiled Lean objects.

With Lean 4.35.0 and Lake installed, run from the extracted directory:

    lake build H12Final
    lake env leanchecker --verbose H12Final

The new lakefile.toml is packaging metadata, not a certified mathematical source; the archive audit checks import closure but a full fresh rebuild of this packaging has not been run locally. The original kernel checks are documented in the companion supplement. A complete build can require hours and substantial memory. The compact independent Python replay is the faster reviewer route.

SOURCE_SHA256.json records the certified source hashes. The permitted final logical axioms are propext, Classical.choice and Quot.sound. See the exact final theorem and its axiom reports in H12Final.lean and the companion formal_evidence directory. No statement for sixteen variables is included.
'''
 z.writestr('README.md',readme)
 z.writestr('SOURCE_SHA256.json',json.dumps(manifest,indent=2)+'\n')
with zipfile.ZipFile(target) as z:
 assert z.testzip() is None
 for n,h in manifest.items():assert sha(z.read(n))==h
for a in archives:a.close()
audit={'status':'PASS_EXACT_CERTIFIED_SOURCES_AND_IMPORT_CLOSURE','dependency_modules':2091,'final_modules':2,'source_files':len(manifest),'source_zip_sha256':sha(target.read_bytes()),'source_zip_bytes':target.stat().st_size,'report_pins':report_pins,'source_origins':origins,'fresh_lake_rebuild_of_packaging_performed':False}
(OUT/'FORMAL_SOURCE_ARCHIVE_AUDIT.json').write_text(json.dumps(audit,indent=2)+'\n')
print(json.dumps({k:v for k,v in audit.items() if k!='source_origins'},indent=2))
