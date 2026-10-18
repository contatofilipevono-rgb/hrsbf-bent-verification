import H12PackedPolynomial
namespace H12PackedProductOptimization
open H12PackedPolynomial

def outerShort : Nat → Nat → Nat → Nat → Nat
  | 0, _, _, _ => 0
  | width+1, start, a, b =>
      if a = 0 ∨ b = 0 then 0
      else (if a.testBit 0 then rowNative start b else 0) ^^^ outerShort width (start+1) (a >>> 1) b

theorem outerRows_left_zero (width start b : Nat) : outerRows width start 0 b = 0 := by
  induction width generalizing start with
  | zero => rfl
  | succ width ih => simp only [outerRows, Nat.zero_testBit, Bool.false_eq_true, ↓reduceIte, Nat.zero_shiftRight, ih, Nat.xor_self]

theorem outerRows_right_zero (width start a : Nat) : outerRows width start a 0 = 0 := by
  induction width generalizing start a with
  | zero => rfl
  | succ width ih =>
    have hr : rowNative start 0 = 0 := by simp [rowNative]
    simp only [outerRows, hr, ih, ite_self, Nat.xor_self]

theorem outerShort_eq (width start a b : Nat) : outerShort width start a b = outerRows width start a b := by
  induction width generalizing start a with
  | zero => rfl
  | succ width ih =>
    by_cases hz : a = 0 ∨ b = 0
    · simp only [outerShort, hz, ↓reduceIte]
      rcases hz with ha | hb
      · subst a; exact (outerRows_left_zero _ _ _).symm
      · subst b; exact (outerRows_right_zero _ _ _).symm
    · simp only [outerShort, hz, ↓reduceIte, ih, outerRows]

def product (a b : Nat) : Nat :=
  (if a.testBit 0 && b.testBit 0 then 1 else 0) ^^^
  linearNative ((if a.testBit 0 then b >>> 1 else 0) ^^^ (if b.testBit 0 then a >>> 1 else 0)) ^^^
  outerShort 36 0 (a >>> 1) (b >>> 1)

theorem product_eq (a b : Nat) : product a b = productWord a b := by
  simp only [product, productWord, outerShort_eq]

theorem product_sound (f : Nat → Bool) (a b : Nat) :
    value 36 f denseBook (product a b) = (affineValue f a && affineValue f b) := by
  rw [product_eq, productWord_sound]

#print axioms product_sound
end H12PackedProductOptimization
