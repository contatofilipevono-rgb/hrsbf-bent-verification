# Exterior-square certificate for the quartic base block

Let V=F_2^8 and let f_4 be the homogeneous quartic part of the certified RS bent base function, with orbit seeds (0,1,2,3), (0,1,2,5), (0,1,3,5). Let T(a,b,c,d)=D_aD_bD_cD_d f_4. It induces Phi: Lambda^2 V -> (Lambda^2 V)^* by Phi(a wedge b)(c wedge d)=T(a,b,c,d).

## Exact computation
In the standard 28-dimensional basis, rank(Phi)=22 and dim ker(Phi)=6. Thus the tempting stronger claim that Phi is injective is false.

The relevant condition is weaker: ker(Phi) must contain no nonzero decomposable 2-vector. Its 63 nonzero elements, viewed as alternating 8x8 matrices, have exact rank spectrum: 60 of rank 8 and 3 of rank 4, with none of rank 2. A nonzero decomposable 2-vector a wedge b has alternating-matrix rank 2. Hence ker(Phi) contains no nonzero decomposable 2-vector, and T(a,b,.,.)=0 forces a,b dependent.

## Consequence
If D_aD_b f is constant, then D_cD_dD_aD_b f=0 for all c,d. Lower-degree terms disappear after four derivatives, so T(a,b,c,d)=0 for all c,d. Hence a,b are dependent. No relaxed M-subspace contains two independent directions, so r-ind(f)=1.

This replaces the previous exhaustive check of 32,385 independent pairs at 256 points each by one 28x28 matrix, its 6-dimensional kernel, and 63 alternating-rank checks.

## General criterion
For any quartic Boolean function, if the kernel of its fourth-polarization map Phi_f: Lambda^2 V -> (Lambda^2 V)^* contains no nonzero decomposable 2-vector, then r-ind(f)=1.

No novelty claim is made here; priority and terminology require dedicated literature comparison before manuscript use.
