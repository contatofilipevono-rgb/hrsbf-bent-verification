# Certified periodic integer-ANF obstructions for homogeneous rotation-symmetric quartics in sixteen variables

Consolidated working draft, 17 October 2026. Bibliographic novelty remains unestablished. This text reorganizes the modular results; the separate finite Pareto and spectral-cover results remain in MANUSCRITO_RASCUNHO.md.

## Abstract

We give explicit necessary conditions for bentness in the 116-dimensional space of homogeneous rotation-symmetric quartic Boolean functions on sixteen variables. Six conditions have an eleven-parity normal form and occupy exactly 3/128 of the original space. Seven additional integer-ANF bits are combined without an independence assumption. The action of the units modulo sixteen reduces 127 nonzero characters to 43 orbits. Character-specific quadratic restrictions and certified upper bounds for radical-zero densities show that thirteen necessary conditions initially exclude at least 99.94316569188364% of the original coefficient space. A finite-difference refinement, certified by 1,441,770 independently checked matrix ranks, increases this to 99.96433819284774%. Complete polynomial substitutions, symmetry actions, 18,080 independent quadratic sums and 173 equation-span checks certify this bound. An exact Walsh-at-zero orbit identity supplies a further test, but the associated SAT pilots were inconclusive. A quotient-compatible subset reduces a prepared GPU domain to 162,537,472 states; no GPU execution is claimed. Global nonexistence is not proved here.

## 1. Setting and necessary divisibility

Let G_j be the sum of the distinct monomials in a cyclic orbit of squarefree quartic monomials. Order the 116 orbits by the first unseen quartet in lexicographic combination order. Write f=Σ_j c_jG_j. Short orbits are summed once, without repetition.

Let h_f(u) be the coefficient at the squarefree support u in the integer multilinear representation of (−1)^f. The classical integer-ANF criterion for a sixteen-variable bent function implies v₂(h_f(u))>|u|−8 when u is not the full support. In particular, weight-twelve supports require h_f(u) divisible by 32. We use this known criterion, not a new characterization of bentness; see Zhang and Gao [1, Lemma 2.4].

The preceding orbit-code certificates establish three linear laws and the factored conditions summarized below. Their full derivations are in T20_TRES_LEIS_PROVA.md, T26_QUARTA_CONDICAO_QUADRATICA.md, T27_QUINTA_CONDICAO.md, and T31_SETIMA_CONDICAO.md.

## 2. An eleven-parity normal form

Define the following parity forms on the original coefficients. Entries are index sets, and all equations are over F₂.

| form | coefficient indices |
|---|---|
| u1 | 0,4,8,18,42,52,56,94 |
| v1 | 14,22,46,71,81,85,98,106 |
| u2 | 1,9,15,28,53,67,76,103 |
| v2 | 3,11,34,45,55,69,78,89 |
| u3 | 2,10,25,37,54,68,83,104 |
| v3 | 12,20,29,33,41,48,96,110 |
| u4 | 13,21,38,70,74,93,97,109 |
| v4 | 24,32,47,72,80,86,91,107 |
| a | 57 |
| t | 23,31,39,112 |
| R | 5,6,7,16,17,19,43,44,49,50,51,58,59,62,63,66,82,84,87,95,100,102,105,108 |

Put b=u1+v1, K=u2+v2+u4+v4, M=u3+v3. The six-condition core is

`c115=0, c113=a, c99=b`,

`t=a+Σ_(i=1)^4 u_i v_i`,

`b(a+K)=0`,

`R=(1+b)M+(1+a)K`.

The three laws together with these eleven forms have rank fourteen. Choose the eight u_i,v_i and a; exclude only b=1,a≠K; reconstruct t,R. There are 256 admissible patterns with b=0 and 128 with b=1. Each pattern has 2^102 original coefficient words, hence the exact fraction is 384·2^102/2^116=3/128. This is a count of necessary-condition candidates, not of bent functions.

