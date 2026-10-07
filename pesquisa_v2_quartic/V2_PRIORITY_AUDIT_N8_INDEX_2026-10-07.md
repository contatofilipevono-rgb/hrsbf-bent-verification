# V2 — Priority audit for the exact linearity index n/8

Date: 2026-10-07

## Claim under audit

For the interleaved r-fold direct-sum quartic RS bent family F_r in n=8r variables,

    ind(F_r) = r-ind(F_r) = r = n/8.

This file audits whether the exact quantitative identity n/8, rather than merely being outside M#, is already present in the literature located as of 2026-10-07.

## Search outcome

Targeted searches were performed for combinations of:
- "linearity index" + "n/8" + bent;
- quartic bent + M-subspaces + linearity index;
- rotation-symmetric bent + M-subspace / M#;
- relaxed linearity index / r-ind + quartic bent;
- direct-sum quartic rotation-symmetric bent functions.

No located source states the exact identity ind(f)=n/8 for an infinite quartic rotation-symmetric bent family.

This is a negative search result, not a proof of global priority.

## Most important 2026 prior art

A. Polujan, S. Kudin, E. Pasalic,
"Rotation-Symmetric Bent Functions Outside the Completed Maiorana-McFarland Class,"
IEEE Transactions on Information Theory 72(6), 4341–4351 (2026),
DOI 10.1109/TIT.2026.3685133.

This paper is mandatory prior art. It:
1. classifies cubic RS bent functions in dimension 10 and finds an EA class outside M#;
2. proves the maximum-degree RS family of Su is outside M# for every n>=8;
3. proves the quartic RS family of Carlet–Gao–Liu (2014) is outside M# for infinitely many n.

Therefore our novelty cannot be framed as:
- first RS bent functions outside M#;
- first infinite RS family outside M#;
- first quartic RS family shown outside M#.

## Separation from the 2026 families

### Su family

The Su family treated in the 2026 paper has maximum algebraic degree n/2.
Our F_r has algebraic degree exactly 4 for every r.

Thus for n=8r with r>=2, deg(Su)=4r > 4, so EA equivalence is excluded by algebraic degree.

At n=8 (r=1), both degrees equal 4. This isolated dimension requires an invariant comparison if one wishes to exclude equivalence of the base block to Su's n=8 member; degree alone does not separate them.

### Carlet–Gao–Liu quartic family

The decisive primary-source audit already stored in
V2_CGL_DECISIVE_COMPARISON_2026-10-07.md shows that the CGL Theorem 3.8 family requires

    n=2m, m odd,

hence n == 2 mod 4. Our family requires n=8r. The dimension supports are disjoint, so no member can be EA-equivalent.

## Pasalic et al. 2024 explicit 8-variable examples

The exact certificate in certify_pasalic_2024_inequivalence.py separates F1 from Examples 28, 29 and 37 by ordinary M-subspace dimension:
- ind(F1)=1;
- each comparison example admits an independent zero-second-derivative pair and hence ind>=2.

## Current defensible novelty statement

Recommended manuscript wording:

> We determine the exact linearity index of an explicit infinite family of quartic rotation-symmetric bent functions in dimensions n=8r, proving ind(F_r)=n/8 for every r>=1. In a targeted literature audit, we did not locate a previously published infinite quartic rotation-symmetric bent family for which the exact identity ind(f)=n/8 is established. This quantitative statement is distinct from prior results establishing rotation-symmetric bent functions outside the completed Maiorana–McFarland class.

Do NOT replace "we did not locate" with "first known" or "first" until a broader systematic priority review is completed.

## New remaining high-value check

At n=8, Su's maximum-degree family also has degree 4. Therefore compute the exact n=8 Su representative from the published formula and compare it with F1 using:
1. ordinary linearity index;
2. relaxed linearity index;
3. zero-second-derivative pair counts;
4. if necessary, 2-rank and derivative spectra.

For r>=2, algebraic degree already excludes equivalence between F_r and Su's family.

## V1 firewall

No V1 file is modified.
