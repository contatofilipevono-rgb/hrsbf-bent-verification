# V2 AUDIT STATUS — 2026-10-07

This file is the canonical navigation/status note for the V2 quartic exact-index work.

## PROVED / CURRENT

1. Base seed:
   - r-ind(f)=ind(f)=1.
   - Canonical conceptual proof: V2_EXTERIOR_SQUARE_CRITERION_2026-10-07.md.
   - Independent algebraic/Pluecker proof: V2_ALGEBRAIC_PROOF_SEED_RIND1.md and V2_HAND_PROOF_SEED_RIND1.md.
   - Independent exhaustive certificate: certify_base_relaxed_index.py / certificates/verify_seed_rind1.py.

2. Fourth-polarization kernel:
   - rank(Phi)=22, dim ker(Phi)=6.
   - nonzero alternating-rank spectrum: 3 elements rank 4, 60 elements rank 8, 0 elements rank 2.
   - therefore ker(Phi) contains no nonzero decomposable bivector.
   - canonical files: V2_EXTERIOR_SQUARE_CRITERION_2026-10-07.md and certify_quartic_exterior_square.py.

3. Correct cyclic-module structure:
   - K=ker(Phi) ~= V_4 direct-sum V_2, NOT V_6.
   - nilpotent filtration for N=rho+I: dim ker N^j = 2,4,5,6 for j=1,2,3,4.
   - canonical file: V2_EXACT_CYCLIC_MODULE_STRUCTURE_2026-10-07.md.

4. Infinite interleaved family:
   - ind(F_r)=r-ind(F_r)=r=n/8 for every r>=1.
   - canonical file: V2_EXACT_LINEARITY_INDEX_THEOREM_2026-10-07.md.
   - IMPORTANT: the proof uses direct block decomposition. It does NOT use bilinearity of finite differences in direction variables, which is false in general.
   - upper bound can be proved directly by block projections; no dependence on the exact numbering of Polujan--Pott Theorem 4.5(3) is needed.
   - interleaving is a coordinate permutation and preserves ind and r-ind.

5. Consequence:
   - under the standard M# criterion (membership requires an M-subspace of dimension n/2), F_r is outside M# for every r>=1.
   - deficiency n/2-ind(F_r)=3n/8.

## COMPUTATIONAL CERTIFICATES

- certify_base_relaxed_index.py
- certify_quartic_exterior_square.py
- certificates/verify_seed_rind1.py
- certificates/verify_seed_algebraic.py
- certify_quartic_boundary.py
- quartic_boundary_certificate.json

These support, but do not replace, the current human-readable proofs where such proofs are available.

## SUPERSEDED / DO NOT CITE

- V2_SYMBOLIC_C8_KERNEL_ROUTE_2026-10-07.md
- V2_REFINED_SYMBOLIC_C8_STRATEGY_2026-10-07.md

Those exploratory notes originally targeted the incorrect module identification K~=V_6. They are retained only as research history and are explicitly marked superseded.

Any other exploratory/priority-audit note is not a theorem source unless its result is repeated in one of the CURRENT files above.

## KNOWN CORRECTIONS MADE DURING AUDIT

1. Incorrect exploratory claim K~=V_6 corrected to K~=V_4 direct-sum V_2.
2. Incorrect invocation of bilinearity of finite differences removed from the exact-index proof. In characteristic two, D_{a+a'}D_b includes a third-derivative correction term in general.
3. Exact family result strengthened to ind(F_r)=r-ind(F_r)=n/8 using direct block projections for the upper bound and direct block decomposition for the lower bound.

## EXTERNAL ADVERSARIAL AUDIT

An independent adversarial review accepted the exterior-square implication r-ind(f)=1 conditional on the exact kernel/rank certificate, including the characteristic-two exterior-square and rank-2/decomposable steps.

A second adversarial review accepted the family theorem after identifying the false bilinearity justification; it supplied the direct block proof now incorporated in the canonical theorem. It also confirmed the stronger conclusion ind(F_r)=r-ind(F_r)=n/8.

## V1 ISOLATION

V1 is frozen and was not modified by this V2 audit.
