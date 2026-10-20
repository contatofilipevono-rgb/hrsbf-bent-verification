from pathlib import Path
import json, hashlib, zipfile, re
R=Path('C:/Users/Valer/Documents/Codex/2026-10-16/https-chatgpt-com-s-cx-6ad2e1da63888191af8d539bda9b3bed/outputs/hrsbf-bent-verification')
D=R/'research_updates/2026_10_20_final_integration'; D.mkdir(exist_ok=True)
reports=[R/'research_updates/2026_10_20_stable_migration/checkpoints/chart0_stable_run39358421659_attempt3_progress.json',R/'research_updates/2026_10_20_stable_migration/checkpoints/chart1_stable_run39358413248_attempt5_progress.json',R/'research_updates/2026_10_19_overnight/chart2_attempt4_progress.json']
rs=[json.loads(p.read_bytes()) for p in reports]
allmods={}; collisions=[]
for c,r in enumerate(rs):
 assert r['root_coverage'] and r['modules_verified']==r['modules_total']
 for x in r['results']:
  n=x['module']
  if n in allmods:
   assert x['source_sha256']==allmods[n]['source_sha256'],n
   if x['olean_sha256']!=allmods[n]['olean_sha256']:collisions.append(n)
  allmods[n]=x
source=(R/'quartic_audit_2026_10_17/lean/H12PeriodFour.lean').read_text(encoding='utf-8')
orbits=json.loads(source.split('def quarticOrbits : List (List Nat) := ',1)[1].split('def periodicColumns',1)[0].strip())
flat=[x for o in orbits for x in o]
assert len(orbits)==43 and len(flat)==495 and len(set(flat))==495
assert set(flat)=={x for x in range(4096) if x.bit_count()==4}
rot=lambda x: ((x<<1)&4095)|(x>>11)
assert all({rot(x) for x in o}==set(o) for o in orbits)
out=dict(modules_union=len(allmods),shared_olean_mismatches=sorted(set(collisions)),reports=[dict(chart=c,sha256=hashlib.sha256(p.read_bytes()).hexdigest(),modules=rs[c]['modules_verified'],roots=rs[c]['roots'],lean_version=rs[c]['lean_version']) for c,p in enumerate(reports)],orbit_basis=dict(orbits=43,distinct_monomials=495,all_weight_four_masks=True,cyclic_closed=True),global_proof_complete=False)
(D/'INPUT_AUDIT.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print(json.dumps(out))