The charts are parametrizations by free coefficient coordinates. Reconstructing c23 and c5 is nonlinear; the original coefficient subsets are not asserted affine. All subsequent affine fibers and translations refer to the free-parameter spaces.

## 3. Three further periodic bits

At supports 0x3f3f, 0x5f5f, and 0x6f6f, the core conditions ensure divisibility by 16. Bentness requires the next bit P_s=h_f(s)/16 mod2 to vanish. On each uniform free-parameter chart b=0 or b=1, evaluate f plus the parity character on the 2,016 nonfixed pairs of the block swap. Its weight gives the identity

`h_f(s)=B0+4032−4 wt(t_f)`.

The diagonal contribution is 64,16,32,−16 in the four cases (a,b)=(0,0),(0,1),(1,0),(1,1). On the charts, all needed weight and pair-intersection congruences hold. The integer XOR-weight expansion therefore reconstructs the next bit as a cubic polynomial before the core substitutions. All terms of higher order vanish modulo two after division by four. Reconstructing c23 through the fourth condition and c5 through the condition at 0x7777 gives six complete chart polynomials. Their coefficients are fully certified, rather than inferred from random evaluations.

## 4. One vector-character lemma

Let P=(P₁,…,P_m), and let S be a common coordinate set such that no monomial of degree greater than two in any P_i involves two coordinates of S. Every nonzero character combination P_λ is quadratic on S, with a constant polar rank r_λ. Let Z_λ be the density, over the external coordinates, where all radical-direction derivatives of this quadratic slice vanish. Then

`Pr(P=0) ≤ 2^(−m) [1+Σ_(λ≠0) 2^(−r_λ/2) Z_λ]`.

Indeed, expand the indicator of P=0 in characters. A normalized quadratic sum on S vanishes when some radical derivative is one; otherwise its modulus is 2^(−r_λ/2). Bound each character expectation by its average modulus. No logical independence of the derivative equations is assumed.

For m=1 this includes the earlier scalar estimates. Here take m=3 and S={27,64,73,77,88,92,112}. All seven character ranks and all radical derivatives are checked symbolically. The densities Z_λ are computed by character expansion of their common-zero indicator. Conditioning on at most {57,35,61} in the zero chart and {35,61} in the one chart makes every remaining polynomial quadratic.

For this historical nine-condition system, the certified conditional pass bounds are 1375476686851/8796093022208 and 172033/1048576. The chart measures in the original coefficient space are 1/64 and 1/128. Consequently the nine-condition overall pass fraction is at most

`2097035386883/562949953421312`.

The exact joint survivor density is not claimed.

## 5. Verification and quotient limitation

VERIFICAR_FORMA_NORMAL_T34.py checks rank fourteen and all 512 aggregate cases. VERIFICAR_POLINOMIOS_T35.py reconstructs 226,930 coefficient terms and checks 192 direct original-ANF evaluations. VERIFICAR_LIMITE_CONJUNTO_T35.py verifies all common restrictions, polar ranks, radical bases, and 4,800 quadratic sums. The generating calculation eliminates pairs in the exponential sum; the independent verifier uses symplectic Gram-Schmidt. The checkers use standard Python.

The prepared GPU quotient records five fibers and has rank thirty-three. The condition from support 0x7777 descends to this quotient and halves its prior finite domain, giving 162,537,472 states. All 111,876 retained parent affine systems were checked on CPU. In contrast, the bit at 0x3f3f alone cannot remove any quotient state: two explicit kernel directions preserve the core and have constant-one mixed derivative on that bit, supplying both values within every state. The additional joint bits have not yet been incorporated into the quotient. CUDA and GPU scanning remain pending.

## 6. Thirteen conditions and normalizer symmetry

