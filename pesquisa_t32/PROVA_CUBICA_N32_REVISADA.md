# Reviewed proof: no homogeneous cubic rotation-symmetric bent function in 32 variables

All additions in vector spaces and Boolean polynomials are over F₂. Character sums are over the integers. Let S be the cyclic shift of 32 coordinates, let R be the cyclic shift of 16 coordinates, and let 1 denote the all-ones vector of the dimension indicated by its argument.

## Lemma

If q:F₂³²→F₂ has degree at most two and q(Sx)=q(x), then balancedness of q implies that its polar is zero.

**Proof.** Define Q(x)=q(x)+q(0), B(x,y)=Q(x+y)+Q(x)+Q(y), and K=rad(B). The form B is alternating and S-invariant; consequently K is S-invariant. Suppose B≠0, so K is a proper subspace.

Identify F₂³² with F₂[X]/(X³²+1), where S acts by multiplication by X. Here X³²+1=(X+1)³². If a vector r has odd weight, its representative polynomial satisfies r(1)=1 and is a unit in this quotient. Multiples of r, hence linear combinations of its cyclic shifts, span the entire module. Thus a proper S-invariant subspace cannot contain an odd-weight vector. It follows that K is contained in the even-weight subspace. This subspace equals im(S+I): the image has dimension 31, since ker(S+I) is the one-dimensional space of constant vectors, and its vectors all have even weight.

For r∈K, choose y with r=Sy+y. Invariance of Q and alternation of B give

$$Q(r)=Q(Sy)+Q(y)+B(Sy,y)=B(r+y,y)=0.$$

Writing A=Σ_x(-1)^{q(x)} and changing variables in its square,

$$A^2=\sum_r(-1)^{Q(r)}\sum_x(-1)^{B(x,r)}
=2^{32}\sum_{r\in K}(-1)^{Q(r)}=2^{32}|K|>0.$$

Thus q is not balanced. The contrapositive proves the lemma. This proof includes all affine terms of q; it does not identify “polar zero” with “function zero.”

## Theorem

No homogeneous cubic rotation-symmetric Boolean function f:F₂³²→F₂ is bent.

**Proof.** Assume otherwise. Set d(u)=(u,u), e(z)=(0,z), and F_z(u)=f(d(u)+e(z)), for u,z∈F₂¹⁶.

The half-turn S¹⁶ pairs each cubic monomial with a distinct monomial. Distinctness follows because a support of odd cardinality cannot be fixed by a fixed-point-free involution. Their evaluations agree on the diagonal, so f(d(u))=0. In particular F_0=0. Moreover,

$$F_z(u)=D_{e(z)}f(d(u)),$$

and therefore deg(F_z)≤2.

Define A_z=Σ_u(-1)^{F_z(u)}. The map (u,z)↦d(u)+e(z) is an invertible linear map, so the transformed function is bent. For every b∈F₂¹⁶,

$$\widehat A(b)=\sum_z(-1)^{b\cdot z}A_z=W_{\widetilde f}(0,b),
\qquad |\widehat A(b)|=2^{16}.$$

Parseval consequently gives

$$\sum_z A_z^2=2^{-16}\sum_b\widehat A(b)^2
=2^{-16}\cdot2^{16}\cdot2^{32}=2^{32}.$$

Since F_0=0, already A_0²=2³². Hence A_z=0 for every z≠0. In particular F_1 must be balanced.

Put a=d(1). The derivative D_af is rotation-invariant and has degree at most two. A nonzero directional derivative of a bent function is balanced: its autocorrelation is zero, as follows from the constant squared Walsh spectrum and Fourier inversion. The lemma implies B_{D_af}=0.

Let T(p,q,r)=D_pD_qD_rf(0). For a cubic Boolean polynomial, T is a symmetric trilinear form; this follows by expanding each square-free cubic monomial into its six polarization terms. It is invariant under S¹⁶. The polar of F_1 satisfies

$$B_{F_1}(u,v)=D_{d(u)}D_{d(v)}f(e(1))
=T(d(u),d(v),e(1)),$$

because D_{d(u)}D_{d(v)}f(0)=0 by the identically zero diagonal restriction. Half-turn invariance gives

$$\begin{aligned}
B_{D_af}(d(u),e(v))
&=T(d(u),e(v),d(1))\\
&=T(d(u),e(v),(1,0))+T(d(u),e(v),(0,1))\\
&=T(d(u),(v,0),(0,1))+T(d(u),(0,v),(0,1))\\
&=T(d(u),d(v),e(1))=B_{F_1}(u,v).
\end{aligned}$$

It follows that B_{F_1}=0. Since deg(F_1)≤2, write F_1(u)=L(u)+c with L linear.

Shifting the vector (u,u+1) cyclically once gives (Ru+e₀,Ru+e₀+1). Rotation invariance of f thus yields

$$F_1(Ru+e_0)=F_1(u).$$

Comparing linear parts shows L(Ru)=L(u); hence L(u)=βΣ_i u_i. Comparing the constants gives L(e₀)=β=0. Therefore F_1 is constant and A_1=±2¹⁶, contradicting A_1=0. This proves the theorem.

## Status and verification

The proof requires homogeneous degree three, full one-step rotation symmetry and the power-of-two dimension used in the lemma. It does not prove the conjecture in all dimensions or degrees. Its bibliographic originality is not certified here.

The n=32 finite certificate verifies, over the entire 155-dimensional cubic coefficient space, that all 136 nonconstant coefficients of F_1 lie in the span of the necessary derivative-polar equations. The separate evaluator verifies the zero diagonal and disappearance of all cubic fiber coefficients directly from ANF evaluations. See `certificado_universal_n32.json`, `verify_universal_n32.py` and `revisao_adversarial_n32.json`.
