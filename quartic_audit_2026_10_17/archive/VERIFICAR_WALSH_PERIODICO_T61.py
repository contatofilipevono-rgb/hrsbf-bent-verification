"""Independent direct FWHT check; needs Python and NumPy, no work/ imports."""
from pathlib import Path
from itertools import combinations
import json,time,numpy as np
start=time.perf_counter();root=Path(__file__).resolve().parent
report=json.loads((root/'T61_WALSH_PERIODICO_PILOTO.json').read_text())
x=np.arange(65536,dtype=np.uint32);seen=set();words=[]
for indices in combinations(range(16),4):
 mask=sum(1<<j for j in indices)
 if mask in seen:continue
 orbit={((mask<<j)|(mask>>(16-j)))&65535 for j in range(16)};seen.update(orbit)
 truth=np.zeros(65536,dtype=np.uint8)
 for m in orbit:truth^=((x&m)==m)
 words.append(int.from_bytes(np.packbits(truth,bitorder='little').tobytes(),'little'))
assert len(words)==116
frequencies=[int(u,16) for u in report['frequencies_hex']]
assert len(frequencies)==36 and len(set(frequencies))==36
expected=set();visited=set()
for u in range(65536):
 if u in visited:continue
 orbit={((u<<j)|(u>>(16-j)))&65535 for j in range(16)};visited.update(orbit)
 if len(orbit)<=8:expected.add(min(orbit))
assert set(frequencies)==expected
order=[frequencies.index(int(u,16)) for u in report['filter_order_hex']]
assert sorted(order)==list(range(36))
prefix=[0]*36;pair13=0;ids=set()
for row in report['records']:
 c=int(row['coefficient_hex'],16);assert 0<=c<1<<116 and c not in ids;ids.add(c);tt=0
 for j,word in enumerate(words):
  if c>>j&1:tt^=word
 bits=np.unpackbits(np.frombuffer(tt.to_bytes(8192,'little'),dtype=np.uint8),bitorder='little').astype(np.int32)
 spectrum=1-2*bits
 for k in range(16):
  block=spectrum.reshape(-1,2,1<<k);left=block[:,0,:].copy();right=block[:,1,:].copy();block[:,0,:]=left+right;block[:,1,:]=left-right
 assert spectrum[frequencies].tolist()==row['walsh']
 valid=True
 for k,j in enumerate(order):
  valid=valid and abs(row['walsh'][j])==256;prefix[k]+=valid
 if row['passes_thirteen'] and all(abs(row['walsh'][j])==256 for j in order[:2]):pair13+=1
assert prefix==report['prefix_survivors'] and len(ids)==report['sample_size']==512
assert pair13==report['thirteen_pair_survivors']
result={'verification':'PASS','original_functions_reconstructed':len(ids),'complete_direct_Walsh_transforms':len(ids),'periodic_amplitudes_checked':len(ids)*36,'prefix_survivors_first_three':prefix[:3],'seconds':time.perf_counter()-start,'scope':'Exact Walsh values and finite sample counts verified. Membership labels in earlier algebraic filters are inherited metadata, not independently reverified here. No global exclusion claim.'}
(root/'T61_WALSH_PERIODICO_VERIFICACAO.json').write_text(json.dumps(result,indent=2));print(json.dumps(result,indent=2))
