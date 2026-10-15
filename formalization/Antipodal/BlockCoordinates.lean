import Antipodal.ANFPolynomial

namespace HRSBF.Antipodal
open Finset

/-- Concatenation of two blocks, with its explicit linear inverse. -/
def joinBlocks (h : ℕ) : PairSpace h ≃ₗ[F₂] Vec (h+h) where
  toFun := readPair
  invFun x := ((fun i => x ⟨i.val, by omega⟩), (fun i => x ⟨h+i.val, by omega⟩))
  left_inv x := by
    apply Prod.ext
    · funext i; exact readPair_left x i
    · funext i; exact readPair_right x i
  right_inv x := by
    funext j
    dsimp [readPair]
    split_ifs with hj
    · rfl
    · congr 1
      apply Fin.ext
      dsimp
      omega
  map_add' x y := by
    funext j
    dsimp [readPair]
    split_ifs <;> rfl
  map_smul' c x := by
    funext j
    dsimp [readPair]
    split_ifs <;> rfl

@[simp] theorem joinBlocks_left {h : ℕ} (x : PairSpace h) (i : Fin h) :
    joinBlocks h x ⟨i.val, by omega⟩ = x.1 i := readPair_left x i

@[simp] theorem joinBlocks_right {h : ℕ} (x : PairSpace h) (i : Fin h) :
    joinBlocks h x ⟨h+i.val, by omega⟩ = x.2 i := readPair_right x i

theorem dot_joinBlocks {h : ℕ} (a b : PairSpace h) :
    dot (joinBlocks h a) (joinBlocks h b) = dot a.1 b.1 + dot a.2 b.2 := by
  unfold dot
  rw [Fin.sum_univ_add]
  congr 1
  · apply sum_congr rfl
    intro i hi
    change readPair a ⟨i.val, by omega⟩ * readPair b ⟨i.val, by omega⟩ = _
    rw [readPair_left, readPair_left]
  · apply sum_congr rfl
    intro i hi
    change readPair a ⟨h+i.val, by omega⟩ * readPair b ⟨h+i.val, by omega⟩ = _
    rw [readPair_right, readPair_right]

theorem walsh_joinBlocks {h : ℕ} (f : Vec (h+h) → F₂) (a b : Vec h) :
    walsh f (joinBlocks h (a,b)) = walshPair (fun x => f (joinBlocks h x)) a b := by
  classical
  unfold walsh transform walshPair
  rw [← Equiv.sum_comp (joinBlocks h).toEquiv
    (fun x => sign (f x) * character (joinBlocks h (a,b)) x), Fintype.sum_prod_type]
  apply sum_congr rfl
  intro u hu
  apply sum_congr rfl
  intro v hv
  change sign (f (joinBlocks h (u,v))) *
    sign (dot (joinBlocks h (a,b)) (joinBlocks h (u,v))) = _
  rw [dot_joinBlocks, sign_add]
  simp only [character]
  ring

theorem bentPair_of_bent_joinBlocks {h : ℕ} (f : Vec (h+h) → F₂) (hb : IsBent f) :
    IsBentPair (fun x => f (joinBlocks h x)) := by
  intro a b
  rw [← walsh_joinBlocks]
  have hc : Fintype.card (Vec (h+h)) = Fintype.card (Vec h) * Fintype.card (Vec h) := by
    rw [← Fintype.card_prod]
    exact Fintype.card_congr (joinBlocks h).symm.toEquiv
  rw [hb, hc, Nat.cast_mul, pow_two]

end HRSBF.Antipodal

#print axioms HRSBF.Antipodal.joinBlocks
#print axioms HRSBF.Antipodal.walsh_joinBlocks
#print axioms HRSBF.Antipodal.bentPair_of_bent_joinBlocks

namespace HRSBF.Antipodal

/-- The concrete rotation, with its wraparound index visible. -/
theorem cyclicShift_apply_mod {n : ℕ} (hn : 0 < n) (x : Vec n) (i : Fin n) :
    cyclicShift n x i = x ⟨(i.val+1)%n, Nat.mod_lt _ hn⟩ := by
  cases n with
  | zero => omega
  | succ n =>
    change x (finRotate (n+1) i) = _
    rw [finRotate_succ_apply]
    congr 1
    apply Fin.ext
    simp [Fin.val_add, Nat.add_mod]

