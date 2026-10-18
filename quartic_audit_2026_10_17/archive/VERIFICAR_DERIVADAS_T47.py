def percent_lower(q):
 """A displayed decimal lower bound; exact fractions remain authoritative."""
 import math as _math
 from fractions import Fraction as _Fraction
 exact=100*q;v=float(exact)
 while _Fraction(str(v))>exact:v=_math.nextafter(v,-_math.inf)
 return v

def percent_upper(q):
 import math as _math
 from fractions import Fraction as _Fraction
 exact=100*q;v=float(exact)
 while _Fraction(str(v))<exact:v=_math.nextafter(v,_math.inf)
 return v

"""Independent finite-difference rank verification for the T43 refinement."""
from pathlib import Path
from fractions import Fraction
from collections import Counter
import json,time
base=Path(__file__).resolve().parent;start=time.perf_counter()
cases=json.loads((base/'T47_DERIVADAS_CERTIFICADO.json').read_text())['cases'];refined=json.loads((base/'T47_LIMITE_CERTIFICADO.json').read_text());previous=json.loads((base/'T44_LIMITE_CERTIFICADO.json').read_text());support_reference=json.loads((base/'T40_LIMITE_CERTIFICADO.json').read_text());models=json.loads((base/'T35_POLINOMIOS_CERTIFICADO.json').read_text())['combined_models']+json.loads((base/'T40_MODELOS_CERTIFICADO.json').read_text())['models']
def toggle(P,m):
 if m in P:P.remove(m)
 else:P.add(m)
def restrict(P,C,value):
 selected=sum(1<<j for j in C);ones=sum(((value>>i)&1)<<j for i,j in enumerate(C));zeros=selected^ones;out=set()
 for m in P:
  if not m&zeros:toggle(out,m&~selected)
 return out
def derivative(P,d):
 out=set()
 for m in P:
  sub=m&d
  while sub:toggle(out,m^sub);sub=(sub-1)&(m&d)
 return out
def rank_low(rows):
 B={}
 for v in rows:
  while v:
   p=(v&-v).bit_length()-1
   if p in B:v^=B[p]
   else:B[p]=v;break
 return len(B)
matrix_checks=0;direction_checks=0;seen=set()
for case in cases:
 branch=case['branch'];character=case['character'];condition=case['conditioning_coordinates'];value=case['condition_value'];key=(branch,character,value);assert key not in seen;seen.add(key)
 supports=support_reference['branches'][branch]['supports'];P=set()
 for j,support in enumerate(supports):
  if character>>j&1:P^={int(m,16) for m in next(r for r in models if r['branch']==branch and r['support_mask']==support)['polynomial_hex']}
 P=restrict(P,condition,value);assert all(m.bit_count()<=4 for m in P)
 free=sorted(set(range(116))-{0,5,23,99,113,115}-({57} if branch else set())-set(condition));assert free==case['free_indices'];index={j:i for i,j in enumerate(free)};mask=sum(1<<j for j in free)
 directions=[int(d,16) for d in case['directions_hex']];k=case['subspace_dimension'];assert k==16 and len(directions)==k and rank_low(directions)==k
 matrices=[]
 for d,stored in zip(directions,case['matrices_hex']):
  assert d&mask==d;D=derivative(P,d);assert all(m.bit_count()<=2 for m in D);rows=[0]*len(free)
  for m in D:
   if m.bit_count()==2:
    a=m&-m;b=m^a;i=index[a.bit_length()-1];j=index[b.bit_length()-1];rows[i]^=1<<j;rows[j]^=1<<i
  assert rows==[int(v,16) for v in stored];matrices.append(rows);direction_checks+=1
 hist=Counter();current=[0]*len(free);old=0
 for ordinal in range(1,1<<k):
  gray=ordinal^(ordinal>>1);changed=(gray^old).bit_length()-1;current=[a^b for a,b in zip(current,matrices[changed])];r=rank_low(current);assert r%2==0;hist[r]+=1;old=gray
 assert dict(hist)=={int(r):count for r,count in case['rank_histogram'].items()} and sum(hist.values())==(1<<k)-1;matrix_checks+=sum(hist.values())
 squared=(1+sum(Fraction(count,2**(r//2)) for r,count in hist.items()))/Fraction(1<<k);assert squared==Fraction(*case['squared_bias_upper_bound']);beta=Fraction(*case['bias_upper_bound']);assert 0<=beta<=1 and beta*beta>=squared
 print('branch',branch,'character',character,'condition',value,'all derivative ranks PASS',flush=True)
total=Fraction(0)
for old_branch,new_branch in zip(previous['branches'],refined['branches']):
 assert old_branch['branch']==new_branch['branch'];amplitudes=Fraction(0)
 assert [r['combination'] for r in old_branch['characters']]==[r['combination'] for r in new_branch['characters']]
 for old,new in zip(old_branch['characters'],new_branch['characters']):
  old_amp=Fraction(*old['selected_amplitude']);assert old_amp==Fraction(*new['old_amplitude']) and old['symmetry_orbit']==new['symmetry_orbit'];selected_cases=[c for c in cases if c['branch']==old_branch['branch'] and c['character']==old['combination']]
  if selected_cases:
   C=selected_cases[0]['conditioning_coordinates'];assert all(c['conditioning_coordinates']==C for c in selected_cases) and sorted(c['condition_value'] for c in selected_cases)==list(range(1<<len(C)))
   new_amp=sum(Fraction(*c['bias_upper_bound']) for c in selected_cases)/len(selected_cases);assert new_amp==Fraction(*new['new_amplitude']);selected=min(old_amp,new_amp)
  else:assert new['new_amplitude'] is None;selected=old_amp
  assert selected==Fraction(*new['selected_amplitude']);amplitudes+=len(new['symmetry_orbit'])*selected
 upper=(1+amplitudes)/128;assert upper==Fraction(*new_branch['conditional_pass_upper_bound']);total+=upper/Fraction(64 if old_branch['branch']==0 else 128)
assert total==Fraction(*refined['global_pass_upper_bound']) and 1-total==Fraction(*refined['global_excluded_lower_bound'])
print(json.dumps({'verification':'PASS','quadratic_derivative_matrices_rebuilt':direction_checks,'nonzero_difference_matrices_rank_checked':matrix_checks,'conditioned_cases':len(cases),'global_pass_upper_bound':str(total),'global_excluded_lower_bound':str(1-total),'excluded_percent_lower_bound':percent_lower(1-total),'seconds':time.perf_counter()-start,'scope':'Finite-difference refinement of the thirteen-condition bound. Every matrix rank enumerated independently with low pivots; rational square-root bounds checked exactly. No nonexistence claim.'},indent=2))
