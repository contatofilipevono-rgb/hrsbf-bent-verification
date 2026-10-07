#!/usr/bin/env python3
"""Exact EA-invariant separation of F1 from Su's n=8 maximal-degree RS bent function."""
from collections import Counter
import json
from pathlib import Path

SEEDS=[(0,1),(0,1,2,3),(0,1,2,5),(0,1,3,5)]
def orbit_terms():
    terms=set()
    for seed in SEEDS:
        terms.symmetric_difference_update({sum(1<<((i+k)%8) for i in seed) for k in range(8)})
    return sorted(terms)
def f1(x):
    return sum((x&t)==t for t in orbit_terms())&1
def su8(x):
    b=[(x>>i)&1 for i in range(8)]
    v=0
    for i in range(4): v ^= b[i]&b[i+4]
    for i in range(8):
        v ^= b[i]&b[(i+1)%8]&b[(i+2)%8]&(b[(i+4)%8]^1)
    return v
def anf_degree(tt):
    a=tt[:]
    for i in range(8):
        for m in range(256):
            if m&(1<<i): a[m]^=a[m^(1<<i)]
    return max((m.bit_count() for m,v in enumerate(a) if v),default=-1)
def spectrum(fn):
    tt=[fn(x) for x in range(256)]
    C=Counter()
    zero=constant=0
    for a in range(1,256):
        for b in range(a+1,256):
            d=[tt[x]^tt[x^a]^tt[x^b]^tt[x^a^b] for x in range(256)]
            deg=anf_degree(d); wt=sum(d)
            C[(deg,wt)]+=1
            if wt==0: zero+=1
            if wt in (0,256): constant+=1
    return C,zero,constant
def main():
    cf,zf,kf=spectrum(f1); cs,zs,ks=spectrum(su8)
    assert zf==zs==0 and kf==ks==0
    assert cf != cs
    out={
      "status":"PASS",
      "invariant":"multiset over unordered independent (a,b) of (algebraic_degree(D_aD_b f), Hamming_weight(D_aD_b f))",
      "F1":{str(k):v for k,v in sorted(cf.items())},
      "Su8":{str(k):v for k,v in sorted(cs.items())},
      "F1_zero_pairs":zf,"Su8_zero_pairs":zs,
      "conclusion":"F1 and Su n=8 are not EA-equivalent because their second-derivative spectra differ."
    }
    Path(__file__).with_name("su8_inequivalence_certificate.json").write_text(json.dumps(out,indent=2)+"\n")
    print(json.dumps(out,indent=2))
if __name__=="__main__": main()
