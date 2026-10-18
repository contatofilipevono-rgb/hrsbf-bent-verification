"""T16: exact n=16 extension V2 -> span(V2,51), rank 21 -> 33.

Standalone NumPy/CuPy implementation. No old notebook variables or files.
All survivors satisfy only necessary conditions; this is not a bentness test.
"""
from pathlib import Path
from itertools import combinations
from collections import Counter
import hashlib,json,time,zipfile
import numpy as np

ZS=[0,85,170,255,51]
V3=[0,85,170,255,51,102,204,153]

def rot(x,n,k=1):
    k%=n
    return ((int(x)<<k)|(int(x)>>(n-k)))&((1<<n)-1)

def generators():
    seen=set();out=[]
    for t in combinations(range(16),4):
        m=sum(1<<i for i in t)
        if m in seen:continue
        orb=sorted({rot(m,16,k) for k in range(16)})
        seen.update(orb);out.append(orb)
    assert len(out)==116
    return out

def rref(a):
    a=a.copy();p=np.eye(len(a),dtype=np.uint8);pv=[]
    for j in range(a.shape[1]):
        k=len(pv);ix=np.flatnonzero(a[k:,j])
        if not len(ix):continue
        t=k+int(ix[0]);a[[k,t]]=a[[t,k]];p[[k,t]]=p[[t,k]]
        ix=np.flatnonzero(a[:,j]);ix=ix[ix!=k];a[ix]^=a[k];p[ix]^=p[k]
        pv.append(j)
        if len(pv)==len(a):break
    return a[:len(pv)],p[:len(pv)],pv

