# V3: dimension-free symplectic property (A) — mathematical proof

Status: **paper-level proof, NOT yet a Lean theorem for arbitrary m**.
The existing green Lean CI certifies only m=2 (four input bits).
This note does not modify V1 or V2.

Let K=F_2, m>=2, V=K^{2m}, and let omega be the standard
nondegenerate alternating symplectic form. Write x=(u_1,v_1,...,u_m,v_m),
q_i(x)=u_i v_i, and f_m(x)=sum_{i<j} q_i(x)q_j(x).

## Fourth polarization

For all a,b,c,d,x in V, the fourth finite difference is independent of x
and equals the Pfaffian-type 4-form

  P(a,b,c,d) =
    omega(a,b)omega(c,d)
  + omega(a,c)omega(b,d)
  + omega(a,d)omega(b,c).

Proof outline: polarization of each q_i is the alternating 2-form omega_i
supported on the i-th coordinate pair. Fourth polarization of q_i q_j is
the six cross-pair terms. Summing i<j gives the three products of the
global omega, because the same-pair contributions cancel in F_2
(the three pairings of four arguments have even total contribution
on any two-dimensional symplectic plane). This identity has been
finite-checked for m=2 in Lean; the dimension-free identity requires
its own formal proof.

## Theorem: property (A) in every even dimension >=4

For all a,b in V,

  (forall c,d in V, P(a,b,c,d)=0)
    iff a,b are linearly dependent.

Proof. If a,b are dependent, alternation gives P(a,b,c,d)=0.

Conversely, suppose a,b are independent.

Case I: omega(a,b)=0. Since omega is nondegenerate, the two
linear functionals omega(a,-), omega(b,-) are independent. Choose
c,d with

  omega(a,c)=1, omega(b,c)=0,
  omega(a,d)=0, omega(b,d)=1.

Then P(a,b,c,d)=1.

Case II: omega(a,b)=1. The span W=<a,b> is a nondegenerate
symplectic plane. Its symplectic orthogonal W^perp is nondegenerate
of dimension 2m-2>=2. Choose c,d in W^perp with omega(c,d)=1.
Then all cross terms vanish and P(a,b,c,d)=1.

Thus P(a,b,-,-) cannot vanish for independent a,b. QED.

Over F_2, dependence is equivalent to a=0 or b=0 or a=b.

## Boundaries and publication cautions

1. This proves a property of the fourth-derivative tensor, assuming
   the displayed polarization identity. It does NOT by itself prove
   R2(F_G)=r or EA classification for the dimension-general graph maps.
2. The 4-form is a standard-looking symplectic/Pfaffian expression.
   Novelty is not claimed for the identity or this elementary argument.
3. A next Lean milestone is a symbolic proof of polarization for
   arbitrary m and a noncomputational Lean proof of the two cases.
4. The graph classification and indecomposability arguments require
   a separate dependency audit before generalization from the 8-bit seed.
