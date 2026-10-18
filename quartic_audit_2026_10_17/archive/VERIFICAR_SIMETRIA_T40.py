"""Verify multiplier symmetry of the core and the four additional support equations."""
from pathlib import Path
from itertools import combinations
import json,time
base=Path(__file__).resolve().parent;start=time.perf_counter();cert=json.loads((base/'T40_SIMETRIA_CERTIFICADO.json').read_text());seven=json.loads((base/'T31_SETIMA_CERTIFICADO.json').read_text());factor=json.loads((base/'T28_SEXTA_CERTIFICADO.json').read_text())['fourth_factorization'];anchor=json.loads((base/'T37_NOVA_CONDICAO_CERTIFICADO.json').read_text())
orbits=[];index={}
for t in combinations(range(16),4):
 m=sum(1<<j for j in t)
 if m in index:continue
 orb=set();r=m
 for _ in range(16):orb.add(r);r=((r<<1)&65535)|(r>>15)
 for r in orb:index[r]=len(orbits)
 orbits.append(orb)
def rotate_orbit(x):
 out=set()
 for _ in range(16):out.add(x);x=((x<<1)&65535)|(x>>15)
 return out
def permute(x,k):return sum(((x>>i)&1)<<((i*k)%16) for i in range(16))
def toggle(P,m):
 if m in P:P.remove(m)
 else:P.add(m)
def substitute(P,j,Q):
 out=set()
 for m in P:
  if m>>j&1:
   for n in Q:toggle(out,(m^(1<<j))|n)
  else:toggle(out,m)
 return out
def reduce_laws(P):return substitute(substitute(substitute(P,115,set()),113,{1<<57}),99,{1<<j for j in seven['L']})
def transform(P,pi):
 out=set()
 for m in P:toggle(out,sum(1<<pi[j] for j in range(116) if m>>j&1))
 return out
core=[{1<<115},{1<<57,1<<113},{1<<99}^{1<<j for j in seven['L']}]
Q={1<<j for j in factor['linear']}
for block in factor['products']:
 for i in block['I']:
  for j in block['J']:toggle(Q,(1<<i)|(1<<j))
core.append(Q);core.append({(1<<99)|(1<<j) for j in [57]+seven['K']})
G={1<<j for j in seven['R']+seven['M']+seven['K']}
for j in seven['M']:toggle(G,(1<<99)|(1<<j))
for j in seven['K']:toggle(G,(1<<57)|(1<<j))
core.append(G)
supports=[int(u,16) for u in cert['supports']];assert supports==[0x3f3f,0x5f5f,0x6f6f,0x33ff,0x66ff,0x73bf,0x76ef]
family={u:{int(m,16) for m in terms} for u,terms in cert['family_polynomials'].items()};assert family['0x33ff']=={int(m,16) for m in anchor['polynomial_after_three_laws_hex']}
assert [a['unit'] for a in cert['actions']]==list(range(1,16,2))
for a in cert['actions']:
 k=a['unit'];pi=[index[permute(min(orb),k)] for orb in orbits];assert pi==a['coefficient_permutation'] and sorted(pi)==list(range(116))
 sp=[]
 for support in supports:
  targets=[j for j,u in enumerate(supports) if u in rotate_orbit(permute(support,k))];assert len(targets)==1;sp.append(targets[0])
 assert sp==a['support_permutation']
 for P in core:assert reduce_laws(transform(P,pi))==reduce_laws(P)
 assert reduce_laws({1<<pi[57]})=={1<<57} and reduce_laws({1<<pi[99]})==reduce_laws({1<<99})
 for i in range(3,7):assert reduce_laws(transform(family[hex(supports[i])],pi))==family[hex(supports[sp[i]])]
unseen=set(range(1,128));orbits_char=[]
while unseen:
 c=min(unseen);orbit=sorted({sum(((c>>i)&1)<<a['support_permutation'][i] for i in range(7)) for a in cert['actions']});assert set(orbit)<=unseen;unseen-=set(orbit);orbits_char.append(orbit)
assert orbits_char==cert['character_orbits'] and len(orbits_char)==43
print(json.dumps({'verification':'PASS','unit_actions_checked':8,'core_conditions_preserved':6,'both_charts_preserved':True,'additional_polynomial_relations_checked':32,'characters_covered':sum(map(len,orbits_char)),'character_orbits':43,'seconds':time.perf_counter()-start,'scope':'Exact normalizer symmetry permits equal character expectations within each orbit. It does not by itself supply an exclusion bound.'},indent=2))
