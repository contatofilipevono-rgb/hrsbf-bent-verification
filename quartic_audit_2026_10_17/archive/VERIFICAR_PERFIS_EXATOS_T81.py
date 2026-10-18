from pathlib import Path
from itertools import product
from fractions import Fraction
import json,time
root=Path(__file__).resolve().parent;start=time.perf_counter();report=json.loads((root/'T81_PERFIS_EXATOS_SEIS_WALSH.json').read_text());table=json.loads((root/'T75_PROJECAO_WALSH_CERTIFICADO.json').read_text())['tables']['4'];A=table['matrix'];freq=[int(u,16) for u in report['frequencies_hex']];q=[int(u,16) for u in report['quotient_classes_hex']]
assert report['class_capacities']==table['full_input_orbit_counts'];M=[[Fraction(v) for v in row] for row in A]
for j in range(6):
 pivot=next(i for i in range(j,6) if M[i][j]);M[j],M[pivot]=M[pivot],M[j];value=M[j][j];M[j]=[v/value for v in M[j]]
 for i in range(j+1,6):
  value=M[i][j];M[i]=[a-value*b for a,b in zip(M[i],M[j])]
lookup={}
for profile in report['profiles']:
 a=profile['a'];b=profile['b'];W=profile['Walsh'];counts=profile['full_orbit_counts'];key=(a,b,tuple(W));assert key not in lookup;lookup[key]=profile
 assert all(type(v)==int and 0<=v<=n for v,n in zip(counts,table['full_input_orbit_counts']))
 assert all(v in [-256,256] for v in W) and W[freq.index(0)]==W[freq.index(65535)]
 assert all(v==(65536 if u==0 else 0)-128*a-192*b-2*sum(C*w for C,w in zip(row,counts)) for u,row,v in zip(freq,A,W))
 assert counts[q.index(1)]%8==counts[q.index(7)]%8==0
for a,b in product(range(2),repeat=2):
 for signs in product([-256,256],repeat=6):
  if signs[freq.index(0)]==signs[freq.index(65535)]:assert (a,b,signs) in lookup
  else:assert (a,b,signs) not in lookup
assert len(lookup)==report['profiles_after_intrinsic_divisibility']==128
result={'verification':'PASS','full_rank_rational_matrix_checked':True,'exact_target_profiles':128,'profiles_per_parameter_case':32,'seconds':time.perf_counter()-start,'scope':'Complete exact six-frequency target table after the proved necessary equality W0=Wones. Does not prove that any profile is realizable by coefficients.'}
(root/'T81_PERFIS_EXATOS_VERIFICACAO.json').write_text(json.dumps(result,indent=2));print(json.dumps(result,indent=2))
