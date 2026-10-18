"""Generate a limited mixed subtree with algebraic and Walsh-terminal checks.
The generated source still requires build and independent kernel replay.
"""
from pathlib import Path
import json,csv,itertools,argparse,re
parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--node',type=int,default=11)
parser.add_argument('--chart',type=int,default=0);parser.add_argument('--prefix',default='H12AffinePilot');parser.add_argument('--register',action='store_true');parser.add_argument('--root-frame',action='store_true');parser.add_argument('--chunk-size',type=int,default=60);parser.add_argument('--proof-chunk-size',type=int,default=200);parser.add_argument('--check-python-composition',action='store_true')
parser.add_argument('--engine',choices=['H12AffineState','H12AffineRowState','H12AffineRowScanState','H12AffineFastState'],default='H12AffineState')
parser.add_argument('--label-leaves',action='store_true',help='Use coefficient labels with rejection proofs from checked witness lists.')
parser.add_argument('--global-label-index',action='store_true',help='Reuse the separately kernel-verified global coefficient index.')
args=parser.parse_args()
def render(source):
 source=source.replace('H12AffineState',args.engine)
 if args.engine=='H12AffineRowState':source=source.replace('scanCanonicalize','H12QuadraticCompose.canonicalFast')
 if args.engine=='H12AffineFastState':source=source.replace('H12PackedSparse.directTransform','H12AffineEnvironment.transform')
 return source
if not re.fullmatch(r'[A-Z][A-Za-z0-9_]*',args.prefix):raise SystemExit('Prefix must be a Lean module name.')
if args.chunk_size<1 or args.proof_chunk_size<1:raise SystemExit('Chunk sizes must be positive.')
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
imports={'H12AffineState'};data=[];proofs=[];counter=0;stats={'nodes':0,'states':0,'transitions':0,'terminal_candidates':0};witnessNames={}
def witness(c):
 if args.label_leaves:
  position=index[c];module=f'H12WitnessData{position//4096:03d}';batch=f'{module}.batch{position%4096//256}';j=position%256
  imports.add(module);imports.add('H12WitnessLabels')
  return f'(H12WitnessLabels.label {c})',f'(H12WitnessLabels.label_good {batch} {batch}_checked {j} (by decide) {c} (by decide +kernel))'
 if c in witnessNames:return witnessNames[c]
 n=len(witnessNames);name=f'w{n}';witnessNames[c]=name
 position=index[c];module=f'H12WitnessData{position//4096:03d}';batch=f'{module}.batch{position%4096//256}';j=position%256;imports.add(module)
 data.append(f'def {name} : H12WitnessTheory.Witness := {batch}[{j}]\'(by decide)')
 data.append(f'theorem {name}_reject : ¬H12Descent.BentAC (H12.quarticFunction (BitVec.ofNat 43 {name}.coefficient)) :=\n  H12WitnessTheory.checked_list_sound {batch} {batch}_checked _ (List.getElem_mem (by decide))'.replace('\\n','\n'))
 data.append(f'theorem {name}_good : H12WitnessSearch.Good (.leaf {name}) := by\n  intro c hc\n  have he : {name}.coefficient = c := beq_iff_eq.mp hc\n  rw [← he]\n  exact {name}_reject'.replace('\\n','\n'))
 return name
def tree(items):
 if args.global_label_index:
  imports.add('H12GlobalWitnessIndex')
  return 'H12GlobalWitnessIndex.tree','H12GlobalWitnessIndex.good'
 if len(items)==1:
  if args.label_leaves:return witness(items[0])
  w=witness(items[0]);return f'(.leaf {w})',f'{w}_good'
 mid=len(items)//2;l,hl=tree(items[:mid]);r,hr=tree(items[mid:]);pivot=items[mid]
 return f'(.node {pivot} {l} {r})',f'(H12WitnessSearch.node_good {pivot} _ _ {hl} {hr})'

