# Directed graphs encoded by quartic vectorial Boolean maps

Research manuscript draft, 2026-10-09. Mathematical source checkpoint:
`7924bc8815729256f407f6a6ef18074537ac64ef` on
`v3c-ea-transport-continuation`. Authorship, affiliations, and submission venue
must be supplied by the researchers. This is a draft for independent review;
no priority claim is made.

## Abstract

For every integer m≥2 and finite loopless directed graph G, we study an explicit
vectorial Boolean map with a quartic seed on each 2m-dimensional vertex block
and cubic couplings encoding the directed arcs. We prove that two canonical
maps are extended-affine equivalent exactly when their graphs are isomorphic.
The argument recovers input blocks from the zero-pair relation of fourth finite
differences, recovers the corresponding output permutation, and detects arcs
using mixed third differences. We also determine the dimension of the fourth
contraction radical and the exact simultaneous relaxed index. For weakly
connected graphs, every quadratic perturbation of the map is indecomposable
under an EA product representation. The structural results are formalized in
Lean 4 with Mathlib, uniformly in the block dimension. These maps are used as
classification objects; no bentness, APN, or cryptographic security property is
asserted.

## 1. Construction and equivalence

All spaces and coefficients are over F₂. Let V=F₂^(2m), with coordinates
v=(p₁,q₁,…,pₘ,qₘ), and define

\[
 f_m(v)=\sum_{1\le s<t\le m}p_sq_sp_tq_t,
 \qquad \omega(v,w)=\sum_s(p_s(v)q_s(w)+q_s(v)p_s(w)).
\]

Let I be a finite vertex set, r=|I|, and let gᵢⱼ∈F₂ encode a loopless directed
graph. On X=V^I, with output Y=F₂^I, put

\[
 (F_{G,m}(x))_i=f_m(x_i)+p_1(x_i)q_1(x_i)
                 \sum_j g_{ij}p_1(x_j).
\]

Both orientations of an edge can occur. The distinguished first coordinate
pair belongs to the construction and is not replaced by another seed.
Lean uses indices 0,…,m−1; thus the pair called first here has Lean index 0.

For a function F on X, DₐF(x)=F(x+a)+F(x). Finite differences commute.
We use ordinary EA equivalence:

\[
 H(x)=B(F(Ax+t))+Lx+k,
\]

where A and B are invertible linear maps on X and Y, respectively, t∈X,
L:X→Y is linear, and k∈Y. Graphs are compared on a common vertex set;
an isomorphism is a permutation π with hᵢⱼ=g_{π(i),π(j)}.

**Theorem 1 (canonical classification).** For m≥2 and loopless directed graphs
G,H on I,

\[
 F_{G,m}\sim_{EA}F_{H,m}\quad\Longleftrightarrow\quad G\cong H.
\]

This theorem concerns the displayed canonical maps. It does not claim an EA
classification of F_G+Q by the graph alone for arbitrary quadratic Q.

## 2. Fourth differences and intrinsic blocks

Write

\[
 P(a,b,c,d)=\omega(a,b)\omega(c,d)+\omega(a,c)\omega(b,d)
                          +\omega(a,d)\omega(b,c).
\]

**Lemma 2 (polarization and zero pairs).** At every base point x,
DₐD_bD_cD_df_m(x)=P(a,b,c,d). For m≥2,

\[
 [\forall c,d\ P(a,b,c,d)=0]
 \quad\Longleftrightarrow\quad a=0\ \text{or}\ b=0\ \text{or}\ a=b.
\]

**Proof.** Fourth differences of each squarefree quartic monomial give its
four-linear polarization. Summing the terms gives the displayed expression;
the terms involving a single coordinate pair cancel in characteristic two.
For the zero-pair assertion, label the 2m scalar coordinates by u and let
Mᵤᵥ=aᵤbᵥ+aᵥbᵤ. Evaluating the zero contraction on symplectic dual basis vectors
gives Mᵤᵥ=ω(a,b)Jᵤᵥ, where J pairs the two coordinates in each local pair.
The minors satisfy

\[
 M_{uv}M_{wz}+M_{uw}M_{vz}+M_{uz}M_{vw}=0.
\]

