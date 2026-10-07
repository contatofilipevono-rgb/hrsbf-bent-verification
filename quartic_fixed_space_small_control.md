# Exact small control for odd-order fixed-space bentness

## Test

Dimension n=6. Let sigma be cyclic coordinate rotation and take T=sigma^2, which has order 3. Its fixed space U=Fix(T) has dimension 2.

All rotation-symmetric Boolean functions on 6 variables were enumerated exactly via the 14 input necklaces, hence 2^14=16384 functions.

Results:
- rotation-symmetric bent functions: 48;
- bent functions whose restriction to U is not bent: 0.

Degree distribution among the 48 RS bent functions:
- degree 2: 8;
- degree 3: 40.

Thus this control includes nonquadratic bent functions but does not yet test genuine quartic RS bent functions.

The dual-coset criterion was also checked directly. For every one of the 48 bent functions, if H=U^perp, the absolute character sums of the bent dual over all cosets of H are uniform, exactly as predicted by the criterion.

## Interpretation

This is evidence only. It does not prove odd-order fixed-space preservation beyond degree 3. In fact, the degree distribution explains why the n=6 experiment is consistent with the already-proved cubic restriction theorem.

A genuinely new quartic falsification test requires a dimension admitting:
1. a nontrivial odd-order rotation with even-dimensional fixed space; and
2. rotation-symmetric bent functions of algebraic degree 4.

Natural next dimensions are n=10 (order-5 reduction to dimension 2) and n=12 (order-3 reduction to dimension 4), but exhaustive enumeration of all RS functions is not the appropriate first approach.

## Current quartic target

Search specifically within quartic RS bent candidates or known quartic bent constructions for failure of dual-coset uniformity. A single counterexample would kill the hoped-for degree-4 fixed-space transfer theorem; survival would justify a proof attempt.
