"""Colab/Linux: python RODAR_H12_A100_AUDITADO.py (piloto de 2^22).
Varredura completa: acrescente --full. Validacao local: --validate-only.
Conclusoes condicionadas as cinco leis iniciais; nao prova nao existencia global.
Somente biblioteca padrao Python + nvcc/CUDA no computador de execucao.
"""
import argparse
from collections import Counter
import hashlib
from itertools import combinations
import json
from pathlib import Path
import random
import shutil
import subprocess
import time

LAWS = [[40], [42,26], [39,8,14,19,26],
        [37,0,2,6,12,15,23,25], [36,1,7,9,18,24,32,34],
        [3,4,5,21,22,26,27,33,35],
        [0,3,4,5,7,12,21,22,23,24,25,27,32,33,34,35]]


def nullspace(rows, n):
    piv = {}
    for v in rows:
        while v:
            p = v.bit_length()-1
            if p in piv:
                v ^= piv[p]
            else:
                piv[p] = v
                break
    basis = []
    for j in range(n):
        if j in piv:
            continue
        v = 1 << j
        for p in sorted(piv):
            if (v & piv[p]).bit_count() & 1:
                v ^= 1 << p
        basis.append(v)
    assert all(not ((v&r).bit_count()&1) for v in basis for r in rows)
    return basis


def orbits(k):
    result, seen = [], set()
    for c in combinations(range(12), k):
        m = sum(1 << i for i in c)
        if m in seen:
            continue
        orb = {((m << r) | (m >> (12-r))) & 4095 for r in range(12)}
        seen.update(orb)
        result.append(sorted(orb))
    return result


def xor_selected(z, columns):
    v = 0
    while z:
        bit = z & -z
        v ^= columns[bit.bit_length()-1]
        z ^= bit
    return v


def prepare():
    orb = orbits(4)
    assert len(orb) == 43
    basis = nullspace([sum(1 << i for i in row) for row in LAWS], 43)
    assert len(basis) == 36
    original = [sum((sum((x&m)==m for m in o)&1) << x for x in range(4096)) for o in orb]
    truth = [xor_selected(v, original) for v in basis]
    filters = [(o[0],1) for o in orbits(8)] + [(u,2) for u in (0x3cf,0x5d7,0x6db)] + [(4095,3)]
    masks = [sum(1 << x for x in range(4096) if (x&u)==x) for u,b in filters]
    # A bit-b of a sum of linear Boolean forms is quadratic if every
    # nonzero signature multiplicity is divisible by 2^(b-1).
    # Check that hypothesis on every subcube before interpolating.
    signatures = [sum(((t >> x)&1) << j for j,t in enumerate(truth)) for x in range(4096)]
    for u,b in filters:
        counts = Counter(signatures[x] for x in range(4096) if (x&u)==x)
        assert all(s==0 or n % (1 << (b-1)) == 0 for s,n in counts.items())
    def exact(z):
        t = xor_selected(z, truth)
        return sum((((t&m).bit_count() >> b)&1) << e for e,((u,b),m) in enumerate(zip(filters,masks)))
    pairs = list(combinations(range(36),2))
    v0 = exact(0)
    singles = [exact(1 << i) for i in range(36)]
    doubles = [exact((1 << i)|(1 << j)) for i,j in pairs]
    eqs = []
    for e,(u,b) in enumerate(filters):
        c = (v0 >> e)&1
        lin = sum((((s >> e)&1)^c) << i for i,s in enumerate(singles))
        rows = [0]*36
        for (i,j),s in zip(pairs,doubles):
            if ((s >> e)&1)^c^((lin >> i)&1)^((lin >> j)&1):
                rows[i] |= 1 << j
        if c or lin or any(rows):
            eqs.append((e,c,lin,rows))
    assert len(eqs) == 42
    def evaluate(z):
        values = 0
        for k,(e,c,lin,rows) in enumerate(eqs):
            v = c ^ ((z&lin).bit_count()&1)
            for i in range(36):
                if (z >> i)&1:
                    v ^= (z&rows[i]).bit_count()&1
            values |= v << k
        return values
    rng = random.Random(106)
    checks = [0, (1<<36)-1] + [1 << i for i in range(36)] + [rng.getrandbits(36) for _ in range(256)]
    for z in checks:
        raw = exact(z)
        expected = sum(((raw >> e)&1) << k for k,(e,*_) in enumerate(eqs))
        assert evaluate(z) == expected
    return basis,truth,eqs,checks,[evaluate(z) for z in checks]


