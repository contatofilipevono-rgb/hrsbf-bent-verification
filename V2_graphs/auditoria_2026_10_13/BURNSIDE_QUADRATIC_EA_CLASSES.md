# V2 — Exact Burnside enumeration of quadratic EA classes

**Research addendum, 2026-10-13.** This is a mathematical consequence of the local-symmetry-certified *ultra-rigidity* theorem in the companion audit file. It is not presented as a Lean-certified result or as bibliographically novel before priority review.

## Theorem A: fixed graph

For a loopless digraph \(G\) on \(r\ge2\) vertices without isolates, set \(V=(\mathbf F_2^8)^r\), \(W=\mathbf F_2^r\), \(D=r\binom{8r}{2}=4r^2(8r-1)\). Assuming the audited EA classification, equivalence classes of \(F_G+Q\) for \(\deg Q\le2\) are orbits of \(\operatorname{Aut}(G)\) on \(\mathcal Q=W\otimes\Lambda^2(V^*)\). Thus
\[
N_{\mathrm{EA}}(G)=|\operatorname{Aut}(G)|^{-1}
\sum_{\pi\in\operatorname{Aut}(G)} 2^{c_2(\pi)},
\]
where \(c_2(\pi)\) is the number of cycles of the permutation induced by \(\pi\) on
\(\Omega=[r]\times\binom{[r]\times[8]}2\).

The action on coefficient labels is a *permutation action*, since an allowed input equivalence permutes 8-variable vertex blocks without changing internal coordinates. If \(d=\operatorname{ord}(\pi)\), let \(f_k\) and \(t_k\) be the number of fixed points and 2-cycles of \(\pi^k\) on the vertices. The induced action on the \(8r\) input coordinates has \(8f_k\) fixed points and \(8t_k\) 2-cycles; hence it fixes \(\binom{8f_k}{2}+8t_k\) unordered pairs of distinct input coordinates. The output factor has \(f_k\) fixed vertices. Burnside on the cyclic subgroup \(\langle\pi\rangle\) gives the explicit expression
\[
\boxed{c_2(\pi)=\frac1d\sum_{k=0}^{d-1}f_k\left[\binom{8f_k}{2}+8t_k\right].}
\]
A binary coefficient vector fixed by this permutation is constant on each coefficient-label cycle and so has exactly \(2^{c_2(\pi)}\) possibilities. Burnside on \(\operatorname{Aut}(G)\) proves the theorem.

## Theorem B: all weakly connected loopless digraphs

Let \(d_r\) be the number of labeled weakly connected loopless digraphs and \(C_r(\pi)\) the number of these graphs fixed by a vertex permutation \(\pi\in S_r\). Then the exact number of EA classes across **all** \(F_G+Q\), where \(G\) is weakly connected, is
\[
\boxed{\mathcal N_r=\frac1{r!}\sum_{\pi\in S_r} C_r(\pi)\,2^{c_2(\pi)}.}
\]
Proof: apply Burnside to pairs \((G,[Q]_2)\) with the diagonal \(S_r\)-action; the graph and quadratic choices are independent under a given permutation. Rigidity ensures that no additional EA identifications exist.

For an algorithm avoiding enumeration of digraphs: let \(\Pi_r^\pi\) be the poset of set partitions invariant **as partitions** under \(\pi\). For an invariant partition \(P\), let \(A_P=\{(i,j):i\ne j,\ i,j\text{ in the same part of }P\}\), and let \(a_\pi(P)\) be the number of orbits of \(\langle\pi\rangle\) on \(A_P\). Write \(H_\pi(P)=2^{a_\pi(P)}\). This counts fixed digraphs whose connected-component partition refines \(P\). The exact counts \(E_\pi(P)\) of fixed digraphs having component partition *equal* to \(P\) are therefore obtained by the triangular recurrence
\[
E_\pi(P)=H_\pi(P)-\sum_{\substack{R\in\Pi_r^\pi\\R<P}}E_\pi(R),\qquad C_r(\pi)=E_\pi(\hat1).
\]
This is a valid Möbius inversion on the **invariant-partition poset**; one must not substitute the ordinary partition-lattice Möbius coefficients.

