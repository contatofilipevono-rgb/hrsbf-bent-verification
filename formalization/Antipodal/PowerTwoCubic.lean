import Antipodal.BlockCoordinates
import Antipodal.CubicTransport
import Antipodal.HomogeneousDiagonal
import Antipodal.DiagonalANF

namespace HRSBF.Antipodal

private theorem power_two_derivative_polar (N k : ℕ) (hk : 1 ≤ k) (hN : N = 2^k)
    (f : Vec N → F₂) (hc : HasCubicRepresentation f) (hb : IsBent f)
    (hs : IsRotationSymmetric f) : ∀ a b, polar (derivative f ones) a b = 0 := by
  subst N
  exact bent_cyclic_cubic_derivative_polar_zero k hk f hc hb hs

/-- A genuine power-of-two nonexistence result under the remaining
constant-diagonal condition. Balance, zero derivative polar, coordinate
compatibility and cubic representation are all derived. -/
theorem not_bent_constant_diagonal_power_two_of_cubic
    (n k : ℕ) (hk : 1 ≤ k) (hN : (n+1)+(n+1) = 2^k)
    (f : Vec ((n+1)+(n+1)) → F₂)
    (hc : HasCubicRepresentation f) (hs : IsRotationSymmetric f)
    (hdiag : ∀ u, f (joinBlocks (n+1) (diagonal u)) = f 0) : ¬ IsBent f := by
  intro hb
  let g : PairSpace (n+1) → F₂ := fun x => f (joinBlocks (n+1) x)
  have hcG : HasCubicRepresentation g :=
    hasCubicRepresentation_comp_linear f hc (joinBlocks (n+1)).toLinearMap
  have hrsG : ∀ j x, g (blockShift j x) = g x := by
    intro j x
    change f (joinBlocks (n+1) (blockShift j x)) = f (joinBlocks (n+1) x)
    rw [joinBlocks_blockShift]
    exact rotation_invariant_pow f hs j _
  have hdiagG : ∀ u, g (diagonal u) = g 0 := by
    intro u
    change f (joinBlocks (n+1) (diagonal u)) = f (joinBlocks (n+1) 0)
    rw [map_zero]
    exact hdiag u
  have hpolar := power_two_derivative_polar _ k hk hN f hc hb hs
  have hzG : ∀ a b, polar (derivative g (ones,ones)) a b = 0 := by
    intro a b
    simpa only [g, polar, derivative, map_add, map_zero, joinBlocks_ones] using
      hpolar (joinBlocks (n+1) a) (joinBlocks (n+1) b)
  exact (not_bent_of_diagonal_and_derivative_polar_zero g hcG hrsG hdiagG hzG)
    (bentPair_of_bent_joinBlocks f hb)


theorem not_bent_constant_diagonal_power_two
    (n k : ℕ) (hk : 1 ≤ k) (hN : (n+1)+(n+1) = 2^k)
    (f : Vec ((n+1)+(n+1)) → F₂)
    (hd : HasAlgebraicDegreeAtMostThree f) (hs : IsRotationSymmetric f)
    (hdiag : ∀ u, f (joinBlocks (n+1) (diagonal u)) = f 0) : ¬ IsBent f :=
  not_bent_constant_diagonal_power_two_of_cubic n k hk hN f
    (hasCubicRepresentation_of_anf_degree f hd) hs hdiag

/-- Explicit half-turn of the coordinate cycle. -/
def halfTurn (h : ℕ) : Equiv.Perm (Fin (h+h)) where
  toFun i := ⟨if i.val < h then i.val+h else i.val-h, by split_ifs <;> omega⟩
  invFun i := ⟨if i.val < h then i.val+h else i.val-h, by split_ifs <;> omega⟩
  left_inv i := by apply Fin.ext; dsimp; split_ifs <;> omega
  right_inv i := by apply Fin.ext; dsimp; split_ifs <;> omega

theorem halfTurn_involutive (h : ℕ) : Function.Involutive (halfTurn h) := by
  intro i
  apply Fin.ext
  dsimp [halfTurn]
  split_ifs <;> omega

theorem halfTurn_free (n : ℕ) (i : Fin ((n+1)+(n+1))) : halfTurn (n+1) i ≠ i := by
  intro he
  have hv := congrArg Fin.val he
  dsimp [halfTurn] at hv
  split_ifs at hv <;> omega

