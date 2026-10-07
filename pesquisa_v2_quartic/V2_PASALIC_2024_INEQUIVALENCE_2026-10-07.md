# V2 — Exact separation from Pasalic–Polujan–Kudin–Zhang (IEEE TIT 2024)

Date: 2026-10-07

## Target

Compare the certified 8-variable quartic RS base block F1 with the three pairwise-inequivalent 8-variable bent functions outside M# and PS# reported in Examples 28, 29 and 37 of:

E. Pasalic, A. Polujan, S. Kudin, F. Zhang,
"Design and Analysis of Bent Functions Using M-Subspaces,"
IEEE Transactions on Information Theory 70(6), 4464–4477 (2024).
DOI: 10.1109/TIT.2024.3352824.

## Separating invariant

The local exact certificate `certify_base_relaxed_index.py` checks all 32,385 unordered independent nonzero pairs in F_2^8 and all 256 evaluation points per pair. It finds no independent a,b such that D_a D_b F1 is constant. In particular, no independent pair satisfies D_a D_b F1 == 0. Therefore

    ind(F1) = 1.

Ordinary linearity index / maximal M-subspace dimension is invariant under nonsingular affine equivalence (and remains unchanged by addition of affine output terms).

Thus, for any comparison function g, a single independent pair a,b with

    D_a D_b g == 0

proves ind(g)>=2 and therefore g is inequivalent to F1.

## Exact reconstruction of the 2024 examples

The companion script `certify_pasalic_2024_inequivalence.py` implements the published formulas for Examples 28, 29 and 37 using coordinates

    (x1,x2,x3,y1,y2,y3,s1,s2).

The last two bits select the four six-variable ingredient functions. The script independently verifies bentness by checking that every Walsh coefficient has absolute value 16.

It then exhaustively tests all 32,385 independent unordered direction pairs for zero second derivative.

## Results

The exact computation gives:

- Example 28: 21 independent pairs with D_a D_b f == 0.
- Example 29: 189 independent pairs with D_a D_b f == 0.
- Example 37: 21 independent pairs with D_a D_b f == 0.

Hence every published example has an M-subspace of dimension at least two, whereas F1 has no M-subspace of dimension two.

Therefore

    F1 not~ Example 28,
    F1 not~ Example 29,
    F1 not~ Example 37.

This is an exact invariant-based separation; it does not rely on heuristic search, random sampling, or design-isomorphism software.

## Consequence for the infinite family

For our interleaved r-fold direct-sum family F_r, the already certified theorem gives

    ind(F_r) = r = n/8.

The 2024 examples are important prior constructions of bent functions outside M# (and the displayed 8-variable examples are also outside PS#), but none of their three explicit 8-variable representatives is equivalent to our base block F1.

This removes the closest explicit 8-variable competitors identified in that paper.

## Scope / novelty wording

Defensible:

> The 8-variable quartic rotation-symmetric base block underlying our family is inequivalent to the three explicit pairwise-inequivalent 8-variable examples outside M# and PS# in Pasalic et al. (2024). The separation follows from M-subspace dimension: ind(F1)=1, whereas each of their Examples 28, 29 and 37 admits a two-dimensional M-subspace.

Do not yet claim global priority ("first known") solely from this comparison. A broader literature audit remains necessary.

## Reproducibility

Run:

    python pesquisa_v2_quartic/certify_base_relaxed_index.py
    python pesquisa_v2_quartic/certify_pasalic_2024_inequivalence.py

The second script writes `pasalic_2024_inequivalence_certificate.json`.

## V1 firewall

No V1 file is modified. V1 remains frozen on `preprint-v1-final-2026-10-06`.