Choose the four coordinates of two different pairs. Substitution yields
ω(a,b)²=0, hence ω(a,b)=0 and all minors vanish. If a≠0, choose a coordinate
of a equal to 1. The vanishing minors then show that b is either 0 or a.
The converse follows from alternation. This argument includes m=2. ∎

Cubic couplings have zero fourth differences. Consequently

\[
 (D_aD_bD_cD_dF_{G,m}(x))_i=P(a_i,b_i,c_i,d_i).
\]

The intrinsic relation R(a,b), defined by the vanishing of this vector for all
c,d,x, is therefore exactly blockwise linear dependence of aᵢ,bᵢ.
EA transport gives D⁴H(a,b,c,d)(x)=B(D⁴F(Aa,Ab,Ac,Ad)(Ax+t));
the affine correction vanishes. Thus A preserves R in both directions.

**Lemma 3 (block recovery).** Every invertible linear map preserving R has the
form A(singleᵢv)=single_{π(i)}(Eᵢv), where π permutes I and each Eᵢ is an
invertible linear map of V.

**Proof.** Suppose U+T=X and every pair
a∈U,b∈T is blockwise dependent. For a fixed block i, if both projections are
nonzero, choose such a,b. Every nonzero projection from either subspace must
equal aᵢ=bᵢ. Their sum cannot cover V, which has dimension at least four.
Hence one projection is zero. To justify the assertion about whole blocks,
suppose T has zero projection at i and decompose singleᵢv=u+t. At i, uᵢ=v.
At any other block k, uₖ+tₖ=0 and one of the two projections vanishes, so
both components vanish. Therefore u=singleᵢv and the block lies in U.

Fix a source block i and a nonzero v₀∈V. Since A is injective, A(singleᵢv₀)
has a nonzero component at some target block j. Let U be the inverse image of
the j-th target block and T the kernel of the j-th target projection composed
with A. These two subspaces cover X. Their images have disjoint block support,
so preservation of R gives blockwise dependence for every pair from U,T.
The partition just proved applies to all source blocks. If the projection of
U at i were zero, the i-th source block would lie in T, contradicting the
choice of j. Thus T projects to zero at i, and that source block lies in U.
It follows that A sends the entire i-th block into the j-th target block.

The restriction Eᵢ is injective and hence surjective, since the two blocks
have the same finite dimension. If two different source blocks were assigned
the same target block, surjectivity of their restrictions would give two
different preimages of a nonzero target vector, contradicting injectivity of A.
The assignment is consequently injective on the finite set I and hence a
permutation. ∎

**Theorem 4 (contraction dimension).** Define the actual vector fourth radical

\[
 K(a)=\{b:\forall c,d,x\ D_aD_bD_cD_dF_{G,m}(x)=0\}.
\]

It is a linear subspace. If s(a)=|{i:aᵢ≠0}|, then

\[
 \dim K(a)=2mr-(2m-1)s(a).
\]

Indeed K(a) is the product of V when aᵢ=0 and span{aᵢ} otherwise, by Lemma 2.
The support counts vertex blocks, rather than individual scalar coordinates.
The statement includes a=0 and the empty vertex set.

## 3. Output recovery and directed arcs

The polarization takes the value 1 on the four basis vectors of two local
coordinate pairs. Fourth differences supported on block i therefore give the
output basis vector eᵢ. Transport and Lemma 3 force
B(e_{π(i)})=eᵢ: the transformed scalar polarization is nonzero and hence is 1
over F₂. By linearity (By)ᵢ=y_{π(i)}. This determines the output map without
assuming that Eᵢ preserves ω. In particular, preservation of the quartic
polarization is not silently strengthened to symplectic preservation at m=2.

For distinct vertices i,j and v,w,z∈V, direct differentiation gives

\[
 D_{\mathrm{single}_iv}D_{\mathrm{single}_iw}
 D_{\mathrm{single}_jz}F_{G,m}(x)
 =e_i\,g_{ij}\big(p_1(v)q_1(w)+q_1(v)p_1(w)\big)p_1(z).
\]

The expression is constant in x. The quartic seeds disappear because at least
one differentiation direction is zero in each seed's block. Choosing the
first p-, q-, and p-basis vectors detects an arc i→j exactly by nonzeroness.
An arc j→i does not interfere with this test.

