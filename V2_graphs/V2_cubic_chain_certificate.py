#!/usr/bin/env python3
"""V2: sparse cubic gluing theorem, 2026-10-08.

All spaces are over F_2. Orb denotes the sum over DISTINCT cyclic shifts.
Use the established seed f = Orb(01)+Orb(0123)+Orb(0125)+Orb(0135), R2(f)=1.
For r>=2, x_i in F_2^8, define
 F_r(x)=(f(x_1),...,f(x_r), sum_{i=1}^{r-1} x_i[0]*x_i[1]*x_{i+1}[0]).
Then F_r: F_2^(8r) -> F_2^(r+1) has degree 4 and R2(F_r)=r.
Moreover F_r+Q is EA-indecomposable for EVERY vectorial Q of degree <=2.
Nontrivial decomposition means both input factors have positive dimension.

PROOF OF INDEX (using the established seed theorem, not rechecking it):
Every relaxed subspace projects to a relaxed subspace for each seed, hence
its dimension is at most the sum of projection dimensions, at most r.
The span of e_(i,7), i=1,...,r, is admissible: the last coordinate is
independent of these variables; on each seed block two directions are
zero or equal. Thus all second differences vanish there. Adding Q makes
second differences constant and does not change R2.

FINITE LOCAL LEMMA (proved by the exact elimination below):
Let phi=D^4 f be its constant alternating 4-tensor. Its radical is zero and
 {P: phi(Pa,b,c,d)=phi(a,Pb,c,d) for all a,b,c,d} = F_2 I.
The constraint ranks are 8 and 63, respectively. Identity is a solution,
so nullity one identifies the whole center. No floating point or packages.

GLOBAL PROOF:
Let T=D^4 F_r=(phi_1,...,phi_r,0). If a decomposition V=A+B were induced
by an EA equivalence to a product, its projection P onto A along B would
satisfy T(Pa,b,c,d)=T(a,Pb,c,d). Indeed all mixed derivatives for the
product vanish; invertible output maps and affine additions preserve this.
Input translations have no effect on the fourth derivative.
For a in block j and b,c,d in block i!=j, taking output i gives
phi(P_ij a,b,c,d)=0, so radical zero implies P_ij=0.
On each diagonal block the local lemma gives P_ii=lambda_i I, lambda_i in F_2.
Thus A,B partition the original eight-dimensional blocks.
Any nontrivial partition cuts some adjacent edge i,i+1 of the chain.
But in the last coordinate,
 D_{e_(i,1)} D_{e_(i+1,0)} F_r = x_i[0],
which is nonconstant. A product has zero mixed second differences, whereas
an added quadratic contributes only a constant and input translation only
translates x_i[0]. Contradiction. Hence even F_r+Q cannot be EA a product.

The result allows ONE extra output coordinate; fixed output dimension r
is not established. Novelty is NOT claimed. Related methods: centers of
multilinear forms and relaxed M-subspaces. No V1 files changed.
"""
from itertools import combinations, product

N = 8
quartic = set()
for seed in ((0,1,2,3), (0,1,2,5), (0,1,3,5)):
    orbit = {tuple(sorted((j+k) % N for j in seed)) for k in range(N)}
    quartic.symmetric_difference_update(orbit)

def phi(a,b,c,d):
    return len({a,b,c,d}) == 4 and tuple(sorted((a,b,c,d))) in quartic

def rank_f2(rows):
    pivots = {}
    for row in rows:
        while row:
            p = row.bit_length()-1
            if p in pivots:
                row ^= pivots[p]
            else:
                pivots[p] = row
                break
    return len(pivots)

# Unknown bit 8*k+a is matrix entry P[k,a].
center_rows = []
for a,b,c,d in product(range(N), repeat=4):
    row = 0
    for k in range(N):
        if phi(k,b,c,d): row ^= 1 << (N*k+a)
        if phi(a,k,c,d): row ^= 1 << (N*k+b)
    center_rows.append(row)
identity = sum(1 << (N*k+k) for k in range(N))
assert all((row & identity).bit_count() % 2 == 0 for row in center_rows)
radical_rows = [sum(int(phi(k,*q)) << k for k in range(N))
                for q in combinations(range(N), 3)]
assert len(quartic) == 24
assert rank_f2(center_rows) == 63
assert rank_f2(radical_rows) == 8
print('PASS: 24 quartic monomials; center rank 63/64; radical rank 8/8.')
print('Local lemma certified exactly over F_2. See docstring for infinite-family proof.')