# V3-C EA transport continuation

Base: `83b53a57f47ae33d4694346dc0e315d2a4c38878` on the read-only reference
`v3c-symplectic-generalization-2026-10-08`. Work branch:
`v3c-ea-transport-continuation`. No V1/V2 files or existing proof modules modified.

## Initial audit

Read FORMALIZATION_REPORT.md, PROOF_STATUS.md, EA_TRANSPORT_PROOF_OBLIGATIONS.md,
Polarization.lean, Contraction.lean, Blocks.lean, and the V2 GraphFunction,
LinearTransport, GraphEATransport, GraphBlockRecovery, GraphEdgeRecovery,
GraphClassification modules. Git working tree was clean at the recorded base.
Lean 4.19.0 was installed from the official release and dependencies fetched at
lake-manifest.json revisions. Bare Lake failed before elaboration with
`could not detect the configuration of the Lake installation`. The existing
logs/environment-path-shim.c fixes this container issue, provided Lake and Lean
are invoked by **absolute executable paths**. No proof change was needed.
An initial uncached build was interrupted to fetch the documented Mathlib cache.
The subsequent baseline build and baseline axiom audit both exited 0.

## A: graph map (compiled)

GraphMap.lean defines the exact seed-plus-cubic canonical family with 2m input
coordinates per vertex. `component_formula` identifies it with the specification.
`cubic_fourth_zero` is algebraic, without finite/native evaluation;
`fourth_component` proves the graph fourth derivative equals the certified
pfaffian at every base point. Looplessness is defined for later classification;
the fourth-derivative theorem works even without that restriction.

Logs: lean/logs/continuation/baseline-build.log, baseline-axioms.log,
graphmap-build.log. B–E remain unverified work until recorded otherwise.

## Reproduction in this container

```
gcc -shared -fPIC logs/environment-path-shim.c -ldl -o /tmp/v3c-path-shim.so
export LD_PRELOAD=/tmp/v3c-path-shim.so
export PATH=/tmp/lean-4.19.0-linux/bin:$PATH
/tmp/lean-4.19.0-linux/bin/lake build
/tmp/lean-4.19.0-linux/bin/lake env /tmp/lean-4.19.0-linux/bin/lean Audit.lean
```

Run from pesquisa_v3c_symplectic/lean. On ordinary Linux use lake build and
lake env lean Audit.lean without the adapter. Do not change the reference branch.

## B: EA transport and intrinsic blocks (compiled)

`representation_fourth` handles arbitrary invertible input/output linear maps,
translations and explicitly affine corrections. `representation_pair` derives
quartic pair-zero preservation from actual graph-map equality. `EA_recovers_blocks`
applies the existing Blocks theorem with that derived premise. `graph_fourth`
is the vector-valued graph identity. Standard axioms only, as recorded in
B-axioms.log; B-build.log is a full successful lake build.

Implementation corrections: affine cancellation required scalar ring normalization
rather than a redundant simp after abel_nf, and Pi.zero_apply to normalize the
output zero. Only new modules were changed. B-first-attempt.log records the first
failure. No mathematical hypothesis was added to fix either elaboration issue.

## C: matched output permutation (compiled)

`exists_pfaffian_one` is deduced from certified Property A and two explicit
independent coordinate vectors. `fourth_single` identifies the output coordinate
line. `representation_output_basis` and `representation_output` prove
B(single (perm i) 1)=single i 1 and (B y)(i)=y(perm i), respectively.
No preservation of omega is assumed, including m=2.

C-build.log and C-axioms.log record successful build/audit. The first extension
to arbitrary y failed because rewriting the coordinate decomposition on both
sides also rewrote the target; a one-sided decomposition of B y and a single-term
sum proof fixed it. C-first-attempt.log records the earlier failure.

## D: directed mixed third derivatives (compiled)

