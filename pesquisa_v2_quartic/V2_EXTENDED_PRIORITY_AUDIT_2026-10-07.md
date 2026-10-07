# V2 — Extended priority audit: prescribed and exact linearity index

Date: 2026-10-07

## Sources checked in this pass

1. Canteaut--Charpin, "Decomposing bent functions", IEEE TIT 49(8), 2003, DOI 10.1109/TIT.2003.814476.
2. Pasalic--Polujan--Kudin--Zhang, "Design and Analysis of Bent Functions Using M-Subspaces", IEEE TIT 70(6), 2024, DOI 10.1109/TIT.2024.3352824.
3. Kudin--Pasalic--Polujan--Zhang--Zhao, "Permutations satisfying (P1) and (P2) properties and ell-optimal bent functions", Journal of Cryptology 39(1), 2026, DOI 10.1007/s00145-025-09562-5.
4. Polujan--Kudin--Pasalic, "Rotation-Symmetric Bent Functions Outside the Completed Maiorana-McFarland Class", IEEE TIT 72(6), 2026.

## Canteaut--Charpin 2003

This foundational paper studies restrictions/decompositions of bent functions through affine subspaces and second derivatives. It supplies important historical background for derivative-based decompositions and examples that cannot be decomposed into four bent functions.

In the material inspected, it does not state an infinite quartic rotation-symmetric family with exact linearity index n/8.

## Pasalic et al. 2024

This paper systematically analyzes M-subspaces, proves that the number of M-subspaces of a fixed dimension is invariant under equivalence, and constructs bent functions outside M# by 4-concatenation.

The already committed exact audit separates F1 from their explicit Examples 28, 29 and 37 by M-subspace dimension.

No statement located in this pass gives the all-r law ind(F_r)=n/8 for a quartic RS family.

## Kudin et al. 2026

This source explicitly introduces ell-optimal bent functions (ind=1) and emphasizes that little is known about constructions outside M# with prescribed maximal M-subspace dimension.

Therefore:
- ind=1 is prior art and terminology should be acknowledged;
- low/prescribed linearity index is not itself a novelty claim;
- exact intermediate-index families remain a legitimate narrower target.

Our F1 is ell-optimal. The direct-sum/interleaving construction gives the exact intermediate law ind(F_r)=n/8.

## Polujan--Kudin--Pasalic 2026

This paper is the decisive prior art for rotation-symmetric functions outside M#:
- first solution of the RS-outside-M# existence problem;
- cubic RS class in n=10 outside M#;
- Su maximum-degree RS family outside M# for all n>=8;
- CGL quartic RS family outside M# for infinitely many dimensions.

Our project must not claim first RS / first infinite RS / first quartic RS outside M#.

Existing committed audits separate our family from Su and CGL.

## Exact search conclusion

Across the sources above and targeted searches for:
- "linearity index" + n/8;
- exact/prescribed linearity index + bent;
- relaxed linearity index + quartic;
- rotation-symmetric + exact linearity index;

no source was located that establishes an infinite quartic rotation-symmetric bent family in n=8r with

    ind(F_r)=r-ind(F_r)=n/8.

This remains a negative bibliographic result, not a mathematical proof of priority.

## Strongest defensible contribution statement

> Let F_r be the interleaved r-fold direct sum of the certified eight-variable quartic rotation-symmetric bent block F1. We prove for every r>=1 that ind(F_r)=r-ind(F_r)=r=n/8. The base block is ell-optimal. The interleaving preserves rotation symmetry while the direct-sum structure yields an exactly controlled intermediate linearity index. In the literature examined, we did not locate the exact n/8 law for a previous infinite quartic rotation-symmetric bent family.

## Evidence stack currently recorded

- exact F1 relaxed-index certificate: all 32,385 independent direction pairs;
- all-r theorem ind(F_r)=r-ind(F_r)=n/8;
- CGL separation by disjoint dimension support;
- Pasalic 2024 Examples 28/29/37 separation by M-subspace dimension;
- Su family separation by degree for n>=16 and exact second-derivative spectrum for n=8;
- 2025/2026 prescribed-index and ell-optimal literature correction;
- this extended priority audit.

## Remaining risk

The remaining priority risk is not the major M-subspace literature already identified. It is an obscure or differently-termed construction whose exact M-subspace dimension can be specialized to n/8 without using the phrase "linearity index". Thus a global "first known" claim is still intentionally withheld.

## V1 firewall

No V1 file is modified.
