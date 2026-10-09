# V3-C — symplectic graph family (research branch)

This branch is separate from V1 and V2. **The seed polarization and Property A are Lean-compiled for variable m; graph classification, graph index, and graph indecomposability remain uncertified.**

Let m≥2, V=F₂^(2m), f_m=Σ_{i<j}p_iq_i p_jq_j, and (F_G,m)_i=f_m(x_i)+p_{i,1}q_{i,1}Σ_{i→j}p_{j,1} for finite loopless directed G.

## Certified scope

See `FORMALIZATION_REPORT.md` for exact declarations, hypotheses, and remaining gaps.
The isolated project is `lean/`, with namespace `VonoV3C` and Lean/Mathlib 4.19.0.

- `seed_fourth`: the requested fourth-polarization identity, at every base point, for every m.
- `seed_property_A`, `fourth_pair_zero_iff`, `constant_second_iff`: uniform m≥2 certificates, without seed/vector enumeration.
- `Blocks.recover_blocks_from_quartic`: block recovery for invertible linear maps preserving the intrinsic direct-sum quartic zero-pair relation. The derivation of that preservation premise from graph EA equivalence remains uncertified.
- Build and axiom logs: `lean/logs/build.log`, `lean/logs/axioms.log`.

## Original target claims (graph portions remain uncertified)

1. D⁴f_m(a,b,c,d)=ω(a,b)ω(c,d)+ω(a,c)ω(b,d)+ω(a,d)ω(b,c).
2. D⁴f_m(a,b,.,.)=0 iff a,b are linearly dependent, m≥2.
3. Intrinsic block recovery via K(a)={b:D⁴F(a,b,.,.)=0}, dim K(a)=2mr−(2m−1)support(a).
4. Mixed D³ detects i→j, hence canonical EA classes classify loopless directed graphs.
5. R₂(F_G,m)=r via upper bound from block projections and witness span(q_{i,1}).
6. If underlying graph is connected, F_G,m+Q is EA-indecomposable for any quadratic vectorial Q; use D⁴ to force block partition and D³ to exclude crossing edges.

## Boundaries

- Arbitrary quadratic perturbations are NOT classified by the graph alone under ordinary EA.
- Preservation of quartic form need NOT preserve ω when m=2.
- A product decomposition under EA has vanishing mixed second derivatives for factor directions (EA correction affine). When working only modulo quadratic perturbations, mixed second derivatives may be nonzero constants; use D³ for robust obstruction.
- Literature priority: Polujan & Pott (2020), DOI 10.1007/s10623-019-00712-y, defines relaxed M-subspaces and relaxed linearity index; 2021 correction DOI 10.1007/s10623-021-00877-5 addresses licensing. Novelty NOT established.

## Lean next steps

The seed and algebraic block-recovery stages are completed. Next define the graph family for variable m, certify annihilation of the cubic coupling by D⁴, and establish EA transport of the zero-pair relation. Then certify edge recovery, canonical classification, the graph index, and quadratic-robust indecomposability. Do not promote the compiled block-recovery criterion into a graph EA theorem before certifying the transport bridge.
