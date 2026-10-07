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
  classical
  apply (_root_.finrank_le_one_iff (K := ZMod 2) (V := S)).2
  by_cases hex : ∃ v : S, v ≠ 0
  · obtain ⟨v, hv⟩ := hex
    refine ⟨v, ?_⟩
    intro w
    by_cases hw : w = 0
    · refine ⟨0, ?_⟩
      simpa only [zero_smul] using hw.symm
    by_cases hwv : w = v
    · refine ⟨1, ?_⟩
      simpa only [one_smul] using hwv.symm
    exfalso
    have hw0 : (w : SeedVec) ≠ 0 := by
      intro h
      exact hw (Subtype.ext h)
    have hv0 : (v : SeedVec) ≠ 0 := by
      intro h
      exact hv (Subtype.ext h)
    have hwv0 : (w : SeedVec) ≠ (v : SeedVec) := by
      intro h
      exact hwv (Subtype.ext h)
    have hc : IsConstant
        (diff (w : SeedVec) (diff (v : SeedVec) seed)) := by
      exact hS w.1 w.property v.1 v.property
    exact seed_no_independent_constant_pair_prop
      (w : SeedVec) (v : SeedVec) hw0 hv0 hwv0 hc
  · refine ⟨0, ?_⟩
    intro w
    have hw : w = 0 := by
      by_contra h
      exact hex ⟨w, h⟩
    refine ⟨0, ?_⟩
    simpa only [zero_smul] using hw.symm

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


/-- Direct index statement for every finite repeated block sum of the explicit Seed8 seed. -/
theorem seed8_has_exact_indices
    {ι : Type*} [Fintype ι] [DecidableEq ι]
    (e0 : SeedVec) (he0 : e0 ≠ 0) :
    HasMIndex (blockSum (fun _ : ι => seed)) (Fintype.card ι) ∧
    HasRelaxedMIndex (blockSum (fun _ : ι => seed)) (Fintype.card ι) := by
  exact exact_block_has_indices
    (f := fun _ : ι => seed)
    (hseed := fun _ S hS => seed_relaxed_finrank_le_one S hS)
    (e := fun _ : ι => e0)
    (hne := fun _ => he0)

end VonoExactIndex
