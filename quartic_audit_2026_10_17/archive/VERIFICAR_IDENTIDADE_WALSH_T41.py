"""Standard-Python verification of the compact exact W_f(0) constraint."""
from pathlib import Path
from itertools import combinations,product
import json,time
base=Path(__file__).resolve().parent;start=time.perf_counter();cert=json.loads((base/'T41_WALSH_CERTIFICADO.json').read_text());seven=json.loads((base/'T31_SETIMA_CERTIFICADO.json').read_text());orbits=[];seen=set()
for T in combinations(range(16),4):
 m=sum(1<<j for j in T)
 if m in seen:continue
 orb=set();r=m
 for _ in range(16):orb.add(r);r=((r<<1)&65535)|(r>>15)
 seen|=orb;orbits.append(orb)
def f(c,x):return sum(sum(x&m==m for m in orb) for j,orb in enumerate(orbits) if c>>j&1)%2
diagonal=[sum((sum((u|(u<<8))&m==m for m in orb)%2)<<u for u in range(256)) for orb in orbits]
assert all(diagonal[j]==0 for j in range(116) if j not in [57,99,113,115])
Da=diagonal[57]^diagonal[113];Db=diagonal[99]
for a,b in product(range(2),repeat=2):assert 256-2*((Da if a else 0)^(Db if b else 0)).bit_count()==256-128*a-192*b
seen=set();reps=[]
for x in range(65536):
 if x in seen:continue
 orbit=set();r=x
 for _ in range(16):orbit.add(r);r=((r<<1)&65535)|(r>>15)
 seen|=orbit
 if len(orbit)==16:reps.append(x)
assert len(reps)==4080 and 16*4080+256==65536
checks=[]
for control in cert['fixed_function_controls']:
 c=int(control['coefficient_hex'],16);a=c>>57&1;b=c>>99&1
 assert c>>115&1==0 and c>>113&1==a and b==sum(c>>j&1 for j in seven['L'])%2
 w=sum(f(c,x) for x in reps);short=sum(1-2*f(c,u|(u<<8)) for u in range(256));W0=short+16*(4080-2*w)
 assert W0==65536-128*a-192*b-32*w==control['W0']
 assert (W0 in [-256,256])==control['expected']
 checks.append({'coefficient_hex':hex(c),'W0':W0,'full_orbit_weight':w,'passes':W0 in [-256,256]})
for count in [2,3]:
 for inputs in product(range(2),repeat=count):
  for sum_bit,carry in product(range(2),repeat=2):
   parity_ok=(sum_bit+sum(inputs))%2==0
   if count==2:
    a,b=inputs;clauses=[(not carry) or a,(not carry) or b,carry or (not a) or (not b)]
   else:
    a,b,c=inputs;clauses=[]
    for p,q in [(a,b),(a,c),(b,c)]:clauses.extend([(not p) or (not q) or carry,p or q or (not carry)])
   assert (parity_ok and all(clauses))==(sum(inputs)==sum_bit+2*carry)
print(json.dumps({'verification':'PASS','full_rotation_orbits':4080,'all_diagonal_basis_values_verified':True,'adder_gate_truth_tables_verified':True,'controls':checks,'seconds':time.perf_counter()-start,'scope':'Exact identity, target weights, and gate semantics. SAT pilot timeouts supply no exclusion or nonexistence proof.'},indent=2))
