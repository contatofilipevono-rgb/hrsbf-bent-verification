# Lean formalization status — 2026-10-07

Scope: V2 exact-index formalization and reproducible Lean verification.

## Green checkpoint

The branch `v2-quartic-mm-index-2026-10-07` reached a successful full GitHub Actions build on commit:

    48506b6697b056d9584842c1873e9455dc34d1b9

GitHub Actions run:

    37674550863

Result:

    completed / success

Environment used by CI:
- Lean 4.19.0
- Mathlib resolved by the repository lake configuration

This commit is the preserved green checkpoint for subsequent V2 work.

## Compiler-verified theorem layers

The successful build includes the current committed Lean source tree, in particular:

- `VonoExactIndex/FiniteDifference.lean`
  - finite differences over `ZMod 2`;
  - `D_a D_a f = 0`;
  - correction identity for direction addition, avoiding the invalid general bilinearity claim.

- `VonoExactIndex/BlockSum.lean`
  - decomposition of second differences over disjoint blocks;
  - one selected direction per block gives zero second difference.

- `VonoExactIndex/MSubspace.lean`
  - M-subspace and relaxed M-subspace definitions;
  - ordinary implies relaxed;
  - coordinate constancy for a constant disjoint-coordinate sum;
  - relaxed block-subspace projections are relaxed.

- `VonoExactIndex/DimensionBound.lean`
  - injective map from a subspace to the product of coordinate images;
  - finrank bound by the sum of projection finranks;
  - block upper bound under the seed relaxed-index hypothesis.

- `VonoExactIndex/LowerBound.lean`
  - explicit selected-direction linear map;
  - injectivity for nonzero selected directions;
  - its range is an ordinary M-subspace;
  - the range has one dimension per block.

## Important correction established during formalization

An earlier informal justification used a false general bilinearity claim for second finite differences in the direction variables. The Lean development does not rely on that claim. The lower-bound construction was replaced by a direct disjoint-block argument: in each block both directions lie on the same one-dimensional `F₂` line, so the block second difference vanishes.

Thus the green checkpoint verifies the corrected argument, not the invalid bilinearity shortcut.

## Trust boundary

The successful CI build establishes that the committed Lean development at the green checkpoint is accepted by Lean/Mathlib.

Before describing the entire mathematical paper as a fully closed formal certificate, perform one final dependency audit of:
- `Seed8.lean`;
- `ExactIndex.lean`;
- the bridge from the finite Seed8 obstruction to the abstract hypothesis that every relaxed seed M-subspace has finrank at most 1;
- all occurrences of `axiom`, `sorry`, `admit`, or theorem hypotheses that still encode an unproved mathematical step.

A green build alone does not imply that every paper-level premise has been internally derived; it certifies the Lean statements actually present in the dependency chain.

## Reproducibility record

Green checkpoint commit:

    48506b6697b056d9584842c1873e9455dc34d1b9

Successful CI run:

    37674550863

Branch:

    v2-quartic-mm-index-2026-10-07

V1 remains untouched.
