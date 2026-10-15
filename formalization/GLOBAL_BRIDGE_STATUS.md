# Lean global antipodal bridge — state of proof (14–15 October 2026)

**Branch:** `formal/antipodal-global-completion-2026-10-14`  
**Baseline:** `57d561393d546e00fbcd3c95cfce1158bfda9a23`  
**Toolchain:** Lean `4.15.0`; Mathlib `9837ca9d65d9de6fad1ef4381750ca688774e608`.

## Proven, with original kernel evidence preserved

- The baseline `formalization/Antipodal/*.lean` 52-result fiber core compiles in GitHub Actions (seen on runs `38663462356` and `38664372468`).
- `Antipodal/OddMultiplicity.lean` formalizes two characteristic-two statements: even orbit multiplicity cancels, odd multiplicity preserves coefficients. Axiom audits contain only `propext`, `Classical.choice`, and `Quot.sound`, with no `sorryAx`.
- **New kernel-certified dimension-2 endpoint:** `Antipodal/Endpoint2.lean` now proves `HRSBF.Antipodal.bent_implies_antipodal_in_two_variables` from the exact four-term integer Walsh equation, using no reflective axioms. Compiled successfully in GitHub Actions run `38665788312`; the printed axioms are precisely `propext`, `Classical.choice`, and `Quot.sound`.
- **New conditional consequences:** `Antipodal/DerivativeBridge.lean` contains `bent_forces_derivative_polar_witness` and `bent_forces_nonconstant_diagonal`, which use the existing 52-result fiber contradiction and express its contrapositive in a form ready for the quadratic rigidity bridge. Both compiled and passed `#print axioms` in run `38666055432`. They do not prove quadratic rigidity or the full antipodal theorem.
- The material in the earlier A100 audit remains unchanged by this branch except for new files under `formalization/` and the new isolated CI workflow.

## Not yet proved in Lean — must not be described as kernel-certified

1. **Odd-order fixed-space reduction:** if an invariant degree≤3 bent function is restricted to the fixed space of a cyclic subgroup of odd order, it remains bent. This needs an abstract linear equivariance/factorization construction and quadratic character-sum lemma.
2. **Quadratic rigidity in power-of-two dimension:** invariant balanced quadratics have zero polar, including linear terms and short quadratic orbits. The polynomial-module argument still has to be formalized.
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
