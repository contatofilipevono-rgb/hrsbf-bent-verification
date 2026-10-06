# Antipodal Rule — independent falsification audit

## Target

For N=2^k, k>=2, every rotation-symmetric bent Boolean function of degree <=3 contains the antipodal quadratic orbit P_N.

## Independence

The script `audit_antipodal_rule.py` does not use the manuscript's proof, derivative lemmas, folding code, certificates, or earlier validators. It constructs cyclic monomial orbits directly.

For N=4 and N=8 it:
1. constructs the complete RS ANF basis in degrees 0,1,2,3;
2. enumerates every coefficient vector;
3. computes every truth table;
4. computes the complete Walsh spectrum using an independent FWHT;
5. identifies every bent function;
6. attempts to find a bent function whose antipodal quadratic coefficient is zero.

Expected audit totals from the independent reconstruction:
- N=4: 8 bent functions, zero violations;
- N=8: 256 bent functions, zero violations.

These exhaustive checks are falsification evidence only. The general Antipodal Rule remains an algebraic theorem and does not rely on finite enumeration.

## Proof dependency map

The general proof has three logically distinct inputs:
- complementary-fiber balance (Walsh/Parseval);
- quadratic RS rigidity for N a power of two;
- complementary-fiber rigidity from third differences and half-rotation.

If the antipodal coefficient vanished, the diagonal fiber would be constant. The first input forces the complementary fiber to be balanced; the latter two force it to be affine and then constant under the twisted cyclic action. This contradiction forces the antipodal coefficient to be one.
