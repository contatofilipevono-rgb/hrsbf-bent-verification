#!/usr/bin/env python3
"""Independent finite checks for the antipodal-rule proof (standard library)."""
from itertools import combinations

def rotmask(m,n,s=1):
    return ((m<<s)|(m>>(n-s)))&((1<<n)-1)
def orbits(n,d):
    unseen={sum(1<<i for i in c) for c in combinations(range(n),d)}; out=[]
    while unseen:
        m=min(unseen); o=[]; x=m
        while x not in o:o.append(x);x=rotmask(x,n)
        unseen-=set(o);out.append(o)
    return out
def eval_orbit(o,x): return sum((x&m)==m for m in o)&1
def walsh(vals):
    a=[1 if v==0 else -1 for v in vals];h=1
    while h<len(a):
        for i in range(0,len(a),2*h):
            for j in range(i,i+h):
                x,y=a[j],a[j+h];a[j]=x+y;a[j+h]=x-y
        h*=2
    return a
def check(n):
    gens=[]
    for d in range(4):
        gens += orbits(n,d)
    ant=set(range(0,n,n)) # dummy
    anti=tuple(sorted(1<<i | 1<<(i+n//2) for i in range(n//2)))
    ai=next(i for i,o in enumerate(gens) if tuple(sorted(o))==anti)
    tabs=[[eval_orbit(o,x) for x in range(1<<n)] for o in gens]
    bent=without=0;target=1<<(n//2)
    for mask in range(1<<len(gens)):
        vals=[0]*(1<<n)
        for j,t in enumerate(tabs):
            if mask>>j&1: vals=[a^b for a,b in zip(vals,t)]
        W=walsh(vals)
        if all(abs(v)==target for v in W):
            bent+=1
            if not(mask>>ai&1):without+=1
    return len(gens),bent,without
if __name__=="__main__":
    for n in (4,8):
        g,b,w=check(n);print(n,g,b,w)
        assert w==0