def fwht(a):
    a=np.array(a,dtype=np.int32,copy=True);shape=a.shape;N=shape[-1]
    for s in (1<<j for j in range((N-1).bit_length())):
        v=a.reshape(-1,N//(2*s),2,s);x=v[:,:,0,:].copy();y=v[:,:,1,:].copy()
        v[:,:,0,:]=x+y;v[:,:,1,:]=x-y
    return a.reshape(shape)

def poisson(V):
    perp=[b for b in range(256) if all((b&z).bit_count()%2==0 for z in V)]
    seen=set();reps=[]
    for b in range(256):
        if b not in seen:reps.append(b);seen.update(b^v for v in perp)
    assert len(reps)==len(V)
    canonical=np.arange(65536,dtype=np.uint32);x=canonical.copy()
    for _ in range(1,16):
        x=((x<<1)&65535)|(x>>15);canonical=np.minimum(canonical,x)
    signs=np.array([[(-1)**((g&z).bit_count()%2) for z in V] for g in reps],dtype=np.int32)
    table=np.zeros((256,len(V),513),dtype=np.uint8)
    for b in range(256):
        for gi,g in enumerate(reps):
            weights=Counter(int(canonical[(b^g^v)|((g^v)<<8)]) for v in perp)
            vals={0}
            for w in weights.values():vals={v+w for v in vals}|{v-w for v in vals}
            vals=len(V)*np.array(sorted(vals),dtype=np.int32)
            assert np.all(np.abs(vals)<=256)
            table[b,gi,vals+256]=1
    return signs,table

def setup():
    u=np.arange(256,dtype=np.uint32);gs=generators()
    ff=np.zeros((116,5,256),dtype=np.uint8)
    for zi,z in enumerate(ZS):
        x=u|((u^z)<<8)
        for i,orb in enumerate(gs):
            for m in orb:ff[i,zi]^=((x&m)==m)
    B,P,pv=rref(ff.reshape(116,-1))
    assert len(B)==33 and sum(j<1024 for j in pv)==21
    assert np.array_equal((P@ff.reshape(116,-1))&1,B)
    B=B.reshape(33,5,256)
    masks=np.zeros((5,32),dtype=np.uint64);ranks=[];bases=[]
    for zi in range(5):
        lb,_,lp=rref(B[:,zi,:]);ranks.append(len(lb));bases.append(lb)
        for j,col in enumerate(lp):masks[zi,j]=sum(int(v)<<i for i,v in enumerate(B[:,zi,col]))
    assert ranks==[4,14,14,8,22]
    perm=np.empty((4,256),dtype=np.int32);phase=perm.copy()
    tau=0;zz=51
    for k in range(4):
        for b in range(256):perm[k,b]=rot(b,8,8-k);phase[k,b]=(-1)**((b&tau).bit_count()%2)
        tau=rot(tau,8)^((zz>>7)&1);zz=rot(zz,8)
    order=np.array(list(dict.fromkeys([0,255,85,170]+list(range(256)))),dtype=np.int32)
    s1,t1=poisson([0,255]);s2,t2=poisson(ZS[:4]);s3,t3=poisson(V3)
    return dict(B=B,P=P,ff=ff,masks=masks,ranks=np.array(ranks,dtype=np.int32),
                bases=bases,perm=perm,phase=phase,order=order,s1=s1,t1=t1,s2=s2,t2=t2,s3=s3,t3=t3)

CUDA=r'''
__device__ unsigned int loc(unsigned long long id,const unsigned long long* masks,int z,int rank){
 unsigned int out=0;for(int j=0;j<rank;j++)out|=(__popcll(id&masks[z*32+j])&1U)<<j;return out;}
__device__ bool allow(const unsigned char* tab,const int* signs,int n,int b,const int* w){
 for(int g=0;g<n;g++){int L=0;for(int z=0;z<n;z++)L+=signs[g*n+z]*w[z];
 if(L< -256||L>256||!tab[(b*n+g)*513+L+256])return false;}return true;}
extern "C" __global__ void base(const unsigned long long* ids,int count,
 const unsigned long long* masks,const int* ranks,const short* t0,const short* t1,
 const short* t2,const short* t3,const unsigned char* line,const int* sl,
 const unsigned char* plane,const int* sp,const int* order,int* out){
 int i=blockDim.x*blockIdx.x+threadIdx.x;if(i>=count)return;
 unsigned int l[4];for(int z=0;z<4;z++)l[z]=loc(ids[i],masks,z,ranks[z]);
 const short* tab[4]={t0,t1,t2,t3};
 for(int q=0;q<256;q++){int b=order[q],w[4],E=0;
  for(int z=0;z<4;z++){w[z]=tab[z][((long long)b<<ranks[z])+l[z]];E+=w[z]*w[z];}
  int pair[2]={w[0],w[3]};
  if(E>65536||!allow(line,sl,2,b,pair)||!allow(plane,sp,4,b,w)){out[i]=q+1;return;}}
 out[i]=0;
}
extern "C" __global__ void extend(const unsigned long long* ids,int count,
 const unsigned long long* masks,const int* ranks,const short* t0,const short* t1,
 const short* t2,const short* t3,const short* t4,const int* perm,const int* phase,
 const unsigned char* cube,const int* sc,const int* order,int* out){
 int i=blockDim.x*blockIdx.x+threadIdx.x;if(i>=count)return;
 unsigned int l[5];for(int z=0;z<5;z++)l[z]=loc(ids[i],masks,z,ranks[z]);
 const short* tab[4]={t0,t1,t2,t3};
 for(int q=0;q<256;q++){int b=order[q],w[8],E=0;
  for(int z=0;z<4;z++)w[z]=tab[z][((long long)b<<ranks[z])+l[z]];
  for(int k=0;k<4;k++)w[4+k]=phase[k*256+b]*t4[((long long)perm[k*256+b]<<ranks[4])+l[4]];
  for(int z=0;z<8;z++)E+=w[z]*w[z];
  if(E>65536||!allow(cube,sc,8,b,w)){out[i]=q+1;return;}}
 out[i]=0;
}
extern "C" __global__ void truth(const unsigned long long* masks,int rank,int start,int count,int* out){
 int i=blockDim.x*blockIdx.x+threadIdx.x;if(i>=count*256)return;
 unsigned int id=start+i/256;out[i]=1-2*(__popcll((unsigned long long)id&masks[i%256])&1U);
}
extern "C" __global__ void hadamard(int* a,int count){
 __shared__ int w[256];int row=blockIdx.x,j=threadIdx.x;if(row>=count)return;
 w[j]=a[row*256+j];__syncthreads();
 for(int s=1;s<256;s*=2){int v=w[j],other=w[j^s];__syncthreads();w[j]=(j&s)?other-v:v+other;__syncthreads();}
 a[row*256+j]=w[j];
}
'''

def cpu_oracle(d,ids,extended):
    ids=np.array(ids,dtype=np.uint64);bits=((ids[:,None]>>np.arange(33,dtype=np.uint64))&1).astype(np.uint8)
    # Evaluate original 116-generator ANF, not the GPU's local truth tables.
    c=(bits@d['P'])&1;t=(c@d['ff'].reshape(116,-1))&1
    w=fwht(1-2*t.astype(np.int32).reshape(-1,5,256))
    if extended:
        ws=np.concatenate([w[:,:4],np.stack([w[:,4,d['perm'][k]]*d['phase'][k] for k in range(4)],axis=1)],axis=1)
        filters=[(d['s3'],d['t3'],ws)]
    else:
        ws=w[:,:4];filters=[(d['s1'],d['t1'],ws[:,[0,3]]),(d['s2'],d['t2'],ws)]
    good=np.all(np.sum(ws.astype(np.int64)**2,axis=1)<=65536,axis=1)
    for signs,table,v in filters:
        L=np.einsum('gz,rzb->rgb',signs,v)
        ok=(np.abs(L)<=256)&(table[np.arange(256)[None,None,:],np.arange(len(signs))[None,:,None],np.clip(L+256,0,512)]!=0)
        good&=np.all(ok,axis=(1,2))
    return good

class Runner:
    def __init__(self,d):
        import cupy as cp
        self.cp=cp;self.d=d
        self.kbase=cp.RawKernel(CUDA,'base');self.kext=cp.RawKernel(CUDA,'extend')
        kt=cp.RawKernel(CUDA,'truth');kh=cp.RawKernel(CUDA,'hadamard')
        self.dev={k:cp.asarray(d[k]) for k in ['masks','ranks','order','perm','phase','t1','s1','t2','s2','t3','s3']}
        self.tables=[]
        for zi,basis in enumerate(d['bases']):
            s=len(basis);points=np.array([sum(int(v)<<j for j,v in enumerate(basis[:,u])) for u in range(256)],dtype=np.uint64)
            points=cp.asarray(points);tab=cp.empty((256,1<<s),dtype=cp.int16)
            for lo in range(0,1<<s,8192):
                n=min(8192,(1<<s)-lo);w=cp.empty((n,256),dtype=cp.int32)
                kt(((n*256+255)//256,),(256,),(points,np.int32(s),np.int32(lo),np.int32(n),w))
                kh((n,),(256,),(w,np.int32(n)));tab[:,lo:lo+n]=w.T.astype(cp.int16)
            sample=np.random.default_rng(1616+zi).integers(0,1<<s,32,dtype=np.uint64)
            bits=((sample[:,None]>>np.arange(s,dtype=np.uint64))&1).astype(np.uint8)
            ref=fwht(1-2*((bits@basis)&1).astype(np.int32))
            assert np.array_equal(cp.asnumpy(tab[:,cp.asarray(sample)].T),ref),'Falha na FWHT GPU'
            self.tables.append(tab);print('TABELA',ZS[zi],'posto',s,'MiB',tab.nbytes//2**20,'FWHT CPU/GPU PASS',flush=True)
        cp.cuda.get_current_stream().synchronize()

    def evaluate(self,ids,extended):
        cp=self.cp;a=self.dev;ids=cp.asarray(ids,dtype=cp.uint64);out=cp.empty(len(ids),dtype=cp.int32)
        common=(ids,np.int32(len(ids)),a['masks'],a['ranks'],*self.tables[:4])
        if extended:args=common+(self.tables[4],a['perm'],a['phase'],a['t3'],a['s3'],a['order'],out);ker=self.kext
        else:args=common+(a['t1'],a['s1'],a['t2'],a['s2'],a['order'],out);ker=self.kbase
        if len(ids):ker(((len(ids)+127)//128,),(128,),args)
        return out

def run():
    import cupy as cp
    root=Path.cwd()/'T16_results';root.mkdir(exist_ok=True)
    device=cp.cuda.runtime.getDeviceProperties(0)['name'];device=device.decode() if isinstance(device,bytes) else device
    print('GPU:',device,flush=True)
    assert 'A100' in device,'Selecione a A100 antes de continuar.'
    print('Reconstruindo geradores, postos e tabelas...',flush=True)
    d=setup();r=Runner(d);rng=np.random.default_rng(2026101616)
    for extended,bits in [(False,21),(True,33)]:
        ids=rng.integers(0,1<<bits,256,dtype=np.uint64)
        assert np.array_equal(cp.asnumpy(r.evaluate(ids,extended))==0,cpu_oracle(d,ids,extended))
    # Validate affine transport against direct ANF at all four new fibers.
    ff=d['ff'];u=np.arange(256,dtype=np.uint32);gs=generators()
    for k,z in enumerate(V3[4:]):
        direct=np.zeros((116,256),dtype=np.uint8);x=u|((u^z)<<8)
        for i,orb in enumerate(gs):
            for m in orb:direct[i]^=((x&m)==m)
        ids=rng.integers(0,1<<33,8,dtype=np.uint64);bits=((ids[:,None]>>np.arange(33,dtype=np.uint64))&1).astype(np.uint8);c=(bits@d['P'])&1
        w=fwht(1-2*((c@ff[:,4,:])&1).astype(np.int32))
        assert np.array_equal(fwht(1-2*((c@direct)&1).astype(np.int32)),w[:,d['perm'][k]]*d['phase'][k])
    print('VALIDACAO CPU/GPU E TRANSPORTE: PASS',flush=True)
    ids=cp.arange(1<<21,dtype=cp.uint64);parents=ids[r.evaluate(ids,False)==0];del ids
    assert len(parents)==391804,f'Prefixo inesperado: {len(parents)}'
    print('PREFIXO EXATO: 391804 / 2097152. Nova extensao: 4096 por pai.',flush=True)
    np.savez_compressed(root/'parameterization.npz',B=d['B'],P=d['P'],masks=d['masks'],ranks=d['ranks'],parents=cp.asnumpy(parents))
    total=len(parents)*4096;signature=hashlib.sha256(Path(__file__).read_bytes()+d['B'].tobytes()).hexdigest()
    ck=root/'checkpoint.npz';done=0;hist=np.zeros(257,dtype=np.int64);examples=np.empty(0,dtype=np.uint64)
    if ck.exists():
        a=np.load(ck);assert str(a['signature'])==signature,'Checkpoint de outra versao.'
        done=int(a['done']);hist=a['hist'];examples=a['examples']
    start=time.perf_counter();initial=done;batch=1<<20
    while done<total:
        end=min(total,done+batch);ordinal=cp.arange(done,end,dtype=cp.uint64)
        words=parents[ordinal>>cp.uint64(12)]|((ordinal&cp.uint64(4095))<<cp.uint64(21))
        result=r.evaluate(words,True);hist+=cp.asnumpy(cp.bincount(result,minlength=257))
        if len(examples)<256:examples=np.concatenate([examples,cp.asnumpy(words[result==0])[:256-len(examples)]])
        done=end
        if done==total or done-initial==batch or (done-initial)%(16*batch)==0:
            cp.cuda.get_current_stream().synchronize();elapsed=time.perf_counter()-start
            assert int(hist.sum())==done
            tmp=root/'checkpoint.tmp.npz';np.savez_compressed(tmp,signature=signature,done=done,hist=hist,examples=examples);tmp.replace(ck)
            report={'status':'EXACT_COMPLETE_FILTERED_IMAGE' if done==total else 'EXACT_PREFIX_PILOT',
                    'n':16,'subspace':V3,'rank':33,'base_rank':21,'parents':391804,'extensions_each':4096,
                    'processed':done,'target':total,'survivors':int(hist[0]),'session_seconds':elapsed,
                    'estimated_remaining_seconds':(total-done)*elapsed/max(1,done-initial),
                    'cpu_gpu_validation':'PASS','scope':'Necessary energy and Poisson filters only; survivors are not certified bent.'}
            if done==total:
                report.update(excluded_fraction_numerator=(1<<33)-int(hist[0]),excluded_fraction_denominator=1<<33,
                              excluded_percent=100*(1-int(hist[0])/(1<<33)),preimages_each=1<<83)
            (root/'progress.json').write_text(json.dumps(report,indent=2)+'\n')
            print(json.dumps(report),flush=True)
    assert np.all(cpu_oracle(d,examples[:128],True))
    archive=Path.cwd()/'GRAU4_T16_RESULTADOS.zip'
    entries=list(root.glob('*'));entries=[p for p in entries if p.is_file()]
    entries.append(Path(__file__))
    with zipfile.ZipFile(archive,'w',zipfile.ZIP_DEFLATED) as z:
        manifest=[]
        for p in entries:
            name=('code/' if p.name==Path(__file__).name else 'results/')+p.name
            z.write(p,name);manifest.append(hashlib.sha256(p.read_bytes()).hexdigest()+'  '+name)
        z.writestr('SHA256SUMS.txt','\n'.join(manifest)+'\n')
    with zipfile.ZipFile(archive) as z:assert z.testzip() is None
    print('\nT16 CONCLUIDO. Copie o ultimo JSON e baixe:',archive,flush=True)
    return str(archive)

if __name__=='__main__':
    output=run()
    try:
        from google.colab import files
        files.download(output)
    except ImportError:pass
