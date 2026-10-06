# Independent short-cubic-orbit folding audit

This audit targets only the short-orbit step in the global cubic proof.

## Claim

For n=t*m with t a power of two and m odd, a cubic monomial orbit with nontrivial rotational stabilizer has stabilizer 3. Its support is necessarily {a,a+n/3,a+2n/3}. Since 3 divides m, all three positions coincide modulo t under fixed-space folding. The complete short orbit therefore restricts exactly to the total linear form L, never to a quadratic orbit.

## Independent executable check

`audit_short_cubic_folding.py` enumerates cubic supports and rotation orbits from scratch and checks this claim for several dimensions. It imports no existing project validator. The computation is supplementary: the manuscript now contains a direct general proof, so the theorem does not depend on these finite tests.

## Referee significance

This isolates a previously compressed sentence in the main proof. In particular, short cubic orbits cannot be a hidden source of the antipodal quadratic orbit after folding.
