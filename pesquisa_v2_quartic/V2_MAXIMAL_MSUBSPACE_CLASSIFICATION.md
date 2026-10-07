# V2 — Classification and count of maximal M-subspaces

Date: 2026-10-07

## Setting

Let f:F_2^8 -> F_2 be the quartic rotation-symmetric bent seed with certified relaxed linearity index

    r-ind(f)=1.

Let

    F_r = f ⊕ ... ⊕ f

be the r-fold direct sum, written in the paper in its interleaved rotation-symmetric coordinates. Coordinate permutation preserves M-subspaces and their dimensions, so classification may be done in ordinary block coordinates.

The previously established result is

    ind(F_r)=r-ind(F_r)=r=n/8.

## Theorem — complete classification of maximal M-subspaces

Every maximal-dimensional M-subspace U of F_r is a direct product

    U = L_1 × ... × L_r,

where each L_j is a one-dimensional subspace of F_2^8.

Conversely, every such product is an r-dimensional M-subspace of F_r.

### Proof

Let U be an M-subspace of F_r with dim U=r. Since every M-subspace is a relaxed M-subspace, U is a relaxed M-subspace.

For each block j, let p_j(U) be its coordinate projection into F_2^8. The projection argument underlying Polujan--Pott Theorem 4.5 shows that p_j(U) is a relaxed M-subspace of f. Since r-ind(f)=1,

    dim p_j(U) <= 1

for every j.

The natural map

    U -> ⊕_{j=1}^r p_j(U)

is injective. Hence

    r = dim U <= Σ_j dim p_j(U) <= r.

All inequalities are equalities. Thus every p_j(U) has dimension exactly one. Write p_j(U)=L_j.

We have

    U ⊆ L_1 × ... × L_r.

Both sides have dimension r, so equality follows:

    U = L_1 × ... × L_r.

Conversely, let L_j=<a_j> be any one-dimensional subspace in block j. For arbitrary vectors a,b in the product, their jth components are α_j a_j and β_j a_j. In characteristic two,

    D_{α_j a_j}D_{β_j a_j} f = 0

because one direction is zero or both directions are equal and D_aD_a f=0. Summing over disjoint blocks gives D_aD_b F_r=0. Therefore the product is an M-subspace of dimension r.

QED.

## Corollary — exact count

Over F_2, every one-dimensional subspace contains exactly one nonzero vector. Therefore F_2^8 has

    2^8-1 = 255

one-dimensional subspaces.

The choices are independent across the r labeled blocks. Hence the number of maximal-dimensional M-subspaces is exactly

    |MS_r(F_r)| = 255^r.

Since n=8r,

    |MS_{n/8}(F_r)| = 255^{n/8}.

Moreover, because every r-dimensional relaxed M-subspace has the same projection argument and must equal a product of one-dimensional block subspaces, and every such product is an ordinary M-subspace,

    RMS_r(F_r) = MS_r(F_r)

at maximal dimension, and therefore

    |RMS_r(F_r)| = |MS_r(F_r)| = 255^r.

## Stronger structural statement

Thus the family has not only exact maximal dimension

    ind(F_r)=r-ind(F_r)=n/8,

but a complete description of every extremal subspace:

    maximal M-subspaces = maximal relaxed M-subspaces
                         = products of one line from each 8-variable block.

There are no diagonal or mixed maximal subspaces outside this product form.

## Novelty positioning

The direct-sum projection mechanism is based on Polujan--Pott Theorem 4.5 and is not claimed as a new general theorem.

The family-specific contribution is that the certified seed satisfies r-ind(f)=1. This collapses every block projection to a line and makes the extremal structure completely classifiable, yielding the explicit count 255^r.

A publication-stage literature search is still required before claiming that the count 255^r or this complete maximal-subspace classification is the first such formula for an infinite quartic rotation-symmetric bent family outside M#.

## V1 firewall

This result belongs only to V2. V1 remains frozen and untouched.
