from itertools import combinations
from collections import Counter
import math,numpy as np

def orbit(n,idx):
 out=set()
 for k in range(n):
  out.add(tuple(sorted((i+k)%n for i in idx)))
 return out

def quartic_phi(n, seeds):
 q=set()
 for idx in seeds:
  q.symmetric_difference_update(orbit(n,idx))
 return q

def make_c(n, quartics):
 pairs=list(combinations(range(n),2))
 ids={p:i for i,p in enumerate(pairs)}
 rows=[0]*len(pairs)
 for t in quartics:
  for p in combinations(t,2):
   v=tuple(x for x in t if x not in p)
   rows[ids[p]] ^= 1<<ids[v]
 return rows,pairs

def kernel(rows,d):
 a=rows[:]; piv=[]; k=0
 for j in range(d):
  ix=next((i for i in range(k,d) if (a[i]>>j)&1),None)
  if ix is None: continue
  a[k],a[ix]=a[ix],a[k]
  for i in range(d):
   if i!=k and (a[i]>>j)&1:a[i]^=a[k]
  piv.append(j); k+=1
 rem=[j for j in range(d) if j not in piv]
 b=[]
 for j in rem:
  v=1<<j
  for i,p in enumerate(piv):
   if (a[i]>>j)&1: v|=1<<p
  b.append(v)
 return k,b

def biv_rank(v,n,pairs):
 a=[0]*n
 for i,(u,w) in enumerate(pairs):
  if v>>i&1:a[u]|=1<<w; a[w]|=1<<u
 return kernel(a,n)[0]

def spectrum(n,seeds):
 q=quartic_phi(n,seeds)
 rows,pairs=make_c(n,q)
 rank,b=kernel(rows,len(pairs))
 spec=Counter()
 for mask in range(1,1<<len(b)):
  v=0
  for j in range(len(b)):
   if (mask>>j)&1:v^=b[j]
  spec[biv_rank(v,n,pairs)]+=1
 return len(q),rank,len(b),dict(spec)

q8=[(0,1,2,3),(0,1,2,5),(0,1,3,5)]
for n,q in [(8,q8),(10,[(0,1,2,5),(0,1,5,6)]),(12,[(0,1,2,3),(0,1,2,7),(0,1,3,7)])]:
 print('CONTRACTION',n,spectrum(n,q))

n=8
fqt=quartic_phi(n,q8)
mon=fqt.symmetric_difference(orbit(n,(0,1)))
vals=np.zeros(1<<n,dtype=np.int16)
for m in mon:
 mask=sum(1<<i for i in m)
 xs=np.arange(1<<n,dtype=np.int16)
 vals ^= (np.bitwise_and(xs,mask)==mask).astype(np.int16)
w=1-2*vals
for j in range(n):
 step=1<<j
 w=w.reshape(-1,2*step)
 l=w[:,:step].copy();r=w[:,step:].copy();w[:,:step]=l+r;w[:,step:]=l-r
 w=w.reshape(-1)
print('BENT8',len(mon),np.unique(np.abs(w),return_counts=True), 'weight',int(vals.sum()))

# count quartic orbit spectra all 1023
Qorbits={tuple(sorted(orbit(n,idx))) for idx in combinations(range(n),4)}
Qorbits=sorted(Qorbits,key=lambda s:s[0]);print('quartic orbits',len(Qorbits), 'sizes',[len(s) for s in Qorbits]);
C=Counter();G=Counter();C_all=Counter();names={}
for m in range(1,1<<len(Qorbits)):
 qq=set()
 for j,o in enumerate(Qorbits):
  if (m>>j)&1:qq.symmetric_difference_update(o)
 rr,pp=make_c(8,qq)
 r,b=kernel(rr,len(pp))
 C_all[(r,len(b))]+=1
 if len(b)>8: continue
 spec=Counter()
 for z in range(1,1<<len(b)):
  v=0
  for j in range(len(b)):
   if z>>j&1:v^=b[j]
  spec[biv_rank(v,8,pp)]+=1
 if 2 not in spec:
  C[(r,len(b))]+=1
  G[(r,tuple(sorted(spec.items())))]+=1
  names.setdefault((r,len(b)),m)
print('all quartic ranks',C_all)
print('Grassmann free counts',C)
print('Grassmann free spectra',G)
print('min sample masks',names)
