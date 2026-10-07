# Research state checkpoint — 2026-10-06

This file is a navigation checkpoint. It separates established arguments from computational checks and open quartic work.

## A. Established in the cubic manuscript

Submission manuscript: paper_cubic_global_submission.tex

Claimed theorem:
No homogeneous rotation-symmetric Boolean function of algebraic degree 3 is bent in any positive even dimension.

Current proof chain:
1. Odd-order fixed-space balance transfer for invariant quadratics.
2. Hence bent functions of degree <=3 restrict bent to the odd-order fixed space.
3. Cubic homogeneous orbit folding cannot create the antipodal quadratic orbit in the power-of-two fixed dimension.
4. Antipodal Rule: every rotation-symmetric bent function of degree <=3 in power-of-two dimension >=4 contains that antipodal quadratic orbit.
5. Contradiction; dimension 2 is handled separately.

These are mathematical arguments in the manuscript. Computational checks are not premises of the proof.

## B. Auxiliary cubic structure

Established derivations:
- complementary-fiber Parseval balance;
- half-swap / fiber-polar identity for cubic functions with constant diagonal;
- cyclic covariance of offset fibers;
- period-one all-ones fiber is exceptional;
- periodic-fiber monodromy alone cannot universally force constancy for orbit period >1.

Files currently present:
- fiber_orbit_propagation.md
- periodic_fiber_monodromy.md

Repository hygiene note:
Some later notes refer to fiber_covariance_cubic.md, but that filename is not currently present on this branch. The mathematical identity should be consolidated into an existing self-contained note or restored under that name before publication packaging.

## C. Quartic program — NOT proved

No theorem excluding homogeneous quartic RS bent functions has been obtained.

The cubic odd-order restriction step does not automatically extend:
- deg f<=4 gives D_a f cubic;
- bentness makes D_a f balanced;
- a second derivative is quadratic, but bentness does not make every second derivative balanced.

Therefore the naive repeated-derivative extension is invalid.

Current exact quartic bridge:
For bent f with dual f*,

W_{D_a f}(b)=(-1)^{a dot b} W_{D_b f*}(a).

For rotation-symmetric bent f, f* is rotation-symmetric. But low algebraic degree and homogeneity need not pass to f*, so this identity is a bridge, not a reduction theorem.

Files:
- quartic_extension_audit.md
- bent_derivative_duality.md

Repository hygiene note:
A filename quartic_derivative_autocorrelation.md was referenced in discussion but is not present on the branch.

## D. Current single research target

Let T have odd order and U=Fix(T). Let f be T-invariant, bent, deg f<=4. For a in U\{0}, define c=D_a f.

Need to determine whether the paired spectral information from f and f* plus T-invariance implies

sum_{u in U} (-1)^{c(u)}=0.

Equivalently: can balance of the cubic derivative c be transferred to U using its full derivative spectrum and the bent dual, rather than an unavailable cubic analogue of the quadratic transfer lemma?

Until this is proved or falsified, do not proceed to quartic orbit-folding claims.

## E. Evidence discipline

PROVED: algebraic identities and lemmas with complete derivations.
COMPUTATION: falsification/validation only; never a premise of the cubic theorem.
OPEN: all degree-4 nonexistence statements and any claimed quartic fixed-space reduction.
