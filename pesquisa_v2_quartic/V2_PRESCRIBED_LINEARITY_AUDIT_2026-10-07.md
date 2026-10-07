# V2 — Prescribed-linearity literature audit (2025/2026)

Date: 2026-10-07

## Primary source checked

Sadmir Kudin, Enes Pasalic, Alexandr Polujan, Fengrong Zhang, Haixia Zhao,
"Permutations satisfying (P1) and (P2) properties and ell-optimal bent functions,"
Journal of Cryptology 39(1), article 5 (2026).
DOI: 10.1007/s00145-025-09562-5.
Preprint: arXiv:2508.14277.

The full arXiv HTML was inspected, especially Introduction and Section 6.

## What the paper actually says

The authors explicitly state that little is known about constructions of bent functions outside M# with a prescribed maximal dimension of M-subspaces. They then focus on the extreme case ind(f)=1 and define such functions as ell-optimal.

Their explicit ell-optimal construction lies in the D_0 class:

    f(x,y) = x · pi(y) + delta_0(x),

under conditions on pi (P1 plus absence of linear structures in its components).

Thus this paper establishes important prior art for:
- minimal linearity index ind=1;
- explicit ell-optimal bent functions;
- secondary constructions using low-index ingredients;
- constructions outside M#.

It does NOT, in the statements inspected, give an infinite quartic rotation-symmetric family in dimensions n=8r with exact linearity index n/8.

## Important wording from the source

The source itself says that "little is known" about constructions outside M# with prescribed maximal M-subspace dimension, before specializing to the extreme value one. This is evidence that exact prescribed intermediate indices remain comparatively underdeveloped as of this paper.

This supports the relevance of our exact intermediate law

    ind(F_r) = n/8,

but is not a proof of global priority.

## Relation to our base block

Our F1 has ind(F1)=1 and is therefore ell-optimal under Definition 6.2 of Kudin et al.

This terminology should be adopted in V2:

    "The 8-variable quartic RS base block F1 is ell-optimal."

However, ell-optimality itself is not novel.

The new quantitative phenomenon in the direct-sum family is that r copies of this ell-optimal block have the exact intermediate index

    ind(F_r) = r = n/8,

while retaining quartic degree and rotation symmetry after interleaving.

## Direct-sum interpretation

The published relaxed-index inequality of Polujan--Pott gives the upper bound

    r-ind(F_r) <= r,

because r-ind(F1)=1.

The explicit one-direction-per-block M-subspace gives the matching lower bound

    ind(F_r) >= r.

Hence

    ind(F_r)=r-ind(F_r)=r=n/8.

This turns an ell-optimal 8-variable primitive into a family with an exactly controlled, linearly growing but strictly sub-M# index.

## Priority assessment after this check

Status strengthened from "unknown" to:

- LOW INDEX IN GENERAL: prior art exists.
- IND=1 / ELL-OPTIMAL: explicit prior art exists.
- PRESCRIBED INTERMEDIATE INDEX: source says little is known.
- EXACT n/8 FOR AN INFINITE QUARTIC RS FAMILY: not located in the checked source or targeted searches.
- GLOBAL "FIRST": still not claimed.

Recommended wording:

> Our eight-variable base block is ell-optimal in the terminology of Kudin et al. (2026). Repeated direct sums, followed by the interleaving permutation that restores rotation symmetry, yield an infinite quartic rotation-symmetric bent family with the exact intermediate linearity index ind(F_r)=r-ind(F_r)=n/8. In the literature checked, we did not locate this exact quantitative law for a prior infinite quartic rotation-symmetric family.

## Remaining audit targets

1. Canteaut--Charpin (2003), Lemma 3, because Kudin et al. identify it as an early source for the ind=1 phenomenon.
2. Polujan--Pott (2020) direct-sum examples: extract exact indices, not only outside-M# bounds.
3. The 2024 M-subspace paper: search all examples/tables for exact intermediate index values.
4. 2026 rotation-symmetric-outside-M# paper: inspect whether any theorem computes exact ind, rather than only proving ind<n/2.
5. Search citations using the exact phrases "prescribed linearity index", "linearity index equals", and "relaxed linearity index" with RS/quartic constraints.

## V1 firewall

No V1 file is modified.
