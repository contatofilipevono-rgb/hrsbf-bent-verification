"""Project the exact mod-four union equations at a fixed degree-five/six part."""

from itertools import combinations

from higher_filter import N, SIZE, evaluate_orbit, orbits, pack, shift, xor_terms
from mobius_rule import integer_anf

LOW = tuple((m,o) for d in (2,3) for m,o in orbits(N,d))
TOP = tuple(orbits(N,4))
UPPER = tuple((m,o) for d in (5,6) for m,o in orbits(N,d))
EQ = tuple(m for d in range(8,13) for m,_ in orbits(N,d))
EQ_INDEX = {s:i for i,s in enumerate(EQ)}


def signs_to_walsh(table):
    a=[1-2*((table>>x)&1) for x in range(SIZE)]
    for j in range(N):
        h=1<<j
        for s in range(0,SIZE,2*h):
            for i in range(s,s+h):
                u,v=a[i],a[i+h]
                a[i],a[i+h]=u+v,u-v
    return a


def dual_quartic(top, lower):
    basis=[evaluate_orbit(o) for _,o in LOW+TOP]
    spectrum=signs_to_walsh(xor_terms(basis,(top<<25)|lower))
    assert all(w in (-64,64) for w in spectrum)
    return sum(int(w<0)<<i for i,w in enumerate(spectrum))


def su_table():
    def value(x):
        y = ((x & 63) & (x >> 6)).bit_count() % 2
        for j in range(N):
            first = shift(31,j)
            opposite = 1 << ((j+6) % N)
            y ^= (x & first) == first and not x & opposite
        return y
    return pack(value)


def high_mask(table):
    coefficients = integer_anf(table)
    return sum((coefficients[m] & 1) << i for i,(m,_) in enumerate(UPPER))


def union_system(upper):
    high = [m for i,(_,o) in enumerate(UPPER) if upper >> i & 1 for m in o]
    quad = [set() for _ in EQ]
    low = [0] * len(EQ)
    constant = [0] * len(EQ)
    X = [(i,m) for i,(_,o) in enumerate(TOP) for m in o]
    for a,b in combinations(high,2):
        j = EQ_INDEX.get(a|b)
        if j is not None:
            constant[j] ^= 1
    for a in high:
        for i,b in X:
            j=EQ_INDEX.get(a|b)
            if j is not None:
                quad[j].symmetric_difference_update((1<<i,))
        for i,(_,o) in enumerate(LOW):
            for b in o:
                j=EQ_INDEX.get(a|b)
                if j is not None:
                    low[j] ^= 1<<i
    for (i,a),(k,b) in combinations(X,2):
        j=EQ_INDEX.get(a|b)
        if j is not None:
            quad[j].symmetric_difference_update(((1<<i)|(1<<k),))
    return [(l, q ^ ({0} if c else set())) for l,q,c in zip(low,quad,constant)]


def eliminate_lower(rows):
    pivots = {}
    residual = []
    for mask, terms in rows:
        p=set(terms)
        while mask:
            j=mask.bit_length()-1
            if j not in pivots:
                pivots[j]=mask,p
                break
            b,q=pivots[j]
            mask ^= b
            p.symmetric_difference_update(q)
        else:
            if p:
                residual.append(p)
    return pivots,residual


def polynomial_linear_relations(residual):
    # Combine all quadratic equations without changing their zero set.
    pivots={}
    for polynomial in residual:
        row=set(polynomial)
        while row:
            i=max(row,key=lambda a:(a.bit_count(),a))
            if i not in pivots:
                pivots[i]=row
                break
            row.symmetric_difference_update(pivots[i])
    linear={m.bit_length()-1:(sum(t for t in p if t),int(0 in p))
            for m,p in pivots.items() if m.bit_count()==1}
    return linear, 0 in pivots


if __name__=="__main__":
    for label,t in [("dual of quartic",dual_quartic(13896404,1065441)),("Su",su_table())]:
        assert all(w in (-64,64) for w in signs_to_walsh(t))
        upper=high_mask(t)
        l,r=eliminate_lower(union_system(upper))
        lin,impossible=polynomial_linear_relations(r)
        print(label,"upper",hex(upper),"lower rank",len(l),"residual",len(r),
              "quartic linear rank",len(lin),"contradiction",impossible)
