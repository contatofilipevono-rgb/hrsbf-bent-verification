"""Exact quartic RS experiments. CPU is an oracle; scientific batches use CUDA.
No theorem is inferred from a sample. Original release is kept immutable.
"""
from pathlib import Path
from itertools import combinations
from collections import Counter
import ast
import contextlib
import hashlib
import json
import math
import os
import platform
import shutil
import sys
import time
import zipfile
import numpy as np

RELEASE_SHA = '033d41bb5c2bc6350879ae85fcd3d71a3d63e78c03fe0f4d7710a934841c37ce'
ROOT = Path.cwd() / 'grau4_a100_results'
ROOT.mkdir(exist_ok=True)

def save(name, obj):
    p = ROOT / name
    p.parent.mkdir(exist_ok=True, parents=True)
    tmp = p.with_suffix(p.suffix + '.tmp')
    tmp.write_text(json.dumps(obj, indent=2, ensure_ascii=False) + '\n')
    tmp.replace(p)
    print(name, 'saved', flush=True)

def rot(x, n, k=1):
    k %= n
    return ((int(x) << k) | (int(x) >> (n-k))) & ((1 << n)-1)

def generators(n, degree=4):
    seen = set(); out = []
    for t in combinations(range(n), degree):
        mask = sum(1 << i for i in t)
        if mask in seen:
            continue
        orbit = sorted({rot(mask, n, k) for k in range(n)})
        seen.update(orbit)
        support = min(tuple(i for i in range(n) if m >> i & 1) for m in orbit)
        out.append((support, orbit))
    return sorted(out)

def fibers(n, zs, gs=None):
    gs = generators(n) if gs is None else gs
    h = n//2; u = np.arange(1 << h, dtype=np.uint64)
    out = np.zeros((len(gs), len(zs), len(u)), dtype=np.uint8)
    for j, z in enumerate(zs):
        x = u | ((u ^ np.uint64(z)) << np.uint64(h))
        for i, (_, orbit) in enumerate(gs):
            for m in orbit:
                out[i,j] ^= ((x & np.uint64(m)) == np.uint64(m))
    return out

