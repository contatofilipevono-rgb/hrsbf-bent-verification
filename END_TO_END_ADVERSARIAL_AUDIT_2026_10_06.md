# End-to-end adversarial audit — global cubic theorem

## Audited object

- Repository: contatofilipevono-rgb/hrsbf-bent-verification
- Required branch: colab-a100-2026-10-06
- Manuscript: paper_cubic_global_submission.tex
- Exact audited commit: 1f680da83a62b33796c777842c78cae369d9d469
- Audit mode: proof reconstruction; existing certificates/scripts were not treated as sources of truth.

## Verdict

**PASS WITH CAVEATS — no fatal mathematical gap found in the end-to-end implication.**

This is an internal adversarial audit, not peer review and not a priority determination.

## Chain audited

### A. Odd-order fixed-space reduction — PASS

For T of odd order, P=sum T^j is an idempotent projection onto U=Fix(T), giving V=U direct-sum ker(P). T-invariance makes the polar orthogonal across this decomposition. On the radical R of the polar restricted to K=ker(P), invariance and oddness force q|R=0. Therefore the K-character sum has square |K||R|>0. Balance on V is equivalent to balance on U.

Boundary m=1 is harmless: T=I, U=V, K=0.

### B. Restriction preserves bentness for degree <=3 — PASS

For every nonzero a in U, D_a f is degree <=2 and balanced by bentness. Since Ta=a and f is T-invariant, D_a f is T-invariant. The quadratic reduction lemma transfers balance to U. The derivative characterization then makes f|U bent.

### C. Short cubic orbit folding — PASS

A nontrivial stabilizer of a 3-element support has order 3. The support is {a,a+n/3,a+2n/3}. Since t is a power of two, 3|m, and all support indices coincide modulo t. The entire short orbit reduces exactly to L(y), not to a quadratic term.

### D. Full cubic orbit folding and antipodal exclusion — PASS

A full n-orbit reduces to m copies of the t cyclic translates, and m is odd. The reduced monomial can have degree 1,2,3. Proper reduced orbit lengths occur with multiplicity t/l; for power-of-two t this is even. The unique short quadratic orbit is antipodal, of length t/2, so it cancels. Thus folding a homogeneous cubic cannot create P_t.

For m=1 no degree collision occurs; the statement remains valid.

### E. Quadratic RS rigidity at N=2^k — PASS

In A=GF(2)[X]/((X+1)^N), a proper rotation-invariant radical contains no unit. The manuscript now explicitly justifies that if it contained a unit u, the vectors u,Xu,...,X^{N-1}u would span A because multiplication by u is invertible. Hence the radical lies in im(S+I). Rotation invariance then makes the normalized quadratic vanish on the radical, forcing a nonzero zero-frequency character sum if the polar is nonzero. A balanced quadratic RS function must therefore have zero polar and be affine.

### F. Complementary-fiber balance — PASS

With G(u,z)=g(u,u+z), the fiber sums A_z have Walsh transform W_G(0,b). Since G is bent on 2h variables, every such coefficient has magnitude 2^h. Parseval gives sum_z A_z^2=2^{2h}. If the diagonal fiber is constant, |A_0|=2^h, so A_0^2 exhausts the entire sum and every z!=0 fiber is balanced.

Normalization and powers of two were checked explicitly.

### G. Complementary-fiber rigidity — PASS

Bentness makes D_J g balanced; J is rotation-fixed, so D_J g is RS and degree <=2. Quadratic rigidity gives zero polar. The third-difference identities correctly use second differences, so no hidden constant term is omitted. Half-rotation converts the relevant third difference into the polar of the complementary fiber. The fiber is affine.

Rotation sends (u,u+1) to (Ru+e0,Ru+e0+1). Invariance of an affine fiber forces R^T a=a and a.e0=0. Since R is one cycle, a is constant and the second condition forces a=0. Thus the complementary fiber is constant.

### H. Antipodal Rule — PASS

On the diagonal (u,u), linear orbit sums cancel; non-antipodal quadratic full orbits cancel under half-rotation; cubic orbits are full at power-of-two dimension and cancel under the same pairing. P_N alone restricts to parity. If its coefficient were zero, the diagonal would be constant. Complementary-fiber balance would make F_1 balanced while complementary-fiber rigidity would make it constant: contradiction.

The N=4 endpoint is covered.

### I. Main contradiction and N=2 boundary — PASS

For s>=2, fixed-space reduction gives a bent RS function in t=2^s variables; homogeneous cubic folding forbids P_t while the Antipodal Rule requires it.

For s=1, t=2. Cubic reduced terms cannot survive as cubic terms; the only quadratic orbit is antipodal and cancels, while short cubic orbits yield only L. Hence the restriction is affine and cannot be bent on two variables.

## Caveats before submission

1. This audit establishes internal consistency of the current proof, not novelty or priority.
2. The exact overlap of the power-of-two quadratic rigidity corollary with Chirvasitu–Cusick should be checked from the full paper before assigning novelty to that lemma.
3. The global novelty statement should remain literature-qualified until a broader search or expert review is complete.
4. Existing computational audits are valuable falsification controls but are not premises of the theorem.
5. A final LaTeX compile/bibliography audit and notation pass should precede submission.

## Bottom line

No fatal gap was found in the complete proof at the audited SHA. The central contradiction is logically closed provided the stated lemmas are read with the definitions and normalizations given in the manuscript.
