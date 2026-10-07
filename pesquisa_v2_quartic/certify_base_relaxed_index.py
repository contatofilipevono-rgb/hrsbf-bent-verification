#!/usr/bin/env python3
"""Exact certificate that the 8-variable quartic block has relaxed linearity index 1."""
import hashlib, json
from pathlib import Path

SEEDS=[(0,1),(0,1,2,3),(0,1,2,5),(0,1,3,5)]

def orbit_terms():
    terms=set()
    for seed in SEEDS:
        orb={sum(1<<((i+k)%8) for i in seed) for k in range(8)}
        terms.symmetric_difference_update(orb)
    return sorted(terms)

def eval_anf(x,terms):
    return sum((x&t)==t for t in terms)&1

def main():
    terms=orbit_terms()
    truth=[eval_anf(x,terms) for x in range(256)]
    tested=0
    constant_pairs=[]
    for a in range(1,256):
        for b in range(a+1,256):
            # Over F2, distinct nonzero vectors are automatically independent.
            tested+=1
            vals={truth[x]^truth[x^a]^truth[x^b]^truth[x^a^b] for x in range(256)}
            if len(vals)==1:
                constant_pairs.append([a,b,next(iter(vals))])
    assert tested == 255*254//2
    assert constant_pairs == []
    result={
        "status":"PASS",
        "dimension":8,
        "independent_unordered_pairs_tested":tested,
        "evaluation_points_per_pair":256,
        "constant_second_derivative_pairs":constant_pairs,
        "relaxed_linearity_index":1,
        "ordinary_linearity_index":1,
        "reason":"No independent pair has constant second derivative; every 1D subspace is an M-subspace because D_a D_a f=0.",
        "scope":"Finite exact certificate for the 8-variable base block. The all-r upper bound uses the published direct-sum inequality for relaxed linearity index.",
        "source_sha256":hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
    }
    out=Path(__file__).with_name("base_relaxed_index_certificate.json")
    out.write_text(json.dumps(result,indent=2)+"\n")
    print(json.dumps(result,indent=2))

if __name__=="__main__":
    main()
