"""Exact falsification checks. Python 3 + numpy; no floating point Walsh tests."""
from itertools import combinations
import json
from pathlib import Path
import numpy as np

def rotate(a,n,step=1):
    return ((a<<step)|(a>>(n-step)))&((1<<n)-1)

def orbits(n,degree,step=1):
    seen=set(); out=[]
    for d in range(degree+1):
        for inds in combinations(range(n),d):
            a=sum(1<<i for i in inds)
            if a in seen: continue
            orb=[]; b=a
            while b not in orb:
                orb.append(b); seen.add(b); b=rotate(b,n,step)
            out.append(orb)
    return out

def fwht(x):
    y=x.copy(); h=1
    while h<y.shape[-1]:
        z=y.reshape(-1,y.shape[-1]//(2*h),2*h)
        a=z[:,:,:h].copy(); b=z[:,:,h:].copy()
        z[:,:,:h]=a+b; z[:,:,h:]=a-b; h*=2
    return y

def tables(n,orbs):
    x=np.arange(1<<n,dtype=np.int64)
    return np.array([np.bitwise_xor.reduce([(x&a)==a for a in orb]) for orb in orbs],dtype=np.int8)

def exact_family(n,step=1):
    obs=orbits(n,3,step); basis=tables(n,obs)
    assert len(obs)<=20
    total=1<<len(obs); bent=0; no_antipodal=0; restriction_fail=0
    t=step if step>1 else n
    folded=np.array([sum(((y>>(i%t))&1)<<i for i in range(n)) for y in range(1<<t)])
    target=3 if n==2 else 1|(1<<(n//2))
    anti=next(i for i,o in enumerate(obs) if target in o)
    for start in range(0,total,1024):
        ids=np.arange(start,min(start+1024,total),dtype=np.int64)
        bits=((ids[:,None]>>np.arange(len(obs)))&1).astype(np.int8)
        vals=(bits@basis)&1
        w=fwht(1-2*vals.astype(np.int64))
        ok=np.all(w*w==(1<<n),axis=1)
        bent+=int(ok.sum()); no_antipodal+=int(np.sum(ok & (bits[:,anti]==0)))
        if step>1:
            wf=fwht(1-2*vals[:,folded].astype(np.int64))
            restriction_fail+=int(np.sum(ok & ~np.all(wf*wf==(1<<t),axis=1)))
    return dict(n=n,rotation_step=step,dimension= len(obs),tested=total,bent=bent,
        bent_without_antipodal=no_antipodal if step==1 else 'not tested: subgroup only',
        bent_restriction_failures=restriction_fail if step>1 else 'not applicable')

def folding(n,t,maxdegree):
    count=0
    for orb in orbits(n,maxdegree):
        accum=set()
        for a in orb:
            b=0
            for i in range(n):
                if a>>i&1:b|=1<<(i%t)
            if b in accum:accum.remove(b)
            else:accum.add(b)
        src=int((1|(1<<(n//2))) in orb)
        dst=int((1|(1<<(t//2))) in accum)
        assert src==dst,(n,t,orb,accum)
        count+=1
    return dict(n=n,t=t,distinct_orbits=count,degree_bound=maxdegree,passed=True)

if __name__=='__main__':
    results={'arithmetic':'integer Walsh transforms; Boolean ANF supports with duplicate cancellation',
        'exhaustive':[exact_family(n) for n in (2,4,6,8)],
        'odd_subgroup_cubics':[exact_family(6,2)],
        'folding':[folding(n,t,3) for n,t in ((6,2),(10,2),(12,4),(18,2),(20,4),(24,8),(30,2),(40,8))]}
    print(json.dumps(results,indent=2))
    Path(__file__).with_name('adversarial_results.json').write_text(json.dumps(results,indent=2)+'\n')
