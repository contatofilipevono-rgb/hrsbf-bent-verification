import H12PackedPolynomial
namespace H12PackedSparse
open H12PackedPolynomial
set_option maxRecDepth 10000
set_option maxHeartbeats 10000000

def top : Nat → Nat → Nat
  | 0, _ => 0
  | depth+1, word =>
      let half := 2^depth
      let high := word >>> half
      if high = 0 then top depth word else half + top depth high

theorem top_bounds (depth word : Nat) (hn : word ≠ 0) (hw : word < 2^(2^depth)) :
    2^(top depth word) ≤ word ∧ word < 2^(top depth word + 1) := by
  induction depth generalizing word with
  | zero =>
    have hsmall : word < 2 := by simpa using hw
    have he : word = 1 := by omega
    subst word
    decide
  | succ depth ih =>
    let half := 2^depth
    let high := word >>> half
    have hd : high = word / 2^half := Nat.shiftRight_eq_div_pow _ _
    have hwidth : 2^(2^(depth+1)) = 2^half * 2^half := by
      rw [Nat.pow_succ, show 2^depth * 2 = half+half by omega, Nat.pow_add]
    have hhigh : high < 2^half := by
      rw [hd, Nat.div_lt_iff_lt_mul (Nat.two_pow_pos _)]
      rwa [hwidth] at hw
    by_cases hz : high = 0
    · have hl : word < 2^half := (Nat.div_eq_zero_iff_lt (Nat.two_pow_pos _)).mp (hd ▸ hz)
      have hi := ih word hn hl
      simpa only [top, show word >>> 2^depth = 0 from hz, ↓reduceIte] using hi
    · have hi := ih high hz hhigh
      have hlo : 2^(top depth high)*2^half ≤ word :=
        Nat.le_trans (Nat.mul_le_mul_right (2^half) hi.1) (by rw [hd]; exact Nat.div_mul_le_self word (2^half))
      have hupper : word < (high+1)*2^half := by
        apply (Nat.div_lt_iff_lt_mul (Nat.two_pow_pos _)).mp
        rw [← hd]
        omega
      have hup : word < 2^(top depth high+1)*2^half :=
        Nat.lt_of_lt_of_le hupper (Nat.mul_le_mul_right (2^half) (by omega))
      constructor
      · simpa only [top, show word >>> 2^depth ≠ 0 from hz, ↓reduceIte,
          Nat.pow_add, Nat.mul_comm] using hlo
      · have he : half + top depth high + 1 = (top depth high+1)+half := by omega
        simp only [top, show word >>> 2^depth ≠ 0 from hz, ↓reduceIte]
        change word < 2^(half + top depth high + 1)
        rw [he, Nat.pow_add]
        exact hup

theorem top_eq_log2 (depth word : Nat) (hn : word ≠ 0) (hw : word < 2^(2^depth)) :
    top depth word = word.log2 := by
  exact ((Nat.log2_eq_iff hn).mpr (top_bounds depth word hn hw)).symm

#print axioms top_eq_log2

def applyFast : Nat → (Nat → Nat) → Nat → Nat
  | 0, _, _ => 0
  | fuel+1, column, word =>
      if word = 0 then 0
      else
        let i := top 11 word
        column i ^^^ applyFast fuel column (word ^^^ 2^i)

theorem applyFast_eq_sparse (fuel : Nat) (column : Nat → Nat) (word : Nat) (hw : word < 2^2048) :
    applyFast fuel column word = applySparse fuel column word := by
  induction fuel generalizing word with
  | zero => rfl
  | succ fuel ih =>
    by_cases hz : word = 0
    · simp only [applyFast, applySparse, hz, ↓reduceIte]
    · have ht : top 11 word = word.log2 := top_eq_log2 11 word hz hw
      have hi : word.log2 < 2048 := (Nat.log2_lt hz).mpr hw
      have hr : word ^^^ 2^word.log2 < 2^2048 :=
        Nat.lt_of_lt_of_le (clear_top_lt word hz) (Nat.pow_le_pow_right (by decide) (by omega))
      simp only [applyFast, applySparse, hz, ↓reduceIte, ht, ih _ hr]

theorem applyScan_zero (width start : Nat) (column : Nat → Nat) : applyScan width start column 0 = 0 := by
  cases width <;> rfl


theorem nxor_left_comm (a b c : Nat) : a ^^^ (b ^^^ c) = b ^^^ (a ^^^ c) := by
  rw [← Nat.xor_assoc, Nat.xor_comm a b, Nat.xor_assoc]

theorem nxor_cancel (a b : Nat) : a ^^^ (a ^^^ b) = b := by
  rw [← Nat.xor_assoc, Nat.xor_self, Nat.zero_xor]

theorem nxor_zero_eq (a b : Nat) (h : a ^^^ b = 0) : a = b := by
  apply Nat.eq_of_testBit_eq
  intro j
  have hb := congrArg (fun w : Nat => w.testBit j) h
  simp only [Nat.testBit_xor, Nat.zero_testBit] at hb
  cases ha : a.testBit j <;> cases hc : b.testBit j <;> simp_all

