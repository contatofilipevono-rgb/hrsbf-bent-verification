import VonoExactIndex.DimensionBound

namespace VonoExactIndex

variable {ι : Type*} [Fintype ι] [DecidableEq ι]
variable {W : ι → Type*}
variable [∀ i, AddCommGroup (W i)] [∀ i, Module (ZMod 2) (W i)]
variable [∀ i, FiniteDimensional (ZMod 2) (W i)]

/-- Linear map selecting one prescribed direction in each block. -/
def selectedDirectionMap (e : ∀ i, W i) :
    (ι → ZMod 2) →ₗ[ZMod 2] BlockVec (ι := ι) (W := W) where
  toFun := fun α i => α i • e i
  map_add' := by
    intro α β
    funext i
    simp [add_smul]
  map_smul' := by
    intro c α
    funext i
    simp [mul_smul]

lemma zmod2_eq_zero_or_one (c : ZMod 2) : c = 0 ∨ c = 1 := by
  have hlt : c.val < 2 := ZMod.val_lt c
  have hv : c.val = 0 ∨ c.val = 1 := by
    omega
  rcases hv with hv | hv
  · left
    calc
      c = (c.val : ZMod 2) := (ZMod.natCast_zmod_val c).symm
      _ = 0 := by rw [hv]; norm_num
  · right
    calc
      c = (c.val : ZMod 2) := (ZMod.natCast_zmod_val c).symm
      _ = 1 := by rw [hv]; norm_num

theorem selectedDirectionMap_injective
    (e : ∀ i, W i) (hne : ∀ i, e i ≠ 0) :
    Function.Injective (selectedDirectionMap e) := by
  intro α β h
  funext i
  have hi : α i • e i = β i • e i := congrFun h i
  rcases zmod2_eq_zero_or_one (α i) with hα | hα <;>
    rcases zmod2_eq_zero_or_one (β i) with hβ | hβ
  · simp [hα, hβ]
  · exfalso
    apply hne i
    simpa [hα, hβ] using hi.symm
  · exfalso
    apply hne i
    simpa [hα, hβ] using hi
  · simp [hα, hβ]

/-- The selected-direction image is an ordinary M-subspace of a block sum. -/
theorem selectedDirectionRange_isM
    (f : ∀ i, W i → ZMod 2)
    (e : ∀ i, W i) :
    IsMSubspace (blockSum f) (LinearMap.range (selectedDirectionMap e)) := by
  intro a ha b hb
  rcases ha with ⟨α, rfl⟩
  rcases hb with ⟨β, rfl⟩
  funext x
  exact selectedDirections_secondDiff_zero f e α β x

/--
With a nonzero selected direction in every block, the explicit M-subspace has
one dimension per block.
-/
theorem selectedDirectionRange_finrank
    (e : ∀ i, W i) (hne : ∀ i, e i ≠ 0) :
    Module.finrank (ZMod 2) (LinearMap.range (selectedDirectionMap e)) =
      Fintype.card ι := by
  have hinj := selectedDirectionMap_injective e hne
  have hrange := LinearMap.finrank_range_of_inj hinj
  calc
    Module.finrank (ZMod 2) (LinearMap.range (selectedDirectionMap e))
        = Module.finrank (ZMod 2) (ι → ZMod 2) := hrange
    _ = Fintype.card ι := Module.finrank_pi (ZMod 2)

end VonoExactIndex
