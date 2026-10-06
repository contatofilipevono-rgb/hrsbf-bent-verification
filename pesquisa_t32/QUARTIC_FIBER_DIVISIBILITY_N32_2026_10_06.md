# Quartic n=32: complementary-fiber divisibility certificate

Status: exact finite certificate; this note does **not** by itself prove nonexistence of quartic HRSBF bent functions.

Let f be a homogeneous quartic rotation-symmetric Boolean function on 32 variables and define

F_1(u) = f(u, u + 1^16),  u in F_2^16.

## Exact structural facts

1. There are 1128 quartic cyclic monomial orbits in 32 variables.
2. Substitution x=(u,u+1^16) cancels degree 4, so every F_1 has degree at most 3.
3. The image of the 1128-dimensional coefficient space under f -> F_1 has rank 36.
4. Every generator image is invariant under the affine map
   tau(u_0,...,u_15)=(u_15+1,u_0,...,u_14).
5. tau acts freely on F_2^16: 2048 orbits, each of length 32.

Hence supports and all intersections of supports of F_1 codewords are unions of tau-orbits.

## 512-divisibility certificate

Choose any independently constructed basis c_1,...,c_36 of the 36-dimensional binary linear code C of F_1 truth tables.

A standard binary-code divisibility criterion reduces 2^9-divisibility of C to intersection weights. Because every intersection is automatically a multiple of 32, only intersection orders j=1,2,3,4 require explicit checks:

- j=1: 36 checks; every nonzero intersection weight has v2 >= 9.
- j=2: 630 checks; every nonzero intersection weight has v2 >= 8.
- j=3: 7140 checks; every nonzero intersection weight has v2 >= 7.
- j=4: 58905 checks; every nonzero intersection weight has v2 >= 6.

Total: 66,711 exact checks; no violation.

Therefore every F_1 in the image satisfies

wt(F_1) == 0 (mod 512).

Since A_1 = sum_u (-1)^{F_1(u)} = 2^16 - 2 wt(F_1),

A_1 == 0 (mod 1024).

## Important limitation

This is a necessary arithmetic restriction on one fiber, not yet a contradiction with bentness. The next target is to combine this with the diagonal quadratic fiber A_0 and additional periodic fibers through the z-Fourier/Parseval identities for a bent function.

## Reproducibility warning

The certificate should be independently regenerated from cyclic quartic supports, not trusted from a stored 36-dimensional basis. The implementation must deduplicate short cyclic orbits before substitution.
