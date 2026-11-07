from pathlib import Path
import json,random
from verifica_reducao_hiperplanos import echelon,nullspace,solve,restrict,mul,regular
root=Path(__file__).parent;rng=random.Random(20261107)
def add(vs,mask):
 out=0
 for i,v in enumerate(vs):
  if mask>>i&1:out^=v
 return out
def paired_blocks(A,B):
 n=len(A)
 if n==0:return []
 assert len(echelon(A))==n
 # A and B are symmetric: row bitsets equal column bitsets.
 T=[solve(A,[(B[i]>>j)&1 for i in range(n)],n) for j in range(n)]
 powers=[[1<<i for i in range(n)]];piv={};poly=None
 for k in range(n+1):
  P=powers[-1];flat=sum(col<<(n*j) for j,col in enumerate(P));rel=1<<k
  while flat:
   h=flat.bit_length()-1
   if h in piv:flat^=piv[h][0];rel^=piv[h][1]
   else:piv[h]=(flat,rel);break
  else:poly=rel;break
  powers.append([add(T,col) for col in P])
 assert poly is not None;d=poly.bit_length()-1
 for x in range(1,1<<n):
  U=[];z=x
  for _ in range(d):U.append(z);z=add(T,z)
  if len(echelon(U))==d:break
 else:raise AssertionError('No vector of maximal cyclic degree')
 assert all((mul(A,u)&v).bit_count()%2==0 for u in U for v in U)
 y=solve([mul(A,u) for u in U],[0]*(d-1)+[1],n);assert y is not None
 Y=[];z=y
 for _ in range(d):Y.append(z);z=add(T,z)
 assert len(echelon(Y))==d and all((mul(A,u)&v).bit_count()%2==0 for u in Y for v in Y)
 H=[sum(((mul(A,u)&v).bit_count()%2)<<j for j,v in enumerate(Y)) for u in U];assert len(echelon(H))==d
 dual=[add(Y,solve(H,[int(i==j) for i in range(d)],d)) for j in range(d)]
 basis=U+dual;assert len(echelon(basis))==2*d
 ar=restrict(A,basis);br=restrict(B,basis)
 for i in range(2*d):
  assert ar[i]==1<<(i+d if i<d else i-d)
 # T on the cyclic half is the companion of poly; compare B to its transpose off-diagonal.
 C=[1<<(i+1) for i in range(d-1)]+[poly^(1<<d)]
 for i in range(d):
  for j in range(d):assert ((br[i]>>(d+j))&1)==((C[i]>>j)&1)
 W=nullspace([mul(A,x) for x in basis],n);assert len(W)==n-2*d
 assert len(echelon(basis+W))==n
 A2=restrict(A,W);B2=restrict(B,W)
 return [poly]+paired_blocks(A2,B2)
res=[]
for rec in json.loads((root/'classifica_nucleos_minimos.json').read_text())['cases']:
 n=rec['n']-(3 if rec['L1'] else 0);A=[0]*n;B=[0]*n;o=0
 for p in rec['polynomial_bits']:
  a,b,k=regular(p,o,n);A=[x^y for x,y in zip(A,a)];B=[x^y for x,y in zip(B,b)];o+=k
 cols=[1<<i for i in range(n)]
 for _ in range(40):
  i,j=rng.sample(range(n),2);cols[i]^=cols[j]
 blocks=paired_blocks(restrict(A,cols),restrict(B,cols))
 assert sum(p.bit_length()-1 for p in blocks)*2==n
 res.append({'label':rec['label'],'cyclic_polynomials':blocks})
(root/'PAREAMENTO_CICLICO_CONTROLES.json').write_text(json.dumps(res,indent=2));print('Pareamento cíclico e blocos companheiros:13/13 controles passaram.')
