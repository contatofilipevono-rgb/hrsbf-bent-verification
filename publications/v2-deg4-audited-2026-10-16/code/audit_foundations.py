#!/usr/bin/env python3
"""Deterministic finite foundations; independent of the two sieve modules."""
from itertools import combinations
from pathlib import Path
import json
import numpy as np

def rotate(x,n,k=1):
    k %= n
    return ((x << k) | (x >> (n-k))) & ((1 << n)-1)

def orbits(n):
    seen=set(); out=[]
    for t in combinations(range(n),4):
        m=sum(1 << i for i in t)
        if m in seen: continue
        o=sorted({rotate(m,n,k) for k in range(n)})
        seen.update(o)
        rep=min(tuple(i for i in range(n) if x >> i & 1) for x in o)
        out.append((rep,o))
    return sorted(out)

def truth(n,obs):
    x=np.arange(1 << n,dtype=np.int64)
    return np.array([np.bitwise_xor.reduce([(x&m)==m for m in o]) for _,o in obs],dtype=np.uint8)

def walsh(tt):
    a=1-2*tt.astype(np.int64)
    for k in range(a.shape[-1].bit_length()-1):
        h=1 << k
        for j in range(0,a.shape[-1],2*h):
            l=a[...,j:j+h].copy();r=a[...,j+h:j+2*h].copy()
            a[...,j:j+h]=l+r;a[...,j+h:j+2*h]=l-r
    return a

def basis(a):
    a=a.copy();r=0
    for j in range(a.shape[1]):
        ix=np.flatnonzero(a[r:,j])
        if len(ix)==0: continue
        t=r+int(ix[0]);a[[r,t]]=a[[t,r]]
        for i in range(len(a)):
            if i!=r and a[i,j]: a[i]^=a[r]
        r+=1
        if r==len(a):break
    return a[:r]

def span(b):
    a=np.zeros((1 << len(b),b.shape[1]),dtype=np.uint8)
    for i,x in enumerate(b):a[1<<i:2<<i]=a[:1<<i]^x
    return a

def main():
    report={"small_cases":{},"n12":{}}
    for n in (4,6,8):
        obs=orbits(n); tt=truth(n,obs);alltt=span(tt)
        count=int(np.sum(np.all(np.abs(walsh(alltt))==2**(n//2),axis=1)))
        assert count==0
        report['small_cases'][str(n)]={"orbits":len(obs),"functions":len(alltt),"bent":count}
    obs=orbits(12);tt=truth(12,obs);u=np.arange(64)
    assert len(obs)==43 and sum(len(o) for _,o in obs)==495
    assert sorted(len(o) for _,o in obs)==[3,6,6]+[12]*40
    fibers=np.stack([tt[:,u | ((u^z)<<6)] for z in range(64)],axis=1)
    W=walsh(fibers)
    for z in range(64):
        assert np.array_equal(fibers[:,z,u^z],fibers[:,z,:])
        a=fibers[:,z,:].copy()
        for k in range(6):
            for x in range(64):
                if x >> k & 1:a[:,x]^=a[:,x^(1<<k)]
        assert not np.any(a[:,[x for x in range(64) if x.bit_count()>3]])
        for k in range(6):
            tau=rotate(z<<6,12,k)&63
            for b in range(64):
                rb=rotate(b,6,-k)
                assert np.array_equal(W[:,rotate(z,6,k),b],(-1)**((b&tau).bit_count()%2)*W[:,z,rb])
    reps=[0,2,4,6,10,12]
    vals=fibers[:,63,reps]
    assert np.all(np.bitwise_xor.reduce(vals,axis=1)==0)
    report['n12']['orbit_table']=[{"index":i,"support":list(t),"size":len(o),"complement_values":vals[i].tolist()} for i,(t,o) in enumerate(obs)]
    for z,tau in ((9,1),(27,3)):
        T=np.array([rotate(int(x),6,3)^tau for x in u])
        assert np.array_equal(T[T],u^z)
        assert np.array_equal(fibers[:,z,T],fibers[:,z,:])
        seen=set();rr=[]
        for x in range(64):
            if x not in seen:
                orb={x,int(T[x]),int(T[T[x]]),int(T[T[T[x]]])}
                assert len(orb)==4;seen.update(orb);rr.append(x)
        assert np.all(np.sum(fibers[:,z,rr],axis=1)%2==0)
    for z,r in ((9,9),(27,10),(63,5)):
        b=basis(fibers[:,z,:]);assert len(b)==r
        w=walsh(span(b));assert np.all(w[:,0]%16==0)
        if z==27:assert np.all(w[:,63]%16==0)
        else:assert np.all(w[:,63]==0)
        report['n12'][str(z)]={"rank":r,"A_values":sorted(set(w[:,0].tolist())),"W63_values":sorted(set(w[:,63].tolist()))}
    tri=[i for i,(_,o) in enumerate(obs) if len(o)<12]
    assert tri==[26,40,42]
    assert not np.any(fibers[[i for i in range(43) if i not in tri],0,:])
    q=[]
    for d in (1,2,3):
        terms=range(3) if d==3 else range(6)
        q.append(np.bitwise_xor.reduce([((u >> i)&1)*((u >> ((i+d)%6))&1) for i in terms]))
    assert np.array_equal(fibers[tri,0,:],np.array(q))
    g0=span(fibers[tri,0,:]);w0=walsh(g0)
    assert np.all(w0 % 8 == 0)
    sectors=[]
    for mask in range(8):
        c26,c40,c42=[mask>>i&1 for i in range(3)]
        assert (int(w0[mask,63])**2%384==256)==bool(c40^(c26&c42))
        sectors.append({"coefficients":[c26,c40,c42],"A0":int(w0[mask,0]),"W0_63":int(w0[mask,63])})
    report['n12']['sectors']=sectors
    out=Path(__file__).resolve().parent.parent/'results';out.mkdir(exist_ok=True)
    (out/'foundations.json').write_text(json.dumps(report,indent=2)+'\n')
    print('PASS: n=4,6,8 full Walsh; 43 quartic orbits; degree and invariance; 1,056,768 signed transport identities; actual generator syzygy; T_9,T_27; image spaces; 8 sectors.')

if __name__=='__main__':main()
