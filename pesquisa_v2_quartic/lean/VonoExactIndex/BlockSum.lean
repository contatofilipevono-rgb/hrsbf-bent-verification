import VonoExactIndex.FiniteDifference

namespace VonoExactIndex

open Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]
variable {W : ι → Type*}
variable [∀ i, AddCommGroup (W i)] [∀ i, Module (ZMod 2) (W i)]

abbrev BlockVec := ∀ i, W i

/-- A Boolean function that is a sum of functions on disjoint blocks. -/
def blockSum (f : ∀ i, W i → ZMod 2) : BlockVec → ZMod 2 :=
  fun x => ∑ i, f i (x i)

/-- Exact block decomposition of a second finite difference. -/
theorem secondDiff_blockSum (f : ∀ i, W i → ZMod 2) (a b x : BlockVec) :
    D[a] (D[b] (blockSum f)) x =
      ∑ i, D[a i] (D[b i] (f i)) (x i) := by
  simp [diff, blockSum, sum_add_distrib]
  congr 1
  funext i
  simp [diff, add_assoc, add_comm, add_left_comm]

/--
One chosen direction in each disjoint block gives an M-subspace:
for coefficient vectors alpha,beta over F_2, every block contribution is
either a zero-direction derivative or a repeated-direction derivative.
-/
theorem selectedDirections_secondDiff_zero
    (f : ∀ i, W i → ZMod 2)
    (e : ∀ i, W i)
    (α β : ι → ZMod 2)
    (x : BlockVec) :
    D[(fun i => α i • e i)] (D[(fun i => β i • e i)] (blockSum f)) x = 0 := by
  rw [secondDiff_blockSum]
  apply Finset.sum_eq_zero
  intro i hi
  fin_cases hα : α i <;> fin_cases hβ : β i
  all_goals simp [hα, hβ]

end VonoExactIndex
