# Exact linearity index of the quartic interleaved RS bent family

## 1. Setup

Let (f:mathbb F_2^8	omathbb F_2) be the certified quartic rotation-symmetric bent block whose short algebraic normal form has orbit representatives

[
(0,1),qquad (0,1,2,3),qquad (0,1,2,5),qquad (0,1,3,5).
]

For (rge1), set (n=8r), partition the coordinates into the interleaved blocks

[
B_j=(x_j,x_{j+r},x_{j+2r},ldots,x_{j+7r}),qquad 0le j<r,
]

and define

[
F_r(x)=sum_{j=0}^{r-1} f(B_j).
]

Equivalently, after a permutation of coordinates, (F_r) is the ordinary (r)-fold direct sum (fopluscdotsoplus f).

For a Boolean function (g), write (D_ag(x)=g(x+a)+g(x)). An M-subspace is a linear subspace (U) such that

[
D_aD_bg=0qquad	ext{for all }a,bin U.
]

The linearity index (operatorname{ind}(g)) is the maximum dimension of an M-subspace. The relaxed linearity index (r	ext{-}operatorname{ind}(g)) is defined analogously with (D_aD_bg) only required to be constant. These notions and the direct-sum inequalities used below are those of Polujan--Pott (2020).


## Rotation-symmetry lemma

### Lemma
For every r >= 1, F_r is rotation-symmetric under the ordinary one-position cyclic shift of its n=8r variables.

### Proof
Let rho be the cyclic shift defined by (rho x)_i=x_{i+1 mod n}, and write

    T_j(x)=f(x_j,x_{j+r},...,x_{j+7r}),  0<=j<r,

so F_r=sum_j T_j. If j<r-1, then directly

    T_j(rho x)=T_{j+1}(x).

For j=r-1, put y_k=x_{kr}, 0<=k<=7. Reduction modulo n=8r gives

    T_{r-1}(rho x)=f(y_1,y_2,...,y_7,y_0).

Since the 8-variable block f is rotation-symmetric,

    f(y_1,...,y_7,y_0)=f(y_0,...,y_7)=T_0(x).

Thus rho cyclically permutes the r summands T_0,...,T_{r-1}, and therefore

    F_r(rho x)=F_r(x).

This argument uses only rotation symmetry of the base block, so it holds for any rotation-symmetric 8-variable f repeated with the same interleaving. QED.

## 2. Base-block certificate

### Lemma 1
For the 8-variable block (f),

[
r	ext{-}operatorname{ind}(f)=1.
]

### Certificate
Every unordered pair of distinct nonzero directions (a,binmathbb F_2^8) was checked exactly. Since the field is binary, such a pair is automatically linearly independent. There are

[
inom{255}{2}=32385
]

such pairs. For every pair, the complete truth table of

[
D_aD_bf(x),qquad xinmathbb F_2^8,
]

was evaluated at all 256 points. No pair produced a constant second derivative.

Hence no relaxed M-subspace can have dimension at least two. Conversely every one-dimensional subspace is an M-subspace because (D_aD_af=0). Therefore

[
r	ext{-}operatorname{ind}(f)=operatorname{ind}(f)=1.
]

The exhaustive computation is retained as a reproducible finite certificate; it is not used as a substitute for an all-(r) enumeration.

## 3. Exact index theorem

### Theorem 2
For every (rge1),

[
oxed{operatorname{ind}(F_r)=r=rac n8}.
]

### Proof

Because (F_r) is linearly equivalent to the (r)-fold direct sum of (f), invariance of the (relaxed) linearity index under nonsingular affine/linear changes of variables allows us to work with the ordinary direct-sum representation.

Polujan--Pott's direct-sum inequality for relaxed linearity index gives

[
r	ext{-}operatorname{ind}(goplus h)
le
r	ext{-}operatorname{ind}(g)+r	ext{-}operatorname{ind}(h).
]