theorem halfTurn_mod (n : ℕ) (i : Fin ((n+1)+(n+1))) :
    (halfTurn (n+1) i).val = (i.val+(n+1))%((n+1)+(n+1)) := by
  dsimp [halfTurn]
  split_ifs with hi
  · rw [Nat.mod_eq_of_lt (by omega)]
  · have he : i.val+(n+1) = (i.val-(n+1))+((n+1)+(n+1)) := by omega
    rw [he, Nat.add_mod_right, Nat.mod_eq_of_lt (by omega)]

theorem rotation_invariant_halfTurn (n : ℕ)
    (f : Vec ((n+1)+(n+1)) → F₂) (hs : IsRotationSymmetric f) :
    ∀ x, f (fun i => x (halfTurn (n+1) i)) = f x := by
  intro x
  have he : (fun i => x (halfTurn (n+1) i)) =
      ((cyclicShift ((n+1)+(n+1))).toLinearMap ^ (n+1)) x := by
    funext i
    rw [cyclicShift_pow_apply_mod (by omega)]
    congr 1
    apply Fin.ext
    exact halfTurn_mod n i
  rw [he]
  exact rotation_invariant_pow f hs _ x

theorem diagonal_fixed_halfTurn (n : ℕ) (u : Vec (n+1))
    (i : Fin ((n+1)+(n+1))) :
    joinBlocks (n+1) (diagonal u) (halfTurn (n+1) i) =
      joinBlocks (n+1) (diagonal u) i := by
  change readPair (u,u) (halfTurn (n+1) i) = readPair (u,u) i
  unfold readPair halfTurn
  dsimp
  split_ifs <;> congr 1 <;> apply Fin.ext <;> dsimp <;> omega

/-- Power-of-two nonexistence of homogeneous cubic RS bent functions.
Every structural premise of the fiber contradiction has been discharged.
The arithmetic equality states exactly which dimensions are covered. -/
theorem not_bent_homogeneous_cubic_power_two
    (n k : ℕ) (hk : 1 ≤ k) (hN : (n+1)+(n+1) = 2^k)
    (f : Vec ((n+1)+(n+1)) → F₂)
    (hf : IsHomogeneousCubic f) (hs : IsRotationSymmetric f) : ¬ IsBent f := by
  apply not_bent_constant_diagonal_power_two n k hk hN f
    (homogeneous_cubic_degree_at_most_three f hf) hs
  intro u
  have hv (v : Vec (n+1)) : f (joinBlocks (n+1) (diagonal v)) = 0 :=
    homogeneous_cubic_vanishes_on_fixed_vectors f hf (halfTurn (n+1))
      (halfTurn_involutive _) (halfTurn_free n) (rotation_invariant_halfTurn n f hs)
      _ (diagonal_fixed_halfTurn n v)
  have hzero : joinBlocks (n+1) (diagonal (0 : Vec (n+1))) = 0 := by
    have he : diagonal (0 : Vec (n+1)) = 0 := rfl
    rw [he, map_zero]
  have hfzero := hv 0
  rw [hzero] at hfzero
  exact (hv u).trans hfzero.symm


