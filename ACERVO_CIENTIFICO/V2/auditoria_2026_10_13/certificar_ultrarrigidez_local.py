#!/usr/bin/env python3
"""Auditoria finita, autônoma, da semente V2 sobre GF(2).
Certifica o grupo Aut(D^4 f), G_{<=2}(f) e estabilizadores.
Sem dependências externas; execute: python3 certificar_ultrarrigidez_local.py
É um certificado COMPUTACIONAL, não uma formalização Lean.
"""
from itertools import combinations
from collections import Counter
from time import time
import hashlib, json
def orbit(n, idx):
    out = set()
    for k in range(n):
        out.add(tuple(sorted((i+k)%n for i in idx)))
    return out

def kernel(rows, d):
    a = rows[:]; piv = []; k = 0
    for j in range(d):
        ix = next((i for i in range(k, len(a)) if (a[i] >> j) & 1), None)
        if ix is None: continue
        a[k], a[ix] = a[ix], a[k]
        for i in range(len(a)):
            if i != k and (a[i] >> j) & 1: a[i] ^= a[k]
        piv.append(j); k += 1
    rem = [j for j in range(d) if j not in piv]
    basis = []
    for j in rem:
        v = 1 << j
        for i, pivot in enumerate(piv):
            if (a[i] >> j) & 1: v |= 1 << pivot
        basis.append(v)
    return k, basis

def make_c(n, quartics):
    prs = list(combinations(range(n), 2))
    ids = {p: i for i,p in enumerate(prs)}
    rows = [0]*len(prs)
    for mon in quartics:
        for p in combinations(mon, 2):
            v = tuple(t for t in mon if t not in p)
            rows[ids[p]] ^= 1 << ids[v]
    return rows,prs
N=8
q=set()
for tup in [(0,1,2,3),(0,1,2,5),(0,1,3,5)]: q.symmetric_difference_update(orbit(8,tup))
assert len(q)==24

def det4(columns):
 a=list(columns);r=0
 for b in range(4):
  ix=next((i for i in range(r,4) if (a[i]>>b)&1),None)
  if ix is None:return 0
  a[ix],a[r]=a[r],a[ix]
  for j in range(r+1,4):
   if (a[j]>>b)&1:a[j]^=a[r]
  r+=1
 return 1

def ph(vs):
 z=0
 for s in q:
  z^=det4([sum(((v>>i)&1)<<j for j,i in enumerate(s)) for v in vs])
 return z

base=[(1<<i)|(1<<(i+4)) for i in range(4)]+[1<<i for i in range(4)]
quads=list(combinations(range(8),4))
qv={s:ph([base[i] for i in s]) for s in quads}


pairs=list(combinations(range(4),2))
M=[[qv[tuple(sorted((a,b,c+4,d+4)))] for c,d in pairs] for a,b in pairs]





def rank_columns(cols, n=4):
 basis=[0]*n
 for col in cols:
  x=col
  while x:
   p=x.bit_length()-1
   if basis[p]:x^=basis[p]
   else:basis[p]=x;break
 return sum(v!=0 for v in basis)

def gl4():
 return [t for t in __import__('itertools').product(range(1,16),repeat=4) if rank_columns(t)==4]

def wedge(u,v):
 z=0
 for i,(a,b) in enumerate(pairs):
  z|=(((u>>a&1)*(v>>b&1))^((u>>b&1)*(v>>a&1)))<<i
 return z

def w2(P):
 return [wedge(P[i],P[j]) for i,j in pairs]

def apply(T,v):
 z=0
 for j in range(len(T)):
  if v>>j&1:z^=T[j]
 return z


Mrow=[sum(v<<i for i,v in enumerate(line)) for line in M]
MTrow=[sum(M[i][j]<<i for i in range(6)) for j in range(6)]
print('rank M',kernel(Mrow,6)[0])
KL=kernel(MTrow,6)[1]
KR=kernel(Mrow,6)[1]
print('KL',KL,'KR',KR)
t0=time()
ALL4=gl4()
print('all gl4',len(ALL4),'generated',time()-t0)
PC=[];QC=[]
for P in ALL4:
 w=w2(P)
 if all(apply(w,v) in [0,KL[0],KL[1],KL[0]^KL[1]] for v in KL):PC.append((P,w))
 if all(apply(w,v) in [0,KR[0],KR[1],KR[0]^KR[1]] for v in KR):QC.append((P,w))
