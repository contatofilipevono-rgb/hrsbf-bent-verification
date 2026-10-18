"""Independent complete 5,775-partition verifier; standard Python only."""
from pathlib import Path
from itertools import combinations
import json
root=Path(__file__).parent;fifth=json.loads((root/'T27_QUINTA_FATORADA.json').read_text());u=fifth['support_mask'];T=[j for j in range(16) if u>>j&1]
assert u==0x3f3f and len(T)==12
def rot(x):return ((x<<1)&65535)|(x>>15)
index={};orbits=[]
for S in combinations(range(16),4):
 m=sum(1<<j for j in S)
 if m in index:continue
 orb=[];v=m
 while v not in orb:orb.append(v);v=rot(v)
 j=len(orbits);orbits.append(orb)
 for v in orb:index[v]=j
assert len(orbits)==116
poly=set();count=0
def toggle(p,m):
 if m in p:p.remove(m)
 else:p.add(m)
for other in combinations(T[1:],3):
 A=(T[0],)+other;remaining=sorted(set(T)-set(A));a=index[sum(1<<j for j in A)]
 for more in combinations(remaining[1:],3):
  B=(remaining[0],)+more;C=set(remaining)-set(B)
  b=index[sum(1<<j for j in B)];c=index[sum(1<<j for j in C)]
  toggle(poly,(1<<a)|(1<<b)|(1<<c));count+=1
assert count==5775
K2=[1,3,9,11,15,28,34,45,53,55,67,69,76,78,89,103]
K4=[13,21,24,32,38,47,70,72,74,80,86,91,93,97,107,109]
L=[0,4,8,14,18,22,42,46,52,56,71,81,85,94,98,106]
raw_expected={1<<57,1<<113}
for pivot,group in [(99,K2+K4),(113,L),(115,K2+[57])]:
 for j in group:toggle(raw_expected,(1<<pivot)|(1<<j))
assert poly==raw_expected
L=[0,4,8,14,18,22,42,46,52,56,71,81,85,94,98,106];reduced=set()
for m in poly:
 if m>>115&1:continue
 if m>>113&1:m=(m^(1<<113))|(1<<57)
 terms=[m] if not(m>>99&1) else [(m^(1<<99))|(1<<j) for j in L]
 for v in terms:toggle(reduced,v)
I=fifth['I'];J=fifth['J'];assert len(I)==33 and len(J)==16 and set(I).isdisjoint(J)
assert reduced=={(1<<i)|(1<<j) for i in I for j in J}
assert J==L and 57 in I
assert all(j not in I+J for j in [23,31,39,112])
fourth=json.loads((root/'T26_QUADRATICA_FATORADA.json').read_text())
assert 23 in fourth['linear'] and 57 in fourth['linear']
assert 23 not in L and not(set(L)&{57,99,113,115})
assert not any(23 in block['I']+block['J'] or 57 in block['I']+block['J'] for block in fourth['products'])
result={'support_mask_hex':hex(u),'partitions_checked':count,'raw_terms':len(poly),'terms_after_three_linear_laws':len(reduced),'factorization':'parity(I33)*parity(J16)','J_equals_c99_under_third_law':True,'fifth_condition_is_necessary_only':True,'joint_uniformity_coordinate_after_four_conditions':23,'exact_fraction_passing_all_five_conditions':'3/64','scope':'Complete partition polynomial identity; global fraction follows from the explicit four-condition parametrization and independent parity coordinates, not a sample.'}
(root/'T27_QUINTA_VERIFICACAO.json').write_text(json.dumps(result,indent=2));print(json.dumps(result,indent=2))
