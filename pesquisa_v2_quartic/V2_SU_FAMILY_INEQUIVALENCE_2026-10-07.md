# V2 — Exact separation from Su's maximal-degree RS family

Date: 2026-10-07

## Source

Sihong Su, "A new construction of rotation symmetric bent functions with maximal algebraic degree,"
Advances in Mathematics of Communications 13(2), 253–265 (2019).
DOI: 10.3934/amc.2019017.

For n=2m, Su defines a rotation-symmetric bent function of algebraic degree m. A 2026 IEEE TIT paper by Polujan, Kudin and Pasalic proves this family is outside M# for every n>=8.

## Dimensions n=8r, r>=2

Our F_r has degree 4. Su's function has degree n/2=4r. For r>=2 this is >4, so EA equivalence is excluded by algebraic degree.

## Exceptional common-degree case n=8

For n=8, Su's function also has degree 4. An exact computation shows:
- ind(F1)=r-ind(F1)=1;
- ind(Su8)=r-ind(Su8)=1.

Thus linearity index alone does NOT separate the two functions.

We therefore use the EA-invariant multiset over unordered independent direction pairs (a,b):

    ( deg(D_a D_b f), wt(D_a D_b f) ).

Under an invertible affine input map, direction pairs are bijectively permuted. Addition of an affine output term vanishes under second differentiation. Algebraic degree and Hamming weight of each second derivative are unchanged by the induced affine change of variables. Hence this multiset is EA-invariant.

Exact exhaustive spectra over all 32,385 independent unordered pairs are:

F1:
- (degree 2, weight 96): 2250
- (degree 2, weight 112): 8400
- (degree 2, weight 128): 10080
- (degree 2, weight 144): 8400
- (degree 2, weight 160): 3240
- (degree 2, weight 192): 15

Su8:
- (degree 1, weight 128): 3
- (degree 2, weight 64): 78
- (degree 2, weight 96): 2400
- (degree 2, weight 112): 6144
- (degree 2, weight 128): 13488
- (degree 2, weight 144): 7296
- (degree 2, weight 160): 2952
- (degree 2, weight 192): 24

The spectra differ. Therefore

    F1 is not EA-equivalent to Su8.

Combining with the degree argument for r>=2, no member F_r in dimension n=8r is EA-equivalent to the same-dimensional member of Su's maximal-degree family.

## Reproducibility

Run:

    python pesquisa_v2_quartic/certify_su8_inequivalence.py

The script reconstructs both functions from their published/committed formulas, exhaustively evaluates all 32,385 direction pairs, and writes su8_inequivalence_certificate.json.

## Consequence

The principal 2026 RS-outside-M# prior art now has explicit separation from our family:
- Carlet–Gao–Liu quartic family: disjoint admissible dimensions.
- Su maximal-degree family: degree separates for n>=16; exact second-derivative spectrum separates n=8.
- Pasalic et al. 2024 Examples 28, 29, 37: M-subspace dimension separates the 8-variable base block.

This materially strengthens, but does not by itself prove, a global priority claim for the exact identity ind(F_r)=n/8.
