import Antipodal.Fourier

/-!
A finite, kernel-reducible endpoint of the global antipodal argument.
This proves the two-variable case only; the global result remains open in Lean.
No sorry, admit, native_decide or nonstandard axioms.
-/

set_option maxRecDepth 4096
set_option maxHeartbeats 4000000

namespace HRSBF.Antipodal

def leftUnit2 : PairSpace 1 := (fun _ => 1, fun _ => 0)
def rightUnit2 : PairSpace 1 := (fun _ => 0, fun _ => 1)

/-- Coefficient of x₀*x₁ by normalized polar differentiation. -/
def antipodalCoeff2 (f : PairSpace 1 → F₂) : F₂ :=
  polar f leftUnit2 rightUnit2

/-- All 16 truth tables on F₂², checked by kernel evaluation. -/
theorem bent_iff_antipodal_in_two_variables :
    ∀ f : PairSpace 1 → F₂, IsBentPair f ↔ antipodalCoeff2 f = 1 := by
  intro f
  fin_cases f <;> decide

theorem bent_implies_antipodal_in_two_variables
    (f : PairSpace 1 → F₂) (hb : IsBentPair f) :
    antipodalCoeff2 f = 1 :=
  (bent_iff_antipodal_in_two_variables f).mp hb

end HRSBF.Antipodal

#print axioms HRSBF.Antipodal.bent_iff_antipodal_in_two_variables
#print axioms HRSBF.Antipodal.bent_implies_antipodal_in_two_variables
