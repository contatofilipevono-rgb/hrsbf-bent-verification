# Manuscript review and proof-route proposal

No verified counterexample or mathematical discrepancy was found in the analyzed manuscript arguments. Historical public manuscript files were not edited.

## Proposed optional simplification

Replace the dependency of the main theorem on the full folding-coefficient identity (manuscript section "Exact antipodal coefficient transport", and its invocation in the final proof) with the following route, now implemented in Lean:

- Canonical half-turn cancellation proves that zero antipodal coefficient implies constancy on the whole half-turn fixed space, in every even dimension.
- Repetition of a diagonal vector from the smaller cyclic fixed space is fixed by the original half-turn, by direct residue arithmetic.
- The restricted cubic is bent by the proved odd-order restriction theorem, but has constant diagonal, contradicting the power-of-two fiber theorem.

This is a shorter sufficient obstruction transport. It does not assert that the stronger coefficient identity is false. That identity can remain as an ordinary independently proved auxiliary result, clearly distinguished from what the kernel build uses.

## Formalization-status wording

The manuscript's older statement that the global theorem is not Lean-formalized should be updated in a **new revision**, citing the exact source commit, universal theorem signature and successful clean CI once confirmed. Kernel certification does not imply journal acceptance, peer review, or novelty certification.

## Primary literature checked during this run

- Chirvasitu and Cusick, *Affine equivalence for quadratic rotation symmetric Boolean functions*, arXiv:1908.08448, https://arxiv.org/abs/1908.08448 (author-posted paper). Its abstract explicitly treats deciding quadratic balancing behavior; no separate novelty claim is made for that established theory.
- Sun, Shi, Liu and Fu, *On the conjecture about the nonexistence of homogeneous rotation symmetric bent functions*, Designs, Codes and Cryptography 94, article 93 (13 April 2026), https://doi.org/10.1007/s10623-026-01848-4 . The publisher's accessible abstract describes partial nonexistence results. The full subscription text was not independently available in this run; detailed theorem-by-theorem novelty comparison remains open.

These limited checks are not an exhaustive priority search. They support correct attribution and caution, not a claim of first discovery.