theorem applyScan_xor (width start : Nat) (column : Nat → Nat) (a b : Nat) :
    applyScan width start column (a ^^^ b) =
      (applyScan width start column a ^^^ applyScan width start column b) := by
  induction width generalizing start a b with
  | zero => simp only [applyScan, Nat.xor_self]
  | succ width ih =>
    by_cases ha : a = 0
    · subst a; simp only [Nat.zero_xor, applyScan_zero]
    by_cases hb : b = 0
    · subst b; simp only [Nat.xor_zero, applyScan_zero]
    by_cases hab : a ^^^ b = 0
    · have he : a = b := nxor_zero_eq a b hab
      subst b
      simp only [Nat.xor_self, applyScan_zero]
    · simp only [applyScan, ha, hb, hab, ↓reduceIte, Nat.testBit_xor,
        Nat.shiftRight_xor_distrib, ih]
      cases a.testBit 0 <;> cases b.testBit 0 <;>
        simp only [Bool.false_xor, Bool.true_xor, Bool.not_true, Bool.not_false,
          Bool.false_eq_true, ↓reduceIte, Nat.zero_xor, Nat.xor_zero,
          Nat.xor_assoc, Nat.xor_comm, nxor_left_comm, Nat.xor_self, nxor_cancel]

#print axioms applyFast_eq_sparse
#print axioms applyScan_xor

theorem applyScan_unit (width start : Nat) (column : Nat → Nat) (j : Nat) (hj : j < width) :
    applyScan width start column (2^j) = column (start+j) := by
  induction width generalizing start j with
  | zero => omega
  | succ width ih =>
    cases j with
    | zero =>
      simp only [Nat.pow_zero, applyScan, Nat.one_ne_zero, ↓reduceIte, Nat.add_zero]
      have hb : (1 : Nat).testBit 0 = true := by decide
      have hs : (1 : Nat) >>> 1 = 0 := by decide
      rw [hb, hs, applyScan_zero, Nat.xor_zero]
      rfl
    | succ j =>
      have hn : 2^(j+1) ≠ 0 := Nat.ne_of_gt (Nat.two_pow_pos _)
      have hb : (2^(j+1)).testBit 0 = false := by simp [Nat.testBit_two_pow]
      have hs : 2^(j+1) >>> 1 = 2^j := by simp [Nat.shiftRight_eq_div_pow, Nat.pow_succ]
      simp only [applyScan, hn, ↓reduceIte, hb, Bool.false_eq_true, hs, Nat.zero_xor]
      have h := ih (start+1) j (by omega)
      simpa only [Nat.add_assoc, Nat.add_comm 1 j] using h

theorem applySparse_eq_scan (width fuel start : Nat) (column : Nat → Nat) (word : Nat)
    (hf : fuel ≤ width) (hw : word < 2^fuel) :
    applySparse fuel (fun i => column (start+i)) word = applyScan width start column word := by
  induction fuel generalizing word with
  | zero =>
    have hz : word = 0 := by simpa using hw
    subst word
    rw [applySparse, applyScan_zero]
  | succ fuel ih =>
    by_cases hz : word = 0
    · subst word
      simp only [applySparse, ↓reduceIte, applyScan_zero]
    · have hi : word.log2 < fuel+1 := (Nat.log2_lt hz).mpr hw
      have hj : word.log2 < width := by omega
      have hr : word ^^^ 2^word.log2 < 2^fuel :=
        Nat.lt_of_lt_of_le (clear_top_lt word hz) (Nat.pow_le_pow_right (by decide) (by omega))
      rw [applySparse, ite_eq_right hz, ih _ (by omega) hr]
      have hd : 2^word.log2 ^^^ (word ^^^ 2^word.log2) = word := by
        rw [Nat.xor_comm word, ← Nat.xor_assoc, Nat.xor_self, Nat.zero_xor]
      have hs := applyScan_xor width start column (2^word.log2) (word ^^^ 2^word.log2)
      rw [applyScan_unit width start column _ hj, hd] at hs
      exact hs.symm

def sparseSubstitute (i a word : Nat) : Nat := applyFast 1333 (fastColumn i a) word

theorem sparseSubstitute_eq (i a word : Nat) (hw : word < 2^1333) :
    sparseSubstitute i a word = scanSubstitute i a word := by
  have hwide : word < 2^2048 := Nat.lt_of_lt_of_le hw (Nat.pow_le_pow_right (by decide) (by decide))
  rw [sparseSubstitute, applyFast_eq_sparse _ _ _ hwide]
  have h := applySparse_eq_scan 1333 1333 0 (fastColumn i a) word (by decide) hw
  simpa only [Nat.zero_add, scanSubstitute] using h

def sparseTransform (i a : Nat) (ps : List Nat) : List Nat := ps.map (sparseSubstitute i a)

theorem sparseTransform_eq (i a : Nat) (ps : List Nat) (hb : packedBounded ps) :
    sparseTransform i a ps = packedTransform i a ps := by
  apply List.map_congr_left
  intro p hp
  exact sparseSubstitute_eq i a p (hb p hp)

