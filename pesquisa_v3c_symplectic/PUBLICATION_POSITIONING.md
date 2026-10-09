# Publication avenue: graph isomorphism inside EA-equivalence

Status: **research consequence of the compiled theorem; the ANF-size analysis below
is elementary and is not itself a Lean complexity formalization**. This note is
for positioning and review, not a novelty or hardness-priority claim.

## Candidate statement

Given two simple undirected graphs G,H on the same n≥2 labeled vertices, regard
their adjacency matrices as symmetric loopless directed matrices and form the
V3-C canonical maps with m=2. Each map has input dimension 4n and output
dimension n. For each vertex i its ANF is

`F_G(x)_i = p_i q_i p'_i q'_i + p_i q_i * sum_{j in N_G(i)} p_j`.

Here `(p_i,q_i,p'_i,q'_i)` are the four coordinates of vertex block i, and the
coupling uses the first coordinate pair. The `GraphFamily.canonical_EA_iff_graph_isomorphic`
theorem yields

`F_G EA-equivalent to F_H  <->  G isomorphic to H`.

The construction is polynomial in the adjacency-matrix input size: it uses 4n
input bits, n output bits, and O(n²) total ANF monomials (one quartic seed term
per output plus one cubic term per directed arc). Thus, on compact ANF input,
it gives a many-one reduction from equal-order simple Graph Isomorphism to EA
equivalence of this restricted family. Unequal vertex counts can be handled by
rejecting immediately and mapping to a fixed nonisomorphic equal-order pair.

## What this adds, and what it does not establish

This is a precise algebraic encoding and a complete converse: EA equivalence of
these canonical quartic vectorial maps cannot identify two nonisomorphic graphs.
The proof extracts a block permutation from fourth derivatives and reads arcs
from mixed third derivatives, including bidirected edges. The Lean theorem
certifies this for all m≥2; m=2 is the fixed-size-block reduction above.

Graph Isomorphism reductions to equivalence of cubic forms are already known;
Agrawal–Saxena (2005) explicitly state `GI ≤P cubic-form equivalence`:
https://www.cse.iitk.ac.in/users/manindra/algebra/algebras-cubicforms2.pdf.
So the reduction alone is not a novelty claim. A manuscript must compare the
precise target (EA-equivalence, vectorial Boolean functions, quartic ANF,
compact representation) with cubic-form equivalence and other function
isomorphism results. The likely contribution is the explicit quartic vectorial
family, its iff classification, and its derivative-based structural recovery,
with a machine-checked proof.

Kaleyski–Sunde, IACR ePrint 2026/940, is a current direct neighbor on algorithms
for deciding/recovering EA and CCZ equivalence of arbitrary vectorial Boolean
functions: https://eprint.iacr.org/2026/940. Its public implementation accepts
truth tables (or Sage polynomials) and the ePrint abstract does not by itself
settle complexity for compact ANF inputs. Compare its input model, guarantees,
and scope against this family before claiming practical or complexity novelty.
It is an algorithmic comparison point, not evidence against the structural
classification theorem.

## Recommended next research check

1. Read the full 2026/940 manuscript and determine its input-size/complexity
   model, treatment of compact ANFs, and any graph-isomorphism reductions.
2. Search for prior EA classifications or complete invariants built from higher
   derivatives for vectorial Boolean functions; compare theorem statements, not
   only titles or abstracts.
3. State the compact-ANF reduction carefully, including equal dimensions and
   the trivial unequal-order case. Do not infer an algorithmic lower bound from
   GI-hardness beyond the usual conditional implication (a polynomial-time
   algorithm for the restricted EA problem would yield one for GI).
4. Keep cryptographic claims separate: this construction is a classification
   family; the current theorem does not certify bentness, APN, or security.
5. A stronger follow-up, if literature comparison supports it, is a theorem on
   EA automorphism groups: graph automorphisms certainly induce EA
   automorphisms, while the existing converse proof may recover the full
   vertex permutation. The remaining internal block/output stabilizer should
   be characterized before claiming the automorphism group is exactly the
   graph automorphism group.

No conclusion about publication priority follows from this preliminary note.
