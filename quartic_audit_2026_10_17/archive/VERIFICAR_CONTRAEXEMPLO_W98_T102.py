"""Standard-library-only original-function counterexample to the W98 B_const formula."""
from itertools import combinations
from pathlib import Path
import json
n=16;allbits=(1<<(1<<n))-1;variables=[(allbits//((1<<(1<<j))+1))<<(1<<j) for j in range(n)]
assert all(v.bit_count()==32768 for v in variables)
orbits=[];seen=set()
for t in combinations(range(16),4):
 m=sum(1<<j for j in t)
 if m in seen:continue
 orbit={((m<<k)|(m>>(16-k)))&65535 for k in range(16)};seen.update(orbit);orbits.append(orbit)
generators={}
for j in [0,1,4,15]:
 word=0
 for monomial in orbits[j]:
  term=allbits
  for k in range(16):
   if monomial>>k&1:term&=variables[k]
  word^=term
 generators[j]=word
supports=[0x7ff,0xeff,0x1cff,0x38ff,0x70ff,0x47bf,0x4ebf,0x5cbf,0x78bf,0x27df,0x2edf,0x3cdf,0x679f,0x6e9f,0x1eef,0x57af]
masks=[]
for u in supports:
 mask=allbits
 for k in range(16):
  if not(u>>k&1):mask&=~variables[k]
 assert mask.bit_count()==2048;masks.append(mask)
cache={}
def Q(c):
 if c not in cache:
  word=0
  for j,g in generators.items():
   if c>>j&1:word^=g
  weights=[(word&m).bit_count() for m in masks];assert all(w%4==0 for w in weights)
  cache[c]=sum(w>>2&1 for w in weights)%2
 return cache[c]
d=0x11;e=0x8002;actual=Q(0)^Q(d)^Q(e)^Q(d^e);predicted=0
for i in [0,4]:
 for j in [1,15]:predicted^=Q(0)^Q(1<<i)^Q(1<<j)^Q((1<<i)|(1<<j))
assert actual==0 and predicted==1
result={'verification':'COUNTEREXAMPLE_CONFIRMED','scope':'Direct original truth tables, no symbolic ANF generator and no external dependencies. The Gemini constant-matrix construction uses only global quadratic coefficients; the actual second difference includes Boolean-substitution contributions from cubic terms.','direction_coefficients_hex':[hex(d),hex(e)],'actual_condition_values':[Q(c) for c in [0,d,e,d^e]],'actual_second_difference':actual,'predicted_by_global_quadratic_part_only':predicted,'coefficient_vectors_evaluated':len(cache)}
(Path(__file__).resolve().parent/'T102_CONTRAEXEMPLO_INDEPENDENTE.json').write_text(json.dumps(result,indent=2));print(result)
