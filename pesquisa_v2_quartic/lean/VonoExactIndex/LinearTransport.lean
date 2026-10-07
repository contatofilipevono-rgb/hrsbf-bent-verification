import VonoExactIndex.MSubspace

namespace VonoExactIndex

variable {V W : Type*}
variable [AddCommGroup V] [Module (ZMod 2) V]
variable [AddCommGroup W] [Module (ZMod 2) W]

/-- Finite differences commute with a linear change of coordinates. -/
theorem diff_comp_linear
    (e : V →ₗ[ZMod 2] W) (a : V) (f : W → ZMod 2) :
    diff a (f ∘ e) = (diff (e a) f) ∘ e := by
  funext x
  simp [diff, e.map_add]

/-- Second finite differences commute with a linear change of coordinates. -/
theorem secondDiff_comp_linear
    (e : V →ₗ[ZMod 2] W) (a b : V) (f : W → ZMod 2) :
    diff a (diff b (f ∘ e)) =
      (diff (e a) (diff (e b) f)) ∘ e := by
  rw [diff_comp_linear e b f]
  exact diff_comp_linear e a (diff (e b) f)

/-- Pulling back an M-subspace along a linear equivalence preserves the M property. -/
theorem IsMSubspace.comap_linearEquiv
    (e : V ≃ₗ[ZMod 2] W) (f : W → ZMod 2)
    (S : Submodule (ZMod 2) W)
    (hS : IsMSubspace f S) :
    IsMSubspace (f ∘ e) (S.comap e.toLinearMap) := by
  intro a ha b hb
  have hea : e a ∈ S := ha
  have heb : e b ∈ S := hb
  rw [secondDiff_comp_linear e.toLinearMap a b f]
  have hzero := hS (e a) hea (e b) heb
  rw [hzero]
  rfl

/-- Pulling back a relaxed M-subspace along a linear equivalence preserves relaxedness. -/
theorem IsRelaxedMSubspace.comap_linearEquiv
    (e : V ≃ₗ[ZMod 2] W) (f : W → ZMod 2)
    (S : Submodule (ZMod 2) W)
    (hS : IsRelaxedMSubspace f S) :
    IsRelaxedMSubspace (f ∘ e) (S.comap e.toLinearMap) := by
  intro a ha b hb
  have hea : e a ∈ S := ha
  have heb : e b ∈ S := hb
  rcases hS (e a) hea (e b) heb with ⟨c, hc⟩
  refine ⟨c, ?_⟩
  rw [secondDiff_comp_linear e.toLinearMap a b f, hc]
  rfl

end VonoExactIndex
