from itertools import combinations
from pathlib import Path
import json

def rank(vs):
 piv={}
 for x in vs:
  while x:
   k=x.bit_length()-1
   if k in piv:x^=piv[k]
   else:piv[k]=x;break
 return len(piv)
def wedge(A,B):
 out=set()
 for a in A:
  for b in B:
   if not a&b:
    if a|b in out:out.remove(a|b)
    else:out.add(a|b)
 return out
def remainder(a,b):
 while a.bit_length()>=b.bit_length():a^=b<<(a.bit_length()-b.bit_length())
 return a
def irreducibles(d):
 return [p for p in range((1<<d)|1,1<<(d+1),2) if all(remainder(p,q) for k in range(1,d//2+1) for q in range(1<<k,1<<(k+1)))]
def reg(p,off=0):
 m=p.bit_length()-1;A=set();B=set()
 edge=lambda i,j:(1<<(off+i))|(1<<(off+j))
 for i in range(m):A.add(edge(i,m+i))
 for j in range(m-1):B.add(edge(j+1,m+j))
 for i in range(m):
  if p>>i&1:B.add(edge(i,2*m-1))
 return A,B,2*m
def audit(label,blocks,L1=False):
 A=set();B=set();n=0
 for p in blocks:
  a,b,k=reg(p,n);A|=a;B|=b;n+=k
 if L1:A.add((1<<n)|(1<<(n+1)));B.add((1<<(n+1))|(1<<(n+2)));n+=3
 def prank(W):
  rows=[0]*n
  for m in W:
   i,j=[i for i in range(n) if m>>i&1];rows[i]^=1<<j;rows[j]^=1<<i
  return rank(rows)
 ranks=[prank(W) for W in [A,B,A^B]]
 assert ranks==[10]*3
 M3=[sum(1<<i for i in c) for c in combinations(range(n),3)];idx3={m:i for i,m in enumerate(M3)}
 T=wedge(A,B);images=[wedge(T,{m}) for m in M3];rows={m:i for i,m in enumerate(sorted(set().union(*images)))}
 cols=[sum(1<<rows[m] for m in image) for image in images]
 ker=len(M3)-rank(cols)
 generators=[wedge(W,{1<<i}) for W in [A,B] for i in range(n)]
 assert all(not wedge(T,g) for g in generators)
 sp=rank([sum(1<<idx3[m] for m in g) for g in generators])
 out={'label':label,'polynomial_bits':blocks,'L1':L1,'n':n,'ranks':ranks,'kernel':ker,'span':sp,'K':ker==sp};print(json.dumps(out),flush=True);return out
p2=irreducibles(2);p3=irreducibles(3);p4=irreducibles(4);p5=irreducibles(5)
assert [len(p2),len(p3),len(p4),len(p5)]==[1,2,3,6]
res=[]
for p in p5:res.append(audit('regular_degree5_'+str(p),[p]))
for p in p3:res.append(audit('regular_degree2_plus3_'+str(p),[p2[0],p]))
for p in p4:res.append(audit('regular_degree4_plusL1_'+str(p),[p],True))
p2_squared=sum(1<<(2*i) for i in range(3) if p2[0]>>i&1)
res.append(audit('regular_degree2_power2_plusL1',[p2_squared],True))
res.append(audit('regular_two_degree2_plusL1',[p2[0],p2[0]],True))
assert len(res)==13
Path(__file__).with_suffix('.json').write_text(json.dumps({'irreducibles':{'2':p2,'3':p3,'4':p4,'5':p5},'cases':res},indent=2))
