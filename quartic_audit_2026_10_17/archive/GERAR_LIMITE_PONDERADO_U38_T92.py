"""Exact global bound using seven U38 quadratic equations and core-state weights."""
from pathlib import Path
root=Path(__file__).resolve().parent
import json,time,sys,contextlib,io
from collections import Counter
from fractions import Fraction
start=time.perf_counter();base=(Path(sys.argv[1]) if len(sys.argv)>1 else Path('work/gemini_adversarial_20261017')).resolve();sys.path.insert(0,str(base));sys.dont_write_bytecode=True
with contextlib.redirect_stdout(io.StringIO()):
 from verify_14parity_normal_form import blocks
D=json.loads((root/'T91_U38_ENUMERACAO_MATRIZES.json').read_text());A=json.loads((root/'T89_U38_MATRIZES_AFINS_CERTIFICADO.json').read_text());S=json.loads((root/'T31_SETIMA_CERTIFICADO.json').read_text());L=set(S['L']);free=D['T20_free_indices'];chosen=D['chosen_free_indices'];parities=[int(v,16) for v in D['parameter_parities_hex']];basis=[[int(v,16) for v in col] for col in D['basis_matrices_hex']];pairs=[tuple(p) for p in A['pair_order']];selected=list(range(7,14));k=len(selected)
def parity(c,group):return sum(c>>j&1 for j in group)%2
def coefficient_basis(j):return (1<<j)^((1<<0) if j in L else 0)^((1<<113) if j==57 else 0)
uvnames=['u1','v1','u2','v2','u3','v3','u4','v4'];chosen_vectors=[coefficient_basis(j) for j in chosen]
for j in free:
 signature=sum((m>>j&1)<<i for i,m in enumerate(parities));v=coefficient_basis(j)
 for name in uvnames:
  assert parity(v,blocks[name])==sum(parity(chosen_vectors[i],blocks[name]) for i in range(15) if signature>>i&1)%2
# The five forms R,r23,alpha1,alpha2,alpha3 are independent on coordinates invisible to B.
forms=[blocks['R1']+blocks['R2']+blocks['R3']+blocks['R4'],blocks['R2']+blocks['R3'],blocks['R2']+blocks['W1'],blocks['R3']+blocks['W2'],blocks['R1']+blocks['W3']]
allR=set(sum(forms,[]));assert all(j in A['zero_original_coordinates'] for j in allR)
formrows=[sum(1<<j for j in f) for f in forms]
def rank(rows):
 pivots=[0]*38;r=0
 for v in rows:
  while v:
   p=v.bit_length()-1
   if pivots[p]:v^=pivots[p]
   else:pivots[p]=v;r+=1;break
 return r
def unrestricted_rank(rows):
 pivots={}
 for v in rows:
  while v:
   p=v.bit_length()-1
   if p in pivots:v^=pivots[p]
   else:pivots[p]=v;break
 return len(pivots)
assert unrestricted_rank(formrows)==5
assert all(j in A['zero_original_coordinates'] for j in [23,57,113,99])
weights=[]
for branch in [0,1]:
 mass=[];c=branch*((1<<0)|(1<<99));old=0
 for ordinal in range(32768):
  gray=ordinal^(ordinal>>1)
  if ordinal:c^=chosen_vectors[(gray^old).bit_length()-1]
  old=gray;u1,v1,u2,v2,u3,v3,u4,v4=[parity(c,blocks[n]) for n in uvnames];assert u1^v1==branch
  K=u2^v2^u4^v4;M=u3^v3;J1=v2^u4;J2=u2^v4;J3=v3^u4^v4;count=0
  for a in [0,1]:
   if branch*(a^K):continue
   R=((1^branch)&M)^((1^a)&K)
   for extra in range(16):
    r23=extra&1;al1=extra>>1&1;al2=extra>>2&1;al3=extra>>3&1
    value=branch^K^M^(branch&r23)^(R&J3)^((a^al3)&K)^(al1&(M^J1))^(al2&(M^J2))
    count+=not value
  mass.append(count)
 weights.append(mass)
assert Fraction(sum(map(sum,weights)),1<<26)==Fraction(13,1024)
print('exact core weights verified',sum(weights[0]),sum(weights[1]),flush=True)
def unpack(packed):
 rows=[0]*38
 for i,(a,b) in enumerate(pairs):
  if packed>>i&1:rows[a]^=1<<b;rows[b]^=1<<a
 return rows
reports=[];sum_numerator=0
for choice in range(1,1<<k):
 bpacked=[]
 for col in basis:
  m=0
  for i,r in enumerate(selected):
   if choice>>i&1:m^=col[r]
  bpacked.append(m)
 brows=[unpack(v) for v in bpacked];branch_hist=[]
 for branch in [0,1]:
  constant=0
  for i,r in enumerate(selected):
   if choice>>i&1:constant^=int(D['branches'][branch]['constant_matrices_hex'][r],16)
  current=unpack(constant);hist=Counter();old=0
  for ordinal,weight in enumerate(weights[branch]):
   gray=ordinal^(ordinal>>1)
   if ordinal:current=[a^b for a,b in zip(current,brows[(gray^old).bit_length()-1])]
   old=gray
   if weight:
    r=rank(current);assert r%2==0;hist[r]+=weight
  branch_hist.append(dict(sorted(hist.items())))
  sum_numerator+=sum(amount*(1<<(19-r//2)) for r,amount in hist.items())
 reports.append({'character':choice,'weighted_rank_histograms':branch_hist})
 if choice%8==0 or choice==127:print('characters',choice,'/127 elapsed',round(time.perf_counter()-start,1),flush=True)
total=sum(map(sum,weights));bound=Fraction(total*(1<<19)+sum_numerator,1<<(26+k+19));excluded=100*(1-bound)
result={'verification':'PASS','scope':'Exact upper bound for core-seven plus seven selected U38 quadratic necessary equations, by weighted average of all 127 character rank bounds over all 32768 parameter states in each T20 branch. Requires independently validated affine-matrix and core-weight inputs; no nonexistence assertion.','selected_combination_indices':selected,'states_per_branch':32768,'core_state_weight_denominator':1<<26,'core_weight_totals':[sum(w) for w in weights],'core_density':[13,1024],'character_histograms':reports,'pass_upper_bound':[bound.numerator,bound.denominator],'excluded_percent_approx':float(excluded),'seconds':time.perf_counter()-start}
(root/'T92_U38_LIMITE_PONDERADO.json').write_text(json.dumps(result,indent=2));print('RESULT',bound,float(excluded),flush=True)
