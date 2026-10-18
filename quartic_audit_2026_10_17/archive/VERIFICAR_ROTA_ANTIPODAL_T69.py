"""Exact checks and counterexamples for the proposed antipodal route."""
from pathlib import Path
from itertools import combinations
from collections import Counter
import json,time
start=time.perf_counter();root=Path(__file__).resolve().parent;seen=set();generators=[];index={}
for indices in combinations(range(16),4):
 m=sum(1<<j for j in indices)
 if m in seen:continue
 orbit={((m<<j)|(m>>(16-j)))&65535 for j in range(16)};seen.update(orbit)
 for z in orbit:index[z]=len(generators)
 generators.append(sorted(orbit))
coords=[i for i in range(16) if i not in [0,8]]
pairs=[(i,j,index[1|256|(1<<i)|(1<<j)]) for i,j in combinations(coords,2)]
restrictions={}
for i,j,c in pairs:
 m=(1<<(i%8-1))|(1<<(j%8-1));key=(c,m)
 if key in restrictions:del restrictions[key]
 else:restrictions[key]=1
expected={(57,1),(57,64),(99,2),(99,32),(113,4),(113,16),(115,8)}
assert set(restrictions)==expected
assert dict(Counter(Counter(c for i,j,c in pairs).values()))=={2:45,1:1}
def Q(c,x):return sum((c>>k&1)*((x>>i)&1)*((x>>j)&1) for i,j,k in pairs)%2
def f(c,x):return sum((c>>k&1)*sum((x&m)==m for m in orbit) for k,orbit in enumerate(generators))%2
minimal=1<<57;v=(1<<1)|(1<<9)
assert Q(minimal,v)==1 and (minimal>>115&1)==0
assert f(minimal,v)^f(minimal,v^1)^f(minimal,v^256)^f(minimal,v^257)==1
core_witness=int('687c33fc2d21fde00ca287b7fc7f0',16)
assert Q(core_witness,v)==1
assert any(int(r['coefficient_hex'],16)==core_witness for r in json.loads((root/'T66_WALSH_NOVA_AMOSTRA.json').read_text())['records'])
rank_witness=int('538cd1007cc3e3521e80fcd78aa46',16);matrix=[0]*14
for i,j,k in pairs:
 if rank_witness>>k&1:
  a=coords.index(i);b=coords.index(j);matrix[a]^=1<<b;matrix[b]^=1<<a
basis={}
for row in matrix:
 while row:
  p=row.bit_length()-1
  if p in basis:row^=basis[p]
  else:basis[p]=row;break
assert len(basis)==14 and not(rank_witness>>115&1)
def bent8(z):return sum(((z>>i)&1)*((z>>(i+4))&1) for i in range(4))%2 ^ int((z&240)==240)
values=[bent8(z) for z in range(256)];spectrum=[1-2*v for v in values]
for k in range(8):
 size=1<<k
 for base in range(0,256,2*size):
  for j in range(size):
   a=spectrum[base+j];b=spectrum[base+j+size];spectrum[base+j]=a+b;spectrum[base+j+size]=a-b
assert {abs(v) for v in spectrum}=={16}
assert sum(values[z]^values[z^1] for z in range(256))==128
assert all(values[z]^values[z^1]^values[z^2]^values[z^3]==0 for z in range(256))
result={'verification':'PASS','Q8_visible_coefficient_dimension':46,'Q8_invisible_coefficient_dimension':70,'Q8_pair_multiplicity_histogram':{'2':45,'1':1},'Q8_restriction_before_laws':'c57*(y1+y7)+c99*(y2+y6)+c113*(y3+y5)+c115*y4','Q8_restriction_under_three_laws':'a*(y1+y3+y5+y7)+b*(y2+y6)','minimal_nonvanishing_counterexample':{'coefficient_hex':hex(minimal),'x_hex':hex(v),'Q8':1},'core_nonvanishing_counterexample':{'coefficient_hex':hex(core_witness),'x_hex':hex(v),'Q8':1},'rank14_counterexample':{'coefficient_hex':hex(rank_witness),'rank':14},'quartic_bent_derivative_counterexample':{'formula':'f(x,y)=sum_{i=0}^3 x_i*y_i+y0*y1*y2*y3','n':8,'all_Walsh_absolute':16,'first_derivative':'D_x0 f=y0','nontrivial_constant_second_derivative':'D_x1 D_x0 f=0','scope':'Quartic bent example disproves the claimed general bentness criterion; it is not claimed homogeneous or rotation invariant.'},'seconds':time.perf_counter()-start,'scope':'Audits claims and provides explicit counterexamples; no nonexistence proof.'}
(root/'T69_ROTA_ANTIPODAL_VERIFICACAO.json').write_text(json.dumps(result,indent=2));print(json.dumps(result,indent=2))
