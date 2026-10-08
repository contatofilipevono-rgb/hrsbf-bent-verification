# V2 — Sol 6.1 audit integration and submission gate

## Audit findings incorporated

The Sol 6.1 audit reported the main graph-family claims valid, conditional on the eight-variable seed certificate. Two presentation corrections were explicitly requested:

1. Write **oriented** graphs as G with an arrow (in LaTeX, `\\vec G`), because edge directions matter.
2. Do **not** say that the global third derivative of the quartic map is constant. Only the mixed restriction with two arguments in V_i and one in V_j (i≠j) is base-point independent.

Both points are addressed in `manuscript/main.tex` on this branch. The revised proof now explains why EA input translations preserve that mixed restriction: the quartic part has no terms crossing different input blocks, so the corresponding mixed fourth derivatives vanish.

## Claims and exact scope

- R₂(F_{G}+Q)=r for vectorial quadratic Q.
- Connected underlying graph => EA indecomposability, including quadratic perturbations.
- Canonical representatives are EA-equivalent iff their **oriented** graphs are isomorphic.
- For arbitrary quadratic Q,Q', EA equivalence implies oriented-graph isomorphism; the reverse implication is **not** claimed.
- Local seed property (A) is a finite-computation premise, checked by `V2_graph_no_extra_output.py`. The proof for all graph sizes is not Lean formalized.

## Pre-submission checks still required

1. Independently run the seed script and record its output and Python version.
2. Compile LaTeX and resolve any warnings or notation issues.
3. Verify full bibliographic metadata and prior-art priority, especially tensor-centroid decompositions and EA classification by graph encodings.
4. Obtain final adversarial review of the *revised* manuscript (a targeted delta review suffices; no need to redo all previous tests).
5. Ensure the statement of EA indecomposability uses a clear definition of admissible direct-product decomposition, including nonzero input/output factors.

This branch is isolated from main and V1. No claim of completed publication-readiness is made.
