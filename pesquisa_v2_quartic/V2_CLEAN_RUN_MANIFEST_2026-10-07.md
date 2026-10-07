# V2 clean-run reproducibility manifest

Purpose: define the exact checks that must pass from a clean checkout before submission. A mismatch in any mandatory invariant below is a release blocker.

## A. Seed relaxed-index certificate

Scripts:
- certify_base_relaxed_index.py
- certificates/verify_seed_rind1.py

Required result:
- seed is the stated 8-variable quartic RS Boolean function;
- all unordered independent nonzero direction pairs are checked;
- number of such pairs: 32,385;
- no independent pair (a,b) has D_aD_b f constant;
- conclusion: r-ind(f)=1.

Release blocker:
- any skipped pair, probabilistic sampling, or independent pair with constant second derivative.

## B. Algebraic / Pluecker certificate

Script:
- certificates/verify_seed_algebraic.py

Required result:
- 28 Pluecker variables p_ij;
- contraction matrix rank 22;
- kernel dimension 6;
- free variables (37),(46),(47),(56),(57),(67);
- selected Grassmann--Pluecker relations reduce to the four equations used in the canonical manuscript;
- exhaustive evaluation of the six free Boolean coordinates finds no nonzero common solution of those necessary decomposability relations;
- conclusion: ker(Phi) contains no nonzero decomposable bivector.

Release blocker:
- different RREF/kernel parametrization not algebraically equivalent to the manuscript;
- any nonzero common solution.

## C. Exterior-square / alternating-rank certificate

Script:
- certify_quartic_exterior_square.py

Required result:
- dim Lambda^2(F_2^8)=28;
- rank(Phi)=22;
- dim ker(Phi)=6;
- 63 nonzero kernel elements;
- rank spectrum:
    rank 4: 3,
    rank 8: 60,
    rank 2: 0;
- conclusion: no nonzero decomposable bivector.

Release blocker:
- any rank-2 nonzero kernel element;
- mismatch with the algebraic kernel dimension/rank.

## D. Quartic boundary certificate

Files:
- certify_quartic_boundary.py
- quartic_boundary_certificate.json

Required result:
- rerun script and compare regenerated exact data with committed JSON;
- no unexplained mismatch.

This certificate is supplementary unless a theorem in the canonical manuscript explicitly depends on one of its fields.

## E. Family theorem

No growing-dimension exhaustive computation is required.

Human proof obligations:
1. r-ind(f)=1 from the finite seed proof.
2. For relaxed U of the r-fold direct sum, each block projection pi_i(U) is relaxed for f.
3. dim pi_i(U)<=1, hence dim U<=r.
4. One chosen nonzero direction per block spans an r-dimensional ordinary M-subspace.
5. Therefore
       ind(F_r)=r-ind(F_r)=r=n/8.
6. Interleaving is a coordinate permutation and preserves both indices.

Forbidden justification:
- do NOT invoke bilinearity of finite differences in direction variables.

## F. Structural module certificate

Current structural claim:
- K=ker(Phi) ~= V_4 direct-sum V_2;
- for N=rho+I on K:
    dim ker N   = 2,
    dim ker N^2 = 4,
    dim ker N^3 = 5,
    dim ker N^4 = 6.

This is supplementary and is NOT required for the exact n/8 theorem.

Release blocker only if retained as a theorem/claim in the submitted paper:
- any mismatch in the filtration or module type.

## G. Manuscript consistency gates

Before release, search the submission sources for:
- "K ~= V_6" or equivalent: must not appear as a current claim;
- "bilinearity of finite differences": may appear only in a correction/history note, never as proof;
- "first quartic RS family outside M#": forbidden;
- "first RS family outside M#": forbidden;
- unconditional global novelty language: forbidden until the 2026 Tang comparison is completed.

Canonical mathematical claim:
    ind(F_r)=r-ind(F_r)=n/8 for n=8r.

## H. V1 firewall

Do not modify V1 or its frozen branch/tag while executing this manifest.
