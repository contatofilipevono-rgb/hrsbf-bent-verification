# V2: exact vector index and EA indecomposability

Lean 4.19.0; pinned Mathlib c44e0c8ee63ca166450922a373c7409c5d26b00b.

For a finite block set I and Boolean directed adjacency adj, the certified map is

F(x)_i = seed(x_i) + x_i(0) x_i(1) sum_j [adj(i,j)] x_j(0),

where each x_i has eight binary coordinates and seed is the existing full Seed8 function, including its quadratic orbit.

## Certified results

- `graph_has_exact_index`: the maximum dimension of a subspace on which every coordinate has constant second differences equals |I|, for every adjacency. The seed Property A is discharged by the previously compiled bridge; it is not an assumed premise.
- `graph_no_relaxed_split`: if every nonempty proper cut has an edge in either direction, no two nonzero input subspaces spanning the input can have constant cross second differences.
- `EA_product_has_relaxed_split`: every nontrivial product representation after an invertible linear input change, arbitrary input translation, linear output map, and affine output addition produces such a split. The output map need not be invertible, so the theorem covers usual EA equivalence as a special case.
- `graph_not_EA_product`: connected maps have no such EA product representation.
- `graph_quadratic_exact_index` and `graph_quadratic_not_EA_product`: these properties persist under every perturbation with constant second differences.
- `quadratic_ANF_second_constant`: the perturbation condition is proved for arbitrary explicit affine-plus-quadratic ANF, namely c + L(x) + sum_k w_k l_k(x)m_k(x), with l_k and m_k linear. `graph_ANF_certified` combines this with the index and split obstruction. No external degree claim is assumed.
- `star_cut_connected`, `star_exact_index`, and `star_no_relaxed_split`: an explicit infinite family, with r+2 blocks for every natural r, input dimension 8(r+2), output dimension r+2, exact index r+2. Quadratic perturbations are covered too. EA indecomposability follows by the generic product bridge.

## Proof route

Fourth differences eliminate the cubic coupling, exposing the actual seed. Property A bounds each projected relaxed subspace by one dimension; projection dimensions bound the full subspace. The directions supported in coordinate 2 furnish the matching lower bound.

For a proposed product split, Property A and spanning force each entire eight-dimensional block to one side. A crossing edge gives a nonzero mixed third difference, contradicting constancy of the cross second difference. This direct argument avoids requiring a separate centroid theorem.

## Validation and trust

`lake build` and `lake env lean GraphFamilyAudit.lean` are checked locally. Audit output is stored under `validation/graphs/`. Successful dependency audits contain only propext, Classical.choice, Quot.sound and Lean.ofReduceBool; there are no custom proof axioms or admitted goals. Native finite certificates retain Lean's native_decide / Lean.ofReduceBool trust boundary, as in the seed certificate. Linter warnings about unused section variables are not proof failures.

The new modules are additive; V1 and previously certified V2 source modules are preserved. The root import adds the graph certificates. The separate CI workflow repeats the build and both audits on the graph branch.

Not certified here: the converse/complete classification of EA equivalence by graph isomorphism, or a formal equivalence between an external polynomial-degree API and the explicit quadratic ANF representation. These are distinct from the exact-index and indecomposability results above.
