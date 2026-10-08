#!/usr/bin/env python3
"""New finite lemma for the graph gluing theorem (no old tests rerun).

THEOREM. Over F2, let f_i:V_i->F2 have degree 4 and let phi_i=D^4 f_i.
Assume phi_i(a,b,-,-)=0 implies a,b are dependent. Let W contain independent
vectors w_1,...,w_r, and H:direct_sum V_i->W have degree <=3. Put tau=D^3 H.
Choose nonzero v_i in V_i, U=span(v_i), and assume tau(U,U,V)=0.
Form a graph with edge ij when tau(V_i,V_j,V) is nonzero. If connected,
F=sum_i w_i*f_i + H has R2=r and F+Q is EA-indecomposable for every deg Q<=2.

PROOF. Constancy of D_aD_b F implies T(a,b,c,d)=0 for every c,d, with
T=D^4F=sum_i w_i phi_i. Hence projections of every relaxed S have dimension
at most one. Thus dim S<=r. U is relaxed: seed second differences vanish
since directions on each block are equal or zero; D^3H(U,U,V)=0 makes its
second differences constant. The same holds after any quadratic addition.
For a hypothetical input splitting A+B of an EA product, its idempotent P
satisfies T(Pa,b,c,d)=T(a,Pb,c,d). Independence of w_i and radical zero of
phi_i force P_ij=0 for i!=j. A nontrivial diagonal idempotent would supply
independent a in its image and b in its kernel with phi_i(a,b,-,-)=0,
contradiction. Therefore A,B partition whole blocks. A connected edge across
this partition supplies a in V_i,b in V_j,c in V with D_aD_bD_c F=tau(a,b,c)
nonzero. All seed mixed derivatives vanish. This persists after adding Q,
input translation, invertible output maps and affine additions, contradicting
a product. This is EA indecomposability, with both input factors nonzero.

EXPLICIT INSTANCE. For any connected simple graph on {1,...,r}, orient each
edge once. Use the established 8-variable seed and define, with indices 0..7,
 F_i(x)=f(x_i)+x_i[0]*x_i[1]*sum_{j: i->j}x_j[0].
Then F:F2^(8r)->F2^r satisfies the theorem with v_i=e_(i,7).
For each edge i->j, D_(i,0) D_(i,1) D_(j,0) of the cubic part is w_i.
This covers every tree and every connected simple graph, regardless of
orientation. Connectedness alone is insufficient for arbitrary edge labels:
vanishing or cancelling cubic tensors do not create effective edges.
No originality claim. The computation below certifies ONLY the new local
hypothesis; the infinite-family argument is the proof above, not a Lean proof.
"""
from itertools import combinations

pairs = list(combinations(range(8), 2))
terms = set()
for a in ((0,1,2,3), (0,1,2,5), (0,1,3,5)):
    terms.symmetric_difference_update({tuple(sorted((j+k)%8 for j in a))
                                       for k in range(8)})
rows = [sum(1 << k for k,b in enumerate(pairs)
            if len(set(a+b)) == 4 and tuple(sorted(a+b)) in terms)
        for a in pairs]

def echelon(rs):
    pivots = {}
    for row in rs:
        while row:
            k = row.bit_length()-1
            if k in pivots:
                row ^= pivots[k]
            else:
                pivots[k] = row
                break
    return pivots

pivots = echelon(rows)
assert len(pivots) == 22
basis = []
for j in range(28):
    if j in pivots:
        continue
    v = 1 << j
    for k in sorted(pivots):
        if (pivots[k] & v).bit_count() % 2:
            v ^= 1 << k
    basis.append(v)
assert len(basis) == 6
assert all((v & row).bit_count() % 2 == 0 for v in basis for row in rows)
assert len(echelon(basis)) == 6
histogram = {}
for mask in range(1, 64):
    v = 0
    for j,b in enumerate(basis):
        if (mask >> j) & 1:
            v ^= b
    matrix = [0]*8
    for k,(a,b) in enumerate(pairs):
        if (v >> k) & 1:
            matrix[a] ^= 1 << b
            matrix[b] ^= 1 << a
    rank = len(echelon(matrix))
    histogram[rank] = histogram.get(rank, 0)+1
assert histogram == {4: 3, 8: 60}
# A nonzero decomposable bivector a wedge b has alternating matrix rank 2.
assert 2 not in histogram
print('PASS: contraction rank 22/28; kernel dimension 6.')
print('All 63 nonzero kernel elements: 3 of rank 4, 60 of rank 8.')
print('No nonzero decomposable kernel element: new seed hypothesis verified.')