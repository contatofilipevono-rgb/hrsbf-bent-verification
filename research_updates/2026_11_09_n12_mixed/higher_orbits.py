"""Transport fixed quintic and sextic slices by cyclic affine normalizers."""
import json
from collections import Counter
from pathlib import Path

import numpy as np

from antipodal_mm import affine_deviation
from higher_filter import N, SIZE, evaluate_orbit, xor_terms
from higher_project import LOW, TOP, UPPER, dual_quartic, high_mask, signs_to_walsh, su_table
from mobius_rule import integer_anf
from quartic_catalog import linear_generators
from top_filters import active_bits

DIR=Path(__file__).parent


def high_actions():
    x=np.arange(SIZE,dtype=np.uint16)
    value=np.zeros((len(UPPER),SIZE),dtype=np.uint8)
    for i,(_,o) in enumerate(UPPER):
        for m in o:
            value[i]^=(x&m)==m
    points=[]
    for rows in linear_generators():
        indices=np.zeros(SIZE,dtype=np.uint16)
        for j,row in enumerate(rows):
            parity=np.zeros(SIZE,dtype=np.uint16)
            for k in active_bits(row):
                parity^=(x>>k)&1
            indices |= parity<<j
        assert len(np.unique(indices))==SIZE
        points.append(indices)
    points.append(x^(SIZE-1))
    operators=[]
    for indices in points:
        a=value[:,indices].copy()
        for j in range(N):
            b=a.reshape(len(UPPER),-1,2,1<<j)
            b[:,:,1,:]^=b[:,:,0,:]
        for rep,orbit in UPPER:
            assert np.all(a[:,list(orbit)]==a[:,rep,None])
        operators.append([sum(int(a[i,rep])<<j for j,(rep,_) in enumerate(UPPER))
                          for i in range(len(UPPER))])
    return operators


def orbit(start, operators):
    found={start}
    queue=[start]
    for v in queue:
        for op in operators:
            w=xor_terms(op,v)
            if w not in found:
                found.add(w)
                queue.append(w)
    assert 1024%len(found)==0
    return found


def describe_example(label, high, top, low, table, dual, degree):
    directions=[(1<<i)|(1<<(i+6)) for i in range(6)]
    witness=None
    for i,a in enumerate(directions):
        for b in directions[i+1:]:
            for x in range(SIZE):
                if ((table>>x)^(table>>(x^a))^(table>>(x^b))^(table>>(x^a^b)))&1:
                    witness=[x,a,b]
                    break
            if witness: break
        if witness: break
    assert witness is not None
    d_anf=integer_anf(dual)
    return {"source":label,"high_mask":hex(high),"quartic_mask":top,"lower_mask":low,
            "degree_of_dual":degree,"second_derivative_on_diagonal":witness,
            "dual_leading_sanf_supports":[m for m,_ in UPPER if m.bit_count()==degree and d_anf[m]%2]}


def main():
    ops=high_actions()
    truth_low=[evaluate_orbit(o) for _,o in LOW]
    truth_top=[evaluate_orbit(o) for _,o in TOP]
    truth_high=[evaluate_orbit(o) for _,o in UPPER]
    result={}
    for label,ref in (("dual5",dual_quartic(13896404,1065441)),("su6",su_table())):
        high=high_mask(ref)
        size=len(orbit(high,ops))
        source=xor_terms(truth_high,high)
        counts=Counter()
        witnesses={}
        for row in (DIR/f"{label}-bent.tsv").read_text().splitlines():
            top,low=map(int,row.split())
            table=source^xor_terms(truth_top,top)^xor_terms(truth_low,low)
            assert all(((table>>x)^(table>>(((x<<1)|(x>>11))&(SIZE-1))))&1==0 for x in range(SIZE))
            w=signs_to_walsh(table)
            assert all(abs(v)==64 for v in w)
            dual=sum(int(v<0)<<i for i,v in enumerate(w))
            c=integer_anf(dual)
            degree=max(i.bit_count() for i,a in enumerate(c) if a%2)
            assert affine_deviation(table) and affine_deviation(dual)
            counts[degree]+=1
            if degree not in witnesses:
                witnesses[degree]=describe_example(label,high,top,low,table,dual,degree)
        result[label]={"high_part":hex(high),"high_orbit_size":size,
                       "normalized_completions_by_dual_degree":dict(counts),
                       "affine_normalizer_family_by_dual_degree":{d:4*size*c for d,c in counts.items()},
                       "witnesses":witnesses}
    (DIR/"fixed-high-orbits.json").write_text(json.dumps(result,indent=2)+"\n")
    for label,row in result.items():
        print(label,{k:v for k,v in row.items() if k!="witnesses"})


if __name__=="__main__":
    main()
