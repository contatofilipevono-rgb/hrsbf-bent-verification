# Quadratic rotation-symmetric rigidity — audit

## Statement under audit

For N=2^k, if a rotation-symmetric Boolean function q of degree at most two is balanced, then its quadratic polar is zero; equivalently q is affine.

## Proof stress test

The proof uses A=GF(2)[X]/((X+1)^N). Because N is a power of two, X^N-1=(X+1)^N, so A is local with unique maximal ideal (X+1). Odd Hamming weight is exactly evaluation 1 at X=1 and therefore exactly the unit condition.

A detail now made explicit in the manuscript: if a rotation-invariant subspace contains a unit u, it contains all X^j u; multiplication by u is invertible, so these vectors span A. Hence a proper invariant radical R lies in (X+1)A=im(S+I). This makes Q vanish on R, and the quadratic character-sum identity forces a nonzero Walsh coefficient at zero, contradicting balance.

## Independent finite check

audit_quadratic_rs_rigidity.py exhausts the full RS degree<=2 coefficient space for N=4,8,16 and verifies that every balanced example has zero quadratic component. The computation is validation only, not a premise.

## Literature positioning

Chirvasitu and Cusick, "Quadratic rotation symmetric Boolean functions" (Discrete Applied Mathematics 343 (2024), 91–105; arXiv:2304.12734), study balancedness of quadratic rotation-symmetric functions and provide broader classification machinery. The present lemma is used as a compact power-of-two consequence tailored to the cubic proof. No priority claim is made here until the precise overlap with their theorem statements is checked from the full text.
