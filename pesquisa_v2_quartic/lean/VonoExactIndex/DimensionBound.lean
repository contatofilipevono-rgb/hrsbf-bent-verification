import VonoExactIndex.MSubspace

namespace VonoExactIndex

variable {ι : Type*} [Fintype ι] [DecidableEq ι]
variable {W : ι → Type*}
variable [∀ i, AddCommGroup (W i)] [∀ i, Module (ZMod 2) (W i)]
variable [∀ i, FiniteDimensional (ZMod 2) (W i)]

/--
The inclusion of a submodule of a product into the product of its coordinate
images is injective. This is the linear-algebra core of the block upper bound.
-/
def projectionRangeMap
    (U : Submodule (ZMod 2) (BlockVec (ι := ι) (W := W))) :
    U →ₗ[ZMod 2] (∀ i, U.map (LinearMap.proj i)) where
  toFun := fun u i => ⟨u.1 i, ⟨u, u.2, rfl⟩⟩
  map_add' := by
    intro x y
    ext i
    rfl
  map_smul' := by
    intro c x
    ext i
    rfl

theorem projectionRangeMap_injective
    (U : Submodule (ZMod 2) (BlockVec (ι := ι) (W := W))) :
    Function.Injective (projectionRangeMap U) := by
  intro x y h
  apply Subtype.ext
  funext i
  exact congrArg (fun z => (z i).1) h

/--
Dimension bound from coordinate images. No relaxed-M hypothesis is needed
for this purely linear statement.
-/
theorem finrank_le_sum_projection_finrank
    (U : Submodule (ZMod 2) (BlockVec (ι := ι) (W := W))) :
    Module.finrank (ZMod 2) U ≤
      ∑ i, Module.finrank (ZMod 2) (U.map (LinearMap.proj i)) := by
  have hinj := projectionRangeMap_injective U
  have hle :
      Module.finrank (ZMod 2) U ≤
        Module.finrank (ZMod 2) (∀ i, U.map (LinearMap.proj i)) :=
    LinearMap.finrank_le_finrank_of_injective hinj
  calc
    Module.finrank (ZMod 2) U
        ≤ Module.finrank (ZMod 2) (∀ i, U.map (LinearMap.proj i)) := hle
    _ = ∑ i, Module.finrank (ZMod 2) (U.map (LinearMap.proj i)) :=
      Module.finrank_pi_fintype (ZMod 2)

/--
Abstract upper bound for a relaxed M-subspace of a disjoint block sum when
every relaxed subspace of each block has dimension at most one.
-/
theorem relaxed_block_finrank_le_card
    (f : ∀ i, W i → ZMod 2)
    (U : Submodule (ZMod 2) (BlockVec (ι := ι) (W := W)))
    (hU : IsRelaxedMSubspace (blockSum f) U)
    (hseed : ∀ i (S : Submodule (ZMod 2) (W i)),
      IsRelaxedMSubspace (f i) S → Module.finrank (ZMod 2) S ≤ 1) :
    Module.finrank (ZMod 2) U ≤ Fintype.card ι := by
  calc
    Module.finrank (ZMod 2) U
        ≤ ∑ i, Module.finrank (ZMod 2) (U.map (LinearMap.proj i)) :=
          finrank_le_sum_projection_finrank U
    _ ≤ ∑ _i : ι, 1 := by
          apply Finset.sum_le_sum
          intro i hi
          exact hseed i _ (relaxed_projection f U hU i)
    _ = Fintype.card ι := by simp

end VonoExactIndex
