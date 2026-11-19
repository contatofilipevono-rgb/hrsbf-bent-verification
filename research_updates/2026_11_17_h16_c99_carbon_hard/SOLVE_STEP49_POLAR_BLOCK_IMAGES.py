import json
from pathlib import Path
import numpy as np
from H16_SPECIALIZED_KERNEL import mul, specialize
from H16_POLAR_FLAGS import add, encode, radical_flag, rref, null

def images_over_offsets(coeff,S,K):
    """Enumerate the rank of the constant map on K on all cosets of S."""
    n=S.shape[1]
    piv=set(rref(S)[1])
    coordinates=[i for i in range(n) if i not in piv]
    J=np.eye(n,dtype=np.uint8)[coordinates]
    block,_=specialize(coeff,np.zeros(n,dtype=np.uint8),J)
    r=len(K)
    def pack(matrix):
        projected=mul(matrix,K.T)
        return sum(c<<(j*len(matrix)) for j,c in enumerate(encode(projected.T)))
    m=coeff[0].shape[0]
    mask=(1<<m)-1
    base=pack(block[0])
    d=len(J)
    slopes=[pack(block[1<<j]) if (1<<j) in block else 0 for j in range(d)]
    mixed=[[0]*d for _ in range(d)]
    for term,mat in block.items():
        if term.bit_count()==2:
            first=term&-term
            a=first.bit_length()-1
            b=(term^first).bit_length()-1
            mixed[a][b]=mixed[b][a]=pack(mat)
    union={}
    common=None
    unique=set()
    for index in range(1<<d):
        if index:
            j=(index&-index).bit_length()-1
            base^=slopes[j]
            for k in range(d): slopes[k]^=mixed[j][k]
        vector=base
        echelon={}
        for _ in range(r):
            add(echelon,vector&mask)
            vector>>=m
        assert len(echelon)==r
        for pivot in sorted(echelon):
            for high in echelon:
                if high>pivot and echelon[high]>>pivot&1:
                    echelon[high]^=echelon[pivot]
        basis=tuple(echelon[j] for j in sorted(echelon))
        if basis not in unique:
            unique.add(basis)
            for row in basis: add(union,row)
            if common is None or len(common)>1:
                elements=[0]
                for row in basis: elements += [v^row for v in elements]
                common=set(elements) if common is None else common.intersection(elements)
    assert common is not None and len(common)&(len(common)-1)==0
    return {"offsets":1<<d,"image_count":len(unique),"image_union_dim":len(union),
            "image_intersection_dim":len(common).bit_length()-1,
            "uniform_projection_rank":m-len(union),
            "same_64_row_projection":len(union)==r}

def main():
    data=json.loads(Path("pencil/step41_B0_11.json").read_text())
    results=[]
    for d,coeff,S in radical_flag(data):
        if d not in (28,30): continue
        base,_=specialize(coeff,np.zeros(S.shape[1],dtype=np.uint8),S)
        nonconstant=[M for k,M in base.items() if k and M.any()]
        K=null(np.concatenate(nonconstant,axis=0))
        assert len(K)==5
        result={"free":d,"fixed":S.shape[1]-d,**images_over_offsets(coeff,S,K)}
        results.append(result)
        print("STEP49_IMAGES",json.dumps(result),flush=True)
    Path("step49_images.json").write_text(json.dumps(results))


if __name__=="__main__":
    main()
