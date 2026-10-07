# V2 — Comparison map for quartic rotation-symmetric bent families

Date: 2026-10-07

## Purpose

This note positions the V2 family

    F_r(x)=sum_{j=0}^{r-1} f(x_j,x_{j+r},...,x_{j+7r}),  n=8r,

against the closest rotation-symmetric bent constructions found in the literature. It records only distinctions supported by the cited papers / project audits. Absence of a published exact index or spectrum is recorded as "not located", not inferred.

## Comparison table

| Family / source | Dimensions | Degree relevant here | Ordinary RS? | Outside M#? | Linearity-index information | Complete M-subspace spectrum? | Relation to F_r |
|---|---:|---:|---|---|---|---|---|
| Carlet–Gao–Liu, JCTA 2014, DOI 10.1016/j.jcta.2014.05.008 | n even, n not divisible by 4 | 4 | Yes | Later work identifies an infinite quartic subfamily outside M# | Exact index not located in the audited source | Not located | No common dimensions: CGL quartic has n≡2 mod 4; F_r has n≡0 mod 8 |
| Polujan–Kudin–Pašalić 2026, cubic 10-variable class | n=10 | 3 | Yes | Yes | Studied via M-subspaces / equivalence classification | No all-k infinite-family spectrum relevant here | Different degree and dimension; not a quartic infinite-family competitor |
| Tang 2026, Family A | n=30·7^j | includes degree 4 | Yes | Yes | Published M-subspace upper bound < n/2 | No complete all-k spectrum located | No common dimensions with n=8r because 30·7^j has 2-adic valuation 1 |
| Tang 2026, Family B | n=70t | includes degree 4 | Yes | Yes | Quartic specialization h_4 has 30t <= ind(h_4) <= 34t | No complete all-k spectrum located | Common dimensions n=280s. There F_{35s} has ind=35s while h_4 has ind>=120s; hence inequivalent |
| Present V2 family F_r | n=8r, every r>=1 | 4 | Yes | Yes | ind(F_r)=r-ind(F_r)=r=n/8 exactly | Yes: closed formula for every 1<=k<=r, and RMS_k=MS_k | New explicit family under current priority audit |

## Present-family results

The 8-variable seed is a quartic rotation-symmetric bent function with computationally certified

    r-ind(f)=1.

The interleaved r-fold direct sum is rotation-symmetric for every r. The exact indices are

    ind(F_r)=r-ind(F_r)=r=n/8.

Hence F_r is outside the completed Maiorana–McFarland class for every r>=1.

More strongly, for every 1<=k<=r,

    RMS_k(F_r)=MS_k(F_r),

and

    |MS_k(F_r)|
      = sum_{s=k}^r C(r,s) 255^s A(s,k),

where

    A(s,k)
      = sum_{j=0}^s (-1)^j C(s,j) [s-j choose k]_2.

Equivalently,

    |MS_k(F_r)|
      = sum_{s=k}^r C(r,s)255^s
          sum_{j=0}^s (-1)^j C(s,j)[s-j choose k]_2.

For k>r, MS_k(F_r)=RMS_k(F_r)=empty.

Special cases:

    |MS_1(F_r)| = 2^(8r)-1,
    |MS_r(F_r)| = 255^r.

## Formal separation from CGL 2014

Carlet–Gao–Liu state that their infinite quartic RS bent class has n even but not divisible by 4. Thus its dimensions satisfy

    n ≡ 2 (mod 4).

Our family has

    n=8r ≡ 0 (mod 8).

Therefore the dimension sets are disjoint. No equivalence comparison at a common dimension exists.

This is a dimensional separation, not an M-subspace-spectrum argument.

## Formal separation from Tang Family A

Tang Family A has

    n=30·7^j.

Since 7^j is odd, every such n has 2-adic valuation one, whereas n=8r has 2-adic valuation at least three. Hence

    30·7^j != 8r

for all positive integers j,r.

Again the families have no common dimensions.

## Formal inequivalence to Tang Family B at every common dimension

Tang Family B has n=70t. Common dimensions with n=8r solve

    8r=70t,

so

    t=4s, r=35s, n=280s.

For the quartic specialization h_4 of Tang's second construction, the ambient decomposition is

    V=V0⊕U⊕W,
    dim U=dim W=30t,

and the function has the form

    h_4(x0,u,w)=b(u,w)+g(x0)+eta_4(u).

The entire W summand is an M-subspace: for directions a,c in W, the terms g and eta_4 are independent of W and b(u,w) is linear in w, so

    D_aD_c h_4=0.

Therefore

    ind(h_4)>=30t.

Tang's published argument supplies

    ind(h_4)<=34t.

At a common dimension n=280s, t=4s and our parameter is r=35s. Thus

    ind(F_{35s})=35s,

whereas

    ind(h_4)>=30(4s)=120s.

Hence

    ind(F_{35s}) != ind(h_4),

and the quartic functions are not extended-affine equivalent for every s>=1.

This separation needs no exact computation of Tang's index and no Tang M-subspace spectrum.

## Why the complete spectrum matters

Prior M-subspace work establishes that fixed-dimensional M-subspace cardinalities are equivalence invariants. Thus

    Sigma(F_r)=(|MS_1(F_r)|,...,|MS_r(F_r)|)

is an explicit equivalence fingerprint.

The exact index records only the final nonzero dimension of this sequence. The V2 formula determines every entry and, in addition, proves equality of ordinary and relaxed M-subspace sets in every admissible dimension.

## Manuscript-safe novelty statement

A safe current formulation is:

" We construct an explicit infinite family of quartic rotation-symmetric bent functions F_r on n=8r variables. The selected eight-variable seed has certified relaxed linearity index one. The interleaved direct-sum construction satisfies ind(F_r)=r-ind(F_r)=n/8 and hence lies outside the completed Maiorana–McFarland class for every r. Moreover, we determine the complete M-subspace spectrum in closed form and prove RMS_k(F_r)=MS_k(F_r) in every admissible dimension. The family is dimensionally disjoint from the quartic Carlet–Gao–Liu family and Tang's first construction, and it is separated by linearity index from the quartic specialization of Tang's second construction at every common dimension."

For global priority, retain "to the best of our knowledge" until the final bibliography audit. Do not claim that counting M-subspaces, relaxed M-subspaces, or direct-sum projection theory is new.

## Source anchors

- C. Carlet, G. Gao, W. Liu, "A secondary construction and a transformation on rotation symmetric functions, and their action on bent and semi-bent functions," J. Combin. Theory Ser. A 127 (2014), 161–175. DOI: 10.1016/j.jcta.2014.05.008.
- Polujan–Pott: relaxed M-subspaces / relaxed linearity index and direct-sum machinery.
- Pašalić–Polujan–Kudin–Zhang, IEEE Trans. Inf. Theory 70(6) (2024), 4464–4477, DOI: 10.1109/TIT.2024.3352824: M-subspace cardinalities and equivalence invariants.
- Deng Tang, ePrint 2026/1799: Families A and B, their dimension sets, algebraic-degree ranges, and M-subspace bounds.
- Project certificate: eight-variable seed has r-ind(f)=1.
- Project proofs: rotation symmetry, exact index, maximal-subspace classification, and complete M-subspace spectrum.

## V1 firewall

V1 is frozen. This note and all claims above belong exclusively to V2.
