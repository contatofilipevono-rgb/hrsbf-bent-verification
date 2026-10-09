# V3-C — symplectic graph family (research branch)

This branch is separate from V1 and V2. **The seed, intrinsic blocks, actual graph fourth derivative, ordinary EA transport, matched output permutation, directed-edge recovery, canonical EA classification, and exact vector relaxed graph index are Lean-compiled for variable m≥2. The fourth-derivative radical is identified with the blockwise pair kernel. The kernel-dimension formula and quadratic-robust graph indecomposability remain uncertified.**

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
- New build and axiom logs: `lean/logs/continuation/`; new audit: `lean/GraphContinuationAudit.lean`.
- Original build and axiom logs: `lean/logs/build.log`, `lean/logs/axioms.log`.

## Target claims (1, 2 and 4 certified; block recovery in 3 certified, dimension pending)

1. D⁴f_m(a,b,c,d)=ω(a,b)ω(c,d)+ω(a,c)ω(b,d)+ω(a,d)ω(b,c).
2. D⁴f_m(a,b,.,.)=0 iff a,b are linearly dependent, m≥2.
3. Intrinsic block recovery via K(a)={b:D⁴F(a,b,.,.)=0} is certified, and the graph fourth-derivative radical is characterized. The dimension formula dim K(a)=2mr−(2m−1)support(a) remains pending.
4. Mixed D³ detects i→j, hence canonical EA classes classify loopless directed graphs.
5. R₂(F_G,m)=r via upper bound from block projections and witness span(q_{i,1}).
6. If underlying graph is connected, F_G,m+Q is EA-indecomposable for any quadratic vectorial Q; use D⁴ to force block partition and D³ to exclude crossing edges. This remains pending.

## Boundaries

- Arbitrary quadratic perturbations are NOT classified by the graph alone under ordinary EA.
- Preservation of quartic form need NOT preserve ω when m=2.
- A product decomposition under EA has vanishing mixed second derivatives for factor directions (EA correction affine). When working only modulo quadratic perturbations, mixed second derivatives may be nonzero constants; use D³ for robust obstruction.
- Literature priority: Polujan & Pott (2020), DOI 10.1007/s10623-019-00712-y, defines relaxed M-subspaces and relaxed linearity index; 2021 correction DOI 10.1007/s10623-021-00877-5 addresses licensing. Novelty NOT established.

## Lean next steps

Stages A–E from EA_TRANSPORT_PROOF_OBLIGATIONS.md are compiled. Next independent
goals: the kernel-dimension formula and quadratic-robust indecomposability.
The exact relaxed graph index is compiled. Follow CONTINUATION_PROGRESS.md.
Do not extend the canonical classification to arbitrary quadratic perturbations.