def fwht_cpu(x):
    a = np.array(x, dtype=np.int64, copy=True)
    n = a.shape[-1]; shape = a.shape
    assert n and n & (n-1) == 0
    step = 1
    while step < n:
        a = a.reshape(-1, n//(2*step), 2, step)
        u = a[:,:,0,:].copy(); v = a[:,:,1,:].copy()
        a[:,:,0,:] = u+v; a[:,:,1,:] = u-v
        a = a.reshape(shape); step *= 2
    return a

def pack_rows(bits):
    """Each row -> little-bit-order uint64 words; not Python hashes."""
    b = np.asarray(bits, dtype=np.uint8)
    if b.ndim != 2:
        raise ValueError('Expected matrix')
    nbytes = ((b.shape[1]+63)//64)*8
    bb = np.packbits(b, axis=1, bitorder='little')
    out = np.zeros((len(b), nbytes), dtype=np.uint8)
    out[:,:bb.shape[1]] = bb
    return out.view('<u8').copy()

def rref(a):
    original = np.asarray(a, dtype=np.uint8)
    m = original.copy(); p = np.eye(len(m), dtype=np.uint8)
    r = 0; pivots = []
    for j in range(m.shape[1]):
        ix = np.flatnonzero(m[r:,j])
        if not len(ix):
            continue
        t = r + int(ix[0]); m[[r,t]] = m[[t,r]]; p[[r,t]] = p[[t,r]]
        ix = np.flatnonzero(m[:,j]); ix = ix[ix != r]
        m[ix] ^= m[r]; p[ix] ^= p[r]
        pivots.append(j); r += 1
        if r == len(m):
            break
    assert np.array_equal(m[:r,pivots], np.eye(r, dtype=np.uint8))
    # uint8 overflow is modulo 256, which preserves the required mod-2 parity.
    assert np.array_equal((p @ original) & 1, m)
    return m[:r], p, pivots

def coefficient_chunks(packed_basis, batch=8192, start=0):
    r = len(packed_basis)
    if r > 30:
        raise ValueError('Image >2^30: structural reduction required before enumeration')
    for lo in range(start, 1 << r, batch):
        ids = np.arange(lo, min(lo+batch, 1 << r), dtype=np.uint64)
        c = np.zeros((len(ids), packed_basis.shape[1]), dtype=np.uint64)
        for j in range(r):
            c ^= ((ids >> np.uint64(j)) & np.uint64(1))[:,None] * packed_basis[j]
        yield lo, c

CUDA_SOURCE = r'''
extern "C" __global__ void signs(
    const unsigned long long* c, const unsigned long long* points,
    int* out, int batch, int count, int words) {
  long long idx = (long long)blockIdx.x*blockDim.x+threadIdx.x;
  long long total = (long long)batch*count;
  if(idx >= total) return;
  int row=idx/count, col=idx%count; unsigned int bit=0;
  for(int w=0;w<words;w++)
    bit ^= (__popcll(c[(long long)row*words+w] & points[(long long)col*words+w]) & 1);
  out[idx] = 1-2*(int)bit;
}
extern "C" __global__ void hadamard(int* a, int n) {
  extern __shared__ int s[];
  long long offset = (long long)blockIdx.x*n;
  for(int j=threadIdx.x;j<n;j+=blockDim.x) s[j]=a[offset+j];
  __syncthreads();
  for(int step=1;step<n;step*=2) {
    for(int p=threadIdx.x;p<n/2;p+=blockDim.x) {
      int j=(p/step)*(2*step)+(p%step); int x=s[j],y=s[j+step];
      s[j]=x+y; s[j+step]=x-y;
    }
    __syncthreads();
  }
  for(int j=threadIdx.x;j<n;j+=blockDim.x) a[offset+j]=s[j];
}
'''

class GPU:
    def __init__(self):
        import cupy as cp
        self.cp = cp
        self.sign_kernel = cp.RawKernel(CUDA_SOURCE, 'signs')
        self.fwht_kernel = cp.RawKernel(CUDA_SOURCE, 'hadamard')
        cp.cuda.Device().use()

    def sync(self):
        self.cp.cuda.get_current_stream().synchronize()

    def transform(self, x):
        cp = self.cp; a = cp.array(x, dtype=cp.int32, order='C', copy=True)
        n = a.shape[-1]
        assert 1 <= n <= 4096 and n & (n-1) == 0
        rows = a.size//n
        if rows:
            self.fwht_kernel((rows,), (min(256,n),), (a,np.int32(n)), shared_mem=4*n)
        return a

    def signs(self, packed_coefficients, packed_points):
        cp = self.cp
        c = cp.asarray(packed_coefficients, dtype=cp.uint64, order='C')
        t = cp.asarray(packed_points, dtype=cp.uint64, order='C')
        assert c.ndim == t.ndim == 2 and c.shape[1] == t.shape[1]
        b,n,w = len(c),len(t),c.shape[1]
        out = cp.empty((b,n), dtype=cp.int32)
        if b*n:
            self.sign_kernel(((b*n+255)//256,), (256,),
                (c,t,out,np.int32(b),np.int32(n),np.int32(w)))
        return out

def prepare_release(path='Pacote_Final_Grau4_n12.zip'):
    zpath = Path(path)
    assert hashlib.sha256(zpath.read_bytes()).hexdigest() == RELEASE_SHA
    dest = ROOT/'release_original'
    with zipfile.ZipFile(zpath) as z:
        assert z.testzip() is None
        for name in z.namelist():
            q = Path(name)
            assert not q.is_absolute() and '..' not in q.parts
        z.extractall(dest)
    release = dest/'Pacote_Final_Grau4_n12'
    for line in (release/'SHA256SUMS.txt').read_text().splitlines():
        sha,name = line.split('  ',1)
        assert hashlib.sha256((release/name).read_bytes()).hexdigest() == sha
    save('T0_integrity.json', {'status':'PASS','release_sha256':RELEASE_SHA,
         'python':sys.version,'numpy':np.__version__,'platform':platform.platform()})
    return release

def validate_gpu(gpu):
    cp = gpu.cp; rng = np.random.default_rng(20261016)
    records = []
    for n in (64,256,1024,4096):
        # Constants, linear characters, a single sign flip, random signed rows.
        u = np.arange(n); x = rng.choice([-1,1],size=(35,n)).astype(np.int32)
        x[0] = 1; x[1] = -1
        x[2] = np.array([(-1)**(int(j&5).bit_count()%2) for j in u])
        x[3] = 1; x[3,0] = -1
        got = cp.asnumpy(gpu.transform(x)); ref = fwht_cpu(x)
        assert np.array_equal(got,ref)
        assert np.array_equal(cp.asnumpy(gpu.transform(got)), n*x.astype(np.int64))
        assert np.all(np.sum(got.astype(np.int64)**2,axis=1) == n*n)
        records.append({'length':n,'rows':len(x),'exact_equal':True})
    # Four uint64 words: exercise >64 and >128 coefficient positions (n=20).
    c = rng.integers(0,2,(31,245),dtype=np.uint8)
    t = rng.integers(0,2,(245,103),dtype=np.uint8)
    got = cp.asnumpy(gpu.signs(pack_rows(c),pack_rows(t.T)))
    assert np.array_equal(got,1-2*((c.astype(np.int64)@t)&1))
    # Negative control: omit the phase and require a real counterexample.
    gs = generators(12); ff = fibers(12,list(range(64)),gs[:1])[0]
    w = fwht_cpu(1-2*ff.astype(np.int32))
    z,k,b = 27,2,5
    target = int(w[rot(z,6,k),b]); no_phase = int(w[z,rot(b,6,-k)])
    tau = rot(z << 6,12,k)&63
    correct = (-1)**((b&tau).bit_count()%2)*no_phase
    assert target == correct and target != no_phase
    name = cp.cuda.runtime.getDeviceProperties(0)['name']
    name = name.decode() if isinstance(name,bytes) else str(name)
    save('T1_gpu_validation.json', {'status':'PASS','gpu':name,
         'cupy':cp.__version__,'fwht':records,'packed_245_coefficients':'PASS',
         'negative_phase_control':{'z':z,'k':k,'b':b,'direct':target,'wrong':no_phase}})

def benchmark(gpu, batch_sizes=(256,4096,32768)):
    cp = gpu.cp; rng = np.random.default_rng(19); rows = []
    for n in (64,256,1024):
        for batch in batch_sizes:
            x = rng.choice([-1,1],size=(batch,n)).astype(np.int32)
            device = cp.asarray(x); gpu.transform(device); gpu.sync() # JIT warm-up
            cpu_times=[]; gpu_times=[]; transfer_times=[]
            for _ in range(3):
                ts=time.perf_counter(); ref=fwht_cpu(x); cpu_times.append(time.perf_counter()-ts)
                gpu.sync(); ts=time.perf_counter(); got=gpu.transform(device); gpu.sync()
                gpu_times.append(time.perf_counter()-ts)
                ts=time.perf_counter(); out=cp.asnumpy(gpu.transform(cp.asarray(x))); gpu.sync()
                transfer_times.append(time.perf_counter()-ts)
            assert np.array_equal(out,ref)
            row={'n':n,'batch':batch,'cpu_seconds':float(np.median(cpu_times)),
                 'gpu_resident_seconds':float(np.median(gpu_times)),
                 'gpu_including_transfers_seconds':float(np.median(transfer_times))}
            row['speedup_including_transfers']=row['cpu_seconds']/row['gpu_including_transfers_seconds']
            rows.append(row); save('T2_benchmark.json',rows)
    return rows

def capture_baseline(release):
    """Execute the unchanged algorithm with AST-only checkpoint instrumentation."""
    work=ROOT/'baseline_work'; work.mkdir(exist_ok=True)
    original=release/'code/verify_independent_n12_reimpl.py'
    source=original.read_text(); tree=ast.parse(source)
    class Instrument(ast.NodeTransformer):
        count=0
        def visit_For(self,node):
            self.generic_visit(node)
            if isinstance(node.iter,ast.Name) and node.iter.id=='rem_specs':
                node.body.append(ast.Expr(ast.Call(ast.Name('capture_stage',ast.Load()),
                    [ast.Name('z_rep',ast.Load()),ast.Name('c_cur',ast.Load())],[])))
                self.count+=1
            return node
    ins=Instrument();tree=ins.visit(tree);ast.fix_missing_locations(tree);assert ins.count==1
    instrumented=ast.unparse(tree)
    (work/'instrumented_reference.py').write_text(instrumented+'\n')
    def capture_stage(z,c):
        if z in (5,15):
            np.savez_compressed(ROOT/f'coefficients_z{z}.npz',coefficients=c)
            print('CHECKPOINT',z,c.shape,flush=True)
    ns={'__name__':'instrumented_reference','capture_stage':capture_stage}
    exec(compile(tree,str(original),'exec'),ns)
    class Tee:
        def __init__(self,f):self.f=f
        def write(self,s):self.f.write(s);self.f.flush();sys.__stdout__.write(s);sys.__stdout__.flush()
        def flush(self):self.f.flush()
    start=time.perf_counter()
    with (ROOT/'T3_reference_execution.log').open('w') as log:
        with contextlib.redirect_stdout(Tee(log)):ns['main']()
    assert np.load(ROOT/'coefficients_z5.npz')['coefficients'].shape==(23636,43)
    assert np.load(ROOT/'coefficients_z15.npz')['coefficients'].shape==(128,43)
    save('T3_reference_execution.json',{'status':'PASS','seconds':time.perf_counter()-start,
         'original_sha256':hashlib.sha256(source.encode()).hexdigest(),
         'instrumentation':'one checkpoint callback appended to rem_specs loop; no filter modified'})

def expand_n12_coefficients():
    gs=generators(12); allff=fibers(12,list(range(64)),gs)
    before41=[0,63,21,42]
    for z in (9,27,7,1,11,13,31,3,5):
        before41.extend(sorted({rot(z,6,k) for k in range(6)}))
    assert len(before41)==len(set(before41))==52
    _,p,pivs=rref(allff[:,before41,:].reshape(43,-1))
    assert len(pivs)==41
    kernel=p[41:]
    assert len(kernel)==2 and np.all(((kernel@allff[:,before41,:].reshape(43,-1))&1)==0)
    parents=np.load(ROOT/'coefficients_z5.npz')['coefficients']
    out=(parents[:,None,:]^np.array([np.zeros(43,dtype=np.uint8),kernel[0],kernel[1],kernel[0]^kernel[1]])[None,:,:]).reshape(-1,43)
    packed=pack_rows(out)
    assert len(np.unique(packed,axis=0))==94544
    return out,allff

def audit_n12_gpu(gpu,batch=512):
    cp=gpu.cp; coefficients,ff=expand_n12_coefficients()
    packed=pack_rows(coefficients)
    pts=pack_rows(ff.reshape(43,-1).T); device_points=cp.asarray(pts)
    x=np.arange(4096); perm=((x&63)^(x>>6))*64+(x&63)
    natural_points=cp.asarray(pts[perm])
    fail=np.zeros((len(coefficients),64),dtype=bool)
    energy_counts=np.zeros(4,dtype=np.int64)
    full_bent_count=0; examples=[]; ts=time.perf_counter()
    for lo in range(0,len(coefficients),batch):
        hi=min(lo+batch,len(coefficients)); c=packed[lo:hi]
        signs=gpu.signs(c,device_points).reshape(-1,64,64)
        w=gpu.transform(signs); energy=cp.sum(w.astype(cp.int64)**2,axis=1)
        e=cp.asnumpy(energy); fail[lo:hi]=e!=4096
        energy_counts += [np.sum(e[:,0]==4096),np.sum(e[:,63]==4096),
                          np.sum((e[:,0]==4096)&(e[:,63]==4096)),np.sum(np.all(e==4096,axis=1))]
        # Complete 12-bit Walsh test: independent of fiber-energy equivalence.
        full=gpu.transform(gpu.signs(c,natural_points))
        full_bent_count+=int(cp.asnumpy(cp.sum(cp.all(cp.abs(full)==64,axis=1))))
        if lo==0:
            # A CPU int64 oracle compares the WHOLE first batch, not only a checksum.
            tt=(coefficients[lo:hi].astype(np.int64)@ff.reshape(43,-1))&1
            ref=fwht_cpu((1-2*tt).reshape(-1,64,64))
            assert np.array_equal(cp.asnumpy(w),ref)
            fullref=fwht_cpu((1-2*tt)[:,perm])
            assert np.array_equal(cp.asnumpy(full),fullref)
        bad=cp.asnumpy(cp.argmax(cp.abs(full)!=64,axis=1))
        vals=cp.asnumpy(full[cp.arange(hi-lo),cp.asarray(bad)])
        for j in range(min(2,hi-lo)):
            if len(examples)<8:examples.append({'coefficient_mask':int(packed[lo+j,0]),'bad_frequency':int(bad[j]),'W':int(vals[j])})
        if (lo//batch)%20==0:
            save('T4_progress.json',{'completed':hi,'total':len(coefficients),'seconds':time.perf_counter()-ts})
    assert energy_counts.tolist()==[32176,39520,5552,0]
    assert full_bent_count==0 and np.all(np.any(fail,axis=1))
    np.savez_compressed(ROOT/'T4_energy_failure_matrix.npz',failure=fail,coefficient_masks=packed)
    save('T4_full_94544_gpu.json',{'status':'PASS','complete_functions':len(coefficients),
         'energy_counts':energy_counts.tolist(),'full_4096_Walsh_bent_count':full_bent_count,
         'cpu_first_batch_comparison':'exact entire arrays','examples':examples,'seconds':time.perf_counter()-ts})
    return fail

def greedy_certificate(fail=None):
    data=np.load(ROOT/'T4_energy_failure_matrix.npz')
    fail=data['failure'] if fail is None else fail
    uncovered=np.ones(len(fail),dtype=bool); selected=[]; covered=[]
    while np.any(uncovered):
        counts=np.sum(fail[uncovered],axis=0); b=int(np.argmax(counts))
        assert counts[b]>0
        selected.append(b);covered.append(int(counts[b]));uncovered &= ~fail[:,b]
    assert np.all(np.any(fail[:,selected],axis=1))
    witness=np.array([selected[int(np.flatnonzero(row[selected])[0])] for row in fail],dtype=np.uint8)
    np.savez_compressed(ROOT/'T5_suffix_witnesses.npz',coefficient_masks=data['coefficient_masks'],bad_b=witness)
    save('T5_frequency_cover.json',{'status':'PASS','frequencies_greedy':selected,
         'newly_covered_counts':covered,'total':len(fail),'minimum_proved':False,
         'scope':'Covers only 94544 extensions after the certified rank-41 prefix; not a standalone proof for 2^43'})

def inspect_images(n):
    h=n//2; N=1<<h; J=N-1; alt=sum(1<<i for i in range(0,h,2))
    gs=generators(n);zs=sorted({0,J,alt,alt^J})
    ff=fibers(n,zs,gs); records=[]
    for name,chosen in [('g0',[0]),('gJ',[J]),('galt',[alt]),('joint_ends',[0,J]),('joint_period2',zs)]:
        ix=[zs.index(z) for z in chosen]
        b,p,piv=rref(ff[:,ix,:].reshape(len(gs),-1))
        np.savez_compressed(ROOT/f'T6_n{n}_{name}_basis.npz',
            basis=b,coefficient_transform=p,pivots=np.array(piv),fibers=np.array(chosen))
        records.append({'name':name,'fibers':chosen,'rank':len(piv),'image_classes':1<<len(piv),
                        'coefficient_space_dimension':len(gs),'coset_size':1<<(len(gs)-len(piv))})
    save(f'T6_n{n}_ranks.json',{'n':n,'generator_count':len(gs),'restrictions':records,
         'scope':'Exact F2 ranks of restriction maps; no bentness exclusion asserted'})
    return records

def poisson_line_J(n):
    """General necessary Poisson table for span(J); integer signed subset sums.
    L = 2 * sum(signs of N/2 complete Walsh frequencies).
    Only equal signs on cyclic frequency orbits are assumed.
    """
    h=n//2;N=1<<h;J=N-1
    path=ROOT/f'T7_n{n}_poisson_lineJ.npz'
    if path.exists():
        return np.load(path)['allowed']
    beta=np.arange(N,dtype=np.uint64)
    parity=np.array([int(x).bit_count()%2 for x in beta],dtype=np.uint8)
    table=np.zeros((2,N,2*N+1),dtype=bool)
    for gamma in (0,1):
        # Cosets of J-perp: beta parity is gamma.
        bb=beta[parity==gamma]
        for b in range(N):
            freq=(np.uint64(b)^bb)|(bb<<np.uint64(h));canonical=freq.copy();current=freq.copy()
            for _ in range(1,n):
                current=((current<<np.uint64(1))&np.uint64((1<<n)-1))|(current>>np.uint64(n-1))
                canonical=np.minimum(canonical,current)
            _,weights=np.unique(canonical,return_counts=True)
            total=int(weights.sum());assert total==N//2
            reachable=1
            for w in weights:reachable |= reachable << int(w)
            values=[2*(total-2*s) for s in range(total+1) if (reachable>>s)&1]
            assert all(-N<=v<=N for v in values)
            table[gamma,b,np.array(values)+N]=True
    np.savez_compressed(path,allowed=table)
    return table

def validate_poisson():
    results=[]
    for n in (12,16,20):
        tab=poisson_line_J(n);N=1<<(n//2)
        w0=np.zeros(N,dtype=np.int64);wj=w0.copy();w0[N-1]=N;wj[0]=N
        # The antipodal quadratic P_n is RS bent, independent of the quartic class.
        for gamma,L in enumerate((w0+wj,w0-wj)):
            assert np.all(tab[gamma,np.arange(N),L+N])
        results.append({'n':n,'P_n_positive_control':'PASS'})
    n=12;N=64;gs=generators(n);ff=fibers(n,list(range(N)),gs)
    rng=np.random.default_rng(20261016);c=rng.integers(0,2,(12,43),dtype=np.uint8)
    tt=(c.astype(np.int64)@ff.reshape(43,-1))&1
    w=fwht_cpu((1-2*tt).reshape(-1,N,N))
    x=np.arange(4096);perm=((x&63)^(x>>6))*64+(x&63)
    full=fwht_cpu((1-2*tt)[:,perm]);beta=np.arange(N)
    for gamma in (0,1):
        bb=beta[np.array([int(v).bit_count()%2 for v in beta])==gamma]
        for b in range(N):
            idx=(b^bb)|(bb<<6)
            L=w[:,0,b]+(-1)**gamma*w[:,63,b]
            assert np.array_equal(L*N,2*np.sum(full[:,idx],axis=1))
    save('T7_poisson_validation.json',{'status':'PASS','positive_controls':results,
         'n12_random_full_Walsh_identity_checks':12*2*64,'seed':20261016})

def enumerate_image_gpu(gpu,n,name='gJ',max_rank=24,batch=8192):
    cp=gpu.cp; gs=generators(n); h=n//2; N=1<<h
    path=ROOT/f'T6_n{n}_{name}_basis.npz'; data=np.load(path)
    chosen=data['fibers'].tolist(); r=len(data['pivots'])
    if r>max_rank:
        save(f'T7_n{n}_{name}.json',{'status':'NOT_ENUMERATED','rank':r,
             'reason':'Rank exceeds configured pilot bound; use measured throughput to choose next stage'})
        return
    ff=fibers(n,chosen,gs);points=cp.asarray(pack_rows(ff.reshape(len(gs),-1).T))
    packed_basis=pack_rows(data['coefficient_transform'][:r])
    freqs=sorted({0,N-1,sum(1<<i for i in range(0,h,2))})
    histogram=np.zeros((len(chosen),len(freqs),2*N+1),dtype=np.int64)
    total=0; common_gcd=0; zero_A=0; minimum_abs_A=N
    bessel_survivors=0;poisson_survivors=0;combined_survivors=0
    has_line=0 in chosen and N-1 in chosen
    poisson=cp.asarray(poisson_line_J(n)) if has_line else None
    bindex=cp.arange(N)[None,:]
    checkpoint=ROOT/f'T7_n{n}_{name}_checkpoint.npz'
    signature=hashlib.sha256(path.read_bytes()+Path(__file__).read_bytes()).hexdigest()
    if checkpoint.exists():
        ck=np.load(checkpoint)
        assert str(ck['signature'])==signature, 'Checkpoint source/basis mismatch; preserve old run and use a new result directory.'
        total=int(ck['total']);histogram=ck['histogram']
        common_gcd=int(ck['gcd']);zero_A=int(ck['zero_A']);minimum_abs_A=int(ck['min_abs_A'])
        bessel_survivors=int(ck['bessel']);poisson_survivors=int(ck['poisson']);combined_survivors=int(ck['combined'])
    ts=time.perf_counter()
    for lo,c in coefficient_chunks(packed_basis,batch,start=total):
        w=gpu.transform(gpu.signs(c,points).reshape(-1,len(chosen),N))
        if lo==0:
            # Independent CPU oracle over actual coefficients for 8 image points.
            unpack=np.unpackbits(c[:8].view(np.uint8),axis=1,bitorder='little')[:,:len(gs)]
            ref=fwht_cpu((1-2*((unpack.astype(np.int64)@ff.reshape(len(gs),-1))&1)).reshape(-1,len(chosen),N))
            assert np.array_equal(cp.asnumpy(w[:8]),ref)
        for zidx in range(len(chosen)):
            for fidx,b in enumerate(freqs):
                histogram[zidx,fidx]+=cp.asnumpy(cp.bincount(w[:,zidx,b]+N,minlength=2*N+1))
        # Walsh gcd divides N by Parseval, so is a power of two. Avoid sorting
        # millions of coefficients to get their 2-adic common divisor.
        absolute=cp.abs(w)
        local=int(cp.asnumpy(cp.min(cp.where(absolute!=0,absolute & -absolute,2*N))))
        common_gcd=math.gcd(common_gcd,local)
        a=cp.asnumpy(w[:,:,0]);zero_A+=int(np.sum(a==0));minimum_abs_A=min(minimum_abs_A,int(np.min(np.abs(a))))
        necessary=cp.all(cp.sum(w.astype(cp.int64)**2,axis=1)<=N*N,axis=1)
        bessel_survivors+=int(cp.asnumpy(cp.sum(necessary)))
        if has_line:
            w0=w[:,chosen.index(0)];wj=w[:,chosen.index(N-1)]
            good=cp.ones(len(c),dtype=bool)
            for gamma,L in enumerate((w0+wj,w0-wj)):
                valid=(L>=-N)&(L<=N)
                good &= cp.all(valid & poisson[gamma,bindex,cp.clip(L+N,0,2*N)],axis=1)
            poisson_survivors+=int(cp.asnumpy(cp.sum(good)))
            combined_survivors+=int(cp.asnumpy(cp.sum(good & necessary)))
        total=lo+len(c)
        if (lo//batch)%32==0 or total==(1<<r):
            tmp=checkpoint.with_suffix('.tmp.npz')
            np.savez_compressed(tmp,total=total,histogram=histogram,gcd=common_gcd,zero_A=zero_A,min_abs_A=minimum_abs_A,signature=signature,
                                bessel=bessel_survivors,poisson=poisson_survivors,combined=combined_survivors)
            tmp.replace(checkpoint)
            save(f'T7_n{n}_{name}_progress.json',{'completed':total,'total':1<<r,'seconds_this_session':time.perf_counter()-ts})
    assert total==(1<<r) and np.all(histogram.sum(axis=2)==total)
    save(f'T7_n{n}_{name}.json',{'status':'EXACT_COMPLETE_IMAGE','n':n,'rank':r,
         'image_functions':total,'fibers':chosen,'frequencies_histogram':freqs,
         'common_spectral_gcd':common_gcd,'zero_A_count_over_fibers':zero_A,
         'minimum_abs_A':minimum_abs_A,'seconds_this_session':time.perf_counter()-ts,
         'partial_energy_survivors':bessel_survivors,
         'poisson_lineJ_survivors':poisson_survivors if has_line else None,
         'combined_survivors':combined_survivors if has_line else None,
         'coefficient_coset_size':1<<(len(gs)-r),
         'complete_functions_excluded_by_combined':((1<<r)-combined_survivors)*(1<<(len(gs)-r)) if has_line else None,
         'scope':'Exact necessary filters on a complete restriction image; surviving classes are not asserted bent. Any full-dimensional exclusion requires zero survivors and verified filter soundness.'})

def cpu_smoke():
    rng=np.random.default_rng(2)
    for n in (4,16,64):
        x=rng.choice([-1,1],size=(13,n));w=fwht_cpu(x)
        assert np.array_equal(fwht_cpu(w),n*x)
    a=rng.integers(0,2,(11,89),dtype=np.uint8);b,p,piv=rref(a)
    assert len(piv)==11
    assert len(generators(12))==43 and len(generators(20))==245
    small=np.eye(5,dtype=np.uint8)
    expanded=np.concatenate([c for _,c in coefficient_chunks(pack_rows(small),7)])
    assert len(np.unique(expanded,axis=0))==32
    ff=fibers(12,list(range(64)),generators(12)[:1])[0]
    w=fwht_cpu(1-2*ff.astype(np.int64));z,k,b=27,2,5
    assert w[rot(z,6,k),b]!=w[z,rot(b,6,-k)]
    original=Path('pacote_final_grau4/code/verify_independent_n12_reimpl.py')
    if original.exists():
        tree=ast.parse(original.read_text())
        assert sum(isinstance(a,ast.For) and isinstance(a.iter,ast.Name) and a.iter.id=='rem_specs' for a in ast.walk(tree))==1
    print('CPU smoke PASS; CUDA kernels NOT EXECUTED locally.')

if __name__=='__main__':
    import argparse
    parser=argparse.ArgumentParser();parser.add_argument('--smoke',action='store_true')
    parser.add_argument('--capture',type=str)
    args=parser.parse_args()
    if args.smoke:cpu_smoke()
    if args.capture:capture_baseline(Path(args.capture))
