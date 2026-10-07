# Fourth-polarization bound for relaxed linearity index (degree <= 4)

Let V=F_2^n and let f:V->F_2 have algebraic degree at most 4. Let T_f be its fourth derivative/polarization and define

    Phi_f: Lambda^2 V -> (Lambda^2 V)^*
    Phi_f(a wedge b)(c wedge d) = T_f(a,b,c,d).

## Proposition
If U <= V is a relaxed M-subspace of f, then

    Lambda^2 U <= ker(Phi_f).

Consequently, if r=dim U,

    binom(r,2) <= dim ker(Phi_f)
               = binom(n,2) - rank(Phi_f).

Hence

    r-ind(f) <= max { r : binom(r,2) <= dim ker(Phi_f) }.

Equivalently, writing k=dim ker(Phi_f),

    r-ind(f) <= floor((1+sqrt(1+8k))/2).

This bound is only a necessary-condition bound and can be weak.

## Proof
For a,b in U, D_a D_b f is constant by definition of a relaxed M-subspace. Hence for arbitrary c,d in V,

    D_c D_d D_a D_b f = 0.

For degree <=4 this fourth derivative is the multilinear fourth polarization T_f(a,b,c,d). Therefore Phi_f(a wedge b)=0 for every a,b in U. Since decomposable wedges a wedge b span Lambda^2 U, Lambda^2 U <= ker(Phi_f). Taking dimensions gives the bound.

## Strong rank-2-free criterion
If ker(Phi_f) contains no nonzero decomposable 2-vector (equivalently, under the standard identification with alternating matrices, no rank-2 element), then r-ind(f)=1.

This is sufficient, not necessary. Conversely, a decomposable element a wedge b in ker(Phi_f) only implies that D_aD_b f has degree at most 1; it need not be constant. Thus the exterior-square kernel is an obstruction layer, not a complete characterization of relaxed M-subspaces.

## Certified 8-variable base
For the quartic RS bent base block in this branch:

    dim Lambda^2 V = 28,
    rank(Phi_f) = 22,
    dim ker(Phi_f) = 6.

The dimension-only inequality gives only r-ind(f)<=4. The stronger geometry of the kernel is decisive: its 63 nonzero elements have alternating ranks 8 (60 elements) and 4 (3 elements), with no rank-2 element. Therefore r-ind(f)=1.

## Literature positioning
The exterior-square / alternating-matrix fact that nonzero decomposable 2-vectors correspond to rank-2 alternating matrices is classical. Gow--Quinlan (Linear and Multilinear Algebra 54 (2006), 415--428, DOI 10.1080/03081080500361264) study maximal subspaces of alternating matrices containing no rank-2 elements, including finite fields.

Relaxed M-subspaces and r-ind are from Polujan--Pott (Designs, Codes and Cryptography 88 (2020), 1701--1722).

The potentially new contribution is the bridge from fourth polarization to relaxed-linearity-index obstructions/bounds for degree-4 Boolean functions. No novelty claim should be made until a fuller priority search confirms that this bridge has not appeared under different terminology.
