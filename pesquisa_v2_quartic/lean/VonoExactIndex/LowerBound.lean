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

theorem selectedDirectionMap_injective
    (e : ∀ i, W i) (hne : ∀ i, e i ≠ 0) :
    Function.Injective (selectedDirectionMap e) := by
  intro α β h
  funext i
  have hi := congrFun h i
  by_contra hab
  have hαβ : α i + β i = 1 := by
    fin_cases hα : α i <;> fin_cases hβ : β i
    all_goals simp_all
  have hz : (α i + β i) • e i = 0 := by
    rw [add_smul]
    simpa [hi]
  rw [hαβ, one_smul] at hz
  exact hne i hz

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
  rw [LinearMap.finrank_range_of_injective _ hinj]
  simp

end VonoExactIndex
