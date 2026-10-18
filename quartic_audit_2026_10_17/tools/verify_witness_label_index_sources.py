"""Independently parse the label-index source, checking keys and routing pivots.
This source audit does not replace Lean's build or independent kernel replay.
"""
from pathlib import Path
import csv,hashlib,json,re

def main():
 root=Path(__file__).resolve().parent.parent;expected=[]
 for file in sorted((root/'cpu_replay').glob('full_thread*.csv')):
  with file.open(newline='') as source:expected.extend(int(r['original_coefficient'],16) for r in csv.DictReader(source))
 expected.sort();assert len(expected)==len(set(expected))==164288
 symbols={};keys=[];sources={};node_count=0
 files=sorted((root/'lean').glob('H12WitnessLabelData[0-9][0-9][0-9].lean'))
 assert len(files)==41
 files.append(root/'lean/H12GlobalWitnessIndex.lean')
 for file in files:
  source=file.read_text(encoding='utf-8');namespace=file.stem;sources[namespace]=hashlib.sha256(file.read_bytes()).hexdigest()
  keys.extend(int(c) for c in re.findall(r'H12WitnessLabels\.label (\d+)',source))
  for name,expression in re.findall(r'^def (tree\d*) : Tree := ([^\n]+)',source,re.M):
   tokens=[];end=0
   for match in re.finditer(r'\(|\)|\.node|[A-Za-z_][\w.]*|\d+',expression):
    assert not expression[end:match.start()].strip(),expression[end:match.start()]
    tokens.append(match.group());end=match.end()
   assert not expression[end:].strip()
   position=0
   def take():
    nonlocal position
    assert position<len(tokens);token=tokens[position];position+=1;return token
   def parse():
    nonlocal node_count
    token=take()
    if token!='(':
     reference=token if '.' in token else namespace+'.'+token
     assert reference in symbols,reference
     return symbols[reference]
    kind=take()
    if kind=='H12WitnessLabels.label':
     c=int(take());assert 0<=c<2**43;assert take()==')';return c,c,1
    assert kind=='.node',kind
    pivot=int(take());left=parse();right=parse();assert take()==')'
    assert left[1]<pivot<=right[0],(namespace,name,pivot,left,right)
    node_count+=1;return left[0],right[1],left[2]+right[2]
   summary=parse();assert position==len(tokens),(namespace,name)
   symbols[namespace+'.'+name]=summary
 assert keys==expected,'Index source keys differ from the independently read candidate list.'
 summary=symbols['H12GlobalWitnessIndex.tree'];assert summary==(expected[0],expected[-1],len(expected))
 report={'status':'PASS_SOURCE_KEYS_AND_PIVOT_ROUTING','keys':len(keys),'distinct_keys':len(set(keys)),'source_modules':len(files),'parsed_routing_nodes':node_count,'root_range_and_count':summary,'source_sha256':sources,'scope':'Independent source/data audit. No claim that Lean replay or any chart root proof has completed.'}
 (root/'reports/WITNESS_LABEL_INDEX_SOURCE_AUDIT.json').write_text(json.dumps(report,indent=2));print(report['status'],len(keys),'keys;',node_count,'routing nodes')

if __name__=='__main__':main()
