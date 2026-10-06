# Homogeneous cubic rotation-symmetric bent functions in power-of-two dimensions

All vector spaces, Boolean polynomials and derivatives are over \(\mathbb F_2\); character sums are ordinary integers. For a positive integer \(m\), let \(S_m\) denote the right cyclic shift on \(\mathbb F_2^m\),
\[
(S_mx)_i=x_{i-1\pmod m}.
\]
A Boolean function is rotation symmetric if it is invariant under this shift.

## Quadratic lemma

**Lemma.** Let \(n=2^k\). If a rotation-symmetric Boolean function \(q:\mathbb F_2^n\to\mathbb F_2\) has degree at most two and is balanced, then its polar form is zero.

**Proof.** Normalize \(q\) by putting
\[
Q(x)=q(x)+q(0),\qquad
B(x,y)=Q(x+y)+Q(x)+Q(y),
\]
and let \(K=\operatorname{rad}B\). The form \(B\) is alternating and invariant under \(S_n\), so \(K\) is an \(S_n\)-invariant subspace. Suppose that \(B\ne0\). Then \(K\) is proper.

Identify \(\mathbb F_2^n\) with the cyclic module
\[
\mathcal R_n=\mathbb F_2[X]/(X^n+1)
              =\mathbb F_2[X]/((X+1)^n),
\]
where \(S_n\) acts as multiplication by \(X\). If \(r\in K\) had odd Hamming weight, then \(r(1)=1\), so \(r\) would be a unit of the local ring \(\mathcal R_n\). The cyclic shifts of \(r\) would span the whole module, contradicting that \(K\) is proper. Hence every vector in \(K\) has even weight.

The even-weight subspace is exactly \(\operatorname{im}(S_n+I)\): the image is contained in it and has dimension \(n-1\), because \(\ker(S_n+I)\) is the one-dimensional space of constant vectors. Thus, for every \(r\in K\), choose \(y\) with \(r=S_ny+y\). Rotation invariance, alternation and \(r\in K\) give
\[
Q(r)=Q(S_ny)+Q(y)+B(S_ny,y)
    =B(r+y,y)=0.
\]

Let \(A(q)=\sum_x(-1)^{q(x)}\). Changing variables in its square yields
\[
\begin{aligned}
A(q)^2
 &=\sum_r(-1)^{Q(r)}\sum_x(-1)^{B(x,r)}\\
 &=2^n\sum_{r\in K}(-1)^{Q(r)}
 =2^n|K|>0.
\end{aligned}
\]
Therefore \(q\) is not balanced whenever \(B\ne0\). The contrapositive proves the lemma. Notice that affine terms are retained: the conclusion is that the polar vanishes, not that \(q\) is zero or constant. \(\square\)

## Main theorem

**Theorem.** Let \(n=2^k\) with \(k\ge2\). No homogeneous cubic rotation-symmetric Boolean function \(f:\mathbb F_2^n\to\mathbb F_2\) is bent.

**Proof.** Write \(n=2h\). For \(u,z\in\mathbb F_2^h\), define
\[
d(u)=(u,u),\qquad e(z)=(0,z),\qquad
F_z(u)=f(d(u)+e(z))=f(u,u+z).
\]

### 1. The diagonal fiber

The half-turn \(S_n^h\) acts without fixed points on the coordinates. It therefore cannot fix a three-element support: a fixed finite set under an involution without fixed coordinates has even cardinality. Because \(f\) is invariant, its cubic monomials occur in half-turn pairs. The two members of each pair agree after the substitution \(x=d(u)\), and hence cancel in characteristic two. Consequently,
\[
f(d(u))=0\quad\text{for every }u,
\qquad F_0=0.
\]
Moreover,
\[
F_z(u)=D_{e(z)}f(d(u)),
\]
so every fiber \(F_z\) has degree at most two.

### 2. Parseval forces every nonzero fiber to be balanced

