# V3 PRIOR ART AUDIT — 2026-10-08

## Critical finding

**Do not claim that graph isomorphism -> polynomial equivalence is new.** Prior literature already establishes reductions of graph isomorphism to equivalence of cubic forms (Agrawal–Saxena, cited in later work), and the broader literature treats polynomial isomorphism and EA equivalence as established problems.

## Sources and relevance

1. Agrawal–Saxena, *On the Complexity of Cubic Forms*, https://www.cse.iitk.ac.in/users/nitin/papers/cubic-forms.pdf — establishes that graph isomorphism reduces to cubic-form equivalence (see exact theorem and field restrictions in original paper before citing a definitive statement).
2. *Polynomial-time algorithms for quadratic isomorphism of polynomials: The regular case*, https://www.sciencedirect.com/science/article/pii/S0885064X15000400 — abstract explicitly cites Agrawal–Saxena's graph-isomorphism reduction to cubic-polynomial equivalence.
3. Canteaut, Couvreur and Perrin, *Recovering or Testing Extended-Affine Equivalence*, IEEE TIT 68(9), 2022, https://ieeexplore.ieee.org/abstract/document/9758689 — foundational EA recovery and invariant algorithms for vectorial Boolean functions, especially quadratic functions.
4. *The number of affine equivalent classes and extended affine equivalent classes of vectorial Boolean functions*, https://www.sciencedirect.com/science/article/pii/S0166218X20304571 — prior enumeration and bounds for EA classes; our Burnside digraph numbers are not new.
5. *On the EA-classes of known APN functions in small dimensions*, https://link.springer.com/article/10.1007/s12095-020-00427-1 — describes correspondence between EA-equivalence and equivalence of associated codes.
6. *Affine equivalence of quartic homogeneous rotation symmetric Boolean functions*, https://www.sciencedirect.com/science/article/abs/pii/S0020025513006348 — prior affine classification of quartic homogeneous rotation-symmetric Boolean functions; do not conflate with our vectorial graph-indexed family.

## Proposed defensible novelty claim (provisional)

An explicit family of quartic vectorial Boolean functions indexed by **all loopless directed graphs**, for which ordinary EA-equivalence is equivalent to directed graph isomorphism, with a certified exact relaxed second-difference index and a Lean proof (including finite computational certificates).

This is a *specific construction and simultaneous property package*. Whether this package is genuinely new requires a deeper systematic literature search, especially Boolean function encodings of graph isomorphism, affine/EA equivalence, and graph-indexed polynomial maps.

## Claims to avoid

- 'First GI-hardness of polynomial equivalence': false in general.
- 'First graph encoding in Boolean functions': unsupported and likely false.
- 'Burnside formula/new unlabeled digraph sequence': known.
- 'Cryptographic security from large EA-class count': does not follow.
- 'GI-complete EA equivalence': not shown.
- 'GI-hard truth-table EA equivalence by this encoding': not shown.
- 'Arbitrary quadratic perturbations are equivalent whenever underlying graphs are isomorphic': not proved.

## Recommended paper positioning

Primary: a formalized exact EA classification theorem for a structured quartic vectorial Boolean family, with intrinsic block/edge recovery.
Secondary: exact relaxed M-subspace index, robust necessity under quadratic corrections, explicit many EA classes, and complexity corollary for succinct ANF/circuit representations.

## Unresolved review tasks

- Inspect Agrawal–Saxena's precise field assumptions, equivalence definition, and reduction.
- Search for prior results on EA equivalence and digraph isomorphism for vectorial Boolean functions.
- Check whether a reduction to EA-equivalence from cubic forms is already published, and whether this family is genuinely distinct.
- Confirm reproducibility by retrieving GitHub Actions run ID/logs (user reports green).
- Independently formalize/count Burnside specialization only if editorially worthwhile.

No changes to V1/V2 source files.
