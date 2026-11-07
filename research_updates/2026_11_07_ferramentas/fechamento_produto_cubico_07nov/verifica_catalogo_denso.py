from pathlib import Path
from itertools import combinations
import numpy as np,json
root=Path(__file__).parent;catalog=json.loads((root/'classifica_nucleos_minimos.json').read_text())['cases']
def rank(M):
 M=M.copy();r=0
 for j in range(M.shape[1]):
  hits=np.flatnonzero(M[r:,j])
  if not len(hits):continue
  k=r+int(hits[0]);M[[r,k]]=M[[k,r]];ii=np.flatnonzero(M[:,j]);ii=ii[ii!=r];M[ii]^=M[r];r+=1
  if r==M.shape[0]:break
 return r
res=[]
for rec in catalog:
 n=rec['n'];A=np.zeros((n,n),dtype=np.uint8);B=A.copy();off=0
 for p in rec['polynomial_bits']:
  m=p.bit_length()-1
  for i in range(m):A[off+i,off+m+i]=A[off+m+i,off+i]=1
  for j in range(m-1):B[off+j+1,off+m+j]=B[off+m+j,off+j+1]=1
  for i in range(m):
   if p>>i&1:B[off+i,off+2*m-1]=B[off+2*m-1,off+i]=1
  off+=2*m
 if rec['L1']:A[off,off+1]=A[off+1,off]=1;B[off+1,off+2]=B[off+2,off+1]=1
 assert [rank(M) for M in [A,B,A^B]]==[10,10,10]
 triples=list(combinations(range(n),3));sevens=list(combinations(range(n),7));four={}
 for S in combinations(range(n),4):
  val=0
  for a,b in combinations(S,2):
   c,d=[i for i in S if i not in (a,b)];val^=int(A[a,b]&B[c,d])
  four[frozenset(S)]=val
 M=np.zeros((len(sevens),len(triples)),dtype=np.uint8)
 for i,S in enumerate(sevens):
  ss=frozenset(S)
  for j,t in enumerate(triples):
   if all(x in ss for x in t):M[i,j]=four[ss-frozenset(t)]
 span=np.zeros((len(triples),2*n),dtype=np.uint8)
 for i,t in enumerate(triples):
  for a in t:
   b,c=[x for x in t if x!=a];span[i,a]=A[b,c];span[i,n+a]=B[b,c]
 assert not np.any((M.astype(np.int64)@span.astype(np.int64))%2)
 ker=len(triples)-rank(M);sp=rank(span)
 assert (ker,sp)==(rec['kernel'],rec['span'])
 res.append({'label':rec['label'],'kernel':ker,'span':sp,'match':True})
(root/'CATALOGO_VERIFICACAO_DENSA.json').write_text(json.dumps(res,indent=2));print('13/13 representantes conferidos por matrizes densas independentes.')
