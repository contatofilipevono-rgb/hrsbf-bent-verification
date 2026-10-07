import VonoExactIndex.FiniteDifference

namespace VonoExactIndex

open Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]
variable {W : ι → Type*}
variable [∀ i, AddCommGroup (W i)] [∀ i, Module (ZMod 2) (W i)]

abbrev BlockVec (ι : Type*) (W : ι → Type*) := ∀ i, W i

def blockSum (f : ∀ i, W i → ZMod 2) :
    BlockVec ι W → ZMod 2 :=
  fun x => ∑ i, f i (x i)

theorem secondDiff_blockSum
    (f : ∀ i, W i → ZMod 2)
    (a b x : BlockVec ι W) :
    diff a (diff b (blockSum f)) x =
      ∑ i, diff (a i) (diff (b i) (f i)) (x i) := by
  simp [diff, blockSum, sum_add_distrib, add_assoc, add_comm, add_left_comm]

lemma zmod2_smul_eq_zero_or_self
    {A : Type*} [AddCommGroup A] [Module (ZMod 2) A]
    (c : ZMod 2) (v : A) :
    c • v = 0 ∨ c • v = v := by
  have hlt : c.val < 2 := by
    exact ZMod.val_lt c
  have hv : c.val = 0 ∨ c.val = 1 := by
    omega
  rcases hv with hv | hv
  · left
    have hc : c = 0 := by
      apply ZMod.val_injective
      simp [hv]
    simp [hc]
  · right
    have hc : c = 1 := by
      apply ZMod.val_injective
      rw [hv]
      norm_num
    simp [hc]

lemma secondDiff_same_line_zero
    {A : Type*} [AddCommGroup A] [Module (ZMod 2) A]
    (f : A → ZMod 2) (e : A) (α β : ZMod 2) (x : A) :
    diff (α • e) (diff (β • e) f) x = 0 := by
  rcases zmod2_smul_eq_zero_or_self α e with hα | hα
  · rw [hα]
    simp
  rcases zmod2_smul_eq_zero_or_self β e with hβ | hβ
  · rw [hβ]
    rw [diff_zero]
    simp [diff]
  · rw [hα, hβ]
    simpa using congrFun (diff_self e f) x

theorem selectedDirections_secondDiff_zero
    (f : ∀ i, W i → ZMod 2)
    (e : ∀ i, W i)
    (α β : ι → ZMod 2)
    (x : BlockVec ι W) :
    diff (fun i => α i • e i)
      (diff (fun i => β i • e i) (blockSum f)) x = 0 := by
  rw [secondDiff_blockSum]
  apply Finset.sum_eq_zero
  intro i hi
  exact secondDiff_same_line_zero (f i) (e i) (α i) (β i) (x i)

end VonoExactIndex