Put
\[
A_z=\sum_{u\in\mathbb F_2^h}(-1)^{F_z(u)}.
\]
The map \((u,z)\mapsto(u,u+z)\) is invertible. Thus
\(\widetilde f(u,z)=F_z(u)\) is bent whenever \(f\) is bent. For every \(b\in\mathbb F_2^h\),
\[
\widehat A(b)=\sum_z(-1)^{b\cdot z}A_z
              =W_{\widetilde f}(0,b),
\]
and bentness gives \(|\widehat A(b)|=2^h\). Parseval on \(\mathbb F_2^h\) therefore gives
\[
\sum_zA_z^2
=2^{-h}\sum_b\widehat A(b)^2
=2^{-h}\,2^h\,2^{2h}=2^{2h}.
\]
Since \(F_0=0\), already \(A_0^2=(2^h)^2=2^{2h}\). Hence
\[
A_z=0\quad\text{for every }z\ne0.
\]
In particular, \(F_{\mathbf1_h}\) is balanced.

### 3. The complementary fiber is affine

Let \(a=d(\mathbf1_h)=\mathbf1_n\). If \(f\) were bent, the nonzero derivative \(D_af\) would be balanced. It is rotation symmetric and has degree at most two. The quadratic lemma implies
\[
B_{D_af}=0.
\]

Let
\[
T(p,q,r)=D_pD_qD_rf(0).
\]
Because \(f\) is homogeneous cubic, \(T\) is a symmetric trilinear form. It is invariant under the simultaneous action of \(S_n\), and therefore under the half-turn.

The polar of the complementary fiber is
\[
B_{F_{\mathbf1_h}}(u,v)
=T(d(u),d(v),e(\mathbf1_h)).
\]
Indeed, the possible base-point term is the second derivative of the identically zero diagonal restriction.

On the other hand, trilinearity and half-turn invariance give
\[
\begin{aligned}
B_{D_af}(d(u),e(v))
 &=T(d(u),e(v),d(\mathbf1_h))\\
 &=T(d(u),e(v),(\mathbf1_h,0))
   +T(d(u),e(v),(0,\mathbf1_h))\\
 &=T(d(u),(v,0),(0,\mathbf1_h))
   +T(d(u),(0,v),(0,\mathbf1_h))\\
 &=T(d(u),d(v),e(\mathbf1_h))\\
 &=B_{F_{\mathbf1_h}}(u,v).
\end{aligned}
\]
Thus \(B_{F_{\mathbf1_h}}=0\). Since this fiber has degree at most two, it is affine:
\[
F_{\mathbf1_h}(u)=L(u)+c
\]
for a linear form \(L\).

### 4. One-step rotation makes the affine fiber constant

With the stated right-shift convention,
\[
S_n(u,u+\mathbf1_h)
=\bigl(S_hu+e_0,\;S_hu+e_0+\mathbf1_h\bigr).
\]
Rotation symmetry of \(f\) gives
\[
F_{\mathbf1_h}(S_hu+e_0)=F_{\mathbf1_h}(u).
\]
Substituting the affine expression and first taking \(u=0\) yields \(L(e_0)=0\); the remaining linear parts give \(L(S_hu)=L(u)\). Every shift-invariant linear form on \(\mathbb F_2^h\) has the form
\[
L(u)=\beta\sum_{i=0}^{h-1}u_i.
\]
But \(L(e_0)=\beta=0\). Therefore \(F_{\mathbf1_h}\) is constant, and
\[
A_{\mathbf1_h}=\pm2^h\ne0,
\]
contradicting the balance forced by Parseval. \(\square\)

## Scope, antecedents and reproducibility

The theorem concerns homogeneous degree-three functions with full one-step rotation symmetry in dimensions that are powers of two. It does not cover arbitrary even dimensions, nonhomogeneous cubics or degrees at least four.

The cyclic-module structure and balancing of quadratic rotation-symmetric functions have substantial antecedents; see A. Chirvasitu and T. W. Cusick, *Affine equivalence for quadratic rotation symmetric Boolean functions*, Designs, Codes and Cryptography 88 (2020), 1301–1329, and *Quadratic rotation symmetric Boolean functions* (2023/2024). The lemma above is included with a self-contained proof and should not be presented as wholly novel without a more precise priority analysis. The fiber-polarization argument should likewise be subjected to a specialist literature review before any originality claim.

`audit_power_of_two_theorem.py` checks, independently at the ANF-generator level, the diagonal cancellation, degree drop, polar-transfer identity and twisted fiber invariance for \(n=4,8,16,32,64\). It exhausts the full homogeneous cubic rotation-symmetric spaces at \(n=4,8\), exhausts the quadratic lemma through \(n=16\), and performs deterministic controls at \(n=32,64\). These calculations support the algebraic proof; they are not proof-assistant formalization.

