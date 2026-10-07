# V2 — Exact linearity-index target for the quartic RS family

## Family
Let f be the certified 8-variable quartic RS bent block with orbit seeds
(0,1), (0,1,2,3), (0,1,2,5), (0,1,3,5).
For r>=1, n=8r, define
F_r(x)=sum_{j=0}^{r-1} f(x_j,x_{j+r},...,x_{j+7r}).

## Structural target
The verified target is
    ind(F_r)=r=n/8,
where ind is the maximum dimension of an M-subspace.

Consequently F_r is outside the completed Maiorana-McFarland class whenever the standard M-subspace characterization is applied, since r<n/2=4r.

The quantitative deficiency from the MM threshold is
    n/2-ind(F_r)=3r=3n/8.

## Proof obligations
The final theorem must have two independent parts.

1. Lower bound: exhibit an explicit r-dimensional M-subspace and verify D_a D_b F_r=0 for all basis generators.
2. Upper bound: prove algebraically that every M-subspace U has dim(U)<=r. Finite enumeration for r=1,2,... is only a certificate/control and cannot replace this step.

Because F_r is an interleaved direct sum of r identical blocks, the preferred route is to express the second derivative as the direct sum of block second derivatives and prove a projection/rank lemma limiting an M-subspace to one independent degree of freedom per block.

## Novelty firewall
Do not claim novelty from the certificate alone.

Polujan–Kudin–Pasalic, IEEE TIT 72(6), 2026, DOI 10.1109/TIT.2026.3685133, already prove RS bent functions outside M# and state that a quartic RS family of Carlet–Gao–Liu (JCTA 127, 2014) is outside M# for infinitely many dimensions.

The priority question is therefore narrower:
- Is this F_r the same family, affine/EA equivalent to it, or different?
- Does the literature already determine its exact linearity index?
- Does it prove exclusion for every n=8r, rather than only infinitely many dimensions?

Current public-source audit located the exclusion result but did not locate an explicit published formula ind(F_r)=n/8. This is a search status, not a novelty claim.

## Required reproducible certificate
The next certificate should record:
- exact block ANF;
- exact definition of M-subspace used;
- exhaustive base-case maximum dimension for r=1;
- explicit witness basis;
- controls for r=2 and feasible larger r;
- machine-checkable verification of every symbolic identity used in the general upper-bound lemma;
- JSON output with PASS/FAIL and hashes.

## V1 isolation
V1 remains frozen at d70ebc8a5a6c8a4901263af24ff71cbdb2a12e93 on preprint-v1-final-2026-10-06.
