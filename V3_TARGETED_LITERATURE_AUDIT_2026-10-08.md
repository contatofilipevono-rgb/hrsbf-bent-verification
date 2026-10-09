# V3 targeted literature audit — 2026-10-08

## Question
Is there prior work combining (i) a directed graph indexed family of quartic vectorial Boolean functions, (ii) a complete EA iff digraph-isomorphism theorem, and (iii) an exact relaxed M-subspace index?

## Findings from focused search
1. Canteaut, Couvreur, Perrin, *Recovering or Testing Extended-Affine Equivalence*, IEEE TIT (2022), https://ieeexplore.ieee.org/abstract/document/9758689. EA recovery and invariants for vectorial Boolean functions; not the same explicit graph family in the abstract.
2. Kaleyski, *Deciding EA-equivalence via invariants*, Cryptography and Communications, https://link.springer.com/article/10.1007/s12095-021-00513-y. General EA invariants for (n,m)-functions, focused on quadratic APN examples.
3. *Design and Analysis of Bent Functions Using M-Subspaces*, IEEE, https://xplorestaging.ieee.org/document/10388463/. M-subspaces, invariance, graph methods for partial spreads, and extension of differential concepts to vectorial functions. Relevant to index terminology and novelty.
4. *Equivalence of 2-rotation symmetric quartic Boolean functions*, Information Sciences, https://www.sciencedirect.com/science/article/pii/S002002551930828X. Quartic rotation symmetric scalar classification; different equivalence and object.
5. *The number of affine equivalent classes and extended affine equivalent classes of vectorial Boolean functions*, Discrete Applied Mathematics, https://www.sciencedirect.com/science/article/pii/S0166218X20304571. Existing general counting literature.
6. Agrawal–Saxena, *Equivalence of F-algebras and cubic forms* (STACS 2006), DOI https://doi.org/10.1007/11672142_8. Prior graph-isomorphism reduction to cubic-form equivalence, cited in https://www.microsoft.com/en-us/research/wp-content/uploads/2016/02/Poly20Equiv.pdf.
7. *On the Complexity of Isomorphism Problems for Tensors, Groups, and Polynomials I: Tensor Isomorphism-Completeness*, SIAM Journal on Computing, https://epubs.siam.org/doi/10.1137/21M1441110. Modern framework of isomorphism reductions; essential complexity context.

## Provisional verdict
No identical construction was located in these sources, but this is NOT proof of novelty. Search coverage is non-exhaustive. Do not claim first-ever GI-hardness, graph encoding, M-subspace invariant, or quartic classification.

## Defensible central claim
A concrete, Lean-certified complete EA classification of canonical graph-indexed quartic vectorial Boolean maps with exact relaxed vector index, for arbitrary finite loopless directed graphs. Distinguish this from all-Boolean-function EA classification and from GI-hardness on truth-table input.

## Immediate checks for publication
- Compare definitions of relaxed M-subspace index with the established literature (some definitions use D_aD_b f=0, while relaxed permits constant).
- State the `Lean.ofReduceBool` trust boundary from native_decide.
- Verify GI reduction uses polynomial-size ANF/circuit encoding.
- Obtain exact GitHub Actions run ID/log before saying independently verified.
- Seek peer review specifically on the fourth-derivative block-recovery criterion and mixed-third-derivative arc recovery.

No changes to V1/V2 source files.
