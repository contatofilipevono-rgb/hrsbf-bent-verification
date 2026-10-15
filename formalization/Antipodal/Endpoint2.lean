import Antipodal.Fourier

/-!
Definitions for the n=2 endpoint of the global theorem.
STATUS: the equivalence between bentness and antipodalCoeff2 = 1 has not
been proved by the Lean kernel. It is intentionally NOT declared as a theorem.
No sorry, admit, or additional axioms are introduced.
-/

namespace HRSBF.Antipodal

def leftUnit2 : PairSpace 1 := (fun _ => 1, fun _ => 0)
def rightUnit2 : PairSpace 1 := (fun _ => 0, fun _ => 1)

/-- Normalized polar coefficient of the unique mixed quadratic monomial. -/
def antipodalCoeff2 (f : PairSpace 1 → F₂) : F₂ :=
  polar f leftUnit2 rightUnit2

-- Still to prove:
-- ∀ f : PairSpace 1 → F₂, IsBentPair f ↔ antipodalCoeff2 f = 1

end HRSBF.Antipodal

#check HRSBF.Antipodal.antipodalCoeff2
