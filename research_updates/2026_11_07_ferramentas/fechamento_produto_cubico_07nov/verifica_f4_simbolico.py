from pathlib import Path
from itertools import combinations
import json,random,time,sys,zlib,hashlib
case=sys.argv[1] if len(sys.argv)>1 else 'F4_3'
n=12 if case=='F4_3' else 11;root=Path(__file__).parent
mon=lambda k:[sum(1<<i for i in c) for c in combinations(range(n),k)]
L3=mon(3);L6=mon(6);L7=mon(7);i6={x:i for i,x in enumerate(L6)};i7={x:i for i,x in enumerate(L7)};i3={x:i for i,x in enumerate(L3)}
w1=set();w2=set()
for b in range(3 if n==12 else 2):
 o=4*b;w1|={(1<<o)|(1<<(o+2)),(1<<(o+1))|(1<<(o+3))};w2|={(1<<(o+1))|(1<<(o+2)),(1<<o)|(1<<(o+3)),(1<<(o+1))|(1<<(o+3))}
if case=='F4_J2_L1':
 w1={(1<<i)|(1<<(4+i)) for i in range(4)}
 w2={(1<<(i+1))|(1<<(4+i)) for i in range(3)}|{(1<<0)|(1<<7),(1<<2)|(1<<7)}
if n==11:
 w1.add((1<<8)|(1<<9));w2.add((1<<9)|(1<<10))
def prod(A,B,ext=False):
 out=set()
 for a in A:
  for b in B:
   if not ext or not a&b:
    c=a|b
    if c in out:out.remove(c)
    else:out.add(c)
 return out
def rank(vs):
 p={}
 for x in vs:
  while x:
   h=x.bit_length()-1
   if h in p:x^=p[h]
   else:p[h]=x;break
 return len(p)
def polar_rank(w):
 rows=[0]*n
 for m in w:
  i,j=[i for i in range(n) if m>>i&1];rows[i]^=1<<j;rows[j]^=1<<i
 return rank(rows)
assert [polar_rank(w) for w in [w1,w2,w1^w2]]==([12]*3 if n==12 else [10]*3)
T=prod(w1,w2,True)
imgs=[sum(1<<i7[x] for x in prod(T,{m},True)) for m in L3]
span=[sum(1<<i3[x] for x in prod(w,{1<<i},True)) for w in [w1,w2] for i in range(n)]
# Recompute a basis of the kernel, then a complement of the linear span.
piv={};kernel=[]
for j,img in enumerate(imgs):
 rel=1<<j
 while img:
  h=img.bit_length()-1
  if h in piv:img^=piv[h][0];rel^=piv[h][1]
  else:piv[h]=(img,rel);break
 else:kernel.append(rel)
base={}
def insert(v):
 while v:
  h=v.bit_length()-1
  if h in base:v^=base[h]
  else:base[h]=v;return True
 return False
for v in span:insert(v)
ex=[]
for v in kernel:
 if insert(v):ex.append(v)
m=len(ex)
assert m==(7 if case=='F4_J2_L1' else 16) and len(kernel)==(40 if n==12 else (29 if case=='F4_J2_L1' else 38)) and rank(span)==2*n and rank(span+ex)==len(kernel)
E=[{L3[i] for i in range(len(L3)) if e>>i&1} for e in ex]
assert all(not prod(T,e,True) for e in E)
D0=prod(w1,w2)
def residue(S):
 r=0
 for a,b in combinations(S,2):
  u=a|b
  if u.bit_count()==6:r^=1<<i6[u]
 return r
def D(es=(),l1=(),l2=(),R2=()):
 R=set(R2)
 for i in es:R^=E[i]
 return prod(w1^{1<<i for i in l1},w2^{1<<i for i in l2})^R
b0=residue(D());b1=[residue(D([i]))^b0 for i in range(m)];b2={(i,j):residue(D([i,j]))^b0^b1[i]^b1[j] for i,j in combinations(range(m),2)}
C2=[residue(D(R2=[q]))^b0 for q in mon(2)]
CL={}
for side in [1,2]:
 for i in range(n):
  kw={'l1':[i]} if side==1 else {'l2':[i]};base=residue(D(**kw))^b0;CL[side,i,None]=base
  for k in range(m):CL[side,i,k]=residue(D([k],**kw))^b0^b1[k]^base
# Independent checks that the interpolated residue matches exact symbolic ANF for joint choices.
rng=random.Random(20261107)
for t in range(100):
 ks=[i for i in range(m) if rng.getrandbits(1)];l1=[i for i in range(n) if rng.getrandbits(1)];l2=[i for i in range(n) if rng.getrandbits(1)];r2=[q for q in mon(2) if rng.getrandbits(1)]
 pred=b0
 for k in ks:pred^=b1[k]
 for i,j in combinations(ks,2):pred^=b2[i,j]
 for q in r2:pred^=C2[mon(2).index(q)]
 for side,ls in [(1,l1),(2,l2)]:
  for i in ls:
   pred^=CL[side,i,None]
   for k in ks:pred^=CL[side,i,k]
 assert pred==residue(D(ks,l1,l2,r2))
