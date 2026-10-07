# V2 — Section 6 priority matrix: Deng Tang ePrint 2026/1799

Date: 2026-10-07
Scope: novelty/prior-art audit for the quartic RS bent family F_r on n=8r.
V1 firewall: V1 remains frozen and untouched.

## 1. What Tang 2026 proves about earlier broad constructions

Section 6 proves that the systematic Su–Tang construction (IEEE TIT 2017) is inside the completed Maiorana–McFarland class M#.

For a cyclic-shift-closed Gamma subset of F_2^r,

    f_Gamma(x,y) = x·y + 1_Gamma(x+y).

Under u=x and v=x+y,

    f_Gamma(u,u+v) = u·v + 1_Gamma(v) + sum_i u_i,

which is EA-equivalent to a Maiorana–McFarland function. Thus f_Gamma belongs to M#.

Tang also proves that the finite-field bent-idempotent construction of Tang et al. has an r-dimensional M-subspace in 2r variables and therefore belongs to M#.

CONSEQUENCE FOR V2:
These two broad 'any algebraic degree' RS constructions are not prior art for our property 'outside M#'.

## 2. Tang's own two 2026 constructions

Family A:
    n = 30 * 7^j, j >= 0.
    Degrees: every d from 3 to n/2.
    M-subspace bound: ind <= 14 * 7^j < n/2.

Family B:
    n = 70t, t >= 1.
    Degrees: every d from 3 to n/2.
    M-subspace bound: ind <= 34t < 35t = n/2.

Tang uses these strict upper bounds to prove non-membership in M#.

Important distinction:
Tang does not claim these displayed upper bounds are exact linearity indices. The paper defines ind and r-ind, but the main constructions use upper bounds sufficient to exclude M#.

## 3. Dimension intersection with F_r

Our family:
    n = 8r, r >= 1.

Tang Family A:
    n = 30*7^j.
This is never divisible by 8, because v_2(n)=1.
Therefore Family A has no dimensional intersection with n=8r.

Tang Family B:
    n = 70t.
Intersection with n=8r requires 8 | 70t, equivalently 4 | t.
Writing t=4s gives
    n = 280s = 8*(35s).
Thus Tang Family B intersects our dimension sequence only when our parameter r is a multiple of 35.

Therefore dimension alone separates F_r from Tang Family A and from most instances of Family B, but NOT from Family B at r=35s.

## 4. Earlier outside-M# prior art summarized by Tang

Tang's Section 6 says the rotation-symmetric functions studied in Polujan–Kudin–Pasalic include:
1. a maximum-degree family, degree n/2, outside M# for every even n >= 8;
2. a quartic family outside M# for infinitely many n;
3. cubic examples in 10 variables.

For our fixed quartic family, item (2) remains the principal pre-2026 comparison target.

The maximum-degree family can coincide in algebraic degree 4 only at n=8, so it is not an infinite quartic collision.

The cubic 10-variable examples are separated by degree and dimension.

## 5. What Tang 2026 does NOT settle for us

Tang 2026 does not, from the statements audited here, establish:
- an exact linearity index n/8 for a quartic RS family on every n=8r;
- identity or EA-equivalence with F_r;
- a fixed quartic family covering every n divisible by 8.

Accordingly, the safe current theorem remains:

    ind(F_r) = r = n/8, for n=8r,

with F_r outside M# because n/8 < n/2.

Global novelty remains subject to exact comparison with the known quartic outside-M# family of Carlet–Gao–Liu as analyzed by Polujan–Kudin–Pasalic and any other fixed-degree quartic RS families not captured by Tang's Section 6 summary.

## 6. Priority matrix

| Construction | RS bent | Quartic possible | Outside M# | Dimensions overlap n=8r | Exact ind=n/8 located? | Status |
|---|---|---|---|---|---|---|
| Su–Tang 2017 | yes | yes | NO; Tang 2026 proves in M# | yes | no | eliminated as outside-M# collision |
| Tang et al. bent idempotents | yes when phi RS | yes | NO; Tang 2026 proves in M# | broad | no | eliminated as outside-M# collision |
| Su 2019 maximal degree / PKP analysis | yes | only n=8 has degree 4 | yes | n=8 only for quartic | no | no infinite quartic collision |
| CGL 2014 quartic / PKP analysis | yes | yes | yes for infinitely many n | requires exact parameter audit | no | PRIMARY PRIOR-ART TARGET |
| Deng Tang 2026 Family A | yes | yes | yes | none | no exact result claimed | dimension-separated |
| Deng Tang 2026 Family B | yes | yes | yes | r multiple of 35 | no exact result claimed | structural comparison needed on intersection |
| F_r | yes | fixed degree 4 | yes | all n=8r | YES: ind=n/8 | candidate contribution |

## 7. Recommended claim language

Do NOT claim yet:
    'the first quartic RS bent family outside M#'.

Safe stronger formulation:
    'We construct/analyze a quartic rotation-symmetric bent family F_r in n=8r variables and determine its linearity index exactly as ind(F_r)=n/8.'

Possible novelty formulation, pending final audit:
    'To the best of our knowledge, this gives the first exact linearity-index formula for an infinite quartic rotation-symmetric bent family outside M# covering every dimension divisible by 8.'

The words 'first' must remain provisional until the exact-index literature search and CGL/PKP formula-level comparison are complete.

## 8. Next decisive task

1. Re-open the CGL 2014 quartic construction and the 2026 Polujan–Kudin–Pasalic analysis.
2. Derive the exact admissible dimensions of the quartic outside-M# subfamily.
3. Compare those dimensions and orbit/SANF support with F_r.
4. Extract every available M-subspace/linearity-index statement.
5. Search specifically for exact index formulas, not merely bounds below n/2.
6. For Tang Family B at n=280s, compare construction invariants; do not claim inequivalence from dimension.
