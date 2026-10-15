import Antipodal.CyclicOddCoordinates
import Antipodal.PowerTwoCubic

/-! Universal antipodal necessity via odd fixed-space reduction and
half-turn diagonal constancy. This route transports the zero-antipodal
obstruction directly, without assuming a coefficient-folding identity. -/
namespace HRSBF.Antipodal

private theorem joined_diagonal_mod (h : ℕ) (hh : 0 < h) (u : Vec h) (i : Fin (h+h)) :
    joinBlocks h (diagonal u) i = u ⟨i.val%h, Nat.mod_lt _ hh⟩ := by
  change readPair (u,u) i = _
  unfold readPair
  split_ifs with hi
  · change u ⟨i.val,_⟩ = u ⟨i.val%h,_⟩
    congr 1
    apply Fin.ext
    exact (Nat.mod_eq_of_lt hi).symm
  · have hsub : i.val-h < h := by omega
    have hi' : i.val = (i.val-h)+h := by omega
    have hmod : i.val%h = i.val-h := by
      calc
        i.val%h = ((i.val-h)+h)%h := congrArg (fun q => q%h) hi'
        _ = (i.val-h)%h := Nat.add_mod_right _ _
        _ = i.val-h := Nat.mod_eq_of_lt hsub
    change u ⟨i.val-h,_⟩ = u ⟨i.val%h,_⟩
    congr 1
    apply Fin.ext
    exact hmod.symm

private theorem repeated_diagonal_mod (h m : ℕ) (hh : 0 < h)
    (u : Vec h) (i : Fin (h*m+h*m)) :
    repeatInto (h+h) (h*m+h*m) (by omega) (joinBlocks h (diagonal u)) i =
      u ⟨i.val%h, Nat.mod_lt _ hh⟩ := by
  change joinBlocks h (diagonal u) ⟨i.val%(h+h),_⟩ = _
  rw [joined_diagonal_mod h hh]
  congr 1
  apply Fin.ext
  dsimp
  exact Nat.mod_mod_of_dvd _ ⟨2, by omega⟩

private theorem halfTurn_multiple_mod (h m : ℕ) (i : Fin (h*m+h*m)) :
    (halfTurn (h*m) i).val%h = i.val%h := by
  dsimp [halfTurn]
  split_ifs with hi
  · simp [Nat.add_mod]
  · have he : i.val = (i.val-h*m)+h*m := by omega
    conv_rhs => rw [he]
    simp [Nat.add_mod]

private theorem repeated_diagonal_fixed (h m : ℕ) (hh : 0 < h) (u : Vec h) :
    ∀ i, repeatInto (h+h) (h*m+h*m) (by omega) (joinBlocks h (diagonal u)) (halfTurn (h*m) i) =
      repeatInto (h+h) (h*m+h*m) (by omega) (joinBlocks h (diagonal u)) i := by
  intro i
  rw [repeated_diagonal_mod h m hh, repeated_diagonal_mod h m hh]
  congr 1
  apply Fin.ext
  exact halfTurn_multiple_mod h m i

private theorem not_bent_constant_diagonal_half
    (h k : ℕ) (hh : 0 < h) (hk : 1 ≤ k) (hpow : h+h = 2^k)
    (f : Vec (h+h) → F₂) (hc : HasCubicRepresentation f) (hs : IsRotationSymmetric f)
    (hdiag : ∀ u, f (joinBlocks h (diagonal u)) = f 0) : ¬ IsBent f := by
  cases h with
  | zero => omega
  | succ n =>
    exact not_bent_constant_diagonal_power_two_of_cubic n k hk hpow f hc hs hdiag

/-- Antipodal necessity in every dimension 2^(r+1)*m with positive odd m.
No coefficient transport, restricted bentness, or diagonal condition is assumed. -/
theorem antipodal_necessity_factored
    (r m : ℕ) (hm : 0 < m) (hodd : Odd m)
    (f : Vec ((2^r*m)+(2^r*m)) → F₂)
    (hd : HasAlgebraicDegreeAtMostThree f) (hs : IsRotationSymmetric f) (hb : IsBent f) :
    anfCoefficient f {⟨0, by have hp : 0 < 2^r*m := Nat.mul_pos (pow_pos (by omega) _) hm; omega⟩, ⟨2^r*m, by have hp : 0 < 2^r*m := Nat.mul_pos (pow_pos (by omega) _) hm; omega⟩} = 1 := by
  classical
  let h := 2^r
  have hh : 0 < h := pow_pos (by omega) _
  have hH : 0 < h*m := Nat.mul_pos hh hm
  have hlen : h*m+h*m = (h+h)*m := by ring
  have hc := hasCubicRepresentation_of_anf_degree f hd
  let R := repeatInto (h+h) (h*m+h*m) (by omega : 0 < h+h)
  let g : Vec (h+h) → F₂ := fun y => f (R y)
  have hbg : IsBent g := bent_repeatInto (h+h) (h*m+h*m) m (by omega) hm hodd hlen f hc hb hs
  have hcg : HasCubicRepresentation g := hasCubicRepresentation_comp_linear f hc R
  have hsg : IsRotationSymmetric g :=
    rotationSymmetric_repeatInto (h+h) (h*m+h*m) m (by omega) hm hlen f hs
  by_contra hne
  have hz : anfCoefficient f {⟨0, by have hp : 0 < 2^r*m := Nat.mul_pos (pow_pos (by omega) _) hm; omega⟩, ⟨2^r*m, by have hp : 0 < 2^r*m := Nat.mul_pos (pow_pos (by omega) _) hm; omega⟩} = 0 :=
    ((by decide : ∀ c : F₂, c = 0 ∨ c = 1) _).resolve_right hne
  have hdiag : ∀ u, g (joinBlocks h (diagonal u)) = g 0 := by
    intro u
    change f (R (joinBlocks h (diagonal u))) = f (R 0)
    rw [map_zero]
    exact constant_on_halfTurn_fixed_of_antipodal_zero (h*m) hH f hd hs hz _
      (repeated_diagonal_fixed h m hh u)
  have hpow : h+h = 2^(r+1) := by simp [h, pow_succ, Nat.mul_two]
  exact (not_bent_constant_diagonal_half h (r+1) hh (by omega) hpow g hcg hsg hdiag) hbg


