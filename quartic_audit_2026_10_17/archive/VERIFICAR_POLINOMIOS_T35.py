"""Reconstruct all periodic second-bit polynomials from original quartic monomials."""
import json,time,random
from pathlib import Path
from itertools import combinations
base=Path(__file__).resolve().parent;start=time.perf_counter()
cert=json.loads((base/'T35_POLINOMIOS_CERTIFICADO.json').read_text());old=json.loads((base/'T28_SEXTA_CERTIFICADO.json').read_text());seventh=json.loads((base/'T31_SETIMA_CERTIFICADO.json').read_text())
seen=set();orbits=[]
for t in combinations(range(16),4):
 m=sum(1<<j for j in t)
 if m in seen:continue
 orb=set();r=m
 for _ in range(16):orb.add(r);r=((r<<1)&65535)|(r>>15)
 seen|=orb;orbits.append(orb)
assert len(orbits)==116
def toggle(P,m):
 if m in P:P.remove(m)
 else:P.add(m)
def evaluate(P,c):return sum((c&m)==m for m in P)%2
def substitute(P,j,Q):
 out=set()
 for m in P:
  if m>>j&1:
   for n in Q:toggle(out,(m^(1<<j))|n)
  else:toggle(out,m)
 return out
L=seventh['L'];K=seventh['K'];factor=old['fourth_factorization'];total_terms=0;direct=0
for support in ['0x3f3f','0x5f5f','0x6f6f']:
 mask=int(support,16)&255;small=[v for v in range(256) if v&mask==v];points=[v|(w<<8) for v in small for w in small]
 truth_words=[sum((sum(x&m==m for m in orb)%2)<<k for k,x in enumerate(points)) for orb in orbits]
 positions=[i*64+j for i in range(64) for j in range(i+1,64)]
 pair_words=[sum(((word>>p)&1)<<k for k,p in enumerate(positions)) for word in truth_words]
 offset=sum((points[p].bit_count()%2)<<k for k,p in enumerate(positions));full_offset=sum((x.bit_count()%2)<<k for k,x in enumerate(points))
 diagonal=[sum(((word>>(i*64+i))&1)<<i for i in range(64)) for word in truth_words]
 assert all(diagonal[j]==0 for j in range(116) if j not in [57,99,113,115])
 Da=diagonal[57]^diagonal[113];Db=diagonal[99]
 assert [64-2*((Da if a else 0)^(Db if b else 0)).bit_count() for a,b in [(0,0),(0,1),(1,0),(1,1)]]==[64,16,32,-16]
 for branch in range(2):
  raw=next(r for r in cert['raw_models'] if r['support_mask']==support and r['branch_c99']==branch)
  expected=next(r for r in cert['combined_models'] if r['support_mask']==support and r['branch']==branch)
  free=sorted(set(range(116))-{0,99,113,115}-({57} if branch else set()));assert free==raw['free_indices']
  origin=(1<<0)|(1<<99) if branch else 0;O=offset^(pair_words[0]^pair_words[99] if branch else 0);cb=[];basis=[]
  for j in free:
   c=(1<<j)^((1<<0) if j in L else 0)
   if branch:
    if j in K:c^=(1<<57)|(1<<113)
   elif j==57:c^=1<<113
   cb.append(c);word=0
   for k in range(116):
    if c>>k&1:word^=pair_words[k]
   basis.append(word)
  assert O.bit_count()%4==0
  assert all(w.bit_count()%2==0 and (w.bit_count()-2*(w&O).bit_count())%4==0 for w in basis)
  assert all((v&w).bit_count()%2==0 for v,w in combinations(basis,2))
  P=set()
  if (branch+O.bit_count()//4)%2:toggle(P,0)
  for i,w in enumerate(basis):
   if (w.bit_count()-2*(w&O).bit_count())//4%2:toggle(P,1<<free[i])
  for i,j in combinations(range(len(free)),2):
   inter=basis[i]&basis[j]
   if (inter.bit_count()//2+(inter&O).bit_count())%2:toggle(P,(1<<free[i])|(1<<free[j]))
  for i,j,k in combinations(range(len(free)),3):
   if (basis[i]&basis[j]&basis[k]).bit_count()%2:toggle(P,(1<<free[i])|(1<<free[j])|(1<<free[k]))
  assert P=={int(m,16) for m in raw['monomials_hex']}
  def form(group):
   mask=sum(1<<j for j in group)
   return {(1<<j) for j,c in zip(free,cb) if (c&mask).bit_count()%2}^({0} if (origin&mask).bit_count()%2 else set())
  Q=form(factor['linear'])
  for block in factor['products']:
   for a in form(block['I']):
    for b in form(block['J']):toggle(Q,a|b)
  assert (1<<23) in Q and all(not m>>23&1 for m in Q if m.bit_count()>1);Q.remove(1<<23)
  R=substitute(P,23,Q)
  G={1<<j for j in seventh['R']}
  if branch==0:
   for j in seventh['M']+K:toggle(G,1<<j)
   for j in K:toggle(G,(1<<57)|(1<<j))
  assert (1<<5) in G and all(not m>>5&1 for m in G if m.bit_count()>1);G.remove(1<<5)
  R=substitute(R,5,G);assert R=={int(m,16) for m in expected['polynomial_hex']};total_terms+=len(P)+len(R)
  rng=random.Random(int(support,16)+branch)
  for sample in range(32):
   z=rng.getrandbits(116)&sum(1<<j for j in free if j not in [5,23]);z|=evaluate(G,z)<<5;z|=evaluate(Q,z)<<23;c=origin
   for j,coefficient in zip(free,cb):
    if z>>j&1:c^=coefficient
   word=full_offset
   for j in range(116):
    if c>>j&1:word^=truth_words[j]
   h=4096-2*word.bit_count();assert h%16==0
   assert (h//16)%2==evaluate(R,z);direct+=1
  print(support,'branch',branch,'complete coefficient reconstruction PASS',flush=True)
print(json.dumps({'verification':'PASS','original_ANF_checks':direct,'reconstructed_coefficient_terms':total_terms,'seconds':time.perf_counter()-start,'scope':'Complete periodic second-bit models after first five and seventh conditions, with original-ANF spot checks. No global nonexistence claim.'},indent=2))
