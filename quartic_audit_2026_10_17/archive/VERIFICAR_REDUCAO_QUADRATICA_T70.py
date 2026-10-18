"""Rebuild the complete Walsh polynomial mod256 and compare it to Q4."""
import runpy,json,time
from pathlib import Path
from itertools import combinations
from collections import defaultdict
root=Path(__file__).resolve().parent;start=time.perf_counter();ctx=runpy.run_path(str(root/'VERIFICAR_NOVA_AMOSTRA_WALSH_T66.py'));words=ctx['words'];orbits=ctx['input_orbits'];L=ctx['seven']['L'];factor=ctx['factor'];free=sorted(set(range(116))-{0,99,113,115})
def toggle(P,m):
 if m in P:P.remove(m)
 else:P.add(m)
def image(m,b):
 P={0}
 for j in range(116):
  if not m>>j&1:continue
  if j==115:return set()
  Q=({1<<k for k in L if k!=0}^({0} if b else set())) if j==0 else ({0} if b else set()) if j==99 else {1<<57} if j==113 else {1<<j}
  R=set()
  for a in P:
   for c in Q:toggle(R,a|c)
  P=R
 return P
Q={1<<j for j in factor['linear']}
for block in factor['products']:
 for i in block['I']:
  for j in block['J']:toggle(Q,(1<<i)|(1<<j))
cases=[]
for branch in range(2):
 weights=defaultdict(int)
 for orbit in orbits:
  C=sum(1-2*((x&0x5555).bit_count()%2) for x in orbit)
  if not C:continue
  r=orbit[0];bits=[word>>r&1 for word in words];signature=0
  for j in free:
   value=bits[j]
   if j in L:value^=bits[0]
   if j==57:value^=bits[113]
   signature|=value<<j
  weights[signature]+=C*(1-2*(branch*(bits[0]^bits[99])))
 weights={s:w for s,w in weights.items() if w};assert all(w%16==0 for w in weights.values())
 entries=list(weights.items());columns={j:sum((s>>j&1)<<i for i,(s,w) in enumerate(entries)) for j in free};groups={w:sum((v==w)<<i for i,(s,v) in enumerate(entries)) for w in set(weights.values())};computed=set()
 assert sum(weights.values())%256==0
 for size in [1,2,3]:
  for subset in combinations(free,size):
   mask=(1<<len(entries))-1
   for j in subset:mask&=columns[j]
   coefficient=((-2)**size)*sum(w*(mask&g).bit_count() for w,g in groups.items())%256
   assert coefficient in [0,128]
   if coefficient:computed.add(sum(1<<j for j in subset))
 expected=set()
 for m in Q:
  for z in image(m,branch):toggle(expected,z)
 assert computed==expected
 cases.append({'branch':branch,'terms':len(computed),'degree':max(m.bit_count() for m in computed),'identity':'W5555=128*Q4 mod256 under the three linear laws'})
result={'verification':'PASS','branches':cases,'coefficients_checked_per_branch':112+6216+227920,'higher_degree_tail':'All signed weights are divisible by16, so coefficients of degree>=4 vanish mod256.','seconds':time.perf_counter()-start,'scope':'Complete modular polynomial identity; no new necessary filter beyond Q4.'}
(root/'T70_REDUCAO_QUADRATICA_VERIFICACAO.json').write_text(json.dumps(result,indent=2));print(json.dumps(result,indent=2))
