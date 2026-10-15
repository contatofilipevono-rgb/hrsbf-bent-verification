# Independent Astra mission: prove the missing half of Lemma 5.1 in Lean

**Repository:** https://github.com/contatofilipevono-rgb/hrsbf-bent-verification
**Frozen starting branch:** `formal/antipodal-global-completion-2026-10-14`
**Baseline kernel run:** https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/38668595156
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

A precise kernel run established the printed axioms are exactly `propext, Classical.choice, Quot.sound`.

## Essential missing subgoals

1. Show the polar radical R is an S-invariant F₂-linear subspace/ideal, and `B_Q≠0 → R≠V`.
2. Under cyclic identification `V≃ F₂[X]/(X^N-1)`, prove `N=2^k` gives a local ring with maximal ideal (X+1); every proper S-invariant ideal is contained in `im(S+I)`.
   - An alternative entirely elementary cyclic-module proof is welcome. No use of unproved unit assumptions.
3. Prove **integer** quadratic Gauss identity (including Q(0)):
   `(∑ₓ (-1)^Q(x))² = |V| * ∑_{r∈R} (-1)^(Q(r)+Q(0))`.
   - Use `QuadraticPolar` and `sum_sign_additive`; no inference that a finite test proves all N.
4. Substitute Q constant on R and derive the contradiction to balance.
5. Integrate the final lemma with `DerivativeBridge.lean` while keeping all previous theorem statements unchanged.

## Strict certification

- Create a new branch, e.g. `formal/astra-quadratic-rigidity-independent`; **do not force-push or rewrite the baseline**.
- No `sorry`, `admit`, `axiom`, `unsafe` proof shortcuts, `native_decide`, `Lean.ofReduceBool`, or private hypotheses that merely restate the target.
- Build with `lake build` plus `lake env lean Antipodal/<new>.lean`; run `#print axioms` on **the final theorem itself**.
- Provide GitHub commit SHA, CI run URL, exact complete theorem signature, dependency graph, and any counterexample if the mathematical statement is false.
- If proof is incomplete, publish only certified auxiliary lemmas, and report exact unproved goals.

**Independent adversarial warning:** do not confuse manuscript publication with a certified kernel proof. Review the local-ring/unit and Gauss-sum arguments for circularity, changes of degree under restriction, and constants.
