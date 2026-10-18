"""Standard-Python bit-parallel exhaustive calibration; independent pair generation."""
from itertools import combinations
from pathlib import Path
from fractions import Fraction
import json,time
base=Path(__file__).resolve().parent;certificate=json.loads((base/'T58_CALIBRACAO_CERTIFICADO.json').read_text());start=time.perf_counter();records=[]
for case in certificate['cases']:
 n=case['n'];index={};orbits=[]
 for T in combinations(range(n),4):
  m=sum(1<<j for j in T)
  if m in index:continue
  orbit=set();r=m
  for _ in range(n):orbit.add(r);r=((r<<1)&((1<<n)-1))|(r>>(n-1))
  for r in orbit:index[r]=len(orbits)
  orbits.append(orbit)
 d=len(orbits);N=1<<d;assert d==case['orbit_dimension'] and N==case['total_functions'];byte_count=N//8;planes=[]
 for j in range(d):
  if j<3:data=bytes([[0xaa,0xcc,0xf0][j]])*byte_count
  else:
   half=1<<(j-3);period=bytes(half)+bytes([255])*half;data=period*(byte_count//len(period))
  planes.append(int.from_bytes(data,'little'))
 full=(1<<N)-1;survivors=full
 for condition in case['conditions']:
  u=int(condition['support_hex'],16);T=[j for j in range(n) if u>>j&1];w=len(T);assert w==condition['support_weight'] and w-n//2+1>2;P=set();count=0
  # Two quartics covering u have intersection of size 8-w.
  for I in combinations(T,8-w):
   remainder=sorted(set(T)-set(I))
   for A in combinations(remainder,w-4):
    B=set(remainder)-set(A);a=sum(1<<j for j in set(I)|set(A));b=sum(1<<j for j in set(I)|B)
    if a>=b:continue
    count+=1;m=(1<<index[a])|(1<<index[b])
    if m in P:P.remove(m)
    else:P.add(m)
  assert count==condition['input_monomial_pairs'] and P=={int(m,16) for m in condition['polynomial_hex']}
  word=0
  for m in P:
   value=full
   for j in range(d):
    if m>>j&1:value&=planes[j]
   word^=value
  assert N-word.bit_count()==condition['passing_functions'];survivors&=full^word;assert survivors.bit_count()==condition['joint_passing_functions']
 assert survivors.bit_count()==case['joint_passing_functions'];density=Fraction(survivors.bit_count(),N);assert density==Fraction(*case['joint_density'])
 records.append({'n':n,'coefficient_vectors_checked':N,'support_orbit_conditions':len(case['conditions']),'nonzero_conditions':sum(bool(c['polynomial_hex']) for c in case['conditions']),'joint_passing_functions':survivors.bit_count(),'joint_density':str(density)})
print(json.dumps({'verification':'PASS','cases':records,'seconds':time.perf_counter()-start,'scope':'Exhaustive bit-parallel evaluation of reconstructed quadratic filters. Does not re-enumerate Walsh spectra or certify the survivors bent.'},indent=2))
