# Finite certificates for polynomial obstructions to cyclic homogeneous quartic bent functions

Working manuscript for independent review, 17 October 2026. The novelty comparison with the complete recent literature remains unfinished. Classical character expansions and quadratic-sum arguments are used as tools, not claimed as new results.

## Abstract

We study the 116-dimensional space of cyclic homogeneous quartic Boolean functions in sixteen variables. Six necessary conditions for bentness admit a normal form in eleven aggregate parities and occupy exactly 3/128 of the coefficient space. Seven additional integer-ANF bits are bounded jointly without assuming independence. Unit symmetries reduce their 127 nonzero characters to 43 orbits. Character-specific quadratic restrictions and finite-difference matrix pencils yield a certified pass fraction at most 2943198307753433/9223372036854775808, hence exclusion of at least 99.96808978000678%. The proof is supported by complete polynomial reconstructions, exact rational arithmetic, 18,080 independent quadratic sums, and 2,555,865 independently checked matrix ranks. We formulate a common certificate interface and a cost-aware selection problem. A further invariant necessary bit preserves the group action and cancels a highest-degree component; its quantitative effect is still being evaluated. Global nonexistence is not established.

## 1. Objects, prior criterion, and scope

Let G_j sum the distinct squarefree monomials in one orbit of cyclic rotation of four-element subsets of {0,...,15}. Order the 116 orbits by the first unseen subset in lexicographic combination order. The vector space consists of f=Σ_j c_jG_j with c_j in F2; it includes the zero vector. Short orbits are never repeated to length sixteen.

Bentness means that every Walsh coefficient of f is ±256. Let h_f(u) be the coefficient at support u in the integer multilinear polynomial representing (-1)^f. The classical integer-ANF criterion implies v2(h_f(u))>|u|-8 for nonfull u; weight-twelve supports therefore require divisibility by 32. We use this prior criterion, as stated in Zhang–Gao [1]. Testing examples does not replace it.

The separate conjecture concerning PC(2) is weaker than bentness and is not resolved by these bent-only filters. The quantitative theorem concerns the entire coefficient space, but is not a global nonexistence theorem. Earlier nonexistence literature, including Sun et al. [2], must be compared in full before a novelty claim is made.

## 2. A general certificate principle

Let every sought object lie in a core E, partitioned into disjoint sets E_b of original measures w_b. Each E_b is bijectively parameterized by a uniform space of free variables; reconstruction in the original variables need not be affine. On each parameter space, m necessary bits form a vector P_b.

Suppose measure-preserving bijections satisfy P_b(φ_g(x))=A_gP_b(x)+v_g, with A_g invertible. They act on nonzero characters by λ↦A_g^Tλ. Character expectations in an orbit equal one representative expectation up to signs. A negative sign cycle forces that expectation to vanish. Otherwise assign consistent signs σ_λ and let c_O=Σ_(λ∈O)σ_λ.

**Certificate principle.** If β_(b,O) bounds the absolute representative expectation, then

`Pr(sought object) ≤ Σ_b w_b 2^(-m) [1+Σ_O |c_O| β_(b,O)]`.

Expand the indicator of P=0 in characters. Invariance of the parameter measure gives the sign relations; grouping and the triangle inequality give the result. Independence of the bits is unnecessary. In the present application all v_g are zero, so c_O is the orbit size.

Three interchangeable leaf arguments provide β. First, a quadratic restriction of fixed polar rank r has normalized sum either zero or of modulus 2^(-r/2). Vanishing of radical-direction derivatives determines the nonzero case. Keeping only selected radical equations gives a safe upper bound for its density. Second, for F=(-1)^P and a k-dimensional subspace T,

`|E F|² ≤ 2^(-k)[1+Σ_(h∈T,h≠0)2^(-rank(D_hP)/2)]`,

provided all differences are quadratic. Indeed, averaging E_x F(x)F(x+h) over T equals the average squared coset mean, which dominates |E F|². Bound each nonzero quadratic sum by its modulus. It suffices to check a basis: D_(a+b)P(x)=D_aP(x+b)+D_bP(x), and translation preserves the quadratic part. Thus polar matrices add. Third, partition the parameter space by independent affine constraints and average valid bounds over every fiber with its exact measure. Taking the minimum of independently valid leaf bounds is safe.

All square-root bounds are rational: β² is checked against the exact rational right-hand side. Decimal lower bounds are truncated or rounded downward.

## 3. The six-condition core

The following forms are parities of original coefficients:

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

Put b=u1+v1, K=u2+v2+u4+v4 and M=u3+v3. The core is

`c115=0, c113=a, c99=b; t=a+Σ_(i=1)^4 u_i v_i; b(a+K)=0; R=(1+b)M+(1+a)K`.

The three laws and eleven aggregate forms have combined rank fourteen. Of 512 choices for the eight u_i,v_i and a, exactly 384 are admitted: 256 with b=0 and 128 with b=1. Each has 2^102 original coefficient words. The core measure is exactly 3/128.

Reconstructing c23 and c5 gives free-parameter spaces of dimensions 110 and 109, with original measures 1/64 and 1/128. These are uniform bijective parametrizations, not assertions that the original core subsets are affine. All later affine fibers refer to the parameter spaces.

## 4. Seven further bits and group reduction

The three supports 0x3f3f,0x5f5f,0x6f6f supply the next required bits h_f(s)/16 mod2 after the core. Their raw polynomial coefficients are reconstructed through the integer XOR-weight identity and a period-eight pairing into 64 fixed points and 2,016 pairs. The full symbolic substitutions are independently checked.

