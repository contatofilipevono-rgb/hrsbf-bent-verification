import Antipodal.LocalRigidity

namespace HRSBF.Antipodal

/-- Read a coordinate in the concatenation of two equally sized blocks. -/
def readPair {h : ℕ} (x : PairSpace h) (j : Fin (h + h)) : F₂ :=
  if hj : j.val < h then x.1 ⟨j.val, hj⟩
  else x.2 ⟨j.val - h, by omega⟩

/-- An actual cyclic shift of all 2h coordinates, expressed in block coordinates. -/
def blockShift {n : ℕ} (k : ℕ) (x : PairSpace (n + 1)) : PairSpace (n + 1) :=
  (fun i => readPair x ⟨(i.val + k) % ((n + 1) + (n + 1)), Nat.mod_lt _ (by omega)⟩,
   fun i => readPair x ⟨((n + 1) + i.val + k) % ((n + 1) + (n + 1)),
     Nat.mod_lt _ (by omega)⟩)

lemma readPair_left {h : ℕ} (x : PairSpace h) (i : Fin h) :
    readPair x ⟨i.val, by omega⟩ = x.1 i := by
  simp [readPair, i.isLt]

lemma readPair_right {h : ℕ} (x : PairSpace h) (i : Fin h) :
    readPair x ⟨h + i.val, by omega⟩ = x.2 i := by
  unfold readPair
  rw [dif_neg (by dsimp; omega)]
  apply congrArg x.2
  apply Fin.ext
  simp

lemma blockShift_half {n : ℕ} (x : PairSpace (n + 1)) :
    blockShift (n + 1) x = swapBlocks x := by
  apply Prod.ext
  · funext i
    change readPair x ⟨(i.val + (n + 1)) % ((n + 1) + (n + 1)), _⟩ = x.2 i
    have he : (⟨(i.val + (n + 1)) % ((n + 1) + (n + 1)), Nat.mod_lt _ (by omega)⟩ : Fin ((n+1)+(n+1))) =
        ⟨(n + 1) + i.val, by omega⟩ := by
      apply Fin.ext
      dsimp
      rw [Nat.mod_eq_of_lt (by omega)]
      omega
    rw [he, readPair_right]
  · funext i
    change readPair x ⟨((n + 1) + i.val + (n + 1)) % ((n + 1) + (n + 1)), _⟩ = x.1 i
    have he : (⟨((n + 1) + i.val + (n + 1)) % ((n + 1) + (n + 1)), Nat.mod_lt _ (by omega)⟩ : Fin ((n+1)+(n+1))) =
        ⟨i.val, by omega⟩ := by
      apply Fin.ext
      dsimp
      have hsum : n + 1 + i.val + (n + 1) = i.val + ((n+1)+(n+1)) := by omega
      rw [hsum, Nat.add_mod_right, Nat.mod_eq_of_lt (by omega)]
    rw [he, readPair_left]

lemma blockShift_one_fst {n : ℕ} (x : PairSpace (n+1)) (i : Fin (n+1)) :
    (blockShift 1 x).1 i =
      if i = Fin.last n then x.2 0 else x.1 (finRotate (n+1) i) := by
  change readPair x ⟨(i.val + 1) % ((n+1)+(n+1)), _⟩ = _
  by_cases hil : i = Fin.last n
  · subst i
    rw [if_pos rfl]
    have he : (⟨((Fin.last n).val + 1) % ((n+1)+(n+1)), Nat.mod_lt _ (by omega)⟩ : Fin ((n+1)+(n+1))) =
        ⟨(n+1)+(0 : Fin (n+1)).val, by omega⟩ := by
      apply Fin.ext
      dsimp
      rw [Nat.mod_eq_of_lt (by omega)]
    rw [he, readPair_right]
  · rw [if_neg hil]
    have hi : i.val < n := by
      have := i.isLt
      simp only [Fin.ext_iff, Fin.val_last] at hil
      omega
    have hr := finRotate_of_lt hi
    have he : (⟨(i.val+1) % ((n+1)+(n+1)), Nat.mod_lt _ (by omega)⟩ : Fin ((n+1)+(n+1))) =
        ⟨(finRotate (n+1) i).val, by omega⟩ := by
      apply Fin.ext
      dsimp
      rw [Nat.mod_eq_of_lt (by omega), show finRotate (n+1) i = ⟨i.val+1, by omega⟩ from hr]
    rw [he, readPair_left]

