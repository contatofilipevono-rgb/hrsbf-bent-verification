"""A flag inside the global polar radical, so no matrix quadratics survive restriction."""
import itertools
import json
import random
from pathlib import Path
import numpy as np
from H16_SPECIALIZED_KERNEL import diagnostic, mul, rank, singular, specialize, strip, verify_specialization
from SOLVE_STEP40A_B11_COMMON_KERNEL_AND_DECOMPOSITION import gf2_rref_np as rref, gf2_nullspace_np as null


def unpack(masks,width):
    return np.array([[(v>>j)&1 for j in range(width)] for v in masks],dtype=np.uint8)


def encode(rows):
    return [sum(int(x)<<j for j,x in enumerate(row)) for row in rows]


def add(pivots, vector):
    while vector:
        lead=vector.bit_length()-1
        if lead not in pivots:
            pivots[lead]=vector
            return True
        vector^=pivots[lead]
    return False


def expanded(pivots,vectors):
    copy=pivots.copy()
    for v in vectors: add(copy,v)
    return copy


def run():
    data=json.loads(Path("pencil/step41_B0_11.json").read_text())
    width=len(data["complement"])
    coeff={0:unpack(data["reduced_constant"],width)}
    for k,m in enumerate(data["reduced_slices"]): coeff[1<<k]=unpack(m,width)
    for i,j,m in data["reduced_quadratic_slices"]: coeff[(1<<i)|(1<<j)]=unpack(m,width)
    n=len(data["w_vars"])
    polar=np.zeros((n,coeff[0].size,n),dtype=np.uint8)
    for i,j,m in data["reduced_quadratic_slices"]:
        matrix=unpack(m,width).ravel()
        polar[i,:,j]^=matrix
        polar[j,:,i]^=matrix
    radical=null(polar.reshape(-1,n))
    lifted,_=specialize(coeff,np.zeros(n,dtype=np.uint8),radical)
    assert all(not m.any() for k,m in lifted.items() if k.bit_count()>1)
    # Build a pool from a radical basis and every pairwise sum.
    pool=[]
    for weight in (1,2):
        for indices in itertools.combinations(range(len(radical)),weight):
            M=np.zeros_like(coeff[0])
            for k in indices:
                M^=lifted.get(1<<k,np.zeros_like(M))
            A, B = encode(M.T),encode(M)
            pool.append((sum(1<<k for k in indices),A,B,rank(M,rref)))
    flag=[]
    given,images,rows={},{},{}
    offsets=random.Random(4400)
    original_P=unpack(data["projector"],len(data["source_rhs_anf"]))
    rhs=[set(row) for row in data["source_rhs_anf"]]
    quads=[set(row)|{int(bit)} for bit,row in data["tails"].items()]
    for d in range(1,31):
        scored=[]
        for mask,c,r,rk in pool:
            extension=given.copy()
            if not add(extension,mask): continue
            im=expanded(images,c)
            row=expanded(rows,r)
            scored.append(((len(im),len(row),rk,mask),extension,im,row))
        score,given,images,rows=min(scored,key=lambda item:item[0])
        flag.append(score[-1])
        if d not in (24,26,28,30): continue
        S=mul(unpack(flag,len(radical)),radical)
        F=null(S)
        _,piv=rref(F)
        values=np.array([[(offsets.getrandbits(1))] for _ in F],dtype=np.uint8)
        A,p=rref(np.concatenate((F[:,piv],values),axis=1))
        assert list(p)==list(range(len(F)))
        base=np.zeros(n,dtype=np.uint8)
        base[piv]=A[:,-1]
        assert np.array_equal(mul(F,base),values[:,0])
        specialized,forms=specialize(coeff,base,S)
        verify_specialization(coeff,specialized,base,S)
        assert all(not M.any() for k,M in specialized.items() if k.bit_count()>1)
        core,P,steps=strip(specialized,rref,null)
        payload={"radical_dim":len(radical),"free":d,"fixed":n-d,
                 "matrix":diagnostic(specialized,rref),"after":diagnostic(core,rref),
                 "elimination":steps}
        if d in (28,30):
            substitution=[None]*(1+max(data["w_vars"]+data["tail_vars"]))
            for i,v in enumerate(data["w_vars"]): substitution[v]=forms[i]
            for i,v in enumerate(data["tail_vars"]): substitution[v]={1<<(d+i)}
            payload["singular"]=singular(core,mul(P,original_P),rhs,quads,substitution,25)
        print("STEP45_RADICAL",json.dumps(payload),flush=True)


if __name__=="__main__":
    run()
