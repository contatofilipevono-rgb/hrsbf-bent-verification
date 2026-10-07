# Dual coset criterion for fixed-space bentness

## Setup

Let V=F_2^n with the standard dot product, U a subspace, and H=U^perp. Let f be bent with dual f*. For a in U define

S_U(D_a f)=sum_{u in U} (-1)^{D_a f(u)}.

The restriction f|_U is bent (when dim U is even) iff S_U(D_a f)=0 for every nonzero a in U.

## Restriction as a Walsh average

The indicator of U is

1_U(x)=|H|^{-1} sum_{lambda in H} (-1)^{lambda dot x}.

Hence for every Boolean c,

sum_{u in U}(-1)^{c(u)}
=
|H|^{-1} sum_{lambda in H} W_c(lambda).

Taking c=D_a f and using derivative-spectrum duality,

W_{D_a f}(lambda)
=
(-1)^{a dot lambda} W_{D_lambda f*}(a).

Since a in U and lambda in H=U^perp, the sign is 1. Therefore

S_U(D_a f)
=
|H|^{-1} sum_{lambda in H} W_{D_lambda f*}(a).

## Coset-square formula

Write Q(w)=(-1)^{f*(w)}. Expanding the derivative Walsh transforms and interchanging sums gives

S_U(D_a f)
=
|H|^{-1}
sum_w (-1)^{a dot w} Q(w)
sum_{lambda in H} Q(w+lambda).

The inner sum is constant on each coset C=w+H. Also a in U=H^perp makes (-1)^{a dot w} constant on C. Thus

S_U(D_a f)
=
|H|^{-1}
sum_{C in V/H}
(-1)^{a dot C}
( sum_{w in C} (-1)^{f*(w)} )^2.

This identity is exact and does not use degree <=4.

## Criterion

Define the coset amplitudes

M(C)=sum_{w in C} (-1)^{f*(w)}.

Then the derivative character sums of f|_U are, up to |H|^{-1}, the Fourier transform on V/H of M(C)^2.

Consequently, assuming the quotient is identified with the dual of U in the usual way,

f|_U is bent
iff
M(C)^2 is constant over C in V/H
iff
|M(C)| is constant over all cosets of U^perp.

Thus fixed-space bentness is equivalent to uniform absolute character sums of the bent dual over the orthogonal cosets.

## Consequence for the quartic program

Derivative-spectrum duality alone does not prove quartic fixed-space reduction. It reformulates the missing statement as a coset-uniformity problem for f*.

For the odd-order rotation T used in the cubic manuscript, T is an orthogonal coordinate permutation. With U=Fix(T), one has U^perp=im(T-I); in the odd-order decomposition this is the moving component. Therefore the quartic target becomes:

> If f is T-invariant, bent, and deg f<=4, must the dual f* have equal-magnitude character sums on all cosets of im(T-I)?

There is no reason from bentness and T-invariance alone for this uniformity to hold; additional low-degree information from f would have to force it.

This criterion is useful even if the quartic route fails: it identifies exactly what the cubic quadratic-transfer lemma was secretly guaranteeing on the dual side.

No quartic nonexistence or fixed-space theorem is claimed here.
