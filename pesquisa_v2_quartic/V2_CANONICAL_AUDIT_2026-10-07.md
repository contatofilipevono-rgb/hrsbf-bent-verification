# V2 canonical manuscript audit — 2026-10-07

Audited: V2_CANONICAL_MANUSCRIPT_2026-10-07.md

## Verdict
No falsification of the central theorem chain was found.

Current chain:
- ker(Phi) has no nonzero decomposable bivector;
- therefore ind(f)=r-ind(f)=1;
- therefore ind(F_r)=r-ind(F_r)=r=n/8;
- under the standard n/2 M-subspace criterion, F_r is outside the completed Maiorana--McFarland class.

## Independent consistency checks
- dim Lambda^2(F_2^8)=28.
- rank(Phi)=22 and dim ker(Phi)=6 agree between the algebraic and exterior-square certificates.
- The free Pluecker coordinates agree with the algebraic certificate.
- Four necessary Grassmann--Pluecker relations suffice: their common Boolean solution in the six-dimensional kernel is already only zero.
- Constant D_aD_b f implies a wedge b belongs to ker(Phi).
- Independent a,b imply a wedge b is nonzero and decomposable.
- Every one-dimensional subspace is an M-subspace because D_aD_a f=0.
- For the r-fold direct sum, disjoint-block constancy forces each block summand to be constant.
- Each block projection of a relaxed M-subspace has dimension at most one.
- One chosen direction per block gives an r-dimensional M-subspace.
- Coordinate interleaving preserves both indices.

## Correction made during this audit
The explanation of four-linearity of the fourth polarization was expanded. For the homogeneous squarefree quartic Boolean form Q, the fourth finite difference is checked monomial-by-monomial to be an F_2-four-linear alternating form. The manuscript now explicitly identifies the matrix of Phi with the 28x28 contraction matrix used by the algebraic certificate.

Canonical-manuscript correction commit:
974f8fcd638b0c0f2a867111c75a430e1f1210dd

## Previously corrected exploratory errors
1. K~=V_6 was incorrect; the corrected cyclic-module type is V_4 direct-sum V_2.
2. Finite differences are not bilinear in their direction arguments in general. The family theorem now uses a direct block proof instead.

## Remaining publication work
These are not currently mathematical gaps in the exact-index theorem:
- verify exact bibliography and theorem numbering;
- perform a dedicated priority/equivalence comparison;
- run all exact certificates end-to-end from a clean checkout;
- prepare final LaTeX and supplementary certificate package.

## V1 firewall
V1 remains frozen and untouched.
