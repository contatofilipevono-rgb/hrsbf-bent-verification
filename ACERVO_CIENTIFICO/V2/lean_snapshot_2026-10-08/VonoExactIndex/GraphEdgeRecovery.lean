import VonoExactIndex.GraphBlockRecovery

namespace VonoExactIndex.GraphFamily
variable {ι : Type*} [Fintype ι] [DecidableEq ι]

private theorem cubic_third_axis_zero : ∀ (s t : ZMod 2) (c x : CubicVec),
    diff ![0,0,s] (diff ![0,0,t] (diff c cubic)) x = 0 := by native_decide

private theorem coupling_single (adj : ι → ι → Bool) (k i : ι) (v : SeedVec) :
    couplingLinear adj k (Pi.single i v) =
      ![if k = i then v 0 else 0, if k = i then v 1 else 0,
        if adj k i then v 0 else 0] := by
  funext p
  fin_cases p
  · by_cases hki : k = i <;> simp [couplingLinear, Pi.single_apply, hki]
  · by_cases hki : k = i <;> simp [couplingLinear, Pi.single_apply, hki]
  · change (∑ j, if adj k j then (Pi.single i v : Input ι) j 0 else 0) = _
    rw [Finset.sum_eq_single i]
    · simp
    · intro j hj hji
      simp [Pi.single_apply, hji]
    · simp

/-- Nonedges annihilate every mixed third difference, at every base point. -/
theorem mixed_third_nonedge (adj : ι → ι → Bool) (i j : ι) (hij : i ≠ j)
    (hedge : adj i j = false) (v w z : SeedVec) (x : Input ι) :
    iterDiff [Pi.single i v, Pi.single i w, Pi.single j z] (graphMap adj) x = 0 := by
  funext k
  change diff (Pi.single i v) (diff (Pi.single i w) (diff (Pi.single j z)
    (fun y => (seed ∘ (LinearMap.proj k : Input ι →ₗ[ZMod 2] SeedVec)) y +
      (cubic ∘ couplingLinear adj k) y))) x = 0
  simp only [diff_add]
  rw [thirdDiff_comp_linear, thirdDiff_comp_linear]
  simp only [Function.comp_apply]
  by_cases hki : k = i
  · subst k
    have hz : (LinearMap.proj i : Input ι →ₗ[ZMod 2] SeedVec) (Pi.single j z) = 0 := by
      simp [Pi.single_apply, hij]
    have hc0 : couplingLinear adj i (Pi.single j z) = 0 := by
      rw [coupling_single]
      funext p
      fin_cases p <;> simp [hij, hedge]
    rw [hz, diff_zero, hc0, diff_zero]
    simp [diff]
  · have hv : (LinearMap.proj k : Input ι →ₗ[ZMod 2] SeedVec) (Pi.single i v) = 0 := by
      simp [Pi.single_apply, hki]
    rw [hv, diff_zero, coupling_single adj k i v, coupling_single adj k i w]
    simp only [if_neg hki]
    rw [cubic_third_axis_zero]
    rfl

def EdgeDetected (adj : ι → ι → Bool) (i j : ι) : Prop :=
  ∃ v w z : SeedVec, ∃ x : Input ι,
    iterDiff [Pi.single i v, Pi.single i w, Pi.single j z] (graphMap adj) x ≠ 0

theorem edge_detected_iff (adj : ι → ι → Bool) (i j : ι) (hij : i ≠ j) :
    EdgeDetected adj i j ↔ adj i j = true := by
  constructor
  · rintro ⟨v,w,z,x,h⟩
    cases he : adj i j
    · exact False.elim (h (mixed_third_nonedge adj i j hij he v w z x))
    · rfl
  · intro he
    refine ⟨unitSeed 1, unitSeed 0, unitSeed 0, 0, ?_⟩
    intro hz
    have hh := congrFun hz i
    have hm := mixed_third_edge adj i j hij
    change diff (blockUnit i 1) (diff (blockUnit i 0) (diff (blockUnit j 0)
      (component adj i))) 0 = 0 at hh
    rw [hm] at hh
    simpa [he] using hh

/-- Mixed derivatives recover directed edges once the intrinsic blocks are recovered. -/
theorem representation_edges (adjG adjH : ι → ι → Bool)
    (A : Input ι ≃ₗ[ZMod 2] Input ι) (B : Output ι ≃ₗ[ZMod 2] Output ι)
    (t : Input ι) (Q : Input ι → Output ι) (hQ : HasConstantSecondDifferences Q)
    (he : ∀ x, graphMap adjH x = B (graphMap adjG (A x + t)) + Q x)
    (p : ι ≃ ι) (e : ι → SeedVec ≃ₗ[ZMod 2] SeedVec)
    (hblock : ∀ i v, A (Pi.single i v) = Pi.single (p i) (e i v))
    (i j : ι) (hij : i ≠ j) : adjH i j = adjG (p i) (p j) := by
  have hdetect : EdgeDetected adjH i j ↔ EdgeDetected adjG (p i) (p j) := by
    constructor
    · rintro ⟨v,w,z,x,h⟩
      refine ⟨e i v, e i w, e j z, A x + t, ?_⟩
      intro hz
      apply h
      rw [representation_third _ _ _ A B t hQ he, hblock, hblock, hblock, hz]
      exact B.map_zero
    · rintro ⟨v,w,z,x,h⟩
      refine ⟨(e i).symm v, (e i).symm w, (e j).symm z, A.symm (x - t), ?_⟩
      intro hz
      have hh := representation_third _ _ _ A B t hQ he
        (Pi.single i ((e i).symm v)) (Pi.single i ((e i).symm w))
        (Pi.single j ((e j).symm z)) (A.symm (x - t))
      rw [hblock, hblock, hblock] at hh
      simp only [LinearEquiv.apply_symm_apply, sub_add_cancel] at hh
      rw [hz] at hh
      apply h
      apply B.injective
      simpa using hh.symm
  rw [edge_detected_iff adjH i j hij,
    edge_detected_iff adjG (p i) (p j) (fun h => hij (p.injective h))] at hdetect
  cases hH : adjH i j <;> cases hG : adjG (p i) (p j) <;> simp_all

end VonoExactIndex.GraphFamily
