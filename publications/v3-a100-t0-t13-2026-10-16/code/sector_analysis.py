"""Independent CPU confirmation and exact sector/Ward certificates."""
from itertools import combinations
import math
import time
import numpy as np
import experiment_science as ex

def span_rows(b):
    out=np.zeros((1<<len(b),b.shape[1]),dtype=np.uint8)
    for i,row in enumerate(b):out[1<<i:2<<i]=out[:1<<i]^row
    return out

def run(gpu):
    cp=gpu.cp;n=20;N=1024;J=1023;gs=ex.generators(n)
    ff=ex.fibers(n,[0,J],gs)
    b,p,piv=ex.rref(ff[:,1,:]);assert len(piv)==13
    # Complete CPU check of all 8192 attainable complementary functions.
    tt=span_rows(b);ts=time.perf_counter()
    wcpu=ex.fwht_cpu(1-2*tt.astype(np.int32))
    hist=np.stack([np.bincount(wcpu[:,k]+N,minlength=2*N+1) for k in (0,341,J)])[None,:,:]
    expected=np.load(ex.ROOT/'T7_n20_gJ_checkpoint.npz')['histogram']
    assert np.array_equal(hist,expected)
    gcd=int(np.gcd.reduce(np.abs(wcpu).ravel()));minimum=int(np.min(np.abs(wcpu[:,0])))
    assert gcd==32 and minimum==64 and not np.any(wcpu[:,0]==0)
    ex.save('T8_n20_complement_CPU.json',{'status':'PASS','complete_image_functions':8192,
        'full_frequency_coefficients_checked':int(wcpu.size),'histograms_match_GPU':True,
        'common_spectral_gcd':gcd,'minimum_abs_A':minimum,'seconds':time.perf_counter()-ts})
    short=[i for i,(_,orb) in enumerate(gs) if len(orb)<20]
    assert len(short)==5 and not np.any(p[:13,short])
    assert not np.any((p[:13]@ff[:,0,:])&1)
    complement_coeff=span_rows(p[:13])
    pts=cp.asarray(ex.pack_rows(ff.reshape(len(gs),-1).T))
    lut=cp.asarray(ex.poisson_line_J(20));idx=cp.arange(N)[None,:]
    sectors=[];passing=np.zeros(32,dtype=np.uint8)
    for mask in range(32):
        sector=np.zeros(len(gs),dtype=np.uint8)
        sector[short]=[(mask>>j)&1 for j in range(5)]
        c=complement_coeff^sector
        w=gpu.transform(gpu.signs(ex.pack_rows(c),pts).reshape(-1,2,N))
        necessary=cp.all(cp.sum(w.astype(cp.int64)**2,axis=1)<=N*N,axis=1)
        good=cp.ones(len(c),dtype=bool)
        for gamma,L in enumerate((w[:,0]+w[:,1],w[:,0]-w[:,1])):
            good &= cp.all((L>=-N)&(L<=N)&lut[gamma,idx,cp.clip(L+N,0,2*N)],axis=1)
        count=int(cp.asnumpy(cp.sum(necessary & good)))
        passing[mask]=count>0
        w0=ex.fwht_cpu(1-2*((sector.astype(np.int64)@ff[:,0,:])&1))
        v=int(w0[J]);condition=v*v%80==16
        sectors.append({'mask':mask,'short_coefficients':sector[short].tolist(),
            'Wg0_J':v,'square_mod80':v*v%80,'condition_mod80':condition,
            'survivors_out_of_8192':count})
    assert sum(s['survivors_out_of_8192'] for s in sectors)==65536
    anf=passing.copy()
    for j in range(5):
        for mask in range(32):
            if mask>>j&1:anf[mask]^=anf[mask^(1<<j)]
    for mask in range(32):
        assert sum(int(anf[t]) for t in range(32) if t&mask==t)%2==passing[mask]
    ex.save('T8_n20_sector_law.json',{'status':'EXACT_FINITE_CLASSIFICATION',
        'short_orbit_indices':short,'short_orbit_supports':[list(gs[i][0]) for i in short],
        'sectors':sectors,'sectors_with_any_survivor':int(passing.sum()),
        'all_or_none_in_each_sector':all(s['survivors_out_of_8192'] in (0,8192) for s in sectors),
        'mod80_matches_nonempty_sectors':all(s['condition_mod80']==bool(passing[s['mask']]) for s in sectors),
        'necessary_sector_indicator_ANF_masks':np.flatnonzero(anf).tolist(),
        'scope':'Exact n=20 classification of the necessary partial-energy and line-Poisson filters; generalization and novelty not claimed'})
    return sectors

def ward_certificate(n,k):
    """Sufficient weight divisibility criterion from XOR inclusion-exclusion.
    For products of s<=k generator rows, require 2^(k-s+1)|weight(product).
    Higher products have coefficient (-2)^(s-1) already divisible by 2^k.
    """
    h=n//2;N=1<<h;J=N-1;u=np.arange(N)
    gs=ex.generators(n);b,p,pivs=ex.rref(ex.fibers(n,[J],gs)[:,0,:])
    linear=np.array([(u>>j)&1 for j in range(h)],dtype=np.uint8)
    rows=np.vstack([b,linear]);checked=0;fail=None;counts={}
    for s in range(1,k+1):
        modulus=1<<(k-s+1);num=0
        for inds in combinations(range(len(rows)),s):
            wt=int(np.sum(np.bitwise_and.reduce(rows[list(inds)],axis=0)))
            checked+=1;num+=1
            if wt%modulus:
                fail={'row_indices':list(inds),'weight':wt,'required_divisor':modulus}
                break
        counts[str(s)]=num
        if fail:break
    report={'n':n,'k':k,'image_rank':len(pivs),'generators_with_linear_characters':len(rows),
        'checked_intersections':checked,'counts_by_product_size':counts,
        'status':'PASS' if fail is None else 'REFUTED','first_counterexample':fail,
        'conclusion_if_PASS':f'Every word of span(g_J images, linear characters) has weight divisible by {1<<k}; therefore every W_gJ(b) is divisible by {1<<(k+1)}.',
        'proof_rule':'XOR weight inclusion-exclusion; all higher-order coefficients vanish modulo 2^k',
        'scope':'Finite n certificate, not a uniform theorem in n'}
    if fail and len(fail['row_indices'])==1 and fail['row_indices'][0]<len(b):
        row=fail['row_indices'][0];inds=np.flatnonzero(p[row]).tolist()
        report['actual_function_counterexample']={
            'coefficient_orbit_indices':inds,'orbit_supports':[list(gs[i][0]) for i in inds],
            'A_J':N-2*fail['weight'],'candidate_Walsh_divisor':1<<(k+1),
            'meaning':'A concrete homogeneous quartic RS function whose complementary Walsh sum violates the stronger candidate divisor'}
    np.savez_compressed(ex.ROOT/f'T9_n{n}_k{k}_rows.npz',image_basis=b,linear_rows=linear,
                        coefficient_transform=p,pivots=np.array(pivs))
    ex.save(f'T9_n{n}_k{k}.json',report)
    return report