`cubic_third` is an algebraic identity. `mixed_third` proves the exact vector
formula at every base point, for arbitrary internal directions. `edge_detected_iff`
identifies nonzero mixed derivatives with the directed adjacency bit for i≠j.
`representation_edges` transports the detection through arbitrary invertible
internal block maps. No restriction on the reverse edge is used.

D-build.log and D-axioms.log record successful build/audit. D-first-attempt.log
records two elaboration failures: the linear-map application needed explicit
unfolding before a finite-sum rewrite, and simplification of the zero seed term
had unfolded the cubic derivatives too soon. Both were corrected in new code.

## E: canonical EA classification (compiled)

`EA_implies_graph_isomorphic` and `graph_isomorphic_implies_EA` give both directions.
`canonical_EA_iff_graph_isomorphic` states their equivalence for every finite
vertex type, all m≥2, and arbitrary loopless Boolean directed adjacency functions.
The empty vertex type is permitted. Bidirectional arcs are permitted. Input and
output maps, translation, and affine correction are quantified in EAEquivalent;
there is no artificial tensor, block, edge, or symplectic-preservation premise.

E-build.log is a full successful lake build. E-axioms.log audits the exported
statements including the final equivalence: only propext, Classical.choice,
Quot.sound. E-first-attempt.log records an explicit-unfolding correction in
coupling reindexing. Existing Polarization/Contraction/Blocks proofs are unchanged.

## Exact scope and remaining work

All requested stages A–E are now compiled for graphs on a common finite vertex
type. Classification of graphs presented on distinct vertex types would need a
heterogeneous EA definition and a transport/reindex bridge; that convenience
extension is not part of the current theorem. No graph-only classification of
arbitrary quadratic perturbations is asserted.

The original dimension, index, and quadratic-robust indecomposability goals
are now certified below. The exact relaxed graph index is proved as an independent
theorem; it is not used in the classification proof. No novelty,
literature-priority, or
publication-readiness claim is made. Builds have only nonfatal Mathlib linter
warnings (unused section parameters and tactic style). Remote CI is distinct
from these local kernel-checked builds.

## Exact vector relaxed index (compiled)

`VonoV3C/GraphRelaxedIndex.lean` defines vector relaxed subspaces and proves
`graph_relaxed_lower_bound`, `graph_relaxed_upper_bound`, and
`graph_has_exact_relaxed_index`. For every finite vertex type `ι`, every
`m ≥ 2`, and every directed adjacency function, the exact vector relaxed
index of `graphMap hm adj` is `Fintype.card ι`. No looplessness hypothesis is
needed for this result.

The proposed value is `Fintype.card ι`. There is a viable lower-bound witness:
in each vertex block, use the vector supported at the second local pair
`⟨1, ...⟩`, with value `(1,0)`. This coordinate is outside the two selected by
`p` and `q`, so the graph cubic coupling is unchanged along every linear
combination of these witness directions. In one output component, the seed
depends only on that same vertex block; the projection of the witness span to
that block is a single line. Its second difference along two vectors on the
line is constant (over `ZMod 2`, the two scalars are each zero or one). The
selected directions are nonzero and have disjoint vertex support, so the
resulting span has dimension `card ι`.

For the upper bound, adapt the V2 projection argument, but prove it using the
V3-C `fourth_component` and `Blocks` property-(A) result. Every pair of
vectors in a vector-relaxed subspace projects at each vertex to zero/equal
vectors; hence each projected subspace has dimension at most one. Injectivity
of the product of coordinate projections gives dimension at most `card ι`.

The witness uses the first component at local pair index 1, where `p` and `q`
both vanish. Thus all graph couplings vanish on the witness space. The seed
term in output coordinate `i` sees only the `i`th input block, and its
projection of the witness space is one-dimensional; over `ZMod 2`, its second
differences on that line vanish. This proves the lower bound. For the upper
bound, constant second differences imply zero fourth differences. The
certified V3-C polarization and Property (A) then force every projected pair
to be zero/equal, so each coordinate image has dimension at most one. The
injective product of the coordinate projections gives the global upper bound.

