import Antipodal.CanonicalANF

namespace HRSBF.Antipodal
open Finset

/-- Covariance of the canonical ANF under a coordinate permutation.
This justifies reading an orbit coefficient from one representative. -/
theorem anfCoefficient_permutation {n : ℕ} (f : Vec n → F₂)
    (e : Equiv.Perm (Fin n))
    (hs : ∀ x : Vec n, f (fun i => x (e i)) = f x)
    (s : Finset (Fin n)) :
    anfCoefficient f (s.map e.toEmbedding) = anfCoefficient f s := by
  classical
  have hsupport (t : Finset (Fin n)) :
      supportVector (t.map e.toEmbedding) = fun i => supportVector t (e.symm i) := by
    funext i
    simp only [supportVector]
    congr 1
    apply propext
    constructor
    · rintro hi
      obtain ⟨j, hj, he⟩ := mem_map.mp hi
      simpa [← he] using hj
    · intro hi
      exact mem_map.mpr ⟨e.symm i, hi, e.apply_symm_apply i⟩
  have hf (t : Finset (Fin n)) :
      f (supportVector (t.map e.toEmbedding)) = f (supportVector t) := by
    have hh := hs (supportVector (t.map e.toEmbedding))
    have he : (fun i => supportVector (t.map e.toEmbedding) (e i)) = supportVector t := by
      rw [hsupport]
      funext i
      simp
    rw [he] at hh
    exact hh.symm
  unfold anfCoefficient booleanMobius
  symm
  apply sum_bij (fun t _ => t.map e.toEmbedding)
  · intro t ht
    exact mem_powerset.mpr (map_subset_map.mpr (mem_powerset.mp ht))
  · intro t ht u hu he
    exact map_injective e.toEmbedding he
  · intro t ht
    refine ⟨t.map e.symm.toEmbedding, ?_, ?_⟩
    · apply mem_powerset.mpr
      have hh := mem_powerset.mp ht
      intro i hi
      obtain ⟨j, hj, rfl⟩ := mem_map.mp hi
      obtain ⟨k, hk, he⟩ := mem_map.mp (hh hj)
      simpa [← he] using hk
    · ext i
      simp
  · intro t ht
    exact (hf t).symm

/-- Rotation symmetry propagates to every canonical coefficient. -/
theorem anfCoefficient_rotation {n : ℕ} (f : Vec n → F₂)
    (hs : IsRotationSymmetric f) (s : Finset (Fin n)) :
    anfCoefficient f (s.map (finRotate n).toEmbedding) = anfCoefficient f s := by
  exact anfCoefficient_permutation f (finRotate n) hs s

end HRSBF.Antipodal

#print axioms HRSBF.Antipodal.anfCoefficient_permutation
#print axioms HRSBF.Antipodal.anfCoefficient_rotation
