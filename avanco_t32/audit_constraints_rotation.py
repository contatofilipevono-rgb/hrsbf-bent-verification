"""Independent algebraic controls for the complete quadratic-fiber clauses.

No imports from the search engine. Tests rotation on original ANFs, the
affine action on lifted coordinates, and radical balance versus complete
truth tables. Random controls are explicitly not an exhaustion of n=32.
"""
from itertools import combinations
from pathlib import Path
import json, random, time

def check(ok, message):
    if not ok:
        raise RuntimeError(message)

def rot(x,n):
    return ((x<<1)|(x>>(n-1))) & ((1<<n)-1)

def orbits(n):
    seen=set(); out=[]
    for triple in combinations(range(n),3):
        m=sum(1<<i for i in triple)
        if m in seen: continue
        orb=set(); t=m
        for _ in range(n):
            orb.add(t); t=rot(t,n)
        seen.update(orb); out.append(tuple(sorted(orb)))
    return out

def value(poly,x):
    return sum((x&m)==m for m in poly)&1

def lift(u,z,m=16):
    return u|((u^z)<<m)

def radical(rows,n):
    piv={}
    for a in rows:
        while a:
            p=a.bit_length()-1
            if p in piv: a^=piv[p]
            else: piv[p]=a; break
    basis=[]
    for j in range(n):
        if j in piv: continue
        r=1<<j
        for p,a in sorted(piv.items()):
            if (a&r).bit_count()&1: r^=1<<p
        check(all(not ((r&a).bit_count()&1) for a in rows), 'Bad radical')
        basis.append(r)
    check(len(basis)==n-len(piv),'Radical dimension')
    return basis

def reconstruct(poly,z,m=16):
    b=value(poly,lift(0,z,m))
    a=[value(poly,lift(1<<i,z,m))^b for i in range(m)]
    rows=[0]*m
    for i,j in combinations(range(m),2):
        v=value(poly,lift((1<<i)|(1<<j),z,m))^b^a[i]^a[j]
        if v: rows[i]|=1<<j; rows[j]|=1<<i
    return b,a,rows

def eval_q(b,a,rows,u):
    ans=b
    for i in range(len(rows)):
        if u>>i&1:
            ans^=a[i]
            ans^=(rows[i]&u&((1<<i)-1)).bit_count()&1
    return ans

def q_sign_sum(b,a,rows):
    u=0; q=b; result=1-2*q
    for k in range(1,1<<len(rows)):
        bit=(k&-k).bit_length()-1
        q^=a[bit]^((rows[bit]&u).bit_count()&1)
        u^=1<<bit; result+=1-2*q
    return result

def run():
    started=time.perf_counter(); rng=random.Random(20261004)
    orb=orbits(32)
    check(len(orb)==155,'Orbit count')
    # Exhaust all quotient directions for the exact affine coordinate action.
    for z in range(65536):
        u=(z*41341+17009)&65535
        up=rot(u,16)^((z>>15)&1)
        check(rot(lift(u,z),32)==lift(up,rot(z,16)), 'Affine rotation action')
    # A completely independent necklace construction by orbit removal.
    seen=set(); reps=[]
    for z in range(1,65536):
        if z in seen: continue
        rep=z; t=z
        for _ in range(16): seen.add(t); rep=min(rep,t); t=rot(t,16)
        reps.append(rep)
    check(len(reps)==4115 and len(seen)==65535,'Necklace exhaustion')
    for poly in orb:
        for _ in range(32):
            x=rng.getrandbits(32)
            check(value(poly,x)==value(poly,rot(x,32)), 'Original ANF rotation')
    cases=[]
    # Include a zero fiber and sparse/dense coefficients, all evaluated via
    # original monomials, rather than via a symbolic fiber expansion.
    specifications=[([],1),([0],1),([0],65535)]
    for k in (1,2,3,5,12,40,80):
        for _ in range(3):
            specifications.append((rng.sample(range(155),k),rng.randrange(1,65536)))
    for active,z in specifications:
        poly=[m for j in active for m in orb[j]]
        b,a,B=reconstruct(poly,z)
        basis=radical(B,16)
        check(len(basis)%2==0 and len(basis)>=2,'Alternating radical parity')
        check(all(not ((row&z).bit_count()&1) for row in B),'Direction not radical')
        check(eval_q(b,a,B,z)==b,'Half-turn value')
        vals=[eval_q(b,a,B,r)^b for r in basis]
        total=q_sign_sum(b,a,B)
        check((total==0)==any(vals),'Full truth-table balance versus radical OR')
        if not any(vals):
            check(total*total==(1<<(16+len(basis))),'Quadratic sign-sum square')
        for _ in range(24):
            u=rng.getrandbits(16)
            check(value(poly,lift(u,z))==eval_q(b,a,B,u),'Quadratic reconstruction')
        bp,ap,Bp=reconstruct(poly,rot(z,16))
        for r in basis:
            rp=rot(r,16)
            check(all(not ((row&rp).bit_count()&1) for row in Bp),'Rotated radical')
            check((eval_q(bp,ap,Bp,rp)^bp)==(eval_q(b,a,B,r)^b),'Rotated radical functional')
        cases.append({'active_orbits':len(active),'z':z,'radical_dimension':len(basis),'sign_sum':total,'balanced':any(vals)})
    result={'status':'passed','affine_action_directions_exhausted':65536,
            'nonzero_necklace_representatives':4115,'covered_nonzero_directions':65535,
            'original_generator_rotation_checks':155*32,
            'full_65536_point_quadratic_truth_tables':len(cases),
            'cases':cases,'seconds':round(time.perf_counter()-started,3),
            'scope':'Algebraic implementation controls; no exclusion of a 32-variable family asserted.'}
    Path(__file__).with_suffix('.json').write_text(json.dumps(result,indent=2),encoding='utf-8')
    print(json.dumps(result,indent=2))

if __name__=='__main__': run()
