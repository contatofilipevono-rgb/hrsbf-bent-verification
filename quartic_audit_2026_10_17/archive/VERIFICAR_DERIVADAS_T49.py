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
cases=json.loads((base/'T49_DERIVADAS_CERTIFICADO.json').read_text())['cases'];refined=json.loads((base/'T49_LIMITE_CERTIFICADO.json').read_text());previous=json.loads((base/'T47_LIMITE_CERTIFICADO.json').read_text());support_reference=json.loads((base/'T40_LIMITE_CERTIFICADO.json').read_text());models=json.loads((base/'T35_POLINOMIOS_CERTIFICADO.json').read_text())['combined_models']+json.loads((base/'T40_MODELOS_CERTIFICADO.json').read_text())['models']+json.loads((base/'T48_SOMA_INVARIANTE_CERTIFICADO.json').read_text())['models']
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
 supports=support_reference['branches'][branch]['supports']+['normalizer_sum_27ff'];P=set()
 for j,support in enumerate(supports):
  if character>>j&1:P^={int(m,16) for m in next(r for r in models if r['branch']==branch and r['support_mask']==support)['polynomial_hex']}
 linear_forms=case.get('conditioning_linear_forms',[])
 assert linear_forms==[[1,9,15,28,53,67,76,103],[2,10,25,37,54,68,83,104],[13,21,38,70,74,93,97,109]][:len(linear_forms)] and len(linear_forms)<=3 and condition==([57] if branch==0 else [])
 P=restrict(P,condition,value&((1<<len(condition))-1))
 for fi,form in enumerate(linear_forms):
  pivot=form[0];replacement={1<<j for j in form[1:]};out=set()
  if value>>(len(condition)+fi)&1:replacement.add(0)
  for m in P:
   if m>>pivot&1:
    for term in replacement:toggle(out,(m^(1<<pivot))|term)
   else:toggle(out,m)
  P=out
 assert all(m.bit_count()<=4 for m in P)
 free=sorted(set(range(116))-{0,5,23,99,113,115}-({57} if branch else set())-set(condition)-{form[0] for form in linear_forms});assert free==case['free_indices'];index={j:i for i,j in enumerate(free)};mask=sum(1<<j for j in free)
 directions=[int(d,16) for d in case['directions_hex']];k=case['subspace_dimension'];assert k==14 and len(directions)==k and rank_low(directions)==k
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
total=Fraction(0);used=set()
for old,reference,new_branch in zip(previous['branches'],support_reference['branches'],refined['branches']):
 branch=old['branch'];assert branch==reference['branch']==new_branch['branch'];amplitudes=Fraction(0)
 expected=[(128,[128])]+[(128|r['combination'],[128|v for v in r['symmetry_orbit']]) for r in reference['characters']]
 assert len(new_branch['new_characters'])==len(expected)==44
 for (character,orbit),stored in zip(expected,new_branch['new_characters']):
  assert stored['combination']==character and stored['symmetry_orbit']==orbit
  selected=[c for c in cases if c['branch']==branch and c['character']==character];assert selected
  C=selected[0]['conditioning_coordinates'];forms=selected[0]['conditioning_linear_forms']
  assert all(c['conditioning_coordinates']==C and c['conditioning_linear_forms']==forms for c in selected)
  assert sorted(c['condition_value'] for c in selected)==list(range(1<<(len(C)+len(forms))))
  used.update((branch,character,c['condition_value']) for c in selected)
  amplitude=sum(Fraction(*c['bias_upper_bound']) for c in selected)/len(selected)
  assert amplitude==Fraction(*stored['average_bias_upper_bound']);amplitudes+=len(orbit)*amplitude
 old_upper=Fraction(*old['conditional_pass_upper_bound']);assert old_upper==Fraction(*new_branch['old_conditional_pass_upper_bound'])
 raw=(128*old_upper+amplitudes)/256;upper=min(old_upper,raw)
 assert raw==Fraction(*new_branch['character_expansion_upper_bound']) and upper==Fraction(*new_branch['conditional_pass_upper_bound'])
 total+=upper/Fraction(64 if branch==0 else 128)
assert used==seen and total==Fraction(*refined['global_pass_upper_bound']) and 1-total==Fraction(*refined['global_excluded_lower_bound'])
print(json.dumps({'verification':'PASS','quadratic_derivative_matrices_rebuilt':direction_checks,'nonzero_difference_matrices_rank_checked':matrix_checks,'conditioned_cases':len(cases),'new_character_orbits':88,'global_pass_upper_bound':str(total),'global_excluded_lower_bound':str(1-total),'excluded_percent_lower_bound':percent_lower(1-total),'seconds':time.perf_counter()-start,'scope':'Fourteen necessary conditions. New invariant character and all affine fibers included; upstream T40/T43/T44/T47/T48 checks required. No global nonexistence claim.'},indent=2))