/-- Exact cyclic power formula, including wraparound. -/
theorem cyclicShift_pow_apply_mod {N : ℕ} (hN : 0 < N) (k : ℕ)
    (x : Vec N) (i : Fin N) :
    (((cyclicShift N).toLinearMap ^ k) x) i =
      x ⟨(i.val+k)%N, Nat.mod_lt _ hN⟩ := by
  induction k generalizing i with
  | zero => simp [Nat.mod_eq_of_lt i.isLt]
  | succ k ih =>
    rw [pow_succ']
    change cyclicShift N (((cyclicShift N).toLinearMap ^ k) x) i = _
    rw [cyclicShift_apply_mod hN, ih]
    congr 1
    apply Fin.ext
    dsimp
    rw [Nat.mod_add_mod]
    congr 1
    omega

/-- Block shifts are exactly the concrete cyclic powers under concatenation. -/
theorem joinBlocks_blockShift {n : ℕ} (k : ℕ) (x : PairSpace (n+1)) :
    joinBlocks (n+1) (blockShift k x) =
      ((cyclicShift ((n+1)+(n+1))).toLinearMap ^ k) (joinBlocks (n+1) x) := by
  funext i
  rw [cyclicShift_pow_apply_mod (by omega)]
  change readPair (blockShift k x) i = _
  unfold readPair
  split_ifs with hi
  · rfl
  · change readPair x ⟨((n+1)+(i.val-(n+1))+k)%((n+1)+(n+1)), _⟩ = _
    congr 1
    apply Fin.ext
    dsimp
    have hh : (n+1)+(i.val-(n+1)) = i.val := by omega
    rw [hh]

@[simp] theorem joinBlocks_ones (h : ℕ) :
    joinBlocks h (ones,ones) = (ones : Vec (h+h)) := by
  funext i
  change readPair (ones,ones) i = 1
  unfold readPair
  split_ifs <;> rfl

theorem rotation_invariant_pow {N : ℕ} (f : Vec N → F₂)
    (hs : IsRotationSymmetric f) (k : ℕ) (x : Vec N) :
    f (((cyclicShift N).toLinearMap ^ k) x) = f x := by
  induction k with
  | zero => rfl
  | succ k ih =>
    rw [pow_succ']
    change f (cyclicShift N (((cyclicShift N).toLinearMap ^ k) x)) = _
    exact (hs _).trans ih

end HRSBF.Antipodal

#print axioms HRSBF.Antipodal.joinBlocks_blockShift

namespace HRSBF.Antipodal

theorem cyclicShift_pow_apply_perm {N : ℕ} (k : ℕ) (x : Vec N) (i : Fin N) :
    (((cyclicShift N).toLinearMap ^ k) x) i = x (((finRotate N)^k) i) := by
  induction k generalizing i with
  | zero => rfl
  | succ k ih =>
    rw [pow_succ' (cyclicShift N).toLinearMap]
    change (((cyclicShift N).toLinearMap ^ k) x) (finRotate N i) = _
    rw [ih]
    simp only [pow_succ, Equiv.Perm.mul_apply]

theorem finRotate_pow_mod {N : ℕ} (hN : 0 < N) (k : ℕ) (i : Fin N) :
    ((finRotate N)^k) i = ⟨(i.val+k)%N, Nat.mod_lt _ hN⟩ := by
  let j : Fin N := ⟨(i.val+k)%N, Nat.mod_lt _ hN⟩
  have hh := cyclicShift_pow_apply_mod hN k (Pi.single j (1 : F₂)) i
  rw [cyclicShift_pow_apply_perm] at hh
  by_contra hne
  have hne' : ((finRotate N)^k) i ≠ j := hne
  simp [Pi.single_apply, hne', Ne.symm hne', j] at hh

theorem anfCoefficient_rotation_pow {N : ℕ} (f : Vec N → F₂)
    (hs : IsRotationSymmetric f) (k : ℕ) (s : Finset (Fin N)) :
    anfCoefficient f (s.map ((finRotate N)^k).toEmbedding) = anfCoefficient f s := by
  apply anfCoefficient_permutation
  intro x
  have he : (fun i => x (((finRotate N)^k) i)) =
      ((cyclicShift N).toLinearMap ^ k) x := by
    funext i
    exact (cyclicShift_pow_apply_perm k x i).symm
  rw [he]
  exact rotation_invariant_pow f hs k x

end HRSBF.Antipodal
