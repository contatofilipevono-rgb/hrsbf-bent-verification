#!/usr/bin/env python3
"""Exact independent finite controls. These do not replace the paper's uniform proof."""
import argparse, hashlib, itertools, json, pathlib, time

def need(p, msg):
    if not p: raise RuntimeError(msg)

def rref(rows, n):
    a=[r for r in rows if r]; piv=[]; k=0
    for j in range(n):
        hit=next((i for i in range(k,len(a)) if (a[i]>>j)&1),None)
        if hit is None: continue
        a[k],a[hit]=a[hit],a[k]
        for i in range(len(a)):
            if i!=k and ((a[i]>>j)&1): a[i]^=a[k]
        piv.append(j);k+=1
        if k==len(a):break
    return tuple(a[:k]),piv

def radical(rows,n):
    rr,piv=rref(rows,n); out=[]; ps=set(piv)
    for f in range(n):
        if f in ps:continue
        v=1<<f
        for row,p in zip(rr,piv):
            if (row>>f)&1:v|=1<<p
        out.append(v)
    return out

def rotate(x,d,n):
    mask=(1<<n)-1
    return ((x<<d)|(x>>(n-d)))&mask

def qeval(c,x,n):
    h=n//2;v=0
    for d in range(1,h):
        if (c>>(d-1))&1:v^=(x&rotate(x,d,n)).bit_count()&1
    if (c>>(h-1))&1:v^=((x&((1<<h)-1))&(x>>h)).bit_count()&1
    return v

def quadratic_control(n):
    h=n//2; generators=[]
    for d in range(1,h+1):
        rows=[0]*n
        for i in range(n if d<h else h):
            j=(i+d)%n;rows[i]^=1<<j;rows[j]^=1<<i
        generators.append(rows)
    rows=[0]*n; old=0;rank_hist={}; balanced=0
    for k in range(1<<h):
        c=k^(k>>1)
        if k:
            idx=(c^old).bit_length()-1
            rows=[a^b for a,b in zip(rows,generators[idx])]
        old=c
        rad=radical(rows,n)
        for v in rad:
            need(all((r&v).bit_count()%2==0 for r in rows),'invalid radical vector')
        rank=n-len(rad);rank_hist[str(rank)]=rank_hist.get(str(rank),0)+1
        for linear in (0,1):
            is_balanced=any(qeval(c,v,n)^(linear*(v.bit_count()&1)) for v in rad)
            if is_balanced:
                balanced+=1;need(rank==0,'balanced RS quadratic with nonzero polar')
    need(balanced==1,'unexpected normalized balanced count')
    return {'n':n,'quadratic_parts':1<<h,'quadratic_and_linear_parts':1<<(h+1),
            'constant_term':'both values follow without changing balance',
            'balanced_normalized_functions':balanced,'balanced_with_nonzero_polar':0,'rank_histogram':rank_hist}

def orbits(n):
    remaining=set(itertools.combinations(range(n),3));out=[]
    while remaining:
        t=min(remaining)
        orb={tuple(sorted((i+s)%n for i in t)) for s in range(n)}
        remaining-=orb;out.append(sorted(orb))
    return out

def fiber_poly(orb,h,complement):
    # Masks encode squarefree monomials in u after substituting x=(u,u+z), z=0 or 1.
    poly=set()
    for triple in orb:
        terms={0}
        for index in triple:
            mask=1<<(index%h);new=set()
            for t in terms:
                v=t|mask
                if v in new:new.remove(v)
                else:new.add(v)
                if complement and index>=h:
                    if t in new:new.remove(t)
                    else:new.add(t)
            terms=new
        poly^=terms
    return poly

def fiber_control(n):
    h=n//2;obs=orbits(n); polar_rows=[0]*(h*h);nonconst={};zero_diagonal=0; tensor_checks=0
    for r,orb in enumerate(obs):
        need(len(orb)==n,'unexpected short cubic orbit at a power of two')
        diag=fiber_poly(orb,h,False);need(not diag,'nonzero diagonal');zero_diagonal+=1
        f=fiber_poly(orb,h,True);need(all(m.bit_count()<=2 for m in f),'fiber degree exceeds two')
        bd=[0]*n
        for triple in orb:
            for a,b in itertools.combinations(triple,2):bd[a]^=1<<b;bd[b]^=1<<a
        for u in range(h):
            for v in range(h):
                lhs=((bd[u]>>(v+h))^(bd[u+h]>>(v+h)))&1
                rhs=int(u!=v and ((1<<u)|(1<<v)) in f)
                need(lhs==rhs,'trilinear contraction mismatch')
                tensor_checks+=1
                if rhs:polar_rows[u*h+v]|=1<<r
        for m in f:
            if m:nonconst[m]=nonconst.get(m,0)^(1<<r)
    rb,pb=rref(polar_rows,len(obs));rf,pf=rref(nonconst.values(),len(obs))
    need(rb==rf and pb==pf,'polar kernel differs from nonconstant fiber kernel')
    return {'n':n,'cubic_orbits':len(obs),'zero_diagonal_orbits':zero_diagonal,
            'trilinear_basis_checks':tensor_checks,'polar_rank':len(rb),'nonconstant_rank':len(rf),
            'kernel_dimension':len(obs)-len(rb),'exact_rowspace_equality':True,'pivots':pb,
            'scope':'all coefficient combinations by linearity; balanced-derivative and fiber-balance implications are algebraic lemmas in the paper'}

def folding_controls():
    counts={}
    for n in (6,10,12,18,20,24,30,40,48,64,96):
        t=n&-n;m=n//t
        if m%2!=1:continue
        tested=0
        for degree in (1,2,3):
            remaining=set(itertools.combinations(range(n),degree))
            while remaining:
                a=min(remaining);orbit={tuple(sorted((i+s)%n for i in a))for s in range(n)};remaining-=orbit
                folded=set()
                for mon in orbit:
                    term=tuple(sorted({i%t for i in mon}))
                    if term in folded:folded.remove(term)
                    else:folded.add(term)
                source_antipodal=(degree==2 and len(orbit)==n//2)
                target=tuple((0,t//2))
                need((target in folded)==source_antipodal,'antipodal coefficient transport failure')
                tested+=1
        counts[str(n)]={'t':t,'odd_factor':m,'orbits_tested':tested}
    return counts

def main():
    p=argparse.ArgumentParser();p.add_argument('--output',type=pathlib.Path,default=pathlib.Path('structural_results.json'));a=p.parse_args()
    start=time.monotonic();result={'method':'independent exact GF(2) bit arithmetic; no numerical floating point',
       'quadratic_rigidity':[quadratic_control(n) for n in (4,8,16,32)],
       'complementary_fiber':[fiber_control(n) for n in (8,16,32)],
       'folding':folding_controls()}
    result['elapsed_seconds']=round(time.monotonic()-start,3)
    result['script_sha256']=hashlib.sha256(pathlib.Path(__file__).read_bytes()).hexdigest()
    result['passed']=True;a.output.write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result,indent=2))
if __name__=='__main__':main()