print('preserve kernels counts',len(PC),len(QC))

def dot(x,y):return (x&y).bit_count()&1
def Mfunc(u,v,s,t):
 w=wedge(u,v)
 right=wedge(s,t)
 return sum(dot(Mrow[i],right) for i in range(6) if w>>i&1)&1

def wedge3(a,b,c):
 trip=list(combinations(range(4),3))
 ans=0
 for k,(i,j,h) in enumerate(trip):

  vals=[sum(((v>>l)&1)<<idx for idx,l in enumerate((i,j,h))) for v in (a,b,c)]
  # determinant 3x3
  mat=vals[:]
  parity=1
  for bit in range(3):
   p=next((ii for ii in range(bit,3) if mat[ii]>>bit&1),None)
   if p is None: parity=0;break
   mat[bit],mat[p]=mat[p],mat[bit]
   for ii in range(bit+1,3):
    if mat[ii]>>bit&1:mat[ii]^=mat[bit]
  ans|=parity<<k
 return ans
Nrow=[sum(qv[(i,)+(tuple(x+4 for x in t))]<<k for k,t in enumerate(combinations(range(4),3))) for i in range(4)]
def Nfunc(u,s,t,v):
 b=wedge3(s,t,v)
 return sum(dot(Nrow[i],b) for i in range(4) if u>>i&1)&1

# find pairs matching M exactly
valid=[]
t0=time()
for P,WP in PC:
 lrows=[]
 for w in WP:
  lr=0
  for i in range(6):
   if w>>i&1:lr^=Mrow[i]
  lrows.append(lr)
 for Q,WQ in QC:
  ok=True
  for i in range(6):
   if not ok:break
   for j in range(6):
    if dot(lrows[i],WQ[j]) != M[i][j]:ok=False;break
  if ok:valid.append((P,Q))
print('valid P,Q for (2,2) part',len(valid),'time',round(time()-t0,2))

# full 1,3 and 0,4 form: linear system for Y of 16 unknowns
Trip=list(combinations(range(4),3))
def eqs_for_pair(P,Q):
 rows=[]
 for i in range(4):
  for a,b,c in Trip:
   desired=qv[(i,a+4,b+4,c+4)]
   base=Nfunc(P[i],Q[a],Q[b],Q[c])
   mask=0
   for j,t in enumerate((a,b,c)):
    z=[a,b,c]; oth=[x for x in z if x!=t]
    for h in range(4):
     if Mfunc(P[i],1<<h,Q[oth[0]],Q[oth[1]]):mask ^= 1<<(4*t+h)
   rows.append((mask,desired^base))
 return rows

def linear_solve(rows,n=16):
 rows=[l|(b<<n) for l,b in rows]
 rank=0;pivots=[]
 for j in range(n):
  r=next((i for i in range(rank,len(rows)) if rows[i]>>j&1),None)
  if r is None:continue
  rows[rank],rows[r]=rows[r],rows[rank]
  for i in range(len(rows)):
   if i!=rank and rows[i]>>j&1:rows[i]^=rows[rank]
  pivots.append(j);rank+=1
 for v in rows[rank:]:
  if v>>n&1:return None
 x=0
 for i,p in enumerate(pivots):
  if rows[i]>>n&1:x|=1<<p
 basis=[]
 for j in range(n):
  if j not in pivots:
   z=1<<j
   for i,p in enumerate(pivots):
    if rows[i]>>j&1:z|=1<<p
   basis.append(z)
 return x,basis

def check_zero_four(Q,Y):
 val=1 # desired target
 # base part original phi on Q columns: one E4, coefficient 1
 val ^= (rank_columns(Q)==4)
 for j in range(4):
  z=[i for i in range(4) if i!=j]
  val ^= Nfunc(Y[j],Q[z[0]],Q[z[1]],Q[z[2]])
 for j,k in combinations(range(4),2):
  z=[i for i in range(4) if i not in (j,k)]
  val ^= Mfunc(Y[j],Y[k],Q[z[0]],Q[z[1]])
 return val==0

