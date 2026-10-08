"""Exhaustive 12-dimensional image of the quintic complementary-fiber map."""
import itertools,json
from pathlib import Path
import numpy as np

def analyze():
    reps=sorted({min(tuple(sorted((i+s)%16 for i in mon)) for s in range(16))
                 for mon in itertools.combinations(range(16),5)})
    u=np.arange(256,dtype=np.uint32);x=u|((u^255)<<8);pivots={}
    for i,rep in enumerate(reps):
        table=np.zeros(256,np.uint8)
        for mon in {tuple(sorted((j+s)%16 for j in rep)) for s in range(16)}:
            mask=sum(1<<j for j in mon);table^=((x&mask)==mask).astype(np.uint8)
        v=int.from_bytes(np.packbits(table,bitorder='little').tobytes(),'little');c=1<<i
        while v:
            p=v.bit_length()-1
            if p in pivots:v^=pivots[p][0];c^=pivots[p][1]
            else:pivots[p]=(v,c);break
    span=[(0,0)]
    for v,c in pivots.values():span += [(w^v,d^c) for w,d in span]
    hist={};degree_counts={};balanced_degrees={};witnesses={}
    for v,c in span:
        weight=v.bit_count();hist[weight]=hist.get(weight,0)+1
        anf=np.unpackbits(np.frombuffer(v.to_bytes(32,'little'),np.uint8),bitorder='little').copy()
        for bit in range(8):
            for mask in range(256):
                if mask&(1<<bit):anf[mask]^=anf[mask^(1<<bit)]
        degree=max((mask.bit_count() for mask in np.flatnonzero(anf)),default=-1)
        degree_counts[degree]=degree_counts.get(degree,0)+1
        if weight==128:
            balanced_degrees[degree]=balanced_degrees.get(degree,0)+1
            witnesses.setdefault(degree,{'fiber_truth_hex':hex(v),'coefficient_mask':hex(c),
                 'active_orbit_representatives':[list(reps[i]) for i in range(len(reps)) if (c>>i)&1],
                 'degree':degree,'weight':weight})
    return {'n':16,'degree':5,'input_orbit_count':len(reps),'image_rank':len(pivots),
            'kernel_dimension':len(reps)-len(pivots),'image_profile_count':len(span),
            'weight_histogram':hist,'degree_counts':degree_counts,'balanced_profile_degrees':balanced_degrees,
            'balanced_witnesses':witnesses,'scope':'Complementary fiber only, not complete bentness conditions.',
            'method':'Independent orbit enumeration, exact GF(2) elimination with generator provenance, complete image enumeration and ANF transform.'}

if __name__=='__main__':
    result=analyze();Path(__file__).with_suffix('.json').write_text(json.dumps(result,indent=2))
    print(json.dumps({k:v for k,v in result.items() if k!='balanced_witnesses'},indent=2))