/-- Actual antipodal necessity in power-of-two dimension, stated on the
canonical coefficient of the pair {0,N/2}. Affine terms are unrestricted. -/
theorem bent_power_two_antipodal_coefficient_one
    (n k : ℕ) (hk : 1 ≤ k) (hN : (n+1)+(n+1) = 2^k)
    (f : Vec ((n+1)+(n+1)) → F₂)
    (hd : HasAlgebraicDegreeAtMostThree f) (hs : IsRotationSymmetric f)
    (hb : IsBent f) :
    anfCoefficient f {⟨0, by omega⟩, ⟨n+1, by omega⟩} = 1 := by
  classical
  let z : Fin ((n+1)+(n+1)) := ⟨0, by omega⟩
  let j : Fin ((n+1)+(n+1)) := ⟨n+1, by omega⟩
  by_contra hne
  have hzero : anfCoefficient f {z,j} = 0 :=
    ((by decide : ∀ c : F₂, c = 0 ∨ c = 1) (anfCoefficient f {z,j})).resolve_right hne
  have hpairs : ∀ i, anfCoefficient f {i, halfTurn (n+1) i} = 0 := by
    intro i
    have hrot := anfCoefficient_rotation_pow f hs i.val {z,j}
    have hz : ((finRotate ((n+1)+(n+1)))^i.val) z = i := by
      rw [finRotate_pow_mod (by omega)]
      apply Fin.ext
      simp only [z, zero_add, Nat.mod_eq_of_lt i.isLt]
    have hj : ((finRotate ((n+1)+(n+1)))^i.val) j = halfTurn (n+1) i := by
      rw [finRotate_pow_mod (by omega)]
      apply Fin.ext
      dsimp [j]
      rw [halfTurn_mod]
      congr 1
      omega
    have hm : ({z,j} : Finset (Fin ((n+1)+(n+1)))).map
        ((finRotate ((n+1)+(n+1)))^i.val).toEmbedding = {i, halfTurn (n+1) i} := by
      simp only [Finset.map_insert, Finset.map_singleton, Equiv.toEmbedding_apply, hz, hj]
    rw [hm, hzero] at hrot
    exact hrot
  apply (not_bent_constant_diagonal_power_two n k hk hN f hd hs) _ hb
  intro u
  exact constant_on_fixed_vectors_of_antipodal_absence f hd (halfTurn (n+1))
    (halfTurn_involutive _) (halfTurn_free n) (rotation_invariant_halfTurn n f hs)
    hpairs _ (diagonal_fixed_halfTurn n u)


/-- Rotation makes all quadratic antipodal pairs have the same canonical coefficient. -/
theorem antipodal_pairs_zero_of_base_zero
    (H : ℕ) (hH : 0 < H) (f : Vec (H+H) → F₂) (hs : IsRotationSymmetric f)
    (hz : anfCoefficient f {⟨0, by omega⟩, ⟨H, by omega⟩} = 0) :
    ∀ i, anfCoefficient f {i, halfTurn H i} = 0 := by
  cases H with
  | zero => omega
  | succ n =>
    intro i
    let z : Fin ((n+1)+(n+1)) := ⟨0, by omega⟩
    let j : Fin ((n+1)+(n+1)) := ⟨n+1, by omega⟩
    have hrot := anfCoefficient_rotation_pow f hs i.val {z,j}
    have h0 : ((finRotate ((n+1)+(n+1)))^i.val) z = i := by
      rw [finRotate_pow_mod (by omega)]
      apply Fin.ext
      simp only [z, zero_add, Nat.mod_eq_of_lt i.isLt]
    have hj : ((finRotate ((n+1)+(n+1)))^i.val) j = halfTurn (n+1) i := by
      rw [finRotate_pow_mod (by omega)]
      apply Fin.ext
      dsimp [j]
      rw [halfTurn_mod]
      congr 1
      omega
    have hm : ({z,j} : Finset (Fin ((n+1)+(n+1)))).map
        ((finRotate ((n+1)+(n+1)))^i.val).toEmbedding = {i, halfTurn (n+1) i} := by
      simp only [Finset.map_insert, Finset.map_singleton, Equiv.toEmbedding_apply, h0, hj]
    rw [hm, hz] at hrot
    exact hrot

/-- A zero antipodal coefficient gives constancy on the whole half-turn
fixed space, in every positive even dimension, without bentness. -/
theorem constant_on_halfTurn_fixed_of_antipodal_zero
    (H : ℕ) (hH : 0 < H) (f : Vec (H+H) → F₂)
    (hd : HasAlgebraicDegreeAtMostThree f) (hs : IsRotationSymmetric f)
    (hz : anfCoefficient f {⟨0, by omega⟩, ⟨H, by omega⟩} = 0)
    (x : Vec (H+H)) (hx : ∀ i, x (halfTurn H i) = x i) : f x = f 0 := by
  have hp := antipodal_pairs_zero_of_base_zero H hH f hs hz
  cases H with
  | zero => omega
  | succ n =>
    exact constant_on_fixed_vectors_of_antipodal_absence f hd (halfTurn (n+1))
      (halfTurn_involutive _) (halfTurn_free n) (rotation_invariant_halfTurn n f hs)
      hp x hx

end HRSBF.Antipodal

#print axioms HRSBF.Antipodal.not_bent_constant_diagonal_power_two

#print axioms HRSBF.Antipodal.not_bent_homogeneous_cubic_power_two

#print axioms HRSBF.Antipodal.bent_power_two_antipodal_coefficient_one
