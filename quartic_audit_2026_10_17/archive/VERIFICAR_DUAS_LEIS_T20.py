"""Independent small certificate checker; standard Python only.
Run from this directory containing fiber_code_certificate.json.
"""
from itertools import combinations
from collections import Counter
from pathlib import Path
import json

def rot(x,n=8):return ((x<<1)&((1<<n)-1))|(x>>(n-1))
def generators():
 seen=set();out=[]
 for T in combinations(range(16),4):
  mask=sum(1<<i for i in T)
  if mask in seen:continue
  orbit=[];v=mask
  for _ in range(16):orbit.append(v);v=rot(v,16)
  orbit=sorted(set(orbit));seen.update(orbit);out.append(orbit)
 return out
gs=generators();assert len(gs)==116
assert [gs[j][0] for j in [57,99,113,115]]==[771,1285,2313,4369]
certificate=json.loads((Path(__file__).parent/'fiber_code_certificate.json').read_text())
for rec in certificate:
 z=rec['z'];step=rec['rotation_step'];seen=set();reps=[];lengths=[]
 def action(u):
  zz=z
  for _ in range(step):u=rot(u)^(zz>>7);zz=rot(zz)
  assert zz==z
  return u
 for u in range(256):
  if u in seen:continue
  reps.append(u);v=u;length=0
  while v not in seen:seen.add(v);length+=1;v=action(v)
  assert v==u;lengths.append(length)
 assert reps==rec['representatives'] and lengths==rec['orbit_lengths']
 words=[]
 for orbit in gs:
  word=0
  for j,u in enumerate(reps):
   x=u|((u^z)<<8);value=sum((x&m)==m for m in orbit)%2
   word|=value<<j
  words.append(word)
 assert [hex(w) for w in words]==rec['generator_words_hex']
 assert all(w.bit_count()%2==0 for w in words)
 if z==85:
  assert all(w.bit_count()%4==0 for w in words)
  assert all((a&b).bit_count()%2==0 for a,b in combinations(words,2))
 assert set(lengths)==({16} if z==255 else {8})
D=[u for u in range(256) if (u&85).bit_count()%2 and (u&170).bit_count()%2]
assert len(D)==64
orbit_counts=Counter();seen=set()
for u in D:
 if u in seen:continue
 v=u;l=0
 while v not in seen:
  assert v in D;seen.add(v);l+=1;v=rot(v)
 assert v==u;orbit_counts[l]+=1
assert orbit_counts=={8:8}
short=[]
for a,b,c,d in __import__('itertools').product(range(2),repeat=4):
 total=0
 for u in range(256):
  bits=[(u>>i)&1 for i in range(8)]
  q=sum(v*sum(bits[i]*bits[(i+distance)%8] for i in range(8)) for v,distance in [(a,1),(b,2),(c,3)])
  q+=d*sum(bits[i]*bits[i+4] for i in range(4))
  total+=1-2*(q%2)
 if d:assert abs(total)==16
 if not d and a^c:assert abs(total)==32
 short.append({'abcd':[a,b,c,d],'A0':total})
report={'all_116_generator_parity_identities_verified':True,'A255_divisible_by_64':True,'A85_divisible_by_64':True,'dual_odd_odd_orbits':dict(orbit_counts),'all_16_diagonal_cases_verified':True,'diagonal_cases':short,'scope':'Verifies the finite identities in the accompanying theoretical proof; does not enumerate all functions or assert global nonexistence.'}
(Path(__file__).parent/'T20_DUAS_LEIS_VERIFICACAO.json').write_text(json.dumps(report,indent=2))
print(json.dumps({k:v for k,v in report.items() if k!='diagonal_cases'},indent=2))
