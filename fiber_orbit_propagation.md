# Orbit propagation for complementary fibers

Let H=F_2^h, V=H direct-sum H, d(u)=(u,u), and F_z(u)=g(u,u+z). Assume g has degree at most three, is rotation-symmetric, and is constant on the diagonal.

The companion note fiber_covariance_cubic.md proves
B_{F_z}(u,v)=B_{D_{d(z)}g}(d(u),e(v))
and the cyclic covariance
F_{Rz}(Ru+z_{h-1}e_0)=F_z(u).

## Propagation along a cyclic orbit

Rotation commutes with diagonal directions:
sigma d(z)=d(Rz).
Therefore D_{d(Rz)}g is the rotation of D_{d(z)}g. In particular,
B_{D_{d(z)}g}=0
if and only if
B_{D_{d(R^jz)}g}=0
for every j.

Hence zero-polar diagonal derivatives propagate through the entire cyclic orbit of z. By the fiber-polar identity, every corresponding F_{R^jz} is affine.

Write
F_z(u)=a_z dot u+c_z.
Substitution into
F_{Rz}(Ru+z_{h-1}e_0)=F_z(u)
shows that the linear coefficients are cyclic translates of one another (up to the fixed convention for R):
a_{Rz}=R a_z.
The constants satisfy the accompanying affine cocycle relation obtained from the translation z_{h-1}e_0.

Thus one zero-polar diagonal derivative produces a whole covariant orbit of affine fibers, not an isolated affine fiber.

## Interaction with bentness

If g is bent and its diagonal is constant, complementary-fiber Parseval gives that F_z is balanced for every z != 0.

An affine Boolean function a dot u+c is balanced exactly when a != 0. Consequently, for every nonzero z,
B_{D_{d(z)}g}=0
implies
F_z affine and balanced,
hence a_z != 0.

This does not contradict bentness for a general cyclic orbit: a nonzero linear coefficient may simply rotate with z.

The fixed offset z=1 is exceptional. It is the unique nonzero vector fixed by R. For this fiber the cyclic covariance contains the translation e_0 and forces an affine F_1 to have zero linear coefficient. Hence F_1 is constant, contradicting its required balance.

This isolates the exact source of the Antipodal Rule contradiction: it is a fixed-orbit obstruction, not a generic consequence of fiber affinity.

## General orbit closure

If z has cyclic period ell, iterating covariance ell times returns to F_z and yields an affine self-symmetry of that fiber. For affine F_z this imposes a linear constraint on a_z determined by the accumulated boundary translations. Such constraints may yield additional obstructions for special periodic offsets, but they do not force a_z=0 in general.

This suggests the next target: classify, for each binary necklace z, the fixed subspace of admissible affine coefficients a_z under the ell-step fiber monodromy, and compare it with the balance requirement a_z != 0.

No claim that all nontrivial necklaces are obstructed is made here.
