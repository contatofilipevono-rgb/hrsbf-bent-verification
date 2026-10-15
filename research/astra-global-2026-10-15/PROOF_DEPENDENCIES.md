# End-to-end dependency graph

## Canonical hypotheses

`anfCoefficient` = Boolean Mobius transform of truth-table evaluations on support vectors.
`booleanMobius_involution` → ANF reconstruction and uniqueness.
Canonical degree≤3 → explicit cubic polynomial representation.
Actual cyclic symmetry → canonical coefficient permutation covariance.

## Analytic route

Integer Walsh definition → Fourier inversion + Wiener--Khinchin → balanced nonzero derivatives.
Cubic representation → quadratic derivatives.
Cyclic invariance + power-of-two dimension + balance → independent Lemma 5.1 → zero all-ones derivative polar.

## Odd-order restriction

S^m=I with odd m → explicit averaging projector → fixed/kernel splitting and polar orthogonality.
Kernel has no nonzero fixed vector → S+I is surjective on its polar radical → invariant quadratic is constant on radical → finite Gauss identity → kernel sign sum nonzero.
Splitting + nonzero factor → quadratic balance transfer.
Actual balanced derivatives of a bent cubic → balanced restricted derivatives → actual restricted bentness.
Concrete S=rotation^t, N=t*m → proved order law and periodicity recurrence → explicit `cyclicFixedEquiv`; repeated blocks intertwine full rotations. No coordinate isomorphism is assumed in `bent_cyclic_odd_fold`.

## Global route

1. Assume the canonical antipodal coefficient is zero.
2. Rotation covariance makes every antipodal pair coefficient zero.
3. Pair all ANF supports by the free coordinate half-turn. Nonfixed supports cancel; fixed nonempty supports of size≤3 are quadratic antipodal pairs. Therefore the function is constant on the entire half-turn fixed space.
4. Factor every positive half-dimension H=2^r*m with m positive odd (proved by strong induction).
5. Restrict to the actual cyclic fixed space of dimension 2^(r+1). Actual bentness, cyclic symmetry and cubic polynomial representation survive.
6. Every repeated diagonal vector of the restriction is fixed by the original half-turn (proved by coordinate residues). The restriction consequently has constant diagonal.
7. Concrete two-block coordinates + the power-of-two derivative polar theorem + the original complementary-fiber contradiction rule out this bent restriction.
8. The zero coefficient is impossible. Since the coefficient lies in F₂, it equals 1.
9. A homogeneous cubic has no degree-two canonical coefficients, so it cannot be bent.

The standalone full equality of antipodal coefficients under odd folding is **not an edge in this graph**. No conjecture, pre-assumed restricted bentness, diagonal, zero polar, radical inclusion or artificial coefficient condition survives as a premise of the final universal theorem.
