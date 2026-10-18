"""Exact proof that T28 alone cannot prune any T27 quotient state; standard Python."""
import json
from pathlib import Path
from itertools import combinations
base=Path(__file__).resolve().parent;cert=json.loads((base/'T28_SEXTA_CERTIFICADO.json').read_text())
seen=set();orbits=[]
for subset in combinations(range(16),4):
 m=sum(1<<j for j in subset)
 if m in seen:continue
 orb=set();r=m
 for _ in range(16):orb.add(r);r=((r<<1)&65535)|(r>>15)
 seen|=orb;orbits.append(orb)
d=1<<75;e=sum(1<<j for j in [42,81,94,106])
def f(c,x):return sum(sum((x&m)==m for m in orbits[j]) for j in range(116) if c>>j&1)%2
points_checked=0
for delta in [d,e]:
 for z in [0,85,170,255,51]:
  for u in range(256):assert f(delta,u|((u^z)<<8))==0;points_checked+=1
factor=cert['fourth_factorization'];fifth=cert['fifth_factorization'];L=[0,4,8,14,18,22,42,46,52,56,71,81,85,94,98,106]
groups=[[115],[57],[113],[99],L,factor['linear'],fifth['I']]
groups += [p[side] for p in factor['products'] for side in ['I','J']]
for delta in [d,e]:
 for group in groups:assert (delta&sum(1<<j for j in group)).bit_count()%2==0
def derivative(P,delta):
 out=set()
 for m in P:
  sub=m&delta
  while sub:
   n=m^sub
   if n in out:out.remove(n)
   else:out.add(n)
   sub=(sub-1)&(m&delta)
 return out
for branch in cert['reduced_models']['branches']:
 P={int(m,16) for m in branch['polynomial_hex']}
 assert derivative(derivative(P,d),e)=={0}
print(json.dumps({'verification':'PASS','original_coefficient_directions':[[75],[42,81,94,106]],'fiber_point_evaluations_checked':points_checked,'all_first_five_conditions_preserved':True,'constant_one_mixed_derivative_both_branches':True,'conclusion':'Every T27 quotient state that has a lift satisfying the first five conditions has lifts with both values of the sixth bit. The sixth condition alone removes no quotient states.'},indent=2))
