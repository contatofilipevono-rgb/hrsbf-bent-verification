# GLOBAL RESULT: NOT PROVED

Author of the scientific manuscript: Filipe Martins Vono. Independent mathematical and Lean continuation, 15 October 2026.

The universal all-even-dimensional antipodal theorem and its universal homogeneous-cubic corollary are **not certified** by this branch. No release/submission claim should say otherwise.

## New completed components

1. Exact integer Fourier inversion, Wiener--Khinchin, and the equivalence between bentness and balanced nonzero derivatives.
2. In power-of-two dimension, actual bentness, cubic degree and rotation invariance force the all-ones derivative to have zero polar. Neither balance nor the zero polar is assumed.
3. Odd-order quadratic balance transfer to the actual fixed subspace, on arbitrary finite F₂-modules. The averaging projector, its kernel, their splitting and polar orthogonality are constructed, not postulated.
4. Actual cubic bentness survives odd-order fixed-space restriction in any linear coordinates on the fixed space. There is a version taking the **canonical ANF degree bound**.
5. Canonical ANF via Boolean Mobius inversion, reconstruction, uniqueness, permutation covariance and conversion of degree≤3 to the existing cubic polynomial interface.
6. Homogeneous cubic cancellation on the fixed vectors of any free coordinate involution.
7. Explicit linear concatenation of two coordinate blocks, Walsh normalization transport, and equality between concrete block rotations and full cyclic powers.
8. **Homogeneous cubic RS functions are not bent in power-of-two dimensions.** This is a genuine kernel theorem with no diagonal, derivative-balance, polar or coordinate-compatibility assumptions. The only dimension equality is `(n+1)+(n+1)=2^k`, `k≥1`; every positive even power of two is covered.

## Reused starting work and provenance

The starting branch was checked at `c333889462e4c08acfb9ae2b6a12ecb2124f8c15`. The independent Lemma 5.1 completion was found at `f3d41a59d4a699367fd0c40374e93f7ba230b0cb`, with clean CI run 38673954917. Its source and theorem signature were inspected, and it was chosen as the exact parent of this isolated branch. Comparing it against c333889 showed the latter adds mission documentation but lacks the independent quadratic completion; no blind merge was made. The global mission text was copied unchanged from c333889.

The existing nilpotence, Nakayama, quadratic Gauss and fiber modules are reused without changing their proofs. The independent worker's derivative bridge is also retained.

## Remaining work

See GAP_REGISTER.md. The general degree≤3 power-of-two **antipodal necessity** theorem is still missing its complete canonical diagonal identity. Odd-order restriction is proved abstractly, but its concrete cyclic folding coordinates and symmetry/degree transport are not assembled. Exact all-dimensional antipodal coefficient transport is still computationally checked, not kernel-proved. The final universal theorem does not exist in this branch.

No mathematical counterexample was found in the executed searches. That does not eliminate the formalization gaps.

## Publication implications

This is a reproducible research progress branch, not certification of the complete manuscript or a journal/arXiv publication. The global certification gate remains closed. The existing manuscript has not been silently edited.
