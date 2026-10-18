"""Necessary linear conditions for arbitrary translations acting on filter span."""
from pathlib import Path
import json,time
base=Path(__file__).resolve().parent;data=json.loads((base/'T35_POLINOMIOS_CERTIFICADO.json').read_text())['combined_models']+json.loads((base/'T40_MODELOS_CERTIFICADO.json').read_text())['models'];reference=json.loads((base/'T40_LIMITE_CERTIFICADO.json').read_text());certificate=json.loads((base/'T52_TRANSLACOES_CERTIFICADO.json').read_text());start=time.perf_counter();reports=[]
def pivot(P):return max(P,key=lambda m:(m.bit_count(),m))
def kernel(rows,variables):
 B={}
 for row in rows:
  while row:
   p=(row&-row).bit_length()-1
   if p in B:row^=B[p]
   else:B[p]=row;break
 result=[]
 for j in variables:
  if j in B:continue
  v=1<<j
  for p in sorted(B,reverse=True):
   if (v&B[p]).bit_count()%2:v^=1<<p
  result.append(v)
 return result,len(B)
def independent(vectors):
 B={}
 for v in vectors:
  while v:
   p=v.bit_length()-1
   if p in B:v^=B[p]
   else:B[p]=v;break
 return list(B.values())
for branch in range(2):
 polys=[{int(m,16) for m in next(r for r in data if r['branch']==branch and r['support_mask']==s)['polynomial_hex']} for s in reference['branches'][branch]['supports']]
 B={}
 for P in polys+[{0}]:
  row=P.copy()
  while row:
   p=pivot(row)
   if p in B:row^=B[p]
   else:B[p]=row;break
 basis=list(B.values());degrees=[max(m.bit_count() for m in row) for row in basis];free=sorted(set(range(116))-{0,5,23,99,113,115}-({57} if branch else set()));variables=free.copy();constraints=[]
 for i,P in enumerate(polys):
  degree=max(m.bit_count() for m in P);rows={}
  for m in P:
   if m.bit_count()==degree:
    rest=m
    while rest:
     bit=rest&-rest;rows[m^bit]=rows.get(m^bit,0)^bit;rest^=bit
  for l,Q in enumerate(basis):
   if degrees[l]>degree-1:continue
   auxiliary=116+i*8+l;variables.append(auxiliary)
   for m in Q:
    if m.bit_count()==degree-1:rows[m]=rows.get(m,0)^(1<<auxiliary)
  constraints.extend(rows.values())
 K,rank=kernel(constraints,variables);mask=sum(1<<j for j in free);projected=independent(v&mask for v in K)
 expected=certificate['branches'][branch];claimed=[int(v,16) for v in expected['necessary_translation_basis_hex']]
 assert rank==expected['constraint_rank'] and len(projected)==len(claimed)==expected['necessary_translation_space_dimension']
 assert len(independent(projected+claimed))==len(claimed)
 failed=[]
 for selector in range(1,1<<len(claimed)):
  direction=0
  for j,v in enumerate(claimed):
   if selector>>j&1:direction^=v
  outside=None
  for i,P in enumerate(polys):
   D=set()
   for m in P:
    sub=m&direction
    while sub:
     monomial=m^sub
     if monomial in D:D.remove(monomial)
     else:D.add(monomial)
     sub=(sub-1)&(m&direction)
   while D:
    p=pivot(D)
    if p not in B:break
    D^=B[p]
   if D:outside={'direction_hex':hex(direction),'filter_index':i,'nonzero_residual_pivot_hex':hex(pivot(D))};break
  assert outside is not None
  failed.append(outside)
 report={'all_nonzero_projected_candidates_rejected':failed,'branch':branch,'degrees_of_span_basis':degrees,'variables':len(variables),'constraint_rows':len(constraints),'constraint_rank':rank,'necessary_translation_space_dimension':len(projected),'necessary_translation_basis_hex':[hex(v) for v in projected]};reports.append(report);print(report,flush=True)
print(json.dumps({'verification':'PASS','branches':reports,'seconds':time.perf_counter()-start,'scope':'All nonzero translations of either affine chart fail to map the seven filters into their span plus constants. Does not exclude general affine transformations or nonlinear symmetries.'},indent=2))
