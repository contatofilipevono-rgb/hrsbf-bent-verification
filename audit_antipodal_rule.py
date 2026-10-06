#!/usr/bin/env python3
"""Independent exhaustive falsification test for the Antipodal Rule.

For N=4 and N=8, build the complete vector space of rotation-symmetric
Boolean functions of algebraic degree <=3 (including constant), enumerate
every function, compute its full Walsh spectrum, and test:

    bent => antipodal quadratic orbit P_N is present.

No proof lemma and no existing project validator is imported.
"""

from itertools import combinations

def rotate_mask(mask, N, k=1):
    out=0
    for i in range(N):
        if (mask>>i)&1:
            out |= 1 << ((i+k)%N)
    return out

def orbit(mask,N):
    return tuple(sorted({rotate_mask(mask,N,k) for k in range(N)}))

def generators(N):
    seen=set(); gs=[("1",(0,))]
    for d in (1,2,3):
        for C in combinations(range(N),d):
            m=sum(1<<i for i in C)
            O=orbit(m,N)
            if O in seen: continue
            seen.add(O)
            gs.append((f"deg{d}:{C}",O))
    return gs

def orbit_value(O,x):
    if O==(0,): return 1
    v=0
    for m in O:
        v ^= int((x&m)==m)
    return v

def fwht(a):
    a=a[:]; h=1
    while h<len(a):
        for i in range(0,len(a),2*h):
            for j in range(i,i+h):
                x,y=a[j],a[j+h]
                a[j],a[j+h]=x+y,x-y
        h*=2
    return a

def audit(N):
    gs=generators(N)
    antip=orbit((1<<0)|(1<<(N//2)),N)
    antip_idx=next(i for i,(_,O) in enumerate(gs) if O==antip)
    tables=[]
    for _,O in gs:
        tables.append([orbit_value(O,x) for x in range(1<<N)])
    bent=bad=0
    for coeff in range(1<<len(gs)):
        signs=[]
        for x in range(1<<N):
            v=0
            for j,T in enumerate(tables):
                if (coeff>>j)&1: v ^= T[x]
            signs.append(1 if v==0 else -1)
        W=fwht(signs)
        target=1<<(N//2)
        if all(abs(z)==target for z in W):
            bent += 1
            if not ((coeff>>antip_idx)&1):
                bad += 1
                raise AssertionError(("counterexample",N,coeff))
    return len(gs),antip_idx,bent,bad

def main():
    for N in (4,8):
        g,a,b,bad=audit(N)
        print(f"N={N}: generators={g}, antipodal_index={a}, bent={b}, violations={bad}, PASS")
    print("NO ANTIPODAL-RULE COUNTEREXAMPLE IN THE COMPLETE N=4,8 SPACES")

if __name__=="__main__":
    main()
