"""Independent symplectic verification of the T29 refinement; standard Python only."""
import json,time
from pathlib import Path
from fractions import Fraction
base=Path(__file__).resolve().parent;start=time.perf_counter()
cert=json.loads((base/'T28_SEXTA_CERTIFICADO.json').read_text())
refinement=json.loads((base/'T32_COMBINACAO_CERTIFICADO.json').read_text())
def toggle(P,m):
 if m in P:P.remove(m)
 else:P.add(m)
def derivative(P,d):
 out=set()
 for m in P:
  sub=m&d
  while sub:toggle(out,m^sub);sub=(sub-1)&(m&d)
 return out
def rank(rows):
 basis={}
 for v in rows:
  while v:
   j=v.bit_length()-1
   if j in basis:v^=basis[j]
   else:basis[j]=v;break
 return len(basis)
def quadratic_bias(P):
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
def symplectic_bias(P):
 if all(m.bit_count()<=2 for m in P):return quadratic_bias(P)
 assert all(m.bit_count()<=3 and m>>57&1 for m in P if m.bit_count()>2)
 answers=[]
 for value in [0,1]:
  Q=set()
  for m in P:
   if m>>57&1:
    if value:toggle(Q,m^(1<<57))
   else:toggle(Q,m)
  answers.append(quadratic_bias(Q))
 return sum(answers)/2
for old,seventh,new in zip(cert['reduced_models']['branches'],refinement['seventh_branch_models'],refinement['combined_models']):
 Q={int(m,16) for m in seventh['polynomial_hex']}
 formula=json.loads((base/'T31_SETIMA_CERTIFICADO.json').read_text())
 expected={1<<j for j in formula['R']}
 if old['branch']==0:
  for j in formula['M']+formula['K']:toggle(expected,1<<j)
  for j in formula['K']:toggle(expected,(1<<57)|(1<<j))
 assert Q==expected
 assert (1<<5) in Q and all(not m>>5&1 for m in Q if m.bit_count()>1)
 Q.remove(1<<5);R=set()
 for m in map(lambda x:int(x,16),old['polynomial_hex']):
  if m>>5&1:
   for n in Q:toggle(R,(m^(1<<5))|n)
  else:toggle(R,m)
 assert R=={int(m,16) for m in new['polynomial_hex']}
cert['reduced_models']['branches']=refinement['combined_models']
cert['quadratic_restrictions']=refinement['quadratic_restrictions']
total=Fraction(0);counts=[]
for reduced,restriction,radical,density in zip(cert['reduced_models']['branches'],cert['quadratic_restrictions'],refinement['radical_polynomials'],refinement['density']['branches']):
 P={int(m,16) for m in reduced['polynomial_hex']};S=restriction['coordinates'];mask=sum(1<<j for j in S)
 assert all((m&mask).bit_count()<=1 for m in P if m.bit_count()>2)
 actual_rows=[sum((((1<<i)|(1<<j)) in P)<<k for k,j in enumerate(S) if i!=j) for i in S]
 assert actual_rows==[int(v,16) for v in restriction['polar_rows_hex']]
 assert rank(actual_rows)==restriction['polar_rank']
 directions=[int(d,16) for d in radical['directions_hex']]
 assert all(d&mask==d for d in directions)
 assert rank(directions)==len(S)-restriction['polar_rank']==radical['radical_dimension']
 D=[]
 for d,row in zip(directions,radical['polynomials_hex']):
  value=derivative(P,d);assert value==set(int(m,16) for m in row)
  assert all(not m&mask and m.bit_count()<=3 for m in value);D.append(value)
 summed=Fraction(0)
 for record in density['quadratic_biases']:
  choice=record['combination'];poly=set()
  for j,row in enumerate(D):
   if choice>>j&1:poly^=row
  value=symplectic_bias(poly);assert value==Fraction(*record['bias']);summed+=value
 assert len(density['quadratic_biases'])==1<<len(D)
 zeros=summed/(1<<len(D));assert zeros==Fraction(*density['radical_zero_fraction'])
 upper=Fraction(1,2)+zeros/Fraction(2**(restriction['polar_rank']//2+1))
 assert upper==Fraction(*density['branch_pass_fraction_upper_bound'])
 total+=upper/Fraction(64 if reduced['branch']==0 else 128)
 counts.append({'branch':reduced['branch'],'quadratic_biases_verified':1<<len(D),'radical_zero_density':str(zeros),'conditional_pass_upper_bound':str(upper)})
assert total==Fraction(*refinement['density']['global_pass_fraction_upper_bound'])
assert 1-total==Fraction(*refinement['density']['global_excluded_fraction_lower_bound'])
print(json.dumps({'verification':'PASS','method':'symplectic Gram-Schmidt independent of pairwise summation elimination used to generate the certificate','branches':counts,'global_pass_upper_bound':str(total),'global_excluded_lower_bound':str(1-total),'excluded_percent_lower_bound':float((1-total)*100),'seconds':time.perf_counter()-start},indent=2))
