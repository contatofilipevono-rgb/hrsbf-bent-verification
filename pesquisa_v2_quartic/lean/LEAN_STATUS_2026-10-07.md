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


## Exact-index layer update

The abstract exact-index theorem is now present at:

    VonoExactIndex/ExactIndex.lean

It proves the certificate form needed for exact equality:
- every relaxed M-subspace of the block sum has finrank <= number of blocks;
- an ordinary M-subspace of exactly that finrank exists;
- a uniform-seed specialization reduces the infinite-family theorem to the seed hypothesis that every relaxed seed subspace has finrank <= 1.

Audit note: an earlier tool call reported creation of ExactIndex.lean but the file was not actually present, while the umbrella module imported it. This was detected by direct fetch (404), corrected, and then rechecked against the recursive Git tree.

Correction commit:

    1bc959c781f7f80377f0c390bd529ade592ddc13

Post-correction repository check:
- 7 committed .lean files;
- ExactIndex.lean present in the recursive tree;
- 0 occurrences of `sorry` in committed .lean files.

Compilation remains pending because this execution environment does not expose Lean/lake.


## Seed8 executable layer

Added:

    VonoExactIndex/Seed8.lean

It defines the explicit 8-variable quartic RS seed from the four orbit representatives and states a complete finite obstruction:

    no distinct nonzero directions a,b have constant D_a D_b seed.

The theorem is discharged in source with `native_decide`, so after successful compilation Lean will evaluate the complete finite proposition rather than a sample. This is the executable counterpart of the Python 32,385-pair certificate.

Current boundary:
- the finite seed obstruction is encoded;
- the generic block exact-index theorem is encoded;
- the small abstract bridge from the finite obstruction to the statement that every relaxed seed subspace has finrank <= 1 is not yet committed, because its implementation should be compiler-guided against the exact Mathlib API rather than guessed.

Seed source commit:

    81c8ddaf795ff717835184d2c64b2c0876f9ac40

As before, no machine-check claim is made until `lake build` succeeds.