Verification: the complete `lake build` succeeded after adding the module;
`GraphContinuationAudit.lean` reports only `propext`, `Classical.choice`, and
`Quot.sound` for all three index theorems. Logs are
`lean/logs/continuation/exact-index-build.log` and
`lean/logs/continuation/exact-index-axioms.log`. The module contains no
`sorry`, `admit`, or new axiom.

## Kernel dimension (compiled, 2026-10-09)

Resumed from remote commit `878a0b7fb704f414ab6092a3266b660d7e9dcb4d`.
The local and remote previous commits had identical trees; the local branch
was synchronized to the remote commit before editing. The existing reports
and source search confirmed that the formula was still missing. Pinned Lean
4.19.0 was restored from the official release because the temporary executable
had disappeared. The baseline full build succeeded without any proof change.
A pre-existing missing Batteries documentation symlink (`docs/README.md`) was
restored from the pinned dependency commit; no dependency proof source changed.

`KernelDimension.lean` now adds:

- `blockPairKernel`, `mem_blockPairKernel`: local full-space/singleton-span
  characterization over F₂.
- `pairKernelSpace`, `mem_pairKernelSpace_iff_graphFourth_zero`: a genuine
  submodule equal to the actual graph fourth-derivative radical at all base points.
- `pairKernelPiEquiv`: explicit linear product decomposition.
- `finrank_pairKernelSpace_sum`: sum of local dimensions 2m or 1.
- `supportCount`, `finrank_pairKernelSpace`: the number of nonzero vertex blocks
  and the exact formula `2*m*card ι - (2*m-1)*supportCount a`.
- `graph_fourth_radical_dimension`: the exported existence, characterization,
  and dimension statement for the actual graph function.

All statements are uniform in the finite vertex type, m≥2, and arbitrary
directed adjacency. Empty vertex types, the zero vector, and bidirectional
arcs are included. No experimental enumeration is used. This proves the
dimension claim for the canonical family; it asserts no classification of
arbitrary quadratic perturbations.

Two failed elaboration attempts are preserved. The first needed the root
`finrank_top` name, the exact `Finset.card_filter` identity, and a type annotation
for `Finset.sum_congr`. The second needed explicit `if_pos` rewriting beneath
the finrank subtype and parentheses around the entire summand. These were
syntax/API corrections; no mathematical premise was added.

Logs: `lean/logs/continuation/kernel-dimension-baseline.log`,
`kernel-dimension-first-attempt.log`, `kernel-dimension-second-attempt.log`,
`kernel-dimension-module.log`, `kernel-dimension-build.log`,
`kernel-dimension-axioms.log`, and `kernel-dimension-existing-axioms.log`.
The full build and both audits succeeded. All audited new and existing
declarations use only the standard foundations `propext`, `Classical.choice`,
and `Quot.sound`. Earlier proof modules are unchanged.

## Quadratic perturbations (compiled, 2026-10-09)

Continued from `1befac8a6fa7d7e8ebea72949bdc9f5736d3c451`, after checking
the clean local checkout and matching remote HEAD. The V2 GraphQuadratic,
GraphSplitting, GraphConnected, and GraphEA modules were read as references.
No V2 file was changed. The official pinned Lean runtime was restored inside
the ignored `lean/.lake/lean-4.19.0-linux/` directory; its executable-path shim
is `lean/.lake/v3c-path-shim.so`, built from the existing adapter source.
The baseline build succeeded. A missing Batteries documentation symlink was
restored from its pinned checkout; no dependency proof source was edited.

`GraphQuadratic.lean` defines the intrinsic constant-second-difference
condition and proves third/fourth derivative annihilation, invariance of those
derivatives under quadratic addition, and preservation of the exact vector
relaxed index. `quadratic_ANF_second_constant` proves the intrinsic condition
for arbitrary affine terms plus finite sums of products of linear forms with
arbitrary output coefficients. Thus standard quadratic ANFs are explicitly
covered; the condition does not assume any indecomposability conclusion.

