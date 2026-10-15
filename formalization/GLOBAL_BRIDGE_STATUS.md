# Lean global antipodal bridge — state of proof (14–15 October 2026)

**Branch:** `formal/antipodal-global-completion-2026-10-14`  
**Baseline:** `57d561393d546e00fbcd3c95cfce1158bfda9a23`  
**Toolchain:** Lean `4.15.0`; Mathlib `9837ca9d65d9de6fad1ef4381750ca688774e608`.

## Proven, with original kernel evidence preserved

- The baseline `formalization/Antipodal/*.lean` 52-result fiber core compiles in GitHub Actions (seen on runs `38663462356` and `38664372468`).
- `Antipodal/OddMultiplicity.lean` formalizes two characteristic-two statements: even orbit multiplicity cancels, odd multiplicity preserves coefficients. In workflow run `38664372468`, both axiom audits contained only `propext`, `Classical.choice`, and `Quot.sound`, with no `sorryAx`.
- The material in the earlier A100 audit remains unchanged by this branch except for new files under `formalization/` and the new isolated CI workflow.

## Not yet proved in Lean — must not be described as kernel-certified

1. **Two-variable endpoint:** `Antipodal/Endpoint2.lean` currently supplies definitions ONLY. The equivalence `IsBentPair f ↔ antipodalCoeff2 f = 1` is not asserted as a theorem because earlier reflective proof attempts failed to elaborate/reduce.
2. **Odd-order fixed-space reduction:** if an invariant degree≤3 bent function is restricted to the fixed space of a cyclic subgroup of odd order, it remains bent. This needs an abstract linear equivariance/factorization construction and quadratic character-sum lemma.
3. **Quadratic rigidity in power-of-two dimension:** invariant balanced quadratics have zero polar, including linear terms and short quadratic orbits. The polynomial-module argument still has to be formalized.
4. **ANF coefficient transport by orbit folding:** establish source/target monomial orbit multiplicities (including short cubic orbits and degree drops), beyond the now-proved parity sublemmas.
5. **Diagonal identity and derivative balance:** show the hypotheses `hd` and `hz` of `Antipodal/Main.lean` from RS bentness and absence of the antipodal monomial.
6. **Universal final theorem:** combine all of the above with the 52-result core and obtain a theorem with no extra hypotheses.

## Required release gate

- `lake build` succeeds using pinned tools and imports the relevant global theorem.
- `#print axioms` for each new theorem shows no `sorryAx` or other unapproved axioms.
- A second clean reproducible CI run succeeds.
- The final Lean statement explicitly quantifies over every positive even dimension and matches the manuscript's ANF definition (not just a conditional fiber lemma).

**Scientific caution:** the algebraic manuscript and finite computations are substantial evidence, but they are not a substitute for an accepted kernel proof of the global theorem. No full certification is claimed here.
