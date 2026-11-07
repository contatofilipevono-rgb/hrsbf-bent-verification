from pathlib import Path
import json,random
root=Path(__file__).parent;rng=random.Random(20261107)
def echelon(rows):
 piv={}
 for x in rows:
  while x:
   h=x.bit_length()-1
   if h in piv:x^=piv[h]
   else:piv[h]=x;break
 return piv
def nullspace(rows,n):
 p=echelon(rows);out=[]
 for f in range(n):
  if f in p:continue
  x=1<<f
  for h,row in sorted(p.items()):
   if (row&x).bit_count()%2:x^=1<<h
  assert all((row&x).bit_count()%2==0 for row in rows);out.append(x)
 return out
def mul(M,x):
 z=0
 while x:
  b=x&-x;z^=M[b.bit_length()-1];x^=b
 return z
def restrict(M,cols):
 return [sum(((mul(M,x)&y).bit_count()%2)<<j for j,y in enumerate(cols)) for x in cols]
def solve(rows,rhs,n):
 p={}
 for a,b in zip(rows,rhs):
  while a:
   h=a.bit_length()-1
   if h in p:a^=p[h][0];b^=p[h][1]
   else:p[h]=(a,b);break
  else:
   if b:return None
 x=0
 for h,(a,b) in sorted(p.items()):
  if (a&x).bit_count()%2!=b:x^=1<<h
 assert all((a&x).bit_count()%2==b for a,b in zip(rows,rhs));return x
def hyperplane(ell,n):
 p=ell.bit_length()-1
 return [(1<<j)^(((ell>>j)&1)<<p) for j in range(n) if j!=p]
def reduce(A,B):
 n=len(A);steps=0
 while n>=11:
  forms=[A,B,[a^b for a,b in zip(A,B)]];ranks=[len(echelon(M)) for M in forms];assert min(ranks)>=10
  radicals=[nullspace(M,n) for M,r in zip(forms,ranks) if r==10]
  if n==11:
   lines=[r[0] for r in radicals];ell=solve(lines,[1]*3,n)
   if ell is None:
    u,v,w=lines;assert len(set(lines))==3 and u^v^w==0
    alpha=mul(A,v);assert alpha==mul(B,u) and alpha
    z=1<<((alpha&-alpha).bit_length()-1)
    W=nullspace([alpha,mul(A,z),mul(B,z)],n);U=[u,v,z]
    assert len(W)==8 and len(echelon(U+W))==11
    assert all((mul(M,x)&y).bit_count()%2==0 for M in [A,B] for x in U for y in W)
    ar=restrict(A,W);br=restrict(B,W);assert [len(echelon(M)) for M in [ar,br,[a^b for a,b in zip(ar,br)]]]==[8]*3
    return {'end':11,'triangular':True,'steps':steps}
  else:
   ell=0
   for _ in range(1000):
    e=rng.randrange(1,1<<n)
    if all(any((e&x).bit_count()%2 for x in R) for R in radicals):ell=e;break
   assert ell
  cols=hyperplane(ell,n);A=restrict(A,cols);B=restrict(B,cols);n-=1;steps+=1
 assert n==10 and [len(echelon(M)) for M in [A,B,[a^b for a,b in zip(A,B)]]]==[10]*3
 return {'end':10,'triangular':False,'steps':steps}
def regular(p,off,n):
 m=p.bit_length()-1;A=[0]*n;B=[0]*n
 def edge(M,i,j):M[i]^=1<<j;M[j]^=1<<i
 for i in range(m):edge(A,off+i,off+m+i)
 for j in range(m-1):edge(B,off+j+1,off+m+j)
 for i in range(m):
  if p>>i&1:edge(B,off+i,off+2*m-1)
 return A,B,2*m
res=[]
for rec in json.loads((root/'classifica_nucleos_minimos.json').read_text())['cases']:
 n=20;A=[0]*n;B=[0]*n;o=0
 for p in rec['polynomial_bits']:
  a,b,k=regular(p,o,n);A=[x^y for x,y in zip(A,a)];B=[x^y for x,y in zip(B,b)];o+=k
 if rec['L1']:A[o]^=1<<(o+1);A[o+1]^=1<<o;B[o+1]^=1<<(o+2);B[o+2]^=1<<(o+1)
 cols=[1<<i for i in range(n)]
 for _ in range(100):
  i,j=rng.sample(range(n),2);cols[i]^=cols[j]
 assert len(echelon(cols))==n
 ans=reduce(restrict(A,cols),restrict(B,cols));ans['label']=rec['label'];res.append(ans)
for t in range(30):
 n=20;forms=[]
 for _ in range(2):
  M=[0]*n
  for i in range(n):
   for j in range(i+1,n):
    if rng.getrandbits(1):M[i]^=1<<j;M[j]^=1<<i
  forms.append(M)
 A,B=forms
 if min(len(echelon(M)) for M in [A,B,[a^b for a,b in zip(A,B)]])<10:continue
 ans=reduce(A,B);ans['random_control']=t;res.append(ans)
(root/'REDUCAO_HIPERPLANOS_CONTROLES.json').write_text(json.dumps({'seed':20261107,'tests':res,'scope':'Controls on 13 canonical embeddings and30 random pairs; general coverage comes from the written proof.'},indent=2));print('Controles exatos:',len(res),'reduções concluídas sem falhas.')
