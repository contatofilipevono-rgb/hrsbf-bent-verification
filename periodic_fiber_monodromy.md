# Classification of periodic-fiber monodromy

## Setup

Let H=F_2^h and let R be the cyclic rotation on H. For a rotation-symmetric Boolean function g on H direct-sum H define

F_z(u)=g(u,u+z).

The cyclic covariance is

F_{Rz}(Ru+z_{h-1}e_0)=F_z(u).

Assume a fiber orbit has become affine through the cubic fiber-polar mechanism, and write

F_z(u)=a_z dot u+c_z.

Then linear coefficients propagate equivariantly around the orbit.

## Periodic offsets

Let z have minimal cyclic period ell, so R^ell z=z and ell divides h. Iterating covariance ell times returns to the same fiber and gives an affine self-symmetry

F_z(R^ell u+t_z)=F_z(u),

where t_z is the accumulated boundary translation during one period.

For affine F_z this gives two conditions:

1. (R^ell)^T a_z=a_z.
2. a_z dot t_z=0.

The first condition says that a_z is constant on each cycle of R^ell. Since ell divides h, R^ell has exactly ell cycles, so its fixed space has dimension ell.

The second condition is one linear constraint on this ell-dimensional fixed space. For a nonzero periodic offset z it is nontrivial in the fixed-fiber case ell=1; more generally its rank is at most one. Thus monodromy alone leaves an admissible coefficient space of dimension at least ell-1.

## Consequence

For ell=1, the only offsets are z=0 and z=1. The nonzero case z=1 gives a zero-dimensional admissible linear-coefficient space, so an affine F_1 must be constant. Bentness, via complementary-fiber Parseval, requires F_1 to be balanced, producing the Antipodal Rule contradiction.

For every ell>1, monodromy by itself cannot universally force a_z=0: the invariant coefficient space has dimension ell before the single translation constraint and therefore retains nonzero possibilities after it. Hence no universal contradiction with balance follows from cyclic fiber monodromy alone.

This identifies the all-ones fiber as not merely the simplest periodic fiber but the unique nonzero period-one fiber and the unique case in which the present monodromy mechanism can annihilate the entire affine linear part without additional information.

## Methodological conclusion

The periodic-fiber program does not yield a stronger universal obstruction by symmetry alone. Any extension beyond the Antipodal Rule must add another ingredient, for example:

- simultaneous constraints from several diagonal derivatives,
- relations among different fiber orbits,
- higher-order derivatives for degree >=4, or
- Walsh constraints stronger than individual fiber balance.

This negative structural result is useful: it prevents spending computation on a route whose symmetry constraints alone are underdetermined for every orbit length ell>1.
