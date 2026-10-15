import Antipodal.BlockCoordinates
import Antipodal.OddRestriction

namespace HRSBF.Antipodal

/-- A power of the actual cyclic coordinate permutation as a linear equivalence. -/
def cyclicPower (N k : ℕ) : Vec N ≃ₗ[F₂] Vec N where
  toFun x i := x (((finRotate N)^k) i)
  invFun x i := x ((((finRotate N)^k).symm) i)
  left_inv x := by funext i; simp
  right_inv x := by funext i; simp
  map_add' _ _ := rfl
  map_smul' _ _ := rfl

theorem cyclicPower_toLinearMap (N k : ℕ) :
    (cyclicPower N k).toLinearMap = (cyclicShift N).toLinearMap ^ k := by
  apply LinearMap.ext
  intro x
  funext i
  exact (cyclicShift_pow_apply_perm k x i).symm

/-- The concrete odd-subgroup generator has order dividing m. -/
theorem cyclicPower_order (t m : ℕ) :
    (cyclicPower (t*m) t).toLinearMap ^ m = 1 := by
  rw [cyclicPower_toLinearMap, ← pow_mul]
  exact cyclicShift_pow (t*m)

/-- The actual folding/repetition substitution, retaining coordinate order. -/
def repeatBlock (t m : ℕ) (ht : 0 < t) : Vec t →ₗ[F₂] Vec (t*m) where
  toFun y i := y ⟨i.val%t, Nat.mod_lt _ ht⟩
  map_add' _ _ := rfl
  map_smul' _ _ := rfl

theorem repeatBlock_injective (t m : ℕ) (ht : 0 < t) (hm : 0 < m) :
    Function.Injective (repeatBlock t m ht) := by
  intro x y hxy
  funext i
  have htm : t ≤ t*m := by
    calc
      t = t*1 := by omega
      _ ≤ t*m := Nat.mul_le_mul_left t (by omega)
  have hi : i.val < t*m := lt_of_lt_of_le i.isLt htm
  have hh := congrFun hxy (⟨i.val, hi⟩ : Fin (t*m))
  simpa only [repeatBlock, LinearMap.coe_mk, AddHom.coe_mk, Nat.mod_eq_of_lt i.isLt] using hh

/-- Repeated blocks lie in the actual fixed space of the subgroup generator. -/
theorem repeatBlock_fixed (t m : ℕ) (ht : 0 < t) (hm : 0 < m) (y : Vec t) :
    cyclicPower (t*m) t (repeatBlock t m ht y) = repeatBlock t m ht y := by
  funext i
  change y ⟨((((finRotate (t*m))^t) i).val)%t, _⟩ = y ⟨i.val%t, _⟩
  rw [finRotate_pow_mod (Nat.mul_pos ht hm)]
  congr 1
  apply Fin.ext
  dsimp
  rw [Nat.mod_mod_of_dvd _ (dvd_mul_right t m), Nat.add_mod_right]

/-- Folding intertwines the one-coordinate rotations, not just their subgroups. -/
theorem repeatBlock_rotate (t m : ℕ) (ht : 0 < t) (hm : 0 < m) (y : Vec t) :
    repeatBlock t m ht (cyclicShift t y) = cyclicShift (t*m) (repeatBlock t m ht y) := by
  funext i
  change cyclicShift t y ⟨i.val%t, _⟩ = cyclicShift (t*m) (repeatBlock t m ht y) i
  rw [cyclicShift_apply_mod ht, cyclicShift_apply_mod (Nat.mul_pos ht hm)]
  change y ⟨(i.val%t+1)%t, _⟩ = y ⟨((i.val+1)%(t*m))%t, _⟩
  congr 1
  apply Fin.ext
  dsimp
  rw [Nat.mod_mod_of_dvd _ (dvd_mul_right t m), Nat.mod_add_mod]

/-- Actual cyclic invariance is preserved by the folding substitution. -/
theorem rotationSymmetric_fold (t m : ℕ) (ht : 0 < t) (hm : 0 < m)
    (f : Vec (t*m) → F₂) (hs : IsRotationSymmetric f) :
    IsRotationSymmetric (fun y => f (repeatBlock t m ht y)) := by
  intro y
  change f (repeatBlock t m ht (cyclicShift t y)) = _
  rw [repeatBlock_rotate t m ht hm]
  exact hs (repeatBlock t m ht y)


private theorem block_length_le (t m : ℕ) (hm : 0 < m) : t ≤ t*m := by
  calc
    t = t*1 := by omega
    _ ≤ t*m := Nat.mul_le_mul_left t (by omega)

