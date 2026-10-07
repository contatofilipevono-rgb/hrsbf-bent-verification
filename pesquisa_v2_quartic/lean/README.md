# Lean 4 formalization — V2 exact-index project

This directory contains the Lean 4 / Mathlib formal verification of the V2
exact-index argument. It is intentionally isolated from V1.

## Verified result

The current development closes the explicit eight-variable seed certificate
into the repeated-block exact-index theorem.

Final theorem:

    VonoExactIndex.seed8_exact_repeated_block_index_certificate

For any finite block index type and any nonzero selected seed direction, Lean
proves both:

1. every relaxed M-subspace of the repeated Seed8 block sum has finrank at
   most the number of blocks;
2. an ordinary M-subspace with finrank exactly the number of blocks exists.

This is the certificate form of equality of the ordinary and relaxed indices
with the number of 8-variable blocks.

## Verified dependency chain

    native_decide Seed8 exhaustive obstruction
      -> seed_no_independent_constant_pair
      -> seed_no_independent_constant_pair_prop
      -> seed_relaxed_finrank_le_one
      -> exact_repeated_block_index_certificate
      -> seed8_exact_repeated_block_index_certificate

The finite obstruction checks all relevant SeedVec direction pairs and all
input points, rather than a sample.

## Structural proof layers

- FiniteDifference.lean
  - finite differences over ZMod 2;
  - D_a D_a f = 0;
  - exact direction-addition correction identity.

- BlockSum.lean
  - blockwise decomposition of second differences;
  - selected one-dimensional direction in each block gives zero second
    derivative.

- MSubspace.lean
  - M-subspace and relaxed M-subspace;
  - coordinate projection of a relaxed block subspace remains relaxed.

- DimensionBound.lean
  - finrank upper bound from coordinate projections.

- LowerBound.lean
  - explicit ordinary M-subspace with one dimension per block.

- ExactIndex.lean
  - abstract exact repeated-block certificate.

- Seed8.lean
  - explicit quartic rotation-symmetric eight-variable seed;
  - exhaustive native_decide obstruction;
  - bridge from that obstruction to relaxed seed finrank <= 1;
  - fully closed repeated-block certificate.

## Important proof correction

The formal proof does NOT use the false claim that second finite differences
are generally bilinear in their direction variables. The lower bound is proved
directly from the disjoint-block construction and the fact that each block
uses a single F_2 direction.

## Reproducibility

Compiler-verified Seed8-closed checkpoint:

    9c54dcd3619df762027327598f5212a389b44b89

Successful GitHub Actions run:

    37682139274

Environment:

    Lean 4.19.0
    Mathlib via lake configuration in this directory

Build locally with:

    lake update
    lake build

Repository audit after the successful build found no occurrences of
`sorry`, `admit`, or `axiom`.

See `LEAN_STATUS_2026-10-07.md` for the detailed verification record.
