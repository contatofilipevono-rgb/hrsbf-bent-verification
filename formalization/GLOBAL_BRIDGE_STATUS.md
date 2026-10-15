# LATEST: universal antipodal theorem kernel-certified in clean CI (15 October 2026)

The isolated branch `formal/astra-global-antipodal-2026-10-15` now contains the exact universal theorem and homogeneous cubic corollary. Core source: `9f186bc871361b263a9356a8d80cbcc837db21de`. Clean CI run 38682075049 completed successfully; its actual job log was retrieved and inspected. See `research/astra-global-2026-10-15/KERNEL_CERTIFICATE.md` and `FINAL_STATUS_GLOBAL.md`.

The proof constructs the odd cyclic fixed-space coordinates and transports the zero-antipodal obstruction directly. It does not assume the full coefficient-folding identity. The historical open-gap notes below are superseded by the new branch's GAP_REGISTER.md.

---

## Historical checkpoints (superseded)

# Lean global antipodal bridge — state of proof (14–15 October 2026)

> **Independent quadratic completion:** `Antipodal/CyclicQuadraticRigidity.lean` now discharges the concrete cyclic order and parity-image obligations and proves unconditional quadratic rigidity. See [INDEPENDENT_QUADRATIC_RIGIDITY_REPORT.md](INDEPENDENT_QUADRATIC_RIGIDITY_REPORT.md). The historical entries below describe earlier checkpoints. The universal cubic theorem remains unproved.

**Branch:** `formal/antipodal-global-completion-2026-10-14`  
**Baseline:** `57d561393d546e00fbcd3c95cfce1158bfda9a23`  
**Toolchain:** Lean `4.15.0`; Mathlib `9837ca9d65d9de6fad1ef4381750ca688774e608`.

## Proven, with original kernel evidence preserved

- The baseline `formalization/Antipodal/*.lean` 52-result fiber core compiles in GitHub Actions (seen on runs `38663462356` and `38664372468`).
- `Antipodal/OddMultiplicity.lean` formalizes two characteristic-two statements: even orbit multiplicity cancels, odd multiplicity preserves coefficients. Axiom audits contain only `propext`, `Classical.choice`, and `Quot.sound`, with no `sorryAx`.
- **New kernel-certified dimension-2 endpoint:** `Antipodal/Endpoint2.lean` now proves `HRSBF.Antipodal.bent_implies_antipodal_in_two_variables` from the exact four-term integer Walsh equation, using no reflective axioms. Compiled successfully in GitHub Actions run `38665788312`; the printed axioms are precisely `propext`, `Classical.choice`, and `Quot.sound`.
- **New conditional consequences:** `Antipodal/DerivativeBridge.lean` contains `bent_forces_derivative_polar_witness` and `bent_forces_nonconstant_diagonal`, which use the existing 52-result fiber contradiction and express its contrapositive in a form ready for the quadratic rigidity bridge. Both compiled and passed `#print axioms` in run `38666055432`. They do not prove quadratic rigidity or the full antipodal theorem.
- The material in the earlier A100 audit remains unchanged by this branch except for new files under `formalization/` and the new isolated CI workflow.

## Quadratic rigidity progress — new Lean certificates

**Clean kernel run:** https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/38668595156

**Pinned Lean:** 4.15.0, Mathlib `9837ca9d65d9de6fad1ef4381750ca688774e608`.

Five additional declarations are now compiled and have explicit `#print axioms` records limited to `propext`, `Classical.choice` and `Quot.sound`:

1. `radical_image_value_zero`: if `r = S y + y`, `Q ∘ S = Q` and `polar Q r y = 0`, then `Q r = Q 0`.
2. `radical_vanishes_of_image`: if the entire polar radical is in `im(S+I)`, then `Q` is constant on that radical.
3. `sum_sign_additive`: exact vanishing of every nontrivial additive sign-character sum on `Vec n`.
4. `quadratic_polar_add_right`: vanishing third differences imply additivity of the normalized polar in the second argument.
5. `quadratic_polar_add_left`: the corresponding additivity in the first argument.

**Not yet obtained:** the module-theoretic result that a *proper* cyclic invariant polar radical lies in `im(S+I)` when the dimension is a power of two; the exact integer quadratic Walsh-square/radical formula; their integration to give `IsBalanced Q → polar Q = 0`. These remain actual mathematical proof obligations, not `sorry` placeholders.

**Boundary:** None of the above asserts that the universal cubic antipodal theorem has been formalized.

## Exact Gauss identity and conditional quadratic-rigidity closure — NEW

**Certified GitHub Actions:** https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/38670063342
**Tested commit:** `a951e0ed177e4a49aa29c53320481b28f7e46b68`

Lean 4.15.0 and the pinned Mathlib version accept the three new statements; `#print axioms` reports only `propext`, `Classical.choice`, and `Quot.sound` for each, with zero `sorryAx`.

- `Antipodal/QuadraticGauss.lean`: `quadratic_walsh_square` gives the **exact integer identity** for any finite binary vector space:
  `(∑ x, sign (Q x))² = |V| * ∑ r, if (∀ x, polar Q r x = 0) then sign (Q r + Q 0) else 0`,
  assuming vanishing third differences.
