"""Generate coefficient-only search trees linked to already checked Walsh batches.
Generation is not verification. The resulting library requires build and kernel replay.
"""
from pathlib import Path
import argparse,csv,json,re,hashlib

def main():
 p=argparse.ArgumentParser(description=__doc__);p.add_argument('--chunks',type=int,default=41);p.add_argument('--register',action='store_true');args=p.parse_args()
 if not 1<=args.chunks<=41:raise SystemExit('chunks must lie between1 and41')
 root=Path(__file__).resolve().parent.parent;rows=[]
 for file in sorted((root/'cpu_replay').glob('full_thread*.csv')):
  with file.open(newline='') as source:rows.extend(int(r['original_coefficient'],16) for r in csv.DictReader(source))
 rows.sort();assert len(rows)==len(set(rows))==164288
 def join(items):
  if len(items)==1:return items[0][1:]
  m=len(items)//2;l,hl=join(items[:m]);r,hr=join(items[m:]);pivot=items[m][0]
  return f'(.node {pivot} {l} {r})',f'(H12WitnessSearch.node_good {pivot} _ _ {hl} {hr})'
 def leaf(c):return c,f'(H12WitnessLabels.label {c})','unused'
 modules=[];roots=[];batches=0;entries=0
 for chunk in range(args.chunks):
  name=f'H12WitnessLabelData{chunk:03d}';wmodule=f'H12WitnessData{chunk:03d}';values=rows[chunk*4096:(chunk+1)*4096]
  source=[f'import {wmodule}','import H12WitnessIndexLabels',f'namespace {name}','open H12WitnessSearch','set_option maxRecDepth 100000','set_option maxHeartbeats 1000000000'];subtrees=[]
  for begin in range(0,len(values),256):
   j=begin//256;coeffs=values[begin:begin+256];tree,_=join([leaf(c) for c in coeffs]);batch=f'{wmodule}.batch{j}'
   source += [f'def tree{j} : Tree := {tree}',f'theorem good{j} : Good tree{j} :=\n  H12WitnessIndexLabels.good_of_coefficients tree{j} {batch} {batch}_checked\n    (beq_iff_eq.mp (by decide +kernel : (H12WitnessIndexLabels.coefficients tree{j} == {batch}.map (fun w => w.coefficient)) = true))']
   subtrees.append((coeffs[0],f'tree{j}',f'good{j}'));batches+=1
  tree,good=join(subtrees);source += [f'def tree : Tree := {tree}',f'theorem good : Good tree := {good}','#print axioms good',f'end {name}']
  text='\n\n'.join(source)+'\n';file=root/'lean'/(name+'.lean')
  if not file.exists() or file.read_text(encoding='utf-8')!=text:file.write_text(text,encoding='utf-8')
  modules.append(name);roots.append((values[0],name+'.tree',name+'.good'));entries+=len(values)
 final='H12GlobalWitnessIndex' if args.chunks==41 else 'H12PartialWitnessLabelIndex';tree,good=join(roots)
 source=['import '+m for m in modules]+[f'namespace {final}','open H12WitnessSearch',f'def tree : Tree := {tree}',f'theorem good : Good tree := {good}','#print axioms good',f'end {final}']
 (root/'lean'/(final+'.lean')).write_text('\n\n'.join(source)+'\n',encoding='utf-8');modules.append(final)
 report={'status':'GENERATED_NOT_YET_KERNEL_VERIFIED','entries':entries,'batches':batches,'modules':modules,'scope':'Search-label index only. Good establishes sound rejection for a lookup hit, not global chart coverage.','generator_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
 (root/'reports'/('WITNESS_LABEL_INDEX_SOURCE.json' if args.chunks==41 else 'WITNESS_LABEL_INDEX_PARTIAL_SOURCE.json')).write_text(json.dumps(report,indent=2));print(json.dumps(report))
 if args.register:
  config=root/'lean/lakefile.toml';text=config.read_text(encoding='utf-8');name='H12WitnessLabelIndexCertificate' if args.chunks==41 else 'H12WitnessLabelIndexPilot'
  block='[[lean_lib]]\nname = "'+name+'"\nroots = '+json.dumps(modules)+'\n';pattern=r'(?ms)^\[\[lean_lib\]\]\s*\nname = "'+name+r'".*?(?=^\[\[lean_lib\]\]|\Z)'
  text=re.sub(pattern,lambda _:block+'\n',text) if re.search(pattern,text) else text.rstrip()+'\n\n'+block
  config.write_text(text,encoding='utf-8')

if __name__=='__main__':main()
