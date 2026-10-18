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

"""Character-specific slice certificate with exact equation-span checks."""
import json,time,subprocess,sys
from pathlib import Path
from fractions import Fraction
base=Path(__file__).resolve().parent;start=time.perf_counter()
certificate=json.loads((base/'T55_CERTIFICADO_MISTO.json').read_text())
models=json.loads((base/'T35_POLINOMIOS_CERTIFICADO.json').read_text())['combined_models']+json.loads((base/'T40_MODELOS_CERTIFICADO.json').read_text())['models']
def toggle(P,m):
 if m in P:P.remove(m)
 else:P.add(m)
def rank(rows):
 B={}
 for v in rows:
  while v:
   j=v.bit_length()-1
   if j in B:v^=B[j]
   else:B[j]=v;break
 return len(B)
def polynomial_rank(rows):
 features=sorted(set().union(*rows));index={m:i for i,m in enumerate(features)}
 return rank([sum(1<<index[m] for m in row) for row in rows])
def derivative(P,d):
 out=set()
 for m in P:
  sub=m&d
  while sub:toggle(out,m^sub);sub=(sub-1)&(m&d)
 return out
def restrict(P,coordinates,value):
 selected=sum(1<<j for j in coordinates);ones=sum(((value>>i)&1)<<j for i,j in enumerate(coordinates));zeros=selected^ones;out=set()
 for m in P:
  if not m&zeros:toggle(out,m&~selected)
 assert all(m.bit_count()<=2 for m in out)
 return out
def combination(rows,c):
 assert c>=0 and not c>>len(rows)
 P=set()
 for j,row in enumerate(rows):
  if c>>j&1:P^=row
 return P

def symplectic_bias(P):
 # A different algorithm from the generating certificate: symplectic Gram-Schmidt.
 variables=sorted({j for m in P for j in range(116) if m>>j&1})
 adjacency={j:0 for j in variables}
 for m in P:
  assert m.bit_count()<=2
  if m.bit_count()==2:
   a=m&-m;b=m^a;adjacency[a.bit_length()-1]^=b;adjacency[b.bit_length()-1]^=a
 def polar(a,b):
  image=0
  while a:
   bit=a&-a;image^=adjacency[bit.bit_length()-1];a^=bit
  return (image&b).bit_count()%2
 constant=int(0 in P)
 def q(v):return sum((v&m)==m for m in P)%2^constant
 vectors=[1<<j for j in variables];pairs=0;sign=constant
 while True:
  pair=next(((i,j) for i in range(len(vectors)) for j in range(i+1,len(vectors)) if polar(vectors[i],vectors[j])),None)
  if pair is None:break
  i,j=pair;e=vectors[i];f=vectors[j];sign^=q(e)*q(f);pairs+=1
  vectors=[v^(e if polar(v,f) else 0)^(f if polar(v,e) else 0) for k,v in enumerate(vectors) if k not in pair]
 if any(q(v) for v in vectors):return Fraction(0)
 return Fraction(-1 if sign else 1,2**pairs)

