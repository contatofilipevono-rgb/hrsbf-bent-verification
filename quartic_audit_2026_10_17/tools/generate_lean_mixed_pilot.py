"""Generate a limited mixed subtree with algebraic and Walsh-terminal checks.
The generated source still requires build and independent kernel replay.
"""
from pathlib import Path
import json,csv,itertools,argparse,re
parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--node',type=int,default=11)
parser.add_argument('--chart',type=int,default=0);parser.add_argument('--prefix',default='H12MixedPilot');parser.add_argument('--register',action='store_true')
args=parser.parse_args()
if not re.fullmatch(r'[A-Z][A-Za-z0-9_]*',args.prefix):raise SystemExit('Prefix must be a Lean module name.')
root=Path(__file__).resolve().parent.parent
model=json.loads((root/'cpu_replay/model.json').read_text());cert=json.loads((root/'cpu_replay/DECOMPOSITION.json').read_text())
mons=[0]+[1<<i for i in range(36)]+[(1<<i)|(1<<j) for i,j in itertools.combinations(range(36),2)];mi={m:i for i,m in enumerate(mons)}
def bits(x):
 while x:b=x&-x;x^=b;yield b.bit_length()-1

def poly(f):
 out=(1 if f['constant'] else 0)
 for i in bits(f['linear']):out^=1<<mi[1<<i]
 for i,row in enumerate(f['symmetric_rows']):
  for j in bits(row):
   if i<j:out^=1<<mi[(1<<i)|(1<<j)]
 return out

def xor(c,ps):
 r=0
 for i in bits(c):r^=ps[i]
 return r

def eliminate(ps,pivot,form,rhs):
 repl=[]
 for idx,m in enumerate(mons):
  if m>>pivot&1:
   rest=m^(1<<pivot);image=(1<<mi[rest]) if rhs else 0
   for i in bits(form):image^=1<<mi[rest|(1<<i)]
   repl.append((1<<idx,image^(1<<idx)))
 out=[]
 for p in ps:
  r=p
  for b,d in repl:
   if p&b:r^=d
  out.append(r)
 return out

def fmt(xs):return '['+','.join(str(x) for x in xs)+']'
def formpoly(mask,rhs):return ([0] if rhs else [])+[1<<i for i in bits(mask)]
book=[0]+[1<<i for i in range(36)]+[(1<<a)|(1<<b) for a in range(36) for b in range(36)]
def ci(m):
 if m==0:return 0
 b=m.bit_length()-1;r=m^(1<<b)
 if not r:return 1+b
 a=r.bit_length()-1;assert r==1<<a
 return 37+a*36+b
def canon(w):
 out=0
 for j in bits(w):out^=1<<ci(book[j])
 return out
def pack(p):
 out=0
 for j in bits(p):out^=1<<ci(mons[j])
 return out
def affine(a):return (a&1)^((a>>1)<<1)
def prod(a,b):
 out=(a&1)&(b&1);out^=(((b>>1) if a&1 else 0)^((a>>1) if b&1 else 0))<<1
 for i in bits(a>>1):out^=(b>>1)<<(37+i*36)
 return out
def col(i,a,j):
 m=book[j]
 if not m>>i&1:return 1<<j
 r=m^(1<<i)
 if not r:return affine(a)
 k=r.bit_length()-1
 return ((1<<(k+1)) if a&1 else 0)^((a>>1)<<(37+k*36))
def trans(ps,i,a):
 out=[]
 for w in ps:
  r=0
  for j in bits(w):r^=col(i,a,j)
  out.append(r)
 return out

chart=model['charts'][args.chart]
initialPS=[poly(f) for f in chart['quadratic_filters']]
initialEnv=[((chart['offset']>>j)&1)^sum(((b>>j)&1)<<(i+1) for i,b in enumerate(chart['basis'])) for j in range(43)]
chosen=None
def locate(nid,ps,env):
 global chosen
 if nid==args.node:chosen=(ps,env);return True
 node=cert['nodes'][nid]
 for step in node['linear_steps']:
  row=xor(int(step['combination'],16),ps);pivot=step['pivot'];form=(row>>1)^(1<<pivot);rhs=row&1
  ps=eliminate(ps,pivot,form,rhs);env=eliminate(env,pivot,form,rhs)
 if node['kind']=='split':
  form=int(node['form'],16);pivot=form.bit_length()-1;rest=form^(1<<pivot)
  for rhs,child in enumerate(node['children']):
   if child<=args.node and locate(child,eliminate(ps,pivot,rest,rhs),eliminate(env,pivot,rest,rhs)):return True
 return False