#print axioms sparseTransform_eq

def directColumn (i a j : Nat) : Nat :=
  if j = 0 then 1
  else if j < 37 then
    if j-1 = i then affineNative a else 2^j
  else
    let r := (j-37)/36
    let t := (j-37)%36
    if r = i then
      if t = i then affineNative a else variableProduct a t
    else if t = i then variableProduct a r else 2^j

theorem directColumn_eq (i a j : Nat) (hj : j < 1333) :
    directColumn i a j = fastColumn i a j := by
  by_cases hz : j = 0
  · subst j
    simp [directColumn, fastColumn, denseMask]
  · by_cases hl : j < 37
    · have hk : j-1 < 36 := by omega
      have hj' : j = 1+(j-1) := by omega
      have hm : denseMask j = 2^(j-1) := (congrArg denseMask hj').trans (dense_unit _ hk)
      simp only [directColumn, hz, hl, ↓reduceIte, fastColumn, hm, Nat.testBit_two_pow]
      by_cases he : j-1 = i
      · simp only [he, ↓reduceIte, decide_true, Nat.xor_self]
      · simp only [he, ↓reduceIte, decide_false, Bool.false_eq_true]
    · let r := (j-37)/36
      let t := (j-37)%36
      have hr : r < 36 := by dsimp [r]; omega
      have ht : t < 36 := by dsimp [t]; omega
      have he : j = 37+r*36+t := by dsimp [r,t]; omega
      have hm : denseMask j = (2^r ||| 2^t) := (congrArg denseMask he).trans (dense_pair r t hr ht)
      simp only [directColumn, hz, hl, ↓reduceIte]
      change (if r = i then (if t = i then affineNative a else variableProduct a t)
        else if t = i then variableProduct a r else 2^j) = fastColumn i a j
      simp only [fastColumn, hm, Nat.testBit_or, Nat.testBit_two_pow]
      by_cases hri : r = i
      · subst i
        by_cases htr : t = r
        · simp only [htr, ↓reduceIte, decide_true, Bool.true_or, Nat.or_self, Nat.xor_self]
        · have hrt : r ≠ t := Ne.symm htr
          simp only [htr, hrt, ↓reduceIte, decide_true, decide_false, Bool.true_or,
            clear_pair, Nat.ne_of_gt (Nat.two_pow_pos _), Nat.log2_two_pow]
      · by_cases hti : t = i
        · subst i
          have htr : t ≠ r := Ne.symm hri
          rw [Nat.or_comm (2^r) (2^t)]
          simp only [hri, htr, ↓reduceIte, decide_true, decide_false, Bool.false_or,
            Bool.true_or, clear_pair, Nat.ne_of_gt (Nat.two_pow_pos _), Nat.log2_two_pow]
        · simp only [hri, hti, ↓reduceIte, decide_false, Bool.false_or, Bool.false_eq_true]

#print axioms directColumn_eq

theorem applySparse_congr (fuel word : Nat) (left right : Nat → Nat)
    (hw : word < 2^fuel) (hc : ∀ j, j < fuel → left j = right j) :
    applySparse fuel left word = applySparse fuel right word := by
  induction fuel generalizing word with
  | zero => rfl
  | succ fuel ih =>
    by_cases hz : word = 0
    · simp only [applySparse, hz, ↓reduceIte]
    · have hi : word.log2 < fuel+1 := (Nat.log2_lt hz).mpr hw
      have hr : word ^^^ 2^word.log2 < 2^fuel :=
        Nat.lt_of_lt_of_le (clear_top_lt word hz) (Nat.pow_le_pow_right (by decide) (by omega))
      rw [applySparse, applySparse, ite_eq_right hz, ite_eq_right hz, hc _ hi,
        ih _ hr (fun j hj => hc j (by omega))]

def directSubstitute (i a word : Nat) : Nat := applyFast 1333 (directColumn i a) word

theorem directSubstitute_eq (i a word : Nat) (hw : word < 2^1333) :
    directSubstitute i a word = scanSubstitute i a word := by
  have hwide : word < 2^2048 := Nat.lt_of_lt_of_le hw (Nat.pow_le_pow_right (by decide) (by decide))
  rw [directSubstitute, applyFast_eq_sparse _ _ _ hwide,
    applySparse_congr _ _ _ _ hw (fun j hj => directColumn_eq i a j hj)]
  have h := applySparse_eq_scan 1333 1333 0 (fastColumn i a) word (by decide) hw
  simpa only [Nat.zero_add, scanSubstitute] using h

def directTransform (i a : Nat) (ps : List Nat) : List Nat := ps.map (directSubstitute i a)

theorem directTransform_eq (i a : Nat) (ps : List Nat) (hb : packedBounded ps) :
    directTransform i a ps = packedTransform i a ps := by
  apply List.map_congr_left
  intro p hp
  exact directSubstitute_eq i a p (hb p hp)

#print axioms directTransform_eq
end H12PackedSparse
