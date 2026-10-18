from pathlib import Path
root=Path('outputs/hrsbf-bent-verification/quartic_audit_2026_10_17/lean')
def rot(x):return (x>>4)|((x&15)<<8)
reps=[x for x in range(4096) if x<rot(x) and x<rot(rot(x))]
assert len(reps)==1360
src='''import Std
namespace H12Descent
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

def rotate4 (x : Nat) : Nat := ((BitVec.ofNat 12 x).rotateLeft 8).toNat
def repeat4 (y : Nat) : Nat := y + 16*y + 256*y
def representatives : List Nat := REPS
def fixedPoints : List Nat := (List.range 16).map repeat4
def triples (rs : List Nat) : List Nat :=
  rs.flatMap (fun r => [r, rotate4 r, rotate4 (rotate4 r)])
def orbitPartition : List Nat := fixedPoints ++ triples representatives

def mergeFuel : Nat → List Nat → List Nat → List Nat
  | 0, xs, ys => xs ++ ys
  | _+1, [], ys => ys
  | _+1, xs, [] => xs
  | n+1, a::as, b::bs =>
    if a ≤ b then a :: mergeFuel n as (b::bs) else b :: mergeFuel n (a::as) bs
theorem merge_perm (n : Nat) (xs ys : List Nat) :
    (mergeFuel n xs ys).Perm (xs ++ ys) := by
  induction n generalizing xs ys with
  | zero => exact .refl _
  | succ n ih =>
    cases xs with
    | nil => simp [mergeFuel]
    | cons a as =>
      cases ys with
      | nil => simp [mergeFuel]
      | cons b bs =>
        simp only [mergeFuel]
        split
        · exact (ih as (b::bs)).cons a
        · exact ((ih (a::as) bs).cons b).trans List.perm_middle.symm
def sortFuel : Nat → List Nat → List Nat
  | 0, xs => xs
  | n+1, xs =>
    mergeFuel xs.length (sortFuel n (xs.take (xs.length/2)))
      (sortFuel n (xs.drop (xs.length/2)))
theorem sort_perm (n : Nat) (xs : List Nat) : (sortFuel n xs).Perm xs := by
  induction n generalizing xs with
  | zero => exact .refl _
  | succ n ih =>
    exact (merge_perm _ _ _).trans
      (((ih _).append (ih _)).trans (List.Perm.of_eq (List.take_append_drop ..)))

theorem sorted_partition :
    sortFuel 12 orbitPartition = List.range 4096 := by decide +kernel

theorem partition_perm : orbitPartition.Perm (List.range 4096) := by
  have h := (sort_perm 12 orbitPartition).symm
  rw [sorted_partition] at h
  exact h

theorem perm_sum_int {xs ys : List Int} (h : xs.Perm ys) : xs.sum = ys.sum := by
  induction h with
  | nil => simp
  | cons _ _ ih => simp [ih]
  | swap => simpa [List.sum_cons] using Int.add_left_comm ..
  | trans _ _ ih₁ ih₂ => simp [ih₁, ih₂]

theorem triple_sum (rs : List Nat) (h : Nat → Int)
    (hi : ∀ r ∈ rs, h (rotate4 r) = h r ∧ h (rotate4 (rotate4 r)) = h r) :
    ((triples rs).map h).sum = 3 * (rs.map h).sum := by
  induction rs with
  | nil => simp [triples]
  | cons r rs ih =>
    have hr := hi r (by simp)
    have ht : ∀ a ∈ rs, h (rotate4 a) = h a ∧ h (rotate4 (rotate4 a)) = h a := by
      intro a ha; exact hi a (by simp [ha])
    have he := ih ht
    simp only [triples, List.flatMap_cons, List.map_append, List.sum_append,
      List.map_cons, List.map_nil, List.sum_cons, List.sum_nil] at he ⊢
    rw [hr.1, hr.2]
    omega

theorem sum_decomposition (h : Nat → Int)
    (hi : ∀ r ∈ representatives,
      h (rotate4 r) = h r ∧ h (rotate4 (rotate4 r)) = h r) :
    ((List.range 4096).map h).sum =
      (fixedPoints.map h).sum + 3 * (representatives.map h).sum := by
  have hp := perm_sum_int (partition_perm.map h)
  rw [← hp]
  simp only [orbitPartition, List.map_append, List.sum_append]
  rw [triple_sum representatives h hi]

theorem descent_mod_three (h : Nat → Int)
    (hi : ∀ r ∈ representatives,
      h (rotate4 r) = h r ∧ h (rotate4 (rotate4 r)) = h r)
    (hzero : ((List.range 4096).map h).sum = 0) :
    3 ∣ (fixedPoints.map h).sum := by
  have hd := sum_decomposition h hi
  refine ⟨-((representatives.map h).sum), ?_⟩
  omega

#print axioms sorted_partition
#print axioms descent_mod_three

def derivativeSign (f : Nat → Bool) (u x : Nat) : Int :=
  if f x == f (x ^^^ u) then 1 else -1
def Rotational4 (f : Nat → Bool) : Prop :=
  ∀ x, x < 4096 → f (rotate4 x) = f x
def BentAC (f : Nat → Bool) : Prop :=
  ∀ u, u < 4096 → u ≠ 0 → ((List.range 4096).map (derivativeSign f u)).sum = 0

theorem rotate_xor (x y : BitVec 12) :
    (x ^^^ y).rotateLeft 8 = x.rotateLeft 8 ^^^ y.rotateLeft 8 := by
  apply BitVec.eq_of_getLsbD_eq
  intro i hi
  simp only [BitVec.getLsbD_rotateLeft, BitVec.getLsbD_xor]
  split
  · rfl
  · simp [hi]

theorem fixed_repeat : ∀ u : Fin 16,
    (BitVec.ofNat 12 (repeat4 u.val)).rotateLeft 8 = BitVec.ofNat 12 (repeat4 u.val) := by decide

theorem xor_compatibility : ∀ x : Fin 4096, ∀ u : Fin 16,
    rotate4 (x.val ^^^ repeat4 u.val) = rotate4 x.val ^^^ repeat4 u.val ∧
    (x.val ^^^ repeat4 u.val) < 4096 ∧ rotate4 x.val < 4096 := by
  intro x u
  have hu : repeat4 u.val < 4096 := by unfold repeat4; omega
  constructor
  · unfold rotate4
    rw [BitVec.ofNat_xor, rotate_xor, fixed_repeat u, BitVec.toNat_xor]
    simp [BitVec.toNat_ofNat, Nat.mod_eq_of_lt hu]
  · constructor
    · have hb := ((BitVec.ofNat 12 x.val) ^^^ (BitVec.ofNat 12 (repeat4 u.val))).isLt
      simpa [BitVec.toNat_xor, BitVec.toNat_ofNat, Nat.mod_eq_of_lt x.isLt,
        Nat.mod_eq_of_lt hu] using hb
    · exact ((BitVec.ofNat 12 x.val).rotateLeft 8).isLt

theorem representative_bounds : representatives.all (fun x => decide (x < 4096)) = true := by decide

theorem repeated_shift_bounds : ∀ u : Fin 15,
    repeat4 (u.val+1) < 4096 ∧ repeat4 (u.val+1) ≠ 0 := by decide

theorem bent_rotational_descent (f : Nat → Bool) (hr : Rotational4 f) (hb : BentAC f)
    (u : Fin 15) :
    3 ∣ (fixedPoints.map (derivativeSign f (repeat4 (u.val+1)))).sum := by
  have hu : u.val+1 < 16 := by omega
  have hd : ∀ x, x < 4096 →
      derivativeSign f (repeat4 (u.val+1)) (rotate4 x) =
        derivativeSign f (repeat4 (u.val+1)) x := by
    intro x hx
    have hc := xor_compatibility ⟨x,hx⟩ ⟨u.val+1,hu⟩
    unfold derivativeSign
    rw [hr x hx, ← hc.1, hr _ hc.2.1]
  apply descent_mod_three
  · intro r hm
    have hlt : r < 4096 := by
      have h := (List.all_eq_true.mp representative_bounds) r hm
      exact of_decide_eq_true h
    have hc := xor_compatibility ⟨r,hlt⟩ ⟨u.val+1,hu⟩
    exact ⟨hd r hlt, (hd (rotate4 r) hc.2.2).trans (hd r hlt)⟩
  · have hs := repeated_shift_bounds u
    exact hb _ hs.1 hs.2

#print axioms bent_rotational_descent
end H12Descent
'''.replace('REPS','['+','.join(map(str,reps))+']')
(root/'H12Descent.lean').write_text(src,encoding='utf-8')
print(len(src))
