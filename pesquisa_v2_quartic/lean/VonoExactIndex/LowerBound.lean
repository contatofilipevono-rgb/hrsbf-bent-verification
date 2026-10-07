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
  have hi : α i • e i = β i • e i := congrFun h i
  by_contra hab
  have hsum_ne : α i + β i ≠ 0 := by
    intro hz
    have : α i = β i := by
      have := congrArg (fun z => z + β i) hz
      simpa [add_assoc] using this
    exact hab this
  have hsum_self : (α i + β i) • e i = e i := by
    rcases zmod2_smul_eq_zero_or_self (α i + β i) (e i) with hz | hz
    · exfalso
      apply hsum_ne
      have he : e i ≠ 0 := hne i
      apply smul_left_cancel₀ (R := ZMod 2) he
      simpa using hz
    · exact hz
  have hz : (α i + β i) • e i = 0 := by
    rw [add_smul]
    have hchar (z : W i) : z + z = 0 := by
      have htwo : (1 : ZMod 2) + 1 = 0 := add_self_zmod2 1
      calc
        z + z = (1 : ZMod 2) • z + (1 : ZMod 2) • z := by simp
        _ = ((1 : ZMod 2) + 1) • z := by rw [add_smul]
        _ = 0 := by rw [htwo, zero_smul]
    rw [hi]
    exact hchar (β i • e i)
  rw [hsum_self] at hz
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
  have hrange := LinearMap.finrank_range_of_inj hinj
  calc
    Module.finrank (ZMod 2) (LinearMap.range (selectedDirectionMap e))
        = Module.finrank (ZMod 2) (ι → ZMod 2) := hrange
    _ = Fintype.card ι := Module.finrank_pi

end VonoExactIndex
