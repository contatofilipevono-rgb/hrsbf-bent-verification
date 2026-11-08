"""Verificacao independente, sem solver, do contraexemplo Astra G7.
Somente biblioteca padrao. A representacao interna usa frozensets de indices.
"""
from itertools import combinations
from pathlib import Path
import json
ROOT=Path(__file__).resolve().parent
D_MASKS=[54,60,75,83,147,149,166,169,340,360,418,424,452,547,553,554,568,645,649,652,660,833,840,912]
W_MASKS=[351,415,575,830,855,861,911,919,923]
def mono(mask):return frozenset(i for i in range(10) if mask&(1<<i))
def form(masks):return {mono(m) for m in masks}
def mask(s):return sum(1<<i for i in s)
def mul(a,b,ext=False):
 out=set()
 for s in a:
  for t in b:
   if ext and s&t:continue
   u=s|t
   out.symmetric_difference_update({u})
 return out
def pairs(a,degree):
 out=set()
 for s,t in combinations(a,2):
  u=s|t
  if len(u)==degree:out.symmetric_difference_update({u})
 return out
A=form([40,132,320,528]);B=form([20,40,132,384,520]);O=form([72,80,144])
x1=form([1]);x2=form([2]);x12=form([3]);v1=form([128]);v2=form([32]);u1=form([512]);u2=set()
At=A^mul(x1,v1,True)^mul(x2,v2,True);Bt=B^mul(x1,u1,True)
D=mul(At,Bt,True)^mul(x12,O,True)
assert D==form(D_MASKS)
assert not mul(mul(A,B,True),O,True)
phi1=mul(A,u1,True)^mul(B,v1,True);phi2=mul(B,v2,True)
omega=O^mul(v2,u1,True)
assert D==mul(A,B,True)^mul(x1,phi1,True)^mul(x2,phi2,True)^mul(x12,omega,True)
assert not pairs(D,8)
counts={}
for s,t in combinations(D,2):
 if not s&t:counts[mask(s|t)]=counts.get(mask(s|t),0)+1
assert sorted(counts)==[507,509,703,735,887,893,894,987,989,999,1005,1006,1020]
assert set(counts.values())=={2}
def rank(vectors):
 piv={}
 for v in vectors:
  while v:
   h=v.bit_length()-1
   if h not in piv:piv[h]=v;break
   v^=piv[h]
 return len(piv)
linear_columns=[sum(1<<mask(s) for s in mul(D,{frozenset([i])},True)) for i in range(10)]
assert rank(linear_columns)==10
form_ranks=[]
for Q in [A,B]:
 rows=[sum(1<<j for j in range(2,10) if j!=i and frozenset([i,j]) in Q) for i in range(2,10)]
 form_ranks.append(rank(rows))
assert form_ranks==[8,6]
D0=mul(A,B,True)^mul(x12,O,True)
R0=form([19,44,67,84,104,168,196,276,324,388,552])
assert mul(D0,R0,True)==pairs(D0,7)
W=form(W_MASKS);rhs=pairs(D,7)
assert len(W&rhs)%2==1
# Toutes les 120 colonnes: aucun solveur ni eliminations reutilises.
columns=0
for c in combinations(range(10),3):
 assert len(W&mul(D,{frozenset(c)},True))%2==0
 columns+=1
assert columns==120
row_equations={}
for u in sorted(W,key=mask):
 row_equations[str(mask(u))]={'cubics':sorted(mask(u-d) for d in D if d<=u),'rhs':int(u in rhs)}
# Autre controle via le relevement entier, table de verite puis Mobius.
def lift(masks,n):
 coeff=[sum((v&m)==m for m in masks)%2 for v in range(1<<n)]
 values=coeff[:]
 for bit in range(n):
  for m in range(1<<n):
   if m>>bit&1:coeff[m]-=coeff[m^(1<<bit)]
 return values,coeff
_,co=lift(D_MASKS,10)
assert all(co[m]%4==0 for m in range(1024) if m.bit_count()==8)
assert all((co[m]//2)%2==int(mono(m) in rhs) for m in range(1024) if m.bit_count()==7)
# Controle positif exige: completion I6 C2, profils et 43180 flats.
positive=[15,51,53,60,178,204,240,13,14,21,42,3,10,12,17,34,130,132]
F=form(positive)
assert all(not pairs(F,k) for k in [6,7,8])
values,co=lift(positive,8)
assert all(co[m]%4==0 for m in range(256) if m.bit_count()>=6)
flats=0
for piv in combinations(range(8),6):
 slots=[(i,j) for i,p in enumerate(piv) for j in range(p+1,8) if j not in piv]
 for bits in range(1<<len(slots)):
  bs=[1<<p for p in piv]
  for h,(i,j) in enumerate(slots):
   if bits>>h&1:bs[i]^=1<<j
  span=[0]
  for v in bs:span += [z^v for z in span]
  unseen=set(range(256))
  while unseen:
   off=min(unseen);coset=[off^z for z in span]
   assert sum(values[z] for z in coset)%4==0
   unseen.difference_update(coset);flats+=1
assert flats==43180
# Controle negativo: a formula falsa de Leibniz.
def sigma(f):
 ans=set()
 for s in f:
  for i in s:ans.symmetric_difference_update({s-{i}})
 return ans
P=form([15]);Q=form([17]);overlap={s for s in mul(P,Q) if len(s)==5}
false_rhs=mul(sigma(P),Q,True)^mul(P,sigma(Q),True)^sigma(mul(P,Q,True))
assert not mul(P,Q,True) and overlap==form([31]) and not false_rhs
out={'counterexample_verified':True,'gamma2_zero':True,'disjoint_union_multiplicities':counts,'A0_B0_ranks':form_ranks,'Delta_wedge_linear_rank':10,'zero_Phi_same_core_G7_solution_verified':True,'all_cubic_columns_checked':columns,'dual_rhs_parity':1,'dual_rows':row_equations,'integer_lift_independently_checked':True,'positive_I6_control_all_flats':flats,'false_Leibniz_control_detected':True}
(ROOT/'ASTRA_VERIFICACAO_INDEPENDENTE_G7_07NOV.json').write_text(json.dumps(out,indent=2),encoding='utf-8')
print(json.dumps(out,indent=2))
