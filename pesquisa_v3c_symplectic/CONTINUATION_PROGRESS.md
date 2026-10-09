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
