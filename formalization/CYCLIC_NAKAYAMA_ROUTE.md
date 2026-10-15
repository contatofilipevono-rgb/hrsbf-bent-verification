# Proposed elementary route: cyclic Nakayama argument over F₂

**Status: mathematical reduction / proof plan — NOT Lean-certified.**

Let N=2^k ≥2, V=F₂^N, S a cyclic coordinate rotation, T=S+I and p(v)=Σᵢvᵢ (mod 2). Let Q be rotation-invariant with zero third differences; B its polar; R=rad(B).

## Existing Lean facts

- `RadicalInvariant.lean`: R is an F₂-submodule, S-stable, and proper when B≠0.
- `PowerTwoNilpotence.lean`: target `T^N=0` assuming `S^N=I`; pending CI as of first write.
- `QuadraticBalanceBridge.lean`: if B≠0 and R⊆im(T), then Q cannot be balanced, via certified integer Gauss identity.

## Avoid heavy local-ring quotient machinery

**A. Characterize image:** Prove `range(T)=ker(p)` for the concrete cyclic S, uniformly in N>0. One inclusion follows from invariance of coordinate sums. For the reverse, if p(v)=0 choose y₀=0 and solve the recurrence yᵢ₊₁=yᵢ+vᵢ; the wraparound condition is precisely p(v)=0.

**B. Nilpotence:** Because S has order N and N is a power of two, Frobenius in characteristic two gives
`T^N=(S+I)^N=S^N+I^N=I+I=0`.

**C. Proper stable subspaces lie in image:** For *any* T-stable proper submodule R, suppose R contains r∉im(T). Since im(T)=ker(p) has codimension one, p(r)=1 and `R+im(T)=V`. Consequently `V=R+T(V)`. Since R is stable under T, induction gives `V=R+T^j(V)` for all j. Take j=N: `V=R+0=R`, contradiction. Hence R⊆im(T).

**D. Finish:** Instantiate `balanced_polar_zero_of_proper_radical_image`. This closes Lemma 5.1 *once steps A–C are kernel-checked*.

## Exact Lean bridge required

Prove a generic lemma for F₂-modules of finite dimension:
`[T^N=0] → [R stable under T] → [ker(p)=range(T)] → [p surjective] → [R≠⊤] → R≤range(T)`
with `p: V→ₗ[F₂] F₂` and its one-dimensional codomain. Alternatively directly build the decomposition of v in R+range(T) using the parity witness r.

This is an *elementary version of Nakayama's lemma* and is likely less expensive in Lean than constructing `F₂[X]/(X+1)^N` and proving that ring is local.

**Certification gate:** exact unconditional rotation-invariant quadratic rigidity must appear under its manuscript hypotheses; no imported `himage` premise may remain in its final signature.
