import VonoExactIndex.ExactIndex
import Mathlib.LinearAlgebra.Dimension.FreeAndStrongRankCondition
import Mathlib.LinearAlgebra.FiniteDimensional.Basic

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
  let v := diff a (diff b seed) 0
  decide (∀ x : SeedVec, diff a (diff b seed) x = v)

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


/-- Propositional form of the exhaustive Seed8 obstruction. -/
theorem seed_no_independent_constant_pair_prop
    (a b : SeedVec)
    (ha : a ≠ 0) (hb : b ≠ 0) (hab : a ≠ b) :
    ¬ IsConstant (diff a (diff b seed)) := by
  have hcert :
      ∀ a b : SeedVec,
        a ≠ 0 → b ≠ 0 → a ≠ b →
        secondDerivativeConstant a b = false := by
    apply of_decide_eq_true
    exact seed_no_independent_constant_pair
  intro hconstant
  rcases hconstant with ⟨c, hc⟩
  have htrue : secondDerivativeConstant a b = true := by
    change decide (∀ x : SeedVec,
      diff a (diff b seed) x = diff a (diff b seed) 0) = true
    apply decide_eq_true
    intro x
    exact (congrFun hc x).trans (congrFun hc 0).symm
  have hfalse : secondDerivativeConstant a b = false :=
    hcert a b ha hb hab
  have hcontr : (false : Bool) = true := hfalse.symm.trans htrue
  cases hcontr

/-- The exhaustive Seed8 obstruction closes the relaxed-index hypothesis. -/
theorem seed_relaxed_finrank_le_one
    (S : Submodule (ZMod 2) SeedVec)
    (hS : IsRelaxedMSubspace seed S) :
    Module.finrank (ZMod 2) S ≤ 1 := by
  rw [Module.finrank_le_one_iff]
  rcases eq_or_ne S ⊥ with hbot | hbot
  · subst S
    refine ⟨0, ?_⟩
    intro w
    exact ⟨0, by simp⟩
  · obtain ⟨v, hvS, hv0⟩ := Submodule.exists_mem_ne_zero_of_ne_bot hbot
    refine ⟨⟨v, hvS⟩, ?_⟩
    intro w
    by_cases hw0 : w.1 = 0
    · exact ⟨0, by ext; simp [hw0]⟩
    · by_cases hwv : w.1 = v
      · exact ⟨1, by ext; simp [hwv]⟩
      · exfalso
        have hc := hS v hvS w.1 w.2
        exact seed_no_independent_constant_pair_prop v w.1 hv0 hw0 hwv hc

/-- Fully closed repeated-block certificate for the explicit eight-variable seed. -/
theorem seed8_exact_repeated_block_index_certificate
    {ι : Type*} [Fintype ι] [DecidableEq ι]
    (e0 : SeedVec) (he0 : e0 ≠ 0) :
    (∀ U : Submodule (ZMod 2) (ι → SeedVec),
        IsRelaxedMSubspace (blockSum (fun _ : ι => seed)) U →
        Module.finrank (ZMod 2) U ≤ Fintype.card ι)
    ∧
    (∃ M : Submodule (ZMod 2) (ι → SeedVec),
        IsMSubspace (blockSum (fun _ : ι => seed)) M ∧
        Module.finrank (ZMod 2) M = Fintype.card ι) := by
  exact exact_repeated_block_index_certificate
    (f := seed)
    (hseed := seed_relaxed_finrank_le_one)
    e0 he0

end VonoExactIndex
