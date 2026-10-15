# GLOBAL RESULT: KERNEL-PROVED LOCALLY; CLEAN CI PENDING

Scientific manuscript author: **Filipe Martins Vono**. Independent mathematical/Lean continuation, 15 October 2026.

The exact universal antipodal theorem and the universal homogeneous cubic nonexistence corollary now type-check locally in Lean 4.15.0 with pinned Mathlib. Their printed axiom sets are exactly `propext`, `Classical.choice`, `Quot.sound`. The release certificate will be completed after a fresh clean GitHub Actions build of this source commit, including `GlobalAntipodal.lean` as a root-library dependency.

## Exact result

For every H>0 and every Boolean function on 2H coordinates, actual cyclic rotation symmetry, canonical ANF degree≤3 and actual integer-Walsh bentness imply that the canonical coefficient of `{0,H}` is 1. Rotation covariance makes this the antipodal **orbit** coefficient. Affine and constant terms are unrestricted.

`universal_antipodal` uses dimension `H+H`; `universal_antipodal_2h` uses `2*H`; `universal_antipodal_canonical` uses the public `antipodalANFCoefficient` interface in dimension `2*(h+1)`. Every positive even dimension is covered: take H=N/2, or h=H-1. `positive_two_power_odd_factor` proves the required arithmetic decomposition, without assuming it in the universal statement.

The theorem `no_homogeneous_cubic_rotation_symmetric_bent` is derived from this necessity theorem and the canonical absence of degree-two terms in a homogeneous cubic. It is not a separate search result.

## Main change in proof route

The formal proof does **not** depend on the manuscript's full coefficient-folding formula. Instead it proves, in every even dimension, that a zero antipodal coefficient makes the function constant on the whole fixed space of the coordinate half-turn. Repeated diagonal vectors from the smaller cyclic fixed space lie in this original fixed space. Thus zero antipodal coefficient directly gives the constant diagonal needed for the power-of-two fiber contradiction.

This removes the full coefficient-transport identity from the global proof dependency graph. That standalone stronger identity is not claimed kernel-proved; see GAP_REGISTER.md. No such identity is assumed by the final theorem.

## Certified components

- Integer Fourier inversion, Wiener--Khinchin and bentness iff balanced nonzero derivatives.
- Unconditional quadratic cyclic rigidity, reused from the independent Lemma 5.1 completion.
- Finite-module Gauss identity, fixed-point-free complement, odd averaging projector, actual fixed/kernel splitting and quadratic balance transfer.
- Cubic bent restriction to odd-order fixed spaces.
- Concrete cyclic subgroup order, repeated-block embedding, **surjectivity** onto the actual fixed space by a periodicity recurrence, explicit linear equivalence and rotation compatibility.
- Canonical ANF reconstruction, uniqueness, permutation covariance, polynomial realization of canonical degree≤3 and linear substitution.
- Free-half-turn ANF cancellation, antipodal-pair covariance and the zero-coefficient/constant-diagonal implication.
- Actual two-block coordinates, rotation powers and Walsh normalization transport.
- Power-of-two antipodal necessity, universal necessity, and universal homogeneous cubic nonexistence.
- Explicit nonvacuous two-variable bent witnesses including affine/constant terms.

## Provenance and preservation

Starting branch checked at `c333889462e4c08acfb9ae2b6a12ecb2124f8c15`. The independent Lemma 5.1 proof at `f3d41a59d4a699367fd0c40374e93f7ba230b0cb` was inspected and verified against successful CI 38673954917, then used as the exact parent of the isolated branch `formal/astra-global-antipodal-2026-10-15`. Comparing the branches showed c333889 adds mission documentation but lacks the independent completion; no blind merge was made. The mission text was copied unchanged from c333889.

The baseline fiber, quadratic Gauss, nilpotence and Nakayama proofs are reused. Historical manuscripts and other research branches are unchanged. Incremental verified commits are preserved.

## Scope of certification

The formal theorem's mathematical content is proved. This does not assert peer review, journal/arXiv acceptance, or exhaustive novelty verification. The auxiliary exact coefficient-folding formula is outside the chosen kernel proof route. Publication readiness still requires checking the manuscript's exposition against this final route and a proper literature/priority review.