CUDA = r'''
#include <cuda_runtime.h>
#include <cstdio>
#include <cstdlib>
#include <cstdint>
#include <algorithm>
#define CK(call) do { cudaError_t e=(call); if(e!=cudaSuccess){fprintf(stderr,"CUDA ERROR line %d: %s\n",__LINE__,cudaGetErrorString(e));exit(2);} } while(0)
using U = unsigned long long;
__constant__ U L[42], Q[42][36], T[36][64], C;
__host__ __device__ inline unsigned parity(U x) {
#ifdef __CUDA_ARCH__
 return __popcll(x)&1;
#else
 return __builtin_popcountll(x)&1;
#endif
}
__device__ U values(U x) {
 U result=0;
 for(int e=0;e<42;e++) {
  U q=0, bits=x;
  while(bits){int i=__ffsll((long long)bits)-1; q^=Q[e][i]&x; bits&=bits-1;}
  result |= U(parity(q)^parity(L[e]&x)^((C>>e)&1))<<e;
 }
 return result;
}
__device__ bool passes(U x) {
 for(int e=0;e<42;e++) {
  U q=0,bits=x;
  while(bits){int i=__ffsll((long long)bits)-1;q^=Q[e][i]&x;bits&=bits-1;}
  if(parity(q)^parity(L[e]&x)^((C>>e)&1))return false;
 }
 return true;
}
__global__ void validate(const U* input,U* output,unsigned n){
 unsigned i=blockIdx.x*blockDim.x+threadIdx.x;
 if(i<n)output[i]=values(input[i]);
}
__global__ void scan(U start,unsigned n,U* found,unsigned* count,U* raw){
 U i=U(blockIdx.x)*blockDim.x+threadIdx.x;
 if(i>=n)return;
 U x=start+i;
 if(!passes(x))return;
 atomicAdd(raw,1ULL);
 unsigned weight=0;
 for(int w=0;w<64;w++){
  U value=0,bits=x;
  while(bits){int j=__ffsll((long long)bits)-1;value^=T[j][w];bits&=bits-1;}
  weight+=__popcll(value);
 }
 // W(0)=4096-2*weight must equal +/-64.
 if(weight!=2016 && weight!=2080)return;
 unsigned p=atomicAdd(count,1u);
 // capacity is n, so no candidate can be truncated.
 found[p]=x;
}
// DATA
int main(int argc,char**argv){
 U start=argc>1?strtoull(argv[1],nullptr,0):0;
 U amount=argc>2?strtoull(argv[2],nullptr,0):(1ULL<<22);
 unsigned chunk=1u<<20;
 if(start>(1ULL<<36)||amount>(1ULL<<36)-start){fprintf(stderr,"Invalid range\n");return 3;}
 CK(cudaSetDevice(0));cudaDeviceProp prop;CK(cudaGetDeviceProperties(&prop,0));
 printf("GPU %s; conditional domain of 36 variables\n",prop.name);fflush(stdout);
 CK(cudaMemcpyToSymbol(L,hL,sizeof(hL)));CK(cudaMemcpyToSymbol(Q,hQ,sizeof(hQ)));
 CK(cudaMemcpyToSymbol(T,hT,sizeof(hT)));CK(cudaMemcpyToSymbol(C,&hC,sizeof(hC)));
 U *di,*dout;CK(cudaMalloc(&di,sizeof(tests)));CK(cudaMalloc(&dout,sizeof(tests)));
 CK(cudaMemcpy(di,tests,sizeof(tests),cudaMemcpyHostToDevice));
 validate<<<(NTEST+255)/256,256>>>(di,dout,NTEST);CK(cudaGetLastError());CK(cudaDeviceSynchronize());
 U actual[NTEST];CK(cudaMemcpy(actual,dout,sizeof(actual),cudaMemcpyDeviceToHost));
 for(int i=0;i<NTEST;i++)if(actual[i]!=expected[i]){fprintf(stderr,"CPU/GPU validation FAILED at %d\n",i);return 4;}
 CK(cudaFree(di));CK(cudaFree(dout));printf("CPU_GPU_VALIDATION_PASS %d\n",NTEST);fflush(stdout);
 U *found,*raw;unsigned *count;
 CK(cudaMalloc(&found,sizeof(U)*chunk));CK(cudaMalloc(&raw,sizeof(U)));CK(cudaMalloc(&count,sizeof(unsigned)));
 U *host=new U[chunk];U totalRaw=0,totalW0=0,totalBent=0;
 cudaEvent_t a,b;CK(cudaEventCreate(&a));CK(cudaEventCreate(&b));
 for(U offset=0;offset<amount;){
  unsigned n=(unsigned)std::min(U(chunk),amount-offset);
  CK(cudaMemset(raw,0,sizeof(U)));CK(cudaMemset(count,0,sizeof(unsigned)));
  CK(cudaEventRecord(a));scan<<<(n+255)/256,256>>>(start+offset,n,found,count,raw);
  CK(cudaGetLastError());CK(cudaDeviceSynchronize());CK(cudaEventRecord(b));CK(cudaEventSynchronize(b));
  float ms;CK(cudaEventElapsedTime(&ms,a,b));unsigned hc;U hr;
  CK(cudaMemcpy(&hc,count,sizeof(hc),cudaMemcpyDeviceToHost));CK(cudaMemcpy(&hr,raw,sizeof(hr),cudaMemcpyDeviceToHost));
  if(hc>n){fprintf(stderr,"Corrupt count\n");return 5;}
  CK(cudaMemcpy(host,found,sizeof(U)*hc,cudaMemcpyDeviceToHost));
  for(unsigned k=0;k<hc;k++){
   U z=host[k],coeff=0;U word[64]={0};
   for(int j=0;j<36;j++)if((z>>j)&1){coeff^=basis[j];for(int w=0;w<64;w++)word[w]^=hT[j][w];}
   int walsh[4096];for(int x=0;x<4096;x++)walsh[x]=((word[x/64]>>(x%64))&1)?-1:1;
   for(int step=1;step<4096;step*=2)for(int p=0;p<4096;p+=2*step)for(int q=0;q<step;q++){
    int u=walsh[p+q],v=walsh[p+q+step];walsh[p+q]=u+v;walsh[p+q+step]=u-v;
   }
   bool bent=true;for(int x=0;x<4096;x++)if(abs(walsh[x])!=64){bent=false;break;}
   if(bent){totalBent++;printf("{\"bent\":true,\"z\":%llu,\"coefficients_hex\":\"%llx\"}\n",z,coeff);}
  }
  totalRaw+=hr;totalW0+=hc;offset+=n;
  printf("{\"end_exclusive\":%llu,\"tested\":%llu,\"quadratic_survivors\":%llu,\"w0_survivors\":%llu,\"bent\":%llu,\"gpu_batch_ms\":%.3f}\n",start+offset,offset,totalRaw,totalW0,totalBent,ms);fflush(stdout);
 }
 printf("{\"status\":\"COMPLETE_CONDITIONAL_RANGE\",\"start\":%llu,\"count\":%llu,\"bent\":%llu}\n",start,amount,totalBent);fflush(stdout);
 CK(cudaFree(found));CK(cudaFree(raw));CK(cudaFree(count));CK(cudaEventDestroy(a));CK(cudaEventDestroy(b));delete[]host;
 return 0;
}
'''


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--full',action='store_true')
    ap.add_argument('--count',type=int)
    ap.add_argument('--start',type=int,default=0)
    ap.add_argument('--validate-only',action='store_true')
    args=ap.parse_args()
    count=args.count if args.count is not None else (1<<36 if args.full else 1<<22)
    if not 0<=args.start<=1<<36 or not 0<count<=(1<<36)-args.start:
        ap.error('Intervalo invalido; ao retomar, informe --start e --count restantes.')
    folder=Path('h12_a100_auditado');folder.mkdir(exist_ok=True)
    t=time.perf_counter()
    basis,truth,eqs,checks,expected=prepare()
    scalar=lambda x:f'{x}ULL'
    array=lambda xs:'{'+','.join(scalar(x) for x in xs)+'}'
    data='\n'.join([
        'static U hC='+scalar(sum(c << k for k,(e,c,l,r) in enumerate(eqs)))+';',
        'static U hL[42]='+array([l for e,c,l,r in eqs])+';',
        'static U hQ[42][36]={'+','.join(array(r) for e,c,l,r in eqs)+'};',
        'static U hT[36][64]={'+','.join(array([(t>>(64*w))&((1<<64)-1) for w in range(64)]) for t in truth)+'};',
        'static U basis[36]='+array(basis)+';',
        f'constexpr int NTEST={len(checks)};',
        'static U tests[NTEST]='+array(checks)+';',
        'static U expected[NTEST]='+array(expected)+';'])
    source=CUDA.replace('// DATA',data)
    cu=folder/'solver.cu';cu.write_text(source,encoding='utf-8')
    metadata={'scope':'Conditional on the five initial laws; no global nonexistence claim.',
              'initial_laws':LAWS[:5],'additional_laws':LAWS[5:],
              'basis_36_hex':[hex(v) for v in basis],'filters':47,'active_equations':42,
              'degree_hypothesis':'PASS','interpolation_points':667,
              'dense_and_boundary_checks':len(checks),
              'cuda_sha256':hashlib.sha256(source.encode()).hexdigest(),
              'gpu_executed':False}
    (folder/'model.json').write_text(json.dumps(metadata,indent=2),encoding='utf-8')
    print(f'CPU: grau quadratico certificado; 42 equacoes; {len(checks)} controles PASS; {time.perf_counter()-t:.2f}s.',flush=True)
    print('ESCOPO: dominio condicionado as cinco leis iniciais. Nenhum teorema global sera anunciado.',flush=True)
    if args.validate_only:return
    if not shutil.which('nvcc'):
        raise SystemExit('nvcc ausente. Ative um ambiente CUDA; validacao CPU e fonte foram salvas.')
    subprocess.run(['nvidia-smi'],check=True)
    binary=folder/'solver'
    subprocess.run(['nvcc','-O3','-std=c++14',str(cu),'-o',str(binary)],check=True)
    name=f'run_{args.start}_{count}_{time.time_ns()}.log'
    with (folder/name).open('w',encoding='utf-8') as log:
        began=time.perf_counter()
        with subprocess.Popen([str(binary.resolve()),str(args.start),str(count)],stdout=subprocess.PIPE,stderr=subprocess.STDOUT,text=True,bufsize=1) as proc:
            try:
                for line in proc.stdout:
                    print(line,end='',flush=True);log.write(line);log.flush()
                rc=proc.wait()
            except BaseException:
                proc.terminate()
                try:
                    proc.wait(timeout=10)
                except subprocess.TimeoutExpired:
                    proc.kill();proc.wait()
                raise
    metadata.update(gpu_executed=True,process_exit_code=rc,start=args.start,count=count,log=name)
    (folder/'model.json').write_text(json.dumps(metadata,indent=2),encoding='utf-8')
    if rc:raise SystemExit(f'Execucao FALHOU (codigo {rc}); nenhum resultado de completude e valido.')
    print(f'Tempo total: {time.perf_counter()-began:.2f}s. Log: {folder/name}',flush=True)
    print('Envie model.json e o log. Um piloto cobre somente o intervalo informado.',flush=True)


if __name__=='__main__':
    main()
