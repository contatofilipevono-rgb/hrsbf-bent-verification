from pathlib import Path
import json,csv,itertools
root=Path.cwd();model=json.loads((root/'cpu_replay/model.json').read_text());cert=json.loads((root/'cpu_replay/DECOMPOSITION.json').read_text())
s=(root/'tools/generate_lean_packed_pilot.py').read_text(encoding='utf-8');exec(s[s.index('mons='):s.index('book=')])
chart=model['charts'][0];ps=[poly(f) for f in chart['quadratic_filters']]
env=[((chart['offset']>>j)&1)^sum(((b>>j)&1)<<(i+1) for i,b in enumerate(chart['basis'])) for j in range(43)]
chosen=None
def locateLeaf(nid,ps,env):
 global chosen
 node=cert['nodes'][nid]
 for st in node['linear_steps']:
  row=xor(int(st['combination'],16),ps);p=st['pivot'];a=(row>>1)^(1<<p);rhs=row&1
  ps=eliminate(ps,p,a,rhs);env=eliminate(env,p,a,rhs)
 if nid==12:chosen=(ps,env);return True
 if node['kind']=='split':
  form=int(node['form'],16);p=form.bit_length()-1;a=form^(1<<p)
  for rhs,ch in enumerate(node['children']):
   if ch<=12 and locateLeaf(ch,eliminate(ps,p,a,rhs),eliminate(env,p,a,rhs)):return True
 return False
assert locateLeaf(cert['roots'][0],ps,env);ps,env=chosen;assert all(x==0 for x in ps);assert all(x<1<<37 for x in env)
support=0
for word in env:support|=word>>1
active=list(bits(support));assert len(active)==3
rows=[]
for file in sorted((root/'cpu_replay').glob('full_thread*.csv')):
 with file.open(newline='') as src:
  for row in csv.DictReader(src):rows.append(int(row['original_coefficient'],16))
rows.sort();index={c:i for i,c in enumerate(rows)};cs=[]
for z in range(1<<len(active)):
 assignment=sum(((z>>j)&1)<<i for j,i in enumerate(active))
 c=sum(((word&1)^(((word>>1)&assignment).bit_count()%2))<<i for i,word in enumerate(env));assert c in index;cs.append(c)
items=sorted(set(cs));imports=set();defs=[];goods=[]
for n,c in enumerate(items):
 position=index[c];module=f'H12WitnessData{position//4096:03d}';batch=f'{module}.batch{position%4096//256}';j=position%256;imports.add(module)
 defs.append(f'def w{n} : H12WitnessTheory.Witness := {batch}[{j}]\'(by decide)')
 goods.append(f'theorem reject{n} : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 w{n}.coefficient)) :=\n  H12WitnessTheory.checked_list_sound {batch} {batch}_checked _ (List.getElem_mem (by decide))')
 goods.append(f'theorem good{n} : H12WitnessSearch.Good (.leaf w{n}) := by\n  intro c hc\n  have he : w{n}.coefficient = c := beq_iff_eq.mp hc\n  rw [← he]\n  exact reject{n}')
def tree(part):
 if len(part)==1:
  n,c=part[0];return f'(.leaf w{n})',f'good{n}'
 mid=len(part)//2;left,hl=tree(part[:mid]);right,hr=tree(part[mid:]);pivot=part[mid][1]
 return f'(.node {pivot} {left} {right})',f'(H12WitnessSearch.node_good {pivot} _ _ {hl} {hr})'
t,h=tree(list(enumerate(items)))
out=['import H12PackedTerminal']+['import '+m for m in sorted(imports)]+['namespace H12ConcreteLeaf12','set_option maxRecDepth 100000','set_option maxHeartbeats 1000000000','open H12PackedPolynomial H12PackedTerminal']+defs+goods
out += ['def env : List Nat := '+fmt(env),'def active : List Nat := '+fmt(active),'def tree : H12WitnessSearch.Tree := '+t,'theorem good : H12WitnessSearch.Good tree := '+h,'theorem checked : terminalCheckFast env active tree = true := by decide +kernel','theorem rejected : ∀ f, ¬H12CertificateBridge.Target (packedObservation f env) := terminalCheckFast_sound env active tree good checked','#print axioms rejected','end H12ConcreteLeaf12']
(root/'lean/H12ConcreteLeaf12.lean').write_text('\n\n'.join(out),encoding='utf-8')
(root/'reports/LEAN_CONCRETE_LEAF12_SOURCE.json').write_text(json.dumps({'scope':'Leaf node12, first chart only; not global tree coverage.','active':active,'candidates':cs,'data_modules':sorted(imports),'status':'GENERATED_NOT_YET_KERNEL_VERIFIED'},indent=2))
print('GENERATED_LEAF12',active,len(items),'candidates',len(imports),'data modules')
