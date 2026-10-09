# V3 exact enumeration: numerical checks

The number of EA classes **inside the canonical graph family** is the number of unlabeled loopless directed graphs, by `canonical_EA_iff_graph_isomorphic`.

Burnside partition formula:

N(r) = sum_{lambda partition of r} 2^(sum_{a,b in lambda} gcd(a,b) - len(lambda)) / prod_d (d^m_d * m_d!).

Values calculated with exact rational arithmetic:

| r | N(r) |
|--:|--:|
| 1 | 1 |
| 2 | 3 |
| 3 | 16 |
| 4 | 218 |
| 5 | 9608 |
| 6 | 1540944 |
| 7 | 882033440 |
| 8 | 1793359192848 |
| 9 | 13027956824399552 |
| 10 | 341260431952972580352 |

These are the known unlabeled loopless directed graph counts (OEIS A000273). The **numbers themselves are not claimed novel**. Their interpretation as EA-class counts is conditional on the existing Lean-certified graph classification.

Reproducible Python 3 implementation:

```python
from math import factorial, gcd
from fractions import Fraction

def partitions(n, lo=1):
    if n == 0:
        yield []
    else:
        for i in range(lo, n+1):
            for rest in partitions(n-i, i):
                yield [i] + rest

def count(r):
    total = Fraction(0)
    for p in partitions(r):
        z = 1
        for d in set(p):
            m = p.count(d)
            z *= d**m * factorial(m)
        orbits = sum(gcd(a,b) for a in p for b in p) - len(p)
        total += Fraction(2**orbits, z)
    assert total.denominator == 1
    return total.numerator

for r in range(1, 11):
    print(r, count(r))
```

Next scientific checks: independent exhaustive orbit enumeration for small r, Lean formalization of Burnside specialization, and literature priority review. No modifications to certified V1/V2 sources.
