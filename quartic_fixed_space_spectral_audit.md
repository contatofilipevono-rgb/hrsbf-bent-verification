# Quartic fixed-space transfer: spectral audit

## Missing statement

For extending the cubic theorem to degree four, the key missing implication is:

If f is bent of degree at most four, T has odd order, a is a nonzero vector in U=Fix(T), and f and D_a f are T-invariant, must D_a f remain balanced after restriction to U?

For degree three this follows because D_a f is quadratic. For degree four it is cubic.

## Second-derivative autocorrelations

For c=D_a f,

A_c(b)=sum_x (-1)^{D_b c(x)}
      =sum_x (-1)^{D_aD_b f(x)}.

Writing s_x=(-1)^{f(x)}, this is the four-point correlation

A_c(b)=sum_x s_x s_{x+a} s_{x+b} s_{x+a+b}.

Bentness of f forces all nonzero two-point autocorrelations

sum_x s_x s_{x+a}=0,

but it does not, by itself, force the four-point correlations A_c(b) to vanish or take one universal value. Therefore there is no immediate spectral shortcut from bentness to balance of the quadratic second derivatives.

## What the existing quadratic lemma still gives

For a,b in U, q_{a,b}=D_aD_b f is T-invariant and quadratic. Hence its zero-frequency character sum is zero on V if and only if it is zero on U.

Equivalently, for directions b in U, the statement

A_{D_a f}(b)=0

transfers exactly between V and U.

This is useful but insufficient: balance of D_a f|_U is its zero-frequency Walsh coefficient, whereas the transferred data concern autocorrelations of that restricted cubic.

## Exact small control

As a sanity check, all 896 bent Boolean functions in four variables were enumerated for an order-three coordinate permutation cycling three coordinates and fixing one. Among 384 cases where a derivative in a nonzero fixed direction was T-invariant, no failure of balance transfer to Fix(T) occurred.

This is not evidence for the genuinely quartic case: bent functions in four variables have algebraic degree at most two. It only verifies that the formulation is consistent in the smallest exact control.

## Next falsification target

The first genuinely informative dimensions are n>=8, where bent functions can have degree four. Exhaustive enumeration is impossible, but structured degree-four bent families (Maiorana-McFarland and related constructions) can be sampled exactly while imposing an odd-order coordinate symmetry.

The immediate research question is therefore:

Can one construct a T-invariant quartic bent f and a nonzero a in Fix(T) such that D_a f is balanced on V but not balanced on Fix(T)?

A single example kills the proposed quartic fixed-space transfer. Failure to find one in broad structured families would motivate a theorem with additional hypotheses.

No quartic transfer theorem is claimed at this stage.
