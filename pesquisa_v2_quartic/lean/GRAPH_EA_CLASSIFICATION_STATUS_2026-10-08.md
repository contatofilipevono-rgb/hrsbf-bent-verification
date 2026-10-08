# V2: completed canonical directed-graph EA classification

This certificate extends commit f148bc6be50215399769f6130e1fb34f44459111. The earlier graph-status document is preserved as a historical snapshot; its classification limitation is resolved by the modules described here.

## Main statement and scope

Fix a finite vertex type I, the same certified eight-variable seed in every block, and two loopless Boolean directed adjacencies G and H. Define the canonical functions as in GraphFunction.lean.

`canonical_EA_iff_graph_isomorphic` proves:

F_G and F_H are EA-equivalent if and only if G and H are isomorphic as directed graphs.

Here `EAEquivalent` has its full explicit meaning: there exist invertible linear input and output maps A and B, an arbitrary input translation t, an arbitrary linear affine correction L, and a constant output k, with

F_H(x) = B(F_G(Ax+t)) + L(x) + k.

`GraphIsomorphic` requires a vertex permutation p with H(i,j)=G(p(i),p(j)) for every ordered pair i,j. The proof applies to all loopless directed graphs, including graphs with edges in both directions, and therefore covers oriented simple graphs. Connectedness is not required for classification. Both graphs have the same finite vertex type; graphs on a common Fin r are the standard instance.

`quadraticEA_implies_graph_isomorphic` proves a stronger necessary implication when the affine correction is replaced by any function with constant second differences.

`perturbed_EA_implies_graph_isomorphic` proves that EA equivalence of F_G+Q_G and F_H+Q_H implies graph isomorphism, for every Q_G,Q_H with constant second differences. `ANF_perturbed_EA_implies_graph_isomorphic` explicitly discharges that condition for arbitrary affine-plus-quadratic ANF. The converse for arbitrary perturbations is not asserted.

## Proof structure

1. GraphEATransport.lean defines vector-valued iterated finite differences and proves their exact transformation under input translation, invertible linear input and output maps, and quadratic correction.
2. The full seed Property A identifies zero fourth-difference contractions with coordinatewise zero-or-equal pairs. No seed assumption is added to the classification theorem.
3. GraphBlockRecovery.lean recovers the input blocks directly from this pair relation. Pulling back each target block and its complement gives a spanning split. The existing projection partition theorem forces each source block wholly into one target block. An injective map of the finite eight-dimensional block to itself is surjective; different source blocks cannot map onto the same target block. Thus the input transformation induces a vertex permutation and an invertible internal linear map in each block. This avoids an unformalized centroid argument.
4. GraphEdgeRecovery.lean proves that a mixed third difference with two directions in block i and one in distinct block j is nonzero for some directions/base point exactly when i points to j. This detection is preserved by the recovered internal changes, translations, and invertible output map.
5. GraphClassification.lean proves the converse by explicitly permuting input blocks and output coordinates using the graph isomorphism. It combines both directions into the EA biconditional.
6. GraphPerturbedClassification.lean absorbs both quadratic perturbations into a quadratic correction and applies the canonical necessary implication.

## Validation and trust

Lean 4.19.0; pinned Mathlib c44e0c8ee63ca166450922a373c7409c5d26b00b.

Validated commands:

```
lake build
lake env lean SeedPropertyAAudit.lean
lake env lean GraphFamilyAudit.lean
lake env lean GraphClassificationAudit.lean
```

The stored logs under validation/graph-classification/ cover the full build, regression audits, classification theorem signatures and dependency audits. The source scan forbids proof placeholders and custom axiomatic declarations across every VonoExactIndex module. Audit dependencies are confined to propext, Classical.choice, Quot.sound and Lean.ofReduceBool; no sorryAx appears. The native_decide / Lean.ofReduceBool trust boundary remains explicit, including the inherited seed certificate and the small cubic finite certificate. Linter warnings do not indicate unproved goals.

## Preservation and remaining scope

V1, the seed bridge, exact-index modules, connected indecomposability certificates, existing audits, workflows and stored validation logs are unchanged. This branch adds five modules, a classification audit, documentation, logs and an isolated CI workflow; the root import exposes the new certificates.

This completes the previously stated canonical classification task. It does not establish novelty or literature priority, a biconditional for arbitrary quadratic perturbations, or the quantitative lower bound on the number of isomorphism classes. The explicit infinite family, exact index and connected EA indecomposability remain certified by the preceding commit.
