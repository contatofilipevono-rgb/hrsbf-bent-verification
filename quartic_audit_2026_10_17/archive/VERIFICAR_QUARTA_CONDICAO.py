"""Independent exact verifier of the factored quadratic Walsh congruence.
Requires standard Python only and the companion certificates in this directory.
"""
from pathlib import Path
from itertools import combinations
import json,runpy,random
root=Path(__file__).parent
state=runpy.run_path(str(root/'VERIFICAR_TERCEIRA_LEI_T20.py'))
words=state['words'].copy();L=state['L'];factor=json.loads((root/'T26_QUADRATICA_FATORADA.json').read_text())
# Substitute c113=c57 and c115=0 before checking triple intersections.
# The unrestricted original code need not have this stronger property.
words[57]^=words[113];words[113]=words[115]=0
# The complete triple-intersection check on this restricted basis is the
# degree bound used by the proof.
assert all((a&b&c).bit_count()%2==0 for a,b,c in combinations(words,3))
poly=set()
def toggle(m):
 if m in poly:poly.remove(m)
 else:poly.add(m)
toggle(1<<57)
for j,w in enumerate(words):
 if w.bit_count()//4%2:toggle(1<<j)
for j,k in combinations(L,2):toggle((1<<j)|(1<<k))
for j,k in combinations(range(116),2):
 intersection=(words[j]&words[k]).bit_count();assert intersection%2==0
 if intersection//2%2:toggle((1<<j)|(1<<k))
reduced=set()
for m in poly:
 if m>>115&1:continue
 if m>>113&1:m=(m^(1<<113))|(1<<57)
 expanded=[m] if not(m>>99&1) else [(m^(1<<99))|(1<<j) for j in L]
 for v in expanded:
  if v in reduced:reduced.remove(v)
  else:reduced.add(v)
expected={1<<j for j in factor['linear']}
for block in factor['products']:
 assert set(block['I']).isdisjoint(block['J'])
 for j in block['I']:
  for k in block['J']:
   term=(1<<j)|(1<<k)
   if term in expected:expected.remove(term)
   else:expected.add(term)
assert reduced==expected and len(reduced)==261
assert not any(m>>57&1 for m in reduced if m.bit_count()>1)
assert (1<<57) in reduced and 57 not in L
rng=random.Random(20261017203);counts=[0,0];witnesses={}
for _ in range(1024):
 c=rng.getrandbits(116)&~((1<<115)|(1<<113)|(1<<99));c|=((c>>57)&1)<<113;c|=(sum(c>>j&1 for j in L)%2)<<99
 full=0
 for j in range(116):
  if c>>j&1:full^=words[j]
 a=c>>57&1;b=c>>99&1;A0=64*(4-2*a-3*b);W0=A0+65280-32*full.bit_count()
 value=sum((c&m)==m for m in reduced)%2
 assert W0%128==0 and W0//128%2==value
 partner=c^(1<<57)^(1<<113)
 partner_value=sum((partner&m)==m for m in reduced)%2
 assert partner_value==1-value
 counts[value]+=1;witnesses.setdefault(str(value),{'coefficients_hex':hex(c),'W0':W0,'quadratic_value':value})
result={'all_triple_intersections_even':True,'raw_terms':len(poly),'exact_reduced_terms':len(reduced),'quadratic_terms':256,'linear_terms':5,'factorization_verified':True,'independent_modular_checks':1024,'pairing_toggle_c57_c113_verified':True,'exact_fraction_passing_four_conditions':'1/16','free_parameters':112,'sample_histogram':counts,'examples':witnesses,'scope':'Necessary conditions for bentness; no assertion that remaining candidates are bent. Exact fraction follows from the algebraic pairing, not the sample histogram.'}
result['triple_intersection_basis']='After substituting c113=c57 and c115=0'
(root/'T26_QUARTA_CONDICAO_VERIFICACAO.json').write_text(json.dumps(result,indent=2))
print(json.dumps(result,indent=2))
