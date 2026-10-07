# Lean 4 formalization — V2 exact-index project

Goal: machine-check the structural part of the proof behind

    ind(F_r) = r-ind(F_r) = r = n/8.

This directory is intentionally isolated from V1.

## Current formalized layer

- Boolean finite differences over ZMod 2.
- D_a D_a f = 0.
- Exact correction formula showing why direction-linearity is false.
- Second derivatives of sums on disjoint blocks decompose blockwise.
- One selected direction per block gives zero second derivative for every
  pair of vectors in their F_2-span.

This directly formalizes the corrected lower-bound argument that replaced the
earlier false appeal to bilinearity.

## Next milestones

1. Define M-subspace and relaxed M-subspace.
2. Formalize the block-projection upper bound.
3. Define ind and r-ind (or equivalent maximal-dimension statements).
4. Prove the abstract direct-sum theorem from seed r-ind = 1.
5. Formalize/certify the finite 8-variable seed and its exterior-square
   obstruction.

Target policy: no `sorry` in theorem files intended as certificates.

Build:

    lake update
    lake build