/-- Elementary factorization of every positive integer; no finite bound
or arithmetic subfamily is substituted for the universal quantifier. -/
theorem positive_two_power_odd_factor (H : ℕ) (hH : 0 < H) :
    ∃ r m : ℕ, 0 < m ∧ Odd m ∧ H = 2^r*m := by
  induction H using Nat.strong_induction_on with
  | h H ih =>
    by_cases ho : Odd H
    · exact ⟨0,H,hH,ho,by simp⟩
    · have he : Even H := (Nat.even_or_odd H).resolve_right ho
      obtain ⟨a,ha⟩ := he
      have ha0 : 0 < a := by omega
      have halt : a < H := by omega
      obtain ⟨r,m,hm,hodd,heq⟩ := ih a halt ha0
      refine ⟨r+1,m,hm,hodd,?_⟩
      calc
        H = a+a := ha
        _ = 2^r*m + 2^r*m := by rw [heq]
        _ = 2^(r+1)*m := by rw [pow_succ]; ring

/-- The exact all-positive-even-dimensional antipodal necessity theorem.
Only actual bentness, rotation symmetry and canonical ANF degree≤3 are
assumed. Affine and constant terms are unrestricted. -/
theorem universal_antipodal
    (H : ℕ) (hH : 0 < H) (f : Vec (H+H) → F₂)
    (hd : HasAlgebraicDegreeAtMostThree f) (hs : IsRotationSymmetric f) (hb : IsBent f) :
    anfCoefficient f {⟨0, by omega⟩, ⟨H, by omega⟩} = 1 := by
  obtain ⟨r,m,hm,hodd,hfactor⟩ := positive_two_power_odd_factor H hH
  subst H
  exact antipodal_necessity_factored r m hm hodd f hd hs hb

private theorem universal_antipodal_in_dimension
    (N H : ℕ) (hN : N = H+H) (hH : 0 < H)
    (f : Vec N → F₂) (hd : HasAlgebraicDegreeAtMostThree f)
    (hs : IsRotationSymmetric f) (hb : IsBent f) (h0 : 0 < N) (hHi : H < N) :
    anfCoefficient f {⟨0,h0⟩, ⟨H,hHi⟩} = 1 := by
  subst N
  exact universal_antipodal H hH f hd hs hb

/-- Identical statement in the conventional dimension notation N=2H. -/
theorem universal_antipodal_2h :
    ∀ (H : ℕ) (hH : 0 < H) (f : Vec (2*H) → F₂),
    HasAlgebraicDegreeAtMostThree f → IsRotationSymmetric f → IsBent f →
    anfCoefficient f {⟨0, by omega⟩, ⟨H, by omega⟩} = 1 := by
  intro H hH f hd hs hb
  exact universal_antipodal_in_dimension (2*H) H (Nat.two_mul H) hH f hd hs hb (by omega) (by omega)

/-- Canonical public interface, covering all positive even dimensions. -/
theorem universal_antipodal_canonical (h : ℕ) (f : Vec (2*(h+1)) → F₂)
    (hd : HasAlgebraicDegreeAtMostThree f) (hs : IsRotationSymmetric f) (hb : IsBent f) :
    antipodalANFCoefficient h f = 1 := by
  exact universal_antipodal_2h (h+1) (by omega) f hd hs hb

/-- The requested universal homogeneous cubic nonexistence corollary. -/
theorem no_homogeneous_cubic_rotation_symmetric_bent
    (H : ℕ) (hH : 0 < H) (f : Vec (H+H) → F₂)
    (hf : IsHomogeneousCubic f) (hs : IsRotationSymmetric f) : ¬ IsBent f := by
  intro hb
  have hone := universal_antipodal H hH f
    (homogeneous_cubic_degree_at_most_three f hf) hs hb
  have hne : (⟨0, by omega⟩ : Fin (H+H)) ≠ ⟨H, by omega⟩ := by
    intro hh
    have hv := congrArg Fin.val hh
    dsimp at hv
    omega
  have hz := hf.1 {⟨0, by omega⟩, ⟨H, by omega⟩} (by rw [Finset.card_pair hne]; decide)
  rw [hone] at hz
  exact one_ne_zero hz

end HRSBF.Antipodal

#print axioms HRSBF.Antipodal.antipodal_necessity_factored

#print axioms HRSBF.Antipodal.universal_antipodal
#print axioms HRSBF.Antipodal.universal_antipodal_canonical
#print axioms HRSBF.Antipodal.no_homogeneous_cubic_rotation_symmetric_bent
