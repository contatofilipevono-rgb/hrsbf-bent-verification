import json
from pathlib import Path
from higher_project import union_system,eliminate_lower
from sparse_projection import reduce_iteratively
from period4_conditions import branch_equations
from upper_mod8 import terms_for_fixed_upper
b=Path(__file__).parent
records=json.loads((b/'spectral-switching-counts.json').read_text())['new_orbits']
charts=[]
for r in records:
 high=r['high_mask']
 rows=union_system(high)
 for branch in (0,1):
  low,p=eliminate_lower(rows+branch_equations(high,branch))
  _,basis,poly,stage,cert=reduce_iteratively(p+[terms_for_fixed_upper(high)])
  d={'mask':high,'period4_branch':branch,'lower_rank':len(low),'quartic_free':len(basis),'residual_equations':len(poly),'stages':stage,'contradiction':cert is not None,'certificate_of_final_contradiction':cert}
  charts.append(d)
  print(high,high.bit_count(),branch,len(low),len(basis),len(poly),cert is not None,flush=True)
(b/'switched-sextic-projection.json').write_text(json.dumps({'classes':charts},indent=2)+'\n')