valid_pqs=[]; AUT=[]; stats=Counter();zt=0
t0=time()
for P,Q in valid:
 sol=linear_solve(eqs_for_pair(P,Q))
 if sol is None:
  stats['1,3 inconsistent']+=1;continue
 x0,basis=sol
 stats[('1,3 dim',len(basis))]+=1
 cnt=0
 for mask in range(1<<len(basis)):
  y=x0
  for k,z in enumerate(basis):
   if mask>>k&1:y^=z
  Y=[(y>>(4*j))&15 for j in range(4)]
  if check_zero_four(Q,Y):
   AUT.append((P,Q,tuple(Y)));cnt+=1
 if cnt:valid_pqs.append((P,Q,cnt))
 stats[('surviving Y',cnt)]+=1
print('AUT result',len(AUT),'pqs',len(valid_pqs),'stats',stats,'time',round(time()-t0,2))

# f scalar seed (with quadratic orbit 01) and cubic coordinate signatures
mon=q.copy(); mon.symmetric_difference_update(orbit(8,(0,1)))
MON=[sum(1<<i for i in ss) for ss in mon]
F=[sum((x&m)==m for m in MON)&1 for x in range(256)]
assert sum(F)==120

def anf_cubic(v):
 v=v.copy()
 for i in range(8):
  b=1<<i
  for m in range(256):
   if m&b:v[m]^=v[m^b]
 return sum(v[m]<<k for k,m in enumerate(range(256)) if m.bit_count()==3)

cubics=[i for i in range(256) if i.bit_count()==3]
def cube_sig(v):
 v=v.copy()
 for i in range(8):
  b=1<<i
  for m in range(256):
   if m&b:v[m]^=v[m^b]
 return sum(v[m]<<k for k,m in enumerate(cubics))
translations={cube_sig([F[x^b] for x in range(256)]):b for b in range(256)}
print('translation cubics distinct',len(translations))

def make_A_std(P,Q,Y):
 def act(x):
  u=x>>4
  e=(x&15)^u
  U=apply(P,u)^apply(Y,e)
  E=apply(Q,e)
  return (U^E)|(U<<4)
 return tuple(act(1<<i) for i in range(8))

def eval_A(A,x):return apply(A,x)

def stab_e0(A):
 return ((A[0]&1)==1) and all((A[i]&1)==0 for i in range(1,8))
def stab_w01(A):
 for i,j in combinations(range(8),2):
  if (((A[i]>>0&1)*(A[j]>>1&1))^((A[j]>>0&1)*(A[i]>>1&1))) != (i==0 and j==1):return False
 return True

G=[];other=Counter();t0=time()
for p,q_,y in AUT:
 A=make_A_std(p,q_,y)
 mapped=[F[apply(A,x)] for x in range(256)]
 c=cube_sig(mapped)
 if c in translations:
  b=translations[c];a0=apply(A,b)
  G.append((A,a0,b, mapped==F))
  other[(a0==0,mapped==F)]+=1
print('G_le2',len(G),'details',other,'time',round(time()-t0,2))
print('stabilizer e0',sum(stab_e0(A) for A,*_ in G),'w01',sum(stab_w01(A) for A,*_ in G))
print('translation nonzero',[(a,b) for A,a,b,_ in G if a!=0][:5])
assert len(G)==40 and all(a==0 and ok for A,a,b,ok in G)
assert sum(stab_e0(A) for A,*_ in G)==1
assert sum(stab_w01(A) for A,*_ in G)==1

# Additional exact property graph isomorphic signature to analyze unassuming possible symmetry


def mulA(A,B):return tuple(apply(A,B[i]) for i in range(8))
ID=tuple(1<<i for i in range(8))
def g_order(A):
 C=ID
 for i in range(1,41):
  C=mulA(A,C)
  if C==ID:return i
 raise RuntimeError('not order <= 40')
countorders=Counter(g_order(A) for A,*_ in G)
print('G element orders',dict(countorders))
P5=next(A for A,*_ in G if g_order(A)==5)
P5inv=next(A for A,*_ in G if mulA(A,P5)==ID)
rot=lambda x: ((x<<1)&255)|(x>>7)
S=tuple(rot(1<<i) for i in range(8))
print('rotate order',g_order(S),'is member',S in [g[0] for g in G]);
for k in (1,2,3,4):
 p=ID
 for j in range(k):p=mulA(P5,p)
 if mulA(S,P5)==mulA(p,S):print('S P S^-1 = P^',k)
