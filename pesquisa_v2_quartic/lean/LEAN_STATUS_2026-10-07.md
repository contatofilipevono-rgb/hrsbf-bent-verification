# Lean formalization status — 2026-10-07

Scope: structural proof of the V2 exact-index theorem.

## Formalized source files

- VonoExactIndex/FiniteDifference.lean
  - Boolean finite difference over ZMod 2.
  - D_a D_a f = 0.
  - direction-addition correction identity, explicitly preventing the false bilinearity argument.

- VonoExactIndex/BlockSum.lean
  - exact decomposition of second finite differences for sums on disjoint blocks.
  - selected one-direction-per-block construction gives zero second derivative.

- VonoExactIndex/MSubspace.lean
  - definitions of M-subspace and relaxed M-subspace.
  - ordinary M-subspace implies relaxed.
  - if a sum of disjoint-coordinate functions is constant, each coordinate function is constant.
  - projection of a relaxed M-subspace of a block sum is relaxed for every block.

## Trust status

A repository scan on 2026-10-07 finds NO `sorry` in any committed .lean source under this directory.

However, this environment does not currently provide the Lean/lake executable, so the source has NOT YET been certified by an actual `lake build`. Therefore the correct status is:

    source-level formalization, no sorry, build pending.

Do not describe it as a machine-checked certificate until CI or a Lean-enabled environment completes `lake build` successfully.

## Next theorem layer

Once compilation is available:
1. repair any Mathlib API/type errors revealed by the compiler;
2. formalize finite-dimensional dimension bounds for block projections;
3. state/prove the abstract theorem:
       seed relaxed index <= 1
       => direct-sum ind = relaxed-ind = number of blocks;
4. connect the finite 8-variable seed certificate.

V1 remains untouched.
