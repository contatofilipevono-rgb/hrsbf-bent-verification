"""Generate the limited subtree-18 packed Lean pilot from the public certificate.
This source generation is not itself a proof check or global tree coverage.
"""
from pathlib import Path
import json,itertools
root=Path(__file__).resolve().parent.parent
model=json.loads((root/'cpu_replay/model.json').read_text())
cert=json.loads((root/'cpu_replay/DECOMPOSITION.json').read_text())
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
selected=None

def locate(nid,ps):
 global selected
 if nid==18:selected=ps;return True
 node=cert['nodes'][nid]
 for st in node['linear_steps']:
  row=xor(int(st['combination'],16),ps);p=st['pivot'];ps=eliminate(ps,p,(row>>1)^(1<<p),row&1)
 if node['kind']=='split':
  form=int(node['form'],16);p=form.bit_length()-1
  for rhs,ch in enumerate(node['children']):
   if ch<=18 and locate(ch,eliminate(ps,p,form^(1<<p),rhs)):return True
 return False
locate(cert['roots'][0],[poly(f) for f in model['charts'][0]['quadratic_filters']]);assert selected is not None
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
out=['import H12PackedPolynomial','namespace H12PackedPilot','open H12PackedPolynomial','set_option maxRecDepth 100000','set_option maxHeartbeats 1000000000'];counter=0;proofs=[];stats={'states':0,'transitions':0,'identities':0}
def state(ps):
 global counter
 n=counter;counter+=1;stats['states']+=1
 out.append(f'def ps{n} : List Nat := '+fmt(ps))
 out.append(f'theorem bound{n} : packedBounded ps{n} := by\n  intro p hp\n  have h : ps{n}.all (fun p => decide (p < 2^1333)) = true := by decide +kernel\n  exact of_decide_eq_true (List.all_eq_true.mp h p hp)')
 return n
def transition(old,new,p,a):
 stats['transitions']+=1;name=f'trans{old}_{new}'
 out.append(f'theorem {name} : packedTransform {p} {a} ps{old} = ps{new} := by\n  exact beq_iff_eq.mp (by decide +kernel : (packedTransform {p} {a} ps{old} == ps{new}) = true)')
 out.append(f'#print axioms {name}')
 return name
def walk(nid,ps,current):
 node=cert['nodes'][nid];chain=[]
 for st in node['linear_steps']:
  inds=list(bits(int(st['combination'],16)));row=xor(int(st['combination'],16),ps);c=canon(row);linear=0
  for j in bits(c):
   assert j<37
   linear^=1<<j
  p=st['pivot'];a=linear^(1<<(p+1));assert canon(row)==affine((1<<(p+1))^a)
  identity=f'id{current}';stats['identities']+=1
  out.append(f'theorem {identity} : scanCanonicalize (packedSelected {fmt(inds)} ps{current}) = affineNative (2^({p}+1) ^^^ {a}) := by decide +kernel')
  out.append(f'theorem selectedBound{current} : packedSelected {fmt(inds)} ps{current} < 2^1333 := by decide +kernel')
  pp=trans(ps,p,a);nxt=state(pp);tr=transition(current,nxt,p,a);chain.append((current,nxt,p,a,inds,tr,identity));ps=pp;current=nxt
 if node['kind']=='contradiction':
  inds=list(bits(int(node['combination'],16)));assert canon(xor(int(node['combination'],16),ps))==1
  proofs.append(f'theorem ref{current} : PackedRefutes (fun _ => True) ps{current} [] :=\n  .contradiction _ _ {fmt(inds)} (by decide +kernel) (by decide +kernel)')
 else:
  assert node['kind']=='split';form=int(node['form'],16);p=form.bit_length()-1;a=(form^(1<<p))<<1;children=[]
  for rhs,ch in enumerate(node['children']):
   pp=trans(ps,p,a^rhs);nxt=state(pp);tr=transition(current,nxt,p,a^rhs);walk(ch,pp,nxt);children.append((nxt,tr))
  proofs.append(f'theorem ref{current} : PackedRefutes (fun _ => True) ps{current} [] := by\n  apply PackedRefutes.split ps{current} [] {p} {a} (by decide) bound{current} (by simp [packedBounded])\n  · rw [{children[0][1]}]; exact ref{children[0][0]}\n  · rw [show {a} ^^^ 1 = {a^1} from by decide +kernel, {children[1][1]}]; exact ref{children[1][0]}')
 for old,nxt,p,a,inds,tr,identity in reversed(chain):
  proofs.append(f'theorem ref{old} : PackedRefutes (fun _ => True) ps{old} [] := by\n  apply PackedRefutes.eliminate ps{old} [] {p} {a} (by decide) {fmt(inds)} selectedBound{old} {identity} bound{old} (by simp [packedBounded])\n  rw [{tr}]; exact ref{nxt}')
initial=state([pack(p) for p in selected]);walk(18,[pack(p) for p in selected],initial)
# Cache numeric lemmas in small modules so a linkage fix does not repeat arithmetic.
header=out[:5];declarations=out[5:];modules=[]
for start in range(0,len(declarations),60):
 name=f'H12PackedPilotData{len(modules):03d}'
 previous=modules[-1] if modules else 'H12PackedPolynomial'
 source='\n\n'.join(['import '+previous]+header[1:]+declarations[start:start+60]+['end H12PackedPilot'])
 file=root/'lean'/(name+'.lean')
 if not file.exists() or file.read_text(encoding='utf-8')!=source:file.write_text(source,encoding='utf-8')
 modules.append(name)
proofs+=['theorem no_model (f : Nat → Bool) (hm : packedModels f ps0) : False :=\n  (packedRefutes_sound (fun _ => True) _ _ ref0 f hm) trivial','#print axioms no_model','end H12PackedPilot']
file=root/'lean/H12PackedPilot.lean';file.write_text('\n\n'.join(['import '+modules[-1]]+header[1:]+proofs),encoding='utf-8')
print(stats,'data_modules',modules,'proof_bytes',file.stat().st_size)
