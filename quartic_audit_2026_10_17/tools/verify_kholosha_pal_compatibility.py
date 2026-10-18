from pathlib import Path
import json,collections,hashlib

def rotate(x,n):return ((x<<1)&((1<<n)-1))|(x>>(n-1))
def orbits(n):
 seen=set();out=[]
 for x in range(1<<n):
  if x in seen:continue
  o=[];y=x
  while y not in o:o.append(y);seen.add(y);y=rotate(y,n)
  out.append(o)
 return out

def fwht(t):
 t=t[:];h=1
 while h<len(t):
  for i in range(0,len(t),2*h):
   for j in range(i,i+h):a,b=t[j],t[j+h];t[j],t[j+h]=a+b,a-b
  h*=2
 return t

report={'scope':'Counterexample to the proposed implication, not to the homogeneous-quartic conjecture.','counterexamples':[],'cyclic_sign_capacity':[]}
for m in [2,3,4,6]:
 n=2*m;mask=(1<<m)-1
 def f(x):return ((x&mask)&(x>>m)).bit_count()%2
 table=[(-1)**f(x) for x in range(1<<n)]
 w=fwht(table)
 assert all(abs(x)==1<<m for x in w)
 assert all(f(rotate(x,n))==f(x) for x in range(1<<n))
 assert all(f(z|(z<<m))==z.bit_count()%2 for z in range(1<<m))
 left=sum((-1)**f(z|(z<<m)) for z in range(1<<m))
 right=sum(w[z|(z<<m)] for z in range(1<<m))
 assert (1<<m)*left==right==0
 report['counterexamples'].append({'m':m,'n':n,'walsh_values':sorted(set(w)),'rotation_invariant':True,'restriction':'sum_i z_i','self_dual_poisson_sides':[left,right//(1<<m)]})
for m in [6,8]:
 oo=orbits(m);possible={0}
 for orbit in oo:possible={v+s*len(orbit) for v in possible for s in [-1,1]}
 expected=set(range(-(1<<m),(1<<m)+1,2))
 assert possible==expected
 report['cyclic_sign_capacity'].append({'m':m,'orbit_length_multiplicities':dict(sorted(collections.Counter(map(len,oo)).items())),'possible_signed_sums':len(possible),'exactly_all_even_values_in_range':True,'range':[-(1<<m),1<<m]})
(Path(__file__).resolve().parent.parent/'reports/KHOLOSHA_PAL_COMPATIBILITY_TESTS.json').write_text(json.dumps(report,indent=2),encoding='utf-8')
print(json.dumps(report,indent=2))