# intrinsic U recovered from rank4 bivectors in ker C_phi
qrows,pr=make_c(8,q)
_,kbasis=kernel(qrows,len(pr))
rank4=[]
def biv_mat(b):
 RR=[0]*8
 for ix,(i,j) in enumerate(pr):
  if b>>ix&1:RR[i]^=1<<j;RR[j]^=1<<i
 return RR
for t in range(1,1<<len(kbasis)):
 v=apply(kbasis,t)
 mat=biv_mat(v)
 if kernel(mat,8)[0]==4:
  rank4.append(v)
  ker4=kernel(mat,8)[1]
  expect=set(base[:4])
  assert len(ker4)==4 and all(((z&15)==(z>>4)) for z in ker4)
assert len(rank4)==3
# centroid dimension: for every a,b,c,d, phi(Pa,b,c,d)=phi(a,Pb,c,d)
T=[[0]*8 for _ in range(8)]
for (a,b,c,d),v in qv.items():
 if v:pass
# use initial quartic coefficients in standard basis
qset={tuple(sorted(z)):1 for z in q}
def qb(a,b,c,d):return int(tuple(sorted((a,b,c,d))) in qset) if len({a,b,c,d})==4 else 0
centrows=[]
for a in range(8):
 for b in range(8):
  for c in range(8):
   for d in range(8):
    L=0
    for p in range(8):
     if qb(p,b,c,d):L^=1<<(8*a+p)
     if qb(a,p,c,d):L^=1<<(8*b+p)
    if L:centrows.append(L)
# gaussian rank not fixed d rows
basis=[0]*64
for row in centrows:
 x=row
 while x:
  i=x.bit_length()-1
  if basis[i]:x^=basis[i]
  else:basis[i]=x;break
print('centroid constraint rank',sum(bool(t) for t in basis),'dimension',64-sum(bool(t) for t in basis))

# Illustrate a subtle but important proof correction: pure quartic f may have nonzero D^3 at origin.
u=(1<<0)|(1<<3); v=(1<<1); w=(1<<2)
third_at_zero = 0
for mask in range(8):
    x = (u if mask&1 else 0) ^ (v if mask&2 else 0) ^ (w if mask&4 else 0)
    third_at_zero ^= F[x]
assert third_at_zero == 1

# Extract deterministic hashes from matrix columns for reproducible certificates.
Aut_std = sorted(make_A_std(p,q_,y) for p,q_,y in AUT)
G_std = sorted(A for A,*_ in G)
assert len(set(Aut_std)) == 1920 and len(set(G_std)) == 40
assert all(S in G_std for S in [ID, tuple(rot(1<<i) for i in range(8))])
def digest(arr):
    return hashlib.sha256(b''.join(bytes(t) for t in arr)).hexdigest()
summary = {
 'seed_quartic_monomials': len(q),
 'contraction_rank': kernel(qrows,len(pr))[0],
 'contraction_nullity':len(kbasis),
 'rank_4_kernel_elements':len(rank4),
 'centralizer_dim':64-sum(bool(t) for t in basis),
 'GL4_size':len(ALL4),
 'P_candidates':len(PC),'Q_candidates':len(QC),
 'PQ_22_compatible':len(valid),
 'PQ_13_solvable':len(valid_pqs),
 'Aut_phi_size':len(AUT),
 'Aut_phi_sha256':digest(Aut_std),
 'G_le2_size':len(G),
 'G_le2_sha256':digest(G_std),
 'G_le2_stab_e0':sum(stab_e0(A) for A,*_ in G),
 'G_le2_stab_e0_wedge_e1':sum(stab_w01(A) for A,*_ in G),
 'G_le2_orders':dict(countorders),
 'G_le2_all_zero_translation':all(a==0 for A,a,b,ok in G),
 'G_le2_all_exact_f_symmetry':all(ok for A,a,b,ok in G),
 'cubic_translation_signatures':len(translations),
 'third_derivative_f_at_origin_nonzero_example':third_at_zero,
}
assert summary['centralizer_dim']==1 and summary['contraction_rank']==22
assert summary['P_candidates']==360 and summary['Q_candidates']==360
assert summary['PQ_22_compatible']==1080 and summary['PQ_13_solvable']==60
assert summary['Aut_phi_size']==1920 and summary['G_le2_size']==40
print('CERTIFICATE_SUMMARY',json.dumps(summary,sort_keys=True,ensure_ascii=False))