Add the first-bit conditions h_f(s)/8 mod2=0 for supports s=0x33ff,0x66ff,0x73bf,0x76ef. Each raw polynomial, after the three linear laws, has 4,748 monomials and degree three. The charts produce eight degree-at-most-four polynomials. All substitutions and 256 original-ANF evaluations are certified in T40_MODELOS_CERTIFICADO.json.

Each odd unit k modulo sixteen acts by permuting input indices i to ki. These actions preserve the six core conditions and both b-charts, and permute the seven remaining bits. Their 127 nonzero characters form 43 orbits. Expectations are equal within an orbit. The symmetry checker verifies eight actions, 32 relations among the four additional polynomials, and the complete orbit partition.

The character lemma permits a different restriction S for each character. A subset of radical equations gives an upper bound for the full radical-zero density; exact linear combinations and reductions of that selected system are certified. Conditional character expansion then evaluates the selected-system density by quadratic sums. Weighting each representative by its orbit size gives conditional pass bounds 1754322589141535/72057594037927936 and 866697251930187/36028797018963968. Multiplying by the chart measures 1/64 and 1/128 yields

`Pr(thirteen conditions) ≤ 1310509920535861/2305843009213693952`.

Thus the excluded fraction is at least 99.94316569188364%. The independent verifier checks 18,080 quadratic sums by a symplectic algorithm and 173 polynomial equation spans. No exact survivor density is claimed. The earlier lower survivor bounds for nine or ten conditions do not constrain the enlarged thirteen-condition set.

## 7. An exact Walsh-at-zero condition

Under the three linear laws, the contribution from the 256 inputs in short rotation orbits is 256−128a−192b. The other inputs form 4,080 orbits of length sixteen. If w counts full orbits on which f is one, then

`W_f(0)=65536−128a−192b−32w`.

Bentness requires w=2040−4a−6b+16σ, σ∈{0,1}. The verifier checks every generator on the diagonal, the complete orbit decomposition, positive and negative controls, and binary-adder semantics. Two strengthened SAT pilots timed out after sixty seconds each. They supply no exclusion and no nonexistence conclusion.

## 8. Finite-difference refinement

For F=(-1)^P and a k-dimensional subspace T, the average over h in T of E_x F(x)F(x+h) equals the average squared mean of F on T-cosets. Jensen therefore bounds |E F| squared by this average. If every D_hP is quadratic, bounding its normalized sum by 2^(-r(h)/2) gives

`|E F|² ≤ 2^(-k)[1+Σ_(h∈T,h≠0)2^(-r(h)/2)]`.

It suffices to verify quadratic differences on a basis. The identity D_(a+b)P(x)=D_aP(x+b)+D_bP(x) then gives quadratic differences throughout T, whose polar matrices add. T43/T44 use k=16 and independently enumerate all 65,535 nonzero matrix combinations per case. The generators use high pivots and the verifiers low pivots. All square-root upper bounds are rational and checked by exact integer inequalities.

T43 handles fourteen cases. T44 handles eight additional affine fibers, fixing c57 and u2 and eliminating c1. Every value of both linear forms is included with weight one fourth; no extra necessary condition is imposed. The independent verifiers rebuild 352 basis matrices and check 1,441,770 ranks. Taking the best valid character bound from T40, T43 and T44 yields

`Pr(thirteen conditions) ≤ 822305287179573/2305843009213693952`.

Thus the strongest certified exclusion is **99.96433819284774%**. The original chart measures and normalizer multiplicities are unchanged.

## 9. Scope and next questions

The quantitative exclusion follows from explicit identities and complete finite certificates. It does not establish nonexistence, and a high exclusion percentage alone is not a publication novelty claim. The next mathematical questions are tighter character estimates, further simplification of the periodic code, exact joint density, and whether an enlarged quotient makes the joint filters effective. The complete recent literature must be compared before a submission claim is made.

## Reference

[1] X. Zhang and G. Gao, On the conjecture about the nonexistence of rotation symmetric bent functions, arXiv:1303.2282 (2013). https://arxiv.org/abs/1303.2282
