# V3-C — EA transport and directed-edge recovery: exact proof obligations

Status: **stages 1–5 below are Lean-compiled on `v3c-ea-transport-continuation`**.
Base reference SHA: `83b53a57f47ae33d4694346dc0e315d2a4c38878`.
This file remains the mathematical specification; certificates are the actual
Graph*.lean modules, full E-build.log and E-axioms.log under lean/logs/continuation.
FORMALIZATION_REPORT.md and CONTINUATION_PROGRESS.md record exact scope.
Existing seed/block proofs are unchanged; no V1/V2 or reference-branch writes.

## 1. Canonical graph map

For a finite vertex type ι, m≥2, V=(Fin m → ZMod 2 × ZMod 2), X=ι→V, and loopless adjacency g:ι→ι→Bool, define

- p(v)=(v 0).1, q(v)=(v 0).2
- q0(v)=p(v)q(v)
- ℓ_g(i,x)=Σ_{j∈ι} if g i j then p(x j) else 0
- F_g(x)(i)=seed m (x i)+q0(x i)ℓ_g(i,x).

All arithmetic is in ZMod 2. The seed is exactly the one already certified in Polarization.lean.

## 2. Fourfold derivative

Let Φ_g(a,b,c,d)=D_aD_bD_cD_d F_g(x). Each cubic coupling has degree ≤3, so its fourth derivative vanishes. Therefore

Φ_g(a,b,c,d)(i)=pfaffian (a i) (b i) (c i) (d i).

The right side is independent of x and g. This must be a theorem about the **actual graph map**, not an assumption about an abstract quartic tensor.

## 3. EA transport and intrinsic relation

Define EA with M:X≃ₗ X, L:(ι→Scalar)≃ₗ(ι→Scalar), t:X, and affine A:X→(ι→Scalar):

F_h(x)=L(F_g(M x+t))+A(x).

Fourth derivatives yield Φ_h(a,b,c,d)=L(Φ_g(M a,M b,M c,M d)).
Thus the intrinsic pair-zero relation satisfies

QuarticPairZero a b ↔ QuarticPairZero (M a) (M b).

Apply certified `Blocks.recover_blocks_from_quartic` to M. This obtains a permutation p of input blocks and invertible internal maps E_i. Note that the inverse orientation must be handled carefully when stating which graph is relabeled.

For any block i, the image span of Φ restricted to that block is exactly the corresponding output coordinate line. Since the field is F₂, L maps coordinate basis vectors by a permutation matching p; it cannot rescale by a nontrivial scalar. **This is a separate required theorem.**

## 4. Mixed third derivative (constant, not global D³)

For i≠j, a,b supported in input block i and c in block j,

D_aD_bD_c F_g(x)
= if g i j then e_i * ((p(a_i)q(b_i)+q(a_i)p(b_i))*p(c_j)) else 0.

The reverse arc j→i contributes zero because its term has only degree one in block i. The seed contributes zero because it is supported on one block.

This expression is independent of x, so an EA input translation does not change it. Addition of an affine output map also does not change it. Under arbitrary invertible internal block maps, the trilinear form is transported but its nonzeroness is invariant.

With the output-coordinate permutation from §3, existence of nonzero mixed derivative is equivalent to g i j=true. Conclude graph isomorphism.

## 5. Necessary edge cases and restrictions

- Require looplessness for cubic edge detection; loops reduce to quadratic terms over F₂.
- Bidirectional edges are allowed and detected separately.
- Do not assume internal maps preserve ω (false for m=2).
- Do not assume all third derivatives of the quartic seed are constant; only the cross-block mixed derivatives above are constant.
- The theorem classifies **canonical** graph representatives, not arbitrary quadratic perturbations.
- Keep V1/V2 source and build untouched.

## 6. Minimal implementation order

1. GraphMap.lean: actual graph map, cubic fourth derivative zero, graph fourth identity.
2. GraphEATransport.lean: fourth derivative under affine input/output, intrinsic pair relation.
3. GraphOutputRecovery.lean: coordinate output lines and matched permutation.
4. GraphEdgeRecovery.lean: exact mixed third derivative and edge iff nonzero.
5. GraphClassification.lean: EA iff graph isomorphism.
6. Only after a clean lake build and axiom audit: update FORMALIZATION_REPORT.md.

The existing V2 files provide templates, but their fixed Seed8 lemmas are **not** direct proofs for variable m.
