"""Independent checks of compact counter identities and nonimplication witnesses."""
from pathlib import Path
from itertools import combinations
import runpy,json,time,numpy as np
root=Path(__file__).resolve().parent;start=time.perf_counter()
context=runpy.run_path(str(root/'VERIFICAR_NOVA_AMOSTRA_WALSH_T66.py'))
words=context['words'];orbits=context['input_orbits'];x=context['x']
old=json.loads((root/'T72_CONDICOES_MODULARES_CERTIFICADO.json').read_text());verified=json.loads((root/'T66_WALSH_NOVA_AMOSTRA_VERIFICACAO.json').read_text())
assert verified['verification']=='PASS'
short=[v for o in orbits if len(o)<16 for v in o];full=[o[0] for o in orbits if len(o)==16];even=[v for v in full if v.bit_count()%2==0];odd=[v for v in full if v.bit_count()%2]
assert len(short)==256 and len(full)==4080 and len(even)==2032 and len(odd)==2048
L=context['seven']['L'];free=sorted(set(range(116))-{0,99,113,115})
short_signatures=[]
for v in short:
 bits=[word>>v&1 for word in words]
 sig=sum((bits[j]^(bits[0] if j in L else 0)^(bits[113] if j==57 else 0))<<j for j in free)
 assert sig in [0,1<<57] and (v&0x5555).bit_count()%2==0 and v.bit_count()%2==0
 short_signatures.append((bool(sig),bits[0]^bits[99]))
for a in range(2):
 for b in range(2):assert sum(1-2*((a*p)^(b*q)) for p,q in short_signatures)==256-128*a-192*b
O=[sum((word>>v&1)<<i for i,v in enumerate(odd)) for word in words]
assert all(v.bit_count()%8==0 for v in O)
assert all((O[i]&O[j]).bit_count()%4==0 for i,j in combinations(range(116),2))
assert all((O[i]&O[j]&O[k]).bit_count()%2==0 for i,j,k in combinations(range(116),3))
chi2=int.from_bytes(np.packbits(np.bitwise_count(x&0x5555)%2,bitorder='little').tobytes(),'little');chi1=context['chi'][0xffff];results=[];counts=[0,0]
for r in verified['thirteen_records']:
 c=int(r['coefficient_hex'],16);a=c>>57&1;b=c>>99&1;tt=0
 for j,w in enumerate(words):
  if c>>j&1:tt^=w
 W0=65536-2*tt.bit_count();Wones=65536-2*(tt^chi1).bit_count();W2=65536-2*(tt^chi2).bit_count()
 w=sum(tt>>v&1 for v in full);wo=sum(tt>>v&1 for v in odd);z=sum((tt>>v&1)^((v&0x5555).bit_count()%2) for v in even)
 assert W0==65536-128*a-192*b-32*w
 assert W2==32768-128*a-192*b-32*z
 assert wo%8==0 and W0-Wones==65536-64*wo
 C0=(w+4*a+6*b)%16==8;C2=(z+4*a+6*b)%16==8
 assert C0==(W0%512==256) and C2==(W2%512==256)
 counts[0]+=C0;counts[1]+=C0 and C2
 results.append({'coefficient_hex':hex(c),'W0':W0,'Wones':Wones,'W5555':W2,'passes_C0':C0,'passes_C2':C2})
assert results==old['records'] and counts==old['survivors_C0_then_C2']
assert old['C0_nonimplication_witness'] in results and old['C2_nonimplication_given_C0_witness'] in results
assert not old['C0_nonimplication_witness']['passes_C0']
assert old['C2_nonimplication_given_C0_witness']['W0']==256 and not old['C2_nonimplication_given_C0_witness']['passes_C2']
result={'verification':'PASS','short_input_signatures_checked':256,'short_input_identity_parameter_cases':4,'odd_divisibility_generator_checks':116,'odd_divisibility_pair_checks':6670,'odd_divisibility_triple_checks':253460,'original_thirteen_survivors_checked':len(results),'survivors_C0_then_C2':counts,'C0_counter_identity':'W0=65536-128*a-192*b-32*w','C2_counter_identity':'W5555=32768-128*a-192*b-32*z','necessary_counter_congruences':['w+4*a+6*b=8 mod16','z+4*a+6*b=8 mod16'],'Wones_congruence_redundancy_verified':True,'nonimplication_witnesses_verified':True,'seconds':time.perf_counter()-start,'scope':'Exact identities, complete short-orbit and odd-overlap checks, and explicit witnesses. Finite-sample counts are not global bounds; Q4 polynomial equivalence is a separate check.'}
(root/'T72_CONDICOES_MODULARES_VERIFICACAO.json').write_text(json.dumps(result,indent=2));print(json.dumps(result,indent=2))
