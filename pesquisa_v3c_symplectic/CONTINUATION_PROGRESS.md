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

The remaining original goal is indecomposability under arbitrary quadratic
perturbations. The graph fourth-derivative radical and its dimension are
certified below. The exact relaxed graph index is proved as an independent
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
4. Continue on this branch with indecomposability modulo quadratic perturbations:
   first certify quadratic D³/D⁴ annihilation, then define a nontrivial product
   decomposition under ordinary EA. Extract input block partitions using the
   certified quartic relation and exclude crossing directed edges using mixed
   D³ and weak connectivity. Ordinary `EAEquivalent` allows only affine
   corrections; quadratic perturbations require separate functions and
   annihilation lemmas. State the graph size/nontrivial-factor conventions
   explicitly, including empty and one-vertex cases.
5. Never modify or merge into V1, V2, or the V3-C reference branch automatically.
