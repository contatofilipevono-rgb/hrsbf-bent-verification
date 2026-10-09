# V3-C — symplectic graph family (research branch)

This branch is separate from V1 and V2. **The seed, intrinsic blocks, actual graph fourth derivative, ordinary EA transport, matched output permutation, directed-edge recovery, canonical EA classification, exact vector relaxed graph index, kernel-dimension formula, and quadratic-robust EA indecomposability for weakly connected graphs are Lean-compiled for variable m≥2.**

Continuation branch: `v3c-ea-transport-continuation`, based on reference SHA
`83b53a57f47ae33d4694346dc0e315d2a4c38878`; reference branch unchanged.
See CONTINUATION_PROGRESS.md and lean/logs/continuation/E-{build,axioms}.log.

Let m≥2, V=F₂^(2m), f_m=Σ_{i<j}p_iq_i p_jq_j, and (F_G,m)_i=f_m(x_i)+p_{i,1}q_{i,1}Σ_{i→j}p_{j,1} for finite loopless directed G.

## Certified scope

See `FORMALIZATION_REPORT.md` for exact declarations, hypotheses, and remaining gaps.
The isolated project is `lean/`, with namespace `VonoV3C` and Lean/Mathlib 4.19.0.

- `seed_fourth`: the requested fourth-polarization identity, at every base point, for every m.
- `seed_property_A`, `fourth_pair_zero_iff`, `constant_second_iff`: uniform m≥2 certificates, without seed/vector enumeration.
- `Blocks.recover_blocks_from_quartic`: block recovery for invertible linear maps preserving the intrinsic direct-sum quartic zero-pair relation. GraphFamily.representation_pair and EA_recovers_blocks now derive that premise from actual graph EA equivalence.
- `GraphFamily.canonical_EA_iff_graph_isomorphic`: complete ordinary EA classification of canonical loopless directed graph representatives on a common finite vertex type; bidirectional arcs allowed.
- `GraphFamily.graph_fourth_radical_dimension`: the actual graph fourth-derivative radical, at every base point, is a linear subspace of dimension `2*m*card ι - (2*m-1)*supportCount a`, where support counts nonzero vertex blocks.
- `GraphFamily.graph_has_exact_relaxed_index`: exact vector relaxed index `card ι`.
- `GraphFamily.quadratic_ANF_second_constant`: every explicit affine-plus-quadratic ANF satisfies the constant-second-difference condition; D³ and D⁴ vanish.
- `GraphFamily.graph_quadratic_exact_index`: the exact vector relaxed index survives all such quadratic perturbations.
- `GraphFamily.graph_quadratic_ANF_not_EA_product`: weakly connected graphs remain EA-indecomposable after arbitrary explicit quadratic ANF perturbations, for two nontrivial input factors. Input linear equivalence, translation, arbitrary linear output mixing, and affine correction are included.
- New build and axiom logs: `lean/logs/continuation/`; new audit: `lean/GraphContinuationAudit.lean`.
- Original build and axiom logs: `lean/logs/build.log`, `lean/logs/axioms.log`.

## Target claims (1–6 certified)

1. D⁴f_m(a,b,c,d)=ω(a,b)ω(c,d)+ω(a,c)ω(b,d)+ω(a,d)ω(b,c).
2. D⁴f_m(a,b,.,.)=0 iff a,b are linearly dependent, m≥2.
3. Intrinsic block recovery via K(a)={b:D⁴F(a,b,.,.)=0} and the dimension formula dim K(a)=2mr−(2m−1)support(a) are certified.
4. Mixed D³ detects i→j, hence canonical EA classes classify loopless directed graphs.
5. R₂(F_G,m)=r via upper bound from block projections and a witness with one safe direction at the second local coordinate pair in each block.
6. If the underlying graph is weakly connected, F_G,m+Q has no nontrivial EA product representation. `graph_quadratic_not_EA_product` uses the intrinsic constant-second-difference condition; `graph_quadratic_ANF_not_EA_product` discharges it for arbitrary explicit quadratic ANFs.

## Boundaries

- Arbitrary quadratic perturbations are NOT classified by the graph alone under ordinary EA.
- Preservation of quartic form need NOT preserve ω when m=2.
- Connectivity is encoded by `CutConnected`: every nonempty proper vertex cut has an arc crossing in at least one direction. Empty and single-vertex cases are allowed; both input factors must be nontrivial.
- No converse connectivity/indecomposability statement for arbitrary quadratic perturbations is asserted. A separate bridge to a Mathlib polynomial-degree predicate is not supplied; explicit quadratic ANFs and the intrinsic derivative condition are certified.
- A product decomposition under EA has vanishing mixed second derivatives for factor directions (EA correction affine). When working only modulo quadratic perturbations, mixed second derivatives may be nonzero constants; use D³ for robust obstruction.
- Literature priority: Polujan & Pott (2020), DOI 10.1007/s10623-019-00712-y, defines relaxed M-subspaces and relaxed linearity index; 2021 correction DOI 10.1007/s10623-021-00877-5 addresses licensing. Novelty NOT established.

## Lean next steps

Stages A–E, the exact relaxed graph index, the kernel-dimension formula, and
quadratic-robust indecomposability are compiled. Follow CONTINUATION_PROGRESS.md
for reproduction, exact scope, and further work. Novelty and publication
readiness require separate literature and manuscript review.
Do not extend the canonical classification to arbitrary quadratic perturbations.
