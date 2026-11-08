from itertools import combinations
from pathlib import Path
import json,random

def prod(A,B,ext=False):
 r=set()
 for a in A:
  for b in B:
   if ext and a&b:continue
   c=a|b
   if c in r:r.remove(c)
   else:r.add(c)
 return r
def sigma(A):
 r=set()
 for a in A:
  for i in range(a.bit_length()):
   if a>>i&1:
    c=a^(1<<i)
    if c in r:r.remove(c)
    else:r.add(c)
 return r
def tau(A,d):
 r=set()
 for a,b in combinations(A,2):
  c=a|b
  if c.bit_count()!=d:continue
  if c in r:r.remove(c)
  else:r.add(c)
 return r
def pack(A):return sum(1<<m for m in A)
def columns_nullspace(cols):
 piv={};ker=[]
 for i,x in enumerate(cols):
  rel=1<<i
  while x:
   h=x.bit_length()-1
   if h not in piv:piv[h]=(x,rel);break
   x^=piv[h][0];rel^=piv[h][1]
  else:ker.append(rel)
 return piv,ker
def solve(cols,rhs):
 piv,ker=columns_nullspace(cols);ans=0
 while rhs:
  h=rhs.bit_length()-1
  if h not in piv:return None,ker
  rhs^=piv[h][0];ans^=piv[h][1]
 return ans,ker
def mons(n,k):return [sum(1<<i for i in c) for c in combinations(range(n),k)]
def subspaces(n,k):
 for piv in combinations(range(n),k):
  slots=[(i,j) for i,p in enumerate(piv) for j in range(p+1,n) if j not in piv]
  for s in range(1<<len(slots)):
   bs=[1<<p for p in piv]
   for h,(i,j) in enumerate(slots):
    if s>>h&1:bs[i]^=1<<j
   yield bs

out={}
# Counterexample to the claimed Leibniz/overlap identity, with P*Omega=0.
P={15};Omega={17};lhs={m for m in prod(P,Omega) if m.bit_count()==5}
rhs=prod(sigma(P),Omega,True)^prod(P,sigma(Omega),True)^sigma(prod(P,Omega,True))
assert not prod(P,Omega,True) and lhs=={31} and rhs==set()
out['false_overlap_identity']={'P':[15],'Omega':[17],'P_wedge_Omega':[],'lhs':sorted(lhs),'rhs':sorted(rhs)}
# Counterexample to the claimed integer degree <=4 of a product of four
# Boolean linear forms: (a XOR b)*c*d*e has integer degree five.
out['false_integer_degree_claim']={'ANF':[29,30],'integer_coefficients':{'29':1,'30':1,'31':-2}}

