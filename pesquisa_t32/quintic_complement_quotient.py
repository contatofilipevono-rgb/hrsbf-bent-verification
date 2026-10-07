#!/usr/bin/env python3
"""Exact all-coefficient quotient of the n=16 quintic complementary fiber."""
from collections import Counter
import hashlib,json,random
from pathlib import Path
import compressed_quintic_constraints as compressed
import audit_quintic_candidate_constraints as full


def quotient():
    orbits,reps,periods,profiles=compressed.build_basis()
    columns=[row[reps.index(255)] for row in profiles]
    echelon={}
    generators=[]
    coordinates=[]
    for original in columns:
        value=original
        coord=0
        for pivot,(row,tag) in sorted(echelon.items(),reverse=True):
            if (value>>pivot)&1:
                value^=row
                coord^=tag
        if value:
            tag=1<<len(generators)
            generators.append(value)
            echelon[value.bit_length()-1]=(value,tag)
            coord^=tag
        coordinates.append(coord)
    rank=len(generators)
    assert rank==12
    def decode(c):
        truth=0
        for i,g in enumerate(generators):
            if (c>>i)&1:
                truth^=g
        return truth
    assert all(decode(c)==original for c,original in zip(coordinates,columns))
    checks=[sum(1<<j for j,c in enumerate(coordinates) if (c>>i)&1) for i in range(rank)]
    words=[decode(c) for c in range(1<<rank)]
    assert len(set(words))==1<<rank
    histogram=Counter(w.bit_count() for w in words)
    balanced=[c for c,w in enumerate(words) if w.bit_count()==128]
    assert len(balanced)==1670
    # Independent direct full truth table evaluation of every orbit at z=255.
    tables=full.orbit_truth_tables(full.cyclic_orbits())
    direct=[]
    for truth in tables:
        direct.append(sum(((truth>>(u|((u^255)<<8)))&1)<<u for u in range(256)))
    assert direct==columns
    rng=random.Random(20261007)
    for _ in range(128):
        mask=rng.getrandbits(273)
        c=sum(((mask&p).bit_count()%2)<<i for i,p in enumerate(checks))
        raw=0
        for j,w in enumerate(direct):
            if (mask>>j)&1:
                raw^=w
        assert decode(c)==raw
    # Rank of coefficient parity map, independently eliminated.
    rows={}
    for p in checks:
        v=p
        while v:
            pivot=v.bit_length()-1
            if pivot in rows:
                v^=rows[pivot]
            else:
                rows[pivot]=v
                break
    assert len(rows)==rank
    root=Path(__file__).parent
    return {'status':'PASS','n':16,'homogeneous_degree':5,'coefficient_dimension':273,
        'fiber_z':'0xff','fiber_truth_length':256,'quotient_rank':rank,'kernel_dimension':273-rank,
        'parity_check_masks_hex':[hex(p) for p in checks],
        'quotient_truth_generators_hex':[hex(w) for w in generators],
        'balanced_quotient_coordinates_hex':[hex(c) for c in balanced],
        'weight_histogram':dict(sorted(histogram.items())),
        'balanced_quotient_count':len(balanced),'total_quotient_count':1<<rank,
        'necessary_filter_pass_fraction':len(balanced)/(1<<rank),
        'necessary_filter_candidate_count_exact':str(len(balanced)*(1<<(273-rank))),
        'independent_orbit_fiber_checks':273,'independent_random_coefficient_checks':128,
        'source_sha256':{p:hashlib.sha256((root/p).read_bytes()).hexdigest() for p in
            ['quintic_complement_quotient.py','compressed_quintic_constraints.py','audit_quintic_candidate_constraints.py']},
        'scope':'Exact characterization of balance on one complementary fiber for all 2^273 coefficients. Necessary only for bentness; no global nonexistence or novelty claim.'}


if __name__=='__main__':
    report=quotient()
    Path(__file__).with_name('quintic_complement_quotient_2026-10-07.json').write_text(json.dumps(report,indent=2)+'\n')
    print(json.dumps({k:v for k,v in report.items() if k not in ['parity_check_masks_hex','quotient_truth_generators_hex','balanced_quotient_coordinates_hex']},indent=2))
