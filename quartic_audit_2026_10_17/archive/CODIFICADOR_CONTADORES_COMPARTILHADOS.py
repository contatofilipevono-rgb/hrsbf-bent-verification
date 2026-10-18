"""Shared truncated orbit counters and modular linear combinations."""
from collections import Counter,defaultdict
from math import gcd
from functools import reduce

class Circuit:
 def __init__(self,solver,start):self.solver=solver;self.variable=start;self.start=start;self.clauses=0;self.xors=0;self.true_literal=None
 def fresh(self):self.variable+=1;return self.variable
 def clause(self,row):self.solver.add_clause(row);self.clauses+=1
 def one(self):
  if self.true_literal is None:self.true_literal=self.fresh();self.clause([self.true_literal])
  return self.true_literal
 def xor(self,row,rhs=False):
  parity=bool(rhs);variables=set()
  for lit in row:
   parity^=lit<0;j=abs(lit)
   if j in variables:variables.remove(j)
   else:variables.add(j)
  if variables:self.solver.add_xor_clause(sorted(variables),parity);self.xors+=1
  elif parity:self.clause([])
 def add(self,A,B,width):
  out=[];carry=None
  for k in range(min(width,max(len(A),len(B)))):
   inputs=[v for v in [A[k] if k<len(A) else None,B[k] if k<len(B) else None,carry] if v is not None]
   if len(inputs)<2:out.append(inputs[0] if inputs else None);carry=None;continue
   if len(inputs)==2 and inputs[0]==inputs[1]:out.append(None);carry=inputs[0];continue
   if len(inputs)==2 and inputs[0]==-inputs[1]:out.append(self.one());carry=None;continue
   z=self.fresh();self.xor([z]+inputs);out.append(z)
   if k==width-1:carry=None;continue
   carry=self.fresh()
   if len(inputs)==2:
    a,b=inputs;self.clause([-carry,a]);self.clause([-carry,b]);self.clause([carry,-a,-b])
   else:
    a,b,c=inputs
    for p,q in [(a,b),(a,c),(b,c)]:self.clause([-p,-q,carry]);self.clause([p,q,-carry])
  if carry is not None and len(out)<width:out.append(carry)
  while out and out[-1] is None:out.pop()
  return out
 def total(self,numbers,width):
  numbers=[x[:width] for x in numbers if x]
  while len(numbers)>1:numbers=[self.add(numbers[i],numbers[i+1],width) if i+1<len(numbers) else numbers[i] for i in range(0,len(numbers),2)]
  return numbers[0] if numbers else []
 def weighted(self,terms,width,constant=0):
  numbers=[]
  for lit,weight in terms:
   weight%=1<<width
   if weight:numbers.append([lit if weight>>k&1 else None for k in range(weight.bit_length())])
  constant%=1<<width
  if constant:numbers.append([self.one() if constant>>k&1 else None for k in range(constant.bit_length())])
  return self.total(numbers,width)
 def linear_constraint(self,words,coefficients,width,target,extra_terms=(),constant=0,activation=None):
  numbers=[]
  for word,coefficient in zip(words,coefficients):
   if not coefficient:continue
   magnitude=abs(coefficient);scaled=self.total([[None]*j+list(word) for j in range(magnitude.bit_length()) if magnitude>>j&1],width)
   if coefficient<0:
    scaled=[-scaled[j] if j<len(scaled) and scaled[j] is not None else self.one() for j in range(width)];constant+=1
   numbers.append(scaled)
  for lit,weight in extra_terms:
   weight%=1<<width
   if weight:numbers.append([lit if weight>>k&1 else None for k in range(weight.bit_length())])
  word=self.total(numbers,width);target=(target-constant)%(1<<width)
  guard=[] if activation is None else [-activation]
  for k in range(width):
   lit=word[k] if k<len(word) else None;value=target>>k&1
   if lit is None:
    if value:self.clause(guard)
   else:self.clause(guard+[lit if value else -lit])

