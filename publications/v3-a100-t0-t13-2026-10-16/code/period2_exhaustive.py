"""Exact complete period-two restriction sieve; integer lookup tables on A100.
No claim of bentness for survivors. Runtime tables are rebuilt from polynomial ANF.
"""
import hashlib, json, time
from pathlib import Path
import numpy as np
import experiment_science as ex

def plane_table(n):
    h=n//2;N=1<<h;J=N-1;A=sum(1<<i for i in range(0,h,2))
    path=ex.ROOT/f'T11_n{n}_plane_table.npz'
    if path.exists():return np.load(path)['allowed']
    beta=np.arange(N,dtype=np.uint64)
    parity=np.array([(int(b&A).bit_count()%2)+2*(int(b&J).bit_count()%2) for b in beta])
    table=np.zeros((4,N,2*N+1),dtype=np.uint8)
    for g in range(4):
        bb=beta[parity==g];assert len(bb)==N//4
        for b in range(N):
            x=(bb^np.uint64(b))|(bb<<np.uint64(h));canonical=x.copy()
            for _ in range(1,n):
                x=((x<<np.uint64(1))&np.uint64((1<<n)-1))|(x>>np.uint64(n-1))
                canonical=np.minimum(canonical,x)
            _,weights=np.unique(canonical,return_counts=True)
            reachable=1
            for w in weights:reachable |= reachable<<int(w)
            vals=[4*(N//4-2*s) for s in range(N//4+1) if (reachable>>s)&1]
            table[g,b,np.array(vals)+N]=1
    np.savez_compressed(path,allowed=table)
    return table

def gamma_signs(g):
    # Fibers ordered [0,A,A^J,J]; gamma bits mean <beta,A>,<beta,J>.
    return np.array([1,(-1)**(g&1),(-1)**((g&1)^((g>>1)&1)),(-1)**((g>>1)&1)])

def validate_plane():
    records=[]
    for n in (12,16,20):
        N=1<<(n//2);A=sum(1<<i for i in range(0,n//2,2));zs=[0,A,A^(N-1),N-1]
        u=np.arange(N); f=np.array([int(x).bit_count()%2 for x in u])
        # P_n(u,u+z)=<u,J+z>.
        w=np.zeros((4,N),dtype=np.int64)
        for i,z in enumerate(zs):w[i,(N-1)^z]=N
        tab=plane_table(n)
        for g in range(4):
            L=gamma_signs(g)@w
            assert np.all(tab[g,np.arange(N),L+N])
        records.append({'n':n,'P_n':'PASS'})
    n=12;N=64;A=21;J=63;zs=[0,A,A^J,J]
    gs=ex.generators(n);allff=ex.fibers(n,list(range(N)),gs)
    rng=np.random.default_rng(7331);c=rng.integers(0,2,(8,43),dtype=np.uint8)
    tt=(c.astype(np.int64)@allff.reshape(43,-1))&1
    w=ex.fwht_cpu((1-2*tt).reshape(-1,N,N))[:,zs,:]
    x=np.arange(4096);perm=((x&63)^(x>>6))*64+(x&63)
    full=ex.fwht_cpu((1-2*tt)[:,perm]);beta=np.arange(N)
    for g in range(4):
        bb=beta[np.array([(int(v&A).bit_count()%2)+2*(int(v&J).bit_count()%2) for v in beta])==g]
        for b in range(N):
            L=np.einsum('z,rz->r',gamma_signs(g),w[:,:,b])
            assert np.array_equal(L*N,4*full[:,(b^bb)|(bb<<6)].sum(axis=1))
    ex.save('T11_plane_validation.json',{'status':'PASS','positive_controls':records,'independent_full_Walsh_checks':8*4*64,'formula':'N sum_z character(g,z) W_gz(b) = 4 sum_beta_in_coset W_f(b+beta,beta)','scope':'Orbit signed-sum tables are necessary relaxations; dual signs need not be coherent across b.'})

def affine_sector(B,P,n):
    r=len(B)
    if n!=20:return B,np.eye(r,dtype=np.uint8),np.zeros(r,dtype=np.uint8)
    C=np.array([P[:r,244],P[:r,186]^P[:r,242]],dtype=np.uint8)
    m=C.copy();rhs=np.array([0,1],dtype=np.uint8);piv=[]
    for j in range(r):
        k=len(piv);ii=np.flatnonzero(m[k:,j])
        if not len(ii):continue
        t=k+int(ii[0]);m[[k,t]]=m[[t,k]];rhs[[k,t]]=rhs[[t,k]]
        ix=np.flatnonzero(m[:,j]);ix=ix[ix!=k];m[ix]^=m[k];rhs[ix]^=rhs[k]
        piv.append(j)
        if len(piv)==2:break
    assert len(piv)==2
    free=[j for j in range(r) if j not in piv];Q=np.zeros((len(free),r),dtype=np.uint8);offset=np.zeros(r,dtype=np.uint8)
    offset[piv]=rhs
    for i,j in enumerate(free):Q[i,j]=1;Q[i,piv]=m[:,j]
    assert not np.any((C@Q.T)&1) and np.array_equal((C@offset)&1,np.array([0,1]))
    assert ex.rref(Q)[0].shape[0]==r-2
    return (Q@B)&1,Q,offset

CUDA=r'''
extern "C" __global__ void sieve(const unsigned long long* ids,
 const unsigned long long* masks,const int* ranks,const unsigned int* offsets,
 const short* t0,const short* ta,const short* tb,const short* tj,
 const unsigned char* plane,const unsigned char* line,const int* order,
 int N,int count,int* result) {
 int k=blockDim.x*blockIdx.x+threadIdx.x;if(k>=count)return;
 unsigned long long id=ids[k];unsigned int local[4];
 for(int z=0;z<4;z++) {unsigned int v=offsets[z];
  for(int j=0;j<ranks[z];j++)v^=(__popcll(id&masks[z*32+j])&1U)<<j;
  local[z]=v;}
 const short* tabs[4]={t0,ta,tb,tj};
 for(int q=0;q<N;q++) {int b=order[q];int w[4];long long energy=0;
  for(int z=0;z<4;z++){w[z]=tabs[z][((long long)b<<ranks[z])+local[z]];energy+=(long long)w[z]*w[z];}
  if(energy>(long long)N*N){result[k]=q+1;return;}
  for(int g=0;g<2;g++) {int L=w[0]+(g?-w[3]:w[3]);
   if(L < -N || L > N || !line[((long long)g*N+b)*(2*N+1)+L+N]){result[k]=q+1;return;}}
  for(int g=0;g<4;g++) {int sa=(g&1)?-1:1,sj=(g&2)?-1:1;
   int L=w[0]+sa*w[1]+sa*sj*w[2]+sj*w[3];
   if(L < -N || L > N || !plane[((long long)g*N+b)*(2*N+1)+L+N]){result[k]=q+1;return;}}
 }
 result[k]=0;
}
'''

class Sieve:
    def __init__(self,gpu,n):
        self.gpu=gpu;self.cp=cp=gpu.cp;self.n=n;self.N=N=1<<(n//2)
        data=np.load(ex.ROOT/f'T6_n{n}_joint_period2_basis.npz')
        A=sum(1<<i for i in range(0,n//2,2));zs=[0,A,A^(N-1),N-1]
        old=data['fibers'].tolist();r=len(data['pivots']);self.P=data['coefficient_transform'][:r]
        B=data['basis'].reshape(r,4,N)[:,[old.index(z) for z in zs],:].reshape(r,-1)
        self.B=B;self.D,self.Q,self.offset=affine_sector(B,self.P,n)
        self.free_rank=len(self.Q);self.full_rank=r
        self.offset_truth=(self.offset@B)&1
        self.tables=[];masks=np.zeros((4,32),dtype=np.uint64);ranks=[];offsets=[];localbases=[]
        start=time.perf_counter()
        for z in range(4):
            local=B.reshape(r,4,N)[:,z,:];basis,_,piv=ex.rref(local);s=len(piv);ranks.append(s);localbases.append(basis)
            maplocal=(self.Q@local[:,piv])&1;off=(self.offset@local[:,piv])&1
            for j in range(s):masks[z,j]=sum(int(v)<<i for i,v in enumerate(maplocal[:,j]))
            offsets.append(sum(int(v)<<j for j,v in enumerate(off)))
            pts=cp.asarray(ex.pack_rows(basis.T));tab=cp.empty((N,1<<s),dtype=cp.int16)
            for lo in range(0,1<<s,8192):
                ids=cp.arange(lo,min(lo+8192,1<<s),dtype=cp.uint64)[:,None]
                w=gpu.transform(gpu.signs(ids,pts));tab[:,lo:lo+len(ids)]=w.T.astype(cp.int16)
            self.tables.append(tab)
            print('TABLE',n,z,'rank',s,'bytes',tab.nbytes,flush=True)
        self.masks=cp.asarray(masks);self.ranks=cp.asarray(ranks,dtype=cp.int32);self.offsets=cp.asarray(offsets,dtype=cp.uint32)
        self.plane=cp.asarray(plane_table(n));self.line=cp.asarray(ex.poisson_line_J(n),dtype=cp.uint8)
        order=list(dict.fromkeys([0,N-1,A,A^(N-1)]+list(range(N))))
        self.order=cp.asarray(order,dtype=cp.int32);self.kernel=cp.RawKernel(CUDA,'sieve')
        self.localbases=localbases;self.host_masks=masks;self.host_offsets=offsets
        gpu.sync();self.build_seconds=time.perf_counter()-start
        np.savez_compressed(ex.ROOT/f'T11_n{n}_parameterization.npz',B=B,Q=self.Q,offset=self.offset,P=self.P,masks=masks,ranks=ranks,local_offsets=offsets,frequency_order=order)

    def evaluate(self,ids):
        cp=self.cp;ids=cp.asarray(ids,dtype=cp.uint64);out=cp.empty(len(ids),dtype=cp.int32)
        self.kernel(((len(ids)+127)//128,),(128,),(ids,self.masks,self.ranks,self.offsets,*self.tables,self.plane,self.line,self.order,np.int32(self.N),np.int32(len(ids)),out))
        return out

    def cpu_check(self,ids):
        ids=np.array(ids,dtype=np.uint64);bits=((ids[:,None]>>np.arange(self.free_rank,dtype=np.uint64))&1).astype(np.uint8)
        coord=((bits@self.Q)&1)^self.offset
        # Independent evaluation from original ANF coefficients and all four fibers.
        c=(coord@self.P)&1;N=self.N;A=sum(1<<i for i in range(0,self.n//2,2));zs=[0,A,A^(N-1),N-1]
        ff=ex.fibers(self.n,zs);truth=(c.astype(np.int64)@ff.reshape(len(ff),-1))&1
        w=ex.fwht_cpu((1-2*truth).reshape(-1,4,N))
        for z,basis in enumerate(self.localbases):
            v=np.full(len(ids),self.host_offsets[z],dtype=np.uint32)
            for j in range(len(basis)):
                v ^= np.array([int(x&self.host_masks[z,j]).bit_count()%2 for x in ids],dtype=np.uint32)<<j
            got=self.cp.asnumpy(self.tables[z][:,self.cp.asarray(v)]).T
            assert np.array_equal(w[:,z],got)
        good=np.all(np.sum(w*w,axis=1)<=N*N,axis=1)
        plane=plane_table(self.n);line=ex.poisson_line_J(self.n)
        for g in range(4):
            L=np.einsum('z,rzb->rb',gamma_signs(g),w)
            good &= np.all((L>=-N)&(L<=N)&plane[g,np.arange(N)[None,:],np.clip(L+N,0,2*N)],axis=1)
        for g in range(2):
            L=w[:,0]+(-1)**g*w[:,3]
            good &= np.all((L>=-N)&(L<=N)&line[g,np.arange(N)[None,:],np.clip(L+N,0,2*N)],axis=1)
        got=self.cp.asnumpy(self.evaluate(ids))==0
        assert np.array_equal(got,good)
        return int(good.sum())

    def run(self,limit=None,batch=1<<20):
        cp=self.cp;total=1<<self.free_rank;end=total if limit is None else min(total,limit)
        sig=hashlib.sha256(Path(__file__).read_bytes()+(ex.ROOT/f'T11_n{self.n}_parameterization.npz').read_bytes()).hexdigest()
        ck=ex.ROOT/f'T11_n{self.n}_checkpoint.npz';done=0;counts=np.zeros(self.N+1,dtype=np.int64);examples=np.empty(0,dtype=np.uint64)
        if ck.exists():
            a=np.load(ck);assert str(a['signature'])==sig
            done=int(a['done']);counts=a['counts'];examples=a['examples']
        start=time.perf_counter();initial=done
        while done<end:
            ids=cp.arange(done,min(done+batch,end),dtype=cp.uint64);result=self.evaluate(ids)
            counts += cp.asnumpy(cp.bincount(result,minlength=self.N+1))
            if len(examples)<256:examples=np.concatenate([examples,cp.asnumpy(ids[result==0])[:256-len(examples)]])
            done+=len(ids)
            if (done-initial)%(batch*16)==0 or done==end:
                tmp=ck.with_suffix('.tmp.npz');np.savez_compressed(tmp,done=done,counts=counts,examples=examples,signature=sig);tmp.replace(ck)
                elapsed=time.perf_counter()-start
                ex.save(f'T11_n{self.n}_progress.json',{'done':done,'total':total,'survivors':int(counts[0]),'session_seconds':elapsed,'estimated_remaining_seconds':(total-done)*elapsed/max(1,done-initial)})
        assert counts.sum()==done
        status='EXACT_COMPLETE_IMAGE' if done==total else 'EXACT_PREFIX_PILOT'
        report={'status':status,'n':self.n,'full_image_rank':self.full_rank,'sector_restricted_rank':self.free_rank,'enumerated':done,'target':total,'survivors':int(counts[0]),'table_build_seconds':self.build_seconds,'session_seconds':time.perf_counter()-start,'filters':['prior necessary sector law for n20','four-fiber partial energy','line-J Poisson','plane Poisson with cyclic dual-sign grouping'],'scope':'Necessary conditions only. Survivors are not asserted bent. A prefix pilot is not an exhaustive classification.'}
        if done==total:
            report['surviving_fraction_original']=f'{int(counts[0])}/{1<<self.full_rank}'
            report['original_coefficient_coset_size']=1<<(len(ex.generators(self.n))-self.full_rank)
        ex.save(f'T11_n{self.n}_result.json',report);return report

if __name__=='__main__':
    gpu=ex.GPU();validate_plane()
    s=Sieve(gpu,12);assert s.cpu_check(np.arange(4096))>=0;print(s.run(),flush=True)
    del s;gpu.cp.get_default_memory_pool().free_all_blocks()
    s=Sieve(gpu,20);rng=np.random.default_rng(2026101602)
    s.cpu_check(rng.integers(0,1<<30,256,dtype=np.uint64))
    ex.save('T11_gpu_lookup_validation.json',{'status':'PASS','n12_all_image_points':4096,'n20_random_points':256,'oracle':'Original ANF CPU evaluation, all four fibers, all Walsh frequencies, independent vectorized filters'})
    print(s.run(limit=1<<24),flush=True)
    print('PILOT_COMPLETE; CALL s.run() TO FINISH',flush=True)
