# V2 — Human-verifiable rank-22 certificate for the contraction map

Date: 2026-10-07

## Purpose

This note removes the phrase "row reduction gives rank 22" from the essential proof of r-ind(f)=1.

The quartic homogeneous part Q of the 8-variable seed defines a linear contraction map

    L : wedge^2(F_2^8) -> Quad_sf(F_2^8),

where the input coordinates are p_ij (0<=i<j<=7), and L(p) is the quadratic homogeneous part of D_aD_b Q when p_ij=a_i b_j+a_j b_i.

Expanding the three rotation orbits of Q and collecting the 28 quadratic monomials gives L(p)=0. Elementary elimination yields the following solved system.

## Six free coordinates

Take

    u=p37, v=p46, w=p47, x=p56, y=p57, z=p67.

Then L(p)=0 is equivalent to the following 22 pivot equations:

    p01 = z
    p02 = v
    p03 = w
    p04 = v+w+y+z
    p05 = u+v+x+y
    p06 = u+x
    p07 = x

    p12 = x
    p13 = y
    p14 = u+v+x+y
    p15 = v+x
    p16 = u+v+w+x
    p17 = v+w+y

    p23 = z
    p24 = u+x
    p25 = u+v+w+x
    p26 = y+z
    p27 = u+w+x+y

    p34 = x
    p35 = v+w+y
    p36 = u+w+x+y

    p45 = z.

The remaining six coordinates are exactly

    p37=u, p46=v, p47=w, p56=x, p57=y, p67=z.

## Rank proof without a black-box rank computation

The displayed system has 22 distinct pivot variables on the left and only the six designated free variables on the right.

Therefore every element of ker(L) is uniquely determined by the six-tuple

    (u,v,w,x,y,z) in F_2^6.

Conversely, direct substitution of the displayed expressions into the 28 coefficients of L(p) makes every coefficient vanish. Hence every six-tuple produces an element of ker(L).

Thus

    ker(L) is isomorphic to F_2^6,

so

    dim ker(L)=6.

Since dim wedge^2(F_2^8)=C(8,2)=28, rank-nullity gives

    rank(L)=28-6=22.

This establishes the rank exactly without invoking a software rank output.

## Why cyclic Fourier diagonalization is not used

Rotation symmetry makes L equivariant for the cyclic group C_8. The 28 pair coordinates split naturally by cyclic distance into orbit sizes

    8, 8, 8, 4.

However, over F_2,

    X^8-1 = (X+1)^8.

Thus the C_8 action is not semisimple in characteristic two. A Fourier/eigenvalue diagonalization would obscure rather than simplify the proof and could silently import an invalid characteristic-zero argument.

The explicit pivot certificate above is shorter and characteristic-correct.

## Completion of the seed proof

If D_aD_b f is constant, then L(a wedge b)=0. Hence its Pluecker coordinates have the six-parameter form above.

Four Grassmann--Pluecker relations, for quadruples

    0123, 0347, 0246, 0125,

then reduce to the four equations recorded in V2_HAND_PROOF_SEED_RIND1.md. The elementary four-case argument on (x,y) proves

    u=v=w=x=y=z=0.

Therefore a wedge b=0, so a,b are dependent. Hence

    r-ind(f)=ind(f)=1.

## Fully human-verifiable proof chain

The essential proof now consists of:

1. Expand the three quartic RS orbits.
2. Use the standard contraction formula for a quartic squarefree monomial.
3. Collect coefficients to obtain L(p)=0.
4. Verify the 22 displayed pivot equations by substitution.
5. Conclude dim ker(L)=6 and rank(L)=22.
6. Impose four Pluecker relations.
7. Use the four elementary (x,y) cases.
8. Conclude p=0 and hence a,b dependent.

No enumeration of the 32385 independent direction pairs, no Groebner basis, and no black-box matrix-rank computation is logically required.

The scripts remain as independent reproducibility checks.

## Publication recommendation

In the main text, state the contraction argument and give the six free coordinates plus the conclusion rank(L)=22. Put the 22 pivot equations in an appendix or supplementary certificate. Keep both Python certificates in the repository.

This balances readability with complete verifiability.

## V1 firewall

V1 remains frozen and untouched.