- `Antipodal/QuadraticBalanceBridge.lean`: `quadratic_unbalanced_of_radical_constant` shows a quadratic constant on its polar radical cannot be balanced, since the nonempty radical contributes strictly positive Gauss weight.
- `Antipodal/QuadraticBalanceBridge.lean`: `balanced_polar_zero_of_proper_radical_image` formalizes the desired quadratic-rigidity deduction **conditional on an explicit local-ring image premise**, quantified only when the polar is nonzero.

**Exact remaining critical obligation:** for N=2^k and the actual cyclic permutation S, derive the premise
`(∃ a b, polar Q a b ≠ 0) → ∀ r ∈ rad(B_Q), ∃ y, r = S y + y`,
from rotation invariance, quadraticity and the power-of-two cyclic module, **without assuming it as a hypothesis**.

This is the next mission assigned to independent Astra review at `ASTRA_MISSION_LEMMA_5_1.md`.
No universal antipodal proof is claimed by this entry.

## New certified cyclic-Nakayama bridge (October 15, 2026)

**Clean source commit:** `0a6b8e1a3450562cbc455f2486e8131efea95dde`  
**GitHub Actions:** https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/38671993921  
**Outcome:** successful `lake build` and standalone module checks; all five new theorem axiom reports include only `propext`, `Classical.choice`, `Quot.sound`, without `sorryAx`.

1. `RadicalInvariant.lean` proves `radical_stable_under_linear_equiv` and `radical_proper_of_nonzero_polar`; it also constructs `radicalSubmodule`.
2. `PowerTwoNilpotence.lean` proves `shift_plus_one_nilpotent`: for any binary-module endomorphism S with S^(2^k)=I, (S+I)^(2^k)=0.
3. `NilpotentNakayama.lean` proves `nilpotent_stable_decomposition_forces_top`: if T^m=0, R is T-stable and V=R+im(T), then R=V.
4. `NilpotentHyperplane.lean` proves `proper_stable_le_range_of_nilpotent_hyperplane`: under an explicit codimension-one decomposition hypothesis, every proper T-stable R lies in im(T).

**Crucial unproved bridge (not kernel-certified):** for the concrete cyclic shift S on `Vec (2^k)`, prove `S^(2^k)=I` and that `im(S+I)` equals the even-coordinate-parity subspace. With these in hand, the Nakayama theorem turns proper rotation-invariant polar radicals into `R ⊆ im(S+I)`, which then discharges the explicit `himage` premise of `balanced_polar_zero_of_proper_radical_image`.

See `CYCLIC_NAKAYAMA_ROUTE.md` for the exact constructive parity recursion and no-local-ring proof plan.

**Scope:** the complete unconditional Lemma 5.1, and therefore the universal cubic antipodal theorem, still are not Lean-certified.

## Not yet proved in Lean — must not be described as kernel-certified

1. **Odd-order fixed-space reduction:** if an invariant degree≤3 bent function is restricted to the fixed space of a cyclic subgroup of odd order, it remains bent. This needs an abstract linear equivariance/factorization construction and quadratic character-sum lemma.
2. **Quadratic rigidity in power-of-two dimension:** Gauss, polar-radical stability/properness, abstract nilpotence, and nilpotent Nakayama now compile. The missing pieces are the concrete shift-order law and image=even-parity identification (which supply the unconditional radical/image inclusion). Full rigidity is not yet proved.
3. **ANF coefficient transport by orbit folding:** establish source/target monomial orbit multiplicities (including short cubic orbits and degree drops), beyond the now-proved parity sublemmas.
4. **Diagonal identity and derivative balance:** show the hypotheses `hd` and `hz` of `Antipodal/Main.lean` from RS bentness and absence of the antipodal monomial.
5. **Universal final theorem:** combine all of the above with the 52-result core and obtain a theorem with no extra hypotheses.

## Latest clean kernel verification

- GitHub Actions: https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/38666055432
- Commit tested: `77f3ef69389e26d6d0dd5242960131fd8646822d`
- Status: **success**, Lean 4.15.0 + pinned Mathlib.
- Passed: baseline fiber core, two multiplicity lemmas, two-variable antipodal necessity, and two structural bridge consequences.
- `#print axioms` on all five new theorems: `propext`, `Classical.choice`, `Quot.sound` only; no `sorryAx`.

## Remaining scope notes

The *necessary direction* of the n=2 statement is proved; the stronger equivalence is not required by the paper and has not been formalized here. No claim is made that the power-of-two theorem for n≥4 or the global n=2^s*m transport is kernel-certified.

## Required release gate

- `lake build` succeeds using pinned tools and imports the relevant global theorem.
- `#print axioms` for each new theorem shows no `sorryAx` or other unapproved axioms.
- A second clean reproducible CI run succeeds.
- The final Lean statement explicitly quantifies over every positive even dimension and matches the manuscript's ANF definition (not just a conditional fiber lemma).

**Scientific caution:** the algebraic manuscript and finite computations are substantial evidence, but they are not a substitute for an accepted kernel proof of the global theorem. No full certification is claimed here.
