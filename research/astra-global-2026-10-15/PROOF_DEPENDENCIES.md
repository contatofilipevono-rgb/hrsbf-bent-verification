# Proof dependencies

## Certified analytic route

`IsBent` (integer Walsh-square = cardinality) → `transform_autocorrelation` + `transform_inversion` → balanced nonzero derivatives.

Canonical ANF degree≤3 → `hasCubicRepresentation_of_anf_degree` → `cubic_derivative_third_zero`.

Cyclic invariance + bentness + cubic degree + N=2^k → balanced cyclic quadratic all-ones derivative → independent Lemma 5.1 → zero derivative polar.

## Certified odd-order route

Odd order + S^m=I → `orbitAverage` → idempotent, image fixed, fixed/kernel direct decomposition.

Invariant quadratic → fixed/kernel polar orthogonality.

Kernel restricted symmetry + averaging identity → no nonzero fixed vector → S+I surjective on the **polar radical** → quadratic constant on radical → generic finite Gauss identity → nonzero kernel sign sum.

Actual decomposition + orthogonality + nonzero kernel sum → `odd_order_quadratic_balance_iff`.

Balanced quadratic derivatives of actual bent cubic → balance transfer → balanced nonzero derivatives of restriction → `odd_order_bent_restriction`.

## Certified power-of-two homogeneous corollary

Canonical homogeneous cubic + coordinate half-turn → diagonal zero (`homogeneous_cubic_vanishes_on_fixed_vectors`).

Explicit `joinBlocks` → coordinate/rotation/Walsh transport → existing fiber contradiction. All-ones derivative polar zero is derived by the analytic route. Therefore `not_bent_homogeneous_cubic_power_two`.

## Missing global edges

Canonical antipodal coefficient zero → full degree≤3 diagonal identity: G1.

Concrete cyclic odd subgroup → explicit repeated-block coordinates and transported degree/symmetry: G2/G5.

Canonical coefficients under odd folding: G3.

All these edges + two-variable endpoint → universal theorem: G4, **not proved**.