# Exact polynomial identity in all106 Boolean parameters, not just the100 sample checks.
# Each coefficient of the coordinate ANF is itself a GF2 polynomial in parameters.
PA={}
def addterm(coord,params):
 bucket=PA.setdefault(coord,set())
 if params in bucket:bucket.remove(params)
 else:bucket.add(params)
for a,ap in [(a,0) for a in w1]+[(1<<i,1<<(m+i)) for i in range(n)]:
 for b,bp in [(b,0) for b in w2]+[(1<<i,1<<(m+n+i)) for i in range(n)]:addterm(a|b,ap|bp)
for k,ee in enumerate(E):
 for c in ee:addterm(c,1<<k)
for j,c in enumerate(mon(2)):addterm(c,1<<(m+2*n+j))
actual={}
for (a,ac),(b,bc) in combinations([(k,v) for k,v in PA.items() if v],2):
 u=a|b
 if u.bit_count()!=6:continue
 rowbit=1<<i6[u]
 for ap in ac:
  for bp in bc:actual[ap|bp]=actual.get(ap|bp,0)^rowbit
actual={k:v for k,v in actual.items() if v}
expected={0:b0}
for k,vv in enumerate(b1):expected[1<<k]=vv
for (i,j),vv in b2.items():expected[(1<<i)|(1<<j)]=vv
for j,vv in enumerate(C2):expected[1<<(m+2*n+j)]=vv
for (side,i,k),vv in CL.items():
 key=1<<((m if side==1 else m+n)+i)
 if k is not None:key|=1<<k
 expected[key]=vv
expected={k:v for k,v in expected.items() if v}
assert actual==expected,{'extra_parameters':set(actual)-set(expected),'missing_parameters':set(expected)-set(actual)}

features=C2+list(CL.values())+b1+list(b2.values())
rk=rank(features);rka=rank(features+[b0]);report={'pencil':case,'kernel':len(kernel),'span':rank(span),'extras':m,'independent_interpolation_controls':100,'feature_rank':rk,'augmented_rank':rka,'exact_parameter_polynomial_identity':True,'number_parameter_monomials':len(actual),'parameters':m+2*n+len(mon(2))}
if rka>rk:
 piv={}
 for row,rhs in [(v,0) for v in features]+[(b0,1)]:
  while row:
   h=row.bit_length()-1
   if h in piv:row^=piv[h][0];rhs^=piv[h][1]
   else:piv[h]=(row,rhs);break
  else:assert rhs==0
 y=0
 for h,(row,rhs) in sorted(piv.items()):
  if (row&y).bit_count()%2 != rhs:y|=1<<h
 assert (b0&y).bit_count()%2==1 and all((v&y).bit_count()%2==0 for v in features)
 report['universal_dual_certificate_masks']=[L6[i] for i in range(len(L6)) if y>>i&1]
else:
 solutions=[];start=time.time();certs=[];certindex={};assignment=[]
 for e in range(1<<m):
  ks=[i for i in range(m) if e>>i&1];rhs=b0
  for k in ks:rhs^=b1[k]
  for i,j in combinations(ks,2):rhs^=b2[i,j]
  cols=list(C2)
  for side in [1,2]:
   for i in range(n):
    c=CL[side,i,None]
    for k in ks:c^=CL[side,i,k]
    cols.append(c)
  piv={}
  for c in cols:
   while c:
    h=c.bit_length()-1
    if h in piv:c^=piv[h]
    else:piv[h]=c;break
  residual=rhs
  for h in sorted(piv,reverse=True):
   if residual>>h&1:residual^=piv[h]
  if residual==0:
   solutions.append(e);continue
  y=residual&-residual
  for h in sorted(piv):
   if (y&piv[h]).bit_count()%2:y^=1<<h
  assert (y&rhs).bit_count()%2==1 and all((y&c).bit_count()%2==0 for c in cols)
  if y not in certindex:certindex[y]=len(certs);certs.append(y)
  assignment.append(certindex[y])
 report['solutions']=solutions;report['cases']=1<<m;report['seconds']=time.time()-start
 assert not solutions and len(assignment)==1<<m
 package={'pencil':case,'n':n,'extras':m,'row_masks':L6,'certificates_hex':[hex(y) for y in certs],'assignment_certificate_index':assignment,'b0':hex(b0),'b1':[hex(x) for x in b1],'b2':[[i,j,hex(x)] for (i,j),x in b2.items()],'C2':[hex(x) for x in C2],'CL':[[side,i,k,hex(x)] for (side,i,k),x in CL.items()]}
 packed=zlib.compress(json.dumps(package,separators=(',',':')).encode(),9)
 (root/('CERTIFICADOS_'+case+'.json.zlib')).write_bytes(packed)
 report['distinct_infeasibility_certificates']=len(certs);report['certificate_bytes']=len(packed);report['certificate_sha256']=hashlib.sha256(packed).hexdigest()
(root/('VERIFICACAO_'+case+'_INDEPENDENTE.json')).write_text(json.dumps(report,indent=2));print(json.dumps(report))
