"""Complete orbit geometry audit plus independent direct FWHT validation."""
from pathlib import Path
from itertools import combinations
from collections import Counter
import json,runpy,time,numpy as np
root=Path(__file__).resolve().parent;start=time.perf_counter();ctx=runpy.run_path(str(root/'VERIFICAR_NOVA_AMOSTRA_WALSH_T66.py'));orbits=ctx['input_orbits'];words=ctx['words'];x=ctx['x'];seven=ctx['seven'];factor=ctx['factor'];parity=ctx['parity'];masks=ctx['masks'];supports=ctx['supports'];chi=ctx['chi'][0xffff]
pilot=json.loads((root/'T75_PROJECAO_WALSH_CERTIFICADO.json').read_text());fresh=json.loads((root/'T76_VALIDACAO_NOVA_PROJECAO.json').read_text());models={};orbit_checks=0
for d in [4,8]:
 table=pilot['tables'][str(d)];reps=[int(z,16) for z in table['quotient_class_representatives_hex']];index={}
 for j,q in enumerate(reps):
  orbit={((q<<k)|(q>>(d-k)))&((1<<d)-1) for k in range(d)}
  assert len(orbit)==table['quotient_class_periods'][j]
  for y in orbit:assert y not in index;index[y]=j
 assert len(index)==1<<d
 groups=[[] for _ in reps];freq=[int(u,16) for u in table['frequencies_hex']]
 for orbit in orbits:
  folded=[]
  for v in orbit:
   y=0
   for k in range(0,16,d):y^=(v>>k)&((1<<d)-1)
   folded.append(y)
  if len(orbit)<16:assert all(y==0 for y in folded);continue
  j=index[folded[0]];groups[j].append(orbit[0]);distribution=Counter(folded);assert len(distribution)==table['quotient_class_periods'][j]
  assert set(distribution.values())=={16//len(distribution)}
  for k,u in enumerate(freq):assert sum(1-2*((u&v).bit_count()%2) for v in orbit)==table['matrix'][k][j]
  orbit_checks+=1
 assert [len(g) for g in groups]==table['full_input_orbit_counts']
 balanced=table['balanced_count_relaxation'];assert all(n%2==0 for n in table['full_input_orbit_counts'])
 assert balanced['counts']==[n//2 for n in table['full_input_orbit_counts']]
 W=[(65536 if u==0 else 0)-2*sum(C*w for C,w in zip(row,balanced['counts'])) for u,row in zip(freq,table['matrix'])];assert W==[256]*len(freq)
 models[d]=(table,groups,freq)
checked=0;fresh_counts={'thirteen_passed':0,'C0_passed':0,'C0_C2_passed':0,'all_six_mod512_passed':0,'all_six_exact_passed':0,'all_36_mod512_passed':0}
def direct(c):
 tt=0
 for j,w in enumerate(words):
  if c>>j&1:tt^=w
 bits=np.unpackbits(np.frombuffer(tt.to_bytes(8192,'little'),dtype=np.uint8),bitorder='little').astype(np.int32);fw=1-2*bits
 for k in range(16):
  block=fw.reshape(-1,2,1<<k);A=block[:,0,:].copy();B=block[:,1,:].copy();block[:,0,:]=A+B;block[:,1,:]=A-B
 return tt,fw
for row in pilot['records']:
 c=int(row['coefficient_hex'],16);tt,fw=direct(c);checked+=1
 for d in [4,8]:
  table,groups,freq=models[d];counts=[sum(tt>>r&1 for r in group) for group in groups];assert counts==row[str(d)]['counts'];assert fw[freq].tolist()==row[str(d)]['Walsh']
for row in fresh['records']:
 c=int(row['coefficient_hex'],16);tt,fw=direct(c);checked+=1;a=c>>57&1;b=c>>99&1
 assert not(c>>115&1) and c>>113&1==a and b==parity(c,seven['L'])
 assert parity(c,factor['linear'])==sum(parity(c,p['I'])*parity(c,p['J']) for p in factor['products'])%2
 assert not b*(a^parity(c,seven['K']))
 assert parity(c,seven['R'])^((1^b)*parity(c,seven['M']))^((1^a)*parity(c,seven['K']))==0
 h=[4096-2*((tt^chi)&masks[u]).bit_count() for u in supports];assert all(v%32==0 for v in h[:3]) and all(v%16==0 for v in h[3:])
 table,groups,freq=models[4];counts=[sum(tt>>r&1 for r in group) for group in groups];W=fw[freq].tolist();assert counts==row['quotient4_counts'] and W==row['Walsh4']
 fresh_counts['thirteen_passed']+=1;C0=int(fw[0])%512==256;C2=int(fw[0x5555])%512==256;passed=all(v%512==256 for v in W)
 fresh_counts['C0_passed']+=C0;fresh_counts['C0_C2_passed']+=C0 and C2;fresh_counts['all_six_mod512_passed']+=passed;fresh_counts['all_six_exact_passed']+=all(abs(v)==256 for v in W)
 if passed:
  table,groups,freq=models[8];assert fw[freq].tolist()==row['Walsh8'];assert [sum(tt>>r&1 for r in group) for group in groups]==row['quotient8_counts'];fresh_counts['all_36_mod512_passed']+=all(int(fw[u])%512==256 for u in freq)
 else:assert 'Walsh8' not in row
for key,value in fresh_counts.items():assert value==fresh['counts'][key]
result={'verification':'PASS','full_input_orbit_geometries_checked':orbit_checks,'discovery_functions_checked':len(pilot['records']),'fresh_thirteen_survivors_checked':len(fresh['records']),'complete_direct_Walsh_transforms':checked,'fresh_record_counts':fresh_counts,'balanced_count_relaxations_verified':2,'seconds':time.perf_counter()-start,'scope':'Complete quotient geometry and exact listed-function checks. Sampling attempt counts and the 8192 stopping count are generator metadata; no global density or nonexistence conclusion.'}
(root/'T75_T76_PROJECAO_VERIFICACAO.json').write_text(json.dumps(result,indent=2));print(json.dumps(result,indent=2))