## Checks and exact examples

For \(r=2\): the identity fixes 3 connected digraphs and has \(c_2=240\); the transposition fixes 1 and has \(c_2=120\). Therefore
\[
\mathcal N_2=(3\cdot2^{240}+2^{120})/2.
\]

For \(r=3\): the three conjugacy types \((1^3),(2,1),(3)\) have, respectively, \(C_r=(54,6,3)\), \(c_2=(828,432,276)\), and multiplicities \((1,3,2)\). Thus
\[
\boxed{\mathcal N_3=9\cdot2^{828}+3\cdot2^{432}+2^{276}.}
\]

Independent standard-Python code reproduced the connected labeled digraph counts \(d_r\) for \(r=2,\ldots,6\), and computed the following number of binary digits in \(\mathcal N_r\):

| \(r\) | \(d_r\) | Bit length of \(\mathcal N_r\) | Decimal digits |
|---|---:|---:|---:|
|2|3|241|73|
|3|54|832|251|
|4|3834|1992|600|
|5|1027080|3914|1178|
|6|1067308488|6789|2044|

These results are conditional on the EA classification theorem and do not independently establish originality against prior enumerative literature.

## Research importance

The earlier V2 bound counts graph-indexed canonical representatives. The formulas here count every quadratic perturbation, and—in the fixed-graph case—reduce an exponentially large search to the cycle structure of \(\operatorname{Aut}(G)\). These are exact class counts, not lower bounds. Preserve the original manuscript unchanged until a mathematical and bibliographic delta review has been completed.


## Theorem C: strong asymptotics and generic loss of all EA symmetries

Let \(M=\binom{8r}{2}\), \(D=rM\), and let \(G\) be a loopless digraph with no isolated vertices. For any nonidentity \(\pi\in S_r\), at least two output vertices are moved by \(\pi\), so at least \(2M\) labels in \(\Omega=[r]\times\binom{[r]\times[8]}2\) lie in nontrivial cycles. A permutation of \(D\) labels with \(L\) moved labels has at most \(D-L/2\) cycles: every nontrivial cycle of length \(\ell\ge2\) loses \(\ell-1\ge\ell/2\) cycles compared with the identity. Therefore
\[
\boxed{c_2(\pi)\le D-M\quad\text{for every }\pi\ne\mathrm{id}.}
\]

For a uniformly chosen homogeneous quadratic perturbation \(Q\), the probability that a given nonidentity graph automorphism \(\pi\) preserves \(Q\) is exactly \(2^{c_2(\pi)-D}\le2^{-M}\). By the union bound,
\[
\boxed{\Pr[\mathrm{Stab}_{\operatorname{Aut}(G)}([Q]_2)\ne1]
\le (|\operatorname{Aut}(G)|-1)\,2^{-\binom{8r}{2}}.}
\]
Thus a uniformly random quadratic perturbation has **trivial EA stabilizer modulo affine output changes** with overwhelming probability, even when \(G\) has nontrivial graph automorphisms.

For the total EA-class count across all weakly connected digraphs, the identity contribution to Burnside is \(d_r\,2^D/r!\). Since \(C_r(\pi)\le d_r\), the preceding bound yields the explicit nonasymptotic inequalities
\[
\boxed{
\frac{d_r\,2^D}{r!}
\le\mathcal N_r
\le \frac{d_r\,2^D}{r!}
\left(1+(r!-1)\,2^{-\binom{8r}{2}}\right).
}
\]
Using the elementary fact that almost all four-state loopless digraphs are weakly connected, \(d_r\sim4^{\binom r2}\), we obtain
\[
\boxed{\mathcal N_r\sim
\frac{4^{\binom r2}\,2^{4r^2(8r-1)}}{r!}\quad(r\to\infty).}
\]

This asymptotic is drastically stronger than merely a lower bound on canonical graph classes: it incorporates *all* degree-at-most-two vectorial perturbations and shows that corrections from permutation stabilizers decay at least as \(r!\,2^{-\binom{8r}{2}}\). As above, its EA interpretation is conditional on the companion ultra-rigidity theorem, and novelty claims require a prior-art check.
