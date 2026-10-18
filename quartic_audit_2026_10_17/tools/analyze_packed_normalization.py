from pathlib import Path
import sys,json
root=Path.cwd();script=(root/'tools/generate_lean_mixed_pilot.py').read_text(encoding='utf-8');sys.argv=['analysis','--node','8'];exec(script[:script.index('rows=[]')])
stats={'states':0,'raw_bits':0,'canonical_bits':0,'raw_nonzero':0,'canonical_nonzero':0}
def observe(raw,normal):
 stats['states']+=1;stats['raw_bits']+=sum(p.bit_count() for p in raw);stats['canonical_bits']+=sum(p.bit_count() for p in normal);stats['raw_nonzero']+=sum(bool(p) for p in raw);stats['canonical_nonzero']+=sum(bool(p) for p in normal)
def walk(nid,raw,normal):
 observe(raw,normal);node=cert['nodes'][nid]
 for step in node['linear_steps']:
  row=canon(xor(int(step['combination'],16),raw));p=step['pivot'];a=row^(1<<(p+1));raw=trans(raw,p,a);normal=[canon(p) for p in trans(normal,p,a)];observe(raw,normal)
 if node['kind']=='split':
  form=int(node['form'],16);p=form.bit_length()-1;a=(form^(1<<p))<<1
  for rhs,child in enumerate(node['children']):walk(child,trans(raw,p,a^rhs),[canon(p) for p in trans(normal,p,a^rhs)])
ps,env=chosen;words=[pack(p) for p in ps];walk(8,words,words);stats['scope']='Subtree8 cost counts only, not proof or runtime.';print(json.dumps(stats));(root/'reports/PACKED_NORMALIZATION_COST_COUNTS.json').write_text(json.dumps(stats,indent=2))
