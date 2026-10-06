#!/usr/bin/env python3
"""Independent exhaustive audit of the odd-order quadratic balance lemma.

For dimensions 1..3, enumerate every invertible linear map T over GF(2),
retain those of odd order, enumerate every degree<=2 Boolean function with
q(0)=0, retain T-invariant q, and test:
    q balanced on V  <=>  q restricted to Fix(T) balanced.
No project code is imported.
"""

from itertools import product

def apply(rows, x, d):
    y = 0
    for i, row in enumerate(rows):
        if (row & x).bit_count() & 1:
            y |= 1 << i
    return y

def rank(rows, d):
    a = list(rows); r = 0
    for c in range(d):
        p = next((i for i in range(r, d) if (a[i] >> c) & 1), None)
        if p is None: continue
        a[r], a[p] = a[p], a[r]
        for i in range(d):
            if i != r and ((a[i] >> c) & 1):
                a[i] ^= a[r]
        r += 1
    return r

def order(rows, d):
    perm = [apply(rows, x, d) for x in range(1 << d)]
    cur = list(range(1 << d))
    for k in range(1, 1000):
        cur = [perm[cur[x]] for x in range(1 << d)]
        if cur == list(range(1 << d)):
            return k
    raise RuntimeError("order bound exceeded")

def mons(d):
    return [(i,) for i in range(d)] + [(i,j) for i in range(d) for j in range(i+1,d)]

def q(mask, x, M):
    z = 0
    for k, mon in enumerate(M):
        if all((x >> i) & 1 for i in mon):
            z ^= (mask >> k) & 1
    return z

def main():
    for d in range(1,4):
        maps = []
        for rows in product(range(1 << d), repeat=d):
            if rank(rows,d) == d:
                o = order(rows,d)
                if o & 1:
                    maps.append((rows,o))
        M=mons(d); invariant=0
        for rows,o in maps:
            fixed=[x for x in range(1<<d) if apply(rows,x,d)==x]
            for mask in range(1<<len(M)):
                vals=[q(mask,x,M) for x in range(1<<d)]
                if not all(vals[apply(rows,x,d)] == vals[x] for x in range(1<<d)):
                    continue
                invariant += 1
                bal = sum(vals)*2 == (1<<d)
                bal_fixed = sum(vals[x] for x in fixed)*2 == len(fixed)
                assert bal == bal_fixed, (d, rows, o, mask)
        print(f"d={d}: odd-order GL maps={len(maps)}, invariant quadratics={invariant}, PASS")
    print("ALL EXHAUSTIVE ODD-ORDER REDUCTION CHECKS PASS")

if __name__ == "__main__":
    main()
