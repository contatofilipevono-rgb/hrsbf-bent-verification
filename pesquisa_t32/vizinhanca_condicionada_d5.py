"""Exact radius-1/2 coefficient neighborhoods, keeping all three necessary tests."""
import itertools,json,time,zipfile
from pathlib import Path
import numpy as np
import pesquisa_fibras_loop as research
from verify_fibras_loop import fwht

def run_neighborhood(root,exact_evaluate,max_scans=12):
    orbits,basis,indices=research.make_tables(16,5);engine=research.Evaluator(basis,indices,'cuda')
    data=np.load(root/'checkpoint.npz'); strict=data['strict'];scores=data['strict_scores']
    idx=int(np.argmin(scores));parent=strict[idx].copy();best=int(scores[idx]);records=[]
    folder=root/'neighborhood';folder.mkdir(exist_ok=True);started=time.monotonic()
    for scan in range(max_scans):
        anchor=parent.copy();anchor_score=best; tested=passed=0
        supports=itertools.chain(((i,) for i in range(len(parent))),itertools.combinations(range(len(parent)),2))
        while True:
            chunk=list(itertools.islice(supports,1024))
            if not chunk:break
            c=np.repeat(anchor[None,:],len(chunk),axis=0)
            for j,s in enumerate(chunk): c[j,list(s)]^=1
            w,d=exact_evaluate(engine,c);bad=(w[:,1:]!=128).sum(axis=1)
            allowed=np.isin(w.sum(axis=1),[32640,32896])&(d==32768)&(w[:,-1]==128)&(c.sum(axis=1)>0)
            tested+=len(c);passed+=int(allowed.sum())
            if allowed.any():
                rows=np.flatnonzero(allowed);j=int(rows[np.argmin(bad[rows])])
                if int(bad[j])<best:best=int(bad[j]);parent=c[j].copy()
        assert tested==len(parent)*(len(parent)+1)//2
        record={'scan':scan+1,'anchor_bad_fibers':anchor_score,'best_bad_fibers':best,
                'tested':tested,'passing_all_three':passed,'radius_two_complete':True}
        records.append(record);print('VIZINHANCA',json.dumps(record),flush=True)
        np.savez_compressed(folder/'checkpoint.npz',parent=parent,best=best,anchor=anchor)
        if best==anchor_score:break
    truth=np.zeros(65536,np.uint8);x=np.arange(65536,dtype=np.uint32)
    for active,(_,orbit) in zip(parent,orbits):
        if active:
            for mon in orbit:
                mask=sum(1<<i for i in mon);truth^=((x&mask)==mask).astype(np.uint8)
    weights=truth[indices].sum(axis=1);derivative=int((truth^truth[::-1]).sum());weight=int(truth.sum())
    assert int((weights[1:]!=128).sum())==best and weight in (32640,32896) and derivative==32768 and weights[-1]==128
    spectrum=fwht(truth)
    audit={'coefficients':parent.astype(int).tolist(),'bad_fibers':best,'weight':weight,'W0':65536-2*weight,
           'derivative_weight':derivative,'complementary_fiber_weight':int(weights[-1]),
           'absolute_walsh_values':np.unique(np.abs(spectrum)).tolist(),'bent':bool(np.all(np.abs(spectrum)==256)),
           'independent_integer_audit':'PASS'}
    result={'gpu':engine.gpu,'scans':records,'best':audit,'elapsed_seconds':time.monotonic()-started,
            'limitations':'A complete local neighborhood is not the entire coefficient space.'}
    (folder/'summary.json').write_text(json.dumps(result,indent=2));return result
