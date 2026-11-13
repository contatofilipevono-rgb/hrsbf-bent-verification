"""Reconstruct the basis used to number the dimension-four support catalog."""
from count_near_antipodal import image_and_kernel
from higher_filter import evaluate_orbit,shift,xor_terms
from lower_dim_model import build
from itertools import combinations


def decode(space):
    model = build(((7,14,28,56),(5,10,20,40))[space-1])
    truth=[]
    seen=set()
    for degree in range(5):
        for indices in combinations(range(12),degree):
            monomial=sum(1<<i for i in indices)
            if monomial in seen:continue
            orbit={shift(monomial,k) for k in range(12)}
            seen.update(orbit)
            truth.append(evaluate_orbit(orbit))
    moved=[sum(((t>>x)&1)<<i for i,x in enumerate(model.coordinates)) for t in truth]
    import numpy as np
    z=np.arange(64)[:,None]
    w=np.arange(64)[None,:]
    idx=(z^w)|(w<<6)
    def conditions(table):
        values=np.array([(table>>i)&1 for i in range(4096)],dtype=np.uint8)[idx]
        rows=[values^values[:,w[0]^a]^values[:,w[0]^b]^values[:,w[0]^a^b]
              for a,b in combinations(model.basis,2)]
        return int.from_bytes(np.packbits(np.concatenate([r.ravel() for r in rows])).tobytes(),"big")
    _,ker=image_and_kernel([conditions(t) for t in truth])
    mm=(1<<256)-1
    def projection(t):
        return sum(((t^(t>>(256<<i)))&mm)<<(256*i) for i in range(4))
    packed=[projection(xor_terms(moved,c)) for c in ker]
    def interleave(mapping):
        return sum(((mapping>>(256*i+x))&1)<<(1023-(4*x+i))
                   for x in range(256) for i in range(4))
    image,_=image_and_kernel([interleave(p) for p in packed])
    maps=[xor_terms(packed,v) for _,v in image]
    def labels(mapping):
        return [sum(((mapping >> (256*i+x))&1)<<i for i in range(4)) for x in range(256)]
    def q(mapping):
        v=labels(mapping)
        return sum(((v[z+64*k]^v[z]) >> i & 1) << (511-(256*(k-1)+4*z+i))
                   for k in (1,2) for z in range(64) for i in range(4))
    image,kernel=image_and_kernel([q(p) for p in maps])
    directions=[xor_terms(maps,v) for v in kernel+[v for _,v in image]]
    return model,directions,labels
