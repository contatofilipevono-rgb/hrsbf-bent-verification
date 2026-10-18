"""Independent original-ANF checks of the reduced sixth condition; standard Python."""
import json,random,time
from pathlib import Path
from itertools import combinations
base=Path(__file__).resolve().parent
certificate=json.loads((base/'T28_SEXTA_CERTIFICADO.json').read_text())
start=time.perf_counter();seen=set();orbits=[]
def rotate(m):return ((m<<1)&65535)|(m>>15)
for subset in combinations(range(16),4):
 m=sum(1<<j for j in subset)
 if m in seen:continue
 orb=[];r=m
 while r not in orb:orb.append(r);r=rotate(r)
 seen.update(orb);orbits.append(orb)
assert len(orbits)==116
points=[v|(w<<8) for v in range(64) for w in range(64)]
words=[]
for orb in orbits:
 word=0
 for k,x in enumerate(points):
  if sum((x&m)==m for m in orb)%2:word|=1<<k
 words.append(word)
signword=sum((x.bit_count()%2)<<k for k,x in enumerate(points))
L=[0,4,8,14,18,22,42,46,52,56,71,81,85,94,98,106]
factor=certificate['fourth_factorization']
K=[j for j in certificate['fifth_factorization']['I'] if j!=57]
data=certificate['reduced_models'];reports=[]
def parity(c,indices):return sum((c>>j)&1 for j in indices)%2
def q4(c):return (parity(c,factor['linear'])+sum(parity(c,p['I'])*parity(c,p['J']) for p in factor['products']))%2
for rec in data['branches']:
 b=rec['branch'];excluded={0,23,99,113,115}|({57} if b else set());free=sorted(set(range(116))-excluded)
 poly=[int(m,16) for m in rec['polynomial_hex']];assert len(poly)==len(set(poly))
 assert max(m.bit_count() for m in poly)==4 and poly
 assert all(not any(m>>j&1 for j in excluded) for m in poly)
 rng=random.Random(128376+b);hist=[0,0];examples=[]
 for sample in range(256):
  z=rng.getrandbits(116)&sum(1<<j for j in free);c=z
  if b:c|=1<<99;c|=parity(c,K)<<57
  c|=(b^parity(c,L))<<0;c|=((c>>57)&1)<<113
  c|=q4(c)<<23
  assert ((c>>99)&1)==parity(c,L) and q4(c)==0
  assert not b or (parity(c,K)^((c>>57)&1))==0
  word=signword
  for j in range(116):
   if c>>j&1:word^=words[j]
  h=4096-2*word.bit_count();assert h%16==0
  value=sum((z&m)==m for m in poly)%2
  assert value==(h//16)%2
  hist[value]+=1
  if len(examples)<4:examples.append({'coefficient_hex':hex(c),'h_u':h,'next_bit':value})
 reports.append({'branch_c99':b,'free_dimension':len(free),'degree':4,'monomials':len(poly),'direct_original_ANF_checks':256,'random_histogram_not_global_density':hist,'examples':examples})
# Complete coefficient reconstruction, not random interpolation.
pair_positions=[v*64+w for v in range(64) for w in range(v+1,64)]
pair_words=[sum(((word>>pos)&1)<<k for k,pos in enumerate(pair_positions)) for word in words]
offset=sum(((points[pos].bit_count())%2)<<k for k,pos in enumerate(pair_positions))
diagonal_words=[sum(((word>>(v*64+v))&1)<<v for v in range(64)) for word in words]
Da=diagonal_words[57]^diagonal_words[113];Db=diagonal_words[99]
for j in range(116):
 if j not in [57,99,113,115]:assert diagonal_words[j]==0
for a in range(2):
 for b in range(2):assert 64-2*((Da if a else 0)^(Db if b else 0)).bit_count()==16*(4-2*a-3*b)
def toggle(p,m):
 if m in p:p.remove(m)
 else:p.add(m)
coefficient_checks=0;restriction_checks=[]
for branch,raw,reduced,restriction in zip(range(2),certificate['branch_models']['branches'],data['branches'],certificate['quadratic_restrictions']):
 free=raw['free_indices'];origin=(1<<0)|(1<<99) if branch else 0
 O=offset^(pair_words[0]^pair_words[99] if branch else 0);basis=[];coefficient_basis=[]
 for j in free:
  c=(1<<j)^((1<<0) if j in L else 0)
  if branch:
   if j in K:c^=(1<<57)|(1<<113)
  elif j==57:c^=1<<113
  coefficient_basis.append(c);w=0
  for k in range(116):
   if c>>k&1:w^=pair_words[k]
  basis.append(w)
 assert O.bit_count()%4==0
 assert all(w.bit_count()%2==0 and (w.bit_count()-2*(O&w).bit_count())%4==0 for w in basis)
 assert all((v&w).bit_count()%2==0 for v,w in combinations(basis,2))
 P=set()
 if (branch+O.bit_count()//4)%2:toggle(P,0)
 for i,w in enumerate(basis):
  if ((w.bit_count()-2*(O&w).bit_count())//4)%2:toggle(P,1<<free[i])
 for i,j in combinations(range(len(free)),2):
  intersection=basis[i]&basis[j]
  if (intersection.bit_count()//2+(O&intersection).bit_count())%2:toggle(P,(1<<free[i])|(1<<free[j]))
 for i,j,k in combinations(range(len(free)),3):
  if (basis[i]&basis[j]&basis[k]).bit_count()%2:toggle(P,(1<<free[i])|(1<<free[j])|(1<<free[k]))
 assert P==set(int(m,16) for m in raw['monomials_hex'])
 def form(indices):
  mask=sum(1<<j for j in indices)
  return {(1<<j) for j,c in zip(free,coefficient_basis) if (c&mask).bit_count()%2} ^ ({0} if (origin&mask).bit_count()%2 else set())
 Q=form(factor['linear'])
 for block in factor['products']:
  for a in form(block['I']):
   for b in form(block['J']):toggle(Q,a|b)
 assert (1<<23) in Q and all(not m>>23&1 for m in Q if m.bit_count()>1)
 Q.remove(1<<23);R=set()
 for m in P:
  if m>>23&1:
   for n in Q:toggle(R,(m^(1<<23))|n)
  else:toggle(R,m)
 assert R==set(int(m,16) for m in reduced['polynomial_hex'])
 coefficient_checks+=len(P)+len(R)
 S=restriction['coordinates'];mask=sum(1<<j for j in S)
 assert all((m&mask).bit_count()<=1 for m in R if m.bit_count()>2)
 quadratic={m for m in R if m.bit_count()==2 and m&mask==m}
 values=[]
 for z in range(1<<len(S)):
  assignment=sum(((z>>i)&1)<<j for i,j in enumerate(S))
  values.append(sum((assignment&m)==m for m in quadratic)%2)
 weights=[sum(value^((z&linear).bit_count()%2) for z,value in enumerate(values)) for linear in range(1<<len(S))]
 minimum=min(min(weights),len(values)-max(weights))
 numerator,denominator=restriction['violation_fraction_lower_bound']
 assert minimum*denominator==len(values)*numerator
 restriction_checks.append({'branch':branch,'dimension':len(S),'affine_restrictions_exhaustively_checked':2*(1<<len(S)),'minimum_ones':minimum,'subcube_size':len(values)})
assert restriction_checks[0]['minimum_ones']*4==restriction_checks[0]['subcube_size']
assert restriction_checks[1]['minimum_ones']*8==3*restriction_checks[1]['subcube_size']
print('Complete polynomial reconstruction PASS:',coefficient_checks,'coefficient terms; subcube certificates:',restriction_checks)

report={'branches':reports,'total_original_ANF_checks':512,'method':'independently reconstructed cyclic quartic orbits and direct signed sum over all 4096 points in support 0x3f3f; no branch coefficient basis or orbit-pair identity used','rigorous_global_candidate_fraction_upper_bound':'17/512','rigorous_global_excluded_fraction_lower_bound':'495/512','scope':'certified quadratic-subcube minimum weights; no exact sixth-condition density or nonexistence claim','seconds':time.perf_counter()-start}
print(json.dumps(report),flush=True)