The first attempt failed only when unfolding the function-valued `addVector`
with `rw`; an explicit definitional `change` fixed it. Logs:
`lean/logs/continuation/quadratic-first-attempt.log`, `quadratic-build.log`,
and `quadratic-axioms.log`. The full build and `GraphQuadraticAudit.lean`
succeeded, using only `propext`, `Classical.choice`, and `Quot.sound`.

## Quadratic-robust EA indecomposability (compiled, 2026-10-09)

`GraphSplitting.lean` defines weak connectivity by crossing arcs for every
nonempty proper cut. It proves `graph_no_relaxed_split` and
`graph_quadratic_no_relaxed_split`. The quartic zero-pair relation forces a
partition of whole input blocks via the existing `Blocks.projection_partition`
and `Blocks.single_mem_left`. On a crossing arc, `edge_detected_iff` gives a
nonzero mixed D³. Constant cross second differences would make this D³ zero.
Both orientations of the crossing arc are handled; bidirectional arcs are allowed.

`GraphIndecomposability.lean` proves `EA_product_has_relaxed_split` for an
explicit input linear equivalence to a product of two nontrivial modules,
arbitrary input translation, separate factor functions, arbitrary linear output
mixing, and affine correction. Its pullbacks of the two coordinate kernels are
nonzero and cover the input. Product separation makes cross second differences
zero, while the affine correction also has zero second differences.

`graph_not_EA_product` certifies the canonical family.
`graph_quadratic_not_EA_product` certifies perturbations with constant second
differences. `graph_quadratic_ANF_not_EA_product` discharges this condition for
arbitrary explicit quadratic ANFs; it assumes no tensor, block, or edge
preservation result. Its only substantive family hypotheses are m≥2 and weak
connectivity. Both candidate input factors must be nontrivial, as required by
the standard indecomposability notion. Output mixing need not be invertible,
so ordinary invertible EA output maps are covered as a special case.

The splitting and product-bridge modules compiled on their first attempts.
Logs: `splitting-first-attempt.log`, `indecomposability-first-attempt.log`,
`indecomposability-build.log`, `indecomposability-axioms.log`, and
`indecomposability-existing-axioms.log`, all in `lean/logs/continuation/`.
The final default `lake build` and both audits exited 0. Standard axioms only:
`propext`, `Classical.choice`, and `Quot.sound`. No prior proof module was edited.

Mathematical boundaries: no converse for arbitrary quadratic perturbations of
disconnected graphs is claimed; no graph-only ordinary EA classification of
those perturbations is claimed. Empty and one-vertex graphs are handled by the
cut convention and nontrivial factor requirement. A separate link to Mathlib's
polynomial-degree API has not been supplied, while arbitrary quadratic ANFs
have explicit certificates. Novelty and publication readiness are not inferred
from compilation.

To reuse the cached runtime in this container, run from `lean/`:

```sh
LD_PRELOAD=$PWD/.lake/v3c-path-shim.so PATH=$PWD/.lake/lean-4.19.0-linux/bin:$PATH $PWD/.lake/lean-4.19.0-linux/bin/lake build
LD_PRELOAD=$PWD/.lake/v3c-path-shim.so PATH=$PWD/.lake/lean-4.19.0-linux/bin:$PATH $PWD/.lake/lean-4.19.0-linux/bin/lake env $PWD/.lake/lean-4.19.0-linux/bin/lean GraphContinuationAudit.lean
```

The cached runtime is ignored by Git; the portable pinned project is unchanged.
On an ordinary Lean 4.19.0 installation, use the ordinary `lake` commands above.

## Publication preparation (2026-10-09)

