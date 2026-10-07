#!/usr/bin/env python3
"""Exact exterior-square certificate for the quartic base block."""
import itertools, json
from collections import Counter
from pathlib import Path
N=8
QUARTIC_SEEDS=[(0,1,2,3),(0,1,2,5),(0,1,3,5)]
PAIRS=list(itertools.combinations(range(N),2))
def quartic_terms():
    terms=set()
    for seed in QUARTIC_SEEDS:
        orb={tuple(sorted((i+k)%N for i in seed)) for k in range(N)}
        terms.symmetric_difference_update(orb)
    return terms
def gf2_rref(rows,ncols):
    rows=rows[:]; r=0; piv=[]
    for c in range(ncols):
        p=next((i for i in range(r,len(rows)) if (rows[i]>>c)&1),None)
        if p is None: continue
        rows[r],rows[p]=rows[p],rows[r]
        for i in range(len(rows)):
            if i!=r and ((rows[i]>>c)&1): rows[i]^=rows[r]
        piv.append(c); r+=1
    return rows,piv
def rank_rows(rows,ncols): return len(gf2_rref(rows,ncols)[1])
def nullspace(rows,ncols):
    rr,piv=gf2_rref(rows,ncols); free=[c for c in range(ncols) if c not in piv]; basis=[]
    for f in free:
        x=1<<f
        for i,c in enumerate(piv):
            if (rr[i]>>f)&1: x|=1<<c
        basis.append(x)
    return basis
def alt_rank(v):
    rows=[0]*N
    for k,(i,j) in enumerate(PAIRS):
        if (v>>k)&1: rows[i]|=1<<j; rows[j]|=1<<i
    return rank_rows(rows,N)
def main():
    terms=quartic_terms(); rows=[]
    for i,j in PAIRS:
        row=0
        for q,(k,l) in enumerate(PAIRS):
            if len({i,j,k,l})==4 and tuple(sorted((i,j,k,l))) in terms: row|=1<<q
        rows.append(row)
    rank=rank_rows(rows,28); ker=nullspace(rows,28); spectrum=Counter()
    for mask in range(1,1<<len(ker)):
        v=0
        for i,b in enumerate(ker):
            if (mask>>i)&1: v^=b
        spectrum[alt_rank(v)]+=1
    assert rank==22 and len(ker)==6
    assert spectrum==Counter({8:60,4:3})
    assert spectrum[2]==0
    out={"status":"PASS","ambient_dimension":8,"lambda2_dimension":28,"phi_rank":rank,
      "phi_kernel_dimension":len(ker),"nonzero_kernel_elements":(1<<len(ker))-1,
      "alternating_rank_spectrum_nonzero_kernel":dict(sorted(spectrum.items())),"rank2_kernel_elements":0,
      "conclusion":"ker(Phi) contains no nonzero decomposable 2-vector; hence T(a,b,.,.)=0 implies a,b dependent.",
      "implication":"For the full quartic Boolean function, constant D_a D_b f with independent a,b is impossible, so relaxed linearity index = 1."}
    Path(__file__).with_name("quartic_exterior_square_certificate.json").write_text(json.dumps(out,indent=2)+"\n")
    print(json.dumps(out,indent=2))
if __name__=="__main__": main()
