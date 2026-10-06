# Fiber covariance for cubic half-swap symmetric Boolean functions

## General setup

Let H = F_2^h and V = H direct-sum H. Write

- d(u) = (u,u),
- e(z) = (0,z),
- e'(z) = (z,0),
- tau(x,y) = (y,x).

Let g: V -> F_2 have algebraic degree at most 3, satisfy g o tau = g, and be constant on the diagonal d(H). After adding a constant, normalize g(d(u)) = 0.

For z in H define the fiber function

F_z(u) = g(u,u+z) = g(d(u)+e(z)).

## The fiber-polar identity

For every u,v,z in H,

B_{F_z}(u,v)
=
B_{D_{d(z)}g}(d(u),e(v)).

Indeed, since the third difference Delta_3 of a degree-at-most-three Boolean function is a symmetric trilinear form,

B_{F_z}(u,v)
=
Delta_3(d(u),d(v),e(z)),

because the second difference at the diagonal base point vanishes. On the other hand,

B_{D_{d(z)}g}(d(u),e(v))
=
Delta_3(d(u),e(v),d(z)).

Using d(z)=e(z)+e'(z), half-swap invariance of Delta_3, and d(v)=e(v)+e'(v), the latter becomes exactly

Delta_3(d(u),d(v),e(z)).

Thus the two polar forms agree on the indicated arguments.

### Corollary: fiber affinity

If B_{D_{d(z)}g}=0, then B_{F_z}=0 and therefore F_z is affine.

This statement requires neither bentness nor rotation symmetry nor power-of-two dimension. It uses only degree <= 3, half-swap symmetry, and constancy on the diagonal.

## Cyclic covariance of the fibers

Now suppose N=2h and g is fully rotation-symmetric. Let R be cyclic rotation on H, with the convention compatible with the N-coordinate rotation used in the manuscript. A direct coordinate calculation gives

F_{Rz}(Ru + z_{h-1} e_0) = F_z(u).

Thus cyclic rotation generally moves one complementary fiber to another.

The fibers fixed by this action on the offset are exactly those with Rz=z. Since R is a single h-cycle, these are z=0 and z=1.

Consequently the all-ones complementary fiber is structurally distinguished: it is the unique nonzero offset fiber preserved by cyclic rotation. For z=1, if F_1 is affine, the covariance becomes

F_1(Ru+e_0)=F_1(u),

which forces its linear part to vanish. Hence F_1 is constant.

## Consequence for the cubic proof

The local complementary-fiber rigidity mechanism decomposes into two independent statements:

1. Half-swap cubic identity:
   zero polar of D_(z,z) g implies F_z affine, for every z.

2. Cyclic fixed-fiber rigidity:
   among nonzero offsets, z=1 is the unique rotation-fixed fiber, and cyclic covariance forces an affine F_1 to be constant.

This shows that the all-ones direction J=(1,1) and the complementary fiber are canonical consequences of cyclic symmetry, rather than an ad hoc choice.

## Novelty caution

This note records an internal structural derivation. No independent novelty claim is made without a dedicated literature audit.
