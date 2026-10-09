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
