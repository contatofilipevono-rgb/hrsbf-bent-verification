"""Verify an affine law on ALL states, exporting every exceptional rejection."""
import numpy as np
import experiment_science as ex

def verify(s,mask=32913392,rhs=1,batch=1<<20):
    cp=s.cp;counts=np.zeros(4,dtype=np.int64);exceptions=[]
    for lo in range(0,1<<s.free_rank,batch):
        ids=cp.arange(lo,min(lo+batch,1<<s.free_rank),dtype=cp.uint64)
        accepted=s.evaluate(ids)==0
        parity=(1-s.gpu.signs(ids[:,None],cp.asarray([[mask]],dtype=cp.uint64))[:,0])//2
        law=(parity==rhs)
        bins=2*accepted.astype(cp.int32)+law.astype(cp.int32)
        counts+=cp.asnumpy(cp.bincount(bins,minlength=4))
        exceptions.append(cp.asnumpy(ids[(~accepted)&law]))
    assert counts.sum()==1<<s.free_rank
    assert counts[2]==0,'Candidate affine law refuted by a survivor'
    exceptional=np.concatenate(exceptions)
    assert len(exceptional)==counts[1]
    v=np.array([(mask>>i)&1 for i in range(s.free_rank)],dtype=np.uint8)
    R,T,piv=ex.rref(s.Q);L=np.zeros(s.full_rank,dtype=np.uint8)
    L[piv]=(T@v)&1
    assert np.array_equal((s.Q@L)&1,v)
    rhs_orig=int(rhs^((s.offset@L)&1))
    data=np.load(ex.ROOT/f'T6_n{s.n}_joint_period2_basis.npz')
    ff=ex.fibers(s.n,data['fibers'].tolist())
    coordmap=ff.reshape(len(ff),-1)[:,data['pivots']]
    original=(coordmap@L)&1
    assert np.array_equal((s.P@original)&1,L)
    # Equivalent laws modulo the two necessary short-sector equations.
    choices=[]
    for a in range(2):
        for b in range(2):
            q=original.copy();target=rhs_orig
            if a:q[244]^=1
            if b:q[186]^=1;q[242]^=1;target^=1
            choices.append((int(q.sum()),q,target))
    _,original,rhs_orig=min(choices,key=lambda t:t[0])
    gs=ex.generators(s.n)
    np.savez_compressed(ex.ROOT/'T12_affine_exceptions.npz',exceptional_ids=exceptional,original_linear_form=original,original_rhs=rhs_orig,free_mask=mask,free_rhs=rhs,Q=s.Q,offset=s.offset)
    report={'status':'EXACT_COMPLETE_IMAGE','n':s.n,'states':1<<s.free_rank,'counts_reject_outside_reject_inside_accept_outside_accept_inside':counts.tolist(),'necessary_affine_law_original_indices':np.flatnonzero(original).tolist(),'necessary_affine_law_original_supports':[list(gs[i][0]) for i in np.flatnonzero(original)],'rhs':rhs_orig,'exceptional_rejections_inside_affine_space':len(exceptional),'all_exceptions_exported':True,'meaning':'On the previous sector-restricted image, the exact T11 filter accepts precisely this affine hyperplane minus the exported finite exception set. Original linear law is necessary for bentness; exceptions describe only this restricted sieve.'}
    ex.save('T12_verified_structure.json',report)
    if len(exceptional):assert s.cpu_check(exceptional[:256])==0
    return report