Restored the clean checkout to remote `7924bc8` before proceeding. Confirmed
that the new mathematical results and the preliminary positioning note already
existed, while a V3-C manuscript did not. Added `MANUSCRIPT_DRAFT.md` with
explicit hypotheses, proofs, declaration correspondence, and reproduction
instructions. Added `PUBLICATION_REVIEW_2026-10-09.md` with primary-source
comparison, unresolved novelty questions, and a precise pre-submission checklist.
V1, V2, the reference branch, and existing Lean proof sources are unchanged.

The full build passed again; `publication-baseline-build.log` is in
`lean/logs/continuation/`. The continuation and original axiom audits are
recorded in `publication-axioms.log` and `publication-existing-axioms.log`.
The 2026/940 full PDF remained inaccessible (direct HTTP 403), so the review
uses only its official abstract and implementation README and explicitly leaves
the full-paper comparison pending. No priority or publication-readiness claim
has been added. This advance is manuscript/review work, not a new Lean theorem.

## Manuscript correspondence and input-model review (2026-10-09)

Continued from remote `cd29f92c06f5a02122649765acb3a926a86793c3`, after a
clean-tree fast-forward of the restored local checkpoint. Expanded Lemma 3's
proof in `MANUSCRIPT_DRAFT.md`, following the already compiled projection
partition and block-assignment argument. Rechecked its hypotheses and the
classification, output orientation, index witness, radical, and quadratic
product obstruction against the corresponding Lean sources. This was a
self-review by the continuing agent, not an independent referee report.

Added `LITERATURE_INPUT_MODEL_REVIEW.md`. The Kaleyski–Sunde implementation is
fixed at `c9cec6515b3297abf5c15fedd23e55b43f2ba888`, with hashes and permanent
links for the inspected files. Its polynomial-input wrapper materializes a
complete truth table before EA search. This is a source observation about
that wrapper, not a lower bound or a comparison of algorithm running times.
The full 2026/940 paper still could not be accessed. Retrieved the versioned
Canteaut–Couvreur–Perrin PDF (arXiv:2103.00078v3), inspected selected quadratic
Jacobian/ortho-derivative statements, and added the comparison and citation.
Novelty remains unresolved.

The official pinned runtime and existing executable-path shim were restored
in ignored `.lake/` paths; the missing pinned Batteries documentation symlink
was restored. The full build and Audit, GraphQuadraticAudit, and
GraphContinuationAudit all exited 0. New logs are
`lean/logs/continuation/manuscript-review-{build,existing-axioms,quadratic-axioms,axioms}.log`.
Standard foundations only: `propext`, `Classical.choice`, and `Quot.sound`.
No new Lean theorem, proof-module change, or global configuration change was
introduced. V1, V2, and the V3-C reference branch remain untouched.

## Handoff

1. Checkout v3c-ea-transport-continuation; verify the remote SHA and clean status.
2. In pesquisa_v3c_symplectic/lean, use pinned Lean/Mathlib 4.19.0 and the cache
   command from FORMALIZATION_REPORT.md; run lake build, lake env lean Audit.lean,
   and lake env lean GraphContinuationAudit.lean. Use the absolute-path adapter
   above only for this container's executable-detection failure.
3. Read the five Graph*.lean modules in A–E order and the E axiom/build logs.
   `representation_output` has inverse output orientation relative to the input
   permutation. `mixed_third` is constant only for the cross-block directions
   it specifies, not for arbitrary third derivatives of the quartic seed.
4. Read GraphQuadratic, GraphSplitting, and GraphIndecomposability in that order.
   Run GraphQuadraticAudit and the expanded GraphContinuationAudit. The original
   proof obligations are complete within their recorded scope. Further tasks
   are a heterogeneous vertex-type bridge, a polynomial-degree API bridge if
   needed, and a manuscript/literature/independent-review pass. Keep arbitrary
   quadratic perturbations separate from canonical graph classification; the
   indecomposability theorem is a forward connectedness obstruction, not a
   classification or a claimed converse.
5. Never modify or merge into V1, V2, or the V3-C reference branch automatically.
