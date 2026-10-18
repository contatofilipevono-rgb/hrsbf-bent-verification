"""Exact small quadratic condition at support 0x7777, after only three T20 laws."""
import sys,json,time
from pathlib import Path
from itertools import combinations
base=Path(__file__).resolve().parent
certificate=json.loads((base/'T28_SEXTA_CERTIFICADO.json').read_text())
def setup(n):
 seen=set();gs=[]
 for t in combinations(range(n),4):
  m=sum(1<<j for j in t)
  if m in seen:continue
  orb=set();r=m
  for _ in range(n):orb.add(r);r=((r<<1)&65535)|(r>>15)
  seen|=orb;gs.append((orb,0))
 return gs,None,None
gs,_,_=setup(16);small=[v for v in range(256) if v&0x77==v];points=[v|(w<<8) for v in small for w in small if v<w];assert len(points)==2016
words=[sum((sum((x&m)==m for m in orb)%2)<<k for k,x in enumerate(points)) for orb,_ in gs];O=sum((x.bit_count()%2)<<k for k,x in enumerate(points));L=[0,4,8,14,18,22,42,46,52,56,71,81,85,94,98,106]
free=sorted(set(range(116))-{99,113,115});cb=[];basis=[]
for j in free:
 c=(1<<j)^((1<<113) if j==57 else 0)^((1<<99) if j in L else 0);cb.append(c);word=0
 for k in range(116):
  if c>>k&1:word^=words[k]
 basis.append(word)
assert O.bit_count()%4==0
assert all(w.bit_count()%2==0 and (w.bit_count()-2*(w&O).bit_count())%4==0 for w in basis)
assert all((v&w).bit_count()%2==0 for v,w in combinations(basis,2))
P=set()
def toggle(m):
 if m in P:P.remove(m)
 else:P.add(m)
if O.bit_count()//4%2:toggle(0)
for i,w in enumerate(basis):
 if (w.bit_count()-2*(w&O).bit_count())//4%2:toggle(1<<free[i])
for i,j in combinations(range(len(free)),2):
 inter=basis[i]&basis[j]
 if (inter.bit_count()//2+(inter&O).bit_count())%2:toggle((1<<free[i])|(1<<free[j]))
for i,j,k in combinations(range(len(free)),3):
 if (basis[i]&basis[j]&basis[k]).bit_count()%2:toggle((1<<free[i])|(1<<free[j])|(1<<free[k]))
factor=certificate['fourth_factorization'];K=[j for j in certificate['fifth_factorization']['I'] if j!=57];M=factor['products'][2]['I']+factor['products'][2]['J'];R=[5,6,7,16,17,19,43,44,49,50,51,58,59,62,63,66,82,84,87,95,100,102,105,108]
expected=set(1<<j for j in R+M+K)
for A,B in [(L,M),([57],K)]:
 for i in A:
  for j in B:
   m=(1<<i)|(1<<j)
   if m in expected:expected.remove(m)
   else:expected.add(m)
assert P==expected
print('PASS',len(P),'degree',max(m.bit_count() for m in P))
report={'support_mask':'0x7777','after_three_T20_laws':True,'R':R,'M':M,'K':K,'L':L,'factorization':'R + (1+c99)*M + (1+c57)*K','monomials_hex':[hex(m) for m in sorted(P)],'terms':len(P),'degree':max(m.bit_count() for m in P),'isolated_free_coordinate':5,'exact_pass_fraction_after_first_five':'3/128','combined_pass_upper_bound_using_T30':'9/512','scope':'Complete coefficient reconstruction. Full independent verifier and publication update still pending.'}
# Verify the diagonal identity on every independent basis direction.
diagonal=[sum((sum((v|(v<<8))&m==m for m in orb)%2)<<i for i,v in enumerate(small)) for orb,_ in gs]
for j in range(116):
 if j not in [57,99,113,115]:assert diagonal[j]==0
Da=diagonal[57]^diagonal[113];Db=diagonal[99]
assert [64-2*((Da if a else 0)^(Db if b else 0)).bit_count() for a,b in [(0,0),(0,1),(1,0),(1,1)]]==[64,32,32,0]
assert all(5 not in p[side] for p in factor['products'] for side in ['I','J'])
assert 5 not in factor['linear']+L+K+M+[57,99,113,115] and 5 in R
def derivative(poly,d):
 out=set()
 for m in poly:
  sub=m&d
  while sub:
   t=m^sub
   if t in out:out.remove(t)
   else:out.add(t)
   sub=(sub-1)&(m&d)
 return out
assert derivative(P,1<<75)==set()
assert derivative(P,sum(1<<j for j in [42,81,94,106]))==set()
import random
rng=random.Random(2026101731);truth_words=[]
allpoints=[v|(w<<8) for v in small for w in small]
for orb,_ in gs:truth_words.append(sum((sum((x&m)==m for m in orb)%2)<<k for k,x in enumerate(allpoints)))
chi=sum((x.bit_count()%2)<<k for k,x in enumerate(allpoints))
for sample in range(256):
 z=rng.getrandbits(116)&sum(1<<j for j in free);c=0
 for j,coef in zip(free,cb):
  if z>>j&1:c^=coef
 word=chi
 for j in range(116):
  if c>>j&1:word^=truth_words[j]
 h=4096-2*word.bit_count();assert h%16==0
 assert (h//16)%2==sum((z&m)==m for m in P)%2
report['original_ANF_checks']=256
report['verification']='PASS'
report['scope']='Complete polynomial reconstruction, diagonal and divisibility checks, exact halving by c5, and preservation of the two T30 directions. T30 supplies the combined seven-condition bound.'
print(json.dumps(report,indent=2))
