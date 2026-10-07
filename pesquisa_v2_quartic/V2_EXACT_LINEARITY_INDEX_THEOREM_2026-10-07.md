# Exact theorem: linearity index n/8 for the interleaved quartic RS family

Let f:F_2^8->F_2 be the certified quartic RS bent function with orbit seeds
(0,1), (0,1,2,3), (0,1,2,5), (0,1,3,5), and let
F_r = f direct-sum ... direct-sum f
under the interleaved coordinate permutation
B_j=(x_j,x_{j+r},...,x_{j+7r}), 0<=j<r.
Thus n=8r.

## Lemma 1: the base relaxed linearity index is one

For nonzero linearly independent a,b in F_2^8, exhaustive exact evaluation of
D_a D_b f(x)=f(x)+f(x+a)+f(x+b)+f(x+a+b)
over all x in F_2^8 finds no pair for which the derivative is constant.

A relaxed M-subspace of dimension at least two would contain two linearly
independent vectors a,b and would require D_a D_b f to be constant. Hence no
such subspace exists. Every one-dimensional subspace is relaxed because
D_a D_a f=0. Therefore

    r-ind(f)=1.

The accompanying certificate checks all unordered independent pairs and all
256 evaluation points, with no probabilistic step.

## Theorem: ind(F_r)=r-ind(F_r)=r=n/8 for every r>=1

Let U be any relaxed M-subspace of the ordinary r-fold direct sum. Write
a=(a_0,...,a_{r-1}) and b=(b_0,...,b_{r-1}) by blocks. Then

    D_a D_b F_r(x) = sum_i D_{a_i} D_{b_i} f(x^(i)).

For a,b in U this sum is constant. Since the summands depend on disjoint
variable blocks, each summand is constant: vary x^(i) while fixing all other
blocks. Hence each projection pi_i(U) is a relaxed M-subspace of f. Since
r-ind(f)=1,

    dim pi_i(U) <= 1.

The block-projection map U -> direct-sum_i pi_i(U) is injective, so

    dim U <= sum_i dim pi_i(U) <= r.

Therefore r-ind(F_r)<=r, and ind(F_r)<=r-ind(F_r)<=r.

For the lower bound, choose a nonzero direction e_i in each block and put

    U_r = span(e_0,...,e_{r-1}).

For arbitrary a=sum_i alpha_i e_i and b=sum_i beta_i e_i,

    D_a D_b F_r = sum_i D_{alpha_i e_i} D_{beta_i e_i} f.

For each i, either alpha_i=0 or beta_i=0, giving zero, or alpha_i=beta_i=1,
in which case D_{e_i}D_{e_i}f=0. Thus D_aD_bF_r=0 for all a,b in U_r.
Therefore U_r is an M-subspace of dimension r and ind(F_r)>=r.

Consequently

    ind(F_r)=r-ind(F_r)=r=n/8.

Since n/2=4r, the deficiency from the completed Maiorana--McFarland threshold is

    n/2-ind(F_r)=3r=3n/8.

In particular F_r is outside M# for every r>=1.

### Correction to an earlier draft

An earlier draft invoked "bilinearity of finite differences in the direction
variables." This is false in general: a third-derivative correction term can
occur. The proof above uses only the direct decomposition into disjoint blocks
and D_vD_v f=0.

## Why the interleaving does not change the argument

The displayed F_r in the RS construction is a coordinate permutation of the
ordinary r-fold direct sum. Linearity index and relaxed linearity index are
invariant under nonsingular affine/linear equivalence (Polujan--Pott,
Proposition 4.4). Hence the theorem applies unchanged to the rotation-symmetric
interleaved representation.

## Literature boundary

This theorem uses the relaxed-M-subspace direct-sum machinery of:
A. A. Polujan and A. Pott, Designs, Codes and Cryptography 88 (2020),
1701--1722, Theorem 4.5 and Proposition 4.4.

A 2026 paper by Polujan--Kudin--Pasalic already proves rotation-symmetric bent
families outside M# and states that a quartic RS family of Carlet--Gao--Liu
(2014) lies outside M# for infinitely many dimensions. Therefore the present
result must not be advertised merely as the first quartic RS family outside
M#. The potentially differentiating statement is the exact quantitative
identity ind(F_r)=n/8 for every n=8r, subject to a dedicated priority/equivalence
comparison with the published quartic family.

## V1 isolation

No V1 file is modified. V1 remains frozen at
d70ebc8a5a6c8a4901263af24ff71cbdb2a12e93 on preprint-v1-final-2026-10-06.