symmetry=json.loads((base/'T40_SIMETRIA_CERTIFICADO.json').read_text())
subprocess.run([sys.executable,str(base/'VERIFICAR_SIMETRIA_T40.py')],capture_output=True,text=True,check=True)
representatives=[min(o) for o in symmetry['character_orbits']]
from collections import Counter
def verify_slice(character,polys):
 global checks,equation_reductions
 choice=character['combination'];P=combination(polys,choice);S=character['coordinates'];mask=sum(1<<j for j in S)
 assert len(S)==len(set(S)) and all((m&mask).bit_count()<=1 for m in P if m.bit_count()>2)
 polar=[sum((((1<<i)|(1<<j)) in P)<<k for k,j in enumerate(S) if i!=j) for i in S];r=rank(polar);assert r==character['polar_rank']
 directions=[int(v,16) for v in character['directions_hex']]
 assert rank(directions)==len(directions)==len(S)-r and all(d&mask==d for d in directions)
 D=[]
 for d,row in zip(directions,character['polynomials_hex']):
  value=derivative(P,d);assert value=={int(m,16) for m in row};assert all(not m&mask for m in value);D.append(value)
 assert len(D)==len(directions)
 preselection=character.get('selected_radical_equation_combinations')
 if preselection is not None:D=[combination(D,int(c,16)) for c in preselection]
 condition=character['conditioning_coordinates'];assert len(condition)==len(set(condition)) and all(not mask>>j&1 for j in condition)
 cases=character['conditioned_cases'];assert [v['condition_value'] for v in cases]==list(range(1<<len(condition)))
 Z=Fraction(0)
 for case in cases:
  rows=[restrict(row,condition,case['condition_value']) for row in D];equation_reductions+=1
  if case['inconsistent_equation_combination'] is not None:
   assert combination(rows,int(case['inconsistent_equation_combination'],16))=={0};assert Fraction(*case['zero_fraction'])==0;continue
  basis=[combination(rows,int(c,16)) for c in case['equation_basis_combinations']]
  assert polynomial_rank(basis)==len(basis)==polynomial_rank(rows)
  values=case['quadratic_biases'];assert len(values)==1<<len(basis);summation=Fraction(0)
  for index,expected in enumerate(values):
   Q=combination(basis,index);actual=symplectic_bias(Q);assert actual==Fraction(*expected);summation+=actual;checks+=1
  z=summation/Fraction(1<<len(basis));assert 0<=z<=1 and z==Fraction(*case['zero_fraction']);Z+=z/Fraction(len(cases))
 assert Z==Fraction(*character['radical_zero_fraction'])
 amplitude=Z/Fraction(2**(r//2));assert amplitude==Fraction(*character['average_absolute_slice_bias'])
 return amplitude
def rank_low(rows):
 B={}
 for v in rows:
  while v:
   p=(v&-v).bit_length()-1
   if p in B:v^=B[p]
   else:B[p]=v;break
 return len(B)
def restrict_general(P,C,value):
 selected=sum(1<<j for j in C);ones=sum(((value>>i)&1)<<j for i,j in enumerate(C));zeros=selected^ones;result=set()
 for m in P:
  if not m&zeros:toggle(result,m&~selected)
 return result
def verify_difference(cases,expected_branch,expected_character):
 assert cases and all(c['branch']==expected_branch and c['character']==expected_character for c in cases)
 matrix_checks=0;direction_checks=0;seen=set()
 for case in cases:
  branch=case['branch'];character=case['character'];condition=case['conditioning_coordinates'];value=case['condition_value'];key=(branch,character,value);assert key not in seen;seen.add(key)
  supports=symmetry['supports'];P=set()
  for j,support in enumerate(supports):
   if character>>j&1:P^={int(m,16) for m in next(r for r in models if r['branch']==branch and r['support_mask']==support)['polynomial_hex']}
  linear_forms=case.get('conditioning_linear_forms',[])
  assert linear_forms in [[],[[1,9,15,28,53,67,76,103]]] and condition in [[],[57]] and not (branch==1 and condition)
  P=restrict_general(P,condition,value&((1<<len(condition))-1))
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
  directions=[int(d,16) for d in case['directions_hex']];k=case['subspace_dimension'];assert 8<=k<=16 and len(directions)==k and rank_low(directions)==k
  assert len(case['matrices_hex'])==k
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
  rmin=case['claimed_minimum_polar_rank'];assert rmin%2==0 and all(r>=rmin for r in hist) and sum(hist.values())==(1<<k)-1;matrix_checks+=sum(hist.values())
  squared=(1+sum(Fraction(count,2**(r//2)) for r,count in hist.items()))/Fraction(1<<k);uniform=Fraction(1,1<<k)+(1-Fraction(1,1<<k))*Fraction(1,1<<(rmin//2));assert squared<=uniform==Fraction(*case['squared_bias_upper_bound']);beta=Fraction(*case['bias_upper_bound']);assert 0<=beta<=1 and beta*beta>=uniform
  print('branch',branch,'character',character,'condition',value,'all derivative ranks PASS',flush=True)
 C=cases[0]['conditioning_coordinates'];forms=cases[0].get('conditioning_linear_forms',[])
 assert all(c['conditioning_coordinates']==C and c.get('conditioning_linear_forms',[])==forms for c in cases)
 assert sorted(c['condition_value'] for c in cases)==list(range(1<<(len(C)+len(forms))))
 return sum(Fraction(*c['bias_upper_bound']) for c in cases)/len(cases),matrix_checks,direction_checks
checks=0;equation_reductions=0;rank_checks=0;direction_checks=0;total=Fraction(0);methods={}
assert certificate['filter_count_after_core']==7
for branch_record in certificate['branches']:
 branch=branch_record['branch'];assert branch in [0,1]
 polys=[{int(m,16) for m in next(r for r in models if r['branch']==branch and r['support_mask']==s)['polynomial_hex']} for s in symmetry['supports']]
 leaves=branch_record['leaves'];assert [r['character'] for r in leaves]==representatives;amplitudes=Fraction(0)
 for leaf in leaves:
  character=leaf['character'];orbit=next(o for o in symmetry['character_orbits'] if character in o);assert leaf['orbit']==orbit
  if leaf['method']=='quadratic_slice':
   evidence=leaf['evidence'];assert evidence['combination']==character;amplitude=verify_slice(evidence,polys)
  elif leaf['method']=='difference_minimum_rank':
   amplitude,n,d=verify_difference(leaf['evidence'],branch,character);rank_checks+=n;direction_checks+=d
  else:raise AssertionError('Unknown proof method')
  assert amplitude==Fraction(*leaf['amplitude_bound']);amplitudes+=len(orbit)*amplitude;methods[leaf['method']]=methods.get(leaf['method'],0)+1
  print('leaf',branch,character,leaf['method'],'PASS',flush=True)
 upper=(1+amplitudes)/128;assert upper==Fraction(*branch_record['conditional_pass_upper_bound']);weight=Fraction(1,64 if branch==0 else 128);assert weight==Fraction(*branch_record['chart_measure']);total+=weight*upper
assert total==Fraction(*certificate['global_pass_upper_bound']) and 1-total==Fraction(*certificate['global_excluded_lower_bound'])
print(json.dumps({'verification':'PASS','independent_quadratic_sums':checks,'equation_span_checks':equation_reductions,'difference_matrix_ranks':rank_checks,'basis_matrices_rebuilt':direction_checks,'leaf_methods':methods,'global_pass_upper_bound':str(total),'global_excluded_lower_bound':str(1-total),'excluded_percent_lower_bound':percent_lower(1-total),'seconds':time.perf_counter()-start,'scope':'One mixed certificate with a uniform leaf interface; discarded historical bounds are not verified. No global nonexistence claim.'},indent=2))
