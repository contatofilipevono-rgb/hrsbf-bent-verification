# V2 — Exact relaxed index, EA indecomposability, and oriented-graph classification

**Status:** mathematical proof drafted; local seed condition (A) is computationally certified in a separate Python script. Novelty relative to literature remains unestablished. Not Lean formalized.

**Isolation:** V2 work is confined to this branch and the `V2_graphs/` directory. V1 is not modified.

## Definitions

For a vectorial Boolean function (F:V\to W), define
[
R_2(F)=\max\{\dim U: D_aD_bF\text{ is constant for every }a,b\in U\}.
]
Differences use (D_aF(x)=F(x+a)+F(x)).

Let (f:\mathbb F_2^8\to\mathbb F_2) be the quartic seed
[
f=\operatorname{Orb}(01)+\operatorname{Orb}(0123)+\operatorname{Orb}(0125)+\operatorname{Orb}(0135).
]
The finite local condition to certify is
[
(A)\qquad \phi(a,b,\cdot,\cdot)=0\Longrightarrow a,b\text{ linearly dependent},\quad \phi=D^4f.
]

For an oriented simple graph \(\vec G\) on \(r\ge2\) vertices, put \(x_i\in\mathbb F_2^8\) and
[
(F_{\vec G})_i(x)=f(x_i)+x_{i,0}x_{i,1}\sum_{j:i\to j}x_{j,0}.
]

## Theorem

Assuming (A), the following hold:

1. \(R_2(F_{\vec G}+Q)=r\) for every vectorial polynomial \(Q\) of degree at most 2.
2. If the underlying graph is connected, \(F_{\vec G}+Q\) is EA-indecomposable for every such \(Q\).
3. For canonical representatives, \(F_{\vec G}\sim_{EA}F_{\vec H}\iff \vec G\cong\vec H\).
4. More generally, \(F_{\vec G}+Q\sim_{EA}F_{\vec H}+Q'\implies \vec G\cong\vec H\). The converse with arbitrary quadratic perturbations is **not** claimed.

## Proof of exact index

For a relaxed subspace \(S\), the constancy of \(D_aD_b(F+Q)\) gives \(D_aD_bD_cD_d(F+Q)=0\) for \(a,b\in S\), \(c,d\in V\). The cubic coupling and quadratic perturbation disappear. Each output component gives \(\phi(a_i,b_i,c_i,d_i)=0\). By (A), each block projection of \(S\) has dimension at most 1. Thus \(\dim S\le r\).

Conversely, \(U=\bigoplus_i\langle e_{i,2}\rangle\) has dimension \(r\). Coupling terms do not involve coordinate 2, and the second differences of each seed vanish for two directions in the same one-dimensional block projection. Quadratic perturbations contribute only constants. Thus \(R_2=r\).

## Intrinsic block recovery

Write \(T=D^4F=\sum_i e_i\phi_i\) and define
[
\mathcal C(T)=\{P\in\operatorname{End}(V):T(Pa,b,c,d)=T(a,Pb,c,d)\ \forall a,b,c,d\}.
]
Condition (A) implies \(\phi_i\) has zero radical. For \(a\in V_j\) and \(b,c,d\in V_i\) with \(i\ne j\), output coordinate \(i\) forces \(\phi_i(P_{ij}a,b,c,d)=0\), hence \(P_{ij}=0\).

If \(P\in\mathcal C(T)\) is idempotent, each diagonal block is idempotent. A diagonal block neither zero nor identity has independent nonzero vectors \(a\) in its image and \(b\) in its kernel. The centroid identity forces \(\phi_i(a,b,\cdot,\cdot)=0\), contradicting (A). Thus the nonzero minimal idempotents are precisely the projections onto individual \(V_i\).

For an EA equivalence \(F_H(x)=B F_G(Ax+t)+L(x)\), one has \(T_H=B T_G(A\cdot,A\cdot,A\cdot,A\cdot)\), so \(\mathcal C(T_H)=A^{-1}\mathcal C(T_G)A\). Minimal idempotents are conjugated, hence \(A\) permutes the input blocks.

## Recovering directed edges

For distinct \(i,j\), restrict the third derivative to \(a,b\in V_i\), \(c\in V_j\). The quartic seeds contribute zero, and the result is independent of the base point:
[
\Theta_{iij}(a,b,c)=\mathbf 1_{i\to j}\,e_i(a_0b_1+a_1b_0)c_0.
]
Therefore \(\Theta_{iij}\ne0\iff i\to j\). The nonvanishing condition is preserved under invertible changes of internal block coordinates, invertible output transformations, input translations, and additions of quadratic polynomials. Thus EA equivalence implies isomorphism of oriented graphs. Conversely, any oriented-graph isomorphism induces a simultaneous permutation of input blocks and output coordinates, giving a linear equivalence of canonical representatives.

## EA indecomposability

Any EA direct-product decomposition yields a nontrivial idempotent in \(\mathcal C(T)\), hence partitions whole blocks. A connected underlying graph has an edge across this partition. Its mixed third derivative is nonzero, whereas every mixed derivative of a direct product is zero. Quadratic perturbations vanish in third derivatives. Contradiction.

## Counting classes

Fix edges \(1\to j\) for \(2\le j\le r\). For every pair among the remaining \(r-1\) vertices, choose no edge, forward edge, or backward edge. This yields \(3^{\binom{r-1}{2}}\) labeled connected oriented graphs. Each isomorphism class contains at most \(r!\) labeled graphs. Hence at least
[
\left\lceil\frac{3^{(r-1)(r-2)/2}}{r!}\right\rceil
]
pairwise EA-inequivalent, indecomposable canonical functions.

## Local finite certificate and scope

For the seed, the contraction \(C_\phi:\Lambda^2\mathbb F_2^8\to(\Lambda^2\mathbb F_2^8)^*\) has rank 22 and kernel dimension 6. Its 63 nonzero kernel bivectors have alternating-matrix ranks 4 (three elements) or 8 (60 elements), never 2. Thus no nonzero decomposable bivector lies in the kernel, proving (A), provided the attached computation is reproduced.

**Not established:** a purely algebraic proof of (A); a biconditional for arbitrary quadratic perturbations; priority/originality in the literature; Lean kernel-checking.
