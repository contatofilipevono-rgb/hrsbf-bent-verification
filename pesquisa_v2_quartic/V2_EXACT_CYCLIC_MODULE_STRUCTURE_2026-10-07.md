# Corrected cyclic-module structure of the quartic polarization kernel

Let rho be cyclic rotation on V=F_2^8 and N=rho+I. For the certified quartic RS base function, K=ker(Phi_f) is rho-invariant and has dimension 6.

## Correct nilpotent filtration

The exact computation gives

    dim ker(N|K)   = 2,
    dim ker(N^2|K) = 4,
    dim ker(N^3|K) = 5,
    dim ker(N^4|K) = 6.

Hence the previous V_6 identification was incorrect. The Jordan block sizes are 4 and 2, so

    K ~= V_4 direct-sum V_2

as an F_2[C_8]-module.

Choose cyclic generators z,u so that

    K = <z,Nz,N^2z,N^3z> direct-sum <u,Nu>.

In coordinates

    omega = c0 z + c1 Nz + c2 N^2z + c3 N^3z + c4 u + c5 Nu,

the three nonzero rank-4 elements form the plane

    R = { c0=c1=0, c2=c4, c3=c5 }.

Equivalently R is spanned by N^2z+u and N^3z+Nu.

## Closed Pfaffian formula on K

For the alternating 8x8 matrix A(omega) associated with omega, the Pfaffian, reduced as a Boolean function on F_2^6, is

    Pf(A(omega))
      = 1 + (1+c0)(1+c1)(1+c2+c4)(1+c3+c5).

Therefore

    Pf(A(omega)) = 0

for nonzero omega exactly on R. Thus every omega in K\R is nonsingular and has alternating rank 8.

For omega in R\{0}, a fixed 4x4 principal Pfaffian minor (for example on coordinates {0,1,2,3}) is nonzero on all three nonzero points. Hence those elements have rank at least 4; the full 8x8 Pfaffian is zero there, and the exact certificate gives rank exactly 4.

Consequently the nonzero rank spectrum of K is exactly

    3 elements of rank 4,
    60 elements of rank 8,
    0 elements of rank 2.

Hence K contains no nonzero decomposable 2-vector, so the quartic base block has relaxed linearity index 1.

## Correction notice

This file supersedes the earlier claim that K~=V_6 and R=ker(N^2|K). That claim resulted from an incorrect nilpotent-filtration calculation. The corrected module type is V_4 direct-sum V_2. The previously established rank spectrum and r-ind(f)=1 conclusion remain valid.

Literature context: Gow--Laffey (J. Group Theory 9 (2006), 659--672) and Korhonen (LAA 624 (2021), 349--363) provide the relevant exterior-square/Jordan theory in characteristic two. The contribution candidate here is the application to the polarization kernel and relaxed linearity index of the quartic Boolean function.