assert locate(cert['roots'][args.chart],initialPS,initialEnv)
rows=[]
for file in sorted((root/'cpu_replay').glob('full_thread*.csv')):
 with file.open(newline='') as source:
  for row in csv.DictReader(source):rows.append(int(row['original_coefficient'],16))
rows.sort();index={c:i for i,c in enumerate(rows)}
imports={'H12PackedTerminal','H12PackedSparse'};data=[];proofs=[];counter=0;stats={'nodes':0,'states':0,'transitions':0,'terminal_candidates':0};witnessNames={}
def witness(c):
 if c in witnessNames:return witnessNames[c]
 n=len(witnessNames);name=f'w{n}';witnessNames[c]=name
 position=index[c];module=f'H12WitnessData{position//4096:03d}';batch=f'{module}.batch{position%4096//256}';j=position%256;imports.add(module)
 data.append(f'def {name} : H12WitnessTheory.Witness := {batch}[{j}]\'(by decide)')
 data.append(f'theorem {name}_reject : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 {name}.coefficient)) :=\n  H12WitnessTheory.checked_list_sound {batch} {batch}_checked _ (List.getElem_mem (by decide))'.replace('\\n','\n'))
 data.append(f'theorem {name}_good : H12WitnessSearch.Good (.leaf {name}) := by\n  intro c hc\n  have he : {name}.coefficient = c := beq_iff_eq.mp hc\n  rw [← he]\n  exact {name}_reject'.replace('\\n','\n'))
 return name
def tree(items):
 if len(items)==1:
  w=witness(items[0]);return f'(.leaf {w})',f'{w}_good'
 mid=len(items)//2;l,hl=tree(items[:mid]);r,hr=tree(items[mid:]);pivot=items[mid]
 return f'(.node {pivot} {l} {r})',f'(H12WitnessSearch.node_good {pivot} _ _ {hl} {hr})'
def state(ps,env):
 global counter
 n=counter;counter+=1;stats['states']+=1
 for label,words in [('ps',ps),('env',env)]:
  data.append(f'def {label}{n} : List Nat := '+fmt(words))
  data.append(f'theorem {label}Bound{n} : packedBounded {label}{n} := by\n  intro p hp\n  have h : {label}{n}.all (fun p => decide (p < 2^1333)) = true := by decide +kernel\n  exact of_decide_eq_true (List.all_eq_true.mp h p hp)'.replace('\\n','\n'))
 return n
def transition(old,new,p,a):
 stats['transitions']+=1
 for label in ['ps','env']:
  data.append(f'theorem {label}Trans{old}_{new} : packedTransform {p} {a} {label}{old} = {label}{new} := by\n  rw [← H12PackedSparse.directTransform_eq {p} {a} {label}{old} {label}Bound{old}]\n  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform {p} {a} {label}{old} == {label}{new}) = true)'.replace('\\n','\n'))
