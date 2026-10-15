# Independent Astra mission: prove the missing half of Lemma 5.1 in Lean

**Repository:** https://github.com/contatofilipevono-rgb/hrsbf-bent-verification
**Frozen starting branch:** `formal/antipodal-global-completion-2026-10-14`
**Latest clean kernel run:** https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/38670063342
**Toolchain:** Lean 4.15.0; pinned Mathlib `9837ca9d65d9de6fad1ef4381750ca688774e608`

You are an independent adversarial mathematics/Lean collaborator. **Do not mark global nonexistence complete** until the exact universal statement type-checks without hidden assumptions.

## Mathematical objective

Let `N=2^k` (k≥1), `V=Fin N→ZMod 2`, S the cyclic coordinate rotation, and Q a Boolean function with third additive difference zero (degree ≤2), invariant under S. Define

`B_Q(u,v)=Q(u+v)+Q(u)+Q(v)+Q(0)`.

Prove, with no assumptions on the coefficients and including affine/constant terms,

`(∑ x : V, sign (Q x) = 0) → (∀ u v, B_Q(u,v) = 0)`.

This is the universal quadratic rigidity statement in the paper, not the whole cubic theorem.

## Existing *certified* building blocks

In `formalization/Antipodal/`:
- `QuadraticPolar.lean`: `quadratic_polar_add_left`, `quadratic_polar_add_right` from zero third differences.
- `QuadraticRadical.lean`: `radical_image_value_zero`, `radical_vanishes_of_image` and `sum_sign_additive`.
- `Fourier.lean`: integer signs and Parseval/character orthogonality.
- `QuadraticGauss.lean`: **proven** integer Gauss-square identity `quadratic_walsh_square` for all finite binary vector spaces.
- `QuadraticBalanceBridge.lean`: **proven** `quadratic_unbalanced_of_radical_constant` and `balanced_polar_zero_of_proper_radical_image` (the latter **explicitly conditional** on radical-image inclusion).

A precise kernel run established the printed axioms are exactly `propext, Classical.choice, Quot.sound`.

## Single critical missing mathematical theorem

1. Show the polar radical R of a quadratic Q is an S-invariant F₂-linear subspace, and show nonzero polar forces R proper.
2. For N=2^k, rigorously establish:
   `(∃ a b, B_Q(a,b) ≠ 0) → ∀ r, (∀ x, B_Q(r,x)=0) → ∃ y, r = S y + y`.
   - Use cyclic-module identification `V ≃ F₂[X]/((X+1)^N)` if helpful, or give a finite-dimensional elementary constructive proof.
   - Key: for a proper S-invariant ideal, every element is a nonunit and hence has even coefficient parity.
   - Ensure equivalence of ideal containment and the exact `S y + y` statement with no hidden assumption.
3. Instantiate the *already compiled* `balanced_polar_zero_of_proper_radical_image` to prove universal quadratic rigidity. Do NOT re-prove the Gauss formula as the main task; audit it adversarially if desired.
4. Integrate with `DerivativeBridge.lean`, keeping the original proof statements untouched. Then state which *cubic* bridges remain outstanding.

## Strict certification

- Create a new branch, e.g. `formal/astra-quadratic-rigidity-independent`; **do not force-push or rewrite the baseline**.
- No `sorry`, `admit`, `axiom`, `unsafe` proof shortcuts, `native_decide`, `Lean.ofReduceBool`, or private hypotheses that merely restate the target.
- Build with `lake build` plus `lake env lean Antipodal/<new>.lean`; run `#print axioms` on **the final theorem itself**.
- Provide GitHub commit SHA, CI run URL, exact complete theorem signature, dependency graph, and any counterexample if the mathematical statement is false.
- If proof is incomplete, publish only certified auxiliary lemmas, and report exact unproved goals.

**Independent adversarial warning:** do not confuse manuscript publication with a certified kernel proof. Review the local-ring/unit and Gauss-sum arguments for circularity, changes of degree under restriction, and constants.
