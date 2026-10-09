# Adversarial mathematical and formalization review

**Verdict: PASS WITH CAVEATS for the stated mathematical scope.**
No false central theorem, circular premise, or unsupported strengthening was
found in this review. Three ambiguities in the prose were repaired. This
verdict is not a novelty or submission-readiness certificate.

Audited baseline SHA: `cf362db05d9a8dfda4a82a2360720ed370da1454`.
Branch: `v3c-ea-transport-continuation`.
Target: `MANUSCRIPT_DRAFT.md` and the V3-C Lean modules at that SHA.
The accompanying commit contains the revised text, review-only boundary
certificates, and new logs. Previously compiled proof modules are unchanged.

This is an adversarial review performed by the same continuing agent that
helped prepare the manuscript. It is not represented as an external or
independent referee report. The review nevertheless checks the mathematical
argument directly, rather than treating the previous reports as evidence.

## Findings and repairs

| Finding in baseline prose | Severity | Repair |
|---|---|---|
| Lemma 3 says “preserving R” without spelling out both directions, although its proof uses the reverse implication | Expository ambiguity | State `R(a,b)↔R(Aa,Ab)` explicitly, matching `recover_blocks_from_quartic`. Ordinary EA transport supplies this premise. |
| Theorem 6 does not explicitly declare t, g, h, L, k and all factor spaces; the reused letter A could obscure that translation now lies in the product space | Expository ambiguity | Supply all domains, codomains and F₂-vector-space assumptions; retain nontrivial input factors and arbitrary linear output mixing. |
| The GI reduction has a monomial count but leaves the bit encoding and fixed negative/empty cases implicit | Incomplete complexity exposition, outside the Lean scope | Specify variable-index-list ANFs, O(r² log(r+1)) bit size, a concrete negative graph pair, and empty-case handling. Label these as unformalized encoding arguments. |

No repair to an old Lean proof was necessary. No new axiom, admission, or seed
replacement was introduced. The changes clarify hypotheses and consequences
already within the authorized research scope.

## Mathematical reconstruction

| Item | Verdict | Reason checked |
|---|---|---|
| Fourth polarization | PASS | Squarefree quartics yield four-linear differences. The diagonal local-pair terms vanish; triangular summation gives the three symplectic products. Identity holds at every base point. |
| Zero-pair rigidity | PASS | Zero contractions imply minors equal ω(a,b) times the pairing matrix. Two distinct local pairs in the Pluecker identity force ω(a,b)=0. Zero minors imply dependence over F₂. m≥2 is used exactly here. |
| Intrinsic block recovery | PASS after clarification | Full input coverage and cross dependence force one projection per block to vanish. Whole-block membership follows from decomposition and the same partition at other blocks. Pull back a target block and its complement; injectivity and equal finite block dimensions give a permutation. |
| Ordinary EA transport | PASS | Affine corrections vanish after two differences; transformed directions and translated base points are included. Inverses of A and B give the reverse zero-pair implication. No preservation theorem is assumed as an EA hypothesis. |
| Output permutation | PASS | A four-direction witness with polarization one gives an output basis vector. Its transformed scalar cannot vanish, hence equals one over F₂. This forces `B(e_{π(i)})=e_i`, so `(By)i=y(π(i))`. |
| Directed arc detector | PASS | Two directions at i and one at j kill all seeds. Only the i→j coupling survives. In the reverse coupling two directions hit its single linear i-coordinate, killing it; bidirectional arcs cause no cancellation. |
| Canonical classification | PASS | Block recovery and invertible mixed-third transport recover off-diagonal adjacency. Looplessness supplies the diagonal. Reindexing supplies the converse. Common finite vertex type is retained. |
| Radical dimension | PASS | Each local factor is all V at zero and span{aᵢ} otherwise. The product dimension is `2mr−(2m−1)s(a)`. There is no unjustified assumption that the radical is linear. |
| Exact simultaneous relaxed index | PASS | Constant D² kills D⁴, forcing every projected subspace to be a line or zero. Projection embedding bounds dimension by r. One p-direction in local pair 2 per vertex gives an r-dimensional witness, with zero coupling differences. |
| Quadratic robustness | PASS | Products of linear forms have constant D². Adding Q preserves the relaxed condition in both directions and kills its D³/D⁴ contributions. The explicit ANF certificate discharges the derivative hypothesis. |
| Product obstruction | PASS after clarification | Pullbacks of the product factors are nonzero and cover X. Product/affine cross D² is zero; after removing Q it is constant. The quartic relation partitions whole blocks. A crossing arc then contradicts constant cross D² through a nonzero D³. Both arc orientations are handled. |

The classification theorem does not logically require the separate output
permutation lemma to recover arcs: invertibility of B already preserves
nonzeroness. The output lemma is still a valid additional structural theorem;
its presence does not create a circular dependency.