Four other supports, 0x33ff,0x66ff,0x73bf,0x76ef, supply first bits h_f(s)/8 mod2 after the three linear laws. Each raw cubic has 4,748 monomials. Their complete normal-form substitutions are certified. Passing the first bit gives divisibility by sixteen, not yet by thirty-two.

Multiplication of input indices by each odd unit modulo sixteen preserves the core and each b-chart. Its induced measure-preserving action permutes the seven bits. The 127 nonzero characters form 43 orbits. The verifier checks the coefficient permutations, core preservation, 32 additional polynomial relations and complete orbit coverage.

## 5. Quantitative theorem and reproduction

**Theorem.** The thirteen necessary conditions above admit at most the fraction

`2943198307753433/9223372036854775808`

of the original 2^116 coefficient words. Consequently they exclude at least **99.96808978000678%** as bent candidates.

For each chart and character orbit, combine a certified quadratic-restriction estimate with any available finite-difference or affine-fiber estimate. Sum orbit sizes times the chosen amplitudes, divide by 128 and weight the charts by 1/64 and 1/128. The resulting rational arithmetic gives the displayed fraction. No candidate independence hypothesis enters the proof.

The electronic proof has two stages. Complete model and symmetry checkers reconstruct the objects used in the theorem. Bound checkers then evaluate 18,080 quadratic sums using a symplectic algorithm distinct from the generator, check 173 equation spans, and rebuild finite-difference matrices. The difference generators use high-pivot elimination; independent checkers use low pivots and enumerate 2,555,865 nonzero matrix combinations across 39 conditioned cases. The 624 basis matrices are reconstructed directly from the polynomials. All checkers use standard Python.

The theorem's exact fractions are authoritative. Reports of completed local verification and the reported external PASS for the T40 bound are distinguished from external tasks still running. The full global nonexistence problem is not solved here.

## 6. Cost-aware certificates

Historical stages expose differently named bounds and recheck estimates later superseded by stronger ones. A compact proof should instead give every leaf the same fields: chart, character, method, amplitude bound and evidence. The aggregator dispatches to the selected leaf verifier and never needs discarded historical bounds.

We implemented a planner over alternative quadratic restrictions and difference dimensions. For a prefix subspace of dimension k, a certified uniform minimum rank r gives the valid squared-bias majorant 2^(-k)+(1-2^(-k))2^(-r/2). A smaller guarantee can therefore require far fewer rank checks. A heuristic budget allocation retains exclusion above 99.96008% at 888,810 estimated cost units, compared with 2,237,290 units for the full earlier T40/T43/T44 chain. The cost ratio is a model, not a runtime guarantee or optimality theorem. The mixed verifier is being executed, and the independent profiler pilot is intended to calibrate these costs.

As a small-space implementation check, the difference inequality was exhaustively checked for all 256 Boolean functions in three variables and all sixteen linear subspaces, giving 4,096 cases. The signed-orbit argument was checked for all 256 functions from F2² to F2², with strict savings in 99 cases. These finite checks do not replace the analytic principle or the H16 proof.

## 7. A useful ceiling and a further invariant obstruction

With m fixed, any certificate of the form Σ_b w_b 2^(-m)(1+nonnegative terms) is at least Σ_b w_b/2^m. Thus the present seven-bit absolute-character method cannot guarantee exclusion exceeding **99.981689453125%**. This is an exact limitation of the estimate, not an independence heuristic or a ceiling on true exclusion. Increasing k to twenty-four entails exponential work for diminishing benefit.

A certified additional bit is the sum of the first bits at supports 0x27ff,0x6edf,0x39ff,0x5eef. This sum remains invariant under all eight units and cancels a degree-five component. Its normal-form models have degrees four in both charts. Reconstruction checks 23,100 partitions, all eight invariances and a concrete witness passing the thirteen old tests but violating the sum. Its quantitative effect is still being calculated. Adding it changes the nonnegative-bound baseline to 3/32768, corresponding to **99.9908447265625%**.

## 8. Limitations and next work

The new quantitative result does not establish bibliographic novelty by itself. Publication requires comparison with the complete literature and a measured improvement in certification or a further structural theorem. The prepared GPU quotient still has 162,537,472 states and has not automatically absorbed the new joint tests; no GPU run is claimed.

An exact Walsh-zero orbit identity supplies another necessary test. Strengthened SAT pilots timed out and provide no exclusion. A separate certified obstruction rules out all nonzero translations of the present free-parameter charts acting on the seven-filter span; general affine and nonlinear symmetries remain possible.

The next work is to finish the mixed-certificate audit, calibrate costs with the profiler, and quantify the new invariant bit. These steps should be assessed through exact bounds and independently checkable artifacts rather than empirical survivor percentages.

## References requiring final bibliographic review

[1] X. Zhang and G. Gao, arXiv:1303.2282, integer-ANF bentness criterion, Lemma 2.4. https://arxiv.org/abs/1303.2282

[2] L. Sun, Z. Shi, J. Liu and F.-W. Fu, On the conjecture about the nonexistence of homogeneous rotation symmetric bent functions, Designs, Codes and Cryptography 94, 93 (2026). https://doi.org/10.1007/s10623-026-01848-4. The complete paper has not yet been compared; its abstract announces partial nonexistence results.
