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

"""Independent verification of the nine-condition vector-Fourier bound."""
import json,time
from pathlib import Path
from fractions import Fraction
base=Path(__file__).resolve().parent;start=time.perf_counter()
polynomial_certificate=json.loads((base/'T35_POLINOMIOS_CERTIFICADO.json').read_text())
certificate=json.loads((base/'T35_LIMITE_CERTIFICADO.json').read_text())
def toggle(P,m):
 if m in P:P.remove(m)
 else:P.add(m)
def rank(rows):
 basis={}
 for v in rows:
  while v:
   j=v.bit_length()-1
   if j in basis:v^=basis[j]
   else:basis[j]=v;break
 return len(basis)
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

total=Fraction(0);checks=0;branches=[]
for radical_branch,density_branch in zip(certificate['radicals'],certificate['density']['branches']):
 branch=radical_branch['branch'];S=radical_branch['coordinates'];mask=sum(1<<j for j in S)
 assert branch==density_branch['branch'] and radical_branch['supports']==['0x3f3f','0x5f5f','0x6f6f']
 polys=[{int(m,16) for m in next(r for r in polynomial_certificate['combined_models'] if r['branch']==branch and r['support_mask']==support)['polynomial_hex']} for support in radical_branch['supports']]
 upper=Fraction(1)
 for radical,density in zip(radical_branch['combinations'],density_branch['combinations']):
  choice=radical['combination'];assert choice==density['combination']
  P=set()
  for j,poly in enumerate(polys):
   if choice>>j&1:P^=poly
  assert all((m&mask).bit_count()<=1 for m in P if m.bit_count()>2)
  polar=[sum((((1<<i)|(1<<j)) in P)<<k for k,j in enumerate(S) if i!=j) for i in S]
  r=rank(polar);assert r==radical['polar_rank']==density['polar_rank']
  directions=[int(v,16) for v in radical['directions_hex']]
  assert rank(directions)==len(directions)==len(S)-r
  assert all(d&mask==d for d in directions)
  derivatives=[]
  for d,stored in zip(directions,radical['polynomials_hex']):
   value=derivative(P,d);assert value=={int(m,16) for m in stored}
   assert all(not m&mask for m in value);derivatives.append(value)
  condition=radical['conditioning_coordinates'];assert condition==density['conditioning_coordinates']
  assert len(condition)==len(set(condition)) and all(not mask>>j&1 for j in condition)
  restricted=[[restrict(D,condition,value) for D in derivatives] for value in range(1<<len(condition))]
  summed=Fraction(0);records=density['quadratic_bias_records'];assert len(records)==1<<len(derivatives)
  for index,record in enumerate(records):
   assert record['radical_combination']==index
   assert len(record['conditioned_quadratic_biases'])==len(restricted)
   for rows,expected in zip(restricted,record['conditioned_quadratic_biases']):
    Q=set()
    for j,row in enumerate(rows):
     if index>>j&1:Q^=row
    value=symplectic_bias(Q);assert value==Fraction(*expected);summed+=value;checks+=1
  Z=summed/Fraction((1<<len(derivatives))*len(restricted));assert Z==Fraction(*density['radical_zero_fraction'])
  amplitude=Z/Fraction(2**(r//2));assert amplitude==Fraction(*density['average_absolute_slice_bias']);upper+=amplitude
  print('branch',branch,'character',choice,'exact radical density and independent quadratic sums PASS',flush=True)
 assert [r['combination'] for r in radical_branch['combinations']]==list(range(1,8))
 upper/=8;assert upper==Fraction(*density_branch['conditional_joint_pass_upper_bound'])
 total+=upper/Fraction(64 if branch==0 else 128);branches.append({'branch':branch,'conditional_pass_upper_bound':str(upper)})
assert total==Fraction(*certificate['density']['global_pass_upper_bound'])
assert 1-total==Fraction(*certificate['density']['global_excluded_lower_bound'])
print(json.dumps({'verification':'PASS','independent_quadratic_bias_checks':checks,'branches':branches,'global_pass_upper_bound':str(total),'global_excluded_lower_bound':str(1-total),'excluded_percent_lower_bound':percent_lower(1-total),'seconds':time.perf_counter()-start,'scope':'Rigorous upper bound from all seven nonzero characters of three necessary second bits, after the six-condition normal form. Not exact density and not a nonexistence theorem.'},indent=2))
