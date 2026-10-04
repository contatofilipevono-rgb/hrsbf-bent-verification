"""Verify the stored sparse quotient classes against the original cubic ANFs.

Run verificar_7_fibras.py first. This checker repeats that independent audit,
then rebuilds the original-orbit polar templates and checks every stored
contradiction. Search and verification implementations are separate.
"""
from pathlib import Path
from collections import Counter
from functools import lru_cache
import json,time,hashlib,sys
BASE=Path(__file__).resolve().parent
if str(BASE) not in sys.path:
    sys.path.insert(0, str(BASE))
import verificar_7_fibras as a

def main():
    started=time.perf_counter()
    a.run()
    orbs=a.cyclic_orbits(32);small=a.cyclic_orbits(16)
    lookup={mon:j for j,o in enumerate(small) for mon in o}
    polys=[a.masks(o) for o in orbs]
    hrows=[0]*35;representatives={}
    for j,o in enumerate(orbs):
        mon=tuple(sorted({i%16 for i in o[0]}))
        if len(mon)==3:
            k=lookup[mon];hrows[k]|=1<<j
            if k not in representatives:representatives[k]=polys[j]
    # a.run has already checked all four lifts share these templates.
    templates=[[a.direct_polar(representatives[j],1<<k) for k in range(16)] for j in range(35)]
    @lru_cache(None)
    def values(x):
        return sum(a.evaluate(poly,x)<<j for j,poly in enumerate(polys))
    def matrices(h):
        result=[[0]*16 for _ in range(16)]
        for j in range(35):
            if h>>j&1:
                for k in range(16):
                    for i in range(16):result[k][i]^=templates[j][k][i]
        return result
    def polar(mats,z):
        result=[0]*16
        for k in range(16):
            if z>>k&1:
                for i in range(16):result[i]^=mats[k][i]
        return result
    inp=BASE/'exploracao_631_classes.json'
    data=json.loads(inp.read_text(encoding='utf-8'))
    all_h=[int(c['h'],16) for c in data['results']]
    expected={0}|{1<<i for i in range(35)}|{(1<<i)|(1<<j) for i in range(35) for j in range(i+1,35)}
    a.check(len(all_h)==631 and set(all_h)==expected,'Incomplete coverage or duplicate H')
    counts=Counter();equations=0;remaining=[]
    for c in data['results']:
        h=int(c['h'],16);mats=matrices(h)
        if c['type']=='not_excluded':
            remaining.append(c['h']);continue
        if c['type']=='constant_ones_fiber':
            a.check(not any(polar(mats,65535)),'Claimed constant fiber has nonzero polar')
            counts[c['type']]+=1;continue
        a.check(c['type']=='linear_contradiction','Unknown certificate type')
        row_sum=rhs_sum=0
        for eq in c['equations']:
            row=int(eq['row'],16);rhs=eq['rhs']
            if eq['kind']=='h':
                j=eq['index']
                a.check(row==hrows[j] and rhs==(h>>j&1),'Wrong quotient equation')
            else:
                a.check(eq['kind']=='fiber','Unknown equation')
                z,r=eq['z'],eq['r'];B=polar(mats,z)
                a.check(z!=0 and r not in (0,z),'Dependent radical vectors')
                a.check(a.rank(B)==14,'Polar rank is not 14')
                a.check(all((line&z).bit_count()%2==0 and (line&r).bit_count()%2==0 for line in B),'Wrong radical')
                direct=values(a.lift(r,z))^values(a.lift(0,z))
                a.check(row==direct and rhs==1,'Wrong original-ANF evaluation equation')
            row_sum^=row;rhs_sum^=rhs;equations+=1
        a.check(row_sum==0 and rhs_sum==1,'No XOR contradiction')
        counts[c['type']]+=1
    result={'status':'verified','certificate_sha256':hashlib.sha256(inp.read_bytes()).hexdigest(),
            'quotient_classes':631,'excluded':sum(counts.values()),'excluded_by_type':dict(counts),
            'not_excluded_by_this_search':remaining,'verified_equations':equations,
            'family_dimension_per_quotient':120,
            'seconds':round(time.perf_counter()-started,3),
            'scope':'Quotient patterns of weight <=2 only. Sparse quotient does NOT mean sparse original function. Remaining is not an existence claim.'}
    (BASE/'resultado_631_classes.json').write_text(json.dumps(result,indent=2),encoding='utf-8')
    print(json.dumps(result,indent=2))

if __name__=='__main__':main()
