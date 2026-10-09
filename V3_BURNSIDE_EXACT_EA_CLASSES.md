# Exact count of canonical EA classes by Burnside

**Scope.** Let N_r be the number of EA-equivalence classes represented by canonical maps F_G where G ranges over all loopless directed graphs on r vertices. The previously formalized biconditional F_G ~EA F_H iff G ≅ H identifies N_r with the number of unlabeled loopless directed graphs.

## Exact formula

For a permutation π in S_r, let o(π) be the number of orbits of its action on ordered pairs (i,j) with i≠j. A loopless digraph fixed by π chooses one binary arc value per orbit, hence has 2^{o(π)} possibilities. Burnside gives

N_r = (1/r!) Σ_{π∈S_r} 2^{o(π)}.

If π has cycle lengths λ_1,...,λ_k, then

o(π) = Σ_{a,b=1}^k gcd(λ_a,λ_b) - k.

Proof: ordered pairs in the full Cartesian square of cycles of lengths u,v split into gcd(u,v) orbits under simultaneous cyclic shifts. Across all cycle pairs this counts Σ gcd; removing diagonal pairs (i,i) removes one orbit for each cycle, hence subtract k.

Equivalently, sum over partitions λ of r:

N_r = Σ_{λ⊢r} 2^{Σ_{a,b}gcd(λ_a,λ_b)-ℓ(λ)} / z_λ,
where z_λ=∏_{d≥1} d^{m_d} m_d!, with m_d the multiplicity of d in λ.

These formulas count exactly the canonical EA classes, **not** all vectorial Boolean EA classes with input dimension 8r and output dimension r.

## Consequences

- Elementary lower bound: N_r ≥ ceil(2^{r(r-1)}/r!).
- The identity permutation contributes 2^{r(r-1)}/r! to Burnside.
- Every canonical map has exact relaxed vector index r by GraphFunction.graph_has_exact_index.
- Since 2^{r(r-1)}/r! grows superexponentially in r, the number of canonical EA classes is unbounded and large.

## Limitations and checks

1. The Burnside argument here is an ordinary mathematical proof and is **not yet separately formalized in Lean**.
2. Independent numeric evaluation and comparison with published digraph counts are recommended.
3. No cryptographic security or new equivalence complexity class follows merely from the count.
4. The reduction from digraph isomorphism to EA equivalence is polynomial for succinct ANF/circuit representation, not truth-table representation.

## Formal source
`pesquisa_v2_quartic/lean/VonoExactIndex/GraphClassification.lean` theorem `canonical_EA_iff_graph_isomorphic`.
