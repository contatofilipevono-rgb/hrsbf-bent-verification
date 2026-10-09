import VonoV3C.GraphOutputRecovery

namespace VonoV3C.GraphFamily
variable {ι : Type*} [Fintype ι] [DecidableEq ι] {m : ℕ}

/-- Exact third polarization of the cubic coupling. -/
theorem cubic_third (a b c x : CubicVec) :
    diff a (diff b (diff c cubic)) x =
    a 0 * b 1 * c 2 + a 0 * c 1 * b 2 + b 0 * a 1 * c 2 +
    b 0 * c 1 * a 2 + c 0 * a 1 * b 2 + c 0 * b 1 * a 2 := by
  simp only [diff, cubic, Pi.add_apply]
  ring_nf (config := { recursive := false })
  simp only [show (2 : Scalar) = 0 from rfl, show (4 : Scalar) = 0 from rfl,
    show (8 : Scalar) = 0 from rfl, mul_zero, zero_mul, add_zero, zero_add]

theorem coupling_single (hm : 2 ≤ m) (adj : ι → ι → Bool) (k i : ι) (v : Vec m) :
    couplingLinear hm adj k (Pi.single i v) = fun l =>
      if l = 0 then (if k = i then p hm v else 0)
      else if l = 1 then (if k = i then q hm v else 0)
      else if adj k i then p hm v else 0 := by
  funext l
  by_cases h0 : l = 0
  · by_cases hki : k = i <;> simp [couplingLinear, h0, p, Pi.single_apply, hki]
  · by_cases h1 : l = 1
    · by_cases hki : k = i <;> simp [couplingLinear, h0, h1, q, Pi.single_apply, hki]
    · change (if l = 0 then _ else if l = 1 then _ else _) = _
      simp only [h0, h1, if_false]
      rw [Finset.sum_eq_single i]
      · simp
      · intro j hj hji
        simp [Pi.single_apply, hji, p]
      · simp

/-- Two directions in block i and one in block j detect i→j only.
Reverse arcs are unrestricted. The expression is constant in the base point. -/
theorem mixed_third (hm : 2 ≤ m) (adj : ι → ι → Bool) (i j : ι) (hij : i ≠ j)
    (v w z : Vec m) (x : Input ι m) :
    iterDiff [Pi.single i v, Pi.single i w, Pi.single j z] (graphMap hm adj) x =
    Pi.single i (if adj i j then
      (p hm v * q hm w + q hm v * p hm w) * p hm z else 0) := by
  funext k
  change diff (Pi.single i v) (diff (Pi.single i w) (diff (Pi.single j z)
    (fun y => (seed m ∘ (LinearMap.proj k : Input ι m →ₗ[Scalar] Vec m)) y +
      (cubic ∘ couplingLinear hm adj k) y))) x = _
  simp only [diff_add]
  rw [third_comp_linear, third_comp_linear]
  simp only [Function.comp_apply, LinearMap.proj_apply]
  by_cases hki : k = i
  · subst k
    have hz : (Pi.single j z : Input ι m) i = 0 := by
      simp [Pi.single_apply, hij]
    rw [hz, diff_zero]
    change (0 : Scalar) + diff (couplingLinear hm adj i (Pi.single i v))
      (diff (couplingLinear hm adj i (Pi.single i w))
        (diff (couplingLinear hm adj i (Pi.single j z)) cubic))
        (couplingLinear hm adj i x) = _
    rw [zero_add, cubic_third, coupling_single, coupling_single, coupling_single]
    cases he : adj i j <;>
      simp [hij, he, Pi.single_eq_same] <;> ring
  · have hv : (Pi.single i v : Input ι m) k = 0 := by
      simp [Pi.single_apply, hki]
    rw [hv, diff_zero]
    rw [cubic_third, coupling_single, coupling_single, coupling_single]
    simp [Pi.single_apply, hki]

def EdgeDetected (hm : 2 ≤ m) (adj : ι → ι → Bool) (i j : ι) : Prop :=
  ∃ v w z : Vec m, ∃ x : Input ι m,
    iterDiff [Pi.single i v, Pi.single i w, Pi.single j z] (graphMap hm adj) x ≠ 0

theorem edge_detected_iff (hm : 2 ≤ m) (adj : ι → ι → Bool) (i j : ι)
    (hij : i ≠ j) : EdgeDetected hm adj i j ↔ adj i j = true := by
  constructor
  · rintro ⟨v,w,z,x,h⟩
    cases he : adj i j
    · apply False.elim
      apply h
      rw [mixed_third hm adj i j hij, he]
      simp
    · rfl
  · intro he
    refine ⟨Blocks.basisP hm, Blocks.basisQ hm, Blocks.basisP hm, 0, ?_⟩
    rw [mixed_third hm adj i j hij, he]
    intro hz
    have hh := congrFun hz i
    simpa [p, q, firstIndex, Blocks.basisP, Blocks.basisQ] using hh

/-- Invertible internal block maps preserve nonzeroness of mixed third differences. -/
theorem representation_edges (hm : 2 ≤ m) (adjG adjH : ι → ι → Bool)
    (A : Input ι m ≃ₗ[Scalar] Input ι m) (B : Output ι ≃ₗ[Scalar] Output ι)
    (t : Input ι m) (L : Input ι m →ₗ[Scalar] Output ι) (k : Output ι)
    (he : ∀ x, graphMap hm adjH x = B (graphMap hm adjG (A x+t)) + (L x+k))
    (perm : ι ≃ ι) (e : ι → Vec m ≃ₗ[Scalar] Vec m)
    (hblock : ∀ i v, A (Pi.single i v) = Pi.single (perm i) (e i v))
    (i j : ι) (hij : i ≠ j) : adjH i j = adjG (perm i) (perm j) := by
  have hdetect : EdgeDetected hm adjH i j ↔ EdgeDetected hm adjG (perm i) (perm j) := by
    constructor
    · rintro ⟨v,w,z,x,h⟩
      refine ⟨e i v, e i w, e j z, A x+t, ?_⟩
      intro hz
      apply h
      rw [representation_third _ _ A B t L k he, hblock, hblock, hblock, hz]
      exact B.map_zero
    · rintro ⟨v,w,z,x,h⟩
      refine ⟨(e i).symm v, (e i).symm w, (e j).symm z, A.symm (x-t), ?_⟩
      intro hz
      have hh := representation_third _ _ A B t L k he
        (Pi.single i ((e i).symm v)) (Pi.single i ((e i).symm w))
        (Pi.single j ((e j).symm z)) (A.symm (x-t))
      rw [hblock, hblock, hblock] at hh
      simp only [LinearEquiv.apply_symm_apply, sub_add_cancel] at hh
      rw [hz] at hh
      apply h
      apply B.injective
      simpa using hh.symm
  rw [edge_detected_iff hm adjH i j hij,
    edge_detected_iff hm adjG (perm i) (perm j) (fun h => hij (perm.injective h))] at hdetect
  cases hH : adjH i j <;> cases hG : adjG (perm i) (perm j) <;> simp_all

end VonoV3C.GraphFamily