Iterating this inequality and using Lemma 1 yields

[
operatorname{ind}(F_r)
le
r	ext{-}operatorname{ind}(F_r)
le
r,r	ext{-}operatorname{ind}(f)
=r.
]

It remains to prove the reverse inequality.

Choose a fixed nonzero direction (einmathbb F_2^8). For each block (j), let (e_jinmathbb F_2^{8r}) denote the vector equal to (e) on block (B_j) and zero on every other block, and set

[
U_r=langle e_0,ldots,e_{r-1}angle.
]

The vectors (e_j) have disjoint supports, hence (dim U_r=r). For arbitrary

[
a=sum_jalpha_je_j,qquad b=sum_jeta_je_j
]

in (U_r), the direct-sum decomposition gives

[
D_aD_bF_r
=
sum_j D_{alpha_je}D_{eta_je}f.
]

For each (j), at least one coefficient is zero, in which case the corresponding second derivative vanishes, or both coefficients equal one, in which case it is (D_eD_ef=0). Thus

[
D_aD_bF_r=0
]

for all (a,bin U_r). Therefore (U_r) is an M-subspace and

[
operatorname{ind}(F_r)ge r.
]

Together with the upper bound,

[
operatorname{ind}(F_r)=r=n/8.
]

(square)

## 4. Maiorana--McFarland consequence

### Corollary 3
For every (rge1), (F_r) lies outside the completed Maiorana--McFarland class (mathcal M^#).

Indeed, a bent function in (n) variables belonging to (mathcal M^#) admits an M-subspace of dimension (n/2). Here

[
operatorname{ind}(F_r)=rac n8<rac n2.
]

More quantitatively, the exact deficiency from the Maiorana--McFarland threshold is

[
oxed{rac n2-operatorname{ind}(F_r)=rac{3n}{8}}.
]

Thus the obstruction grows linearly with dimension.

## 5. Relation to prior RS bent families

The novelty claim must be separated from the theorem above.

Carlet--Gao--Liu (2014), Theorem 3.8, construct an infinite quartic RS bent family under (n=2m) with (m) odd; hence its dimensions satisfy (nequiv2pmod4). The present family has (n=8r), so these admissible dimension sets are disjoint.

Polujan--Kudin--Pašalić (2026) prove that rotation-symmetric bent functions can lie outside (mathcal M^#), including a quartic family originating in Carlet--Gao--Liu. Consequently the bare property “quartic RS bent outside (mathcal M^#)” is not a novelty claim.

Deng Tang (ePrint 2026/1799) gives two further RS bent constructions outside (mathcal M^#) with any possible algebraic degree. His displayed M-subspace arguments establish strict upper bounds sufficient for non-membership in (mathcal M^#); in the sources audited for this project, no exact formula (operatorname{ind}=n/8) for the present family was located.

Tang's Section 6 also proves that the broad Su--Tang 2017 systematic construction belongs to (mathcal M^#), so that construction is not an outside-(mathcal M^#) collision with the present theorem.

## 6. Priority statement

The mathematically proved claim is:

> For every (n=8r), the family (F_r) has exact linearity index (operatorname{ind}(F_r)=n/8), and therefore lies outside (mathcal M^#).

The bibliographic statement should remain qualified:

> To the best of our knowledge, the audited literature does not contain a previous exact determination (operatorname{ind}(F_r)=n/8) for this infinite quartic rotation-symmetric bent family.

An absolute “first” claim is intentionally avoided unless a final publication-stage priority search supports it.

## 7. Reproducibility

The repository should retain:
- the explicit SANF/ANF of the 8-variable block;
- the exact base-block relaxed-index verifier;
- its machine-readable certificate;
- the theorem above;
- literature-comparison notes;
- hashes/commit identifiers tying the certificate to the code used.

## 8. V1 firewall

This section belongs exclusively to V2. The V1 preprint remains frozen and must not be modified by this development.
