# Publication review and continuation checklist

Date: 2026-10-09. Source baseline: `7924bc8815729256f407f6a6ef18074537ac64ef`.
Branch: `v3c-ea-transport-continuation`.

## What was already done

The remote branch already contained the canonical classification, radical
dimension, exact simultaneous relaxed index, quadratic derivative stability,
and quadratic-robust EA indecomposability. These results were not reconstructed.
`PUBLICATION_POSITIONING.md` already discussed the GI reduction. There was no
V3-C manuscript in this checkout. `MANUSCRIPT_DRAFT.md` is the new manuscript;
the V2 manuscript and priority reports remain separate and unchanged.

The local checkout was behind the remote branch at `1befac8`. A clean-tree
fast-forward restored the two already published commits to `7924bc8` before
writing. No reference branch or old proof module was changed.

## Sources inspected and limits of comparison

| Source | Material actually inspected | Consequence for claim language |
|---|---|---|
| Agrawal–Saxena, *Equivalence of F-algebras and cubic forms*, author-hosted 2005 manuscript | Full PDF text; abstract, introduction and definition of cubic-form equivalence | GI-to-algebraic-equivalence reductions have prior art. Avoid a broad first-reduction claim. Formal polynomial equality under linear substitution differs from the vectorial Boolean EA target here. Exact overlap remains a review question. |
| Polujan–Pott, *Cubic bent functions outside the completed Maiorana–McFarland class*, DOI 10.1007/s10623-019-00712-y | Publisher full text, Definitions 4.1–4.2 and Proposition 4.4 | Credit the scalar relaxed-subspace/index framework. Our condition is simultaneous across vector coordinates. |
| Kaleyski–Sunde, ePrint 2026/940 | Official abstract and authors' implementation README | General EA/CCZ algorithms and automorphism computation are relevant neighbors. README accepts truth tables and Sage polynomials; that alone gives no polynomial compact-ANF complexity guarantee. Full-paper comparison is pending. |

Primary-source URLs:

- https://www.cse.iitk.ac.in/users/manindra/algebra/algebras-cubicforms2.pdf
- https://link.springer.com/article/10.1007/s10623-019-00712-y
- https://eprint.iacr.org/2026/940
- https://github.com/zskiley/CCZ-EA-equivalence/blob/main/README.md

Retrieval of `https://eprint.iacr.org/2026/940.pdf` failed through the web
retriever and direct download (HTTP 403). No conclusion about an absent theorem
in that paper is justified. Searches for graph-isomorphism/EA and
quartic/symplectic/Boolean connections were a screening step, not an exhaustive
priority audit. No third-party search snippet is used as theorem evidence.
The README is mutable; freeze its commit before a final citation or benchmark.

## Mathematical checks on the draft

- Classification has m≥2, common finite vertex type, and loopless graphs.
  Both arc orientations are permitted. Arbitrary quadratic perturbations are
  not claimed to share that graph-only ordinary EA classification.
- The input block permutation sends H block i to G block π(i); output recovery
  is `(B y)i=y(π(i))`. The manuscript follows this orientation.
- Fourth derivatives are constant for the graph family. The displayed mixed
  third derivative is constant for its specified two-block directions; arbitrary
  third derivatives of a quartic function are not called constant.
- The m=2 proof uses zero-pair rigidity, not an unsupported assertion that all
  quartic stabilizers preserve the symplectic form.
- Radical support counts nonzero vertex blocks. The zero vector and empty
  vertex set are included.
- R₂ is a simultaneous vector relaxed index. It is not the scalar linearity
  index of a bent function. No bentness/APN/security theorem is inferred.
- Quadratic coverage uses an explicit affine-plus-products-of-linear-forms
  ANF, whose derivative condition is proved. A separate polynomial-degree API
  bridge has not been formalized.
- Indecomposability allows arbitrary linear output mixing; both candidate
  input factors are nontrivial. Cut connectivity includes empty/singleton
  cases. No quadratic-perturbation converse is asserted.
- At m=2 an undirected graph gives r+2|E| monomials; the compact-ANF complexity
  consequence is elementary mathematics, not a Lean complexity certificate.

## New reproduction check

The official Lean 4.19.0 runtime and the existing executable-path adapter were
restored in ignored `.lake/` locations. The pinned Batteries documentation
symlink `docs/README.md` was restored; no dependency proof was edited.

From `pesquisa_v3c_symplectic/lean`, the full `lake build` exited 0; log:
`logs/continuation/publication-baseline-build.log`. Existing linter warnings
remain; the build reports success. The continuation axiom audit is recorded in
`logs/continuation/publication-axioms.log`; the seed/block audit is recorded in
`logs/continuation/publication-existing-axioms.log`.

## Precise next steps before submission

1. Obtain and inspect the full 2026/940 paper. Record version/date and theorem
   statements concerning representations, complexity, higher derivatives, and
   automorphisms. Do not infer these from the abstract.
2. Extend formula-level prior-art comparison to graph encodings by vectorial
   functions, tensor zero-pair block recovery, and connected indecomposability.
   Search failure does not establish novelty.
3. Have an independent researcher check the manuscript against the Lean
   declarations, especially Lemma 3, the index witness, and product-factor
   nontriviality. The draft contains proof outlines where explicitly labeled.
4. Supply authorship and affiliations from the actual contributors. Convert
   the reviewed text to the chosen journal/preprint format and check its
   bibliography and rendered equations. The present Markdown draft is not a
   submitted or typeset publication.
5. If more mathematics is needed, prioritize the heterogeneous vertex-type
   bridge or the internal EA automorphism stabilizer. Avoid claiming that the
   full EA automorphism group is exactly the graph automorphism group.
6. Run the pinned full build and all three audits from a fresh environment,
   archive the exact commit and logs, and only then select submission claims.

The candidate contribution is a uniform explicit family with complete
canonical classification, derivative-based recovery, and quadratic-robust
indecomposability backed by machine-checked proofs. Publication relevance is
plausible; novelty and acceptance are not established by this review.
