import numpy as np
from itertools import combinations
from numba import njit

def orbit(n,idx):
 return frozenset(tuple(sorted((i+k)%n for i in idx)) for k in range(n))

def ors(n,d):
 return sorted({orbit(n,idx) for idx in combinations(range(n),d)},key=lambda o:sorted(o)[0])

def anf_orbit_truth(n,orbit):
 T=np.zeros(1<<n,dtype=np.uint8)
 for idx in orbit:
  mask=sum(1<<i for i in idx)
  for x in range(1<<n):
   T[x]^=(x&mask)==mask
 return T

n=8
qs=ors(n,4)
low=ors(n,2)+ors(n,3)
qbasis=np.array([anf_orbit_truth(n,k) for k in qs])
lbasis=np.array([anf_orbit_truth(n,k) for k in low])
@njit
def construct(tb):
 out=np.zeros((1<<tb.shape[0],tb.shape[1]),dtype=np.uint8)
 for m in range(1,out.shape[0]):
  k=0
  while (m>>k)&1==0:k+=1
  prev=m^(1<<k)
  for x in range(tb.shape[1]):out[m,x]=out[prev,x]^tb[k,x]
 return out
qval=construct(qbasis); lval=construct(lbasis)
@njit
def bent(a,b):
 w=np.empty(256,dtype=np.int16)
 s=0
 for x in range(256):
  t=1-2*(a[x]^b[x]);w[x]=t;s+=t
 if s!=16 and s!=-16:return False
 for j in range(8):
  h=1<<j
  for start in range(0,256,2*h):
   for x in range(start,start+h):
    u=w[x];v=w[x+h];w[x]=u+v;w[x+h]=u-v
  # after each level, cap values at most 16? no earlier levels max 2**(j+1), always <=16 if j<=3, false after later but no necessary
 for x in range(256):
  if w[x]!=16 and w[x]!=-16:return False
 return True
@njit
def count_bent(qval,lval):
 exists=np.zeros(qval.shape[0],dtype=np.bool_)
 first=np.full(qval.shape[0],-1,dtype=np.int32)
 for m in range(1,qval.shape[0]):
  for k in range(lval.shape[0]):
   if bent(qval[m],lval[k]):
    exists[m]=True;first[m]=k;break
 return exists,first
res,first=count_bent(qval,lval)
print('n=8 quartic RS with RS <=3 bent completion',int(res.sum()))
print('first few completions',[(m,int(first[m])) for m in range(1,30) if res[m]])
np.savez('v2_bent_results.npz',qval=qval,qs=np.array([['.'.join(map(str,t)) for t in sorted(o)] for o in qs],dtype=object),is_bent=res,first=first)
