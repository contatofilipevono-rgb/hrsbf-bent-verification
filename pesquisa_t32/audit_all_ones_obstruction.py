"""Independent all-ones derivative certificate; Python standard library only.

Regenerates cubic orbits and all matrices directly from monomials. No SAT,
production tensor, or previously computed matrix is imported.
"""
import argparse
import itertools
import json
from pathlib import Path

def orbits(n, degree):
    unseen = {tuple(c) for c in itertools.combinations(range(n), degree)}
    result = []
    while unseen:
        s = min(unseen)
        orbit = {tuple(sorted((i+t) % n for i in s)) for t in range(n)}
        unseen.difference_update(orbit)
        result.append((min(orbit), sorted(orbit)))
    return sorted(result)

def polar(n, monomials):
    rows = [0]*n
    for support in monomials:
        for i,j in itertools.combinations(support, 2):
            rows[i] ^= 1 << j
            rows[j] ^= 1 << i
    return rows

def rank_radical(rows):
    n=len(rows); a=list(rows); piv=[]
    for c in range(n):
        p=next((i for i in range(len(piv),n) if a[i] >> c & 1),None)
        if p is None: continue
        k=len(piv); a[k],a[p]=a[p],a[k]
        for i in range(n):
            if i != k and a[i] >> c & 1: a[i] ^= a[k]
        piv.append(c)
    rad=[]
    for c in range(n):
        if c in piv: continue
        r=1<<c
        for row,p in zip(a,piv):
            if row >> c & 1: r |= 1<<p
        rad.append(r)
    return len(piv),rad

def truth_sum(n, terms, linear=0):
    masks=[sum(1<<i for i in t) for t in terms]
    return sum((-1)**((sum((x&m)==m for m in masks)+linear*x.bit_count())%2)
               for x in range(1<<n))

def quadratic_controls(n):
    oo=orbits(n,2); checked=0
    for c in range(1<<len(oo)):
        terms=[t for j,(_,orb) in enumerate(oo) if c>>j&1 for t in orb]
        rows=polar(n,terms); rank,rad=rank_radical(rows)
        masks=[sum(1<<i for i in t) for t in terms]
        for linear in (0,1):
            balanced=any((sum((r&m)==m for m in masks)+linear*r.bit_count())%2 for r in rad)
            assert not (rank and balanced), (n,c,linear)
            if n<=8:
                assert (truth_sum(n,terms,linear)==0)==balanced
            checked+=2  # both constants; a constant only reverses the sum
    return {'n':n,'all_invariant_quadratics_including_affine_terms':checked,'status':'PASS'}

def audit(families):
    o16=orbits(16,3); o32=orbits(32,3)
    assert (len(o16),len(o32))==(35,155)
    idx={t:i for i,(_,orb) in enumerate(o16) for t in orb}
    b16=[polar(16,orb) for _,orb in o16]
    targets=[]; groups=[[] for _ in o16]
    for j,(support,orb) in enumerate(o32):
        reduced=tuple(sorted({i%16 for i in support}))
        target=idx.get(reduced); targets.append(target)
        if target is not None: groups[target].append(j)
        full=polar(32,orb)
        cross=[((full[i]^full[i+16])>>16)&65535 for i in range(16)]
        assert cross == ([0]*16 if target is None else b16[target]), j
    assert all(len(g)==4 for g in groups)
    assert targets.count(None)==15
    records=[]
    for htext in sorted(set(families),key=lambda s:int(s,16)):
        h=int(htext,16); assert h.bit_count()==3
        rows=[0]*16
        for k in range(35):
            if h>>k&1:
                rows=[a^b for a,b in zip(rows,b16[k])]
        rank,_=rank_radical(rows); assert rank>0
        i,j=next((i,j) for i in range(16) for j in range(i+1,16) if rows[i]>>j&1)
        hform=sum(1<<k for k in range(35) if b16[k][i]>>j&1)
        cform=sum(1<<k for k,t in enumerate(targets) if t is not None and hform>>t&1)
        assert (h&hform).bit_count()%2==1
        records.append({'h':htext,'polar_rank':rank,'witness_entry':[i,j],
                        'h_linear_form':hex(hform),'original_155_linear_form':hex(cform),
                        'rows16':[hex(r) for r in rows],
                        'status':'EXCLUDED_BY_ALL_ONES_DERIVATIVE'})
    # Essential boundary and positive controls, checked directly from truth tables.
    assert truth_sum(8,[],1)==0
    n6=sorted({tuple(sorted((i,(i+2)%6))) for i in range(6)})
    assert rank_radical(polar(6,n6))[0]>0 and truth_sum(6,n6)==0
    controls=[quadratic_controls(n) for n in (4,8,16,32)]
    return {'scope':'Fixed-H weight-three families only; not all cubic HRSBF in 32 variables',
            'cubic_basis_cross_identities_verified':155,
            'basis16':[list(s) for s,_ in o16], 'basis32':[list(s) for s,_ in o32],
            'quadratic_exhaustive_controls':controls,
            'non_power_of_two_balanced_quadratic_control':{'n':6,'status':'PASS'},
            'excluded_family_count':len(records),'families':records}

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('input');p.add_argument('output');args=p.parse_args()
    source=json.loads(Path(args.input).read_text())
    families=[h for group in source for h in group['members']]
    result=audit(families)
    Path(args.output).write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps({k:result[k] for k in ('cubic_basis_cross_identities_verified','excluded_family_count','quadratic_exhaustive_controls')}))