def exact_profile_constraints(circuit,words,profiles,branch,activation=None):
 selectors=[]
 for profile in profiles:
  if profile['b']!=branch:continue
  assert len(profile['full_orbit_counts'])==len(words)
  selector=circuit.fresh();selectors.append(selector);circuit.clause([-selector,58 if profile['a'] else -58])
  for word,target in zip(words,profile['full_orbit_counts']):
   for k in range(max(len(word),target.bit_length())):
    lit=word[k] if k<len(word) else None;value=target>>k&1
    if lit is None:
     if value:circuit.clause([-selector])
    else:circuit.clause([-selector,lit if value else -lit])
 circuit.clause(selectors if activation is None else [-activation]+selectors)
 return selectors

def encode_projection(solver,start,projection,gs,branch,L,with_activations=False,exact_profiles=None,full_counters=False,state=None):
 assert projection['n']==16 and projection['d'] in [4,8] and len(gs)==116
 assert not(with_activations and exact_profiles is not None)
 assert exact_profiles is None or projection['d']==4
 circuit=Circuit(solver,start);free=sorted(set(range(116))-{0,99,113,115});cache={};words=[];metadata=[]
 for orbit,group in zip(projection['classes'],projection['groups']):
  period=len(orbit);width=max(1,len(group).bit_length()) if exact_profiles is not None or full_counters else (16*period).bit_length()-1;counts=Counter()
  for r in group:
   bits=[word>>r&1 for _,word in gs]
   signature=sum((bits[j]^(bits[0] if j in L else 0)^(bits[113] if j==57 else 0))<<j for j in free);origin=branch*(bits[0]^bits[99]);counts[signature,origin]+=1
  by_signature=defaultdict(lambda:[0,0])
  for (signature,origin),amount in counts.items():by_signature[signature][origin]+=amount
  terms=[];constant=0
  for signature,(n0,n1) in by_signature.items():
   if not signature:constant+=n1;continue
   difference=n0-n1;constant+=min(n0,n1)
   if not difference:continue
   if signature not in cache:
    lit=circuit.fresh();circuit.xor([lit]+[j+1 for j in free if signature>>j&1]);cache[signature]=lit
   terms.append((cache[signature] if difference>0 else -cache[signature],abs(difference)))
  word=circuit.weighted(terms,width,constant);words.append(word);metadata.append({'quotient_representative':hex(orbit[0]),'input_orbits':len(group),'counter_bits':width})
 if state is not None:state.update(circuit=circuit,cache=cache,free=free)
 counter_stage={'variables':circuit.variable-start,'clauses':circuit.clauses,'xor_equations':circuit.xors}
 if exact_profiles is not None:
  selectors=exact_profile_constraints(circuit,words,exact_profiles,branch)
  return circuit.variable,{'new_variables':circuit.variable-start,'clauses':circuit.clauses,'xor_equations':circuit.xors,'truth_signature_variables':len(cache),'counter_stage':counter_stage,'counters':metadata,'target_profiles':len(selectors),'scope':'Exact six-amplitude target table with full counters under three T20 laws and fixed b.'},words
 activations=[]
 for row in projection['matrix']:
  g=reduce(gcd,[abs(C) for C in row]);modulus=256//g;assert modulus&(modulus-1)==0
  width=modulus.bit_length()-1
  activation=circuit.fresh() if with_activations else None;activations.append(activation)
  circuit.linear_constraint(words,[C//g for C in row],width,128//g,extra_terms=[(58,64//g)],constant=branch*(96//g),activation=activation)
 return circuit.variable,{'new_variables':circuit.variable-start,'clauses':circuit.clauses,'xor_equations':circuit.xors,'truth_signature_variables':len(cache),'counter_stage':counter_stage,'counters':metadata,'frequency_constraints':len(projection['frequencies']),'activation_variables':activations if with_activations else [],'scope':'Shared counters for necessary Walsh congruences mod512 under the three T20 laws, fixed c99 branch.'},words
