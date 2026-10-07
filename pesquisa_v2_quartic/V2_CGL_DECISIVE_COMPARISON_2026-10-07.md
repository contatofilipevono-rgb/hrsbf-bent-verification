# V2 — Decisive comparison with Carlet–Gao–Liu (2014)

Date: 2026-10-07

## Primary-source result

The full 2014 JCTA paper supplied for this audit resolves the principal identity question.

Carlet–Gao–Liu, Theorem 3.8, assumes n=2m with m odd and constructs a quartic rotation-symmetric bent function h* from two m-variable quadratic RS semi-bent functions with complementary Walsh supports. Therefore its admissible dimensions satisfy

    n = 2m, m odd,
    n ≡ 2 (mod 4).

The paper's conclusion explicitly describes this quartic RS bent family as having n even but not divisible by 4.

## Comparison with F_r

Our interleaved direct-sum family satisfies

    n = 8r,
    n ≡ 0 (mod 8).

Hence the admissible dimension sets are disjoint.

Consequently F_r is not literally the quartic family of CGL Theorem 3.8. Moreover no member of F_r can be affine/EA-equivalent to a member of that CGL family, because affine/EA equivalence compares Boolean functions on the same ambient dimension and there is no common admissible dimension.

This removes the principal suspected overlap with the 2014 quartic family.

## Structural distinction

CGL Theorem 3.8 obtains h* through the indirect-sum construction

    h*(x,y)=f1*(x)+f1*(y)+(f1*+f2*)(x)(f1*+f2*)(y),

with m odd.

Our F_r is an interleaved coordinate permutation of an r-fold direct sum of one certified 8-variable quartic bent block.

Thus the constructions differ both in admissible dimensions and in the displayed secondary-construction structure.

## Our quantitative theorem

For every r>=1,

    ind(F_r)=r=n/8.

Therefore

    F_r notin M#

and its exact deficiency from the M# M-subspace threshold is

    n/2-ind(F_r)=3r=3n/8.

The proof uses:
1. exact exhaustive certification that the 8-variable base block has relaxed linearity index 1;
2. the published direct-sum upper bound for relaxed linearity index;
3. an explicit r-dimensional M-subspace, one direction per block;
4. invariance under the interleaving coordinate permutation.

## Novelty status after primary-source comparison

The CGL identity/equivalence concern is RESOLVED: the Theorem 3.8 quartic family is distinct from F_r already by dimension support.

Global novelty is still a separate bibliographic question. We must still exclude other quartic RS bent constructions in dimensions n=8r and prior exact computations of linearity index n/8.

Defensible manuscript wording at this stage:

> We study an interleaved direct-sum family of quartic rotation-symmetric bent functions in dimensions n=8r and determine its exact linearity index, ind(F_r)=n/8. The family is distinct, already at the level of admissible dimensions, from the quartic rotation-symmetric family of Carlet–Gao–Liu (2014), whose construction requires n=2m with m odd.

Do not use “first” until the broader priority audit is complete.

## Source anchors

Carlet, Gao, Liu, Journal of Combinatorial Theory Series A 127 (2014), 161–175, DOI 10.1016/j.jcta.2014.05.008:
- Proposition 3.7: indirect-sum RS bent construction.
- Theorem 3.8: n=2m, m odd; explicit quartic RS bent h*.
- Following paragraph: first infinite classes of bent idempotents and RS bent functions of degree >3.
- Conclusion: quartic RS bent family has n even but not divisible by 4.

## V1 firewall

V1 remains frozen at d70ebc8a5a6c8a4901263af24ff71cbdb2a12e93 on branch preprint-v1-final-2026-10-06. No V1 file is modified.
