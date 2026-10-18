"""T26: exact re-scan of T16 with three proved linear laws and a new quadratic law.
Requires CuPy, an A100, GRAU4_T16_A100.py and T26_parameterization.npz beside this file.
Default is a bounded pilot; call run(full_scan=True) to resume the complete finite domain.
"""
from pathlib import Path
import hashlib,json,time,zipfile
import numpy as np
import GRAU4_T16_A100 as t16

CUDA=r'''
extern "C" __global__ void ids11(unsigned long long start,int count,
 const unsigned int* parents,const unsigned short* gradient,
 const unsigned char* constant,unsigned long long* output){
 int i=blockIdx.x*blockDim.x+threadIdx.x;if(i>=count)return;
 unsigned long long ordinal=start+i;unsigned int row=ordinal>>11,z=ordinal&2047U;
 unsigned int g=gradient[row],pivot=__ffs(g)-1,lower=(1U<<pivot)-1;
 unsigned int extension=(z&lower)|((z>>pivot)<<(pivot+1));
 unsigned int bit=(__popc(extension&g)^constant[row])&1U;
 extension|=bit<<pivot;
 output[i]=(unsigned long long)parents[row]|((unsigned long long)extension<<21);
}
extern "C" __global__ void ids12(unsigned long long start,int count,
 const unsigned int* parents,unsigned long long* output){
 int i=blockIdx.x*blockDim.x+threadIdx.x;if(i>=count)return;
 unsigned long long ordinal=start+i;unsigned int row=ordinal>>12,extension=ordinal&4095U;
 output[i]=(unsigned long long)parents[row]|((unsigned long long)extension<<21);
}
'''
FORM_MASKS=[0x100e00001,0x100ffce38,0x100fed040,0xfc06db0,0xfc06e40,0x6db0,0x10238,0xfc0cc00,0xfc04ab0]
def quadratic(ids):
 ids=np.asarray(ids,dtype=np.uint64);bits=[np.bitwise_count(ids&np.uint64(m))%2 for m in FORM_MASKS];out=bits[0].copy()
 for j in range(4):out^=bits[1+2*j]&bits[2+2*j]
 return out
def cpu_ids11(ordinals,parameters):
 ordinals=np.asarray(ordinals,dtype=np.uint64);rows=(ordinals>>np.uint64(11)).astype(np.int64);z=(ordinals&np.uint64(2047)).astype(np.uint32)
 g=parameters['gradient_11'][rows].astype(np.uint32);pivot=np.array([(int(v)&-int(v)).bit_length()-1 for v in g],dtype=np.uint32);lower=(np.uint32(1)<<pivot)-1
 extension=(z&lower)|((z>>pivot)<<(pivot+1));bit=(np.bitwise_count(extension&g)^parameters['constant_11'][rows])&1;extension|=bit.astype(np.uint32)<<pivot
 return parameters['parents_11'][rows].astype(np.uint64)|(extension.astype(np.uint64)<<np.uint64(21))
def cpu_ids12(ordinals,parameters):
 ordinals=np.asarray(ordinals,dtype=np.uint64);rows=(ordinals>>np.uint64(12)).astype(np.int64)
 return parameters['parents_12'][rows].astype(np.uint64)|((ordinals&np.uint64(4095))<<np.uint64(21))
