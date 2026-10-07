# Exact cyclic-module structure of the quartic polarization kernel

Let rho be cyclic rotation on V=F_2^8 and N=rho+I. For the certified quartic RS base function, K=ker(Phi_f) is rho-invariant and has dimension 6.

Exact computation of the nilpotent filtration on K gives
dim ker(N^j|K) = 1,2,3,4,5,6 for j=1,...,6.
Hence rho|K has one Jordan block of size 6:
    K is isomorphic to the indecomposable F_2[C_8]-module V_6.

Let R be the 2-dimensional subspace whose three nonzero elements are exactly the alternating-rank-4 elements of K. The computation gives
    R = ker(N^2|K).
Therefore R is the unique length-2 submodule in the uniserial chain of K and R is isomorphic to V_2. All 60 elements of K\R have alternating rank 8.

This explains structurally why the exceptional rank-4 locus is a plane: it is the canonical second term in the nilpotent/Jordan filtration of the indecomposable cyclic module K, not an accidental set found by enumeration.

Literature context: Gow--Laffey (J. Group Theory 9 (2006), 659--672) gives decomposition theorems for exterior squares of indecomposable modules of cyclic 2-groups in characteristic 2; Korhonen (LAA 624 (2021), 349--363) studies Jordan forms on exterior squares in characteristic two. Our claim here is the exact module identification of this specific polarization kernel and its use in the Boolean-function linearity-index argument, not novelty of cyclic-module exterior-square theory.

Consequences retained from the exterior-square certificate:
- dim K=6;
- rank spectrum K\{0}: 3 elements of alternating rank 4, 60 of rank 8, none of rank 2;
- hence K contains no nonzero decomposable 2-vector;
- hence the quartic base block has relaxed linearity index 1.
