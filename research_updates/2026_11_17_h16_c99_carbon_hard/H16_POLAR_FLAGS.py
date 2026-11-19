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


def decompose_all_offsets(coeff,S,K):
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
    count={}
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
        k=len(echelon)
        count[k]=count.get(k,0)+1
    return count


def radical_flag(data):
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
        yield d, coeff, mul(unpack(flag,len(radical)),radical)
