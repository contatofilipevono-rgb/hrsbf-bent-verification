"""Exact normal-form substitution for the additional support 0x33ff."""
from pathlib import Path
from itertools import combinations
import json,random,time
base=Path(__file__).resolve().parent;start=time.perf_counter()
certificate=json.loads((base/'T38_MODELOS_CERTIFICADO.json').read_text());new=json.loads((base/'T37_NOVA_CONDICAO_CERTIFICADO.json').read_text());old=json.loads((base/'T28_SEXTA_CERTIFICADO.json').read_text());seven=json.loads((base/'T31_SETIMA_CERTIFICADO.json').read_text());factor=old['fourth_factorization']
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
orbits=[];seen=set()
for t in combinations(range(16),4):
 m=sum(1<<j for j in t)
 if m in seen:continue
 orb=set();r=m
 for _ in range(16):orb.add(r);r=((r<<1)&65535)|(r>>15)
 seen|=orb;orbits.append(orb)
points=[x for x in range(65536) if x&0x33ff==x];truth_words=[sum((sum(x&m==m for m in orb)%2)<<k for k,x in enumerate(points)) for orb in orbits];chi=sum((x.bit_count()%2)<<k for k,x in enumerate(points))
def parity(c,indices):return sum((c>>j)&1 for j in indices)%2
checks=0;details=[]
for branch,record in enumerate(certificate['models']):
 assert branch==record['branch'] and record['support_mask']=='0x33ff'
 P={int(m,16) for m in new['polynomial_after_three_laws_hex']};C={1<<j for j in seven['L'] if j!=0}
 if branch:C.add(0)
 P=substitute(P,0,C)
 if branch:P=substitute(P,57,{1<<j for j in seven['K']})
 free=sorted(set(range(116))-{0,99,113,115}-({57} if branch else set()));origin=(1<<0)|(1<<99) if branch else 0;basis=[]
 for j in free:
  c=(1<<j)^((1<<0) if j in seven['L'] else 0)
  if branch:
   if j in seven['K']:c^=(1<<57)|(1<<113)
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
 G={1<<j for j in seven['R']}
 if branch==0:
  for j in seven['M']+seven['K']:toggle(G,1<<j)
  for j in seven['K']:toggle(G,(1<<57)|(1<<j))
 assert (1<<5) in G and all(not m>>5&1 for m in G if m.bit_count()>1);G.remove(1<<5);P=substitute(P,5,G)
 assert P=={int(m,16) for m in record['polynomial_hex']}
 rng=random.Random(2026101738+branch)
 for sample in range(32):
  c=rng.getrandbits(116)&sum(1<<j for j in free if j not in [23,5])
  if branch:c|=1<<99;c|=parity(c,seven['K'])<<57
  c|=(branch^parity(c,seven['L']))<<0;c|=((c>>57)&1)<<113
  a=c>>57&1;c|=(a^parity(c,[31,39,112])^sum(parity(c,p['I'])*parity(c,p['J']) for p in factor['products'])%2)<<23
  c|=(parity(c,seven['R'])^((1^branch)&parity(c,seven['M']))^((1^a)&parity(c,seven['K'])))<<5
  word=chi
  for j in range(116):
   if c>>j&1:word^=truth_words[j]
  h=4096-2*word.bit_count();assert h%8==0
  assert h//8%2==sum((c&m)==m for m in P)%2;checks+=1
 details.append({'branch':branch,'monomials':len(P),'degree':max(m.bit_count() for m in P)})
print(json.dumps({'verification':'PASS','complete_substitutions':details,'original_ANF_checks':checks,'seconds':time.perf_counter()-start,'scope':'Exact additional first-bit condition after the six-condition core; no global exclusion bound is asserted by this checker alone.'},indent=2))
