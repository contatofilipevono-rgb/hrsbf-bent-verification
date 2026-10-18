"""Reconstruct functions, verify core, nine filters, Walsh triples and survivors."""
from pathlib import Path
from itertools import combinations
from collections import Counter
import json,time,numpy as np
root=Path(__file__).resolve().parent;start=time.perf_counter()
data=json.loads((root/'T66_WALSH_NOVA_AMOSTRA.json').read_text());seven=json.loads((root/'T31_SETIMA_CERTIFICADO.json').read_text());factor=json.loads((root/'T28_SEXTA_CERTIFICADO.json').read_text())['fourth_factorization']
x=np.arange(65536,dtype=np.uint32);seen=set();words=[]
for indices in combinations(range(16),4):
 mask=sum(1<<j for j in indices)
 if mask in seen:continue
 orbit={((mask<<j)|(mask>>(16-j)))&65535 for j in range(16)};seen.update(orbit);truth=np.zeros(65536,dtype=np.uint8)
 for m in orbit:truth^=((x&m)==m)
 words.append(int.from_bytes(np.packbits(truth,bitorder='little').tobytes(),'little'))
assert len(words)==116
input_orbits=[];seen=set()
for u in range(65536):
 if u in seen:continue
 orbit=sorted({((u<<j)|(u>>(16-j)))&65535 for j in range(16)});seen.update(orbit);input_orbits.append(orbit)
frequencies=[o[0] for o in input_orbits if len(o)<=8]
full_even=[o[0] for o in input_orbits if len(o)==16 and o[0].bit_count()%2==0];full_odd=[o[0] for o in input_orbits if len(o)==16 and o[0].bit_count()%2]
generator_even=[];generator_odd=[]
for word in words:
 bits=np.unpackbits(np.frombuffer(word.to_bytes(8192,'little'),dtype=np.uint8),bitorder='little')
 generator_even.append(int(bits[full_even].sum()));generator_odd.append(int(bits[full_odd].sum()))
gemini={'all_odd_generator_weights_divisible_by_eight':all(w%8==0 for w in generator_odd),'even_weights_not_divisible_by_four':[j for j,w in enumerate(generator_even) if w%4],'even_weights_four_mod_eight':[j for j,w in enumerate(generator_even) if w%8==4],'generator_even_weights':generator_even,'generator_odd_weights':generator_odd}
chi={u:int.from_bytes(np.packbits(np.bitwise_count(x&u)%2,bitorder='little').tobytes(),'little') for u in [0xffff,0x101]}
supports=[0x3f3f,0x5f5f,0x6f6f,0x33ff,0x66ff,0x73bf,0x76ef]
masks={u:int.from_bytes(np.packbits((x&u)==x,bitorder='little').tobytes(),'little') for u in supports}
def parity(c,indices):return sum(c>>j&1 for j in indices)%2
prefix=[0,0,0];thirteen=0;thirteen_triple=0;controls=[];ids=set();periodic_prefix=[0]*36;thirteen_records=[]
for row in data['records']:
 c=int(row['coefficient_hex'],16);assert 0<=c<1<<116 and c not in ids;ids.add(c)
 a=c>>57&1;b=c>>99&1
 assert c>>115&1==0 and (c>>113&1)==a and b==parity(c,seven['L'])
 assert parity(c,factor['linear'])==sum(parity(c,p['I'])*parity(c,p['J']) for p in factor['products'])%2
 K=parity(c,seven['K']);assert b*(a^K)==0
 assert parity(c,seven['R'])^((1^b)*parity(c,seven['M']))^((1^a)*K)==0
 tt=0
 for j,word in enumerate(words):
  if c>>j&1:tt^=word
 signed=tt^chi[0xffff];h=[(1<<u.bit_count())-2*(signed&masks[u]).bit_count() for u in supports]
 assert h[:3]==row['periodic_h'] and all(v%32==0 for v in h[:3])
 passes13=all(v%16==0 for v in h[3:]);thirteen+=passes13
 W=[65536-2*tt.bit_count(),65536-2*(tt^chi[0xffff]).bit_count(),65536-2*(tt^chi[0x101]).bit_count()];assert W==row['walsh']
 if passes13:thirteen_records.append({'coefficient_hex':hex(c),'walsh_triple':W})
 good=True
 for j,v in enumerate(W):good=good and abs(v)==256;prefix[j]+=good
 if good:
  thirteen_triple+=passes13
  bits=np.unpackbits(np.frombuffer(tt.to_bytes(8192,'little'),dtype=np.uint8),bitorder='little').astype(np.int32);spectrum=1-2*bits
  for k in range(16):
   block=spectrum.reshape(-1,2,1<<k);A=block[:,0,:].copy();B=block[:,1,:].copy();block[:,0,:]=A+B;block[:,1,:]=A-B
  assert spectrum[[0,65535,0x101]].tolist()==W
  good36=True
  for j,u in enumerate(frequencies):good36=good36 and abs(int(spectrum[u]))==256;periodic_prefix[j]+=good36
  controls.append({'coefficient_hex':hex(c),'passes_thirteen':passes13,'walsh_triple':W,'periodic_Walsh':[int(spectrum[u]) for u in frequencies],'maximum_absolute_Walsh':int(np.abs(spectrum).max())})
assert prefix==data['prefix_survivors'] and len(ids)==4096
result={'verification':'PASS','functions_checked':len(ids),'core_and_nine_filters_checked':len(ids),'prefix_survivors':prefix,'thirteen_survivors':thirteen,'thirteen_records':thirteen_records,'thirteen_and_triple_survivors':thirteen_triple,'triple_survivors':controls,'periodic_frequencies_hex':[hex(u) for u in frequencies],'periodic_prefix_among_triple_survivors':periodic_prefix,'all_36_survivors':periodic_prefix[-1],'Gemini_generator_weight_audit':gemini,'seconds':time.perf_counter()-start,'scope':'Exact checks on finite sample and explicit witnesses. No global nonexistence claim.'}
(root/'T66_WALSH_NOVA_AMOSTRA_VERIFICACAO.json').write_text(json.dumps(result,indent=2));print(json.dumps({k:v for k,v in result.items() if k not in ['triple_survivors','thirteen_records','Gemini_generator_weight_audit']},indent=2))