def run(full_scan=False,pilot_states=1<<24,batch=1<<20):
 import cupy as cp
 here=Path(__file__).resolve().parent;parameter_path=here/'T26_parameterization.npz';p=dict(np.load(parameter_path))
 device=cp.cuda.runtime.getDeviceProperties(0)['name'];device=device.decode() if isinstance(device,bytes) else str(device)
 if 'A100' not in device:raise RuntimeError('Selecione uma A100 antes de executar este experimento.')
 source_signature=hashlib.sha256(Path(__file__).read_bytes()+(here/'GRAU4_T16_A100.py').read_bytes()+parameter_path.read_bytes()).hexdigest()
 target11=len(p['parents_11'])*2048;target12=len(p['parents_12'])*4096;target=target11+target12
 assert (len(p['parents_11']),len(p['parents_12']),target)==(173056,25348,458244096)
 d=t16.setup();runner=t16.Runner(d);assert np.array_equal(p['P'],d['P'])
 dev={k:cp.asarray(p[k]) for k in ['parents_11','gradient_11','constant_11','parents_12']}
 mapper11=cp.RawKernel(CUDA,'ids11');mapper12=cp.RawKernel(CUDA,'ids12')
 def map_group(start,count,group):
  output=cp.empty(count,dtype=cp.uint64)
  if group==11:mapper11(((count+255)//256,),(256,),(np.uint64(start),np.int32(count),dev['parents_11'],dev['gradient_11'],dev['constant_11'],output))
  else:mapper12(((count+255)//256,),(256,),(np.uint64(start),np.int32(count),dev['parents_12'],output))
  return output
 rng=np.random.default_rng(20261017206)
 for group,total,mapper in [(11,target11,cpu_ids11),(12,target12,cpu_ids12)]:
  direct=cp.asnumpy(map_group(0,512,group));assert np.array_equal(direct,mapper(np.arange(512,dtype=np.uint64),p))
  for start in rng.integers(0,total-256,8):
   ids=cp.asnumpy(map_group(int(start),256,group));reference=mapper(np.arange(start,start+256,dtype=np.uint64),p)
   assert np.array_equal(ids,reference) and not np.any(quadratic(ids))
   assert np.array_equal(cp.asnumpy(runner.evaluate(cp.asarray(ids),True))==0,t16.cpu_oracle(d,ids,True))
 print('T26: geracao de estados, nova condicao e filtros CPU/GPU: PASS',flush=True)
 root=here/'T26_results';root.mkdir(exist_ok=True);checkpoint=root/'checkpoint.npz';hist=np.zeros(257,dtype=np.int64);done=0;examples=np.empty(0,dtype=np.uint64)
 if checkpoint.exists():
  old=np.load(checkpoint);assert str(old['signature'])==source_signature,'Checkpoint de outra versao: preserve-o em outra pasta.'
  done=int(old['done']);hist=old['hist'];examples=old['examples'];assert int(hist.sum())==done
 initial=done;stop=target if full_scan else min(target,done+int(pilot_states));begin=time.perf_counter()
 while done<stop:
  group=11 if done<target11 else 12;boundary=target11 if group==11 else target;end=min(stop,done+batch,boundary);local=done if group==11 else done-target11
  ids=map_group(local,end-done,group);flags=runner.evaluate(ids,True);hist+=cp.asnumpy(cp.bincount(flags,minlength=257));done=end
  if len(examples)<256:examples=np.r_[examples,cp.asnumpy(ids[flags==0])[:256-len(examples)]]
  if done==stop or done==boundary or done-initial==batch or (done-initial)%(16*batch)==0:
   cp.cuda.get_current_stream().synchronize();elapsed=time.perf_counter()-begin;assert int(hist.sum())==done
   temp=root/'checkpoint.tmp.npz';np.savez_compressed(temp,signature=source_signature,done=done,hist=hist,examples=examples);temp.replace(checkpoint)
   report={'status':'EXACT_COMPLETE_T26_DOMAIN' if done==target else 'EXACT_PREFIX_PILOT','n':16,'processed':done,'target':target,'survivors':int(hist[0]),'three_linear_laws_and_quadratic':'PROVED_NECESSARY_CONDITIONS','mapping_and_filter_CPU_GPU_validation':'PASS','session_seconds':elapsed,'states_per_second_this_session':(done-initial)/max(elapsed,1e-9),'estimated_remaining_seconds':(target-done)*elapsed/max(1,done-initial),'device':device,'source_signature':source_signature,'scope':'Necessary filters on the complete T26 domain or its explicit prefix. Survivors are not certified bent.'}
   (root/'progress.json').write_text(json.dumps(report,indent=2));print(json.dumps(report),flush=True)
 if len(examples):assert not np.any(quadratic(examples));assert np.all(t16.cpu_oracle(d,examples[:128],True))
 archive=here/'GRAU4_T26_RESULTADOS.zip';entries=[checkpoint,root/'progress.json'];manifest=[]
 with zipfile.ZipFile(archive,'w',zipfile.ZIP_DEFLATED) as z:
  for path in entries:
   name='results/'+path.name;content=path.read_bytes();z.writestr(name,content);manifest.append(hashlib.sha256(content).hexdigest()+'  '+name)
  z.writestr('SHA256SUMS.txt','\n'.join(manifest)+'\n')
 print('Arquivo de resultados:',archive,flush=True)
 return str(archive)
if __name__=='__main__':run(full_scan=False)
