# Quartic fixed-space falsification strategy

## Literature checkpoint

Classical exhaustive work on homogeneous rotation-symmetric functions reports no homogeneous RS bent functions of degree >2 through n=10, including exhaustive homogeneous searches in degrees 3, 4, and 5 for n=10. Therefore n=10 homogeneous degree 4 is not a useful new search target.

Known nonhomogeneous rotation-symmetric bent constructions can have high algebraic degree. These are useful as controls because the proposed fixed-space transfer statement is about degree <=4 and does not intrinsically require homogeneity.

## Exact n=6 control

For n=6, T=sigma^2 has order 3 and dim Fix(T)=2. Exact enumeration of all 2^14 RS functions gives 48 bent functions and zero failures of fixed-space bentness. These bent functions have degree 2 or 3, so this is fully consistent with the established cubic theorem and is not new quartic evidence.

## Next falsification target

A genuinely informative counterexample search should satisfy all of:
1. f rotation-symmetric and bent;
2. deg f=4;
3. n has an odd factor, so T=sigma^(2^s) has nontrivial odd order;
4. f restricted to U=Fix(T) can be tested for bentness.

Natural dimensions:
- n=10: U has dimension 2, T has order 5;
- n=12: U has dimension 4, T has order 3.

Do not enumerate the full RS function space. Search within known nonhomogeneous RS bent constructions or affine/equivalence families that preserve rotation symmetry and yield exact degree 4.

## Decision rule

One counterexample f with deg f<=4 and f|_U non-bent disproves the hoped-for quartic fixed-space transfer theorem.

If a substantial structured family survives, that is evidence only and the proof target remains the dual-coset uniformity criterion.

## Current status

No quartic transfer theorem is claimed.
No quartic counterexample has yet been found.
The next computation should be construction-driven rather than brute-force.
