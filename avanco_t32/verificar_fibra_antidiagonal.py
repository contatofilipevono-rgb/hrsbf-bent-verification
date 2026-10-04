import importlib.util, json, hashlib
from pathlib import Path
BASE=Path(__file__).resolve().parent
s=importlib.util.spec_from_file_location('audit',BASE/'verificador_integrado.py'); v=importlib.util.module_from_spec(s);s.loader.exec_module(v)
orbits=v.orbit_basis(32,3);polys=[v.fiber_polynomial(o,16,65535) for o in orbits]
def from_coeffs(a):
 p=set()
 for d in range(1,8):
  if a>>(d-1)&1:
   for i in range(16):p.symmetric_difference_update({(1<<i)|(1<<((i+d)%16))})
 B=set(p)
 for j in range(16):
  if sum(((1<<i)|(1<<j)) in B for i in range(j))%2:p.add(1<<j)
 return p
coeffs=[]
for i,p in enumerate(polys):
 a=sum(int(((1<<d)|1) in p)<<(d-1) for d in range(1,8))
 if (a&0b1010101).bit_count()%2: raise RuntimeError('Odd-distance parity failed')
 if p!=from_coeffs(a)^({0} if 0 in p else set()): raise RuntimeError(f'ANF identity failed: {i}')
 coeffs.append(a)
forms=[sum(((a>>d)&1)<<i for i,a in enumerate(coeffs)) for d in range(6)]
v.require(v.full_rank(forms)==6,'The six forms are dependent')
monomials=sorted(set.union(*polys))
v.require(v.full_rank([sum((m in p)<<i for i,m in enumerate(monomials)) for p in polys])==7,'Wrong full image dimension')
cases=[]
for x in range(64):
 a=x|(((x&0b10101).bit_count()%2)<<6)
 p=from_coeffs(a)
 wt=v.truth_bits(16,p).bit_count()
 if wt!=(32768 if x else 0): raise RuntimeError(f'Weight failure: {x}, {wt}')
 cases.append({'six_bit_parameter':x,'seven_bit_polar_coefficients':a,'weight':wt})
result={'status':'passed','n':32,'z':65535,'basis_convention':'orbit_basis(32,3): lex combinations, skip seen, each orbit sorted','orbit_representatives':[list(o[0]) for o in orbits], 'linear_forms_hex':[hex(a) for a in forms],'linear_forms_indices':[[i for i in range(155) if a>>i&1] for a in forms], 'linear_forms_interpretation':'a_d = parity(popcount(c AND mask[d-1])) for d=1,...,6; a_7=a_1+a_3+a_5', 'rank':6,'kernel_dimension':149,'excluded_coefficient_vectors':str(2**149),'total_vectors':str(2**155),'excluded_fraction':'1/64','all_fiber_image_dimension_including_constants':7,'constant_fibers':2,'nonconstant_fibers':126,'normalized_fibers_cases':cases,'proof_scope':'Exact classification of the single anti-diagonal fiber; necessary condition only; no global nonexistence'}
(BASE/'fibra_J_certificado.json').write_text(json.dumps(result,indent=2),encoding='utf-8')
print(json.dumps({k:result[k] for k in ['status','linear_forms_hex','rank','kernel_dimension','excluded_fraction']},indent=2))
