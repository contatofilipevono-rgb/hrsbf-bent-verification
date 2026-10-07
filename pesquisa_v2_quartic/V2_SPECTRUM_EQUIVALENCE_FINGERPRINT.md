# V2 — M-subspace spectrum as an equivalence fingerprint

Date: 2026-10-07

## Established family invariant

For F_r on n=8r variables define the M-subspace spectrum

    Sigma(F_r) = ( |MS_1(F_r)|, ..., |MS_r(F_r)| ).

The complete formula already proved is

    |MS_k(F_r)|
      = sum_{s=k}^r C(r,s) 255^s
          sum_{j=0}^s (-1)^j C(s,j) [s-j choose k]_2,

for 1<=k<=r, and |MS_k(F_r)|=0 for k>r.

Also RMS_k(F_r)=MS_k(F_r) for every k.

## Why this is an equivalence fingerprint

Prior work (Polujan--Pott, Proposition 4.4, as cited explicitly by Pasalic--Polujan--Kudin--Zhang, IEEE TIT 2024) establishes that the number of M-subspaces of any fixed dimension k is invariant under equivalence.

Therefore the entire sequence Sigma(F_r) is an equivalence invariant.

Consequently, for any same-dimensional bent function G, if there exists any k such that

    |MS_k(G)| != |MS_k(F_r)|,

then G is inequivalent to F_r.

This gives a stronger discriminator than the single number ind(F_r)=r.

## Immediate separations

### Completed Maiorana--McFarland class

Every n-variable bent function in M# has an M-subspace of dimension n/2.

For F_r,

    MS_k(F_r)=empty for k>n/8.

Hence F_r is separated from M# already by support of the spectrum.

### CGL quartic family

The CGL quartic family previously audited has admissible dimensions n=2m with m odd, i.e. n=2 mod 4, whereas F_r exists at n=0 mod 8.

There is no same-dimensional comparison to perform for that family, so equivalence is excluded dimensionally rather than spectrally.

### Tang 2026 Family A

Tang Family A has n=30*7^j and never intersects n=8r. Again, no same-dimensional equivalence comparison exists.

## Remaining genuine collision: Tang 2026 Family B

Tang Family B has n=70t. It intersects n=8r precisely when t=4s, giving

    n=280s,
    r=35s.

For F_{35s},

    ind(F_{35s}) = 35s,

and the maximal-spectrum coefficient is

    |MS_{35s}(F_{35s})| = 255^{35s}.

Tang's published argument gives an upper bound on M-subspace dimension (reported in the prior audit as <=34t=136s for t=4s), sufficient to show non-membership in M#, but that bound does not determine Tang's actual index or its M-subspace spectrum.

Therefore the present evidence is insufficient to prove inequivalence between F_{35s} and Tang Family B solely from M-subspace data.

A decisive comparison would require either:
1. the exact ind of Tang Family B at t=4s;
2. any |MS_k| value differing from our closed formula;
3. another preserved invariant (degree is not enough because both can be quartic).

Do not claim spectral inequivalence to Tang Family B until one of these is obtained.

## PKP/CGL and other RS families

The literature establishes that M-subspace cardinality at fixed dimension is an equivalence invariant, but the searched RS papers generally report existence/nonexistence or upper bounds, not complete spectra.

Thus absence of a published spectrum is not itself an inequivalence proof.

## Manuscript-safe statement

"The sequence (|MS_k(F_r)|)_k is completely determined and, since fixed-dimensional M-subspace cardinalities are equivalence invariants, provides an explicit equivalence fingerprint for the family. It immediately separates F_r from M# and can be used to test inequivalence against any same-dimensional construction for which corresponding M-subspace counts are available."

## Stronger future target

At common dimensions n=280s with Tang Family B, compute or derive one M-subspace count for Tang's quartic specialization. The cheapest target is likely its exact index: if ind(Tang) != 35s, inequivalence follows immediately.

## V1 firewall

V1 remains frozen and untouched.
