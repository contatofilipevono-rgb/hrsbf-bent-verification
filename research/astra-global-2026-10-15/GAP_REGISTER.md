# Gap register

## Global theorem proof

**No unproved premise remains in `universal_antipodal`, `universal_antipodal_canonical`, or `no_homogeneous_cubic_rotation_symmetric_bent`.** The local kernel checks pass. Clean source-commit CI is the remaining release check at this checkpoint.

| Historical gap | Resolution |
|---|---|
| G1: general degree≤3 diagonal identity | `DiagonalANF.lean` proves canonical free-involution cancellation; `PowerTwoCubic.lean` derives constancy on the actual half-turn fixed space from the zero antipodal representative coefficient. |
| G2: concrete odd fixed-space coordinates | `CyclicOddCoordinates.lean` proves cyclic subgroup order, periodicity of every fixed vector, explicit repeated-block linear equivalence, and actual bentness/symmetry preservation. |
| G4: all-even-dimensional assembly | `GlobalAntipodal.lean` proves factorization of every positive half-dimension, the factored theorem, both H+H and 2H universal interfaces, the public coefficient interface, and the homogeneous cubic corollary. |
| G5: polynomial transport needed in assembly | Canonical degree≤3 is converted to `HasCubicRepresentation`; linear substitutions preserve that interface. No additional degree assumption is introduced for the restriction. |

## Auxiliary task not claimed complete

**G3: the standalone equality of canonical antipodal coefficients under arbitrary odd folding**, for all RS degree≤3 functions whether bent or not, has not been separately formalized. It remains supported by the manuscript's orbit-counting proof and the exact computational checks. The universal kernel theorem does not depend on it: the zero-coefficient/constant-diagonal obstruction is transported directly instead. This is a proof-route change, not a hidden assumption or a counterexample to G3.

Also not claimed: equivalence of `HasCubicRepresentation` and the canonical degree bound in both directions. The direction needed for the universal theorem is proved; restricted polynomial degree is handled constructively through linear substitution.

## Non-proof publication tasks

The source-commit clean CI must be confirmed and recorded in KERNEL_CERTIFICATE.md. Independent full literature-priority review and manuscript revision around the shorter formal route remain editorial/research tasks, not Lean proof gaps. No acceptance/priority claim is made.
