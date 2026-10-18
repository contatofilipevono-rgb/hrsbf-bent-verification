"""Exact signed orbit sums, folded by coefficient signatures before encoding."""
from collections import defaultdict
from functools import reduce
from math import gcd
L={0,4,8,14,18,22,42,46,52,56,71,81,85,94,98,106}

def input_orbits(n=16):
 seen=set();out=[];mask=(1<<n)-1
 for x in range(1<<n):
  if x in seen:continue
  orbit=sorted({((x<<k)|(x>>(n-k)))&mask for k in range(n)})
  seen.update(orbit);out.append(orbit)
 return out

def signed_folded_weights(gs,orbits,frequency,branch):
 free=sorted(set(range(116))-{0,99,113,115});weights=defaultdict(int)
 for orbit in orbits:
  C=sum(1-2*((frequency&x).bit_count()%2) for x in orbit)
  if not C:continue
  bits=[word>>orbit[0]&1 for _,word in gs]
  signature=sum((bits[j]^(bits[0] if j in L else 0)^(bits[113] if j==57 else 0))<<j for j in free)
  origin=branch*(bits[0]^bits[99]);weights[signature]+=C*(1-2*origin)
 return {s:w for s,w in weights.items() if w}

def add_weighted_amplitude(solver,start_variable,weights,amplitude=256,congruence_modulus=None):
 variable=start_variable;clauses=0;xors=0
 def fresh():
  nonlocal variable
  variable+=1;return variable
 def clause(row):
  nonlocal clauses
  solver.add_clause(row);clauses+=1
 def xor(row,rhs=False):
  nonlocal xors
  solver.add_xor_clause(row,bool(rhs));xors+=1
 def add(A,B):
  out=[];carry=None
  for k in range(max(len(A),len(B))):
   inputs=[v for v in [A[k] if k<len(A) else None,B[k] if k<len(B) else None,carry] if v is not None]
   if len(inputs)<2:out.append(inputs[0] if inputs else None);carry=None;continue
   z=fresh();xor([z]+inputs);out.append(z);carry=fresh()
   if len(inputs)==2:
    a,b=inputs;clause([-carry,a]);clause([-carry,b]);clause([carry,-a,-b])
   else:
    a,b,c=inputs
    for p,q in [(a,b),(a,c),(b,c)]:clause([-p,-q,carry]);clause([p,q,-carry])
  if carry is not None:out.append(carry)
  if width is not None:out=out[:width]
  return out
 constant=weights.get(0,0);g=reduce(gcd,[abs(w) for s,w in weights.items() if s],0) or 1
 width=None
 if congruence_modulus is not None:
  assert congruence_modulus==2*amplitude and congruence_modulus%(2*g)==0
  quotient=congruence_modulus//(2*g);assert quotient&(quotient-1)==0
  width=quotient.bit_length()-1
 numbers=[];absolute=sum(abs(w) for s,w in weights.items() if s)
 for signature,weight in weights.items():
  if not signature:continue
  y=fresh();xor([y]+[j+1 for j in range(signature.bit_length()) if signature>>j&1],weight<0)
  weight=abs(weight)//g
  if width is not None:weight%=1<<width
  if weight:numbers.append([y if weight>>k&1 else None for k in range(weight.bit_length())])
 while len(numbers)>1:numbers=[add(numbers[i],numbers[i+1]) if i+1<len(numbers) else numbers[i] for i in range(0,len(numbers),2)]
 bits=numbers[0] if numbers else []
 if width is not None:
  numerator=constant+absolute-amplitude
  if numerator%(2*g):clause([]);target=None
  else:
   target=(numerator//(2*g))%(1<<width)
   for k in range(width):
    bit=bits[k] if k<len(bits) else None;value=target>>k&1
    if bit is None:
     if value:clause([])
    else:clause([bit if value else -bit])
  return variable,{'new_variables':variable-start_variable,'clauses':clauses,'xor_equations':xors,'constant':constant,'weight_gcd':g,'nonconstant_signatures':len(weights)-(0 in weights),'congruence_modulus':congruence_modulus,'counter_bits':width,'residue_target':target,'scope':'Necessary congruence only, not exact amplitude.'}
 sign=fresh();targets=[]
 for negative in range(2):
  numerator=constant+absolute-amplitude*(1-2*negative)
  target=numerator//(2*g);guard=[-sign if negative else sign]
  if numerator%(2*g) or target<0 or target>absolute//g:
   clause(guard);targets.append(None);continue
  targets.append(target)
  for k in range(max(len(bits),target.bit_length())):
   bit=bits[k] if k<len(bits) else None;value=target>>k&1
   if bit is None:
    if value:clause(guard)
   else:clause(guard+[bit if value else -bit])
 return variable,{'new_variables':variable-start_variable,'clauses':clauses,'xor_equations':xors,'constant':constant,'weight_gcd':g,'absolute_weight_sum':absolute,'nonconstant_signatures':len(weights)-(0 in weights),'targets':targets,'sum_output_bits':len(bits)}
