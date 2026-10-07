# Symbolic route to the C8-module kernel (work note)

Let V be the 8-dimensional permutation module of the cyclic rotation rho over F_2. Put t=rho+1. Since rho^8=1 and X^8-1=(X+1)^8 in characteristic two, V is the indecomposable cyclic module V_8, equivalently F_2[t]/(t^8).

The homogeneous quartic part of the certified base function is rho-invariant. Hence its fourth polarization induces a C_8-equivariant self-dual map
    Phi: Lambda^2(V_8) -> Lambda^2(V_8)^*.
The computed kernel is V_6.

A conceptual proof can therefore avoid checking all 28 basis wedges if one:
1. uses the known decomposition of Lambda^2(V_8) into indecomposable F_2[C_8]-modules in characteristic two;
2. writes Phi on generators of those summands (or, equivalently, determines the relevant homomorphism in the local algebra F_2[t]/(t^m));
3. shows that exactly one kernel summand/chain of length 6 remains.

Because F_2[C_8] is local and the V_m are uniserial, an equivariant homomorphism is controlled by the image of a cyclic generator subject to t^m-annihilation. This should reduce the 28x28 calculation to a small number of polynomial identities in t.

Current exact facts to be reproduced symbolically:
- dim ker Phi = 6;
- dim ker((rho+1)^j | ker Phi)=j for 1<=j<=6;
- hence ker Phi ~= V_6;
- the rank-4 plane R equals ker((rho+1)^2 | ker Phi) ~= V_2;
- all nonzero elements outside R have alternating rank 8, and K contains no rank-2 element.

Caution: the module type K~=V_6 alone does not imply the alternating-rank spectrum. A symbolic proof of r-ind=1 still needs to exclude decomposable vectors in K, either by an explicit rank formula along the t-adic chain or by a known theorem about this embedded copy of V_6 in Lambda^2(V_8).

This note records the reduction target; it does not claim the full symbolic derivation is complete.
