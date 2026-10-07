# V2 — Formula-level comparison status: Carlet–Gao–Liu vs. F_r

Date: 2026-10-07

## Our family

The certified base block is the 8-variable RS bent function with SANF orbit seeds

    (0,1)
    (0,1,2,3)
    (0,1,2,5)
    (0,1,3,5)

and F_r is its r-fold direct sum after interleaving coordinates, n=8r.

We proved/certified the structural identity

    ind(F_r)=r=n/8.

## What the primary 2014 source establishes

Carlet–Gao–Liu, JCTA 127 (2014), DOI 10.1016/j.jcta.2014.05.008, states in its abstract that it derives the first infinite classes of idempotent and rotation-symmetric bent functions of algebraic degree greater than 3. It also studies a transformation between RS functions and idempotents and notes that the transformed functions are in general not affinely equivalent.

The accessible publisher metadata/abstract does not expose the complete quartic ANF needed for a term-by-term identity test with our four orbit seeds.

## What the 2026 source establishes

Polujan–Kudin–Pasalic, IEEE TIT 72(6) (2026), DOI 10.1109/TIT.2026.3685133, states explicitly that:
- a maximum-degree RS bent family is outside M# for all n>=8;
- a quartic RS bent family of Carlet–Gao–Liu is outside M# for infinitely many n.

The accessible article page also discusses linearity index as the M-subspace invariant relevant to M#, but the public abstract does not state an exact n/8 formula for that quartic family.

## Formula-level conclusion currently justified

We cannot yet certify one of:
A. F_r is literally the Carlet–Gao–Liu quartic family;
B. F_r is EA/linear equivalent to it;
C. F_r is distinct.

Reason: the complete defining quartic formula from the relevant theorem/example in the 2014 paper is not exposed in the publisher abstract/metadata available in this audit.

Therefore no identity or inequivalence claim should be made from title/degree/dimension pattern alone.

## Strong result that does not depend on that unresolved identity

Irrespective of whether F_r is old as a construction, the present proof determines a quantitative invariant:

    ind(F_r)=n/8 for every n=8r.

This is stronger than the bare statement F_r notin M#.

Dedicated web searches performed on 2026-10-07 for combinations of:
- "n/8" + "linearity index" + bent;
- "n/8" + "M-subspace";
- Carlet Gao Liu + linearity index;
- quartic rotation symmetric + M-subspace;
did not locate a publication explicitly stating this exact formula for the family.

STATUS:
    theorem correctness: PROVED modulo cited published direct-sum theorem;
    finite base certificate: EXACT;
    non-membership in M#: COROLLARY;
    novelty of exact n/8 formula: PLAUSIBLE / NOT CERTIFIED;
    identity with CGL quartic family: UNRESOLVED pending full theorem formula.

## Next decisive action

Obtain the full text of the 2014 JCTA paper (legitimate author manuscript, institutional repository, or user-provided copy), extract the precise quartic construction, normalize indices modulo n, and compare:
1. orbit supports;
2. parameter restrictions;
3. direct-sum/interleaving structure;
4. affine/linear equivalence invariants;
5. published M-subspace bounds.

Until that comparison is complete, manuscript language should say “candidate quantitative refinement” rather than “new family” or “first exact index result”.

## V1 firewall

V1 remains unchanged at d70ebc8a5a6c8a4901263af24ff71cbdb2a12e93.
