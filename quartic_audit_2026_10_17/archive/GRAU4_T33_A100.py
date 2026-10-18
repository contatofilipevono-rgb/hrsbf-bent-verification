"""T33: exact re-scan of T16 with three proved linear laws and three proved quadratic laws.
Requires CuPy, an A100, GRAU4_T16_A100.py and T33_parameterization.npz beside this file.
Default is a bounded pilot; call run(full_scan=True) to resume the complete finite domain.
"""
from pathlib import Path
import hashlib,json,time,zipfile
import numpy as np
import GRAU4_T16_A100 as t16

CUDA=r'''
extern "C" __global__ void ids10(unsigned long long start,int count,
 const unsigned int* parents,const unsigned short* ga,const unsigned short* gb,
 const unsigned char* ca,const unsigned char* cb,const unsigned char* pa,const unsigned char* pb,
 unsigned long long* output){
 int i=blockIdx.x*blockDim.x+threadIdx.x;if(i>=count)return;
 unsigned long long ordinal=start+i;unsigned int row=ordinal>>10,z=ordinal&1023U;
 unsigned int p=pa[row],q=pb[row],extension=0,k=0;
 for(unsigned int j=0;j<12;j++)if(j!=p&&j!=q){extension|=((z>>k)&1U)<<j;k++;}
 extension|=((__popc(extension&ga[row])^ca[row])&1U)<<p;
 extension|=((__popc(extension&gb[row])^cb[row])&1U)<<q;
 output[i]=(unsigned long long)parents[row]|((unsigned long long)extension<<21);
}

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
FIFTH_MASKS=[0x8541,0x11e78]
def fifth(ids):
 ids=np.asarray(ids,dtype=np.uint64)
 return (np.bitwise_count(ids&np.uint64(FIFTH_MASKS[0]))%2)&(np.bitwise_count(ids&np.uint64(FIFTH_MASKS[1]))%2)
FORM_MASKS=[0x100e00001,0x100ffce38,0x100fed040,0xfc06db0,0xfc06e40,0x6db0,0x10238,0xfc0cc00,0xfc04ab0]
SEVENTH_MASKS=[0xfccfe72,0x16f88,0x8540,0x1,0x2]
def seventh(ids):
 ids=np.asarray(ids,dtype=np.uint64);R,M,K,a,b=[np.bitwise_count(ids&np.uint64(m))%2 for m in SEVENTH_MASKS]
 return R^M^K^(b&M)^(a&K)

def quadratic(ids):
 ids=np.asarray(ids,dtype=np.uint64);bits=[np.bitwise_count(ids&np.uint64(m))%2 for m in FORM_MASKS];out=bits[0].copy()
 for j in range(4):out^=bits[1+2*j]&bits[2+2*j]
 return out
def cpu_ids10(ordinals,parameters):
 ordinals=np.asarray(ordinals,dtype=np.uint64);rows=(ordinals>>np.uint64(10)).astype(np.int64);z=(ordinals&np.uint64(1023)).astype(np.uint32)
 pa=parameters['pivot_a'][rows];pb=parameters['pivot_b'][rows];extension=np.zeros(len(z),dtype=np.uint32);k=np.zeros(len(z),dtype=np.uint32)
 for j in range(12):
  use=(pa!=j)&(pb!=j);extension|=np.where(use,((z>>k)&1)<<j,0).astype(np.uint32);k+=use.astype(np.uint32)
 for suffix,pivot in [('a',pa),('b',pb)]:
  bit=(np.bitwise_count(extension&parameters['gradient_'+suffix][rows])^parameters['constant_'+suffix][rows])&1
  extension|=bit.astype(np.uint32)<<pivot
 return parameters['parents_10'][rows].astype(np.uint64)|(extension.astype(np.uint64)<<np.uint64(21))

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
 here=Path(__file__).resolve().parent;parameter_path=here/'T33_parameterization.npz';p=dict(np.load(parameter_path))
 device=cp.cuda.runtime.getDeviceProperties(0)['name'];device=device.decode() if isinstance(device,bytes) else str(device)
 if 'A100' not in device:raise RuntimeError('Selecione uma A100 antes de executar este experimento.')
 assert not np.any(fifth(p['parents_10'])) and not np.any(fifth(p['parents_11']))
 source_signature=hashlib.sha256(Path(__file__).read_bytes()+(here/'GRAU4_T16_A100.py').read_bytes()+parameter_path.read_bytes()).hexdigest()
 target10=len(p['parents_10'])*1024;target11=len(p['parents_11'])*2048;target=target10+target11
 assert (len(p['parents_10']),len(p['parents_11']),target)==(65024,46852,162537472)
 d=t16.setup();runner=t16.Runner(d);assert np.array_equal(p['P'],d['P'])
 dev={k:cp.asarray(p[k]) for k in ['parents_10','gradient_a','gradient_b','constant_a','constant_b','pivot_a','pivot_b','parents_11','gradient_11','constant_11']}
 mapper10=cp.RawKernel(CUDA,'ids10');mapper11=cp.RawKernel(CUDA,'ids11')
 def map_group(start,count,group):
  output=cp.empty(count,dtype=cp.uint64)
  if group==10:mapper10(((count+255)//256,),(256,),(np.uint64(start),np.int32(count),dev['parents_10'],dev['gradient_a'],dev['gradient_b'],dev['constant_a'],dev['constant_b'],dev['pivot_a'],dev['pivot_b'],output))
  else:mapper11(((count+255)//256,),(256,),(np.uint64(start),np.int32(count),dev['parents_11'],dev['gradient_11'],dev['constant_11'],output))
  return output
 rng=np.random.default_rng(20261017206)
 for group,total,mapper in [(10,target10,cpu_ids10),(11,target11,cpu_ids11)]:
  direct=cp.asnumpy(map_group(0,512,group));assert np.array_equal(direct,mapper(np.arange(512,dtype=np.uint64),p))
  for start in rng.integers(0,total-256,8):
   ids=cp.asnumpy(map_group(int(start),256,group));reference=mapper(np.arange(start,start+256,dtype=np.uint64),p)
   assert np.array_equal(ids,reference) and not np.any(quadratic(ids)) and not np.any(fifth(ids)) and not np.any(seventh(ids))
   assert np.array_equal(cp.asnumpy(runner.evaluate(cp.asarray(ids),True))==0,t16.cpu_oracle(d,ids,True))
 print('T33: geracao de estados, nova condicao e filtros CPU/GPU: PASS',flush=True)
 root=here/'T33_results';root.mkdir(exist_ok=True);checkpoint=root/'checkpoint.npz';hist=np.zeros(257,dtype=np.int64);done=0;examples=np.empty(0,dtype=np.uint64)
 if checkpoint.exists():
  old=np.load(checkpoint);assert str(old['signature'])==source_signature,'Checkpoint de outra versao: preserve-o em outra pasta.'
  done=int(old['done']);hist=old['hist'];examples=old['examples'];assert int(hist.sum())==done
 initial=done;stop=target if full_scan else min(target,done+int(pilot_states));begin=time.perf_counter()
 while done<stop:
  group=10 if done<target10 else 11;boundary=target10 if group==10 else target;end=min(stop,done+batch,boundary);local=done if group==10 else done-target10
  ids=map_group(local,end-done,group);flags=runner.evaluate(ids,True);hist+=cp.asnumpy(cp.bincount(flags,minlength=257));done=end
  if len(examples)<256:examples=np.r_[examples,cp.asnumpy(ids[flags==0])[:256-len(examples)]]
  if done==stop or done==boundary or done-initial==batch or (done-initial)%(16*batch)==0:
   cp.cuda.get_current_stream().synchronize();elapsed=time.perf_counter()-begin;assert int(hist.sum())==done
   temp=root/'checkpoint.tmp.npz';np.savez_compressed(temp,signature=source_signature,done=done,hist=hist,examples=examples);temp.replace(checkpoint)
   report={'status':'EXACT_COMPLETE_T33_DOMAIN' if done==target else 'EXACT_PREFIX_PILOT','n':16,'processed':done,'target':target,'survivors':int(hist[0]),'three_linear_laws_and_three_quadratics':'PROVED_NECESSARY_CONDITIONS','mapping_and_filter_CPU_GPU_validation':'PASS','session_seconds':elapsed,'states_per_second_this_session':(done-initial)/max(elapsed,1e-9),'estimated_remaining_seconds':(target-done)*elapsed/max(1,done-initial),'device':device,'source_signature':source_signature,'scope':'First five conditions and seventh condition, plus energy/Poisson filters on the complete T33 domain or its explicit prefix. Survivors are not certified bent.'}
   (root/'progress.json').write_text(json.dumps(report,indent=2));print(json.dumps(report),flush=True)
 if len(examples):assert not np.any(quadratic(examples));assert not np.any(fifth(examples));assert not np.any(seventh(examples));assert np.all(t16.cpu_oracle(d,examples[:128],True))
 archive=here/'GRAU4_T33_RESULTADOS.zip';entries=[checkpoint,root/'progress.json'];manifest=[]
 with zipfile.ZipFile(archive,'w',zipfile.ZIP_DEFLATED) as z:
  for path in entries:
   name='results/'+path.name;content=path.read_bytes();z.writestr(name,content);manifest.append(hashlib.sha256(content).hexdigest()+'  '+name)
  z.writestr('SHA256SUMS.txt','\n'.join(manifest)+'\n')
 print('Arquivo de resultados:',archive,flush=True)
 return str(archive)
if __name__=='__main__':run(full_scan=False)
