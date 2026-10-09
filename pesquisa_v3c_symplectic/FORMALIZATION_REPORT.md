# V3-C: certified seed, EA transport and canonical directed-graph classification

## Scope and isolation

The original seed/block work was confined to the now read-only reference
`v3c-symplectic-generalization-2026-10-08`, starting at
`40daaaf5717f0a46941e814a9b0bdd2d895f07cf`. No existing V1/V2 source, certificate,
project configuration, or workflow was edited.

The continuation is exclusively on `v3c-ea-transport-continuation`, based on
`83b53a57f47ae33d4694346dc0e315d2a4c38878`. Existing seed/block proof modules
remain byte-identical. See CONTINUATION_PROGRESS.md for staged builds and handoff. A separate Lean project is under
`pesquisa_v3c_symplectic/lean`, with namespace `VonoV3C` and Lean/Mathlib 4.19.0.

`Vec m = Fin m → (ZMod 2 × ZMod 2)` represents the requested 2m coordinates.
The definition `seed m` is the explicit sum over i<j of p_i q_i p_j q_j.
No alternative seed or extra hypothesis on the seed is used.

## Certified statements

| Priority | Declaration | Exact scope |
| --- | --- | --- |
| 1 | `VonoV3C.seed_fourth` | D⁴f_m(a,b,c,d)(x) equals the three symplectic pairing products for every m and every base point x. |
| 2 | `VonoV3C.seed_property_A` | For every m≥2, vanishing D⁴f_m(a,b,c,d)(0) for all c,d implies a=0 or b=0 or a=b. |
| 2 | `VonoV3C.fourth_pair_zero_iff` | The preceding condition is equivalent to that dependent-pair criterion. |
| 2 | `VonoV3C.constant_second_iff` | D_a D_b f_m is constant iff a=0 or b=0 or a=b, for m≥2. |
| 3, algebraic part | `VonoV3C.Blocks.quartic_pair_zero_iff` | The direct sum quartic zero-pair relation is exactly dependence in each block. |
| 3, algebraic part | `VonoV3C.Blocks.recover_blocks_from_quartic` | Any invertible linear map preserving this intrinsic zero-pair relation permutes the entire blocks and restricts to a linear equivalence on each block. |
| Graph A | `GraphFamily.fourth_component`, `graph_fourth` | Actual graph fourth derivative equals the certified pfaffian, for every base point and m≥2. |
| Graph B | `GraphFamily.representation_fourth`, `representation_pair`, `EA_recovers_blocks` | Ordinary EA transport derives intrinsic pair preservation and input-block recovery. |
| Graph C | `GraphFamily.representation_output_basis`, `representation_output` | Output coordinate permutation matches the recovered input permutation with inverse orientation. |
| Graph D | `GraphFamily.mixed_third`, `edge_detected_iff`, `representation_edges` | Exact mixed third derivative and directed edge recovery, reverse arcs unrestricted. |
| Graph E | `GraphFamily.canonical_EA_iff_graph_isomorphic` | For canonical loopless graphs on any common finite vertex type and m≥2, ordinary EA iff graph isomorphism. |
| Graph index | `GraphFamily.graph_has_exact_relaxed_index` | Exact vector relaxed index `card ι` for every finite vertex type, m≥2, and every adjacency function. |
| Kernel dimension | `GraphFamily.graph_fourth_radical_dimension` | For each input a, the actual fourth-derivative radical at all base points is a linear subspace of dimension `2*m*card ι - (2*m-1)*supportCount a`. |

Over F₂, `a=0 ∨ b=0 ∨ a=b` is the explicit dependent-pair criterion. The
certificates use this disjunction directly; they do not state a separate theorem
identifying it with Mathlib's `LinearIndependent` predicate.

Polarization is proved by algebraic first-, second-, and third-difference
identities for each quartic monomial, followed by the fourth-difference identity,
linearity over finite sums, and a triangular-sum rearrangement. Characteristic-two
coefficients are reduced by definitional equalities. The proof is not a truth
table or a certificate for finitely many values of m.

