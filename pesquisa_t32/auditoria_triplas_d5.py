"""Independent exact enumeration of all three-orbit quintic RSBFs at n=16."""
import itertools, json, hashlib, struct, time
from pathlib import Path
import numpy as np

def audit_triples():
    started=time.monotonic(); groups={}
    for support in itertools.combinations(range(16),5):
        orbit={tuple(sorted((i+s)%16 for i in support)) for s in range(16)}
        groups.setdefault(min(orbit),orbit)
    reps=sorted(groups); x=np.arange(65536,dtype=np.uint32);u=np.arange(256,dtype=np.uint32)
    indices=[u|((u^z)<<8) for z in range(256)]
    tables=[];fiber_bits=[]
    for rep in reps:
        truth=np.zeros(65536,np.uint8)
        for mon in groups[rep]:
            mask=sum(1<<i for i in mon);truth^=((x&mask)==mask).astype(np.uint8)
        assert not np.any(truth[indices[0]])
        tables.append(int.from_bytes(np.packbits(truth,bitorder='little').tobytes(),'little'))
        fiber_bits.append([int.from_bytes(np.packbits(truth[idx],bitorder='little').tobytes(),'little') for idx in indices])
    tested=weight_excluded=fiber_excluded=0; survivors=[]; digest=hashlib.sha256();hist={}
    for i,j,k in itertools.combinations(range(len(reps)),3):
        truth=tables[i]^tables[j]^tables[k];weight=truth.bit_count();tested+=1
        hist[weight]=hist.get(weight,0)+1
        if weight not in (32640,32896):
            weight_excluded+=1;z=0;w=weight
        else:
            z=0;w=weight
            for t in range(1,256):
                fw=(fiber_bits[i][t]^fiber_bits[j][t]^fiber_bits[k][t]).bit_count()
                if fw!=128:z=t;w=fw;fiber_excluded+=1;break
            if not z:survivors.append([i,j,k])
        digest.update(struct.pack('<HHHHI',i,j,k,z,w))
        if tested%500000==0:print('TRIPLAS',tested,'peso_excluidos',weight_excluded,flush=True)
    expected=len(reps)*(len(reps)-1)*(len(reps)-2)//6
    assert tested==expected
    return {'n':16,'degree':5,'orbit_count':len(reps),'tested':tested,'expected':expected,
            'weight_exclusions':weight_excluded,'fiber_exclusions':fiber_excluded,
            'surviving_necessary_conditions':survivors,'weight_histogram':hist,
            'ordered_witness_sha256':digest.hexdigest(),'elapsed_seconds':time.monotonic()-started,
            'scope':'Exactly three active rotation orbits; not all quintic RSBFs.',
            'method':'Independent monomial orbits, integer XOR and popcount; no CUDA or float products.'}

if __name__=='__main__':
    result=audit_triples()
    Path(__file__).with_suffix('.json').write_text(json.dumps(result,indent=2))
    print(json.dumps({k:v for k,v in result.items() if k!='weight_histogram'},indent=2))
