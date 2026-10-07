#!/usr/bin/env python3
"""Independent exact certificate of a quartic RS bent function without P_8."""
import hashlib,itertools,json
from collections import Counter
from pathlib import Path

SEEDS=[(0,1),(0,1,2,3),(0,1,2,5),(0,1,3,5)]

def orbit_terms(n,seeds):
    terms=set()
    for seed in seeds:
        orb={sum(1<<((i+k)%n) for i in seed) for k in range(n)}
        terms.symmetric_difference_update(orb)
    return sorted(terms)

def evaluate(x,terms):
    return sum((x&t)==t for t in terms)%2

def direct_walsh(truth):
    return [sum(1-2*(v^((a&x).bit_count()%2)) for x,v in enumerate(truth)) for a in range(len(truth))]

def mobius(truth):
    a=truth.copy();n=(len(a)-1).bit_length()
    for i in range(n):
        for mask in range(len(a)):
            if mask&(1<<i):a[mask]^=a[mask^(1<<i)]
    return [i for i,v in enumerate(a) if v]

def fast_walsh(truth):
    w=[1-2*v for v in truth];h=1
    while h<len(w):
        for low in range(0,len(w),2*h):
            for j in range(h):
                a,b=w[low+j],w[low+j+h]
                w[low+j],w[low+j+h]=a+b,a-b
        h*=2
    return w

def run():
    terms=orbit_terms(8,SEEDS);truth=[evaluate(x,terms) for x in range(256)]
    w=direct_walsh(truth)
    assert all(abs(v)==16 for v in w)
    assert w==fast_walsh(truth)
    assert all(truth[x]==truth[((x<<1)|(x>>7))&255] for x in range(256))
    recovered=mobius(truth)
    assert terms==recovered
    antip=[(1<<i)|(1<<(i+4)) for i in range(4)]
    assert not set(antip)&set(recovered)
    assert max(t.bit_count() for t in recovered)==4
    lift=[]
    # An independent full 16-variable check of interleaved direct sum (r=2).
    n=16;r=2
    lifted_terms=orbit_terms(n,[tuple(r*i for i in seed) for seed in SEEDS])
    tt=[]
    for x in range(1<<n):
        blocks=[sum(((x>>(j+r*k))&1)<<k for k in range(8)) for j in range(r)]
        v=truth[blocks[0]]^truth[blocks[1]]
        assert v==evaluate(x,lifted_terms)
        tt.append(v)
    assert all(abs(v)==256 for v in fast_walsh(tt))
    assert not any(((1<<i)|(1<<(i+8))) in lifted_terms for i in range(8))
    lift.append({'n':16,'full_truth_points':65536,'walsh_abs':256,'orbit_formula_matches':True})
    return {'status':'PASS','n':8,'seeds_zero_based':SEEDS,'orbit_sizes':[len(orbit_terms(8,[s])) for s in SEEDS],
        'anf_term_masks':terms,'anf_degree_counts':dict(sorted(Counter(t.bit_count() for t in terms).items())),
        'truth_table_bits_in_increasing_x_order':''.join(map(str,truth)),
        'walsh_coefficients_in_increasing_a_order':w,'walsh_histogram':dict(Counter(w)),
        'antipodal_coefficient':0,'rotation_invariance_all_inputs':True,
        'independent_mobius_anf_match':True,'lift_controls':lift,
        'source_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        'scope':'Explicit degree-4 nonhomogeneous example and finite certificate. General 8r extension follows by interleaved direct sum as proved in accompanying note. No novelty claim.'}

if __name__=='__main__':
    data=run();Path(__file__).with_name('quartic_boundary_certificate.json').write_text(json.dumps(data,indent=2)+'\n')
    print(json.dumps({k:v for k,v in data.items() if k not in ['truth_table_bits_in_increasing_x_order','walsh_coefficients_in_increasing_a_order','anf_term_masks']},indent=2))
