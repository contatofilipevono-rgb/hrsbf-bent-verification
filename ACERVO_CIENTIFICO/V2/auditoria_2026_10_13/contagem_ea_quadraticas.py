#!/usr/bin/env python3
"""Exact Burnside counting of quadratic EA classes in the V2 family.
Mathematical interpretation conditional on the ultra-rigidity theorem.
Only Python 3 standard library needed.
"""
from itertools import permutations
from math import factorial, comb

def partitions(items):
    if not items:
        yield ()
        return
    x, *tail = items
    for p in partitions(tail):
        yield ((x,),) + p
        for j,b in enumerate(p):
            yield p[:j] + (tuple(sorted(b+(x,))),) + p[j+1:]

def canonical(part):
    return tuple(sorted(tuple(sorted(b)) for b in part))

def refine(a,b):
    return all(any(set(x).issubset(y) for y in b) for x in a)

def orbit_count(perm, objects):
    objects, seen = set(objects), set()
    count=0
    for x in objects:
        if x in seen: continue
        count+=1
        y=x
        while y not in seen:
            assert y in objects
            seen.add(y)
            y=(perm[y[0]],perm[y[1]])
    return count

def fixed_connected(perm):
    n=len(perm)
    parts=sorted({
        p for p in (canonical(p) for p in partitions(list(range(n))))
        if canonical(tuple(tuple(perm[x] for x in b) for b in p))==p
    },key=lambda p:-len(p))
    exact={}
    for p in parts:
        arcs=((i,j) for b in p for i in b for j in b if i!=j)
        total=1 << orbit_count(perm,arcs)
        exact[p]=total-sum(v for q,v in exact.items() if refine(q,p))
        assert exact[p]>=0
    return exact[(tuple(range(n)),)]

def q_cycles(perm):
    n=len(perm)
    ident=tuple(range(n))
    p=ident
    total=0
    d=0
    while True:
        f=sum(p[i]==i for i in range(n))
        t=sum(i<p[i] and p[p[i]]==i for i in range(n))
        total+=f*(comb(8*f,2)+8*t)
        d+=1
        p=tuple(perm[p[i]] for i in range(n))
        if p==ident: break
    assert total%d==0
    return total//d

def cycle_type(perm):
    done=set()
    cyc=[]
    for i in range(len(perm)):
        if i in done: continue
        j=i; length=0
        while j not in done:
            done.add(j);length+=1;j=perm[j]
        cyc.append(length)
    return tuple(sorted(cyc,reverse=True))

def count_ea(r):
    terms={}
    for p in permutations(range(r)):
        key=cycle_type(p)
        if key in terms:
            frequency,connected,dim=terms[key]
            terms[key]=(frequency+1,connected,dim)
        else:
            terms[key]=(1,fixed_connected(p),q_cycles(p))
    numerator=sum(m*c*(1<<d) for m,c,d in terms.values())
    assert numerator%factorial(r)==0
    return terms,numerator//factorial(r)

def test():
    two,n2=count_ea(2)
    assert two[(1,1)]==(1,3,240)
    assert two[(2,)]==(1,1,120)
    assert n2==(3*(1<<240)+(1<<120))//2
    three,n3=count_ea(3)
    assert three[(1,1,1)]==(1,54,828)
    assert three[(2,1)]==(3,6,432)
    assert three[(3,)]==(2,3,276)
    assert n3==9*(1<<828)+3*(1<<432)+(1<<276)

if __name__=="__main__":
    test()
    for r in (2,3,4,5,6):
        t,v=count_ea(r)
        dr=t[(1,)*r][1]
        print("r",r,"connected_labeled",dr,"EA_count_bits",v.bit_length(),
              "EA_count_decimal_digits",len(str(v)))
        for k,(m,c,d) in sorted(t.items()):
            print("  cycle_type",k,"multiplicity",m,"connected_fixed",c,
                  "quadratic_fixed_dimension",d)
    print("SMALL_CHECKS_OK")
