import VonoExactIndex.ExactIndex

namespace VonoExactIndex

abbrev SeedVec := Fin 8 → ZMod 2

def bit (x : SeedVec) (i : Nat) : ZMod 2 := x ⟨i % 8, by omega⟩
def monomial (idx : List Nat) (x : SeedVec) : ZMod 2 :=
  idx.foldl (fun acc i => acc * bit x i) 1
def rotateRep (rep : List Nat) (s : Nat) : List Nat :=
  rep.map (fun i => (i + s) % 8)
def orbitValue (rep : List Nat) (x : SeedVec) : ZMod 2 :=
  ∑ s : Fin 8, monomial (rotateRep rep s) x

/-- The eight-variable quartic rotation-symmetric seed used in V2. -/
def seed : SeedVec → ZMod 2 := fun x =>
  orbitValue [0,1] x +
  orbitValue [0,1,2,3] x +
  orbitValue [0,1,2,5] x +
  orbitValue [0,1,3,5] x

def secondDerivativeConstant (a b : SeedVec) : Bool :=
  let v := D[a] (D[b] seed) 0
  decide (∀ x : SeedVec, D[a] (D[b] seed) x = v)

/-- Complete finite obstruction for the seed. -/
def seedNoIndependentConstantPair : Bool :=
  decide (∀ a b : SeedVec,
    a ≠ 0 → b ≠ 0 → a ≠ b →
    secondDerivativeConstant a b = false)

/--
When compiled, native_decide checks the complete finite statement: every
distinct nonzero direction pair and every input point.
-/
theorem seed_no_independent_constant_pair :
    seedNoIndependentConstantPair = true := by
  native_decide

end VonoExactIndex