/-- Every fixed vector is periodic with period t, proved by a subtraction
recurrence rather than by an assumed dimension count. -/
theorem cyclicPower_fixed_periodic (t m : ℕ) (ht : 0 < t) (hm : 0 < m)
    (x : Vec (t*m)) (hx : cyclicPower (t*m) t x = x) :
    ∀ q (hq : q < t*m),
      x ⟨q,hq⟩ = x ⟨q%t, lt_of_lt_of_le (Nat.mod_lt q ht) (block_length_le t m hm)⟩ := by
  intro q
  induction q using Nat.strong_induction_on with
  | h q ih =>
    intro hq
    by_cases hqt : q < t
    · congr 1
      apply Fin.ext
      exact (Nat.mod_eq_of_lt hqt).symm
    · have hge : t ≤ q := by omega
      have hp : q-t < t*m := by omega
      have hstep := congrFun hx (⟨q-t,hp⟩ : Fin (t*m))
      change x (((finRotate (t*m))^t) ⟨q-t,hp⟩) = x ⟨q-t,hp⟩ at hstep
      rw [finRotate_pow_mod (Nat.mul_pos ht hm)] at hstep
      have he : (q-t+t)%(t*m) = q := by
        rw [Nat.sub_add_cancel hge, Nat.mod_eq_of_lt hq]
      simp only [he] at hstep
      have hrec := ih (q-t) (by omega) hp
      have hmod : (q-t)%t = q%t := by
        have hh : q = (q-t)+t := by omega
        conv_rhs => rw [hh]
        rw [Nat.add_mod_right]
      exact hstep.trans (hrec.trans (by congr 1; apply Fin.ext; exact hmod))

/-- Concrete linear coordinates on the actual cyclic fixed subspace. -/
def cyclicFixedEquiv (t m : ℕ) (ht : 0 < t) (hm : 0 < m) :
    Vec t ≃ₗ[F₂] fixedSubspace (cyclicPower (t*m) t) where
  toFun y := ⟨repeatBlock t m ht y, repeatBlock_fixed t m ht hm y⟩
  invFun x i := x.val ⟨i.val, lt_of_lt_of_le i.isLt (block_length_le t m hm)⟩
  left_inv y := by
    funext i
    change y ⟨i.val%t,_⟩ = y i
    congr 1
    apply Fin.ext
    exact Nat.mod_eq_of_lt i.isLt
  right_inv x := by
    apply Subtype.ext
    funext i
    exact (cyclicPower_fixed_periodic t m ht hm x x.property i.val i.isLt).symm
  map_add' x y := by apply Subtype.ext; rfl
  map_smul' c x := by apply Subtype.ext; rfl

/-- Concrete odd cyclic folding preserves bentness for cubic functions.
There is no assumed isomorphism or assumed restricted bentness. -/
theorem bent_cyclic_odd_fold (t m : ℕ) (ht : 0 < t) (hm : 0 < m)
    (hodd : Odd m) (f : Vec (t*m) → F₂)
    (hc : HasCubicRepresentation f) (hb : IsBent f) (hs : IsRotationSymmetric f) :
    IsBent (fun y : Vec t => f (repeatBlock t m ht y)) := by
  have hsinv : ∀ x, f (cyclicPower (t*m) t x) = f x := by
    intro x
    change f (((cyclicPower (t*m) t).toLinearMap) x) = _
    rw [cyclicPower_toLinearMap]
    exact rotation_invariant_pow f hs t x
  exact odd_order_bent_restriction f hc hb (cyclicPower (t*m) t) hsinv
    m hodd (cyclicPower_order t m) (cyclicFixedEquiv t m ht hm)


/-- Repetition into a specified ambient length; the length relation is
supplied only when a fixed-space theorem is invoked. -/
def repeatInto (t N : ℕ) (ht : 0 < t) : Vec t →ₗ[F₂] Vec N where
  toFun y i := y ⟨i.val%t, Nat.mod_lt _ ht⟩
  map_add' _ _ := rfl
  map_smul' _ _ := rfl

theorem bent_repeatInto (t N m : ℕ) (ht : 0 < t) (hm : 0 < m)
    (hodd : Odd m) (hlen : N = t*m) (f : Vec N → F₂)
    (hc : HasCubicRepresentation f) (hb : IsBent f) (hs : IsRotationSymmetric f) :
    IsBent (fun y => f (repeatInto t N ht y)) := by
  subst N
  exact bent_cyclic_odd_fold t m ht hm hodd f hc hb hs

theorem rotationSymmetric_repeatInto (t N m : ℕ) (ht : 0 < t) (hm : 0 < m)
    (hlen : N = t*m) (f : Vec N → F₂) (hs : IsRotationSymmetric f) :
    IsRotationSymmetric (fun y => f (repeatInto t N ht y)) := by
  subst N
  exact rotationSymmetric_fold t m ht hm f hs

end HRSBF.Antipodal

#print axioms HRSBF.Antipodal.cyclicPower_order
#print axioms HRSBF.Antipodal.repeatBlock_injective
#print axioms HRSBF.Antipodal.repeatBlock_fixed
#print axioms HRSBF.Antipodal.repeatBlock_rotate
#print axioms HRSBF.Antipodal.rotationSymmetric_fold

#print axioms HRSBF.Antipodal.cyclicFixedEquiv
#print axioms HRSBF.Antipodal.bent_cyclic_odd_fold
