# V2 — Hand proof of the Pluecker-kernel step

Date: 2026-10-07

This note replaces the final Groebner/64-state check in the algebraic proof of r-ind(f)=1 by an elementary hand argument over F_2.

## Starting point

The contraction map from the quartic homogeneous part of the seed has a six-dimensional kernel, parametrized by

    u=p37, v=p46, w=p47, x=p56, y=p57, z=p67.

For a decomposable bivector p=a wedge b, four Grassmann--Pluecker relations reduce on this kernel to

    R1: v y + w x + z = 0,

    R2: u v + u w + u y + u z + w + x = 0,

    R3: u + v + v y + v z + w y + w z + x + y + z = 0,

    R4: u x + u z + v + v z + w z + x + x y + x z = 0.

All variables lie in F_2.

## Eliminate z

From R1,

    z = v y + w x.

Substituting this into R2,R3,R4 and using t^2=t over F_2 gives

    E2: u v y + u v + u w x + u w + u y + w + x = 0,

    E3: u + v w x + v w y + v y + v + w y + x + y = 0,

    E4: u v y + u w x + u x + v w x + v w y
        + v x y + v y + v + x y + x = 0.

It remains to consider the four possible pairs (x,y).

## Case 1: x=0, y=0

The equations reduce to

    E2: u v + u w + w = 0,
    E3: u + v = 0,
    E4: v = 0.

Thus v=0, then u=0, then w=0. From R1, z=0.

Hence all six variables vanish.

## Case 2: x=0, y=1

The first two equations reduce to

    E2: u w + u + w = 0,
    E3: u + v w + w + 1 = 0.

For Boolean u,w, the equation

    u w + u + w = 0

has only u=w=0: if either is 1, the left-hand side is 1.

But then E3 becomes

    1=0,

a contradiction.

Therefore this case has no solution.

## Case 3: x=1, y=0

The equations reduce to

    E2: u v + w + 1 = 0,
    E3: u + v w + v + 1 = 0,
    E4: u w + u + v w + v + 1 = 0.

Split only on v.

If v=0, E2 gives w=1 and E3 gives u=1. Then E4 gives

    1+1+1 = 1 != 0,

a contradiction.

If v=1, E2 gives

    w=u+1,

whereas E3 gives

    w=u.

Again a contradiction.

Thus this case has no solution.

## Case 4: x=1, y=1

Already E2 and E3 reduce respectively to

    u+w+1=0,
    u+w=0,

which are incompatible.

Thus this case has no solution.

## Conclusion

The only common F_2-solution of R1,R2,R3,R4 is

    u=v=w=x=y=z=0.

Therefore the six-dimensional kernel of the contraction map contains no nonzero decomposable bivector.

Hence if the quadratic homogeneous part of D_a D_b f vanishes, then

    a wedge b = 0,

so a and b are linearly dependent.

In particular,

    D_a D_b f constant => a,b dependent.

Therefore no two-dimensional relaxed M-subspace exists. Since every nonzero line is an M-subspace,

    r-ind(f)=ind(f)=1.

## Proof-status hierarchy

The seed now has three mutually reinforcing verification levels:

1. Elementary algebraic proof:
   contraction map + six-dimensional kernel + four Pluecker relations + four hand cases.

2. Compact symbolic certificate:
   rank 22 and Boolean/Pluecker verification.

3. Full exhaustive certificate:
   all 32385 independent direction pairs and all 256 inputs per second derivative.

The manuscript should use level 1 as the mathematical proof, with levels 2 and 3 retained in the reproducibility supplement.

## Remaining finite algebra

The only finite linear-algebra datum still used in the hand proof is the row reduction of the 28x28 contraction matrix giving rank 22 and the displayed six-parameter kernel. This is deterministic linear algebra, independently checkable by the compact certificate. If desired, the matrix itself can be printed in an appendix or replaced by 22 explicit pivot equations.

## V1 firewall

V1 remains frozen and untouched.