The invertible maps Eᵢ and EA transport preserve the existence of a nonzero
mixed third difference. Therefore hᵢⱼ=g_{π(i),π(j)} for i≠j. Looplessness
supplies the equality on the diagonal. Conversely, reindexing input blocks
and output coordinates by a graph isomorphism gives an EA equivalence with
zero translation and affine correction. This proves Theorem 1.

## 4. Exact relaxed index and quadratic robustness

Call U≤X simultaneously relaxed for F if DₐD_bF is a constant vector-valued
function for every a,b∈U. The maximum dimension of such U is R₂(F). This is
the coordinatewise vector analogue of the scalar relaxed linearity index of
Polujan and Pott [PP20, Definitions 4.1–4.2], rather than a new definition of
the scalar invariant.

**Theorem 5.** R₂(F_{G,m})=r. Moreover R₂(F_{G,m}+Q)=r whenever every second
difference of Q is constant, in particular for every quadratic ANF.

**Proof.** A constant second difference has zero fourth differences. Lemma 2
forces the projection of a relaxed subspace into each vertex block to have
dimension at most one; the embedding into the product of these projections
gives dim U≤r. For equality choose in each block the p-basis direction in the
second local pair. Couplings do not depend on these coordinates. Each block's
two directions are dependent, so the seed has zero second difference on them.
Their span has dimension r. Adding Q changes each second difference by a
constant, preserving the condition in both directions. ∎

Quadratic perturbations are explicitly covered by

\[
 Q(x)=c+L_Qx+\sum_{\alpha\in A}w_\alpha\ell_\alpha(x)n_\alpha(x),
\]

for any finite A, linear scalar forms ℓα,nα and output coefficients wα.
Such Q has constant second differences and zero third and fourth differences.
This represents arbitrary affine-plus-quadratic ANFs in the chosen coordinates.
The formal development uses this explicit representation and an intrinsic
derivative condition, not a separate Mathlib polynomial-degree API bridge.

**Theorem 6 (quadratic-robust indecomposability).** Suppose every nonempty
proper vertex cut has an arc crossing it in either direction. For Q as above,
F_G+Q has no representation

\[
 F_G(x)+Q(x)=B\big(g((Ax+t)_1),h((Ax+t)_2)\big)+Lx+k,
\]

where A:X≃V₁×V₂ is a linear equivalence, both input factors are nontrivial,
and B:W₁×W₂→Y is linear. B need not be invertible, so ordinary EA product
representations are included.

**Proof.** Pull back the two input factors to nonzero subspaces U,T with
U+T=X. Product separation forces all cross second differences for a∈U,b∈T
to vanish; affine terms also have zero second differences. Since Q has
constant second differences, cross second differences of F_G are constant.
Their fourth differences vanish, and the partition argument of Lemma 3
assigns whole vertex blocks to U or T. Both sides receive a block. A crossing
arc yields a nonzero mixed third difference by the formula in Section 3,
contradicting constancy of the cross second difference. The opposite arc
orientation is treated by exchanging the two subspaces. ∎

The cut convention includes empty and singleton graphs. The requirement of
two nontrivial input factors deals with these cases. We assert no converse for
arbitrary quadratic perturbations of disconnected graphs.

## 5. Complexity consequence and related work

Fix m=2 and replace every undirected edge by both directed arcs. There are 4r
input bits, r output bits, and exactly r+2|E| squarefree ANF monomials for a
nonempty simple graph. Theorem 1 gives a polynomial many-one reduction from
equal-order graph isomorphism to EA equivalence of these compact ANFs. This
size calculation is a mathematical consequence, not a Lean complexity theorem.
For unequal graph orders, send the instance to a fixed pair of nonisomorphic
equal-order graphs; Theorem 1 certifies the corresponding negative EA instance.
No NP-hardness or unconditional superpolynomial lower bound follows.

Agrawal and Saxena [AS05] already reduce graph isomorphism to cubic-form
equivalence. Their target uses formal homogeneous polynomials and invertible
linear substitution. This rules out positioning the present reduction as the
first connection between graph isomorphism and algebraic equivalence. Our
target is an explicit vectorial Boolean family under ordinary EA equivalence.
Whether that distinction supplies a new theorem requires further comparison.

