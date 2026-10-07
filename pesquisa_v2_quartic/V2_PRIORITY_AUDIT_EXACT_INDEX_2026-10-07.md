# V2 — Priority audit for the exact linearity-index theorem

Date: 2026-10-07

## Claim under audit

For the interleaved r-fold direct-sum quartic RS bent family F_r on n=8r variables,

    ind(F_r)=r=n/8,

hence F_r is outside the completed Maiorana–McFarland class M# for every r>=1, with exact deficiency

    n/2-ind(F_r)=3n/8.

This file audits novelty separately from correctness.

## What is definitely prior art

### Carlet–Gao–Liu (2014)
C. Carlet, G. Gao, W. Liu, JCTA 127 (2014), 161–175,
DOI 10.1016/j.jcta.2014.05.008.

The paper constructs the first infinite classes of rotation-symmetric/idempotent bent functions of algebraic degree greater than 3. Therefore neither “infinite quartic RS bent family” nor “first RS bent family of degree >3” is a novelty claim available to us.

### Polujan–Kudin–Pašalić (2026)
A. Polujan, S. Kudin, E. Pašalić, IEEE TIT 72(6) (2026), 4341–4351,
DOI 10.1109/TIT.2026.3685133.

Their published abstract states:
1. a cubic RS bent EA-class in 10 variables is outside M#;
2. a maximum-degree RS bent family of Su is outside M# for all n>=8;
3. a quartic RS bent family of Carlet–Gao–Liu is outside M# for infinitely many n.

Therefore we must NOT claim:
- first RS bent functions outside M#;
- first infinite RS bent family outside M#;
- first quartic RS bent family outside M#.

## Exact-index search

Dedicated searches were run for combinations of:
- "n/8" + "linearity index" + bent;
- "n/8" + "M-subspace" + bent;
- "r-ind" + quartic + rotation symmetric;
- "linearity index" + Carlet/Gao/Liu;
- the 2026 paper title + "linearity index".

The accessible literature located definitions and general machinery for M-subspaces, relaxed M-subspaces, and low-linearity-index constructions, but no explicit statement was located giving

    ind(F_r)=n/8

for the quartic RS family under study.

This is evidence of a potentially new quantitative refinement, NOT proof of novelty.

## Correctness backbone already available in prior theory

Polujan–Pott, Designs, Codes and Cryptography 88 (2020), develops relaxed M-subspaces and relaxed linearity index for direct sums. This is the correct published machinery for our upper bound.

Our independent exact base-block certificate finds no independent nonzero pair a,b in F_2^8 for which D_a D_b f is constant. Thus

    r-ind(f)=1.

Applying the direct-sum inequality iteratively gives

    ind(F_r) <= r-ind(F_r) <= r.

An explicit one-direction-per-block M-subspace gives ind(F_r)>=r. Hence ind(F_r)=r.

The interleaved RS representation is a coordinate permutation of the ordinary direct sum, so the index is unchanged.

## Current novelty status

STATUS: PLAUSIBLE QUANTITATIVE NOVELTY — NOT YET CERTIFIED.

The strongest defensible wording at this stage is:

> We determine the exact linearity index of the interleaved direct-sum quartic rotation-symmetric bent family, obtaining ind(F_r)=n/8 for n=8r. Existing literature already contains rotation-symmetric bent functions outside M# and quartic RS examples outside M#; our priority audit therefore treats the exact index formula, rather than non-membership itself, as the candidate new contribution.

Do not use “first” until the full text/formula of the Carlet–Gao–Liu family and the 2026 secondary-construction section have been compared explicitly.

## Remaining equivalence test

The unresolved bibliographic question is whether our base block / r-fold family is:
A. literally an instance of the Carlet–Gao–Liu quartic family;
B. linearly/affinely/EA-equivalent to an instance;
C. structurally distinct.

Even in cases A or B, the exact formula ind=n/8 may remain a valid new refinement if it is not already proved. In case C, both the construction and the quantitative invariant may be new, subject to broader literature search.

## Sources checked

- Carlet author publication page / JCTA metadata for the 2014 construction.
- IEEE / University of Primorska repository metadata for Polujan–Kudin–Pašalić 2026.
- Polujan–Pott 2020 direct-sum / relaxed M-subspace literature.
- Pasalic et al. 2024 systematic M-subspace literature.
- 2025/2026 low-linearity-index and l-optimal literature.

## V1 firewall

No V1 claim or file is changed. V1 remains frozen at
d70ebc8a5a6c8a4901263af24ff71cbdb2a12e93.
