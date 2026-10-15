# Gap register — GLOBAL NOT PROVED

| ID | Severity | Exact outstanding obligation | Next step |
|---|---|---|---|
| G1 | Critical | For RS `f` of canonical ANF degree≤3 in dimension `2^k`, prove that zero antipodal coefficient forces `f(joinBlocks h(diagonal u))=f 0` for all u. | Pair ANF supports by half-turn. Nonfixed supports cancel; classify fixed supports of size≤3 as empty or antipodal pairs. Use proved ANF permutation covariance. Feed the identity into `not_bent_constant_diagonal_power_two`. |
| G2 | Critical | For `n=t*m`, t a positive power of two, m odd, construct `S=rotation^t`, prove `S^m=I`, and give explicit linear `Vec t ≃ₗ fixedSubspace S` using repeated blocks. | Use the proved cyclic power coordinate formula and prefix/repetition arithmetic; apply `odd_order_bent_restriction_of_anf_degree`. Prove induced rotation compatibility. |
| G3 | Critical | Prove canonical antipodal coefficient is unchanged by odd folding, including degree drops, short orbits and cancellations. | Use canonical reconstruction and covariance; pair preimage supports under the original half-turn or formalize distinct-orbit fiber counting. Existing `OddMultiplicity` alone is insufficient. |
| G4 | Critical | Assemble the exact universal all-even-dimensional antipodal theorem and derive the universal homogeneous cubic corollary. | Close G1--G3; use the existing two-variable endpoint; print the exact theorem axioms and build it as a root target. |
| G5 | Important | Establish canonical degree transport under concrete folding. | Linear substitution preserves `HasCubicRepresentation` (proved). Either prove its converse canonical degree bound or directly bound canonical coefficients of the substituted polynomial. |

## Deliberate boundaries

The theorem `odd_order_bent_restriction_of_anf_degree` quantifies over a linear coordinate equivalence onto the **actual** fixed subspace. It does not assume restricted bentness or any balance lemma; G2 concerns constructing that equivalence for the concrete rotation.

`not_bent_constant_diagonal_power_two` still assumes the constant-diagonal identity and is explicitly intermediate. `not_bent_homogeneous_cubic_power_two` discharges it using actual canonical homogeneity and a free half-turn. Neither result is the requested universal antipodal necessity theorem.

No mathematical impossibility or counterexample to the manuscript theorem is being asserted. The remaining blockers are exact unimplemented general lemmas, not tolerated proof holes. No incomplete Lean theorem with a placeholder is checked in.