lemma blockShift_one_snd {n : ℕ} (x : PairSpace (n+1)) (i : Fin (n+1)) :
    (blockShift 1 x).2 i =
      if i = Fin.last n then x.1 0 else x.2 (finRotate (n+1) i) := by
  change readPair x ⟨((n+1)+i.val+1) % ((n+1)+(n+1)), _⟩ = _
  by_cases hil : i = Fin.last n
  · subst i
    rw [if_pos rfl]
    have he : (⟨((n+1)+(Fin.last n).val+1) % ((n+1)+(n+1)), Nat.mod_lt _ (by omega)⟩ : Fin ((n+1)+(n+1))) =
        ⟨(0 : Fin (n+1)).val, by omega⟩ := by
      apply Fin.ext
      dsimp
      have hs : n+1+n+1 = (n+1)+(n+1) := by omega
      rw [hs, Nat.mod_self]
    rw [he, readPair_left]
  · rw [if_neg hil]
    have hi : i.val < n := by
      have := i.isLt
      simp only [Fin.ext_iff, Fin.val_last] at hil
      omega
    have hr := finRotate_of_lt hi
    have he : (⟨((n+1)+i.val+1) % ((n+1)+(n+1)), Nat.mod_lt _ (by omega)⟩ : Fin ((n+1)+(n+1))) =
        ⟨(n+1)+(finRotate (n+1) i).val, by omega⟩ := by
      apply Fin.ext
      dsimp
      rw [Nat.mod_eq_of_lt (by omega), show finRotate (n+1) i = ⟨i.val+1, by omega⟩ from hr]
      rfl
    rw [he, readPair_right]

lemma blockShift_one_complementary {n : ℕ} (u : Vec (n + 1)) :
    blockShift 1 (u, u + ones) = (twistedRotate u, twistedRotate u + ones) := by
  apply Prod.ext
  · funext i
    rw [blockShift_one_fst]
    by_cases hil : i = Fin.last n
    · subst i
      simp [twistedRotate, rotate, seam, ones, finRotate_last]
    · simp [hil, twistedRotate, rotate, seam, ones, Pi.single_apply]
  · funext i
    rw [blockShift_one_snd]
    by_cases hil : i = Fin.last n
    · subst i
      simp [twistedRotate, rotate, seam, ones, finRotate_last, add_assoc, CharTwo.add_self_eq_zero]
    · simp [hil, twistedRotate, rotate, seam, ones, Pi.single_apply]

/-- The local rigidity lemma, for every positive half-dimension.
The degree hypothesis is an explicit list of cubic polynomial terms.
Rotation symmetry here means invariance under the actual coordinate shifts.
-/
theorem local_complementary_fiber_rigidity {n : ℕ}
    (g : PairSpace (n + 1) → F₂)
    (hc : HasCubicRepresentation g)
    (hrs : ∀ k x, g (blockShift k x) = g x)
    (hd : ∀ u, g (diagonal u) = g 0)
    (hz : ∀ a b, polar (derivative g (ones, ones)) a b = 0) :
    ∀ u, complementaryFiber g u = complementaryFiber g 0 := by
  have hs (x : PairSpace (n + 1)) : g (swapBlocks x) = g x := by
    simpa only [blockShift_half] using hrs (n + 1) x
  have hp := complementaryFiber_polar_zero g hc hd hs hz
  apply affine_twisted_invariant_constant (complementaryFiber g) hp
  intro u
  have ht := hrs 1 (u, u + ones)
  simpa only [blockShift_one_complementary, complementaryFiber] using ht

end HRSBF.Antipodal