Property A is proved through coordinate minors. Vanishing contractions imply
that the minors equal omega(a,b) times the standard symplectic pairing matrix.
The Pluecker identity on the two distinct coordinate planes indexed 0 and 1
forces omega(a,b)=0. Vanishing minors then force the dependent-pair criterion.
The only scalar reduction is the elementary fact that a residue with value <2
has value 0 or 1, proved using natural-number inequalities.

The block-recovery proof follows the V2 partition argument, replacing the
finite `native_decide` witness by two explicitly distinct coordinate vectors.
Its preservation premise is explicit. No EA classification theorem is inferred
without proving that premise for the actual graph maps. The continuation now
proves it in GraphEATransport.lean before applying this theorem.

## Kernel dimension (certified)

`pairKernelSpace a` is the product of unrestricted local spaces when `a i = 0`
and singleton spans when `a i ≠ 0`. `pairKernelPiEquiv` gives the linear
equivalence to that product. `mem_pairKernelSpace_iff_graphFourth_zero` connects
this subspace to the actual graph map's fourth derivative for all remaining
directions, output coordinates, and base points. `finrank_pairKernelSpace` sums
the local dimensions 2m and 1, producing the claimed formula. Support counts
nonzero vertex blocks, not nonzero scalar coordinates. Empty vertex types and
the zero input are covered. No looplessness hypothesis is needed here.

## Remaining gaps

5. **Indecomposability with quadratic perturbations:** formalize quadratic
   annihilation by D³/D⁴, extract a block partition from a product decomposition,
   and rule out crossing edges for a weakly connected graph. No graph
   indecomposability certificate is delivered.

No graph-classification or indecomposability statement is silently weakened by
an artificial premise and then advertised as the requested unconditional result.

## Reproduction and logs

```sh
cd pesquisa_v3c_symplectic/lean
lake exe cache get Mathlib.Data.ZMod.Basic Mathlib.Algebra.BigOperators.Group.Finset.Basic Mathlib.Algebra.BigOperators.Ring.Finset Mathlib.Tactic.Ring Mathlib.Tactic.Abel Mathlib.LinearAlgebra.Pi
lake build
lake env lean Audit.lean
lake env lean GraphContinuationAudit.lean
```

`logs/build.log` records a rebuild after deleting only this project's generated
`.lake/build` directory. `logs/axioms.log` records the exported theorem audit.
The axioms are the standard Mathlib foundations `propext`, `Classical.choice`,
and `Quot.sound`; there are no newly introduced axioms or native-evaluation
axioms. No `sorry`, `admit`, `unsafe`, or `native_decide` occurs in the delivered
V3-C source modules.

`logs/continuation/A-build.log` through `E-build.log` record each successful
continuation build; the corresponding axiom logs record the kernel dependencies.
First-attempt failure logs and their corrections are explained in
CONTINUATION_PROGRESS.md. All five requested graph modules are included in the
default library target. Nonfatal tactic/unused-parameter linter warnings remain.

`lean/logs/continuation/kernel-radical-build.log` records the earlier radical
characterization. `lean/logs/continuation/kernel-dimension-build.log` and
`kernel-dimension-axioms.log` record the full dimension build and axiom audit.
The exported graph-radical dimension theorem uses only `propext`,
`Classical.choice`, and `Quot.sound`. Failure logs and corrections are described
in CONTINUATION_PROGRESS.md.

`logs/ENVIRONMENT.md` documents the local executable-path adapter necessitated
by this execution container. It does not change Lean's kernel or proof objects.
The new workflow `lean-v3c-symplectic.yml` applies only to the original reference research branch
and project; it is not automatically triggered by continuation pushes. Local verification and GitHub CI status are separate: the existence
of the workflow alone does not mean that a remote run has passed.

## Boundaries

Graph-only classification under arbitrary quadratic perturbations is not claimed.
For m=2, quartic preservation is not assumed to imply preservation of omega.
No literature novelty or publication readiness is asserted by this formalization.

The theorem uses a common finite vertex type. A heterogeneous graph-type/EA
convenience wrapper remains unimplemented. This does not restrict the adjacency
matrices or the quantified EA maps in the certified common-type theorem.
