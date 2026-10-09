# V3-C — symplectic graph family (research branch)

This branch is separate from V1 and V2. **No V3-C theorem is claimed Lean-compiled.**

Let m≥2, V=F₂^(2m), f_m=Σ_{i<j}p_iq_i p_jq_j, and (F_G,m)_i=f_m(x_i)+p_{i,1}q_{i,1}Σ_{i→j}p_{j,1} for finite loopless directed G.

## Mathematical claims requiring Lean certification

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

Create a new `VonoV3C` namespace/module hierarchy without editing existing V1/V2 modules. First certify polarization and pair-contraction theorem for variable m; then reuse V2 block-recovery and edge-recovery proof patterns; then index and indecomposability. Run `lake build` in a configured Lean 4/Mathlib environment before marking any statement certified.
