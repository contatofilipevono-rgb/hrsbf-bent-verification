# V2 targeted literature check — 2026-10-08

Preliminary search, **not** a comprehensive novelty or priority review.

1. Polujan and Pott, *Cubic bent functions outside the completed Maiorana–McFarland class*, Designs, Codes and Cryptography (2020), https://link.springer.com/article/10.1007/s10623-019-00712-y. Defines relaxed M-subspaces and the relaxed linearity index for scalar Boolean functions. Therefore the scalar notion of constant second derivatives on a subspace must not be claimed as new.
2. Kaleyski, *Deciding EA-equivalence via invariants*, Cryptography and Communications 14 (2022), 271–290, https://link.springer.com/article/10.1007/s12095-021-00513-y. Relevant to positioning EA invariants.
3. *Affine equivalence of quartic homogeneous rotation symmetric Boolean functions*, Information Sciences 259 (2014), 192–211, https://doi.org/10.1016/j.ins.2013.09.001. Related quartic rotation-symmetric equivalence literature; not the same oriented-graph classification.

**Current scope:** these sources do not by themselves establish whether the specific vectorial oriented-graph family, exact index, and EA classification are new. A broader focused search and careful comparison are required before submission.

**Reproduction:** run `python V2_graph_no_extra_output.py` from this folder. Expected outputs: contraction rank 22/28, kernel dimension 6, nonzero bivector ranks 4:3 and 8:60. The Python script verifies the finite seed lemma, not the infinite-family proof.

**Proof caution:** `D^3F` is not globally constant for quartic F. Only mixed third derivatives involving distinct blocks are base-point-independent in the canonical construction.

**Quadratic perturbations:** graph isomorphism is a necessary condition for EA equivalence of arbitrarily perturbed functions; the converse is not established.
