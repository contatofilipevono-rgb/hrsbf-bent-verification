"""Exact finite G7 catalog. Generate or replay without solving systems."""
from pathlib import Path
from itertools import combinations,product
from collections import Counter
import json,zlib,time,sys,hashlib
ROOT=Path(__file__).resolve().parent
DATA=ROOT/'CATALOGO_DESLOCAMENTOS_G7_07NOV.json.zlib'
def wedge(A,B):
 r=set()
 for a in A:
  for b in B:
   if not a&b:
    if a|b in r:r.remove(a|b)
    else:r.add(a|b)
 return r
def tau(D,k):
 r=set()
 for a,b in combinations(D,2):
  m=a|b
  if m.bit_count()==k:
   if m in r:r.remove(m)
   else:r.add(m)
 return r
M3=[sum(1<<i for i in c) for c in combinations(range(10),3)]
M7=[sum(1<<i for i in c) for c in combinations(range(10),7)]
PARAM=[0]+[1<<i for i in range(2,10)]
A={40,132,320,528};B={20,40,132,384,520};C={72,80,144}
def make(q):
 u1,u2,v1,v2=[{x} if x else set() for x in q]
 At=A^wedge({1},v1)^wedge({2},v2)
 Bt=B^wedge({1},u1)^wedge({2},u2)
 return wedge(At,Bt)^wedge({3},C)
def solve(D):
 target=tau(D,7);cols=[wedge(D,{m}) for m in M3];piv={};ans=0
 for j,col in enumerate(cols):
  z=sum(1<<m for m in col);rel=1<<j
  while z:
   k=z.bit_length()-1
   if k not in piv:piv[k]=(z,rel);break
   z^=piv[k][0];rel^=piv[k][1]
 z=sum(1<<m for m in target)
 while z:
  k=z.bit_length()-1
  if k not in piv:break
  z^=piv[k][0];ans^=piv[k][1]
 if not z:return {'R3':[m for i,m in enumerate(M3) if ans>>i&1]}
 # Independently track equation combinations to certify the negative case.
 piv={}
 for m in M7:
  row=sum(1<<j for j,col in enumerate(cols) if m in col);rhs=int(m in target);rel=1<<m
  while row:
   k=row.bit_length()-1
   if k not in piv:piv[k]=(row,rhs,rel);break
   a,b,s=piv[k];row^=a;rhs^=b;rel^=s
  else:
   if rhs:return {'dual':[m for m in M7 if rel>>m&1]}
 raise AssertionError('Inconsistent solve paths')
def verify(D,cert):
 assert not tau(D,8)
 rhs=tau(D,7)
 if 'R3' in cert:
  assert wedge(D,set(cert['R3']))==rhs
 else:
  w=set(cert['dual'])
  assert len(w&rhs)%2==1
  assert all(len(w&wedge(D,{m}))%2==0 for m in M3)

start=time.time()
if '--generate' in sys.argv:
 cases=[];objects=[];known={}
 for q in product(PARAM,repeat=4):
  D=make(q);key=tuple(sorted(D))
  if key not in known:
   cert=solve(D);verify(D,cert);known[key]=len(objects)
   objects.append({'Delta':list(key),'certificate':cert})
  cases.append({'parameters':q,'object':known[key]})
 data={'scope':'Exactly 9^4 coordinate-or-zero shifts of one fixed core and residual; G7 only, not I6.','basis':['x1','x2']+['y'+str(i) for i in range(1,9)],'A0':sorted(A),'B0':sorted(B),'Omega_res':sorted(C),'cases':cases,'objects':objects}
 DATA.write_bytes(zlib.compress(json.dumps(data,separators=(',',':')).encode(),9))
data=json.loads(zlib.decompress(DATA.read_bytes()))
assert len(data['cases'])==6561
assert {tuple(c['parameters']) for c in data['cases']}==set(product(PARAM,repeat=4))
for obj in data['objects']:verify(set(obj['Delta']),obj['certificate'])
counts=Counter();distinct=Counter()
for obj in data['objects']:distinct['soluble' if 'R3' in obj['certificate'] else 'insoluble']+=1
for case in data['cases']:
 obj=data['objects'][case['object']]
 assert make(case['parameters'])==set(obj['Delta'])
 counts['soluble' if 'R3' in obj['certificate'] else 'insoluble']+=1
out={'cases':len(data['cases']),'distinct_Delta':len(data['objects']),'parameter_case_counts':dict(counts),'distinct_Delta_counts':dict(distinct),'all_G8_and_G7_certificates_replayed_without_solver':True,'compressed_bytes':DATA.stat().st_size,'sha256':hashlib.sha256(DATA.read_bytes()).hexdigest(),'seconds':time.time()-start,'scope':data['scope']}
(ROOT/'CATALOGO_DESLOCAMENTOS_G7_07NOV_RESUMO.json').write_text(json.dumps(out,indent=2))
print(json.dumps(out))
