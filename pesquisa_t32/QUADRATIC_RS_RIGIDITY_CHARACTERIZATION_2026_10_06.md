# Exact characterization of quadratic RS rigidity

## Statement

Let \(N\ge 2\). The following are equivalent:

1. \(N\) is a power of two.
2. Every balanced rotation-symmetric Boolean function \(q:\mathbb F_2^N\to\mathbb F_2\) of degree at most two has zero polar form.

The forward implication is the quadratic rotation-symmetric rigidity lemma used in the submission manuscript.

For the converse, write
\[
N=dm,\qquad d=2^{v_2(N)},\qquad m>1\text{ odd}.
\]
Define the single-orbit quadratic
\[
q_d(x)=\sum_{i=0}^{N-1}x_i x_{i+d},
\]
with indices modulo \(N\). Since \(m\ge3\), this is a full quadratic orbit (no double counting).

## Proof of the converse

The graph underlying \(q_d\) is the disjoint union of \(d\) cycles of length \(m\), one on each residue class modulo \(d\). Its polar form is the adjacency bilinear form of this union of cycles.

On one odd cycle, a vector \(r\) is in the radical exactly when
\[
r_{j-1}+r_{j+1}=0
\]
at every vertex. Thus \(r_{j-1}=r_{j+1}\). Because the cycle length \(m\) is odd, all coordinates on that cycle are equal. Hence the radical consists exactly of vectors that are constant independently on each of the \(d\) cycles, and therefore has dimension \(d\).

Let \(r\) be 1 on one cycle and 0 on the others. Then
\[
q_d(r)=m\equiv1\pmod2.
\]
Thus the restriction of \(q_d\) to the radical is a nonzero linear form.

For a quadratic \(q\) with \(q(0)=0\) and polar radical \(R\),
\[
\left(\sum_x(-1)^{q(x)}\right)^2
=2^N\sum_{r\in R}(-1)^{q(r)}.
\]
Since \(q_d|_R\) is a nonzero linear form, the last sum is zero. Therefore \(q_d\) is balanced.

Its polar form is nonzero because every component is an odd cycle of length \(m\ge3\). Hence whenever \(N\) is not a power of two there exists a balanced quadratic rotation-symmetric function with nonzero polar form.

Together with the power-of-two rigidity lemma, this proves the equivalence.

## Computational falsification control

Before the symbolic proof was extracted, the proposed one-orbit construction was checked by exact GF(2) matrix algebra for every even non-power-of-two \(N\le100\). No exception occurred. The observed polar nullity was always \(d=2^{v_2(N)}\). These computations are validation only and are not premises of the proof.

## Relevance to the cubic theorem

This characterization explains exactly why the power-of-two hypothesis enters the Antipodal Rule through the quadratic derivative step. The subsequent local complementary-fiber rigidity lemma only requires even dimension and zero polar form; it does not require a power-of-two dimension or bentness.
