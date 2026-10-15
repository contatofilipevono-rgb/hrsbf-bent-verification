import Antipodal.Fourier

/-!
A finite, *kernel-reducible* endpoint of the global antipodal argument.
The two-variable case is valid without assuming rotation invariance
or a polynomial degree bound, since any function on F₂² has degree ≤ 2.

No sorry, admit, native_decide, or new axioms.
This is intentionally NOT a statement of the global conjecture.
-/

namespace HRSBF.Antipodal

def leftUnit2 : PairSpace 1 := (fun _ => 1, fun _ => 0)
def rightUnit2 : PairSpace 1 := (fun _ => 0, fun _ => 1)

/-- The coefficient of x₀*x₁ in the two-variable ANF, extracted by
the normalized polar identity (independent of affine terms). -/
def antipodalCoeff2 (f : PairSpace 1 → F₂) : F₂ :=
  polar f leftUnit2 rightUnit2

/-- Exhaustive *kernel* proof for all 16 Boolean functions of two variables.
This verifies the t=2 endpoint in the ordinary algebraic proof. -/
theorem bent_iff_antipodal_in_two_variables :
    ∀ f : PairSpace 1 → F₂, IsBentPair f ↔ antipodalCoeff2 f = 1 := by
  decide

theorem bent_implies_antipodal_in_two_variables
    (f : PairSpace 1 → F₂) (hb : IsBentPair f) :
    antipodalCoeff2 f = 1 :=
  (bent_iff_antipodal_in_two_variables f).mp hb

end HRSBF.Antipodal

#print axioms HRSBF.Antipodal.bent_iff_antipodal_in_two_variables
#print axioms HRSBF.Antipodal.bent_implies_antipodal_in_two_variables
