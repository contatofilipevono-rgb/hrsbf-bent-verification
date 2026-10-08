# Integration of seed property (A), 2026-10-08

Status: **COMPILA**. Full local `lake build` and the dependency audit both
completed with exit code 0. No `sorryAx` appears in final theorem dependencies.
The compiler has only pre-existing style warnings.

Base commit: `3be954f63a64d2eae45e2ce34629df59769dc1a1`.
Integration branch: `v2-seed-property-a-integration-2026-10-08`.

## Exact scope

The pre-existing `Seed8.lean` already closes the relaxed seed index and the
exact indices of repeated disjoint blocks. These results were not missing.
This integration adds a fourth-difference property (A) certificate and
connects it to the project's actual seed and its index definitions.

`QuarticSeedPropertyA.lean` represents F₂⁸ as `Fin 256`, with XOR addition.
It tabulates the explicit cyclic-orbit quartic formula internally, checks
that this tabulation agrees with the formula on all 256 vectors, checks
65,536 ordered pairs against 28 basis pairs, and excludes independent
pairs with zero contraction. Matrix multiplication uses XOR/parity.

`SeedPropertyAComputations.lean` checks the finite encoding and fourth-difference
bridge. `SeedPropertyABridge.lean` connects these certificates to
`SeedVec := Fin 8 → ZMod 2`, with a checked surjective decoding and checked
compatibility with addition. Its finite fourth-difference check includes
the quadratic orbit `[0,1]` of the original project seed. It transports the
fourth differences into the original project's definition of `diff`.
The final property (A) has no seed-specific premise other than the stated
vanishing of fourth differences at zero for every c,d. Vanishing at every
input point is a stronger hypothesis and implies this one.

The computational certificates and logical deductions are separate modules,
so proof maintenance does not require repeatedly evaluating the large finite checks.

The new logical chain is:

```
seed_property_A
  -> no_independent_constant_pair_via_property_A
  -> relaxed_finrank_le_one_via_property_A
  -> exact_indices_via_property_A
  -> exact_indices_canonical_via_property_A
```

The last theorem fixes a canonical nonzero direction internally and gives
both ordinary and relaxed indices equal to r for
r disjoint copies of the original seed. It does not state the index of
an arbitrary perturbed or nonseparable family.

## Pre-existing compilation failure corrected

The last committed `Hypergraph.lean` did not compile at the base commit.
`Finset.card_le_one` was used as if it returned an empty-or-singleton
alternative; the implementation now derives that alternative explicitly.
The proof also attempted to show a monomial evaluation formula for arbitrary
u,v using information that only concerned a,b. The corrected proof evaluates
exactly x, x+a, x+b, x+a+b using the support assumptions already in the
unchanged theorem statement. Characteristic-two cancellation is explicit.
No new hypothesis was added to the theorem.

## Trust and boundaries

Finite checks use Lean's standard `native_decide` mechanism and therefore
`Lean.ofReduceBool`. This is not a pure kernel-reduction certificate.
No custom axiom, `sorry`, `admit`, or `unsafe` declaration is introduced.
`SeedPropertyAAudit.lean` prints the actual final statements and dependencies.

The property (A) implication needs no extension by multilinearity: a hypothesis
for all c,d already includes the 28 basis pairs.
EA indecomposability, graph classification, and an index theorem for the
nonseparable vector family are not claimed as Lean-certified by this change.
The existing seed, all existing exact-index proofs, and V1 files are preserved.
Only the failing Hypergraph proof, root imports, new modules, and a new
integration CI workflow are changed.

## Reproduction

Lean: 4.19.0, commit `6caaee842e94`.
Mathlib: `c44e0c8ee63ca166450922a373c7409c5d26b00b` (v4.19.0).
Dependency revisions are pinned in `lake-manifest.json`.

From `pesquisa_v2_quartic/lean`:

```bash
lake exe cache get
lake build
lake env lean SeedPropertyAAudit.lean
```

The local runtime needed a readlink compatibility wrapper to locate Lean,
and `TAR_OPTIONS=--no-same-owner` for archive extraction. These adjustments
are environmental; they do not modify Lean's proof checking or mathematical
Mathlib modules. The optional ProofWidgets release was recovered successfully.

Final results and compiler logs are in `audit_logs`.
