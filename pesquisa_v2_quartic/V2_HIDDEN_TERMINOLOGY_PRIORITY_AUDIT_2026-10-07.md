# V2 — Hidden-terminology priority audit

Date: 2026-10-07

## Purpose

Search for prior results that could subsume ind(F_r)=n/8 without using the phrase "linearity index" prominently, especially under:
- M-subspace dimension;
- maximal M-subspace;
- normality / weak normality;
- decompositions and concatenations;
- controllable/prescribed low linearity index.

## Important additional prior art

### Kudin--Pasalic--Polujan--Zhang: algebraic characterization of M-subspaces of bent concatenations

The 2025 IEEE TIT work on bent concatenations is closer than a title-only search suggests. For constructions of the form

    f = g || h || g || (h+1),

it gives algebraic characterizations of M-subspaces and exact/upper-bound control of ind(f). In particular, its results show that the concatenation mechanism can reduce the linearity index relative to ind(g), ind(h), and can be iterated to produce controllably low indices.

This is important prior art for "exact/controllable low index" as a general phenomenon.

It is nevertheless a different construction mechanism from our interleaved direct sum, and no located theorem in this audit states an infinite quartic rotation-symmetric n=8r family with exact ind=n/8.

### Normality literature

Normality asks for a large affine flat on which f is constant (or affine for weak normality). This is related to, but not identical with, M-subspace dimension.

The 2026 result of Gillot--Langevin--Polujan proves that every 8-variable bent function is normal up to addition of a linear function. Therefore normality cannot be used as a novelty separator for our 8-variable base block.

No source located in the normality search converts that universal n=8 normality statement into the all-r identity ind(F_r)=n/8.

### Older rotation-symmetric literature

Gao--Zhang--Liu--Carlet (2012) gives infinite quadratic/cubic RS bent constructions. Carlet--Gao--Liu (2014) gives the first infinite RS bent classes of algebraic degree >3. These are essential RS antecedents but do not supply the same dimension/index theorem.

## Key conceptual distinction for the manuscript

Avoid claiming:
- "first controllable low-linearity-index bent family";
- "first prescribed-index construction";
- "first ell-optimal bent function";
- "first RS bent outside M#";
- "first quartic RS bent family".

The narrow result currently surviving the audit is:

    explicit quartic RS bent F_r, n=8r,
    ind(F_r)=r-ind(F_r)=r=n/8 for every r>=1.

## Why n/8 is nontrivial despite prescribed-index prior art

The index is not simply selected as an external parameter. It is forced exactly by:
1. an ell-optimal 8-variable quartic RS primitive F1 with r-ind(F1)=1;
2. the published subadditivity of relaxed linearity index under direct sum;
3. an explicit r-dimensional ordinary M-subspace;
4. an interleaving permutation that yields the RS presentation without changing the invariant.

Thus the exact index, quartic degree, and RS symmetry coexist for all n=8r.

## Search result

Targeted web searches using both modern and older terminology did not locate a prior theorem with all four properties:
1. infinite family;
2. quartic;
3. rotation-symmetric;
4. exact linearity index n/8 in n=8r variables.

This is a bibliographic negative result, not a proof of global absence.

## Priority wording

Recommended:

> We prove an exact linearity-index theorem for an explicit infinite quartic rotation-symmetric bent family: ind(F_r)=r-ind(F_r)=n/8 for n=8r. While recent concatenation and ell-optimal constructions provide bent functions with controllable or minimal linearity index, the literature examined in our priority audit did not reveal this exact n/8 law for a previous infinite quartic rotation-symmetric family.

## V1 firewall

No V1 file is modified.
