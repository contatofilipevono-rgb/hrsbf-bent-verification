# Cyclic-module interpretation of the polarization kernel

Let rho be the cyclic coordinate rotation of order 8 on V=F_2^8. Since the quartic homogeneous part is rotation symmetric, its fourth-polarization map Phi is rho-equivariant; hence K=ker(Phi) is an F_2[C_8]-submodule of Lambda^2 V.

In characteristic two the C_8 action is modular: X^8-1=(X+1)^8. Thus rho is unipotent rather than semisimple, and K should be analyzed by the nilpotent operator N=rho+I (equivalently rho-I).

The exact rank computation already identifies a distinguished plane R<=K: its three nonzero vectors are exactly the rank-4 elements, while every element of K\R has alternating rank 8. Because alternating rank is preserved by coordinate rotation and the rank-4 locus is unique, R is automatically rho-invariant. Therefore R is a canonical F_2[C_8]-submodule of K.

This supplies a structural explanation for the invariance of the exceptional rank-4 locus without enumerating its orbit: it is characterized intrinsically as the set {0} union {x in K: alt-rank(x)=4}.

Relevant representation-theoretic literature: Gow--Laffey (2006) decomposes exterior squares of indecomposable modules for cyclic 2-groups in characteristic 2; Himstedt--Symonds gives recursive formulas for exterior/symmetric powers. These should be used to compare the module type of K and R before claiming a new classification.

Next exact invariants to compute are the Jordan block sizes of rho|K and rho|R, equivalently dim ker(N^j) for j=1,...,8. These determine their indecomposable C_8-module decompositions.