## Explicit attempts at invalid extensions

1. **m=1:** the seed sum is empty and the seed is identically zero. Independent
   directions in a two-dimensional block therefore cannot satisfy the proposed
   zero-pair rigidity conclusion. The excluded case is checked in
   `RefereeAudit.seed_dimension_one_zero`. It is not silently included.
2. **Symplectic preservation at m=2:** permuting q₁ and p₂ preserves the
   product p₁q₁p₂q₂ and hence its fourth polarization, but sends the pair
   (p₁-basis,q₁-basis), with ω=1, to (p₁-basis,p₂-basis), with ω=0. Thus an
   arbitrary quartic stabilizer need not preserve ω. This analytical witness
   explains why that extra premise is forbidden; the existing proof avoids it.
3. **Graph-only classification after quadratic perturbation:** for a one-vertex
   loopless graph at m=2, f=p₁q₁p₂q₂ has nonlinearity one, while f+p₁p₂ has
   nonlinearity three. Their supports have sizes one and three. Every
   nonconstant affine function has weight eight, bounding distances below by
   seven and five; comparison with zero attains one and three. Affine input
   permutation and affine addition permute all affine comparison functions,
   so the minima are EA invariants. The functions cannot be EA-equivalent.
   This is now included in the manuscript as an elementary prose counterexample,
   explicitly not a Lean-formalized extra result.
4. **Strong connectivity:** not needed. The proof needs a crossing arc in either
   direction at every nontrivial cut, which is the stated weak-connectivity
   condition. No unidirectionality assumption is inserted.
5. **Disconnected quadratic converse:** not claimed. A quadratic perturbation
   can couple otherwise separate input factors; the connectedness obstruction
   alone does not give a converse classification.

The analytical witnesses in items 2–3 are direct finite algebra/counting
arguments. They are not experimental evidence for a general theorem.

## Compilation and proof foundations

Pinned Lean: `leanprover/lean4:v4.19.0`.
Pinned Mathlib checkout and manifest SHA:
`c44e0c8ee63ca166450922a373c7409c5d26b00b`.
Mathlib working tree was clean. The configured default target imports every
V3-C proof module, including classification, index, radical, and product
obstruction. No V2 proof module is imported by this project.

Ran `lake clean VonoV3C`, which removes only this package's generated build
directory, followed by `lake build`. Dependencies remained cached. This is
a full recompilation of the V3-C project sources, not a claim to have rebuilt
all Mathlib from source. The container's previously documented path adapter
was reused; no proof or global configuration was changed.

| Check | Result | Log under `lean/logs/continuation/` |
|---|---|---|
| Package-specific clean | exit 0 | `referee-clean.log` |
| Full default build | exit 0 | `referee-build.log` |
| Seed/block audit | exit 0 | `referee-existing-axioms.log` |
| Quadratic audit | exit 0 | `referee-quadratic-axioms.log` |
| Classification/index/radical/product audit | exit 0 | `referee-axioms.log` |
| Exact type snapshot and boundary certificates | exit 0 | `referee-boundaries.log` |

All audited declarations depend only on subsets of `propext`,
`Classical.choice`, and `Quot.sound`. Source inspection found no `sorry`,
`admit`, new `axiom` declarations, or `native_decide` in the V3-C modules or
review file. Existing linter warnings remain; they do not invalidate the build.

`RefereeAudit.lean` compiled on its first attempt. It is separate from the
mathematical library and supplies seven review certificates: zero m=1 seed,
empty/singleton cut conditions, empty relaxed index, singleton absence of a
relaxed split, and both directions of a bidirected edge. These instantiate
the compiled machinery; they do not replace uniform proofs by finite tests.
The original three audits were also rerun after recompilation.

## Remaining caveats and researcher handoff

- This review found no central mathematical error in the scoped statements.
  It cannot establish priority or guarantee that another referee finds none.
- A complete comparison with ePrint 2026/940 remains unavailable. No new
  bibliographic result is inferred in this mathematical review.
- A heterogeneous vertex-type bridge and a polynomial-degree API bridge are
  not formalized. Neither is assumed by the current theorem statements.
- The GI bit-encoding argument and the analytical counterexamples above are
  mathematically justified prose, outside the Lean certificate scope.
- Authorship, rendered submission format, and final bibliography still require
  completion. No preprint submission or merge was performed.

To reproduce, checkout the accompanying continuation commit; in `lean/`,
run `lake clean VonoV3C`, `lake build`, and each of `Audit.lean`,
`GraphQuadraticAudit.lean`, `GraphContinuationAudit.lean`, `RefereeAudit.lean`
using `lake env lean`. Use the documented container adapter only if executable
path detection requires it. Read the revised manuscript and compare its
numbered statements to the printed types in `referee-boundaries.log`.
