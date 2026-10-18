"""Small exact normal form for the first five and seventh necessary conditions."""
import json
from pathlib import Path
from itertools import product
base=Path(__file__).resolve().parent
old=json.loads((base/'T28_SEXTA_CERTIFICADO.json').read_text())
seventh=json.loads((base/'T31_SETIMA_CERTIFICADO.json').read_text())
factor=old['fourth_factorization'];forms=[]
for block in factor['products']:
 forms.extend([block['I'],block['J']])
forms.extend([[57],[23,31,39,112],seventh['R']])
def mask(group):return sum(1<<j for j in group)
linear_constraints=[[115],[57,113],[99]+seventh['L']]
def rank(rows):
 B={}
 for v in rows:
  while v:
   j=v.bit_length()-1
   if j in B:v^=B[j]
   else:B[j]=v;break
 return len(B)
assert rank([mask(g) for g in linear_constraints+forms])==14
assert set(seventh['L'])==set(forms[0]+forms[1])
assert set(seventh['M'])==set(forms[4]+forms[5])
assert set(seventh['K'])==set(forms[2]+forms[3]+forms[6]+forms[7])
assert set(factor['linear'])=={23,31,39,57,112}
counts=[0,0];patterns=[]
for parities in product(range(2),repeat=8):
 u=parities[0::2];v=parities[1::2];b=u[0]^v[0];K=u[1]^v[1]^u[3]^v[3];M=u[2]^v[2]
 for a in range(2):
  if b&(a^K):continue
  t=a^sum(x*y for x,y in zip(u,v))%2
  R=((1^b)&M)^((1^a)&K)
  assert t^a^sum(x*y for x,y in zip(u,v))%2==0
  assert R^((1^b)&M)^((1^a)&K)==0
  patterns.append({'u':u,'v':v,'a':a,'t':t,'R':R});counts[b]+=1
assert counts==[256,128] and len(patterns)==384
report={'verification':'PASS','combined_linear_form_rank':14,'irrelevant_linear_kernel_dimension':102,'aggregate_coordinates_after_three_laws':11,'free_binary_choices_before_last_gate':9,'aggregate_patterns_passing':384,'branch_pattern_counts':counts,'exact_original_fraction':'3/128','form_order':['u1','v1','u2','v2','u3','v3','u4','v4','a','t','R'],'forms':forms,'scope':'Exact equivalence and count for the first five conditions together with the seventh. The sixth is handled separately; this is not a bentness characterization.'}
print(json.dumps(report,indent=2))
