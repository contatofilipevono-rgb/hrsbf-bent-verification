"""Independent original-function audit of SAT candidates; not a bentness assertion."""
from pathlib import Path
import runpy,json,time,numpy as np
root=Path(__file__).resolve().parent;start=time.perf_counter();ctx=runpy.run_path(str(root/'VERIFICAR_NOVA_AMOSTRA_WALSH_T66.py'));words=ctx['words'];seven=ctx['seven'];factor=ctx['factor'];parity=ctx['parity'];records=[]
for branch in range(2):
 path=root/f'T83_SAT_EXATO_SEIS_RAMO{branch}.json'
 if not path.exists():continue
 row=json.loads(path.read_text())
 if row['answer'] is not True:continue
 c=int(row['coefficient_hex'],16);a=c>>57&1;b=c>>99&1;assert b==branch
 assert not(c>>115&1) and c>>113&1==a and b==parity(c,seven['L'])
 assert parity(c,factor['linear'])==sum(parity(c,p['I'])*parity(c,p['J']) for p in factor['products'])%2
 assert not b*(a^parity(c,seven['K']))
 assert parity(c,seven['R'])^((1^b)*parity(c,seven['M']))^((1^a)*parity(c,seven['K']))==0
 tt=0
 for j,w in enumerate(words):
  if c>>j&1:tt^=w
 bits=np.unpackbits(np.frombuffer(tt.to_bytes(8192,'little'),dtype=np.uint8),bitorder='little').astype(np.int32);fw=1-2*bits
 for k in range(16):
  block=fw.reshape(-1,2,1<<k);A=block[:,0,:].copy();B=block[:,1,:].copy();block[:,0,:]=A+B;block[:,1,:]=A-B
 assert {u:int(fw[int(u,16)]) for u in row['original_Walsh']}==row['original_Walsh'];assert all(abs(v)==256 for v in row['original_Walsh'].values())
 h=[4096-2*((tt^ctx['chi'][0xffff])&ctx['masks'][u]).bit_count() for u in ctx['supports']]
 profiles=json.loads((root/'T75_PROJECAO_WALSH_CERTIFICADO.json').read_text())['tables']['8'];freq=[int(u,16) for u in profiles['frequencies_hex']]
 records.append({'branch':b,'coefficient_hex':hex(c),'all_six_amplitudes_verified':True,'periodic_support_h':dict(zip([hex(u) for u in ctx['supports']],h)),'passes_nine':all(v%32==0 for v in h[:3]),'passes_thirteen':all(v%32==0 for v in h[:3]) and all(v%16==0 for v in h[3:]),'periodic_Walsh':dict(zip(profiles['frequencies_hex'],[int(fw[u]) for u in freq])),'maximum_absolute_Walsh':int(np.abs(fw).max()),'is_bent':bool(np.all(np.abs(fw)==256))})
result={'verification':'PASS','original_candidates_checked':len(records),'records':records,'seconds':time.perf_counter()-start,'scope':'Exact original-function verification of six-frequency SAT models. Bentness is checked separately by the full spectrum.'}
(root/'T83_CANDIDATOS_VERIFICACAO.json').write_text(json.dumps(result,indent=2));print(json.dumps(result,indent=2))
