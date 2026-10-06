# Odd-order fixed-space reduction — independent audit

Target lemma: for an odd-order linear automorphism T and a T-invariant Boolean function q of degree at most two, q is balanced on V iff q restricted to Fix(T) is balanced.

## Algebraic reconstruction

Let P=sum_{j=0}^{m-1} T^j. Since m is odd, P is an idempotent projection onto U=Fix(T), so V=U direct-sum K with K=ker(P). T-invariance of the polar form B makes U and K B-orthogonal. Hence the quadratic character sum factors as S_V=S_U S_K.

For the radical R of B restricted to K, T preserves R. For z in R, all T^j z lie in R, so all cross-polar terms among them vanish. Invariance of q and oddness of m imply q(Pz)=m q(z)=q(z). But Pz=0 on K, so q(z)=0. Therefore q vanishes on R and the standard character-sum identity gives S_K^2=|K||R|>0. Thus S_K cannot alter whether the total sum vanishes.

## Exhaustive independent check

audit_odd_order_reduction.py enumerates, for dimensions 1,2,3:
- every invertible binary linear map;
- every map of odd order;
- every degree <=2 Boolean function normalized by q(0)=0;
- every invariant q;
and checks the balance equivalence directly.

This finite computation is supplementary. The manuscript's proof is general and does not depend on it.