def walk(nid,ps,env,current):
 stats['nodes']+=1;node=cert['nodes'][nid];chain=[]
 for step in node['linear_steps']:
  indices=list(bits(int(step['combination'],16)));row=canon(xor(int(step['combination'],16),ps));assert row<1<<37
  p=step['pivot'];a=row^(1<<(p+1))
  data.append(f'theorem identity{current} : scanCanonicalize (packedSelected {fmt(indices)} ps{current}) = affineNative (2^({p}+1) ^^^ {a}) := by decide +kernel')
  data.append(f'theorem selectedBound{current} : packedSelected {fmt(indices)} ps{current} < 2^1333 := by decide +kernel')
  np=trans(ps,p,a);ne=trans(env,p,a);nxt=state(np,ne);transition(current,nxt,p,a);chain.append((current,nxt,p,a,indices));ps,env,current=np,ne,nxt
 if node['kind']=='contradiction':
  indices=list(bits(int(node['combination'],16)))
  proofs.append(f'theorem ref{current} : PackedRefutes H12CertificateBridge.Target ps{current} env{current} :=\n  .contradiction _ _ {fmt(indices)} (by decide +kernel) (by decide +kernel)'.replace('\\n','\n'))
 elif node['kind']=='solutions':
  assert all(canon(p)==0 for p in ps) and all(w<1<<37 for w in env)
  support=0
  for word in env:support|=word>>1
  active=list(bits(support));assert len(active)==node['dimension']
  candidates=[]
  for z in range(1<<len(active)):
   assignment=sum(((z>>j)&1)<<i for j,i in enumerate(active))
   c=sum(((word&1)^(((word>>1)&assignment).bit_count()%2))<<i for i,word in enumerate(env));assert c in index;candidates.append(c)
  stats['terminal_candidates']+=len(candidates);t,h=tree(sorted(set(candidates)))
  data.append(f'def active{current} : List Nat := '+fmt(active))
  data.append(f'def tree{current} : H12WitnessSearch.Tree := '+t)
  data.append(f'theorem treeGood{current} : H12WitnessSearch.Good tree{current} := '+h)
  data.append(f'theorem terminalChecked{current} : H12PackedTerminal.terminalCheckFast env{current} active{current} tree{current} = true := by decide +kernel')
  proofs.append(f'theorem ref{current} : PackedRefutes H12CertificateBridge.Target ps{current} env{current} :=\n  .terminal _ _ (H12PackedTerminal.terminalCheckFast_sound env{current} active{current} tree{current} treeGood{current} terminalChecked{current})'.replace('\\n','\n'))
 else:
  form=int(node['form'],16);p=form.bit_length()-1;a=(form^(1<<p))<<1;children=[]
  for rhs,child in enumerate(node['children']):
   np=trans(ps,p,a^rhs);ne=trans(env,p,a^rhs);nxt=state(np,ne);transition(current,nxt,p,a^rhs);walk(child,np,ne,nxt);children.append(nxt)
  proofs.append(f'theorem ref{current} : PackedRefutes H12CertificateBridge.Target ps{current} env{current} := by\n  apply PackedRefutes.split ps{current} env{current} {p} {a} (by decide) psBound{current} envBound{current}\n  · rw [psTrans{current}_{children[0]}, envTrans{current}_{children[0]}]; exact ref{children[0]}\n  · rw [show {a} ^^^ 1 = {a^1} from by decide +kernel, psTrans{current}_{children[1]}, envTrans{current}_{children[1]}]; exact ref{children[1]}'.replace('\\n','\n'))
 for old,nxt,p,a,indices in reversed(chain):
  proofs.append(f'theorem ref{old} : PackedRefutes H12CertificateBridge.Target ps{old} env{old} := by\n  apply PackedRefutes.eliminate ps{old} env{old} {p} {a} (by decide) {fmt(indices)} selectedBound{old} identity{old} psBound{old} envBound{old}\n  rw [psTrans{old}_{nxt}, envTrans{old}_{nxt}]; exact ref{nxt}'.replace('\\n','\n'))
ps,env=chosen;ps=[pack(p) for p in ps];env=[pack(p) for p in env];start=state(ps,env);walk(args.node,ps,env,start)
header=[f'namespace {args.prefix}','open H12PackedPolynomial','set_option maxRecDepth 100000','set_option maxHeartbeats 1000000000'];modules=[]
for begin in range(0,len(data),60):
 name=f'{args.prefix}Data{len(modules):03d}';prior=['import '+modules[-1]] if modules else ['import '+m for m in sorted(imports)]
 source='\n\n'.join(prior+header+data[begin:begin+60]+[f'end {args.prefix}']);file=root/'lean'/(name+'.lean')
 if not file.exists() or file.read_text(encoding='utf-8')!=source:file.write_text(source,encoding='utf-8')
 modules.append(name)
proofs += ['theorem rejected (f : Nat → Bool) (hm : packedModels f ps0) : ¬H12CertificateBridge.Target (packedObservation f env0) :=\n  packedRefutes_sound H12CertificateBridge.Target _ _ ref0 f hm'.replace('\\n','\n'),'#print axioms rejected',f'end {args.prefix}']
file=root/'lean'/(args.prefix+'.lean');file.write_text('\n\n'.join(['import '+modules[-1]]+header+proofs),encoding='utf-8')
report={'status':'GENERATED_NOT_YET_KERNEL_VERIFIED','chart':args.chart,'subtree':args.node,'scope':'Limited subtree only; paths from global roots remain separate obligations.','statistics':stats,'modules':modules+[args.prefix]}
(root/'reports'/(args.prefix+'_SOURCE.json')).write_text(json.dumps(report,indent=2));print(report)

if args.register:
 config=root/'lean/lakefile.toml';text=config.read_text(encoding='utf-8');name=args.prefix+'Certificate'
 block='[[lean_lib]]\nname = "'+name+'"\nroots = '+json.dumps(modules+[args.prefix])+'\n'
 pattern=r'(?ms)^\[\[lean_lib\]\]\s*\nname = "'+re.escape(name)+r'".*?(?=^\[\[lean_lib\]\]|\Z)'
 if re.search(pattern,text):text=re.sub(pattern,lambda _:block+'\n',text)
 else:text=text.rstrip()+'\n\n'+block
 config.write_text(text,encoding='utf-8')
