"""Complete partition, symmetry, normal-form, and witness checks for an invariant additional bit."""
from pathlib import Path
from itertools import combinations
import json,time
start=time.perf_counter();base=Path(__file__).resolve().parent
cert=json.loads((base/'T48_SOMA_INVARIANTE_CERTIFICADO.json').read_text());old=json.loads((base/'T28_SEXTA_CERTIFICADO.json').read_text());seventh=json.loads((base/'T31_SETIMA_CERTIFICADO.json').read_text())
orbits=[];index={}
for t in combinations(range(16),4):
 m=sum(1<<j for j in t)
 if m in index:continue
 orb=set();r=m
 for _ in range(16):orb.add(r);r=((r<<1)&65535)|(r>>15)
 for r in orb:index[r]=len(orbits)
 orbits.append(orb)
assert len(orbits)==116
def toggle(P,m):
 if m in P:P.remove(m)
 else:P.add(m)
all_raw=set();partition_total=0
for record in cert['individual_raw_models']:
 u=int(record['support_mask'],16);T=[j for j in range(16) if u>>j&1];assert len(T)==12;P=set();partitions=0
 for restA in combinations(T[1:],3):
  A=(T[0],)+restA;remaining=sorted(set(T)-set(A));a=index[sum(1<<j for j in A)]
  for restB in combinations(remaining[1:],3):
   B=(remaining[0],)+restB;C=set(remaining)-set(B);b=index[sum(1<<j for j in B)];c=index[sum(1<<j for j in C)]
   toggle(P,(1<<a)|(1<<b)|(1<<c));partitions+=1
 assert partitions==5775
 reduced=set()
 for m in P:
  if m>>115&1:continue
  if m>>113&1:m=(m^(1<<113))|(1<<57)
  if m>>99&1:
   for j in seventh['L']:toggle(reduced,(m^(1<<99))|(1<<j))
  else:toggle(reduced,m)
 assert reduced=={int(m,16) for m in record['polynomial_hex']}
 assert len(reduced)==5498
 all_raw^=reduced;partition_total+=partitions
assert all_raw=={int(m,16) for m in cert['invariant_raw_sum_hex']}
actions=json.loads((base/'T40_SIMETRIA_CERTIFICADO.json').read_text())['actions']
for action in actions:
 mapped=set()
 for m in all_raw:
  n=sum(1<<action['coefficient_permutation'][j] for j in range(116) if m>>j&1)
  if n>>115&1:continue
  if n>>113&1:n=(n^(1<<113))|(1<<57)
  if n>>99&1:
   for j in seventh['L']:toggle(mapped,(n^(1<<99))|(1<<j))
  else:toggle(mapped,n)
 assert mapped==all_raw
factor=old['fourth_factorization'];details=[]
def substitute(P,j,Q):
 out=set()
 for m in P:
  if m>>j&1:
   for n in Q:toggle(out,(m^(1<<j))|n)
  else:toggle(out,m)
 return out
for branch,record in enumerate(cert['models']):
 assert branch==record['branch'] and record['support_mask']=='normalizer_sum_27ff'
 P={int(m,16) for m in cert['invariant_raw_sum_hex']};C={1<<j for j in seventh['L'] if j!=0}
 if branch:C.add(0)
 P=substitute(P,0,C)
 if branch:P=substitute(P,57,{1<<j for j in seventh['K']})
 free=sorted(set(range(116))-{0,99,113,115}-({57} if branch else set()));origin=(1<<0)|(1<<99) if branch else 0;basis=[]
 for j in free:
  c=(1<<j)^((1<<0) if j in seventh['L'] else 0)
  if branch:
   if j in seventh['K']:c^=(1<<57)|(1<<113)
  elif j==57:c^=1<<113
  basis.append(c)
 def form(indices):
  mask=sum(1<<j for j in indices)
  return {1<<j for j,c in zip(free,basis) if (c&mask).bit_count()%2}^({0} if (origin&mask).bit_count()%2 else set())
 Q=form(factor['linear'])
 for block in factor['products']:
  for a in form(block['I']):
   for b in form(block['J']):toggle(Q,a|b)
 assert (1<<23) in Q and all(not m>>23&1 for m in Q if m.bit_count()>1);Q.remove(1<<23);P=substitute(P,23,Q)
 G={1<<j for j in seventh['R']}
 if branch==0:
  for j in seventh['M']+seventh['K']:toggle(G,1<<j)
  for j in seventh['K']:toggle(G,(1<<57)|(1<<j))
 assert (1<<5) in G and all(not m>>5&1 for m in G if m.bit_count()>1);G.remove(1<<5);P=substitute(P,5,G)
 assert P=={int(m,16) for m in record['polynomial_hex']}

 details.append({'branch':branch,'monomials':len(P),'degree':max(m.bit_count() for m in P)})
c=int(cert['witness_coefficient_hex'],16);a=c>>57&1;b=c>>99&1
def parity(group):return sum(c>>j&1 for j in group)%2
assert c>>115&1==0 and c>>113&1==a and b==parity(seventh['L'])
factor=old['fourth_factorization'];assert parity(factor['linear'])^sum(parity(p['I'])*parity(p['J']) for p in factor['products'])%2==0
assert b&(a^parity(seventh['K']))==0
monomials=[m for j,orb in enumerate(orbits) if c>>j&1 for m in orb];cache={}
def f(x):
 if x not in cache:cache[x]=sum(x&m==m for m in monomials)%2
 return cache[x]
def h(u):
 total=0;x=u
 while True:
  total+=(1-2*f(x))*(-1 if (u.bit_count()-x.bit_count())%2 else 1)
  if x==0:break
  x=(x-1)&u
 return total
values={}
for support in [0x3f3f,0x5f5f,0x6f6f,0x7777]:
 value=h(support);assert value%32==0;values[hex(support)]=value
for support in [0x33ff,0x66ff,0x73bf,0x76ef]:assert h(support)%16==0
new_values={record['support_mask']:h(int(record['support_mask'],16)) for record in cert['individual_raw_models']}
assert all(v%8==0 for v in new_values.values()) and sum(v//8 for v in new_values.values())%2==1
assert sum((c&m)==m for m in all_raw)%2==1
print(json.dumps({'verification':'PASS','partitions_checked':partition_total,'unit_invariance_checks':len(actions),'raw_sum_monomials':len(all_raw),'normalized_models':details,'witness_coefficient_hex':hex(c),'new_h_values':new_values,'original_ANF_points_evaluated':len(cache),'seconds':time.perf_counter()-start,'scope':'A new invariant necessary bit, not implied by the thirteen previous filters. No improved global density is asserted.'},indent=2))