output_root=Path(__file__).resolve().parent
root=output_root/'argon_duas_formas_I6'
certs=json.loads((root/'CERTIFICADOS.json').read_text(encoding='utf-8'))
for name,c in certs.items():
 if not isinstance(c,dict) or 'Delta_masks' not in c:continue
 n=c['n'];D=set(c['Delta_masks']);deg=7 if name.startswith('CERT_1_') else 6
 w=set(c[f'vetor_dual_w_masks_grau{deg}'])
 M3=mons(n,3);M2=mons(n,2)
 if deg==7:
  assert all(len(w&prod(D,{m},True))%2==0 for m in M3)
  assert len(w&tau(D,7))%2==1
  out['certificate1']='dual certificate independently verified on all cubic columns'
 else:
  R0=set(c['R3_solucao_grau7_masks'])
  assert not (prod(D,R0,True)^tau(D,7))
  assert all(len(w&prod(D,{m},True))%2==0 for m in M2)
  rhs=tau(D^R0,6);assert len(w&rhs)%2==1
  At={12,48,130};Bt={48,192,5}
  Kspan=[prod(Q,{1<<i},True) for Q in [At,Bt] for i in range(8)]
  valid=[k for k in Kspan if not prod(D,k,True)]
  assert all(len(w&(tau(D^R0^k,6)^rhs))%2==0 for k in valid)
  assert all(len(w&(tau(k^l,6)^tau(k,6)^tau(l,6)))%2==0 for k,l in combinations(valid,2))
  _,rels=columns_nullspace([pack(prod(D,k,True)) for k in Kspan])
  inter=[]
  for rel in rels:
   v=set()
   for i,k in enumerate(Kspan):
    if rel>>i&1:v^=k
   assert not prod(D,v,True)
   inter.append(v)
  rank=lambda vs:len(columns_nullspace(vs)[0])
  lin=[i for i,k in enumerate(inter) if len(w&(tau(D^R0^k,6)^rhs))%2]
  cross=[(i,j) for i,j in combinations(range(len(inter)),2) if len(w&(tau(inter[i]^inter[j],6)^tau(inter[i],6)^tau(inter[j],6)))%2]
  out['certificate2_restricted_span']={'individually_valid_generators_span_dimension':rank([pack(k) for k in valid]),'true_span_kernel_intersection_dimension':rank([pack(k) for k in inter]),'true_intersection_linear_failures':lin,'true_intersection_cross_failures':cross,'valid_for_declared_span_intersection':not lin and not cross}
  cols=[pack(prod(D,{m},True)) for m in M3]
  _,ker=columns_nullspace(cols)
  examples=[];directions=[]
  for v in ker:
   R={M3[i] for i in range(len(M3)) if v>>i&1}
   directions.append(R)
   assert not prod(D,R,True)
   if len(w&(tau(D^R0^R,6)^rhs))%2:
    examples.append(sorted(R))
  cross_fail=[]
  for i,j in combinations(range(len(directions)),2):
   cross=tau(directions[i]^directions[j],6)^tau(directions[i],6)^tau(directions[j],6)
   if len(w&cross)%2:cross_fail.append([i,j])
  out['certificate2_full_kernel']={'kernel_dimension':len(ker),'linear_tests':len(directions),'quadratic_cross_tests':len(directions)*(len(directions)-1)//2,'certificate_universal_over_full_kernel':not examples and not cross_fail,'kernel_direction_breaking_dual':examples[:1],'quadratic_cross_failures':cross_fail[:3]}
  if cross_fail:
   i,j=cross_fail[0];R=R0^directions[i]^directions[j]
   assert not (prod(D,R,True)^tau(D,7))
   assert len(w&tau(D^R,6))%2==0
   out['certificate2_full_kernel']['explicit_joint_direction']={'i':i,'j':j,'directions':[sorted(directions[i]),sorted(directions[j])],'R3':sorted(R),'degree7_passes':True,'dual_rhs_parity':0}
  rng2=random.Random(7142026);completion=None
  quadcols=[pack(prod(D,{m},True)) for m in M2]
  sparse=[(i,j) for i,j in combinations(range(len(directions)),2)]
  for trial in range(len(sparse)+2000):
   R=set(R0)
   if trial<len(sparse):
    i,j=sparse[trial];R^=directions[i]^directions[j]
   else:
    for direction in directions:
     if rng2.getrandbits(1):R^=direction
   sol,_=solve(quadcols,pack(tau(D^R,6)))
   if sol is None:continue
   R2={M2[i] for i in range(len(M2)) if sol>>i&1};F=D^R^R2
   assert all(not tau(F,k) for k in [6,7,8])
   values=[sum((v&m)==m for m in F)%2 for v in range(1<<n)];coeff=values[:]
   for bit in range(n):
    for m in range(1<<n):
     if m>>bit&1:coeff[m]-=coeff[m^(1<<bit)]
   assert all(coeff[m]%4==0 for m in range(1<<n) if m.bit_count()>=6)
   checked=0
   for basis in subspaces(n,6):
    span=[0]
    for v in basis:span += [z^v for z in span]
    unseen=set(range(1<<n))
    while unseen:
     off=min(unseen);coset=[off^z for z in span]
     assert sum(values[v] for v in coset)%4==0
     checked+=1;unseen.difference_update(coset)
   assert checked==43180
   completion={'trial':trial,'D_ANF':sorted(F),'R3':sorted(R),'R2':sorted(R2),'full_mod4_profile_passes':True,'direct_affine6_weight_checks':checked};break
  out['certificate2_full_kernel']['full_I6_completion_search']={'limit':len(sparse)+2000,'completion':completion,'negative_search_not_proof':completion is None}

# A bounded challenge to the universal solvability claim; not a proof.
rng=random.Random(20261107);trials=0;passing8=0;fail=None
for n in [8,9,10]:
 M2=mons(n,2);M3=mons(n,3);WM2=[m for m in M2 if not m&3];WM1=[1<<i for i in range(2,n)]
 for t in range(300):
  A={m for m in WM2 if rng.random()<0.18};B={m for m in WM2 if rng.random()<0.18}
  us=[{m for m in WM1 if rng.getrandbits(1)} for _ in range(4)]
  Phi1=prod(A,us[0],True)^prod(B,us[1],True);Phi2=prod(A,us[2],True)^prod(B,us[3],True)
  Om={m for m in WM2 if rng.random()<0.15}
  D=prod(A,B,True)^prod({1},Phi1,True)^prod({2},Phi2,True)^prod({3},Om,True)
  trials+=1
  if tau(D,8):continue
  passing8+=1
  ans,_=solve([pack(prod(D,{m},True)) for m in M3],pack(tau(D,7)))
  if ans is None:
   fail={'n':n,'A':sorted(A),'B':sorted(B),'Phi1':sorted(Phi1),'Phi2':sorted(Phi2),'Omega':sorted(Om),'Delta':sorted(D)};break
 if fail:break
out['theorem42_sample']={'trials':trials,'passing_degree8':passing8,'counterexample':fail,'scope':'sample only; invalid proof is independently refuted above'}
(output_root/'AUDITORIA_ARGON_DUAS_FORMAS_CONTROLES.json').write_text(json.dumps(out,indent=2),encoding='utf-8')
print(json.dumps(out,indent=2))
