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
import json,time
from pathlib import Path
from fractions import Fraction
base=Path(__file__).resolve().parent;start=time.perf_counter()
certificate=json.loads((base/'T39_RESTRICOES_CERTIFICADO.json').read_text())
models=json.loads((base/'T35_POLINOMIOS_CERTIFICADO.json').read_text())['combined_models']+json.loads((base/'T38_MODELOS_CERTIFICADO.json').read_text())['models']
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

total_upper=Fraction(0);total_lower=Fraction(0);checks=0;equation_reductions=0;records=[]
for branch_record in certificate['branches']:
 branch=branch_record['branch'];supports=branch_record['supports'];assert supports==['0x3f3f','0x5f5f','0x6f6f','0x33ff']
 polys=[{int(m,16) for m in next(r for r in models if r['branch']==branch and r['support_mask']==s)['polynomial_hex']} for s in supports]
 assert [r['combination'] for r in branch_record['characters']]==list(range(1,16))
 amplitudes=Fraction(0)
 for character in branch_record['characters']:
  choice=character['combination'];P=combination(polys,choice);S=character['coordinates'];mask=sum(1<<j for j in S)
  assert len(S)==len(set(S)) and all((m&mask).bit_count()<=1 for m in P if m.bit_count()>2)
  polar=[sum((((1<<i)|(1<<j)) in P)<<k for k,j in enumerate(S) if i!=j) for i in S];r=rank(polar);assert r==character['polar_rank']
  directions=[int(v,16) for v in character['directions_hex']]
  assert rank(directions)==len(directions)==len(S)-r and all(d&mask==d for d in directions)
  D=[]
  for d,row in zip(directions,character['polynomials_hex']):
   value=derivative(P,d);assert value=={int(m,16) for m in row};assert all(not m&mask for m in value);D.append(value)
  assert len(D)==len(directions)
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
  amplitude=Z/Fraction(2**(r//2));assert amplitude==Fraction(*character['average_absolute_slice_bias']);amplitudes+=amplitude
  print('branch',branch,'character',choice,'slice and equation-span certificate PASS',flush=True)
 upper=(1+amplitudes)/16;lower=(1-amplitudes)/16
 assert upper==Fraction(*branch_record['conditional_pass_upper_bound']) and lower==Fraction(*branch_record['conditional_pass_lower_bound'])
 weight=Fraction(1,64 if branch==0 else 128);total_upper+=weight*upper;total_lower+=weight*lower;records.append({'branch':branch,'conditional_pass_upper_bound':str(upper),'conditional_pass_lower_bound':str(lower)})
assert total_upper==Fraction(*certificate['global_pass_upper_bound'])
assert 1-total_upper==Fraction(*certificate['global_excluded_lower_bound'])
print(json.dumps({'verification':'PASS','independent_quadratic_sums':checks,'exact_equation_span_checks':equation_reductions,'branches':records,'global_pass_upper_bound':str(total_upper),'global_pass_lower_bound':str(total_lower),'excluded_percent_interval':[percent_lower(1-total_upper),percent_upper(1-total_lower)],'seconds':time.perf_counter()-start,'scope':'Ten necessary conditions with character-specific restrictions. Positive survivor lower bound refers to passing filters, not to bent functions.'},indent=2))
