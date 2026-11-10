import json
from pathlib import Path
from collections import defaultdict
from higher_project import union_system,eliminate_lower
from period4_conditions import branch_equations
from sparse_projection import reduce_iteratively
from upper_mod8 import terms_for_fixed_upper
b=Path(__file__).parent
d=json.loads((b/'four-quintic-reduced.json').read_text())
rows=[]
for parent,r in enumerate(d['classes']):
 if r['contradiction'] or r['quartic_free']<29:
  rows.append(r);continue
 for branch in (0,1):
  high=r['mask']
  low,p=eliminate_lower(union_system(high)+branch_equations(high,branch))
  _,basis,poly,stages,cert=reduce_iteratively(p+[terms_for_fixed_upper(high)])
  rows.append({**r,'period4_branch':branch,'parent_index':parent,'lower_rank':len(low),'quartic_free':len(basis),'residual_equations':len(poly),'stages':stages,'contradiction':cert is not None,'certificate_of_final_contradiction':cert})
expected=defaultdict(list)
for r in rows:expected[r['mask']].append(r.get('period4_branch'))
assert set(expected)=={r['mask'] for r in d['classes']}
assert all(s==[None] or s==[0,1] for s in expected.values())
sum_=sum(1<<r['quartic_free'] for r in rows if not r['contradiction'])
print('quartic trials',d['summary']['quartic_trials'],'->',sum_)
d['summary']['quartic_trials_after_period4_split']=sum_
d['classes']=rows
(b/'four-quintic-split.json').write_text(json.dumps(d,separators=(',',':'))+'\n')
