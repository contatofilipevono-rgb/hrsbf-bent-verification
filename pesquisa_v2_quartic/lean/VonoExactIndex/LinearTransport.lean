import VonoExactIndex.ExactIndex

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
  change diff a (diff b (f ∘ e.toLinearMap)) = 0
  rw [secondDiff_comp_linear e.toLinearMap a b f]
  have hzero := hS (e a) hea (e b) heb
  change (diff (e a) (diff (e b) f)) ∘ e.toLinearMap = 0
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
  change diff a (diff b (f ∘ e.toLinearMap)) = fun _ => c
  rw [secondDiff_comp_linear e.toLinearMap a b f]
  change (diff (e a) (diff (e b) f)) ∘ e.toLinearMap = fun _ => c
  rw [hc]
  rfl


/-- The forward image of an M-subspace under a coordinate equivalence is an M-subspace. -/
theorem IsMSubspace.map_linearEquiv
    (e : V ≃ₗ[ZMod 2] W) (f : W → ZMod 2)
    (S : Submodule (ZMod 2) V)
    (hS : IsMSubspace (f ∘ e) S) :
    IsMSubspace f (S.map e.toLinearMap) := by
  intro a ha b hb
  rcases ha with ⟨a, ha, rfl⟩
  rcases hb with ⟨b, hb, rfl⟩
  have h := hS a ha b hb
  have htransport := secondDiff_comp_linear e.toLinearMap a b f
  change diff a (diff b (f ∘ e.toLinearMap)) = 0 at h
  rw [h] at htransport
  funext y
  have hy := congrFun htransport (e.symm y)
  simpa using hy.symm

/-- The forward image of a relaxed M-subspace remains relaxed. -/
theorem IsRelaxedMSubspace.map_linearEquiv
    (e : V ≃ₗ[ZMod 2] W) (f : W → ZMod 2)
    (S : Submodule (ZMod 2) V)
    (hS : IsRelaxedMSubspace (f ∘ e) S) :
    IsRelaxedMSubspace f (S.map e.toLinearMap) := by
  intro a ha b hb
  rcases ha with ⟨a, ha, rfl⟩
  rcases hb with ⟨b, hb, rfl⟩
  rcases hS a ha b hb with ⟨c, hc⟩
  refine ⟨c, ?_⟩
  funext y
  have htransport := secondDiff_comp_linear e.toLinearMap a b f
  change diff a (diff b (f ∘ e.toLinearMap)) = fun _ => c at hc
  rw [hc] at htransport
  have hy := congrFun htransport (e.symm y)
  simpa using hy.symm


/-- Exact ordinary M-index is invariant under an invertible linear change of variables. -/
theorem HasMIndex.comp_linearEquiv
    (e : V ≃ₗ[ZMod 2] W) (f : W → ZMod 2) (d : Nat)
    (hf : HasMIndex f d) :
    HasMIndex (f ∘ e) d := by
  rcases hf with ⟨hupper, S, hS, hdim⟩
  constructor
  · intro T hT
    have hmap := IsMSubspace.map_linearEquiv e f T hT
    have hle := hupper (T.map e.toLinearMap) hmap
    rwa [e.finrank_map_eq] at hle
  · refine ⟨S.comap e.toLinearMap, IsMSubspace.comap_linearEquiv e f S hS, ?_⟩
    have hcomap : (S.comap e.toLinearMap).map e.toLinearMap = S := by
      ext y
      constructor
      · rintro ⟨x, hx, rfl⟩
        exact hx
      · intro hy
        exact ⟨e.symm y, by simpa using hy, by simp⟩
    rw [← hcomap, e.finrank_map_eq] at hdim
    exact hdim

/-- Exact relaxed M-index is invariant under an invertible linear change of variables. -/
theorem HasRelaxedMIndex.comp_linearEquiv
    (e : V ≃ₗ[ZMod 2] W) (f : W → ZMod 2) (d : Nat)
    (hf : HasRelaxedMIndex f d) :
    HasRelaxedMIndex (f ∘ e) d := by
  rcases hf with ⟨hupper, S, hS, hdim⟩
  constructor
  · intro T hT
    have hmap := IsRelaxedMSubspace.map_linearEquiv e f T hT
    have hle := hupper (T.map e.toLinearMap) hmap
    rwa [e.finrank_map_eq] at hle
  · refine ⟨S.comap e.toLinearMap, IsRelaxedMSubspace.comap_linearEquiv e f S hS, ?_⟩
    have hcomap : (S.comap e.toLinearMap).map e.toLinearMap = S := by
      ext y
      constructor
      · rintro ⟨x, hx, rfl⟩
        exact hx
      · intro hy
        exact ⟨e.symm y, by simpa using hy, by simp⟩
    rw [← hcomap, e.finrank_map_eq] at hdim
    exact hdim

end VonoExactIndex
