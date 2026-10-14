# Draft manuscript — V2 (pre-submission)

**Title:** Exact Relaxed Second-Derivative Indices and EA-Rigid Families of Vectorial Quartic Boolean Functions

**Author:** Filipe Martins Vono

## Abstract

We construct quartic vectorial Boolean functions indexed by finite oriented simple graphs. A certified eight-variable quartic seed yields exact relaxed second-derivative index equal to the number of graph vertices. Connected underlying graphs give EA-indecomposable functions, including after arbitrary quadratic perturbations. The canonical functions are EA-equivalent exactly when their oriented graphs are isomorphic. We derive a lower bound for inequivalent indecomposable functions.

## 1. Construction and main result

For a vectorial Boolean function F, let R₂(F) be the maximum dimension of a linear subspace U such that D_a D_b F is constant for all a,b in U.

Take f = Orb(01) + Orb(0123) + Orb(0125) + Orb(0135) on F₂⁸, where Orb sums distinct cyclic rotations of a squarefree monomial. Set φ=D⁴f. The finite seed certificate checks:

(A) φ(a,b,·,·)=0 implies a,b linearly dependent.

For an oriented simple graph G on r≥2 vertices, define

(F_G)_i(x) = f(x_i) + x_{i,0}x_{i,1} Σ_{j:i→j} x_{j,0}.

**Main theorem (conditional on certified (A)).** For any vectorial Q of degree ≤2:

(i) R₂(F_G+Q)=r.

(ii) If the underlying graph is connected, F_G+Q is EA-indecomposable.

(iii) Canonical representatives F_G and F_H are EA-equivalent if and only if G and H are isomorphic as oriented graphs.

(iv) F_G+Q EA-equivalent to F_H+Q' implies oriented-graph isomorphism; the converse for arbitrary Q,Q' is not claimed.

## 2. Proof of exact index

Let S be relaxed. Constancy of D_a D_b(F_G+Q), for a,b∈S, implies D_a D_b D_c D_d(F_G+Q)=0. Quartic derivatives come only from independent seed components, giving φ(a_i,b_i,c_i,d_i)=0. Condition (A) forces dim π_i(S)≤1, hence dim S≤r. The subspace U spanned by e_{i,2} over all i has dimension r. The cubic couplings omit coordinate 2; on each seed, D_a D_b vanishes for collinear a,b; quadratic perturbations contribute only constants. Thus R₂=r.

## 3. Intrinsic block rigidity

Write T=D⁴F_G=Σ_i e_i φ_i. Define the input centroid C(T)={P:T(Pa,b,c,d)=T(a,Pb,c,d) for all a,b,c,d}. Applying this identity with a in V_j and b,c,d in V_i, i≠j, shows φ_i(P_ij a,b,c,d)=0. By (A), φ_i has zero radical and P_ij=0.

For an idempotent P, each diagonal P_ii is idempotent. If P_ii differs from 0 and I, choose independent nonzero a in im(P_ii), b in ker(P_ii). Then φ_i(a,b,·,·)=0, violating (A). Conversely, projections onto unions of entire blocks lie in C(T). Therefore the minimal nonzero idempotents are exactly the individual block projections.

Under EA equivalence H(x)=B F(Ax+t)+L(x), the fourth derivative transforms as T_H=B T_F(A·,A·,A·,A·), and C(T_H)=A⁻¹ C(T_F) A. Thus any EA equivalence of canonical or quadratically perturbed members permutes whole input blocks.

## 4. Directed-edge recovery and indecomposability

For i≠j, a,b∈V_i and c∈V_j, the third derivative D_a D_b D_c F_G is independent of the base point and equals 1_{i→j} e_i (a₀b₁+a₁b₀)c₀. It is nonzero exactly when i→j. This nonvanishing survives blockwise invertible coordinate changes, output invertible transformations, translations and quadratic perturbations. Hence EA equivalence implies oriented-graph isomorphism. Conversely, an isomorphism permutes identical input seed blocks and output coordinates, proving EA equivalence of canonical representatives.

A direct-product EA decomposition induces a nontrivial centroid idempotent and therefore a partition into whole blocks. Connectivity gives an edge crossing that partition, with nonzero mixed third derivative. A direct product has zero mixed derivatives across its factors, contradiction. Quadratic perturbations do not affect third derivatives.

## 5. Counting inequivalent classes

Fix a directed star 1→j for all j≥2. Each of the binomial(r−1,2) remaining pairs independently admits no edge or either orientation, yielding 3^{binomial(r−1,2)} labeled connected oriented graphs. At most r! labeled graphs occur per isomorphism class. Thus there are at least ceil(3^{(r−1)(r−2)/2}/r!) inequivalent indecomposable canonical functions.

## 6. Finite certificate

The local contraction map on Λ²(F₂⁸) has rank 22, kernel dimension 6; among 63 nonzero kernel elements, three have alternating matrix rank 4 and sixty rank 8. A nonzero decomposable bivector has rank 2, so no decomposable bivector lies in the kernel. Reproduce with `python V2_graph_no_extra_output.py`.

## 7. Prior art and scope

The scalar relaxed M-subspace / relaxed linearity index is prior art (Polujan–Pott). EA-equivalence invariants and algorithms are established (Kaleyski; *Recovering or Testing Extended-Affine Equivalence*), as is work on counting EA classes of vectorial Boolean functions. The proposed novelty lies specifically in the graph-indexed quartic vectorial family, its exact index and indecomposability, and the oriented-graph classification. Bibliographic priority is **not yet established**. A standalone algebraic proof of (A) and Lean verification remain open improvements.

### References requiring final bibliographic formatting

- A. Polujan and A. Pott, *Cubic bent functions outside the completed Maiorana–McFarland class* (2020).
- N. Kaleyski, *Deciding EA-equivalence via invariants*, Cryptography and Communications (2022), DOI 10.1007/s12095-021-00513-y.
- *Recovering or Testing Extended-Affine Equivalence*, IEEE Transactions on Information Theory 68 (2022), 6187–6206.
- *The number of affine equivalent classes and extended affine equivalent classes of vectorial Boolean functions* (2020).

**Draft status:** argument recorded for peer review; not a certified typeset manuscript or a claim of publication readiness.