Kaleyski and Sunde [KS26] give general EA/CCZ equivalence and automorphism
algorithms. At implementation commit
`c9cec6515b3297abf5c15fedd23e55b43f2ba888`, the Python polynomial-input path
evaluates all 2^N field elements into a truth table before EA search. It treats
that path as a square field map; rectangular maps use explicit tables. This
path therefore expands the input exponentially in N, unlike the compact ANF
encoding above. This code observation is not a complexity theorem about the
unretrieved full paper or every possible implementation.

Canteaut, Couvreur and Perrin [CCP22] recover EA equivalences of quadratic
functions using Jacobians and study ortho-derivatives for quadratic APN
functions (Definition 33 and Proposition 36). Their derivative transport is
relevant prior methodology. Our proof uses a fourth-contraction zero-pair
relation to recover quartic input blocks and mixed third differences to read
directed arcs. These are different mathematical objects; that distinction
alone does not establish novelty.

Polujan and Pott [PP20] provide the scalar relaxed-subspace framework.
We do not claim novelty of that framework or infer bentness from the index.

## 6. Machine-checked scope and reproduction

The formalization uses Lean/Mathlib 4.19.0. The correspondence is:

| Statement | Declaration (namespace VonoV3C unless qualified) |
|---|---|
| Lemma 2 | `seed_fourth`, `pfaffian_property_A`, `fourth_pair_zero_iff` |
| Lemma 3 | `Blocks.recover_blocks_from_quartic`, `GraphFamily.EA_recovers_blocks` |
| Theorem 4 | `GraphFamily.graph_fourth_radical_dimension` |
| Output permutation | `GraphFamily.representation_output` |
| Mixed third difference | `GraphFamily.mixed_third`, `GraphFamily.edge_detected_iff` |
| Theorem 1 | `GraphFamily.canonical_EA_iff_graph_isomorphic` |
| Theorem 5 | `GraphFamily.graph_has_exact_relaxed_index`, `GraphFamily.graph_quadratic_exact_index` |
| Quadratic ANFs | `GraphFamily.quadratic_ANF_second_constant` |
| Theorem 6 | `GraphFamily.graph_quadratic_ANF_not_EA_product` |

On the continuation branch, enter `pesquisa_v3c_symplectic/lean` and run
`lake build`, `lake env lean Audit.lean`, `lake env lean GraphQuadraticAudit.lean`,
and `lake env lean GraphContinuationAudit.lean`. Container-specific executable
path instructions and immutable dependency pins are documented in
`CONTINUATION_PROGRESS.md` and `FORMALIZATION_REPORT.md`.
The audited results depend only on `propext`, `Classical.choice`, and `Quot.sound`.
There are no added axioms or admitted proof holes. Compilation establishes
the Lean statements; independent review must still check correspondence with
the mathematical prose. Novelty, authorship, and publication readiness are
separate matters.

## References consulted

- [AS05] M. Agrawal and N. Saxena, *Equivalence of F-algebras and cubic forms*,
  author-hosted manuscript, 15 September 2005.
  https://www.cse.iitk.ac.in/users/manindra/algebra/algebras-cubicforms2.pdf
- [PP20] A. Polujan and A. Pott, *Cubic bent functions outside the completed
  Maiorana–McFarland class*, Designs, Codes and Cryptography (2020),
  DOI: https://doi.org/10.1007/s10623-019-00712-y. Definitions 4.1–4.2 and
  Proposition 4.4 were inspected on the publisher's full-text page.
- [KS26] N. Kaleyski and J. Sunde, *Efficiently deciding and recovering CCZ and
  EA equivalence for arbitrary vectorial Boolean functions using the partition
  refinement framework*, IACR ePrint 2026/940.
  https://eprint.iacr.org/2026/940
  Public implementation, fixed version:
  https://github.com/zskiley/CCZ-EA-equivalence/tree/c9cec6515b3297abf5c15fedd23e55b43f2ba888
  The abstract, README and Python input/search dispatch were inspected;
  full-paper comparison is pending. See `LITERATURE_INPUT_MODEL_REVIEW.md`
  for file hashes and reproduction instructions.
- [CCP22] A. Canteaut, A. Couvreur and L. Perrin, *Recovering or Testing
  Extended-Affine Equivalence*, arXiv:2103.00078v3, 16 May 2022.
  https://arxiv.org/abs/2103.00078v3
  Complete PDF retrieved; selected statements in Section 3 and Section 4.1.2
  inspected for this comparison.
