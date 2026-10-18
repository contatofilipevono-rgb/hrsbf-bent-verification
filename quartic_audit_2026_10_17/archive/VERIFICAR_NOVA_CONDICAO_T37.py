"""Complete partition certificate and direct original-ANF witness for a tenth condition."""
from pathlib import Path
from itertools import combinations
import json,time
start=time.perf_counter();base=Path(__file__).resolve().parent
cert=json.loads((base/'T37_NOVA_CONDICAO_CERTIFICADO.json').read_text());old=json.loads((base/'T28_SEXTA_CERTIFICADO.json').read_text());seventh=json.loads((base/'T31_SETIMA_CERTIFICADO.json').read_text())
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
u=0x33ff;T=[j for j in range(16) if u>>j&1];assert len(T)==12;P=set();partitions=0
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
assert reduced=={int(m,16) for m in cert['polynomial_after_three_laws_hex']}
assert len(reduced)==4748
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
new_h=h(u);assert new_h==-120 and new_h%8==0 and new_h%16!=0 and new_h%32!=0
assert sum((c&m)==m for m in reduced)%2==new_h//8%2==1
second_h=h(0x5e9f);assert second_h==168 and second_h%16!=0
report={'verification':'PASS','partitions_checked':partitions,'new_condition_support':'0x33ff','degree':max(m.bit_count() for m in reduced),'monomials':len(reduced),'witness_coefficient_hex':hex(c),'four_existing_periodic_values':values,'new_support_h':new_h,'required_divisibility':32,'second_new_support_h':second_h,'original_ANF_points_evaluated':len(cache),'seconds':time.perf_counter()-start,'scope':'Exact witness passes all nine old conditions and violates the additional necessary condition. This proves non-implication, not a global rejection rate or nonexistence.'}
print(json.dumps(report,indent=2))