initialVariables=[1<<(i+1) for i in range(36)];chosenVariables=None
if args.root_frame:
 def locateVariables(nid,ps,variables):
  global chosenVariables
  if nid==args.node:chosenVariables=variables;return True
  node=cert['nodes'][nid]
  for step in node['linear_steps']:
   row=xor(int(step['combination'],16),ps);pivot=step['pivot'];form=(row>>1)^(1<<pivot);rhs=row&1
   ps=eliminate(ps,pivot,form,rhs);variables=eliminate(variables,pivot,form,rhs)
  if node['kind']=='split':
   form=int(node['form'],16);pivot=form.bit_length()-1;rest=form^(1<<pivot)
   for rhs,child in enumerate(node['children']):
    if child<=args.node and locateVariables(child,eliminate(ps,pivot,rest,rhs),eliminate(variables,pivot,rest,rhs)):return True
  return False
 assert locateVariables(cert['roots'][args.chart],initialPS,initialVariables)
sourcePS=[pack(p) for p in (initialPS if args.root_frame else chosen[0])]
sourceObs=[pack(p) for p in (initialEnv if args.root_frame else chosen[1])]

def transformAffine(env,p,a):
 return [word^((1<<(p+1))^a) if word>>(p+1)&1 else word for word in env]
def composeNative(env,word):
 out=0
 for j in bits(word):
  if j==0:out^=1
  elif j<37:out^=affine(env[j-1])
  else:out^=prod(env[(j-37)//36],env[(j-37)%36])
 return out
data.append('def rootPS : List Nat := '+fmt(sourcePS));data.append('def rootObs : List Nat := '+fmt(sourceObs))
data.append('theorem rootObsBound : packedBounded rootObs := by\n  intro p hp\n  have h : rootObs.all (fun p => decide (p < 2^1333)) = true := by decide +kernel\n  exact of_decide_eq_true (List.all_eq_true.mp h p hp)'.replace('\\n','\n'))
def state(env):
 global counter
 n=counter;counter+=1;stats['states']+=1
 data.append(f'def env{n} : List Nat := '+fmt(env))
 data.append(f'theorem envBound{n} : H12AffineState.Bounded env{n} := by\n  intro p hp\n  have h : env{n}.all (fun p => decide (p < 2^37)) = true := by decide +kernel\n  exact of_decide_eq_true (List.all_eq_true.mp h p hp)'.replace('\\n','\n'))
 return n
def transition(old,new,p,a):
 stats['transitions']+=1
 data.append(f'theorem envTrans{old}_{new} : H12PackedSparse.directTransform {p} {a} env{old} = env{new} := by\n  exact beq_iff_eq.mp (by decide +kernel : (H12PackedSparse.directTransform {p} {a} env{old} == env{new}) = true)'.replace('\\n','\n'))
def walk(nid,ps,env,current):
 stats['nodes']+=1;node=cert['nodes'][nid];chain=[]
 if stats['nodes']%1000==0:print('GENERATING_NODES',stats['nodes'],'states',stats['states'],flush=True)
 for step in node['linear_steps']:
  combination=int(step['combination'],16);indices=list(bits(combination));row=xor(combination,ps);assert row<1<<37
  if args.check_python_composition:assert canon(composeNative(env,xor(combination,sourcePS)))==row
  p=step['pivot'];a=row^(1<<(p+1))
  data.append(f'theorem identity{current} : scanCanonicalize (H12AffineState.compose env{current} (packedSelected {fmt(indices)} rootPS)) = affineNative (2^({p}+1) ^^^ {a}) := by decide +kernel')
  data.append(f'theorem selectedBound{current} : packedSelected {fmt(indices)} rootPS < 2^1333 := by decide +kernel')
  np=eliminate(ps,p,a>>1,a&1);ne=transformAffine(env,p,a);nxt=state(ne);transition(current,nxt,p,a);chain.append((current,nxt,p,a,indices));ps,env,current=np,ne,nxt
 if node['kind']=='contradiction':
  indices=list(bits(int(node['combination'],16)))
  if args.check_python_composition:assert canon(composeNative(env,xor(int(node['combination'],16),sourcePS)))==1
  proofs.append(f'theorem ref{current} : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env{current} :=\n  .contradiction _ {fmt(indices)} (by decide +kernel) (by decide +kernel)'.replace('\\n','\n'))
 elif node['kind']=='solutions':
  assert all(p==0 for p in ps)
  coeffEnv=[composeNative(env,p) for p in sourceObs];assert all(w<1<<37 for w in coeffEnv)
  support=0
  for word in coeffEnv:support|=word>>1
  active=list(bits(support));assert len(active)==node['dimension'];candidates=[]
  for z in range(1<<len(active)):
   assignment=sum(((z>>j)&1)<<i for j,i in enumerate(active))
   c=sum(((word&1)^(((word>>1)&assignment).bit_count()%2))<<i for i,word in enumerate(coeffEnv));assert c in index;candidates.append(c)
  stats['terminal_candidates']+=len(candidates);t,h=tree(sorted(set(candidates)))
  data.append(f'def leafEnv{current} : List Nat := '+fmt(coeffEnv));data.append(f'def active{current} : List Nat := '+fmt(active));data.append(f'def tree{current} : H12WitnessSearch.Tree := '+t)
  data.append(f'theorem treeGood{current} : H12WitnessSearch.Good tree{current} := '+h)
  data.append(f'theorem leafIdentity{current} : H12AffineState.composeSystem env{current} rootObs = leafEnv{current} := by\n  exact beq_iff_eq.mp (by decide +kernel : (H12AffineState.composeSystem env{current} rootObs == leafEnv{current}) = true)'.replace('\\n','\n'))
  data.append(f'theorem terminalChecked{current} : H12PackedTerminal.terminalCheckFast leafEnv{current} active{current} tree{current} = true := by decide +kernel')
  proofs.append(f'theorem ref{current} : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env{current} :=\n  .terminal _ (H12AffineState.leaf_sound env{current} rootObs leafEnv{current} active{current} tree{current} rootObsBound treeGood{current} leafIdentity{current} terminalChecked{current})'.replace('\\n','\n'))
 else:
  form=int(node['form'],16);p=form.bit_length()-1;a=(form^(1<<p))<<1;children=[]
  for rhs,child in enumerate(node['children']):
   np=eliminate(ps,p,(a^rhs)>>1,(a^rhs)&1);ne=transformAffine(env,p,a^rhs);nxt=state(ne);transition(current,nxt,p,a^rhs);walk(child,np,ne,nxt);children.append(nxt)
  n0,n1=children
  proofs.append(f'theorem ref{current} : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env{current} := by\n  apply H12AffineState.Refutes.split env{current} {p} {a} (by decide) envBound{current}\n  · rw [envTrans{current}_{n0}]; exact envBound{n0}\n  · rw [show {a} ^^^ 1 = {a^1} from by decide +kernel, envTrans{current}_{n1}]; exact envBound{n1}\n  · rw [envTrans{current}_{n0}]; exact ref{n0}\n  · rw [show {a} ^^^ 1 = {a^1} from by decide +kernel, envTrans{current}_{n1}]; exact ref{n1}'.replace('\\n','\n'))
 for old,nxt,p,a,indices in reversed(chain):
  proofs.append(f'theorem ref{old} : H12AffineState.Refutes H12CertificateBridge.Target rootPS rootObs env{old} := by\n  apply H12AffineState.Refutes.eliminate env{old} {p} {a} (by decide) {fmt(indices)} selectedBound{old} identity{old} envBound{old}\n  · rw [envTrans{old}_{nxt}]; exact envBound{nxt}\n  · rw [envTrans{old}_{nxt}]; exact ref{nxt}'.replace('\\n','\n'))
ps=chosen[0];env=[pack(p) for p in chosenVariables] if args.root_frame else initialVariables;start=state(env);walk(args.node,ps,env,start)
header=[f'namespace {args.prefix}','open H12PackedPolynomial','set_option maxRecDepth 100000','set_option maxHeartbeats 1000000000'];modules=[]
for begin in range(0,len(data),args.chunk_size):
 name=f'{args.prefix}Data{len(modules):03d}';prior=['import '+modules[-1]] if modules else ['import '+m for m in sorted(imports)]
 source=render('\n\n'.join(prior+header+data[begin:begin+args.chunk_size]+[f'end {args.prefix}']));file=root/'lean'/(name+'.lean')
 if not file.exists() or file.read_text(encoding='utf-8')!=source:file.write_text(source,encoding='utf-8')
 modules.append(name)
if args.root_frame and args.node!=cert['roots'][args.chart]:
 conclusion='theorem rejected (f : Nat → Bool) (hm : packedModels (H12AffineState.assignment env0 f) rootPS) : ¬H12CertificateBridge.Target (packedObservation (H12AffineState.assignment env0 f) rootObs) :=\n  H12AffineState.refutes_sound H12CertificateBridge.Target rootPS rootObs env0 ref0 f hm'
else:
 conclusion='theorem rejected (f : Nat → Bool) (hm : packedModels f rootPS) : ¬H12CertificateBridge.Target (packedObservation f rootObs) :=\n  H12AffineState.reject_identity H12CertificateBridge.Target rootPS rootObs ref0 f hm'
proofModules=[]
for begin in range(0,len(proofs),args.proof_chunk_size):
 name=f'{args.prefix}Proof{len(proofModules):03d}'
 prior=proofModules[-1] if proofModules else modules[-1]
 source=render('\n\n'.join(['import '+prior]+header+proofs[begin:begin+args.proof_chunk_size]+[f'end {args.prefix}']))
 file=root/'lean'/(name+'.lean')
 if not file.exists() or file.read_text(encoding='utf-8')!=source:file.write_text(source,encoding='utf-8')
 proofModules.append(name)
last=proofModules[-1] if proofModules else modules[-1]
final=[conclusion,'#print axioms rejected']
if args.node==cert['roots'][args.chart]:
 final += [f'theorem rootPS_identity : rootPS = H12PackedRoots.rootPS {args.chart} := by\n  exact beq_iff_eq.mp (by decide +kernel : (rootPS == H12PackedRoots.rootPS {args.chart}) = true)',
           f'theorem rootObs_identity : rootObs = H12PackedRoots.rootEnv {args.chart} := by\n  exact beq_iff_eq.mp (by decide +kernel : (rootObs == H12PackedRoots.rootEnv {args.chart}) = true)',
           f'theorem refutation : H12AffineState.Refutes H12CertificateBridge.Target (H12PackedRoots.rootPS {args.chart}) (H12PackedRoots.rootEnv {args.chart}) H12AffineState.identityEnv := by\n  have h := ref0\n  rw [rootPS_identity, rootObs_identity] at h\n  exact h', '#print axioms refutation']
final += [f'end {args.prefix}']
file=root/'lean'/(args.prefix+'.lean');file.write_text(render('\n\n'.join(['import '+last]+header+final)),encoding='utf-8')
modules += proofModules
report={'status':'GENERATED_NOT_YET_KERNEL_VERIFIED','chart':args.chart,'subtree':args.node,'root_frame':args.root_frame,'scope':'Fixed-equation affine-environment subtree only; not global tree coverage.','full_recorded_chart_root':args.node==cert['roots'][args.chart],'generator_sha256':__import__('hashlib').sha256(Path(__file__).read_bytes()).hexdigest(),'statistics':stats,'modules':modules+[args.prefix]}
report['engine']=args.engine
report['coefficient_label_leaves']=args.label_leaves
report['global_coefficient_label_index']=args.global_label_index
report['data_chunk_size']=args.chunk_size
report['proof_chunk_size']=args.proof_chunk_size
(root/'reports'/(args.prefix+'_SOURCE.json')).write_text(json.dumps(report,indent=2));print(report)
if args.register:
 config=root/'lean/lakefile.toml';text=config.read_text(encoding='utf-8');name=args.prefix+'Certificate'
 block='[[lean_lib]]\nname = "'+name+'"\nroots = '+json.dumps(modules+[args.prefix])+'\n'
 pattern=r'(?ms)^\[\[lean_lib\]\]\s*\nname = "'+re.escape(name)+r'".*?(?=^\[\[lean_lib\]\]|\Z)'
 if re.search(pattern,text):text=re.sub(pattern,lambda _:block+'\n',text)
 else:text=text.rstrip()+'\n\n'+block
 config.write_text(text,encoding='utf-8')
