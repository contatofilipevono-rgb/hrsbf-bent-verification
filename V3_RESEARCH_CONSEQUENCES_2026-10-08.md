# V3: rigorous consequences of canonical graph EA classification

Base theorem: `VonoExactIndex.GraphFamily.canonical_EA_iff_graph_isomorphic` in `pesquisa_v2_quartic/lean/VonoExactIndex/GraphClassification.lean`.

For each r, loopless directed graphs G on r labeled vertices define F_G:(F_2^8)^r -> F_2^r by
(F_G)_i(x)=f(x_i)+x_{i,0}x_{i,1} sum_{j: i->j}x_{j,0}.

## Corollary 1: injection on isomorphism classes
The map [G] -> [F_G]_EA is injective. This is immediate from the proved biconditional. The domain includes arbitrary loopless digraphs (not necessarily connected).

## Corollary 2: lower bound on EA classes
There are 2^{r(r-1)} labeled loopless directed graphs. Each isomorphism class has at most r! labeled representatives. Therefore the family contains at least ceil(2^{r(r-1)}/r!) distinct EA classes for every r>=1. This is a lower bound, not an exact count. Input dimension is 8r, output dimension r. A tighter count can be obtained from directed-graph enumeration/Burnside, subject to independent verification.

## Corollary 3: explicit inequivalence
Any pair of nonisomorphic loopless digraphs G,H yields EA-inequivalent F_G,F_H. For example, the empty graph and a graph with exactly one arc are not isomorphic when r>=2. Their associated maps have exact vector relaxed index r according to `GraphFunction.graph_has_exact_index`.

## Complexity caveat
The graph encoding is compact as a circuit/ANF of size polynomial in r (at most O(r^2) arc terms plus r fixed seeds). Therefore directed graph isomorphism many-one reduces to EA equivalence for succinctly encoded vectorial Boolean maps, **provided** the target decision problem is defined on such circuit/ANF representations and the source digraph instance is encoded explicitly. This does not by itself establish GI-hardness for truth-table input with polynomial reduction: the truth table has 2^{8r} rows, exponential in r. Nor does it prove EA equivalence is GI-complete, or that arbitrary EA equivalence lies in GI.

## Stronger quadratic statement
`quadraticEA_implies_graph_isomorphic` proves that a quadratic-corrected equivalence between *canonical* representatives implies graph isomorphism. It does not assert a converse for independently and arbitrarily quadratically perturbed representatives.

## Novelty and publication boundaries
These corollaries are mathematical deductions from the formal theorem, not independent discoveries of new primitives or cryptographic security. Verify literature priority, especially graph-to-Boolean-function equivalence reductions, and distinguish complexity of succinct ANF/circuit encoding from truth-table encoding.

## Verification
A successful GitHub Actions workflow was reported by the user for branch `v3-independent-ea-audit-20261008`; independent retrieval of its run ID and logs remains outstanding. Do not call the workflow a verified independent run until logs are independently inspected.
