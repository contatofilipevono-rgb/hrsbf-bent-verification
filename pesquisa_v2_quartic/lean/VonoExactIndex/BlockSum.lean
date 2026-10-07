import VonoExactIndex.FiniteDifference

namespace VonoExactIndex

open Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]
variable {W : ι → Type*}
variable [∀ i, AddCommGroup (W i)] [∀ i, Module (ZMod 2) (W i)]

abbrev BlockVec := ∀ i, W i

def blockSum (f : ∀ i, W i → ZMod 2) : BlockVec → ZMod 2 :=
  fun x => ∑ i, f i (x i)

theorem secondDiff_blockSum (f : ∀ i, W i → ZMod 2) (a b x : BlockVec) :
    diff a (diff b (blockSum f)) x =
      ∑ i, diff (a i) (diff (b i) (f i)) (x i) := by
  simp [diff, blockSum, sum_add_distrib, add_assoc, add_comm, add_left_comm]

theorem selectedDirections_secondDiff_zero
    (f : ∀ i, W i → ZMod 2)
    (e : ∀ i, W i)
    (α β : ι → ZMod 2)
    (x : BlockVec) :
    diff (fun i => α i • e i)
      (diff (fun i => β i • e i) (blockSum f)) x = 0 := by
  rw [secondDiff_blockSum]
  apply Finset.sum_eq_zero
  intro i hi
  fin_cases hα : α i <;> fin_cases hβ : β i
  all_goals simp [hα, hβ]

end VonoExactIndex
